#!/bin/bash
# ============================================================================
# QUICK CHECK - Pre-Flight Validation (Expanded - 16 Checks)
# ============================================================================
# Usage: ./quick-check.sh <article-file>
# Run DURING writing to catch issues before full gate
#
# This script catches 90%+ of common failures early, saving context tokens
# by preventing multiple gate iterations.
#
# Core checks (10):
# 1. AI-isms (navigate, delve, comprehensive, robust, etc.)
# 2. Deficit language (fix, cure, normal, special needs)
# 3. HushAway trademark (must have registered symbol)
# 4. "actually" count (max 2-3 based on length)
# 5. "specifically" count (max 2)
# 6. Short sentences (standalone paragraphs under 40 chars)
# 7. Contractions (minimum based on word count)
# 8. Community quote present
# 9. HushAway in intro (first 500 words)
# 10. And/But sentence starters (need 2+)
#
# NEW checks (6) - previously caused iteration loops:
# 11. Hedging density (max 8 per 1000 words)
# 12. Stacked hedges (no multiple hedges in one sentence)
# 13. 3+ paragraphs starting with same word in any section
# 14. Primary keyword in H2 heading
# 15. Meta description length (140-160 chars)
# 16. Commitment language in tables
#
# This is NOT a replacement for the full gate - it's a pre-flight check.
# ============================================================================

FILE="$1"
FAILS=0
WARNINGS=0

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "QUICK CHECK - Pre-Flight Validation"
    echo "============================================================================"
    echo ""
    echo "Usage: ./quick-check.sh <article-file>"
    echo ""
    echo "Run DURING writing to catch top failures early."
    echo "This saves context tokens by preventing gate iterations."
    echo ""
    exit 1
fi

WORD_COUNT=$(wc -w < "$FILE" | tr -d ' ')

# URL-stripped content for deficit/clinical checks (prevents false positives from URLs)
CONTENT_NO_URLS=$(sed -E 's|\[([^]]*)\]\([^)]+\)|\1|g; s|https?://[^)"'\'' >]+||g' "$FILE")

echo "============================================================================"
echo "QUICK CHECK - Pre-Flight Validation (16 checks)"
echo "============================================================================"
echo "File: $FILE"
echo "Words: $WORD_COUNT"
echo "============================================================================"
echo ""

# ============================================================================
# CORE CHECKS (1-10)
# ============================================================================

# 1. AI-isms (most common failure)
AIISMS=$(grep -ciE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital|realm|multifaceted|paradigm|synergy|harness|unlock|empower|straightforward|seamless|seamlessly|utilize|utilise|facilitate|optimal|plethora|myriad|pivotal|foster|bolster|whilst|moreover|furthermore|additionally|hence|thus|therefore|consequently|nevertheless|nonetheless|notwithstanding|firstly|secondly|thirdly|aforementioned|underscore|coupled with|in essence|certainly|essentially|fundamentally|undoubtedly|remarkably|ultimately|notably|evidently|inherently|arguably|invariably|interestingly" "$FILE" 2>/dev/null) || AIISMS=0
if [ "$AIISMS" -gt 0 ]; then
    echo "FAIL: AI-isms found ($AIISMS instances)"
    grep -niE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital" "$FILE" 2>/dev/null | head -3
    FAILS=$((FAILS+1))
else
    echo "PASS: No AI-isms"
fi

# 2. Deficit language (NEW - was causing failures)
DEFICIT=$(echo "$CONTENT_NO_URLS" | grep -ciE "\bfix\b|\bcure\b|\bnormal\b|suffering from|special needs|afflicted|victim|deficient|abnormal|disability" 2>/dev/null) || DEFICIT=0
if [ "$DEFICIT" -gt 0 ]; then
    echo "FAIL: Deficit language found ($DEFICIT instances)"
    echo "$CONTENT_NO_URLS" | grep -inE "\bfix\b|\bcure\b|\bnormal\b|suffering from|special needs|disability" 2>/dev/null | head -3
    FAILS=$((FAILS+1))
else
    echo "PASS: No deficit language"
fi

# 3. HushAway trademark
MISSING_TM=$(grep "HushAway" "$FILE" 2>/dev/null | grep -v "HushAway®" | grep -v "hushaway.com" | wc -l) || MISSING_TM=0
MISSING_TM=$(echo "$MISSING_TM" | tr -d ' ')
if [ "$MISSING_TM" -gt 0 ]; then
    echo "FAIL: HushAway missing registered symbol ($MISSING_TM instances)"
    grep -n "HushAway" "$FILE" 2>/dev/null | grep -v "HushAway®" | grep -v "hushaway.com" | head -3
    FAILS=$((FAILS+1))
else
    echo "PASS: All HushAway instances have registered symbol"
fi

# 4. "actually" count (max 2, scaled for longer articles)
SCALE_FACTOR=$(( (WORD_COUNT - 2000) / 1500 ))
[ "$SCALE_FACTOR" -lt 0 ] && SCALE_FACTOR=0
ACTUALLY_MAX=$((2 + SCALE_FACTOR))
ACTUALLY=$(grep -ciw "actually" "$FILE" 2>/dev/null) || ACTUALLY=0
if [ "$ACTUALLY" -gt "$ACTUALLY_MAX" ]; then
    echo "FAIL: 'actually' exceeds limit ($ACTUALLY found, max $ACTUALLY_MAX)"
    FAILS=$((FAILS+1))
else
    echo "PASS: 'actually' = $ACTUALLY (max $ACTUALLY_MAX)"
fi

# 5. "specifically" count (max 2)
SPECIFICALLY=$(grep -ciw "specifically" "$FILE" 2>/dev/null) || SPECIFICALLY=0
if [ "$SPECIFICALLY" -gt 2 ]; then
    echo "FAIL: 'specifically' exceeds limit ($SPECIFICALLY found, max 2)"
    FAILS=$((FAILS+1))
else
    echo "PASS: 'specifically' = $SPECIFICALLY (max 2)"
fi

# 6. Short sentences (standalone paragraphs under 40 chars)
SHORT=$(grep -cE "^[^.#]{1,40}\.$" "$FILE" 2>/dev/null) || SHORT=0
if [ "$SHORT" -lt 3 ]; then
    echo "FAIL: Short sentences ($SHORT found, need 3+ standalone paragraphs)"
    echo "      Tip: Put short sentences on their own line"
    FAILS=$((FAILS+1))
else
    echo "PASS: Short sentences = $SHORT"
fi

# 7. Contractions
CONTRACTIONS=$(grep -ciE "you're|it's|don't|doesn't|didn't|can't|won't|I'm|I've|I'll|we're|we've|we'll|they're|they've|that's|there's|here's|what's|who's|isn't|aren't|wasn't|weren't|hasn't|haven't|hadn't|couldn't|wouldn't|shouldn't" "$FILE" 2>/dev/null) || CONTRACTIONS=0
if [ "$WORD_COUNT" -gt 0 ]; then
    MIN_CONTRACTIONS=$((WORD_COUNT * 2 / 500))
else
    MIN_CONTRACTIONS=0
fi
if [ "$CONTRACTIONS" -lt "$MIN_CONTRACTIONS" ]; then
    echo "FAIL: Contractions ($CONTRACTIONS found, need $MIN_CONTRACTIONS for $WORD_COUNT words)"
    FAILS=$((FAILS+1))
else
    echo "PASS: Contractions = $CONTRACTIONS (need $MIN_CONTRACTIONS)"
fi

# 8. Community quote
QUOTES=$(grep -ciE "one mum|one parent|as one parent|parent shared|parents in our community|mum put it|parent told" "$FILE" 2>/dev/null) || QUOTES=0
if [ "$QUOTES" -lt 1 ]; then
    echo "FAIL: No community quote with attribution found"
    FAILS=$((FAILS+1))
else
    echo "PASS: Community quote found ($QUOTES)"
fi

# 9. HushAway in intro (first 500 words approximation - first 3000 chars)
INTRO=$(head -c 3000 "$FILE")
HUSHAWAY_INTRO=$(echo "$INTRO" | grep -c "HushAway®") || HUSHAWAY_INTRO=0
if [ "$HUSHAWAY_INTRO" -lt 1 ]; then
    echo "FAIL: HushAway® not in introduction (first 500 words)"
    FAILS=$((FAILS+1))
else
    echo "PASS: HushAway® in introduction"
fi

# 10. And/But sentence starters (need 2+)
AND_BUT=$(grep -cE "^(And|But) " "$FILE" 2>/dev/null) || AND_BUT=0
if [ "$AND_BUT" -lt 2 ]; then
    echo "FAIL: And/But sentence starters = $AND_BUT (need at least 2)"
    FAILS=$((FAILS+1))
else
    echo "PASS: And/But starters = $AND_BUT"
fi

# ============================================================================
# NEW CHECKS (11-16) - These caused iteration loops in previous sessions
# ============================================================================

echo ""
echo "--- Additional checks (previously caused iterations) ---"
echo ""

# 11. Hedging density (max 8 per 1000 words)
HEDGES=$(grep -oiE "\bmay\b|\bmight\b|\bcould\b|\bpotentially\b|\bpossibly\b|\bperhaps\b|\blikely\b|\bunlikely\b|\boften\b|\btend to\b|\btends to\b" "$FILE" 2>/dev/null | wc -l | tr -d ' ') || HEDGES=0
WORDS_K=$((WORD_COUNT / 1000))
[ "$WORDS_K" -lt 1 ] && WORDS_K=1
MAX_HEDGES=$((WORDS_K * 8))
if [ "$HEDGES" -gt "$MAX_HEDGES" ]; then
    echo "FAIL: Hedges = $HEDGES (max $MAX_HEDGES for ${WORD_COUNT} words)"
    echo "      Hedge words: may, might, could, potentially, possibly, perhaps, likely, often"
    FAILS=$((FAILS+1))
else
    echo "PASS: Hedges = $HEDGES (max $MAX_HEDGES)"
fi

# 12. Stacked hedges (multiple in same sentence)
STACKED=$(grep -ciE "(may|might|could|potentially|possibly|often|tend to|tends to).*(may|might|could|potentially|possibly|often|tend to|tends to)" "$FILE" 2>/dev/null) || STACKED=0
if [ "$STACKED" -gt 0 ]; then
    echo "FAIL: Stacked hedges found ($STACKED sentences with 2+ hedges)"
    grep -inE "(may|might|could|potentially|possibly|often|tend to|tends to).*(may|might|could|potentially|possibly|often|tend to|tends to)" "$FILE" 2>/dev/null | head -2
    FAILS=$((FAILS+1))
else
    echo "PASS: No stacked hedges"
fi

# 13. Paragraph variety (3+ paragraphs starting with same word in section)
PARA_START_FAILS=0
SECTION_NUM=0
SCRATCHPAD_DIR=".claude/scratchpad"
mkdir -p "$SCRATCHPAD_DIR" 2>/dev/null
TEMP_PARA_FILE="$SCRATCHPAD_DIR/para_starts_$$"
rm -f "$TEMP_PARA_FILE"

while IFS= read -r line; do
    if echo "$line" | grep -qE "^## "; then
        # New section - check previous section
        if [ "$SECTION_NUM" -gt 0 ] && [ -f "$TEMP_PARA_FILE" ]; then
            DUPE_STARTERS=$(sort "$TEMP_PARA_FILE" | uniq -c | awk '$1 >= 3 {count++} END {print count+0}')
            PARA_START_FAILS=$((PARA_START_FAILS + DUPE_STARTERS))
        fi
        SECTION_NUM=$((SECTION_NUM+1))
        rm -f "$TEMP_PARA_FILE"
    elif [ -n "$line" ] && ! echo "$line" | grep -qE "^#|^-|^\*|^\||^>" ; then
        # Get first word of paragraph
        FIRST_WORD=$(echo "$line" | awk '{print $1}' | tr -d '[:punct:]')
        [ -n "$FIRST_WORD" ] && echo "$FIRST_WORD" >> "$TEMP_PARA_FILE"
    fi
done < "$FILE"

# Check last section
if [ -f "$TEMP_PARA_FILE" ]; then
    DUPE_STARTERS=$(sort "$TEMP_PARA_FILE" | uniq -c | awk '$1 >= 3 {count++} END {print count+0}')
    PARA_START_FAILS=$((PARA_START_FAILS + DUPE_STARTERS))
    rm -f "$TEMP_PARA_FILE"
fi

if [ "$PARA_START_FAILS" -gt 0 ]; then
    echo "FAIL: $PARA_START_FAILS section(s) have 3+ paragraphs starting with same word"
    echo "      Tip: Vary paragraph openers within each H2 section"
    FAILS=$((FAILS+1))
else
    echo "PASS: Paragraph variety OK (no section has 3+ same starts)"
fi

# 14. Primary keyword in H2 heading
TARGET_KEYWORD=$(grep "^targetKeyword:" "$FILE" 2>/dev/null | sed 's/targetKeyword:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$TARGET_KEYWORD" ]; then
    if grep "^## " "$FILE" 2>/dev/null | grep -qi "$TARGET_KEYWORD"; then
        echo "PASS: Primary keyword '$TARGET_KEYWORD' in at least one H2"
    else
        echo "FAIL: Primary keyword '$TARGET_KEYWORD' not in any H2 heading"
        echo "      Tip: Include the keyword in at least one ## heading"
        FAILS=$((FAILS+1))
    fi
else
    echo "WARN: No targetKeyword in frontmatter (skipping H2 keyword check)"
    WARNINGS=$((WARNINGS+1))
fi

# 15. Meta description length (140-160 chars)
META_DESC=$(grep "^metaDescription:" "$FILE" 2>/dev/null | sed 's/metaDescription:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$META_DESC" ]; then
    META_LENGTH=${#META_DESC}
    if [ "$META_LENGTH" -lt 140 ]; then
        echo "FAIL: Meta description too short ($META_LENGTH chars, need 140+)"
        FAILS=$((FAILS+1))
    elif [ "$META_LENGTH" -gt 160 ]; then
        echo "FAIL: Meta description too long ($META_LENGTH chars, max 160)"
        FAILS=$((FAILS+1))
    else
        echo "PASS: Meta description = $META_LENGTH chars (140-160)"
    fi
else
    echo "WARN: No metaDescription in frontmatter"
    WARNINGS=$((WARNINGS+1))
fi

# 16. Commitment language in tables (causes conversion gate failures)
TABLE_COMMIT=$(grep -E "^\|" "$FILE" 2>/dev/null | grep -ciE "subscription|subscribe|trial|premium|upgrade|sign up|register") || TABLE_COMMIT=0
if [ "$TABLE_COMMIT" -gt 0 ]; then
    echo "FAIL: Commitment language in table ($TABLE_COMMIT instances)"
    grep -E "^\|" "$FILE" 2>/dev/null | grep -iE "subscription|subscribe|trial|premium|upgrade|sign up|register" | head -2
    echo "      Use: 'paid monthly' not 'subscription', 'free tier' not 'free trial'"
    FAILS=$((FAILS+1))
else
    echo "PASS: No commitment language in tables"
fi

# --- RESULT ---
echo ""
echo "============================================================================"
if [ "$FAILS" -eq 0 ]; then
    echo "QUICK CHECK: PASS (0 issues, $WARNINGS warnings)"
    echo "Ready for full gate check."
    echo "============================================================================"
    exit 0
else
    echo "QUICK CHECK: $FAILS issue(s) found"
    echo "Fix these before running full gate to save context tokens."
    echo "============================================================================"
    exit 1
fi
