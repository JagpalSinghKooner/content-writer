#!/bin/bash
# ============================================================================
# GATE STATE MANAGEMENT - Shared functions for diff-based output
# ============================================================================
# Provides state persistence between gate runs to show:
# - FIXED: Was failing, now passing
# - STILL FAILING: Was failing, still failing
# - NEW FAILURE: Was passing, now failing
#
# Usage: Source this file in gate scripts
#   source "$(dirname "$0")/lib/gate-state.sh"
# ============================================================================

STATE_DIR="/tmp/gate-state"

# Initialize state directory
init_state_dir() {
    mkdir -p "$STATE_DIR" 2>/dev/null
}

# Generate file hash for unique state files per article
# macOS compatible (md5 vs md5sum)
get_file_hash() {
    local file="$1"
    if command -v md5 >/dev/null 2>&1; then
        echo "$file" | md5 -q
    else
        echo "$file" | md5sum | cut -d' ' -f1
    fi
}

# Get state file path for an article/script combination
get_state_file() {
    local file="$1"
    local script_name="$2"
    local file_hash
    file_hash=$(get_file_hash "$file")
    echo "$STATE_DIR/${script_name}-${file_hash}.txt"
}

# Save current run state to file
# Usage: save_state "$STATE_FILE" "$ARTICLE" "$SCRIPT_NAME" "${CURRENT_STATE[@]}"
save_state() {
    local state_file="$1"
    local article_file="$2"
    local script_name="$3"
    shift 3

    init_state_dir

    {
        echo "# Gate state file - auto-generated"
        echo "# Article: $article_file"
        echo "# Script: $script_name"
        echo "# Timestamp: $(date -Iseconds 2>/dev/null || date '+%Y-%m-%dT%H:%M:%S')"
        echo ""
        for entry in "$@"; do
            echo "$entry"
        done
    } > "$state_file"
}

# Get previous value for a check (bash 3.2 compatible - no associative arrays)
# Returns: STATUS:VALUE or empty if not found
get_prev_value() {
    local check_name="$1"
    local state_file="$2"

    if [ ! -f "$state_file" ]; then
        return 1
    fi

    grep "^${check_name}=" "$state_file" 2>/dev/null | cut -d'=' -f2
}

# Check if previous state exists
has_previous_state() {
    local state_file="$1"
    [ -f "$state_file" ] && [ -s "$state_file" ]
}

# Output diff summary between runs
# Takes arrays by reference-like passing (bash 3.2 workaround)
# Usage: output_diff "$FIXED_COUNT" "$STILL_FAILING_COUNT" "$NEW_FAILURE_COUNT" \
#                   "${DIFF_FIXED[*]}" "${DIFF_STILL_FAILING[*]}" "${DIFF_NEW_FAILURE[*]}"
output_diff_summary() {
    local fixed_count="$1"
    local still_count="$2"
    local new_count="$3"
    local fixed_items="$4"
    local still_items="$5"
    local new_items="$6"

    echo ""
    echo "============================================================================"
    echo "DIFF FROM PREVIOUS RUN"
    echo "============================================================================"

    if [ "$fixed_count" -gt 0 ]; then
        echo ""
        echo "FIXED ($fixed_count):"
        echo "$fixed_items" | tr '|' '\n' | while read -r item; do
            [ -n "$item" ] && echo "  + $item"
        done
    fi

    if [ "$still_count" -gt 0 ]; then
        echo ""
        echo "STILL FAILING ($still_count):"
        echo "$still_items" | tr '|' '\n' | while read -r item; do
            [ -n "$item" ] && echo "  - $item"
        done
    fi

    if [ "$new_count" -gt 0 ]; then
        echo ""
        echo "NEW FAILURE ($new_count):"
        echo "$new_items" | tr '|' '\n' | while read -r item; do
            [ -n "$item" ] && echo "  ! $item"
        done
    fi

    if [ "$fixed_count" -eq 0 ] && [ "$still_count" -eq 0 ] && [ "$new_count" -eq 0 ]; then
        echo ""
        echo "No changes from previous run."
    fi

    echo ""
}

# Compare single check result with previous state
# Returns: FIXED, STILL_FAILING, NEW_FAILURE, or UNCHANGED
compare_check_result() {
    local check_name="$1"
    local curr_status="$2"  # PASS or FAIL
    local prev_status="$3"  # PASS or FAIL or empty

    if [ -z "$prev_status" ]; then
        # No previous state - not a diff
        echo "NEW_CHECK"
    elif [ "$prev_status" = "FAIL" ] && [ "$curr_status" = "PASS" ]; then
        echo "FIXED"
    elif [ "$prev_status" = "FAIL" ] && [ "$curr_status" = "FAIL" ]; then
        echo "STILL_FAILING"
    elif [ "$prev_status" = "PASS" ] && [ "$curr_status" = "FAIL" ]; then
        echo "NEW_FAILURE"
    else
        echo "UNCHANGED"
    fi
}

# Clean up old state files (older than 7 days)
cleanup_old_states() {
    if [ -d "$STATE_DIR" ]; then
        find "$STATE_DIR" -type f -mtime +7 -delete 2>/dev/null
    fi
}

# Clear state for a specific article (useful for fresh start)
clear_state() {
    local state_file="$1"
    rm -f "$state_file" 2>/dev/null
}
