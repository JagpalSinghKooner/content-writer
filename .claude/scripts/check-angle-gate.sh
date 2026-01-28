#!/bin/bash
# ============================================================================
# ANGLE GATE CHECK - Post Positioning Angles Verification
# ============================================================================
# Usage: ./check-angle-gate.sh <research-file>
# Example: ./check-angle-gate.sh research/pillar-5-adhd-apps/hub-research.md
#
# Exit codes: 0 = UNLOCKED (writing can proceed), 1 = LOCKED (cannot proceed)
#
# This script ensures positioning angles have been generated and selected
# before article writing begins.
# The /positioning-angles skill MUST be run before this gate can be unlocked.
# Writing cannot start until this gate shows UNLOCKED.
# ============================================================================

FILE="$1"

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "ANGLE GATE CHECK"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-angle-gate.sh <research-file>"
    echo ""
    echo "Examples:"
    echo "  ./check-angle-gate.sh research/pillar-5-adhd-apps/hub-research.md"
    echo "  ./check-angle-gate.sh research/pillar-7-neurodivergent-parenting/7.1-parent-burnout-research.md"
    echo ""
    echo "This gate verifies that /positioning-angles skill has been run and:"
    echo "  - An angle has been selected"
    echo "  - Angle description is documented"
    echo "  - Headline direction is defined"
    echo "  - Counter-positions are documented"
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "ANGLE GATE: LOCKED"
    echo "============================================================================"
    echo ""
    echo "ERROR: Research file not found: $FILE"
    echo ""
    echo "You must complete research and run /positioning-angles skill first."
    echo ""
    exit 1
fi

echo "============================================================================"
echo "ANGLE GATE CHECK"
echo "============================================================================"
echo "File: $FILE"
echo "Timestamp: $(date)"
echo "============================================================================"
echo ""
echo "This gate verifies /positioning-angles skill has been completed."
echo ""

FAILS=0

# Check 1: angleStatus in frontmatter
echo ">>> CHECK 1: Angle Status"
ANGLE_STATUS=$(grep "^angleStatus:" "$FILE" 2>/dev/null | sed 's/angleStatus:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ "$ANGLE_STATUS" = "selected" ]; then
    echo "PASS: angleStatus = selected"
else
    echo "FAIL: angleStatus = '$ANGLE_STATUS' (must be 'selected')"
    echo "      Run /positioning-angles skill and select an angle."
    FAILS=$((FAILS+1))
fi

# Check 2: selectedAngle exists and is not empty
echo ""
echo ">>> CHECK 2: Selected Angle"
SELECTED_ANGLE=$(grep "^selectedAngle:" "$FILE" 2>/dev/null | sed 's/selectedAngle:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$SELECTED_ANGLE" ] && [ "$SELECTED_ANGLE" != "null" ] && [ "$SELECTED_ANGLE" != "" ]; then
    echo "PASS: Selected angle: '$SELECTED_ANGLE'"
else
    echo "FAIL: No selected angle found"
    echo "      Run /positioning-angles skill and select one of the generated angles."
    FAILS=$((FAILS+1))
fi

# Check 3: angleDescription exists
echo ""
echo ">>> CHECK 3: Angle Description"
ANGLE_DESC=$(grep "^angleDescription:" "$FILE" 2>/dev/null | sed 's/angleDescription:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$ANGLE_DESC" ] && [ "$ANGLE_DESC" != "null" ] && [ "$ANGLE_DESC" != "" ]; then
    echo "PASS: Angle description documented"
else
    echo "FAIL: No angle description found"
    echo "      Document the one-sentence description of your selected angle."
    FAILS=$((FAILS+1))
fi

# Check 4: headlineDirection exists
echo ""
echo ">>> CHECK 4: Headline Direction"
HEADLINE_DIR=$(grep "^headlineDirection:" "$FILE" 2>/dev/null | sed 's/headlineDirection:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ -n "$HEADLINE_DIR" ] && [ "$HEADLINE_DIR" != "null" ] && [ "$HEADLINE_DIR" != "" ]; then
    echo "PASS: Headline direction defined: '$HEADLINE_DIR'"
else
    echo "FAIL: No headline direction found"
    echo "      Document the headline direction from /positioning-angles output."
    FAILS=$((FAILS+1))
fi

# Check 5: counterPositions exist (at least 2)
echo ""
echo ">>> CHECK 5: Counter-Positions (min 2)"
# Count lines that start with "  - " after counterPositions: (YAML array format)
COUNTER_COUNT=$(sed -n '/^counterPositions:/,/^[a-zA-Z]/p' "$FILE" 2>/dev/null | grep -c "^  - " 2>/dev/null) || COUNTER_COUNT=0

# Also check for inline format
if [ "$COUNTER_COUNT" -eq 0 ]; then
    INLINE_COUNTER=$(grep "^counterPositions:" "$FILE" 2>/dev/null | grep -o '\[.*\]' | tr ',' '\n' | wc -l | tr -d ' ') || INLINE_COUNTER=0
    COUNTER_COUNT=$INLINE_COUNTER
fi

if [ "$COUNTER_COUNT" -ge 2 ]; then
    echo "PASS: Counter-positions found: $COUNTER_COUNT (need 2+)"
else
    echo "FAIL: Only $COUNTER_COUNT counter-positions found (need at least 2)"
    echo "      Document counter-positions for competitor categories."
    FAILS=$((FAILS+1))
fi

# Check 6: Research gate must be unlocked (angle comes after research)
echo ""
echo ">>> CHECK 6: Research Gate Prerequisite"
RESEARCH_GATE=$(grep "^gateStatus:" "$FILE" 2>/dev/null | sed 's/gateStatus:[[:space:]]*//' | tr -d '"' | tr -d "'")
if [ "$RESEARCH_GATE" = "unlocked" ]; then
    echo "PASS: Research gate is unlocked (prerequisite met)"
else
    echo "FAIL: Research gate is not unlocked"
    echo "      Complete research and pass research gate before running /positioning-angles."
    FAILS=$((FAILS+1))
fi

# Check 7: Verify skill was actually run (look for skill output markers)
echo ""
echo ">>> CHECK 7: Positioning Angles Skill Evidence"
# Look for evidence that /positioning-angles skill output was incorporated
SKILL_EVIDENCE=$(grep -ciE "angle.?option|psychology|headline.?direction|transformation|mechanism|competitor.?alternative|counter.?position" "$FILE" 2>/dev/null) || SKILL_EVIDENCE=0
if [ "$SKILL_EVIDENCE" -ge 3 ]; then
    echo "PASS: Evidence of /positioning-angles skill output found"
else
    echo "WARN: Limited evidence of /positioning-angles skill output"
    echo "      Ensure you ran /positioning-angles and incorporated its output."
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
    echo "   ANGLE GATE: UNLOCKED"
    echo "   Positioning complete."
    echo "   Writing phase can proceed."
    echo "============================================"
    echo ""
    echo "SELECTED ANGLE: $SELECTED_ANGLE"
    echo "HEADLINE DIRECTION: $HEADLINE_DIR"
    echo ""
    echo "NEXT STEPS:"
    echo "  1. Complete HushAway® Prominence Planning using this angle"
    echo "  2. Run /seo-content skill with angle context"
    echo "  3. Pass content gate: .claude/scripts/master-gate.sh [article] [hub|cluster]"
    echo ""
    exit 0
else
    echo "============================================"
    echo "   ANGLE GATE: LOCKED"
    echo "   $FAILS check(s) failed."
    echo "============================================"
    echo ""
    echo "REQUIRED ACTION:"
    echo "  1. Ensure research gate is unlocked first"
    echo "  2. Run /positioning-angles skill with research context"
    echo "  3. Select ONE angle from the generated options"
    echo "  4. Document: selectedAngle, angleDescription, headlineDirection, counterPositions"
    echo "  5. Re-run this gate"
    echo ""
    echo "DO NOT START WRITING UNTIL THIS GATE IS UNLOCKED."
    echo ""
    exit 1
fi
