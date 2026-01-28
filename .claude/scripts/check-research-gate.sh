#!/bin/bash
# ============================================================================
# RESEARCH GATE CHECK - Pre-Writing Verification
# ============================================================================
# Usage: ./check-research-gate.sh <research-file>
# Example: ./check-research-gate.sh research/pillar-5-adhd-apps/hub-research.md
#
# Exit codes: 0 = UNLOCKED (writing can proceed), 1 = LOCKED (cannot proceed)
#
# This script ensures research is complete before article writing begins.
# Writing cannot start until this gate shows UNLOCKED.
# ============================================================================

FILE="$1"

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "RESEARCH GATE CHECK"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-research-gate.sh <research-file>"
    echo ""
    echo "Examples:"
    echo "  ./check-research-gate.sh research/pillar-5-adhd-apps/hub-research.md"
    echo "  ./check-research-gate.sh research/pillar-7-neurodivergent-parenting/7.1-parent-burnout-research.md"
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "RESEARCH GATE: LOCKED"
    echo "============================================================================"
    echo ""
    echo "ERROR: Research file not found: $FILE"
    echo ""
    echo "You must create the research file before writing can begin."
    echo "Template: /templates/research-template.md"
    echo ""
    exit 1
fi

echo "============================================================================"
echo "RESEARCH GATE CHECK"
echo "============================================================================"
echo "File: $FILE"
echo "Timestamp: $(date)"
echo "============================================================================"
echo ""

FAILS=0

# Check 1: gateStatus in frontmatter
echo ">>> CHECK 1: Gate Status"
GATE_STATUS=$(grep "^gateStatus:" "$FILE" 2>/dev/null | sed 's/gateStatus:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ "$GATE_STATUS" = "unlocked" ]; then
    echo "PASS: gateStatus = unlocked"
else
    echo "FAIL: gateStatus = '$GATE_STATUS' (must be 'unlocked')"
    FAILS=$((FAILS+1))
fi

# Check 2: researchStatus in frontmatter
echo ""
echo ">>> CHECK 2: Research Status"
RESEARCH_STATUS=$(grep "^researchStatus:" "$FILE" 2>/dev/null | sed 's/researchStatus:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ "$RESEARCH_STATUS" = "complete" ]; then
    echo "PASS: researchStatus = complete"
else
    echo "FAIL: researchStatus = '$RESEARCH_STATUS' (must be 'complete')"
    FAILS=$((FAILS+1))
fi

# Check 3: Target keyword exists
echo ""
echo ">>> CHECK 3: Target Keyword"
TARGET_KEYWORD=$(grep -iE "^target.?keyword:|^primary.?keyword:" "$FILE" 2>/dev/null | head -1)
if [ -n "$TARGET_KEYWORD" ]; then
    echo "PASS: Target keyword defined"
else
    echo "FAIL: No target keyword found in research"
    FAILS=$((FAILS+1))
fi

# Check 4: Secondary keywords (at least 3)
echo ""
echo ">>> CHECK 4: Secondary Keywords"
SECONDARY_KEYWORDS=$(grep -ciE "secondary.?keyword|related.?keyword|keyword.?cluster" "$FILE" 2>/dev/null) || SECONDARY_KEYWORDS=0
if [ "$SECONDARY_KEYWORDS" -gt 0 ]; then
    echo "PASS: Secondary keywords section found"
else
    echo "FAIL: No secondary keywords defined"
    FAILS=$((FAILS+1))
fi

# Check 5: Search intent analysis
echo ""
echo ">>> CHECK 5: Search Intent"
SEARCH_INTENT=$(grep -ciE "search.?intent|user.?intent" "$FILE" 2>/dev/null) || SEARCH_INTENT=0
if [ "$SEARCH_INTENT" -gt 0 ]; then
    echo "PASS: Search intent analysis present"
else
    echo "FAIL: No search intent analysis"
    FAILS=$((FAILS+1))
fi

# Check 6: Competitor gaps identified
echo ""
echo ">>> CHECK 6: Competitor Gaps"
COMPETITOR_GAPS=$(grep -ciE "competitor.?gap|content.?gap|missing|opportunity" "$FILE" 2>/dev/null) || COMPETITOR_GAPS=0
if [ "$COMPETITOR_GAPS" -ge 2 ]; then
    echo "PASS: Competitor gaps identified ($COMPETITOR_GAPS mentions)"
else
    echo "FAIL: Insufficient competitor gap analysis"
    FAILS=$((FAILS+1))
fi

# Check 7: People Also Ask questions (need 5+)
echo ""
echo ">>> CHECK 7: People Also Ask (min 5 questions)"
PAA_SECTION=$(grep -ciE "people also ask|PAA|related question" "$FILE" 2>/dev/null) || PAA_SECTION=0
if [ "$PAA_SECTION" -eq 0 ]; then
    echo "FAIL: No People Also Ask section found"
    FAILS=$((FAILS+1))
else
    # Count actual questions (lines ending with ?)
    PAA_COUNT=$(grep -cE "\?$|\? *$" "$FILE" 2>/dev/null) || PAA_COUNT=0
    if [ "$PAA_COUNT" -ge 5 ]; then
        echo "PASS: PAA questions found: $PAA_COUNT (need 5+)"
    else
        echo "FAIL: Only $PAA_COUNT questions found (need at least 5 PAA questions)"
        FAILS=$((FAILS+1))
    fi
fi

# Check 8: Research sources with citations
echo ""
echo ">>> CHECK 8: Research Sources"
SOURCES=$(grep -cE "20[0-9]{2}" "$FILE" 2>/dev/null) || SOURCES=0
if [ "$SOURCES" -ge 3 ]; then
    echo "PASS: Research sources with dates found ($SOURCES)"
else
    echo "FAIL: Insufficient dated research sources (need 3+)"
    FAILS=$((FAILS+1))
fi

# Check 9: Positioning angle selected
echo ""
echo ">>> CHECK 9: Positioning Angle"
POSITIONING=$(grep -ciE "positioning|angle" "$FILE" 2>/dev/null) || POSITIONING=0
if [ "$POSITIONING" -gt 0 ]; then
    echo "PASS: Positioning angle defined"
else
    echo "FAIL: No positioning angle selected"
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
echo ""

if [ "$FAILS" -eq 0 ]; then
    echo "============================================"
    echo "   RESEARCH GATE: UNLOCKED"
    echo "   Research complete. Writing can proceed."
    echo "============================================"
    exit 0
else
    echo "============================================"
    echo "   RESEARCH GATE: LOCKED"
    echo "   $FAILS check(s) failed."
    echo "   Complete ALL research before writing."
    echo "   DO NOT START WRITING UNTIL UNLOCKED."
    echo "============================================"
    exit 1
fi
