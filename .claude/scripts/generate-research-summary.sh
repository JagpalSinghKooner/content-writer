#!/bin/bash
# ============================================================================
# GENERATE RESEARCH SUMMARY - Extracts key data for skills to read
# ============================================================================
# Usage: ./generate-research-summary.sh <research-file>
# Example: ./generate-research-summary.sh research/pillar-5-adhd-apps/5.1-focus-apps-research.md
#
# This script extracts key data from a research file and writes a compact
# summary to .claude/scratchpad/research-summary.md
#
# Skills should read the summary instead of the full research file to
# reduce context window usage.
#
# Run this script after Research Gate passes.
# ============================================================================

RESEARCH_FILE="$1"
OUTPUT_FILE=".claude/scratchpad/research-summary.md"

if [ -z "$RESEARCH_FILE" ]; then
    echo "============================================================================"
    echo "GENERATE RESEARCH SUMMARY"
    echo "============================================================================"
    echo ""
    echo "Usage: ./generate-research-summary.sh <research-file>"
    echo ""
    echo "Example:"
    echo "  ./generate-research-summary.sh research/pillar-5-adhd-apps/5.1-focus-apps-research.md"
    echo ""
    echo "This script extracts key data from the research file and writes"
    echo "a compact summary for skills to read instead of the full file."
    echo ""
    exit 1
fi

if [ ! -f "$RESEARCH_FILE" ]; then
    echo "ERROR: Research file not found: $RESEARCH_FILE"
    exit 1
fi

# Ensure output directory exists
mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "Extracting research summary from: $RESEARCH_FILE"

# --- Extract frontmatter data ---

# Article info
ARTICLE_TITLE=$(grep "^articleTitle:" "$RESEARCH_FILE" | sed 's/articleTitle:[[:space:]]*//' | tr -d '"')
ARTICLE_NUMBER=$(grep "^articleNumber:" "$RESEARCH_FILE" | sed 's/articleNumber:[[:space:]]*//' | tr -d '"')
PILLAR_NAME=$(grep "^pillarName:" "$RESEARCH_FILE" | sed 's/pillarName:[[:space:]]*//' | tr -d '"')

# Keywords
TARGET_KEYWORD=$(grep "^targetKeyword:" "$RESEARCH_FILE" | sed 's/targetKeyword:[[:space:]]*//' | tr -d '"')
SEARCH_VOLUME=$(grep "^searchVolume:" "$RESEARCH_FILE" | sed 's/searchVolume:[[:space:]]*//' | tr -d '"')

# Extract secondary keywords (lines starting with "  - " after "secondaryKeywords:")
SECONDARY_KEYWORDS=$(awk '/^secondaryKeywords:/{flag=1; next} /^[a-zA-Z#]/{flag=0} flag && /^  - /{gsub(/^  - /, ""); gsub(/"/, ""); print "- " $0}' "$RESEARCH_FILE")

# Angle info
SELECTED_ANGLE=$(grep "^selectedAngle:" "$RESEARCH_FILE" | sed 's/selectedAngle:[[:space:]]*//' | tr -d '"')
ANGLE_DESCRIPTION=$(grep "^angleDescription:" "$RESEARCH_FILE" | sed 's/angleDescription:[[:space:]]*//' | tr -d '"')
HEADLINE_DIRECTION=$(grep "^headlineDirection:" "$RESEARCH_FILE" | sed 's/headlineDirection:[[:space:]]*//' | tr -d '"')

# Extract competitor gaps
COMPETITOR_GAPS=$(awk '/^competitorGaps:/{flag=1; next} /^[a-zA-Z#]/{flag=0} flag && /^  - /{gsub(/^  - /, ""); gsub(/"/, ""); print "- " $0}' "$RESEARCH_FILE")

# Extract PAA questions
PAA_QUESTIONS=$(awk '/^paaQuestions:/{flag=1; next} /^[a-zA-Z#]/{flag=0} flag && /^  - /{gsub(/^  - /, ""); gsub(/"/, ""); print "- " $0}' "$RESEARCH_FILE" | head -5)

# Extract research sources with findings
RESEARCH_SOURCES=$(awk '
/^researchSources:/{flag=1; next}
/^[a-zA-Z#]/{flag=0}
flag && /^  - source:/{gsub(/^  - source:/, ""); gsub(/"/, ""); source=$0}
flag && /^    year:/{gsub(/^    year:/, ""); gsub(/"/, ""); year=$0}
flag && /^    finding:/{gsub(/^    finding:/, ""); gsub(/"/, ""); finding=$0; print "| " source " | " year " | " finding " |"}
' "$RESEARCH_FILE" | head -4)

# --- Extract E-E-A-T citations based on pillar ---
EEAT_LIBRARY="research/eeat-library.md"
PILLAR_NUM=$(echo "$RESEARCH_FILE" | grep -oE 'pillar-[0-9]+' | grep -oE '[0-9]+')

# Function to extract citations from a section
extract_section_citations() {
    local section_name="$1"
    local library="$2"
    # Extract the "How to Cite (Warm)" column from tables in the section
    awk -v section="$section_name" '
    $0 ~ "## " section {found=1; next}
    found && /^## / {found=0}
    found && /^\|.*\|.*\|.*\|.*\|.*\|$/ && !/Statistic.*Source.*Year/ && !/---/ {
        # Split by | and get last column (How to Cite)
        n = split($0, cols, "|")
        if (n >= 6) {
            cite = cols[6]
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", cite)
            if (cite != "" && cite !~ /How to Cite/) {
                print "- " cite
            }
        }
    }
    ' "$library"
}

EEAT_CITATIONS=""

if [ -f "$EEAT_LIBRARY" ]; then
    case "$PILLAR_NUM" in
        1)
            # ADHD Sleep → Sleep Problems + UK Stats
            EEAT_CITATIONS=$(extract_section_citations "Sleep Problems in ADHD Children" "$EEAT_LIBRARY")
            EEAT_CITATIONS="$EEAT_CITATIONS"$'\n'"$(extract_section_citations "UK-Specific Statistics" "$EEAT_LIBRARY" | head -2)"
            ;;
        5)
            # ADHD Apps → Parenting Stress (apps help with focus/stress) + UK Stats
            EEAT_CITATIONS=$(extract_section_citations "Parenting Stress and Mental Health" "$EEAT_LIBRARY" | head -3)
            EEAT_CITATIONS="$EEAT_CITATIONS"$'\n'"$(extract_section_citations "UK-Specific Statistics" "$EEAT_LIBRARY" | head -2)"
            ;;
        7)
            # Neurodivergent Parenting → Parenting Stress + Caregiver Burnout + UK Stats
            EEAT_CITATIONS=$(extract_section_citations "Parenting Stress and Mental Health" "$EEAT_LIBRARY" | head -2)
            EEAT_CITATIONS="$EEAT_CITATIONS"$'\n'"$(extract_section_citations "Caregiver Burnout" "$EEAT_LIBRARY" | head -2)"
            EEAT_CITATIONS="$EEAT_CITATIONS"$'\n'"$(extract_section_citations "UK-Specific Statistics" "$EEAT_LIBRARY" | head -2)"
            ;;
        *)
            # Default: UK Stats + General Parenting
            EEAT_CITATIONS=$(extract_section_citations "Parenting Stress and Mental Health" "$EEAT_LIBRARY" | head -2)
            EEAT_CITATIONS="$EEAT_CITATIONS"$'\n'"$(extract_section_citations "UK-Specific Statistics" "$EEAT_LIBRARY" | head -2)"
            ;;
    esac
fi

# Clean up empty lines from citations
EEAT_CITATIONS=$(echo "$EEAT_CITATIONS" | grep -v '^$' | head -6)

# --- Generate summary file ---

cat > "$OUTPUT_FILE" << EOF
# Research Summary (Auto-Generated)

**Article:** $ARTICLE_NUMBER - $ARTICLE_TITLE
**Pillar:** $PILLAR_NAME
**Generated:** $(date +%Y-%m-%d)

---

## Keywords

**Target:** $TARGET_KEYWORD
**Volume:** $SEARCH_VOLUME

**Secondary Keywords:**
$SECONDARY_KEYWORDS

---

## Positioning

**Angle:** $SELECTED_ANGLE
**Core Insight:** $ANGLE_DESCRIPTION
**Headline Direction:** $HEADLINE_DIRECTION

---

## Key Stats for Citations (From Research)

| Source | Year | Finding |
|--------|------|---------|
$RESEARCH_SOURCES

---

## E-E-A-T Citations (Auto-Pulled from Library)

**Use these pre-formatted citations in the article:**

$EEAT_CITATIONS

---

## Competitor Gaps (for HushAway positioning)

$COMPETITOR_GAPS

---

## PAA Questions to Address

$PAA_QUESTIONS

---

*Full research file: $RESEARCH_FILE*
EOF

echo ""
echo "============================================================================"
echo "SUMMARY GENERATED"
echo "============================================================================"
echo "Output: $OUTPUT_FILE"
echo ""
echo "Skills should now read $OUTPUT_FILE instead of the full research file."
echo ""

# Show summary stats
SUMMARY_LINES=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')
RESEARCH_LINES=$(wc -l < "$RESEARCH_FILE" | tr -d ' ')
REDUCTION=$(( 100 - (SUMMARY_LINES * 100 / RESEARCH_LINES) ))

echo "Research file: $RESEARCH_LINES lines"
echo "Summary file: $SUMMARY_LINES lines"
echo "Reduction: ${REDUCTION}%"
echo ""
