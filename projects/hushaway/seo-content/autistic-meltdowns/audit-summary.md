# Pillar Audit: Autistic Meltdowns

**Date:** 2026-02-05
**Articles:** 7
**Total Word Count:** 16,586
**Status:** PARTIAL

---

## Article Results

| # | Article | Validation | Links | Citations | Consistency | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | understanding-autism-meltdowns | FAIL (1) | FAIL | PASS | PASS | FAIL |
| 02 | sounds-to-play-autism-meltdown | FAIL (8) | FAIL | PASS | PASS | FAIL |
| 03 | after-school-autism-meltdown-why | FAIL (7) | FAIL | FAIL (1 broken URL) | PASS | FAIL |
| 04 | helping-child-recover-after-meltdown | FAIL (7) | FAIL | PASS | PASS | FAIL |
| 05 | understanding-meltdown-vs-shutdown | FAIL (5) | FAIL | PASS | PASS | FAIL |
| 06 | preventing-autism-meltdowns-warning-signs | FAIL (1) | FAIL | PASS | PASS | FAIL |
| 07 | complete-guide-autism-meltdowns-uk-parents | PASS | FAIL | PASS | PASS | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Incorrect Internal Link Format (Rule 5a) | 51+ | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Broken Internal Links (wrong slug) | 12 | 0 | 01, 02, 03, 04, 05 |
| Broken Citation URL (404) | 1 | 0 | 03 |
| Citation URL Bot-Blocking (403) | 0 | 5 | 01, 02, 04, 06, 07 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links (wrong slug) | 12 | FAIL | 01, 02, 03, 04, 05 |
| Incorrect URL format | 51 | FAIL | 01, 02, 03, 04, 05, 06, 07 |
| Stale placeholders | 0 | PASS | - |
| Valid placeholders | 0 | INFO | - |

### Two Format Violation Patterns

1. **Pattern A:** `/autistic-meltdowns/{slug}` (removes `articles/` but keeps pillar prefix) - Articles 01-05
2. **Pattern B:** `/autistic-meltdowns/articles/{filename}` (full directory structure) - Articles 06, 07

### Broken Slug References

Several links use shortened or incorrect slug names instead of exact frontmatter slugs:

| Incorrect Reference | Correct Slug |
|-------------------|-------------|
| `02-what-to-play-during-meltdown` | `sounds-to-play-autism-meltdown` |
| `04-meltdown-recovery` | `helping-child-recover-after-meltdown` |
| `03-after-school-meltdowns` | `after-school-autism-meltdown-why` |
| `06-preventing-meltdowns` | `preventing-autism-meltdowns-warning-signs` |
| `05-meltdown-vs-shutdown` | `understanding-meltdown-vs-shutdown` |

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 0 | - |
| Inbound | 0 | - |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide to Supporting | 6/6 | PASS |
| Supporting to Guide | 5/6 | FAIL |

**Missing links TO pillar guide:**
- 02-what-to-play-during-meltdown.md: No link to `/complete-guide-autism-meltdowns-uk-parents`

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 7 | autism.org.uk, pubmed x2, frontiersin x3, ambitiousaboutautism |
| Bot-Blocking (403) | 5 | NCBI PMC x3, Wiley, ScienceDirect, AAP |
| Broken (404) | 0 | Fixed: frontiersin URL replaced with PMC8992925 (Article 03) |
| Timeout | 0 | - |

**Broken URL Details:**
- Article 03 (after-school-autism-meltdown-why): FIXED. Replaced with Mantzalas et al., 2022: "What Is Autistic Burnout?" (https://pmc.ncbi.nlm.nih.gov/articles/PMC8992925/)

**403 URLs (likely bot-blocking, not broken):**
- `ncbi.nlm.nih.gov/pmc/articles/PMC7082250/` (Article 06)
- `ncbi.nlm.nih.gov/pmc/articles/PMC7084183/` (Articles 04, 07)
- `ncbi.nlm.nih.gov/pmc/articles/PMC6493207/` (Article 02)
- `onlinelibrary.wiley.com/doi/10.1002/aur.2867` (Article 06)
- `sciencedirect.com/science/article/abs/pii/S1750946719300285` (Article 04)
- `publications.aap.org/pediatrics/article/145/1/e20193447/36917` (Article 01)

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| None found | - | - | - |

All articles use consistent terminology across the pillar.

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| None found | - | - | - |

No conflicting statistics or recommendations detected across articles.

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Neurological foundation | Strong |
| 02 | Direct answer to "what to play" | Strong |
| 03 | Masking debt and after-school pattern | Strong |
| 04 | Recovery focus (competitor gap) | Strong |
| 05 | Meltdown vs shutdown differentiation | Strong |
| 06 | Cumulative triggers, prevention as daily regulation | Strong |
| 07 | Comprehensive pillar guide | Strong |

All articles strongly aligned with their assigned positioning angles.

---

## Patterns (3+ occurrences)

### Internal Link Format Violation (Rule 5a)
- Articles: All 7
- Count: 51+ instances
- Already in common-mistakes.md: Yes (from App Comparisons audit)
- Recommend for common-mistakes.md: No (already tracked)

---

## Summary

**Primary Issue:** All articles use incorrect internal link format (directory structure instead of `/{slug}`). This is the same systematic issue found in all other audited pillars.

**Content Quality:** Excellent. All 7 articles demonstrate:
- Strong positioning alignment with assigned angles
- Consistent terminology across the pillar
- No conflicting claims or statistics
- Strong brand voice alignment (warm, parent-to-parent)
- No banned AI words or patterns
- UK English throughout

**Issues Requiring Manual Review:**
1. **Citation URL (FAIL):** Article 03 has 1 broken URL (Frontiers fpsyg.2021.767782 returns 404)
2. **Missing bidirectional link:** Article 02 missing link to pillar guide
3. **Internal link format:** 51+ violations across all 7 articles (auto-fixable)
4. **Broken slug references:** 12 links using wrong slug names (auto-fixable)
