# Keyword Research Context V3 (HushAway)

**Skill:** /keyword-research
**Gate:** Keyword Gate V3 (check-keyword-gate-v3.sh)
**Spec:** KEYWORD-VALIDATION-SYSTEM-V2.md

---

## Purpose

This file provides **HushAway-specific context** that SUPPLEMENTS the main skill.

**Do NOT re-read specs already in SKILL.md or KEYWORD-VALIDATION-SYSTEM-V2.md.** This file contains ONLY:
- Library file locations for HushAway workflow
- V3 changes summary (what's different from V1)
- Quick reference for most common failures
- HushAway-specific thresholds (if different from spec)

**For full V3 specifications:** Read `KEYWORD-VALIDATION-SYSTEM-V2.md`

---

## V3.1 Changes from V1

| Feature | V1 | V3.1 |
|---------|----|----|
| DataForSEO | Optional (graceful fallback) | **MANDATORY** |
| Volume floors | None | Intent-tiered (50/100/200) |
| Crisis intent | N/A | **NEW: 2.5x multiplier, 100 floor** |
| Informational floor | N/A | **Lowered: 500 → 200** |
| Hub threshold | Volume >= 3000 | **Removed: Set explicitly via pillar strategy** |
| Opportunity scoring | None | Formula with 15+ threshold |
| Pre-API filters | None | Brand alignment, negative/rejected keywords |
| Libraries | keyword-library.md only | + negative-keywords.md, rejected-keywords.md |
| Frontmatter fields | ~15 | ~40 |

---

## Phase 0: Pre-Validation (Before API Calls)

Check BEFORE making any API calls:

1. **Negative keywords:** `.claude/negative-keywords.md`
   - Brand conflicts (cure, fix, normal, suffering)
   - Medical overreach (medication, diagnosis, prescription)
   - Off-topic (adult ADHD, workplace)
   - If match: STOP, do not proceed

2. **Rejected keywords:** `.claude/rejected-keywords.md`
   - Previously failed validation
   - Check revisit classification
   - If "Never" or "No": STOP

3. **Brand alignment patterns:**
   - Deficit language
   - Harmful practices
   - If pattern match: STOP, add to negative keywords

---

## API Requirements (Both MANDATORY)

### DataForSEO (Run First)

Query 1: Search Volume + Difficulty
- Location: 2826 (UK)
- Returns: Exact volume, difficulty 0-100, CPC

Query 2: Related Keywords
- Limit: 30
- Returns: Related keywords with volumes

**If API fails:** Retry 3x with backoff. If still fails, keyword cannot be validated.

### Perplexity MCP (Run Second)

Query 1: Keyword Validation + Trends
Query 2: PAA Discovery (7+ questions)
Query 3: Competitor SERP Analysis
Query 4: Research Source Discovery

**Both APIs must succeed** for keyword to pass validation.

---

## V3.1 Classifications Required

| Classification | Values |
|----------------|--------|
| searchIntent | transactional, commercial, **crisis**, informational-product, informational |
| trendDirection | rising, stable, declining |
| articleType | hub, cluster |
| journeyStage | awareness, consideration, decision, retention |
| pillarAssignment | Pillar N: Name |
| crossPillarOpportunity | true/false |

**Crisis Intent Signals (V3.1):**
- Time urgency: won't sleep, can't calm, nothing works, desperate
- Emotional urgency: meltdown, breakdown, overwhelmed, exhausted
- Action urgency: help my child, how to stop, what do I do

---

## V3 Scores Required

| Score | Threshold | Formula |
|-------|-----------|---------|
| opportunityScore | 15+ | (Vol x Intent x Trend) / (EffDiff + 10) + Snippet |
| differentiationScore | 5+ (7+ for hubs) | Gap-based scoring |
| competitiveMoatScore | 4+ recommended | Defensibility factors |
| priorityRank | 1-5 | Based on score and tier |

---

## V3.1 Hard Gates (Must Pass)

**Core 7 gates shown below. Full 14 gates in `KEYWORD-VALIDATION-SYSTEM-V2.md` Section 3.**

| Gate | Threshold |
|------|-----------|
| Volume | Intent-tiered floor (50/100/200) |
| Opportunity Score | 15+ |
| PAA Questions | 7+ |
| Competitor Gaps | 2+ |
| Research Sources | 2+ |
| Differentiation | 5+ (7+ for hubs if difficulty > 40) |
| Trend + Score Combo | If declining, score must be 25+ |

**V3.1 Volume Floor by Intent:**
- Transactional: 50
- Commercial: 100
- Crisis: 100 (NEW)
- Info + Product: 200
- Info General: 200 (was 500)

**Additional gates (see spec):** DataForSEO data, Perplexity data, content type compatibility, brand alignment, negative keyword check, rejected keyword check, pillar assignment.

---

## V3 Output Requirements

Research file frontmatter must include ALL V3 fields:

```yaml
# Tool Usage (BOTH MANDATORY)
perplexityUsed: true
dataforSeoUsed: true

# Core Metrics
targetKeyword: "[keyword]"
searchVolume: [exact number]
keywordDifficulty: [0-100]

# Classifications
searchIntent: [type]
trendDirection: [direction]
articleType: [hub/cluster]
pillarAssignment: "[Pillar N: Name]"
journeyStage: [stage]

# Scores
opportunityScore: [calculated]
differentiationScore: [0-15+]
competitiveMoatScore: [0-10]
priorityRank: [1-5]

# Validation
keywordVerdict: GO
validationDate: "[YYYY-MM-DD]"

# Required Data
secondaryKeywords: [5+ with volumes]
paaQuestions: [7+ with intent]
competitorGaps: [2+]
researchSources: [2+ with URLs]
```

---

## After Skill Completes

1. **Run V3 gate script:**
   ```bash
   .claude/scripts/check-keyword-gate-v3.sh [research-file]
   ```

2. **If PASS:** Library auto-updated via update-keyword-library.sh
3. **If FAIL:** Keyword logged to rejected-keywords.md

---

## Common V3 Failures

- DataForSEO not used (mandatory in V3)
- Volume below intent-tiered floor
- Opportunity score below 15
- Differentiation too low for difficulty level
- Declining trend with marginal score
- Brand conflict pattern detected
- Previously rejected keyword
