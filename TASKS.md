# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Tasks 20-25h: Audit System Build + Full Audit | PASS (all completed) |
| Task 26: Auto-Fix All Pillars + Extract Patterns | pending |

### Completed Work (Tasks 20-25h)

Built the audit system (link-auditor agent, consistency-checker agent, audit-pillar skill) and ran validation-only audits across all 8 HushAway pillars (57 articles, 155,336 words). Results: 9 PASS, 48 FAIL. App Comparisons auto-fixed (51 link format issues corrected). Cross-pillar summary compiled at `projects/hushaway/seo-content/cross-pillar-summary.md`.

Key findings:
- ~365 internal link format violations across all 8 pillars (auto-fixable)
- 19 broken citation URLs across 7 pillars (manual)
- 14 missing bidirectional guide links across 4 pillars (auto-fixable)
- 28 broken slug references across 4 pillars (auto-fixable)
- 5 keyword-only slugs across 3 pillars (editorial decision)
- ~30 clinical terminology uses across 2 pillars (auto-fixable)

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

**Execution Plan (from cross-pillar-summary.md):**
1. Build complete slug lookup table (all 57 articles)
2. Fix internal link format across 7 pillars (~314 instances)
3. Add missing bidirectional guide links (14 articles across 4 pillars)
4. Fix broken slug references (28 instances across 4 pillars)
5. Fix clinical terminology (~30 instances across 2 pillars)
6. Validate all articles post-fix
7. Escalate broken citation URLs for manual review (19 URLs)
8. Present keyword-only slug decisions to user (5 articles)
9. Extract recurring patterns to common-mistakes.md

**Note:** Fix mode consumed 100% context on 7 articles (Task 24). Must run 1 pillar per session.

**Status:** pending
