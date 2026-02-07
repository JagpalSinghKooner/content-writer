# Perplexity Prompt Templates

Prompt templates for competitor analysis and content angle discovery using Perplexity MCP tools.

---

## Available Perplexity Tools

- **`perplexity_search`:** Quick facts, current rankings, basic research
- **`perplexity_ask`:** Conversational analysis, interpreting data
- **`perplexity_research`:** Deep competitor analysis, comprehensive reports
- **`perplexity_reason`:** Strategic decisions, weighing trade-offs

---

## Competitor Content Analysis

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
- Content gaps: Topics competitors don't cover well
- Angle opportunities: Positioning no one owns
- Depth issues: Where existing content is surface-level
- Freshness: Outdated information you can update
- Format gaps: Missing how-tos, comparisons, or examples

---

## Trend Validation

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

## Strategic Pillar Decisions

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
