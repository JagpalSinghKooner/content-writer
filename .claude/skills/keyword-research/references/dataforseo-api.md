# DataForSEO Labs API Reference

Everything about DataForSEO Labs API endpoints used in keyword research: parameters, result interpretation, thresholds, and SERP analysis.

---

## Keyword Suggestions Endpoint

**URL:** `/dataforseo_labs/google/keyword_suggestions/live`

The primary tool for keyword expansion + full metrics. With `include_serp_info: true`, a single call returns search volume, keyword difficulty, search intent, SERP features, and backlinks data.

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
- `keyword` (string): Seed keyword to expand
- `location_code` (2826): UK (use 2840 for US)
- `language_code` ("en"): English
- `include_serp_info` (true): **Critical** — Returns KD, intent, SERP features
- `limit` (100): Keywords per request (max 1,000)

---

## Interpreting Results

**Example response:**

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

**Result fields:**
- `search_volume` (in `keyword_info`): Average monthly searches
- `keyword_difficulty` (in `keyword_properties`): **Organic** ranking difficulty (0-100)
- `main_intent` (in `search_intent_info`): Search intent classification
- `serp_item_types` (in `serp_info`): SERP features present for this keyword
- `backlinks` (in `avg_backlinks_info`): Avg backlinks on ranking pages

---

## Keyword Difficulty Thresholds

- **0-29 (Easy):** Target immediately — quick wins
- **30-49 (Medium):** Winnable with quality content
- **50-69 (Hard):** Requires authority + great content
- **70-100 (Very Hard):** Long-term play, needs link building

---

## Volume Thresholds for UK Market

- **>5,000:** High-priority pillar
- **1,000-5,000:** Valid pillar
- **500-1,000:** Strong supporting article
- **100-500:** Supporting article if highly relevant
- **<100:** Skip unless zero-competition niche

---

## Bulk Keyword Difficulty Endpoint

**URL:** `/dataforseo_labs/google/bulk_keyword_difficulty/live`

Use when you have an existing keyword list and need organic KD scores quickly.

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

## Advanced SERP Analysis Endpoint

**URL:** `/serp/google/organic/live/advanced`

Use for deep SERP analysis. Returns full SERP features including People Also Ask questions, related searches, and videos.

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
- `depth` (10): Number of organic results (10 = page 1)
- `location_code` (2826): UK
- `keyword` (string): Single keyword per request

---

## Response Structure

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

---

## SERP Item Types

What to extract from each item type and how to use it:

- **`organic`:** Extract titles, domains, descriptions. Use for competitive analysis, angle finding.
- **`people_also_search`:** Extract related search queries. Use for additional keyword ideas.
- **`related_searches`:** Extract bottom-of-SERP suggestions. Use for long-tail expansion.
- **`people_also_ask`:** Extract PAA questions (if present). Use for FAQ section content, subheadings.
- **`featured_snippet`:** Extract snippet holder + content. Target for position zero.
- **`video`:** Note video results present. Consider video content.

---

## Organic Results Data Points

What to assess from organic results and how it affects decisions:

- **Domain patterns:** All big brands vs mix? All DR 80+ = harder to win.
- **Content types ranking:** Guides? Listicles? Tools? Match or differentiate format.
- **Title patterns:** What angles dominate? Find unclaimed angles.
- **Content freshness:** Check timestamps. Outdated content = opportunity.
- **SERP features:** Featured snippets? PAA? Target these specifically.

---

## Competitive Assessment Matrix

- **All DR 80+ sites, comprehensive content (Very Hard):** Find niche angle or skip.
- **Mix of DR 50-80, moderate content (Medium):** Winnable with great content.
- **DR <50 sites, thin content (Easy):** High priority, move fast.
- **No clear winner, varied content (Medium):** Opportunity to define category.
