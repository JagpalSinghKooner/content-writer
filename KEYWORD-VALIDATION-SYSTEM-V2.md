# Keyword Validation Rules V3

**Purpose:** Executable rules for keyword validation. Implementation guidance and tracking are in [implementation-keywords.md](implementation-keywords.md).

**Status:** PRODUCTION READY

**Key Features:**
- Both Perplexity MCP AND DataForSEO are MANDATORY
- Pre-API brand alignment gate (saves costs)
- Intent-tiered volume floors (50/100/200)
- **Crisis intent type** for urgent parenting searches (V3.1)
- Opportunity score threshold (15+)
- Differentiation gates for competitive keywords

---

## Quick Reference

### Volume Floors (Intent-Tiered)
- Transactional: 50
- Commercial: 100
- **Crisis: 100** (V3.1)
- Info + Product: 200
- Info General: **200** (V3.1 - lowered from 500)

### Hard Gates
- Volume: Intent-tiered floor
- Score: 15+
- PAA: 7+
- Gaps: 2+
- Sources: 2+
- Differentiation: 5+ (7+ for hubs)

### Priority Modifiers
See [implementation-keywords.md](implementation-keywords.md#phase-4-priority-modifiers) for full modifier system (NOT YET IMPLEMENTED in gate script).

### Difficulty Tiers
- Easy (0-30): 2-4 months
- Medium (31-50): 4-6 months
- Hard (51-70): 6-12 months
- Very Hard (71+): 12-18+ months

---

## Table of Contents

### Core System
1. [Tool Requirements](#1-tool-requirements)
2. [Pre-Validation Filters](#2-pre-validation-filters)
3. [Hard Gate Thresholds](#3-hard-gate-thresholds)
4. [Opportunity Score Formula](#4-opportunity-score-formula)
5. [Search Intent Classification](#5-search-intent-classification)
6. [Difficulty Tiers](#6-difficulty-tiers)

### SERP Intelligence
7. [Competitor Authority Assessment](#7-competitor-authority-assessment)
8. [SERP Feature Analysis](#8-serp-feature-analysis)

### Content & Clustering
9. [Keyword Clustering Rules](#9-keyword-clustering-rules)
10. [Content Differentiation Score](#10-content-differentiation-score)
11. [Competitive Moat Assessment](#11-competitive-moat-assessment)

### Special Cases
12. [Question Keyword Handling](#12-question-keyword-handling)
13. [Zero-Volume Keyword Handling](#13-zero-volume-keyword-handling)
14. [Trend Direction Gate](#14-trend-direction-gate)

### Priority & Libraries
15. [Publish Priority System](#15-publish-priority-system)
16. [Negative Keyword Library](#16-negative-keyword-library)
17. [Rejected Keyword Library](#17-rejected-keyword-library)

### Output Specifications
18. [Frontmatter Specification](#18-frontmatter-specification)
19. [Verdict Output Format](#19-verdict-output-format)

---

## 1. Tool Requirements

| Tool | Status | What It Provides | If Unavailable |
|------|--------|------------------|----------------|
| **Perplexity MCP** | MANDATORY | PAA questions, trends, competitor analysis, SERP features, AI overview presence, research sources | FAIL validation |
| **DataForSEO API** | MANDATORY | Exact search volumes, keyword difficulty scores (0-100), CPC, related keywords | FAIL validation |

**Both tools must return valid data for a keyword to pass validation.**

---

## 2. Pre-Validation Filters

**Purpose:** Reject unsuitable keywords BEFORE making API calls to save cost and time.

### Brand Alignment Check

```yaml
brandAlignmentCheck:
  hardReject:
    deficitLanguage:
      - "cure"
      - "fix"
      - "treat"
      - "disorder"
      - "normal"
      - "suffering from"
      - "special needs"

    medicalImplication:
      - "treatment"
      - "therapy"
      - "clinical"
      - "diagnosis"
      - "medication"
      - "prescription"

    harmfulPractices:
      - "punishment"
      - "force"
      - "make them"
      - "discipline"
      - "consequences"

  softWarn:
    - Keywords requiring careful framing
    - Topics on boundary of medical advice

  action:
    ifHardReject: REJECT immediately, log to negative keywords
    ifSoftWarn: FLAG for review, proceed with caution
```

### Other Pre-Validation Checks

| Check | Action if Fail |
|-------|----------------|
| Negative keyword library lookup | REJECT - permanently blocked |
| Rejected keyword library lookup | REJECT - previously researched and rejected |
| Pillar relevance check | WARN - orphan content risk |
| Format validation (not a sentence) | REJECT - not a valid keyword |

---

## 3. Hard Gate Thresholds

These are non-negotiable. Fail ANY = keyword rejected.

### Hard Gates

| Criterion | Threshold | Rejection Message |
|-----------|-----------|-------------------|
| DataForSEO Data | Must have volume + difficulty | "DataForSEO required - no fallback" |
| Perplexity Data | Must have PAA + gaps + sources | "Perplexity MCP required - no fallback" |
| **Volume Floor** | **Intent-tiered (see below)** | "Volume too low for [intent] type" |
| Opportunity Score | 15+ | "Opportunity score too low (<15)" |
| PAA Questions | 7+ | "Insufficient PAA questions (<7)" |
| Competitor Gaps | 2+ | "Insufficient competitor gaps (<2)" |
| Research Sources | 2+ with URLs | "Insufficient research sources (<2)" |
| Differentiation Score | 5+ if difficulty > 40; 7+ for hubs | "Low differentiation for competitive keyword" |
| Trend + Score Combo | If declining, score must be 25+ | "Declining trend with marginal score" |
| Content Type | Not shopping/video dominant | "SERP format incompatible with text content" |

### Intent-Tiered Volume Floors

| Search Intent | Minimum Volume | Rationale |
|---------------|----------------|-----------|
| Transactional | 50 | High conversion compensates for low volume |
| Commercial Investigation | 100 | Comparison shoppers convert well |
| **Crisis (V3.1)** | **100** | **Urgent parenting searches have high engagement** |
| Informational + Product Fit | 200 | Need volume to justify effort |
| Informational General | **200** | **Lowered from 500 - education-first strategy** |

### Soft Gates (Warnings, Not Rejections)

| Criterion | Threshold | Warning Message |
|-----------|-----------|-----------------|
| Cannibalization Risk | Similar keyword exists | "Potential overlap with [Article] - review required" |
| Validation Freshness | > 90 days since validation | "Stale validation - re-run before writing" |
| SERP CTR Risk | High feature saturation | "Low CTR expected - featured snippet dominates" |
| Competitor Authority | 3+ top results DA 70+ | "High-authority SERP - timeline extended" |
| AI Overview Present | AI overview in SERP | "AEO optimisation required - structure for extraction" |
| Video Dominant | 50%+ video results | "Consider video companion content" |
| No Hub Exists | Cluster with no parent hub | "Hub-first strategy recommended" |
| Low Moat Score | Moat < 4 | "Expect competition catch-up - plan updates" |

---

## 4. Opportunity Score Formula

### Base Formula

```
Opportunity Score = (Volume × Intent Multiplier × Trend Multiplier) / (Effective Difficulty + 10) + Snippet Bonus
```

### Intent Multipliers

| Search Intent | Multiplier | CPC Validation |
|---------------|------------|----------------|
| Transactional | 3.0 | Confirmed if CPC > £2.00 |
| Commercial Investigation | 2.5 | Confirmed if CPC > £0.50 |
| **Crisis (V3.1)** | **2.5** | **N/A - urgency signals override CPC** |
| Informational + Product Fit | 2.0 | N/A |
| Informational General | **1.5** | **Raised from 1.0 - education-first strategy** |

### Trend Multipliers

| Trend Direction | Multiplier |
|-----------------|------------|
| Rising | 1.2 |
| Stable | 1.0 |
| Declining | 0.7 |

### Effective Difficulty

```
Effective Difficulty = DataForSEO KD + Authority Adjustment + Difficulty Trend Adjustment

Authority Adjustment:
- 3+ of top 5 results are DA 70+ = +20
- 2 of top 5 results are DA 70+ = +10
- 1 or fewer DA 70+ = +0
- Mostly DA <30 = -5 (floor at original KD)

Difficulty Trend Adjustment:
- KD increased 10+ points in 6 months = +5 (hardening)
- KD decreased 10+ points = -5 (softening)
- Stable = +0
```

### Snippet Bonus (SERP Opportunity)

```yaml
snippetBonus:
  featuredSnippetType:
    paragraph: +3 (if we can answer in 40-60 words)
    list: +2 (if content has clear steps)
    table: +2 (if comparison content fits)
    none: 0

  currentSnippetHolder:
    weak_domain: +2 (DA <40)
    outdated_content: +2 (>2 years old)
    poor_format: +1 (doesn't match snippet type well)
    strong_holder: 0 (NHS, major authority)

  # Total snippet bonus: 0 to +7
```

### Example Calculations

| Keyword | Vol | KD | Auth | Eff Diff | Intent | Trend | Snippet | Score | Verdict |
|---------|-----|----|----- |----------|--------|-------|---------|------:|---------|
| ADHD apps | 25,000 | 65 | +20 | 85 | Comm (2.5) | Stable | +0 | 658 | GO (Hard) |
| ADHD apps emotional regulation UK | 500 | 25 | +0 | 25 | Comm (2.5) | Rising | +5 | 47.8 | GO (Easy) |
| focus apps ADHD UK | 300 | 20 | +0 | 20 | Comm (2.5) | Stable | +3 | 28.0 | GO (Easy) |
| ADHD help free app | 80 | 15 | +0 | 15 | Trans (3.0) | Stable | +2 | 11.6 | GO (Trans floor 50) |
| declining topic | 400 | 30 | +0 | 30 | Info+Prod (2.0) | Declining | +0 | 14.0 | REJECT |

---

## 5. Search Intent Classification

### Classification Rules

```yaml
intentClassification:
  transactional:
    signals:
      keywords:
        - "buy"
        - "download"
        - "get"
        - "try"
        - "free"
        - "price"
        - "cost"
        - "sign up"
      patterns:
        - "[product] + [action word]"
        - "free [product]"
    examples:
      - "download ADHD app"
      - "free focus app"
      - "try HushAway"
    multiplier: 3.0
    volumeFloor: 50
    cpcValidation: "> £2.00 confirms"

  commercial:
    signals:
      keywords:
        - "best"
        - "top"
        - "review"
        - "vs"
        - "alternative"
        - "comparison"
        - "recommended"
      patterns:
        - "[product type] for [use case]"
        - "best [product] for [audience]"
        - "[product] vs [product]"
    examples:
      - "best ADHD apps UK"
      - "focus apps vs medication"
      - "ADHD apps for emotional regulation"
    multiplier: 2.5
    volumeFloor: 100
    cpcValidation: "> £0.50 confirms"

  # V3.1: NEW intent type for urgent parenting searches
  crisis:
    signals:
      keywords:
        timeUrgency:
          - "won't sleep"
          - "can't sleep"
          - "won't calm"
          - "can't calm"
          - "nothing works"
          - "desperate"
          - "urgent"
        emotionalUrgency:
          - "meltdown"
          - "breakdown"
          - "overwhelmed"
          - "exhausted"
          - "struggling"
        actionUrgency:
          - "help my child"
          - "how to stop"
          - "what do i do"
          - "what to do when"
      patterns:
        - Urgent need, distressed parent searching
        - 3am searches, crisis moments
        - Seeking immediate help/validation
    examples:
      - "ADHD child won't sleep"
      - "autistic meltdown what to do"
      - "help my child is overwhelmed"
      - "nothing works for my ADHD child"
    multiplier: 2.5
    volumeFloor: 100
    cpcValidation: "N/A - urgency signals override CPC"
    note: "Check crisis signals BEFORE other intent types"

  informational_product:
    signals:
      keywords:
        - "how to"
        - "help"
        - "what helps"
        - "strategies"
        - "tips"
      patterns:
        - Question format where HushAway solves the problem
        - Pain point + solution seeking
    examples:
      - "how to help ADHD child focus"
      - "why won't my child sleep"
      - "calm ADHD meltdown"
    multiplier: 2.0
    volumeFloor: 200
    cpcValidation: "N/A"

  informational_general:
    signals:
      keywords:
        - "what is"
        - "definition"
        - "signs of"
        - "symptoms"
      patterns:
        - Pure education, no product angle
        - Definition/explanation queries
    examples:
      - "what is ADHD"
      - "signs of autism in toddlers"
      - "sensory processing disorder explained"
    multiplier: 1.5  # V3.1: Raised from 1.0 - education-first strategy
    volumeFloor: 200  # V3.1: Lowered from 500 - long-tail cluster protection
    cpcValidation: "Question if CPC > £1.00"
```

### CPC Intent Validation

```yaml
cpcValidation:
  purpose: "Google advertisers have validated commercial viability"

  interpretation:
    highCpc: "> £2.00 → Confirms transactional/commercial intent"
    mediumCpc: "£0.50-£2.00 → Moderate commercial value"
    lowCpc: "< £0.50 → Likely informational"
    noCpc: "No advertisers → Pure informational or very niche"

  validation:
    rule: "If intent = commercial but CPC < £0.30"
    action: "WARN - Intent classification may be incorrect"
```

---

## 6. Difficulty Tiers

### Tier Classification

| Tier | Effective Difficulty | Timeline (No Links) | Timeline (With Links) | Est. Backlinks |
|------|---------------------|--------------------|-----------------------|----------------|
| **Easy** | 0-30 | 2-4 months | 1-2 months | 0-3 |
| **Medium** | 31-50 | 4-6 months | 2-4 months | 3-10 |
| **Hard** | 51-70 | 6-12 months | 4-6 months | 10-25 |
| **Very Hard** | 71+ | 12-18+ months | 6-12 months | 25+ |

**Timeline Modifiers:** See [implementation-keywords.md](implementation-keywords.md#phase-1-serp-analysis-critical) (NOT YET IMPLEMENTED).

---

## 7. Competitor Authority Assessment

**Authority Adjustment Values (used in Opportunity Score):**

| Top 5 Composition | Difficulty Adjustment |
|-------------------|----------------------:|
| 3+ DA 70+ sites | +20 |
| 2 DA 70+ sites | +10 |
| 1 or fewer DA 70+ | +0 |
| Mostly DA <30 | -5 (floor at KD) |

**Full detection system:** See [implementation-keywords.md](implementation-keywords.md#phase-1-serp-analysis-critical) (NOT YET AUTOMATED - skill applies manually).

---

## 8. SERP Feature Analysis

### Feature Reference

| Feature | CTR Impact | Opportunity |
|---------|------------|-------------|
| Featured Snippet | -20-30% to #1 | HIGH - capturable by new sites |
| Knowledge Panel | -15-25% | LOW - entity-based |
| Video Carousel | -10-20% | MEDIUM - if video possible |
| PAA (expanded) | -5-15% | HIGH - answer-based content |
| AI Overview | -20-40% | HIGH - citation opportunity |
| Shopping Results | -10-20% | N/A for informational |
| Local Pack | -15-25% | N/A for national content |

**SERP Opportunity Scoring (0-12):** See [implementation-keywords.md](implementation-keywords.md#phase-1-serp-analysis-critical) (NOT YET AUTOMATED).

---

## 9. Keyword Clustering Rules

### Same Article Criteria

```yaml
sameArticleCriteria:
  intentOverlap: "> 80%"
  serpOverlap: "> 60% (3+ shared results in top 5)"
  modifierRelationship: "One keyword is modifier of another"

  examples:
    - "ADHD apps" + "ADHD apps UK" → Same article (UK is modifier)
    - "focus apps ADHD" + "ADHD focus apps" → Same article (word reorder)
    - "best ADHD apps" + "top ADHD apps" → Same article (synonym)
```

### Separate Articles Criteria

```yaml
separateArticlesCriteria:
  differentIntents: "Commercial vs Informational"
  differentSerpCompositions: "Different top 5 results"
  differentContentRequired: "Answer requires fundamentally different content"

  examples:
    - "ADHD apps" vs "how to help ADHD child focus" → Separate (different intent)
    - "focus apps ADHD" vs "task management ADHD apps" → Separate (different topic)
```

### SERP Overlap Check

```yaml
serpOverlapCheck:
  method: "Compare top 5 results for candidate keywords via Perplexity"
  threshold: "3+ shared results = likely same article"

  process:
    1: "Query Perplexity for top 5 results of keyword A"
    2: "Query Perplexity for top 5 results of keyword B"
    3: "Count shared domains"
    4: "If 3+ shared → merge as primary + secondary"
```

---

## 10. Content Differentiation Score

### Gate Logic (ACTIVE)

```
IF differentiation_score < 5 AND effective_difficulty > 40:
    REJECT "Low differentiation for competitive keyword"

IF differentiation_score < 7 AND articleType = hub:
    REJECT "Hubs require differentiation score 7+"

IF differentiation_score < 5 AND effective_difficulty <= 40:
    WARN "Low differentiation - ensure strong execution"
    PROCEED with caution
```

### Differentiation Tiers

| Score | Classification | Gate Status |
|------:|----------------|-------------|
| 10+ | Strong | PASS - clear differentiation |
| 7-9 | Good | PASS (required for hubs) |
| 5-6 | Moderate | PASS (clusters only) |
| 3-4 | Weak | WARN - requires strong execution |
| 0-2 | None | REJECT if difficulty > 40 |

**Point breakdown for calculating score:** See [implementation-keywords.md](implementation-keywords.md#phase-2-semantic-analysis) (skill applies manually, NOT automated in gate).

---

## 11. Competitive Moat Assessment

### Warning Gate (ACTIVE)

| Moat Score | Gate Status |
|------------|-------------|
| 8-10 | Strong - ranking defensible |
| 5-7 | Moderate - maintain with updates |
| 0-4 | **WARN** - expect competition catch-up |

**Moat factor breakdown (0-10 scoring):** See [implementation-keywords.md](implementation-keywords.md#phase-2-semantic-analysis) (skill applies manually, NOT automated in gate).

---

## 12. Question Keyword Handling

### Question Types

```yaml
questionKeywordHandling:
  how_to:
    format: "Step-by-step guide"
    snippetTarget: "List/numbered steps"
    example: "How to help ADHD child sleep"
    structureGuidance: "Lead with numbered steps in H2"

  what_is:
    format: "Definition + explanation"
    snippetTarget: "Paragraph (40-50 words)"
    example: "What is sensory processing disorder"
    structureGuidance: "Lead with concise definition"

  why:
    format: "Cause-effect explanation"
    snippetTarget: "Paragraph with reasoning"
    example: "Why do ADHD children struggle with sleep"
    structureGuidance: "Lead with direct answer to why"

  which_best:
    format: "Comparison/recommendation"
    snippetTarget: "List or table"
    example: "Which apps are best for ADHD focus"
    structureGuidance: "Lead with top recommendation, then comparison"

  can_does:
    format: "Direct answer + elaboration"
    snippetTarget: "Paragraph, yes/no opener"
    example: "Can white noise help ADHD children sleep"
    structureGuidance: "Lead with yes/no, then explain"
```

### Question Keyword Bonus

```yaml
questionKeywordBonus:
  priorityBonus: "+0.5 rank"
  reason: "High featured snippet potential"
  requirement: "Structure content to match snippet format"
```

---

## 13. Zero-Volume Keyword Handling

### Zero-Volume Criteria

```yaml
zeroVolumeHandling:
  ifDataForSeoReturnsZero:
    check1:
      name: "Perplexity demand signals"
      test: "PAA questions exist? Forums discuss?"
      pass: "Real search activity confirmed"

    check2:
      name: "Related keyword volume"
      test: "Related keywords have volume?"
      pass: "Topic has proven demand"

    check3:
      name: "Commercial intent"
      test: "High intent? (transactional/commercial)"
      pass: "Buyers search specific terms"

  decision:
    ifAllThreePass:
      status: "Zero-volume viable"
      assignedVolume: 50
      priority: "Standard calculation applies"
      note: "Tool limitation - real demand confirmed"

    ifNotAllPass:
      status: "REJECT"
      reason: "Zero volume, no demand indicators"
```

---

## 14. Trend Direction Gate

### Trend Classification

```yaml
trendClassification:
  rising:
    signals:
      - "growing interest"
      - "trending upward"
      - "increasing searches"
    multiplier: 1.2
    priorityModifier: "+1 rank"

  stable:
    signals:
      - "consistent interest"
      - "stable searches"
      - "steady demand"
    multiplier: 1.0
    priorityModifier: "None"

  declining:
    signals:
      - "declining interest"
      - "decreasing searches"
      - "waning popularity"
    multiplier: 0.7
    priorityModifier: "-1 rank"
```

### Trend Gate Logic

```
IF trend = declining AND adjusted_score < 25:
    REJECT "Declining trend with marginal opportunity"

IF trend = declining AND adjusted_score >= 25:
    WARN "Declining trend - monitor before writing"
    PROCEED with lower priority
```

### Seasonal vs Declining

```yaml
seasonalDistinction:
  cyclical:
    pattern: "Same peaks each year"
    example: "ADHD back to school (Aug-Sept peak)"
    treatment: "Seasonal keyword, not declining"
    calculation: "Use peak volume for scoring"

  declining:
    pattern: "Consistent downward trend"
    example: "Topic interest peaked 2024, now falling"
    treatment: "Apply declining multiplier (0.7)"
```

---

## 15. Publish Priority System

### Priority Calculation (ACTIVE)

```
Base Priority Score = Opportunity Score / Tier Weight

Tier Weights:
- Easy (0-30): 1.0
- Medium (31-50): 1.5
- Hard (51-70): 2.0
- Very Hard (71+): 3.0
```

### Priority Ranks (ACTIVE)

| Rank | Criteria | Guidance |
|-----:|----------|----------|
| 5 | Priority Score 40+ AND Easy tier | Write this week |
| 4 | Priority Score 25-40 AND Easy tier | Write soon |
| 3 | Priority Score 25-40 AND Medium tier | Schedule normally |
| 2 | Priority Score 15-25 OR Hard tier | Lower priority |
| 1 | Priority Score 15-25 AND Hard tier | Strategic only |

**Priority Modifiers (15 total):** See [implementation-keywords.md](implementation-keywords.md#phase-4-priority-modifiers) (NOT YET IMPLEMENTED in gate script).

---

## 16. Negative Keyword Library

### Permanent Negatives

```yaml
permanentNegatives:
  brand_conflict:
    keywords:
      - "cure ADHD"
      - "fix autism"
      - "normal child"
      - "stop ADHD"
      - "get rid of ADHD"
    reason: "Deficit language - brand conflict"
    revisit: "Never"

  medical_overreach:
    keywords:
      - "ADHD medication"
      - "ADHD diagnosis"
      - "autism treatment"
      - "prescription for ADHD"
    reason: "Medical advice territory"
    revisit: "Never"

  off_topic:
    keywords:
      - "adult ADHD apps"
      - "ADHD workplace"
      - "teacher ADHD resources"
      - "ADHD school interventions"
    reason: "Not HushAway target audience"
    revisit: "Never"
```

### Temporary Negatives

```yaml
temporaryNegatives:
  competitor_dominated:
    example: "Competitor-specific keywords where position unassailable"
    revisit: "Monitor quarterly"

  resource_mismatch:
    example: "Keywords requiring video when only text viable"
    revisit: "When video capacity available"
```

---

## 17. Rejected Keyword Library

### Structure

```markdown
## Rejected Keywords

| Keyword | Date | Rejection Reason | Volume | Score | Revisit? |
|---------|------|------------------|-------:|------:|----------|
| random low-vol keyword | 2026-01-30 | Volume <50 (transactional) | 30 | - | No |
| ADHD cure apps | 2026-01-30 | Brand conflict (deficit language) | 800 | - | Never |
| focus music ADHD | 2026-01-30 | Cannibalization with 5.1 | 600 | 28 | Merge |
| declining topic | 2026-01-30 | Declining + score <25 | 400 | 14 | Monitor |
| hard with no angle | 2026-01-30 | Low differentiation + high difficulty | 1200 | 38 | If angle found |
```

### Revisit Classifications

| Classification | Meaning | Action |
|----------------|---------|--------|
| No | Fundamentally unviable | Never revisit |
| Never | Brand/value conflict | Permanently blocked |
| Merge | Should be secondary keyword | Add to existing article |
| Monitor | May become viable | Check quarterly |
| If [condition] | Conditionally viable | Revisit when condition met |
| Seasonal | Cyclically viable | Revisit before peak season |

---

## 18. Frontmatter Specification

### Complete Frontmatter Template

```yaml
# ═══════════════════════════════════════════════════════════════
# KEYWORD VALIDATION DATA v3
# ═══════════════════════════════════════════════════════════════

# Tool Usage (BOTH MANDATORY)
perplexityUsed: true
perplexityDate: "2026-01-30"
dataforSeoUsed: true
dataforSeoDate: "2026-01-30"

# Core Metrics (from DataForSEO)
targetKeyword: "ADHD apps emotional regulation UK"
searchVolume: 500
keywordDifficulty: 25
cpc: 0.85

# Intent Classification
searchIntent: commercial          # transactional/commercial/informational-product/informational
intentMultiplier: 2.5
volumeFloor: 100                  # Intent-tiered floor

# Trend Analysis
trendDirection: rising            # rising/stable/declining
trendMultiplier: 1.2
trendNote: "Growing interest in emotional regulation apps"

# Seasonal Analysis
seasonalKeyword: false
seasonalPeak: null                # or "August-September"
publishLeadTime: null             # or "8 weeks"
optimalPublishDate: null          # or "2026-06-15"

# Authority Assessment
competitorAuthorityLevel: low     # low/medium/medium-high/high
competitorAuthorityDetail: "Niche blogs in top 3, ADHD UK at #4"
authorityAdjustment: 0

# Difficulty Classification
effectiveDifficulty: 25           # KD + authorityAdjustment
difficultyTier: easy              # easy/medium/hard/very-hard
rankingTimeline: "2-4 months"
estimatedBacklinksNeeded: 3

# Opportunity Scoring
snippetBonus: 5
opportunityScore: 47.8
trafficPotentialCtr: 0.19
estimatedMonthlyClicks: 95

# Differentiation
differentiationScore: 9
differentiationTier: good         # strong/good/moderate/weak/none
differentiationBreakdown:
  - "UK-specific (NHS focus): +3"
  - "Affirming voice gap: +3"
  - "Missing PAA (3 questions): +3"

# Competitor Analysis
competitorQualityScore: 6
competitorQualityDetail: "Thin content, outdated, missing E-E-A-T"

# Competitive Moat
competitiveMoatScore: 8
competitiveMoatTier: strong       # strong/moderate/weak
moatBreakdown:
  - "Unique angle (passive sound): +3"
  - "UK specificity: +2"
  - "E-E-A-T advantage: +2"
  - "Fresh content: +1"

# Link Potential
linkAttractionScore: 5
linkAttractionTier: moderate      # high/moderate/low
backlinkStrategy: "Organic + light outreach"

# SERP Analysis
serpCtrRisk: medium               # low/medium/high
serpFeatures: "Featured snippet, AI Overview, PAA box"
serpOpportunityScore: 8
serpContentType: organic_text
serpVolatility: high
serpVolatilityModifier: +1

# AEO/GEO Analysis
aiOverviewPresent: true
aeoOpportunityScore: 4
aeoStrategy:
  - "Lead with 50-word definition"
  - "Structure H2s around PAA questions"
  - "Include comparison table"

# Voice/Device Analysis
voiceSearchLikely: false
deviceIntent: mixed

# Article Classification
articleType: cluster              # hub/cluster
pillarAssignment: "Pillar 5: ADHD Apps"
hubSupport: "ADHD apps"
topicalCohesionScore: 3

# Cross-Pillar
crossPillarOpportunity: true
secondaryPillars:
  - "Pillar 6: Emotional Regulation"
crossPillarBonus: +1

# Journey Stage
journeyStage: consideration       # awareness/consideration/decision/retention
contentApproach: "Solution-focused"
conversionExpectation: "15-25%"

# UK Analysis
ukModifierPresent: true
ukLocalisationRequired: true
ukDifferentiationBonus: +2

# Entity Analysis
entitiesDetected:
  - entity: "ADHD"
    type: condition
  - entity: "UK"
    type: geographic

# Question Analysis
questionKeyword: false
questionType: null
snippetFormat: null

# Priority System
priorityScore: 47.8
priorityRank: 5                   # 1-5
priorityGuidance: "Write this week"
priorityModifiers:
  - "Rising trend: +1"
  - "SERP volatility: +1"
  - "Cross-pillar: +1"
  - "Capped at 5"

# Cannibalization Check
cannibalizationRisk: none         # none/potential/confirmed
cannibalizationDetail: null
cannibalizationResolution: null

# Validation Status
validationDate: "2026-01-30"
validationFreshness: fresh        # fresh/current/aging/stale
keywordVerdict: GO                # GO/NO-GO
rejectionReason: null

# Data Confidence
dataConfidence:
  volume: high
  difficulty: high
  trend: high
  overall: high

# Topic Freshness
freshnessCategory: technology_dependent
reviewCadence: quarterly
nextReviewDate: "2026-04-30"

# Quality Score Decay
originalOpportunityScore: 47.8
decayMultiplier: 1.0
currentOpportunityScore: 47.8

# Keyword Relationships
keywordRelationships:
  - keyword: "ADHD apps"
    relationship: parent
    status: published
    linkOpportunity: "Link from intro"
  - keyword: "focus apps ADHD"
    relationship: sibling
    status: published
    linkOpportunity: "Cross-link"

# Secondary Keywords (minimum 5)
secondaryKeywords:
  - keyword: "emotional regulation apps ADHD"
    volume: 300
    difficulty: 22
  - keyword: "ADHD emotional dysregulation apps"
    volume: 250
    difficulty: 28
  - keyword: "apps for ADHD emotional control"
    volume: 200
    difficulty: 25
  - keyword: "ADHD mood regulation apps"
    volume: 180
    difficulty: 24
  - keyword: "emotional regulation app children ADHD"
    volume: 150
    difficulty: 20

# PAA Questions (minimum 7)
paaQuestions:
  - question: "What apps help with ADHD emotional regulation?"
    journeyStage: "consideration"
    intent: "commercial"
  - question: "How can apps help children with ADHD manage emotions?"
    journeyStage: "consideration"
    intent: "informational-product"
  # ... (7+ required)

# Competitor Gaps (minimum 2)
competitorGaps:
  - "No UK-focused content in top 5"
  - "All competitors use clinical language"
  - "No comparison tables or decision frameworks"
  - "Outdated information (2023 or earlier)"

# Research Sources (minimum 2)
researchSources:
  - source: "ADHD UK"
    url: "https://adhduk.co.uk/..."
    year: 2024
    finding: "72% of ADHD children experience emotional dysregulation"
  - source: "NHS"
    url: "https://nhs.uk/..."
    year: 2025
    finding: "..."
```

---

## 19. Verdict Output Format

### GO Example

```
═══════════════════════════════════════════════════════════════════
KEYWORD VALIDATION: GO
═══════════════════════════════════════════════════════════════════
Target: "ADHD apps emotional regulation UK"

METRICS
  Volume:              500/month (UK)
  Difficulty:          25 (DataForSEO) → 25 Effective
  Intent:              Commercial Investigation (2.5x)
  Trend:               Rising (1.2x)
  Snippet Bonus:       +5
  Opportunity Score:   47.8
  Traffic Potential:   95 clicks/month (175 if snippet captured)

CLASSIFICATION
  Difficulty Tier:     Easy
  Article Type:        Cluster (supports ADHD apps hub)
  Pillar:              Pillar 5: ADHD Apps
  Journey Stage:       Consideration
  Expected Timeline:   2-4 months (1-2 with backlinks)

SERP INTELLIGENCE
  Authority Level:     Low (niche blogs dominate)
  SERP Volatility:     High (opportunity)
  Features:            Featured snippet, AI Overview, PAA
  SERP Opportunity:    8/12 (strong)
  Content Type:        Organic text (compatible)

AEO/GEO ANALYSIS
  AI Overview:         Present
  AEO Score:           4/5 (high citation potential)
  Strategy:            Lead with 50-word definition, structure for extraction

DIFFERENTIATION
  Score:               9 (Good)
  Breakdown:           UK-specific +3, Affirming voice +3, Missing PAA +3
  Competitor Quality:  Weak (thin, outdated, no E-E-A-T)

COMPETITIVE MOAT
  Score:               8/10 (Strong)
  Defensibility:       High - unique angle, UK specificity, E-E-A-T

PRIORITY
  Priority Score:      47.8
  Priority Rank:       5 (Write this week)
  Modifiers:           Rising +1, Volatility +1, Cross-pillar +1 (capped)

VALIDATION
  ✓ Volume 500 >= 100 (commercial floor)
  ✓ Score 47.8 >= 15
  ✓ PAA questions: 9
  ✓ Competitor gaps: 4
  ✓ Research sources: 3
  ✓ Differentiation: 9 (Good)
  ✓ Trend: Rising (no combo gate)

WARNINGS
  ⚠ AI Overview present - optimise for citation
  ⚠ Cross-pillar with Pillar 6 - plan linking strategy

INTERNAL LINKING
  Parent: ADHD apps (hub) - link from intro
  Siblings: focus apps ADHD, executive function apps
  Cross-pillar: Emotional regulation strategies (Pillar 6)

CONTENT GUIDANCE
  Structure: Solution-focused, HushAway as primary recommendation
  AEO: Lead H2 with PAA question, 50-word answer, then expand
  CTA: Try the Sound Sanctuary - free forever
  Freshness: Technology-dependent, quarterly review

NEXT STEPS
  1. Proceed to research completion
  2. Run check-keyword-gate-v3.sh → should PASS
  3. Complete research file → check-research-gate.sh
═══════════════════════════════════════════════════════════════════
```

### NO-GO Example

```
═══════════════════════════════════════════════════════════════════
KEYWORD VALIDATION: NO-GO
═══════════════════════════════════════════════════════════════════
Target: "declining topic example"

METRICS
  Volume:              400/month (UK)
  Difficulty:          30 (DataForSEO)
  Effective Difficulty: 30
  Intent:              Informational + Product (2.0x)
  Trend:               Declining (0.7x)
  Opportunity Score:   14.0

REJECTION REASONS
  ✗ Score 14.0 < 15 minimum threshold
  ✗ Declining trend requires score >= 25

RECOMMENDATION
  This keyword is not viable. Consider:
  - Related keyword with stable/rising trend
  - Higher-volume variant in same topic
  - Different angle that improves differentiation

LOGGED TO
  Rejected keyword library with "Monitor" status
  Revisit: Check quarterly for trend reversal
═══════════════════════════════════════════════════════════════════
```

---

## Document History

| Date | Version | Change |
|------|---------|--------|
| 2026-01-30 | 1.0 | Initial system in SEO-RANKING-STRATEGY.md |
| 2026-01-30 | 2.0 | Separate document, DataForSEO mandatory |
| 2026-01-30 | 3.0 | Complete system with all components |
| 2026-01-30 | 3.1 | Split rules from implementation (implementation-keywords.md) |
