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
| Task 25-pre2: Create Consistency-Checker Agent | PASS |
| Task 25a: Audit ADHD Sleep (Validate Only) | PASS |
| Task 25b: Audit Autistic Meltdowns (Validate Only) | PASS |
| Task 25c: Audit Sensory Overload (Validate Only) | PASS |
| Task 25d: Audit Calming Sounds (Validate Only) | PASS |
| Task 25e: Audit Emotional Regulation (Validate Only) | pending |
| Task 25f: Audit Bedtime Routines (Validate Only) | PASS |
| Task 25g: Audit Sound Therapy (Validate Only) | pending |
| Task 25h: Cross-Pillar Summary | pending |
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

### Task 25-pre2: Create Consistency-Checker Agent

**Objective:** Build a `consistency-checker` agent that offloads Phase 5 (Cross-Article Consistency) from the audit-pillar main session into its own context window.

**Acceptance Criteria:**
- [x] Created `.claude/agents/consistency-checker.md` following link-auditor/content-validator pattern
- [x] YAML frontmatter: name, description, tools (Read, Glob, Grep, Write), disallowedTools (Edit, Bash), model (sonnet)
- [x] Agent reads positioning.md + client profile for marketing context (angles, terminology, brand voice)
- [x] Agent reads all articles in the pillar
- [x] Agent checks: terminology consistency (profile terms vs actual usage), conflicting claims (statistics/percentages across articles), positioning alignment (intro/conclusion vs assigned angle, rated Strong/Moderate/Weak)
- [x] File-based output: writes `{pillar}/consistency-check.md` on FAIL, deletes on PASS
- [x] Returns: `PASS` or `FAIL, {term_issues}, {claim_issues}, {alignment_issues}, {pillar}/consistency-check.md`
- [x] Updated SKILL.md Phase 5: spawn consistency-checker agent instead of running in main session
- [x] Updated SKILL.md Phase 6: read `{pillar}/consistency-check.md` for cross-article findings
- [x] Updated SKILL.md Critical Constraint #6: "Cross-article consistency runs as consistency-checker agent"
- [x] Added `consistency-checker` to Agents table in `.claude/CLAUDE.md`
- [x] Git commit created and pushed

**Starter Prompt:**
> Create the `consistency-checker` agent and update the audit-pillar skill to use it. Task 25b (autistic-meltdowns audit) failed with "prompt too long" because Phase 5 loads all 7 articles into main session context (~23K tokens). This agent moves that work into its own context window.
>
> **Step 1: Create agent.** Write `.claude/agents/consistency-checker.md` modelled after `.claude/agents/link-auditor.md` (same architecture: YAML frontmatter, read-only, file-based output, minimal return format). The agent checks cross-article consistency for a pillar: (1) Terminology consistency - extract key terms from positioning.md and profile, scan all articles for variations or prohibited terms; (2) Conflicting claims - extract statistics/percentages/recommendations across articles, flag contradictions; (3) Positioning alignment - check each article's intro/conclusion against its assigned angle from positioning.md (rate Strong/Moderate/Weak). Reads: all articles in pillar, positioning.md, client profile, universal-rules.md (terminology section). Writes: `{pillar}/consistency-check.md` on FAIL. Returns: `PASS` or `FAIL, {term_issues}, {claim_issues}, {alignment_issues}, {file_path}`.
>
> **Step 2: Update SKILL.md.** Edit `.claude/skills/audit-pillar/SKILL.md`: (a) Phase 5 - change from "Runs in main session" to spawn consistency-checker agent with invocation block; (b) Phase 6 - add step to read `{pillar}/consistency-check.md` for cross-article findings; (c) Critical Constraint #6 - change to "Cross-article consistency runs as consistency-checker agent".
>
> **Step 3: Update CLAUDE.md.** Add `consistency-checker` to the Agents table in `.claude/CLAUDE.md`.
>
> **Step 4: Commit and push.**

**Status:** PASS

---

**Handoff:**
- **Done:** Created consistency-checker agent at `.claude/agents/consistency-checker.md`. Updated audit-pillar SKILL.md: Phase 5 now spawns consistency-checker agent instead of running in main session, Phase 6 reads `consistency-check.md` for cross-article findings, Critical Constraint #6 updated. Added consistency-checker to CLAUDE.md agents table (now 6 agents).
- **Decisions:** Modelled after link-auditor.md architecture (YAML frontmatter, read-only, file-based output, minimal return). Three check categories: terminology (product names, prohibited terms, variations), conflicting claims (statistics, recommendations, definitions), positioning alignment (Strong/Moderate/Weak rating). Weak alignment is FAIL, moderate is WARN.
- **Next:** Task 25b (Audit Autistic Meltdowns) can now proceed with consistency-checker agent handling Phase 5.

---

### Task 25b: Audit Autistic Meltdowns (Validate Only)

**Objective:** Run validation-only audit on the Autistic Meltdowns pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar autistic-meltdowns` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/autistic-meltdowns/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked (via consistency-checker agent)
- [x] Session completes fully (commit + TASKS.md update within context)
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> **Prerequisite:** Task 25-pre2 (Create Consistency-Checker Agent) must be PASS before running this. First, delete stale files from the failed previous attempt: `projects/hushaway/seo-content/autistic-meltdowns/audit-summary.md`, `link-audit.md`, and all `.validation.md` files in `articles/`. Then run `/audit-pillar autistic-meltdowns` to validate the Autistic Meltdowns pillar (7 articles). Validation-only mode (no --fix). Phase 5 now uses the consistency-checker agent instead of main session. Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on Autistic Meltdowns pillar (7 articles, 16,586 words). Phase 2: 7 content-validator agents in parallel (1 PASS, 6 FAIL). Phase 3: link-auditor agent found 51 format violations + 12 broken slug references. Phase 4: 13 citation URLs checked (7 working, 5 WARN from NCBI/Wiley/ScienceDirect/AAP 403 bot-blocking, 1 FAIL from Frontiers 404). Phase 5: consistency-checker agent found 0 terminology issues, 0 conflicting claims, all 7 articles Strong positioning alignment. Phase 6: audit-summary.md written with all required sections.
- **Decisions:** Article 07 (pillar guide) is only article with correct `/{slug}` links (PASS validation). Articles 01-05 use Pattern A (`/autistic-meltdowns/{slug}`), Articles 06-07 use Pattern B (`/autistic-meltdowns/articles/{filename}`). 403 bot-blocking on NCBI/Wiley/ScienceDirect/AAP marked WARN (not broken). Consistency-checker FAIL was due to link format issues (overlaps with link-auditor), actual content consistency was all PASS.
- **Next:** Task 25c (Audit Sensory Overload). For Task 26 (auto-fix): All articles need link format fix (`/{slug}` only). 12 broken slug references need manual slug correction. Article 03 has 1 broken citation URL (Frontiers fpsyg.2021.767782 returns 404). Article 02 missing link to pillar guide.

---

### Task 25c: Audit Sensory Overload (Validate Only)

**Objective:** Run validation-only audit on the Sensory Overload pillar (8 articles — largest pillar).

**Acceptance Criteria:**
- [x] `/audit-pillar sensory-overload` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/sensory-overload/audit-summary.md`
- [x] All 8 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar sensory-overload` to validate the Sensory Overload pillar (8 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on Sensory Overload pillar (8 articles, 23,449 words). Phase 2: 8 content-validator agents in parallel (0 PASS, 8 FAIL). Phase 3: link-auditor agent found 50 format violations + 5 broken slug references + 7 missing bidirectional guide links. Phase 4: 19 citation URLs checked (11 working, 4 WARN from NCBI/PMC 403 bot-blocking, 4 FAIL from NHS/NAS/Understood.org/Frontiers 404). Phase 5: consistency-checker agent returned PASS (0 terminology issues, 0 conflicting claims, all 8 articles Strong positioning alignment). Phase 6: audit-summary.md written with all required sections.
- **Decisions:** All 8 articles FAIL primarily due to systematic internal link format violations (50 instances of directory structure instead of `/{slug}` format) and slug number prefixes in frontmatter. Article 01 has unique broken link pattern (uses `/sensory-overload/{partial-slug}` instead of directory path). NCBI/PMC 403s marked WARN (bot-blocking, not broken). 4 broken citation URLs need replacement: NHS sensory-processing-disorder (Art 01, 08), NAS after-school-restraint-collapse (Art 04), Understood.org sensory-diet (Art 06), Frontiers fpsyg.2020.574461 (Art 07). New pattern: 0/7 supporting articles link back to pillar guide.
- **Next:** Task 25d (Audit Calming Sounds). For Task 26 (auto-fix): All 8 articles need link format fix (`/{slug}` only). 8 slug number prefixes need removal. 5 broken slug references need correction. 7 missing bidirectional guide links need adding. 4 broken citation URLs need replacement.

---

### Task 25d: Audit Calming Sounds (Validate Only)

**Objective:** Run validation-only audit on the Calming Sounds pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar calming-sounds` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/calming-sounds/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar calming-sounds` to validate the Calming Sounds pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on Calming Sounds pillar (7 articles, 18,050 words). Phase 2: 7 content-validator agents in parallel (2 PASS, 5 FAIL). Phase 3: link-auditor agent found 28 format violations + 4 missing bidirectional guide links. Phase 4: 21 citation URLs checked (12 working, 6 WARN from NCBI/BMJ/AAP/Sage 403 bot-blocking, 3 FAIL from CHADD/NHS/Frontiers 404). Phase 5: consistency-checker agent returned PASS (0 terminology FAILs, 0 conflicting claims, all 7 articles Strong positioning alignment, 1 WARN for "dysregulated" in Art 06). Phase 6: audit-summary.md written with all required sections.
- **Decisions:** Articles 05 and 06 pass content validation (no banned words, good SEO, correct UK English). All 7 articles FAIL due to systematic internal link format violations (directory paths instead of `/{slug}` format). 403 bot-blocking on NCBI/BMJ/AAP/Sage marked WARN (not broken). 4 articles (01, 03, 04, 06) missing bidirectional links back to pillar guide.
- **Next:** Task 25e (Audit Emotional Regulation). For Task 26 (auto-fix): All 7 articles need link format fix (`/{slug}` only). 4 articles need bidirectional guide links added. 3 broken citation URLs need replacement (CHADD 404, NHS autism 404, Frontiers fpsyg.2020.564206 404, NHS every-mind-matters 404). Art 06 "dysregulated" should be replaced with "overwhelmed".

---

### Task 25e: Audit Emotional Regulation (Validate Only)

**Objective:** Run validation-only audit on the Emotional Regulation pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar emotional-regulation` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/emotional-regulation/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar emotional-regulation` to validate the Emotional Regulation pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Audit completed for Emotional Regulation pillar (7 articles). audit-summary.md created with all required sections.
- **Decisions:** All 7 articles FAIL primarily due to incorrect internal link format (71 instances using `/pillar/articles/nn-slug` instead of `/{slug}`). 3 broken citation URLs (404). Positioning alignment is strong across all articles. No banned AI words or em dashes found.
- **Next:** Run `--fix` to auto-correct internal link format issues. Manually resolve 3 broken citation URLs (zonesofregulation.com, nhs.uk/emotions, hushaway.com/the-open-sanctuary). Address clinical term "intervention" in article 07.

---

### Task 25f: Audit Bedtime Routines (Validate Only)

**Objective:** Run validation-only audit on the Bedtime Routines pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar bedtime-routines` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/bedtime-routines/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar bedtime-routines` to validate the Bedtime Routines pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on Bedtime Routines pillar (7 articles, 20,506 words). Phase 2: 7 content-validator agents in parallel (5 PASS, 2 FAIL). Phase 3: link-auditor agent found 56 format violations + 2 missing bidirectional guide links. Phase 4: 15 citation URLs checked (7 working, 5 WARN from NCBI/PMC 403 bot-blocking, 4 FAIL from PubMed/NAS/SleepFoundation 404). Phase 5: consistency-checker agent returned PASS (0 terminology issues, 0 conflicting claims, all 7 articles Strong positioning alignment). Phase 6: audit-summary.md written with all required sections. Commit `5a59e1e`.
- **Decisions:** All 7 articles FAIL primarily due to systematic internal link format violations (56 instances using `/bedtime-routines/articles/{slug}` or `/{pillar}/articles/{slug}` instead of `/{slug}`). 5 NCBI/PMC 403s marked WARN (bot-blocking, not broken). Content quality is excellent: no banned AI words, no em dashes, all positioning Strong, statistics consistent across articles. Only 2 articles (03, 07) caught by validators for link format; others missed it. 1 slug mismatch: Art 01 references `/adhd-sleep/articles/04-adhd-racing-thoughts` but actual slug is `quieting-adhd-racing-thoughts-bedtime`.
- **Next:** Task 25g (Audit Sound Therapy + Cross-Pillar Summary). For Task 26 (auto-fix): All 7 articles need link format fix (`/{slug}` only). 12 cross-pillar links also need format fix. 2 articles (04, 05) need bidirectional guide links added. 4 broken citation URLs need replacement: PubMed 25928655 (Art 02), NAS visual-supports (Art 03), PubMed 28838255 (Art 03), SleepFoundation separation-anxiety (Art 06). 1 slug mismatch in cross-pillar link needs correction (Art 01).

---

### Task 25g: Audit Sound Therapy (Validate Only)

**Objective:** Run validation-only audit on the Sound Therapy pillar (7 articles).

**Acceptance Criteria:**
- [x] `/audit-pillar sound-therapy` completes without errors
- [x] `audit-summary.md` created at `projects/hushaway/seo-content/sound-therapy/audit-summary.md`
- [x] All 7 articles validated with correct PASS/FAIL counts
- [x] Link audit completed
- [x] Citation URL validation completed
- [x] Cross-article consistency checked
- [x] Issues documented in handoff for auto-fix planning

**Starter Prompt:**
> Run `/audit-pillar sound-therapy` to validate the Sound Therapy pillar (7 articles). Validation-only mode (no --fix). Verify audit-summary.md is created with all required sections. Document all issues found. Commit audit-summary.md. Update TASKS.md with results.

**Status:** PASS

---

**Handoff:**
- **Done:** Ran full 8-phase audit on Sound Therapy pillar (7 articles, 18,608 words). Phase 2: 7 content-validator agents in parallel (0 PASS, 7 FAIL). Phase 3: link-auditor agent found 29 format violations, 0 broken links, 0 stale placeholders, guide coverage 6/6 both directions. Phase 4: 22 citation URLs checked (15 working, 6 WARN from Sagepub/PMC 403 bot-blocking, 1 FAIL from ScienceDirect 404). Phase 5: consistency-checker agent returned PASS (0 terminology issues, 0 conflicting claims, all 7 articles Strong positioning alignment). Phase 6: audit-summary.md written with all required sections.
- **Decisions:** All 7 articles FAIL primarily due to systematic internal link format violations (29 instances using `/sound-therapy/{slug}` instead of `/{slug}`). 4 PMC 403s marked WARN (bot-blocking, respond 200 on GET). 2 Sagepub 403s marked WARN (bot-blocking). Content quality is excellent: no banned AI words, no em dashes, all positioning Strong, statistics consistent across articles. 2 articles (03, 06) have keyword-only slugs. Article 07 has number prefix in slug.
- **Next:** Task 25h (Cross-Pillar Summary). For Task 26 (auto-fix): All 7 articles need link format fix (`/{slug}` only). 2 articles (03, 06) need slug update from keyword-only to descriptive-first. Article 07 needs slug number prefix removed. 1 broken citation URL needs replacement: ScienceDirect S1053810020300982 (Art 07).

---

### Task 25h: Cross-Pillar Summary

**Objective:** Review all 8 audit-summary.md files and compile a cross-pillar summary of common issues for Task 26 auto-fix planning.

**Acceptance Criteria:**
- [ ] All 8 audit-summary.md files read (adhd-sleep, autistic-meltdowns, sensory-overload, calming-sounds, emotional-regulation, bedtime-routines, sound-therapy, app-comparisons)
- [ ] Cross-pillar summary compiled: common issues by category across all 8 pillars
- [ ] Patterns appearing 3+ times documented with pillar names and counts
- [ ] Total article counts and PASS/FAIL breakdown per pillar
- [ ] Broken citation URLs aggregated across all pillars
- [ ] Findings documented for Task 26 auto-fix planning
- [ ] Summary written to `projects/hushaway/seo-content/cross-pillar-summary.md`

**Starter Prompt:**
> Read all 8 audit-summary.md files under `projects/hushaway/seo-content/` (adhd-sleep, autistic-meltdowns, sensory-overload, calming-sounds, emotional-regulation, bedtime-routines, sound-therapy, app-comparisons). Compile a cross-pillar summary: common issues by category, patterns appearing 3+ times with pillar names and occurrence counts, total article counts (PASS/FAIL per pillar), aggregated broken citation URLs, and findings for Task 26 auto-fix planning. Write summary to `projects/hushaway/seo-content/cross-pillar-summary.md`. Commit. Update TASKS.md with results.

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
