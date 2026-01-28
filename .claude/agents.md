# HushAway®: Article Writing Workflow

This is the quick workflow reference for writing SEO articles. Articles are written here, previewed, then copied to the main HushAway® website.

**For comprehensive verification processes, checklists, and detailed guidance, see:** `.claude/skills/write-article.md`

---

## HARD GATES (Zero Bypass Policy)

**ALL RULES ARE HARD FORCED. NO ESCAPES. NO EXCEPTIONS.**

The workflow has THREE mandatory gates. An article cannot proceed until each gate shows PASS/OPEN/UNLOCKED.

### Gate 1: Research Gate (Before Writing)
```bash
.claude/scripts/check-research-gate.sh [research-file]
```
- **Must show:** `RESEARCH GATE: UNLOCKED`
- **Checks:** gateStatus, researchStatus, keywords, search intent, competitor gaps, PAA questions, sources, positioning
- **Exit code:** 0 = proceed, 1 = blocked
- **Writing CANNOT begin until this gate is unlocked**

### Gate 2: Content Gate (After Writing)
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster]
```
- **Must show:** `GATE STATUS: OPEN`
- **Checks:** 23 sections covering all humanise-content.md rules
- **Exit code:** 0 = proceed, 1 = blocked
- **Preview/export CANNOT proceed until this gate is open**

### Gate 3: Final Gate (Before Export)
- Word count verified (3000+ hub, 1500+ cluster)
- All frontmatter complete
- Gate 2 passed with zero failures
- **Export CANNOT proceed until all checks pass**

### Enforcement Rules
1. **No manual overrides** - If a gate fails, fix the content and re-run
2. **No partial passes** - ALL checks must pass, not just most
3. **No skipping gates** - Each gate must be run in sequence
4. **No exceptions** - These rules apply to every article, every time

---

## Quick Start

1. Check `.claude/claude.md` for brand voice and keywords table
2. Complete research for the article
3. **Run research gate:** `.claude/scripts/check-research-gate.sh [research-file]` - MUST show UNLOCKED
4. Complete HushAway® Prominence Planning (see `.claude/skills/write-article.md` Step 5)
5. Use `/seo-content` skill to write the article
6. **Run content gate:** `.claude/scripts/master-gate.sh [filename] [hub|cluster]` - MUST show OPEN
7. Fix any failures, re-run until GATE OPEN
8. Preview with `npm run dev`
9. Final checks complete, export to main website

---

## Step 1: Choose Article

Open `claude.md` and select the next article from the keywords table. Follow pillar priority order:

1. Pillar 5: ADHD Apps (25,000 searches) - START HERE
2. Pillar 2: Sleep Apps for Kids (8,000-12,000)
3. Pillar 1: ADHD Sleep Support (5,000-8,000)
4. Pillar 3: Anxiety Apps (4,000-6,000)
5. Pillar 4: Sensory Friendly Apps (2,000-3,000)
6. Pillar 7: Neurodivergent Parenting (2,000-4,000)
7. Pillar 6: Emotional Regulation (1,000-2,000)

---

## Step 2: Complete Research

Before writing, complete research for the article. **Writing cannot begin until research is complete and unlocked.**

**Research file location:**
```
/research/pillar-[N]-[topic-name]/[article]-research.md
```

Example: `/research/pillar-7-neurodivergent-parenting/hub-research.md`

**Naming:**
- Hub articles: `hub-research.md`
- Cluster articles: `[X.X]-[slug]-research.md` (e.g., `7.1-parent-burnout-research.md`)

**Research requirements:**
1. Target keyword + 3-5 secondary keywords
2. Search intent analysis
3. Top 5 SERP results reviewed
4. 3+ competitor gaps identified
5. 5+ People Also Ask questions (these become H2/H3 headings in the article)
6. 3+ research sources with citations
7. Positioning angle selected

**Gate status explained:**
- `gateStatus: locked` = Research incomplete, writing CANNOT begin
- `gateStatus: unlocked` = Research complete, writing can proceed

This gate ensures thorough research before any article writing starts. Do not bypass.

**When research is complete:**
- Set `researchStatus: complete` in frontmatter
- Set `gateStatus: unlocked` in frontmatter
- Set `dateCompleted` to today's date
- Proceed to writing

---

## Step 3: Write Article

Use the `/seo-content` skill with these parameters:

```
Target keyword: [from research]
Keyword cluster: [secondary keywords from research]
Search intent: [Informational / Commercial]
Content type: [Pillar hub / Cluster article]
Positioning angle: [from research]
MINIMUM word count: [3,000+ hub / 1,500+ cluster]

Requirements:
- Lead with empathy for exhausted parents
- Parent-to-parent tone throughout
- Include signature phrases naturally
- Gentle CTA: "Explore the Sound Sanctuary"
- UK English, NO emojis, NO em-dashes
- **Community quotes:** 2+ for hub, 1+ for cluster (must follow humanise-content.md Section 8 categories: Verified, Composite, or Illustrative)
- **Dated citations:** Always include year (e.g., "Research from 2023 found...")
- **Curiosity loops:** 2+ for hub, 1+ for cluster (transitional hooks)
- **Internal links:** 8-10 for hub, 4-6 for cluster (cross-pillar)
```

---

## Step 4: Run Master Gate (MANDATORY)

**All verification is now automated in a single script.**

```bash
.claude/scripts/master-gate.sh "[filename]" [hub|cluster]
```

**Examples:**
```bash
# For hub articles
.claude/scripts/master-gate.sh "src/content/pillar-5-adhd-apps/hub-adhd-apps.md" hub

# For cluster articles
.claude/scripts/master-gate.sh "src/content/pillar-7-neurodivergent-parenting/7.1-parent-burnout.md" cluster
```

### What the Script Checks (23 Sections - Fully Automated)

| Section | Checks |
|---------|--------|
| 1 | Word count (3000 hub / 1500 cluster) |
| 2 | 50+ banned AI-isms, deficit language, clinical terms, American English |
| 3 | 19 frequency-limited words |
| 4 | 12 intensifier limits |
| 5 | Banned phrases (openers, conclusions, transitions, filler, citations) |
| 6 | Redundant phrases |
| 7 | Structural limits (This is, Examples include, backward refs, -ly adverbs) |
| 8 | Hedging density + stacked hedges (includes often, tend to) |
| 9 | Sentence variety (global + per-section This limit, consecutive You/Your, short sentences) |
| 10 | Human markers (And/But, We, contractions) |
| 11 | Community quotes (2 hub / 1 cluster) |
| 12 | Dated citations (3 hub / 2 cluster) |
| 13 | Curiosity loops (2 hub / 1 cluster) |
| 14 | Internal links (8 hub / 4 cluster) |
| 15 | HushAway® trademark |
| 16 | Em-dashes |
| 17 | Emojis |
| 18 | Brand prominence (HushAway® in intro, 50% of H2s, comparison element) |
| 19 | Keyword placement (in first 150 words, in H2s) |
| 20 | Title/meta length (title <60, meta 140-160 chars) |
| 21 | External links (UK sources preferred) |
| 22 | Additional structural (self-answering Qs, paragraph starters, list variety, The-starts, verb-starts) |
| 23 | Human voice (consecutive It paragraphs, on one hand pattern, external link count) |

### Gate Status

**OPEN (exit code 0):** All checks passed. Proceed to Step 6.

**CLOSED (exit code 1):** Failures found.
1. Review failures listed in output
2. Fix ALL failures in article
3. Re-run script
4. Repeat until OPEN

**Do NOT proceed with CLOSED gate. No exceptions.**

**All checks are fully automated.** The gate now includes 22 sections covering:
- Banned words, phrases, and AI-isms
- Frequency limits and intensifiers
- Structural patterns (per-section limits, consecutive patterns)
- Human voice markers (contractions, And/But, We language)
- Self-answering questions (auto-detected)
- Paragraph starters (auto-detected per section)
- List structure variety (auto-detected)
- Section length variety (auto-detected)
- External link sources (UK-approved check)

**GATE OPEN = Article passes. GATE CLOSED = Fix and re-run. No manual steps required.**

---

## Step 5: Save and Preview

**Save article to:**
```
/src/content/pillar-[N]-[topic-name]/[filename].md
```

Example: `/src/content/pillar-7-neurodivergent-parenting/hub-neurodivergent-parenting.md`

**File naming:**
- Hub articles: `hub-[slug].md`
- Cluster articles: `[X.X]-[slug].md` (e.g., `7.1-parent-burnout.md`)

**Frontmatter:**
```yaml
---
title: "[Article Title]"
pillar: [Number]
pillarName: "[Pillar Name]"
articleNumber: "[PILLAR or X.X]"
targetKeyword: "[Primary Keyword]"
metaDescription: "[Question + soft answer, 140-160 chars, includes keyword]"
status: draft
wordCount: [count]
dateCreated: [YYYY-MM-DD]
dateUpdated: [YYYY-MM-DD]
---
```

**Preview:**
```
npm run dev
```
Open `http://localhost:4321` to view the article.

---

## Step 6: Export to Main Site

When article passes quality check:
1. Copy markdown content (meta description is in frontmatter)
2. Paste into main HushAway® website CMS
3. Add featured image
4. Replace any `[LINK TO: Article Title]` placeholders with actual links
5. Publish
6. Update status in local file to `published`

---

## Common Issues

### Content sounds too clinical
Replace medical terminology with everyday parent language. Write like explaining to a friend, not lecturing.

### Deficit language present
Replace "fix," "suffering from," "normal" with supportive alternatives. Frame neurodivergence as difference, not deficit.

### AI-isms detected
Remove "delve," "landscape," "leverage," "comprehensive," "robust." Make it sound more human.

### Opening lacks empathy
Start by acknowledging parent struggle before introducing concepts or solutions.

### American English
Change "mom" to "mum," "color" to "colour," "behavior" to "behaviour."

### Missing community voice
Add parent quotes with lived experience. Format: "One mum put it perfectly: '[quote]'" or "As one parent shared: '[quote]'". Quotes should feel specific and emotionally resonant.

### Undated citations
Every research citation must include the year. Change "Research shows..." to "Research from 2023 found..." or "A 2022 study showed..."

### Weak mid-article engagement
Add curiosity loops before major sections. End a section with a question that pulls readers into the next: "But here is the question most guides never ask: [question]?"

### Insufficient internal links
Hub articles need 8-10 internal links, cluster articles need 4-6. Include cross-pillar links, not just same-pillar.

---

## File Structure

```
/src/content/pillar-[N]-[topic-name]/  - Article markdown files
  - hub-[slug].md                       - Hub articles
  - [X.X]-[slug].md                     - Cluster articles (e.g., 7.1-parent-burnout.md)
/research/pillar-[N]-[topic-name]/     - Research files
  - hub-research.md                     - Hub research
  - [X.X]-[slug]-research.md            - Cluster research (e.g., 7.1-parent-burnout-research.md)
/templates/                             - Research template
/dashboard/                             - Progress tracking (HTML dashboard)
/.claude/claude.md                      - Brand voice, product info, pillar table
/.claude/agents.md                      - This workflow guide
/.claude/humanise-content.md           - Master content rules (50+ banned words, limits)
/.claude/scripts/master-gate.sh        - Content gate (23 sections)
/.claude/scripts/check-research-gate.sh - Research gate (9 checks)
/.claude/skills/write-article.md       - Detailed article writing process
/.claude/skills/                        - Marketing skills
```

---

## Skills Reference

**For articles:**
- `/seo-content` - Write SEO articles
- `/keyword-research` - Research keywords

**For other content:**
- `/brand-voice` - Refine brand voice
- `/positioning-angles` - Find angles
- `/direct-response-copy` - Conversion copy
- `/email-sequences` - Email sequences
- `/content-atomizer` - Repurpose content
