#!/bin/bash
# ============================================================================
# CONVERSION GATE CHECK - Post Content Gate Verification (Gate 5)
# ============================================================================
# Usage: ./check-conversion-gate.sh <article-file>
# Example: ./check-conversion-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md
#
# Exit codes: 0 = PASS (export can proceed), 1 = FAIL (cannot proceed)
#
# This script ensures the article has proper conversion elements to funnel
# readers into signing up for the free Sound Sanctuary.
# Content Gate (master-gate.sh) MUST pass before this gate can be run.
# Export cannot proceed until this gate shows PASS.
# ============================================================================

FILE="$1"

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "CONVERSION GATE CHECK (Gate 5)"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-conversion-gate.sh <article-file>"
    echo ""
    echo "Examples:"
    echo "  ./check-conversion-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md"
    echo "  ./check-conversion-gate.sh src/content/pillar-7-neurodivergent-parenting/7.1-parent-burnout.md"
    echo ""
    echo "This gate verifies conversion elements are present:"
    echo "  - Parent objections addressed (at least 2 of 4)"
    echo "  - CTA clarity (free forever language)"
    echo "  - Low-friction language (no commitment barriers)"
    echo "  - Neurodivergent-first differentiation"
    echo "  - HushAway prominence in conversion contexts"
    echo "  - Risk reversal language"
    echo ""
    echo "Run AFTER Content Gate (master-gate.sh) passes."
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "CONVERSION GATE: FAIL"
    echo "============================================================================"
    echo ""
    echo "ERROR: Article file not found: $FILE"
    echo ""
    echo "Ensure you have written the article and passed Content Gate first."
    echo ""
    exit 1
fi

echo "============================================================================"
echo "CONVERSION GATE CHECK (Gate 5)"
echo "============================================================================"
echo "File: $FILE"
echo "Timestamp: $(date)"
echo "============================================================================"
echo ""
echo "Checking conversion elements for Sound Sanctuary sign-up funnel."
echo ""

FAILS=0
WARNINGS=0

# ============================================================================
# CHECK 1: Parent Objections Addressed (Need 2 of 4)
# ============================================================================
echo ">>> CHECK 1: Parent Objections Addressed (need 2 of 4)"
echo ""

OBJECTIONS_FOUND=0

# Objection 1: "Another app won't help" - Counter: passive sound is different
OBJ1_PATTERNS="passive sound|no engagement required|doesn't require engagement|without requiring|just listen|simply play|no interaction needed|different from.*apps|unlike.*apps that"
OBJ1=$(grep -ciE "$OBJ1_PATTERNS" "$FILE" 2>/dev/null) || OBJ1=0
if [ "$OBJ1" -gt 0 ]; then
    echo "  [x] Objection 1: 'Another app won't help' - ADDRESSED ($OBJ1 mentions)"
    OBJECTIONS_FOUND=$((OBJECTIONS_FOUND+1))
else
    echo "  [ ] Objection 1: 'Another app won't help' - NOT FOUND"
    echo "      Add: passive sound is different, no engagement required"
fi

# Objection 2: "Too tired to try" - Counter: zero learning curve
OBJ2_PATTERNS="zero learning curve|just press play|no setup|no effort|no learning|simply press|just play|nothing to learn|no instructions|instant access|immediately|straight away"
OBJ2=$(grep -ciE "$OBJ2_PATTERNS" "$FILE" 2>/dev/null) || OBJ2=0
if [ "$OBJ2" -gt 0 ]; then
    echo "  [x] Objection 2: 'Too tired to try' - ADDRESSED ($OBJ2 mentions)"
    OBJECTIONS_FOUND=$((OBJECTIONS_FOUND+1))
else
    echo "  [ ] Objection 2: 'Too tired to try' - NOT FOUND"
    echo "      Add: zero learning curve, just press play, no effort required"
fi

# Objection 3: "Is this actually different?" - Counter: neurodivergent-first
OBJ3_PATTERNS="neurodivergent.first|built.*for.*neurodivergent|designed.*specifically|not.*adapted|not.*generic|specifically.*created|created.*for|purpose.built|from the ground up"
OBJ3=$(grep -ciE "$OBJ3_PATTERNS" "$FILE" 2>/dev/null) || OBJ3=0
if [ "$OBJ3" -gt 0 ]; then
    echo "  [x] Objection 3: 'Is this actually different?' - ADDRESSED ($OBJ3 mentions)"
    OBJECTIONS_FOUND=$((OBJECTIONS_FOUND+1))
else
    echo "  [ ] Objection 3: 'Is this actually different?' - NOT FOUND"
    echo "      Add: neurodivergent-first positioning, not adapted generic"
fi

# Objection 4: "What if my child won't use it?" - Counter: free forever, no risk
OBJ4_PATTERNS="free forever|nothing to lose|no risk|costs nothing|no commitment|no obligation|try.*free|free.*try|what.*lose|risk.free"
OBJ4=$(grep -ciE "$OBJ4_PATTERNS" "$FILE" 2>/dev/null) || OBJ4=0
if [ "$OBJ4" -gt 0 ]; then
    echo "  [x] Objection 4: 'What if my child won't use it?' - ADDRESSED ($OBJ4 mentions)"
    OBJECTIONS_FOUND=$((OBJECTIONS_FOUND+1))
else
    echo "  [ ] Objection 4: 'What if my child won't use it?' - NOT FOUND"
    echo "      Add: free forever, nothing to lose, no risk to try"
fi

echo ""
if [ "$OBJECTIONS_FOUND" -ge 2 ]; then
    echo "PASS: $OBJECTIONS_FOUND of 4 objections addressed (minimum 2 required)"
else
    echo "FAIL: Only $OBJECTIONS_FOUND of 4 objections addressed (minimum 2 required)"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 2: CTA Clarity - "Free Forever" Language
# ============================================================================
echo ""
echo ">>> CHECK 2: CTA Clarity (free forever language)"

FREE_FOREVER_PATTERNS="free forever|free, forever|forever free|always free|completely free|100% free"
FREE_FOREVER=$(grep -ciE "$FREE_FOREVER_PATTERNS" "$FILE" 2>/dev/null) || FREE_FOREVER=0

if [ "$FREE_FOREVER" -ge 1 ]; then
    echo "PASS: 'Free forever' language found ($FREE_FOREVER mentions)"
else
    echo "FAIL: 'Free forever' or equivalent not found"
    echo "      Add near CTA: 'free forever', 'always free', 'completely free'"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 3: Low-Friction Language (No Commitment Barriers)
# ============================================================================
echo ""
echo ">>> CHECK 3: Low-Friction Language"

# Check for BAD commitment language (should NOT be present)
BAD_PATTERNS="free trial|start.*trial|subscribe|subscription|sign up for|register for|create.*account|premium|upgrade"
BAD_LANGUAGE=$(grep -ciE "$BAD_PATTERNS" "$FILE" 2>/dev/null) || BAD_LANGUAGE=0

# Check for GOOD low-friction language (should be present)
GOOD_PATTERNS="just.*email|name.*email|instant access|no credit card|no payment|no subscription|no sign.?up|magic link"
GOOD_LANGUAGE=$(grep -ciE "$GOOD_PATTERNS" "$FILE" 2>/dev/null) || GOOD_LANGUAGE=0

if [ "$BAD_LANGUAGE" -gt 0 ]; then
    echo "FAIL: Commitment language detected ($BAD_LANGUAGE instances)"
    echo "      Remove: 'free trial', 'subscribe', 'sign up for', 'register'"
    FAILS=$((FAILS+1))
else
    echo "PASS: No commitment barrier language found"
fi

if [ "$GOOD_LANGUAGE" -ge 1 ]; then
    echo "PASS: Low-friction access language found ($GOOD_LANGUAGE mentions)"
else
    echo "WARNING: Consider adding low-friction language"
    echo "      Add: 'just enter your email', 'instant access', 'no credit card'"
    WARNINGS=$((WARNINGS+1))
fi

# ============================================================================
# CHECK 4: Neurodivergent-First Differentiation
# ============================================================================
echo ""
echo ">>> CHECK 4: Neurodivergent-First Differentiation"

DIFF_PATTERNS="neurodivergent|sensory.friendly|sensory processing|neurodivergent.first|ADHD.friendly|autism.friendly|designed for.*children who"
DIFFERENTIATION=$(grep -ciE "$DIFF_PATTERNS" "$FILE" 2>/dev/null) || DIFFERENTIATION=0

if [ "$DIFFERENTIATION" -ge 3 ]; then
    echo "PASS: Neurodivergent-first positioning clear ($DIFFERENTIATION mentions)"
else
    echo "FAIL: Insufficient neurodivergent-first differentiation ($DIFFERENTIATION mentions, need 3+)"
    echo "      Strengthen: neurodivergent-first, sensory-friendly, designed specifically"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 5: HushAway Prominence in Conversion Contexts
# ============================================================================
echo ""
echo ">>> CHECK 5: HushAway Prominence"

# Count HushAway mentions
HUSHAWAY_COUNT=$(grep -c "HushAway" "$FILE" 2>/dev/null) || HUSHAWAY_COUNT=0

# Check HushAway appears near conversion language
HUSHAWAY_CONVERSION=$(grep -ciE "HushAway.{0,100}(free|try|sound sanctuary|access)" "$FILE" 2>/dev/null) || HUSHAWAY_CONVERSION=0

if [ "$HUSHAWAY_COUNT" -ge 5 ]; then
    echo "PASS: HushAway mentioned $HUSHAWAY_COUNT times"
else
    echo "FAIL: HushAway only mentioned $HUSHAWAY_COUNT times (need 5+)"
    FAILS=$((FAILS+1))
fi

if [ "$HUSHAWAY_CONVERSION" -ge 2 ]; then
    echo "PASS: HushAway in conversion contexts ($HUSHAWAY_CONVERSION instances)"
else
    echo "FAIL: HushAway not prominent in conversion contexts ($HUSHAWAY_CONVERSION instances, need 2+)"
    echo "      Add HushAway near: 'free', 'try', 'Sound Sanctuary', 'access'"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 6: Sound Sanctuary CTA Present
# ============================================================================
echo ""
echo ">>> CHECK 6: Sound Sanctuary CTA"

SANCTUARY_PATTERNS="Sound Sanctuary|sound sanctuary"
SANCTUARY=$(grep -cE "$SANCTUARY_PATTERNS" "$FILE" 2>/dev/null) || SANCTUARY=0

if [ "$SANCTUARY" -ge 2 ]; then
    echo "PASS: Sound Sanctuary mentioned $SANCTUARY times"
else
    echo "FAIL: Sound Sanctuary not mentioned enough ($SANCTUARY times, need 2+)"
    echo "      Add CTA destination: 'Sound Sanctuary'"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# CHECK 7: Risk Reversal Language
# ============================================================================
echo ""
echo ">>> CHECK 7: Risk Reversal"

RISK_PATTERNS="nothing to lose|no risk|risk.free|no commitment|no obligation|costs nothing|free to try|what.*to lose|no strings"
RISK_REVERSAL=$(grep -ciE "$RISK_PATTERNS" "$FILE" 2>/dev/null) || RISK_REVERSAL=0

if [ "$RISK_REVERSAL" -ge 1 ]; then
    echo "PASS: Risk reversal language found ($RISK_REVERSAL mentions)"
else
    echo "FAIL: No risk reversal language found"
    echo "      Add: 'nothing to lose', 'no risk', 'costs nothing to try'"
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
echo "Objections addressed: $OBJECTIONS_FOUND of 4"
echo "Free forever mentions: $FREE_FOREVER"
echo "HushAway mentions: $HUSHAWAY_COUNT"
echo "Sound Sanctuary mentions: $SANCTUARY"
echo ""

if [ "$FAILS" -eq 0 ]; then
    echo "============================================"
    echo "   CONVERSION GATE: PASS"
    echo "   All conversion elements verified."
    echo "   Proceed to Final Gate and export."
    echo "============================================"
    exit 0
else
    echo "============================================"
    echo "   CONVERSION GATE: FAIL"
    echo "   $FAILS check(s) failed."
    echo "   Fix conversion elements and re-run."
    echo "   DO NOT EXPORT UNTIL THIS GATE PASSES."
    echo "============================================"
    exit 1
fi
