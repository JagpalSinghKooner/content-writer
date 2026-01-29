#!/bin/bash
# ============================================================================
# AUTO-UPDATE ANGLE LIBRARY
# ============================================================================
# Usage: ./update-angle-library.sh <research-file>
# Example: ./update-angle-library.sh research/pillar-5-adhd-apps/hub-research.md
#
# Called automatically by check-angle-gate.sh on PASS.
# Extracts angle data from research file and appends to angle-library.md
# ============================================================================

FILE="$1"
LIBRARY=".claude/angle-library.md"

if [ -z "$FILE" ]; then
    echo "ERROR: No research file specified"
    echo "Usage: ./update-angle-library.sh <research-file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "ERROR: Research file not found: $FILE"
    exit 1
fi

if [ ! -f "$LIBRARY" ]; then
    echo "ERROR: Angle library not found: $LIBRARY"
    exit 1
fi

# Extract data from research file frontmatter
ARTICLE_TITLE=$(grep "^articleTitle:" "$FILE" 2>/dev/null | sed 's/articleTitle:[[:space:]]*//' | tr -d '"' | tr -d "'")
PILLAR=$(grep "^pillar:" "$FILE" 2>/dev/null | sed 's/pillar:[[:space:]]*//' | tr -d '"' | tr -d "'")
SELECTED_ANGLE=$(grep "^selectedAngle:" "$FILE" 2>/dev/null | sed 's/selectedAngle:[[:space:]]*//' | tr -d '"' | tr -d "'")
ANGLE_DESC=$(grep "^angleDescription:" "$FILE" 2>/dev/null | sed 's/angleDescription:[[:space:]]*//' | tr -d '"' | tr -d "'")
HEADLINE_DIR=$(grep "^headlineDirection:" "$FILE" 2>/dev/null | sed 's/headlineDirection:[[:space:]]*//' | tr -d '"' | tr -d "'")

# Get today's date
DATE=$(date +%Y-%m-%d)

# Validate required fields
if [ -z "$ARTICLE_TITLE" ] || [ "$ARTICLE_TITLE" = "null" ]; then
    echo "ERROR: articleTitle not found in research file"
    exit 1
fi

if [ -z "$SELECTED_ANGLE" ] || [ "$SELECTED_ANGLE" = "null" ]; then
    echo "ERROR: selectedAngle not found in research file"
    exit 1
fi

# Check if entry already exists (by article title + angle combination)
if grep -q "$ARTICLE_TITLE.*$SELECTED_ANGLE" "$LIBRARY" 2>/dev/null; then
    echo "INFO: Entry for '$ARTICLE_TITLE' with angle '$SELECTED_ANGLE' already exists. Skipping."
    exit 0
fi

# Create new row
NEW_ROW="| $ARTICLE_TITLE | $PILLAR | $SELECTED_ANGLE | $ANGLE_DESC | $HEADLINE_DIR | $DATE |"

# Find the empty row marker in Angles Used table and insert after it
# The table has an empty row: | | | | | | |
sed -i '' "/^| | | | | | |$/a\\
$NEW_ROW
" "$LIBRARY"

echo "SUCCESS: Added angle entry to library"
echo "  Article: $ARTICLE_TITLE"
echo "  Angle: $SELECTED_ANGLE"
echo "  Headline: $HEADLINE_DIR"
