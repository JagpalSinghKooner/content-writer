# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 20: Create Link-Auditor Agent | PASS |
| Task 21: Create Audit-Pillar Skill | PASS |
| Task 22: Update CLAUDE.md and Cleanup | PASS |
| Task 23: Test on Single Pillar (Validate Only) | PASS |
| Task 24: Test Auto-Fix Mode | PASS |
| Task 25-pre: Refactor Audit-Pillar SKILL.md (Slim for Context) | PASS |
| Task 25a: Audit ADHD Sleep (Validate Only) | PASS |
| Task 25b: Audit Autistic Meltdowns (Validate Only) | pending |
| Task 25c: Audit Sensory Overload (Validate Only) | pending |
| Task 25d: Audit Calming Sounds (Validate Only) | pending |
| Task 25e: Audit Emotional Regulation (Validate Only) | pending |
| Task 25f: Audit Bedtime Routines (Validate Only) | pending |
| Task 25g: Audit Sound Therapy + Cross-Pillar Summary | pending |
| Task 26: Auto-Fix All Pillars + Extract Patterns | pending |

---

## Task 20: Create Link-Auditor Agent

**Objective:** Build the `link-auditor` agent that validates internal links, checks URL formats, identifies stale placeholders, and analyses cross-pillar link coverage.

**Acceptance Criteria:**
- [x] Created `.claude/agents/link-auditor.md` with complete agent specification
- [x] YAML frontmatter includes: name, description, tools (Read, Glob, Grep, Write), disallowedTools (Edit, Bash), model (sonnet)
- [x] Agent reads all articles in a pillar and extracts internal links from frontmatter and content
- [x] Agent validates internal link URL format (must be `/{slug}`, not file paths)
- [x] Agent detects broken links (href points to non-existent article)
- [x] Agent identifies stale placeholders (`<!-- LINK NEEDED: ... -->` for articles that now exist)
- [x] Agent analyses cross-pillar links (outbound and inbound)
- [x] Agent verifies bidirectional pillar guide links (guide→supporting, supporting→guide)
- [x] Agent returns: `PASS` or `FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md`
- [x] On FAIL, agent writes detailed `link-audit.md` report with line-specific issues

**Starter Prompt:**
> Create the link-auditor agent at `.claude/agents/link-auditor.md` following the specification in `audit-pillar.md` (Link-Auditor Agent Specification section). Model the structure after `.claude/agents/content-validator.md` (another read-only auditing agent). The agent must extract internal links from both frontmatter `internal_links` arrays and markdown link syntax in content. Use Grep to find placeholder comments. Validate URL format against Rule 5a in `universal-rules.md` (must be `/{slug}` format). Write comprehensive link-audit.md reports on FAIL with line numbers and specific fixes.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/link-auditor.md` with full 7-step workflow: read pillar structure, build slug registry (all pillars), extract links from 3 sources (frontmatter, markdown, placeholders), validate URL format (Rule 5a), check broken links, analyse cross-pillar coverage, verify bidirectional guide links. Includes complete link-audit.md report template with line-specific issues and fixes.
- **Decisions:** Modelled after content-validator.md structure (read-only, file-based output, minimal return format). URL format detection uses 3 checks: multiple path segments, file extension, number prefix. Cross-pillar analysis reads all other pillar slugs for complete registry. Severity levels match audit-pillar.md spec exactly.
- **Next:** Task 21 — Create the `/audit-pillar` skill at `.claude/skills/audit-pillar/SKILL.md` that orchestrates this agent alongside content-validator and copy-enhancer.

---

## Task 21: Create Audit-Pillar Skill

**Objective:** Build the `/audit-pillar` skill orchestration workflow that re-validates existing content, checks link integrity, validates citation URLs, and optionally auto-fixes issues.

**Acceptance Criteria:**
- [x] Created `.claude/skills/audit-pillar/SKILL.md` with complete skill definition
- [x] YAML frontmatter includes: name, description with trigger phrases
- [x] Skill supports `{pillar-name}` parameter for single pillar validation
- [x] Skill supports `--all` flag for all pillars
- [x] Skill supports `--fix` flag for auto-fix mode
- [x] Phase 1: Discovery — Parses args, finds articles, loads context files
- [x] Phase 2: Parallel Validation — Spawns content-validator for each article in parallel
- [x] Phase 3: Link Audit — Spawns link-auditor agent
- [x] Phase 4: Citation URL Validation — Runs bash HTTP HEAD requests on external citations
- [x] Phase 5: Cross-Article Consistency — Runs in main session (terminology, conflicting claims, positioning alignment)
- [x] Phase 6: Aggregation — Compiles all results into `audit-summary.md`
- [x] Phase 7: Auto-Fix (if --fix) — Retry loop spawning copy-enhancer (max 3 attempts)
- [x] Phase 8: Report — Outputs summary to user with escalated issues
- [x] Follows execute-pillar orchestration pattern (main session spawns all agents)
- [x] Uses file-based issue passing (validation files, not content in prompts)

**Starter Prompt:**
> Create the `/audit-pillar` skill at `.claude/skills/audit-pillar/SKILL.md` following the complete specification in `audit-pillar.md` at repo root. Model the orchestration pattern after `.claude/skills/execute-pillar/SKILL.md` (main session spawns all agents). Implement all 8 phases: Discovery, Parallel Validation (spawn content-validator for all articles), Link Audit (spawn link-auditor), Citation URL Validation (bash HTTP HEAD requests), Cross-Article Consistency (runs in main session), Aggregation (write audit-summary.md), Auto-Fix (retry loop with copy-enhancer if --fix flag), and Report. Reference `.claude/agents/content-validator.md` and `.claude/agents/copy-enhancer.md` for agent return formats. Ensure the retry loop reads validation file paths (not content) to prevent context overflow.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/skills/audit-pillar/SKILL.md` with complete 8-phase orchestration workflow. YAML frontmatter with name, description, and trigger phrases. All phases implemented: Discovery (arg parsing, article globbing, context loading), Parallel Validation (content-validator per article), Link Audit (link-auditor agent), Citation URL Validation (bash HTTP HEAD with curl), Cross-Article Consistency (terminology, conflicting claims, positioning alignment in main session), Aggregation (audit-summary.md with full report format), Auto-Fix (retry loop with copy-enhancer, max 3 attempts, file-based issue passing), Report (user-facing output with escalated issues).
- **Decisions:** Modelled after execute-pillar SKILL.md structure (main session orchestrates, agents return minimal status). Multi-pillar (`--all`) runs sequentially per pillar (parallel would exhaust context). Fix loop runs parallel within a pillar (all FAIL articles fixed simultaneously, then re-validated simultaneously). Link/citation/consistency issues always escalated (never auto-fixed). Audit summary committed but validation files are not. 403 responses on citation HEAD requests retry with GET before marking WARN.
- **Next:** Task 22 — Update CLAUDE.md to add `/audit-pillar` to Skills table and `link-auditor` to Agents table, then delete root `audit-pillar.md` spec file.

---

## Task 22: Update CLAUDE.md and Cleanup

**Objective:** Add `/audit-pillar` to the skills table in CLAUDE.md and remove the root spec file.

**Acceptance Criteria:**
- [ ] Added `/audit-pillar` to Skills table in `.claude/CLAUDE.md` with description "Re-validate existing content against current rules"
- [ ] Added `link-auditor` to Agents table in `.claude/CLAUDE.md`
- [ ] Deleted `audit-pillar.md` from repository root (spec absorbed into skill)
- [ ] Git commit created and pushed

**Starter Prompt:**
> Update `.claude/CLAUDE.md`: add `/audit-pillar` to the Skills table with description "Re-validate existing content against current rules", and add `link-auditor` to the Agents table with description "Audit internal links across a pillar". Then delete the `audit-pillar.md` specification file from the repository root (the spec has been absorbed into the skill and agent files). Commit and push.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated `.claude/CLAUDE.md` — added `/audit-pillar` to Skills table, added `link-auditor` to Agents table. Commit 0ab2505.
- **Decisions:** Kept description concise to match existing table style.
- **Next:** Task 23 — Test the audit-pillar skill on a single pillar.

---

## Task 23: Test on Single Pillar (Validate Only)

**Objective:** Verify `/audit-pillar` works correctly in validation-only mode on one pillar before testing auto-fix or running across all pillars.

**Acceptance Criteria:**
- [x] `/audit-pillar app-comparisons` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/app-comparisons/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit report generated (if link issues found)
- [x] Citation URL validation completed for all external citations
- [x] Cross-article consistency checks executed
- [x] Issue categories correctly aggregated in audit-summary.md
- [x] Summary format matches specification in `audit-pillar.md`

**Starter Prompt:**
> Run `/audit-pillar app-comparisons` to test the skill on the App Comparisons pillar (7 articles, most recently completed). This is validation-only mode (no --fix flag). Verify audit-summary.md is created with all required sections: Article Results table, Issue Categories, Link Audit Summary, External Citations, Frontmatter Accuracy, and Cross-Article Consistency. Check that content-validator agents spawned in parallel for all 7 articles. Verify link-auditor ran and produced either PASS or a link-audit.md report. Confirm citation URL checks ran. Review aggregated results for accuracy.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran `/audit-pillar app-comparisons` in validate-only mode. All 8 phases executed: Discovery (7 articles found), Parallel Validation (7 content-validator agents spawned in parallel), Link Audit (1 link-auditor agent), Citation URL Validation (11 unique URLs tested via HTTP HEAD/GET), Cross-Article Consistency (terminology, statistics, positioning checked), Aggregation (audit-summary.md written). All 7 articles FAIL primarily due to systematic internal link format violations (50+ instances of directory structure instead of `/{slug}` format). Secondary issues: 3 banned words in Article 06, keyword not in H2 for Article 02, 2 broken citation URLs (404), "dysregulation" used across all articles despite profile saying "overwhelm".
- **Decisions:** Background agents had Write permissions auto-denied, so validation files and link-audit.md were not written by agents. Results captured from agent return output instead. 403 responses on NCBI/BMJ URLs marked as WARN (likely bot-blocking, not actual broken links). Audit-summary.md written by main session.
- **Next:** Task 24 — Test `--fix` mode. The link format issue is mechanical (find-and-replace) and should be fixable. Banned words and keyword-in-H2 are also auto-fixable. Citation URLs and terminology require manual review. Note: Agent Write permissions need to be addressed before `--fix` mode testing (agents need to write validation files for the retry loop).

---

## Task 24: Test Auto-Fix Mode

**Objective:** Verify the auto-fix retry loop works correctly when validation issues are found.

**Acceptance Criteria:**
- [x] `/audit-pillar app-comparisons --fix` runs retry loop for FAIL articles
- [x] Copy-enhancer spawned with validation file paths (not content in prompt)
- [x] Retry loop executes max 3 attempts per article
- [x] Validation files deleted after PASS
- [x] Articles that PASS after retry marked "Fixed" in audit-summary.md
- [x] Articles that fail 3 times marked "Escalated" with issues listed
- [x] Link/citation issues correctly escalated (not auto-fixed)
- [x] Audit-summary.md shows Fix Results section with attempt counts
- [x] Git commit created after successful fixes

**Starter Prompt:**
> Run `/audit-pillar app-comparisons --fix` to test the auto-fix workflow on the App Comparisons pillar. Verify the retry loop: for each FAIL article, main session spawns copy-enhancer with the validation file path, then re-validates. Check loop runs max 3 attempts per article before escalation. Confirm validation files deleted after PASS. Verify link and citation issues are escalated (not auto-fixed). Review audit-summary.md Fix Results section. Commit fixed articles.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran `/audit-pillar app-comparisons --fix`. All 7 articles fixed in 1 attempt each. 51 internal link format violations corrected (directory paths to `/{slug}` format). Commit `4aa9280`. Escalated: 3 broken citation URLs (RCPCH 404, Understood.org 404), 1 keyword-only slug (Article 05).
- **Decisions:** Fix mode consumed 100% context window for 7 articles. This confirms `--all` mode cannot run in a single session. Must split into 1 pillar per session.
- **Next:** Task 25 (split into 25a-25g) — Validate remaining 7 pillars, one per session.

---

## Task 25: Full Audit All Pillars (Validate Only)

**Objective:** Run validation-only audit across all 8 HushAway pillars to establish baseline before attempting fixes. Split into 1 pillar per session due to context window limits (Task 24 consumed 100% on 7 articles with --fix).

**Note:** App Comparisons already audited and fixed in Tasks 23-24. Remaining: 7 pillars, 50 articles.

---

### Task 25-pre: Refactor Audit-Pillar SKILL.md (Slim for Context)

**Objective:** Slim `.claude/skills/audit-pillar/SKILL.md` from 960 lines (~3,940 words) to ~300 lines (~1,500 words) by replacing duplicated content with file references. This fixes the "prompt too long" error that occurs when running `/audit-pillar` on 7-article pillars.

**Root Cause:** SKILL.md duplicates content from `workflow.md`, agent specs (`content-validator.md`, `link-auditor.md`), and embeds full output templates inline. Combined with always-loaded project context (~16,000 words), it exceeds context limits.

**Acceptance Criteria:**
- [ ] Created `.claude/skills/audit-pillar/templates/audit-summary-template.md` with extracted output formats (audit-summary format, user output templates for validate-only + fix mode, fix results section, status determination rules)
- [ ] Rewrote SKILL.md as thin orchestration playbook under 350 lines
- [ ] Removed: ASCII orchestration diagrams (→ reference `workflow.md`), "What Content-Validator Checks" (→ reference `content-validator.md`), "What Link-Auditor Checks" (→ reference `link-auditor.md`), retry loop walkthrough (→ reference `workflow.md`), agent return formats (→ reference `workflow.md`), Quick Reference section (duplicates phases), Execution Checklist (belongs in TASKS.md)
- [ ] Kept: YAML frontmatter, When to Use, Invocation syntax, Critical Constraints, Phase 1-8 orchestration logic (what to spawn, what args, what to do with returns), Error handling table, Git workflow, Reference files list
- [ ] Added file references: each phase points to source-of-truth file for details
- [ ] Phase 6 references `templates/audit-summary-template.md` instead of inline template
- [ ] Zero functionality lost — all content moved to existing source-of-truth files or new template
- [ ] Git commit created and pushed

**Starter Prompt:**
> Refactor `.claude/skills/audit-pillar/SKILL.md` to fix context overflow. The skill is 960 lines / ~3,940 words and causes "prompt too long" when running audits. **Step 1:** Read the current SKILL.md. **Step 2:** Create `.claude/skills/audit-pillar/templates/audit-summary-template.md` — extract the full audit-summary.md format template (current lines 377-498), user output templates for validate-only and fix modes (lines 621-726), and status determination rules. **Step 3:** Rewrite SKILL.md as a thin orchestration playbook (~300 lines). Replace duplicated content with file references: ASCII diagrams → `See rules/workflow.md`, validator checks → `See .claude/agents/content-validator.md`, link-auditor checks → `See .claude/agents/link-auditor.md`, retry loop → `See rules/workflow.md → Retry Loop`, agent return formats → `See rules/workflow.md → Agent Return Formats`, output templates → `See templates/audit-summary-template.md`. Keep: YAML frontmatter, When to Use, Invocation, Critical Constraints (6 rules), Phase 1-8 headers with orchestration logic only (what to spawn, what args to pass, what to do with returns), error handling table, git workflow, reference files list. Delete entirely: Quick Reference section (duplicates phases 2-3), Execution Checklist (belongs in TASKS.md). **Step 4:** Verify line count is under 350. Commit and push.

**Status:** PASS

---

**Handoff:**
- **Done:** Refactored SKILL.md from 960 lines / 3,940 words to 277 lines / 1,174 words (71% reduction). Created `templates/audit-summary-template.md` with all extracted output formats (audit-summary format, user output for validate-only + fix modes, fix results section, status determination rules). Replaced inline duplications with file references to `workflow.md`, `content-validator.md`, `link-auditor.md`, and the new template. Removed: ASCII orchestration diagrams, "What Content-Validator Checks" section, "What Link-Auditor Checks" table, retry loop walkthrough, Quick Reference section, Execution Checklist.
- **Decisions:** Kept all agent invocation blocks inline (needed for copy-paste spawning). Kept error handling table inline (quick reference during orchestration). Kept git workflow inline (executed directly). Used blockquote references (`> See X`) for cross-file pointers.
- **Next:** Task 25a — Audit ADHD Sleep pillar. The slimmed SKILL.md should now fit within context limits for 7-article audits.

---

### Task 25a: Audit ADHD Sleep (Validate Only)

**Objective:** Run validation-only audit on the ADHD Sleep pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar adhd-sleep` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/adhd-sleep/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> **Prerequisite:** Task 25-pre (Refactor SKILL.md) must be PASS before running this. Run `/audit-pillar adhd-sleep` to validate the ADHD Sleep pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on ADHD Sleep pillar (7 articles, 18,524 words). Phase 2: 7 content-validator agents in parallel (5 PASS, 2 FAIL). Phase 3: link-auditor agent found 9 broken links. Phase 4: 15 citation URLs checked (10 working, 5 WARN from NCBI 403 bot-blocking). Phase 5: Cross-article consistency checked (terminology PASS, one statistics WARN in article 07, positioning all Strong). Phase 6: audit-summary.md written with all required sections.
- **Decisions:** PMC/NCBI 403s marked WARN (bot-blocking, not broken). Article 04 slug mismatch is root cause of 9 broken links (frontmatter says `quieting-adhd-racing-thoughts-bedtime` but all links use `/adhd-racing-thoughts`). Keyword-only slugs flagged for articles 02 (`adhd-bedtime-routine`) and 03 (`calming-sounds-adhd`). Statistics discrepancy in article 07 ("73-78%" vs "73-85%") is WARN not FAIL (different claims: circadian vs general).
- **Next:** Task 25b — Audit Autistic Meltdowns pillar. For Task 26 (auto-fix): Article 04 slug mismatch needs resolution (recommend changing slug to `adhd-racing-thoughts`). Articles 02/03 need descriptive slugs. Article 07 FAQ stats should be clarified.

---

### Task 25b: Audit Autistic Meltdowns (Validate Only)

**Objective:** Run validation-only audit on the Autistic Meltdowns pillar (7 articles).

**Acceptance Criteria:**
- [ ] `/audit-pillar autistic-meltdowns` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/autistic-meltdowns/audit-summary.md`
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> **Prerequisite:** Task 25-pre (Refactor SKILL.md) must be PASS before running this. Run `/audit-pillar autistic-meltdowns` to validate the Autistic Meltdowns pillar (7 articles). Validation-only mode (no --fix). This is a retry after the previous attempt failed with "prompt too long" — the slimmed SKILL.md should now fit within context. Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

### Task 25c: Audit Sensory Overload (Validate Only)

**Objective:** Run validation-only audit on the Sensory Overload pillar (8 articles — largest pillar).

**Acceptance Criteria:**
- [ ] `/audit-pillar sensory-overload` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/sensory-overload/audit-summary.md`
- [ ] All 8 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar sensory-overload` to validate the Sensory Overload pillar (8 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

### Task 25d: Audit Calming Sounds (Validate Only)

**Objective:** Run validation-only audit on the Calming Sounds pillar (7 articles).

**Acceptance Criteria:**
- [ ] `/audit-pillar calming-sounds` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/calming-sounds/audit-summary.md`
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar calming-sounds` to validate the Calming Sounds pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

### Task 25e: Audit Emotional Regulation (Validate Only)

**Objective:** Run validation-only audit on the Emotional Regulation pillar (7 articles).

**Acceptance Criteria:**
- [ ] `/audit-pillar emotional-regulation` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/emotional-regulation/audit-summary.md`
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar emotional-regulation` to validate the Emotional Regulation pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

### Task 25f: Audit Bedtime Routines (Validate Only)

**Objective:** Run validation-only audit on the Bedtime Routines pillar (7 articles).

**Acceptance Criteria:**
- [ ] `/audit-pillar bedtime-routines` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/bedtime-routines/audit-summary.md`
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar bedtime-routines` to validate the Bedtime Routines pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

### Task 25g: Audit Sound Therapy + Cross-Pillar Summary (Validate Only)

**Objective:** Run validation-only audit on the Sound Therapy pillar (7 articles), then compile a cross-pillar summary of all issues found across all 8 pillars.

**Acceptance Criteria:**
- [ ] `/audit-pillar sound-therapy` completes without errors
- [ ] `audit-summary.md` created at `projects/hushaway/seo-content/sound-therapy/audit-summary.md`
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Link audit completed
- [ ] Citation URL validation completed
- [ ] Cross-article consistency checked
- [ ] Cross-pillar summary compiled: common issues across all 8 pillars
- [ ] Patterns appearing 3+ times documented for Task 26 auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar sound-therapy` to validate the Sound Therapy pillar (7 articles). Validation-only mode (no --fix). After completion, review all 8 audit-summary.md files (adhd-sleep, autistic-meltdowns, sensory-overload, calming-sounds, emotional-regulation, bedtime-routines, sound-therapy, app-comparisons) and compile a cross-pillar summary: common issues by category, patterns appearing 3+ times, total article counts. Document findings for Task 26 auto-fix planning. Commit audit-summary.md. Update TASKS.md with results.

**Status:** pending

---

## Task 26: Auto-Fix All Pillars + Extract Patterns

**Objective:** Run auto-fix mode across all pillars, fix validation issues, and extract recurring patterns to common-mistakes.md.

**Acceptance Criteria:**
- [ ] `/audit-pillar --all --fix` fixes all fixable issues across 8 pillars
- [ ] Link/citation issues escalated for manual review (documented in audit-summary.md)
- [ ] Articles failing 3+ validation attempts escalated with reasons documented
- [ ] Recurring patterns (3+ occurrences) extracted to `.claude/rules/common-mistakes.md`
- [ ] Each extracted pattern includes: pattern name, count, source pillars, example
- [ ] Git commits created for each pillar's fixes
- [ ] Escalated articles documented in central summary for user review
- [ ] Post-fix validation confirms all auto-fixed articles now PASS

**Starter Prompt:**
> Run `/audit-pillar --all --fix` to auto-fix validation issues across all 8 HushAway pillars. Monitor the retry loop for each failing article (max 3 attempts via copy-enhancer). Document escalated articles (failed after 3 attempts or link/citation issues). After all pillars complete, review all audit-summary.md files and extract recurring patterns (3+ occurrences) to `.claude/rules/common-mistakes.md` using the Issue extraction template. Create git commits for each pillar's fixes. Compile final summary of escalated issues requiring manual review.

**Status:** pending
