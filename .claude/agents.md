# HushAway®: Article Writing Workflow

This is the quick workflow reference for writing SEO articles. Articles are written here, previewed, then copied to the main HushAway® website.

**For comprehensive verification processes, checklists, and detailed guidance, see:** `.claude/skills/write-article.md`

---

## HARD GATES (Zero Bypass Policy)

**ALL RULES ARE HARD FORCED. NO ESCAPES. NO EXCEPTIONS.**

The workflow has **FIVE mandatory gates**. An article cannot proceed until each gate shows PASS/OPEN/UNLOCKED.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         5-GATE CONTENT WORKFLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

STEP 1: Choose Article ─────────────── Seed from claude.md keywords table
           │
STEP 2: Run /keyword-research ──────── Validate + expand keywords
           │
           ▼
    ┌──────────────┐
    │ KEYWORD GATE │ ← Gate 1: Keywords validated & table updated
    └──────────────┘
           │
STEP 3: Complete Research ──────────── Competitors, PAA, sources
           │
           ▼
    ┌──────────────┐
    │ RESEARCH GATE│ ← Gate 2: Research complete
    └──────────────┘
           │
STEP 4: Run /positioning-angles ────── Find article-specific angle
           │
           ▼
    ┌──────────────┐
    │  ANGLE GATE  │ ← Gate 3: Angle selected & documented
    └──────────────┘
           │
STEP 5: Plan HushAway® Prominence ──── Using selected angle
           │
STEP 6: Write with /seo-content ────── Article creation
           │
           ▼
    ┌──────────────┐
    │ CONTENT GATE │ ← Gate 4: Content passes 23 checks
    └──────────────┘
           │
           ▼
    ┌──────────────┐
    │  FINAL GATE  │ ← Gate 5: All checks complete
    └──────────────┘
           │
STEP 7: Preview & Export
```

---

### Gate 1: Keyword Gate (After Keyword Research) - NEW
```bash
.claude/scripts/check-keyword-gate.sh [research-file]
```
- **Must show:** `KEYWORD GATE: UNLOCKED`
- **Checks:** keywordStatus, target keyword validated, secondary keywords (5+), search volume, keyword cluster complete
- **Exit code:** 0 = proceed, 1 = blocked
- **Requirement:** claude.md keywords table MUST be updated with validated keyword and secondaries
- **Research CANNOT begin until this gate is unlocked**

### Gate 2: Research Gate (After Research Complete)
```bash
.claude/scripts/check-research-gate.sh [research-file]
```
- **Must show:** `RESEARCH GATE: UNLOCKED`
- **Checks:** gateStatus, researchStatus, keywords, search intent, competitor gaps, PAA questions, sources
- **Exit code:** 0 = proceed, 1 = blocked
- **Positioning CANNOT begin until this gate is unlocked**

### Gate 3: Angle Gate (After Positioning Angles) - NEW
```bash
.claude/scripts/check-angle-gate.sh [research-file]
```
- **Must show:** `ANGLE GATE: UNLOCKED`
- **Checks:** angleStatus, selected angle documented, headline direction, counter-positions defined
- **Exit code:** 0 = proceed, 1 = blocked
- **Writing CANNOT begin until this gate is unlocked**

### Gate 4: Content Gate (After Writing)
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster]
```
- **Must show:** `GATE STATUS: OPEN`
- **Checks:** 23 sections covering all humanise-content.md rules
- **Exit code:** 0 = proceed, 1 = blocked
- **Preview/export CANNOT proceed until this gate is open**

### Gate 5: Final Gate (Before Export)
- Word count verified (3000+ hub, 1500+ cluster)
- All frontmatter complete
- Gate 4 passed with zero failures
- **Export CANNOT proceed until all checks pass**

### Enforcement Rules
1. **No manual overrides** - If a gate fails, fix the content and re-run
2. **No partial passes** - ALL checks must pass, not just most
3. **No skipping gates** - Each gate must be run in sequence
4. **No exceptions** - These rules apply to every article, every time
5. **Skills are MANDATORY** - /keyword-research and /positioning-angles must run, not optional

---

## Quick Start

1. Check `.claude/claude.md` for brand voice and keywords table (seed keyword)
2. **Run `/keyword-research` skill** to validate and expand keywords
3. **Run keyword gate:** `.claude/scripts/check-keyword-gate.sh [research-file]` - MUST show UNLOCKED
4. **Update claude.md table** with validated keyword and secondary keywords
5. Complete research for the article (competitors, PAA, sources)
6. **Run research gate:** `.claude/scripts/check-research-gate.sh [research-file]` - MUST show UNLOCKED
7. **Run `/positioning-angles` skill** to find article-specific angle
8. **Run angle gate:** `.claude/scripts/check-angle-gate.sh [research-file]` - MUST show UNLOCKED
9. Complete HushAway® Prominence Planning using the selected angle
10. Use `/seo-content` skill to write the article
11. **Run content gate:** `.claude/scripts/master-gate.sh [filename] [hub|cluster]` - MUST show OPEN
12. Fix any failures, re-run until GATE OPEN
13. Preview with `npm run dev`
14. Final checks complete, export to main website

---

## Step 1: Choose Article (Seed Keyword)

Open `claude.md` and select the next article from the keywords table. **The table provides SEED keywords - these are starting points, not final targets.**

Follow pillar priority order:

1. Pillar 5: ADHD Apps (25,000 searches) - START HERE
2. Pillar 2: Sleep Apps for Kids (8,000-12,000)
3. Pillar 1: ADHD Sleep Support (5,000-8,000)
4. Pillar 3: Anxiety Apps (4,000-6,000)
5. Pillar 4: Sensory Friendly Apps (2,000-3,000)
6. Pillar 7: Neurodivergent Parenting (2,000-4,000)
7. Pillar 6: Emotional Regulation (1,000-2,000)

**Note:** The seed keyword will be validated and potentially improved in Step 2.

---

## Step 2: Run Keyword Research (MANDATORY)

**Before any research begins, run the `/keyword-research` skill.**

This is NOT optional. Every article requires dynamic keyword validation.

### Invoke the skill:
```
/keyword-research
```

### Provide context:
- **Seed keyword:** [from claude.md table]
- **Pillar topic:** [pillar name]
- **Content type:** [Hub or Cluster]
- **Business context:** HushAway® sound therapy for neurodivergent children

### The skill will output:
1. **Validated target keyword** (may confirm seed or suggest better alternative)
2. **Secondary keyword cluster** (5-10 related keywords)
3. **Search volume validation**
4. **Competitor opportunity assessment**
5. **Content type recommendation**

### After skill completes:

1. **Update the research file** with:
   - `keywordStatus: validated`
   - Target keyword (validated)
   - Full secondary keywords list
   - Search volume data

2. **Update claude.md keywords table** with:
   - Validated target keyword (if different from seed)
   - Secondary keywords column

3. **Run the Keyword Gate:**
```bash
.claude/scripts/check-keyword-gate.sh [research-file]
```

**MUST show `KEYWORD GATE: UNLOCKED` before proceeding to Step 3.**

---

## Step 3: Complete Research

**After Keyword Gate is unlocked**, complete research for the article.

**Research file location:**
```
/research/pillar-[N]-[topic-name]/[article]-research.md
```

Example: `/research/pillar-7-neurodivergent-parenting/hub-research.md`

**Naming:**
- Hub articles: `hub-research.md`
- Cluster articles: `[X.X]-[slug]-research.md` (e.g., `7.1-parent-burnout-research.md`)

**Research requirements:**
1. Target keyword (validated from Step 2) + secondary keywords (from Step 2)
2. Search intent analysis
3. Top 5 SERP results reviewed
4. 3+ competitor gaps identified
5. 5+ People Also Ask questions (these become H2/H3 headings in the article)
6. 3+ research sources with citations

**Note:** Positioning angle is NO LONGER selected here - it comes from Step 4.

**When research is complete:**
- Set `researchStatus: complete` in frontmatter
- Set `gateStatus: unlocked` in frontmatter
- Set `dateCompleted` to today's date

**Run the Research Gate:**
```bash
.claude/scripts/check-research-gate.sh [research-file]
```

**MUST show `RESEARCH GATE: UNLOCKED` before proceeding to Step 4.**

---

## Step 4: Run Positioning Angles (MANDATORY)

**After Research Gate is unlocked, run the `/positioning-angles` skill.**

This is NOT optional. Every article requires a dynamic, article-specific angle.

### Invoke the skill:
```
/positioning-angles
```

### Provide context:
- **Article topic:** [from research]
- **Target keyword:** [validated keyword]
- **Competitor gaps:** [from research - what competitors miss]
- **Search intent:** [from research]
- **HushAway® differentiator:** Sound therapy for neurodivergent children

### The skill will output:
1. **3-5 distinct angle options** for this specific article
2. **Psychology/reasoning** behind each angle
3. **Headline directions** for each
4. **Recommended starting angle**

### After skill completes:

1. **Select ONE angle** as the primary angle for this article

2. **Update the research file** with:
   ```yaml
   angleStatus: selected
   selectedAngle: "[Name of chosen angle]"
   angleDescription: "[One sentence description]"
   headlineDirection: "[Example headline from skill output]"
   counterPositions:
     - "[Counter-position for competitor category 1]"
     - "[Counter-position for competitor category 2]"
   ```

3. **Run the Angle Gate:**
```bash
.claude/scripts/check-angle-gate.sh [research-file]
```

**MUST show `ANGLE GATE: UNLOCKED` before proceeding to Step 5.**

---

## Step 5: Plan HushAway® Prominence

**After Angle Gate is unlocked**, plan where HushAway® appears throughout the article using the selected angle.

### Using Your Selected Angle:

Your angle from Step 4 informs ALL prominence planning:

| Planning Element | How Angle Informs It |
|------------------|---------------------|
| Introduction mention | Frame HushAway® using the angle's core insight |
| Counter-positions | Use the counter-positions defined in Step 4 |
| Comparison section | Build around the angle's differentiation |
| CTA framing | Connect Sound Sanctuary to the angle's promise |

### Complete this checklist:

- [ ] **Introduction mention planned:** Draft callout using selected angle within first 500 words
- [ ] **Counter-positions mapped:** Each competitor category closes with angle-informed HushAway® positioning
- [ ] **Differentiator section planned:** "Why Most [Topic] Approaches Fail" using angle insight
- [ ] **Comparison format chosen:** Table/checklist highlighting angle's differentiation

**Minimum HushAway® presence:**
- Introduction: 1 mention using angle framing
- Body sections: 50%+ of H2 sections close with angle-informed positioning
- Closing: Comparison element + Sound Sanctuary CTA

---

## Step 6: Write Article

**After prominence planning is complete**, use the `/seo-content` skill.

### Invoke the skill:
```
/seo-content
```

### Provide these parameters:

```
Target keyword: [validated keyword from Step 2]
Keyword cluster: [secondary keywords from Step 2]
Search intent: [from research]
Content type: [Pillar hub / Cluster article]
Selected angle: [from Step 4]
Headline direction: [from Step 4]
Counter-positions: [from Step 4]
MINIMUM word count: [3,000+ hub / 1,500+ cluster]

Requirements:
- Lead with empathy for exhausted parents
- Parent-to-parent tone throughout
- Include signature phrases naturally
- Use selected angle throughout (not static pillar angles)
- Apply counter-positions from Step 4
- Gentle CTA: "Explore the Sound Sanctuary"
- UK English, NO emojis, NO em-dashes
- **Community quotes:** 2+ for hub, 1+ for cluster
- **Dated citations:** Always include year (e.g., "Research from 2023 found...")
- **Curiosity loops:** 2+ for hub, 1+ for cluster (transitional hooks)
- **Internal links:** 8-10 for hub, 4-6 for cluster (cross-pillar)
```

---

## Step 7: Run Master Gate (MANDATORY)

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

## Step 8: Save and Preview

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

## Step 9: Export to Main Site

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
/.claude/claude.md                      - Brand voice, product info, pillar table (SEED keywords)
/.claude/agents.md                      - This workflow guide
/.claude/humanise-content.md           - Master content rules (50+ banned words, limits)
/.claude/scripts/check-keyword-gate.sh - Keyword gate (after /keyword-research)
/.claude/scripts/check-research-gate.sh - Research gate (after research complete)
/.claude/scripts/check-angle-gate.sh   - Angle gate (after /positioning-angles)
/.claude/scripts/master-gate.sh        - Content gate (23 sections)
/.claude/skills/write-article.md       - Detailed article writing process
/.claude/skills/keyword-research/      - Keyword research skill
/.claude/skills/positioning-angles/    - Positioning angles skill
/.claude/skills/seo-content/           - SEO content writing skill
/.claude/skills/                        - Other marketing skills
```

---

## Skills Reference

**MANDATORY for every article (in order):**
1. `/keyword-research` - Validate + expand keywords (Step 2) - **CANNOT SKIP**
2. `/positioning-angles` - Find article-specific angle (Step 4) - **CANNOT SKIP**
3. `/seo-content` - Write the article (Step 6)

**For other content:**
- `/brand-voice` - Refine brand voice
- `/direct-response-copy` - Conversion copy
- `/email-sequences` - Email sequences
- `/content-atomizer` - Repurpose content
- `/newsletter` - Newsletter formats
- `/lead-magnet` - Lead magnet concepts
