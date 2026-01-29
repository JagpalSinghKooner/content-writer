# HushAway®: Article Writing Workflow

This is the quick workflow reference for writing SEO articles. Articles are written here, previewed, then copied to the main HushAway® website.

**For comprehensive verification processes, checklists, and detailed guidance, see:** `.claude/skills/write-article.md`

---

## HARD GATES (Zero Bypass Policy)

**ALL RULES ARE HARD FORCED. NO ESCAPES. NO EXCEPTIONS.**

**ALWAYS START WITH `/orchestrator`** - It diagnoses the optimal approach and routes to the right skills.

The workflow has **SIX mandatory gates**. An article cannot proceed until each gate shows PASS. All gates are fully automated.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         6-GATE CONTENT WORKFLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

STEP 0: Run /orchestrator ──────────── Entry point: diagnoses needs, routes to skills
           │
STEP 1: Choose Article ─────────────── Select from ARTICLE-ORDER.md
           │
STEP 2: Run /keyword-research ──────── Validate keywords + Perplexity MCP (MANDATORY)
           │
           ▼
    ┌──────────────┐
    │ KEYWORD GATE │ ← Gate 1: Keywords validated + Perplexity verified
    └──────────────┘
           │
STEP 3: Complete Research ──────────── Review Perplexity data + remaining sections
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
STEP 5.5: Verify Libraries ────────── Pre-flight check (keyword + angle entries exist)
           │
STEP 6: Write with /seo-content ────── Article creation
           │
           ▼
    ┌──────────────┐
    │ CONTENT GATE │ ← Gate 4: Content passes 23 checks
    └──────────────┘
           │
STEP 7a: Run /direct-response-copy ─── Conversion review (skill FIRST)
           │
STEP 7b: Run check-conversion-gate.sh ── Conversion verification (script SECOND)
           │
           ▼
    ┌────────────────┐
    │ CONVERSION GATE│ ← Gate 5: Conversion elements verified
    └────────────────┘
           │
           ▼
    ┌──────────────┐
    │  FINAL GATE  │ ← Gate 6: All checks complete
    └──────────────┘
           │
STEP 8: Preview & Export
```

---

### Gate 1: Keyword Gate (After Keyword Research + Perplexity)
```bash
.claude/scripts/check-keyword-gate.sh [research-file]
```
- **Must show:** `KEYWORD GATE: PASS`
- **Checks:** keywordStatus, target keyword validated, secondary keywords (5+), **perplexityUsed: true**, PAA questions (7+), competitor gaps, research sources
- **Exit code:** 0 = PASS, 1 = FAIL
- **Auto-update:** On PASS, automatically adds entry to `.claude/keyword-library.md`
- **Requirement:** Perplexity MCP must be used during keyword research
- **Research CANNOT begin until this gate shows PASS**

### Gate 2: Research Gate (After Research Complete)
```bash
.claude/scripts/check-research-gate.sh [research-file]
```
- **Must show:** `RESEARCH GATE: PASS`
- **Checks:** gateStatus, researchStatus, keywords, search intent, competitor gaps, PAA questions, sources
- **Exit code:** 0 = PASS, 1 = FAIL
- **Positioning CANNOT begin until this gate shows PASS**

### Gate 3: Angle Gate (After Positioning Angles)
```bash
.claude/scripts/check-angle-gate.sh [research-file]
```
- **Must show:** `ANGLE GATE: PASS`
- **Checks:** angleStatus, selected angle documented, headline direction, counter-positions defined
- **Exit code:** 0 = PASS, 1 = FAIL
- **Auto-update:** On PASS, automatically adds entry to `.claude/angle-library.md`
- **Writing CANNOT begin until this gate shows PASS**

### Gate 4: Content Gate (After Writing)
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster]
```
- **Must show:** `CONTENT GATE: PASS`
- **Checks:** 23 sections covering all humanise-content.md rules
- **Exit code:** 0 = PASS, 1 = FAIL
- **Conversion review CANNOT begin until this gate shows PASS**

### Gate 5: Conversion Gate (After Content Gate)

**This gate requires TWO steps:**
1. Run `/direct-response-copy` skill for AI-assisted conversion review
2. Run `check-conversion-gate.sh` script for automated verification

```bash
.claude/scripts/check-conversion-gate.sh [article-file]
```
- **Must show:** `CONVERSION GATE: PASS`
- **Checks:** 7 automated checks for conversion elements
- **Exit code:** 0 = PASS, 1 = FAIL
- **Final Gate CANNOT proceed until this gate shows PASS**

**Remediation:** If script shows FAIL, fix issues and re-run script only (not the skill again).

**Automated Checks (7 total):**

| Check | Requirement |
|-------|-------------|
| 1. Parent Objections | At least 2 of 4 objections addressed |
| 2. CTA Clarity | "Free forever" language present |
| 3. Low-Friction | No commitment barriers (no "trial", "subscribe") |
| 4. Differentiation | 3+ neurodivergent-first mentions |
| 5. HushAway® Prominence | 5+ mentions, 2+ in conversion contexts |
| 6. Sound Sanctuary CTA | 2+ mentions of destination |
| 7. Risk Reversal | Risk-free language present |

**Parent Objections Detected:**
1. "Another app won't help" → passive sound, no engagement required
2. "Too tired to try" → zero learning curve, just press play
3. "Is this actually different?" → neurodivergent-first, not adapted generic
4. "What if my child won't use it?" → free forever, nothing to lose

### Gate 6: Final Gate (Before Export)
```bash
.claude/scripts/check-final-gate.sh [article-file] [hub|cluster]
```
- **Must show:** `FINAL GATE: PASS`
- **Checks:** Frontmatter complete (title, meta, dates), word count, file location, trademark verification
- **Exit code:** 0 = proceed, 1 = blocked
- **Auto-update:** On PASS, automatically updates status in `ARTICLE-ORDER.md`
- **Export CANNOT proceed until this gate passes**

**This gate is FULLY AUTOMATED. No manual verification required.**

### Enforcement Rules
1. **All gates automated** - Every gate has a script. If a gate fails, fix the content and re-run the script
2. **No partial passes** - ALL checks must pass, not just most
3. **No skipping gates** - Each gate must be run in sequence
4. **No exceptions** - These rules apply to every article, every time
5. **Skills are MANDATORY** - /orchestrator, /keyword-research, /positioning-angles, /seo-content, and /direct-response-copy must ALL run
6. **Gate 5 requires BOTH** - Run /direct-response-copy skill first, THEN run check-conversion-gate.sh script

---

## Quick Start

**Always start with `/orchestrator`** - It will guide you through the workflow.

0. **Run `/orchestrator` skill** - Entry point that diagnoses needs and routes to right skills
1. **READ `ARTICLE-ORDER.md`** to select next article in priority order
2. **READ `.claude/keyword-library.md`** to see previously validated keywords
3. **Run `/keyword-research` skill** to validate and expand keywords
4. **Run keyword gate:** `.claude/scripts/check-keyword-gate.sh [research-file]` - MUST show PASS (auto-updates keyword library)
5. **Update research file** with validated keyword and secondary keywords
6. Complete research for the article (competitors, PAA, sources)
7. **Run research gate:** `.claude/scripts/check-research-gate.sh [research-file]` - MUST show PASS
8. **READ `.claude/angle-library.md`** to see all angles already used
9. **Run `/positioning-angles` skill** to find article-specific angle
10. **Run angle gate:** `.claude/scripts/check-angle-gate.sh [research-file]` - MUST show PASS (auto-updates angle library)
11. Complete HushAway® Prominence Planning using the selected angle
12. **VERIFY both libraries** have entries for this article before writing
13. Use `/seo-content` skill to write the article
14. **Run content gate:** `.claude/scripts/master-gate.sh [filename] [hub|cluster]` - MUST show PASS
15. Fix any failures, re-run script until PASS
16. **Run `/direct-response-copy` skill** for conversion review
17. **Run conversion gate:** `.claude/scripts/check-conversion-gate.sh [article-file]` - MUST show PASS
18. Fix any conversion issues, re-run script until PASS
19. **Run final gate:** `.claude/scripts/check-final-gate.sh [article-file] [hub|cluster]` - MUST show PASS (auto-updates ARTICLE-ORDER.md)
20. Preview with `npm run dev`
21. Export to main website

---

## Step 1: Choose Article (Seed Keyword)

Open `ARTICLE-ORDER.md` and select the next article in priority order. **The keywords provided are SEED keywords - starting points, not final targets.**

The file lists articles by search volume (highest first) with status tracking and prompts for each article.

**Note:** The seed keyword will be validated and potentially improved in Step 2.

---

## Step 2: Run Keyword Research (MANDATORY)

**Before any research begins, run the `/keyword-research` skill.**

This is NOT optional. Every article requires dynamic keyword validation.

**Perplexity MCP is REQUIRED.** The Keyword Gate will FAIL without it.
- Ensure Perplexity MCP is configured: `claude mcp add perplexity --env PERPLEXITY_API_KEY=<your-key>`
- The skill uses Perplexity for PAA questions, competitor analysis, and research sources
- Gate 1 checks `perplexityUsed: true` in the research file

### Before running skill:
1. **READ `.claude/keyword-library.md`** to see previously validated keywords
2. Note existing keywords for clustering opportunities

### Invoke the skill:
```
/keyword-research
```

### Provide context:
- **Seed keyword:** [from ARTICLE-ORDER.md]
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

2. **Auto-update `.claude/keyword-library.md`** with validated keyword:
   - Add new row to "Validated Keywords" table
   - Include: Article, Pillar, Target Keyword, Volume, Secondary Keywords, Date

3. **Run the Keyword Gate:**
```bash
.claude/scripts/check-keyword-gate.sh [research-file]
```

**MUST show `KEYWORD GATE: PASS` before proceeding to Step 3.**

---

## Step 3: Complete Research

**After Keyword Gate passes**, complete research for the article.

**Note:** Perplexity MCP already populated key research sections during Step 2. This step completes the remaining sections and reviews the Perplexity data.

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

**MUST show `RESEARCH GATE: PASS` before proceeding to Step 4.**

---

## Step 4: Run Positioning Angles (MANDATORY)

**After Research Gate is unlocked, run the `/positioning-angles` skill.**

This is NOT optional. Every article requires a dynamic, article-specific angle.

### Before running skill:
1. **READ `.claude/angle-library.md`** to see all angles already used
2. Note any patterns that have been overused
3. Prioritise fresh angles that haven't been used before

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

3. **Auto-update `.claude/angle-library.md`** with selected angle:
   - Add new row to "Angles Used" table
   - Include: Article, Pillar, Angle Name, Core Insight, Headline Direction, Date
   - Update "Pattern Tracking" if a recurring theme is identified

4. **Run the Angle Gate:**
```bash
.claude/scripts/check-angle-gate.sh [research-file]
```

**MUST show `ANGLE GATE: PASS` before proceeding to Step 5.**

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

**PASS (exit code 0):** All checks passed. Proceed to next gate.

**FAIL (exit code 1):** Failures found.
1. Review failures listed in output
2. Fix ALL failures in article
3. Re-run script (NOT the skill)
4. Repeat until PASS

**Do NOT proceed with FAIL. No exceptions.**

**All checks are fully automated.** The gate now includes 23 sections covering:
- Banned words, phrases, and AI-isms
- Frequency limits and intensifiers
- Structural patterns (per-section limits, consecutive patterns)
- Human voice markers (contractions, And/But, We language)
- Self-answering questions (auto-detected)
- Paragraph starters (auto-detected per section)
- List structure variety (auto-detected)
- Section length variety (auto-detected)
- External link sources (UK-approved check)

**PASS = Proceed to next gate. FAIL = Fix and re-run script. All gates are fully automated.**

---

## Step 7.5: Run Conversion Gate (MANDATORY)

**After Content Gate shows PASS:**
1. Run `/direct-response-copy` skill for AI-assisted conversion review
2. Run `check-conversion-gate.sh` script for automated verification

```bash
.claude/scripts/check-conversion-gate.sh [article-file]
```

Example:
```bash
.claude/scripts/check-conversion-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md
```

### What the Script Checks (7 Automated Checks)

| Check | Requirement | Auto-Detection |
|-------|-------------|----------------|
| 1. Parent Objections | 2+ of 4 objections addressed | Keyword patterns |
| 2. CTA Clarity | "Free forever" language | Text matching |
| 3. Low-Friction | No commitment barriers | Banned phrase detection |
| 4. Differentiation | 3+ neurodivergent-first mentions | Pattern count |
| 5. HushAway® Prominence | 5+ total, 2+ in conversion contexts | Context analysis |
| 6. Sound Sanctuary CTA | 2+ mentions | Text count |
| 7. Risk Reversal | Risk-free language present | Pattern matching |

### Gate Status

**PASS (exit code 0):** All checks passed. Proceed to Final Gate.

**FAIL (exit code 1):** Failures found.
1. Review failures listed in output
2. Fix ALL failures in article
3. Re-run script (NOT the skill again)
4. Repeat until PASS

**Remediation:** Skill runs once. After initial review, only re-run the script.

### Parent Objections (Auto-Detected)

| Objection | Keywords Detected |
|-----------|-------------------|
| "Another app won't help" | passive sound, no engagement, just listen |
| "Too tired to try" | zero learning curve, just press play, no setup |
| "Is this actually different?" | neurodivergent-first, designed specifically, not adapted |
| "What if my child won't use it?" | free forever, nothing to lose, no risk |

**All checks are fully automated. PASS = proceed to Final Gate. FAIL = fix and re-run script.**

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

## Step 9: Update Tracking and Export to Main Site

**After Final Gate shows PASS:**

1. **Update `ARTICLE-ORDER.md`:**
   - Mark article checkbox as complete: `- [x]`
   - This tracks overall progress across all articles

2. **Export to main site:**
   - Copy markdown content (meta description is in frontmatter)
   - Paste into main HushAway® website CMS
   - Add featured image
   - Replace any `[LINK TO: Article Title]` placeholders with actual links
   - Publish
   - Update status in local file to `published`

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
/ARTICLE-ORDER.md                       - Full article list, priority order, status tracking, prompts
/.claude/claude.md                      - Brand voice, product info, rules reference
/.claude/agents.md                      - This workflow guide
/.claude/angle-library.md               - Central angle registry (grows dynamically)
/.claude/keyword-library.md             - Central keyword registry (grows dynamically)
/.claude/humanise-content.md           - Master content rules (50+ banned words, limits)
/.claude/scripts/check-keyword-gate.sh    - Keyword gate (after /keyword-research)
/.claude/scripts/check-research-gate.sh  - Research gate (after research complete)
/.claude/scripts/check-angle-gate.sh     - Angle gate (after /positioning-angles)
/.claude/scripts/master-gate.sh          - Content gate (23 sections)
/.claude/scripts/check-conversion-gate.sh - Conversion gate (after /direct-response-copy)
/.claude/scripts/check-final-gate.sh     - Final gate (before export)
/.claude/skills/write-article.md         - Detailed article writing process
/.claude/skills/keyword-research/      - Keyword research skill
/.claude/skills/positioning-angles/    - Positioning angles skill
/.claude/skills/seo-content/           - SEO content writing skill
/.claude/skills/                        - Other marketing skills
```

---

## Skills Reference

### Entry Point (Always Start Here)

**`/orchestrator`** - Marketing strategist that diagnoses your needs and routes to the right skills. Use this when:
- Starting any new content task
- Unsure which skill to use
- Need a multi-step workflow
- Have a vague marketing request

### MANDATORY for Every Article (in order)

| Step | Skill/Script | Purpose | Gate |
|------|--------------|---------|------|
| 0 | `/orchestrator` | Diagnose + route | - |
| 2 | `/keyword-research` | Validate keywords | Keyword Gate |
| 4 | `/positioning-angles` | Find article angle | Angle Gate |
| 6 | `/seo-content` | Write the article | Content Gate |
| 7a | `/direct-response-copy` | Conversion review (skill) | - |
| 7b | `check-conversion-gate.sh` | Conversion verification (script) | Conversion Gate |
| 8 | `check-final-gate.sh` | Pre-export verification | Final Gate |

**CANNOT SKIP** - All skills AND scripts in the table above are mandatory for every article.
**Gate 5 requires BOTH:** Run skill first, then run script for automated verification.

### For Other Content

- `/brand-voice` - Extract or refine brand voice
- `/email-sequences` - Email nurture sequences
- `/content-atomizer` - Repurpose content for social
- `/newsletter` - Newsletter formats
- `/lead-magnet` - Lead magnet concepts

### MCP Integration Status

| MCP Server | Status | Integration Point |
|------------|--------|-------------------|
| **Perplexity MCP** | IMPLEMENTED | Step 2: /keyword-research |
| **DataForSEO MCP** | PLANNED | Step 2: exact volumes (future) |

**Perplexity MCP (Active):**
- Runs during `/keyword-research` skill
- Provides: real PAA questions, competitor analysis, research sources, trend data
- Keyword Gate verifies `perplexityUsed: true`

See `LIVE-DATA-WORKFLOW.md` for DataForSEO implementation plan.
