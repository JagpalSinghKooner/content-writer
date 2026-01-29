#!/bin/bash
# ============================================================================
# AUTO-UPDATE KEYWORD LIBRARY
# ============================================================================
# Usage: ./update-keyword-library.sh <research-file>
# Example: ./update-keyword-library.sh research/pillar-5-adhd-apps/hub-research.md
#
# Called automatically by check-keyword-gate.sh on PASS.
# Extracts keyword data from research file and appends to keyword-library.md
# ============================================================================

FILE="$1"
LIBRARY=".claude/keyword-library.md"

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

# Extract data from research file frontmatter
ARTICLE_TITLE=$(grep "^articleTitle:" "$FILE" 2>/dev/null | sed 's/articleTitle:[[:space:]]*//' | tr -d '"' | tr -d "'")
PILLAR=$(grep "^pillar:" "$FILE" 2>/dev/null | sed 's/pillar:[[:space:]]*//' | tr -d '"' | tr -d "'")
TARGET_KEYWORD=$(grep "^targetKeyword:" "$FILE" 2>/dev/null | sed 's/targetKeyword:[[:space:]]*//' | tr -d '"' | tr -d "'")
SEARCH_VOLUME=$(grep "^searchVolume:" "$FILE" 2>/dev/null | sed 's/searchVolume:[[:space:]]*//' | tr -d '"' | tr -d "'")

# Extract secondary keywords (YAML array format)
SECONDARY_KEYWORDS=$(sed -n '/^secondaryKeywords:/,/^[a-zA-Z]/p' "$FILE" 2>/dev/null | grep "^  - " | sed 's/^  - //' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')

# If no YAML array, try inline format
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

# Check if entry already exists (by target keyword)
if grep -q "$TARGET_KEYWORD" "$LIBRARY" 2>/dev/null; then
    echo "INFO: Entry for '$TARGET_KEYWORD' already exists in library. Skipping."
    exit 0
fi

# Create new row
NEW_ROW="| $ARTICLE_TITLE | $PILLAR | $TARGET_KEYWORD | $SEARCH_VOLUME | $SECONDARY_KEYWORDS | $DATE |"

# Find the empty row marker and insert after it
# The table has an empty row: | | | | | | |
# We insert the new row after this marker

# Use sed to insert after the empty row in Validated Keywords table
# We look for the pattern "| | | | | | |" and append after it
sed -i '' "/^| | | | | | |$/a\\
$NEW_ROW
" "$LIBRARY"

echo "SUCCESS: Added keyword entry to library"
echo "  Article: $ARTICLE_TITLE"
echo "  Keyword: $TARGET_KEYWORD"
echo "  Volume: $SEARCH_VOLUME"
