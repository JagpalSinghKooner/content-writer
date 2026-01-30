#!/bin/bash
# ============================================================================
# CONVERSION GATE CHECK - Post Content Gate Verification (Gate 5)
# ============================================================================
# Usage: ./check-conversion-gate.sh <article-file> [--remediate] [--diff] [--fail-fast]
# Example: ./check-conversion-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md
# Example: ./check-conversion-gate.sh article.md --remediate
# Example: ./check-conversion-gate.sh article.md --diff --summary
#
# Exit codes: 0 = PASS (export can proceed), 1 = FAIL (cannot proceed)
#
# --remediate flag: Only shows failures, suppresses verbose PASS output
#                   Use on 2nd+ runs to reduce context window usage
# --diff flag: Shows changes from previous run (FIXED, STILL FAILING, NEW FAILURE)
#              Useful for iterative fixing sessions
# --fail-fast flag: Stops checking after 3 failures to save time
#
# RULES SOURCE: .claude/rules/humanise-rules.md Section 8 (Conversion Language)
# This script enforces conversion rules - objections, CTAs, risk reversal.
# Skills should read the rules file BEFORE writing; this script verifies AFTER.
#
# This script ensures the article has proper conversion elements to funnel
# readers into signing up for the free Sound Sanctuary.
# Content Gate (master-gate.sh) MUST pass before this gate can be run.
# Export cannot proceed until this gate shows PASS.
# ============================================================================

# --- ARGUMENTS ---
FILE=""
QUIET_PASS=false
SUMMARY_MODE=false
DIFF_MODE=false
FAIL_FAST=false
MAX_FAILS_BEFORE_STOP=3

# Parse arguments
for arg in "$@"; do
    case $arg in
        --remediate) QUIET_PASS=true ;;
        --summary) SUMMARY_MODE=true; QUIET_PASS=true ;;
        --diff) DIFF_MODE=true ;;
        --fail-fast) FAIL_FAST=true ;;
        *) [ -z "$FILE" ] && FILE="$arg" ;;
    esac
done

# Track failures for summary mode
declare -a FAILURE_SUMMARY

# --- DIFF MODE: State tracking ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/lib/gate-state.sh" ]; then
    source "$SCRIPT_DIR/lib/gate-state.sh"
fi

# State tracking variables (pipe-delimited for bash 3.2 compatibility)
CURRENT_STATE=""
DIFF_FIXED=""
DIFF_STILL_FAILING=""
DIFF_NEW_FAILURE=""
FIXED_COUNT=0
STILL_COUNT=0
NEW_COUNT=0

# Record check result for diff tracking
record_check() {
    local check_name="$1"
    local status="$2"  # PASS or FAIL
    local value="$3"

    # Add to current state
    if [ -n "$CURRENT_STATE" ]; then
        CURRENT_STATE="${CURRENT_STATE}
${check_name}=${status}:${value}"
    else
        CURRENT_STATE="${check_name}=${status}:${value}"
    fi

    # If diff mode and we have previous state, compare
    if [ "$DIFF_MODE" = true ] && [ -n "$STATE_FILE" ] && has_previous_state "$STATE_FILE" 2>/dev/null; then
        local prev_data
        prev_data=$(get_prev_value "$check_name" "$STATE_FILE")
        local prev_status="${prev_data%%:*}"

        local result
        result=$(compare_check_result "$check_name" "$status" "$prev_status")

        case "$result" in
            FIXED)
                FIXED_COUNT=$((FIXED_COUNT + 1))
                if [ -n "$DIFF_FIXED" ]; then
                    DIFF_FIXED="${DIFF_FIXED}|${check_name}: ${value}"
                else
                    DIFF_FIXED="${check_name}: ${value}"
                fi
                ;;
            STILL_FAILING)
                STILL_COUNT=$((STILL_COUNT + 1))
                if [ -n "$DIFF_STILL_FAILING" ]; then
                    DIFF_STILL_FAILING="${DIFF_STILL_FAILING}|${check_name}: ${value}"
                else
                    DIFF_STILL_FAILING="${check_name}: ${value}"
                fi
                ;;
            NEW_FAILURE)
                NEW_COUNT=$((NEW_COUNT + 1))
                if [ -n "$DIFF_NEW_FAILURE" ]; then
                    DIFF_NEW_FAILURE="${DIFF_NEW_FAILURE}|${check_name}: ${value}"
                else
                    DIFF_NEW_FAILURE="${check_name}: ${value}"
                fi
                ;;
        esac
    fi
}

# Helper function for pass output (suppressed in remediate/summary mode)
pass_msg() {
    if [ "$QUIET_PASS" = false ]; then
        echo "PASS: $1"
    fi
}

# Helper function to track failures for summary mode
track_fail() {
    FAILURE_SUMMARY+=("$1")
}

# Helper function for fail-fast mode
check_fail_fast() {
    if [ "$FAIL_FAST" = true ] && [ "$FAILS" -ge "$MAX_FAILS_BEFORE_STOP" ]; then
        echo ""
        echo "============================================"
        echo "FAIL-FAST: Stopping after $FAILS failures"
        echo "============================================"
        exit 1
    fi
}

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

# --- DIFF MODE: Initialize state file ---
if [ "$DIFF_MODE" = true ]; then
    STATE_FILE=$(get_state_file "$FILE" "conversion-gate" 2>/dev/null)
    cleanup_old_states 2>/dev/null
fi

echo "============================================================================"
echo "CONVERSION GATE CHECK (Gate 5)"
echo "============================================================================"
echo "File: $FILE"
if [ "$SUMMARY_MODE" = true ]; then
    echo "Mode: SUMMARY (compact output)"
elif [ "$QUIET_PASS" = true ]; then
    echo "Mode: REMEDIATE (failures only)"
fi
if [ "$FAIL_FAST" = true ]; then
    echo "Fail-Fast: ON (stops after $MAX_FAILS_BEFORE_STOP failures)"
fi
if [ "$DIFF_MODE" = true ]; then
    if has_previous_state "$STATE_FILE" 2>/dev/null; then
        echo "Diff Mode: ON (comparing to previous run)"
    else
        echo "Diff Mode: ON (no previous state - first run)"
    fi
fi
echo "Timestamp: $(date)"
echo "============================================================================"
if [ "$SUMMARY_MODE" = false ]; then
    echo ""
    echo "Checking conversion elements for Sound Sanctuary sign-up funnel."
    echo ""
fi

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
    pass_msg "$OBJECTIONS_FOUND of 4 objections addressed (minimum 2 required)"
    record_check "OBJECTIONS" "PASS" "$OBJECTIONS_FOUND"
else
    echo "FAIL: Only $OBJECTIONS_FOUND of 4 objections addressed (minimum 2 required)"
    track_fail "Objections: $OBJECTIONS_FOUND/4 (need 2)"
    record_check "OBJECTIONS" "FAIL" "$OBJECTIONS_FOUND"
    FAILS=$((FAILS+1))
fi

check_fail_fast

# ============================================================================
# CHECK 2: CTA Clarity - "Free Forever" Language
# ============================================================================
echo ""
echo ">>> CHECK 2: CTA Clarity (free forever language)"

FREE_FOREVER_PATTERNS="free forever|free, forever|forever free|always free|completely free|100% free"
FREE_FOREVER=$(grep -ciE "$FREE_FOREVER_PATTERNS" "$FILE" 2>/dev/null) || FREE_FOREVER=0

if [ "$FREE_FOREVER" -ge 1 ]; then
    pass_msg "'Free forever' language found ($FREE_FOREVER mentions)"
    record_check "FREE_FOREVER" "PASS" "$FREE_FOREVER"
else
    echo "FAIL: 'Free forever' or equivalent not found"
    echo "      Add near CTA: 'free forever', 'always free', 'completely free'"
    track_fail "Missing 'free forever' language"
    record_check "FREE_FOREVER" "FAIL" "0"
    FAILS=$((FAILS+1))
fi

check_fail_fast

# ============================================================================
# CHECK 3: Low-Friction Language (No Commitment Barriers)
# ============================================================================
echo ""
echo ">>> CHECK 3: Low-Friction Language"

# Check for BAD commitment language (should NOT be present)
# Exclude lines with negative context (no/without subscription)
BAD_PATTERNS="free trial|start.*trial|subscribe|subscription|sign up for|register for|create.*account|premium|upgrade"
BAD_LANGUAGE=$(grep -iE "$BAD_PATTERNS" "$FILE" 2>/dev/null | grep -viE "no subscription|without.*subscription|subscription.*not|free from.*subscription" | wc -l) || BAD_LANGUAGE=0
BAD_LANGUAGE=$(echo "$BAD_LANGUAGE" | tr -d ' ')

# Check for GOOD low-friction language (should be present)
GOOD_PATTERNS="just.*email|name.*email|instant access|no credit card|no payment|no subscription|no sign.?up|magic link"
GOOD_LANGUAGE=$(grep -ciE "$GOOD_PATTERNS" "$FILE" 2>/dev/null) || GOOD_LANGUAGE=0

if [ "$BAD_LANGUAGE" -gt 0 ]; then
    echo "FAIL: Commitment language detected ($BAD_LANGUAGE instances)"
    echo "      Remove: 'free trial', 'subscribe', 'sign up for', 'register for', 'premium', 'upgrade'"
    FAILS=$((FAILS+1))
else
    pass_msg "No commitment barrier language found"
fi

if [ "$GOOD_LANGUAGE" -ge 1 ]; then
    pass_msg "Low-friction access language found ($GOOD_LANGUAGE mentions)"
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
    pass_msg "Neurodivergent-first positioning clear ($DIFFERENTIATION mentions)"
    record_check "ND_DIFFERENTIATION" "PASS" "$DIFFERENTIATION"
else
    echo "FAIL: Insufficient neurodivergent-first differentiation ($DIFFERENTIATION mentions, need 3+)"
    echo "      Strengthen: neurodivergent-first, sensory-friendly, designed specifically"
    record_check "ND_DIFFERENTIATION" "FAIL" "$DIFFERENTIATION"
    FAILS=$((FAILS+1))
fi

check_fail_fast

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
    pass_msg "HushAway mentioned $HUSHAWAY_COUNT times"
else
    echo "FAIL: HushAway only mentioned $HUSHAWAY_COUNT times (need 5+)"
    FAILS=$((FAILS+1))
fi

if [ "$HUSHAWAY_CONVERSION" -ge 2 ]; then
    pass_msg "HushAway in conversion contexts ($HUSHAWAY_CONVERSION instances)"
else
    echo "FAIL: HushAway not prominent in conversion contexts ($HUSHAWAY_CONVERSION instances, need 2+)"
    echo "      Add HushAway near: 'free', 'try', 'Sound Sanctuary', 'access'"
    FAILS=$((FAILS+1))
fi

check_fail_fast

# ============================================================================
# CHECK 6: Sound Sanctuary CTA Present
# ============================================================================
echo ""
echo ">>> CHECK 6: Sound Sanctuary CTA"

SANCTUARY_PATTERNS="Sound Sanctuary|sound sanctuary"
SANCTUARY=$(grep -cE "$SANCTUARY_PATTERNS" "$FILE" 2>/dev/null) || SANCTUARY=0

if [ "$SANCTUARY" -ge 2 ]; then
    pass_msg "Sound Sanctuary mentioned $SANCTUARY times"
else
    echo "FAIL: Sound Sanctuary not mentioned enough ($SANCTUARY times, need 2+)"
    echo "      Add CTA destination: 'Sound Sanctuary'"
    FAILS=$((FAILS+1))
fi

check_fail_fast

# ============================================================================
# CHECK 7: Risk Reversal Language
# ============================================================================
echo ""
echo ">>> CHECK 7: Risk Reversal"

RISK_PATTERNS="nothing to lose|no risk|risk.free|no commitment|no obligation|costs nothing|free to try|what.*to lose|no strings"
RISK_REVERSAL=$(grep -ciE "$RISK_PATTERNS" "$FILE" 2>/dev/null) || RISK_REVERSAL=0

if [ "$RISK_REVERSAL" -ge 1 ]; then
    pass_msg "Risk reversal language found ($RISK_REVERSAL mentions)"
    record_check "RISK_REVERSAL" "PASS" "$RISK_REVERSAL"
else
    echo "FAIL: No risk reversal language found"
    echo "      Add: 'nothing to lose', 'no risk', 'costs nothing to try'"
    record_check "RISK_REVERSAL" "FAIL" "0"
    FAILS=$((FAILS+1))
fi

# ============================================================================
# DIFF OUTPUT (if --diff mode enabled)
# ============================================================================
if [ "$DIFF_MODE" = true ]; then
    # Check if we had previous state BEFORE saving current state
    HAD_PREVIOUS_STATE=false
    if [ -n "$STATE_FILE" ] && [ -f "$STATE_FILE" ]; then
        HAD_PREVIOUS_STATE=true
    fi

    # Save current state for next run
    if [ -n "$STATE_FILE" ]; then
        init_state_dir 2>/dev/null
        echo "$CURRENT_STATE" > "$STATE_FILE"
    fi

    # Output diff only if we had previous state to compare against
    if [ "$HAD_PREVIOUS_STATE" = true ]; then
        if [ "$FIXED_COUNT" -gt 0 ] || [ "$STILL_COUNT" -gt 0 ] || [ "$NEW_COUNT" -gt 0 ]; then
            output_diff_summary "$FIXED_COUNT" "$STILL_COUNT" "$NEW_COUNT" \
                "$DIFF_FIXED" "$DIFF_STILL_FAILING" "$DIFF_NEW_FAILURE"
        else
            echo ""
            echo "============================================================================"
            echo "DIFF FROM PREVIOUS RUN"
            echo "============================================================================"
            echo ""
            echo "No changes from previous run."
            echo ""
        fi
    fi
fi

# ============================================================================
# FINAL RESULT
# ============================================================================
echo ""
echo "============================================================================"
echo "FINAL RESULT"
echo "============================================================================"

if [ "$SUMMARY_MODE" = true ]; then
    # Compact summary output
    if [ "$FAILS" -eq 0 ]; then
        echo "CONVERSION GATE: PASS"
    else
        echo "CONVERSION GATE: FAIL ($FAILS issues)"
        for failure in "${FAILURE_SUMMARY[@]}"; do
            echo "- $failure"
        done
    fi
    echo "============================================================================"
else
    # Standard output
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
    else
        echo "============================================"
        echo "   CONVERSION GATE: FAIL"
        echo "   $FAILS check(s) failed."
        echo "   Fix conversion elements and re-run."
        echo "   DO NOT EXPORT UNTIL THIS GATE PASSES."
        echo "============================================"
    fi
fi

# Exit with 0 for pass, 1 for fail (standard shell convention)
if [ "$FAILS" -eq 0 ]; then
    exit 0
else
    exit 1
fi
