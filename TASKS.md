# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| **CLAUDE.md Slim (plan: giggly-doodling-otter.md)** | |
| Task 55: Move Phase 2 reference sections to `references/` | PASS |
| Task 56: Condense Rules 1-3 and Task Tracking in-place | PASS |
| Task 57: Final verification of CLAUDE.md slim | PASS |
| **universal-rules.md Slim (plan: zazzy-plotting-pelican.md)** | |
| Task 58: Move UK English patterns 4-8 to `references/` | PASS |
| **Token Efficiency & Scalability Audit (plan: slim-down.md)** | |
| Task 59: Strip inline rule copies from content-validator.md | PASS |
| Task 60: Strip inline banned words from copy-enhancer.md + add "Before Starting" | PASS |
| Task 61: Strip inline rule copies from validate-content/SKILL.md | PASS |
| Task 62: Extract banned words, phrases, AI patterns to `references/` | pending |
| Task 63: Extract SEO requirements and citation rules to `references/` | PASS |
| Task 64: Condense workflow.md retry/tier details | pending |
| Task 65: Archive agents-prd.md | pending |
| Task 66: Add multi-client path isolation to CLAUDE.md | pending |

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

**Status:** PASS

---

**Handoff:**
- **Done:** Extracted UK English patterns 4-8, Miscellaneous, and Directional Words into `.claude/references/uk-english-patterns.md`. Replaced with pointer in `universal-rules.md`. Updated `seo-writer.md` and `content-validator.md` read lists.
- **Decisions:** Kept patterns 1-3 inline (highest frequency). Reference file follows same heading structure (####) as original.
- **Next:** Continue with next cleanup task if planned, or verify agents load the new reference file correctly during next content generation run.

---

## Task 59: Strip inline rule copies from content-validator.md

**Objective:** Remove duplicated rule content from `content-validator.md` that the agent already reads from `universal-rules.md` at startup. Replace with references to the canonical source. Saves ~90 lines.

**Context:** The content-validator already reads `universal-rules.md` in its "Before Starting" section (line 21). Its inline copies of rules are loaded twice per validation — once from the source file, once from the agent's own instructions. This is pure token waste.

**Depends on:** Nothing (can run in parallel with Tasks 60, 61)

**Risk:** LOW — agent already reads the source files.

**Execution Steps:**
1. Read `.claude/agents/content-validator.md` in full
2. Section 1.1 (UK English, lines ~72-90): Replace 10-pair word list with `"Scan for American spellings per universal-rules.md Rule 1 and uk-english-patterns.md."` Keep output format example only
3. Section 1.2 (Banned Words, lines ~92-106): Replace full 53-word list with `"Scan for all 53 banned words per universal-rules.md Rule 2."` Keep output format
4. Section 1.3 (Banned Phrases, lines ~108-121): Replace category summaries with reference to Rule 3. Keep output format
5. Section 1.4 (AI Patterns, lines ~124-136): Replace pattern list with reference to Rule 4. Keep output format
6. Section 1.5 (Em Dashes, lines ~139-163): Keep the Grep detection method (unique value). Remove the duplicate rule explanation and exclusion list
7. Section 1.9 (SEO Requirements, lines ~226-245): Replace checklist with reference to Rule 5. Keep output format
8. Verify: agent still has output format examples for every rule category
9. Verify: no references to rules that don't exist in source files
10. Commit

**Acceptance Criteria:**
- [x] Inline UK English word pairs removed, replaced with reference
- [x] Inline banned words list removed, replaced with reference
- [x] Inline banned phrases removed, replaced with reference
- [x] Inline AI patterns removed, replaced with reference
- [x] Em dash Grep detection method preserved
- [x] Inline SEO checklist removed, replaced with reference
- [x] All output format examples retained
- [x] `content-validator.md` reduced by ~48 lines (632→584; actual duplication was less than estimated ~90)
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 59 for steps. Read `.claude/agents/content-validator.md` in full. For sections 1.1-1.5 and 1.9, replace inline rule copies with references to `universal-rules.md` Rules 1-5. Keep all output format examples and the Em Dash Grep detection method. Verify output format coverage. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Replaced inline rule copies in sections 1.1-1.5 and 1.9 with references to `universal-rules.md` Rules 1-5 and `uk-english-patterns.md`. Preserved all output format examples and the Em Dash Grep detection method.
- **Decisions:** Kept Em Dash exclusion guidance embedded in step 2 of detection method (already concise). Actual line reduction was 48 (not estimated 90) because inline copies were more concise than the source rules.
- **Next:** Task 60 (copy-enhancer.md) and Task 61 (validate-content/SKILL.md) can run in parallel.

---

## Task 60: Strip inline banned words from copy-enhancer.md + add "Before Starting" section

**Objective:** Add a "Before Starting" section to `copy-enhancer.md` (matching the pattern in seo-writer.md and content-validator.md) and replace the inline 53-word banned list with a reference. Saves ~15 lines.

**Context:** The copy-enhancer has no "Before Starting" section telling it to read rules files. It relies entirely on its preloaded skill and an inline "Quick Reference" of 53 banned words. Adding the read-on-start pattern ensures it always has the latest rules.

**Depends on:** Nothing (can run in parallel with Tasks 59, 61)

**Risk:** LOW-MEDIUM — the "Before Starting" addition is new for this agent but follows established pattern from seo-writer.md and content-validator.md.

**Execution Steps:**
1. Read `.claude/agents/copy-enhancer.md` in full
2. Read `.claude/agents/seo-writer.md` lines 1-30 for "Before Starting" pattern reference
3. Add "Before Starting" section after the frontmatter/intro, instructing agent to read `universal-rules.md` and `uk-english-patterns.md`
4. Replace lines ~38-48 (full banned word list) with reference to `universal-rules.md` Rule 2
5. Keep the replacement examples table (lines ~58-70) — this is unique value showing natural alternatives
6. Keep the pre-return check and fix-mode behaviour
7. Verify: "Before Starting" section matches pattern from other agents
8. Verify: replacement examples table intact
9. Commit

**Acceptance Criteria:**
- [x] "Before Starting" section added with reads for `universal-rules.md` and `uk-english-patterns.md`
- [x] Inline 53-word banned list replaced with reference to Rule 2
- [x] Replacement examples table preserved
- [x] Pre-return check and fix-mode behaviour preserved
- [x] `copy-enhancer.md` net ~1 line reduction (banned list -11 lines offset by new Before Starting +11 lines of non-duplicated value)
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 60 for steps. Read `.claude/agents/copy-enhancer.md` in full. Read `.claude/agents/seo-writer.md` lines 1-30 for "Before Starting" pattern. Add "Before Starting" section to copy-enhancer.md. Replace inline banned word list with reference to `universal-rules.md` Rule 2. Keep replacement examples table. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Added "Before Starting" section to `copy-enhancer.md` matching the pattern from `seo-writer.md` and `content-validator.md`. Replaced inline 53-word banned list with reference to `universal-rules.md` Rule 2.
- **Decisions:** Kept replacement examples table (unique value showing natural alternatives). "Before Starting" reads `universal-rules.md` and `uk-english-patterns.md` matching other agents. Net file size change minimal because the new section adds non-duplicated value.
- **Next:** Task 61 (validate-content/SKILL.md) can proceed. Task 62 will add `banned-words-phrases.md` to this agent's "Before Starting" section.

---

## Task 61: Strip inline rule copies from validate-content/SKILL.md

**Objective:** Remove duplicated rule content from `validate-content/SKILL.md`. This is the biggest duplication in the system — the skill is preloaded into the content-validator agent which already reads `universal-rules.md`, so every rule list is loaded twice per validation. Saves ~300 lines.

**Context:** This skill file contains full copies of UK English pairs, banned words, banned phrases, AI patterns, SEO requirements, and content type scope matrix. All of these exist in `universal-rules.md` which the content-validator agent reads at startup. The skill adds unique value through output format examples and content-type-specific checks (email subject lines, newsletter hooks) — those must be kept.

**Depends on:** Nothing (can run in parallel with Tasks 59, 60)

**Risk:** LOW — the skill is loaded into an agent that already reads the source files.

**Execution Steps:**
1. Read `.claude/skills/validate-content/SKILL.md` in full
2. Section 1.1 (UK English, lines ~88-115): Replace 24-pair table with reference to Rule 1 + `uk-english-patterns.md`
3. Section 1.2 (Banned Words, lines ~121-143): Replace full word list with reference to Rule 2
4. Section 1.3 (Banned Phrases, lines ~146-195): Replace ~50 lines of phrases with reference to Rule 3
5. Section 1.4 (AI Patterns, lines ~197-226): Replace with reference to Rule 4
6. SEO Requirements section: Replace checklist with reference to Rule 5
7. Content Type Variations section (lines ~612-788): Replace scope matrix duplicate with reference to `universal-rules.md` Scope section. Keep content-type-specific checks (email subject lines, newsletter hooks) that are NOT in `universal-rules.md`
8. Keep ALL output format examples throughout
9. Verify: output format examples present for every rule category
10. Verify: content-type-specific checks (email, newsletter) preserved
11. Commit

**Acceptance Criteria:**
- [x] Inline UK English pairs removed, replaced with reference
- [x] Inline banned words removed, replaced with reference
- [x] Inline banned phrases removed, replaced with reference
- [x] Inline AI patterns removed, replaced with reference
- [x] Inline SEO checklist removed, replaced with reference
- [x] Scope matrix duplicate removed, replaced with reference
- [x] Content-type-specific checks (email, newsletter) preserved
- [x] All output format examples retained
- [x] `validate-content/SKILL.md` reduced by 168 lines (1132→964; actual duplication was less than estimated ~300)
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 61 for steps. Read `.claude/skills/validate-content/SKILL.md` in full. For sections 1.1-1.4, SEO Requirements, and Content Type Variations, replace inline rule copies with references to `universal-rules.md` Rules 1-5 and `uk-english-patterns.md`. Keep all output format examples and content-type-specific checks. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Replaced inline rule copies in sections 1.1-1.4, 1.5 SEO, and Content Type Variations (7.2-7.5) with references to `universal-rules.md` Rules 1-5, Rule 5a, and `uk-english-patterns.md`. Preserved all 25 output format examples and all content-type-specific additional checks (email subject lines, newsletter hooks, lead magnet bridge, distribution hooks).
- **Decisions:** Actual reduction was 168 lines (not estimated 300) because the scope lists in Content Type Variations were more concise than expected. Kept the 7.6 Quick Reference table (maps all phases × content types — unique value not duplicated elsewhere).
- **Next:** Task 62 can proceed (extract banned words/phrases to references). The validate-content skill now references `universal-rules.md` directly, so when Task 62 moves rules to reference files, the skill's references remain valid (it points to rule numbers, not specific file locations of content).

---

## Task 62: Extract banned words, phrases, AI patterns, and em dash rules to references

**Objective:** Move Rules 2-4b (banned words, banned phrases, AI patterns, em dashes) from `universal-rules.md` to a new reference file `banned-words-phrases.md`. Replace with named stubs in `universal-rules.md`. Update agent "Before Starting" sections. Saves ~155 lines from auto-load.

**Context:** These rules are content-creation specific. They waste auto-load tokens during system development sessions where no content is being written. The stub pattern keeps rule names visible (so you know they exist) while moving the full lists to on-demand reference files.

**Depends on:** Tasks 59, 60, 61 (agents must reference source files before we move the content)

**Risk:** MEDIUM — agents must read the new reference file or rules are silently dropped. Mitigated by stub pattern (rule names remain visible in auto-loaded file) and content-validator as gatekeeper.

**Execution Steps:**
1. Read `universal-rules.md` in full (post Tasks 59-61 state)
2. Create `.claude/references/banned-words-phrases.md` containing:
   - Rule 2: Banned AI Words (full 53-word list)
   - Rule 3: Banned AI Phrases (full list)
   - Rule 4: AI Patterns
   - Rule 4b: No Em Dashes
3. Replace each section in `universal-rules.md` with a named stub + reference link (e.g., `### 2. Banned AI Words\n53 banned words. See [Banned Words & Phrases](../references/banned-words-phrases.md).`)
4. Add `.claude/references/banned-words-phrases.md` to "Before Starting" sections in:
   - `content-validator.md`
   - `seo-writer.md`
   - `copy-enhancer.md` (added in Task 60)
5. Verify: stubs in `universal-rules.md` still show rule names and numbers
6. Verify: reference file contains all 53 banned words, all banned phrases, all AI patterns, em dash rules
7. Verify: all three agents list the new reference file in "Before Starting"
8. Commit

**Acceptance Criteria:**
- [x] `references/banned-words-phrases.md` created with Rules 2, 3, 4, 4b
- [x] `universal-rules.md` has named stubs with reference links for each moved rule
- [x] `content-validator.md` "Before Starting" includes new reference file
- [x] `seo-writer.md` "Before Starting" includes new reference file
- [x] `copy-enhancer.md` "Before Starting" includes new reference file
- [x] `universal-rules.md` reduced by ~155 lines from auto-load (actual: 157)
- [x] All 53 banned words present in reference file
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 62 for steps. Read `universal-rules.md` in full. Create `.claude/references/banned-words-phrases.md` with Rules 2-4b (banned words, phrases, AI patterns, em dashes). Replace sections in `universal-rules.md` with named stubs + reference links. Update "Before Starting" in content-validator.md, seo-writer.md, and copy-enhancer.md to read the new file. Verify coverage. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `references/banned-words-phrases.md` with Rules 2-4b (banned words, phrases, AI patterns, em dashes). Replaced full rule content in `universal-rules.md` with named stubs + reference links. Updated "Before Starting" in content-validator.md, seo-writer.md, and copy-enhancer.md to read the new file.
- **Decisions:** Stubs keep rule names and numbers visible with one-line summaries. Reference links use anchor fragments for direct navigation. Reduction was 157 lines (427 → 270), slightly above the ~155 target.
- **Next:** Task 63 can proceed (extract SEO requirements and citation rules to `seo-requirements.md`). The stub pattern is established and works well for sequential extraction.

---

## Task 63: Extract SEO requirements and citation rules to references

**Objective:** Move Rules 5, 5a, and 6 (SEO requirements, internal link format, external citations) from `universal-rules.md` to a new reference file `seo-requirements.md`. Replace with named stubs. Update agent "Before Starting" sections. Saves ~85 lines from auto-load.

**Context:** These rules only apply to articles. System dev, email, and distribution sessions never need them. Moving them to a reference file means they only load when content agents spawn.

**Depends on:** Task 62 (sequential extraction — do banned words first, then SEO)

**Risk:** MEDIUM — same pattern as Task 62. Mitigated by stub visibility and validator gatekeeper.

**Execution Steps:**
1. Read `universal-rules.md` in full (post Task 62 state)
2. Create `.claude/references/seo-requirements.md` containing:
   - Rule 5: SEO Requirements (keyword placement, content length, meta data, links, structure, H1 format)
   - Rule 5a: Internal Link Format
   - Rule 6: External Citations (E-E-A-T)
3. Replace each section in `universal-rules.md` with named stubs + reference links
4. Add `.claude/references/seo-requirements.md` to "Before Starting" sections in:
   - `content-validator.md`
   - `seo-writer.md`
   - `link-auditor.md`
5. Verify: stubs in `universal-rules.md` still show rule names
6. Verify: reference file contains complete SEO checklist, internal link format, citation rules
7. Verify: all three agents list the new reference file
8. Commit

**Acceptance Criteria:**
- [x] `references/seo-requirements.md` created with Rules 5, 5a, 6
- [x] `universal-rules.md` has named stubs with reference links for each moved rule
- [x] `content-validator.md` "Before Starting" includes new reference file
- [x] `seo-writer.md` "Before Starting" includes new reference file
- [x] `link-auditor.md` "Before Starting" includes new reference file
- [x] `universal-rules.md` reduced by ~83 lines from auto-load (271→188)
- [x] Complete SEO checklist present in reference file
- [x] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 63 for steps. Read `universal-rules.md` in full. Create `.claude/references/seo-requirements.md` with Rules 5, 5a, 6. Replace sections in `universal-rules.md` with named stubs + reference links. Update "Before Starting" in content-validator.md, seo-writer.md, and link-auditor.md. Verify coverage. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `references/seo-requirements.md` with Rules 5, 5a, 6 (SEO requirements, internal link format, external citations). Replaced full rule content in `universal-rules.md` with named stubs + reference links. Updated "Before Starting" in content-validator.md, seo-writer.md, and link-auditor.md to read the new file.
- **Decisions:** Stubs follow same pattern as Task 62 (one-line summary + anchor link). Reduction was 83 lines (271→188), close to ~85 target. Link-auditor "Before Starting" expanded from single-rule reference to full pattern matching other agents.
- **Next:** Task 64 (condense workflow.md), Task 65 (archive agents-prd.md), and Task 66 (multi-client docs) can run in parallel.

---

## Task 64: Condense workflow.md retry/tier details

**Objective:** Condense the retry loop (lines ~54-96) and tier execution (lines ~100-114) sections in `workflow.md` to short summaries with pointers to `execute-pillar/SKILL.md`. Saves ~45 lines from auto-load.

**Context:** Retry loop details and tier execution are only needed during pillar execution. The `execute-pillar/SKILL.md` (791 lines) already contains all these details in expanded form. The auto-loaded `workflow.md` just needs to mention they exist and point to the full source.

**Depends on:** Nothing (independent, can run in parallel with Tasks 65, 66)

**Risk:** LOW — full details remain in `execute-pillar/SKILL.md`.

**Execution Steps:**
1. Read `.claude/rules/workflow.md` in full
2. Read `.claude/skills/execute-pillar/SKILL.md` lines 1-50 to confirm retry/tier details exist there
3. Condense retry loop section (~lines 54-96) to ~5-line summary with pointer to execute-pillar skill
4. Condense tier execution section (~lines 100-114) to ~4-line summary with pointer to execute-pillar skill
5. Keep: 7-step overview, agent pipeline, "agents cannot spawn agents" constraint, agent return formats
6. Verify: workflow overview (steps 1-7) intact
7. Verify: "agents cannot spawn agents" constraint intact
8. Verify: agent return formats intact
9. Commit

**Acceptance Criteria:**
- [ ] Retry loop section condensed to ~5-line summary + pointer
- [ ] Tier execution section condensed to ~4-line summary + pointer
- [ ] 7-step workflow overview preserved
- [ ] "Agents cannot spawn agents" constraint preserved
- [ ] Agent pipeline and return formats preserved
- [ ] `workflow.md` reduced by ~45 lines
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 64 for steps. Read `.claude/rules/workflow.md` in full. Read `.claude/skills/execute-pillar/SKILL.md` lines 1-50 to confirm detail overlap. Condense retry loop to ~5-line summary and tier execution to ~4-line summary, both pointing to execute-pillar skill. Keep overview, constraint, pipeline, return formats. Commit.

**Status:** pending

---

## Task 65: Archive agents-prd.md

**Objective:** Move the 948-line `agents-prd.md` to `.claude/archive/` and update the reference in `CLAUDE.md`. The 6 agent files in `.claude/agents/` are the canonical implementation — the PRD duplicates their specs and contains stale content.

**Depends on:** Nothing (independent, can run in parallel with Tasks 64, 66)

**Risk:** LOW — document served its purpose, agent files are the source of truth.

**Execution Steps:**
1. Read `.claude/agents-prd.md` first 20 lines to confirm it's the design doc
2. Create `.claude/archive/` directory if it doesn't exist
3. Move `.claude/agents-prd.md` to `.claude/archive/agents-prd.md`
4. Add archival note at top of file: `> **Archived:** This PRD served its purpose during initial agent development. The canonical agent specifications now live in .claude/agents/. This file is kept for historical reference only.`
5. Update `CLAUDE.md` reference from `See [Agents PRD](agents-prd.md)` to `Agent files in .claude/agents/`
6. Update any other files that reference `agents-prd.md` (check `workflow.md` agent reference section)
7. Verify: no broken references to `agents-prd.md`
8. Commit

**Acceptance Criteria:**
- [ ] `agents-prd.md` moved to `.claude/archive/agents-prd.md`
- [ ] Archival note added at top of moved file
- [ ] `CLAUDE.md` reference updated
- [ ] `workflow.md` agent reference updated (if applicable)
- [ ] No broken references to `agents-prd.md` anywhere in `.claude/`
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 65 for steps. Move `.claude/agents-prd.md` to `.claude/archive/agents-prd.md` with archival note. Update references in `CLAUDE.md` and `workflow.md`. Grep for any remaining references. Commit.

**Status:** pending

---

## Task 66: Add multi-client path isolation to CLAUDE.md

**Objective:** Add an 8-line "Multi-Client Architecture" subsection to `CLAUDE.md` documenting path isolation rules for scaling to 5+ clients.

**Context:** At 5+ clients, the main risk is context pollution — loading the wrong client's profile. This task adds documentation-only guardrails to prevent it.

**Depends on:** Nothing (independent, can run in parallel with Tasks 64, 65)

**Risk:** LOW — documentation only, no code changes.

**Execution Steps:**
1. Read `.claude/CLAUDE.md` in full
2. Add "Multi-Client Architecture" subsection (suggested location: after the Phase 1 section or as a new section before Rules & References)
3. Content to add (~8 lines):
   - Each client isolated by directory path (`/clients/{name}/`)
   - Agents receive client profile path as explicit input
   - Main session verifies correct profile path before spawning agents
   - Never load multiple client profiles in the same session
4. Verify: section fits naturally in CLAUDE.md structure
5. Verify: no contradictions with existing client profile references
6. Commit

**Acceptance Criteria:**
- [ ] "Multi-Client Architecture" subsection added to CLAUDE.md
- [ ] Contains path isolation rules (4 key points)
- [ ] Fits naturally in document structure
- [ ] No contradictions with existing content
- [ ] ~8 lines added
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 66 for steps. Read `.claude/CLAUDE.md` in full. Add "Multi-Client Architecture" subsection with path isolation rules (each client by directory, explicit profile path input, verify before spawning, never load multiple profiles). Place after Phase 1 or before Rules & References. Commit.

**Status:** pending

---

## Execution Order

```
Tasks 59 + 60 + 61    (parallel — strip agent/skill duplication)
        |
    Task 62            (extract banned words/phrases to references)
        |
    Task 63            (extract SEO rules to references — Task 58 already done)
        |
Tasks 64 + 65 + 66    (parallel — workflow trim + archive PRD + multi-client docs)
```

---
