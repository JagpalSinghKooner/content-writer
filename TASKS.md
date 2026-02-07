# Project Tasks: HushAway SEO Content Fixes

## Summary

| Task | Status |
|------|--------|
| **CLAUDE.md Slim (plan: giggly-doodling-otter.md)** | |
| Task 55: Move Phase 2 reference sections to `references/` | PASS |
| Task 56: Condense Rules 1-3 and Task Tracking in-place | pending |
| Task 57: Final verification of CLAUDE.md slim | pending |

---

## CLAUDE.md Slim: Move Reference Material + Condense Rules

Full plan documented in `~/.claude/plans/giggly-doodling-otter.md`. Goal: reduce CLAUDE.md from ~386 to ~250 lines by (1) moving reference sections to `references/` and (2) trimming fluff from Rules 1-3.

### Execution Rules

- **Branch:** `cleanup/context-slim` (same branch as Tasks 48-54)
- **Plan:** `~/.claude/plans/giggly-doodling-otter.md` is the single source of truth
- **Sequence:** One task per context window, verify, commit, then next
- **Commit format:** `Cleanup Step {N}: {Description}`

---

## Task 55: Move Phase 2 Reference Sections to `references/`

**Objective:** Extract 3 reference sections from CLAUDE.md Phase 2 (File Naming, Internal Linking, Validation Checkpoints) into new reference files, replacing them with compact pointers. This preserves all information while removing ~96 lines from auto-loaded context.

**Context:** These 3 sections are duplicated in skills that use them: `seo-content/SKILL.md`, `start-pillar/SKILL.md`, `execute-pillar/SKILL.md`, `validate-content/SKILL.md`. The main session loads the relevant skill when doing content work, so the reference material doesn't need to be in CLAUDE.md. Agents never see CLAUDE.md — they get their own agent file.

**Execution Steps:**
1. Read CLAUDE.md in full
2. Create `.claude/references/file-naming-conventions.md` from CLAUDE.md File Naming Conventions section
3. Create `.claude/references/internal-linking-strategy.md` from CLAUDE.md Internal Linking Strategy + Cross-Pillar Linking sections
4. Create `.claude/references/validation-checkpoints.md` from CLAUDE.md Validation Checkpoints section
5. Replace extracted sections in CLAUDE.md with compact pointers (~20 lines):
   - File Naming: 3-line summary + pointer to reference file
   - Pillar-First Execution: **keep as-is** (core principle — do NOT move)
   - Internal Linking: 4-line summary preserving placeholder syntax + pointer
   - Validation: 2-line summary
6. Grep CLAUDE.md for key terms (`LINK NEEDED`, `{nn}-{slug}`, `Post-draft`, `Post-enhancement`) to confirm pointers preserve essentials
7. `wc -l` CLAUDE.md to confirm reduction
8. Commit

**Acceptance Criteria:**
- [ ] 3 new reference files created in `.claude/references/`
- [ ] CLAUDE.md reduced by ~76 lines (after adding ~20 lines of pointers)
- [ ] Placeholder syntax `<!-- LINK NEEDED: [slug] when published -->` preserved in CLAUDE.md pointer
- [ ] Pillar-First Execution section still intact in CLAUDE.md
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 55 for full context. Read `.claude/CLAUDE.md` in full. Extract 3 sections: File Naming Conventions, Internal Linking Strategy + Cross-Pillar Linking, and Validation Checkpoints into new reference files in `.claude/references/`. Replace with compact pointers. Keep Pillar-First Execution in CLAUDE.md. Verify with grep and wc -l. Commit.

**Status:** PASS

---

**Handoff:**
- **Done:** Extracted File Naming Conventions, Internal Linking Strategy + Cross-Pillar Linking, and Validation Checkpoints into 3 new files in `.claude/references/`. Replaced with compact pointers in CLAUDE.md. Pillar-First Execution kept intact.
- **Decisions:** Pointers preserve key syntax (`LINK NEEDED` placeholder, `{nn}-{slug}` pattern) and checkpoint names inline so the main session has enough context without loading reference files.
- **Next:** Task 56 condenses Rules 1-3 and Task Tracking in-place. CLAUDE.md is now 289 lines (down from 387).

---

## Task 56: Condense Rules 1-3 and Task Tracking In-Place

**Objective:** Remove ~55 lines of motivational text, redundant examples, and duplicate explanations from Rules 1-3 and Task Tracking. Every rule stays. Every instruction stays. Only the fluff goes.

**Context:** These deletions are safe because they remove text that restates what the rule spec already says. No rule logic, format specs, checklists, or templates are touched.

**Execution Steps:**
1. Read CLAUDE.md in full
2. Delete these specific blocks (find by content, not line number — lines shifted after Task 55):
   - **Rule #1 "Why This Rule Exists"** (~9 lines): The block starting "Prevents context rot..." through "If you skip this rule, the work fails." Keep the `See [Common Mistakes]` link. Motivational — the CRITICAL warning and checklist already enforce compliance.
   - **Rule #2 example commit** (~8 lines): The code block starting `✅ Complete pillar brief for AI Marketing`. Duplicates the format spec with `{placeholders}` above it.
   - **Rule #2 "PR triggers when"** (~4 lines): The list starting "Pillar guide is written and validated...". Restates the "When a Pillar is Complete" section above it.
   - **Rule #3 error examples block** (~8 lines): The code block with `**[Validation FAIL]** Banned word "leverage"...`. The format `**[Error Type]** {message}` is clear without examples.
   - **Rule #3 closing comment template** (~10 lines): Replace the full code block with 1 line: "Close the Issue with a summary of total errors, patterns extracted, and updates to common-mistakes.md."
   - **Rule #3 "Why This Rule Exists"** (~6 lines): The block starting "Captures everything..." Motivational.
   - **Task Tracking "Why two files?"** (~4 lines): The block starting "TASKS.md (root): Tracks work on the content system itself..." Repeats what the bullet points above already say.
3. Verify all 3 Rule headers still present (grep for "Rule #1", "Rule #2", "Rule #3")
4. Verify CRITICAL warning, STOP checklist, commit format spec, error types list all survived
5. `wc -l` CLAUDE.md — target ~250 lines
6. Commit

**Acceptance Criteria:**
- [ ] All 3 Rule headers present
- [ ] CRITICAL warning in Rule #1 intact
- [ ] STOP checklist in Rule #1 intact
- [ ] PROJECT-TASKS.md template in Rule #1 intact
- [ ] Commit message format spec in Rule #2 intact
- [ ] Error types list in Rule #3 intact
- [ ] CLAUDE.md ~250 lines
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 56 for full context. Read `.claude/CLAUDE.md` in full. Delete: Rule #1 "Why This Rule Exists" block (keep the Common Mistakes link), Rule #2 example commit + "PR triggers when", Rule #3 error examples + closing template (replace with 1 line) + "Why This Rule Exists", Task Tracking "Why two files?". Verify all rules/instructions survived with grep. Report line count. Commit.

**Status:** pending

---

## Task 57: Final Verification of CLAUDE.md Slim

**Objective:** Verify the slimmed CLAUDE.md is correct and complete. Count total auto-loaded lines. Confirm no broken references.

**Execution Steps:**
1. `wc -l` on `.claude/CLAUDE.md`, `.claude/rules/universal-rules.md`, `.claude/rules/workflow.md` — report total
2. Verify `.claude/references/` has 5 files (original 2 + 3 new)
3. Grep CLAUDE.md for all `##` section headers to confirm structure intact
4. Grep for broken paths across `.claude/` (any `references/` path that doesn't exist)
5. Verify each new reference file has content (not empty)
6. Update TASKS.md summary table
7. Commit

**Acceptance Criteria:**
- [ ] Total auto-loaded lines reported (target: ~920)
- [ ] `references/` has 5 files
- [ ] Zero broken path references
- [ ] All 3 new reference files have content
- [ ] TASKS.md summary updated
- [ ] Git commit created

**Starter Prompt:**
> Read TASKS.md Task 57 for steps. Count lines in all 3 auto-loaded files. List `.claude/references/` directory — expect 5 files. Grep for broken paths. Verify reference files have content. Update TASKS.md summary. Commit.

**Status:** pending

---
