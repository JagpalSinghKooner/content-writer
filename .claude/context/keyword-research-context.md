# Keyword Research Context (HushAway)

**Skill:** /keyword-research
**Gate:** Keyword Gate (check-keyword-gate.sh)

---

## Input Requirements

- Seed keyword from ARTICLE-ORDER.md
- Pillar topic and article type (hub/cluster)
- Check `.claude/keyword-library.md` for existing validated keywords

---

## Perplexity MCP Queries (4 Required)

1. **Keyword Validation + Trends**
   - Confirm search intent matches HushAway audience
   - Check for keyword trends and seasonality

2. **PAA Discovery (7+ Questions)**
   - Pull real "People Also Ask" questions from Google
   - Include questions from Reddit, Mumsnet, UK parenting forums

3. **Competitor SERP Analysis**
   - Identify top-ranking content for target keyword
   - Note content gaps HushAway can fill

4. **Research Source Discovery**
   - Find E-E-A-T worthy sources (NHS, ADHD UK, academic)
   - Identify statistics with dates for citations

---

## Output Requirements

Research file frontmatter must include:
```yaml
perplexityUsed: true
targetKeyword: [validated keyword]
secondaryKeywords: [5+ keywords]
paaQuestions: [7+ questions]
competitorGaps: [3+ gaps]
researchSources: [URLs for E-E-A-T]
```

---

## After Skill Completes

1. **Update keyword-library.md** with validated keyword (all 6 columns required)
2. **Run gate script:**
   ```bash
   .claude/scripts/check-keyword-gate.sh [research-file]
   ```
3. **MUST show:** `KEYWORD GATE: PASS`

---

## Common Failures

- Missing `perplexityUsed: true` in frontmatter
- Fewer than 7 PAA questions
- No secondary keywords listed
- Missing research sources with URLs
