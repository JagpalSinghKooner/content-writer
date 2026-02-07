---
name: keyword-research
description: "Strategic keyword research without expensive tools. Use when someone needs content strategy, topic ideas, SEO planning, or asks what should I write about. Uses the 6 Circles Method to expand from seed keywords, clusters into content pillars, and maps to a prioritized content plan. Triggers on: keyword research for X, content strategy for X, what topics should I cover, SEO strategy, content calendar, topic clusters. Outputs prioritized keyword clusters with content recommendations."
---

# Keyword Research

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

### DataForSEO Labs

Use the DataForSEO Labs API for keyword expansion, metrics, and SERP analysis. Returns search volume, organic keyword difficulty (0-100), search intent, SERP features, and backlinks data.

**Primary endpoint:** `/dataforseo_labs/google/keyword_suggestions/live` with `include_serp_info: true` for full metrics in a single call.

**Full API reference, endpoints, parameters, response formats, and thresholds:** See [references/dataforseo-api.md](references/dataforseo-api.md).

---

### Perplexity MCP

Use Perplexity MCP tools for competitor content analysis and trend validation. Complements DataForSEO's quantitative data with qualitative insights.

**Prompts, use cases, and extraction patterns:** See [references/perplexity-prompts.md](references/perplexity-prompts.md).

---

### Integrating Data into the Workflow

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

**Data points captured with data enhancement:**
- **Search volume** — from `keyword_suggestions`
- **Keyword difficulty** — organic KD (0-100) from `keyword_suggestions`
- **Search intent** — from `keyword_suggestions`
- **SERP features** — from `keyword_suggestions` + `serp/advanced`
- **PAA questions** — from `serp/advanced`
- **Related searches** — from `serp/advanced`
- **Backlinks data** — from `keyword_suggestions`

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

- **Search volume** — Google Keyword Planner (requires Ads account)
- **Keyword difficulty** — Ubersuggest free tier, Keywords Everywhere
- **SERP analysis** — Manual Google search + Moz/Ahrefs free tools
- **PAA questions** — AlsoAsked.com free tier
- **Competitor analysis** — Manual review + ChatGPT/Claude analysis
- **Trends** — Google Trends

The skill works without external tools — data just makes prioritisation more accurate.

---

## Phase 3: Cluster

Group expanded keywords into content pillars using the hub-and-spoke model: each pillar is a major topic area with clusters of related keywords underneath.

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

- **Product-centric (wrong):** "Our methodology", "[Your tool name] tutorials", "Why we're different", Features of your product
- **Market-centric (right):** "Marketing automation", "[Category] tutorials", "[Problem] solutions", Outcomes people search for

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

- **Proprietary data others don't have** — Prioritise highly
- **Unique methodology or framework** — Prioritise highly
- **Practitioner experience (done it, not read about it)** — Prioritise
- **Same info everyone else has** — Deprioritise

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

## Phase 4: Prioritise

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

- **DO FIRST:** High value + High opportunity + Fast
- **DO SECOND:** High value + High opportunity + Medium speed
- **DO THIRD:** High value + Medium opportunity + Fast
- **QUICK WIN:** Medium value + High opportunity + Fast
- **LONG PLAY:** High value + Low opportunity + Any speed
- **BACKLOG:** Low value + Any opportunity + Any speed

---

## Phase 5: Map to Content

For each priority cluster, assign:

### Content type

- **Pillar Guide** — Comprehensive topic coverage (5,000-8,000 words)
- **How-To Tutorial** — Step-by-step instructions (2,000-3,000 words)
- **Comparison** — X vs Y, Best [category] (2,500-4,000 words)
- **Listicle** — Tools, examples, tips (2,000-3,000 words)
- **Use Case** — Industry or scenario specific (1,500-2,500 words)
- **Definition** — What is [term] (1,500-2,500 words)

### Intent matching

- **Informational** (what, how, why, guide) — Educate thoroughly → Newsletter/resource CTA
- **Commercial** (best, vs, review, compare) — Help them decide → Free trial/demo CTA
- **Transactional** (buy, pricing, get, hire) — Make it easy → Purchase/contact CTA

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
