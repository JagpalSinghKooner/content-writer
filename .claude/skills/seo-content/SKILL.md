---
name: seo-content
description: "Create high-quality, SEO-optimized content that ranks AND reads like a human wrote it. Use when turning keyword research into actual content pieces. Takes a target keyword/cluster and produces a complete article optimized for search while avoiding AI-sounding output. Triggers on: write SEO content for X, create article for keyword, write blog post about X, SEO article, content for keyword cluster. Outputs publication-ready content with proper structure, optimization, and human voice."
---

# SEO Content Workflow

SEO content has a reputation problem. Most of it is garbage — keyword-stuffed, AI-sounding, says nothing new. It ranks for a month, then dies.

This skill creates content that ranks AND builds trust. Content that sounds like an expert sharing what they know, not a content mill churning out filler.

The goal: Would someone bookmark this? Would they share it? Would they come back?

If yes, Google will reward it. If no, no amount of optimization saves it.

---

## The core job

Transform a keyword target into **publication-ready content** that:
- Answers the search intent completely
- Sounds like a knowledgeable human wrote it
- Is structured for both readers and search engines
- Includes proper on-page optimization
- Passes the "would I actually read this?" test

---

## Required inputs

Before writing, gather:

1. **Target keyword** — Primary keyword to rank for
2. **Keyword cluster** — Related keywords to include naturally
3. **Search intent** — Informational / Commercial / Transactional
4. **Content type** — Pillar guide / How-to / Comparison / Listicle / etc.
5. **Brand voice profile** — (from brand-voice skill, if available)
6. **Positioning angle** — From `02-positioning.md`, the specific angle assigned to this article. For supporting articles: Use the **SECONDARY ANGLE**. For pillar guide: Use the **PRIMARY ANGLE**.

If coming from keyword-research skill, most of this is already defined. If coming from pillar workflow, positioning angles are defined in `02-positioning.md`.

---

## The workflow

```
RESEARCH → BRIEF → OUTLINE → DRAFT → HUMANIZE → OPTIMIZE → REVIEW
```

---

## Phase 1: Research

Before writing a word, understand what you're competing against.

### SERP Analysis

Search the target keyword (incognito) and analyze top 5 results:

**For each result, note:**
- Content type (guide, listicle, tool page, etc.)
- Approximate word count
- Structure (headers, sections)
- Unique angles or data
- What they do well
- What they miss or get wrong
- How recent (publish/update date)

**Extract from SERP features:**
- People Also Ask questions (answer ALL of these)
- Featured Snippet format (match it to win it)
- AI Overview presence (what it includes/excludes)

### Gap Analysis

After reviewing competitors, identify:

1. **What's missing?** — Questions unanswered, angles unexplored
2. **What's outdated?** — Old information, deprecated methods
3. **What's generic?** — Surface-level advice anyone could give
4. **What's your edge?** — Unique data, experience, perspective

Your content should fill these gaps.

---

## Phase 2: Content Brief

Before drafting, create a brief:

```
# Content Brief: [Title]

## Target Keyword
Primary: [keyword]
Secondary: [keyword], [keyword], [keyword]

## Search Intent
[Informational / Commercial / Transactional]

## Content Type
[Pillar Guide / How-To / Comparison / Listicle / etc.]

## Target Word Count
[Based on competitor analysis]

## Audience
Who is searching this? What do they need?

## Unique Angle
What makes our take different?

## Key Points to Cover
- [Point 1]
- [Point 2]
- [Point 3]

## Questions to Answer (from PAA)
- [Question 1]
- [Question 2]
- [Question 3]

## Competitor Gaps to Fill
- [Gap 1]
- [Gap 2]

## Internal Links
- Link to: [related content on site]
- Link from: [existing content that should link here]

## CTA
What action should readers take?
```

### Angle Integration

When writing pillar content, extract the assigned angle from `02-positioning.md`:

1. **Identify your angle** — For supporting articles, find your article's SECONDARY ANGLE. For the pillar guide, use the PRIMARY ANGLE.

2. **Extract the positioning elements:**
   - **"This angle claims"** — The territory you're staking out
   - **"This angle rejects"** — What you're positioning against
   - **"Reinforces primary via"** — How this article connects back to the pillar's core positioning

3. **Apply the angle throughout:**
   - **Hook/intro** — The angle shapes your opening. Lead with the claim or the rejection.
   - **Framing of examples** — Choose and present examples that reinforce the angle.
   - **Conclusion's call-back** — End by tying back to the angle's core claim.

**Example:** If your angle claims "human-AI collaboration beats pure automation" and rejects "the fire-your-marketing-team AI hype," your intro should challenge the automation narrative, your examples should show collaboration wins, and your conclusion should reinforce why this approach matters.

---

## Phase 3: Outline

Structure the content based on type:

### Pillar Guide Structure (5,000-8,000 words)

```
1. Hook Intro (150-250 words)
   - Answer the title question immediately
   - Why this matters NOW
   - Who this is for (and who it's not for)

2. Quick Answer Section (200-300 words)
   - Direct answer for Featured Snippet
   - TL;DR for skimmers

3. Core Sections (3-5 major sections)
   - Each 800-1,500 words
   - Each answers a major sub-question
   - H2 headers with keyword variations

4. Implementation / How to Apply (300-500 words)
   - Specific actionable steps
   - Decision framework if applicable

5. FAQ Section (5-10 questions)
   - From PAA research
   - Schema-ready format

6. Conclusion with CTA (150-200 words)
   - Summarize key takeaway
   - Clear next action
```

### How-To Tutorial Structure (2,000-3,000 words)

```
1. What You'll Achieve (150-200 words)
   - End result shown first
   - Time estimate
   - Prerequisites

2. Why This Method (200-300 words)
   - Context and alternatives
   - Why this approach works

3. Step-by-Step Instructions (1,200-2,000 words)
   - Numbered steps
   - One action per step
   - Troubleshooting inline

4. Variations / Advanced Tips (300-400 words)

5. Common Mistakes (200-300 words)

6. Next Steps with CTA (100-150 words)
```

### Comparison Structure (2,500-4,000 words)

```
1. Quick Verdict (200-300 words)
   - Bottom line recommendation
   - "Choose X if... Choose Y if..."

2. Comparison Table
   - 8-12 key differentiators
   - Pricing, best for, key features

3. Deep Dive: Option A (800-1,000 words)
   - What it is
   - Key features
   - Pros/cons
   - Best for
   - Real example

4. Deep Dive: Option B (800-1,000 words)
   - Same structure

5. Head-to-Head Comparison (300-500 words)
   - Specific scenarios
   - When to pick each

6. FAQ (3-5 questions)

7. Final Recommendation with CTA
```

### Listicle Structure (2,000-3,000 words)

```
1. Intro with Context (150-200 words)
   - Why this list matters
   - How items were selected

2. Quick Summary Table/List
   - All items at a glance
   - For skimmers

3. Individual Items (150-300 words each)
   - What it is
   - Why it's included
   - Best for / Use case
   - Limitations (honesty builds trust)

4. How to Choose (200-300 words)
   - Decision framework

5. FAQ (3-5 questions)

6. Conclusion with CTA
```

---

## Phase 4: Draft

Write the first draft following these principles:

### The First Paragraph Rule

Answer the search query in the first 2-3 sentences. Don't make them scroll.

**Bad:**
> "In today's rapidly evolving digital landscape, marketers are increasingly turning to artificial intelligence to streamline their workflows and enhance productivity..."

**Good:**
> "AI marketing tools can automate 60-80% of repetitive marketing tasks. Here are the 10 that actually work, based on testing them across 50+ client accounts."

### The "So What?" Chain

For every point you make, ask "so what?" until you hit something the reader actually cares about:

> Feature: "Automated email sequences"
> So what? "Sends follow-ups without you remembering"
> So what? "You wake up to replies instead of a blank inbox"
> So what? "Close deals while you sleep"

Write from the bottom of the chain, not the top.

### Specificity Over Generality

**Weak:** "This tool saves time."
**Strong:** "This tool cut our email outreach from 4 hours to 15 minutes per day."

**Weak:** "Many marketers struggle with content."
**Strong:** "73% of marketers publish less than once per week. Here's why."

Numbers, examples, specifics. Always.

### Show Your Work

Don't just make claims. Show how you know:

> "After testing 23 AI writing tools over 6 months, three stood out..."

> "We analyzed 147 high-ranking articles in this space. The pattern was clear..."

> "When I implemented this for [client], the results were..."

Experience signals beat assertions.

---

## Phase 5: Humanize

AI-generated content has tells. Remove them ruthlessly.

The goal isn't "sounds okay." It's "sounds like a specific person wrote this based on real experience."

### The AI Detection Patterns

AI content fails in predictable ways. Learn to spot them:

**1. Word-Level Tells**

Kill these immediately:
- delve, dive into, dig into
- comprehensive, robust, cutting-edge
- utilize (just say "use")
- leverage (as a verb)
- crucial, vital, essential
- unlock, unleash, supercharge
- game-changer, revolutionary
- landscape, navigate, streamline
- tapestry, multifaceted, myriad
- foster, facilitate, enhance
- realm, paradigm, synergy
- embark, journey (for processes)
- plethora, myriad, bevy
- nuanced, intricate, seamless

**2. Phrase-Level Tells**

These scream "AI wrote this":
- "In today's fast-paced world..."
- "In today's digital age..."
- "It's important to note that..."
- "When it comes to..."
- "In order to..." (just say "to")
- "Whether you're a... or a..."
- "Let's dive in" / "Let's explore"
- "Without further ado"
- "At the end of the day"
- "It goes without saying"
- "In conclusion" (especially at the end)
- "This comprehensive guide will..."
- "Are you looking for..." (fake questions)
- "Look no further"

**3. Structure-Level Tells**

AI has recognizable structural patterns:

- **The Triple Pattern**: Everything in threes. Three benefits. Three examples. Three subpoints. Humans are messier.
- **Perfect Parallelism**: Every bullet point same length, same structure. Too clean.
- **The Hedge Stack**: "While X, it's important to consider Y, but also Z." Never commits.
- **Fake Objectivity**: "Some experts say... others believe..." without taking a position.
- **Summary Sandwich**: Intro summarizes, body covers, conclusion summarizes again. Boring.
- **Empty Transitions**: "Now that we've covered X, let's move on to Y." Adds nothing.

**4. Voice-Level Tells**

The hardest to fix:

- **No Opinions**: Everything balanced, nothing claimed. Real experts have takes.
- **No Mistakes Mentioned**: Never wrong about anything, ever. Suspicious.
- **Generic Examples**: "For example, a business might..." instead of a real story.
- **Distance from Subject**: Writing about, not from experience of.
- **Uniform Certainty**: Every statement equally confident. Humans hedge where uncertain, commit where sure.

### Before/After Examples

**AI Version:**
> "Email marketing remains a crucial component of any comprehensive digital marketing strategy. When it comes to improving open rates, it's important to consider several key factors. First, crafting compelling subject lines is essential. Second, segmenting your audience allows for more targeted messaging. Third, timing plays a vital role in engagement."

**Human Version:**
> "I ignored email for two years. Social media was sexier. Then I looked at the numbers: email drove 3x the revenue of all social combined. Here's what actually moves open rates—the stuff that worked when we tested it across 12 client accounts."

---

**AI Version:**
> "In today's fast-paced business landscape, professionals are increasingly turning to automation tools to streamline their workflows and enhance productivity. These comprehensive solutions offer a myriad of benefits for organizations of all sizes."

**Human Version:**
> "Most automation tools are shelfware. You buy them, set them up, use them twice, forget they exist. Here are the three that actually stuck after a year of testing—and the 14 I wasted money on."

---

**AI Version:**
> "Whether you're a seasoned marketer or just starting your journey, understanding SEO fundamentals is crucial for success. Let's dive into the essential strategies that can help you navigate the complex landscape of search engine optimization."

**Human Version:**
> "SEO advice is 90% outdated garbage. The tactics that worked in 2019 will get you penalized now. I'm going to show you what's actually ranking in December 2024—pulled from 300+ sites we analyzed last month."

### Voice Injection Points

Human content has these. AI content doesn't. Add them:

**Personal experience with specifics:**
> "I made this mistake for two years. Cost me roughly $40K in lost revenue before someone on Twitter pointed out what I was doing wrong."

**Opinion with reasoning:**
> "Honestly, most SEO advice is written by people who've never ranked anything. They're regurgitating what they read somewhere else. Here's what I've actually seen work..."

**Admission of limitations:**
> "This won't work for everyone. If you're in YMYL niches, ignore this entirely—different rules apply. If you're B2B enterprise, probably not either."

**Specific examples from real work:**
> "When we implemented this for [specific client—an e-commerce brand selling outdoor gear], their organic traffic went from 12K to 89K monthly in four months. Not because of any trick—because we fixed the structural issues killing their crawlability."

**Uncertainty where honest:**
> "I'm not 100% sure why this works. Best guess: the semantic density signals topical authority. But I've seen it work across 40+ sites, so I stopped questioning it."

**Tangents and asides:**
> "This is the part where most guides tell you to 'create quality content.' (Useless advice.) What does that actually mean? Here's the specific bar to clear..."

### Rhythm Variation

AI writes in monotonous rhythm—similar sentence lengths, parallel structures, predictable patterns. Fix it:

- Vary sentence length. Short punch. Then longer explanatory sentences that build out the context and add nuance that couldn't fit in a shorter form.
- Use fragments. For emphasis. Or drama.
- Start sentences with "And" or "But" when natural. Grammar rules exist to serve clarity, not the other way around.
- Include parenthetical asides (the kind of thing you'd say out loud if explaining to a friend).
- Ask questions. Then answer them. Or don't—leave some things hanging.
- One-word paragraphs.

Really.

### The Detection Checklist

Before publishing, run through:

```
[ ] No AI words (delve, comprehensive, crucial, leverage, landscape)
[ ] No AI phrases (in today's world, it's important to note, let's dive in)
[ ] Not everything in threes
[ ] At least one personal opinion stated directly
[ ] At least one specific number from real experience
[ ] At least one admission of limitation or uncertainty
[ ] Sentence lengths vary (some under 5 words, some over 20)
[ ] Would I say this out loud to a smart friend?
[ ] Does it sound like a specific person, or a committee?
[ ] Can I identify whose voice this is?
```

### The Read-Aloud Test

Read your draft out loud. If you stumble, readers will too. If it sounds like a textbook, rewrite it. If you'd be embarrassed to read it to a colleague, it's not ready.

---

## Phase 6: Optimize

### On-Page SEO Checklist

```
[ ] Primary keyword in title (front-loaded if possible)
[ ] Primary keyword in H1 (can match title)
[ ] Primary keyword in first 100 words
[ ] Primary keyword in at least one H2
[ ] Secondary keywords in H2s naturally
[ ] Primary keyword in meta description
[ ] Primary keyword in URL slug
[ ] Image alt text includes relevant keywords
[ ] Internal links to related content (4-8 per piece)
[ ] External links to authoritative sources (2-4 per piece)
```

### Title Optimization

**Format:** [Primary Keyword]: [Benefit or Hook] ([Year] if relevant)

**Examples:**
- "AI Marketing Tools: 10 That Actually Work (2025)"
- "What is Agentic AI Marketing? The Complete Guide"
- "n8n vs Zapier: Which Automation Tool is Right for You?"

**Title rules:**
- Under 60 characters (or it gets cut off)
- Front-load the keyword
- Include a hook or differentiator
- Match search intent

### Meta Description

**Format:** [Direct answer to query]. [Proof/credibility]. [CTA or hook].

**Example:**
> "AI marketing tools can automate 60-80% of repetitive tasks. We tested 23 tools over 6 months to find the 10 that actually deliver. See the results."

**Meta rules:**
- 150-160 characters
- Include primary keyword
- Compelling enough to click
- Match what the content delivers

### Header Structure

```
H1: Main title (one per page)
  H2: Major section (keyword variation)
    H3: Subsection
    H3: Subsection
  H2: Major section (keyword variation)
    H3: Subsection
  H2: FAQ (if included)
    H3: Question 1
    H3: Question 2
```

Use headers for structure, not decoration. Each H2 should be a scannable summary of what follows.

### Featured Snippet Optimization

**For definition snippets:**
- Put definition in first paragraph
- Format: "[Keyword] is [definition in 40-50 words]"

**For list snippets:**
- Use H2 for the question
- Immediately follow with numbered or bulleted list
- Keep list items concise (one line each)

**For table snippets:**
- Use actual HTML tables
- Include clear headers
- Keep data concise

### Internal Linking Strategy

**Link TO this content from:**
- Related pillar content
- Blog posts on similar topics
- Resource pages

**Link FROM this content to:**
- Deeper dives on subtopics mentioned
- Related tools or resources
- Conversion pages (where appropriate)

**Anchor text:**
- Use descriptive text, not "click here"
- Vary anchor text naturally
- Include keywords where natural

**Placeholder Convention for Unpublished Articles:**

When writing an article that should link to another article that doesn't exist yet, use a placeholder:

```html
<!-- LINK NEEDED: [slug] when published -->
```

**Example:**
```markdown
For implementation details, see our step-by-step guide<!-- LINK NEEDED: 03-implementation-guide when published -->.
```

**When to use placeholders:**
- Target article is in the pillar plan but not yet written
- Pillar guide is not yet published (supporting articles reference it)

**Post-publish linking pass:** After the pillar is complete, search for all `<!-- LINK NEEDED: ... -->` placeholders and replace with actual links.

**Cross-Pillar Links:**

After completing the current pillar, review other pillars for cross-linking opportunities:
- Add cross-pillar links only after the current pillar is fully complete
- Limit to 1-2 cross-pillar links per article (more dilutes internal link equity)
- Use anchor text that clarifies the pillar context (e.g., "our guide to email sequences" not just "email marketing")
- Cross-pillar links are supplementary—each article should primarily link within its own pillar

---

## Phase 7: Quality Review

### Content Quality Checklist

```
[ ] Answers title question in first 300 words
[ ] At least 3 specific examples or numbers
[ ] At least 1 personal experience or unique insight
[ ] Unique angle present (not just aggregation)
[ ] All claims supported by evidence or experience
[ ] No generic advice (could apply to anyone)
[ ] Would I bookmark this? Would I share it?
```

### Voice Quality Checklist

```
[ ] Reads naturally out loud
[ ] No AI-isms (delve, landscape, comprehensive)
[ ] No corporate speak (leverage, synergy)
[ ] Sentence length varies
[ ] Personality present
[ ] Would I actually say this to someone?
```

### SEO Quality Checklist

```
[ ] Primary keyword in title, H1, first paragraph
[ ] Secondary keywords in H2s naturally
[ ] Meta description compelling and <160 chars
[ ] Internal links included (4-8)
[ ] External citations for claims (2-4)
[ ] Alt text on all images
[ ] Headers create logical structure
[ ] FAQ section with schema-ready format
```

### E-E-A-T Signals Checklist

```
[ ] Experience shown (real examples, specific results)
[ ] Expertise demonstrated (depth, accuracy, nuance)
[ ] Author credentials visible
[ ] Sources cited for factual claims
[ ] Updated date visible
[ ] No misleading claims
```

---

## Output format

The final deliverable uses the unified article template with YAML frontmatter. See `templates/article-template.md` for full specification.

**All articles MUST output in this format:**

```markdown
---
# Core metadata
title: "[Article Title - includes H1]"
meta_title: "[SEO title, under 60 characters]"
meta_description: "[150-160 characters with primary keyword]"
slug: "[lowercase-hyphenated-keyword-url]"
author: "[Author name from client profile]"
date: "[YYYY-MM-DD]"
status: "draft"

# Taxonomy
categories:
  - "[Primary category]"
tags:
  - "[tag1]"
  - "[tag2]"

# SEO metadata
primary_keyword: "[Main target keyword]"
secondary_keywords_used:
  - "[keyword1]"
  - "[keyword2]"
keyword_density: "[X.X%]"
word_count: "[XXXX]"

# Open Graph
og_title: "[Social sharing title]"
og_description: "[Social sharing description]"
og_image: ""
canonical_url: ""

# Schema
schema_type: "Article"

# Links
internal_links:
  - url: "[/path/to/page]"
    anchor: "[anchor text]"
external_citations:
  - url: "[https://source.com]"
    author: "[Author/Org]"
    year: "[YYYY]"
    title: "[Source title]"
---

## Table of Contents (include for articles 3000+ words)

- [Section One](#section-one)
- [Section Two](#section-two)

---

[Full article content with proper H2/H3 structure]

---

## FAQ

### [Question 1]
[Answer]

### [Question 2]
[Answer]
```

### Frontmatter requirements

- **meta_title:** Under 60 characters, front-load primary keyword
- **meta_description:** 150-160 characters, include primary keyword, compelling
- **slug:** Lowercase, hyphenated, contains primary keyword
- **word_count:** Calculate actual word count of body content
- **keyword_density:** Calculate primary keyword occurrences / total words × 100
- **internal_links:** Minimum 3 links with descriptive anchor text
- **external_citations:** Include author/org and year for E-E-A-T compliance
- **Table of Contents:** Auto-generate for articles 3000+ words, placed after frontmatter

### Table of Contents Generation

**When to generate:** Articles with 3000+ words MUST include a Table of Contents. Articles under 3000 words should NOT include one.

**Placement:** After the closing `---` of the YAML frontmatter, before the first H2 of the article content.

**Format:** Use anchor link format with each H2 section as an entry:

```markdown
## Table of Contents

- [Section Title](#section-title)
- [Another Section](#another-section)
- [FAQ](#faq)
```

**Anchor link rules:**
- Convert the H2 text to lowercase
- Replace spaces with hyphens
- Remove special characters (colons, commas, apostrophes, etc.)
- Keep numbers as-is
- Example: `## What is AI Marketing?` → `[What is AI Marketing?](#what-is-ai-marketing)`

**What to include:**
- All H2 sections in the article
- Do NOT include H3 subsections (keeps ToC scannable)
- Do NOT include the FAQ section's individual questions (just the FAQ H2)

**What NOT to do:**
- Don't number the ToC entries (use bullets)
- Don't add descriptions after links
- Don't nest entries (flat list only)

---

## Example: Creating SEO content from keyword research

### Input from keyword-research skill:

```
Target: "what is agentic AI marketing"
Cluster: agentic AI, AI marketing agents, autonomous marketing
Intent: Informational
Content type: Pillar guide
Priority: Critical (category definition opportunity)
```

### SERP analysis findings:
- Top results are thin (500-1,000 words)
- No comprehensive guide exists
- PAA questions unanswered well
- Opportunity to define the category

### Content brief created:
- 5,000+ word pillar guide
- Unique angle: Practitioner perspective with real implementations
- Include: Definition, examples, tools, how to implement, future outlook
- Answer all PAA questions
- Target Featured Snippet with clear definition

### Draft following pillar guide structure:
- Hook: "AI agents can now run marketing campaigns without you. Here's what that actually means."
- Quick answer section for snippet
- Deep sections on: What it is, How it works, Real examples, Tools, Implementation
- FAQ from PAA research
- CTA to community/resources

### Humanized with:
- Personal experience running AI marketing campaigns
- Specific metrics from real implementations
- Honest limitations acknowledged
- Conversational tone throughout

### Optimized with:
- Keyword in title, H1, first paragraph
- Secondary keywords in H2s
- Internal links to related content
- FAQ schema ready

---

## Output location

Save articles to the pillar's articles folder using this naming convention:

```
{pillar}/articles/{nn}-{slug}.md
```

**Naming rules:**
- `{nn}` = Two-digit number matching the article order from pillar brief (01, 02, 03...)
- `{slug}` = Lowercase, hyphenated primary keyword (max 50 chars, no stop words unless essential)

**Examples:**
- `ai-marketing-strategy/articles/01-what-is-agentic-ai-marketing.md`
- `ai-marketing-strategy/articles/02-ai-marketing-tools-comparison.md`
- `ai-marketing-strategy/articles/03-building-ai-marketing-team.md`

**Pillar guide numbering:** The pillar guide uses the highest number in the sequence and publishes last. Example: 10 supporting articles + pillar guide = supporting articles are `01`-`10`, pillar guide is `11-ai-marketing-strategy-guide.md`.

---

## Pillar Mode (Multiple Articles)

When generating a full pillar (7+ articles), running each article sequentially in one session exhausts context. Pillar mode solves this through agent orchestration.

**Full documentation:** [Workflow Rules](../../rules/workflow.md)

### When to Use Pillar Mode

| Scenario | Mode | Trigger |
|----------|------|---------|
| Single article | Standard | `/seo-content` |
| 2-3 articles | Standard (sequential) | `/seo-content` per article |
| 4+ articles (full pillar) | Agent-automated | `/execute-pillar` |

### How Pillar Mode Works

The main session orchestrates 4 agents (seo-writer, copy-enhancer, content-validator, content-atomizer) using **Parallel by Dependency Tier** execution:

1. **Tier 1:** Foundation articles (no dependencies)
2. **Tier 2+:** Articles grouped by internal linking dependencies
3. **Final Tier:** Pillar guide (links to all articles)

Within each tier, multiple articles can run in parallel. The main session:
- Spawns agents and receives PASS/FAIL results
- Handles retry loops (max 3 attempts per article)
- Commits after each tier completes
- Runs post-pillar linking pass

**Key constraint:** Agents cannot spawn other agents. The main session orchestrates all execution.

### Agent Pipeline Per Article

```
seo-writer → copy-enhancer → content-validator → (retry if FAIL) → content-atomizer
```

See [Workflow Rules](../../rules/workflow.md) for the complete orchestration pattern, retry logic, and tier identification guide.

---

## How this connects to other skills

**Input from:**
- **keyword-research** → Provides target keyword, cluster, intent, content type
- **positioning-angles** → Provides unique angle for differentiation (from `02-positioning.md`)
- **brand-voice** → Provides voice profile for consistent tone

**Uses:**
- **direct-response-copy** → For CTAs and conversion elements within content

**The flow:**
1. keyword-research identifies the opportunity
2. positioning-angles finds the unique angle
3. brand-voice defines how it should sound
4. **seo-content creates the actual piece** (saved to `articles/{nn}-{slug}.md`)
5. direct-response-copy punches up CTAs

---

## Reference: E-E-A-T Examples

See `references/eeat-examples.md` for 20 best-in-class examples of human-written content across verticals:

**Marketing/Business:**
- Paul Graham, Wait But Why, Stratechery, James Clear, Backlinko, Lenny's Newsletter, Derek Sivers

**Finance/Economics:**
- Matt Levine (Money Stuff), Morgan Housel (Psychology of Money)

**Technical/Engineering:**
- Julia Evans, Dan Luu, Shopify Engineering Blog

**Healthcare/Science:**
- Dr. Peter Attia, Dr. Siddhartha Mukherjee

**Enterprise/B2B:**
- First Round Review, Rosalyn Santa Elena (RevOps)

**Specialized Verticals:**
- Brian Krebs (Cybersecurity), Ken White (Legal), Katrina Kibben (HR/Recruiting), J. Kenji López-Alt (Food Science)

Study these patterns. The goal is content that reads like these writers—not like AI trained on generic web content.

---

## The test

Before publishing, ask:

1. **Does it answer the query better than what's ranking?**
2. **Would an expert in this field approve of the accuracy?**
3. **Would a reader bookmark or share this?**
4. **Does it sound like a person, not a content mill?**
5. **Is there at least one thing here they can't find elsewhere?**
6. **Does it pass the AI detection checklist?** (Phase 5)
7. **Does it match the quality bar of the E-E-A-T examples?**

If any answer is no, revise before publishing.

---

## Non-Interactive Mode

When invoked by an agent (see [Workflow Rules](../../rules/workflow.md)), this skill runs in non-interactive mode.

### What Changes

| Behaviour | Interactive | Non-Interactive |
|-----------|-------------|-----------------|
| Clarifying questions | Asked when needed | Never asked — all context must be in prompt |
| Research prompts | May ask for direction | Uses provided context only |
| Confirmation requests | May ask "Continue?" | Proceeds without confirmation |
| Output format | Flexible | Structured return format only |

### Requirements for Non-Interactive

The sub-agent prompt must include:

- [ ] Client profile path (for brand voice)
- [ ] Positioning document path (for angle)
- [ ] Pillar brief path (for keyword data)
- [ ] Target keyword (explicit)
- [ ] Word count target (explicit)
- [ ] Output file path (where to write the article)
- [ ] Completed articles list (for internal linking)

### Return Format

In non-interactive mode, return ONLY:

```
**Status:** PASS | FAIL

**File Path:** {output_path}

**Word Count:** {actual_word_count}

**Issues (if FAIL):**
- [List any validation failures]

**Notes:**
- [Any relevant context for the main session]
```

Do NOT return full article content — the main session reads from the file path if needed.

### Missing Context Handling

If required context is missing:

1. Return FAIL status immediately
2. List missing context in Issues
3. Do NOT attempt to guess or ask for clarification

Example:
```
**Status:** FAIL

**Issues:**
- Missing positioning document at provided path
- Cannot determine article angle without positioning

**Notes:**
- Main session should verify file paths before re-spawning
```

---

*Reference: `rules/workflow.md` for complete agent orchestration guidelines.*
