# Pillar Audit: Calming Sounds

**Date:** 2026-02-05
**Articles:** 7
**Total Word Count:** 18,050 (2156 + 2247 + 2847 + 2412 + 1756 + 1785 + 4847)
**Status:** FAIL

---

## Article Results

| # | Article | Validation | Links | Citations | Consistency | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | why-generic-calming-sounds-dont-work-nd-children | FAIL (4) | FAIL (6) | PASS | Strong | FAIL |
| 02 | sleep-sounds-children-which-type-helps | FAIL (3) | FAIL (3) | PASS | Strong | FAIL |
| 03 | asmr-binaural-beats-white-noise-parents-guide-sound-types | FAIL (6) | FAIL (4) | PASS | Strong | FAIL |
| 04 | calming-sounds-every-situation-anxiety-focus-transitions | FAIL (3) | FAIL (2) | PASS | Strong | FAIL |
| 05 | free-calming-sounds-children-uk-options | PASS | FAIL (3) | WARN (1) | Strong | FAIL |
| 06 | calming-sounds-vs-music-children-difference | PASS | FAIL (4) | PASS | Strong | FAIL |
| 07 | complete-guide-calming-sounds-children (pillar guide) | FAIL (12) | FAIL (6) | WARN (2) | Strong | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Incorrect Internal Link Format | 28 | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Missing Bidirectional Guide Links | 4 | 0 | 01, 03, 04, 06 |
| Broken Citation URLs (404) | 3 | 0 | 01, 05, 07 |
| Citation Bot-Blocking (403) | 0 | 6 | 03, 04, 07 |
| Prohibited Term ("dysregulated") | 0 | 1 | 06 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links | 0 | PASS | - |
| Incorrect URL format | 28 | FAIL | 01, 02, 03, 04, 05, 06, 07 |
| Stale placeholders | 0 | PASS | - |
| Valid placeholders | 0 | INFO | - |

**Pattern:** All 7 articles use `/calming-sounds/articles/{slug}` or `/sensory-overload/articles/{slug}` format instead of required `/{slug}` format. This is a systematic issue across the entire pillar.

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 5 | sensory-overload |
| Inbound | Not audited | - |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide → Supporting | 6/6 | PASS |
| Supporting → Guide | 2/6 | FAIL |

**Missing links TO pillar guide:**
- 01-why-generic-calming-sounds-dont-work-nd-children.md
- 03-asmr-binaural-beats-white-noise-parents-guide-sound-types.md
- 04-calming-sounds-every-situation-anxiety-focus-transitions.md
- 06-calming-sounds-vs-music-children-difference.md

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 12 | pubmed.ncbi x5, sleepfoundation, autism.org.uk x2, frontiersin (fnhum), bbc.co.uk x2, nhs.uk (tinnitus) |
| Bot-Blocking (403) | 6 | ncbi.nlm.nih.gov/pmc x3, bmjopen.bmj.com, publications.aap.org, journals.sagepub.com |
| Broken (404) | 3 | See below |

**Broken Citation URLs:**
- **Art 01:** `https://chadd.org/about-adhd/sensory-processing-issues/` → 404
- **Art 05:** `https://www.nhs.uk/conditions/autism/autism-and-everyday-life/help-with-everyday-life/` → 404
- **Art 07:** `https://www.frontiersin.org/articles/10.3389/fpsyg.2020.564206/full` → 404
- **Art 07:** `https://www.nhs.uk/every-mind-matters/childrens-mental-health/sleep-problems-in-children/` → 404

**Domain Frequency Issues:**
- None found (no article cites the same domain more than twice)

---

## Frontmatter Accuracy

| Article | word_count | keyword_density | Slug Format |
|---------|------------|-----------------|-------------|
| 01 | PASS (2156) | PASS (1.3%) | PASS (descriptive-first) |
| 02 | PASS (2247) | PASS (1.4%) | PASS (descriptive-first) |
| 03 | PASS (2847) | PASS (1.2%) | PASS (descriptive-first) |
| 04 | PASS (2412) | PASS (1.4%) | PASS (descriptive-first) |
| 05 | PASS (1756) | PASS (1.3%) | PASS (descriptive-first) |
| 06 | PASS (1785) | PASS (1.4%) | PASS (descriptive-first) |
| 07 | PASS (4847) | PASS (1.4%) | PASS (descriptive-first) |

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| Neurodivergent children | "neurodivergent children", "ND children", "ND child" | All | WARN: Standardise to full term in body text |
| Designed FOR mechanism | "designed FOR vs adapted FOR", "designed for", "built from the ground up" | 01, 02, 03, 05, 07 | WARN: Use full contrast consistently |
| Prohibited term | "dysregulated" (Art 06, line 167) | 06 | WARN: Replace with "overwhelmed" |

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| None found | - | - | - |

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Design mismatch: generic sounds fail ND brains | Strong |
| 02 | Different sleep problems need different sounds | Strong |
| 03 | Evidence-based clarity on sound types | Strong |
| 04 | Right sound for the right moment | Strong |
| 05 | Only free ND-designed option in UK | Strong |
| 06 | Sounds bypass cognitive processing music demands | Strong |
| 07 | Designed FOR vs adapted FOR (primary angle) | Strong |

---

## Patterns (3+ occurrences)

### Internal Link Format Violations (Systematic)
- Articles: 01, 02, 03, 04, 05, 06, 07
- Count: 28 violations across all 7 articles
- Recommend for common-mistakes.md: No (already documented in previous audits)

### Missing Bidirectional Guide Links
- Articles: 01, 03, 04, 06
- Count: 4 missing links
- Recommend for common-mistakes.md: No (already documented in previous audits)
