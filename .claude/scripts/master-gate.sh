#!/bin/bash
# ============================================================================
# MASTER HUMANISATION GATE - Fully Automated (23 Sections)
# ============================================================================
# Usage: ./master-gate.sh <filename> [hub|cluster] [--remediate]
# Example: ./master-gate.sh article.md hub
# Example: ./master-gate.sh article.md cluster --remediate
#
# Exit codes: 0 = PASS (GATE OPEN), 1 = FAIL (GATE CLOSED)
#
# This script enforces ALL rules from .claude/humanise-content.md
# No manual steps required - everything is automated.
#
# --remediate flag: Only shows failures, suppresses verbose PASS output
#                   Use on 2nd+ runs to reduce context window usage
#
# Sections (23 total):
# 1-4:   Word count, banned words, frequency limits, intensifiers
# 5-7:   Banned phrases, redundant phrases, structural limits
# 8-10:  Hedging density, sentence variety, human markers
# 11-14: Community quotes, citations, curiosity loops, internal links
# 15-17: Trademark, em-dashes, emojis
# 18-20: Brand prominence, keyword placement, title/meta
# 21:    External links
# 22:    Additional structural checks (self-answering Qs, paragraph starters, list variety)
# 23:    Additional human voice checks (consecutive It, on one hand pattern, external link count)
# ============================================================================

# --- ARGUMENTS ---
FILE="$1"
TYPE="$2"
REMEDIATE="$3"

# --- REMEDIATION MODE ---
QUIET_PASS=false
if [ "$REMEDIATE" = "--remediate" ]; then
    QUIET_PASS=true
fi

# Helper function for pass output (suppressed in remediate mode)
pass_msg() {
    if [ "$QUIET_PASS" = false ]; then
        echo "PASS: $1"
    fi
}

if [ -z "$FILE" ] || [ -z "$TYPE" ]; then
    echo "============================================================================"
    echo "ERROR: Both filename and article type are REQUIRED"
    echo "============================================================================"
    echo ""
    echo "Usage: ./master-gate.sh <filename> <hub|cluster>"
    echo ""
    echo "Examples:"
    echo "  ./master-gate.sh article.md hub      # For pillar hub articles (3000+ words)"
    echo "  ./master-gate.sh article.md cluster  # For cluster articles (1500+ words)"
    echo ""
    echo "IMPORTANT: You must specify 'hub' or 'cluster' to set correct minimums."
    echo "           Hub articles: 3000 words, 2 quotes, 2 loops, 8 links, 3 citations"
    echo "           Cluster articles: 1500 words, 1 quote, 1 loop, 4 links, 2 citations"
    exit 1
fi

if [ "$TYPE" != "hub" ] && [ "$TYPE" != "cluster" ]; then
    echo "============================================================================"
    echo "ERROR: Invalid article type '$TYPE'"
    echo "============================================================================"
    echo ""
    echo "Type must be either 'hub' or 'cluster'"
    echo ""
    echo "Usage: ./master-gate.sh <filename> <hub|cluster>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

# --- CONFIGURATION BASED ON TYPE ---
if [ "$TYPE" = "hub" ]; then
    MIN_WORDS=3000
    MIN_COMMUNITY_QUOTES=2
    MIN_CURIOSITY_LOOPS=2
    MIN_INTERNAL_LINKS=8
    MIN_CITATIONS=3
else
    MIN_WORDS=1500
    MIN_COMMUNITY_QUOTES=1
    MIN_CURIOSITY_LOOPS=1
    MIN_INTERNAL_LINKS=4
    MIN_CITATIONS=2
fi

# --- COUNTERS ---
WORD_COUNT=$(wc -w < "$FILE" | tr -d ' ')
FAILS=0
WARNINGS=0

# --- URL-STRIPPED CONTENT (for banned word checks) ---
# This prevents URLs containing banned words (e.g., NHS "disorder" URLs) from triggering false positives
# Pattern: Remove markdown links entirely [text](url), then remove any remaining http/https URLs
CONTENT_NO_URLS=$(sed -E 's|\[([^]]*)\]\([^)]+\)|\1|g; s|https?://[^)"'\'' >]+||g' "$FILE")

echo "============================================================================"
echo "MASTER HUMANISATION GATE"
echo "============================================================================"
echo "File: $FILE"
echo "Type: $TYPE"
echo "Word Count: $WORD_COUNT (min: $MIN_WORDS)"
echo "Timestamp: $(date)"
echo "============================================================================"

# --- SECTION 1: WORD COUNT ---
echo ""
echo ">>> SECTION 1: WORD COUNT"
if [ "$WORD_COUNT" -lt "$MIN_WORDS" ]; then
    echo "FAIL: Word count $WORD_COUNT < minimum $MIN_WORDS"
    FAILS=$((FAILS+1))
else
    pass_msg "Word count $WORD_COUNT >= $MIN_WORDS"
fi

# --- SECTION 2: BANNED WORDS (must be 0) ---
echo ""
echo ">>> SECTION 2: BANNED WORDS (must be 0)"

# AI-isms (complete list from humanise-content.md)
AIISMS=$(grep -ciE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital|realm|multifaceted|paradigm|synergy|harness|unlock|empower|straightforward|seamless|seamlessly|utilize|utilise|facilitate|optimal|plethora|myriad|pivotal|foster|bolster|whilst|moreover|furthermore|additionally|hence|thus|therefore|consequently|nevertheless|nonetheless|notwithstanding|firstly|secondly|thirdly|aforementioned|underscore|coupled with|in essence|certainly|essentially|fundamentally|undoubtedly|remarkably|ultimately|notably|evidently|inherently|arguably|invariably|interestingly" "$FILE" 2>/dev/null) || AIISMS=0
if [ "$AIISMS" -gt 0 ]; then
    echo "FAIL: AI-isms found: $AIISMS"
    grep -inE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital|realm|multifaceted|paradigm|synergy|harness|unlock|empower|straightforward|seamless|seamlessly|utilize|utilise|facilitate|optimal|plethora|myriad|pivotal|foster|bolster|whilst|moreover|furthermore|additionally|hence|thus|therefore|consequently|nevertheless|nonetheless|notwithstanding|firstly|secondly|thirdly|aforementioned|underscore|coupled with|in essence|certainly|essentially|fundamentally|undoubtedly|remarkably|ultimately|notably|evidently|inherently|arguably|invariably|interestingly" "$FILE" 2>/dev/null | head -10
    FAILS=$((FAILS+1))
else
    pass_msg "No AI-isms"
fi

# Hyperbolic/misused (0 allowed)
HYPERBOLIC=$(grep -ciwE "amazing|literally|obviously" "$FILE" 2>/dev/null) || HYPERBOLIC=0
if [ "$HYPERBOLIC" -gt 0 ]; then
    echo "FAIL: Hyperbolic words (amazing/literally/obviously): $HYPERBOLIC"
    grep -inwE "amazing|literally|obviously" "$FILE" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No hyperbolic words"
fi

# Deficit language (uses URL-stripped content to avoid false positives from URLs)
DEFICIT=$(echo "$CONTENT_NO_URLS" | grep -ciE "\bfix\b|\bcure\b|\bnormal\b|suffering from|special needs|afflicted|victim|deficient|abnormal" 2>/dev/null) || DEFICIT=0
if [ "$DEFICIT" -gt 0 ]; then
    echo "FAIL: Deficit language found: $DEFICIT"
    echo "$CONTENT_NO_URLS" | grep -inE "\bfix\b|\bcure\b|\bnormal\b|suffering from|special needs" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No deficit language"
fi

# Clinical terms (uses URL-stripped content to avoid false positives from official URLs)
CLINICAL=$(echo "$CONTENT_NO_URLS" | grep -ciE "\bdisorder\b|\bpatient\b|\btreatment\b|\bsymptoms\b" 2>/dev/null) || CLINICAL=0
if [ "$CLINICAL" -gt 0 ]; then
    echo "FAIL: Clinical terms found: $CLINICAL"
    echo "$CONTENT_NO_URLS" | grep -inE "\bdisorder\b|\bpatient\b|\btreatment\b|\bsymptoms\b" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No clinical terms"
fi

# American English (expanded list)
# Note: "practice" removed - UK uses "practice" (noun) and "practise" (verb). Only "practicing" is American.
AMERICAN=$(grep -ciE "\bmom\b|\bcolor\b|\bbehavior\b|\bfavor\b|\bhonor\b|\borganize\b|\brecognize\b|\brealize\b|\banalyze\b|\bcenter\b|\bfiber\b|\btheater\b|\btraveled\b|\bcanceled\b|\bfavorite\b|\bneighbor\b|\blabor\b|\bpediatric\b|\bspecialized\b|\bpracticing\b" "$FILE" 2>/dev/null) || AMERICAN=0
if [ "$AMERICAN" -gt 0 ]; then
    echo "FAIL: American English found: $AMERICAN"
    grep -inE "\bmom\b|\bcolor\b|\bbehavior\b|\bfavor\b|\bhonor\b|\borganize\b|\brecognize\b|\btraveled\b|\bcanceled\b|\bpracticing\b" "$FILE" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No American English"
fi

# --- SECTION 3: FREQUENCY-LIMITED WORDS ---
echo ""
echo ">>> SECTION 3: FREQUENCY-LIMITED WORDS"

# Calculate scaling factor for longer articles
# Base limits apply at 2000 words, +1 allowance per 1500 words beyond that
SCALE_FACTOR=$(( (WORD_COUNT - 2000) / 1500 ))
[ "$SCALE_FACTOR" -lt 0 ] && SCALE_FACTOR=0
echo "INFO: Scaling factor = $SCALE_FACTOR (for $WORD_COUNT words)"

check_frequency() {
    local word="$1"
    local max="$2"
    local count
    count=$(grep -ciw "$word" "$FILE" 2>/dev/null) || count=0
    if [ "$count" -gt "$max" ]; then
        echo "FAIL: '$word' appears $count times (max $max)"
        FAILS=$((FAILS+1))
    else
        pass_msg "'$word' = $count (max $max)"
    fi
}

check_frequency_pattern() {
    local pattern="$1"
    local label="$2"
    local max="$3"
    local count
    count=$(grep -ciE "$pattern" "$FILE" 2>/dev/null) || count=0
    if [ "$count" -gt "$max" ]; then
        echo "FAIL: '$label' appears $count times (max $max)"
        FAILS=$((FAILS+1))
    else
        pass_msg "'$label' = $count (max $max)"
    fi
}

# Fixed limits (these words should be rare regardless of article length)
check_frequency "specifically" 2
check_frequency "particularly" 2
check_frequency_pattern "significant|significantly" "significant/ly" 2
check_frequency_pattern "designed to|designed for" "designed to/for" 3
check_frequency "various" 1
check_frequency "numerous" 1
check_frequency_pattern "ensure|ensuring" "ensure/ing" 2
check_frequency "key" 2
check_frequency "unique" 1
check_frequency "tailored" 1
check_frequency "address" 2
check_frequency "essential" 2
check_frequency "powerful" 1
check_frequency_pattern "intended for" "intended for" 1
check_frequency_pattern "aimed at" "aimed at" 1

# Scaled limits (these common words get more allowance in longer articles)
EFFECTIVE_MAX=$((2 + SCALE_FACTOR))
HELPFUL_MAX=$((3 + SCALE_FACTOR))
IMPORTANT_MAX=$((3 + SCALE_FACTOR))

check_frequency_pattern "effective|effectively" "effective/ly" "$EFFECTIVE_MAX"
check_frequency "helpful" "$HELPFUL_MAX"
check_frequency "important" "$IMPORTANT_MAX"

# --- SECTION 4: INTENSIFIER LIMITS ---
echo ""
echo ">>> SECTION 4: INTENSIFIER LIMITS"

# Fixed limits
check_frequency "very" 3
check_frequency "really" 2
check_frequency "truly" 1
check_frequency "highly" 2
check_frequency "extremely" 1
check_frequency "definitely" 1
check_frequency "absolutely" 1
check_frequency_pattern "incredible|incredibly" "incredible/ly" 1
check_frequency "wonderful" 1
check_frequency "clearly" 1
check_frequency "basically" 1

# Scaled limit (actually is a common natural word)
ACTUALLY_MAX=$((2 + SCALE_FACTOR))
check_frequency "actually" "$ACTUALLY_MAX"

# --- SECTION 5: BANNED PHRASES ---
echo ""
echo ">>> SECTION 5: BANNED PHRASES (must be 0)"

check_banned() {
    local pattern="$1"
    local label="$2"
    local count
    count=$(grep -ciE "$pattern" "$FILE" 2>/dev/null) || count=0
    if [ "$count" -gt 0 ]; then
        echo "FAIL: $label found: $count"
        grep -inE "$pattern" "$FILE" 2>/dev/null | head -3
        FAILS=$((FAILS+1))
    else
        pass_msg "No $label"
    fi
}

check_banned "in today's world|in today's fast-paced world|when it comes to|if you're like most|you may be wondering|here's everything you need|looking for\?|welcome to our|the good news is|the bad news is|are you struggling with" "banned openers"
check_banned "in conclusion|to sum up|all in all|in summary|to conclude|at the end of the day|the bottom line is|to wrap up|in closing" "banned conclusions"
check_banned "that said|that being said|having said that|with that in mind|moving forward|on that note|along those lines|in light of this|given this|on the other hand" "banned transitions"
check_banned "let's take a closer look|let's take a look at|it's important to understand that|one thing to keep in mind|it's also worth pointing out|it's safe to say that|it bears mentioning|it should be noted|what's interesting is" "banned filler"
check_banned "research has consistently shown|studies have repeatedly demonstrated|experts agree that|evidence suggests|according to experts|science shows|research indicates|studies suggest" "vague citations"
check_banned "the honest answer:|the takeaway\?|the takeaway:|what this means:|the pattern we see:|key findings:|important caveats:|here's the thing:|the bottom line:|the reality is:|the truth is:|in other words:|simply put:|to put it simply:|think of it this way:|consider this:" "labelled transitions"
check_banned "this guide will|in this article|let's dive in|let's explore|without further ado|first and foremost|last but not least|it goes without saying|it's worth noting|it's important to note|needless to say" "guide-speak"

# --- SECTION 6: REDUNDANT PHRASES ---
echo ""
echo ">>> SECTION 6: REDUNDANT PHRASES (must be 0)"

REDUNDANT=$(grep -ciE "completely unique|absolutely essential|very important|basic fundamentals|end result|past history|future plans|free gift|true fact|close proximity|each and every|advance planning|added bonus|brief moment|difficult dilemma|unexpected surprise|completely eliminate|final outcome" "$FILE" 2>/dev/null) || REDUNDANT=0
if [ "$REDUNDANT" -gt 0 ]; then
    echo "FAIL: Redundant phrases found: $REDUNDANT"
    grep -inE "completely unique|absolutely essential|very important|basic fundamentals|end result|past history|future plans" "$FILE" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No redundant phrases"
fi

# --- SECTION 7: STRUCTURAL LIMITS ---
echo ""
echo ">>> SECTION 7: STRUCTURAL LIMITS"

THIS_IS=$(grep -ciE "this is why|this is where|this is what" "$FILE" 2>/dev/null) || THIS_IS=0
if [ "$THIS_IS" -gt 3 ]; then
    echo "FAIL: 'This is why/where/what' appears $THIS_IS times (max 3)"
    FAILS=$((FAILS+1))
else
    pass_msg "'This is why/where/what' = $THIS_IS (max 3)"
fi

EXAMPLES_INCLUDE=$(grep -ci "examples include" "$FILE" 2>/dev/null) || EXAMPLES_INCLUDE=0
if [ "$EXAMPLES_INCLUDE" -gt 2 ]; then
    echo "FAIL: 'Examples include' appears $EXAMPLES_INCLUDE times (max 2)"
    FAILS=$((FAILS+1))
else
    pass_msg "'Examples include' = $EXAMPLES_INCLUDE (max 2)"
fi

BACKWARD=$(grep -ciE "as mentioned earlier|as stated above|as previously discussed|as noted earlier" "$FILE" 2>/dev/null) || BACKWARD=0
if [ "$BACKWARD" -gt 1 ]; then
    echo "FAIL: Backward references appear $BACKWARD times (max 1)"
    FAILS=$((FAILS+1))
else
    pass_msg "Backward references = $BACKWARD (max 1)"
fi

LY_ADVERBS=$(grep -cE "^(Interestingly|Unfortunately|Importantly|Surprisingly|Notably|Significantly|Remarkably|Understandably|Evidently|Inherently|Arguably|Invariably)," "$FILE" 2>/dev/null) || LY_ADVERBS=0
if [ "$LY_ADVERBS" -gt 2 ]; then
    echo "FAIL: Sentence-initial -ly adverbs = $LY_ADVERBS (max 2)"
    FAILS=$((FAILS+1))
else
    pass_msg "Sentence-initial -ly adverbs = $LY_ADVERBS (max 2)"
fi

# --- SECTION 8: HEDGING DENSITY ---
echo ""
echo ">>> SECTION 8: HEDGING DENSITY"

HEDGES=$(grep -oiE "\bmay\b|\bmight\b|\bcould\b|\bpotentially\b|\bpossibly\b|\bperhaps\b|\blikely\b|\bunlikely\b|\boften\b|\btend to\b|\btends to\b" "$FILE" 2>/dev/null | wc -l | tr -d ' ') || HEDGES=0
WORDS_K=$((WORD_COUNT / 1000))
[ "$WORDS_K" -lt 1 ] && WORDS_K=1
MAX_HEDGES=$((WORDS_K * 8))
if [ "$HEDGES" -gt "$MAX_HEDGES" ]; then
    echo "FAIL: Hedges = $HEDGES (max $MAX_HEDGES for ${WORD_COUNT} words)"
    FAILS=$((FAILS+1))
else
    pass_msg "Hedges = $HEDGES (max $MAX_HEDGES)"
fi

# Check for stacked hedges (multiple in same sentence)
STACKED=$(grep -ciE "(may|might|could|potentially|possibly|often|tend to|tends to).*(may|might|could|potentially|possibly|often|tend to|tends to)" "$FILE" 2>/dev/null) || STACKED=0
if [ "$STACKED" -gt 0 ]; then
    echo "FAIL: Stacked hedges found: $STACKED"
    grep -inE "(may|might|could|potentially|possibly|often|tend to|tends to).*(may|might|could|potentially|possibly|often|tend to|tends to)" "$FILE" 2>/dev/null | head -3
    FAILS=$((FAILS+1))
else
    pass_msg "No stacked hedges"
fi

# --- SECTION 9: SENTENCE VARIETY (Automated) ---
echo ""
echo ">>> SECTION 9: SENTENCE VARIETY"

# Count sentences starting with "This" (global check)
THIS_STARTS=$(grep -cE "^This " "$FILE" 2>/dev/null) || THIS_STARTS=0
if [ "$THIS_STARTS" -gt 6 ]; then
    echo "FAIL: Sentences starting with 'This' = $THIS_STARTS (max 6 for article)"
    FAILS=$((FAILS+1))
else
    pass_msg "Sentences starting with 'This' = $THIS_STARTS (global)"
fi

# Per-section "This" limit check (max 2 per H2 section)
THIS_SECTION_FAILS=0
SECTION_NUM=0
SECTION_THIS_COUNT=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^## "; then
        # New section - check previous section count
        if [ "$SECTION_NUM" -gt 0 ] && [ "$SECTION_THIS_COUNT" -gt 2 ]; then
            THIS_SECTION_FAILS=$((THIS_SECTION_FAILS+1))
        fi
        SECTION_NUM=$((SECTION_NUM+1))
        SECTION_THIS_COUNT=0
    elif echo "$line" | grep -qE "^This "; then
        SECTION_THIS_COUNT=$((SECTION_THIS_COUNT+1))
    fi
done < "$FILE"
# Check last section
if [ "$SECTION_NUM" -gt 0 ] && [ "$SECTION_THIS_COUNT" -gt 2 ]; then
    THIS_SECTION_FAILS=$((THIS_SECTION_FAILS+1))
fi

if [ "$THIS_SECTION_FAILS" -gt 0 ]; then
    echo "FAIL: $THIS_SECTION_FAILS H2 section(s) have 3+ sentences starting with 'This' (max 2 per section)"
    FAILS=$((FAILS+1))
else
    pass_msg "No H2 section exceeds 2 'This' sentence starts"
fi

# Count "you/your" sentence starts (total)
YOU_YOUR_TOTAL=$(grep -cE "^(You|Your)" "$FILE" 2>/dev/null) || YOU_YOUR_TOTAL=0
echo "INFO: Total 'You/Your' sentence starts = $YOU_YOUR_TOTAL"

# Check for 3+ consecutive sentences starting with You/Your (FAIL condition)
CONSECUTIVE_YOU=0
PREV_YOU=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^(You|Your)"; then
        PREV_YOU=$((PREV_YOU+1))
        if [ "$PREV_YOU" -ge 3 ]; then
            CONSECUTIVE_YOU=$((CONSECUTIVE_YOU+1))
        fi
    else
        PREV_YOU=0
    fi
done < "$FILE"

if [ "$CONSECUTIVE_YOU" -gt 0 ]; then
    echo "FAIL: Found $CONSECUTIVE_YOU instance(s) of 3+ consecutive 'You/Your' sentences (max 0)"
    FAILS=$((FAILS+1))
else
    pass_msg "No consecutive 'You/Your' patterns (3+ in a row)"
fi

# Check for short sentences (under 8 words) - global check
SHORT_SENTENCES=$(grep -cE "^[^.]{1,40}\.$" "$FILE" 2>/dev/null) || SHORT_SENTENCES=0
if [ "$SHORT_SENTENCES" -lt 3 ]; then
    echo "FAIL: Short sentences (under ~8 words) = $SHORT_SENTENCES (need at least 3 total)"
    FAILS=$((FAILS+1))
else
    pass_msg "Short sentences = $SHORT_SENTENCES (global)"
fi

# Per-section short sentence check (min 1 per H2 section)
SHORT_SECTION_FAILS=0
SECTION_NUM=0
SECTION_SHORT_COUNT=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^## "; then
        # New section - check previous section count
        if [ "$SECTION_NUM" -gt 0 ] && [ "$SECTION_SHORT_COUNT" -lt 1 ]; then
            SHORT_SECTION_FAILS=$((SHORT_SECTION_FAILS+1))
        fi
        SECTION_NUM=$((SECTION_NUM+1))
        SECTION_SHORT_COUNT=0
    elif echo "$line" | grep -qE "^[^.#]{1,40}\.$"; then
        SECTION_SHORT_COUNT=$((SECTION_SHORT_COUNT+1))
    fi
done < "$FILE"
# Check last section
if [ "$SECTION_NUM" -gt 0 ] && [ "$SECTION_SHORT_COUNT" -lt 1 ]; then
    SHORT_SECTION_FAILS=$((SHORT_SECTION_FAILS+1))
fi

if [ "$SHORT_SECTION_FAILS" -gt 0 ]; then
    echo "WARN: $SHORT_SECTION_FAILS H2 section(s) have no short sentences (recommended: 1+ per section)"
    WARNINGS=$((WARNINGS+1))
else
    pass_msg "All H2 sections have at least 1 short sentence"
fi

# --- SECTION 10: HUMAN MARKERS (must have) ---
echo ""
echo ">>> SECTION 10: HUMAN MARKERS (required)"

AND_BUT=$(grep -cE "^(And|But) " "$FILE" 2>/dev/null) || AND_BUT=0
if [ "$AND_BUT" -lt 2 ]; then
    echo "FAIL: And/But sentence starters = $AND_BUT (need at least 2)"
    FAILS=$((FAILS+1))
else
    pass_msg "And/But starters = $AND_BUT"
fi

WE_USAGE=$(grep -ciw "we" "$FILE" 2>/dev/null) || WE_USAGE=0
if [ "$WE_USAGE" -lt 2 ]; then
    echo "FAIL: 'We' usage = $WE_USAGE (need at least 2)"
    FAILS=$((FAILS+1))
else
    pass_msg "'We' usage = $WE_USAGE"
fi

# Contractions check
CONTRACTIONS=$(grep -ciE "you're|it's|don't|doesn't|didn't|can't|won't|I'm|I've|I'll|we're|we've|we'll|they're|they've|that's|there's|here's|what's|who's|isn't|aren't|wasn't|weren't|hasn't|haven't|hadn't|couldn't|wouldn't|shouldn't" "$FILE" 2>/dev/null) || CONTRACTIONS=0
if [ "$WORD_COUNT" -gt 0 ]; then
    CONTRACTION_RATIO=$((CONTRACTIONS * 500 / WORD_COUNT))
else
    CONTRACTION_RATIO=0
fi
if [ "$CONTRACTION_RATIO" -lt 2 ]; then
    echo "FAIL: Contractions = $CONTRACTIONS (need ~2+ per 500 words)"
    FAILS=$((FAILS+1))
else
    pass_msg "Contractions = $CONTRACTIONS"
fi

# --- SECTION 11: COMMUNITY QUOTES ---
echo ""
echo ">>> SECTION 11: COMMUNITY QUOTES (min: $MIN_COMMUNITY_QUOTES)"

QUOTES=$(grep -ciE "one mum|one parent|as one parent|parent shared|parents in our community|mum put it|parent told" "$FILE" 2>/dev/null) || QUOTES=0
if [ "$QUOTES" -lt "$MIN_COMMUNITY_QUOTES" ]; then
    echo "FAIL: Community quotes = $QUOTES (need at least $MIN_COMMUNITY_QUOTES)"
    FAILS=$((FAILS+1))
else
    pass_msg "Community quotes = $QUOTES"
fi

# --- SECTION 12: DATED CITATIONS ---
echo ""
echo ">>> SECTION 12: DATED CITATIONS (min: $MIN_CITATIONS)"

DATED_CITATIONS=$(grep -cE "20[0-9]{2}" "$FILE" 2>/dev/null) || DATED_CITATIONS=0
if [ "$DATED_CITATIONS" -lt "$MIN_CITATIONS" ]; then
    echo "FAIL: Dated citations = $DATED_CITATIONS (need at least $MIN_CITATIONS)"
    FAILS=$((FAILS+1))
else
    pass_msg "Dated citations = $DATED_CITATIONS"
fi

# --- SECTION 13: CURIOSITY LOOPS ---
echo ""
echo ">>> SECTION 13: CURIOSITY LOOPS (min: $MIN_CURIOSITY_LOOPS)"

# Questions that appear before H2 headings
CURIOSITY=$(grep -B2 "^## " "$FILE" 2>/dev/null | grep -c "?") || CURIOSITY=0
if [ "$CURIOSITY" -lt "$MIN_CURIOSITY_LOOPS" ]; then
    echo "FAIL: Curiosity loops = $CURIOSITY (need at least $MIN_CURIOSITY_LOOPS)"
    FAILS=$((FAILS+1))
else
    pass_msg "Curiosity loops = $CURIOSITY"
fi

# --- SECTION 14: INTERNAL LINKS ---
echo ""
echo ">>> SECTION 14: INTERNAL LINKS (min: $MIN_INTERNAL_LINKS)"

LINKS=$(grep -c "LINK TO:" "$FILE" 2>/dev/null) || LINKS=0
if [ "$LINKS" -lt "$MIN_INTERNAL_LINKS" ]; then
    echo "FAIL: Internal links = $LINKS (need at least $MIN_INTERNAL_LINKS)"
    FAILS=$((FAILS+1))
else
    pass_msg "Internal links = $LINKS"
fi

# --- SECTION 15: TRADEMARK ---
echo ""
echo ">>> SECTION 15: TRADEMARK"

HUSHAWAY_NO_TM=$(grep "HushAway" "$FILE" 2>/dev/null | grep -v "HushAway®" | grep -v "hushaway.com" | wc -l | tr -d ' ') || HUSHAWAY_NO_TM=0
if [ "$HUSHAWAY_NO_TM" -gt 0 ]; then
    echo "FAIL: HushAway without registered symbol found: $HUSHAWAY_NO_TM"
    grep -n "HushAway" "$FILE" 2>/dev/null | grep -v "HushAway®" | grep -v "hushaway.com" | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "All HushAway instances have registered symbol"
fi

# --- SECTION 16: EM-DASHES ---
echo ""
echo ">>> SECTION 16: EM-DASHES (must be 0)"

EMDASH=$(grep -c "—" "$FILE" 2>/dev/null) || EMDASH=0
if [ "$EMDASH" -gt 0 ]; then
    echo "FAIL: Em-dashes found: $EMDASH"
    grep -n "—" "$FILE" 2>/dev/null | head -5
    FAILS=$((FAILS+1))
else
    pass_msg "No em-dashes"
fi

# --- SECTION 17: EMOJIS ---
echo ""
echo ">>> SECTION 17: EMOJIS (must be 0)"

# Check for common emoji unicode ranges (macOS compatible)
EMOJIS=$(grep -c $'[\xF0\x9F]' "$FILE" 2>/dev/null) || EMOJIS=0
if [ "$EMOJIS" -gt 0 ]; then
    echo "FAIL: Emojis found: $EMOJIS"
    FAILS=$((FAILS+1))
else
    pass_msg "No emojis"
fi

# --- SECTION 18: BRAND PROMINENCE ---
echo ""
echo ">>> SECTION 18: BRAND PROMINENCE (required)"

# Extract first 500 words and check for HushAway®
FIRST_500=$(head -c 3000 "$FILE" | tr '\n' ' ')
if echo "$FIRST_500" | grep -q "HushAway®"; then
    pass_msg "HushAway® appears in introduction"
else
    echo "FAIL: HushAway® must appear within first 500 words"
    FAILS=$((FAILS+1))
fi

# Count H2 sections and how many mention HushAway®
TOTAL_H2=$(grep -c "^## " "$FILE" 2>/dev/null) || TOTAL_H2=0
if [ "$TOTAL_H2" -gt 0 ]; then
    # Get H2 sections that mention HushAway® (looking at H2 and next 20 lines)
    H2_WITH_HUSHAWAY=0
    while IFS= read -r line_num; do
        section_content=$(sed -n "${line_num},$((line_num+20))p" "$FILE" 2>/dev/null)
        if echo "$section_content" | grep -q "HushAway®"; then
            H2_WITH_HUSHAWAY=$((H2_WITH_HUSHAWAY+1))
        fi
    done < <(grep -n "^## " "$FILE" 2>/dev/null | cut -d: -f1)

    HALF_H2=$(( (TOTAL_H2 + 1) / 2 ))
    if [ "$H2_WITH_HUSHAWAY" -lt "$HALF_H2" ]; then
        echo "FAIL: HushAway® in only $H2_WITH_HUSHAWAY of $TOTAL_H2 H2 sections (need $HALF_H2 or more)"
        FAILS=$((FAILS+1))
    else
        pass_msg "HushAway® in $H2_WITH_HUSHAWAY of $TOTAL_H2 H2 sections"
    fi
else
    echo "WARN: No H2 sections found"
    WARNINGS=$((WARNINGS+1))
fi

# Check for comparison element (table or side-by-side)
HAS_TABLE=$(grep -c "^|" "$FILE" 2>/dev/null) || HAS_TABLE=0
HAS_COMPARISON=$(grep -ciE "comparison|compare|vs\.?|versus|side.by.side|how .* differs" "$FILE" 2>/dev/null) || HAS_COMPARISON=0
if [ "$HAS_TABLE" -gt 2 ] || [ "$HAS_COMPARISON" -gt 0 ]; then
    pass_msg "Comparison element found"
else
    echo "FAIL: Missing comparison element (table or side-by-side content)"
    FAILS=$((FAILS+1))
fi

# --- SECTION 19: KEYWORD PLACEMENT ---
echo ""
echo ">>> SECTION 19: KEYWORD PLACEMENT (SEO requirement)"

# Extract targetKeyword from frontmatter
TARGET_KEYWORD=$(grep "^targetKeyword:" "$FILE" 2>/dev/null | sed 's/targetKeyword:[[:space:]]*//' | tr -d '"' | tr -d "'")

if [ -n "$TARGET_KEYWORD" ]; then
    # Check keyword in first 150 words (approximately first 1000 chars)
    FIRST_150=$(head -c 1000 "$FILE" | tr '\n' ' ')
    if echo "$FIRST_150" | grep -qi "$TARGET_KEYWORD"; then
        pass_msg "Primary keyword '$TARGET_KEYWORD' in first 150 words"
    else
        echo "FAIL: Primary keyword '$TARGET_KEYWORD' not found in first 150 words"
        FAILS=$((FAILS+1))
    fi

    # Check keyword in at least one H2
    if grep "^## " "$FILE" 2>/dev/null | grep -qi "$TARGET_KEYWORD"; then
        pass_msg "Primary keyword in at least one H2"
    else
        echo "FAIL: Primary keyword '$TARGET_KEYWORD' not in any H2 heading"
        FAILS=$((FAILS+1))
    fi
else
    echo "FAIL: No targetKeyword found in frontmatter"
    FAILS=$((FAILS+1))
fi

# --- SECTION 20: TITLE AND META DESCRIPTION ---
echo ""
echo ">>> SECTION 20: TITLE AND META DESCRIPTION"

# Extract title from frontmatter
TITLE=$(grep "^title:" "$FILE" 2>/dev/null | sed 's/title:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$TITLE" ]; then
    TITLE_LENGTH=${#TITLE}
    if [ "$TITLE_LENGTH" -gt 60 ]; then
        echo "FAIL: Title length $TITLE_LENGTH chars (max 60)"
        FAILS=$((FAILS+1))
    else
        pass_msg "Title length $TITLE_LENGTH chars"
    fi
else
    echo "FAIL: No title found in frontmatter"
    FAILS=$((FAILS+1))
fi

# Extract metaDescription from frontmatter
META_DESC=$(grep "^metaDescription:" "$FILE" 2>/dev/null | sed 's/metaDescription:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$META_DESC" ]; then
    META_LENGTH=${#META_DESC}
    if [ "$META_LENGTH" -lt 140 ]; then
        echo "FAIL: Meta description $META_LENGTH chars (min 140)"
        FAILS=$((FAILS+1))
    elif [ "$META_LENGTH" -gt 160 ]; then
        echo "FAIL: Meta description $META_LENGTH chars (max 160)"
        FAILS=$((FAILS+1))
    else
        pass_msg "Meta description $META_LENGTH chars"
    fi

    # Check if meta contains keyword
    if [ -n "$TARGET_KEYWORD" ]; then
        if echo "$META_DESC" | grep -qi "$TARGET_KEYWORD"; then
            pass_msg "Meta description contains primary keyword"
        else
            echo "FAIL: Meta description missing primary keyword '$TARGET_KEYWORD'"
            FAILS=$((FAILS+1))
        fi
    fi
else
    echo "FAIL: No metaDescription found in frontmatter"
    FAILS=$((FAILS+1))
fi

# --- SECTION 21: EXTERNAL LINKS ---
echo ""
echo ">>> SECTION 21: EXTERNAL LINKS (UK sources only)"

# Extract all external links (http/https URLs not hushaway.com)
EXTERNAL_LINKS=$(grep -oE "https?://[^)\"' >]+" "$FILE" 2>/dev/null | grep -v "hushaway.com" | sort -u)

if [ -n "$EXTERNAL_LINKS" ]; then
    BAD_EXTERNAL=0
    while IFS= read -r link; do
        # Check if it's an approved UK source
        if echo "$link" | grep -qiE "nhs\.uk|adhduk\.co\.uk|nice\.org\.uk|bps\.org\.uk|rcpsych\.ac\.uk|gov\.uk|ncbi\.nlm\.nih\.gov|pubmed|apa\.org"; then
            pass_msg "Approved source: $link"
        else
            # Check for US-specific sources (flag as warning for review)
            if echo "$link" | grep -qiE "\.com|cdc\.gov|nimh\.nih\.gov|aap\.org"; then
                echo "WARN: Non-UK source needs review: $link"
                WARNINGS=$((WARNINGS+1))
            else
                pass_msg "Link accepted: $link"
            fi
        fi
    done <<< "$EXTERNAL_LINKS"
else
    echo "INFO: No external links found"
fi

# --- SECTION 22: ADDITIONAL STRUCTURAL CHECKS (Previously Manual) ---
echo ""
echo ">>> SECTION 22: ADDITIONAL STRUCTURAL CHECKS"

# Check for self-answering questions (? followed by formulaic answer patterns)
# Note: Removed "Yes,", "No,", "It depends" - these are natural conversational responses
# Only flag truly formulaic AI-like patterns
SELF_ANSWER=$(grep -ciE "\?[^?]*\b(The answer is|The answer:|The honest answer|The short answer|The simple answer|Here's the answer)" "$FILE" 2>/dev/null) || SELF_ANSWER=0
if [ "$SELF_ANSWER" -gt 0 ]; then
    echo "FAIL: Self-answering questions found: $SELF_ANSWER (questions followed by formulaic 'The answer is' patterns)"
    grep -inE "\?[^?]*\b(The answer is|The answer:|The honest answer|The short answer|The simple answer|Here's the answer)" "$FILE" 2>/dev/null | head -3
    FAILS=$((FAILS+1))
else
    pass_msg "No formulaic self-answering question patterns detected"
fi

# Check for paragraph starters (3+ paragraphs starting with same word per section)
# Uses temp file approach for macOS bash 3.2 compatibility (no associative arrays)
PARA_START_FAILS=0
SECTION_NUM=0
# Use project-local scratchpad (sandbox-safe)
SCRATCHPAD_DIR=".claude/scratchpad"
mkdir -p "$SCRATCHPAD_DIR"
TEMP_PARA_FILE="$SCRATCHPAD_DIR/para_starts_$$"
rm -f "$TEMP_PARA_FILE"

while IFS= read -r line; do
    if echo "$line" | grep -qE "^## "; then
        # New section - check previous section using temp file
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
    echo "FAIL: $PARA_START_FAILS instance(s) of 3+ paragraphs starting with same word in a section"
    FAILS=$((FAILS+1))
else
    pass_msg "No section has 3+ paragraphs starting with same word"
fi

# Check for list variety (detect identical bullet point starts)
LIST_IDENTICAL=0
PREV_BULLET=""
IDENTICAL_COUNT=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^- "; then
        BULLET_START=$(echo "$line" | sed 's/^- //' | awk '{print $1}')
        if [ "$BULLET_START" = "$PREV_BULLET" ]; then
            IDENTICAL_COUNT=$((IDENTICAL_COUNT+1))
            if [ "$IDENTICAL_COUNT" -ge 4 ]; then
                LIST_IDENTICAL=$((LIST_IDENTICAL+1))
                IDENTICAL_COUNT=0
            fi
        else
            IDENTICAL_COUNT=1
        fi
        PREV_BULLET="$BULLET_START"
    else
        PREV_BULLET=""
        IDENTICAL_COUNT=0
    fi
done < "$FILE"

if [ "$LIST_IDENTICAL" -gt 0 ]; then
    echo "FAIL: Found $LIST_IDENTICAL list(s) with 5+ bullets starting with identical word (vary structure)"
    FAILS=$((FAILS+1))
else
    pass_msg "List structure has variety (no identical word starts)"
fi

# Check for lists where all bullets start with "The"
THE_LISTS=0
THE_COUNT=0
IN_LIST=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^- "; then
        IN_LIST=1
        if echo "$line" | grep -qE "^- The "; then
            THE_COUNT=$((THE_COUNT+1))
        fi
    elif [ "$IN_LIST" -eq 1 ]; then
        # End of list - check count
        if [ "$THE_COUNT" -ge 5 ]; then
            THE_LISTS=$((THE_LISTS+1))
        fi
        THE_COUNT=0
        IN_LIST=0
    fi
done < "$FILE"
# Check final list
if [ "$THE_COUNT" -ge 5 ]; then
    THE_LISTS=$((THE_LISTS+1))
fi

if [ "$THE_LISTS" -gt 0 ]; then
    echo "FAIL: Found $THE_LISTS list(s) with 5+ bullets starting with 'The' (vary structure)"
    FAILS=$((FAILS+1))
else
    pass_msg "No lists with all 'The' starts"
fi

# Check for lists where all bullets start with verbs (common AI pattern)
# Detects patterns like: "- Provides...", "- Creates...", "- Reduces..."
VERB_LISTS=0
VERB_COUNT=0
NON_VERB_COUNT=0
IN_LIST=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^- "; then
        IN_LIST=1
        # Check if starts with common verb endings (third person present)
        if echo "$line" | grep -qE "^- [A-Z][a-z]+(s|es|ies) "; then
            VERB_COUNT=$((VERB_COUNT+1))
        else
            NON_VERB_COUNT=$((NON_VERB_COUNT+1))
        fi
    elif [ "$IN_LIST" -eq 1 ]; then
        # End of list - check if all verbs and 5+ items
        TOTAL_IN_LIST=$((VERB_COUNT + NON_VERB_COUNT))
        if [ "$VERB_COUNT" -ge 5 ] && [ "$NON_VERB_COUNT" -eq 0 ]; then
            VERB_LISTS=$((VERB_LISTS+1))
        fi
        VERB_COUNT=0
        NON_VERB_COUNT=0
        IN_LIST=0
    fi
done < "$FILE"
# Check final list
TOTAL_IN_LIST=$((VERB_COUNT + NON_VERB_COUNT))
if [ "$VERB_COUNT" -ge 5 ] && [ "$NON_VERB_COUNT" -eq 0 ]; then
    VERB_LISTS=$((VERB_LISTS+1))
fi

if [ "$VERB_LISTS" -gt 0 ]; then
    echo "WARN: Found $VERB_LISTS list(s) with 5+ bullets all starting with verbs (consider varying)"
    WARNINGS=$((WARNINGS+1))
else
    pass_msg "No lists with all verb starts"
fi

# Check for section length variety (no more than 3 sections of identical length)
SECTION_LENGTHS=()
CURRENT_LENGTH=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^## "; then
        if [ "$CURRENT_LENGTH" -gt 0 ]; then
            SECTION_LENGTHS+=("$CURRENT_LENGTH")
        fi
        CURRENT_LENGTH=0
    else
        CURRENT_LENGTH=$((CURRENT_LENGTH+1))
    fi
done < "$FILE"
if [ "$CURRENT_LENGTH" -gt 0 ]; then
    SECTION_LENGTHS+=("$CURRENT_LENGTH")
fi

# Check for variance
if [ "${#SECTION_LENGTHS[@]}" -ge 3 ]; then
    MIN_LEN=${SECTION_LENGTHS[0]}
    MAX_LEN=${SECTION_LENGTHS[0]}
    for len in "${SECTION_LENGTHS[@]}"; do
        [ "$len" -lt "$MIN_LEN" ] && MIN_LEN=$len
        [ "$len" -gt "$MAX_LEN" ] && MAX_LEN=$len
    done
    VARIANCE=$((MAX_LEN - MIN_LEN))
    if [ "$VARIANCE" -lt 5 ]; then
        echo "WARN: Section lengths have low variance (min: $MIN_LEN, max: $MAX_LEN lines) - consider varying"
        WARNINGS=$((WARNINGS+1))
    else
        pass_msg "Section lengths have variety (min: $MIN_LEN, max: $MAX_LEN lines)"
    fi
else
    echo "INFO: Not enough sections to check length variety"
fi

# --- SECTION 23: ADDITIONAL HUMAN VOICE CHECKS ---
echo ""
echo ">>> SECTION 23: ADDITIONAL HUMAN VOICE CHECKS"

# Check for consecutive paragraphs starting with "It" (max 2 in a row)
CONSECUTIVE_IT=0
PREV_IT=0
while IFS= read -r line; do
    if echo "$line" | grep -qE "^It "; then
        PREV_IT=$((PREV_IT+1))
        if [ "$PREV_IT" -ge 3 ]; then
            CONSECUTIVE_IT=$((CONSECUTIVE_IT+1))
        fi
    elif [ -n "$line" ] && ! echo "$line" | grep -qE "^#|^-|^\*|^\||^>" ; then
        PREV_IT=0
    fi
done < "$FILE"

if [ "$CONSECUTIVE_IT" -gt 0 ]; then
    echo "FAIL: Found $CONSECUTIVE_IT instance(s) of 3+ consecutive paragraphs starting with 'It' (max 2 in a row)"
    FAILS=$((FAILS+1))
else
    pass_msg "No consecutive 'It' paragraph patterns (3+ in a row)"
fi

# Check for "on one hand... on the other hand" pattern (0 allowed)
ON_ONE_HAND=$(grep -ciE "on (the )?one hand|on the other hand" "$FILE" 2>/dev/null) || ON_ONE_HAND=0
if [ "$ON_ONE_HAND" -gt 0 ]; then
    echo "FAIL: Found 'on one hand/on the other hand' pattern: $ON_ONE_HAND (creates overly balanced AI-like text)"
    grep -inE "on (the )?one hand|on the other hand" "$FILE" 2>/dev/null | head -3
    FAILS=$((FAILS+1))
else
    pass_msg "No 'on one hand/on the other hand' patterns"
fi

# Check minimum external links count
EXTERNAL_LINK_COUNT=$(grep -cE "https?://[^)\"' >]+" "$FILE" 2>/dev/null | grep -v "hushaway.com") || EXTERNAL_LINK_COUNT=0
EXTERNAL_LINK_COUNT=$(grep -oE "https?://[^)\"' >]+" "$FILE" 2>/dev/null | grep -v "hushaway.com" | wc -l | tr -d ' ') || EXTERNAL_LINK_COUNT=0
if [ "$TYPE" = "hub" ]; then
    MIN_EXTERNAL=3
else
    MIN_EXTERNAL=2
fi
if [ "$EXTERNAL_LINK_COUNT" -lt "$MIN_EXTERNAL" ]; then
    echo "FAIL: External links = $EXTERNAL_LINK_COUNT (need at least $MIN_EXTERNAL for $TYPE articles)"
    FAILS=$((FAILS+1))
else
    pass_msg "External links = $EXTERNAL_LINK_COUNT (min $MIN_EXTERNAL)"
fi

# ============================================================================
# FINAL RESULT
# ============================================================================
echo ""
echo "============================================================================"
echo "FINAL RESULT"
echo "============================================================================"
echo "Total checks failed: $FAILS"
echo "Warnings: $WARNINGS"
echo ""

if [ "$FAILS" -eq 0 ]; then
    echo "============================================"
    echo "   CONTENT GATE: PASS"
    echo "   All checks passed. Proceed to Conversion Gate."
    echo "============================================"
    echo ""
    echo "NEXT STEP: Run /direct-response-copy skill, then:"
    echo "  .claude/scripts/check-conversion-gate.sh $FILE"
    echo ""
    exit 0
else
    echo "============================================"
    echo "   CONTENT GATE: FAIL"
    echo "   $FAILS check(s) failed."
    echo "   FIX ALL FAILURES and re-run script."
    echo "   DO NOT PROCEED UNTIL GATE SHOWS PASS."
    echo "============================================"
    exit 1
fi
