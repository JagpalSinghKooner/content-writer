# HushAway® Article Writing Skill

**Purpose:** Complete guide to writing a HushAway® SEO article from scratch.

---

## Quick Start Instructions

When you invoke this skill with `/write-article`, follow these steps:

### Step 1: Load Project Context

**First, read these files to understand the project:**
- `.claude/CLAUDE.md` - HushAway® brand voice, critical rules, positioning
- `.claude/agents.md` - Complete article writing workflow

**Quick test:** Ask yourself "What are HushAway®'s forbidden words?"
- Answer should include: No emojis, no em-dashes, UK English, no deficit language, no AI-isms

### Step 2: Identify Article to Write

**Option A: Use Content Dashboard (Recommended)**
1. Open `/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard/index.html` in browser
2. Filter by HIGH priority articles in "Draft" status
3. Look for Pillar 7 (Neurodivergent Parenting) articles first
4. Note the article title and target keyword

**Option B: Ask User**
- "Which article would you like me to write?"
- User will provide title and pillar number

**Priority Order (by search volume):**
1. **Pillar 5:** ADHD Apps (25,000 searches) - START HERE
2. **Pillar 2:** Sleep Apps for Kids (8,000-12,000)
3. **Pillar 1:** ADHD Sleep Support (5,000-8,000)
4. **Pillar 3:** Anxiety Apps (4,000-6,000)
5. **Pillar 4:** Sensory Friendly Apps (2,000-3,000)
6. **Pillar 7:** Neurodivergent Parenting (2,000-4,000)
7. **Pillar 6:** Emotional Regulation (1,000-2,000)

### Step 3: Open the Article Template File

The file should already exist at:
`src/content/pillar-[N]-[topic-name]/[article-file].md`

Example: `src/content/pillar-7-neurodivergent-parenting/hub-neurodivergent-parenting.md`

If file doesn't exist, user needs to run:
```bash
cd "/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard"
./create-article.sh
```

### Step 4: Verify Research is Complete

**Before writing, confirm the research file exists and is complete.**

**Research file location:**
`/research/pillar-[N]-[topic-name]/[article-slug]-research.md`

Example: `/research/pillar-7-neurodivergent-parenting/7.1-parent-burnout-research.md`

**Verify these elements are present:**
- [ ] Target keyword confirmed
- [ ] Secondary keywords listed (3-5)
- [ ] PAA (People Also Ask) questions captured
- [ ] Competitor analysis complete (top 3-5 ranking articles reviewed)
- [ ] Key statistics identified (with sources)
- [ ] Content angle/positioning determined

**If research file is incomplete:**
1. Complete the missing sections before proceeding
2. Check `/research/eeat-library.md` for verified statistics
3. Use keyword research tools to confirm secondary keywords

**Do not proceed to writing until research is verified.**

### Step 5: HushAway® Prominence Planning (NEW - REQUIRED)

**Before writing, plan where HushAway® appears throughout the article.**

This step prevents the common mistake of writing competitor-focused content that only mentions HushAway® at the end.

**Complete this checklist before proceeding:**

- [ ] **Introduction mention planned:** Draft a callout or paragraph introducing HushAway®'s different approach within the first 500 words
- [ ] **Counter-positions defined:** For each competitor category/section, write the HushAway® positioning statement that will close that section
- [ ] **Differentiator section planned:** Decide if a "Why Most [Topic] Apps Fail" or similar section is needed
- [ ] **Comparison format chosen:** Table, checklist, or side-by-side comparison for closing

**Example counter-positions by section type:**

| Section Type | HushAway® Counter-Position |
|--------------|---------------------------|
| Focus apps | "But focus apps only work when your child is calm enough to engage. HushAway® helps create that calm first." |
| Emotional regulation apps | "These apps require active participation. HushAway® offers passive emotional support through sound." |
| Task management apps | "Structure helps, but an overwhelmed child cannot follow any routine. Sound support creates the foundation." |
| Educational apps | "Learning apps work best when combined with sensory support that helps children feel regulated." |

**Minimum HushAway® presence:**
- Introduction: 1 mention (required)
- Body sections: At least 50% of H2 sections should close with HushAway® positioning
- Closing: Comparison element + Sound Sanctuary CTA

### Step 6: Use the seo-content Skill

**Invoke the existing seo-content skill:**

```
/seo-content
```

**When prompted, provide:**
- **Target keyword:** [from article frontmatter]
- **Article title:** [from article frontmatter]
- **Content type:** [Pillar Hub or Cluster]
- **Word count minimum:** [3000 for hub / 1500 for cluster]
- **Special instructions:** Reference the pillar-specific guidance below AND the prominence planning from Step 5

---

## Pre-Writing Research Checklist

**Do not start writing until all items are confirmed.**

This checklist ensures you have everything needed before invoking the seo-content skill.

### Required Research Elements

| Element | Where to Find | Status |
|---------|---------------|--------|
| Research file | `/research/pillar-[N]-[topic-name]/[article]-research.md` | [ ] Exists |
| Target keyword | Research file frontmatter or content-database.json | [ ] Confirmed |
| Secondary keywords | Research file or article frontmatter | [ ] 3-5 listed |
| PAA questions | Research file (from Google search) | [ ] Captured |
| Competitor analysis | Research file | [ ] Top 3-5 reviewed |
| Statistics | Research file + `/research/eeat-library.md` | [ ] 2-3 with sources |
| Positioning angle | CLAUDE.md pillar guidance | [ ] Identified |

### Research File Structure Check

Your research file should contain:

```markdown
# [Article Title] Research

## Target Keywords
- Primary: [keyword]
- Secondary: [keyword 1], [keyword 2], [keyword 3]

## PAA Questions
- Question 1?
- Question 2?
- Question 3?

## Competitor Analysis
### [Competitor URL 1]
- Word count:
- Key points covered:
- Gaps/opportunities:

## Statistics to Include
- [Stat 1] - Source: [Name], Year: [YYYY], URL: [link]
- [Stat 2] - Source: [Name], Year: [YYYY], URL: [link]

## Content Outline
- H2: ...
- H2: ...
```

### If Research is Incomplete

1. **Missing PAA questions:** Search target keyword in Google, note "People Also Ask" questions
2. **Missing statistics:** Check `/research/eeat-library.md` first, then search for verified sources
3. **Missing competitor analysis:** Search target keyword, review top 3-5 organic results
4. **Missing secondary keywords:** Use keyword research or check related searches in Google

**Only proceed when all checkboxes are ticked.**

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

## Pillar-Specific Writing Guidance

### Pillar 7: Neurodivergent Parenting
**Lead angle:** Angle 4 (Supportive Ally) - OWN THIS COMPLETELY

**Important voice note:** Nicola has professional expertise, not personal lived experience as a neurodivergent parent. The "parent-to-parent" voice comes from the HushAway® community, not Nicola's personal parenting stories.

**Special requirements:**
- Nicola's professional observations woven throughout: "In my years working with families..."
- Community voice for lived experience: "Parents in our community often tell me..."
- Vulnerable, real, exhausted honesty (attributed to community)
- Permission to struggle
- Warm professional voice, not expert-talking-down

**Example opening:**
> "So many parents tell me the same thing: 'I'm sitting outside my child's bedroom door at 2am, exhausted and wondering if I'm the only one who finds this so hard.' If you're reading this right now, feeling that same exhaustion, I need you to know something before anything else: you're not alone. In my years working with families navigating neurodivergent parenting, I've seen how isolating this can feel. But you're not failing. This is just really, really hard."

### Pillar 4: Sensory Friendly Apps
**Lead angle:** Angle 3 (Research-Backed Science) + Angle 1 (Neurodivergent-First)

**Special requirements:**
- OWN this space as THE authority
- Explain ASMR, binaural beats accessibly
- Differentiate overload vs seeking
- Position HushAway® as specialist

### Pillar 1: ADHD Sleep Support
**Lead angle:** Angle 3 (Research-Backed Science) + Angle 1 (Neurodivergent-First)

**Special requirements:**
- Explain circadian rhythm delays accessibly
- Validate bedtime battles are real
- Position sound support as neurological need
- High commercial intent - guide to HushAway® naturally

### Pillar 2: Sleep Apps for Kids
**Lead angle:** Angle 1 (Neurodivergent-First) + Angle 5 (Gentle Consistency)

**Special requirements:**
- Don't do generic listicle
- Educate on sensory-friendly criteria first
- Emphasise predictability
- Differentiate from Calm/Headspace

### Pillar 3: Anxiety Apps
**Lead angle:** Angle 2 (Passive Support Alternative) - KILLER ANGLE

**Special requirements:**
- Acknowledge active apps require capacity anxious children don't have
- Position passive sound as alternative, not inferior
- "When your child is already overwhelmed, the last thing they need is another task"

### Pillar 6: Emotional Regulation Apps
**Lead angle:** Angle 2 (Passive Support) + Angle 1 (Neurodivergent-First)

**Special requirements:**
- Acknowledge skill-building requires capacity
- Position passive regulation as step BEFORE active work
- "Before we can teach children to name feelings, they need to feel safe"

### Pillar 5: ADHD Apps
**Lead angle:** Angle 1 (Neurodivergent-First) + Angle 4 (Parent-to-Parent)

**Special requirements:**
- Don't compete on productivity
- Carve out "emotional regulation first" positioning
- "Before focus, children need to feel regulated"

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

**GATE MUST SHOW "OPEN" TO PROCEED.**

- Exit code 0 = OPEN (all 22 sections passed)
- Exit code 1 = CLOSED (failures found)

**If CLOSED:**
1. Review failures listed in output
2. Fix ALL failures in article
3. Re-run script
4. Repeat until OPEN

**Do NOT proceed with CLOSED gate. No exceptions.**

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

### PRE-WRITING VERIFICATION (Complete Before Writing)
- [ ] Research file exists and is complete
- [ ] Target keyword confirmed
- [ ] Secondary keywords listed (3-5)
- [ ] PAA questions captured
- [ ] Competitor analysis complete
- [ ] Statistics identified with verifiable sources
- [ ] E-E-A-T library checked for citations

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

### THE FINAL TEST
- [ ] Would an exhausted parent at 2am find this supportive?
- [ ] Does it sound unmistakably like HushAway®?
- [ ] Would I bookmark this?
- [ ] Does it differentiate from generic competitors?

---

## After Writing: Next Steps

### Step 1: Update Word Count in Frontmatter
Update the `wordCount` field in the article's frontmatter with actual count.

### Step 2: Update Status
Change `status` from `draft` to `in-review`

### Step 3: Save the File
Save the completed article to the content folder.

### Step 4: Update Dashboard
1. Open `/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard/index.html`
2. Click "Edit Details" on the article
3. Update status to "In Review"
4. Confirm word count
5. Save changes

### Step 5: Quality Review
Run through the quality checklist above. If all pass, mark as "Ready to Publish".

### Step 6: Publish to Framer
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
cd "/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard"
./create-article.sh
```

**Open dashboard:**
```
/Users/jagpalkooner/Downloads/HushAway - Launch/dashboard/index.html
```

**Start writing with seo-content skill:**
```
/seo-content
```

---

## Example Usage

**At start of new session:**

1. User: `/write-article`
2. Claude reads this file + CLAUDE.md + agents.md
3. Claude: "I'm ready to write a HushAway® article. Which article would you like me to write, or should I start with the next priority article from Pillar 7?"
4. User provides article details or confirms Pillar 7 hub
5. Claude invokes `/seo-content` skill with proper context
6. Claude writes the article following all guidelines
7. Claude updates frontmatter with word count
8. User saves file and updates dashboard

---

*This skill ensures every HushAway® article maintains consistent quality, brand voice, and SEO optimisation while genuinely helping exhausted parents raising neurodivergent children.*
