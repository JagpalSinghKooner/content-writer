# Validation Checkpoints

Content validation happens at specific points in the workflow. Some checkpoints are automatic (run every time), others are manual (run on request).

- **Post-draft** (Automatic): After `/seo-content`, validate full article against universal rules
- **Post-enhancement** (Automatic): After `/direct-response-copy`, validate full article + brand voice alignment
- **Pre-publish** (Automatic): Before changing status to "published", run final validation (all checks)
- **Batch review** (Manual): After pillar complete, review all pillar articles for cross-article consistency
- **Spot check** (Manual): When issues suspected, validate specific content on request

## Automatic Checkpoints

These run without being asked:
- **Post-draft:** Catches AI fingerprints and rule violations early, before enhancement work
- **Post-enhancement:** Ensures direct-response-copy changes didn't introduce issues
- **Pre-publish:** Final gate before content goes live

## Manual Checkpoints

These run when explicitly requested:
- **Batch review:** After completing a pillar, review all articles together for consistency, contradictions, and cross-linking
- **Spot check:** When client feedback suggests issues, when revisiting old content, or when quality is questioned
