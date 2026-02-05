# Pillar Audit: App Comparisons

**Date:** 2026-02-05
**Articles:** 7
**Total Word Count:** 21,072
**Status:** FAIL

---

## Article Results

| # | Article | Validation | Links | Citations | Frontmatter | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | why-generic-calming-apps-fail-nd-children | FAIL (4) | FAIL (8) | FAIL (1) | PASS | FAIL |
| 02 | best-apps-autistic-children-uk | FAIL (4) | FAIL (6) | WARN (2) | PASS | FAIL |
| 03 | best-apps-adhd-children-uk | FAIL (6) | FAIL (6) | WARN (2) | PASS | FAIL |
| 04 | comparison-moshi-vs-calm-vs-headspace-nd-kids | FAIL (8) | FAIL (8) | WARN (2) | PASS | FAIL |
| 05 | free-calming-apps-kids-uk | FAIL (4) | FAIL (4) | WARN (1) | PASS | FAIL |
| 06 | guide-screen-free-calming-alternatives-kids | FAIL (5) | FAIL (5) | FAIL (1) | PASS | FAIL |
| 07 | complete-guide-best-calming-apps-nd-children-uk | FAIL (19) | FAIL (19+) | WARN (2) | PASS | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Incorrect Internal Link Format | 50+ | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Banned AI Words | 3 | 0 | 06 |
| Primary Keyword Not in H2 | 1 | 0 | 02 |
| Citation URL Broken (404) | 2 | 0 | 01, 06 |
| Citation URL Redirect (301/302) | 0 | 2 | 05, 02/04/06/07 |
| Citation URL Blocked (403) | 0 | 4 | 02, 03, 04, 07 |
| Terminology (dysregulation) | 0 | 7 | 01, 02, 03, 04, 05, 06, 07 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links | 0 | PASS | - |
| Incorrect URL format | 38 | FAIL | 01, 02, 03, 04, 05, 06, 07 |
| Stale placeholders | 0 | PASS | - |
| Valid placeholders | 0 | INFO | - |

**Root Cause:** All internal links use directory structure format (`/app-comparisons/articles/{nn}-{slug}`) instead of the required `/{slug}` format per Rule 5a. This is a systematic issue affecting every article.

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 0 | None (self-contained pillar) |
| Inbound | Not audited | Requires full pillar scan |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide -> Supporting | 6/6 | PASS |
| Supporting -> Guide | 6/6 | PASS |

**No missing bidirectional links.** All supporting articles link to the pillar guide and vice versa.

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 3 | bbc.co.uk/cbeebies/radio, pubmed.ncbi.nlm.nih.gov/32046984, nice.org.uk/guidance/ng87 |
| Redirects (301/302) | 2 | smilingmind.com.au/about -> /vision-and-mission; autism.org.uk/sensory-differences -> /about-autism/sensory-processing |
| Blocked (403) | 4 | ncbi.nlm.nih.gov/pmc/articles/PMC6424546, PMC7082250, PMC6534423; adc.bmj.com/content/109/2/138 |
| Broken (404) | 2 | understood.org/articles/executive-function-disorder-adhd (Article 01); rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents (Article 06) |
| Timeout | 0 | - |

**Domain Frequency Issues:** None. No article exceeds 2 citations from the same domain.

**Broken Citation Details:**

1. **Article 01:** `https://www.understood.org/articles/executive-function-disorder-adhd` returned 404. Used in Understood.org, 2024 citation about Executive Function and ADHD. Needs replacement source.

2. **Article 06:** `https://www.rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents` returned 404. Used in Royal College of Paediatrics and Child Health, 2019 citation about screen time. Needs replacement source.

**Redirect Details:**

1. `https://www.smilingmind.com.au/about` -> `https://www.smilingmind.com.au/vision-and-mission` (Articles: 05). URL should be updated.

2. `https://www.autism.org.uk/advice-and-guidance/topics/sensory-differences/sensory-differences/all-audiences` -> `https://www.autism.org.uk/advice-and-guidance/about-autism/sensory-processing` (Articles: 02, 04, 06, 07). URL should be updated across 4 articles.

**Blocked (403) Note:** NCBI PMC and BMJ archives commonly block HEAD and GET requests from automated tools. These URLs are likely valid but cannot be verified automatically. Manual verification recommended.

---

## Frontmatter Accuracy

| Article | word_count | keyword_density | Keywords |
|---------|------------|-----------------|----------|
| 01-slug | PASS | PASS | PASS |
| 02-slug | PASS | PASS | FAIL (keyword not in H2) |
| 03-slug | PASS | PASS | PASS |
| 04-slug | PASS | PASS | PASS |
| 05-slug | PASS | PASS | PASS |
| 06-slug | PASS | PASS | PASS |
| 07-slug | PASS | PASS | PASS |

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| Dysregulation / Overwhelm | "dysregulation" used throughout; profile says use "overwhelm" | 01, 02, 03, 04, 05, 06, 07 | Replace "dysregulation" with "overwhelm" across all articles |

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| None detected | - | - | - |

**Statistics are consistent across articles:**
- ADHD sleep problems: "25-50%" (Articles 03, 07) - both cite NICE guidance
- Autism sensory sensitivity: "up to 90%" (Articles 02, 07) - both cite NAS
- ADHD sleep onset: "up to half" (Article 03) - aligns with 25-50%

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | It's not your child failing the app. It's the app failing your child. | Strong |
| 02 | Reviewed through an autism lens | Strong |
| 03 | Works WITH the ADHD brain, not against it | Strong |
| 04 | The fourth option you didn't know existed | Strong |
| 05 | Free AND ND-first, not free BUT generic | Strong |
| 06 | Screen-free without sacrificing depth | Strong |
| 07 | Design origin determines effectiveness (Pillar Guide) | Strong |

**All 7 articles strongly align with their assigned angles.** The "Designed FOR vs Adapted FOR" positioning thread is consistent throughout the pillar.

---

## Patterns (3+ occurrences)

### Internal Link Format (Directory Structure)
- Articles: 01, 02, 03, 04, 05, 06, 07
- Count: 50+ violations
- Root cause: All links were written using file paths (`/app-comparisons/articles/{nn}-{slug}`) instead of CMS-compatible slugs (`/{slug}`)
- Recommend for common-mistakes.md: Yes

### Clinical Terminology (dysregulation)
- Articles: 01, 02, 03, 04, 05, 06, 07
- Count: 20+ instances across all articles
- Root cause: Client profile specifies "overwhelm" but "dysregulation" was used throughout
- Recommend for common-mistakes.md: Yes

---

## Notes

- **Agent Write permissions:** Content-validator and link-auditor agents were unable to write `.validation.md` and `link-audit.md` files due to background agent Write permission restrictions. Validation results were captured from agent return output instead.
- **Content quality:** Despite the FAIL status (driven by systematic link format issues), the overall content quality across all 7 articles is high. Brand voice, readability, SEO optimisation, and positioning alignment are all strong.
- **Fix complexity:** The link format issue is mechanical (find-and-replace pattern) and should be straightforward to fix with `--fix` mode.
