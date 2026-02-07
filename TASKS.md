# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| **CLAUDE.md Slim (plan: giggly-doodling-otter.md)** | |
| Task 55: Move Phase 2 reference sections to `references/` | PASS |
| Task 56: Condense Rules 1-3 and Task Tracking in-place | PASS |
| Task 57: Final verification of CLAUDE.md slim | PASS |
| **universal-rules.md Slim (plan: zazzy-plotting-pelican.md)** | |
| Task 58: Move UK English patterns 4-8 to `references/` | pending |

---

## Task 58: Move UK English Patterns 4-8 to `references/`

**Objective:** Extract low-frequency UK English patterns (4-8, Miscellaneous, Directional Words) from `universal-rules.md` into a reference file. Keep high-frequency patterns 1-3 inline. Update agent read lists. This saves ~91 lines from auto-loaded context.

**Context:** Patterns 1-3 (-our/-or, -ise/-ize, -re/-er) catch the vast majority of UK English violations. Patterns 4-8 cover edge cases (doubled consonants, -ogue/-og, miscellaneous words like "grey", directional words like "towards"). These are still needed by agents that validate content, but don't need to load every session via the main auto-loaded file.

**Risk:** MODERATE. Agents that validate UK English must be updated to read the new reference file. If missed, obscure UK spellings could slip through. Common ones (-our, -ise, -re) still inline.

**Execution Steps:**
1. Read `universal-rules.md` in full
2. Create `.claude/references/uk-english-patterns.md` from lines 108-201 (Pattern 4 through Directional Words, including separators)
3. Replace lines 108-201 in `universal-rules.md` with a 3-line pointer: `Patterns 4-8, Miscellaneous, and Directional Words: see [UK English Extended Patterns](../references/uk-english-patterns.md).`
4. Update `.claude/agents/seo-writer.md` line 20 area — add `- .claude/references/uk-english-patterns.md` to "Before Starting" read list
5. Update `.claude/agents/content-validator.md` line 21 area — add `- .claude/references/uk-english-patterns.md` to "Before Starting" read list
6. Verify: `wc -l` on `universal-rules.md` — target ~424 lines
7. Verify: grep for "Pattern 1", "Pattern 2", "Pattern 3" still present in `universal-rules.md`
8. Verify: grep for "Pattern 4" through "Pattern 8" present in new reference file
9. Verify: no broken `references/` paths across `.claude/`
10. Commit

**Acceptance Criteria:**
- [ ] `references/uk-english-patterns.md` created with patterns 4-8 + Miscellaneous + Directional Words
- [ ] Patterns 1-3 still inline in `universal-rules.md`
- [ ] Pointer to reference file replaces moved content
- [ ] `seo-writer.md` reads new reference file
- [ ] `content-validator.md` reads new reference file
- [ ] `universal-rules.md` ~424 lines (down from 515)
- [ ] Total auto-loaded ~780 lines (down from 871)
- [ ] Zero broken path references
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 58 for steps. Read `universal-rules.md` in full. Extract patterns 4-8 + Miscellaneous + Directional Words (lines 108-201) into `.claude/references/uk-english-patterns.md`. Replace with pointer. Update `seo-writer.md` and `content-validator.md` read lists. Verify line counts and paths. Commit.

**Status:** pending

---
