---
name: validate-content
description: "Check content against universal rules and client profile, outputting PASS/FAIL with line-specific issues. Use after /direct-response-copy to validate final content before publishing. Triggers on: validate this content, check this article, validate content, content check, is this ready to publish, check for AI words. Outputs validation result with specific fixes needed."
---

# Content Validation Workflow

Every piece of content gets validated before publishing. No exceptions.

This skill checks content against universal rules (UK English, banned AI words, SEO requirements) and client-specific rules (brand voice, terminology, avoided topics). It outputs a clear PASS/FAIL verdict with line-specific issues that can be fixed.

The goal: Catch AI fingerprints and quality issues before they reach readers.

---

## The core job

Validate content against all rules and output:
- **PASS** — Ready to publish
- **FAIL** — Issues must be fixed before publishing

Every FAIL issue includes the line number, the problem, and the specific fix.

---

## Required inputs

Before validating, gather:

1. **Article to validate** — File path or content to check
2. **Primary keyword** — For SEO requirement checks
3. **Client profile path** — (Optional but recommended) For brand voice and terminology checks

If no client profile provided, validation runs against universal rules only.

---

## When to Run Validation

Validation runs at specific points in the content workflow. Missing a checkpoint risks publishing content with issues.

### Mandatory Triggers

These checkpoints are non-negotiable:

| Trigger | When | Why |
|---------|------|-----|
| After `/seo-content` | Every article draft | Catch AI fingerprints and rule violations before enhancement |
| After `/direct-response-copy` | Every enhanced article | Ensure conversion edits didn't introduce banned words or break voice |
| Before publishing | Every piece of content | Final gate before readers see it |

### Recommended Triggers

These improve quality but aren't strictly required:

| Trigger | When | Why |
|---------|------|-----|
| After completing pillar | All pillar articles written | Check cross-article consistency, contradictions, and linking |
| When revisiting old content | Updating existing articles | Older content may not meet current standards |
| When client feedback suggests issues | Quality concerns raised | Targeted validation to identify specific problems |
| After batch edits | Multiple articles updated at once | Ensure consistency wasn't broken |

### Automatic vs Manual

**Automatic checkpoints** (Post-draft, Post-enhancement, Pre-publish) run as part of the standard workflow—you don't need to ask for them.

**Manual checkpoints** (Batch review, Spot checks) run when explicitly requested. Use `/validate-content` to trigger these.

---

## The workflow

```
LOAD CONTENT → PHASE 1: UNIVERSAL RULES → PHASE 2: CLIENT PROFILE → PHASE 3: HUMAN QUALITY → PHASE 4: SCHEMA VALIDATION → PHASE 5: READABILITY METRICS → PHASE 6: PILLAR CONSISTENCY → OUTPUT VERDICT
```

---

## Phase 1: Universal Rules Check

Check against all FAIL conditions in `.claude/rules/universal-rules.md`.

### 1.1 UK English Spelling Scan

Scan for American spellings. Any found = FAIL.

**Check for these US→UK pairs:**

| US (FAIL) | UK (correct) |
|-----------|--------------|
| color | colour |
| behavior | behaviour |
| organization | organisation |
| favorite | favourite |
| honor | honour |
| favor | favour |
| humor | humour |
| labor | labour |
| recognize | recognise |
| organize | organise |
| realize | realise |
| analyze | analyse |
| center | centre |
| meter | metre |
| theater | theatre |
| mom | mum |
| traveling | travelling |
| canceled | cancelled |
| defense | defence |
| license | licence |
| gray | grey |
| check (money) | cheque |
| program | programme |
| catalog | catalogue |

**Output format:**
```
FAIL: Line 23: "color" - US spelling → use "colour"
```

### 1.2 Banned AI Words Scan (53 words)

Scan for any of the 53 banned AI words. Any found = FAIL.

**Overused Verbs:**
delve, navigate, leverage, utilize, facilitate, harness, empower, foster, embark, unleash, spearhead, bolster, underscore, spotlight, streamline

**Hollow Adjectives:**
comprehensive, robust, crucial, vital, optimal, seamless, intricate, nuanced, cutting-edge, revolutionary, pivotal, paramount, transformative, groundbreaking, multifaceted

**Buzzwords:**
plethora, myriad, bevy, tapestry, realm, paradigm, synergy, landscape (figurative), journey (for processes), game-changer, supercharge, elevate, unlock

**Filler Adverbs:**
noteworthy, notably, interestingly, importantly, undoubtedly, certainly, surely, obviously, clearly

**Weak Transitions:**
firstly, secondly, thirdly, lastly, additionally, furthermore, moreover

**Output format:**
```
FAIL: Line 45: "leverage" - banned AI word → use "use" or rephrase
FAIL: Line 67: "comprehensive" - banned AI word → use "complete" or "full"
```

### 1.3 Banned AI Phrases Scan

Scan for AI fingerprint phrases. Any found = FAIL.

**Opening Cliches:**
- "In today's fast-paced world"
- "In today's digital age"
- "In today's modern landscape"
- "In the ever-evolving world of..."
- "In this day and age"

**Throat-Clearing:**
- "It's important to note that..."
- "It's worth noting that..."
- "It's worth mentioning that..."
- "Let me explain..."
- "Let's dive in"
- "Let's explore"
- "Let's unpack"
- "Without further ado"

**Padding Phrases:**
- "When it comes to..."
- "In order to..." (just use "to")
- "Whether you're a... or a..."
- "At the end of the day"
- "It goes without saying"
- "The fact of the matter is"
- "For all intents and purposes"

**Meta-Commentary:**
- "In conclusion"
- "To summarize"
- "To sum up"
- "In this article, we will..."
- "This comprehensive guide will..."
- "As we've discussed"
- "As mentioned earlier"

**Desperate Hooks:**
- "Are you looking for...?"
- "Look no further"
- "You've come to the right place"
- "Ready to take your X to the next level?"

**Output format:**
```
FAIL: Line 12: "In today's digital age" - banned AI phrase → cut or rewrite opening
FAIL: Line 156: "In conclusion" - banned AI phrase → just start concluding
```

### 1.4 AI Pattern Detection

Scan for structural patterns that reveal AI authorship. Any found = FAIL.

**Repetitive Sentence Starts:**
- 3+ consecutive sentences starting with the same word
- Every paragraph starting with "The" or "This"

**The Rule of Threes:**
- Everything in perfect threes (3 points, 3 examples, 3 benefits repeatedly)
- "First... Second... Third..." structure

**Hedging Overload:**
- Excessive use of: might, could, perhaps, possibly, potentially, may
- Count hedging words — if more than 5% of content, flag

**Empty Transitions:**
- "Now let's move on to..."
- "With that said..."
- "Having covered X, let's turn to Y"

**Artificial Balance:**
- "While X is great, it's important to consider Y" pattern repeated

**Output format:**
```
FAIL: Lines 34-36: 3 consecutive sentences start with "This" - vary sentence openers
FAIL: Lines 45-67: Perfect "First... Second... Third..." structure - vary the pattern
FAIL: Content has 7% hedging words (might, could, perhaps) - make definitive statements
```

### 1.5 SEO Requirements Check

Check all SEO requirements. Missing requirements = FAIL.

**Keyword Placement:**
- [ ] Primary keyword in first 150 words
- [ ] Primary keyword in at least one H2
- [ ] Primary keyword density: 1-2% (not stuffed)

**Content Length:**
- [ ] Minimum 1,500 words

**Meta Data:**
- [ ] Meta title present and under 60 characters
- [ ] Meta description present and 140-160 characters
- [ ] Both include primary keyword

**Links:**
- [ ] At least 3 internal links

**Structure:**
- [ ] One H1 only (the title)
- [ ] Logical H2/H3 hierarchy
- [ ] Short paragraphs (3-4 sentences max)

**Output format:**
```
FAIL: Primary keyword "AI marketing tools" not in first 150 words → add to opening paragraph
FAIL: Word count is 1,234 → minimum is 1,500 words
FAIL: Meta title is 67 characters → shorten to under 60
FAIL: Only 2 internal links → add at least 1 more
FAIL: 2 H1 tags found → only one H1 allowed (the title)
```

---

## Phase 2: Client Profile Check

If client profile provided, check against client-specific rules.

### 2.1 Brand Voice Alignment

Read the brand voice section of the client profile and assess:

- Does the tone match? (formal/casual, serious/playful)
- Does the personality come through?
- Is the writing style consistent with examples?

**Output format:**
```
WARN: Tone is too formal — client profile indicates casual, conversational voice
WARN: Missing personality markers — client uses humour and self-deprecation, not present
```

### 2.2 Terminology Consistency

Check against the client's preferred terminology:

- Product names spelled correctly?
- Industry terms used consistently?
- Preferred phrases present?

**Output format:**
```
FAIL: Line 89: "product" should be "Acme Pro Suite" (client terminology)
WARN: Using "customers" — client prefers "members"
```

### 2.3 Avoided Words/Topics Check

Check against the client's "avoid" list:

- Any banned competitor mentions?
- Any sensitive topics?
- Any words the client specifically avoids?

**Output format:**
```
FAIL: Line 123: Mentions "CompetitorX" — client profile says avoid competitor mentions
WARN: Line 45: Topic of "pricing" — client prefers not to discuss pricing in content
```

---

## Phase 3: Human Quality Assessment

This is the "gut check" phase. AI can't fully assess this, but can flag concerns.

### 3.1 Overall AI Detection

Read the full content and assess:

- Does this sound like AI wrote it?
- Is there a distinct voice/personality?
- Would a reader suspect AI authorship?

**Signals of AI writing:**
- Uniform tone throughout (no variation)
- No opinions or positions taken
- Generic examples ("a business might...")
- Perfect structure with no tangents
- Every claim hedged or balanced

**Output format:**
```
WARN: Content feels AI-generated — no distinct voice, all claims hedged, generic examples
WARN: No opinions expressed — add author perspective or position
```

### 3.2 Natural Flow and Rhythm

Check for:

- Varied sentence length (mix short and long)
- Natural contractions used (it's, you're, we're)
- Paragraph length variation
- Conversational elements (questions, asides)

**Output format:**
```
WARN: All sentences 15-25 words — vary length (some under 5, some over 20)
WARN: No contractions used — "it is" should be "it's" for natural tone
WARN: 8 consecutive paragraphs same length — vary structure
```

### 3.3 Specific Examples and Opinions

Check for:

- Specific numbers from real experience
- Named examples (not "a company" but "Shopify")
- Author opinions clearly stated
- Admissions of limitations or uncertainty

**Output format:**
```
WARN: No specific numbers — add data from real experience
WARN: No named examples — replace "a business" with real example
WARN: No author opinions — add "We've found that..." or "The best approach is..."
```

---

## Phase 4: Schema Validation

Verify all frontmatter fields are present and correctly formatted per the article template.

### 4.1 Required Field Check

Parse the YAML frontmatter and verify all required fields exist:

**Core Metadata (all required):**
- [ ] `title` — present and non-empty
- [ ] `meta_title` — present, non-empty, under 60 characters
- [ ] `meta_description` — present, 150-160 characters
- [ ] `slug` — present and valid (see 4.2)
- [ ] `author` — present and non-empty
- [ ] `date` — present and valid YYYY-MM-DD format
- [ ] `status` — present and one of: draft, review, published

**Taxonomy:**
- [ ] `categories` — at least one category listed

**SEO Metadata (all required):**
- [ ] `primary_keyword` — present and non-empty
- [ ] `secondary_keywords_used` — at least one keyword listed
- [ ] `keyword_density` — present and formatted as "X.X%"
- [ ] `word_count` — present and numeric

**Open Graph:**
- [ ] `og_title` — present and non-empty
- [ ] `og_description` — present and non-empty
- [ ] `schema_type` — present and one of: Article, HowTo, FAQ, Product, Review

**Links:**
- [ ] `internal_links` — at least 3 entries with url and anchor fields
- [ ] `external_citations` — recommended (warn if missing, don't fail)

**Output format:**
```
FAIL: Missing required field "meta_title" in frontmatter
FAIL: Missing required field "keyword_density" in frontmatter
FAIL: "status" must be one of: draft, review, published — found "final"
WARN: No external_citations in frontmatter — recommended for E-E-A-T
```

### 4.2 Slug Format Validation

The slug must follow strict formatting rules. Invalid slug = FAIL.

**Slug Rules:**
- [ ] Lowercase only (no uppercase letters)
- [ ] Words separated by hyphens (no underscores, spaces, or special characters)
- [ ] Contains the primary keyword (or close variant)
- [ ] Maximum 50 characters
- [ ] No consecutive hyphens
- [ ] No leading or trailing hyphens

**Output format:**
```
FAIL: Slug "What-Is-SEO" contains uppercase → use "what-is-seo"
FAIL: Slug "seo_best_practices" uses underscores → use "seo-best-practices"
FAIL: Slug is 67 characters → shorten to under 50
FAIL: Slug "marketing-tips" doesn't contain primary keyword "seo tools" → add keyword
```

### 4.3 SEO Metrics Validation

Verify the SEO metrics in frontmatter match the actual content.

**Checks:**
- [ ] `word_count` matches actual body word count (±5% tolerance)
- [ ] `keyword_density` matches calculated density (±0.2% tolerance)
- [ ] `secondary_keywords_used` actually appear in the content
- [ ] `internal_links` count matches frontmatter entries

**Output format:**
```
FAIL: word_count says 2,500 but actual count is 1,847 — update frontmatter
FAIL: keyword_density says 1.8% but calculated density is 0.9% — recalculate or add keywords
FAIL: secondary_keyword "email marketing" listed but not found in content — remove or add to content
WARN: internal_links shows 4 but only 3 found in content — verify links
```

---

## Phase 5: Readability Metrics

Calculate readability scores to ensure content is accessible to the target audience.

### 5.1 Flesch-Kincaid Grade Level

Calculate the Flesch-Kincaid Grade Level using:

```
Grade Level = 0.39 × (total words / total sentences) + 11.8 × (total syllables / total words) - 15.59
```

**Target Ranges:**

| Content Type | Target Grade | Description |
|--------------|--------------|-------------|
| General blog | 6-8 | Easy to read, wide audience |
| B2B content | 8-10 | Professional but accessible |
| Technical | 10-12 | Expert audience acceptable |

**Output format:**
```
PASS: Flesch-Kincaid Grade Level: 7.2 (target: 6-8 for general blog)
WARN: Flesch-Kincaid Grade Level: 12.4 (target: 8-10 for B2B) — simplify sentence structure
FAIL: Flesch-Kincaid Grade Level: 16.1 — content too complex, break up long sentences
```

### 5.2 Flesch Reading Ease

Calculate the Flesch Reading Ease score:

```
Reading Ease = 206.835 - 1.015 × (total words / total sentences) - 84.6 × (total syllables / total words)
```

**Score Interpretation:**

| Score | Readability |
|-------|-------------|
| 90-100 | Very Easy (5th grade) |
| 80-89 | Easy (6th grade) |
| 70-79 | Fairly Easy (7th grade) |
| 60-69 | Standard (8th-9th grade) |
| 50-59 | Fairly Difficult (10th-12th grade) |
| 30-49 | Difficult (College) |
| 0-29 | Very Difficult (College graduate) |

**Target:** Most SEO content should score 60-70 (Standard readability).

**Output format:**
```
PASS: Flesch Reading Ease: 65 (Standard readability)
WARN: Flesch Reading Ease: 42 (Difficult) — use shorter sentences and simpler words
```

### 5.3 Sentence Length Analysis

Check for problematic sentence patterns:

- [ ] Average sentence length under 20 words
- [ ] No sentences over 40 words
- [ ] Variety in sentence length (standard deviation > 5)

**Output format:**
```
WARN: Average sentence length is 28 words — aim for under 20
FAIL: Line 45: Sentence is 67 words — break into 2-3 sentences
WARN: All sentences between 18-22 words — add variety (some short, some longer)
```

### 5.4 Readability Report

Include a readability summary in the validation output:

```
### Readability Metrics

| Metric | Score | Target | Status |
|--------|-------|--------|--------|
| Flesch-Kincaid Grade | 7.2 | 6-8 | ✓ |
| Flesch Reading Ease | 65 | 60-70 | ✓ |
| Avg Sentence Length | 16 words | <20 | ✓ |
| Longest Sentence | 34 words | <40 | ✓ |
```

---

## Phase 6: Pillar Consistency Check

Verify the article aligns with the positioning strategy defined in positioning.md.

### 6.1 Load Positioning Context

If validating content within a pillar structure, load:

- `{pillar}/02-positioning.md` — The positioning angles document
- `{pillar}/01-pillar-brief.md` — The pillar brief with article plan

If these files don't exist, skip this phase with a note.

**Output format:**
```
SKIP: No positioning.md found — pillar consistency check skipped
```

### 6.2 Angle Alignment Check

Verify the article uses the correct positioning angle from positioning.md:

- [ ] Article matches its assigned SECONDARY ANGLE (or PRIMARY ANGLE for pillar guide)
- [ ] Key messaging points from the angle are present
- [ ] Angle is consistent throughout (not switching mid-article)

**What to check:**
1. Read the assigned angle for this article from positioning.md
2. Verify the article's hook/intro aligns with that angle
3. Check that supporting points reinforce the angle
4. Ensure conclusion ties back to the angle

**Output format:**
```
PASS: Article aligns with assigned angle "Speed + Simplicity"
WARN: Assigned angle is "Cost Savings" but article emphasises "Features" — realign or confirm intentional
FAIL: Article switches from "Beginner-friendly" angle to "Advanced techniques" — maintain consistent angle
```

### 6.3 Internal Linking Consistency

Check that internal links align with the pillar structure:

- [ ] Links point to other articles in the same pillar (where relevant)
- [ ] Anchor text matches the linked article's focus
- [ ] No orphan articles (every article links to/from at least one other)

**Output format:**
```
PASS: Internal links correctly reference pillar articles
WARN: Link to "/blog/unrelated-topic" is outside pillar — verify intentional
FAIL: No internal links to other pillar articles — add at least one pillar interlink
```

### 6.4 Messaging Consistency

Check for contradictions with the pillar's core messaging:

- [ ] No claims that contradict other pillar articles
- [ ] Consistent terminology across the pillar
- [ ] Brand voice matches pillar positioning

**Output format:**
```
PASS: Messaging consistent with pillar positioning
WARN: Uses "cheap" but pillar positioning uses "affordable" — align terminology
FAIL: Claims "complex setup required" but pillar guide says "simple 5-minute setup" — resolve contradiction
```

---

## Phase 7: Content Type Variations

Not all content types require the same validation. This phase determines which rules apply based on content type.

### 7.1 Determine Content Type

Before validating, identify the content type:

| Content Type | Indicators |
|--------------|------------|
| **Article** | In `/articles/` folder, has SEO frontmatter, 1,500+ words |
| **Email** | In email sequence file, has subject line, part of sequence |
| **Newsletter** | In newsletter folder, has hook/body/CTA structure |
| **Lead Magnet** | Conceptual document, bridge to paid offer |
| **Distribution** | In `/distribution/` folder, platform-specific format |

### 7.2 Email Sequences

**Rules that APPLY:**
- UK English (all spellings must be British)
- Banned AI Words (all 53 words)
- Banned AI Phrases (all phrases)
- AI Patterns (repetitive starts, hedging overload)
- Brand Voice (must match client voice profile)

**Rules to SKIP:**
- SEO Requirements (no keyword density, word count, or meta data needed)
- Pillar Consistency (emails don't belong to pillars)
- External Citations (not required, but can be used for credibility)

**Additional Checks for Emails:**

| Check | Requirement | FAIL/WARN |
|-------|-------------|-----------|
| Subject line length | Under 50 characters | WARN |
| Preview text | Present and under 90 characters | WARN |
| CTA count | One primary CTA per email | FAIL if multiple competing CTAs |
| CTA clarity | Clear, specific action | WARN if vague |
| Personalisation | Uses subscriber name/context where appropriate | WARN |

**Output format:**
```
PASS: Email validates against applicable rules
WARN: Subject line is 62 characters → shorten to under 50
WARN: No preview text → add preview text under 90 characters
FAIL: Email has 3 different CTAs → use one primary CTA
```

### 7.3 Newsletters

**Rules that APPLY:**
- UK English (all spellings must be British)
- Banned AI Words (all 53 words)
- Banned AI Phrases (all phrases)
- AI Patterns (repetitive starts, hedging overload)
- Brand Voice (must match client voice profile)

**Rules to SKIP:**
- SEO Requirements (newsletters aren't optimised for search)
- Pillar Consistency (newsletters are standalone content)

**Additional Checks for Newsletters:**

| Check | Requirement | FAIL/WARN |
|-------|-------------|-----------|
| Hook present | Opening grabs attention in first 2 sentences | FAIL |
| Scannable format | Uses headers, bullets, or bold for scanning | WARN |
| CTA present | At least one CTA (can be soft) | WARN |
| Value delivery | Provides standalone value before any pitch | WARN |
| Length appropriate | Matches newsletter format (see below) | WARN |

**Format-Specific Length Guidelines:**

| Newsletter Format | Target Length |
|-------------------|---------------|
| Deep-Dive | 1,000-2,000 words |
| News Briefing | 500-800 words |
| Curated Links | 300-600 words + links |
| Personal Essay | 800-1,500 words |
| Roundup | 600-1,200 words |

**Output format:**
```
PASS: Newsletter validates against applicable rules
FAIL: No hook — first 2 sentences don't grab attention → rewrite opening
WARN: Wall of text — no headers or bullets → add scannable formatting
WARN: No CTA — add at least a soft CTA (reply, share, follow)
```

### 7.4 Lead Magnets (Concepts)

Lead magnet concepts are validated lightly since they're planning documents, not final content.

**Rules that APPLY:**
- UK English (all spellings must be British)
- Brand Voice alignment (concept should fit brand personality)

**Rules to SKIP:**
- Banned AI Words (planning documents can use any language)
- Banned AI Phrases (planning documents can use any language)
- AI Patterns (not applicable to concept documents)
- SEO Requirements (lead magnets aren't search-optimised)
- Pillar Consistency (lead magnets are standalone)
- External Citations (not required for concepts)

**Additional Checks for Lead Magnets:**

| Check | Requirement | FAIL/WARN |
|-------|-------------|-----------|
| Bridge to paid offer | Clear connection to what you're selling | FAIL |
| Quick win defined | Specific transformation promise | WARN |
| Hook clarity | Why someone would download is clear | WARN |
| Format appropriate | Format matches audience and topic | WARN |

**Output format:**
```
PASS: Lead magnet concept validates
FAIL: No bridge to paid offer — unclear how this leads to sale → define connection
WARN: Quick win vague — "learn about X" isn't a transformation → specify outcome
WARN: Hook unclear — why would someone download this? → sharpen the promise
```

### 7.5 Distribution Content

**Rules that APPLY:**
- UK English (all spellings must be British)
- Banned AI Words (all 53 words)
- Brand Voice (must match client voice profile, adjusted for platform)

**Rules to SKIP:**
- Banned AI Phrases (some phrases work in short-form social content)
- AI Patterns (short-form content has different patterns)
- SEO Requirements (social content isn't search-optimised)
- Pillar Consistency (distribution references articles but isn't part of pillar)
- External Citations (not required for social posts)

**Additional Checks for Distribution:**

| Check | Requirement | FAIL/WARN |
|-------|-------------|-----------|
| Hook in first line | Opening line stops the scroll | FAIL |
| Platform-appropriate length | Matches platform specs | WARN |
| Source article referenced | Links back or references original | WARN |
| CTA appropriate | Platform-appropriate action | WARN |

**Platform Length Guidelines:**

| Platform | Format | Max Length |
|----------|--------|------------|
| LinkedIn | Text post | 3,000 characters |
| LinkedIn | Carousel | 10 slides, 200 chars/slide |
| Twitter/X | Single | 280 characters |
| Twitter/X | Thread | 15 tweets max |
| Instagram | Caption | 2,200 characters |
| Instagram | Carousel | 10 slides |

**Output format:**
```
PASS: Distribution content validates for LinkedIn
FAIL: No hook — first line doesn't stop scroll → rewrite opening line
WARN: LinkedIn post is 3,400 characters → trim to under 3,000
WARN: No reference to source article → add link or mention
```

### 7.6 Content Type Quick Reference

Use this table to quickly identify which phases to run:

| Phase | Articles | Emails | Newsletters | Lead Magnets | Distribution |
|-------|:--------:|:------:|:-----------:|:------------:|:------------:|
| 1. Universal Rules | Full | Partial | Partial | Minimal | Partial |
| 2. Client Profile | Full | Full | Full | Partial | Full |
| 3. Human Quality | Full | Full | Full | Skip | Partial |
| 4. Schema | Full | Skip | Skip | Skip | Partial |
| 5. Readability | Full | Skip | Optional | Skip | Skip |
| 6. Pillar Consistency | Full | Skip | Skip | Skip | Skip |
| 7. Content Type | Skip | Email | Newsletter | Lead Magnet | Distribution |

---

## Output Format

After all phases, output the validation result:

```markdown
## Validation Result: [PASS/FAIL]

**Article:** [filename or "provided content"]
**Primary Keyword:** [keyword]
**Word Count:** [count]
**Client Profile:** [used/not provided]

---

### FAIL Issues (must fix before publishing)

1. **Line 23:** "color" - US spelling → use "colour"
2. **Line 45:** "leverage" - banned AI word → use "use" or rephrase
3. **Line 67:** "In today's digital age" - banned AI phrase → rewrite opening
4. **Missing:** Primary keyword not in first 150 words → add to opening
5. **Structure:** Word count is 1,234 → add 266+ words to reach 1,500 minimum

---

### WARN Issues (should fix for quality)

1. **Line 89:** No contraction used → "it is" could be "it's"
2. **Lines 45-67:** 4 consecutive sentences start with "The" → vary openers
3. **Voice:** No author opinions expressed → add perspective
4. **Examples:** All examples generic → add specific named examples

---

### SEO Checklist

- [x] Primary keyword in first 150 words
- [x] Primary keyword in H2
- [ ] Word count 1,500+ (currently 1,234)
- [x] Meta title under 60 chars
- [x] Meta description 140-160 chars
- [x] 3+ internal links
- [x] Single H1

---

### Schema Validation

- [x] All required frontmatter fields present
- [x] Slug format valid (lowercase, hyphenated, contains keyword)
- [ ] word_count matches actual (frontmatter says 2,500, actual is 1,847)
- [x] keyword_density matches calculated
- [x] secondary_keywords found in content

---

### Readability Metrics

| Metric | Score | Target | Status |
|--------|-------|--------|--------|
| Flesch-Kincaid Grade | 7.2 | 6-8 | ✓ |
| Flesch Reading Ease | 65 | 60-70 | ✓ |
| Avg Sentence Length | 16 words | <20 | ✓ |
| Longest Sentence | 34 words | <40 | ✓ |

---

### Pillar Consistency

- [x] Article aligns with assigned angle "Speed + Simplicity"
- [x] Internal links reference pillar articles
- [x] Messaging consistent with positioning.md
- [x] No contradictions with other pillar content

---

### Suggested Pattern for common-mistakes.md

*Only shown if same issue appears 3+ times across content*

```markdown
### [Issue Name]

**Pattern:** [What to look for]

**Why it fails:** [Explanation]

**Fix:** [How to correct]
```
```

---

## Failure Workflow

When validation returns FAIL:

### Auto-Retry (once)

1. List all FAIL issues with specific fixes
2. Apply fixes to content
3. Re-run validation
4. If PASS → ready to publish
5. If still FAIL → escalate

### Escalation to Human Review

If auto-retry fails:

1. Output full list of remaining issues
2. Flag content for human review
3. Include recommendations for manual fixes
4. Do not publish until human clears

### Pattern Suggestion

If the same issue appears 3+ times in content (or across multiple pieces):

1. Suggest addition to `.claude/rules/common-mistakes.md`
2. Use the template format from that file
3. Human approves/rejects addition
4. Future content avoids the pattern

---

## How this connects to other skills

**Input from:**
- **direct-response-copy** → Provides `04-final.md` to validate

**Output to:**
- **PASS** → Content ready to publish
- **FAIL** → Back to direct-response-copy for fixes

**Feeds:**
- **common-mistakes.md** → Pattern suggestions when recurring issues detected

**The flow:**
```
04-final.md → validate-content → PASS → publish
                              → FAIL → fix → re-validate
                                     → still FAIL → human review
```

---

## Quick Reference: What Fails, What Warns

### Automatic FAIL (must fix)

| Category | Issue | Applies To |
|----------|-------|------------|
| UK English | Any US spelling | All content types |
| AI Words | Any of 53 banned words | Articles, Emails, Newsletters, Distribution |
| AI Phrases | Any banned phrase | Articles, Emails, Newsletters |
| AI Patterns | Repetitive starts, rule of threes, hedging overload | Articles, Emails, Newsletters |
| SEO | Missing keyword placement, under 1,500 words, bad meta data | Articles only |
| SEO | Multiple H1s, no internal links | Articles only |
| Client | Wrong terminology, avoided words/topics | All content types |
| Schema | Missing required frontmatter fields | Articles only |
| Schema | Invalid slug format (uppercase, underscores, too long, missing keyword) | Articles only |
| Schema | word_count or keyword_density mismatch with content | Articles only |
| Readability | Flesch-Kincaid Grade > 14 (too complex) | Articles only |
| Readability | Sentence over 40 words | Articles only |
| Pillar | Article contradicts other pillar content | Articles only |
| Pillar | No internal links to pillar articles | Articles only |
| Emails | Multiple competing CTAs in single email | Emails only |
| Newsletters | No hook in first 2 sentences | Newsletters only |
| Lead Magnets | No bridge to paid offer | Lead Magnets only |
| Distribution | No hook in first line | Distribution only |

### Automatic WARN (should fix)

| Category | Issue | Applies To |
|----------|-------|------------|
| Contractions | Formal "it is" instead of "it's" | All content types |
| Rhythm | Monotonous sentence length | Articles, Emails, Newsletters |
| Voice | No personal opinions | Articles, Newsletters |
| Examples | Generic instead of specific | Articles, Newsletters |
| Voice | Passive voice overuse | Articles, Emails |
| Schema | Missing external_citations (recommended for E-E-A-T) | Articles only |
| Readability | Flesch-Kincaid Grade 10-14 (consider simplifying) | Articles only |
| Readability | Average sentence length > 20 words | Articles only |
| Pillar | Angle emphasis differs from positioning.md | Articles only |
| Pillar | Links to content outside pillar | Articles only |
| Emails | Subject line over 50 characters | Emails only |
| Emails | No preview text | Emails only |
| Newsletters | No scannable formatting (headers, bullets) | Newsletters only |
| Newsletters | No CTA present | Newsletters only |
| Lead Magnets | Quick win vague or missing | Lead Magnets only |
| Distribution | Platform length exceeded | Distribution only |
| Distribution | No reference to source article | Distribution only |

---

## The test

Before marking validation complete, verify:

1. **All FAIL issues have line numbers and specific fixes**
2. **WARN issues are genuinely optional improvements**
3. **SEO checklist is accurate (counts verified)**
4. **Client profile rules were checked (if provided)**
5. **Human quality assessment completed**
6. **Schema validation completed (all frontmatter fields checked)**
7. **Slug format validated (lowercase, hyphenated, keyword present, under 50 chars)**
8. **SEO metrics verified (word_count and keyword_density match actual content)**
9. **Readability metrics calculated and reported (Flesch-Kincaid scores)**
10. **Pillar consistency checked (if positioning.md exists)**
11. **Content type variations applied (emails, newsletters, lead magnets, distribution)**
12. **Auto-retry workflow triggered if FAIL**

A good validation catches issues before readers do. A great validation explains exactly how to fix them.

---

## Non-Interactive Mode

When invoked by a sub-agent (see [Sub-Agent Rules](../../rules/sub-agent-rules.md)), this skill runs in non-interactive mode.

### What Changes

| Behaviour | Interactive | Non-Interactive |
|-----------|-------------|-----------------|
| Clarifying questions | Asked when needed | Never asked |
| Confirmation requests | May ask "Continue?" | Proceeds without confirmation |
| Summary output | May abbreviate for clarity | FULL output required |
| User suggestions | May recommend actions | Returns data only |

### Critical: Full Output Required

**In non-interactive mode, return the COMPLETE validation output. Do not abbreviate.**

The main session needs:
- Every FAIL issue with line numbers and specific fixes
- Every WARN issue with suggestions
- Full SEO checklist with actual values
- Complete readability metrics table
- Brand voice alignment assessment

**Why:** The main session uses this output to decide whether to retry, escalate, or proceed. Abbreviated output forces re-validation or direct file reading, defeating sub-agent isolation.

### Requirements for Non-Interactive

The sub-agent prompt must include:

- [ ] Article path to validate
- [ ] Client profile path (for brand voice)
- [ ] Primary keyword (for SEO checks)
- [ ] Content type (Article/Email/Newsletter/Distribution)

### Return Format

In non-interactive mode, return the FULL validation output format:

```
## Validation Result: [PASS/FAIL]

**Article:** [filename]
**Primary Keyword:** [keyword]
**Word Count:** [actual count]
**Client Profile:** [path]

---

### FAIL Issues (must fix before publishing)

[Every FAIL issue with line number and fix]

---

### WARN Issues (should fix for quality)

[Every WARN issue with suggestion]

---

### SEO Checklist

[Full checklist with actual values]

---

### Schema Validation

[Full schema check results]

---

### Readability Metrics

[Complete metrics table]

---

### Brand Voice

- Aligned: Yes | No
- Tone Match: [assessment]
- Terminology: [any violations]
- Notes: [any concerns]

---

### Pillar Consistency (if checked)

[Full pillar consistency results]
```

### Missing Context Handling

If required context is missing:

1. Return FAIL status immediately
2. List missing context in the Issues section
3. Do NOT attempt to guess or validate partially

Example:
```
## Validation Result: FAIL

**Article:** [path]
**Primary Keyword:** [unknown]

---

### FAIL Issues

1. **Missing Context:** Client profile not found at provided path — cannot validate brand voice
2. **Missing Context:** Primary keyword not provided — cannot validate SEO requirements

---

### Notes

Main session should verify file paths and parameters before re-spawning.
```

---

*Reference: `rules/sub-agent-rules.md` for complete sub-agent orchestration guidelines.*
