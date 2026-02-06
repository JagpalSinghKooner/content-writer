# Pillar Audit: Sensory Overload

**Date:** 2026-02-05
**Articles:** 8
**Total Word Count:** 23,449
**Status:** FAIL

---

## Article Results

| # | Article | Validation | Links | Citations | Consistency | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | understanding-sensory-overload-children | FAIL (6) | FAIL | WARN (1) | PASS | FAIL |
| 02 | calming-sounds-sensory-overload | FAIL (3) | FAIL | PASS | PASS | FAIL |
| 03 | sound-sensitivity-children-auditory-hypersensitivity | FAIL (4) | FAIL | PASS | PASS | FAIL |
| 04 | after-school-sensory-overload-meltdowns | FAIL (3) | FAIL | FAIL (1) | PASS | FAIL |
| 05 | sensory-tools-children-sound-works | FAIL (4) | FAIL | PASS | PASS | FAIL |
| 06 | sensory-diet-children-missing-system | FAIL (5) | FAIL | FAIL (2) | PASS | FAIL |
| 07 | recovering-sensory-overload-hours-after | FAIL (5) | FAIL | FAIL (2) | PASS | FAIL |
| 08 | complete-guide-sensory-overload-children (pillar guide) | FAIL (4) | FAIL | WARN (1) | PASS | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Incorrect URL Format (Rule 5a) | 50 | 0 | 01, 02, 03, 04, 05, 06, 07, 08 |
| Slug Number Prefix | 8 | 0 | 01, 02, 03, 04, 05, 06, 07, 08 |
| Broken Internal Links | 5 | 0 | 01, 04, 05, 06 |
| Missing Bidirectional Links (Supporting → Guide) | 7 | 0 | 01, 02, 03, 04, 05, 06, 07 |
| Citation URL 404 | 4 | 0 | 01, 04, 06, 07, 08 |
| Citation URL 403 (bot-blocking) | 0 | 4 | 01, 02, 03, 04, 08 |
| Meta Description Length | 1 | 0 | 01 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Incorrect URL format | 50 | FAIL | 01, 02, 03, 04, 05, 06, 07, 08 |
| Broken links (slug mismatch) | 5 | FAIL | 01, 04, 05, 06 |
| Stale placeholders | 0 | PASS | - |
| Valid placeholders | 0 | INFO | - |

**Format Issue Detail:** All 8 articles use directory structure (`/sensory-overload/articles/{slug}`) or partial paths (`/sensory-overload/{partial-slug}`) instead of required `/{slug}` format. 23 violations in frontmatter, 27 in content markdown links.

**Broken Link Detail:**
- Article 01 frontmatter: 3 broken slug references (uses partial slugs that don't match any article's frontmatter slug)
- Articles 04, 05: reference non-existent slug `03-after-school-sensory-overload` (correct: `understanding-after-school-sensory-overload`)
- Articles 04, 06: reference non-existent slug `07-sensory-overload-recovery` (correct: `recovering-sensory-overload-hours-after`)

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 0 | - |
| Inbound | 0 | - |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide → Supporting | 7/7 | PASS |
| Supporting → Guide | 0/7 | FAIL |

**Missing links TO pillar guide:**
- 01-understanding-sensory-overload-children.md
- 02-calming-sounds-sensory-overload.md
- 03-sound-sensitivity-children-auditory-hypersensitivity.md
- 04-after-school-sensory-overload-meltdowns.md
- 05-sensory-tools-children-sound-works.md
- 06-sensory-diet-children-missing-system.md
- 07-recovering-sensory-overload-hours-after.md

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 11 | All functioning correctly |
| Redirects (301/302) | 0 | - |
| Bot-blocked (403) | 4 | NCBI/PMC URLs (consistent with prior audits) |
| Broken (404) | 4 | See below |
| Method Not Allowed (405→200) | 1 | soundhealingacademy.co.uk (passed on GET retry) |

**Broken Citation URLs (404):**
- Article 01, 08: `https://www.nhs.uk/conditions/sensory-processing-disorder/` (NHS page removed/moved)
- Article 04: `https://www.autism.org.uk/advice-and-guidance/topics/mental-health/after-school-restraint-collapse` (NAS page not found)
- Article 06: `https://www.understood.org/en/articles/sensory-diet` (Understood.org page removed/moved)
- Article 07: `https://www.frontiersin.org/articles/10.3389/fpsyg.2020.574461/full` (Frontiers page returns 404)

**Bot-Blocked URLs (403 WARN):**
- `https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6879775/` (Art 01, 03)
- `https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5618809/` (Art 02)
- `https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7474833/` (Art 04)
- `https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8566186/` (Art 08)

**Domain Frequency:** No single domain cited more than twice in any single article.

---

## Cross-Article Consistency

**Status:** PASS

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| None found | - | - | - |

All terminology consistent across pillar. HushAway® and The Open Sanctuary used correctly throughout.

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| None found | - | - | - |

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Auditory system is the key to regulation | Strong |
| 02 | Sound is the only zero-demand sensory input | Strong |
| 03 | Therapeutic sound ≠ triggering noise | Strong |
| 04 | Sound should be FIRST thing offered | Strong |
| 05 | Tactile tools for prevention; sound for crisis | Strong |
| 06 | Auditory input is the missing sensory system | Strong |
| 07 | Post-overload recovery needs sound | Strong |
| 08 | Sound isn't the enemy, it's the solution | Strong |

---

## Patterns (3+ occurrences)

### Internal Link Format Violations (Directory Structure)
- Articles: 01, 02, 03, 04, 05, 06, 07, 08
- Count: 50
- Recommend for common-mistakes.md: Already documented

### Slug Number Prefix in Frontmatter
- Articles: 01, 02, 03, 04, 05, 06, 07, 08
- Count: 8
- Recommend for common-mistakes.md: Already documented

### Missing Bidirectional Guide Links
- Articles: 01, 02, 03, 04, 05, 06, 07
- Count: 7
- Recommend for common-mistakes.md: Yes (new pattern)

### Broken Citation URLs (NHS/NAS/Understood.org)
- Articles: 01, 04, 06, 07, 08
- Count: 4 unique URLs
- Recommend for common-mistakes.md: No (external dependency, not a writing pattern)
