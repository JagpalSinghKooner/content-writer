# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 19: Expand UK/US Spelling Validation | pending |

**Previous work:** Tasks 1-18 completed (see git history). Agent system fully validated via Task 11 pipeline test.

---

## Task 19: Expand UK/US Spelling Validation

**Objective:** Add pattern-based UK/US spelling guidance and expand the word list in universal-rules.md.

**Acceptance Criteria:**
- [x] Add pattern-based categories (-our/-or, -ise/-ize, -re/-er, etc.)
- [x] Expand word list from 26 to ~48 pairs
- [x] Add derived forms guidance (plurals, compounds)
- [x] Test validation catches: "color", "harbor", "memorize", "jewelry"

**Starter Prompt:**
> Implement Task 19: Expand UK/US Spelling Validation. Update universal-rules.md to add pattern-based categories for systematic UK/US differences, expand the word list with commonly missed spellings, and add derived forms guidance.

**Status:** PASS

---

**Handoff:**
- **Done:** Rewrote UK English section (Rule 1) in universal-rules.md with 8 pattern-based categories: -our/-or, -ise/-ize, -re/-er, -ce/-se, doubled consonants (-ll-), -ogue/-og, -ence/-ense, and miscellaneous. Expanded from 25 pairs to 48+ pairs. Added derived forms guidance under each pattern. Added Quick Validation Checklist for common US patterns to search for.
- **Decisions:** Kept patterns as the primary organisation (easier to learn than flat lists). Added notes about exceptions (e.g., words always -ise in both variants). Included directional words section (towards/toward) as these are subtle UK markers.
- **Next:** No immediate follow-up needed. The content-validator agent will now have comprehensive UK/US spelling guidance to check against.

---
