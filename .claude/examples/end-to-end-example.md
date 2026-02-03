# End-to-End Workflow Example

A complete walkthrough of the SEO Content System using a fictional client. This example demonstrates every phase from onboarding to distribution, with realistic file paths, PROJECT-TASKS.md entries, and handoff notes.

**Client:** Apex Analytics (B2B marketing analytics SaaS)
**Project:** Q1 2024 Content Programme

---

## Phase 1: Client Onboarding

**Skill used:** `/onboard-client`

### Session Highlights

The onboarding interview covered:

1. **Company context** — 4-year-old B2B SaaS, 50 employees, £2M ARR, primarily serving marketing teams at mid-market companies (100-500 employees)
2. **Product deep-dive** — Marketing attribution platform that unifies data from 40+ marketing tools into a single dashboard
3. **Audience mapping** — Marketing directors and CMOs frustrated with "data chaos" across disconnected tools
4. **Competitor analysis** — Identified 3 main competitors, noted Apex's advantage in implementation speed (2 weeks vs 8+ weeks)
5. **Brand voice extraction** — Conversational expert tone, avoids jargon, uses sports analogies

### Output Structure

```
/clients/apex-analytics/
└── profile.md
```

**Profile sections created:**
- Company (name, industry, size, website, years in business)
- Product/Service (core offering, problem solved, price point, unique mechanism)
- Target Audience (job titles, pain points, failed solutions, desired outcomes)
- Competitors (3 competitors with URLs, strengths, weaknesses, our advantage)
- Brand Voice (summary, 5 personality traits, tone spectrum, vocabulary guide, rhythm patterns, example phrases, do's/don'ts)
- Content Rules (avoided words, signature phrases, terminology)
- Conversion Elements (primary CTA, lead magnets, social proof)
- Goals (traffic targets, lead generation, authority building)

### PROJECT-TASKS.md Entry

```markdown
## Task 1: Client Onboarding

**Objective:** Complete client profile for Apex Analytics

**Acceptance Criteria:**
- [x] All 8 profile sections completed
- [x] Brand voice includes tone spectrum and example phrases
- [x] At least 3 competitors documented with analysis
- [x] Conversion elements include primary CTA templates

**Status:** PASS

---

**Handoff:**
- **Done:** Full profile at /clients/apex-analytics/profile.md
- **Decisions:** Used "Marketing Director" as primary persona (CMO is secondary). Voice is "smart colleague" not "thought leader"—client wanted approachable, not authoritative.
- **Next:** Keyword research. Client prioritises "marketing attribution" and "marketing analytics" clusters.
```

---

## Phase 2: Keyword Research

**Skill used:** `/keyword-research`

### Output

```
/projects/apex-analytics/q1-content/
├── PROJECT-TASKS.md
└── 00-keyword-brief.md
```

### Keyword Brief Highlights

**Seed keywords expanded:** marketing attribution, marketing analytics, multi-touch attribution, marketing ROI, campaign tracking

**Clusters identified:**

| Cluster | Articles | Priority | Rationale |
|---------|----------|----------|-----------|
| Marketing Attribution | 8 | P1 | Core product positioning |
| Marketing Analytics Tools | 6 | P2 | Comparison/alternative searches |
| Marketing ROI | 5 | P3 | Problem-aware audience |

**Pillar selection rationale:**

"Marketing Attribution" chosen as first pillar because:
1. Direct product alignment (attribution is the core feature)
2. High commercial intent (searchers evaluating solutions)
3. Manageable competition (established players but gaps in content quality)
4. Clear pillar structure (pillar guide + 7 supporting articles)

### PROJECT-TASKS.md Entry

```markdown
## Task 2: Keyword Research

**Objective:** Produce prioritised keyword clusters for Q1 content

**Acceptance Criteria:**
- [x] 3+ clusters identified with priority ranking
- [x] First pillar selected with rationale
- [x] Keyword brief follows naming convention (00-keyword-brief.md)

**Status:** PASS

---

**Handoff:**
- **Done:** Keyword brief at /projects/apex-analytics/q1-content/00-keyword-brief.md with 3 clusters (19 total articles planned)
- **Decisions:** "Marketing Attribution" as P1 pillar (8 articles). Deprioritised "data visualisation" cluster—too far from product.
- **Next:** Start pillar brief for "marketing-attribution" pillar. Competitor analysis needed for HubSpot, Ruler Analytics, Dreamdata.
```

---

## Phase 3: Pillar Brief

**Skill used:** `/start-pillar`

### Output

```
/projects/apex-analytics/q1-content/
├── PROJECT-TASKS.md
├── 00-keyword-brief.md
└── marketing-attribution/
    └── 01-pillar-brief.md
```

### Pillar Brief Highlights

**Pillar:** Marketing Attribution
**Articles planned:** 7 supporting + 1 pillar guide = 8 total

**Content plan:**

| # | Slug | Target Keyword | Search Intent |
|---|------|----------------|---------------|
| 01 | what-is-marketing-attribution | marketing attribution | Informational |
| 02 | marketing-attribution-models | attribution models marketing | Informational |
| 03 | multi-touch-attribution-guide | multi-touch attribution | Informational |
| 04 | first-touch-vs-last-touch | first touch vs last touch attribution | Comparison |
| 05 | marketing-attribution-tools | marketing attribution software | Commercial |
| 06 | attribution-implementation-guide | how to implement attribution | How-to |
| 07 | attribution-common-mistakes | marketing attribution mistakes | Problem-aware |
| 08 | marketing-attribution-complete-guide | marketing attribution guide | Pillar guide |

**Competitor analysis findings:**
- HubSpot: Strong domain authority but surface-level attribution content
- Ruler Analytics: Deep technical content but poor readability
- Dreamdata: Good B2B angle but US-focused examples

**Gap identified:** No competitor combines technical depth with accessible writing and UK-relevant examples.

### PROJECT-TASKS.md Entry

```markdown
## Task 3: Pillar Brief

**Objective:** Create pillar brief for "Marketing Attribution"

**Acceptance Criteria:**
- [x] 7+ supporting articles mapped with keywords
- [x] Pillar guide keyword and angle defined
- [x] Competitor analysis for top 3 competitors
- [x] Content gap identified

**Status:** PASS

---

**Handoff:**
- **Done:** Pillar brief at /projects/apex-analytics/q1-content/marketing-attribution/01-pillar-brief.md
- **Decisions:** 7 supporting articles (not 10)—quality over quantity. Article 05 (tools comparison) will mention Apex but focus on category education. Pillar guide is article 08.
- **Next:** Positioning angles. Need to find the hook that differentiates from HubSpot's generic "what is attribution" content.
```

---

## Phase 4: Positioning

**Skill used:** `/positioning-angles`

### Output

```
/projects/apex-analytics/q1-content/marketing-attribution/
├── 01-pillar-brief.md
└── 02-positioning.md
```

### Positioning Document Highlights

**PRIMARY ANGLE (for pillar guide):**

> "Attribution isn't about perfect data—it's about better decisions. Most guides obsess over model accuracy. We focus on what you can actually do with imperfect attribution data."

- **This angle claims:** Action beats accuracy; 80% attribution insight > 0% from paralysis
- **This angle rejects:** The pursuit of "perfect" attribution; waiting for complete data
- **Proof points:** Case studies of decisions made with incomplete data that still drove results

**SECONDARY ANGLES (for supporting articles):**

| Article | Angle | Claims | Rejects |
|---------|-------|--------|---------|
| 01-what-is-marketing-attribution | Attribution is a decision tool, not a scoreboard | Attribution should inform action | Treating attribution as reporting |
| 02-marketing-attribution-models | No model is "right"—only right for your question | Context determines model choice | One-size-fits-all model recommendations |
| 03-multi-touch-attribution-guide | Multi-touch is a mindset, not just a model | Credit sharing reflects reality | Single-touch as "simpler" |
| 04-first-touch-vs-last-touch | The debate is a distraction | Understanding both > choosing one | Either/or framing |
| 05-marketing-attribution-tools | Tools should match your maturity, not your ambition | Right-sized solutions win | Enterprise tools for everyone |
| 06-attribution-implementation-guide | Start small, prove value, expand | Quick wins build momentum | Big-bang implementations |
| 07-attribution-common-mistakes | Most attribution failures are people problems | Process > technology | Blaming the tools |

**Consistency check:** All angles reinforce "action over perfection" primary theme.

### PROJECT-TASKS.md Entry

```markdown
## Task 4: Positioning Angles

**Objective:** Define primary and secondary angles for marketing-attribution pillar

**Acceptance Criteria:**
- [x] Primary angle defined with claims/rejects
- [x] Secondary angle for each supporting article
- [x] All angles reinforce primary theme
- [x] Consistency check passed

**Status:** PASS

---

**Handoff:**
- **Done:** Positioning at /projects/apex-analytics/q1-content/marketing-attribution/02-positioning.md
- **Decisions:** "Action over perfection" as unifying theme. Rejected "attribution is easy" angle—doesn't match audience sophistication.
- **Next:** Article creation. Start with 01-what-is-marketing-attribution (foundational, links to all others).
```

---

## Phase 5: Article Creation

**Skills used:** `/seo-content` then `/direct-response-copy`

> **Agent Automation Note:** Steps 4-7 (seo-content, direct-response-copy, validate-content, content-atomizer) can be automated via the agent system. For full pillar execution with multiple articles, use `/execute-pillar` which orchestrates the seo-writer, copy-enhancer, content-validator, and content-atomizer agents in tier-based parallel execution. See [Workflow Rules](../rules/workflow.md) for details.
>
> This example shows the manual workflow for a single article to illustrate each step. In practice, use agent automation for efficiency when generating 4+ articles.

### Output

```
/projects/apex-analytics/q1-content/marketing-attribution/
├── 01-pillar-brief.md
├── 02-positioning.md
└── articles/
    └── 01-what-is-marketing-attribution.md
```

### Article Creation Process (abbreviated)

**Step 1: SEO Content Draft**

- Target keyword: "marketing attribution"
- Word count: 2,100 words
- Structure: Definition > Why it matters > How it works > Models overview > Getting started
- Angle applied: Attribution as decision tool, not scoreboard
- Internal links: Placeholders for articles 02-07 (not yet written)

**Step 2: Direct Response Enhancement**

- Hook strengthened: "Your marketing works. You just don't know which parts."
- CTA added: Free attribution audit (existing lead magnet)
- Proof points: Added anonymised client data ("Marketing team reduced wasted spend by 23% in 90 days")
- Voice alignment: Checked against profile—conversational, uses "you/your", sports analogies where natural

### Article Frontmatter

```yaml
---
title: "What Is Marketing Attribution? A Practical Guide for Marketing Teams"
slug: what-is-marketing-attribution
target_keyword: marketing attribution
secondary_keywords: [marketing attribution meaning, what is attribution in marketing]
meta_title: "What Is Marketing Attribution? A Practical Guide (2024)"
meta_description: "Marketing attribution shows which channels drive results. Learn how it works, why it matters, and how to start—without drowning in data."
status: draft
internal_links: []
created: 2024-01-15
updated: 2024-01-15
---
```

### PROJECT-TASKS.md Entry

```markdown
## Task 5.1: Article 01 - What Is Marketing Attribution

**Objective:** Write and enhance first supporting article

**Acceptance Criteria:**
- [x] SEO draft complete (2000+ words, keyword in first 150 words)
- [x] Direct response pass complete (hook, CTA, proof points)
- [x] Angle from positioning document applied
- [x] Frontmatter complete

**Status:** PASS

---

**Handoff:**
- **Done:** Article at /projects/apex-analytics/q1-content/marketing-attribution/articles/01-what-is-marketing-attribution.md
- **Decisions:** Used 4 link placeholders (articles 02, 03, 05, 06). Opening hook focuses on "works but don't know" insight from client interviews.
- **Next:** Validation, then article 02.
```

---

## Phase 6: Validation

**Skill used:** `/validate-content`

### Output

Validation runs in place—no new files created.

### Validation Result (abbreviated)

```
VALIDATION RESULT: PASS

Content: 01-what-is-marketing-attribution.md
Type: Article

CHECKS:
✓ UK English: PASS (no US spellings detected)
✓ Banned AI Words: PASS (0 violations)
✓ Banned AI Phrases: PASS (0 violations)
✓ AI Patterns: PASS (varied sentence openers, no rule-of-threes abuse)
✓ SEO Requirements: PASS (keyword in first 50 words, 2,100 words, meta under limits)
✓ Citations: PASS (3 external citations, properly formatted)
✓ Brand Voice: PASS (conversational tone, "you/your" present, no jargon)

WARNINGS:
⚠ Line 47: Consider adding contraction ("do not" → "don't")
⚠ Line 112: Passive voice ("was measured" → "we measured")

RESULT: PASS with 2 warnings (non-blocking)
```

### PROJECT-TASKS.md Entry

```markdown
## Task 5.2: Validate Article 01

**Objective:** Run validation on first article

**Acceptance Criteria:**
- [x] All FAIL checks pass
- [x] Warnings reviewed and addressed if needed
- [x] Article ready for next step

**Status:** PASS

---

**Handoff:**
- **Done:** Validation passed with 2 warnings. Fixed contraction on line 47. Left passive voice on line 112 (intentional for flow).
- **Decisions:** Warnings are non-blocking; fixed the easy one, noted the intentional one.
- **Next:** Continue with article 02, or atomise article 01 for distribution.
```

---

## Phase 7: Distribution Atomisation

**Skill used:** `/content-atomizer`

### Output

```
/projects/apex-analytics/q1-content/marketing-attribution/
└── distribution/
    └── what-is-marketing-attribution/
        ├── linkedin.md
        ├── twitter.md
        ├── newsletter.md
        └── instagram.md
```

### Distribution Content (abbreviated)

**LinkedIn carousel (10 slides):**
1. "Your marketing works. You just don't know which parts." (hook)
2. What is marketing attribution? (definition)
3. The problem it solves (visual: disconnected data)
4. How it works (simplified 3-step)
5. Common models (one slide, high level)
6. Real example (anonymised result)
7. Getting started (3 actions)
8. The mindset shift (angle reinforcement)
9. Common mistake to avoid
10. CTA: Free attribution audit

**Twitter thread (8 tweets):**
- Hook tweet with "works but don't know" insight
- 5 tweets covering key points (one per section)
- Proof point tweet
- CTA tweet with link

**Newsletter snippet:**
- 150-word summary with "why this matters now"
- Bridge to full article
- Single CTA

### PROJECT-TASKS.md Entry

```markdown
## Task 6: Atomise Article 01

**Objective:** Create distribution content for first article

**Acceptance Criteria:**
- [x] LinkedIn carousel (10 slides)
- [x] Twitter thread (8+ tweets)
- [x] Newsletter snippet
- [x] Instagram carousel (optional—completed)

**Status:** PASS

---

**Handoff:**
- **Done:** Distribution at /projects/apex-analytics/q1-content/marketing-attribution/distribution/what-is-marketing-attribution/
- **Decisions:** Instagram carousel mirrors LinkedIn but with shorter text. Newsletter snippet is standalone value, not just a teaser.
- **Next:** Article 02-07 following same process. After all articles complete: pillar guide (article 08), then linking pass.
```

---

## Full Project Structure (After Phase 7)

```
/projects/apex-analytics/q1-content/
├── PROJECT-TASKS.md
├── 00-keyword-brief.md
└── marketing-attribution/
    ├── 01-pillar-brief.md
    ├── 02-positioning.md
    ├── articles/
    │   ├── 01-what-is-marketing-attribution.md
    │   ├── 02-marketing-attribution-models.md (pending)
    │   ├── ...
    │   └── 08-marketing-attribution-complete-guide.md (pillar, pending)
    └── distribution/
        └── what-is-marketing-attribution/
            ├── linkedin.md
            ├── twitter.md
            ├── newsletter.md
            └── instagram.md
```

---

## Key Patterns Demonstrated

1. **PROJECT-TASKS.md drives everything** — Every phase has a task entry with acceptance criteria, status, and handoff notes
2. **File naming is predictable** — `00-keyword-brief.md`, `01-pillar-brief.md`, `02-positioning.md`, then numbered articles
3. **Handoffs carry context** — Each task explains decisions made and context for next task
4. **Validation catches issues early** — Run after every article, not just at the end
5. **Angles unify the pillar** — Primary angle informs all supporting article angles
6. **Distribution reuses, doesn't recreate** — Atomised content pulls from the article, adapted per platform

---

## Continuing the Project

After this example point, the project would continue:

1. **Articles 02-07:** Same process (seo-content → direct-response-copy → validate)
2. **Article 08 (pillar guide):** Written last, links to all supporting articles
3. **Linking pass:** Replace all `<!-- LINK NEEDED -->` placeholders, add pillar guide links
4. **Batch validation:** Review all 8 articles together for consistency
5. **Distribution:** Atomise remaining high-priority articles
6. **Next pillar:** Move to "Marketing Analytics Tools" cluster (P2)

---

*This example uses fictional client data. Adapt the process to each client's specific context, voice, and goals.*
