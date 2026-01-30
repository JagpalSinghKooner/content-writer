---
name: keyword-research
description: "Strategic keyword research without expensive tools. Use when someone needs content strategy, topic ideas, SEO planning, or asks what should I write about. Uses the 6 Circles Method to expand from seed keywords, clusters into content pillars, and maps to a prioritized content plan. Triggers on: keyword research for X, content strategy for X, what topics should I cover, SEO strategy, content calendar, topic clusters. Outputs prioritized keyword clusters with content recommendations."
---

# Keyword Research

**HushAway Context:** Read `.claude/context/keyword-research-context.md` for HushAway-specific requirements.

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
SEED → PERPLEXITY → EXPAND → CLUSTER → PRIORITIZE → MAP
```

1. **Seed** — Get seed keyword from ARTICLE-ORDER.md
2. **Perplexity** — Run 4 MCP queries for real-time validation (MANDATORY)
3. **Expand** — Use 6 Circles Method + Perplexity-discovered keywords
4. **Cluster** — Group into content pillars using PAA questions
5. **Prioritize** — Score by opportunity (informed by competitor gaps)
6. **Map** — Assign clusters to content pieces with research sources

---

## Library Integration (HushAway Workflow)

**IMPORTANT:** For HushAway articles, check the libraries BEFORE validating keywords.

### Before validating keywords:

1. **CHECK `ARTICLE-ORDER.md`** to confirm:
   - Correct article is selected (by priority order)
   - Seed keyword matches the article you're working on
   - Pillar context for clustering opportunities

2. **READ `.claude/keyword-library.md`**:
   - Check "Validated Keywords" table to see all keywords already validated
   - Check "Keyword Clusters" table for cross-pillar linking opportunities
   - Review "Gaps Identified" table for keywords worth pursuing

3. **IDENTIFY** how the new keyword relates to existing validated keywords

### When validating keywords:
- Note if a keyword relates to existing validated keywords (linking opportunities)
- Identify any keyword gaps discovered during research (200+ volume, relevant, not yet targeted)
- Consider how new keywords fit into existing clusters

### After keyword validation:
Include this instruction in your output:

> **Next step:** Update `.claude/keyword-library.md`:
>
> **Validated Keywords table (required):**
> - Article: [article name]
> - Pillar: [pillar number]
> - Target Keyword: [validated keyword]
> - Volume: [search volume]
> - Secondary Keywords: [comma-separated list]
> - Date: [today's date]

This ensures the library grows with each article and provides learning data for future research.

---

## Perplexity MCP Integration (MANDATORY)

**For HushAway articles, Perplexity MCP is required.** The Keyword Gate will FAIL without it.

### Before running this skill:

Verify Perplexity MCP is configured:
```bash
claude mcp list
```
If "perplexity" is not listed, configure it first:
```bash
claude mcp add perplexity --env PERPLEXITY_API_KEY=<your-key>
```

### Perplexity Queries (Run During Keyword Research)

Run these 4 queries using the Perplexity MCP tool during the skill:

**Query 1: Keyword Validation + Trends**
```
Search: "[seed keyword]" UK search trends 2024 2025
Prompt: For the keyword "[seed keyword]", provide:
1. Is this actively searched by UK parents?
2. What related keywords are trending?
3. What seasonal patterns exist?
4. Suggested keyword variations with higher search potential
```

**Query 2: PAA Discovery**
```
Search: Questions parents ask about "[seed keyword]"
Prompt: Find 7+ questions UK parents commonly ask about this topic. Include:
1. Google "People Also Ask" questions
2. Questions from Reddit r/ADHD_parents, r/AutismParenting
3. Questions from UK forums like Mumsnet
Note the search intent for each (informational vs solution-seeking).
```

**Query 3: Competitor SERP Analysis**
```
Search: "[seed keyword]" guide site:uk
Prompt: Analyze the top 5 ranking results. For each, identify:
1. Content type and word count
2. Strengths and gaps
3. Whether they use neurodivergent-affirming language
4. UK vs US focus
```

**Query 4: Source Discovery**
```
Search: Research "[seed keyword]" children 2022-2026 UK
Prompt: Find citable research and statistics. Prioritise:
1. NHS or NICE guidelines
2. Peer-reviewed studies (2022+)
3. UK organisations (ADHD UK, National Autistic Society)
Provide: source name, year, key finding, URL for each.
```

### How to Invoke Perplexity MCP Tools

The AI assistant MUST use these MCP tools during keyword research. The gate verifies `perplexityUsed: true` which should ONLY be set after actual tool invocation.

**For keyword validation and trends (Query 1):**
```
Tool: mcp__perplexity__perplexity_ask
Messages: [{"role": "user", "content": "[seed keyword] UK search trends 2024 2025 - is this actively searched by UK parents? Related keywords? Seasonal patterns?"}]
```

**For PAA question discovery (Query 2):**
```
Tool: mcp__perplexity__perplexity_research
Messages: [{"role": "user", "content": "Questions UK parents ask about [seed keyword] - include Google PAA, Reddit, Mumsnet questions"}]
```

**For SERP and competitor analysis (Query 3):**
```
Tool: mcp__perplexity__perplexity_search
Query: "[seed keyword] guide site:uk"
Max results: 5
```

**For research source discovery (Query 4):**
```
Tool: mcp__perplexity__perplexity_research
Messages: [{"role": "user", "content": "Research [seed keyword] children 2022-2026 UK - NHS, NICE, peer-reviewed studies with URLs"}]
```

**Tool Selection Guide:**
| Query | Best Tool | Why |
|-------|-----------|-----|
| Query 1 (Trends) | `perplexity_ask` | Quick validation, conversational |
| Query 2 (PAA) | `perplexity_research` | Deep research with citations |
| Query 3 (SERP) | `perplexity_search` | Web search with ranked results |
| Query 4 (Sources) | `perplexity_research` | Academic sources with URLs |

### After Perplexity Queries:

The skill output MUST include:
1. `perplexityUsed: true` in research file frontmatter
2. `perplexityDate: [YYYY-MM-DD]`
3. `searchTrend: [rising/stable/declining]` from Query 1
4. Real PAA questions discovered (min 7)
5. Competitor gaps identified
6. Research sources with URLs

**These populate the research file sections automatically.**

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

```
## Pillar: [Topic Name]
**Priority:** [Critical / High / Medium / Low]
**Content pieces:** [Number]

| Cluster | Priority | Intent | Content Type | Target |
|---------|----------|--------|--------------|--------|
| [name]  | [H/M/L]  | [type] | [format]     | [date] |
```

### 90-Day Content Calendar

```
## Month 1
- Week 1-2: [Flagship piece] — [Target keyword cluster]
- Week 3: [Supporting piece] — [Target keyword cluster]
- Week 4: [Supporting piece] — [Target keyword cluster]

## Month 2
- Week 5-6: [Second pillar piece] — [Target keyword cluster]
...
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

### Clustered into pillars

**Pillar 1: AI Marketing Strategy** (Priority: Critical)
- What is AI marketing
- AI marketing examples
- AI marketing tools
- AI marketing for startups

**Pillar 2: Marketing Automation** (Priority: High)
- Marketing automation for startups
- No-code marketing automation
- n8n vs Zapier for marketing
- Marketing workflow templates

**Pillar 3: Fractional Marketing** (Priority: Medium)
- What is a fractional CMO
- Fractional CMO vs agency
- When to hire fractional marketing

### Top 3 recommendations

**1. "What is AI Marketing?" (Do First)**
- Category definition opportunity
- Growing search trend
- Weak competition (thin content dominates)
- You have practitioner expertise
- Pillar guide, 5,000+ words

**2. "AI Marketing Tools 2025" (Do Second)**
- Commercial intent, close to purchase
- Existing content is generic/outdated
- Unique angle: practitioner reviews
- Comparison listicle, 3,000+ words

**3. "Marketing Automation for Startups" (Quick Win)**
- Specific audience match
- Less competitive than broad term
- Clear differentiation path
- How-to guide, 2,500+ words

---

## What this skill does NOT do

This skill provides **strategic direction and research data**, not:
- Content writing (use /seo-content skill)
- Technical SEO audits (different skill set)
- Exact search volume numbers (Perplexity provides trends, not precise volumes)

The output is a validated keyword plan with research data. Content writing is separate.

---

## HushAway Output Format (with Perplexity)

For HushAway articles, the output MUST include these frontmatter fields for the research file:

```yaml
# Keyword Research (validated by Perplexity MCP)
keywordStatus: validated
perplexityUsed: true
perplexityDate: [YYYY-MM-DD]

targetKeyword: "[validated keyword]"
searchTrend: [rising/stable/declining]

secondaryKeywords:
  - "[keyword 1]"
  - "[keyword 2]"
  - "[keyword 3]"
  - "[keyword 4]"
  - "[keyword 5]"

# PAA Questions (from Perplexity Query 2)
paaQuestions:
  - "[Question 1]"
  - "[Question 2]"
  - "[Question 3]"
  - "[Question 4]"
  - "[Question 5]"
  - "[Question 6]"
  - "[Question 7]"

# Competitor Gaps (from Perplexity Query 3)
competitorGaps:
  - "[Gap 1]"
  - "[Gap 2]"
  - "[Gap 3]"

# Research Sources (from Perplexity Query 4)
researchSources:
  - source: "[Source name]"
    year: [YYYY]
    finding: "[Key finding]"
    url: "[URL]"
```

This data automatically populates research file sections 1, 3, 4, 5, and 8.

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
