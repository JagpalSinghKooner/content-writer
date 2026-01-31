#!/bin/bash
# ============================================================================
# KEYWORD SCORING LIBRARY - V3 Validation Formulas
# ============================================================================
# Shared functions for keyword validation scoring and classification.
# Used by check-keyword-gate-v3.sh and update-keyword-library.sh
#
# Usage: Source this file in scripts
#   source "$(dirname "$0")/lib/keyword-scoring.sh"
#
# All functions use bash 3.2 compatible syntax (macOS default)
# ============================================================================

# ============================================================================
# INTENT CLASSIFICATION
# ============================================================================

# Get intent multiplier based on search intent type
# Usage: get_intent_multiplier "commercial"
# Returns: Multiplier value (e.g., "2.5")
# V3.1: Added crisis intent type (2.5x), updated informational to 1.5x
get_intent_multiplier() {
    local intent="$1"
    case "$intent" in
        transactional)      echo "3.0" ;;
        commercial)         echo "2.5" ;;
        crisis)             echo "2.5" ;;  # NEW: Crisis intent (same priority as commercial)
        informational-product|info-product) echo "2.0" ;;
        informational|info) echo "1.5" ;;  # UPDATED: Was 1.0, now 1.5
        *)                  echo "1.5" ;;  # Default to informational
    esac
}

# Get volume floor based on search intent type
# Usage: get_volume_floor "commercial"
# Returns: Minimum volume threshold (e.g., "100")
# V3.1: Added crisis intent (100), lowered informational from 500 to 200
get_volume_floor() {
    local intent="$1"
    case "$intent" in
        transactional)      echo "50" ;;
        commercial)         echo "100" ;;
        crisis)             echo "100" ;;  # NEW: Crisis intent (same floor as commercial)
        informational-product|info-product) echo "200" ;;
        informational|info) echo "200" ;;  # UPDATED: Was 500, now 200
        *)                  echo "200" ;;  # Default to informational
    esac
}

# Classify search intent from keyword signals
# Usage: classify_intent "best ADHD apps UK" "0.85"
# Args: keyword, cpc (optional)
# Returns: Intent type (transactional, commercial, crisis, informational-product, informational)
# V3.1: Added crisis intent detection for urgent parenting searches
classify_intent() {
    local keyword="$1"
    local cpc="${2:-0}"
    local keyword_lower
    keyword_lower=$(echo "$keyword" | tr '[:upper:]' '[:lower:]')

    # Crisis signals (check FIRST - highest priority for HushAway audience)
    # Time urgency patterns
    if echo "$keyword_lower" | grep -qE "\b(won't sleep|won't go to sleep|can't sleep|won't calm|can't calm|nothing works|at my wit's end|desperate|urgent)\b"; then
        echo "crisis"
        return
    fi
    # Emotional urgency patterns
    if echo "$keyword_lower" | grep -qE '\b(meltdown|breakdown|overwhelmed|exhausted|struggling|crisis)\b'; then
        echo "crisis"
        return
    fi
    # Action urgency patterns
    if echo "$keyword_lower" | grep -qE '\b(help my child|how to stop|what do i do|what to do when|how do i help)\b'; then
        echo "crisis"
        return
    fi

    # Transactional signals
    if echo "$keyword_lower" | grep -qE '\b(buy|download|get|try|free|price|cost|sign up|subscribe)\b'; then
        echo "transactional"
        return
    fi

    # Commercial signals
    if echo "$keyword_lower" | grep -qE '\b(best|top|review|vs|alternative|comparison|recommended|for kids|for children|for adhd)\b'; then
        echo "commercial"
        return
    fi

    # Informational + Product signals (question format with product fit)
    if echo "$keyword_lower" | grep -qE '\b(how to|help|what helps|strategies|tips|apps|app)\b'; then
        echo "informational-product"
        return
    fi

    # Default to informational
    echo "informational"
}

# ============================================================================
# TREND CLASSIFICATION
# ============================================================================

# Get trend multiplier based on trend direction
# Usage: get_trend_multiplier "rising"
# Returns: Multiplier value (e.g., "1.2")
get_trend_multiplier() {
    local trend="$1"
    case "$trend" in
        rising)    echo "1.2" ;;
        stable)    echo "1.0" ;;
        declining) echo "0.7" ;;
        *)         echo "1.0" ;; # Default to stable
    esac
}

# ============================================================================
# DIFFICULTY CALCULATION
# ============================================================================

# Calculate effective difficulty with authority adjustment
# Usage: calculate_effective_difficulty 25 "+10" "+0"
# Args: base_kd, authority_adjustment, difficulty_trend_adjustment
# Returns: Effective difficulty score
calculate_effective_difficulty() {
    local base_kd="$1"
    local auth_adj="${2:-0}"
    local trend_adj="${3:-0}"

    # Remove + prefix if present
    auth_adj="${auth_adj#+}"
    trend_adj="${trend_adj#+}"

    # Calculate (bash integer math)
    local effective=$((base_kd + auth_adj + trend_adj))

    # Floor at base_kd (never go below original)
    if [ "$effective" -lt "$base_kd" ]; then
        effective="$base_kd"
    fi

    echo "$effective"
}

# Get authority adjustment based on top 5 SERP composition
# Usage: get_authority_adjustment 3  # 3 DA 70+ sites in top 5
# Args: count_da70_plus
# Returns: Authority adjustment value (-5, 0, +10, +20)
get_authority_adjustment() {
    local da70_count="${1:-0}"
    local mostly_low_da="${2:-false}"  # true if mostly DA <30

    if [ "$da70_count" -ge 3 ]; then
        echo "20"
    elif [ "$da70_count" -eq 2 ]; then
        echo "10"
    elif [ "$mostly_low_da" = "true" ]; then
        echo "-5"
    else
        echo "0"
    fi
}

# Get difficulty tier from effective difficulty
# Usage: get_difficulty_tier 25
# Returns: Tier name (easy, medium, hard, very-hard)
get_difficulty_tier() {
    local eff_diff="$1"

    if [ "$eff_diff" -le 30 ]; then
        echo "easy"
    elif [ "$eff_diff" -le 50 ]; then
        echo "medium"
    elif [ "$eff_diff" -le 70 ]; then
        echo "hard"
    else
        echo "very-hard"
    fi
}

# Get ranking timeline based on difficulty tier
# Usage: get_ranking_timeline "easy" "false"
# Args: tier, with_links (true/false)
# Returns: Timeline string (e.g., "2-4 months")
get_ranking_timeline() {
    local tier="$1"
    local with_links="${2:-false}"

    if [ "$with_links" = "true" ]; then
        case "$tier" in
            easy)       echo "1-2 months" ;;
            medium)     echo "2-4 months" ;;
            hard)       echo "4-6 months" ;;
            very-hard)  echo "6-12 months" ;;
            *)          echo "4-6 months" ;;
        esac
    else
        case "$tier" in
            easy)       echo "2-4 months" ;;
            medium)     echo "4-6 months" ;;
            hard)       echo "6-12 months" ;;
            very-hard)  echo "12-18+ months" ;;
            *)          echo "6-12 months" ;;
        esac
    fi
}

# Get estimated backlinks needed based on difficulty tier
# Usage: get_backlinks_estimate "medium"
# Returns: Backlink range string (e.g., "3-10")
get_backlinks_estimate() {
    local tier="$1"

    case "$tier" in
        easy)       echo "0-3" ;;
        medium)     echo "3-10" ;;
        hard)       echo "10-25" ;;
        very-hard)  echo "25+" ;;
        *)          echo "3-10" ;;
    esac
}

# ============================================================================
# OPPORTUNITY SCORE CALCULATION
# ============================================================================

# Calculate opportunity score using V3 formula
# Usage: calculate_opportunity_score 500 2.5 1.2 25 5
# Args: volume, intent_multiplier, trend_multiplier, effective_difficulty, snippet_bonus
# Returns: Opportunity score (decimal, one decimal place)
calculate_opportunity_score() {
    local volume="$1"
    local intent_mult="$2"
    local trend_mult="$3"
    local eff_diff="$4"
    local snippet_bonus="${5:-0}"

    # Formula: (Volume × Intent × Trend) / (EffDiff + 10) + SnippetBonus
    # Using awk for decimal math
    awk -v v="$volume" -v i="$intent_mult" -v t="$trend_mult" -v d="$eff_diff" -v s="$snippet_bonus" \
        'BEGIN { printf "%.1f", (v * i * t) / (d + 10) + s }'
}

# Get snippet bonus from SERP analysis
# Usage: get_snippet_bonus "paragraph" "weak" "true"
# Args: snippet_type, holder_strength, format_match
# Returns: Snippet bonus (0-7)
get_snippet_bonus() {
    local snippet_type="$1"       # paragraph, list, table, none
    local holder_strength="$2"    # weak, outdated, poor_format, strong
    local format_match="${3:-true}"  # true if our content can match format

    local bonus=0

    # Type match bonus (if we can create matching content)
    if [ "$format_match" = "true" ]; then
        case "$snippet_type" in
            paragraph) bonus=$((bonus + 3)) ;;
            list)      bonus=$((bonus + 2)) ;;
            table)     bonus=$((bonus + 2)) ;;
            *)         bonus=$((bonus + 0)) ;;
        esac
    fi

    # Holder weakness bonus
    case "$holder_strength" in
        weak)        bonus=$((bonus + 2)) ;;  # DA <40
        outdated)    bonus=$((bonus + 2)) ;;  # >2 years old
        poor_format) bonus=$((bonus + 1)) ;;  # Doesn't match snippet type
        strong)      bonus=$((bonus + 0)) ;;  # NHS, major authority
        *)           bonus=$((bonus + 0)) ;;
    esac

    # Cap at 7
    if [ "$bonus" -gt 7 ]; then
        bonus=7
    fi

    echo "$bonus"
}

# ============================================================================
# DIFFERENTIATION SCORING
# ============================================================================

# Calculate differentiation score from gap analysis
# Usage: calculate_differentiation_score "true" "true" "false" 3 "true" "true"
# Args: uk_specific, affirming_voice, passive_sound, missing_paa_count, outdated_content, format_opportunity
# Returns: Differentiation score (0-15+)
calculate_differentiation_score() {
    local uk_specific="${1:-false}"
    local affirming_voice="${2:-false}"
    local passive_sound="${3:-false}"
    local missing_paa="${4:-0}"
    local outdated_content="${5:-false}"
    local format_opportunity="${6:-false}"
    local depth_gap="${7:-false}"
    local missing_eeat="${8:-false}"
    local poor_ux="${9:-false}"

    local score=0

    # Major gaps (+3 each)
    [ "$uk_specific" = "true" ] && score=$((score + 3))
    [ "$affirming_voice" = "true" ] && score=$((score + 3))
    [ "$passive_sound" = "true" ] && score=$((score + 3))

    # Medium gaps (+2 each)
    [ "$outdated_content" = "true" ] && score=$((score + 2))
    [ "$format_opportunity" = "true" ] && score=$((score + 2))
    [ "$missing_eeat" = "true" ] && score=$((score + 2))

    # Minor gaps (+1 each)
    score=$((score + missing_paa))  # +1 per missing PAA answer
    [ "$depth_gap" = "true" ] && score=$((score + 1))
    [ "$poor_ux" = "true" ] && score=$((score + 1))

    echo "$score"
}

# Get differentiation tier from score
# Usage: get_differentiation_tier 9
# Returns: Tier name (strong, good, moderate, weak, none)
get_differentiation_tier() {
    local score="$1"

    if [ "$score" -ge 10 ]; then
        echo "strong"
    elif [ "$score" -ge 7 ]; then
        echo "good"
    elif [ "$score" -ge 5 ]; then
        echo "moderate"
    elif [ "$score" -ge 3 ]; then
        echo "weak"
    else
        echo "none"
    fi
}

# ============================================================================
# COMPETITIVE MOAT SCORING
# ============================================================================

# Calculate competitive moat score
# Usage: calculate_moat_score "true" "true" "true" "false" "true"
# Args: unique_angle, uk_specificity, eeat_advantage, community_data, fresh_content
# Returns: Moat score (0-10)
calculate_moat_score() {
    local unique_angle="${1:-false}"     # +3 if HushAway has positioning competitors can't copy
    local uk_specificity="${2:-false}"   # +2 if UK-specific content US competitors won't create
    local eeat_advantage="${3:-false}"   # +2 if Nicola's credentials provide authority
    local community_data="${4:-false}"   # +2 if community quotes are uncopyable
    local fresh_content="${5:-false}"    # +1 if content more current than competitors

    local score=0

    [ "$unique_angle" = "true" ] && score=$((score + 3))
    [ "$uk_specificity" = "true" ] && score=$((score + 2))
    [ "$eeat_advantage" = "true" ] && score=$((score + 2))
    [ "$community_data" = "true" ] && score=$((score + 2))
    [ "$fresh_content" = "true" ] && score=$((score + 1))

    echo "$score"
}

# Get moat tier from score
# Usage: get_moat_tier 8
# Returns: Tier name (strong, moderate, weak)
get_moat_tier() {
    local score="$1"

    if [ "$score" -ge 8 ]; then
        echo "strong"
    elif [ "$score" -ge 5 ]; then
        echo "moderate"
    else
        echo "weak"
    fi
}

# ============================================================================
# PRIORITY CALCULATION
# ============================================================================

# Calculate priority score from opportunity score and tier
# Usage: calculate_priority_score 47.8 "easy"
# Args: opportunity_score, difficulty_tier
# Returns: Priority score
calculate_priority_score() {
    local opp_score="$1"
    local tier="$2"

    # Tier weights
    local tier_weight
    case "$tier" in
        easy)       tier_weight="1.0" ;;
        medium)     tier_weight="1.5" ;;
        hard)       tier_weight="2.0" ;;
        very-hard)  tier_weight="3.0" ;;
        *)          tier_weight="1.5" ;;
    esac

    # Priority = Opportunity Score / Tier Weight
    awk -v o="$opp_score" -v t="$tier_weight" 'BEGIN { printf "%.1f", o / t }'
}

# Calculate priority rank (1-5) from priority score and tier
# Usage: calculate_priority_rank 42.8 "easy"
# Args: priority_score, difficulty_tier
# Returns: Priority rank (1-5)
calculate_priority_rank() {
    local priority_score="$1"
    local tier="$2"

    # Convert to integer for comparison (bash doesn't do decimals)
    local score_int
    score_int=$(echo "$priority_score" | cut -d. -f1)

    if [ "$score_int" -ge 40 ] && [ "$tier" = "easy" ]; then
        echo "5"  # Write this week
    elif [ "$score_int" -ge 25 ] && [ "$tier" = "easy" ]; then
        echo "4"  # Write soon
    elif [ "$score_int" -ge 25 ] && [ "$tier" = "medium" ]; then
        echo "3"  # Schedule normally
    elif [ "$score_int" -ge 15 ] || [ "$tier" = "hard" ]; then
        echo "2"  # Lower priority
    else
        echo "1"  # Strategic only
    fi
}

# Apply priority modifiers and return final rank (capped at 5)
# Usage: apply_priority_modifiers 3 "rising" "high" "true" "false" 8
# Args: base_rank, trend, volatility, cross_pillar, seasonal_near_peak, moat_score
# Returns: Modified rank (1-5)
apply_priority_modifiers() {
    local rank="$1"
    local trend="${2:-stable}"
    local volatility="${3:-moderate}"
    local cross_pillar="${4:-false}"
    local seasonal_near="${5:-false}"
    local moat_score="${6:-5}"
    local question_keyword="${7:-false}"
    local hub_keyword="${8:-false}"
    local brand_defence="${9:-false}"

    # Rising trend: +1
    [ "$trend" = "rising" ] && rank=$((rank + 1))
    # Declining trend: -1
    [ "$trend" = "declining" ] && rank=$((rank - 1))

    # High SERP volatility: +1
    [ "$volatility" = "high" ] && rank=$((rank + 1))

    # Cross-pillar: +1
    [ "$cross_pillar" = "true" ] && rank=$((rank + 1))

    # Seasonal near peak: +2
    [ "$seasonal_near" = "true" ] && rank=$((rank + 2))

    # Question keyword: +0.5 (rounds up to +1 if already at .5)
    [ "$question_keyword" = "true" ] && rank=$((rank + 1))

    # Hub keyword: +1
    [ "$hub_keyword" = "true" ] && rank=$((rank + 1))

    # Brand defence: +2
    [ "$brand_defence" = "true" ] && rank=$((rank + 2))

    # High moat (8+): +1
    [ "$moat_score" -ge 8 ] && rank=$((rank + 1))
    # Low moat (<4): -1
    [ "$moat_score" -lt 4 ] && rank=$((rank - 1))

    # Cap at 5, floor at 1
    [ "$rank" -gt 5 ] && rank=5
    [ "$rank" -lt 1 ] && rank=1

    echo "$rank"
}

# Get priority guidance text
# Usage: get_priority_guidance 5
# Returns: Guidance string
get_priority_guidance() {
    local rank="$1"

    case "$rank" in
        5) echo "Write this week - high opportunity, easy competition" ;;
        4) echo "Write soon - good opportunity" ;;
        3) echo "Schedule normally - moderate priority" ;;
        2) echo "Lower priority - consider other keywords first" ;;
        1) echo "Strategic only - proceed if pillar needs coverage" ;;
        *) echo "Review manually" ;;
    esac
}

# ============================================================================
# TRAFFIC ESTIMATION
# ============================================================================

# Estimate monthly traffic based on CTR adjustments
# Usage: estimate_traffic 500 "1" "featured_snippet,ai_overview"
# Args: volume, target_position, serp_features (comma-separated)
# Returns: Estimated monthly clicks
estimate_traffic() {
    local volume="$1"
    local position="${2:-3}"
    local features="${3:-}"

    # Base CTR by position
    local base_ctr
    case "$position" in
        1) base_ctr="0.27" ;;
        2) base_ctr="0.15" ;;
        3) base_ctr="0.11" ;;
        4) base_ctr="0.08" ;;
        5) base_ctr="0.06" ;;
        *) base_ctr="0.02" ;;
    esac

    # Feature deductions
    local deduction="0"
    if echo "$features" | grep -q "featured_snippet"; then
        deduction=$(awk -v d="$deduction" 'BEGIN { print d + 0.08 }')
    fi
    if echo "$features" | grep -q "ai_overview"; then
        deduction=$(awk -v d="$deduction" 'BEGIN { print d + 0.10 }')
    fi
    if echo "$features" | grep -q "knowledge_panel"; then
        deduction=$(awk -v d="$deduction" 'BEGIN { print d + 0.05 }')
    fi
    if echo "$features" | grep -q "video_carousel"; then
        deduction=$(awk -v d="$deduction" 'BEGIN { print d + 0.04 }')
    fi
    if echo "$features" | grep -q "paa"; then
        deduction=$(awk -v d="$deduction" 'BEGIN { print d + 0.03 }')
    fi

    # Calculate adjusted CTR and traffic
    awk -v v="$volume" -v c="$base_ctr" -v d="$deduction" \
        'BEGIN {
            adjusted = c - d
            if (adjusted < 0.02) adjusted = 0.02
            printf "%.0f", v * adjusted
        }'
}

# ============================================================================
# VALIDATION HELPERS
# ============================================================================

# Check if keyword passes volume floor for intent
# Usage: check_volume_floor 80 "transactional"
# Returns: "PASS" or "FAIL"
check_volume_floor() {
    local volume="$1"
    local intent="$2"
    local floor
    floor=$(get_volume_floor "$intent")

    if [ "$volume" -ge "$floor" ]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}

# Check if differentiation passes for difficulty
# Usage: check_differentiation_gate 5 45 "cluster"
# Args: diff_score, effective_difficulty, article_type
# Returns: "PASS", "WARN", or "FAIL"
check_differentiation_gate() {
    local diff_score="$1"
    local eff_diff="$2"
    local article_type="${3:-cluster}"

    # Hubs require 7+
    if [ "$article_type" = "hub" ] && [ "$diff_score" -lt 7 ]; then
        echo "FAIL"
        return
    fi

    # High difficulty (>40) requires 5+
    if [ "$eff_diff" -gt 40 ] && [ "$diff_score" -lt 5 ]; then
        echo "FAIL"
        return
    fi

    # Low differentiation warning
    if [ "$diff_score" -lt 5 ]; then
        echo "WARN"
        return
    fi

    echo "PASS"
}

# Check trend + score combo gate
# Usage: check_trend_score_gate "declining" 24
# Returns: "PASS" or "FAIL"
check_trend_score_gate() {
    local trend="$1"
    local score="$2"

    # Convert score to integer
    local score_int
    score_int=$(echo "$score" | cut -d. -f1)

    # Declining trend with score <25 = FAIL
    if [ "$trend" = "declining" ] && [ "$score_int" -lt 25 ]; then
        echo "FAIL"
    else
        echo "PASS"
    fi
}

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Round decimal to integer
# Usage: round_decimal 47.8
# Returns: 48
round_decimal() {
    local num="$1"
    awk -v n="$num" 'BEGIN { printf "%.0f", n + 0.5 }'
}

# Format score with status indicator
# Usage: format_score_status 47.8 15 "Opportunity Score"
# Args: value, threshold, label
# Returns: Formatted string with PASS/FAIL indicator
format_score_status() {
    local value="$1"
    local threshold="$2"
    local label="$3"

    local value_int
    value_int=$(echo "$value" | cut -d. -f1)

    if [ "$value_int" -ge "$threshold" ]; then
        echo "PASS: $label $value >= $threshold"
    else
        echo "FAIL: $label $value < $threshold"
    fi
}
