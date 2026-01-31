# HushAway® Keyword Library

This file tracks all validated keywords across articles. The `/keyword-research` skill references this for learning and to identify opportunities.

**Updated after each article's keyword validation.**

---

## Validated Hub Keywords (V3.1 Schema)

**Note:** Legacy ADHD Apps pillar discarded (2026-01-31). New 8-pillar structure validated via DataForSEO.

| Article | Pillar | Target Keyword | Volume | Difficulty | Intent | Trend | Score | Priority | Date |
|---------|--------|----------------|--------|------------|--------|-------|-------|----------|------|
| HUB: Sleep & Bedtime | 1 | ADHD sleep | 2,400 | 5 | crisis | stable | 400 | 5 | 2026-01-31 |
| HUB: Meltdowns | 2 | autistic meltdown | 3,600 | 10 | crisis | stable | 450 | 5 | 2026-01-31 |
| HUB: Emotional Regulation | 3 | emotional dysregulation | 9,900 | 42 | info-product | rising | 457 | 4 | 2026-01-31 |
| HUB: Transitions & Routines | 4 | autism routine | 390 | 12 | info-product | stable | 35 | 4 | 2026-01-31 |
| HUB: Focus & Concentration | 5 | ADHD focus | 260 | 16 | info-product | stable | 20 | 3 | 2026-01-31 |
| HUB: Sensory Processing | 6 | sensory overload | 3,600 | 46 | crisis | stable | 161 | 4 | 2026-01-31 |
| HUB: Sound Therapy | 7 | sound therapy | 1,600 | 41 | info-product | stable | 63 | 3 | 2026-01-31 |
| HUB: Comparisons | 8 | calm apps | 4,400 | 47 | commercial | stable | 193 | 3 | 2026-01-31 |

---

## Keyword Clusters (for internal linking)

As this library grows, related keywords will be grouped for cross-linking opportunities.

| Cluster Theme | Related Pillars | Linking Opportunities |
|---------------|-----------------|----------------------|
| Sleep Crisis | P1 + P2 | Cross-link bedtime meltdowns, racing thoughts, sensory bedroom |
| Meltdown Recovery | P2 + P6 | Cross-link sensory triggers, after-meltdown recovery |
| Emotional + Sensory | P3 + P6 | Cross-link overstimulation, emotional dysregulation |
| Morning Battles | P1 + P4 | Cross-link morning routines, time blindness, school refusal |
| Focus + Sound | P5 + P7 | Cross-link background noise, binaural beats, focus strategies |
| Sensory Foundation | P6 + All | Sensory processing links to all use-case pillars |
| Product Positioning | P7 + P8 | Cross-link sound therapy benefits with app comparisons |

---

## Gaps Identified

Keywords discovered during research that aren't yet targeted:

| Keyword | Est. Volume | Potential Article | Notes |
|---------|-------------|-------------------|-------|
| ADHD apps that actually work UK | 200-400 | Could be 5.1 or standalone | Long-tail with high intent |
| sound apps for ADHD kids | 300-500 | Pillar 4 or 5 cluster | Direct HushAway opportunity |
| calming apps for ADHD children | 400-700 | Pillar 3 or 5 cluster | Overlaps anxiety + ADHD |
| apps for ADHD children waiting for CAMHS | 100-200 | Pillar 7 or blog post | Very specific UK pain point |
| visual planner apps ADHD kids | 300-500 | 5.2 or standalone | Tiimo/Thruday specific, high intent |
| apps that work for ADHD children UK | 200-400 | Could support any Pillar 5 | UK-specific, solution-seeking intent |
| Class Charts ADHD reasonable adjustments | 200-400 | 5.4 or Pillar 7 | High intent, school advocacy angle |
| passive calming apps ADHD | 100-300 | Pillar 4 or 5 | Direct HushAway positioning opportunity |

### What Qualifies as a "Gap"?

A gap is a keyword that:
1. Has meaningful search volume (200+ monthly)
2. Is relevant to HushAway®'s audience (parents of neurodivergent children)
3. Is NOT already covered by existing or planned articles
4. Could support a future article or content update

### When to Add Gaps

Add to this table when you discover:
- High-volume keywords that don't fit current article scope
- Long-tail variations worth separate articles
- Competitor keywords we're not targeting
- Questions from "People Also Ask" that deserve full coverage

### How Gaps Inform Planning

When planning the next content batch:
1. Review this table for high-potential keywords
2. Prioritise gaps that cluster with existing content
3. Use gaps to inform new pillar/cluster decisions
4. Delete gaps once they're assigned to planned articles

---

## How to Use This File

### For the /keyword-research skill:
1. READ "Validated Keywords" table before validating new keywords
2. CHECK for clustering opportunities with existing keywords
3. NOTE any keyword gaps discovered during research
4. OUTPUT instruction to add validated keyword to this library

### After keyword validation:
1. Add new row to the "Validated Keywords" table (all 6 columns required)
2. Update "Keyword Clusters" if new cross-pillar linking opportunities emerge
3. Add any gaps discovered to the "Gaps Identified" table
4. Run the Keyword Gate to verify validation complete

---

## Perplexity Data Requirements

All validated keywords MUST come from Perplexity MCP research:

| Data Point | Source | Required |
|------------|--------|----------|
| Target Keyword | Perplexity Query 1 | Yes |
| Search Volume | Perplexity Query 1 (estimate) | Yes |
| Search Trend | Perplexity Query 1 | Recommended |
| Secondary Keywords | Perplexity Query 1 + 6 Circles | Yes (5+) |
| PAA Questions | Perplexity Query 2 | Yes (7+) |
| Competitor Gaps | Perplexity Query 3 | Yes (2+) |
| Research Sources | Perplexity Query 4 | Yes (2+) |

**Gate 1 (Keyword Gate) verifies:**
- `perplexityUsed: true` in research file
- `perplexityDate` is documented
- All minimum thresholds met

---

## V3.1 Schema (Current)

The V3.1 keyword validation system is active (updated 2026-01-31).

| Field | Description |
|-------|-------------|
| Volume | Exact monthly searches from DataForSEO |
| Difficulty | 0-100 keyword difficulty score |
| Intent | transactional/commercial/**crisis**/informational-product/informational |
| Trend | rising/stable/declining |
| Score | Opportunity score (15+ to pass) |
| Priority | 1-5 rank (5 = write this week) |

**V3.1 Changes:**
- Added **crisis intent** (2.5x multiplier, 100 floor) for urgent parenting searches
- Lowered informational floor from 500 to **200**
- Increased informational multiplier from 1.0 to **1.5**
- Removed hub volume threshold (hubs now set by pillar strategy, not volume)

**V3.1 Features:**
- Both DataForSEO AND Perplexity are mandatory
- Intent-tiered volume floors (50/100/200)
- Crisis signals: won't sleep, meltdown, can't calm, help my child
- Automatic opportunity scoring
- Pre-API brand alignment checks
- Rejected keyword tracking in `.claude/rejected-keywords.md`
- Negative keyword blocking in `.claude/negative-keywords.md`

**Gate Script:** Use `check-keyword-gate-v3.sh` for V3.1 validation.

---

## Archive Notes

This file persists across article batches. When a batch is archived:
- Keep this file (valuable SEO data)
- Keywords from archived articles remain as reference
- Clusters help identify future content opportunities
- Gaps inform next batch planning
