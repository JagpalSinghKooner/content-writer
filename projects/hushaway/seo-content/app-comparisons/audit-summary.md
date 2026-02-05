# Pillar Audit: App Comparisons

**Date:** 2026-02-05
**Articles:** 7
**Total Word Count:** 21,072
**Status:** PASS (after fix)
**Mode:** Validate + Auto-Fix

---

## Article Results

| # | Article | Validation | Links | Citations | Frontmatter | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | why-generic-calming-apps-fail-nd-children | FAIL (8) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 02 | review-best-apps-autistic-children-uk | FAIL (3) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 03 | review-best-apps-adhd-children-uk | FAIL (6) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 04 | honest-comparison-moshi-vs-calm-vs-headspace-nd-kids | FAIL (8) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 05 | free-calming-apps-kids-uk | FAIL (3) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 06 | guide-screen-free-calming-alternatives-kids | FAIL (4) → PASS | FAIL → PASS | PASS | PASS | PASS |
| 07 | guide-best-calming-apps-nd-children-uk (pillar guide) | FAIL (19) → PASS | FAIL → PASS | PASS | PASS | PASS |

---

## Issue Categories

| Category | Pre-Fix FAILs | Post-Fix FAILs | Articles |
|----------|---------------|----------------|----------|
| Internal Link Format (Rule 5a) | 51 | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Banned AI Words | 0 | 0 | - |
| Em Dashes | 0 | 0 | - |
| UK Spelling | 0 | 0 | - |
| AI Patterns | 0 | 0 | - |
| Frontmatter Mismatch | 0 | 0 | - |

---

## Link Audit Summary

### Internal Links

| Check | Pre-Fix | Post-Fix | Articles |
|-------|---------|----------|----------|
| Incorrect URL format | 51 | 0 | All 7 → Fixed |
| Broken links | 0 | 0 | - |
| Stale placeholders | 0 | 0 | - |

### Cross-Pillar Links

Not audited in this run (single pillar audit).

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide → Supporting | 6/6 | PASS |
| Supporting → Guide | 6/6 | PASS |

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 6 | pubmed, autism.org.uk, bbc.co.uk, nhs.uk, nice.org.uk, smilingmind.com.au |
| Likely Bot Block (403) | 6 | adc.bmj.com, journals.sagepub.com, ncbi.nlm.nih.gov (x4) |
| Broken (404) | 2 | rcpch.ac.uk (articles 06, 07), understood.org (article 01) |
| Total Unique URLs | 14 | |

**Broken Citation Details:**
- `https://www.rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents` → 404 (used in articles 06, 07)
- `https://www.understood.org/articles/executive-function-disorder-adhd` → 404 (used in article 01)

**Domain Frequency Notes:**
- ncbi.nlm.nih.gov: 5 references in article 07, 4 in article 04 (but these are unique studies, acceptable for pillar guide/comparison)

---

## Frontmatter Accuracy

| Article | word_count | keyword_density | Keywords |
|---------|------------|-----------------|----------|
| 01 | PASS | PASS | PASS |
| 02 | PASS | PASS | PASS |
| 03 | PASS | PASS | PASS |
| 04 | PASS | PASS | PASS |
| 05 | PASS | PASS | PASS |
| 06 | PASS | PASS | PASS |
| 07 | PASS | PASS | PASS |

---

## Cross-Article Consistency

### Terminology Variations

No significant terminology variations detected. All articles consistently use:
- "neurodivergent" (not "special needs")
- "HushAway®" (with registration mark)
- "The Open Sanctuary" (capitalised)
- "ND" as abbreviation for neurodivergent
- UK English throughout

### Conflicting Claims

No conflicting claims detected across articles.

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | It's not your child, it's the design | Strong |
| 02 | Reviewed through an autism lens | Strong |
| 03 | Works WITH the ADHD brain | Strong |
| 04 | The fourth option you didn't know existed | Strong |
| 05 | Free AND ND-first | Strong |
| 06 | Screen-free without sacrificing depth | Strong |
| 07 | Designed FOR vs Adapted FOR (pillar guide) | Strong |

---

## Patterns (3+ occurrences)

### Internal Link Directory Format

- Articles: All 7
- Count: 51 total instances
- Pattern: Using `/app-comparisons/articles/{filename}` instead of `/{slug}`
- Fix applied: Replaced all with correct `/{slug}` format
- Recommend for common-mistakes.md: Yes

---

## Fix Results

| Article | Attempts | Final | Notes |
|---------|----------|-------|-------|
| 01-slug | 1 | PASS | Fixed 8 internal link format issues |
| 02-slug | 1 | PASS | Fixed 3 internal link format issues |
| 03-slug | 1 | PASS | Fixed 6 internal link format issues + 1 variant |
| 04-slug | 1 | PASS | Fixed 8 internal link format issues |
| 05-slug | 1 | PASS | Fixed 3 internal link format issues + 1 variant |
| 06-slug | 1 | PASS | Fixed 4 internal link format issues (missed in initial validation) |
| 07-slug | 1 | PASS | Fixed 19 internal link format issues |

### Escalated Issues (Manual Review Required)

**Citation Issues (cannot auto-fix):**
- Articles 06, 07: `https://www.rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents` returns 404
- Article 01: `https://www.understood.org/articles/executive-function-disorder-adhd` returns 404

**Slug Issue (editorial decision):**
- Article 05: Slug `free-calming-apps-kids-uk` is keyword-only. Consider changing to descriptive-first format like `guide-free-calming-apps-kids-uk`
