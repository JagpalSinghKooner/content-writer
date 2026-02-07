# SEO Requirements & Citations

Reference file for Rules 5, 5a, and 6. These rules apply primarily to articles (SEO blog posts, pillar guides, supporting articles).

---

## Rule 5: SEO Requirements

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

## Rule 5a: Internal Link Format

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

## Rule 6: External Citations (E-E-A-T)

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
