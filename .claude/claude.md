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

## Content Rules and Verification (6 Hard Gates)

**All content rules:** `.claude/humanise-content.md` (50+ banned words, 30+ frequency limits, structural rules, human voice requirements)

**6-Gate Verification (ALL MANDATORY):**

| Gate | Script | When | Status |
|------|--------|------|--------|
| 1. Keyword Gate | `check-keyword-gate.sh` | After /keyword-research + Perplexity | PASS/FAIL |
| 2. Research Gate | `check-research-gate.sh` | After research complete | PASS/FAIL |
| 3. Angle Gate | `check-angle-gate.sh` | After /positioning-angles | PASS/FAIL |
| 4. Content Gate | `master-gate.sh` | After /seo-content | PASS/FAIL |
| 5. Conversion Gate | `check-conversion-gate.sh` | After /direct-response-copy | PASS/FAIL |
| 6. Final Gate | `check-final-gate.sh` | Before export | PASS/FAIL |

```bash
# Gate 1: After /keyword-research skill
.claude/scripts/check-keyword-gate.sh [research-file]

# Gate 2: After research is complete
.claude/scripts/check-research-gate.sh [research-file]

# Gate 3: After /positioning-angles skill
.claude/scripts/check-angle-gate.sh [research-file]

# Gate 4: After /seo-content skill
.claude/scripts/master-gate.sh [article-file] [hub|cluster]

# Gate 5: After /direct-response-copy skill (run skill THEN script)
.claude/scripts/check-conversion-gate.sh [article-file]

# Gate 6: Before export (fully automated)
.claude/scripts/check-final-gate.sh [article-file] [hub|cluster]
```

**ALL 6 GATES MUST PASS. NO EXCEPTIONS. ALL GATES ARE FULLY AUTOMATED.**
- Exit code 0 = PASS (proceed to next gate)
- Exit code 1 = FAIL (fix issues and re-run script)
- Any failure = fix ALL issues and re-run the script
- No exceptions. No bypasses. Every gate has an automated script.
- **Skills are MANDATORY** - /orchestrator, /keyword-research, /positioning-angles, /seo-content, /direct-response-copy must ALL run
- **Gate 5 requires BOTH:** Run /direct-response-copy skill first, THEN run check-conversion-gate.sh script

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

**Workflow enforcement (6 gates in order):**
1. Keyword Gate MUST show PASS before research begins
2. Research Gate MUST show PASS before positioning begins
3. Angle Gate MUST show PASS before writing begins
4. Content Gate MUST show PASS before conversion review
5. Conversion Gate MUST show PASS before final gate
6. Final Gate MUST show PASS before export
7. NO article proceeds with ANY gate failure
8. FIX and RE-RUN script until gate shows PASS

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
A sound therapy platform (mobile app + web app) designed specifically for neurodivergent children, with a free forever tier.

**Pricing Model:**
- **Free Forever:** Full access to the Sound Sanctuary (sounds, stories, daytime/nighttime content, affirmations)
- **Premium:** Coming soon (additional features)
- **Sign-up:** Name + email → magic link sent automatically (no password required)

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

## Content Pillars

**For the full article list, priority order, status tracking, and prompts:** See `ARTICLE-ORDER.md`

### Article Workflow

Before writing ANY article (all steps automated):
1. **READ `ARTICLE-ORDER.md`** to select the next article in priority order
2. **READ `.claude/keyword-library.md`** to see previously validated keywords and clustering opportunities
3. Run `/keyword-research` skill with context from the library
4. **Auto-update `.claude/keyword-library.md`** with the validated keyword (all 6 columns required)
5. Complete research file and pass Research Gate
6. **Run `.claude/scripts/generate-research-summary.sh`** to create compact summary for skills
7. **READ `.claude/angle-library.md`** to see angles already used and patterns to avoid
8. Run `/positioning-angles` skill (reads summary, not full research file)
9. **Auto-update `.claude/angle-library.md`** with the selected angle (all 6 columns required)
10. **READ both libraries** to confirm angle and keywords before writing
11. Write with `/seo-content` skill (reads summary, not full research file)
12. Pass all 6 gates in order
13. Auto-update `ARTICLE-ORDER.md` status once complete

**Why READ libraries first?**
- `keyword-library.md` shows existing keyword clusters for internal linking opportunities
- `angle-library.md` prevents reusing angles and ensures diversity across articles
- Both libraries accumulate learning data that improves future articles

### Batch Management

When current batch is complete:
1. Archive completed research/articles to `/archive/` folder (for training data)
2. Clear `ARTICLE-ORDER.md`
3. Add new pillars and articles
4. Keep `angle-library.md` and `keyword-library.md` (carries forward as learning data)

---

## Article Writing Process (6-Gate Workflow)

**ALWAYS START WITH `/orchestrator`** - It diagnoses the optimal approach and routes to the right skills.

**MANDATORY SKILLS (in order):**
1. `/orchestrator` - Entry point → Diagnoses needs, routes to skills
2. `/keyword-research` - Run BEFORE research → Pass KEYWORD GATE
3. `/positioning-angles` - Run AFTER research → Pass ANGLE GATE
4. `/seo-content` - Run AFTER angle gate → Pass CONTENT GATE
5. `/direct-response-copy` - Run AFTER content gate → Pass CONVERSION GATE

**Workflow:** `.claude/agents.md`
**Detailed process:** `.claude/skills/write-article.md`
**Content rules:** `.claude/humanise-content.md`

**Gate Scripts (ALL AUTOMATED):**
- `.claude/scripts/check-keyword-gate.sh` - After /keyword-research
- `.claude/scripts/check-research-gate.sh` - After research complete
- `.claude/scripts/check-angle-gate.sh` - After /positioning-angles
- `.claude/scripts/master-gate.sh` - After writing complete (23 sections)
- `.claude/scripts/check-conversion-gate.sh` - After /direct-response-copy (7 conversion checks)
- `.claude/scripts/check-final-gate.sh` - Before export (frontmatter, word count, location)

**All 6 gates are fully automated. Every gate has a script. No manual verification steps.**

---

## Context Optimization (Prevent Context Window Exhaustion)

**After Research Gate passes, generate a research summary:**

```bash
.claude/scripts/generate-research-summary.sh [research-file]
# Example: .claude/scripts/generate-research-summary.sh research/pillar-5-adhd-apps/5.1-focus-apps-research.md
```

This script automatically extracts key data from the research file and saves a compact summary (90% smaller) to `.claude/scratchpad/research-summary.md`.

**Summary contains:**
- Target keyword + secondary keywords
- Selected angle + headline direction
- Key stats for citations (with source/year)
- Competitor gaps for HushAway positioning
- Top 5 PAA questions to address

**Skills should read `.claude/scratchpad/research-summary.md` instead of full research file after Research Gate passes.**

**Gate remediation:** When a gate fails, use `--remediate` flag on re-runs to suppress PASS output:
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster] --remediate
.claude/scripts/check-conversion-gate.sh [article-file] --remediate
```

---

## Conversion Requirements (Conversion Gate)

**Goal:** Every article should guide readers towards signing up for the free Sound Sanctuary.

### Parent Objections to Address

Every article must counter these common objections:

| Objection | How to Address |
|-----------|----------------|
| "Another app won't help" | Show how passive sound is different from active apps that failed |
| "Too tired to try" | Emphasise zero learning curve, just press play, no effort required |
| "Is this actually different?" | Neurodivergent-first positioning (not adapted generic wellness) |
| "What if my child won't use it?" | It's free forever, no risk to try, nothing to lose |

### Conversion Gate Checklist

**Gate 5 requires TWO steps:**
1. Run `/direct-response-copy` skill for AI-assisted conversion review
2. Run `check-conversion-gate.sh` script for automated verification

For content to pass the Conversion Gate, both must complete (7 checks):

1. **Objection Handling** - At least 2 of the 4 objections addressed naturally in content
2. **CTA Clarity** - "Free forever" or equivalent mentioned near primary CTA
3. **Low-Friction Language** - No commitment language, emphasis on instant/easy access
4. **Differentiation** - Neurodivergent-first positioning clear (not just another app)
5. **HushAway® Prominence** - Appears in conversion contexts, not just informational
6. **Sound Sanctuary CTA** - 2+ mentions of Sound Sanctuary as destination
7. **Risk Reversal** - Free access removes all barriers to trying

### Conversion CTA Patterns

**Good:**
- "Try the Sound Sanctuary free, forever. Just enter your name and email."
- "No subscription needed. No credit card. Just gentle sounds, ready when you need them."
- "See if it helps. It costs nothing to find out."

**Avoid:**
- "Sign up for our premium service"
- "Start your free trial" (implies it ends)
- "Subscribe to get access"

### Remediation Loop

If `check-conversion-gate.sh` shows FAIL:
1. Review specific failures in script output
2. Fix affected sections in the article
3. Re-run `check-conversion-gate.sh` script (NOT the skill again)
4. Repeat until script shows PASS

**Note:** The skill only runs once. After initial review, fix issues and re-run the script only.

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

### Entry Point (Always Start Here)

**`/orchestrator`** - Marketing strategist that diagnoses your needs and routes to the right skills. Use this when:
- Starting any new content task
- Unsure which skill to use
- Need a multi-step workflow
- Have a vague marketing request

### Article Workflow Skills (Mandatory Order)

| Step | Skill/Script | Purpose | Gate | Notes |
|------|--------------|---------|------|-------|
| 1 | `/orchestrator` | Diagnose + route | - | Entry point |
| 2 | `/keyword-research` | Validate keywords | Keyword Gate | Perplexity MCP required |
| 3 | `/positioning-angles` | Find article angle | Angle Gate | After research |
| 4 | `/seo-content` | Write the article | Content Gate | 23 checks |
| 5a | `/direct-response-copy` | Conversion review | - | **Run FIRST** |
| 5b | `check-conversion-gate.sh` | Conversion verify | Conversion Gate | **Run SECOND** |
| 6 | `check-final-gate.sh` | Pre-export check | Final Gate | Ready for export |

**IMPORTANT:** Gate 5 requires BOTH the skill AND the script. Run `/direct-response-copy` first for AI-assisted review, THEN run the script for automated verification.

### Other Content Skills

- `/brand-voice` - Extract or refine brand voice
- `/email-sequences` - Email nurture sequences
- `/content-atomizer` - Repurpose content for social
- `/newsletter` - Newsletter formats
- `/lead-magnet` - Lead magnet concepts

### Live Data Integration (MCP)

**Perplexity MCP is MANDATORY for all article research.**

| MCP Server | Status | Integration Point | What It Provides |
|------------|--------|-------------------|------------------|
| **Perplexity MCP** | IMPLEMENTED | Step 2: /keyword-research | Real PAA questions, competitor analysis, research sources |
| **DataForSEO MCP** | PLANNED | Step 2: (future) | Exact search volumes, keyword difficulty |

**Perplexity runs during `/keyword-research` and provides:**
- Real PAA questions from Google, Reddit, Mumsnet (7+ required)
- Competitor SERP analysis with content gaps
- Research sources with URLs for E-E-A-T citations
- Keyword trend validation

**Keyword Gate verifies Perplexity was used:** `perplexityUsed: true`

**To configure Perplexity MCP:**
```bash
claude mcp add perplexity --env PERPLEXITY_API_KEY=<your-key>
```

See `LIVE-DATA-WORKFLOW.md` for DataForSEO implementation plan.
