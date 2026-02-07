# Universal Rules

Rules that apply to ALL content. Violations result in FAIL (rejected) or WARN (flagged).

---

## Scope

Not all rules apply to all content types. Use this matrix to determine which checks run for each content type.

- **1. UK English:** Articles, Emails, Newsletters, Lead Magnets, Distribution
- **2. Banned AI Words:** Articles, Emails, Newsletters, Distribution
- **3. Banned AI Phrases:** Articles, Emails, Newsletters
- **4. AI Patterns:** Articles, Emails, Newsletters
- **4b. No Em Dashes:** Articles, Emails, Newsletters, Lead Magnets, Distribution
- **5. SEO Requirements:** Articles only
- **5a. Internal Link Format:** Articles, Emails, Newsletters
- **6. External Citations:** Articles (optional for Emails, Newsletters)
- **Brand Voice:** Articles, Emails, Newsletters, Lead Magnets, Distribution

**Legend:**
- **✓** — Rule applies, violations result in FAIL or WARN as defined
- **-** — Rule does not apply to this content type
- **Optional** — Recommended but not required

**Content Type Definitions:**
- **Articles** — SEO blog posts, pillar guides, supporting articles
- **Emails** — Welcome sequences, nurture emails, conversion emails, launch sequences
- **Newsletters** — Regular newsletter editions (deep-dive, roundup, curated, news briefing)
- **Lead Magnets** — Conceptual documents (checklists, swipe files, templates, guides)
- **Distribution** — Social media content (LinkedIn, Twitter/X, Instagram, TikTok)

---

## FAIL Conditions

Content is **rejected** if any of these rules are violated.

---

### 1. UK English

Use British spelling throughout. American spelling = automatic fail.

---

#### Pattern 1: -our / -or

UK uses **-our**, US uses **-or**.

- colour (not color)
- behaviour (not behavior)
- favourite (not favorite)
- honour (not honor)
- favour (not favor)
- humour (not humor)
- labour (not labor)
- harbour (not harbor)
- neighbour (not neighbor)
- flavour (not flavor)
- savour (not savor)
- vapour (not vapor)
- odour (not odor)
- vigour (not vigor)
- rumour (not rumor)

---

#### Pattern 2: -ise / -ize

UK prefers **-ise**, US uses **-ize**.

- recognise (not recognize)
- organise (not organize)
- realise (not realize)
- analyse (not analyze)
- memorise (not memorize)
- specialise (not specialize)
- prioritise (not prioritize)
- apologise (not apologize)
- customise (not customize)
- summarise (not summarize)
- optimise (not optimize)
- emphasise (not emphasize)
- criticise (not criticize)
- capitalise (not capitalize)
- categorise (not categorize)
- minimise (not minimize)
- maximise (not maximize)

---

#### Pattern 3: -re / -er

UK uses **-re**, US uses **-er**.

- centre (not center)
- metre (not meter)
- theatre (not theater)
- fibre (not fiber)
- litre (not liter)
- calibre (not caliber)
- sombre (not somber)
- lustre (not luster)
- spectre (not specter)
- manoeuvre (not maneuver)

---

Patterns 4-8, Miscellaneous, and Directional Words: see [UK English Extended Patterns](../references/uk-english-patterns.md).

---

### 2. Banned AI Words

53 banned words across 6 categories. See [Banned Words & Phrases](../references/banned-words-phrases.md#rule-2-banned-ai-words).

---

### 3. Banned AI Phrases

Banned opening cliches, throat-clearing, padding, meta-commentary, and desperate hooks. See [Banned Words & Phrases](../references/banned-words-phrases.md#rule-3-banned-ai-phrases).

---

### 4. AI Patterns

Structural tells: repetitive starts, rule of threes, hedging, empty transitions, artificial balance. See [Banned Words & Phrases](../references/banned-words-phrases.md#rule-4-ai-patterns).

---

### 4b. No Em Dashes

Em dashes are an AI fingerprint. Never use them; restructure instead. See [Banned Words & Phrases](../references/banned-words-phrases.md#rule-4b-no-em-dashes).

---

### 5. SEO Requirements

Technical requirements for search optimisation.

**Keyword Placement:**
- [ ] Primary keyword in first 150 words
- [ ] Primary keyword in at least one H2
- [ ] Primary keyword density: 1-2% (not stuffed)

**Content Length:**
- [ ] Minimum 1,500 words
- [ ] No maximum, but stay focused

**Meta Data:**
- [ ] Meta title: under 60 characters
- [ ] Meta description: 140-160 characters
- [ ] Both include primary keyword

**Links:**
- [ ] At least 3 internal links
- [ ] External links to authoritative sources where relevant
- [ ] No broken links

**Structure:**
- [ ] One H1 only (the title)
- [ ] H1 contains primary keyword AND a hook (not keyword alone)
- [ ] Logical H2/H3 hierarchy
- [ ] No duplicate heading text (each H1/H2/H3 must be unique)
- [ ] Short paragraphs (3-4 sentences max)

**H1 Format Examples:**

- ✗ "ADHD Sleep Problems" → ✓ "Why Your ADHD Brain Won't Let You Sleep"
- ✗ "Email Marketing Guide" → ✓ "Email Marketing Guide: Send Less, Sell More"
- ✗ "Content Strategy" → ✓ "The Content Strategy That Built a 7-Figure Business"
- ✗ "SEO Best Practices" → ✓ "SEO Best Practices the Experts Actually Use"

**Why keyword-only H1s fail:**
- Boring (no reason to click)
- Generic (everyone ranks for the same title)
- No differentiation in search results
- Misses the hook that drives engagement

---

### 5a. Internal Link Format

Internal links must use the article's frontmatter `slug` value, not file paths or directory structures.

**Correct Format:** `/{slug}`

The URL should be the exact slug from the target article's frontmatter, with a leading slash. No directories, no file extensions, no number prefixes.

**Examples:**

- ✓ `/why-generic-calming-apps-fail-nd-children` (not `/app-comparisons/articles/01-...` which uses directory structure)
- ✓ `/adhd-bedtime-routine` (not `/adhd-sleep/articles/02-adhd-bedtime-routine.md` which uses file path with extension)
- ✓ `/calming-sounds-adhd` (not `/01-calming-sounds-adhd` which includes file number prefix)

**Validation Checklist:**
- [ ] Link URL is `/{slug}` format (single path segment after leading slash)
- [ ] Slug matches target article's frontmatter `slug` field exactly
- [ ] No file extensions (`.md`)
- [ ] No directory structure (`/pillar/articles/...`)
- [ ] No file number prefixes (`/01-...`)

**Why this matters:**

These articles will be uploaded to a CMS where URLs are defined by the slug, not the local file structure. Links using file paths will break in production.

---

### 6. External Citations (E-E-A-T)

Citations build trust and demonstrate expertise. Proper sourcing is a Google ranking factor.

**Citation Format:**

Use this format for all external citations:

> [Author/Organisation], [Year]: [hyperlinked title](URL)

**Examples:**
- Google, 2023: [Search Quality Evaluator Guidelines](https://example.com)
- NHS, 2024: [Mental Health Statistics](https://example.com)
- Dr. Sarah Chen, 2023: [The Future of Remote Work](https://example.com)

**Citation Checklist:**
- [ ] Every citation includes a working hyperlink
- [ ] Author or organisation name is present
- [ ] Publication year is included
- [ ] Link opens in context (not broken or paywalled without note)

**Minimum Requirements:**
- [ ] At least 2 external citations per 1,500 words
- [ ] Citations support claims, not just decorate content
- [ ] No citation to the same domain more than twice per article

---

## WARN Conditions

Content is **flagged** but not rejected. Fix if possible.

---

### Missing Contractions

Formal writing sounds robotic. Use contractions naturally.

---

### Monotonous Sentence Length

Vary your rhythm. Mix short punchy sentences with longer explanatory ones.

---

### No Personal Voice

Content should feel like a human wrote it. Include opinions, share experiences, take positions.

---

### No Specific Examples

Vague content doesn't convert. Use specific numbers, percentages, and concrete examples.

---

### Passive Voice Overuse

Active voice is stronger. Prefer active constructions over passive ones.
