# Workflow Rules

The single source of truth for content generation workflow. All agents and skills reference this document.

---

## Workflow Overview

The content workflow has 7 steps: 3 manual (require user decisions) and 4 agent-automated.

1. `/keyword-research` (Manual): Client profile → `00-keyword-brief.md`
2. `/start-pillar` (Manual): Keyword brief + pillar → `{pillar}/01-pillar-brief.md`
3. `/positioning-angles` (Manual): Pillar brief + profile → `{pillar}/02-positioning.md`
4. `/seo-content` (Agent): Positioning + profile → `{pillar}/articles/{nn}-{slug}.md`
5. `/direct-response-copy` (Agent): Draft article → updates article in place
6. `/validate-content` (Agent): Final + rules → PASS/FAIL
7. `/content-atomizer` (Agent): Final article → `{pillar}/distribution/{slug}/`

**Manual Steps (1-3):** Interactive skills that require user decisions. Run one at a time with user input.

**Agent-Automated Steps (4-7):** Handled by the 4-agent system. Can run in parallel for multiple articles.

---

## Critical Constraint: Agents Cannot Spawn Agents

From Claude Code's architecture:

> "Subagents cannot spawn other subagents. If your workflow requires nested delegation, use Skills or chain subagents from the main conversation."

This means:
- The **main session** orchestrates ALL agent spawning
- Agents return PASS/FAIL to the main session
- The main session decides what to spawn next
- Retry loops are orchestrated by the main session, not agents

---

## Main Session Orchestration

The main session spawns agents sequentially for each article. Agents return results to the main session; they cannot pass work to each other.

**Pipeline per article:**

1. Main session spawns **SEO Writer** → receives file path + status + word count
2. Main session spawns **Copy Enhancer** → receives status + changes made
3. Main session spawns **Content Validator** → receives PASS/FAIL + issues
   - If PASS: continue to step 4
   - If FAIL: enter retry loop (see below)
4. Main session spawns **Content Atomizer** → receives status + files created
5. Main session commits to git + updates PROJECT-TASKS.md

---

## Retry Loop

On validation FAIL, the main session re-spawns Copy Enhancer (mode: "fix") then Content Validator, up to 3 attempts. Copy Enhancer reads issues from the validation file (file-based, not prompt-based) to prevent context overflow. After 3 failures, escalate to user. Full retry logic: see [Execute Pillar skill](../skills/execute-pillar/SKILL.md) Step 4.

---

## Tier-Based Parallel Execution

Articles are grouped into tiers by internal linking dependencies: Tier 1 (no dependencies) → Tier 2 (references Tier 1) → Tier 3 → Pillar Guide (final). Articles within a tier run in parallel; tiers run sequentially. Commit per tier after all articles pass. Full tier logic: see [Execute Pillar skill](../skills/execute-pillar/SKILL.md) Step 3.

---

## Agent Reference

For full agent specifications, see [agents-prd.md](../agents-prd.md).

- **SEO Writer** (`seo-writer.md`): Write articles with E-E-A-T research. Tools: Read, Glob, Grep, Write
- **Copy Enhancer** (`copy-enhancer.md`): Add persuasion + fix validation issues. Tools: Read, Edit
- **Content Validator** (`content-validator.md`): Check rules + quality, write validation file. Tools: Read, Glob, Grep, Write
- **Content Atomizer** (`content-atomizer.md`): Create platform distribution. Tools: Read, Write

### Agent Return Formats

- **SEO Writer:** returns `PASS, {file_path}`
- **Copy Enhancer:** returns `PASS`
- **Content Validator:** returns `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}`
- **Content Atomizer:** returns `PASS`

**Why minimal returns:** Prevents main session context overflow during pillar execution (32+ articles). Full validation output goes to files, not return messages.

---

*This file is the single source of truth for workflow rules. All agents and skills reference this document. Update here → changes propagate everywhere.*
