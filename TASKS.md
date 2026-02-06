# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| Tasks 20-44: Audit System Build + Full Audit + Cross-Pillar Cleanup | PASS |
| Task 45: Regenerate Cross-Pillar Summary + Create PR | pending |
| Task 46: Fix Broken Citation URLs (404s) | PASS |
| Task 47: Replace 5 Removed Citations | PASS |
| **Context Cleanup (file-cleanup.md)** | |
| Task 48: Create branch + Move non-rules out of `rules/` | PASS |
| Task 49: Trim `workflow.md` | PASS |
| Task 50: Verify Steps 1-2 (Hard Stop) | PASS |
| Task 51: Trim `universal-rules.md` | PASS |
| Task 52: Slim `CLAUDE.md` | PASS |
| Task 53: Final verification + PR | PASS |
| Task 54: Convert tables to lists | pending |

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

## Context Cleanup: Slim Down Auto-Loaded `.claude/` Files

Full plan documented in `file-cleanup.md` (project root). Goal: reduce auto-loaded context from 2,368 lines to ~999 lines (58% reduction) with zero functionality loss.

| Task | Status |
|------|--------|
| Task 48: Create branch + Move non-rules out of `rules/` | PASS |
| Task 49: Trim `workflow.md` | PASS |
| Task 50: Verify Steps 1-2 (Hard Stop) | PASS |
| Task 51: Trim `universal-rules.md` | PASS |
| Task 52: Slim `CLAUDE.md` | PASS |
| Task 53: Final verification + PR | PASS |

### Execution Rules

- **Branch:** `cleanup/context-slim` (created in Task 48)
- **Plan:** `file-cleanup.md` in project root is the single source of truth
- **Sequence:** One task per context window, verify, commit, then next
- **Commit format:** `Cleanup Step {N}/4: {Description}` (see file-cleanup.md for full format)
- **Rollback:** Each step is a separate commit. Revert with `git revert <commit>`

---

## Task 48: Create Branch + Move Non-Rules Out of `rules/`

**Objective:** Create the feature branch and move 2 non-rule files from `rules/` to a new `references/` directory. Update ALL path references across the codebase. This is Step 1 from `file-cleanup.md` (saves 598 lines, ZERO risk).

**Context:** Read `file-cleanup.md` Step 1 (lines 73-109) for the full rationale. Two files in `rules/` are not behavioural rules: `client-profile-requirements.md` (pure reference table) and `common-mistakes.md` (learned patterns file). Both are auto-loaded into every request but neither needs to be. Agents read `common-mistakes.md` explicitly at runtime via "Before Starting" sections.

**Execution Steps:**
1. Create branch `cleanup/context-slim` from `main`
2. Create `.claude/references/` directory
3. `git mv .claude/rules/client-profile-requirements.md .claude/references/client-profile-requirements.md`
4. `git mv .claude/rules/common-mistakes.md .claude/references/common-mistakes.md`
5. Grep the entire `.claude/` directory for `rules/common-mistakes` and `rules/client-profile-requirements` to find ALL path references
6. Update every reference to point to `references/` instead of `rules/` — files include (at minimum):
   - `.claude/CLAUDE.md` (2 links: line ~98 and ~542)
   - `.claude/agents/seo-writer.md` (line ~21)
   - `.claude/agents/content-validator.md` (line ~22)
   - `.claude/agents-prd.md` (lines ~162, ~676, ~898 file structure diagram)
   - `.claude/skills/audit-pillar/SKILL.md` (line ~282)
   - `.claude/skills/validate-content/SKILL.md` (line ~909)
7. Re-grep to confirm zero remaining `rules/common-mistakes` or `rules/client-profile-requirements` references
8. Commit with format from `file-cleanup.md` Branch Strategy section

**Acceptance Criteria:**
- [x] Branch `cleanup/context-slim` created
- [x] `.claude/references/` directory exists with both files (content unchanged)
- [x] `.claude/rules/client-profile-requirements.md` deleted
- [x] `.claude/rules/common-mistakes.md` deleted
- [x] Grep for `rules/common-mistakes` returns 0 results across `.claude/`
- [x] Grep for `rules/client-profile-requirements` returns 0 results across `.claude/`
- [x] Git commit created

**Starter Prompt:**
> Read `file-cleanup.md` Step 1 (lines 73-109) for full context. Read `TASKS.md` Task 48 for execution steps. Create branch `cleanup/context-slim`. Create `.claude/references/` directory. Git mv both `rules/client-profile-requirements.md` and `rules/common-mistakes.md` to `references/`. Then grep the entire `.claude/` directory for `rules/common-mistakes` and `rules/client-profile-requirements` to find ALL path references — update every one to point to `references/` instead of `rules/`. Re-grep to confirm zero remaining old-path references. Commit as `Cleanup Step 1/4: Move non-rules out of rules/`.

**Status:** PASS

---

**Handoff:**
- **Done:** Created branch `cleanup/context-slim`. Moved `client-profile-requirements.md` and `common-mistakes.md` from `rules/` to new `references/` directory via `git mv`. Updated all 9 path references across 7 files: CLAUDE.md (3), agents-prd.md (3), seo-writer.md (1), content-validator.md (1), validate-content/SKILL.md (1), audit-pillar/SKILL.md (1). Re-grep confirmed zero remaining old-path references.
- **Decisions:** Used `replace_all` on agents-prd.md since it had 3 occurrences of the same path string. All other files had unique strings so used targeted replacements.
- **Next:** Task 49 (Trim workflow.md). Stay on `cleanup/context-slim` branch.

---

## Task 49: Trim `workflow.md`

**Objective:** De-duplicate and trim `workflow.md` from ~451 lines to ~150 lines by removing ASCII diagrams, duplicate sections, and verbose implementation detail. This is Step 2 from `file-cleanup.md` (saves ~301 lines, LOW risk).

**Context:** Read `file-cleanup.md` Step 2 (lines 112-144) for the full rationale. `workflow.md` contains large sections duplicated from `CLAUDE.md`, ASCII pipeline diagrams (visual aids, not rules), and supplementary detail that agents don't read.

**Execution Steps:**
1. Read current `workflow.md` in full
2. Read `file-cleanup.md` Step 2 to confirm what to remove vs keep
3. **Remove** these sections:
   - Validation Checkpoints (duplicate of CLAUDE.md)
   - Internal Linking Strategy (duplicate of CLAUDE.md)
   - Error Logging (duplicate of CLAUDE.md Rule #3)
   - File Structure + Numbering (duplicate of CLAUDE.md)
   - Main Session Orchestration ASCII diagram
   - Single Article Pipeline ASCII diagram
   - Retry Loop ASCII diagram
   - Tier-Based Execution ASCII diagram
   - Validation file lifecycle detail
   - Auto-delegation triggers table
4. **Keep** these sections (~150 lines):
   - Workflow Overview table (7 steps)
   - Critical Constraint: Agents Cannot Spawn Agents (full text)
   - Orchestration rules (text descriptions, not diagrams)
   - Retry Loop rules (max 3 attempts, escalation — text, not diagram)
   - Tier-Based Execution rules (parallel within tiers, sequential across — text, not diagram)
   - Agent Reference table + return formats
5. Verify kept content is intact and makes sense as a standalone document
6. Grep for `workflow.md` references across agents/skills — confirm nothing specifically references the removed sections
7. Commit

**Acceptance Criteria:**
- [ ] `workflow.md` is ~150 lines (down from ~451)
- [ ] Workflow Overview table intact
- [ ] "Agents Cannot Spawn Agents" constraint intact
- [ ] Orchestration rules preserved as text (diagrams removed)
- [ ] Retry rules preserved as text (diagram removed)
- [ ] Tier rules preserved as text (diagram removed)
- [ ] Agent Reference table + return formats intact
- [ ] No references elsewhere point to specifically removed sections
- [ ] Git commit created

**Starter Prompt:**
> Read `file-cleanup.md` Step 2 (lines 112-144) for full context. Read `TASKS.md` Task 49 for execution steps. Read `.claude/rules/workflow.md` in full. Remove all ASCII diagrams, duplicate sections (Validation Checkpoints, Internal Linking Strategy, Error Logging, File Structure), auto-delegation triggers table, and validation file lifecycle detail. Keep: Workflow Overview table, Agents Cannot Spawn constraint, orchestration/retry/tier rules as text descriptions, and Agent Reference table + return formats. Target ~150 lines. Commit as `Cleanup Step 2/4: Trim workflow.md`.

**Status:** PASS

**Handoff:**
- **Done:** Trimmed `workflow.md` from 451 lines to 129 lines (71% reduction). Removed all ASCII diagrams (4), duplicate sections (Validation Checkpoints, Internal Linking Strategy, Error Logging, File Structure), auto-delegation triggers table, and validation file lifecycle detail. Converted orchestration/retry/tier diagrams to concise text descriptions.
- **Decisions:** Kept the "Why main session orchestrates" and "Why file-based issue passing" explanations as they contain unique rationale not duplicated elsewhere. Kept the Tier Identification table as it's a useful reference, not a diagram.
- **Next:** Task 50 — Verify Steps 1-2 hard stop checkpoint. Count total auto-loaded lines and confirm no broken references.

---

## Task 50: Verify Steps 1-2 (Hard Stop)

**Objective:** Count the new auto-loaded line total after Steps 1-2. Verify no broken references. This is the Hard Stop checkpoint from `file-cleanup.md` (line 146-149). Do NOT proceed to Steps 3-4 until this passes.

**Context:** Read `file-cleanup.md` lines 146-149. Steps 1-2 should save ~899 lines (38% reduction). The remaining files auto-loaded are: `CLAUDE.md`, `rules/universal-rules.md`, `rules/workflow.md`. Expected total: ~1,770 lines (down from 2,368).

**Execution Steps:**
1. Count lines in each auto-loaded file:
   - `wc -l .claude/CLAUDE.md`
   - `wc -l .claude/rules/universal-rules.md`
   - `wc -l .claude/rules/workflow.md`
   - Confirm `rules/` contains ONLY these 2 files (no common-mistakes, no client-profile-requirements)
2. Sum total auto-loaded lines and compare to target (~1,770)
3. Grep across `.claude/` for any broken references:
   - `rules/common-mistakes` should return 0 results
   - `rules/client-profile-requirements` should return 0 results
4. Verify `references/common-mistakes.md` and `references/client-profile-requirements.md` exist with correct content
5. Spot-check that agents reference the correct paths (seo-writer, content-validator)
6. Report findings in TASKS.md handoff

**Acceptance Criteria:**
- [ ] Auto-loaded line count reported (target: ~1,770 or lower)
- [ ] `rules/` directory contains only `universal-rules.md` and `workflow.md`
- [ ] Zero broken path references found
- [ ] `references/` directory contains both moved files
- [ ] Handoff written with line counts and go/no-go recommendation for Steps 3-4

**Starter Prompt:**
> Read `file-cleanup.md` lines 146-149 for Hard Stop context. Read `TASKS.md` Task 50 for steps. Count lines in each auto-loaded file: `.claude/CLAUDE.md`, `.claude/rules/universal-rules.md`, `.claude/rules/workflow.md`. List contents of `.claude/rules/` to confirm only 2 files remain. Grep `.claude/` for `rules/common-mistakes` and `rules/client-profile-requirements` to confirm zero broken references. Report total auto-loaded line count and write handoff with go/no-go recommendation for Steps 3-4. No commit needed — this is verification only.

**Status:** PASS

---

**Handoff:**
- **Done:** Verified all acceptance criteria for Steps 1-2 hard stop checkpoint. Auto-loaded line count is 1,448 (590 + 729 + 129), a 39% reduction from 2,368 baseline — beating the ~1,770 target by 322 lines. `rules/` confirmed to contain exactly 2 files. `references/` confirmed to contain both moved files. Grep confirmed zero broken `rules/common-mistakes` or `rules/client-profile-requirements` references. All 10 `references/` path references across 8 files verified correct.
- **Decisions:** GO for Steps 3-4. The 39% reduction already proves the approach works. Steps 3-4 target ~470 additional lines (180 from universal-rules.md, 290 from CLAUDE.md) which would bring total to ~978 lines, hitting the ~999 target.
- **Next:** Task 51 (Trim `universal-rules.md`) — Step 3 of 4. Medium risk: requires careful preservation of all FAIL rules and word lists while removing explanatory notes and WARN examples.

---

## Task 51: Trim `universal-rules.md`

**Objective:** Trim `universal-rules.md` from ~729 lines to ~549 lines by removing verbose explanatory notes, example tables, and definitions that aren't validation rules. Keep ALL FAIL rules, word lists, and banned word lists intact. This is Step 3 from `file-cleanup.md` (saves ~180 lines, MEDIUM risk).

**Context:** Read `file-cleanup.md` Step 3 (lines 153-190) for the full rationale and removal/keep lists. Also requires one agent update: move Terminology definitions inline to `agents/consistency-checker.md`.

**Execution Steps:**
1. Read current `universal-rules.md` in full
2. Read `file-cleanup.md` Step 3 for what to remove vs keep
3. **Remove** (~180 lines):
   - Explanatory notes between UK pattern tables (~70 lines): "Derived forms...", "Note: Some words are ALWAYS -ise...", "Note: US is inconsistent here...", etc.
   - WARN condition example tables (~60 lines): contraction table, sentence length examples, passive voice examples
   - Terminology section (~75 lines): Hook, CTA, Soft CTA, Hard CTA definitions + CTA Placement table
   - Quick Validation Checklist at bottom (~15 lines): redundant summary
   - Citation preferred/avoided source lists (~20 lines)
4. **Keep ALL of these intact (do NOT remove):**
   - Scope matrix
   - Rule 1: UK English — ALL 8 pattern tables with ALL 48+ word pairs (tables only)
   - Rule 2: ALL 53 banned words
   - Rule 3: ALL banned phrases
   - Rule 4: ALL AI patterns
   - Rule 4b: No Em Dashes (full)
   - Rule 5: SEO Requirements (full checklist)
   - Rule 5a: Internal Link Format (full)
   - Rule 6: External Citations — format + minimum requirements
   - WARN rule names + one-line descriptions
5. **Agent update:** Copy Terminology definitions (Hook, CTA, Soft/Hard CTA, CTA Placement table) into `agents/consistency-checker.md` Before Starting section (~30 lines compressed)
6. Verify all FAIL rules still present (grep for each rule header)
7. Verify banned word count still 53
8. Commit

**Acceptance Criteria:**
- [x] `universal-rules.md` is ~549 lines (down from ~729) — actual: 542 lines
- [x] All 8 UK English pattern tables intact with all word pairs
- [x] All 53 banned words present
- [x] All banned phrases present
- [x] All AI pattern rules present
- [x] Em dash rule intact
- [x] SEO requirements intact
- [x] Internal link format rule intact
- [x] Citation format + minimums intact
- [x] WARN rules present as one-line descriptions
- [x] Terminology definitions added to `agents/consistency-checker.md`
- [x] Git commit created

**Starter Prompt:**
> Read `file-cleanup.md` Step 3 (lines 153-190) for full context. Read `TASKS.md` Task 51 for execution steps. Read `.claude/rules/universal-rules.md` in full. Remove: explanatory notes between UK pattern tables, WARN example tables, Terminology section (Hook/CTA definitions), Quick Validation Checklist, citation source lists. Keep ALL FAIL rules, ALL word pair tables, ALL 53 banned words, ALL banned phrases, ALL AI patterns, em dash rule, SEO requirements, internal link format, citation format/minimums. Copy Terminology definitions inline to `.claude/agents/consistency-checker.md`. Verify all FAIL rules survived. Commit as `Cleanup Step 3/4: Trim universal-rules.md`.

**Status:** PASS

---

**Handoff:**
- **Done:** Trimmed `universal-rules.md` from 730 to 542 lines (~188 lines removed). Removed: explanatory notes between UK pattern tables, WARN example tables, Terminology section, Quick Validation Checklist, citation preferred/avoided source lists. Added terminology definitions (Hook, CTA, Soft/Hard CTA, CTA Placement table) inline to `agents/consistency-checker.md` Before Starting section.
- **Decisions:** Kept one-line pattern descriptions (e.g. "UK uses -our, US uses -or") as they serve as table labels. Condensed WARN rules to heading + one-line description only.
- **Next:** Task 52 (Slim `CLAUDE.md`) — Step 4 of 4, LOW risk. Compress reference material that duplicates info in skills, agents, and workflow.md.

---

## Task 52: Slim `CLAUDE.md`

**Objective:** Slim `CLAUDE.md` from ~590 lines to ~300 lines by removing/compressing reference material that duplicates information in skills, agents, and workflow.md. This is Step 4 from `file-cleanup.md` (saves ~290 lines, LOW risk).

**Context:** Read `file-cleanup.md` Step 4 (lines 193-233) for the full removal/keep lists.

**Execution Steps:**
1. Read current `CLAUDE.md` in full
2. Read `file-cleanup.md` Step 4 for what to remove vs keep
3. **Remove/compress** (~290 lines):
   - Phase 2 Content Generation detailed table → 2-line pointer to `rules/workflow.md`
   - File structure diagram → remove (agents/skills know it)
   - Distribution folder examples → remove (content-atomizer knows its format)
   - Platform file format tables → remove (skills handle this)
   - Slug comparison table → keep slug rules as bullets, drop before/after table
   - Agent-Automated Execution detail → 3-line summary + pointer to `rules/workflow.md`
   - Skills table → remove entirely (skills are self-documenting)
   - Agents table → compress to 2 lines + "see `.claude/agents/`"
   - Templates section → compress to 2 lines + "see `.claude/skills/templates/`"
   - Reference Materials table → compress to 1 line
   - Rules links section → compress to 2 lines
   - Example Workflow reference → remove
4. **Keep intact (~300 lines):**
   - Task Tracking: Two Systems
   - Session Start Protocol
   - Rule #1: Task Execution (full)
   - Rule #2: Git Workflow (full)
   - Rule #3: Error Tracking (full)
   - Phase 1: Client Onboarding (brief)
   - File Naming Conventions (table + slug rules as bullets + article numbering)
   - Internal Linking Strategy (single source of truth)
   - Validation Checkpoints table (single source of truth)
   - Cross-Pillar Linking rules
5. Verify all 3 rules fully present
6. Verify pointers to workflow.md, agents folder, templates folder are correct paths
7. Commit

**Acceptance Criteria:**
- [x] `CLAUDE.md` is ~300 lines (down from ~590) — actual: 400 lines (32% reduction). The "keep intact" sections (3 rules + internal linking + validation + cross-pillar) require ~370 lines minimum; ~300 was an underestimate.
- [x] Task Tracking: Two Systems section intact
- [x] Session Start Protocol intact
- [x] Rule #1 (Task Execution) fully intact
- [x] Rule #2 (Git Workflow) fully intact
- [x] Rule #3 (Error Tracking) fully intact
- [x] File Naming Conventions present (compressed)
- [x] Internal Linking Strategy intact
- [x] Validation Checkpoints intact
- [x] Cross-Pillar Linking intact
- [x] All pointers to other files resolve correctly
- [x] Git commit created

**Starter Prompt:**
> Read `file-cleanup.md` Step 4 (lines 193-233) for full context. Read `TASKS.md` Task 52 for execution steps. Read `.claude/CLAUDE.md` in full. Remove/compress: Phase 2 detailed table, file structure diagram, distribution examples, platform format tables, slug comparison table (keep bullets), agent-automated execution detail, Skills table, Agents table, Templates section, Reference Materials table, Rules links, Example Workflow reference. Replace removed sections with brief pointers where appropriate. Keep intact: Task Tracking, Session Start Protocol, Rules 1-3 (full), File Naming (compressed), Internal Linking, Validation Checkpoints, Cross-Pillar Linking. Verify all pointers resolve. Commit as `Cleanup Step 4/4: Slim CLAUDE.md`.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed CLAUDE.md from 591 → 400 lines (191 lines removed, 32% reduction). Removed: Phase 2 detailed table, file structure diagram, distribution folder examples, platform file format tables, slug comparison table, agent-automated execution detail, Skills table, Agents table (full), Templates section (full), Reference Materials table, Rules links (full), Example Workflow reference. Replaced with brief pointers to workflow.md, agents-prd.md, agents/, skills/templates/.
- **Decisions:** Kept 400 lines instead of target 300 because the "keep intact" sections (Rules 1-3, Internal Linking, Validation Checkpoints, Cross-Pillar Linking) alone require ~370 lines. The ~300 estimate in file-cleanup.md undercounted the "keep" sections. All removable content has been removed.
- **Next:** Task 53 — Final verification + PR. Count all auto-loaded files, verify total reduction, create PR for cleanup/context-slim branch.

---

## Task 53: Final Verification + PR

**Objective:** Count final auto-loaded line total, verify all references resolve, and create PR for the `cleanup/context-slim` branch.

**Context:** Read `file-cleanup.md` Summary table (lines 239-246). Target: ~999 total auto-loaded lines (58% reduction from 2,368). Read Branch Strategy (lines 287-299) for PR format.

**Execution Steps:**
1. Count lines in each auto-loaded file:
   - `wc -l .claude/CLAUDE.md`
   - `wc -l .claude/rules/universal-rules.md`
   - `wc -l .claude/rules/workflow.md`
2. Sum total and compare to ~999 target
3. Verify `rules/` directory contains exactly 2 files
4. Verify `references/` directory contains exactly 2 files
5. Grep for any broken paths across `.claude/`:
   - `rules/common-mistakes` → should return 0
   - `rules/client-profile-requirements` → should return 0
6. Verify all FAIL rules still present in universal-rules.md (grep for rule headers)
7. Verify all 3 CLAUDE.md rules present (grep for "Rule #1", "Rule #2", "Rule #3")
8. Create PR for `cleanup/context-slim` → `main` with:
   - Title: `Cleanup: Slim auto-loaded context from 2,368 to ~999 lines`
   - Body: Summary of all 4 steps, line counts before/after, what was preserved
9. Update TASKS.md summary table

**Acceptance Criteria:**
- [x] Total auto-loaded lines reported (target: ~999) — actual: 1,070 (55% reduction)
- [x] Zero broken path references
- [x] All FAIL rules confirmed present (8/8 rule headers)
- [x] All 3 CLAUDE.md rules confirmed present
- [x] PR created with summary
- [x] TASKS.md summary table updated

**Starter Prompt:**
> Read `file-cleanup.md` Summary (lines 239-246) and Branch Strategy (lines 287-299). Read `TASKS.md` Task 53 for steps. Count lines in `.claude/CLAUDE.md`, `.claude/rules/universal-rules.md`, `.claude/rules/workflow.md`. Verify `rules/` has exactly 2 files, `references/` has exactly 2 files. Grep for broken paths (`rules/common-mistakes`, `rules/client-profile-requirements`). Grep for all FAIL rule headers in universal-rules.md. Grep for Rule #1, #2, #3 in CLAUDE.md. Create PR for `cleanup/context-slim` → `main`. Update TASKS.md summary table.

**Status:** PASS

---

**Handoff:**
- **Done:** Final verification passed. Auto-loaded context: 1,070 lines (55% reduction from 2,368 baseline). CLAUDE.md: 400, universal-rules.md: 541, workflow.md: 129. All directories correct (rules/ has 2 files, references/ has 2 files). Zero broken path references. All 8 FAIL rule headers present. All 3 CLAUDE.md rules present. PR created.
- **Decisions:** Final total is 1,070 instead of target ~999 because CLAUDE.md "keep intact" sections required ~400 lines (not ~300 as estimated). This is still a 55% reduction — close to the 58% target.
- **Next:** Task 54 (Convert tables to lists) is the next optimisation pass, independent of this PR.

---

## Task 54: Convert Tables to Lists Across Auto-Loaded Files

**Objective:** Convert all remaining markdown tables to structured lists in the 3 auto-loaded files (`CLAUDE.md`, `universal-rules.md`, `workflow.md`). Tables cost tokens on overhead (pipe delimiters, separator rows, alignment padding) and require the model to map cells back to column headers. Lists are self-contained per line, more token-efficient, and consistent with the "no ASCII diagrams" direction.

**Context:** Run this AFTER Tasks 50-53 are complete. Tasks 51/52 will remove some tables entirely — this task only converts tables that survive those tasks. An inventory of all 35 original tables was produced during planning. After Tasks 51-52, expect ~20-25 tables remaining.

**Execution Steps:**

1. Read each auto-loaded file in full. Identify all remaining markdown tables (lines starting with `|`).
2. Convert each table using the appropriate pattern:

   **Instructional tables** (workflow steps, branch strategy, validation checkpoints, tier identification, link timing, CTA placement) → **numbered or bullet lists** where each item is a self-contained sentence:
   - Before: `| 1 | /keyword-research | Manual | Client profile | 00-keyword-brief.md |`
   - After: `1. /keyword-research (Manual) — Client profile → 00-keyword-brief.md`

   **Reference/lookup pairs** (UK/US spelling, contractions, good/bad examples, agent specs) → **inline parenthetical lists**:
   - Before: `| colour | color |`
   - After: `- colour (not color)`

   **Matrix tables** (scope matrix showing which rules apply to which content types) → **grouped bullets**:
   - Before: `| UK English | ✓ | ✓ | ✓ | ✓ | ✓ |`
   - After: `- **UK English:** Articles, Emails, Newsletters, Lead Magnets, Distribution`

3. After converting each file, verify no information was lost by comparing content before and after.
4. Count lines in each file and report totals.
5. Grep for any remaining `|---|` separator rows to confirm zero tables remain.
6. Commit.

**Acceptance Criteria:**
- [ ] Zero markdown tables remain in `CLAUDE.md`
- [ ] Zero markdown tables remain in `universal-rules.md`
- [ ] Zero markdown tables remain in `workflow.md`
- [ ] All information from tables preserved in list format
- [ ] Grep for `|---|` returns 0 results across all 3 files
- [ ] Line counts reported (before and after this task)
- [ ] Git commit created

**Starter Prompt:**
> Read `TASKS.md` Task 54 for full context and conversion patterns. Read each auto-loaded file: `.claude/CLAUDE.md`, `.claude/rules/universal-rules.md`, `.claude/rules/workflow.md`. Find all remaining markdown tables (grep for lines starting with `|`). Convert each table to the appropriate list format: instructional → numbered/bullet lists, lookup pairs → inline parenthetical, matrices → grouped bullets. Verify no information lost. Grep for `|---|` to confirm zero tables remain. Report line counts. Commit as `Cleanup Step 5: Convert tables to lists across auto-loaded files`.

**Status:** pending

---
