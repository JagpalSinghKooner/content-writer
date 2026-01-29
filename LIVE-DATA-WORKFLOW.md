# Live Data Workflow for SEO Keyword Research

**Purpose:** Integrate real-time keyword data into the content workflow using MCP (Model Context Protocol) servers for DataForSEO and Perplexity.

**Status:** PARTIALLY IMPLEMENTED

---

## Implementation Status

| MCP Server | Status | Integration Point | Date |
|------------|--------|-------------------|------|
| **Perplexity MCP** | IMPLEMENTED | Step 2: /keyword-research | 2026-01-29 |
| **DataForSEO MCP** | PLANNED | Step 2: exact volumes (future) | - |

---

## Overview

The `/keyword-research` skill now integrates Perplexity MCP for real-time search data:

1. **Perplexity MCP** (ACTIVE) - Real-time search trends, competitor insights, PAA questions, research sources
2. **DataForSEO MCP** (PLANNED) - Exact keyword volumes, difficulty scores, SERP data

Perplexity runs during Step 2 (/keyword-research) and is MANDATORY. The Keyword Gate verifies `perplexityUsed: true`.

---

## Perplexity Integration Verification Points

| Gate | Perplexity Check | Status |
|------|------------------|--------|
| Gate 1: Keyword | `perplexityUsed: true`, `perplexityDate`, `searchTrend`, 7+ PAA, 2+ gaps, 2+ sources | IMPLEMENTED |
| Gate 2: Research | `perplexityUsed: true` verification, date freshness (<30 days) | IMPLEMENTED |
| Gate 3: Angle | (No direct check - uses research data) | N/A |
| Gate 4: Content | (No direct check - verifies citations exist) | N/A |
| Gate 5: Conversion | (No direct check) | N/A |
| Gate 6: Final | (No direct check) | N/A |

**Data Flow:**
```
Perplexity MCP → Research File Frontmatter → Gate 1 (Keyword) → Gate 2 (Research) → Article
     ↓                      ↓                     ↓                   ↓
  4 queries          YAML fields verified    11 checks           Freshness check
```

---

## Current Gap (After Perplexity Implementation)

| What We Have | What We Need | Status |
|--------------|--------------|--------|
| Seed keywords in ARTICLE-ORDER.md | Validated search volumes | Perplexity provides trends |
| Strategic keyword frameworks | Real difficulty/competition data | DataForSEO (planned) |
| Perplexity competitor research | Exact SERP positions | DataForSEO (planned) |
| Trend-based volumes | Actual monthly search data | DataForSEO (planned) |
| Dynamic secondary keywords | Exact volume per keyword | DataForSEO (planned) |
| Real PAA questions | - | SOLVED (Perplexity) |
| Real competitor gaps | - | SOLVED (Perplexity) |
| Research sources with URLs | - | SOLVED (Perplexity) |

---

## DataForSEO MCP

### What It Provides

| API Endpoint | Use Case |
|--------------|----------|
| **Keywords Data API** | Search volume, CPC, competition, keyword difficulty |
| **SERP API** | Live search results, featured snippets, PAA questions |
| **DataForSEO Labs** | Related keywords, keyword suggestions, content gaps |
| **On-Page API** | Content analysis, keyword density |
| **Backlinks API** | Competitor link profiles |

### Installation

**Option 1: NPM**
```bash
npm install @anthropic-ai/mcp-server-dataforseo
```

**Option 2: Docker**
```bash
docker pull dataforseo/mcp-server
```

### Configuration

Add to Claude Code MCP settings (`.claude/settings.json` or global config):

```json
{
  "mcpServers": {
    "dataforseo": {
      "command": "npx",
      "args": ["@anthropic-ai/mcp-server-dataforseo"],
      "env": {
        "DATAFORSEO_LOGIN": "<your-login>",
        "DATAFORSEO_PASSWORD": "<your-password>"
      }
    }
  }
}
```

### API Credentials

1. Sign up at: https://dataforseo.com/
2. Get API credentials from dashboard
3. Store securely (environment variables, not in code)

### Pricing Considerations

DataForSEO uses a credit-based system:
- Keywords Data API: ~0.05 credits per keyword
- SERP API: ~0.1 credits per search
- Estimate per article: 50-100 credits (seed + secondaries + SERP)

**Recommendation:** Start with prepaid credits to control costs during testing.

---

## Perplexity MCP

### What It Provides

| Capability | Use Case |
|------------|----------|
| Real-time web search | Current trends, recent articles |
| Source citations | Find authoritative sources for EEAT |
| Competitor content analysis | What's ranking now |
| Topical clustering | Related topics and angles |
| Question discovery | Real PAA-style questions |

### Installation

```bash
npm install @anthropic-ai/mcp-server-perplexity
```

### Configuration

Add to Claude Code MCP settings:

```json
{
  "mcpServers": {
    "perplexity": {
      "command": "npx",
      "args": ["@anthropic-ai/mcp-server-perplexity"],
      "env": {
        "PERPLEXITY_API_KEY": "<your-api-key>"
      }
    }
  }
}
```

### API Credentials

1. Sign up at: https://www.perplexity.ai/
2. Get API key from developer settings
3. Store securely

### Pricing Considerations

Perplexity API pricing:
- Per-query pricing model
- Estimate per article: 5-10 queries (SERP review, competitor analysis, trend check)

---

## Integrated Workflow

### Updated Step 2: Keyword Research with Live Data

```
CURRENT WORKFLOW (No Live Data):
┌─────────────────────────────────────────────────────────┐
│ Step 2: /keyword-research                               │
│                                                         │
│ Input: Seed keyword from claude.md                      │
│ Process: Strategic frameworks only                      │
│ Output: Recommended keywords (no validation)            │
└─────────────────────────────────────────────────────────┘

PROPOSED WORKFLOW (With Live Data):
┌─────────────────────────────────────────────────────────┐
│ Step 2: /keyword-research (Enhanced)                    │
│                                                         │
│ Input: Seed keyword from claude.md                      │
│                                                         │
│ Phase 1: DataForSEO Validation                          │
│   → Get exact search volume for seed keyword            │
│   → Get keyword difficulty score                        │
│   → Get related keywords with volumes                   │
│   → Identify keyword opportunities (high vol, low diff) │
│                                                         │
│ Phase 2: Perplexity SERP Analysis                       │
│   → Analyze current top 5 results                       │
│   → Identify content gaps in ranking pages              │
│   → Find trending subtopics                             │
│   → Discover real PAA questions                         │
│                                                         │
│ Phase 3: Strategic Synthesis                            │
│   → Apply existing skill frameworks                     │
│   → Combine with live data insights                     │
│   → Prioritize based on opportunity score               │
│                                                         │
│ Output: Validated keywords with real data               │
└─────────────────────────────────────────────────────────┘
```

### Data Flow Diagram

```
                    ┌──────────────────┐
                    │  Seed Keyword    │
                    │  from claude.md  │
                    └────────┬─────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
     ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
     │ DataForSEO  │  │ Perplexity  │  │ Skill       │
     │ MCP         │  │ MCP         │  │ Frameworks  │
     └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
            │                │                │
            ▼                ▼                ▼
     ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
     │ • Volume    │  │ • SERP gaps │  │ • 6 Circles │
     │ • Difficulty│  │ • Trends    │  │ • Clusters  │
     │ • Related   │  │ • Questions │  │ • Priority  │
     │ • CPC       │  │ • Sources   │  │ • Intent    │
     └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
            │                │                │
            └────────────────┼────────────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ VALIDATED OUTPUT │
                    │ • Target keyword │
                    │ • Real volume    │
                    │ • Secondary list │
                    │ • Opp. score     │
                    │ • Content gaps   │
                    └──────────────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  KEYWORD GATE    │
                    │  (Enhanced)      │
                    └──────────────────┘
```

---

## Updated Keyword Gate Checks

The keyword gate script would be enhanced to verify live data was used:

| Current Check | Enhanced Check |
|---------------|----------------|
| keywordStatus = validated | keywordStatus = validated |
| targetKeyword exists | targetKeyword exists + **has live volume** |
| 5+ secondary keywords | 5+ secondary keywords + **with volumes** |
| searchVolume documented | searchVolume = **real number from DataForSEO** |
| Skill evidence markers | **dataSource: dataforseo** in frontmatter |

### New Frontmatter Fields

```yaml
---
# Gate 1: Keyword Research (Enhanced with Live Data)
keywordStatus: validated
dataSource: dataforseo  # NEW - proves live data used
dataFetchedDate: 2026-01-28  # NEW - when data was pulled

targetKeyword: "adhd apps for kids"
targetKeywordVolume: 25000  # NEW - real volume
targetKeywordDifficulty: 45  # NEW - difficulty score

secondaryKeywords:
  - keyword: "adhd apps for children"
    volume: 8100
  - keyword: "best adhd apps"
    volume: 12000
  - keyword: "focus apps for adhd"
    volume: 4500
  - keyword: "adhd organisation apps"
    volume: 2200
  - keyword: "adhd timer apps"
    volume: 1800

serpGaps:  # NEW - from Perplexity analysis
  - "No articles focus on UK-specific apps"
  - "Missing neurodivergent-first perspective"
  - "No sound therapy alternatives mentioned"

trendingSubtopics:  # NEW - from Perplexity
  - "AI-powered ADHD support"
  - "Sensory-friendly app design"
---
```

---

## Implementation Steps

### Phase 1: Setup (Prerequisites)

- [ ] Sign up for DataForSEO account
- [ ] Get DataForSEO API credentials
- [ ] Sign up for Perplexity API access
- [ ] Get Perplexity API key
- [ ] Estimate monthly API costs based on content volume

### Phase 2: MCP Installation

- [ ] Install DataForSEO MCP server
- [ ] Configure DataForSEO credentials
- [ ] Test DataForSEO connection
- [ ] Install Perplexity MCP server
- [ ] Configure Perplexity credentials
- [ ] Test Perplexity connection

### Phase 3: Skill Update

- [ ] Update `/keyword-research` skill to use MCP tools
- [ ] Add DataForSEO query functions
- [ ] Add Perplexity analysis functions
- [ ] Update output format with live data fields
- [ ] Test with sample keyword

### Phase 4: Gate Update

- [ ] Update `check-keyword-gate.sh` to verify live data
- [ ] Add dataSource check
- [ ] Add volume validation (must be number, not estimate)
- [ ] Test gate with enhanced research file

### Phase 5: Documentation

- [ ] Update `agents.md` with live data workflow
- [ ] Update `write-article.md` with new frontmatter fields
- [ ] Update `claude.md` to reference live data process
- [ ] Create troubleshooting guide for API issues

---

## Cost Estimate

### Per Article

| Service | Queries | Est. Cost |
|---------|---------|-----------|
| DataForSEO Keywords | 1 seed + 10 related | ~$0.50 |
| DataForSEO SERP | 1 query | ~$0.10 |
| Perplexity | 5-10 queries | ~$0.50-1.00 |
| **Total per article** | | **~$1.10-1.60** |

### Monthly (77 articles total)

| Scenario | Articles/Month | Est. Cost |
|----------|----------------|-----------|
| Light | 5 articles | ~$8 |
| Medium | 10 articles | ~$16 |
| Heavy | 20 articles | ~$32 |

---

## Fallback Strategy

If API calls fail or budget is exhausted:

1. **Graceful degradation** - Skill continues with frameworks only
2. **Cache recent data** - Reuse keyword data less than 30 days old
3. **Manual override** - Allow proceeding with documented reason
4. **Rate limiting** - Spread queries across sessions

---

## Security Considerations

- [ ] API keys stored in environment variables only
- [ ] Never commit credentials to repository
- [ ] Use `.env` file added to `.gitignore`
- [ ] Consider key rotation schedule
- [ ] Monitor API usage for anomalies

---

## Questions to Resolve Before Implementation

1. **Budget approval** - Confirm monthly API budget
2. **Account setup** - Who creates/owns the API accounts?
3. **Credential storage** - Use `.env` or secrets manager?
4. **Cache strategy** - How long to cache keyword data?
5. **Failure handling** - Block workflow or allow degraded mode?

---

## Next Steps

1. Review this document
2. Decide on budget and account ownership
3. Sign up for DataForSEO and Perplexity
4. Confirm implementation approach
5. Begin Phase 1 setup

---

*Document created: 2026-01-28*
*Status: PLANNING - Awaiting review*
