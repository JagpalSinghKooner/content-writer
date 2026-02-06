# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| Tasks 20-44: Audit System Build + Full Audit + Cross-Pillar Cleanup | PASS |
| Task 45: Regenerate Cross-Pillar Summary + Create PR | pending |
| Task 46: Fix Broken Citation URLs (404s) | PASS |
| Task 47: Replace 5 Removed Citations | PASS |

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

## Task 47: Replace 5 Removed Citations

**Objective:** Add replacement citations for 5 broken URLs that were removed (not replaced) during Task 46. Each article lost evidence backing that needs restoring.

**Context:** Task 46 fixed 18 broken citation URLs. 13 were replaced with working alternatives, but 5 were deleted entirely without replacement. This task restores those gaps.

**Citation Format (both must be updated per fix):**
- **Frontmatter:** `external_citations` YAML array with `url`, `author`, `year`, `title` fields
- **Inline body:** `[Author], Year: [Title](URL)` markdown links woven into text where the topic is discussed

**5 Citations to Replace:**

| # | Removed URL | Article(s) | Evidence Gap | Proposed Replacement |
|---|------------|------------|-------------|---------------------|
| 1 | `nhs.uk/conditions/sensory-processing-disorder/` | sensory-overload/01, 08 | NHS authority for sensory processing claims | Sheffield Children's NHS: Sensory Processing Difficulties (`sheffieldchildrens.nhs.uk/services/child-development-and-neurodisability/sensory-processing-difficulties/`) |
| 2 | `frontiersin.org/articles/10.3389/fpsyg.2021.767782/full` | autistic-meltdowns/03 | Burnout-specific research (article discusses "masking debt" but only cites camouflaging research) | Raymaker et al., 2020: Defining Autistic Burnout (`pmc.ncbi.nlm.nih.gov/articles/PMC7313636/`) |
| 3 | `sciencedirect.com/science/article/pii/S1053810020300982` | sound-therapy/07 | Peer-reviewed neuroscience backing for sound-brain state claims | Koelsch et al., 2019: Neural Underpinnings of Auditory Perception (`pmc.ncbi.nlm.nih.gov/articles/PMC6633293/`) |
| 4 | `autism.org.uk/.../after-school-restraint-collapse` | sensory-overload/04 | Source specifically about after-school restraint collapse pattern | National Autistic Society: Autistic Burnout (`autism.org.uk/advice-and-guidance/professional-practice/autistic-burnout`) |
| 5 | `sleepfoundation.org/children-and-sleep/separation-anxiety-and-sleep` | bedtime-routines/06 | Authoritative source on separation anxiety at bedtime | AAP, 2022: Separation Anxiety and Sleeping (`healthychildren.org/English/healthy-living/sleep/Pages/separation-anxiety-and-sleeping.aspx`) |

**Execution Steps:**
1. Verify all 5 proposed replacement URLs load (WebFetch or curl)
2. For each article, update frontmatter `external_citations` YAML (add new entry)
3. For each article, add inline citation in body text where topic is discussed
4. Grep for old URL patterns to confirm none crept back
5. Grep for new URLs to confirm they appear in correct articles
6. Commit

**Acceptance Criteria:**
- [x] All 5 replacement URLs verified working
- [x] 6 article files updated (both frontmatter + inline body text)
- [x] Grep confirms new citations present in correct articles
- [x] No YAML syntax errors introduced
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 47 for full context. Add replacement citations for 5 URLs that were removed during Task 46. First verify each proposed replacement URL loads via WebFetch. Then for each of the 6 article files, add the new citation to both (1) frontmatter `external_citations` YAML and (2) inline body text as `[Author], Year: [Title](URL)`. Grep to verify. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Added 5 replacement citations across 6 article files. Each citation updated in both frontmatter `external_citations` YAML and inline body text.
- **Decisions:**
  - Citation #3 (sound-therapy/07) was changed from the proposed "Koelsch et al., 2019" (PMC6633293 was actually Brancucci et al., 2011) to Zaatar et al., 2023: "The transformative power of music: Insights into neuroplasticity, health, and disease" (PMC10765015), which better supports the sound-brain state claims.
  - All other 4 citations used as proposed and verified working.
- **Next:** Task 45 (Regenerate Cross-Pillar Summary + Create PR) remains pending.

---
