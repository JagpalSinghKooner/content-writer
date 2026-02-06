# Pillar Audit: Bedtime Routines

**Date:** 2026-02-06
**Articles:** 7
**Total Word Count:** 20,506
**Status:** FAIL

---

## Article Results

| # | Article | Validation | Links | Citations | Consistency | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | why-bedtime-harder-neurodivergent-children | PASS (0F, 2W) | FAIL (6 format) | PASS | Strong | FAIL |
| 02 | sound-based-bedtime-routine-nd-children | PASS (0F, 0W) | FAIL (3 format) | FAIL (1 broken) | Strong | FAIL |
| 03 | visual-bedtime-routine-neurodivergent-children | FAIL (3F, 0W) | FAIL (5 format) | FAIL (2 broken) | Strong | FAIL |
| 04 | sound-anchored-adhd-bedtime-routine | PASS (0F, 0W) | FAIL (4 format) | PASS | Strong | FAIL |
| 05 | autism-bedtime-routine-predictability-calm | PASS (0F, 0W) | FAIL (5 format) | PASS | Strong | FAIL |
| 06 | bedtime-anxiety-sound-calm-answer | PASS (0F, 0W) | FAIL (7 format) | FAIL (1 broken) | Strong | FAIL |
| 07 | complete-guide-nd-bedtime-routines (pillar guide) | FAIL (7F, 0W) | FAIL (14 format) | PASS | Strong | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Incorrect Internal Link Format | 56 | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Missing Bidirectional Guide Links | 2 | 0 | 04, 05 |
| Broken Citation URLs (404) | 4 | 0 | 02, 03, 06 |
| NCBI/PMC Bot-Blocking (403) | 0 | 5 | 01, 02, 04, 05, 06, 07 |
| Cross-Pillar Link Format | 12 | 0 | 01, 02, 04, 05 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links | 0 | PASS | - |
| Incorrect URL format (within pillar) | 44 | FAIL | 01, 02, 03, 04, 05, 06, 07 |
| Incorrect URL format (cross-pillar) | 12 | FAIL | 01, 02, 04, 05 |
| Stale placeholders | 0 | PASS | - |

**Format Pattern:** All articles use `/bedtime-routines/articles/{slug}` or `/{other-pillar}/articles/{slug}` instead of the required `/{slug}` format. This is a systematic issue across the entire pillar.

**Slug Mismatch:** Article 01 references `/adhd-sleep/articles/04-adhd-racing-thoughts` but the actual slug in that article is `quieting-adhd-racing-thoughts-bedtime`.

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 12 | adhd-sleep (3), calming-sounds (3), emotional-regulation (2), sensory-overload (2) |
| Inbound | 0 | - |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide -> Supporting | 6/6 | PASS |
| Supporting -> Guide | 4/6 | FAIL |

**Missing links TO pillar guide:**
- 04-adhd-bedtime-routine-that-works.md
- 05-autism-bedtime-routine-predictability-calm.md

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 7 | sleepfoundation.org/adhd-and-sleep, autism.org.uk/sleep, pubmed/25554879, frontiersin.org/fnhum.2018.00288, frontiersin.org/fpsyg.2020.01982, nhs.uk/autism/other-conditions |
| Bot-Blocking (403) | 5 | ncbi PMC4340974 (Art 01, 05), ncbi PMC6379245 (Art 04), ncbi PMC5618824 (Art 02, 07), ncbi PMC6361831 (Art 06), ncbi PMC3072849 (Art 06) |
| Broken (404) | 4 | See below |
| Redirects | 0 | - |
| Timeout | 0 | - |

**Broken Citation URLs (404):**
- Art 02: `https://pubmed.ncbi.nlm.nih.gov/25928655/` (Poerio et al. ASMR study)
- Art 03: `https://www.autism.org.uk/advice-and-guidance/topics/communication/visual-supports` (NAS visual supports)
- Art 03: `https://pubmed.ncbi.nlm.nih.gov/28838255/` (Knight & Sartini visual supports review)
- Art 06: `https://www.sleepfoundation.org/children-and-sleep/separation-anxiety-and-sleep` (Sleep Foundation separation anxiety)

**Domain Frequency:** No issues (no domain cited more than twice per article).

---

## Frontmatter Accuracy

| Article | word_count | Keywords | Slug Format |
|---------|------------|----------|-------------|
| 01 | 2,456 | PASS | PASS (descriptive-first) |
| 02 | 2,698 | PASS | PASS (descriptive-first) |
| 03 | 2,234 | PASS | PASS (descriptive-first) |
| 04 | 2,847 | PASS | PASS (descriptive-first) |
| 05 | 2,847 | PASS | PASS (descriptive-first) |
| 06 | 2,412 | PASS | PASS (descriptive-first) |
| 07 | 5,012 | PASS | PASS (descriptive-first) |

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| (none found) | - | - | - |

All product names (HushAway, The Open Sanctuary) used correctly across all articles. No prohibited clinical jargon detected.

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| (none found) | - | - | - |

All statistics consistent: 75% ADHD sleep problems, 50-80% autism sleep difficulties, 20-30% neurotypical, 38% Messineo sleep onset improvement.

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Neurology, not behaviour | Strong |
| 02 | The WHAT nobody told you | Strong |
| 03 | Visuals work better WITH sound | Strong |
| 04 | Racing brain needs anchor | Strong |
| 05 | Predictability through sound | Strong |
| 06 | Sound stays when you leave | Strong |
| 07 | Sound is THE core element | Strong |

---

## Patterns (3+ occurrences)

### Incorrect Internal Link Format (Systematic)
- Articles: 01, 02, 03, 04, 05, 06, 07
- Count: 56 (44 within-pillar + 12 cross-pillar)
- Recommend for common-mistakes.md: Already documented
- Note: Same systematic pattern found in all other audited pillars

### NCBI/PMC 403 Bot-Blocking
- Articles: 01, 02, 04, 05, 06, 07
- Count: 5 unique URLs
- Recommend for common-mistakes.md: No (known limitation, not a content issue)

### Broken Citation URLs
- Articles: 02, 03, 06
- Count: 4 unique URLs returning 404
- Recommend for common-mistakes.md: No (requires manual replacement, case-by-case)
