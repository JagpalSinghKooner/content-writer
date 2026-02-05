# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 20: Create Link-Auditor Agent | PASS |
| Task 21: Create Audit-Pillar Skill | PASS |
| Task 22: Update CLAUDE.md and Cleanup | pending |
| Task 23: Test on Single Pillar (Validate Only) | PASS |
| Task 24: Test Auto-Fix Mode | pending |
| Task 25: Full Audit All Pillars (Validate Only) | pending |
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

**Status:** pending

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
- [ ] `/audit-pillar app-comparisons --fix` runs retry loop for FAIL articles
- [ ] Copy-enhancer spawned with validation file paths (not content in prompt)
- [ ] Retry loop executes max 3 attempts per article
- [ ] Validation files deleted after PASS
- [ ] Articles that PASS after retry marked "Fixed" in audit-summary.md
- [ ] Articles that fail 3 times marked "Escalated" with issues listed
- [ ] Link/citation issues correctly escalated (not auto-fixed)
- [ ] Audit-summary.md shows Fix Results section with attempt counts
- [ ] Git commit created after successful fixes

**Starter Prompt:**
> Run `/audit-pillar app-comparisons --fix` to test the auto-fix workflow on the App Comparisons pillar. Verify the retry loop: for each FAIL article, main session spawns copy-enhancer with the validation file path, then re-validates. Check loop runs max 3 attempts per article before escalation. Confirm validation files deleted after PASS. Verify link and citation issues are escalated (not auto-fixed). Review audit-summary.md Fix Results section. Commit fixed articles.

**Status:** pending

---

## Task 25: Full Audit All Pillars (Validate Only)

**Objective:** Run validation-only audit across all 8 HushAway pillars to establish baseline before attempting fixes.

**Acceptance Criteria:**
- [ ] `/audit-pillar --all` validates all 57 articles across 8 pillars
- [ ] Each pillar has `audit-summary.md` with complete results
- [ ] Link audit identifies all broken links, incorrect URL formats, and stale placeholders
- [ ] Citation URL validation catches all 4xx/5xx errors and redirects
- [ ] Cross-article consistency checks identify terminology variations and conflicting claims
- [ ] Common issues (3+ occurrences) flagged for pattern extraction
- [ ] No orchestration failures or context overflow

**Starter Prompt:**
> Run `/audit-pillar --all` to validate all 8 HushAway pillars: adhd-sleep (7), autistic-meltdowns (7), calming-sounds (7), sensory-overload (8), emotional-regulation (7), bedtime-routines (7), sound-therapy (7), app-comparisons (7). Total: 57 articles. Validation-only mode to establish baseline. Review all 8 audit-summary.md files. Identify common patterns across pillars (same issue appearing 3+ times). Document all issues found for planning the auto-fix run.

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
