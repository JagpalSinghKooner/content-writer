#!/bin/bash
# ============================================================================
# KEYWORD GATE V3 - Full Validation System
# ============================================================================
# Usage: ./check-keyword-gate-v3.sh <research-file> [--summary] [--remediate]
# Example: ./check-keyword-gate-v3.sh research/pillar-5-adhd-apps/hub-research.md
#
# Exit codes: 0 = PASS (GO), 1 = FAIL (NO-GO)
#
# V3 Features:
# - Pre-API brand alignment validation
# - DataForSEO MANDATORY (not optional)
# - Intent-tiered volume floors (50/100/200/500)
# - Opportunity scoring (15+ to pass)
# - Differentiation scoring (5+ for difficulty >40; 7+ for hubs)
# - Competitive moat assessment
# - Trend + Score combo gate
# - Automatic rejected keyword logging
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$CLAUDE_DIR")"

# Source shared libraries
source "$SCRIPT_DIR/lib/keyword-scoring.sh"
source "$SCRIPT_DIR/lib/gate-state.sh" 2>/dev/null || true

# Files
NEGATIVE_KEYWORDS="$CLAUDE_DIR/negative-keywords.md"
REJECTED_KEYWORDS="$CLAUDE_DIR/rejected-keywords.md"
KEYWORD_LIBRARY="$CLAUDE_DIR/keyword-library.md"

# Parse arguments
FILE=""
SUMMARY_MODE=false
REMEDIATE_MODE=false
DIFF_MODE=false

for arg in "$@"; do
    case "$arg" in
        --summary)   SUMMARY_MODE=true ;;
        --remediate) REMEDIATE_MODE=true ;;
        --diff)      DIFF_MODE=true ;;
        -*)          echo "Unknown option: $arg"; exit 1 ;;
        *)           FILE="$arg" ;;
    esac
done

# ============================================================================
# HELP AND VALIDATION
# ============================================================================

if [ -z "$FILE" ]; then
    echo "============================================================================"
    echo "KEYWORD GATE V3 - Full Validation System"
    echo "============================================================================"
    echo ""
    echo "Usage: ./check-keyword-gate-v3.sh <research-file> [options]"
    echo ""
    echo "Options:"
    echo "  --summary    Compact output (~80% fewer tokens)"
    echo "  --remediate  Shows failures only (for fixing)"
    echo "  --diff       Shows changes from previous run"
    echo ""
    echo "Examples:"
    echo "  ./check-keyword-gate-v3.sh research/pillar-5-adhd-apps/hub-research.md"
    echo "  ./check-keyword-gate-v3.sh research/pillar-5-adhd-apps/5.5-research.md --summary"
    echo ""
    echo "V3 validates:"
    echo "  Step 0: Pre-API filters (brand, negative/rejected keywords)"
    echo "  Step 1: DataForSEO data MANDATORY"
    echo "  Step 2: Perplexity MCP data MANDATORY"
    echo "  Step 3: Classifications (intent, trend, pillar, article type)"
    echo "  Step 4: Scores (opportunity, differentiation, moat)"
    echo "  Step 5: Hard gates (volume floors, score thresholds)"
    echo "  Step 6: Verdict (GO/NO-GO with full metrics)"
    echo ""
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "============================================================================"
    echo "KEYWORD GATE V3: FAIL"
    echo "============================================================================"
    echo ""
    echo "ERROR: Research file not found: $FILE"
    echo ""
    echo "Create the research file and run /keyword-research skill first."
    echo "Template: /templates/research-template.md"
    echo ""
    exit 1
fi

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Extract frontmatter value
get_fm() {
    local key="$1"
    grep "^${key}:" "$FILE" 2>/dev/null | head -1 | sed "s/${key}:[[:space:]]*//" | tr -d '"' | tr -d "'"
}

# Extract YAML array count
get_array_count() {
    local key="$1"
    sed -n "/^${key}:/,/^[a-zA-Z]/p" "$FILE" 2>/dev/null | grep -c "^  - " || echo "0"
}

# Check if keyword is in negative library
check_negative_keyword() {
    local keyword="$1"
    local keyword_lower
    keyword_lower=$(echo "$keyword" | tr '[:upper:]' '[:lower:]')

    if [ ! -f "$NEGATIVE_KEYWORDS" ]; then
        return 1  # Not found (file doesn't exist)
    fi

    # Check exact match in tables
    if grep -qi "| ${keyword_lower} |" "$NEGATIVE_KEYWORDS" 2>/dev/null; then
        return 0  # Found
    fi

    return 1  # Not found
}

# Check for brand conflict patterns
check_brand_patterns() {
    local keyword="$1"
    local keyword_lower
    keyword_lower=$(echo "$keyword" | tr '[:upper:]' '[:lower:]')

    # Deficit language patterns
    if echo "$keyword_lower" | grep -qE '\b(cure|curing|cured|fix|fixing|fixed)\b.*\b(adhd|autism|child)\b'; then
        echo "deficit_language"
        return 0
    fi

    if echo "$keyword_lower" | grep -qE '\b(normal|abnormal|suffering)\b'; then
        echo "deficit_language"
        return 0
    fi

    # Medical patterns
    if echo "$keyword_lower" | grep -qE '\b(medication|medicine|meds|diagnosis|diagnose|prescription|prescribe)\b'; then
        echo "medical_overreach"
        return 0
    fi

    # Off-topic patterns
    if echo "$keyword_lower" | grep -qE '\b(adult|adults|workplace|college|dating|marriage)\b.*adhd'; then
        echo "off_topic"
        return 0
    fi

    # Harmful practice patterns
    if echo "$keyword_lower" | grep -qE '\b(punish|punishment|force|forcing|discipline)\b.*\b(adhd|child)\b'; then
        echo "harmful_practice"
        return 0
    fi

    return 1  # No pattern match
}

# Check if keyword was previously rejected
check_rejected_keyword() {
    local keyword="$1"
    local keyword_lower
    keyword_lower=$(echo "$keyword" | tr '[:upper:]' '[:lower:]')

    if [ ! -f "$REJECTED_KEYWORDS" ]; then
        return 1  # Not found
    fi

    if grep -qi "| ${keyword_lower} |" "$REJECTED_KEYWORDS" 2>/dev/null; then
        # Get revisit classification
        local revisit
        revisit=$(grep -i "| ${keyword_lower} |" "$REJECTED_KEYWORDS" | head -1 | awk -F'|' '{print $7}' | tr -d ' ')
        echo "$revisit"
        return 0  # Found
    fi

    return 1  # Not found
}

# Log rejected keyword to library
log_rejected_keyword() {
    local keyword="$1"
    local reason="$2"
    local volume="${3:-0}"
    local score="${4:-0}"
    local revisit="${5:-Monitor}"
    local date
    date=$(date '+%Y-%m-%d')

    if [ ! -f "$REJECTED_KEYWORDS" ]; then
        return 1
    fi

    # Check if already in table
    if grep -qi "| ${keyword} |" "$REJECTED_KEYWORDS" 2>/dev/null; then
        return 0  # Already logged
    fi

    # Find the table line after header and add entry
    # Insert after the header row
    sed -i '' "/^| Keyword | Date |/a\\
| ${keyword} | ${date} | ${reason} | ${volume} | ${score} | ${revisit} |
" "$REJECTED_KEYWORDS" 2>/dev/null || true
}

# ============================================================================
# COUNTERS AND STATE
# ============================================================================

TOTAL_CHECKS=0
PASS_CHECKS=0
FAIL_CHECKS=0
WARN_CHECKS=0

HARD_FAILS=0
SOFT_WARNS=0

declare -a FAILURES
declare -a WARNINGS
declare -a CURRENT_STATE

record_check() {
    local name="$1"
    local status="$2"  # PASS, FAIL, WARN
    local detail="$3"

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    CURRENT_STATE+=("${name}=${status}")

    case "$status" in
        PASS)
            PASS_CHECKS=$((PASS_CHECKS + 1))
            if [ "$REMEDIATE_MODE" != "true" ]; then
                [ "$SUMMARY_MODE" != "true" ] && echo "PASS: $name"
            fi
            ;;
        FAIL)
            FAIL_CHECKS=$((FAIL_CHECKS + 1))
            HARD_FAILS=$((HARD_FAILS + 1))
            FAILURES+=("$name: $detail")
            echo "FAIL: $name"
            [ -n "$detail" ] && echo "      $detail"
            ;;
        WARN)
            WARN_CHECKS=$((WARN_CHECKS + 1))
            SOFT_WARNS=$((SOFT_WARNS + 1))
            WARNINGS+=("$name: $detail")
            if [ "$REMEDIATE_MODE" != "true" ]; then
                echo "WARN: $name"
                [ -n "$detail" ] && echo "      $detail"
            fi
            ;;
    esac
}

# ============================================================================
# HEADER
# ============================================================================

echo "============================================================================"
echo "KEYWORD GATE V3 - Full Validation System"
echo "============================================================================"
echo "File: $FILE"
echo "Timestamp: $(date)"
[ "$SUMMARY_MODE" = "true" ] && echo "Mode: Summary (compact output)"
[ "$REMEDIATE_MODE" = "true" ] && echo "Mode: Remediate (failures only)"
echo "============================================================================"
echo ""

# ============================================================================
# STEP 0: PRE-API FILTERS (No cost validation)
# ============================================================================

echo ">>> STEP 0: PRE-API FILTERS"
echo ""

# Get target keyword
TARGET_KEYWORD=$(get_fm "targetKeyword")

if [ -z "$TARGET_KEYWORD" ] || [ "$TARGET_KEYWORD" = "null" ]; then
    record_check "Target keyword exists" "FAIL" "No target keyword defined in frontmatter"
else
    record_check "Target keyword exists" "PASS" ""

    # Check negative keyword library
    if check_negative_keyword "$TARGET_KEYWORD"; then
        record_check "Not in negative keywords" "FAIL" "'$TARGET_KEYWORD' is in permanent negative keyword list"
    else
        record_check "Not in negative keywords" "PASS" ""
    fi

    # Check brand conflict patterns
    PATTERN_MATCH=$(check_brand_patterns "$TARGET_KEYWORD")
    if [ -n "$PATTERN_MATCH" ]; then
        record_check "Brand alignment" "FAIL" "'$TARGET_KEYWORD' matches $PATTERN_MATCH pattern"
    else
        record_check "Brand alignment" "PASS" ""
    fi

    # Check rejected keyword library
    REVISIT=$(check_rejected_keyword "$TARGET_KEYWORD")
    if [ -n "$REVISIT" ]; then
        if [ "$REVISIT" = "Never" ] || [ "$REVISIT" = "No" ]; then
            record_check "Not previously rejected" "FAIL" "'$TARGET_KEYWORD' was rejected (Revisit: $REVISIT)"
        else
            record_check "Not previously rejected" "WARN" "'$TARGET_KEYWORD' was rejected (Revisit: $REVISIT) - check if conditions changed"
        fi
    else
        record_check "Not previously rejected" "PASS" ""
    fi

    # Format validation (not a sentence)
    WORD_COUNT=$(echo "$TARGET_KEYWORD" | wc -w | tr -d ' ')
    if [ "$WORD_COUNT" -gt 8 ]; then
        record_check "Format validation" "WARN" "Keyword has $WORD_COUNT words - may be a sentence not a keyword"
    else
        record_check "Format validation" "PASS" ""
    fi
fi

echo ""

# Early exit if pre-API checks fail hard
if [ "$HARD_FAILS" -gt 0 ]; then
    echo "============================================================================"
    echo "KEYWORD GATE V3: NO-GO (Pre-API filter failure)"
    echo "============================================================================"
    echo ""
    echo "REJECTION REASON: Failed pre-API validation"
    echo ""
    for failure in "${FAILURES[@]}"; do
        echo "  - $failure"
    done
    echo ""
    echo "This keyword was rejected BEFORE API calls to save costs."
    echo "Check negative-keywords.md and rejected-keywords.md for details."
    echo ""
    exit 1
fi

# ============================================================================
# STEP 1: DATAFORSEO DATA VERIFICATION (MANDATORY)
# ============================================================================

echo ">>> STEP 1: DATAFORSEO DATA (MANDATORY)"
echo ""

DATAFORSEO_USED=$(get_fm "dataforSeoUsed")
DATAFORSEO_DATE=$(get_fm "dataforSeoDate")
KW_DIFFICULTY=$(get_fm "keywordDifficulty")
SEARCH_VOLUME=$(get_fm "searchVolume")
CPC=$(get_fm "cpc")

if [ "$DATAFORSEO_USED" = "true" ]; then
    record_check "DataForSEO used" "PASS" ""

    if [ -n "$DATAFORSEO_DATE" ] && [ "$DATAFORSEO_DATE" != "null" ]; then
        record_check "DataForSEO date" "PASS" ""
    else
        record_check "DataForSEO date" "WARN" "Date not documented"
    fi

    # Verify volume is numeric
    if [[ "$SEARCH_VOLUME" =~ ^[0-9]+$ ]]; then
        record_check "Search volume (numeric)" "PASS" ""
    else
        record_check "Search volume (numeric)" "FAIL" "Volume '$SEARCH_VOLUME' is not numeric - DataForSEO should provide exact numbers"
    fi

    # Verify difficulty is numeric
    if [[ "$KW_DIFFICULTY" =~ ^[0-9]+$ ]]; then
        record_check "Keyword difficulty (numeric)" "PASS" ""
    else
        record_check "Keyword difficulty (numeric)" "FAIL" "Difficulty '$KW_DIFFICULTY' is not numeric"
    fi

else
    record_check "DataForSEO used" "FAIL" "DataForSEO is MANDATORY in V3 - set dataforSeoUsed: true"
fi

echo ""

# ============================================================================
# STEP 2: PERPLEXITY MCP DATA VERIFICATION (MANDATORY)
# ============================================================================

echo ">>> STEP 2: PERPLEXITY MCP DATA (MANDATORY)"
echo ""

PERPLEXITY_USED=$(get_fm "perplexityUsed")
PERPLEXITY_DATE=$(get_fm "perplexityDate")
PAA_COUNT=$(get_array_count "paaQuestions")
GAP_COUNT=$(get_array_count "competitorGaps")
SOURCE_COUNT=$(get_array_count "researchSources")

if [ "$PERPLEXITY_USED" = "true" ]; then
    record_check "Perplexity MCP used" "PASS" ""

    if [ -n "$PERPLEXITY_DATE" ] && [ "$PERPLEXITY_DATE" != "null" ]; then
        record_check "Perplexity date" "PASS" ""
    else
        record_check "Perplexity date" "WARN" "Date not documented"
    fi
else
    record_check "Perplexity MCP used" "FAIL" "Perplexity is MANDATORY - set perplexityUsed: true"
fi

# PAA Questions (7+ required)
if [ "$PAA_COUNT" -ge 7 ]; then
    record_check "PAA questions (7+)" "PASS" ""
else
    record_check "PAA questions (7+)" "FAIL" "Found $PAA_COUNT PAA questions, need at least 7"
fi

# Competitor Gaps (2+ required)
if [ "$GAP_COUNT" -ge 2 ]; then
    record_check "Competitor gaps (2+)" "PASS" ""
else
    record_check "Competitor gaps (2+)" "FAIL" "Found $GAP_COUNT gaps, need at least 2"
fi

# Research Sources (2+ required)
if [ "$SOURCE_COUNT" -ge 2 ]; then
    record_check "Research sources (2+)" "PASS" ""
else
    record_check "Research sources (2+)" "FAIL" "Found $SOURCE_COUNT sources, need at least 2"
fi

echo ""

# ============================================================================
# STEP 3: CLASSIFICATION VALIDATION
# ============================================================================

echo ">>> STEP 3: CLASSIFICATIONS"
echo ""

# Search Intent
SEARCH_INTENT=$(get_fm "searchIntent")
if [ -n "$SEARCH_INTENT" ] && [ "$SEARCH_INTENT" != "null" ]; then
    record_check "Search intent classified" "PASS" ""
else
    # Auto-classify from keyword
    SEARCH_INTENT=$(classify_intent "$TARGET_KEYWORD" "$CPC")
    record_check "Search intent classified" "WARN" "Not in frontmatter - auto-classified as: $SEARCH_INTENT"
fi

# Trend Direction
TREND=$(get_fm "trendDirection")
if [ -z "$TREND" ] || [ "$TREND" = "null" ]; then
    TREND=$(get_fm "searchTrend")  # Fallback to old field name
fi
if [ -n "$TREND" ] && [ "$TREND" != "null" ]; then
    record_check "Trend direction" "PASS" ""
else
    TREND="stable"  # Default
    record_check "Trend direction" "WARN" "Not documented - defaulting to 'stable'"
fi

# Article Type
# V3.1: Removed volume-based hub inference - hub/cluster determined by pillar strategy, not volume
ARTICLE_TYPE=$(get_fm "articleType")
if [ -n "$ARTICLE_TYPE" ] && [ "$ARTICLE_TYPE" != "null" ]; then
    record_check "Article type" "PASS" ""
else
    # Default to cluster - hubs should be explicitly set based on pillar strategy
    ARTICLE_TYPE="cluster"
    record_check "Article type" "WARN" "Not documented - defaulting to 'cluster'. Set articleType: hub explicitly for hub articles."
fi

# Pillar Assignment
PILLAR=$(get_fm "pillarAssignment")
if [ -z "$PILLAR" ] || [ "$PILLAR" = "null" ]; then
    PILLAR=$(get_fm "pillar")  # Fallback
fi
if [ -n "$PILLAR" ] && [ "$PILLAR" != "null" ]; then
    record_check "Pillar assignment" "PASS" ""
else
    record_check "Pillar assignment" "WARN" "No pillar assigned - orphan content risk"
fi

# Secondary Keywords
SECONDARY_COUNT=$(get_array_count "secondaryKeywords")
if [ "$SECONDARY_COUNT" -ge 5 ]; then
    record_check "Secondary keywords (5+)" "PASS" ""
else
    record_check "Secondary keywords (5+)" "FAIL" "Found $SECONDARY_COUNT, need at least 5"
fi

echo ""

# ============================================================================
# STEP 4: SCORE VERIFICATION
# ============================================================================

echo ">>> STEP 4: SCORES"
echo ""

# Get scores from frontmatter or calculate
INTENT_MULT=$(get_intent_multiplier "$SEARCH_INTENT")
TREND_MULT=$(get_trend_multiplier "$TREND")
VOLUME_FLOOR=$(get_volume_floor "$SEARCH_INTENT")

# Clean volume (remove commas for numeric comparison)
SEARCH_VOLUME_CLEAN=$(echo "$SEARCH_VOLUME" | tr -d ',')

# Authority adjustment (from frontmatter or default)
AUTH_ADJ=$(get_fm "authorityAdjustment")
[ -z "$AUTH_ADJ" ] || [ "$AUTH_ADJ" = "null" ] && AUTH_ADJ=0

# Effective difficulty
EFF_DIFF=$(get_fm "effectiveDifficulty")
if [ -z "$EFF_DIFF" ] || [ "$EFF_DIFF" = "null" ]; then
    EFF_DIFF=$(calculate_effective_difficulty "${KW_DIFFICULTY:-30}" "$AUTH_ADJ" "0")
fi

# Snippet bonus
SNIPPET_BONUS=$(get_fm "snippetBonus")
[ -z "$SNIPPET_BONUS" ] || [ "$SNIPPET_BONUS" = "null" ] && SNIPPET_BONUS=0

# Opportunity score
OPP_SCORE=$(get_fm "opportunityScore")
if [ -z "$OPP_SCORE" ] || [ "$OPP_SCORE" = "null" ]; then
    OPP_SCORE=$(calculate_opportunity_score "${SEARCH_VOLUME_CLEAN:-0}" "$INTENT_MULT" "$TREND_MULT" "$EFF_DIFF" "$SNIPPET_BONUS")
fi

# Differentiation score
DIFF_SCORE=$(get_fm "differentiationScore")
[ -z "$DIFF_SCORE" ] || [ "$DIFF_SCORE" = "null" ] && DIFF_SCORE=0

# Moat score
MOAT_SCORE=$(get_fm "competitiveMoatScore")
[ -z "$MOAT_SCORE" ] || [ "$MOAT_SCORE" = "null" ] && MOAT_SCORE=5

# Difficulty tier
DIFF_TIER=$(get_difficulty_tier "$EFF_DIFF")

# Priority
PRIORITY_SCORE=$(calculate_priority_score "$OPP_SCORE" "$DIFF_TIER")
PRIORITY_RANK=$(calculate_priority_rank "$PRIORITY_SCORE" "$DIFF_TIER")

if [ "$SUMMARY_MODE" != "true" ]; then
    echo "Calculated scores:"
    echo "  Intent: $SEARCH_INTENT (${INTENT_MULT}x)"
    echo "  Trend: $TREND (${TREND_MULT}x)"
    echo "  Volume: $SEARCH_VOLUME (floor: $VOLUME_FLOOR)"
    echo "  Difficulty: $KW_DIFFICULTY → $EFF_DIFF effective ($DIFF_TIER tier)"
    echo "  Snippet Bonus: +$SNIPPET_BONUS"
    echo "  Opportunity Score: $OPP_SCORE"
    echo "  Differentiation: $DIFF_SCORE"
    echo "  Moat: $MOAT_SCORE"
    echo "  Priority: Rank $PRIORITY_RANK (score $PRIORITY_SCORE)"
    echo ""
fi

# ============================================================================
# STEP 5: HARD GATES
# ============================================================================

echo ">>> STEP 5: HARD GATES"
echo ""

# Volume floor (intent-tiered)
VOLUME_INT="${SEARCH_VOLUME_CLEAN:-0}"
if [ "$VOLUME_INT" -ge "$VOLUME_FLOOR" ]; then
    record_check "Volume floor ($SEARCH_INTENT: $VOLUME_FLOOR+)" "PASS" ""
else
    record_check "Volume floor ($SEARCH_INTENT: $VOLUME_FLOOR+)" "FAIL" "Volume $VOLUME_INT < $VOLUME_FLOOR floor for $SEARCH_INTENT intent"
fi

# Opportunity score (15+)
OPP_INT=$(echo "$OPP_SCORE" | cut -d. -f1)
if [ "$OPP_INT" -ge 15 ]; then
    record_check "Opportunity score (15+)" "PASS" ""
else
    record_check "Opportunity score (15+)" "FAIL" "Score $OPP_SCORE < 15 minimum"
fi

# Differentiation gate (conditional)
DIFF_GATE=$(check_differentiation_gate "$DIFF_SCORE" "$EFF_DIFF" "$ARTICLE_TYPE")
case "$DIFF_GATE" in
    PASS) record_check "Differentiation gate" "PASS" "" ;;
    WARN) record_check "Differentiation gate" "WARN" "Low differentiation ($DIFF_SCORE) - ensure strong execution" ;;
    FAIL)
        if [ "$ARTICLE_TYPE" = "hub" ]; then
            record_check "Differentiation gate" "FAIL" "Hubs require differentiation score 7+, got $DIFF_SCORE"
        else
            record_check "Differentiation gate" "FAIL" "High difficulty ($EFF_DIFF) requires differentiation 5+, got $DIFF_SCORE"
        fi
        ;;
esac

# Trend + Score combo gate
TREND_GATE=$(check_trend_score_gate "$TREND" "$OPP_SCORE")
if [ "$TREND_GATE" = "PASS" ]; then
    record_check "Trend + Score combo" "PASS" ""
else
    record_check "Trend + Score combo" "FAIL" "Declining trend requires score 25+, got $OPP_SCORE"
fi

# Content type compatibility (from frontmatter)
SERP_TYPE=$(get_fm "serpContentType")
if [ "$SERP_TYPE" = "shopping_dominant" ]; then
    record_check "Content type compatibility" "FAIL" "Shopping-dominant SERP incompatible with informational content"
elif [ "$SERP_TYPE" = "video_dominant" ]; then
    record_check "Content type compatibility" "WARN" "Video-dominant SERP - consider video companion"
else
    record_check "Content type compatibility" "PASS" ""
fi

echo ""

# ============================================================================
# STEP 6: SOFT GATES (Warnings)
# ============================================================================

echo ">>> STEP 6: SOFT GATES"
echo ""

# AI Overview presence
AI_OVERVIEW=$(get_fm "aiOverviewPresent")
if [ "$AI_OVERVIEW" = "true" ]; then
    record_check "AI Overview strategy" "WARN" "AI Overview present - structure content for extraction"
else
    record_check "AI Overview strategy" "PASS" ""
fi

# Moat score
if [ "$MOAT_SCORE" -lt 4 ]; then
    record_check "Competitive moat" "WARN" "Low moat ($MOAT_SCORE) - expect competition catch-up"
else
    record_check "Competitive moat" "PASS" ""
fi

# Hub existence for clusters
if [ "$ARTICLE_TYPE" = "cluster" ]; then
    HUB_STATUS=$(get_fm "hubStatus")
    if [ "$HUB_STATUS" = "published" ] || [ "$HUB_STATUS" = "complete" ]; then
        record_check "Hub exists for cluster" "PASS" ""
    else
        record_check "Hub exists for cluster" "WARN" "Hub not published - consider hub-first strategy"
    fi
fi

# Cannibalization check
CANNIBAL_RISK=$(get_fm "cannibalizationRisk")
if [ "$CANNIBAL_RISK" = "confirmed" ]; then
    record_check "Cannibalization" "FAIL" "Confirmed cannibalization - resolve before proceeding"
elif [ "$CANNIBAL_RISK" = "potential" ]; then
    record_check "Cannibalization" "WARN" "Potential overlap - review differentiation"
else
    record_check "Cannibalization" "PASS" ""
fi

# Validation freshness (if re-validating)
VALIDATION_DATE=$(get_fm "validationDate")
if [ -n "$VALIDATION_DATE" ] && [ "$VALIDATION_DATE" != "null" ]; then
    # Calculate days since validation (macOS compatible)
    DAYS_OLD=$(( ($(date +%s) - $(date -j -f "%Y-%m-%d" "$VALIDATION_DATE" +%s 2>/dev/null || echo "0")) / 86400 ))
    if [ "$DAYS_OLD" -gt 90 ]; then
        record_check "Validation freshness" "WARN" "Validation is $DAYS_OLD days old - consider refresh"
    fi
fi

echo ""

# ============================================================================
# VERDICT
# ============================================================================

echo "============================================================================"

if [ "$HARD_FAILS" -eq 0 ]; then
    # GO
    echo "KEYWORD GATE V3: GO"
    echo "============================================================================"
    echo ""
    echo "Target: \"$TARGET_KEYWORD\""
    echo ""
    echo "METRICS"
    echo "  Volume:              $SEARCH_VOLUME/month (UK)"
    echo "  Difficulty:          $KW_DIFFICULTY (DataForSEO) → $EFF_DIFF effective"
    echo "  Intent:              $SEARCH_INTENT (${INTENT_MULT}x)"
    echo "  Trend:               $TREND (${TREND_MULT}x)"
    echo "  Opportunity Score:   $OPP_SCORE"
    echo ""
    echo "CLASSIFICATION"
    echo "  Difficulty Tier:     $DIFF_TIER"
    echo "  Article Type:        $ARTICLE_TYPE"
    echo "  Pillar:              $PILLAR"
    echo "  Timeline:            $(get_ranking_timeline "$DIFF_TIER" "false")"
    echo "  Est. Backlinks:      $(get_backlinks_estimate "$DIFF_TIER")"
    echo ""
    echo "PRIORITY"
    echo "  Priority Rank:       $PRIORITY_RANK"
    echo "  Guidance:            $(get_priority_guidance "$PRIORITY_RANK")"
    echo ""

    if [ ${#WARNINGS[@]} -gt 0 ]; then
        echo "WARNINGS"
        for warning in "${WARNINGS[@]}"; do
            echo "  - $warning"
        done
        echo ""
    fi

    echo "VALIDATION"
    echo "  Total Checks: $TOTAL_CHECKS"
    echo "  Passed: $PASS_CHECKS"
    echo "  Warnings: $WARN_CHECKS"
    echo ""
    echo "NEXT STEPS"
    echo "  1. Complete research file sections"
    echo "  2. Run check-research-gate.sh"
    echo "  3. Run /positioning-angles skill"
    echo ""

    # Update validation date in file (if not already today)
    TODAY=$(date '+%Y-%m-%d')
    if ! grep -q "^validationDate: $TODAY" "$FILE" 2>/dev/null; then
        if grep -q "^validationDate:" "$FILE" 2>/dev/null; then
            sed -i '' "s/^validationDate:.*/validationDate: $TODAY/" "$FILE" 2>/dev/null || true
        fi
    fi

    exit 0
else
    # NO-GO
    echo "KEYWORD GATE V3: NO-GO"
    echo "============================================================================"
    echo ""
    echo "Target: \"$TARGET_KEYWORD\""
    echo ""
    echo "METRICS"
    echo "  Volume:              ${SEARCH_VOLUME:-N/A}/month"
    echo "  Difficulty:          ${KW_DIFFICULTY:-N/A} → ${EFF_DIFF:-N/A} effective"
    echo "  Intent:              ${SEARCH_INTENT:-N/A}"
    echo "  Trend:               ${TREND:-N/A}"
    echo "  Opportunity Score:   ${OPP_SCORE:-N/A}"
    echo ""
    echo "REJECTION REASONS ($HARD_FAILS failures)"
    for failure in "${FAILURES[@]}"; do
        echo "  - $failure"
    done
    echo ""
    echo "RECOMMENDATION"
    echo "  This keyword is not viable. Consider:"
    echo "  - Related keyword with higher volume"
    echo "  - Different angle that improves differentiation"
    echo "  - Alternative with stable/rising trend"
    echo ""

    # Log to rejected keywords
    if [ -n "$TARGET_KEYWORD" ]; then
        REJECTION_REASON="${FAILURES[0]}"
        log_rejected_keyword "$TARGET_KEYWORD" "$REJECTION_REASON" "${SEARCH_VOLUME:-0}" "${OPP_SCORE:-0}" "Monitor"
        echo "LOGGED TO"
        echo "  Rejected keyword library (rejected-keywords.md)"
        echo "  Revisit: Monitor"
        echo ""
    fi

    exit 1
fi
