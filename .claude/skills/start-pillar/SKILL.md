---
name: start-pillar
description: "Bridge from keyword research to positioning. Extracts a single pillar from the master keyword brief, runs deep competitor analysis, and outputs a focused pillar brief. Use when starting work on a specific content pillar. Triggers on: start pillar X, begin pillar X, pillar brief for X, competitor analysis for X. Outputs a pillar-brief.md ready for positioning-angles."
---

# Start Pillar

Keyword research gives you the map. This skill zooms in on one territory.

It extracts a single pillar from your master keyword brief, runs competitor analysis to find gaps and opportunities, and outputs a focused brief that fits in context for positioning work.

---

## The core job

Transform a pillar from your keyword research into an **actionable brief** with:
- Strategic context (why this pillar, why now)
- Keyword table (all terms in the cluster)
- Competitor analysis (top 3 competitors, their angles, their gaps)
- Content plan (articles to write, in priority order)
- Angle opportunities (positioning directions to explore)
- Internal linking map (how articles connect)
- Publishing order (sequence with dependencies mapped)

**Output:** A 1,000-1,500 word `01-pillar-brief.md` that gives positioning-angles everything it needs.

---

## How to run

```
/start-pillar [pillar-name]
```

**Required:**
- Pillar name (must match a pillar in your 00-keyword-brief.md)
- Working directory set to the project folder (e.g., `/projects/client-name/project-name/`)

**Example:**
```
/start-pillar ai-marketing-strategy
```

---

## The process

```
EXTRACT → RESEARCH → ANALYSE → PLAN → OUTPUT
```

1. **Extract** — Pull the pillar section from 00-keyword-brief.md
2. **Research** — Search for top-ranking content on pillar keywords
3. **Analyse** — Identify competitor angles, gaps, and opportunities
4. **Plan** — Map keywords to articles with priorities
5. **Output** — Create pillar-brief.md and folder structure

---

## Step 1: Extract the pillar

Read `00-keyword-brief.md` from the current project directory.

Find the section matching the pillar name. Extract:
- Pillar keyword (the main term)
- Priority level
- All clusters within this pillar
- All keywords within those clusters
- Content type recommendations (if present)

If the pillar doesn't exist in the brief, stop and ask the user to verify the name.

---

## Step 2: Research competitors

For the pillar's primary keyword, search:

1. **"[pillar keyword]"** — Find who ranks
2. **"[pillar keyword] guide"** — Find comprehensive content
3. **"best [pillar keyword]"** — Find commercial content

Identify the **top 3 competitors** for this pillar. For each:
- Domain/brand name
- Content type (guide, listicle, tool page, etc.)
- Primary angle (how they position the content)
- Content depth (word count estimate, comprehensiveness)
- Unique elements (tools, templates, data, visuals)

---

## Step 3: Competitor Deep-Dive

With competitors identified, run deep analysis using DataForSEO and Perplexity.

### 3.1 Get Domain Rating (DataForSEO API)

Call DataForSEO `/backlinks/domain_rating/live` to get actual DR scores for each competitor URL.

**API Request Format:**

```bash
curl --location 'https://api.dataforseo.com/v3/backlinks/domain_rating/live' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic YOUR_API_KEY' \
--data '[
  {
    "target": "competitor-domain.com"
  }
]'
```

**Response fields to extract:**
- `domain_rating` — The DR score (0-100)
- `total_backlinks` — Total backlinks pointing to domain
- `referring_domains` — Unique domains linking to target

Run this for each competitor URL identified in Step 2.

### 3.2 Deep Content Analysis (Perplexity MCP)

Use Perplexity to analyse competitor content depth and strategy.

**Analysis prompt:**

```
Analyse the content at [competitor URL] for:
1. Main angle/positioning used
2. Content structure and depth
3. Unique elements (data, tools, templates, visuals)
4. Trust signals (author credentials, citations, proof)
5. Gaps in coverage (what they miss or handle poorly)
6. Target audience signals
```

Use `mcp__perplexity__perplexity_ask` for quick competitor analysis or `mcp__perplexity__perplexity_research` for comprehensive deep-dives.

### 3.3 Competitor Validation Table

Compile findings into a validation table:

| Competitor | DR Score | Backlinks | Referring Domains | Content Depth | Primary Angle | Key Gap |
|------------|----------|-----------|-------------------|---------------|---------------|---------|
| [Domain 1] | [0-100]  | [count]   | [count]           | [H/M/L]       | [angle]       | [gap]   |
| [Domain 2] | [0-100]  | [count]   | [count]           | [H/M/L]       | [angle]       | [gap]   |
| [Domain 3] | [0-100]  | [count]   | [count]           | [H/M/L]       | [angle]       | [gap]   |

**Interpreting DR scores:**
- **DR 70+:** High authority, hard to outrank directly — find angle gaps
- **DR 50-69:** Medium authority, beatable with better content + links
- **DR <50:** Lower authority, opportunity for comprehensive coverage

### 3.4 Gap Analysis

With competitor data complete, identify:

**Content gaps:**
- Topics competitors miss entirely
- Depth they lack (surface-level coverage)
- Perspectives they ignore (specific audiences, use cases)
- Formats they don't use (templates, tools, checklists)

**Angle gaps:**
- Common angles everyone uses (crowded positioning)
- Angles no one has claimed (opportunity)
- Contrarian positions available (challenge assumptions)

**Trust gaps:**
- Missing proof (no data, no examples)
- Missing expertise signals (no practitioner voice)
- Missing specificity (vague, generic advice)

**Authority gaps (from DR analysis):**
- Can you match/exceed their backlink profile?
- Where are their referring domains coming from?
- What link-worthy assets are they missing?

---

## Step 4: Plan the content

Map keywords to articles:

**Pillar article (1):**
- Targets the primary pillar keyword
- Comprehensive coverage (3,000-5,000+ words)
- Links out to all supporting articles
- Publishes LAST (after supporting content exists)

**Supporting articles (3-7):**
- Each targets a cluster within the pillar
- Focused coverage (1,500-2,500 words)
- Links to pillar and 1-2 other supporting articles
- Publish in priority order

**Article numbering:**

Number articles sequentially, reserving the final number for the pillar guide:

- Supporting articles: `01`, `02`, `03`... in priority/publishing order
- Pillar guide: Highest number (publishes last)
- Example: 10 supporting articles + pillar guide = articles `01`-`10` are supporting, `11` is the pillar guide

**Priority criteria:**
1. Business value (commercial intent, close to conversion)
2. Opportunity (weak competition, content gaps)
3. Quick wins (can rank faster)
4. Linking value (enables other articles)

**Publishing order:**

After prioritising articles, map their dependencies:
- Which articles introduce concepts used by later articles?
- Which must exist for internal links to work?
- Which can publish in parallel (same dependencies)?

Create a publishing order table with:
- **Order:** Sequence number (1, 2, 3...)
- **Article:** Title of the article
- **Depends On:** Which earlier articles must publish first (use # references)
- **Notes:** Why this order matters (foundational, linking, strategic)

The pillar guide always publishes last—it links to all supporting articles.

---

## Step 5: Output

### Create folder structure

```
{pillar-name}/
  01-pillar-brief.md
  02-positioning.md (created by positioning-angles)
  articles/
  distribution/ (created by content-atomizer)
```

The `articles/` folder will hold individual article files as they're created (named `{nn}-{slug}.md`).

### Write 01-pillar-brief.md

Use this exact format (keeps context compact):

```markdown
# Pillar Brief: [Pillar Name]

## 1. Strategic Context

**Pillar:** [Primary keyword]
**Priority:** [From keyword brief]
**Why now:** [1-2 sentences on opportunity]
**Proprietary advantage:** [What unique angle/data/expertise you bring]

---

## 2. Keyword Table

| Keyword | Intent | Volume | Difficulty | Article |
|---------|--------|--------|------------|---------|
| [term]  | [I/C/T] | [H/M/L] | [H/M/L]   | [#]     |

Intent: I=Informational, C=Commercial, T=Transactional
Volume/Difficulty: H=High, M=Medium, L=Low
Article: Number reference to content plan

---

## 3. Competitor Analysis

### Competitor Metrics

| Competitor | DR Score | Backlinks | Referring Domains | Difficulty |
|------------|----------|-----------|-------------------|------------|
| [Domain 1] | [0-100]  | [count]   | [count]           | [H/M/L]    |
| [Domain 2] | [0-100]  | [count]   | [count]           | [H/M/L]    |
| [Domain 3] | [0-100]  | [count]   | [count]           | [H/M/L]    |

*DR scores from DataForSEO `/backlinks/domain_rating/live`*

### [Competitor 1]
- **URL:** [link]
- **DR Score:** [0-100]
- **Angle:** [their positioning]
- **Strengths:** [what they do well]
- **Gaps:** [what they miss]

### [Competitor 2]
- **URL:** [link]
- **DR Score:** [0-100]
- **Angle:** [their positioning]
- **Strengths:** [what they do well]
- **Gaps:** [what they miss]

### [Competitor 3]
- **URL:** [link]
- **DR Score:** [0-100]
- **Angle:** [their positioning]
- **Strengths:** [what they do well]
- **Gaps:** [what they miss]

---

## 4. Content Plan

### Article 1: [Title] (PRIORITY: Do First)
- **Target keyword:** [primary]
- **Secondary keywords:** [list]
- **Content type:** [guide/how-to/listicle/comparison]
- **Word count:** [range]
- **Angle opportunity:** [brief]

### Article 2: [Title]
[Same structure]

### Article 3: [Title]
[Same structure]

[Continue for all planned articles]

### Pillar Article: [Title] (PUBLISH LAST)
- **Target keyword:** [pillar keyword]
- **Secondary keywords:** [list]
- **Content type:** Comprehensive guide
- **Word count:** [range]
- **Links to:** Articles 1-N

---

## 5. Angle Opportunities

Based on competitor gaps, these angles are available:

1. **[Angle name]:** [One sentence description]
2. **[Angle name]:** [One sentence description]
3. **[Angle name]:** [One sentence description]

**Recommended starting angle:** [Which one and why]

---

## 6. Internal Linking Map

```
[Pillar Article]
    |
    +-- [Article 1] -- [Article 2]
    |       |
    +-- [Article 3] -- [Article 4]
    |
    +-- [Article 5]
```

**Linking rules for this pillar:**
- Every article links to pillar (when published)
- Each article links to 1-2 related supporting articles
- [Any specific linking notes]

**Link Timing:**

| Link Type | When Added |
|-----------|------------|
| Links TO pillar guide | After pillar guide published |
| Links BETWEEN supporting articles | During writing if target exists, otherwise use placeholder |
| Links FROM pillar guide | During pillar guide writing (all supporting articles exist) |

**Placeholder convention:** When an article needs to link to content that doesn't exist yet:
```html
<!-- LINK NEEDED: [slug] when published -->
```

**Post-pillar linking pass:** After pillar guide publishes, replace all placeholders with actual links and add links TO the pillar guide from all supporting articles.

---

## 7. Publishing Order

| Order | Article | Depends On | Notes |
|-------|---------|------------|-------|
| 1     | [Title] | None       | [Why first - foundational/quick win] |
| 2     | [Title] | #1         | [Dependency reason] |
| 3     | [Title] | #1, #2     | [Dependency reason] |
| N     | [Pillar Guide] | All above | Publish last - links to all |

**Dependency types:**
- Content: Explains concepts needed by later articles
- Linking: Must exist for internal links to work
- Strategic: Business reasons for this order
```

---

## What this skill does NOT do

This skill prepares the brief. It does NOT:
- Write the actual content (use /seo-content)
- Find the final positioning (use /positioning-angles)
- Create the keyword research (use /keyword-research first)
- Validate finished content (use /validate-content)

The output is strategic preparation. Execution happens downstream.

---

## How this connects to other skills

**Before this skill:**
- `/keyword-research` creates the master brief with all pillars
- `/onboard-client` ensures client profile exists

**After this skill:**
- `/positioning-angles` finds the specific angle for each article
- `/seo-content` writes the actual content
- `/direct-response-copy` adds conversion elements

**Workflow:**
```
keyword-research → start-pillar → positioning-angles → seo-content → validate
```

---

## The test

A good pillar brief answers these questions:

1. **Why this pillar?** (strategic context is clear)
2. **What keywords?** (complete table, no guessing)
3. **Who's winning?** (competitor analysis is specific)
4. **What's the plan?** (articles are prioritised)
5. **What's our angle?** (opportunities are identified)
6. **How does it connect?** (linking map is clear)
7. **What publishes when?** (publishing order with dependencies mapped)

If any answer is vague, the brief isn't ready for positioning work.

---

## Example: Starting the "AI Marketing Strategy" pillar

**Input:**
```
/start-pillar ai-marketing-strategy
```

**Actions taken:**
1. Read 00-keyword-brief.md, extract "AI Marketing Strategy" pillar
2. Search "ai marketing strategy", "ai marketing strategy guide", "best ai marketing strategy"
3. Analyse top 3 results (HubSpot, Sprout Social, Salesforce)
4. Identify gaps: no practitioner perspective, no 2025 tools coverage, generic advice
5. Create folder: `ai-marketing-strategy/articles/`
6. Write pillar-brief.md with all 6 sections

**Output:**
- `ai-marketing-strategy/01-pillar-brief.md` (1,200 words)
- Empty `ai-marketing-strategy/articles/` folder ready for content
- Clear next step: run `/positioning-angles` on Article 1
