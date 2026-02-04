# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 22: Implement Minimal Agent Returns | PASS |

**Previous work:** Tasks 1-21 completed (see git history). Agent system fully validated via Task 11 pipeline test. Tasks 19-21 covered UK/US spelling validation, agent workflow fixes, and pillar status tracking.

---

## Task 22: Implement Minimal Agent Returns

**Objective:** Reduce agent return verbosity to prevent main session context overflow during pillar execution.

**Context:** Sensory Overload pillar execution hit 100% context window. Root cause: agents return too much data to main session (full validation reports ~1000+ words, self-validation checklists, banned word checks). 32 verbose returns = context explosion by Tier 5. Full analysis in `agent-audit-2.md`.

**The Fix:** Minimal returns. Main session only needs PASS/FAIL to orchestrate. Detailed output goes to files for consuming agents to read.

**Acceptance Criteria:**
- [x] Update `content-validator.md`: Write full output to `{slug}.validation.md` on FAIL, delete file on PASS, return only `PASS` or `FAIL, {fail_count}, {warn_count}, {file_path}`
- [x] Update `copy-enhancer.md`: In Fix mode, read validation file from path provided; remove banned words check from return (keep internal); return only `PASS`
- [x] Update `seo-writer.md`: Remove self-validation checklist entirely (validator is single source of truth); return only `PASS, {file_path}`
- [x] Update `content-atomizer.md`: Simplify return to just `PASS`
- [x] Update `agents-prd.md`: Update all 4 return format specs to minimal versions
- [x] Update `workflow.md`: Update Agent Return Formats section, update retry logic (3 attempts max, no fail_count threshold), document validation file lifecycle

**New Return Formats:**

| Agent | New Return Format |
|-------|-------------------|
| SEO Writer | `PASS, {file_path}` |
| Copy Enhancer | `PASS` |
| Content Validator | `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}` |
| Content Atomizer | `PASS` |

**Validation File Lifecycle:**
1. FAIL: Validator writes full report to `{slug}.validation.md`, returns minimal
2. Main session spawns copy-enhancer with article path + validation file path
3. Copy-enhancer reads validation file, fixes issues, returns `PASS`
4. Main session spawns validator again
5. PASS: Validator deletes validation file, returns `PASS`
6. After 3 failures: Escalate (validation file remains for debugging)

**Implementation Order:**
1. content-validator.md (highest impact)
2. copy-enhancer.md (must update to read from file)
3. seo-writer.md (remove self-validation)
4. content-atomizer.md (simplify return)
5. agents-prd.md (update specs)
6. workflow.md (update docs)

**Starter Prompt:**
> Implement Task 22: Minimal Agent Returns. Based on `agent-audit-2.md` analysis, update 6 files to reduce agent return verbosity:
>
> 1. `.claude/agents/content-validator.md` — Write full output to `{slug}.validation.md` on FAIL, delete on PASS, return only `PASS` or `FAIL, {counts}, {path}`
> 2. `.claude/agents/copy-enhancer.md` — Read validation file in Fix mode, return only `PASS`
> 3. `.claude/agents/seo-writer.md` — Remove self-validation checklist, return only `PASS, {file_path}`
> 4. `.claude/agents/content-atomizer.md` — Return only `PASS`
> 5. `.claude/agents-prd.md` — Update all 4 return format specs
> 6. `.claude/rules/workflow.md` — Update return formats, retry logic (3 max), validation file lifecycle
>
> Full plan at `task-22-plan.md`
>
> After implementation, test on Calming Sounds pillar to verify context stays manageable.

**Status:** PASS

---

**Handoff:**
- **Done:** All 6 files updated with minimal agent returns. Content Validator now writes full output to `{slug}.validation.md` on FAIL and deletes on PASS. Copy Enhancer reads validation file in Fix mode. SEO Writer removed self-validation checklist. All agents return minimal status.
- **Decisions:** Validator needs Write tool access (added to YAML frontmatter). Validation file placed alongside article in same directory. File deleted on PASS, retained for debugging after 3 failures.
- **Next:** Test on Calming Sounds pillar to verify context stays manageable during full execution.

---
