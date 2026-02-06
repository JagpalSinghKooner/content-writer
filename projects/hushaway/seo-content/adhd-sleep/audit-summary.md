# Pillar Audit: ADHD Sleep

**Date:** 2026-02-05
**Articles:** 7
**Total Word Count:** 18,524
**Status:** PARTIAL

---

## Article Results

| # | Article | Validation | Links | Citations | Frontmatter | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | why-your-adhd-child-wont-sleep | PASS | FAIL (1) | PASS | PASS | FAIL |
| 02 | parents-guide-adhd-bedtime-routine | FAIL (1) | FAIL (1) | PASS | PASS | FAIL |
| 03 | best-calming-sounds-adhd-children | FAIL (1) | FAIL (1) | PASS | PASS | FAIL |
| 04 | quieting-adhd-racing-thoughts-bedtime | PASS | PASS | PASS | PASS | PASS |
| 05 | beyond-melatonin-adhd-sleep-alternatives | PASS | FAIL (1) | PASS | PASS | FAIL |
| 06 | parents-guide-adhd-vs-autism-sleep | PASS | PASS | PASS | PASS | PASS |
| 07 | complete-guide-adhd-sleep-problems-uk | PASS | FAIL (1) | PASS | PASS | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Keyword-Only Slug (fixed in Task 37) | 2 | 0 | 02, 03 |
| Broken Internal Links (slug mismatch) | 9 | 0 | 01, 02, 03, 05, 07 |
| Citation URL 403 (bot-blocking) | 0 | 5 | 02, 03, 04, 06, 07 |
| Statistics Inconsistency | 0 | 1 | 07 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links (slug mismatch) | 9 | FAIL | 01, 02, 03, 05, 07 |
| Incorrect URL format | 0 | PASS | - |
| Stale placeholders | 0 | PASS | - |
| Valid placeholders | 0 | INFO | - |

**Root Cause:** Article 04 frontmatter slug is `quieting-adhd-racing-thoughts-bedtime` but all 9 links across 5 articles reference `/adhd-racing-thoughts`. This slug does not exist in any pillar.

**Fix Options:**
- **Option A (recommended):** Change article 04 slug to `adhd-racing-thoughts` (matches how it's naturally referenced, shorter, user-friendly)
- **Option B:** Update all 9 link references to `/quieting-adhd-racing-thoughts-bedtime`
- **Note:** Slug references updated in Task 38

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 0 | - |
| Inbound | 5 | app-comparisons, bedtime-routines, emotional-regulation |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide → Supporting | 6/6 | PASS |
| Supporting → Guide | 6/6 | PASS |

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 10 | All verified |
| Blocked (403) | 5 | All pmc.ncbi.nlm.nih.gov / pubmed.ncbi.nlm.nih.gov (bot-blocking, not broken) |
| Broken (4xx/5xx) | 0 | - |
| Timeout | 0 | - |

**403 URLs (WARN — likely bot-blocking, not broken):**
1. https://pmc.ncbi.nlm.nih.gov/articles/PMC5799342/ (Article 06)
2. https://pmc.ncbi.nlm.nih.gov/articles/PMC11283987/ (Articles 03, 04, 05, 07)
3. https://pmc.ncbi.nlm.nih.gov/articles/PMC11585357/ (Article 03)
4. https://pmc.ncbi.nlm.nih.gov/articles/PMC12330042/ (Article 02)
5. https://pmc.ncbi.nlm.nih.gov/articles/PMC10545997/ (Article 02)

**Domain Frequency Issues:** None. No article cites the same domain more than twice.

---

## Frontmatter Accuracy

| Article | word_count | keyword_density | Keywords |
|---------|------------|-----------------|----------|
| 01-why-your-adhd-child-wont-sleep | PASS (2247) | PASS (1.4%) | PASS |
| 02-parents-guide-adhd-bedtime-routine | PASS (2412) | PASS (1.3%) | PASS |
| 03-best-calming-sounds-adhd-children | PASS (2412) | PASS (1.3%) | PASS |
| 04-adhd-racing-thoughts | PASS (2089) | PASS (1.3%) | PASS |
| 05-beyond-melatonin-adhd-sleep-alternatives | PASS (2542) | PASS (1.4%) | PASS |
| 06-parents-guide-adhd-vs-autism-sleep | PASS (2124) | PASS (1.4%) | PASS |
| 07-complete-guide-adhd-sleep-problems-uk | PASS (4698) | PASS (1.2%) | PASS |

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| Racing brain/thoughts | "racing brain", "racing thoughts", "brain won't switch off" | All | Consistent (all acceptable synonyms) |
| Passive listening | "passive listening", "just press play", "passive sound" | All | Consistent |
| Overwhelm (not dysregulation) | "overwhelm", "overwhelming" | 01, 02, 03, 05, 06, 07 | PASS (matches profile) |

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| ADHD sleep % | "73-78%" (circadian) vs "73-85%" (general) | 07 (line 126 vs 584) | WARN: Different claims (circadian vs general) but could confuse readers. Recommend clarifying in FAQ. |

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Generic advice fails ADHD kids | Strong |
| 02 | Routine needs the missing piece | Strong |
| 03 | Which sounds work and why | Strong |
| 04 | Redirect, don't force quiet | Strong |
| 05 | Beyond medication | Strong |
| 06 | Tailored solutions matter | Strong |
| 07 | Sound is the missing piece | Strong |

---

## Patterns (3+ occurrences)

### Keyword-Only Slugs
- Articles: 02, 03
- Count: 2
- Recommend for common-mistakes.md: Already exists

### Slug Mismatch (Article 04)
- Articles: 01, 02, 03, 05, 07 (9 broken link instances)
- Count: 9
- Recommend for common-mistakes.md: Yes (new pattern — slug in frontmatter doesn't match how it's referenced)

### PMC/NCBI 403 Bot-Blocking
- Articles: 02, 03, 04, 06, 07
- Count: 5 unique URLs
- Recommend for common-mistakes.md: No (external issue, not content problem)
