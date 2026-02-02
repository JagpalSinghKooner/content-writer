# API Costs Reference

Personal reference for API pricing. Not loaded into skills (reduces context).

---

## DataForSEO

**Account:** jagpal_kooner@hotmail.co.uk

### Labs API (Keyword Research)

| Endpoint | Cost | Notes |
|----------|------|-------|
| `/dataforseo_labs/google/keyword_suggestions/live` | ~$0.05-0.10 | Returns 100+ keywords with full metrics |
| `/dataforseo_labs/google/bulk_keyword_difficulty/live` | ~$0.05 per 1,000 keywords | Quick KD validation |
| `/dataforseo_labs/google/related_keywords/live` | ~$0.05-0.10 | Semantic expansion |
| `/dataforseo_labs/google/keyword_ideas/live` | ~$0.05-0.10 | Broadest expansion |

### SERP API

| Endpoint | Cost | Notes |
|----------|------|-------|
| `/serp/google/organic/live/regular` | ~$0.002 | Basic organic results |
| `/serp/google/organic/live/advanced` | ~$0.002 | Full SERP features (PAA, snippets, videos) |

### Keywords Data API

| Endpoint | Cost | Notes |
|----------|------|-------|
| `/keywords_data/google/search_volume/live` | ~$0.01 per keyword | Volume, CPC, Ads competition |

### Backlinks API

| Endpoint | Cost | Notes |
|----------|------|-------|
| `/backlinks/domain_rating/live` | Requires separate subscription | Error 40204 on current plan |
| `/backlinks/domain_pages_summary/live` | Requires separate subscription | Error 40204 on current plan |

### Estimated Costs Per Task

| Task | Estimated Cost |
|------|----------------|
| Full keyword research (5 seeds, 100 keywords each) | $0.50-1.00 |
| SERP analysis (5 priority keywords) | $0.01 |
| Quick KD check (50 keywords) | $0.05 |

---

## Perplexity MCP

| Tool | Cost |
|------|------|
| `perplexity_search` | Included in API subscription |
| `perplexity_ask` | Included in API subscription |
| `perplexity_research` | Included in API subscription |
| `perplexity_reason` | Included in API subscription |

---

## Notes

- DataForSEO charges per successful API call
- Check dashboard for current balance: https://app.dataforseo.com/
- Costs are approximate and may vary based on parameters
- Last validated: 2026-02-02
