# Cross-Pillar Audit Summary

**Date:** 2026-02-06
**Pillars Audited:** 8
**Total Articles:** 57
**Total Word Count:** 155,336

---

## Per-Pillar Results

| Pillar | Articles | Words | PASS | FAIL | Status |
|--------|:--------:|------:|:----:|:----:|--------|
| ADHD Sleep | 7 | 18,524 | 2 | 5 | PARTIAL |
| Autistic Meltdowns | 7 | 16,586 | 0 | 7 | FAIL |
| Sensory Overload | 8 | 23,449 | 0 | 8 | FAIL |
| Calming Sounds | 7 | 18,050 | 0 | 7 | FAIL |
| Emotional Regulation | 7 | 18,541 | 0 | 7 | FAIL |
| Bedtime Routines | 7 | 20,506 | 0 | 7 | FAIL |
| Sound Therapy | 7 | 18,608 | 0 | 7 | FAIL |
| App Comparisons | 7 | 21,072 | 7 | 0 | PASS (after fix) |
| **Totals** | **57** | **155,336** | **9** | **48** | |

**Note:** App Comparisons is the only pillar that has been auto-fixed. All others are validate-only audits.

---

## Issue Categories (Aggregated)

| Category | Pillars Affected | Total Instances | Auto-Fixable? |
|----------|:----------------:|:---------------:|:-------------:|
| Incorrect Internal Link Format (Rule 5a) | 8/8 | ~365 | Yes |
| Citation Bot-Blocking (403) | 8/8 | ~43 unique URLs | No (external) |
| Broken Citation URLs (404) | 7/8 | 19 unique URLs | No (manual) |
| Missing Bidirectional Guide Links | 4/8 | 14 | Yes |
| Broken Internal Links (slug mismatch) | 4/8 | 28 | Yes |
| Keyword-Only Slugs | 3/8 | 5 articles | Yes (editorial) |
| Slug Number Prefix in Frontmatter | 2/8 | 9 articles | Yes |
| Clinical Terminology (WARN) | 2/8 | 30+ uses | Yes |
| Statistics Inconsistency (WARN) | 1/8 | 1 | Manual |
| Meta Description Length | 1/8 | 1 | Yes |

---

## Patterns Appearing 3+ Times

### 1. Incorrect Internal Link Format (Rule 5a)

**Pillars:** All 8 (8/8)
**Total instances:** ~365

| Pillar | Count | Pattern |
|--------|------:|---------|
| Emotional Regulation | 71 | `/emotional-regulation/articles/{slug}` |
| Bedtime Routines | 56 | `/bedtime-routines/articles/{slug}` |
| Autistic Meltdowns | 51+ | `/autistic-meltdowns/{slug}` or `/autistic-meltdowns/articles/{filename}` |
| App Comparisons | 51 | `/app-comparisons/articles/{filename}` (FIXED) |
| Sensory Overload | 50 | `/sensory-overload/articles/{slug}` |
| Sound Therapy | 29 | `/sound-therapy/{slug}` |
| Calming Sounds | 28 | `/calming-sounds/articles/{slug}` |
| ADHD Sleep | 9 | Slug mismatch (different root cause) |

**Root cause:** All articles were generated with directory-structure internal links instead of the required `/{slug}` format. This is a systematic issue from the original content generation workflow.

**Auto-fix plan:** Find-and-replace all internal link URLs from `/{pillar}/articles/{nn}-{slug}` or `/{pillar}/{slug}` to `/{slug}`. App Comparisons proves this fix works (51 instances fixed in one pass, all articles PASS).

---

### 2. Broken Citation URLs (404)

**Pillars:** 7/8 (all except ADHD Sleep)
**Total unique URLs:** 19

**Auto-fixable:** No. Each requires manual replacement with a working URL or removal.

| # | Broken URL | Pillar(s) | Article(s) |
|---|-----------|-----------|------------|
| 1 | `frontiersin.org/articles/10.3389/fpsyg.2021.767782/full` | Autistic Meltdowns | 03 |
| 2 | `nhs.uk/conditions/sensory-processing-disorder/` | Sensory Overload | 01, 08 |
| 3 | `autism.org.uk/advice-and-guidance/topics/mental-health/after-school-restraint-collapse` | Sensory Overload | 04 |
| 4 | `understood.org/en/articles/sensory-diet` | Sensory Overload | 06 |
| 5 | `frontiersin.org/articles/10.3389/fpsyg.2020.574461/full` | Sensory Overload | 07 |
| 6 | `chadd.org/about-adhd/sensory-processing-issues/` | Calming Sounds | 01 |
| 7 | `nhs.uk/conditions/autism/autism-and-everyday-life/help-with-everyday-life/` | Calming Sounds | 05 |
| 8 | `frontiersin.org/articles/10.3389/fpsyg.2020.564206/full` | Calming Sounds | 07 |
| 9 | `nhs.uk/every-mind-matters/childrens-mental-health/sleep-problems-in-children/` | Calming Sounds | 07 |
| 10 | `zonesofregulation.com/learn-more.html` | Emotional Regulation | 04, 07 |
| 11 | `nhs.uk/mental-health/children-and-young-adults/advice-for-parents/help-your-child-manage-emotions/` | Emotional Regulation | 06, 07 |
| 12 | `hushaway.com/the-open-sanctuary/` | Emotional Regulation | 05 |
| 13 | `pubmed.ncbi.nlm.nih.gov/25928655/` | Bedtime Routines | 02 |
| 14 | `autism.org.uk/advice-and-guidance/topics/communication/visual-supports` | Bedtime Routines | 03 |
| 15 | `pubmed.ncbi.nlm.nih.gov/28838255/` | Bedtime Routines | 03 |
| 16 | `sleepfoundation.org/children-and-sleep/separation-anxiety-and-sleep` | Bedtime Routines | 06 |
| 17 | `sciencedirect.com/science/article/pii/S1053810020300982` | Sound Therapy | 07 |
| 18 | `rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents` | App Comparisons | 06, 07 |
| 19 | `understood.org/articles/executive-function-disorder-adhd` | App Comparisons | 01 |

**Domain frequency in broken URLs:**
- NHS (nhs.uk): 4 URLs
- Frontiers (frontiersin.org): 3 URLs
- Understood.org: 2 URLs
- PubMed (pubmed.ncbi.nlm.nih.gov): 2 URLs
- autism.org.uk: 2 URLs
- Others (1 each): chadd.org, zonesofregulation.com, hushaway.com, sleepfoundation.org, sciencedirect.com, rcpch.ac.uk

---

### 3. Citation Bot-Blocking (403)

**Pillars:** All 8 (8/8)
**Total unique URLs:** ~43

These are WARN, not FAIL. The URLs are likely valid but return 403 to automated requests (bot protection). Domains affected:

| Domain | Frequency |
|--------|-----------|
| ncbi.nlm.nih.gov / pmc.ncbi.nlm.nih.gov | ~25 URLs |
| journals.sagepub.com | ~4 URLs |
| publications.aap.org | ~2 URLs |
| onlinelibrary.wiley.com | ~1 URL |
| sciencedirect.com | ~1 URL |
| bmjopen.bmj.com / adc.bmj.com | ~2 URLs |
| mind.org.uk | ~1 URL |

**Recommendation:** No action needed. These are academic/medical sources with bot protection. They work in browsers.

---

### 4. Missing Bidirectional Guide Links

**Pillars:** 4/8
**Total missing:** 14

| Pillar | Missing Count | Articles Missing Link to Guide |
|--------|:------------:|-------------------------------|
| Sensory Overload | 7 | 01, 02, 03, 04, 05, 06, 07 (all supporting) |
| Calming Sounds | 4 | 01, 03, 04, 06 |
| Bedtime Routines | 2 | 04, 05 |
| Autistic Meltdowns | 1 | 02 |

**Auto-fix plan:** Add link to pillar guide at the end of each affected article. Template: "For the complete guide, see [our comprehensive guide to {topic}](/{pillar-guide-slug})."

---

### 5. Broken Internal Links (Slug Mismatch)

**Pillars:** 4/8
**Total instances:** 28

| Pillar | Count | Root Cause |
|--------|------:|-----------|
| Autistic Meltdowns | 12 | Links use shortened/incorrect slug names (e.g., `02-what-to-play-during-meltdown` instead of `sounds-to-play-autism-meltdown`) |
| ADHD Sleep | 9 | All reference `/adhd-racing-thoughts` but frontmatter slug is `quieting-adhd-racing-thoughts-bedtime` (note: slug references updated in Task 38) |
| Sensory Overload | 5 | Partial slugs that don't match any article's frontmatter |
| Emotional Regulation | 2 | Filename/slug mismatch for article 02 |

**Auto-fix plan:** Map each incorrect slug to the correct frontmatter slug and replace. Requires a slug lookup table per pillar.

---

### 6. Keyword-Only Slugs

**Pillars:** 3/8
**Total articles:** 5

| Pillar | Articles | Current Slug |
|--------|----------|-------------|
| ADHD Sleep | 02 | `parents-guide-adhd-bedtime-routine` |
| ADHD Sleep | 03 | `best-calming-sounds-adhd-children` |
| Sound Therapy | 03 | `safety-guide-binaural-beats-children` |
| Sound Therapy | 06 | `parents-guide-sound-vs-music-therapy` |
| App Comparisons | 05 | `guide-free-calming-apps-kids-uk` |

**Auto-fix plan:** Editorial decision required. Changing slugs affects all internal links referencing them. Recommend batching slug changes with link format fixes.

---

## Content Quality Summary

Despite the link/citation issues, content quality across all 8 pillars is excellent:

| Quality Check | Result | Notes |
|---------------|--------|-------|
| Brand Voice Alignment | Strong (all 57 articles) | Warm, parent-to-parent tone |
| UK English | PASS (all 57 articles) | Zero American spelling violations |
| Banned AI Words | PASS (all 57 articles) | Zero banned words detected |
| Em Dashes | PASS (all 57 articles) | Zero em dashes detected |
| AI Patterns | PASS (all 57 articles) | Natural sentence variation |
| Positioning Alignment | Strong (all 57 articles) | Every article aligns with assigned angle |
| Terminology Consistency | PASS (56/57 articles) | 1 WARN for "dysregulated" in calming-sounds/06 |
| Conflicting Claims | PASS (56/57 articles) | 1 WARN for statistics inconsistency in adhd-sleep/07 |
| SEO (keyword density, word count, meta) | PASS (all 57 articles) | All meet requirements |
| Frontmatter Accuracy | PASS (all 57 articles) | Word counts and keywords correct |

---

## Task 26 Auto-Fix Planning

### Priority 1: Internal Link Format (Auto-Fixable)

**Scope:** 7 pillars (App Comparisons already fixed), ~314 remaining instances
**Approach:** For each article:
1. Read frontmatter `slug` field from all articles across all pillars (build slug lookup)
2. Replace all `/pillar/articles/nn-slug` patterns with `/{slug}`
3. Replace all `/pillar/slug` patterns with `/{slug}`
4. Validate after fix

**Estimated effort:** Low. App Comparisons proves the pattern. Each pillar is one pass.

### Priority 2: Missing Bidirectional Guide Links (Auto-Fixable)

**Scope:** 4 pillars, 14 articles
**Approach:** Add contextual link to pillar guide in the conclusion section of each affected article.

**Estimated effort:** Low. Formulaic fix.

### Priority 3: Broken Slug References (Auto-Fixable)

**Scope:** 4 pillars, 28 instances
**Approach:** Build correct slug mapping per pillar, then find-and-replace.
**Note:** Some overlap with Priority 1 (fixing link format also fixes some slug issues).

**Estimated effort:** Medium. Requires building a slug lookup table.

### Priority 4: Broken Citation URLs (Manual)

**Scope:** 7 pillars, 19 unique URLs
**Approach:** For each broken URL:
1. Search for replacement URL (same study/resource at new location)
2. If found, replace
3. If not found, find alternative authoritative source or remove citation
4. Re-validate article after fix

**Estimated effort:** High. Each URL requires manual research.

### Priority 5: Keyword-Only Slugs (Editorial Decision)

**Scope:** 3 pillars, 5 articles
**Approach:** Requires user decision on new slugs. Changing slugs cascades to all internal links referencing them.
**Recommendation:** Bundle with Priority 1 link fixes.

**Estimated effort:** Medium. Needs editorial input.

### Priority 6: Clinical Terminology (WARN)

**Scope:** 2 pillars, ~30 instances
**Approach:** Replace "dysregulation" with "overwhelm" in parent-facing body text. Keep in FAQ/SEO keyword contexts only.

**Estimated effort:** Low. Find-and-replace with context review.

---

## Execution Order for Task 26

1. Build complete slug lookup table (all 57 articles)
2. Fix internal link format across 7 pillars (Priority 1 + 3 combined)
3. Add missing bidirectional guide links (Priority 2)
4. Fix clinical terminology (Priority 6)
5. Validate all articles post-fix
6. Escalate broken citation URLs for manual review (Priority 4)
7. Present keyword-only slug decisions to user (Priority 5)

---

*Summary compiled 2026-02-06 from 8 pillar audit-summary.md files.*
