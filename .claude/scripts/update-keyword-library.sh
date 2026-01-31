#!/bin/bash
# ============================================================================
# AUTO-UPDATE KEYWORD LIBRARY (V3)
# ============================================================================
# Usage: ./update-keyword-library.sh <research-file>
# Example: ./update-keyword-library.sh research/pillar-5-adhd-apps/hub-research.md
#
# Called automatically by check-keyword-gate-v3.sh on PASS.
# Extracts V3 keyword data from research file and appends to keyword-library.md
# ============================================================================

FILE="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$(dirname "$SCRIPT_DIR")"
LIBRARY="$CLAUDE_DIR/keyword-library.md"
REJECTED="$CLAUDE_DIR/rejected-keywords.md"

if [ -z "$FILE" ]; then
    echo "ERROR: No research file specified"
    echo "Usage: ./update-keyword-library.sh <research-file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "ERROR: Research file not found: $FILE"
    exit 1
fi

if [ ! -f "$LIBRARY" ]; then
    echo "ERROR: Keyword library not found: $LIBRARY"
    exit 1
fi

# Helper function to extract frontmatter value
get_fm() {
    local key="$1"
    grep "^${key}:" "$FILE" 2>/dev/null | head -1 | sed "s/${key}:[[:space:]]*//" | tr -d '"' | tr -d "'"
}

# Extract V3 data from research file frontmatter
ARTICLE_TITLE=$(get_fm "articleTitle")
PILLAR=$(get_fm "pillar")
TARGET_KEYWORD=$(get_fm "targetKeyword")
SEARCH_VOLUME=$(get_fm "searchVolume")
KW_DIFFICULTY=$(get_fm "keywordDifficulty")
SEARCH_INTENT=$(get_fm "searchIntent")
TREND=$(get_fm "trendDirection")
[ -z "$TREND" ] && TREND=$(get_fm "searchTrend")  # Fallback to old field name
OPP_SCORE=$(get_fm "opportunityScore")
PRIORITY_RANK=$(get_fm "priorityRank")
VERDICT=$(get_fm "keywordVerdict")

# Extract secondary keywords (V3 format with nested structure)
# Try nested format first: secondaryKeywords: - keyword: "..."
SECONDARY_KEYWORDS=$(sed -n '/^secondaryKeywords:/,/^[a-zA-Z]/p' "$FILE" 2>/dev/null | grep "keyword:" | sed 's/.*keyword:[[:space:]]*//' | tr -d '"' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')

# If no nested format, try simple array format
if [ -z "$SECONDARY_KEYWORDS" ]; then
    SECONDARY_KEYWORDS=$(sed -n '/^secondaryKeywords:/,/^[a-zA-Z]/p' "$FILE" 2>/dev/null | grep "^  - " | sed 's/^  - //' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')
fi

# If still empty, try inline format
if [ -z "$SECONDARY_KEYWORDS" ]; then
    SECONDARY_KEYWORDS=$(grep "^secondaryKeywords:" "$FILE" 2>/dev/null | grep -o '\[.*\]' | tr -d '[]')
fi

# Get today's date
DATE=$(date +%Y-%m-%d)

# Validate required fields
if [ -z "$ARTICLE_TITLE" ] || [ "$ARTICLE_TITLE" = "null" ]; then
    echo "ERROR: articleTitle not found in research file"
    exit 1
fi

if [ -z "$TARGET_KEYWORD" ] || [ "$TARGET_KEYWORD" = "null" ]; then
    echo "ERROR: targetKeyword not found in research file"
    exit 1
fi

# Check verdict - only add if GO
if [ "$VERDICT" = "NO-GO" ]; then
    echo "INFO: Keyword verdict is NO-GO. Logging to rejected keywords instead."

    # Log to rejected keywords file
    if [ -f "$REJECTED" ]; then
        REJECTION_REASON=$(get_fm "rejectionReason")
        [ -z "$REJECTION_REASON" ] && REJECTION_REASON="Failed V3 validation"

        # Check if already in rejected table
        if ! grep -q "$TARGET_KEYWORD" "$REJECTED" 2>/dev/null; then
            # Add to rejected keywords (after header row)
            sed -i '' "/^| Keyword | Date |/a\\
| $TARGET_KEYWORD | $DATE | $REJECTION_REASON | ${SEARCH_VOLUME:-0} | ${OPP_SCORE:-0} | Monitor |
" "$REJECTED" 2>/dev/null
            echo "LOGGED: Added '$TARGET_KEYWORD' to rejected keywords library"
        fi
    fi
    exit 0
fi

# Check if entry already exists (by target keyword)
if grep -q "| $TARGET_KEYWORD |" "$LIBRARY" 2>/dev/null; then
    echo "INFO: Entry for '$TARGET_KEYWORD' already exists in library. Skipping."
    exit 0
fi

# Set defaults for missing V3 fields
[ -z "$KW_DIFFICULTY" ] || [ "$KW_DIFFICULTY" = "null" ] && KW_DIFFICULTY="-"
[ -z "$SEARCH_INTENT" ] || [ "$SEARCH_INTENT" = "null" ] && SEARCH_INTENT="-"
[ -z "$TREND" ] || [ "$TREND" = "null" ] && TREND="-"
[ -z "$OPP_SCORE" ] || [ "$OPP_SCORE" = "null" ] && OPP_SCORE="-"
[ -z "$PRIORITY_RANK" ] || [ "$PRIORITY_RANK" = "null" ] && PRIORITY_RANK="-"

# Create new V3 row
NEW_ROW="| $ARTICLE_TITLE | $PILLAR | $TARGET_KEYWORD | $SEARCH_VOLUME | $KW_DIFFICULTY | $SEARCH_INTENT | $TREND | $OPP_SCORE | $PRIORITY_RANK | $SECONDARY_KEYWORDS | $DATE |"

# Find the V3 table header and insert after first data row
# V3 header: | Article | Pillar | Target Keyword | Volume | Difficulty | Intent | Trend | Score | Priority | Secondary Keywords | Date |

# Insert after the table header row (skip past any existing rows and add at the end of the table)
# We'll add after the last row that starts with "|" before the next "---" or section header

# Find the line number of the table header
HEADER_LINE=$(grep -n "| Article | Pillar | Target Keyword | Volume | Difficulty |" "$LIBRARY" 2>/dev/null | head -1 | cut -d: -f1)

if [ -n "$HEADER_LINE" ]; then
    # Find the next section (line starting with ## or ---) after the header
    NEXT_SECTION=$(tail -n +$((HEADER_LINE + 2)) "$LIBRARY" | grep -n "^---\|^##" | head -1 | cut -d: -f1)

    if [ -n "$NEXT_SECTION" ]; then
        INSERT_LINE=$((HEADER_LINE + NEXT_SECTION))
    else
        # No next section found, append at end
        INSERT_LINE=$(wc -l < "$LIBRARY")
    fi

    # Insert the new row
    sed -i '' "${INSERT_LINE}i\\
$NEW_ROW
" "$LIBRARY" 2>/dev/null
else
    # Fallback: try old method
    echo "$NEW_ROW" >> "$LIBRARY"
fi

echo "============================================================================"
echo "KEYWORD LIBRARY UPDATED (V3)"
echo "============================================================================"
echo "  Article:    $ARTICLE_TITLE"
echo "  Keyword:    $TARGET_KEYWORD"
echo "  Volume:     $SEARCH_VOLUME"
echo "  Difficulty: $KW_DIFFICULTY"
echo "  Intent:     $SEARCH_INTENT"
echo "  Trend:      $TREND"
echo "  Score:      $OPP_SCORE"
echo "  Priority:   $PRIORITY_RANK"
echo "============================================================================"
