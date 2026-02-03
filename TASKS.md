# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 26: Pillar 1 Retrospective | pending |
| Task 27: HushAway File Restructure | pending |
| Task 28: Create Pillar 2 Task File | pending |
| Task 29: Standardize Sub-Agent Workflow | PASS |

**Previous work:** Tasks 1-25 completed (see git history). Git + GitHub setup complete. Error tracking system added. ADHD Sleep pillar complete with 7 articles, direct-response copy, validation, and distribution.

---

## Task 26: Pillar 1 Retrospective

**Objective:** Extract learnings from ADHD Sleep pillar and update common-mistakes.md

**Acceptance Criteria:**
- [ ] Review ADHD Sleep workflow (Tasks 1-8d in PROJECT-TASKS.md)
- [ ] Add patterns to `rules/common-mistakes.md`:
  - Updating wrong TASKS.md (system vs project)
  - Skipping /direct-response-copy step
  - Self-validation instead of /validate-content skill
  - Session ending without workflow completion handoff
- [ ] Document any process improvements for future pillars

**Starter Prompt:**
> Run retrospective on ADHD Sleep pillar (Pillar 1). Read `projects/hushaway/seo-content/PROJECT-TASKS.md` to understand the workflow. Extract recurring error patterns and add them to `rules/common-mistakes.md` using the standard template. Note any process friction for system improvement.

**Status:** pending

---

## Task 27: HushAway File Restructure

**Objective:** Split PROJECT-TASKS.md and centralize distribution folder for multi-pillar workflow.

**Acceptance Criteria:**
- [ ] Create `projects/hushaway/seo-content/distribution/` folder
- [ ] Move `adhd-sleep/distribution/*` to `distribution/adhd-sleep/`
- [ ] Create `adhd-sleep/PROJECT-TASKS.md` (Tasks 1-7 only, content creation)
- [ ] Create `distribution/PROJECT-TASKS.md` (all distribution tasks across pillars)
- [ ] Delete root `projects/hushaway/seo-content/PROJECT-TASKS.md` after split
- [ ] Verify no broken references

**Starter Prompt:**
> Restructure HushAway project for multi-pillar workflow. Reference plan at `/Users/jagpalkooner/.claude/plans/rippling-wobbling-seahorse.md` for exact file structure. Key changes: (1) Centralize distribution folder at project root, (2) Each pillar gets own PROJECT-TASKS.md for content tasks, (3) Centralized distribution/PROJECT-TASKS.md tracks all platform distribution across pillars.

**Status:** pending

---

## Task 28: Create Pillar 2 Task File

**Objective:** Set up PROJECT-TASKS.md for Autistic Meltdowns pillar.

**Acceptance Criteria:**
- [ ] Create `projects/hushaway/seo-content/autistic-meltdowns/` folder
- [ ] Create `autistic-meltdowns/PROJECT-TASKS.md`
- [ ] Include Tasks 1-7 (keyword extraction through validation)
- [ ] Starter prompts reference correct file paths
- [ ] All tasks status: pending

**Starter Prompt:**
> Create PROJECT-TASKS.md for Pillar 2 (Autistic Meltdowns). Reference `00-keyword-brief.md` for pillar details. Structure matches ADHD Sleep but with Pillar 2 specific keywords and angles. Tasks 1-7 only (distribution handled in centralized file). Use starter prompts from ADHD Sleep as template but update paths.

**Status:** pending

---

## Task 29: Standardize Sub-Agent Workflow

**Objective:** Create single source of truth for sub-agent orchestration with explicit fresh context documentation.

**Acceptance Criteria:**
- [x] Create `rules/sub-agent-rules.md` with:
  - Fresh context window principle (explicitly documented)
  - Sub-agent types and responsibilities (Writing, Validation)
  - Task tool invocation syntax
  - Skills sub-agents should invoke (`/seo-content`, `/validate-content`)
  - Return data format specification (path + status + full validation output)
  - Failure handling and escalation
  - Context management principles
  - Orchestration patterns (tier-based, parallel execution)
- [x] Create `templates/sub-agent-validate-content.md` for validation sub-agents
- [x] Update `templates/sub-agent-seo-content.md` with reference to rules file
- [x] Update CLAUDE.md "Sub-Agent Orchestration" section to reference rules file
- [x] Update `/seo-content` SKILL.md with "Non-Interactive Mode" section
- [x] Update `/validate-content` SKILL.md with "Non-Interactive Mode" section
- [x] Add 4 sub-agent patterns to `rules/common-mistakes.md`:
  - Asking clarifying questions in sub-agent context
  - Returning abbreviated validation output
  - Combining writing and validation in single sub-agent
  - Passing content instead of file paths

**Starter Prompt:**
> Implement Task 29: Standardize Sub-Agent Workflow. Create `rules/sub-agent-rules.md` as the single source of truth for sub-agent orchestration. Key requirements: (1) Fresh context windows explicitly documented, (2) Sub-agents invoke skills directly (`/seo-content`, `/validate-content`), (3) Writing and validation are SEPARATE sub-agents, (4) Full validation output returned (not just PASS/FAIL), (5) All clarifying questions resolved BEFORE spawning. Update CLAUDE.md to reference the new rules file. Create validation sub-agent template. Add non-interactive mode sections to skill files. Add 4 patterns to common-mistakes.md. Reference plan at `/Users/jagpalkooner/.claude/plans/functional-coalescing-otter.md`.

**Status:** PASS

---

**Handoff:**
- **Done:** Created comprehensive sub-agent rules system with single source of truth at `rules/sub-agent-rules.md`. Created validation sub-agent template. Updated CLAUDE.md to reference rules file (reduced from ~85 lines to ~20 lines). Added Non-Interactive Mode sections to both `/seo-content` and `/validate-content` skills. Added 4 sub-agent anti-patterns to common-mistakes.md.
- **Decisions:**
  - Fresh context window is the core principle, explicitly documented at top of rules file
  - Writing and validation are always separate sub-agents (never combined)
  - Full validation output required (not abbreviated) for retry decision-making
  - Skills invoked directly by sub-agents (not manual instructions)
  - All templates reference the rules file as source of truth
- **Next:** Tasks 26-28 are pending (Pillar 1 Retrospective, HushAway File Restructure, Create Pillar 2 Task File)

---

**Plan reference:** /Users/jagpalkooner/.claude/plans/rippling-wobbling-seahorse.md
