# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 19: Expand UK/US Spelling Validation | PASS |
| Task 20: Fix Agent Workflow Issues (Brutal Review) | pending |

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

## Task 20: Fix Agent Workflow Issues (Brutal Review)

**Objective:** Implement fixes for 3 major issues identified in agent-work-review-01.md: tier 1 parallel execution failure, first-draft quality issues, and validator false positives.

**Context:** Autistic Meltdowns pillar execution revealed:
- Articles 01-02 ran sequentially (should have been parallel Tier 1) → 10-15 min wasted
- 3 validation retries across 7 articles (42% retry rate) due to agents missing keyword mismatches, slug format errors, banned words
- Validator flagged placeholder links as FAIL (they're valid per workflow rules)

**Acceptance Criteria:**
- [x] Add automated tier validation to execute-pillar (Step 2B: checks completeness, no circular deps, valid references)
- [x] Add self-validation checklist to seo-writer (frontmatter keyword match, slug format, no placeholders, H1 format)
- [x] Add banned words check to copy-enhancer (53 words, search + replace before returning PASS)
- [x] Add placeholder link recognition to content-validator (recognize `<!-- LINK NEEDED: ... -->` as valid, output as INFO not FAIL)
- [x] Add proactive context communication to execute-pillar (explain agent architecture at start)
- [x] Extract 3 error patterns from Issue #3 to common-mistakes.md (keyword mismatch, slug format, banned words slip)

**Starter Prompt:**
> Implement Task 20: Fix Agent Workflow Issues. Based on agent-work-review-01.md findings and the plan in /Users/jagpalkooner/.claude/plans/jazzy-yawning-lecun.md, update 5 files:
> 1. .claude/skills/execute-pillar/SKILL.md — Add Step 2B (automated tier validation) + context communication
> 2. .claude/agents/seo-writer.md — Add pre-return self-validation checklist
> 3. .claude/agents/copy-enhancer.md — Add banned words check with search/replace
> 4. .claude/agents/content-validator.md — Add placeholder link recognition
> 5. rules/common-mistakes.md — Extract 3 patterns from Issue #3
>
> Target: Reduce validation retry rate from 42% to 14-28%, eliminate tier structure errors, zero false positives.

**Status:** PASS

---

**Handoff:**

**Done:**
- Updated all 5 files as specified in the plan
- execute-pillar: Added Step 2B (automated tier validation) with completeness checks, circular dependency detection, and Tier 1 validation
- execute-pillar: Added Step 1.4 (context architecture communication) to proactively explain agent orchestration to users
- seo-writer: Added Section 6 (pre-return self-validation checklist) with 15 validation checkpoints and self-validation output format
- copy-enhancer: Added banned words validation section (both modes) with 53-word reference list, detection method, and replacement examples
- content-validator: Added Section 1.10 (placeholder link handling) to recognize `<!-- LINK NEEDED: ... -->` as valid workflow syntax
- common-mistakes: Extracted 3 patterns from Issue #3 (primary keyword frontmatter mismatch, slug format keyword-only, banned words slipping through)
- All changes committed and pushed to pillar/autistic-meltdowns branch

**Decisions:**
- Automated tier validation approach: Check deterministically without user interruption (not hard enforcement or soft guidance)
- Self-validation strategy: Better agent checklists (not schema validation layer or validator-before-enhancement)
- Placeholder link output: INFO section (not FAIL or WARN) to eliminate false positives
- All 3 error patterns from Issue #3 marked with "(Issue #3)" for traceability back to original error log

**Next:**
- Test these improvements on the next pillar execution
- Expected improvements: 10-15% faster execution (parallel Tier 1), 50-70% fewer validation retries (better first drafts), cleaner validation output (no false positives)
- Monitor validation retry rate: target is 14-28% (down from 42%)
- If retry rate doesn't improve to target range, investigate further and refine agent checklists

---
