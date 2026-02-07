---
name: validate-content
description: "Check content against universal rules and client profile, outputting PASS/FAIL with line-specific issues. Use after /direct-response-copy to validate final content before publishing. Triggers on: validate this content, check this article, validate content, content check, is this ready to publish, check for AI words. Outputs validation result with specific fixes needed."
---

# Content Validation Workflow

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

## When to validate

Run validation after `/seo-content`, after `/direct-response-copy`, and before publishing. These three checkpoints are mandatory. Optional: after completing a pillar, when revisiting old content, after batch edits.

---

## The workflow

```
LOAD CONTENT → PHASE 1: UNIVERSAL RULES → PHASE 2: CLIENT PROFILE → PHASE 3: HUMAN QUALITY → PHASE 4: SCHEMA VALIDATION → PHASE 5: READABILITY METRICS → PHASE 6: PILLAR CONSISTENCY → OUTPUT VERDICT
```

---

## Phase 1: Universal Rules Check

Check against all FAIL conditions in `.claude/rules/universal-rules.md`.

### 1.1 UK English Spelling Scan

Scan for American spellings per `universal-rules.md` Rule 1 (patterns 1-3) and `references/uk-english-patterns.md` (patterns 4-8). Any found = FAIL.

**Output format:**
```
FAIL: Line 23: "color" - US spelling → use "colour"
```

### 1.2 Banned AI Words Scan (53 words)

Scan for all 53 banned AI words per `universal-rules.md` Rule 2. Any found = FAIL.

**Output format:**
```
FAIL: Line 45: "leverage" - banned AI word → use "use" or rephrase
FAIL: Line 67: "comprehensive" - banned AI word → use "complete" or "full"
```

### 1.3 Banned AI Phrases Scan

Scan for all banned AI phrases per `universal-rules.md` Rule 3 (opening cliches, throat-clearing, padding, meta-commentary, desperate hooks). Any found = FAIL.

**Output format:**
```
FAIL: Line 12: "In today's digital age" - banned AI phrase → cut or rewrite opening
FAIL: Line 156: "In conclusion" - banned AI phrase → just start concluding
```

### 1.4 AI Pattern Detection

Scan for structural AI patterns per `universal-rules.md` Rule 4 (repetitive sentence starts, rule of threes, hedging overload, empty transitions, artificial balance) and Rule 4b (em dashes). Any found = FAIL.

**Output format:**
```
FAIL: Lines 34-36: 3 consecutive sentences start with "This" - vary sentence openers
FAIL: Lines 45-67: Perfect "First... Second... Third..." structure - vary the pattern
FAIL: Content has 7% hedging words (might, could, perhaps) - make definitive statements
```

### 1.5 SEO Requirements Check

Check all SEO requirements per `universal-rules.md` Rule 5 (keyword placement, content length, meta data, links, structure, H1 format) and Rule 5a (internal link format). Missing requirements = FAIL.

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
- General blog: Grade 6-8 (easy to read, wide audience)
- B2B content: Grade 8-10 (professional but accessible)
- Technical: Grade 10-12 (expert audience acceptable)

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
- 90-100: Very Easy (5th grade)
- 80-89: Easy (6th grade)
- 70-79: Fairly Easy (7th grade)
- 60-69: Standard (8th-9th grade)
- 50-59: Fairly Difficult (10th-12th grade)
- 30-49: Difficult (College)
- 0-29: Very Difficult (College graduate)

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

- Flesch-Kincaid Grade: [score] (target: [range]) [status]
- Flesch Reading Ease: [score] (target: 60-70) [status]
- Avg Sentence Length: [words] (target: <20) [status]
- Longest Sentence: [words] (target: <40) [status]

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

- **Article** — In `/articles/` folder, has SEO frontmatter, 1,500+ words
- **Email** — In email sequence file, has subject line, part of sequence
- **Newsletter** — In newsletter folder, has hook/body/CTA structure
- **Lead Magnet** — Conceptual document, bridge to paid offer
- **Distribution** — In `/distribution/` folder, platform-specific format

### 7.2 Email Sequences

Applicable rules: see `universal-rules.md` Scope section (Emails column). Skip SEO, Pillar Consistency, External Citations.

**Additional Checks for Emails:**
- Subject line length: under 50 characters (WARN)
- Preview text: present and under 90 characters (WARN)
- CTA count: one primary CTA per email (FAIL if multiple competing CTAs)
- CTA clarity: clear, specific action (WARN)
- Personalisation: uses subscriber name/context where appropriate (WARN)

**Output format:**
```
PASS: Email validates against applicable rules
WARN: Subject line is 62 characters → shorten to under 50
WARN: No preview text → add preview text under 90 characters
FAIL: Email has 3 different CTAs → use one primary CTA
```

### 7.3 Newsletters

Applicable rules: see `universal-rules.md` Scope section (Newsletters column). Skip SEO, Pillar Consistency.

**Additional Checks for Newsletters:**
- Hook present: opening grabs attention in first 2 sentences (FAIL)
- Scannable format: uses headers, bullets, or bold for scanning (WARN)
- CTA present: at least one CTA, can be soft (WARN)
- Value delivery: provides standalone value before any pitch (WARN)
- Length appropriate: matches newsletter format (WARN)

**Format-Specific Length Guidelines:**
- Deep-Dive: 1,000-2,000 words
- News Briefing: 500-800 words
- Curated Links: 300-600 words + links
- Personal Essay: 800-1,500 words
- Roundup: 600-1,200 words

**Output format:**
```
PASS: Newsletter validates against applicable rules
FAIL: No hook — first 2 sentences don't grab attention → rewrite opening
WARN: Wall of text — no headers or bullets → add scannable formatting
WARN: No CTA — add at least a soft CTA (reply, share, follow)
```

### 7.4 Lead Magnets (Concepts)

Lead magnet concepts are validated lightly since they're planning documents, not final content. Applicable rules: see `universal-rules.md` Scope section (Lead Magnets column). Only UK English and Brand Voice apply.

**Additional Checks for Lead Magnets:**
- Bridge to paid offer: clear connection to what you're selling (FAIL)
- Quick win defined: specific transformation promise (WARN)
- Hook clarity: why someone would download is clear (WARN)
- Format appropriate: format matches audience and topic (WARN)

**Output format:**
```
PASS: Lead magnet concept validates
FAIL: No bridge to paid offer — unclear how this leads to sale → define connection
WARN: Quick win vague — "learn about X" isn't a transformation → specify outcome
WARN: Hook unclear — why would someone download this? → sharpen the promise
```

### 7.5 Distribution Content

Applicable rules: see `universal-rules.md` Scope section (Distribution column). Skip Banned Phrases, AI Patterns, SEO, Pillar Consistency, External Citations.

**Additional Checks for Distribution:**
- Hook in first line: opening line stops the scroll (FAIL)
- Platform-appropriate length: matches platform specs (WARN)
- Source article referenced: links back or references original (WARN)
- CTA appropriate: platform-appropriate action (WARN)

**Platform Length Guidelines:**
- LinkedIn text post: 3,000 characters
- LinkedIn carousel: 10 slides, 200 chars/slide
- Twitter/X single: 280 characters
- Twitter/X thread: 15 tweets max
- Instagram caption: 2,200 characters
- Instagram carousel: 10 slides

**Output format:**
```
PASS: Distribution content validates for LinkedIn
FAIL: No hook — first line doesn't stop scroll → rewrite opening line
WARN: LinkedIn post is 3,400 characters → trim to under 3,000
WARN: No reference to source article → add link or mention
```

### 7.6 Content Type Quick Reference

Which phases to run per content type:

**Articles:** All phases (1-6 full).

**Emails:** Phase 1 partial (UK English, Banned Words, Banned Phrases, AI Patterns, Em Dashes), Phase 2 full, Phase 3 full, Phase 7 Email checks. Skip: SEO, Schema, Readability, Pillar Consistency.

**Newsletters:** Phase 1 partial (UK English, Banned Words, Banned Phrases, AI Patterns, Em Dashes), Phase 2 full, Phase 3 full, Phase 5 optional, Phase 7 Newsletter checks. Skip: SEO, Schema, Pillar Consistency.

**Lead Magnets:** Phase 1 minimal (UK English, Em Dashes only), Phase 2 partial, Phase 7 Lead Magnet checks. Skip: Banned Words/Phrases, AI Patterns, SEO, Schema, Readability, Human Quality, Pillar Consistency.

**Distribution:** Phase 1 partial (UK English, Banned Words, Em Dashes), Phase 2 full, Phase 3 partial, Phase 4 partial, Phase 7 Distribution checks. Skip: Banned Phrases, AI Patterns, Readability, Pillar Consistency.

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
3. **Missing:** Primary keyword not in first 150 words → add to opening
4. **Structure:** Word count is 1,234 → add 266+ words to reach 1,500 minimum

---

### WARN Issues (should fix for quality)

1. **Line 89:** No contraction used → "it is" could be "it's"
2. **Lines 45-67:** 4 consecutive sentences start with "The" → vary openers
3. **Voice:** No author opinions expressed → add perspective

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

- Flesch-Kincaid Grade: [score] (target: [range]) [status]
- Flesch Reading Ease: [score] (target: 60-70) [status]
- Avg Sentence Length: [words] (target: <20) [status]
- Longest Sentence: [words] (target: <40) [status]

---

### Pillar Consistency

- [x] Article aligns with assigned angle
- [x] Internal links reference pillar articles
- [x] Messaging consistent with positioning.md
- [x] No contradictions with other pillar content

---

### Suggested Pattern for common-mistakes.md

*Only shown if same issue appears 3+ times across content*
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

If the same issue appears 3+ times in content (or across multiple pieces), suggest addition to `.claude/references/common-mistakes.md`.

---

## Skill connections

**Input from:** `/direct-response-copy` provides article to validate
**Output to:** PASS → publish, FAIL → back for fixes
**Feeds:** `common-mistakes.md` with recurring patterns

---

## Quick Reference: What Fails, What Warns

### Automatic FAIL (must fix)

- UK English: Any US spelling (All content types)
- AI Words: Any of 53 banned words (Articles, Emails, Newsletters, Distribution)
- AI Phrases: Any banned phrase (Articles, Emails, Newsletters)
- AI Patterns: Repetitive starts, rule of threes, hedging overload (Articles, Emails, Newsletters)
- SEO: Missing keyword placement, under 1,500 words, bad meta data (Articles only)
- SEO: Multiple H1s, no internal links (Articles only)
- Client: Wrong terminology, avoided words/topics (All content types)
- Schema: Missing required frontmatter fields (Articles only)
- Schema: Invalid slug format (uppercase, underscores, too long, missing keyword) (Articles only)
- Schema: word_count or keyword_density mismatch with content (Articles only)
- Readability: Flesch-Kincaid Grade > 14 (too complex) (Articles only)
- Readability: Sentence over 40 words (Articles only)
- Pillar: Article contradicts other pillar content (Articles only)
- Pillar: No internal links to pillar articles (Articles only)
- Emails: Multiple competing CTAs in single email (Emails only)
- Newsletters: No hook in first 2 sentences (Newsletters only)
- Lead Magnets: No bridge to paid offer (Lead Magnets only)
- Distribution: No hook in first line (Distribution only)

### Automatic WARN (should fix)

- Contractions: Formal "it is" instead of "it's" (All content types)
- Rhythm: Monotonous sentence length (Articles, Emails, Newsletters)
- Voice: No personal opinions (Articles, Newsletters)
- Examples: Generic instead of specific (Articles, Newsletters)
- Voice: Passive voice overuse (Articles, Emails)
- Schema: Missing external_citations (recommended for E-E-A-T) (Articles only)
- Readability: Flesch-Kincaid Grade 10-14 (consider simplifying) (Articles only)
- Readability: Average sentence length > 20 words (Articles only)
- Pillar: Angle emphasis differs from positioning.md (Articles only)
- Pillar: Links to content outside pillar (Articles only)
- Emails: Subject line over 50 characters (Emails only)
- Emails: No preview text (Emails only)
- Newsletters: No scannable formatting (headers, bullets) (Newsletters only)
- Newsletters: No CTA present (Newsletters only)
- Lead Magnets: Quick win vague or missing (Lead Magnets only)
- Distribution: Platform length exceeded (Distribution only)
- Distribution: No reference to source article (Distribution only)

---

## Non-Interactive Mode

When invoked by an agent (see `rules/workflow.md`), this skill runs in non-interactive mode.

### What Changes

- **Clarifying questions:** Never asked (proceeds without)
- **Confirmation requests:** Proceeds without confirmation
- **Summary output:** FULL output required (never abbreviated)
- **User suggestions:** Returns data only (no action recommendations)

### Critical: Full Output Required

In non-interactive mode, return the COMPLETE validation output as defined in the Output Format section above. Do not abbreviate.

The main session needs every FAIL issue with line numbers, every WARN issue, full SEO checklist, complete readability metrics, and brand voice assessment. Abbreviated output forces re-validation, defeating agent isolation.

### Requirements for Non-Interactive

The agent prompt must include:

- [ ] Article path to validate
- [ ] Client profile path (for brand voice)
- [ ] Primary keyword (for SEO checks)
- [ ] Content type (Article/Email/Newsletter/Distribution)

### Missing Context Handling

If required context is missing, return FAIL immediately with missing context listed in the Issues section. Do NOT attempt to guess or validate partially.

Example:
```
## Validation Result: FAIL

**Article:** [path]
**Primary Keyword:** [unknown]

---

### FAIL Issues

1. **Missing Context:** Client profile not found at provided path
2. **Missing Context:** Primary keyword not provided

---

### Notes

Main session should verify file paths and parameters before re-spawning.
```

---

*Reference: `rules/workflow.md` for complete agent orchestration guidelines.*
