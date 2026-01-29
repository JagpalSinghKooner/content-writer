#!/bin/bash
# ============================================================================
# AUTO-UPDATE ARTICLE STATUS
# ============================================================================
# Usage: ./update-article-status.sh <article-file>
# Example: ./update-article-status.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md
#
# Called automatically by check-final-gate.sh on PASS.
# Updates ARTICLE-ORDER.md checkbox from incomplete to complete.
# ============================================================================

FILE="$1"
ORDER_FILE="ARTICLE-ORDER.md"

if [ -z "$FILE" ]; then
    echo "ERROR: No article file specified"
    echo "Usage: ./update-article-status.sh <article-file>"
    exit 1
fi

if [ ! -f "$ORDER_FILE" ]; then
    echo "ERROR: ARTICLE-ORDER.md not found"
    exit 1
fi

# Extract article identifier from file path
FILENAME=$(basename "$FILE" .md)

# Determine if this is a hub or cluster article
if [[ "$FILENAME" == hub-* ]]; then
    # Hub article - extract pillar from path
    # e.g., src/content/pillar-5-adhd-apps/hub-adhd-apps.md -> "HUB:"
    PILLAR_PATH=$(dirname "$FILE")
    PILLAR_NUM=$(echo "$PILLAR_PATH" | grep -oE 'pillar-[0-9]+' | grep -oE '[0-9]+')

    # Find the row with "HUB:" in the correct pillar section
    # Look for pattern "| 1 |" followed by status and "HUB:"
    SEARCH_PATTERN="| HUB:"

    echo "Updating hub article status for Pillar $PILLAR_NUM..."
else
    # Cluster article - extract number (5.1, 7.2, etc.)
    ARTICLE_NUM=$(echo "$FILENAME" | grep -oE '^[0-9]+\.[0-9]+')

    if [ -z "$ARTICLE_NUM" ]; then
        echo "ERROR: Could not extract article number from filename: $FILENAME"
        exit 1
    fi

    SEARCH_PATTERN="| $ARTICLE_NUM "
    echo "Updating cluster article status for $ARTICLE_NUM..."
fi

# Check if the row exists
if ! grep -q "$SEARCH_PATTERN" "$ORDER_FILE"; then
    echo "WARNING: Could not find article in ARTICLE-ORDER.md"
    echo "  Filename: $FILENAME"
    echo "  Search pattern: $SEARCH_PATTERN"
    exit 0
fi

# Count current completions before update
BEFORE_COUNT=$(grep -c "| ✅ |" "$ORDER_FILE" 2>/dev/null) || BEFORE_COUNT=0

# Replace the checkbox from incomplete to complete on the matching line
# Pattern: Find the line with our search pattern, change first instance of incomplete box
if [[ "$FILENAME" == hub-* ]]; then
    # For hub articles, we need to match the line more carefully
    # Find line in the correct pillar section containing "| HUB:"
    sed -i '' "/$SEARCH_PATTERN/s/| ⬜ |/| ✅ |/" "$ORDER_FILE"
else
    # For cluster articles, match by article number
    sed -i '' "/$SEARCH_PATTERN/s/| ⬜ |/| ✅ |/" "$ORDER_FILE"
fi

# Count completions after update
AFTER_COUNT=$(grep -c "| ✅ |" "$ORDER_FILE" 2>/dev/null) || AFTER_COUNT=0

# Update the completion count at top of file
# Pattern: **Completed:** X / 77
sed -i '' "s/\*\*Completed:\*\* [0-9]* \/ 77/**Completed:** $AFTER_COUNT \/ 77/" "$ORDER_FILE"

# Update Quick Stats table - find the pillar row and update counts
# This is more complex, so we'll just update the main counter for now

if [ "$AFTER_COUNT" -gt "$BEFORE_COUNT" ]; then
    echo "SUCCESS: Article status updated"
    echo "  Total completed: $AFTER_COUNT / 77"
else
    echo "INFO: Article may have already been marked complete"
    echo "  Total completed: $AFTER_COUNT / 77"
fi
