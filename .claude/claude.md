# HushAway®: Local Article Writing Environment

This is a local development folder for writing and previewing SEO articles. Articles created here will be copied to the main HushAway® website.

**Purpose:** Write high-quality SEO content and visually preview it before publishing to the main site.

---

## Quick Reference (Critical Rules)

### NEVER Use
- "HushAway" without the ® symbol (always write HushAway®)
- Emojis (anywhere, ever)
- Em-dashes (use commas, full stops, or semicolons instead)
- American English (always UK: colour, behaviour, mum, organisation, recognise)
- Deficit language: "fix," "cure," "normal," "suffering from," "special needs"
- Clinical terms: "disorder," "patient," "treatment," "symptoms"
- Corporate speak: "comprehensive solution," "optimise," "transform your life"
- AI-isms: "delve," "landscape," "leverage," "comprehensive," "robust," "crucial," "vital," "navigate," "realm," "multifaceted," "paradigm," "synergy," "harness," "unlock," "empower"

### ALWAYS Include
- HushAway® (every instance, never just "HushAway" - URLs like hushaway.com are exempt)
- UK English spelling and terminology
- Primary keyword in first 100-150 words
- Empathy before solutions (acknowledge parent struggle first)
- Signature phrases: "big feelings," "soft place to land," "feel safe in their body"
- Research cited warmly, never clinically
- Gentle CTA: "Explore the Sound Sanctuary"
- Short paragraphs (2-4 sentences), generous white space

---

## Content Rules and Verification (Hard Gate)

**All content rules:** `.claude/humanise-content.md` (50+ banned words, 30+ frequency limits, structural rules, human voice requirements)

**Verification scripts:**
- Research gate: `.claude/scripts/check-research-gate.sh`
- Content gate: `.claude/scripts/master-gate.sh`

```bash
# GATE 1: Run before writing begins
.claude/scripts/check-research-gate.sh [research-file]

# GATE 2: Run after writing completes
.claude/scripts/master-gate.sh [filename] [hub|cluster]
```

**BOTH GATES MUST PASS TO PROCEED.**
- Exit code 0 = OPEN/UNLOCKED (pass)
- Exit code 1 = CLOSED/LOCKED (fail)
- Any failure = fix ALL issues and re-run
- No exceptions. No bypasses. No manual overrides.

---

## Enforcement Summary (Hard Rules)

**ALL RULES ARE HARD FORCED. ZERO TOLERANCE.**

| Category | Rules | Enforcement | Gate |
|----------|-------|-------------|------|
| Banned AI-isms | 50+ words | master-gate.sh Section 2 | Content |
| Frequency limits | 19 words | master-gate.sh Section 3 | Content |
| Intensifiers | 12 words | master-gate.sh Section 4 | Content |
| Banned phrases | 40+ phrases | master-gate.sh Section 5 | Content |
| Redundant phrases | 18 phrases | master-gate.sh Section 6 | Content |
| Structural limits | 6 patterns | master-gate.sh Section 7 | Content |
| Hedging density | 8 per 1000 words | master-gate.sh Section 8 | Content |
| Human markers | And/But, We, contractions | master-gate.sh Section 10 | Content |
| Community quotes | 2 hub / 1 cluster | master-gate.sh Section 11 | Content |
| Brand prominence | Intro + 50% H2s | master-gate.sh Section 18 | Content |
| Keyword placement | First 150 words + H2 | master-gate.sh Section 19 | Content |
| Title/meta length | <60 / 140-160 chars | master-gate.sh Section 20 | Content |
| Research complete | All sections filled | check-research-gate.sh | Research |

**Workflow enforcement:**
1. Research Gate MUST show UNLOCKED before writing begins
2. Content Gate MUST show OPEN before preview/export
3. NO article proceeds with ANY failure
4. FIX and RE-RUN until all passes

---

## Brand Voice

HushAway® sounds like a warm, understanding friend who has been there, knows what it is like to parent a child with big feelings, and wants to share what actually helps. Gentle but credible. Soft but confident. Empathetic but never clinical. Parent-to-parent, never expert-to-patient.

**Core traits:**
1. Gentle confidence: Soft delivery backed by research
2. Empathetic understanding: Validates struggle before offering solutions
3. Neurodiversity-affirming: Support not "fix", celebrate neurodivergence
4. Supportive ally: Relatable, real, honest about what is hard

### Voice Attribution Note

**Nicola has professional expertise, not personal lived experience as a neurodivergent parent.**

This means:
- Nicola speaks from 7 years of professional experience working with families
- Use general professional references: "In my years working with families..." NOT specific personal parenting anecdotes
- The "parent-to-parent" voice comes from the HushAway® community
- When sharing lived experience (e.g., "sitting outside the bedroom door at 2am"), attribute to community voices, not Nicola directly

**Example voice split:**
- Nicola: "The families I work with often tell me..." / "In my years running a nursery..."
- Community: "Parents in our community describe..." / "One mum put it perfectly..."

---

## HushAway® Product

**Website:** hushaway.com

**What is HushAway®?**
A subscription-based sound therapy platform (mobile app + web app) designed specifically for neurodivergent children.

**Sound Types:**
- Sleep soundscapes (ambient sounds, white noise, nature sounds)
- ASMR content (gentle sounds for sensory comfort)
- Binaural beats (frequency-based sounds for focus or calm)
- Guided content (narrated meditations, stories, breathing exercises)

**What Makes It Neurodivergent-Specific:**
- Sensory-friendly design: No sudden sounds, predictable patterns, customisable intensity
- Created by a Certified Neurodivergent Inclusive Coach
- Sounds specifically chosen for sensory processing differences

**Key Pages (for internal linking):**
- About Nicola: hushaway.com/about
- Sound Sanctuary: hushaway.com/sound-sanctuary (CTA destination)
- Blog: hushaway.com/blog

**Author Attribution:** All articles attributed to Nicola Maria Rose with her credentials for E-E-A-T.

---

## Signature Phrases

**Use these naturally:**
- "Big feelings" (instead of "emotions" or "meltdowns")
- "Soft place to land" (safe space metaphor)
- "Feel safe in their body" (sensory safety)
- "Children who feel everything" (empowering framing)
- "Sound Sanctuary" (brand concept and CTA destination)
- "Gentle sound support" (what we offer)
- "Mum" (not "mom", UK English)
- "You know your child best"

---

## 5 Base Positioning Angles (Reference Only)

**IMPORTANT: These are BASE angles for reference. Every article MUST run `/positioning-angles` skill to generate article-specific angles.**

The `/positioning-angles` skill will:
1. Use these base angles as context
2. Analyze the specific article's research and competitor gaps
3. Generate 3-5 article-specific angles
4. Provide headline directions and counter-positions

**Base angles (for context):**

| Angle | Pillar Context |
|-------|----------------|
| 1. Neurodivergent-First Specialist | ALL content (default positioning) |
| 2. Passive Support Alternative | Pillars 3, 6 (anxiety, emotional regulation) |
| 3. Research-Backed Sensory Science | Pillars 1, 4 (ADHD sleep, sensory apps) |
| 4. Supportive Ally | Pillar 7 (neurodivergent parenting) |
| 5. Gentle Consistency Promise | Pillars 2, 5 (sleep apps, ADHD apps) |

**DO NOT use these directly.** Run `/positioning-angles` skill after research to get article-specific angles with counter-positions.

---

## Content Requirements

### Word Count Minimums (Non-Negotiable)
- **Pillar hub articles:** MINIMUM 3,000 words (target 3,500-4,000)
- **Cluster articles:** MINIMUM 1,500 words (target 2,000-2,500)

### Article Structure
**Opening (First 100-150 words):**
1. Acknowledge parent's experience/struggle (empathy first)
2. Validate that this is common/real
3. Introduce what article covers
4. Include primary keyword naturally

**Closing:**
1. Summarise key takeaways (2-3 main points)
2. Offer reassurance and validation
3. Gentle CTA: "Explore the Sound Sanctuary"

### Brand Prominence (Critical for Content Marketing)

**These articles are HushAway® content marketing, not neutral guides.**

HushAway® should be prominently positioned throughout every article, not just mentioned at the end. Competitors can be named for SEO credibility, but HushAway® should be the clear alternative presented.

**Minimum requirements:**
- HushAway® mentioned in introduction (within first 500 words)
- HushAway® positioning in at least 50% of H2 sections
- Each competitor category should close with a HushAway® counter-position
- Include a comparison element (table, checklist, or side-by-side) near the closing

**Pattern for competitor sections:**
1. Describe competitor category/apps (for SEO value)
2. Acknowledge what they do well
3. Close with HushAway®'s different/better approach

**Example counter-position:**
> "Focus apps assume your child can already engage. But if their nervous system is overwhelmed, no attention-training game will help. This is where passive sound support like HushAway® can make a difference, helping children feel calm enough to access focus in the first place."

**What to avoid:**
- Writing competitor-focused guides where HushAway® is an afterthought
- Only mentioning HushAway® in the Sound Therapy section and closing CTA
- Giving competitors more prominent treatment than HushAway®

---

## Meta Descriptions

**Format:** Question + soft answer
**Length:** 140-160 characters
**Must include:** Primary keyword

**Example:**
> "Struggling with bedtime battles? Discover gentle, research-backed ways to help your ADHD child find calm and settle into sleep."

**NOT:**
> "Comprehensive guide to ADHD sleep solutions. Learn expert tips and strategies for better sleep."

---

## Article Schema

All articles should include Article schema markup for enhanced search visibility.

**Required fields:**
- headline (article title)
- author (Nicola Maria Rose)
- datePublished
- dateModified
- publisher (HushAway®)
- description (meta description)

**Implementation:** Schema is added during publishing to the main site.

---

## Featured Snippet Optimisation

Structure content to capture position zero:

**For "what is" queries:**
- Provide a clear 40-60 word definition immediately after the H2

**For "how to" queries:**
- Use numbered steps with clear action verbs
- Keep each step to 1-2 sentences

**For list queries:**
- Use bullet points with consistent formatting
- Include 5-8 items for optimal snippet capture

**For comparison queries:**
- Use tables where appropriate
- Include clear headers

---

## Research Citations and E-E-A-T

**E-E-A-T is essential for ranking.** Every article needs verifiable research citations.

### Citation Sources

**Before writing:** Check `/research/eeat-library.md` for verified statistics with source links.

**Requirements:**
- Minimum 3-4 research citations per hub article, 2-3 per cluster article
- All statistics must have a verifiable source (journal, institution, or recognised organisation)
- Prefer sources from 2020 onwards. Where multiple sources exist, prioritise 2022+ research. Always verify older statistics have not been superseded by newer studies.
- **ALWAYS include the year in every citation** (not "when relevant" but every time)
- Format: "Research from [YEAR] found..." or "A [YEAR] study showed..."

### Citation Style (Warm, Not Academic)

**Good examples:**
- "Research from 2024 found that parents of children with ADHD are more than four times more likely to experience depression."
- "A large Swedish study found that children with ADHD are eight times more likely to have a sleep disorder."
- "According to the Cleo Family Health Index, 65% of parents of neurodivergent children are at higher risk for burnout."
- "Studies show that between 35% and 70% of children with ADHD struggle with sleep."

**NOT:**
- "According to a study published in the Journal of Sleep Research (Smith et al., 2023)..."
- "Research conducted by the Department of Psychology at..."
- "A meta-analysis of 47 studies demonstrated that (p<0.001)..."

Cite the finding warmly, acknowledge the source briefly, move on. The parent reading at 2am does not need a literature review.

### E-E-A-T Signals to Include

**Experience:**
- Nicola's professional observations: "In my years working with families..." (general, not specific anecdotes)
- Parent community insights: "Parents in our community often say..." (for lived experience)
- Testimonials from hushaway.com (check website for real quotes)

**Community Voice Quotes (Non-Negotiable):**
- **Hub articles:** Minimum 2 parent quotes with lived experience
- **Cluster articles:** Minimum 1 parent quote with lived experience
- Format: "One mum put it perfectly: '[quote]'" or "As one parent shared: '[quote]'"
- Quotes should feel real, specific, and emotionally resonant
- Place quotes where they reinforce key points or transitions

**Example community quotes:**
- "We have tried every app going. He loves them for three days, then they collect dust. I realised we were trying to build the roof before the foundation."
- "The morning routine chart was useless until we started playing brown noise while he got ready. Now he actually follows it."

**Expertise:**
- Nicola's credentials (Certified Neurodivergent Inclusive Coach, ADHD Coach, Sound Therapy Practitioner, 7 years nursery experience)
- Research citations (minimum 2-3 per article)

**Authoritativeness:**
- Internal links: **8-10 per hub article, 4-6 per cluster article** (include cross-pillar links, not just same-pillar)
- External links to UK sources: NHS, ADHD UK, NICE guidelines, British Psychological Society, Royal College of Psychiatrists (2-4 per article)

**Trust:**
- Honest limitations ("this article provides information, not professional advice")
- "When to seek professional help" sections
- Acknowledgement that every family is different

---

## Internal Linking Strategy

**Links should be woven naturally into content**, not listed in a separate section at the bottom.

**Placeholder convention for early articles:**
When linking to articles that do not yet exist, use this format:
```
[LINK TO: Article Title]
```

Example: "If you're struggling with burnout, you're not alone [LINK TO: Recognising Parent Burnout]."

**After publishing:** Run a batch update to replace placeholders with actual links.

**What to link to:**
- Related cluster articles in same pillar
- Hub article for the pillar
- Relevant articles in other pillars
- Sound Sanctuary page (closing CTA)
- About Nicola page (when referencing her experience)

---

## 7 Content Pillars (77 Articles Total)

### IMPORTANT: Seed Keywords vs Validated Keywords

**The keywords in this table are SEED KEYWORDS - starting points, not final targets.**

Before writing ANY article:
1. Select the seed keyword from this table
2. Run `/keyword-research` skill to validate and expand
3. Update this table with the VALIDATED keyword and secondary keywords
4. Pass the Keyword Gate before proceeding

**Table columns:**
- **Article** - Article identifier
- **Target Keyword** - Seed keyword (update with validated keyword after /keyword-research)
- **Volume** - Estimated search volume (update if /keyword-research provides new data)
- **Secondary Keywords** - Add after /keyword-research skill completes
- **Status** - validated / not-started

---

**Priority Order (by search volume):**

### Pillar 5: ADHD Apps (Start Here - Highest Volume)
**Volume:** 25,000 monthly searches | **Angle:** Neurodivergent-First + Supportive Ally

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | ADHD apps | 25,000 |
| 5.1 | Focus apps ADHD | 600-1,200 |
| 5.2 | Task management apps kids | 400-900 |
| 5.3 | Executive function ADHD apps | 300-700 |
| 5.4 | Behavior tracking ADHD | 300-700 |
| 5.5 | Organization apps ADHD children | 400-800 |
| 5.6 | ADHD treatment medication therapy apps | 400-900 |
| 5.7 | FDA approved ADHD game | 300-600 |
| 5.8 | ADHD apps school classroom | 400-900 |
| 5.9 | ADHD apps by age | 300-700 |
| 5.10 | Emotional dysregulation ADHD apps | 400-800 |

### Pillar 2: Sleep Apps for Kids
**Volume:** 8,000-12,000 monthly searches | **Angle:** Neurodivergent-First + Gentle Consistency

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | Sleep apps for kids | 8,000-12,000 |
| 2.1 | Bedtime stories vs meditation apps kids | 300-600 |
| 2.2 | Sleep apps for toddlers | 1,000-2,000 |
| 2.3 | Sleep apps for school age children | 800-1,500 |
| 2.4 | Sleep apps for teens | 600-1,200 |
| 2.5 | Sleep routine for kids | 1,500-2,500 |
| 2.6 | White noise vs guided sleep apps | 200-500 |
| 2.7 | Screen time before bed kids | 1,000-2,000 |
| 2.8 | Best free sleep apps for kids | 800-1,500 |
| 2.9 | Sleep apps and sleep training | 300-700 |
| 2.10 | Sleep tracking apps for kids | 400-800 |

### Pillar 1: ADHD Sleep Support
**Volume:** 5,000-8,000 monthly searches | **Angle:** Research-Backed Science + Neurodivergent-First

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | ADHD sleep dysregulation | 5,000-8,000 |
| 1.1 | ADHD bedtime resistance | 1,500-2,000 |
| 1.2 | How to help ADHD child fall asleep | 1,200-1,800 |
| 1.3 | ADHD sleep schedule | 800-1,200 |
| 1.4 | Sensory bedroom ADHD | 600-1,000 |
| 1.5 | ADHD medication sleep side effects | 400-700 |
| 1.6 | Melatonin ADHD children | 400-600 |
| 1.7 | ADHD night waking | 500-900 |
| 1.8 | ADHD anxiety sleep children | 600-1,000 |
| 1.9 | ADHD early morning dysregulation | 300-600 |
| 1.10 | ADHD screen time sleep | 400-700 |

### Pillar 3: Anxiety Apps for Children
**Volume:** 4,000-6,000 monthly searches | **Angle:** Passive Support Alternative

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | Anxiety apps for children | 4,000-6,000 |
| 3.1 | Anxiety autism children | 700-1,400 |
| 3.2 | CBT apps for kids anxiety | 400-900 |
| 3.3 | Grounding techniques anxious kids | 600-1,200 |
| 3.4 | Social anxiety ADHD children | 500-1,100 |
| 3.5 | Separation anxiety apps kids | 400-900 |
| 3.6 | Panic attacks children | 1,000-2,000 |
| 3.7 | Anxiety medication children apps | 300-700 |
| 3.8 | Parent anxiety child anxiety | 400-900 |
| 3.9 | School anxiety children apps | 400-900 |
| 3.10 | Performance anxiety neurodivergent children | 200-500 |

### Pillar 4: Sensory Friendly Apps
**Volume:** 2,000-3,000 monthly searches | **Angle:** Research-Backed Science + Neurodivergent-First

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | Sensory apps for children | 2,000-3,000 |
| 4.1 | Sensory overload vs sensory seeking | 300-700 |
| 4.2 | Binaural beats kids | 400-800 |
| 4.3 | ASMR kids | 600-1,200 |
| 4.4 | Autism sensory regulation apps | 400-900 |
| 4.5 | ADHD stimming apps | 300-700 |
| 4.6 | Sensory toolkit children | 200-500 |
| 4.7 | Sensory diet children | 300-600 |
| 4.8 | Weighted blankets anxiety sleep | 800-1,500 |
| 4.9 | Sensory friendly home design | 200-500 |
| 4.10 | School sensory accommodations | 300-700 |

### Pillar 7: Neurodivergent Parenting
**Volume:** 2,000-4,000 monthly searches | **Angle:** Supportive Ally

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | Neurodivergent parenting | 2,000-4,000 |
| 7.1 | Parent burnout ADHD | 500-1,100 |
| 7.2 | ADHD parent sleep deprivation | 300-700 |
| 7.3 | Respite care ADHD children | 200-500 |
| 7.4 | Co-parenting ADHD | 300-700 |
| 7.5 | Parent therapy counseling | 400-900 |
| 7.6 | ADHD parenting community support | 300-700 |
| 7.7 | Self-compassion parents | 300-700 |
| 7.8 | Parent self-care apps | 300-700 |
| 7.9 | Stress management parents | 500-1,100 |
| 7.10 | Neurodivergent parent ADHD | 400-900 |

### Pillar 6: Emotional Regulation
**Volume:** 1,000-2,000 monthly searches | **Angle:** Passive Support + Neurodivergent-First

| Article | Target Keyword | Volume |
|---------|---------------|--------|
| HUB | Emotional regulation apps children | 1,000-2,000 |
| 6.1 | Emotional dysregulation ADHD children | 400-800 |
| 6.2 | Emotional regulation autism | 300-700 |
| 6.3 | Affirmations anxious children | 300-700 |
| 6.4 | Mindfulness ADHD children | 600-1,200 |
| 6.5 | Anger management apps kids | 500-1,100 |
| 6.6 | Emotional vocabulary children | 300-700 |
| 6.7 | Self-compassion children | 300-700 |
| 6.8 | Emotional resilience children | 400-900 |
| 6.9 | Breathing exercises kids anxiety | 600-1,200 |
| 6.10 | Coping strategies apps kids | 300-700 |

---

## Article Writing Process (5-Gate Workflow)

**MANDATORY SKILLS (cannot skip):**
1. `/keyword-research` - Run BEFORE research → Pass KEYWORD GATE
2. `/positioning-angles` - Run AFTER research → Pass ANGLE GATE
3. `/seo-content` - Run AFTER angle gate → Pass CONTENT GATE

**Workflow:** `.claude/agents.md`
**Detailed process:** `.claude/skills/write-article.md`
**Content rules:** `.claude/humanise-content.md`

**Gate Scripts:**
- `.claude/scripts/check-keyword-gate.sh` - After /keyword-research
- `.claude/scripts/check-research-gate.sh` - After research complete
- `.claude/scripts/check-angle-gate.sh` - After /positioning-angles
- `.claude/scripts/master-gate.sh` - After writing complete

**The Final Test:**
Would an exhausted parent at 2am find this supportive? If yes, publish.

---

## Human Voice Guidelines

**Full rules:** `.claude/humanise-content.md` (Section 6: Human Voice Requirements)

**Quick reference:**
- Use contractions (you're, it's, don't)
- Start sentences with "And" or "But" (min 2 per article)
- Use "we" language (min 2 per article)
- Vary sentence lengths
- Include specific, concrete examples
- Avoid formulaic transitions and perfect parallel structure

---

## Mid-Article Engagement (Curiosity Loops)

**Full templates:** `.claude/humanise-content.md` (Section 9: Curiosity Loop Templates)

**Requirements:**
- Hub articles: 2+ curiosity loops
- Cluster articles: 1+ curiosity loop

**Quick examples:**
- "But here is the question most guides never ask..."
- "So which type of support does your child actually need?"
- "There is one thing these approaches have in common."

---

## Local Development Workflow

1. **Research:** Complete research file in `/research/pillar-[N]-[topic-name]/`
2. **Write:** Use `/seo-content` skill to generate article
3. **Verify:** Run all verification processes (see `.claude/skills/write-article.md`)
4. **Save:** Save to `/src/content/pillar-[N]-[topic-name]/`
5. **Preview:** Run `npm run dev` to view at localhost:4321
6. **Export:** Copy finalised content to main HushAway® website

---

## File Structure

```
/src/content/pillar-[N]-[topic-name]/   - Article markdown files
  - hub-[slug].md                        - Hub articles
  - [X.X]-[slug].md                      - Cluster articles (e.g., 7.1-parent-burnout.md)
/research/pillar-[N]-[topic-name]/      - Research files
  - hub-research.md                      - Hub research
  - [X.X]-[slug]-research.md             - Cluster research (e.g., 7.1-parent-burnout-research.md)
/templates/                              - Quality checklist and research template
/dashboard/                              - Progress tracking (HTML dashboard)
/docs/                                   - Competitor research reference
/.claude/skills/                         - Marketing skills for content creation
```

**Example folder names:**
- `pillar-7-neurodivergent-parenting`
- `pillar-1-adhd-sleep`
- `pillar-4-sensory-apps`

---

## URL Structure

**Format:** `/blog/[pillar-keyword]/[article-slug]`

**Rules:**
- All lowercase
- Hyphens between words (no underscores)
- No stop words (the, a, an, of) unless essential for meaning
- Include primary keyword
- Maximum 60 characters

**Examples:**
- Hub: `/blog/adhd-apps/`
- Cluster: `/blog/adhd-apps/focus-apps-adhd-children/`

---

## Skills Available

**MANDATORY for every article (in order):**
1. `/keyword-research` - Validate + expand keywords - **CANNOT SKIP** - Run before research
2. `/positioning-angles` - Find article-specific angle - **CANNOT SKIP** - Run after research
3. `/seo-content` - Write the article - Run after angle gate passes

**Other skills:**
- `/brand-voice` - Extract or refine brand voice
- `/direct-response-copy` - Conversion copywriting
- `/email-sequences` - Email nurture sequences
- `/content-atomizer` - Repurpose content
- `/newsletter` - Newsletter formats
- `/lead-magnet` - Lead magnet concepts
