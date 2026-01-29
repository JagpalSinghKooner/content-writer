# HushAway® Article Writing Skill

**Purpose:** Complete guide to writing a HushAway® SEO article from scratch.

---

## 6-GATE WORKFLOW OVERVIEW

**ALWAYS START WITH `/orchestrator`** - It diagnoses the optimal approach and routes to the right skills.

**Every article MUST pass through 6 gates. No exceptions. No skipping.**

```
STEP 0: /orchestrator ──────────────── Entry point: diagnoses, routes
           │
STEP 1: Choose Article ─────────────── Select from ARTICLE-ORDER.md
           │
STEP 2: /keyword-research ──────────── MANDATORY skill
           │
    ┌──────────────┐
    │ KEYWORD GATE │ ← Must pass before research
    └──────────────┘
           │
STEP 3: Complete Research
           │
    ┌──────────────┐
    │ RESEARCH GATE│ ← Must pass before angles
    └──────────────┘
           │
STEP 4: /positioning-angles ────────── MANDATORY skill
           │
    ┌──────────────┐
    │  ANGLE GATE  │ ← Must pass before writing
    └──────────────┘
           │
STEP 5: Prominence Planning
           │
STEP 6: /seo-content ───────────────── Write article
           │
    ┌──────────────┐
    │ CONTENT GATE │ ← Must pass before conversion review
    └──────────────┘
           │
STEP 7: check-conversion-gate.sh ───── Conversion verification
           │
    ┌────────────────┐
    │CONVERSION GATE │ ← Must pass before export
    └────────────────┘
           │
    ┌──────────────┐
    │  FINAL GATE  │
    └──────────────┘
```

---

## Quick Start Instructions

**Always start with `/orchestrator`** - It will guide you through the workflow.

When you invoke this skill with `/write-article`, follow these steps:

### Step 0: Run Orchestrator (Entry Point)

**Start every session with:**
```
/orchestrator
```

The orchestrator will:
1. Diagnose what you need to do
2. Route you to the right skills in order
3. Guide you through the workflow

### Step 1: Load Project Context

**First, read these files to understand the project:**
- `.claude/claude.md` - HushAway® brand voice, critical rules
- `ARTICLE-ORDER.md` - Full article list, priority order, status tracking
- `.claude/agents.md` - Complete article writing workflow with 6 gates

**Library files (read at point of use):**
- `.claude/keyword-library.md` - Read BEFORE running /keyword-research (Step 3)
- `.claude/angle-library.md` - Read BEFORE running /positioning-angles (Step 5)

**Why read libraries at point of use?**
- `keyword-library.md` must be checked immediately before keyword validation to avoid duplicates
- `angle-library.md` must be checked immediately before angle selection to ensure diversity
- Reading at the right moment ensures fresh context for each skill

**Quick test:** Ask yourself "What are HushAway®'s forbidden words?"
- Answer should include: No emojis, no em-dashes, UK English, no deficit language, no AI-isms

### Step 2: Identify Article to Write (Seed Keyword)

**Option A: Use Content Dashboard (Recommended)**
1. Open the dashboard in browser
2. Filter by HIGH priority articles in "Draft" status
3. Note the article title and SEED keyword (this will be validated in Step 3)

**Option B: Ask User**
- "Which article would you like me to write?"
- User will provide title and pillar number

**Priority Order:** See `ARTICLE-ORDER.md` for the full priority list with search volumes and status tracking.

**Note:** Keywords in ARTICLE-ORDER.md are SEEDS - they will be validated/improved in Step 3.

### Step 3: Run Keyword Research (MANDATORY - CANNOT SKIP)

**Before ANY research begins, run the `/keyword-research` skill.**

**Using library context from Step 1:**
1. Reference `.claude/keyword-library.md` (already loaded) for previously validated keywords
2. Note existing keywords for clustering opportunities
3. Identify which pillar keywords might create internal linking opportunities

```
/keyword-research
```

**Provide context:**
- **Seed keyword:** [from ARTICLE-ORDER.md]
- **Pillar topic:** [pillar name]
- **Content type:** [Hub or Cluster]
- **Business context:** HushAway® sound therapy for neurodivergent children

**The skill will output:**
1. Validated target keyword (may confirm seed or suggest better alternative)
2. Secondary keyword cluster (5-10 related keywords)
3. Search volume validation
4. Competitor opportunity assessment
5. Content type recommendation

**After skill completes:**

1. **Update the research file frontmatter:**
   ```yaml
   keywordStatus: validated
   targetKeyword: "[validated keyword]"
   secondaryKeywords:
     - "[keyword 1]"
     - "[keyword 2]"
     - "[keyword 3]"
     - "[keyword 4]"
     - "[keyword 5]"
   searchVolume: "[volume]"
   ```

2. **Auto-update `.claude/keyword-library.md`** with validated keyword:
   - Add new row to "Validated Keywords" table
   - Include: Article, Pillar, Target Keyword, Volume, Secondary Keywords, Date

3. **Run the Keyword Gate:**
   ```bash
   .claude/scripts/check-keyword-gate.sh [research-file]
   ```

**MUST show `KEYWORD GATE: PASS` before proceeding.**

### Step 4: Complete Research

**After Keyword Gate is unlocked**, complete the research file.

**Research file location:**
`/research/pillar-[N]-[topic-name]/[article-slug]-research.md`

**Verify these elements are present:**
- [ ] Target keyword (validated from Step 3)
- [ ] Secondary keywords (5+ from Step 3)
- [ ] Search intent analysis
- [ ] PAA (People Also Ask) questions captured (5+)
- [ ] Competitor analysis complete (top 3-5 ranking articles reviewed)
- [ ] Competitor gaps identified (3+)
- [ ] Key statistics identified (with sources)

**When research is complete:**
- Set `researchStatus: complete` in frontmatter
- Set `gateStatus: unlocked` in frontmatter

**Run the Research Gate:**
```bash
.claude/scripts/check-research-gate.sh [research-file]
```

**MUST show `RESEARCH GATE: PASS` before proceeding.**

### Step 5: Run Positioning Angles (MANDATORY - CANNOT SKIP)

**After Research Gate is unlocked, run the `/positioning-angles` skill.**

**Using library context from Step 1:**
1. Reference `.claude/angle-library.md` (already loaded) for all angles already used
2. Note any patterns that have been overused
3. Prioritise fresh angles that haven't been used before
4. Avoid reusing patterns within the same pillar

```
/positioning-angles
```

**Provide context:**
- **Article topic:** [from research]
- **Target keyword:** [validated keyword from Step 3]
- **Competitor gaps:** [from research - what competitors miss]
- **Search intent:** [from research]
- **HushAway® differentiator:** Sound therapy for neurodivergent children

**The skill will output:**
1. 3-5 distinct angle options for THIS specific article
2. Psychology/reasoning behind each angle
3. Headline directions for each
4. Recommended starting angle

**After skill completes:**

1. **Select ONE angle** as the primary angle

2. **Update the research file:**
   ```yaml
   angleStatus: selected
   selectedAngle: "[Name of chosen angle]"
   angleDescription: "[One sentence description]"
   headlineDirection: "[Example headline]"
   counterPositions:
     - "[Counter-position 1]"
     - "[Counter-position 2]"
     - "[Counter-position 3]"
   ```

3. **Auto-update `.claude/angle-library.md`** with selected angle:
   - Add new row to "Angles Used" table
   - Include: Article, Pillar, Angle Name, Core Insight, Headline Direction, Date
   - Update "Pattern Tracking" if a recurring theme is identified

4. **Run the Angle Gate:**
   ```bash
   .claude/scripts/check-angle-gate.sh [research-file]
   ```

**MUST show `ANGLE GATE: PASS` before proceeding.**

### Step 6: HushAway® Prominence Planning (REQUIRED)

**After Angle Gate is unlocked**, plan where HushAway® appears using your SELECTED ANGLE.

**Your angle from Step 5 informs ALL prominence planning:**

| Planning Element | How Angle Informs It |
|------------------|---------------------|
| Introduction mention | Frame HushAway® using the angle's core insight |
| Counter-positions | Use the counter-positions from Step 5 |
| Comparison section | Build around the angle's differentiation |
| CTA framing | Connect Sound Sanctuary to the angle's promise |

**Complete this checklist:**

- [ ] **Introduction mention planned:** Using selected angle within first 500 words
- [ ] **Counter-positions mapped:** Using positions from Step 5
- [ ] **Differentiator section planned:** Using angle insight
- [ ] **Comparison format chosen:** Highlighting angle's differentiation

**Minimum HushAway® presence:**
- Introduction: 1 mention using angle framing
- Body sections: 50%+ of H2 sections close with angle-informed positioning
- Closing: Comparison element + Sound Sanctuary CTA

### Step 7: Write with seo-content Skill

**Invoke the seo-content skill:**

```
/seo-content
```

**Provide ALL of these parameters:**
- **Target keyword:** [validated from Step 3]
- **Secondary keywords:** [from Step 3]
- **Article title:** [from frontmatter]
- **Content type:** [Pillar Hub or Cluster]
- **Word count minimum:** [3000 for hub / 1500 for cluster]
- **Selected angle:** [from Step 5]
- **Headline direction:** [from Step 5]
- **Counter-positions:** [from Step 5]
- **Prominence plan:** [from Step 6]

### Step 8: Run Conversion Gate (MANDATORY)

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

**The script automatically checks (7 checks):**

| Check | Requirement | Auto-Detection |
|-------|-------------|----------------|
| 1. Parent Objections | 2+ of 4 objections addressed | Keyword patterns |
| 2. CTA Clarity | "Free forever" language | Text matching |
| 3. Low-Friction | No commitment barriers | Banned phrase detection |
| 4. Differentiation | 3+ neurodivergent-first mentions | Pattern count |
| 5. HushAway® Prominence | 5+ total, 2+ in conversion contexts | Context analysis |
| 6. Sound Sanctuary CTA | 2+ mentions | Text count |
| 7. Risk Reversal | Risk-free language present | Pattern matching |

**Parent Objections (Auto-Detected):**

| Objection | Keywords Detected |
|-----------|-------------------|
| "Another app won't help" | passive sound, no engagement, just listen |
| "Too tired to try" | zero learning curve, just press play, no setup |
| "Is this actually different?" | neurodivergent-first, designed specifically |
| "What if my child won't use it?" | free forever, nothing to lose, no risk |

**If FAIL:**
1. Review failures listed in script output
2. Fix ALL failures in article
3. Re-run script (NOT the skill again - skill only runs once)
4. Repeat until PASS

**Conversion CTA Patterns:**

**Good:**
- "Try the Sound Sanctuary free, forever. Just enter your name and email."
- "No subscription needed. No credit card. Just gentle sounds, ready when you need them."
- "See if it helps. It costs nothing to find out."

**Avoid:**
- "Sign up for our premium service"
- "Start your free trial" (implies it ends)
- "Subscribe to get access"

**CONVERSION GATE MUST show PASS before proceeding to Final Gate.**

---

## Pre-Writing Checklist (Gates 1-3 Must Show PASS Before Writing)

**Do not start writing until all gates show PASS.**

### Gate 1: Keyword Gate Checklist

| Element | Source | Status |
|---------|--------|--------|
| `/keyword-research` skill run | Skill output | [ ] Completed |
| keywordStatus | Research file frontmatter | [ ] = "validated" |
| Target keyword validated | Research file | [ ] Confirmed |
| Secondary keywords | Research file | [ ] 5+ listed |
| Search volume | Research file | [ ] Documented |
| Keyword Gate script | `.claude/scripts/check-keyword-gate.sh` | [ ] Shows PASS |

### Gate 2: Research Gate Checklist

| Element | Source | Status |
|---------|--------|--------|
| Research file exists | `/research/pillar-[N]-[topic-name]/[article]-research.md` | [ ] Exists |
| researchStatus | Research file frontmatter | [ ] = "complete" |
| gateStatus | Research file frontmatter | [ ] = "unlocked" |
| Search intent analysis | Research file | [ ] Documented |
| PAA questions | Research file | [ ] 5+ captured |
| Competitor analysis | Research file | [ ] Top 3-5 reviewed |
| Competitor gaps | Research file | [ ] 3+ identified |
| Statistics | Research file + eeat-library.md | [ ] 3+ with sources |
| Research Gate script | `.claude/scripts/check-research-gate.sh` | [ ] Shows PASS |

### Gate 3: Angle Gate Checklist

| Element | Source | Status |
|---------|--------|--------|
| `/positioning-angles` skill run | Skill output | [ ] Completed |
| angleStatus | Research file frontmatter | [ ] = "selected" |
| selectedAngle | Research file | [ ] Documented |
| angleDescription | Research file | [ ] One sentence |
| headlineDirection | Research file | [ ] Example headline |
| counterPositions | Research file | [ ] 2+ defined |
| Angle Gate script | `.claude/scripts/check-angle-gate.sh` | [ ] Shows PASS |

### Research File Structure (Updated)

Your research file MUST contain:

```yaml
---
# Gate 1: Keyword Research (from /keyword-research skill)
keywordStatus: validated
targetKeyword: "[validated keyword]"
secondaryKeywords:
  - "[keyword 1]"
  - "[keyword 2]"
  - "[keyword 3]"
  - "[keyword 4]"
  - "[keyword 5]"
searchVolume: "[volume]"

# Gate 2: Research
researchStatus: complete
gateStatus: unlocked
dateCompleted: [YYYY-MM-DD]

# Gate 3: Positioning Angles (from /positioning-angles skill)
angleStatus: selected
selectedAngle: "[Name of chosen angle]"
angleDescription: "[One sentence description]"
headlineDirection: "[Example headline]"
counterPositions:
  - "[Counter-position 1]"
  - "[Counter-position 2]"
---

# [Article Title] Research

## Search Intent
[Informational / Commercial / etc.]

## PAA Questions
- Question 1?
- Question 2?
- Question 3?
- Question 4?
- Question 5?

## Competitor Analysis
### [Competitor URL 1]
- Word count:
- Key points covered:
- Gaps/opportunities:

## Competitor Gaps (What They Miss)
1. [Gap 1]
2. [Gap 2]
3. [Gap 3]

## Statistics to Include
- [Stat 1] - Source: [Name], Year: [YYYY], URL: [link]
- [Stat 2] - Source: [Name], Year: [YYYY], URL: [link]
- [Stat 3] - Source: [Name], Year: [YYYY], URL: [link]

## Content Outline
- H2: ...
- H2: ...
```

**Gates 1-3 (Keyword, Research, Angle) must show PASS before writing begins.**

---

## CRITICAL RULES (Must Follow)

### Forbidden Elements
- **[NO]** emojis (anywhere, ever)
- **[NO]** em-dashes (—) use commas, full stops, or semicolons
- **[NO]** American English (always UK: colour, behaviour, mum, organisation)
- **[NO]** deficit language: "fix," "cure," "normal," "suffering from," "special needs"
- **[NO]** clinical terms: "disorder," "patient," "treatment," "symptoms"
- **[NO]** AI-isms: "delve," "landscape," "leverage," "comprehensive," "robust," "crucial," "vital"

### Required Elements
- **[YES]** UK English throughout
- **[YES]** Primary keyword in first 100-150 words
- **[YES]** Empathy before solutions (acknowledge parent struggle first)
- **[YES]** Signature phrases: "big feelings," "soft place to land," "feel safe in their body"
- **[YES]** Research cited warmly (never clinically)
- **[YES]** Gentle CTA: "Explore the Sound Sanctuary"
- **[YES]** Short paragraphs (2-4 sentences)

---

## Brand Voice Quick Reference

**Tone:** Warm, understanding friend who's been there. Parent-to-parent, never expert-to-patient.

**Voice Essence:**
- Gentle but credible
- Soft but confident
- Empathetic but never clinical
- Relatable, real, honest

**Signature Vocabulary:**
- "Big feelings" (not "emotions" or "meltdowns")
- "Soft place to land" (safe space metaphor)
- "Feel safe in their body" (sensory safety)
- "Children who feel everything" (empowering framing)
- "Gentle sound support" (what we offer)

---

## Semantic Keyword Integration Strategy

### Understanding Secondary Keywords

Every HushAway® article now targets 3-5 secondary keywords in addition to the primary keyword. These are semantic variations and long-tail keywords that help capture more search traffic and establish topical authority.

**Where to find secondary keywords:**
- Look in the article's frontmatter: `secondaryKeywords` field
- Or check the content-database.json for your article

### Natural Placement Strategy

**1. H2 Headings (1-2 secondary keywords)**
   - Include secondary keywords in major section headings
   - Keep natural and readable (not keyword-stuffed)
   - Example: "Understanding ADHD Sleep Problems" (uses "ADHD sleep problems")

**2. Introduction (1 secondary keyword in first 150 words)**
   - Weave one secondary keyword naturally into opening
   - Don't force it—maintain empathy-first tone
   - Example: "If bedtime battles with your ADHD child feel exhausting..."

**3. Body Sections (semantic variations)**
   - Use secondary keywords naturally throughout body
   - Vary the phrasing (don't repeat exact keyword)
   - Focus on readability over keyword density

**4. H2/H3 Headings from PAA Questions (2-3 secondary keywords)**
   - Use PAA questions from research as natural H2/H3 headings throughout the article
   - Example: "Why Does My ADHD Child Refuse to Go to Bed?" as an H2 heading

**5. Meta Description (primary + 1 secondary if space)**
   - 150-160 characters total
   - Primary keyword + one secondary if it fits naturally

### Example: ADHD Bedtime Resistance Article

**Primary:** "ADHD bedtime resistance"
**Secondary:** "ADHD child won't go to bed", "bedtime battles ADHD", "ADHD refuses bedtime", "why ADHD kids fight sleep"

**H2 Headings:**
- "Why ADHD Children Fight Sleep" ✓ (semantic variation)
- "Understanding Bedtime Battles in ADHD" ✓ (uses "bedtime battles ADHD")
- "When Your ADHD Child Won't Go to Bed: What's Really Happening" ✓ (uses secondary keyword)

**Introduction example:**
> "If bedtime with your ADHD child feels like a nightly battle you're losing, you're far from alone. Many parents of children with ADHD experience the same bedtime resistance—that moment when your exhausted child suddenly has boundless energy the second you mention sleep..."

(Uses primary "bedtime resistance" and secondary "bedtime battles" naturally)

**H2/H3 Headings (from PAA questions):**
- H2: "Why Does My ADHD Child Refuse to Go to Bed?" ✓ (uses "ADHD refuses bedtime")
- H3: "How Can I Stop Bedtime Battles with My ADHD Child?" ✓ (uses "bedtime battles ADHD")

### What NOT to Do

**[BAD] Keyword stuffing:**
"ADHD bedtime resistance affects children with ADHD who have bedtime battles and ADHD bedtime issues..."

**[BAD] Forcing keywords awkwardly:**
"Your ADHD child won't go to bed when ADHD refuses bedtime during bedtime battles ADHD..."

**[BAD] Sacrificing brand voice for keywords:**
Remember: HushAway®'s warm, empathetic tone is more important than keyword density

### Quality Check

Before finalizing article:
- [ ] Primary keyword appears in first 100-150 words
- [ ] 1-2 secondary keywords in H2 headings
- [ ] Secondary keywords used naturally 4-6 times throughout article
- [ ] PAA questions used as natural H2/H3 headings throughout article
- [ ] Keywords feel natural, not forced
- [ ] Brand voice maintained throughout

---

## Article Structure Template

### Title Tag (Under 60 Characters)

**Requirements:**
- Maximum 60 characters (to avoid truncation in search results)
- Primary keyword front-loaded (appears in first 3-4 words)
- Compelling and click-worthy
- Matches search intent

**Verification Steps:**
1. Count characters (use text editor or online tool)
2. If over 60: shorten without losing meaning
3. Verify primary keyword appears early
4. Read aloud to check it sounds natural

**Examples:**
| Title | Characters | Valid |
|-------|------------|-------|
| "ADHD Sleep: Why Your Child Can't Settle at Night" | 49 | Yes |
| "A Comprehensive Guide to Understanding Why Children with ADHD Struggle with Bedtime" | 85 | No (too long) |
| "Neurodivergent Parenting: Support for Exhausted Parents" | 56 | Yes |

**Title Tag Checklist:**
- [ ] Under 60 characters
- [ ] Primary keyword in first 3-4 words
- [ ] No truncation in search preview
- [ ] Compelling and accurate

### Meta Description (140-160 Characters)

**Requirements:**
- Minimum 140 characters (to fill space in search results)
- Maximum 160 characters (to avoid truncation)
- Primary keyword included
- Question + soft answer format preferred
- Compelling call to action

**Pattern:** Validate struggle + offer hope + gentle invitation

**Verification Steps:**
1. Count characters exactly (spaces count)
2. If under 140: expand with relevant detail
3. If over 160: trim without losing core message
4. Verify primary keyword is present
5. Check format follows question + soft answer pattern

**Examples:**

**Good (156 chars):**
> "Struggling with bedtime battles? Discover gentle, research-backed ways to help your ADHD child find calm and settle into sleep naturally."

**Bad (too short - 89 chars):**
> "Tips for helping your ADHD child sleep better at night."

**Bad (too long - 178 chars):**
> "If you're struggling with bedtime battles every single night with your ADHD child, discover our comprehensive guide to gentle, research-backed ways to help them find calm and settle."

**Meta Description Checklist:**
- [ ] Character count is 140-160
- [ ] Primary keyword included
- [ ] Follows question + soft answer format
- [ ] Compelling and click-worthy
- [ ] No truncation in search preview

### Introduction (First 100-150 words)
1. **Acknowledge parent's experience** (empathy first)
2. **Validate this is common/real**
3. **Include primary keyword naturally** in first 2 sentences
4. **Introduce what article covers**

### Body Structure
- **H2s and H3s** for scannable structure
- **Short paragraphs** (2-4 sentences max)
- **Bullet points** for practical lists
- **Research cited warmly** ("Research shows..." not "Studies prove...")
- **Signature phrases woven naturally**

### Required Sections
- **When Professional Support is Needed** (always include, gentle language)
- **Key Takeaways** (2-3 bullet points)

### Linking Strategy
- **Internal links** woven naturally into content (8-10 for hub, 4-6 for cluster), use `[LINK TO: Article Title]` placeholders for unpublished articles
- **External links** woven naturally into content (2-4 to authoritative sources like NHS, ADHD UK)
- **PAA questions** integrated as natural H2/H3 headings throughout (NOT a separate FAQ section)

### Closing
1. **Reassurance and validation**
2. **"You know your child best"**
3. **Gentle CTA:** "Explore the Sound Sanctuary"

**Example closing:**
> "You know your child best. If neurodivergent parenting feels overwhelming right now, you're far from alone. Many parents navigate these same challenges, and finding what works for your family is a journey, not a race. Explore the Sound Sanctuary to discover gentle sound support that meets your child where they are."

---

## Citation Verification Process

Every article requires 2-3 research citations. Follow this process to ensure all citations are accurate and verifiable.

### Step 1: Check the E-E-A-T Library First

**Location:** `/research/eeat-library.md`

If your citation exists in this file:
- Use exactly as provided (already verified)
- Note the source link for reference

### Step 2: If Citation is NOT in the Library

When you want to use a statistic or research finding not in eeat-library.md:

1. **Search for the original source**
   - Find the actual journal, institution, or organisation that published the research
   - Do not rely on other blogs or articles citing the same stat

2. **Verify accuracy**
   - Confirm the statistic matches the original source exactly
   - Check it has not been misquoted or taken out of context
   - Note the exact wording used in the source

3. **Check publication date**
   - Prefer sources from 2020 onwards
   - Where multiple sources exist, prioritise 2022+ research
   - Older sources acceptable only if foundational research

4. **Confirm source reputation**
   - Acceptable: NHS, NICE guidelines, UK universities, peer-reviewed journals, recognised UK research bodies (e.g., ADHD UK, British Psychological Society, Royal College of Psychiatrists)
   - Not acceptable: US-focused sites (use UK equivalents), other blogs, news articles without original source, social media

5. **If verified, add to eeat-library.md**
   - Include: statistic, source name, year, and URL
   - This prevents re-verification work for future articles

6. **If cannot verify, do not use**
   - Find an alternative statistic from a verifiable source
   - Never include unverified claims

### Red Flags (Do Not Use)

- Statistics without traceable original sources
- Research older than 2015 (unless foundational)
- Numbers that seem inflated or sensationalised
- Sources that are just other blogs citing the same unverified stat
- Statistics that have been cited many times but no one links to the original

### Citation Verification Checklist

- [ ] All citations checked against eeat-library.md first
- [ ] Any new citations verified against original source
- [ ] Publication dates noted (prefer 2020+)
- [ ] Sources are reputable institutions/journals
- [ ] New verified citations added to eeat-library.md
- [ ] No unverified statistics included in article

---

## Word Count Verification Process

Word count minimums are non-negotiable. Follow this process to verify.

### Minimum Requirements

| Article Type | Minimum Words | Target Words |
|--------------|---------------|--------------|
| Hub (Pillar) | 3,000 | 3,500-4,000 |
| Cluster | 1,500 | 2,000-2,500 |

### Verification Steps

1. **Count actual words in draft**
   - Use your text editor's word count feature
   - Or run: `wc -w [filename]` in terminal
   - Count body content only (exclude frontmatter)

2. **Compare against minimum**
   - Hub articles: Must be 3,000+ words
   - Cluster articles: Must be 1,500+ words

3. **If under minimum**
   - Identify sections that need expansion (not padding)
   - Add depth to existing sections rather than new filler sections
   - Consider: more examples, additional research, practical steps, common questions
   - Do NOT add fluff or repeat information

4. **Re-count after additions**
   - Verify final count meets minimum
   - Record final count in article frontmatter

5. **Update frontmatter**
   - Set `wordCount` field to actual count
   - This allows dashboard tracking

### Word Count Checklist

- [ ] Word count measured (excluding frontmatter)
- [ ] Count meets minimum (3,000+ hub / 1,500+ cluster)
- [ ] If expanded, additions add genuine value (not padding)
- [ ] Final count recorded in article frontmatter

---

## Banned Words Scanning Process

Systematically scan your article for forbidden elements before publishing.

### Search Patterns by Category

**1. AI-isms (Search for each term)**
```
delve, landscape, leverage, comprehensive, robust, crucial, vital,
cutting-edge, game-changer, unlock, empower, harness, navigate,
realm, multifaceted, myriad, plethora, paradigm, synergy
```

**2. Deficit Language (Search for each term)**
```
fix, cure, normal, suffering from, special needs, disorder,
afflicted, victim, handicapped, deficient, abnormal
```

**3. Clinical Terms (Search for each term)**
```
disorder, patient, treatment, symptoms, diagnosis, therapy,
condition, intervention, clinical, pathology
```

**4. American English (Search and replace)**
| American | UK Replacement |
|----------|----------------|
| mom | mum |
| color | colour |
| behavior | behaviour |
| favor | favour |
| honor | honour |
| organize | organise |
| recognize | recognise |
| realize | realise |
| analyze | analyse |
| center | centre |
| fiber | fibre |
| theater | theatre |
| traveled | travelled |
| canceled | cancelled |
| program (non-computer) | programme |

**5. Em-dashes**
Search for: `—` (em-dash character)
Replace with: comma, full stop, or semicolon depending on context

**6. Emojis**
Visual scan or search for common emoji unicode ranges

**7. HushAway® Trademark**
Search for: `HushAway` (without ®)
Every instance must include the ® symbol (except in URLs like hushaway.com)

### How to Scan

**Option A: Manual search (text editor)**
1. Use Cmd+F (Mac) or Ctrl+F (Windows)
2. Search each term from the lists above
3. Replace or rewrite as needed

**Option B: Command line search**
```bash
# Search for AI-isms
grep -i -E "delve|landscape|leverage|comprehensive|robust|crucial|vital" [filename]

# Search for American spellings
grep -i -E "behavior|color|mom|organize|recognize" [filename]

# Search for em-dashes
grep "—" [filename]
```

**Option C: Regex pattern (covers multiple categories)**
```
(delve|landscape|leverage|comprehensive|robust|crucial|vital|fix|cure|normal|suffering from|special needs|disorder|patient|treatment|symptoms|mom|color|behavior|organize|recognize)
```

### Replacement Guidelines

**When you find a banned word:**

| Found | Replace With |
|-------|--------------|
| comprehensive | thorough, complete, full |
| robust | strong, solid, reliable |
| crucial | important, key, essential |
| vital | important, necessary |
| leverage | use, apply, build on |
| delve | explore, look at, examine |
| disorder | (reframe entirely - avoid the concept) |
| treatment | support, help, approach |
| symptoms | signs, experiences, what you might notice |
| fix | support, help with, ease |
| cure | (avoid - reframe to support/manage) |

### Banned Words Checklist

- [ ] Scanned for AI-isms (none found or all replaced)
- [ ] Scanned for deficit language (none found or all replaced)
- [ ] Scanned for clinical terms (none found or all replaced)
- [ ] Scanned for American English (all converted to UK)
- [ ] Scanned for em-dashes (all replaced with appropriate punctuation)
- [ ] Visual scan for emojis (none present)
- [ ] HushAway® trademark verified (all instances have ® symbol, URLs exempt)

### MANDATORY: Run Master Gate Script

**Use the automated master gate script for all verification.**

```bash
.claude/scripts/master-gate.sh "[filename]" [hub|cluster]
```

**Examples:**
```bash
# Hub article
.claude/scripts/master-gate.sh "src/content/pillar-5-adhd-apps/hub-adhd-apps.md" hub

# Cluster article
.claude/scripts/master-gate.sh "src/content/pillar-7-neurodivergent-parenting/7.1-parent-burnout.md" cluster
```

### Gate Enforcement

**GATE MUST SHOW "PASS" TO PROCEED.**

- Exit code 0 = PASS (all 23 sections passed)
- Exit code 1 = FAIL (failures found)

**If FAIL:**
1. Review failures listed in output
2. Fix ALL failures in article
3. Re-run script (NOT the skill)
4. Repeat until PASS

**Do NOT proceed with FAIL. No exceptions. All gates are fully automated.**

---

## Link Verification Process

Verify all internal and external links before publishing.

### Internal Links

**Step 1: Identify all internal links in your article**
- Links to other HushAway® articles
- Links to Sound Sanctuary page
- Links to About Nicola page

**Step 2: Check if linked articles exist**

Check the content folder:
```
/src/content/pillar-[N]-[topic-name]/
```

**If article EXISTS:** Use actual relative link
```markdown
[parent burnout](/blog/parent-burnout-adhd)
```

**If article DOES NOT EXIST:** Use placeholder format
```markdown
[LINK TO: Parent Burnout ADHD]
```

**Step 3: Verify existing links are correct**
- Open each linked article to confirm it exists
- Verify the URL slug matches the link

**Step 4: Track placeholders for later**
- Note all `[LINK TO: ...]` placeholders
- These will be updated when target articles are published

### External Links

**Step 1: Identify all external links**
- Links to UK sources: NHS, ADHD UK, NICE, BPS, RCP
- Links to research sources
- Links to statistics sources

**Step 2: Verify each link is live**
- Click through to confirm page loads
- Check the content is still relevant
- Verify it has not redirected to a different page

**Step 3: Confirm source authority**
Acceptable external sources (UK only):
- NHS (nhs.uk)
- ADHD UK (adhduk.co.uk)
- NICE guidelines (nice.org.uk)
- British Psychological Society (bps.org.uk)
- Royal College of Psychiatrists (rcpsych.ac.uk)
- UK universities and research institutions
- Peer-reviewed journals
- UK Government health departments

Not acceptable:
- Other blogs (unless highly authoritative)
- Social media
- Wikipedia (use original sources instead)
- Commercial sites with bias

**Step 4: Check link count**
- Target: 2-4 external links per article
- All should be to authoritative sources

### Link Verification Checklist

- [ ] All internal links checked for existence
- [ ] Placeholders used for unpublished articles
- [ ] All external links tested and working
- [ ] External links go to UK authoritative sources only (NHS, ADHD UK, NICE, BPS, RCP)
- [ ] Link count within target range (8-10 internal for hub / 4-6 for cluster, 2-4 external)

---

## Quality Checklist

Before marking article complete, verify:

### PRE-WRITING GATES (All Must Show PASS)
- [ ] `/keyword-research` skill completed
- [ ] **KEYWORD GATE: PASS** (check-keyword-gate.sh)
- [ ] Research file complete
- [ ] **RESEARCH GATE: PASS** (check-research-gate.sh)
- [ ] `/positioning-angles` skill completed
- [ ] **ANGLE GATE: PASS** (check-angle-gate.sh)
- [ ] Selected angle documented with counter-positions
- [ ] Prominence planning complete using selected angle

### CRITICAL RULES (Must Pass)
- [ ] Word count meets minimum (3000+ hub / 1500+ cluster)
- [ ] NO emojis anywhere
- [ ] NO em-dashes (—)
- [ ] UK English only (colour, behaviour, mum, organisation, recognise)
- [ ] NO deficit language (fix, cure, normal, suffering from, special needs)
- [ ] NO clinical terms (disorder, patient, treatment, symptoms)
- [ ] NO AI-isms (delve, landscape, leverage, comprehensive, robust, crucial, vital)
- [ ] HushAway® written with ® symbol every instance (URLs like hushaway.com exempt)

### BRAND VOICE
- [ ] Empathy-first opening (acknowledges parent struggle)
- [ ] Parent-to-parent tone (not expert talking down)
- [ ] Signature phrases included naturally
- [ ] Research cited warmly, not clinically
- [ ] Validation before solutions
- [ ] Gentle CTA at end: "Explore the Sound Sanctuary"

### BRAND PROMINENCE (NEW - CRITICAL)
- [ ] HushAway® mentioned in introduction (within first 500 words)
- [ ] HushAway® positioning in at least 50% of H2 sections
- [ ] Each competitor category closes with HushAway® comparison statement
- [ ] Comparison table or clear differentiation section present
- [ ] Sound Sanctuary CTA in closing
- [ ] Article does NOT read as competitor-focused guide with HushAway® as afterthought

### SEO
- [ ] Title tag under 60 characters (verified by count)
- [ ] Title tag has keyword front-loaded
- [ ] Meta description 140-160 characters (verified by count)
- [ ] Meta description includes primary keyword
- [ ] Meta description follows question + soft answer format
- [ ] Primary keyword in first 100-150 words
- [ ] Primary keyword in at least one H2
- [ ] Internal links woven into content (8-10 for hub / 4-6 for cluster), placeholders used for unpublished articles
- [ ] External links woven into content (2-4 to UK authoritative sources only)
- [ ] PAA questions integrated as natural H2/H3 headings throughout article

### FEATURED SNIPPET OPTIMISATION
- [ ] "What is" queries: 40-60 word definition immediately after H2
- [ ] "How to" queries: Numbered steps with clear action verbs
- [ ] List queries: 5-8 bullet points with consistent formatting
- [ ] Comparison queries: Tables with clear headers where appropriate

### URL STRUCTURE
- [ ] URL slug is all lowercase
- [ ] Uses hyphens (not underscores)
- [ ] Includes primary keyword
- [ ] Under 60 characters
- [ ] No unnecessary stop words (the, a, an, of)

### HUMAN VOICE (AI Detection Avoidance)
- [ ] Sentence lengths varied (short + long mixed)
- [ ] Contractions used naturally (you're, it's, don't)
- [ ] No perfect parallel structure in every list
- [ ] No formulaic transitions
- [ ] Specific examples included (not generic)
- [ ] Mild hedging present ("often", "many parents find")
- [ ] At least 2 sentences starting with "And" or "But"
- [ ] "We" language used at least twice (community feel)
- [ ] No banned openers/conclusions/transitions
- [ ] Intensifiers within limits (very ≤3, really ≤2, etc.)
- [ ] No redundant phrases (completely unique, very important, etc.)
- [ ] Community quotes feel real (specific, emotional, contractions)
- [ ] Hedging density within limits (see below)

**Hedging Density Calculation:**
Max hedges = (word count / 1000) x 8
- 3,000-word hub article: max 24 hedges
- 1,500-word cluster article: max 12 hedges
- Hedge words: may, might, could, potentially, possibly, perhaps, likely, unlikely, often, tend to

### ARTICLE SCHEMA READINESS
- [ ] Title suitable for schema headline
- [ ] Author: Nicola Maria Rose
- [ ] Meta description suitable for schema description
- [ ] Date fields in frontmatter (dateCreated, dateUpdated)

### CONTENT QUALITY
- [ ] Answers search query in first 300 words
- [ ] At least 3 specific examples or numbers
- [ ] Practical takeaways included
- [ ] Professional support guidance when appropriate
- [ ] Short paragraphs (2-4 sentences)
- [ ] Generous white space
- [ ] Bullet points for scannable lists

### VERIFICATION PROCESSES COMPLETED
- [ ] Word count verification process completed (see section above)
- [ ] Citation verification process completed (all sources verified)
- [ ] Banned words scanning completed (AI-isms, deficit, clinical, American English, em-dashes, emojis)
- [ ] Internal link verification completed (all links checked or placeholders used)
- [ ] External link verification completed (all links tested and authoritative)
- [ ] New citations added to eeat-library.md (if any)

### CONVERSION GATE (After Content Gate Shows PASS)
- [ ] `/direct-response-copy` skill run for conversion review (run once)
- [ ] `check-conversion-gate.sh` script run for automated verification
- [ ] At least 2 of 4 parent objections addressed
- [ ] "Free forever" or equivalent clear near primary CTA
- [ ] No commitment language (no "trial", "subscribe")
- [ ] Neurodivergent-first differentiation prominent
- [ ] HushAway® in conversion contexts (not just informational)
- [ ] Risk reversal present (free removes barriers)
- [ ] **CONVERSION GATE: PASS** (if FAIL, fix and re-run script only)

### FINAL GATE (Gate 6 - Automated)
- [ ] Run `check-final-gate.sh` script
- [ ] All frontmatter complete (title, meta, dates)
- [ ] Word count meets minimum
- [ ] File in correct location
- [ ] HushAway® trademark on all instances
- [ ] **Script shows PASS before export**

---

## Quality Aspirations (NOT Gate Requirements)

These are goals to strive for but are NOT part of automated gate verification:
- Would an exhausted parent at 2am find this supportive?
- Does it sound unmistakably like HushAway®?
- Would I bookmark this?
- Does it differentiate from generic competitors?
- Would an exhausted parent want to try HushAway® after reading this?

**Note:** These are subjective quality markers. The 6 automated gates verify objective requirements.

---

## After Writing: Next Steps

### Step 1: Update Word Count in Frontmatter
Update the `wordCount` field in the article's frontmatter with actual count.

### Step 2: Update Status
Change `status` from `draft` to `in-review`

### Step 3: Save the File
Save the completed article to the content folder.

### Step 4: Update ARTICLE-ORDER.md
After Final Gate shows PASS:
1. Open `ARTICLE-ORDER.md`
2. Mark article checkbox as complete: `- [x]`
3. This tracks overall progress across all articles

### Step 5: Update Dashboard
1. Open `dashboard/index.html`
2. Click "Edit Details" on the article
3. Update status to "In Review"
4. Confirm word count
5. Save changes

### Step 6: Quality Review
Run through the quality checklist above. If all pass, mark as "Ready to Publish".

### Step 7: Publish to Framer
Once ready:
1. Copy content from markdown file
2. Paste into Framer CMS
3. Add meta description and featured image
4. Publish to live site
5. Update dashboard with Framer URL and status "Published"

---

## Quick Command Reference

**Create new article:**
```bash
./dashboard/create-article.sh
```

**Open dashboard:**
```
dashboard/index.html
```

**Start writing with seo-content skill:**
```
/seo-content
```

---

## Example Usage

**At start of new session:**

1. User: `/orchestrator` (entry point)
2. Orchestrator diagnoses needs and routes to /write-article
3. Claude reads this file + CLAUDE.md + agents.md + keyword-library.md + angle-library.md
4. Claude: "I'm ready to write a HushAway® article. According to ARTICLE-ORDER.md, the next priority article is [ARTICLE NAME]. Shall I proceed with this one?"
5. User confirms or selects different article from ARTICLE-ORDER.md
6. Claude references keyword-library.md context (already loaded in Step 3)
7. Claude runs `/keyword-research` → Updates keyword-library.md → Keyword Gate shows PASS
8. Claude completes research → Research Gate shows PASS
9. Claude references angle-library.md context (already loaded in Step 3)
10. Claude runs `/positioning-angles` → Updates angle-library.md → Angle Gate shows PASS
11. Claude confirms library context before writing
12. Claude invokes `/seo-content` skill with proper context
13. Claude writes the article following all guidelines
14. Content Gate shows PASS (23 sections verified)
15. Claude runs `/direct-response-copy` for conversion review
16. Claude runs `check-conversion-gate.sh` → Conversion Gate shows PASS
17. Claude runs `check-final-gate.sh` → Final Gate shows PASS
18. Claude updates frontmatter with word count
19. Claude updates `ARTICLE-ORDER.md` to mark article complete
20. User saves file and exports to main website

---

*This skill ensures every HushAway® article maintains consistent quality, brand voice, SEO optimisation, and conversion focus while genuinely helping exhausted parents raising neurodivergent children.*
