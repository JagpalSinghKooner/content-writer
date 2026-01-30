#!/bin/bash
# ============================================================================
# FINAL GATE CHECK - Pre-Export Verification (Gate 6)
# ============================================================================
# Usage: ./check-final-gate.sh <article-file> [hub|cluster]
# Example: ./check-final-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md hub
#
# Exit codes: 0 = PASS (export can proceed), 1 = FAIL (cannot proceed)
#
# RULES SOURCE: .claude/rules/humanise-rules.md Section 7 (Article Thresholds)
# This script enforces thresholds: word counts, meta lengths, link counts.
#
# This script ensures the article is ready for export to the main website.
# Content Gate (master-gate.sh) and Conversion Gate MUST pass before this gate.
# Export cannot proceed until this gate shows PASS.
# ============================================================================

FILE="$1"
TYPE="${2:-hub}"

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "FINAL GATE CHECK (Gate 6)"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-final-gate.sh <article-file> [hub|cluster]"
    echo ""
    echo "Examples:"
    echo "  ./check-final-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md hub"
    echo "  ./check-final-gate.sh src/content/pillar-7-neurodivergent-parenting/7.1-parent-burnout.md cluster"
    echo ""
    echo "This gate verifies article is ready for export:"
    echo "  - Frontmatter complete (title, meta, dates)"
    echo "  - Word count meets minimum"
    echo "  - File in correct location"
    echo "  - No remaining placeholder links"
    echo "  - All mandatory elements present"
    echo ""
    echo "Run AFTER Conversion Gate (check-conversion-gate.sh) passes."
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "FINAL GATE: FAIL"
    echo "============================================================================"
    echo ""
    echo "ERROR: Article file not found: $FILE"
    echo ""
    echo "Ensure you have written the article and passed all previous gates."
    echo ""
    exit 1
fi

# Set word count minimum based on type
if [ "$TYPE" = "hub" ]; then
    MIN_WORDS=3000
else
    MIN_WORDS=1500
fi

echo "============================================================================"
echo "FINAL GATE CHECK (Gate 6)"
echo "============================================================================"
echo "File: $FILE"
echo "Type: $TYPE (minimum $MIN_WORDS words)"
echo "Timestamp: $(date)"
echo "============================================================================"
echo ""
echo "Verifying article is ready for export to main website."
echo ""

FAILS=0
WARNINGS=0

# ============================================================================
# CHECK 1: Frontmatter - Title Present
# ============================================================================
echo ">>> CHECK 1: Frontmatter - Title"
TITLE=$(grep "^title:" "$FILE" 2>/dev/null | sed 's/title:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$TITLE" ] && [ "$TITLE" != "null" ] && [ "$TITLE" != "" ]; then
    # Check title length (must be under 60 chars)
    TITLE_LEN=${#TITLE}
    if [ "$TITLE_LEN" -le 60 ]; then
        echo "PASS: Title present ($TITLE_LEN chars): '$TITLE'"
    else
        echo "FAIL: Title too long ($TITLE_LEN chars, max 60): '$TITLE'"
        FAILS=$((FAILS+1))
    fi
else
    echo "FAIL: No title in frontmatter"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 2: Frontmatter - Meta Description
# ============================================================================
echo ""
echo ">>> CHECK 2: Frontmatter - Meta Description"
META_DESC=$(grep "^metaDescription:" "$FILE" 2>/dev/null | sed 's/metaDescription:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$META_DESC" ] && [ "$META_DESC" != "null" ] && [ "$META_DESC" != "" ]; then
    META_LEN=${#META_DESC}
    if [ "$META_LEN" -ge 140 ] && [ "$META_LEN" -le 160 ]; then
        echo "PASS: Meta description present ($META_LEN chars)"
    elif [ "$META_LEN" -lt 140 ]; then
        echo "FAIL: Meta description too short ($META_LEN chars, need 140-160)"
        FAILS=$((FAILS+1))
    else
        echo "FAIL: Meta description too long ($META_LEN chars, need 140-160)"
        FAILS=$((FAILS+1))
    fi
else
    echo "FAIL: No meta description in frontmatter"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 3: Frontmatter - Dates Present
# ============================================================================
echo ""
echo ">>> CHECK 3: Frontmatter - Dates"
DATE_CREATED=$(grep "^dateCreated:" "$FILE" 2>/dev/null | sed 's/dateCreated:[[:space:]]*//' | tr -d '"' | tr -d "'")
DATE_UPDATED=$(grep "^dateUpdated:" "$FILE" 2>/dev/null | sed 's/dateUpdated:[[:space:]]*//' | tr -d '"' | tr -d "'")

DATE_FAILS=0
if [ -n "$DATE_CREATED" ] && [ "$DATE_CREATED" != "null" ]; then
    echo "PASS: dateCreated present: $DATE_CREATED"
else
    echo "FAIL: No dateCreated in frontmatter"
    DATE_FAILS=$((DATE_FAILS+1))
fi

if [ -n "$DATE_UPDATED" ] && [ "$DATE_UPDATED" != "null" ]; then
    echo "PASS: dateUpdated present: $DATE_UPDATED"
else
    echo "FAIL: No dateUpdated in frontmatter"
    DATE_FAILS=$((DATE_FAILS+1))
fi

if [ "$DATE_FAILS" -gt 0 ]; then
    FAILS=$((FAILS+DATE_FAILS))
fi

# ============================================================================
# CHECK 4: Frontmatter - Status
# ============================================================================
echo ""
echo ">>> CHECK 4: Frontmatter - Status"
STATUS=$(grep "^status:" "$FILE" 2>/dev/null | sed 's/status:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$STATUS" ] && [ "$STATUS" != "null" ]; then
    echo "PASS: Status present: $STATUS"
    if [ "$STATUS" = "draft" ]; then
        echo "      Note: Status is 'draft'. Update to 'in-review' or 'ready' before export."
    fi
else
    echo "FAIL: No status in frontmatter"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 5: Word Count
# ============================================================================
echo ""
echo ">>> CHECK 5: Word Count (minimum $MIN_WORDS)"

# Extract content after frontmatter (skip first --- block only, preserve --- section dividers)
CONTENT=$(awk 'BEGIN{fm=0} /^---$/{fm++; if(fm==2){next}} fm>=2' "$FILE" 2>/dev/null)
WORD_COUNT=$(echo "$CONTENT" | wc -w | tr -d ' ')

if [ "$WORD_COUNT" -ge "$MIN_WORDS" ]; then
    echo "PASS: Word count is $WORD_COUNT (minimum $MIN_WORDS)"
else
    echo "FAIL: Word count is $WORD_COUNT (minimum $MIN_WORDS required)"
    echo "      Add $(($MIN_WORDS - $WORD_COUNT)) more words to meet minimum."
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 6: File Location
# ============================================================================
echo ""
echo ">>> CHECK 6: File Location"

# Check file is in src/content/pillar-* directory
if [[ "$FILE" == *"src/content/pillar-"* ]]; then
    echo "PASS: File in correct content directory"
else
    echo "FAIL: File not in src/content/pillar-* directory"
    echo "      Expected: src/content/pillar-[N]-[topic-name]/[filename].md"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 7: Placeholder Links
# ============================================================================
echo ""
echo ">>> CHECK 7: Placeholder Links"

PLACEHOLDER_COUNT=$(grep -c '\[LINK TO:' "$FILE" 2>/dev/null) || PLACEHOLDER_COUNT=0

if [ "$PLACEHOLDER_COUNT" -eq 0 ]; then
    echo "PASS: No placeholder links remaining"
else
    echo "WARNING: $PLACEHOLDER_COUNT placeholder link(s) remaining"
    echo "      These should be replaced with actual links before final export."
    echo "      Placeholders found:"
    grep '\[LINK TO:' "$FILE" 2>/dev/null | head -5
    WARNINGS=$((WARNINGS+1))
fi

# ============================================================================
# CHECK 8: HushAway Trademark
# ============================================================================
echo ""
echo ">>> CHECK 8: HushAway Trademark Verification"

# Count HushAway without trademark (excluding URLs and possessives)
# Valid forms: HushAway® (trademarked), HushAway's (possessive), hushaway.com (URL)
CONTENT_NO_URLS=$(echo "$CONTENT" | sed 's/hushaway\.com//g' | sed 's/hushaway\.co\.uk//g')
# Pattern: HushAway followed by letter or space (not ®, ', or punctuation like . ! ? , :)
# This catches "HushAway is" but not "HushAway®" or "HushAway's" or "HushAway."
HUSHAWAY_NO_TM=$(echo "$CONTENT_NO_URLS" | grep -cE "HushAway[a-zA-Z ]" 2>/dev/null) || HUSHAWAY_NO_TM=0
# Also check for HushAway at end of line (would need ® before newline)
HUSHAWAY_EOL=$(echo "$CONTENT_NO_URLS" | grep -c 'HushAway$' 2>/dev/null) || HUSHAWAY_EOL=0
HUSHAWAY_NO_TM=$((HUSHAWAY_NO_TM + HUSHAWAY_EOL))

if [ "$HUSHAWAY_NO_TM" -eq 0 ]; then
    echo "PASS: All HushAway instances have trademark symbol"
else
    echo "FAIL: $HUSHAWAY_NO_TM instance(s) of 'HushAway' without ® symbol"
    echo "      Every instance must be HushAway® (URLs exempt)"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 9: Essential Elements Present
# ============================================================================
echo ""
echo ">>> CHECK 9: Essential Elements"

# Check for Sound Sanctuary CTA
SANCTUARY=$(grep -c "Sound Sanctuary" "$FILE" 2>/dev/null) || SANCTUARY=0
if [ "$SANCTUARY" -ge 1 ]; then
    echo "PASS: Sound Sanctuary CTA present ($SANCTUARY mentions)"
else
    echo "FAIL: No Sound Sanctuary CTA found"
    FAILS=$((FAILS+1))
fi

# Check for internal links
INTERNAL_LINKS=$(grep -c '\[.*\](/blog' "$FILE" 2>/dev/null) || INTERNAL_LINKS=0
INTERNAL_LINKS_ALT=$(grep -c '\[LINK TO:' "$FILE" 2>/dev/null) || INTERNAL_LINKS_ALT=0
TOTAL_LINKS=$((INTERNAL_LINKS + INTERNAL_LINKS_ALT))

if [ "$TYPE" = "hub" ]; then
    MIN_LINKS=8
else
    MIN_LINKS=4
fi

if [ "$TOTAL_LINKS" -ge "$MIN_LINKS" ]; then
    echo "PASS: Internal links sufficient ($TOTAL_LINKS found, need $MIN_LINKS)"
else
    echo "FAIL: Only $TOTAL_LINKS internal links found (need $MIN_LINKS for $TYPE)"
    echo "      Add more [LINK TO: Article Title] or [text](/blog/...) internal links."
    FAILS=$((FAILS+1))
fi

# ============================================================================
# FINAL RESULT
# ============================================================================
echo ""
echo "============================================================================"
echo "FINAL RESULT"
echo "============================================================================"
echo "Total checks failed: $FAILS"
echo "Total warnings: $WARNINGS"
echo ""
echo "Word count: $WORD_COUNT"
echo "Title length: ${#TITLE} chars"
echo "Meta description length: ${#META_DESC} chars"
echo ""

if [ "$FAILS" -eq 0 ]; then
    echo "============================================"
    echo "   FINAL GATE: PASS"
    echo "   Article is ready for export."
    echo "   All gates complete."
    echo "============================================"
    echo ""
    # AUTO-UPDATE: Update article status in ARTICLE-ORDER.md
    echo ">>> AUTO-UPDATING ARTICLE STATUS..."
    SCRIPT_DIR="$(dirname "$0")"
    if [ -f "$SCRIPT_DIR/update-article-status.sh" ]; then
        "$SCRIPT_DIR/update-article-status.sh" "$FILE"
    else
        echo "WARNING: update-article-status.sh not found. Manual update required."
    fi
    echo ""
    echo "EXPORT READY:"
    echo "  1. Copy markdown content to main website CMS"
    echo "  2. Add featured image"
    echo "  3. Replace any placeholder links with actual URLs"
    echo "  4. Publish"
    echo "  5. Update local file status to 'published'"
    echo ""
    exit 0
else
    echo "============================================"
    echo "   FINAL GATE: FAIL"
    echo "   $FAILS check(s) failed."
    echo "   Fix issues and re-run."
    echo "   DO NOT EXPORT UNTIL THIS GATE PASSES."
    echo "============================================"
    echo ""
    exit 1
fi
