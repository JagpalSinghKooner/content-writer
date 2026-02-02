# Integration Test Results: Live Data Validation

**Date:** 2026-02-02
**Purpose:** Validate all external integrations work end-to-end with real data

---

## Summary

| Integration | Endpoint/Tool | Status | Notes |
|-------------|---------------|--------|-------|
| Perplexity Search | `perplexity_search` | **PASS** | 5 results with metadata |
| DataForSEO Volume | `/keywords_data/google/search_volume/live` | **PASS** | Real UK search volumes |
| DataForSEO SERP | `/serp/google/organic/live/regular` | **PASS** | Live SERP data |
| DataForSEO Backlinks | `/backlinks/domain_pages_summary/live` | **FAIL** | Requires separate subscription |
| Perplexity Research | `perplexity_research` | **PASS** | Deep competitor analysis |

**Overall: 4/5 integrations working**

---

## Test 1: Perplexity Search

**Query:** "best project management software 2024"

**Result:** Returned 5 search results with:
- Titles and URLs
- Content snippets
- Publication dates
- Structured data (tables, lists)

**Sample output:**
- thedigitalprojectmanager.com — "40 Best Project Management Software Picked For 2026"
- project-management.com — "Best Project Management Software Reviewed by Experts"
- atlassian.com — "Best For Prioritization And..."
- tech.co — "5. Wrike -- Best For..."
- paymoapp.com — "20+ Best Project Management Software for 2025"

---

## Test 2: DataForSEO Search Volume

**Endpoint:** `https://api.dataforseo.com/v3/keywords_data/google/search_volume/live`

**Test keywords:** Email marketing automation cluster (UK market)

**Results:**

| Keyword | Monthly Volume | CPC | Competition |
|---------|---------------|-----|-------------|
| mailchimp alternatives | 720 | £28.83 | 0.78 |
| email marketing automation | 320 | £47.74 | 0.34 |
| automated email campaigns | 90 | £93.82 | 0.13 |
| drip email campaigns | 90 | — | 0.47 |
| email automation for small business | 10 | — | — |
| email marketing software small business | 10 | — | — |
| best email automation tools | 10 | £51.02 | 0.93 |

**Raw API response (sample):**

```json
{
  "keyword": "email marketing automation",
  "location_code": 2826,
  "language_code": "en",
  "search_partners": false,
  "competition": 0.34,
  "cpc": 47.74,
  "search_volume": 320,
  "monthly_searches": [
    {"year": 2025, "month": 12, "search_volume": 110},
    {"year": 2025, "month": 11, "search_volume": 90},
    {"year": 2025, "month": 10, "search_volume": 140},
    {"year": 2025, "month": 9, "search_volume": 720},
    {"year": 2025, "month": 8, "search_volume": 210},
    {"year": 2025, "month": 7, "search_volume": 170},
    {"year": 2025, "month": 6, "search_volume": 210},
    {"year": 2025, "month": 5, "search_volume": 480},
    {"year": 2025, "month": 4, "search_volume": 480},
    {"year": 2025, "month": 3, "search_volume": 480},
    {"year": 2025, "month": 2, "search_volume": 390},
    {"year": 2025, "month": 1, "search_volume": 320}
  ]
}
```

**Insights:**
- "mailchimp alternatives" (720/mo) highest volume — commercial intent
- Long-tail "small business" keywords have very low UK volume (<100)
- Seasonality visible: September spike (720 vs avg 320)

---

## Test 3: DataForSEO SERP Analysis

**Endpoint:** `https://api.dataforseo.com/v3/serp/google/organic/live/regular`

**Keyword:** "email marketing automation" (UK)

**Results:**

| Rank | Domain | Title | Content Type |
|------|--------|-------|--------------|
| 1 | mailchimp.com | What is Email Marketing Automation? A Beginner's Guide | Definition/Guide |
| 2 | emailtooltester.com | The Best Email Automation Software in 2026 | Listicle |
| 3 | saleshandy.com | Top 11 Email Automation Tools in 2026 [Tried & Tested] | Listicle |
| 4 | bloomreach.com | Email Marketing Automation Guide: Strategies & Examples | Guide |
| 5 | mautic.org | Mautic: Open Source Marketing Automation | Product page |
| 6 | knowledge.hubspot.com | Use automation with emails | Help docs |
| 7 | act.com | Email Marketing Automation - Act! | Product page |
| 8 | zapier.com | The 8 best free email marketing services in 2026 | Listicle |
| 9 | sendgrid.com | Email Marketing Automation Software | Product page |

**Raw API response (sample):**

```json
{
  "type": "organic",
  "rank_group": 1,
  "rank_absolute": 1,
  "domain": "mailchimp.com",
  "title": "What is Email Marketing Automation? A Beginner's Guide",
  "description": "Email automation is a powerful marketing automation tool that lets you send the right message to the right people at the right time, using automated workflows.",
  "url": "https://mailchimp.com/marketing-glossary/email-automation/"
}
```

**Insights:**
- SERP dominated by tool vendors (mailchimp, hubspot, sendgrid, act)
- Independent reviewers rank well (emailtooltester, saleshandy)
- Gap: Small business-focused practical content (not tool comparison)

---

## Test 4: DataForSEO Backlinks (FAILED)

**Endpoint:** `https://api.dataforseo.com/v3/backlinks/domain_pages_summary/live`

**Error:**

```json
{
  "status_code": 40204,
  "status_message": "Access denied. Visit Plans and Subscriptions to activate your subscription and get access to this API"
}
```

**Impact:** Cannot pull Domain Rating (DR) programmatically. Workaround: Estimate DR from domain recognition (hubspot = 90+, unknown = <50).

---

## Test 5: Perplexity Research (Competitor Analysis)

**Query:** Analyse top 5 ranking articles for "email marketing automation for small businesses"

**Results summary:**

### Articles Analysed

1. **EmailVendorSelection** — Platform comparison, feature enumeration
2. **EmailToolTester** — Technical depth, advanced features focus
3. **Campaign Monitor** — Startup-specific guide
4. **YouCanBookMe** — Foundational skills, accessible
5. **HubSpot** — Decision frameworks, evaluation criteria

### Content Gaps Identified

| Gap | Description |
|-----|-------------|
| No strategic sequencing | Which automations to implement first? |
| Missing ROI frameworks | How to measure if automation is working |
| No organisational readiness | Can your team actually implement this? |
| Insufficient list hygiene | The foundation that makes automation work |
| No vertical-specific guidance | E-commerce vs B2B vs services differ |

### Key Insight

> "The small business automation paradox: businesses most likely to benefit from email automation are simultaneously the least likely to have internal expertise to implement it effectively."

**Opportunity:** Content that addresses strategic planning before platform selection would differentiate significantly.

---

## Full Keyword Research Output (Sample)

Using the `/keyword-research` skill with live data:

### Search Volume Data (DataForSEO)

| Keyword | Volume | CPC | Competition | Verdict |
|---------|--------|-----|-------------|---------|
| mailchimp alternatives | 720 | £28.83 | HIGH | Valid pillar |
| email marketing automation | 320 | £47.74 | LOW | Supporting article |
| automated email campaigns | 90 | £93.82 | LOW | Supporting article |
| drip email campaigns | 90 | — | MEDIUM | Supporting article |

### SERP Analysis (DataForSEO)

**Keyword:** "email marketing automation"

| Rank | Domain | Opportunity |
|------|--------|-------------|
| 1 | mailchimp.com | Product-owned, authoritative |
| 2 | emailtooltester.com | Independent reviewer, beatable |
| 3 | saleshandy.com | Moderate authority, beatable |
| 4 | bloomreach.com | Enterprise-focused, different audience |

**Assessment:** SERP shows mix of product pages and listicles. Gap exists for practical small business implementation content.

### Competitor Analysis (Perplexity)

**Dominant positioning:** Platform comparison and feature lists

**Content gaps:**
- No strategic automation sequencing
- Missing ROI measurement guidance
- No organisational readiness frameworks
- Insufficient list hygiene coverage

**Differentiation opportunity:** Strategy-first content that helps businesses decide WHAT to automate before choosing platforms.

---

## API Costs

| Endpoint | Cost per call |
|----------|---------------|
| Search volume (7 keywords) | $0.075 |
| SERP analysis (1 keyword) | $0.002 |
| Perplexity search | Included in MCP |
| Perplexity research | Included in MCP |

**Estimated cost per full keyword research:** ~$0.50-1.00 (depending on keyword count and SERP depth)

---

## Conclusion

The integration stack is production-ready for keyword research:

1. **DataForSEO search volume** — Provides real UK search data for prioritisation
2. **DataForSEO SERP** — Shows competitive landscape and content gaps
3. **Perplexity research** — Adds qualitative competitor analysis
4. **Perplexity search** — Quick fact-checking and trend validation

**Missing:** Backlinks/DR data (requires separate subscription, not blocking)

The `/keyword-research` skill can now produce data-backed keyword briefs with real search volumes and SERP analysis instead of estimates.
