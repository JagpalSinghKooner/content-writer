# Keyword Validation System Implementation

> **Last Updated:** 2026-01-30 | **Overall Coverage:** ~45%

**Purpose:** Implementation tracking and guidance for the keyword validation system. Rules are in [KEYWORD-VALIDATION-SYSTEM-V2.md](KEYWORD-VALIDATION-SYSTEM-V2.md).

---

## Implementation Status

### Quick Summary

| Category | Status | Coverage |
|----------|--------|----------|
| Pre-API Filters (Step 0) | COMPLETE | 100% |
| API Verification (Steps 1-2) | COMPLETE | 100% |
| Hard Gates (Step 5) | COMPLETE | 95% |
| Scoring Formulas (Step 4) | WORKING | 70% |
| Soft Gates (Step 6) | PARTIAL | 70% |
| Seasonal/Trend/Decay | BASIC | 30% |
| Content Differentiation | GATE ONLY | 15% |
| SERP Analysis | MINIMAL | 10% |
| AEO/GEO Strategy | MINIMAL | 10% |
| Topical Authority | NOT STARTED | 0% |

### Fully Implemented (100%)

**Pre-API Filters**
- [x] Brand alignment check (deficit language, medical, harmful practices)
- [x] Negative keyword library lookup
- [x] Rejected keyword library lookup with revisit classification
- [x] Format validation (sentence length warning)

**API Verification**
- [x] DataForSEO mandatory check (`dataforSeoUsed: true`)
- [x] Volume and difficulty numeric validation
- [x] Perplexity mandatory check (`perplexityUsed: true`)
- [x] PAA questions count (7+ required)
- [x] Competitor gaps count (2+ required)
- [x] Research sources count (2+ required)

**Classification Validation**
- [x] Search intent classification (auto-classify if missing)
- [x] Trend direction validation (default to stable)
- [x] Article type inference (hub if vol ≥3000)
- [x] Pillar assignment check
- [x] Secondary keywords count (5+ required)

**Scoring Calculations**
- [x] Intent multiplier (3.0/2.5/2.0/1.0)
- [x] Trend multiplier (1.2/1.0/0.7)
- [x] Volume floor by intent (50/100/200/500)
- [x] Effective difficulty calculation
- [x] Opportunity score formula
- [x] Difficulty tier assignment
- [x] Priority score and rank calculation

**Hard Gates**
- [x] Volume floor (intent-tiered)
- [x] Opportunity score threshold (15+)
- [x] Differentiation gate (5+ for difficulty >40; 7+ for hubs)
- [x] Trend + Score combo gate (declining requires 25+)
- [x] Content type compatibility (basic)

**Soft Gates**
- [x] AI Overview presence flag
- [x] Moat score warning (<4)
- [x] Hub existence check for clusters
- [x] Cannibalization risk check (basic)
- [x] Validation freshness check (90 days)

**Infrastructure**
- [x] Rejected keyword auto-logging
- [x] Frontmatter template specification
- [x] GO/NO-GO output formatting
- [x] Exit codes (0=GO, 1=NO-GO)

### Partially Implemented

**Priority System (~40%)**
- [x] Base priority score calculation
- [x] Priority rank (1-5)
- [ ] Rising trend modifier (+1)
- [ ] High moat score modifier (+1)
- [ ] Brand defence modifier (+2)
- [ ] Seasonal modifiers
- [ ] Cross-pillar bonus (+1)

**SERP Analysis (~10%)**
- [x] Content type flag check (shopping/video dominant)
- [ ] Top 5 authority composition analysis
- [ ] DA tier detection (A/B/C/D)
- [ ] Featured snippet type detection
- [ ] SERP feature opportunity scoring
- [ ] SERP volatility assessment

**AEO/GEO (~10%)**
- [x] AI overview presence flag
- [ ] AEO opportunity score calculation
- [ ] AEO structure guidance output
- [ ] Citation opportunity assessment

**Differentiation (~15%)**
- [x] Differentiation score threshold gate
- [ ] UK-specific gap detection
- [ ] Affirming voice gap scoring
- [ ] Passive sound positioning detection
- [ ] Outdated competitor detection
- [ ] Missing PAA answer scoring

**Seasonal/Trend (~30%)**
- [x] Trend direction (rising/stable/declining)
- [x] Trend multiplier application
- [ ] Seasonal vs declining distinction
- [ ] Seasonal calendar matching
- [ ] Peak month identification
- [ ] Publish lead time calculation
- [ ] Optimal publish date output

---

## System Architecture

### Validation Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│ STEP 0: PRE-API FILTERS (No cost)                               │
├─────────────────────────────────────────────────────────────────┤
│ □ Brand alignment check (deficit language = REJECT)             │
│ □ Negative keyword lookup (permanent block = REJECT)            │
│ □ Rejected keyword lookup (previously rejected = REJECT)        │
│ □ Pillar relevance check (orphan = WARN)                        │
│ □ Format validation (sentence = REJECT)                         │
│                                                                 │
│ IF ANY HARD REJECT → Stop, log reason, no API calls             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 1: DATAFORSEO QUERIES (MANDATORY)                          │
├─────────────────────────────────────────────────────────────────┤
│ Query 1: Search Volume + Difficulty                             │
│   POST /keywords_data/google/search_volume/live                 │
│   location_code: 2826 (UK)                                      │
│   Extract: search_volume, keyword_difficulty, cpc               │
│                                                                 │
│ Query 2: Related Keywords                                       │
│   POST /dataforseo_labs/google/related_keywords/live            │
│   limit: 30                                                     │
│   Extract: keyword, search_volume, keyword_difficulty           │
│                                                                 │
│ ERROR HANDLING: 3 retries, exponential backoff                  │
│ IF FAIL AFTER RETRIES → REJECT "DataForSEO required"            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 2: PERPLEXITY MCP QUERIES (MANDATORY)                      │
├─────────────────────────────────────────────────────────────────┤
│ Query 1: Keyword Validation + Trends (perplexity_ask)           │
│   Extract: trend direction, seasonal patterns, UK variations    │
│                                                                 │
│ Query 2: PAA Discovery (perplexity_research)                    │
│   Extract: 7+ questions, journey stages, search intent          │
│                                                                 │
│ Query 3: Competitor SERP Analysis (perplexity_search)           │
│   Extract: top 5 domains, authority tiers, gaps, SERP features  │
│            AI overview presence, content types, volatility      │
│                                                                 │
│ Query 4: Research Source Discovery (perplexity_research)        │
│   Extract: 2+ UK sources with URLs, publication years           │
│                                                                 │
│ ERROR HANDLING: 2 retries, 3 second delay                       │
│ IF FAIL OR INSUFFICIENT DATA → REJECT                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 3: CLASSIFICATION                                          │
├─────────────────────────────────────────────────────────────────┤
│ 1. Classify search intent → Intent multiplier + volume floor    │
│ 2. Classify trend direction → Trend multiplier                  │
│ 3. Detect seasonal pattern → Seasonal classification            │
│ 4. Classify journey stage → Content approach                    │
│ 5. Detect question format → Question type + snippet format      │
│ 6. Detect UK modifiers → UK requirements                        │
│ 7. Detect entities → E-E-A-T requirements                       │
│ 8. Assign hub vs cluster → Article type                         │
│ 9. Assign pillar → Pillar + cohesion score                      │
│ 10. Check cross-pillar → Cross-pillar bonus                     │
│ 11. Map keyword relationships → Internal linking guidance       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 4: SCORING                                                 │
├─────────────────────────────────────────────────────────────────┤
│ 1. Calculate authority adjustment from SERP analysis            │
│ 2. Calculate effective difficulty                               │
│ 3. Calculate snippet bonus from SERP features                   │
│ 4. Calculate opportunity score                                  │
│ 5. Calculate traffic potential (CTR-adjusted)                   │
│ 6. Calculate differentiation score                              │
│ 7. Calculate competitor quality score                           │
│ 8. Calculate competitive moat score                             │
│ 9. Calculate link attraction potential                          │
│ 10. Calculate AEO opportunity score                             │
│ 11. Classify difficulty tier                                    │
│ 12. Calculate priority score                                    │
│ 13. Apply priority modifiers                                    │
│ 14. Calculate final priority rank (1-5)                         │
│ 15. Calculate data confidence score                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 5: GATE VALIDATION                                         │
├─────────────────────────────────────────────────────────────────┤
│ HARD GATES (any fail = REJECT):                                 │
│ □ Volume >= intent-tiered floor (50/100/200/500)                │
│ □ Opportunity Score >= 15                                       │
│ □ PAA Questions >= 7                                            │
│ □ Competitor Gaps >= 2                                          │
│ □ Research Sources >= 2                                         │
│ □ Differentiation >= 5 (if difficulty > 40)                     │
│ □ Differentiation >= 7 (if hub article)                         │
│ □ Score >= 25 (if trend declining)                              │
│ □ Content type compatible (not shopping dominant)               │
│                                                                 │
│ SOFT GATES (warn but proceed):                                  │
│ □ No cannibalization risk                                       │
│ □ AI overview strategy noted                                    │
│ □ SERP CTR risk documented                                      │
│ □ Authority level documented                                    │
│ □ Hub exists for cluster                                        │
│ □ Moat score >= 4                                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ STEP 6: VERDICT OUTPUT                                          │
├─────────────────────────────────────────────────────────────────┤
│ IF all hard gates pass:                                         │
│   → GO                                                          │
│   → Include: all scores, tier, timeline, priority               │
│   → Include: AEO guidance, snippet strategy                     │
│   → Include: internal linking map                               │
│   → Include: content structure guidance                         │
│   → Include: any soft gate warnings                             │
│   → Update keyword library (validated section)                  │
│                                                                 │
│ IF any hard gate fails:                                         │
│   → NO-GO                                                       │
│   → Include: specific rejection reason(s)                       │
│   → Include: recommendations for alternatives                   │
│   → Update keyword library (rejected section)                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: SERP Analysis (Critical)

**Priority:** HIGH - Required for accurate difficulty and timeline estimates

### Timeline Modifiers (NOT IMPLEMENTED)

| Condition | Timeline Impact |
|-----------|-----------------|
| Competitor authority HIGH | +3-6 months |
| SERP volatility HIGH | -1-2 months (opportunity) |
| SERP entrenched (1+ year same domains) | +2-3 months |
| Stale competitor content | -1-2 months |
| AI overview present | +1 month (need AEO optimisation) |
| Strong differentiation (10+) | -1 month |
| Cross-pillar keyword | -1 month (more linking opportunities) |

### SERP Volatility Assessment

```yaml
serpVolatility:
  assessment:
    query: "How stable are the top 5 rankings? Position changes in last 6 months?"

  classification:
    high_volatility:
      signal: "3+ position changes in top 5 recently"
      implication: OPPORTUNITY
      modifier: "+1 priority rank"

    moderate:
      signal: "1-2 changes in top 5"
      implication: "Standard competition"
      modifier: "None"

    entrenched:
      signal: "Same domains for 1+ year"
      implication: CHALLENGE
      modifier: "-1 priority rank (Hard tier only)"
```

### Content Type Compatibility

```yaml
contentTypeCheck:
  organic_text:
    threshold: "60%+ organic text results"
    action: PROCEED
    note: "Text content viable"

  video_dominant:
    threshold: "50%+ video results"
    action: WARN
    note: "Consider video companion content"
    modifier: "Flag for multimedia strategy"

  shopping_dominant:
    threshold: "40%+ shopping results"
    action: REJECT (for informational content)
    note: "SERP expects product pages"

  local_pack_dominant:
    threshold: "Local pack in top 3"
    action: WARN
    note: "Local intent detected - may not be suitable"
```

### Traffic Potential Estimation

**CTR Estimates by Position:**

| Target Position | Base CTR |
|-----------------|----------|
| Position 1 | 27% |
| Position 3 | 11% |
| Position 5 | 6% |
| Position 10 | 2% |

**SERP Feature CTR Deductions:**

| Feature | CTR Deduction |
|---------|---------------|
| Featured Snippet | -8% |
| AI Overview | -10% |
| Knowledge Panel | -5% |
| Video Carousel | -4% |
| PAA (expanded) | -3% |

**Calculation Example:**
```
Keyword: "ADHD apps emotional regulation UK"
Volume: 500
Target: Position 1 (27% CTR)
Features: Featured snippet (-8%), AI overview (-10%)
Adjusted CTR: 27% - 8% - 10% = 9%
Estimated Clicks: 500 × 0.09 = 45/month

BUT: If we capture featured snippet:
Featured snippet CTR: ~35%
Adjusted Clicks: 500 × 0.35 = 175/month
```

### SERP Opportunity Scoring (NOT IMPLEMENTED)

```yaml
serpOpportunityScore:
  featuredSnippetCapture:
    type_match:
      paragraph: +3 (if we can answer in 40-60 words)
      list: +2 (if content has clear steps)
      table: +2 (if comparison content fits)

    holder_weakness:
      weak_domain_DA40: +2
      outdated_2plus_years: +2
      poor_format_match: +1
      strong_holder: +0

    totalPossible: 0-7

  aiOverviewOpportunity:
    cited_sources_weak: +2
    unique_angle_possible: +2
    eeat_advantage: +1

    totalPossible: 0-5

  serpOpportunityTotal: 0-12

  interpretation:
    10-12: "Exceptional SERP opportunity"
    7-9: "Strong SERP opportunity"
    4-6: "Moderate opportunity"
    0-3: "Standard organic competition"
```

### Authority Tier Detection (NOT IMPLEMENTED)

| Tier | DA Range | Examples |
|------|----------|----------|
| **Tier A** | 70+ | NHS, Understood, ADDitude, gov.uk, major newspapers |
| **Tier B** | 50-69 | ADHD UK, NAS, established health sites |
| **Tier C** | 30-49 | Niche sites, smaller charities |
| **Tier D** | <30 | Forums, personal blogs, outdated sites |

**Output Format:**
```yaml
competitorAuthorityLevel: high
competitorAuthorityDetail: "NHS #1, ADDitude #2, Understood #4"
authorityAdjustment: 20
effectiveDifficulty: 45  # Original 25 + 20 adjustment
```

---

## Phase 2: Semantic Analysis

### Differentiation Point Breakdown (NOT IMPLEMENTED)

| Gap Type | Points | Example |
|----------|-------:|---------|
| UK-specific angle competitors miss | +3 | NHS/CAMHS focus vs US CDC references |
| Neurodivergent-affirming voice gap | +3 | Competitors use deficit language |
| Passive sound positioning opportunity | +3 | No competitor covers passive support |
| Outdated competitor content (>2 years) | +2 | Top result from 2022, no updates |
| Missing PAA answer | +1 each | Competitor doesn't answer common question |
| Different content format opportunity | +2 | All text, opportunity for comparison tables |
| Depth/comprehensiveness gap | +1 | Competitors are shallow/thin content |
| Missing E-E-A-T signals | +2 | No author, no citations |
| Poor UX/formatting | +1 | Walls of text, no images |

### Moat Factor Breakdown (NOT IMPLEMENTED)

```yaml
competitiveMoatAssessment:
  factors:
    uniqueAngle:
      score: +3
      condition: "HushAway has positioning competitors cannot copy"
      example: "Neurodivergent-first passive sound approach"

    ukSpecificity:
      score: +2
      condition: "UK-specific content US competitors won't create"
      example: "NHS pathway, CAMHS waiting lists"

    eeatAdvantage:
      score: +2
      condition: "Nicola's credentials provide unique authority"
      example: "Certified Neurodivergent Inclusive Coach"

    communityData:
      score: +2
      condition: "Community quotes/insights are uncopyable"
      example: "Real parent testimonials from HushAway community"

    freshContent:
      score: +1
      condition: "Content more current than competitors"
      example: "2026 research citations"

  totalMoat: "0-10"

  interpretation:
    8-10: "Strong moat - ranking likely defensible"
    5-7: "Moderate moat - maintain with updates"
    0-4: "Weak moat - expect competition catch-up"
```

### Pillar Authority Contribution

```yaml
topicalCohesion:
  existingPillar:
    score: +3
    description: "Keyword fits existing pillar"
    benefit: "Compounds topical authority"
    priorityModifier: "+1 rank"

  adjacentPillar:
    score: +1
    description: "Related to existing pillar"
    benefit: "Cross-linking opportunity"
    priorityModifier: "None"

  newTerritory:
    score: -1
    description: "No pillar connection"
    risk: "Orphan content, diluted authority"
    priorityModifier: "-1 rank"
    action: "WARN - consider pillar-first strategy"
```

### Hub vs Cluster Assignment

**Hub Criteria:**
- Volume: 3,000+ monthly searches
- Breadth: Topic spans 5+ subtopics (cluster opportunities)
- Pillar anchor: Could serve as pillar centre
- Difficulty: Accepted at any level (strategic foundation)

**Cluster Criteria:**
- Volume: 50-3,000 monthly searches (intent-tiered floor)
- Specificity: Narrow focus, single main question
- Supports hub: Links naturally to existing hub keyword

### Cross-Pillar Opportunity Detection

```yaml
crossPillarAnalysis:
  detection:
    method: "Identify keywords that bridge multiple pillar topics"
    value: "High strategic value - connects topic clusters"

  example:
    keyword: "ADHD apps emotional regulation UK"
    primaryPillar: "Pillar 5: ADHD Apps"
    relatedPillars:
      - "Pillar 6: Emotional Regulation"
      - "Pillar 1: ADHD Sleep" (emotional dysregulation affects sleep)

    opportunity:
      - "Internal linking to 3 pillars instead of 1"
      - "Topical bridge content (connects pillar topics)"
      - "Compounds authority across multiple topic clusters"

  bonus:
    bridges2Pillars: "+1 priority rank"
    bridges3PlusPillars: "+2 priority rank"
```

### Keyword Relationship Mapping

```yaml
keywordRelationships:
  parent_child:
    description: "Hub to cluster relationship"
    example: '"ADHD apps" (parent) → "focus apps ADHD" (child)'
    linkDirection: "Child links to parent (hub)"
    anchorStrategy: "Keyword-rich anchor to hub"

  sibling:
    description: "Cluster to cluster in same pillar"
    example: '"focus apps ADHD" ↔ "task management ADHD apps"'
    linkDirection: "Bidirectional contextual links"
    anchorStrategy: "Natural contextual anchors"

  crossPillar:
    description: "Content bridging different pillars"
    example: '"ADHD apps emotional regulation" ↔ "emotional regulation strategies"'
    linkDirection: "Cross-pillar bridges"
    anchorStrategy: "Topic-bridging anchors"
```

### Competitor Content Quality Assessment

```yaml
competitorQualityAssessment:
  indicators:
    thin_content:
      signal: "Word count under 1,000"
      opportunity: +2 differentiation

    outdated_info:
      signal: "No updates in 2+ years"
      opportunity: +2 differentiation

    poor_ux:
      signal: "No images, walls of text, bad formatting"
      opportunity: +1 differentiation

    missing_eeat:
      signal: "No author, no citations, no expertise shown"
      opportunity: +2 differentiation

    generic_advice:
      signal: "No specific examples, actionable steps"
      opportunity: +1 differentiation

  qualityGapScore: "Sum of indicators (0-8)"

  interpretation:
    6-8: "Weak competition - strong quality opportunity"
    3-5: "Moderate quality gap"
    0-2: "Strong competitor content - differentiate on angle"
```

### Link Attraction Potential

```yaml
linkAttractionPotential:
  factors:
    data_original:
      score: +3
      signal: "Original research/survey possible"
      potential: "High - journalists, bloggers cite data"

    resource_comprehensive:
      score: +2
      signal: "Definitive guide on topic"
      potential: "Medium - reference linking"

    tool_calculator:
      score: +2
      signal: "Interactive element possible"
      potential: "High - utility linking"

    controversy_opinion:
      score: +1
      signal: "Takes stance on debated topic"
      potential: "Medium - discussion linking"

    news_timely:
      score: +1
      signal: "Tied to current events"
      potential: "Variable - news cycle dependent"

  totalScore: "0-9"

  interpretation:
    7-9: "High link potential - invest in outreach"
    4-6: "Moderate - may attract organic links"
    0-3: "Low - focus on traffic/conversion value"
```

---

## Phase 3: AEO/Seasonal/Decay

### Answer Engine Optimisation (AEO)

```yaml
aeoStrategy:
  ifAiOverviewPresent:
    content_approach:
      - "Lead with concise, definitive answer (40-60 words)"
      - "Structure for extraction (clear H2s, lists, tables)"
      - "Include unique information AI cannot synthesise"
      - "Add E-E-A-T signals (citations, expertise)"
      - "Use HushAway community quotes (uncopyable)"

    structure_guidance:
      - "H2 headings match PAA questions exactly"
      - "First paragraph under H2 is snippet-ready"
      - "Tables for comparisons (AI extracts these)"
      - "Numbered lists for processes"

    uniqueness_factors:
      - "Community quotes/testimonials"
      - "Original data/survey results"
      - "Expert commentary (Nicola)"
      - "UK-specific resources"

  aiOverviewOpportunity:
    citationPotential:
      weak_current_sources: +2
      unique_angle_possible: +2
      eeat_advantage: +1

    totalOpportunity: "0-5"

    interpretation:
      4-5: "High AEO potential - optimise for citation"
      2-3: "Moderate AEO potential"
      0-1: "Low AEO potential - focus on traditional SEO"
```

### Seasonal Intelligence

**UK School Calendar:**

| Period | Months |
|--------|--------|
| Back to School | August-September |
| Autumn Half Term | October |
| Christmas | December |
| Spring Half Term | February |
| Easter | March-April |
| Summer Half Term | May |
| Exams | May-June |
| Summer Holidays | July-August |

**ADHD Peaks:**
- Diagnosis season: September-November (post-school-start concerns)
- Medication decisions: January (new year resolutions)
- Summer challenges: June-July (routine disruption)
- Back to school prep: July-August

**Seasonal Keyword Handling:**
```yaml
seasonalKeywordHandling:
  identification:
    query: "Is this keyword seasonal? What months does it peak?"
    output: "Peak months and volume swing percentage"

  ifSeasonal:
    peakMonths: "August-September"
    publishLeadTime: "8-12 weeks before peak"
    optimalPublishDate: "Calculate: peak minus lead time"
    offPeakViability: "Calculate: off-peak volume %"

  priorityModifiers:
    nearPeak: "+2 priority (within publish window)"
    farFromPeak: "-1 priority (time to wait)"
    missedWindow: "WARN - consider next year"
```

### Validation Freshness & Decay

**Freshness Rules:**

| Time Since Validation | Status | Action |
|----------------------|--------|--------|
| 0-30 days | Fresh | Proceed to writing |
| 31-60 days | Current | Proceed, consider quick refresh |
| 61-90 days | Aging | Quick validation refresh recommended |
| 91+ days | Stale | MUST re-validate before writing |

**Quality Score Decay Model:**

| Days Since Validation | Decay Multiplier |
|----------------------|------------------|
| 0-30 days | 100% |
| 31-60 days | 95% |
| 61-90 days | 85% |
| 91-120 days | 70% |
| 121+ days | 50% |

**Topic Freshness Requirements:**

| Category | Review Cadence | Example |
|----------|----------------|---------|
| Evolving research | Annual minimum | ADHD medication research |
| Technology dependent | Quarterly | Best ADHD apps 2026 |
| Policy linked | When policy changes | CAMHS waiting times |
| Evergreen | Biennial | How to create calm bedtime routine |

---

## Phase 4: Priority Modifiers

### Complete Priority Modifier System

| Condition | Modifier | Implementation Status |
|-----------|----------|----------------------|
| Rising trend | +1 rank | NOT IMPLEMENTED |
| Declining trend | -1 rank | NOT IMPLEMENTED |
| High SERP authority | -1 rank | NOT IMPLEMENTED |
| Strong differentiation (10+) | +1 rank | NOT IMPLEMENTED |
| Cannibalization warning | -1 rank until resolved | NOT IMPLEMENTED |
| Cross-pillar opportunity | +1 rank | NOT IMPLEMENTED |
| Seasonal near peak | +2 rank | NOT IMPLEMENTED |
| Seasonal far from peak | -1 rank | NOT IMPLEMENTED |
| SERP volatility high | +1 rank | NOT IMPLEMENTED |
| SERP entrenched | -1 rank (Hard tier only) | NOT IMPLEMENTED |
| Question keyword | +0.5 rank | NOT IMPLEMENTED |
| High moat score (8+) | +1 rank | NOT IMPLEMENTED |
| Low moat score (<4) | -1 rank | NOT IMPLEMENTED |
| Hub keyword | +1 rank (strategic) | NOT IMPLEMENTED |
| Brand defence | +2 rank | NOT IMPLEMENTED |

---

## Phase 5: Voice/Device/Journey

### Voice Search Patterns

```yaml
voiceSearchAnalysis:
  indicators:
    conversational: "Query is full sentence/question"
    naturalLanguage: 'Uses "who", "what", "where", "when", "how"'
    longTail: "5+ words in query"

  classification:
    voiceLikely: "Matches 2+ indicators"
    textStandard: "Typical keyword format"

voiceSearchOptimisation:
  ifVoiceLikely:
    content_approach:
      - "Include direct, concise answer in first paragraph"
      - "Answer the question in 30-40 words, then expand"
      - "Use conversational language"
      - "Include the question as an H2"

    structure:
      - "Question as H2"
      - "Direct answer (30-40 words) immediately after"
      - "Supporting detail follows"
```

### Device Intent Analysis

```yaml
deviceIntentAnalysis:
  mobileSignals:
    - '"near me" (local intent)'
    - "Short queries (action-oriented)"
    - "Time-sensitive (bedtime, morning routine)"
    - "On-the-go searches"

  desktopSignals:
    - "Long research queries"
    - "Comparison/review intent"
    - "In-depth informational"
    - "Multiple tabs behaviour"

deviceContentImplications:
  mobileDominant:
    format:
      - "Prioritise above-the-fold answers"
      - "Scannable format (bullets, short paragraphs)"
      - "Key info in first 100 words"
      - "Mobile-friendly tables"

  desktopDominant:
    format:
      - "Longer-form content acceptable"
      - "Detailed comparisons"
      - "Complex tables/charts"

  mixed:
    format:
      - "Balance both approaches"
      - "Progressive disclosure (summary → detail)"
```

### User Journey Stage Mapping

```yaml
buyerJourneyStages:
  awareness:
    signals:
      - "what is"
      - "signs of"
      - "symptoms"
      - "is my child"
    contentApproach: "Educational, introduce HushAway as one option"
    conversionExpectation: "5-10%"
    ctaType: "Soft - explore resources"

  consideration:
    signals:
      - "how to help"
      - "best ways to"
      - "apps for"
      - "strategies"
    contentApproach: "Solution-focused, HushAway as primary recommendation"
    conversionExpectation: "15-25%"
    ctaType: "Medium - try Sound Sanctuary"

  decision:
    signals:
      - "best"
      - "review"
      - "vs"
      - "alternative"
      - "free"
    contentApproach: "Comparison, HushAway differentiation highlighted"
    conversionExpectation: "25-40%"
    ctaType: "Strong - sign up free forever"

  retention:
    signals:
      - "HushAway"
      - Brand-specific queries
    contentApproach: "Support content, feature education"
    conversionExpectation: "Very high (existing users)"
    ctaType: "Feature education"

journeyStagePriority:
  decision: "Highest priority - direct revenue impact"
  consideration: "High priority - pipeline building"
  awareness: "Medium priority - top of funnel"
  retention: "As needed - support existing users"
```

---

## Reference Materials

### UK/Geographic Handling

**UK Modifiers:**
- Explicit: UK, NHS, CAMHS, NICE guidelines, British, England, Scotland, Wales, Northern Ireland
- Implicit: Pounds (£), GP (vs doctor), UK spelling (behaviour, colour), UK-specific resources

**Geographic Market Analysis:**
- Primary: UK (location_code: 2826)
- Related: Ireland (similar healthcare, same language)
- Regional: Scotland/Wales (devolved health systems)

**Entity Types:**
- Healthcare institutions: NHS, CAMHS, NICE, GP
- Charities: ADHD UK, NAS, Understood
- Products: HushAway, competitor app names
- Conditions: ADHD, autism, sensory processing
- Demographics: children, kids, toddlers, teens

### Cannibalization Check

**Decision Matrix:**

| Overlap Type | Action | Resolution |
|--------------|--------|------------|
| Exact match | BLOCK | Cannot proceed |
| High semantic overlap | WARN | Must differentiate OR merge as secondary |
| Low semantic overlap | PROCEED | Document for internal linking |
| Different pillar, similar topic | PROCEED | Cross-link opportunity |

### API Error Handling

**DataForSEO:**
- Retry attempts: 3
- Retry delay: 5 seconds exponential backoff
- Timeout: 30 seconds per request
- Rate limit: Wait 60 seconds, retry
- Authentication error: FAIL immediately
- No data: Check if keyword too niche (zero-volume handling)

**Perplexity:**
- Retry attempts: 2
- Retry delay: 3 seconds
- Rate limit: Wait 30 seconds, retry
- Timeout: Retry with simpler query

**Partial Failure:**
- Either API fails = REJECT (both mandatory)

### Data Confidence Scoring

```yaml
dataConfidenceScoring:
  volumeConfidence:
    high: "DataForSEO and Perplexity within 20%"
    medium: "20-50% variance"
    low: ">50% variance or zero-volume"

  difficultyConfidence:
    high: "SERP analysis confirms KD estimate"
    medium: "Mixed signals (KD easy but SERP has authorities)"
    low: "Significant mismatch"

  trendConfidence:
    high: "Clear trend signal from Perplexity"
    medium: "Mixed or unclear signals"
    low: "No trend data available"

  overallConfidence:
    formula: "Average of components"
    threshold: "Proceed if overall >= medium"
    action: "If low, flag for manual review"
```

### Backlink Requirement Estimation

| Effective Difficulty | Est. Backlinks | Timeline Without | Timeline With |
|---------------------|----------------|------------------|---------------|
| 0-30 (Easy) | 0-3 | 2-4 months | 1-2 months |
| 31-50 (Medium) | 3-10 | 4-6 months | 2-4 months |
| 51-70 (Hard) | 10-25 | 6-12 months | 4-6 months |
| 71+ (Very Hard) | 25+ | 12-18+ months | 6-12 months |

**Backlink Strategy by Tier:**
- Easy: Focus on content quality, internal links sufficient
- Medium: Organic + light outreach, guest posts, HARO
- Hard: Proactive link building, digital PR, original research
- Very Hard: Dedicated campaign, all channels, sustained effort

### Test Cases

| # | Test Case | Input | Expected Result |
|--:|-----------|-------|-----------------|
| 1 | Sweet spot keyword | Vol 500, KD 25, Commercial, Rising | GO, Score ~48, Easy, Priority 5 |
| 2 | Low volume (transactional) | Vol 80, KD 15, Transactional | GO (floor 50 for transactional) |
| 3 | Low volume (informational) | Vol 150, KD 20, Informational | REJECT: Volume <500 for info general |
| 4 | Low score | Vol 200, KD 60, Info general, Stable | REJECT: Score <15 |
| 5 | Hub keyword | Vol 25,000, KD 65, Commercial, Stable | GO, Hard, Priority 2 |
| 6 | Insufficient PAA | Only 4 PAA questions | REJECT: PAA <7 |
| 7 | Insufficient gaps | Only 1 gap identified | REJECT: Gaps <2 |
| 8 | DataForSEO failure | API error after retries | REJECT: DataForSEO required |
| 9 | Perplexity failure | MCP unavailable | REJECT: Perplexity required |
| 10 | Declining + low score | Vol 400, KD 30, Declining | REJECT: Declining + score <25 |
| 11 | Declining + high score | Vol 2000, KD 30, Declining | GO with WARN, -1 priority |
| 12 | High-authority SERP | 4/5 top results DA 70+ | GO, +20 effective difficulty |
| 13 | Cannibalization detected | Same keyword exists | BLOCK |
| 14 | Stale validation | 95 days old | BLOCK: Re-validate required |
| 15 | Low diff, easy KD | Diff 4, KD 25 | GO with WARN |
| 16 | Low diff, hard KD | Diff 3, KD 55 | REJECT: Low diff for hard |
| 17 | Brand conflict | "cure ADHD" | REJECT at Step 0 (pre-API) |
| 18 | Video-dominant SERP | 70% videos | GO with WARN |
| 19 | Zero-volume viable | 0 vol, Perplexity confirms demand | GO, assigned 50 volume |
| 20 | Cross-pillar | Bridges 2+ pillars | GO, +1 priority |
| 21 | High CPC, low volume | £3.50 CPC, 80 vol, transactional | GO (trans floor 50) |
| 22 | Volatile SERP | 3+ position changes | GO, +1 priority |
| 23 | Entrenched SERP, Hard | Same domains 1+ year, KD 55 | GO, -1 priority |
| 24 | Seasonal near peak | 8 weeks to peak | GO, +2 priority |
| 25 | Question keyword | "How to help ADHD child sleep" | GO, +0.5 priority |
| 26 | Hub-worthy keyword | 5,000 vol, 8+ subtopics | GO, articleType: hub |
| 27 | Cluster no hub | Cluster with no parent hub | GO with WARN |
| 28 | NHS/CAMHS entity | Contains NHS | GO, UK-specific flag |
| 29 | AI overview present | SGE in SERP | GO with AEO guidance |
| 30 | Voice search pattern | 7+ word question | GO with voice flag |
| 31 | SERP overlap 70% | Two keywords, same SERPs | Cluster together |
| 32 | High moat (8+) | Strong unique positioning | GO, +1 priority |
| 33 | Low moat (2) | Weak differentiation | GO with WARN |
| 34 | Hub low differentiation | Hub, diff score 5 | REJECT: Hubs need 7+ |
| 35 | Shopping dominant SERP | 50% shopping results | REJECT: Incompatible |
| 36 | Thin competitor content | Avg 600 words | GO, +2 differentiation |

### Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Research time per keyword | <15 minutes | Time from start to GO/NO-GO |
| GO rate (first attempt) | >40% | Keywords passing all hard gates |
| False positive rate | <5% | GO keywords that fail to rank |
| False negative rate | <10% | REJECT keywords that were viable |
| Timeline accuracy | Within 2 months | Predicted vs actual ranking time |
| API cost per validation | Reduce 30% vs v1 | Pre-filters + caching |
| Re-research rate | <5% | Same keyword researched twice |
| Snippet capture rate | >25% | GO keywords that win snippets |
| AEO citation rate | >15% | GO keywords cited in AI overviews |

---

## Recommended Implementation Order

1. **Phase 1 (Critical):** SERP analysis module (authority, features, volatility)
2. **Phase 2:** Semantic analysis (differentiation gaps, cross-pillar, relationships)
3. **Phase 3:** AEO/seasonal/decay logic
4. **Phase 4:** Complete priority modifier system
5. **Phase 5:** Voice/device/journey mapping
