---
name: start-pillar
description: "Bridge from keyword research to positioning. Extracts a single pillar from the master keyword brief, runs deep competitor analysis, and outputs a focused pillar brief. Use when starting work on a specific content pillar. Triggers on: start pillar X, begin pillar X, pillar brief for X, competitor analysis for X. Outputs a pillar-brief.md ready for positioning-angles."
---

# Start Pillar

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

**Response fields to extract:** `domain_rating` (0-100), `total_backlinks`, `referring_domains`

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

### 3.3 Competitor Validation

For each competitor, compile:
- **DR Score** (0-100) and difficulty tier: DR 70+ = high authority (find angle gaps), DR 50-69 = medium (beatable with better content), DR <50 = lower authority (opportunity)
- **Backlinks** and **referring domains** count
- **Content depth** (H/M/L)
- **Primary angle**
- **Key gap**

### 3.4 Gap Analysis

With competitor data complete, identify:

**Content gaps:** Topics competitors miss, depth they lack, perspectives they ignore, formats they don't use

**Angle gaps:** Common angles everyone uses (crowded), angles no one has claimed (opportunity), contrarian positions available

**Trust gaps:** Missing proof, missing expertise signals, missing specificity

**Authority gaps (from DR analysis):** Can you match/exceed their backlink profile? Where are their referring domains coming from? What link-worthy assets are they missing?

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

Write `01-pillar-brief.md` using the template at `templates/pillar-brief-template.md`.
