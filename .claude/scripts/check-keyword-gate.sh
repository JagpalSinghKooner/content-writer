#!/bin/bash
# ============================================================================
# KEYWORD GATE CHECK - Post Keyword Research Verification
# ============================================================================
# Usage: ./check-keyword-gate.sh <research-file>
# Example: ./check-keyword-gate.sh research/pillar-5-adhd-apps/hub-research.md
#
# Exit codes: 0 = UNLOCKED (research can proceed), 1 = LOCKED (cannot proceed)
#
# This script ensures keyword research is complete before article research begins.
# The /keyword-research skill MUST be run before this gate can be unlocked.
# Research cannot start until this gate shows UNLOCKED.
# ============================================================================

FILE="$1"

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "KEYWORD GATE CHECK"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-keyword-gate.sh <research-file>"
    echo ""
    echo "Examples:"
    echo "  ./check-keyword-gate.sh research/pillar-5-adhd-apps/hub-research.md"
    echo "  ./check-keyword-gate.sh research/pillar-7-neurodivergent-parenting/7.1-parent-burnout-research.md"
    echo ""
    echo "This gate verifies that /keyword-research skill has been run and:"
    echo "  - Target keyword has been validated"
    echo "  - Secondary keywords have been identified (5+)"
    echo "  - Search volume has been documented"
    echo "  - claude.md table has been updated"
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "KEYWORD GATE: LOCKED"
    echo "============================================================================"
    echo ""
    echo "ERROR: Research file not found: $FILE"
    echo ""
    echo "You must create the research file and run /keyword-research skill first."
    echo "Template: /templates/research-template.md"
    echo ""
    exit 1
fi

echo "============================================================================"
echo "KEYWORD GATE CHECK"
echo "============================================================================"
echo "File: $FILE"
echo "Timestamp: $(date)"
echo "============================================================================"
echo ""
echo "This gate verifies /keyword-research skill has been completed."
echo ""

FAILS=0

# Check 1: keywordStatus in frontmatter
echo ">>> CHECK 1: Keyword Status"
KEYWORD_STATUS=$(grep "^keywordStatus:" "$FILE" 2>/dev/null | sed 's/keywordStatus:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ "$KEYWORD_STATUS" = "validated" ]; then
    echo "PASS: keywordStatus = validated"
else
    echo "FAIL: keywordStatus = '$KEYWORD_STATUS' (must be 'validated')"
    echo "      Run /keyword-research skill to validate the seed keyword."
    FAILS=$((FAILS+1))
fi

# Check 2: Target keyword exists and is not empty
echo ""
echo ">>> CHECK 2: Target Keyword"
TARGET_KEYWORD=$(grep "^targetKeyword:" "$FILE" 2>/dev/null | sed 's/targetKeyword:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$TARGET_KEYWORD" ] && [ "$TARGET_KEYWORD" != "null" ] && [ "$TARGET_KEYWORD" != "" ]; then
    echo "PASS: Target keyword defined: '$TARGET_KEYWORD'"
else
    echo "FAIL: No validated target keyword found"
    echo "      Run /keyword-research skill to validate the seed keyword."
    FAILS=$((FAILS+1))
fi

# Check 3: Secondary keywords (at least 5)
echo ""
echo ">>> CHECK 3: Secondary Keywords (min 5)"
# Count lines that start with "  - " after secondaryKeywords: (YAML array format)
SECONDARY_COUNT=$(sed -n '/^secondaryKeywords:/,/^[a-zA-Z]/p' "$FILE" 2>/dev/null | grep -c "^  - " 2>/dev/null) || SECONDARY_COUNT=0

# Also check for inline format: secondaryKeywords: [keyword1, keyword2]
if [ "$SECONDARY_COUNT" -eq 0 ]; then
    INLINE_SECONDARY=$(grep "^secondaryKeywords:" "$FILE" 2>/dev/null | grep -o '\[.*\]' | tr ',' '\n' | wc -l | tr -d ' ') || INLINE_SECONDARY=0
    SECONDARY_COUNT=$INLINE_SECONDARY
fi

if [ "$SECONDARY_COUNT" -ge 5 ]; then
    echo "PASS: Secondary keywords found: $SECONDARY_COUNT (need 5+)"
else
    echo "FAIL: Only $SECONDARY_COUNT secondary keywords found (need at least 5)"
    echo "      Run /keyword-research skill to generate keyword cluster."
    FAILS=$((FAILS+1))
fi

# Check 4: Search volume documented
echo ""
echo ">>> CHECK 4: Search Volume"
SEARCH_VOLUME=$(grep "^searchVolume:" "$FILE" 2>/dev/null | sed 's/searchVolume:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$SEARCH_VOLUME" ] && [ "$SEARCH_VOLUME" != "null" ] && [ "$SEARCH_VOLUME" != "" ]; then
    echo "PASS: Search volume documented: $SEARCH_VOLUME"
else
    echo "FAIL: No search volume documented"
    echo "      Run /keyword-research skill to validate search volume."
    FAILS=$((FAILS+1))
fi

# Check 5: Verify skill was actually run (look for skill output markers)
echo ""
echo ">>> CHECK 5: Keyword Research Skill Evidence"
# Look for evidence that /keyword-research skill output was incorporated
SKILL_EVIDENCE=$(grep -ciE "keyword.?cluster|keyword.?validation|search.?volume.?validation|competitor.?opportunity|validated.?keyword" "$FILE" 2>/dev/null) || SKILL_EVIDENCE=0
if [ "$SKILL_EVIDENCE" -ge 2 ]; then
    echo "PASS: Evidence of /keyword-research skill output found"
else
    echo "WARN: Limited evidence of /keyword-research skill output"
    echo "      Ensure you ran /keyword-research and incorporated its output."
    # This is a warning, not a fail - the other checks are more definitive
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
    echo "   KEYWORD GATE: UNLOCKED"
    echo "   Keyword research complete."
    echo "   Research phase can proceed."
    echo "============================================"
    echo ""
    echo "NEXT STEP: Complete research, then run:"
    echo "  .claude/scripts/check-research-gate.sh $FILE"
    echo ""
    exit 0
else
    echo "============================================"
    echo "   KEYWORD GATE: LOCKED"
    echo "   $FAILS check(s) failed."
    echo "============================================"
    echo ""
    echo "REQUIRED ACTION:"
    echo "  1. Run /keyword-research skill with the seed keyword"
    echo "  2. Update research file with validated keyword and secondaries"
    echo "  3. Update claude.md keywords table"
    echo "  4. Re-run this gate"
    echo ""
    echo "DO NOT START RESEARCH UNTIL THIS GATE IS UNLOCKED."
    echo ""
    exit 1
fi
