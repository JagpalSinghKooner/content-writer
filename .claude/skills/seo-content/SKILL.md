---
name: seo-content
description: "Create high-quality, SEO-optimized content that ranks AND reads like a human wrote it. Use when turning keyword research into actual content pieces. Takes a target keyword/cluster and produces a complete article optimized for search while avoiding AI-sounding output. Triggers on: write SEO content for X, create article for keyword, write blog post about X, SEO article, content for keyword cluster. Outputs publication-ready content with proper structure, optimization, and human voice."
---

# SEO Content Workflow

Transform a keyword target into **publication-ready content** that:
- Answers the search intent completely
- Sounds like a knowledgeable human wrote it
- Is structured for both readers and search engines
- Includes proper on-page optimisation
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

1. Research — Analyse SERP and identify gaps
2. Brief — Create content brief with angle
3. Outline — Structure by content type
4. Draft — Write following draft principles
5. Humanise — Remove AI patterns per `references/banned-words-phrases.md`
6. Optimise — Apply SEO requirements per `references/seo-requirements.md`
7. Review — Run quality checklists

---

## Phase 1: Research

Before writing a word, understand what you're competing against.

### SERP Analysis

Search the target keyword (incognito) and analyse top 5 results:

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
   - Summarise key takeaway
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

**Bad:** "In today's rapidly evolving digital landscape, marketers are increasingly turning to artificial intelligence..."

**Good:** "AI marketing tools can automate 60-80% of repetitive marketing tasks. Here are the 10 that actually work, based on testing them across 50+ client accounts."

### The "So What?" Chain

For every point, ask "so what?" until you hit something the reader cares about. Write from the bottom of the chain, not the top.

### Specificity Over Generality

Use specific numbers, percentages, and concrete examples. "This tool cut our email outreach from 4 hours to 15 minutes" beats "This tool saves time."

### Show Your Work

Don't just make claims. Show how you know:
- "After testing 23 AI writing tools over 6 months, three stood out..."
- "We analysed 147 high-ranking articles in this space..."
- "When I implemented this for [client], the results were..."

Experience signals beat assertions.

### Voice

- Vary sentence length. Short punch. Then longer explanatory sentences.
- Use fragments for emphasis.
- Start sentences with "And" or "But" when natural.
- Include parenthetical asides.
- Ask questions. Then answer them.
- Take positions. Real experts have takes.
- Admit limitations honestly.

---

## Phase 5: Humanise

Remove AI patterns ruthlessly. Apply all checks from `references/banned-words-phrases.md`: banned words (Rule 2), banned phrases (Rule 3), AI structural patterns (Rule 4), and em dash removal (Rule 4b).

The goal isn't "sounds okay." It's "sounds like a specific person wrote this based on real experience."

---

## Phase 6: Optimise

Apply on-page SEO requirements from `references/seo-requirements.md`: title optimisation, meta description, header structure, featured snippet targeting, keyword placement.

For internal linking rules and placeholder conventions, see `references/internal-linking-strategy.md`.

---

## Phase 7: Quality Review

### Content Quality

```
[ ] Answers title question in first 300 words
[ ] At least 3 specific examples or numbers
[ ] At least 1 personal experience or unique insight
[ ] Unique angle present (not just aggregation)
[ ] All claims supported by evidence or experience
[ ] No generic advice (could apply to anyone)
[ ] Would I bookmark this? Would I share it?
```

### Voice Quality

```
[ ] Reads naturally out loud
[ ] No AI-isms (delve, landscape, comprehensive)
[ ] No corporate speak (leverage, synergy)
[ ] Sentence length varies
[ ] Personality present
[ ] Would I actually say this to someone?
```

### E-E-A-T Signals

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

Use `skills/templates/article-template.md` for full article structure, YAML frontmatter specification, and Table of Contents rules.

## Output location

See `references/file-naming-conventions.md` for article naming, slug format, and distribution paths.

---

## Pillar mode

For generating full pillars (4+ articles), use `/execute-pillar`. See `rules/workflow.md` for agent orchestration, tier-based parallel execution, and retry logic.

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

## E-E-A-T reference

See `references/eeat-patterns.md` for 20 best-in-class examples of human-written content with universal patterns, questions to ask before writing, and red flags to avoid.

---

## The test

Before publishing, ask:

1. **Does it answer the query better than what's ranking?**
2. **Would an expert in this field approve of the accuracy?**
3. **Would a reader bookmark or share this?**
4. **Does it sound like a person, not a content mill?**
5. **Is there at least one thing here they can't find elsewhere?**
6. **Does it pass all checks in `references/banned-words-phrases.md`?**
7. **Does it match the quality bar of the E-E-A-T examples?**

If any answer is no, revise before publishing.

---

## Non-interactive mode

When invoked by an agent, all required context must be in the prompt. See `rules/workflow.md` for agent return format and missing context handling.
