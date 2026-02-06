# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| Tasks 20-25h: Audit System Build + Full Audit | PASS |
| Tasks 26-44: Cross-Pillar Cleanup (em dashes, slugs, links, terminology, validation files, re-audit) | PASS |
| Task 45: Regenerate Cross-Pillar Summary + Create PR | pending |
| Task 46: Fix Broken Citation URLs (404s) | PASS |

### Completed Work (Tasks 20-44)

Built the audit system (link-auditor, consistency-checker, audit-pillar skill) and ran validation-only audits across all 8 pillars (57 articles, 155,336 words). Then executed 18 fix tasks:

- **Em dashes:** Removed all 172 em dashes across 8 articles (Tasks 27-36)
- **Slugs:** Updated 28 frontmatter slugs to descriptive-first format + cascaded references (Tasks 37-38)
- **Internal links:** Converted ~314 directory-structure links to `/{slug}` format across 7 pillars (Task 39)
- **HushAway URL:** Replaced `the-open-sanctuary` with waitlist link in 3 articles (Task 40)
- **Guide links:** Added bidirectional pillar guide links to 14 articles (Task 41)
- **Clinical terminology:** Replaced 53 instances of "dysregulation"/"dysregulated" with "overwhelm"/"overwhelmed" (Task 42)
- **Cleanup:** Deleted 6 stale .validation.md files (Task 43)
- **Re-audit:** Independent grep verification confirms 0 violations across all categories (Task 44)

### Verified Issue Scale (Post-Fix)

| Issue | Count | Status |
|-------|:-----:|--------|
| Em dashes | 0 | PASS |
| Non-compliant slugs | 0 (28 fixed) | PASS |
| Internal link format wrong | 0 (~314 fixed) | PASS |
| Missing guide links | 0 (14 added) | PASS |
| Clinical terminology in body text | 0 (53 replaced, 18 kept in frontmatter/FAQ/citations) | PASS |
| Stale validation files | 0 (6 deleted) | PASS |
| Broken HushAway URL | 0 (3 articles fixed) | PASS |
| Broken citation URLs (404) | 0 (18 fixed) | PASS |
| Bot-blocked citations (403) | ~43 | WARN (acceptable) |

### Execution Rules

- **Branch:** `fix/cross-pillar-cleanup` (single branch, single PR)
- **Verification:** Raw grep output for every task (no relying on audit tool)
- **Sequence:** One task at a time, verify, commit, then next
- **Filenames:** Keep current filenames, only change frontmatter slugs

---

## Task 45: Regenerate Cross-Pillar Summary + Create PR

**Objective:** Update `cross-pillar-summary.md` to reflect the clean state after all fixes. Create the pull request for the `fix/cross-pillar-cleanup` branch.

**Acceptance Criteria:**
- [ ] `cross-pillar-summary.md` accurately reflects current state of all 8 pillars
- [ ] All previously-failing checks now show PASS
- [ ] Em dash count shows 0 (verified, not assumed)
- [ ] Slug compliance shows 57/57 PASS
- [ ] Internal link format shows all compliant
- [ ] Deferred items clearly documented: 18 broken citation URLs (404s) for Task 46
- [ ] 43 bot-blocked URLs (403s) documented as acceptable (WARN, not FAIL)
- [ ] Git commit created
- [ ] PR created for `fix/cross-pillar-cleanup` branch with summary of all changes

**Starter Prompt:**
> Read TASKS.md for context on all completed work. Regenerate `projects/hushaway/seo-content/cross-pillar-summary.md` based on the verified issue scale. Update all tables to show current PASS/FAIL status for each pillar. Document deferred items: 18 broken citation URLs (Task 46) and ~43 bot-blocked URLs (acceptable WARN). Commit, then create a PR for the `fix/cross-pillar-cleanup` branch summarising all 18 fix tasks.

**Status:** pending

---

## Task 46: Fix Broken Citation URLs (404s)

**Objective:** Research and replace 18 broken external citation URLs across 7 pillars (~22 article locations). Each fix updates both the frontmatter `external_citations` YAML and the inline body text markdown link.

**Strategy:**
1. Use Perplexity MCP (`mcp__perplexity__perplexity_search`) to find same source at new URL first
2. If same source not found, find equivalent authoritative replacement
3. If no good replacement exists, remove the citation

**Citation Format (both must be updated per fix):**
- **Frontmatter:** `external_citations` YAML array with `url`, `author`, `year`, `title` fields
- **Inline body:** `[Author], Year: [Title](URL)` markdown links woven into text

**18 Broken URLs:**

| # | Broken URL | Pillar | Article(s) | Search Hint |
|---|-----------|--------|------------|-------------|
| 1 | `nhs.uk/conditions/sensory-processing-disorder/` | Sensory Overload | 01, 08 | NHS sensory processing disorder page |
| 2 | `nhs.uk/conditions/autism/autism-and-everyday-life/help-with-everyday-life/` | Calming Sounds | 05 | NHS autism everyday life help page |
| 3 | `nhs.uk/every-mind-matters/childrens-mental-health/sleep-problems-in-children/` | Calming Sounds | 07 | NHS Every Mind Matters children sleep problems |
| 4 | `nhs.uk/mental-health/children-and-young-adults/advice-for-parents/help-your-child-manage-emotions/` | Emotional Regulation | 06, 07 | NHS help child manage emotions advice parents |
| 5 | `frontiersin.org/articles/10.3389/fpsyg.2021.767782/full` | Autistic Meltdowns | 03 | DOI 10.3389/fpsyg.2021.767782 autistic burnout |
| 6 | `frontiersin.org/articles/10.3389/fpsyg.2020.574461/full` | Sensory Overload | 07 | DOI 10.3389/fpsyg.2020.574461 sensory processing |
| 7 | `frontiersin.org/articles/10.3389/fpsyg.2020.564206/full` | Calming Sounds | 07 | DOI 10.3389/fpsyg.2020.564206 music therapy |
| 8 | `pubmed.ncbi.nlm.nih.gov/25928655/` | Bedtime Routines | 02 | PubMed 25928655 |
| 9 | `pubmed.ncbi.nlm.nih.gov/28838255/` | Bedtime Routines | 03 | PubMed 28838255 |
| 10 | `sciencedirect.com/science/article/pii/S1053810020300982` | Sound Therapy | 07 | ScienceDirect S1053810020300982 consciousness sound |
| 11 | `rcpch.ac.uk/resources/health-impacts-screen-time-guide-clinicians-parents` | App Comparisons | 06, 07 | RCPCH screen time health impacts guide clinicians |
| 12 | `autism.org.uk/advice-and-guidance/topics/mental-health/after-school-restraint-collapse` | Sensory Overload | 04 | National Autistic Society after school restraint collapse |
| 13 | `autism.org.uk/advice-and-guidance/topics/communication/visual-supports` | Bedtime Routines | 03 | National Autistic Society visual supports communication |
| 14 | `understood.org/en/articles/sensory-diet` | Sensory Overload | 06 | Understood.org sensory diet children |
| 15 | `understood.org/articles/executive-function-disorder-adhd` | App Comparisons | 01 | Understood.org executive function disorder ADHD |
| 16 | `chadd.org/about-adhd/sensory-processing-issues/` | Calming Sounds | 01 | CHADD sensory processing issues ADHD |
| 17 | `zonesofregulation.com/learn-more.html` | Emotional Regulation | 04, 07 | Zones of Regulation learn more official site |
| 18 | `sleepfoundation.org/children-and-sleep/separation-anxiety-and-sleep` | Bedtime Routines | 06 | Sleep Foundation separation anxiety children sleep |

**Execution Steps:**
1. Research all 18 URLs via Perplexity (batch by domain for efficiency: NHS, Frontiers, PubMed/Academic, Other)
2. Build mapping table: `old_url` -> `new_url` + updated `author`/`year`/`title` if source changed
3. For each affected article, update both frontmatter `external_citations` YAML and inline body text
4. Verify: grep all articles for remaining old URLs (expect 0 matches)
5. Spot-check 3-4 replacement URLs to confirm they load
6. Commit

**Acceptance Criteria:**
- [x] All 18 broken URLs researched via Perplexity
- [x] Mapping table built with new URL (or "remove" decision) for each
- [x] All ~22 article locations updated (both frontmatter + inline body text)
- [x] Grep for each of the 18 old URL patterns returns 0 matches across all articles
- [x] 3-4 replacement URLs verified working via WebFetch or curl
- [x] No YAML syntax errors introduced in frontmatter
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 46 for full context. Fix 18 broken citation URLs across 7 pillars. Use `mcp__perplexity__perplexity_search` to research each broken URL — find the same source at a new URL first, then find an equivalent authoritative replacement if not found. Each citation appears in TWO places per article: (1) frontmatter `external_citations` YAML array with `url`, `author`, `year`, `title` fields, and (2) inline body text as `[Author], Year: [Title](URL)` markdown links. Update BOTH locations for every fix. After all changes, grep for each old URL pattern to verify 0 matches. Spot-check 3-4 replacements with WebFetch. Commit when done.

**Status:** PASS

**Handoff:**
- **Done:** Fixed 18 broken citation URLs across 19 articles in 7 pillars. Updated both frontmatter YAML and inline body text for each. Verified 0 matches for all old URL patterns in article files. Spot-checked 4 replacement URLs (NAS, PMC, Zones of Regulation, NHS) — all load successfully.
- **Decisions:** Where same source moved to new URL, kept original author/title. Where source removed entirely, found closest authoritative replacement. Frontiers URLs changed from `/articles/` to `/journals/psychology/articles/` path format. PubMed URLs migrated to PMC full-text equivalents.
- **Next:** Task 45 (Regenerate cross-pillar summary + create PR) is the only remaining task.

---
