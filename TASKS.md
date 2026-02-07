# System Tasks

## Workflow Optimisation: Agent Context Loading & Output Quality

**Source plan:** `workflow-update.md`
**Goal:** Reduce ~91,554 lines loaded across an 8-article pillar to ~52,000 lines (43% reduction) by stripping tables, ASCII diagrams, motivational intros, duplicated content, and extracting reference material to on-demand files.

**Phase 1:** Complete (Tasks 67-83). All agents and automated skills slimmed.
**Phase 2:** Complete (Tasks 84-101). Interactive skills, audit system, templates, and references slimmed. Total reduction: 6,050 lines (-44.7%) across 32 files.
**Phase 3:** Final cleanup. Fix broken references and stale terminology.

---

## Phase 3: Final Cleanup

A 5-agent duplication audit found ~250 lines flagged as "duplicated" across 4 files. On review, most of it is intentional:

- **execute-pillar** operationalises abstract workflow.md rules into concrete steps — that's implementation, not duplication
- **copy-enhancer** replacement examples (navigate → handle) are unique guidance not found in banned-words-phrases.md
- **audit-pillar** repeats "agents cannot spawn agents" where the constraint needs to be enforced — safety, not duplication
- **validate-content** SEO checklist tells the validator what to check — different purpose from the rules reference

What IS broken: 3 dead/stale references, and 1 deprecated term.

---

## Task 102: Fix broken references and stale terminology

**Depends on:** None

**Objective:** Fix 3 broken/stale cross-file references and 1 deprecated term found during the duplication audit.

**What to do:**
1. `references/common-mistakes.md` line ~139: Fix `[Workflow Rules](workflow.md)` to correct relative path `../rules/workflow.md`
2. `skills/direct-response-copy/SKILL.md` line ~10: Fix relative path to `copywriting-frameworks.md` — should resolve correctly from the skill's directory
3. `skills/validate-content/SKILL.md` lines ~731, ~735: Replace "sub-agent" with "agent" (stale terminology from deleted archive files)
4. Grep all `.claude/` files for markdown links and verify each target file exists — report any additional broken links

**Acceptance Criteria:**
- [ ] common-mistakes.md workflow link resolves correctly
- [ ] direct-response-copy/SKILL.md frameworks link resolves correctly
- [ ] Zero occurrences of "sub-agent" in any `.claude/` file
- [ ] Zero broken markdown links across all `.claude/` files

**Starter Prompt:**
> Fix broken references: (1) In `.claude/references/common-mistakes.md`, find the markdown link to `workflow.md` and fix the path. (2) In `.claude/skills/direct-response-copy/SKILL.md`, find the reference to `copywriting-frameworks.md` and fix the relative path. (3) In `.claude/skills/validate-content/SKILL.md`, replace all "sub-agent" with "agent". (4) Grep all `.claude/` files for markdown links `](` and verify each target file exists. Report any additional broken links.

**Status:** pending

---

## Remaining Work

1 task pending: 102

```
Task 102: Fix broken references + stale terminology (no blockers)
```
