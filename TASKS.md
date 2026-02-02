# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 7: Error Learning System with GitHub Integration | PASS |
| Task 6: End-to-End Validation with Real Client | pending |

**Previous work:** 37 tasks completed (see git history). Git + GitHub setup complete. Error tracking system added.

---

## Task 7: Error Learning System with GitHub Integration

**Objective:** Add automatic error logging to GitHub Issues for pattern extraction and system improvement.

**Acceptance Criteria:**
- [x] Rule #3: Error Tracking Protocol added to CLAUDE.md
- [x] Extracted-from-Issue template added to common-mistakes.md
- [x] System creates Issue + Draft PR at pillar start
- [x] Errors auto-logged to Issue during workflow
- [x] Pattern extraction step added at pillar completion

**Status:** PASS

---

**Handoff:**
- **Done:** Added Rule #3 (Error Tracking Protocol) to CLAUDE.md. Added extracted-from-Issue template to common-mistakes.md.
- **Decisions:** Per-pillar tracking (not per-project or per-session). Minimal error detail (type + message only). Both Issue (for errors) and Draft PR (for work) created at pillar start. Patterns extracted when 3+ occurrences.
- **Next:** First real use will be during Task 6 (End-to-End Validation). Error tracking activates when starting the first pillar.

---

## Task 6: End-to-End Validation with Real Client

**Objective:** Run complete system with first real client to validate all changes.

**Acceptance Criteria:**
- [ ] Complete pillar (10+ articles) produced for real client
- [ ] All skills used at least once during project
- [ ] No undocumented gaps encountered during workflow
- [ ] `.claude/rules/common-mistakes.md` updated with any patterns observed
- [ ] Retrospective completed documenting lessons learned

**Starter Prompt:**
> Run end-to-end validation with first real client. Execute complete workflow: (1) Run /onboard-client for real client; (2) Run /keyword-research to produce keyword brief with real search data; (3) Run /start-pillar for first pillar with DR scores; (4) Run /positioning-angles for pillar positioning; (5) Run /seo-content for all supporting articles + pillar guide (10+ total); (6) Run /direct-response-copy on each article; (7) Run /validate-content on each article; (8) Run /content-atomizer on at least 2 articles; (9) Document any gaps or friction points encountered; (10) Update common-mistakes.md with any patterns; (11) Write retrospective noting what worked, what didn't, and any system improvements needed.

**Status:** pending
