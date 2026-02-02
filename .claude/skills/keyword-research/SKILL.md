---
name: keyword-research
description: "Strategic keyword research without expensive tools. Use when someone needs content strategy, topic ideas, SEO planning, or asks what should I write about. Uses the 6 Circles Method to expand from seed keywords, clusters into content pillars, and maps to a prioritized content plan. Triggers on: keyword research for X, content strategy for X, what topics should I cover, SEO strategy, content calendar, topic clusters. Outputs prioritized keyword clusters with content recommendations."
---

# Keyword Research

Most keyword research is backwards. People start with tools, get overwhelmed by data, and end up with a spreadsheet they never use.

This skill starts with strategy. What does your business need? Who are you trying to reach? What would make them find you? Then it builds a content plan that actually makes sense.

No expensive tools required. Just systematic thinking.

---

## The core job

Transform a business context into a **prioritized content plan** with:
- Keyword clusters organized by topic
- Priority ranking based on opportunity
- Content type recommendations
- A clear "start here" action

**Output format:** Clustered keywords mapped to content pieces, prioritized by business value and opportunity.

---

## The process

```
SEED → EXPAND → CLUSTER → PRIORITIZE → MAP
```

1. **Seed** — Generate initial keywords from business context
2. **Expand** — Use the 6 Circles Method to build comprehensive list
3. **Cluster** — Group related keywords into content pillars
4. **Prioritize** — Score by opportunity and business value
5. **Map** — Assign clusters to specific content pieces

---

## Before starting: Gather context

Get these inputs before generating anything:

1. **What do you sell/offer?** (1-2 sentences)
2. **Who are you trying to reach?** (Be specific)
3. **What's your website?** (To understand current content)
4. **Who are 2-3 competitors?** (Or help identify them)
5. **What's the goal?** (Traffic? Leads? Sales? Authority?)
6. **Timeline?** (Quick wins or long-term plays?)

---

## Phase 1: Seed Generation

From the business context, generate 20-30 seed keywords covering:

**Direct terms** — What you actually sell
> "AI marketing automation", "fractional CMO", "marketing workflows"

**Problem terms** — What pain you solve
> "can't keep up with content", "marketing team too small", "don't understand AI"

**Outcome terms** — What results you deliver
> "faster campaign execution", "10x content production", "marketing ROI"

**Category terms** — Broader industry terms
> "marketing automation", "AI marketing", "growth marketing"

---

## Phase 2: Expand (The 6 Circles Method)

For each seed keyword, expand using 6 different lenses:

### Circle 1: What You Sell
Products, services, and solutions you offer directly.
> Example: "AI marketing automation", "marketing workflow templates", "fractional CMO services"

### Circle 2: Problems You Solve
Pain points and challenges your audience faces.
> Example: "marketing team overwhelmed", "can't measure marketing ROI", "content takes too long"

### Circle 3: Outcomes You Deliver
Results and transformations customers achieve.
> Example: "automated lead generation", "consistent content publishing", "marketing that runs itself"

### Circle 4: Your Unique Positioning
What makes you different from alternatives.
> Example: "no-code marketing", "AI-first approach", "community-driven marketing"

### Circle 5: Adjacent Topics
Related areas where your audience spends time.
> Example: "startup growth", "indie hackers", "solopreneur tools", "productivity systems"

### Circle 6: Entities to Associate With
People, tools, frameworks, concepts you want to be connected to.
> Example: "Claude AI", "n8n automation", specific thought leaders, industry frameworks

### Expansion techniques

For each seed, find variations using:

**Question patterns:**
- What is [keyword]?
- How to [keyword]?
- Why [keyword]?
- Best [keyword]?
- [keyword] vs [alternative]?
- [keyword] examples
- [keyword] for [audience]

**Modifier patterns:**
- [keyword] tools
- [keyword] templates
- [keyword] guide
- [keyword] strategy
- [keyword] 2025
- [keyword] for beginners
- [keyword] for [industry]

**Comparison patterns:**
- [keyword A] vs [keyword B]
- best [category]
- [tool] alternatives
- [tool] review

**Output:** Expanded list of 100-200 keywords from seed terms

---

## Phase 2.5: Data-Enhanced Research (Optional)

When available, use DataForSEO Labs API and Perplexity MCP to validate keyword opportunities with real data. This transforms strategic guesses into data-backed decisions.

**Note:** This phase is optional. The skill works without external tools, but data validation significantly improves prioritisation accuracy.

---

### DataForSEO Labs: Keyword Expansion + Full Metrics

The `/dataforseo_labs/google/keyword_suggestions/live` endpoint is the primary tool. With `include_serp_info: true`, a single call returns:
- **Search volume** — Monthly searches and trend data
- **Keyword difficulty** — Organic ranking difficulty (0-100), NOT Ads competition
- **Search intent** — Informational, commercial, transactional, or navigational
- **SERP features** — Which features appear (PAA, featured snippets, AI overview, videos)
- **Backlinks data** — Average backlinks/referring domains for ranking pages

**When to call:**
- After Phase 2 expansion, to generate 100+ keyword variations per seed
- Returns everything needed for clustering and prioritisation in one call

**Example API request:**

```bash
curl -X POST "https://api.dataforseo.com/v3/dataforseo_labs/google/keyword_suggestions/live" \
  -H "Authorization: Basic [YOUR_CREDENTIALS]" \
  -H "Content-Type: application/json" \
  -d '[{
    "keyword": "email marketing",
    "location_code": 2826,
    "language_code": "en",
    "include_serp_info": true,
    "limit": 100
  }]'
```

**Key parameters:**
| Parameter | Value | Notes |
|-----------|-------|-------|
| `keyword` | string | Seed keyword to expand |
| `location_code` | 2826 | UK (use 2840 for US) |
| `language_code` | "en" | English |
| `include_serp_info` | true | **Critical** — Returns KD, intent, SERP features |
| `limit` | 100 | Keywords per request (max 1,000) |

**Interpreting results:**

```json
{
  "keyword": "email marketing automation",
  "keyword_info": {
    "search_volume": 320,
    "cpc": 47.74,
    "competition": 0.34,
    "monthly_searches": [...]
  },
  "keyword_properties": {
    "keyword_difficulty": 29
  },
  "search_intent_info": {
    "main_intent": "informational"
  },
  "serp_info": {
    "serp_item_types": ["organic", "people_also_ask", "video", "related_searches"]
  },
  "avg_backlinks_info": {
    "backlinks": 7801,
    "referring_domains": 717
  }
}
```

| Field | Location | What it means |
|-------|----------|---------------|
| `search_volume` | `keyword_info` | Average monthly searches |
| `keyword_difficulty` | `keyword_properties` | **Organic** ranking difficulty (0-100) |
| `main_intent` | `search_intent_info` | Search intent classification |
| `serp_item_types` | `serp_info` | SERP features present for this keyword |
| `backlinks` | `avg_backlinks_info` | Avg backlinks on ranking pages |

**Keyword Difficulty thresholds:**

| KD Score | Difficulty | Strategy |
|----------|------------|----------|
| 0-29 | Easy | Target immediately — quick wins |
| 30-49 | Medium | Winnable with quality content |
| 50-69 | Hard | Requires authority + great content |
| 70-100 | Very Hard | Long-term play, needs link building |

**Volume thresholds for UK market:**

| Volume | Content Decision |
|--------|------------------|
| >5,000 | High-priority pillar |
| 1,000-5,000 | Valid pillar |
| 500-1,000 | Strong supporting article |
| 100-500 | Supporting article if highly relevant |
| <100 | Skip unless zero-competition niche |

---

### DataForSEO Labs: Bulk Keyword Difficulty

Use `/dataforseo_labs/google/bulk_keyword_difficulty/live` when you have an existing keyword list and need organic KD scores quickly.

**When to call:**
- Validating keywords from manual research or client input
- Comparing keywords you already identified

**Example API request:**

```bash
curl -X POST "https://api.dataforseo.com/v3/dataforseo_labs/google/bulk_keyword_difficulty/live" \
  -H "Authorization: Basic [YOUR_CREDENTIALS]" \
  -H "Content-Type: application/json" \
  -d '[{
    "keywords": ["email marketing automation", "ai marketing strategy", "drip campaigns"],
    "location_code": 2826,
    "language_code": "en"
  }]'
```

**Response:**

```json
{
  "items": [
    {"keyword": "email marketing automation", "keyword_difficulty": 29},
    {"keyword": "ai marketing strategy", "keyword_difficulty": 53},
    {"keyword": "drip campaigns", "keyword_difficulty": 41}
  ]
}
```

---

### DataForSEO: Advanced SERP Analysis

Use `/serp/google/organic/live/advanced` for deep SERP analysis. Returns full SERP features including People Also Ask questions, related searches, and videos.

**When to call:**
- During Pillar Validation (Phase 3)
- For top 3-5 priority keywords only (more expensive than suggestions endpoint)
- When you need actual PAA questions for content planning

**Example API request:**

```bash
curl -X POST "https://api.dataforseo.com/v3/serp/google/organic/live/advanced" \
  -H "Authorization: Basic [YOUR_CREDENTIALS]" \
  -H "Content-Type: application/json" \
  -d '[{
    "keyword": "email marketing automation",
    "location_code": 2826,
    "language_code": "en",
    "depth": 10
  }]'
```

**Key parameters:**
| Parameter | Value | Notes |
|-----------|-------|-------|
| `depth` | 10 | Number of organic results (10 = page 1) |
| `location_code` | 2826 | UK |
| `keyword` | string | Single keyword per request |

**Response structure:**

The response includes `item_types` array showing what features appear on the SERP:

```json
{
  "item_types": ["organic", "people_also_search", "video", "related_searches"],
  "items": [
    {"type": "organic", "rank_group": 1, "domain": "mailchimp.com", "title": "..."},
    {"type": "people_also_search", "items": ["Best email marketing platform", "Email automation free", "..."]},
    {"type": "related_searches", "items": ["Email marketing automation examples", "..."]}
  ]
}
```

**Extracting value from Advanced SERP:**

| Item Type | What to Extract | Content Use |
|-----------|-----------------|-------------|
| `organic` | Titles, domains, descriptions | Competitive analysis, angle finding |
| `people_also_search` | Related search queries | Additional keyword ideas |
| `related_searches` | Bottom-of-SERP suggestions | Long-tail expansion |
| `people_also_ask` | PAA questions (if present) | FAQ section content, subheadings |
| `featured_snippet` | Snippet holder + content | Target for position zero |
| `video` | Video results present | Consider video content |

**What to extract from organic results:**

| Data Point | How to Assess | Decision Impact |
|------------|---------------|-----------------|
| **Domain patterns** | All big brands vs mix? | All DR 80+ = harder to win |
| **Content types ranking** | Guides? Listicles? Tools? | Match or differentiate format |
| **Title patterns** | What angles dominate? | Find unclaimed angles |
| **Content freshness** | Check timestamps | Outdated content = opportunity |
| **SERP features** | Featured snippets? PAA? | Target these specifically |

**Competitive assessment matrix:**

| SERP Pattern | Difficulty | Recommendation |
|--------------|------------|----------------|
| All DR 80+ sites, comprehensive content | Very Hard | Find niche angle or skip |
| Mix of DR 50-80, moderate content | Medium | Winnable with great content |
| DR <50 sites, thin content | Easy | High priority, move fast |
| No clear winner, varied content | Medium | Opportunity to define category |

---

### Perplexity MCP: Competitor Analysis & Trends

Use the Perplexity MCP tools for deeper competitor content analysis and trend validation. These complement DataForSEO's quantitative data with qualitative insights.

**Available Perplexity tools:**

| Tool | Use Case |
|------|----------|
| `perplexity_search` | Quick facts, current rankings, basic research |
| `perplexity_ask` | Conversational analysis, interpreting data |
| `perplexity_research` | Deep competitor analysis, comprehensive reports |
| `perplexity_reason` | Strategic decisions, weighing trade-offs |

---

#### Competitor Content Analysis

Use `perplexity_research` to analyse what competitors are actually publishing.

**Example prompt:**

```
Analyse the top 5 ranking articles for "AI marketing automation". For each:
1. What's their main angle or positioning?
2. What topics do they cover?
3. What's missing that a practitioner would want to know?
4. How recent is the content?

Focus on gaps and opportunities for differentiation.
```

**What to extract:**
- **Content gaps:** Topics competitors don't cover well
- **Angle opportunities:** Positioning no one owns
- **Depth issues:** Where existing content is surface-level
- **Freshness:** Outdated information you can update
- **Format gaps:** Missing how-tos, comparisons, or examples

---

#### Trend Validation

Use `perplexity_search` to validate whether a topic is growing or declining.

**Example prompt:**

```
What's the current trend for "AI marketing automation"? Is interest growing, stable, or declining? Any recent developments or news driving search interest?
```

**Trend signals to look for:**
- Industry news or events driving interest
- New tools or platforms emerging
- Regulatory changes affecting the space
- Seasonal patterns
- Year-over-year growth indicators

---

#### Strategic Pillar Decisions

Use `perplexity_reason` when you need to make strategic choices about pillar selection.

**Example prompt:**

```
I'm choosing between two content pillars for an AI marketing consultancy:

Option A: "AI Marketing Strategy" - 2,400 monthly searches, medium competition, strong commercial intent

Option B: "Marketing Automation for Startups" - 800 monthly searches, lower competition, niche but loyal audience

The consultancy's target client is funded startups with 10-50 employees. Which pillar should be prioritised and why?
```

**When to use reasoning:**
- Comparing two viable pillars
- Deciding between broad vs niche positioning
- Evaluating risk/reward trade-offs
- Resolving conflicting data signals

---

### Integrating Data into the Workflow

**Updated workflow with data enhancement:**

```
SEED → EXPAND + ENRICH → CLUSTER → PRIORITIZE → MAP
```

**Phase 2.5 checklist:**

1. [ ] For each seed keyword, call `/keyword_suggestions` with `include_serp_info: true`
2. [ ] Collect 50-100 suggestions per seed (returns volume, KD, intent, SERP features)
3. [ ] Filter out keywords with KD > 70 (too hard) or volume < 100 (too small)
4. [ ] Identify potential pillars: volume > 1,000 AND KD < 50
5. [ ] Call `/serp/organic/live/advanced` for top 3-5 pillar keywords
6. [ ] Extract People Also Ask and related searches for content planning
7. [ ] Use Perplexity to analyse competitor content for top pillars
8. [ ] Use Perplexity to validate trends for any uncertain keywords
9. [ ] Document findings in pillar validation section

**Data points now captured:**

| Data Point | Source | Previous | Now |
|------------|--------|----------|-----|
| Search volume | `keyword_suggestions` | ✓ | ✓ |
| Keyword difficulty | `keyword_suggestions` | ✗ (had Ads competition) | ✓ Organic KD (0-100) |
| Search intent | `keyword_suggestions` | ✗ | ✓ |
| SERP features | `keyword_suggestions` + `serp/advanced` | ✗ | ✓ |
| PAA questions | `serp/advanced` | ✗ | ✓ |
| Related searches | `serp/advanced` | ✗ | ✓ |
| Backlinks data | `keyword_suggestions` | ✗ | ✓ |

**Data-enhanced pillar validation format:**

```
Pillar: [Name]

### Keyword Metrics (DataForSEO Labs)
- Primary keyword: [keyword]
- Search volume: [X] monthly
- Keyword difficulty: [X]/100 — [Easy/Medium/Hard/Very Hard]
- Search intent: [informational/commercial/transactional]
- Trend: [growing/stable/declining] (from monthly_searches)
- CPC: £[X] (commercial value indicator)

### SERP Features Present
- [ ] People Also Ask
- [ ] Featured Snippet
- [ ] Video results
- [ ] AI Overview
- [ ] Related searches

### SERP Analysis (DataForSEO Advanced)
| Rank | Domain | Title Pattern | Content Type | Gap/Opportunity |
|------|--------|---------------|--------------|-----------------|
| 1 | [domain] | [pattern] | [type] | [gap] |
| 2 | [domain] | [pattern] | [type] | [gap] |
| 3 | [domain] | [pattern] | [type] | [gap] |

### People Also Ask (Content Ideas)
- [Question 1]
- [Question 2]
- [Question 3]

### Competitor Content Analysis (Perplexity)
- **Dominant angle:** [what competitors focus on]
- **Content gaps:** [what's missing]
- **Opportunity:** [how to differentiate]

### Verdict
- Volume test: PASS/FAIL — [X] searches (threshold: 1,000)
- Difficulty test: PASS/FAIL — KD [X] (threshold: <50 for quick wins)
- Intent match: PASS/FAIL — [intent] matches content goal
- Competitive test: PASS/FAIL — [winnable because...]
- Proprietary advantage: YES/NO — [what advantage]

**FINAL:** VALID PILLAR / DEMOTE TO CLUSTER / REMOVE
```

---

### When Data Isn't Available

If DataForSEO or Perplexity aren't available, fall back to free tools:

| Data Need | Free Alternative |
|-----------|------------------|
| Search volume | Google Keyword Planner (requires Ads account) |
| Keyword difficulty | Ubersuggest free tier, Keywords Everywhere |
| SERP analysis | Manual Google search + Moz/Ahrefs free tools |
| PAA questions | AlsoAsked.com free tier |
| Competitor analysis | Manual review + ChatGPT/Claude analysis |
| Trends | Google Trends |

The skill works without external tools—data just makes prioritisation more accurate.

---

## Phase 3: Cluster

Group expanded keywords into content pillars using the hub-and-spoke model:

```
                    [PILLAR]
                 Main Topic Area
                      |
        +-------------+-------------+
        |             |             |
   [CLUSTER 1]   [CLUSTER 2]   [CLUSTER 3]
    Subtopic       Subtopic       Subtopic
        |             |             |
    Keywords      Keywords      Keywords
```

### Identifying pillars (5-10 per business)

A pillar is a major topic area that could support:
- One comprehensive guide (3,000-8,000 words)
- 3-7 supporting articles
- Ongoing content expansion

Ask: "Could this be a complete guide that thoroughly covers the topic?"

### Pillar Validation (Critical Step)

**Before finalizing pillars, run these 4 checks:**

Most keyword research fails because pillars are chosen based on what the business WANTS to talk about, not what the market ACTUALLY searches for.

**1. Search Volume Test**
Does this pillar have >1,000 monthly searches across its keyword cluster?

- If YES: Valid pillar
- If NO: Not a pillar. It may be a single article or shouldn't be created at all.

Example failure: "Claude marketing" (zero search volume) chosen as pillar because the product uses Claude. Market searches "AI marketing" instead.

**2. Product vs. Market Test**
Is this pillar something the MARKET searches for, or something YOU want to talk about?

| Product-Centric (Wrong) | Market-Centric (Right) |
|-------------------------|------------------------|
| "Our methodology" | "Marketing automation" |
| "[Your tool name] tutorials" | "[Category] tutorials" |
| "Why we're different" | "[Problem] solutions" |
| Features of your product | Outcomes people search for |

The market doesn't search for your product name (unless you're famous). They search for solutions to their problems.

**3. Competitive Reality Test**
Can you actually win here?

Check the top 3 results for the pillar keyword:
- All DR 80+ sites (Forbes, HubSpot, etc.)? Find adjacent pillar.
- Mix of authority and smaller sites? Winnable with great content.
- Thin content from unknown sites? High opportunity.

Don't choose pillars where you have no realistic path to page 1.

**4. Proprietary Advantage Test**
Do you have unique content, data, or expertise for this pillar?

| Advantage | Priority |
|-----------|----------|
| Proprietary data others don't have | Prioritize highly |
| Unique methodology or framework | Prioritize highly |
| Practitioner experience (done it, not read about it) | Prioritize |
| Same info everyone else has | Deprioritize |

If you have 2,589 marketing workflows and nobody else does, "marketing workflows" should be a pillar. If you're writing about "AI marketing" with no unique angle, you're competing on equal footing with everyone.

**Validation Output:**

For each proposed pillar, document:

```
Pillar: [Name]
Search volume test: PASS/FAIL — [evidence]
Market-centric test: PASS/FAIL — [evidence]
Competitive test: PASS/FAIL — [evidence]
Proprietary advantage: YES/NO — [what advantage]
VERDICT: VALID PILLAR / DEMOTE TO CLUSTER / REMOVE
```

**If a pillar fails 2+ tests, it's not a pillar.** Either demote it to a single article within another pillar, or remove it entirely.

### Clustering process

1. **Group by semantic similarity** — Keywords that mean similar things
2. **Group by search intent** — Keywords with same user goal
3. **Identify the pillar keyword** — The broadest term in each group
4. **Identify supporting keywords** — More specific variations

### Example cluster

**Pillar:** AI Marketing Automation

**Clusters:**
- What is AI marketing automation (definitional)
- AI marketing tools (commercial/comparison)
- AI marketing examples (proof/validation)
- Building AI marketing workflows (how-to)
- AI vs traditional automation (comparison)

---

## Phase 4: Prioritize

Not all keywords are equal. Score each cluster by:

### Business Value (High / Medium / Low)

**High:** Direct path to revenue
- Commercial intent keywords
- Close to purchase decision
- Your core offering

**Medium:** Indirect path
- Builds trust and authority
- Captures leads
- Educational content

**Low:** Brand awareness only
- Top of funnel
- Tangentially related
- Nice to have

### Opportunity (High / Medium / Low)

**High opportunity signals:**
- No good content exists (you'd define the category)
- Existing content is outdated (2+ years old)
- Existing content is thin (surface-level, generic)
- You have unique angle competitors miss
- Growing trend (check Google Trends)

**Low opportunity signals:**
- Dominated by major authority sites
- Excellent comprehensive content already exists
- Highly competitive commercial terms
- Declining interest

### Speed to Win (Fast / Medium / Long)

**Fast (3 months):**
- Low competition
- You have unique expertise/data
- Content gap is clear

**Medium (6 months):**
- Moderate competition
- Requires comprehensive content
- Differentiation path exists

**Long (9-12 months):**
- High competition
- Requires authority building
- May need link building

### Priority Matrix

| Business Value | Opportunity | Speed | Priority |
|---------------|-------------|-------|----------|
| High | High | Fast | **DO FIRST** |
| High | High | Medium | **DO SECOND** |
| High | Medium | Fast | **DO THIRD** |
| Medium | High | Fast | **QUICK WIN** |
| High | Low | Any | **LONG PLAY** |
| Low | Any | Any | **BACKLOG** |

---

## Phase 5: Map to Content

For each priority cluster, assign:

### Content type

| Type | When to Use | Word Count |
|------|-------------|------------|
| **Pillar Guide** | Comprehensive topic coverage | 5,000-8,000 |
| **How-To Tutorial** | Step-by-step instructions | 2,000-3,000 |
| **Comparison** | X vs Y, Best [category] | 2,500-4,000 |
| **Listicle** | Tools, examples, tips | 2,000-3,000 |
| **Use Case** | Industry or scenario specific | 1,500-2,500 |
| **Definition** | What is [term] | 1,500-2,500 |

### Intent matching

| Intent | Keyword Signals | Content Approach | CTA Type |
|--------|-----------------|------------------|----------|
| **Informational** | what, how, why, guide | Educate thoroughly | Newsletter, resource |
| **Commercial** | best, vs, review, compare | Help them decide | Free trial, demo |
| **Transactional** | buy, pricing, get, hire | Make it easy | Purchase, contact |

### Content calendar placement

**Tier 1 (Publish in weeks 1-4):** Highest priority, category-defining
**Tier 2 (Publish in weeks 5-8):** High priority, supporting pillars
**Tier 3 (Publish in weeks 9-12):** Medium priority, depth content
**Tier 4 (Backlog):** Lower priority, future opportunities

---

## Output format

### Executive Summary

```
# Keyword Research: [Business Name]

## Top Opportunities
1. [Keyword/cluster] — [Why it's an opportunity]
2. [Keyword/cluster] — [Why it's an opportunity]
3. [Keyword/cluster] — [Why it's an opportunity]

## Quick Wins (3-month potential)
- [Keyword] — [Why quick]
- [Keyword] — [Why quick]

## Long-Term Plays (6-12 months)
- [Keyword] — [Strategy needed]

## Start Here
[Specific first piece of content to create and why]
```

### Pillar Overview

Each pillar section must be clearly delineated for extraction by `/start-pillar`.

```
---BEGIN PILLAR---
## Pillar: [Topic Name]

**Priority:** [Critical / High / Medium / Low]
**Business Value:** [H/M/L] — [reason]
**Opportunity:** [H/M/L] — [reason]
**Speed to Win:** [Fast/Medium/Long]
**Content pieces:** [Number]

### Competitor Validation

| Site | DR | Content Quality | Winnable? |
|------|-----|-----------------|-----------|
| [url] | [score] | thin/moderate/comprehensive | Y/N — [reason] |
| [url] | [score] | thin/moderate/comprehensive | Y/N — [reason] |
| [url] | [score] | thin/moderate/comprehensive | Y/N — [reason] |

**Overall Assessment:** [Summary of competitive landscape and win strategy]

### Keyword Table

| Cluster | Priority | Intent | Content Type |
|---------|----------|--------|--------------|
| [name]  | [H/M/L]  | [type] | [format]     |

---END PILLAR---
```

### Production Queue

The production queue orders pillars by priority matrix (business value × opportunity × speed). This is about what to PRODUCE in what order, not when to PUBLISH.

```
## Production Queue

| Priority | Pillar | Business Value | Opportunity | Speed | First Article |
|----------|--------|----------------|-------------|-------|---------------|
| 1 | [Pillar name] | H | H | Fast | [Article title] |
| 2 | [Pillar name] | H | H | Medium | [Article title] |
| 3 | [Pillar name] | H | M | Fast | [Article title] |
| ... | ... | ... | ... | ... | ... |

### Execution Order

1. **[Pillar 1]** — [Why this pillar first: opportunity + advantage]
2. **[Pillar 2]** — [Why second: builds on first or high value]
3. **[Pillar 3]** — [Why third: strategic reason]
```

---

## Example: Keyword research for "AI Marketing Consultant"

### Context gathered
- **Business:** AI marketing consulting for startups
- **Audience:** Funded startups, 10-50 employees, no marketing hire yet
- **Goal:** Leads for consulting engagements
- **Timeline:** Mix of quick wins and authority building

### Seed keywords generated
- AI marketing consultant
- AI marketing strategy
- Marketing automation
- Startup marketing
- Fractional CMO
- AI marketing tools

### Expanded via 6 Circles (sample)

**Circle 1 (What you sell):** AI marketing consultant, AI marketing strategy, AI marketing audit, marketing automation setup

**Circle 2 (Problems):** startup marketing overwhelm, no time for marketing, marketing not working, can't hire marketing team

**Circle 3 (Outcomes):** automated lead generation, consistent content, marketing ROI, scalable marketing

**Circle 4 (Positioning):** AI-first marketing, no-code marketing, startup-focused marketing

**Circle 5 (Adjacent):** startup growth strategies, product-led growth, indie hacker marketing

**Circle 6 (Entities):** Claude AI marketing, n8n marketing automation, HubSpot alternatives

### Clustered into pillars (with competitor validation)

---BEGIN PILLAR---
## Pillar: AI Marketing Strategy

**Priority:** Critical
**Business Value:** H — Direct path to consulting leads
**Opportunity:** H — Category is underserved, thin content dominates
**Speed to Win:** Fast
**Content pieces:** 4

### Competitor Validation

| Site | DR | Content Quality | Winnable? |
|------|-----|-----------------|-----------|
| hubspot.com/ai-marketing | 93 | comprehensive | N — Too authoritative, but angles exist |
| marketingai.com/guide | 45 | moderate | Y — Missing practitioner depth |
| forbes.com/ai-marketing | 95 | thin | Y — Generic overview, no actionable content |

**Overall Assessment:** High-authority sites rank but content is either thin (Forbes) or generic (others). Win path: practitioner-depth content with unique frameworks and real examples.

### Keyword Table

| Cluster | Priority | Intent | Content Type |
|---------|----------|--------|--------------|
| What is AI marketing | H | Informational | Pillar Guide |
| AI marketing examples | H | Commercial | Listicle |
| AI marketing tools | H | Commercial | Comparison |
| AI marketing for startups | M | Commercial | Use Case |

---END PILLAR---

---BEGIN PILLAR---
## Pillar: Marketing Automation

**Priority:** High
**Business Value:** H — Leads to tool setup consulting
**Opportunity:** M — Competitive but niches available
**Speed to Win:** Medium
**Content pieces:** 4

### Competitor Validation

| Site | DR | Content Quality | Winnable? |
|------|-----|-----------------|-----------|
| zapier.com/automation | 89 | comprehensive | N — Product-owned category |
| hubspot.com/automation | 93 | comprehensive | N — Authority too high |
| automationhero.io/guide | 35 | moderate | Y — Startup-focused angle missing |

**Overall Assessment:** Category dominated by tool vendors. Win path: "for startups" and "no-code" angles that big players don't serve.

### Keyword Table

| Cluster | Priority | Intent | Content Type |
|---------|----------|--------|--------------|
| Marketing automation for startups | H | Informational | How-To Guide |
| No-code marketing automation | H | Commercial | Comparison |
| n8n vs Zapier for marketing | M | Commercial | Comparison |
| Marketing workflow templates | M | Transactional | Listicle |

---END PILLAR---

---BEGIN PILLAR---
## Pillar: Fractional Marketing

**Priority:** Medium
**Business Value:** H — Direct service offering
**Opportunity:** M — Growing search trend, moderate competition
**Speed to Win:** Medium
**Content pieces:** 3

### Competitor Validation

| Site | DR | Content Quality | Winnable? |
|------|-----|-----------------|-----------|
| chiefoutsiders.com | 52 | comprehensive | Y — Agency-focused, not startup-focused |
| fractionalcmo.io | 38 | moderate | Y — Generic content, no unique angle |
| growthramp.io/fractional | 42 | thin | Y — Surface-level, no depth |

**Overall Assessment:** No dominant player. Competition is moderate-DR sites with generic content. Win path: startup-specific positioning and transparent pricing/process content.

### Keyword Table

| Cluster | Priority | Intent | Content Type |
|---------|----------|--------|--------------|
| What is a fractional CMO | H | Informational | Definition |
| Fractional CMO vs agency | M | Commercial | Comparison |
| When to hire fractional marketing | M | Commercial | How-To Guide |

---END PILLAR---

### Production Queue

| Priority | Pillar | Business Value | Opportunity | Speed | First Article |
|----------|--------|----------------|-------------|-------|---------------|
| 1 | AI Marketing Strategy | H | H | Fast | What is AI Marketing (Pillar Guide) |
| 2 | Marketing Automation | H | M | Medium | Marketing Automation for Startups |
| 3 | Fractional Marketing | H | M | Medium | What is a Fractional CMO |

### Execution Order

1. **AI Marketing Strategy** — Highest opportunity with fast win potential. Thin content from authority sites = clear differentiation path. This pillar establishes category authority.
2. **Marketing Automation** — Builds on pillar 1 (AI marketing → automation). Startup-focused angle avoids direct competition with tool vendors.
3. **Fractional Marketing** — Direct service offering but requires pillar 1-2 authority first. No rush—moderate competition isn't going anywhere.

---

## What this skill does NOT do

This skill provides **strategic direction**, not:
- Content writing (use seo-content and direct-response-copy skills)
- Technical SEO audits (different skill set)
- Backlink analysis (use dedicated SEO tools)
- On-page optimisation recommendations (handled during content creation)

**Note:** With DataForSEO and Perplexity integration (Phase 2.5), the skill CAN provide search volume data and SERP analysis when those tools are available. Without them, fall back to free tools listed in the "Free tools to supplement" section.

The output is a prioritised plan. Execution is separate.

---

## Free tools to supplement

If the user needs data validation:

- **Google Trends** (trends.google.com) — Trend direction, seasonality
- **Google Search** — SERP analysis, autocomplete, "People Also Ask"
- **AnswerThePublic** (free tier) — Question-based keywords
- **AlsoAsked** (free tier) — PAA relationship mapping
- **Reddit/Quora search** — Real user questions and language

---

## How this connects to other skills

**keyword-research** identifies WHAT to write about.

Then:
- **positioning-angles** → finds the angle for each piece
- **brand-voice** → ensures consistent voice across content
- **direct-response-copy** → writes the actual content

The keyword research creates the content strategy. Other skills execute it.

---

## The test

A good keyword research output:

1. **Actionable** — Clear "start here" recommendation
2. **Prioritized** — Not just a list, but ranked by opportunity
3. **Realistic** — Acknowledges competition and timelines
4. **Strategic** — Connects to business goals, not just traffic
5. **Specific** — Content types and angles, not just keywords

If the output is "here's 500 keywords, good luck" — it failed.
