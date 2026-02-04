# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 20: Create audit-pillar Skill | pending |
| Task 21: Test audit-pillar on Single Pillar | pending |
| Task 22: Run Full Audit Across All Pillars | pending |

---

## Task 20: Create audit-pillar Skill

**Objective:** Create the `/audit-pillar` skill that re-validates existing content against current rules.

**Acceptance Criteria:**
- [ ] Created `.claude/skills/audit-pillar/SKILL.md` with full skill definition
- [ ] Skill follows execute-pillar orchestration pattern (main session spawns agents)
- [ ] Supports `{pillar-name}` parameter for single pillar
- [ ] Supports `--fix` flag for auto-fix mode
- [ ] Supports `--all` flag for all pillars
- [ ] Generates `audit-summary.md` in pillar directory
- [ ] Updated CLAUDE.md skills table with `/audit-pillar`
- [ ] Deleted `audit-pillar.md` spec file from root (absorbed into skill)

**Starter Prompt:**
> Create the `/audit-pillar` skill following the specification in `audit-pillar.md` at repo root. Use the orchestration pattern from `.claude/skills/execute-pillar/SKILL.md`. The skill spawns content-validator agents in parallel for all articles, aggregates results into `audit-summary.md`, and optionally runs copy-enhancer fix loops. Reference `.claude/agents/content-validator.md` and `.claude/agents/copy-enhancer.md` for agent return formats. After creating the skill, add it to the skills table in `.claude/CLAUDE.md` and delete the root spec file.

**Status:** pending

---

## Task 21: Test audit-pillar on Single Pillar

**Objective:** Validate the skill works correctly on one pillar before running across all.

**Acceptance Criteria:**
- [ ] `/audit-pillar adhd-sleep` completes without error
- [ ] `adhd-sleep/audit-summary.md` created with correct format
- [ ] All 7 articles validated with correct PASS/FAIL counts
- [ ] Issue categories correctly aggregated
- [ ] `/audit-pillar adhd-sleep --fix` runs retry loop correctly
- [ ] Validation files deleted after PASS

**Starter Prompt:**
> Run `/audit-pillar adhd-sleep` to test the skill on the ADHD Sleep pillar (7 articles). Verify the audit-summary.md is created at `projects/hushaway/seo-content/adhd-sleep/audit-summary.md`. Check that all articles are validated and results match expected format. Then run `/audit-pillar adhd-sleep --fix` to test the auto-fix workflow. Confirm retry loop works (max 3 attempts) and validation files are cleaned up on PASS.

**Status:** pending

---

## Task 22: Run Full Audit Across All Pillars

**Objective:** Audit all 4 HushAway pillars and fix any issues found.

**Acceptance Criteria:**
- [ ] `/audit-pillar --all` validates all 29 articles across 4 pillars
- [ ] Each pillar has `audit-summary.md` with results
- [ ] `/audit-pillar --all --fix` fixes all fixable issues
- [ ] Any escalated articles (3+ failures) documented
- [ ] Patterns extracted to `common-mistakes.md` if 3+ occurrences
- [ ] Git commit with all fixes

**Starter Prompt:**
> Run `/audit-pillar --all` to validate all HushAway pillars: adhd-sleep (7), autistic-meltdowns (7), calming-sounds (7), sensory-overload (8). Review all audit-summary.md files. Then run `/audit-pillar --all --fix` to auto-fix issues. Document any escalated articles. Extract recurring patterns (3+ occurrences) to `.claude/rules/common-mistakes.md`. Commit all changes with message "Audit all pillars against current rules".

**Status:** pending
