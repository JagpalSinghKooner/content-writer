# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 1: Create Agents Directory Structure | pending |
| Task 2: Create SEO Writer Agent | pending |
| Task 3: Create Copy Enhancer Agent | pending |
| Task 4: Create Content Validator Agent | pending |
| Task 5: Create Content Atomizer Agent | pending |
| Task 6: Create workflow.md | pending |
| Task 7: Create /execute-pillar Skill | pending |
| Task 8: Update References | pending |
| Task 9: Test Auto-Delegation | pending |
| Task 10: Test Return Formats + Rules at Runtime | pending |
| Task 11: Full Pipeline Validation | pending |

**Previous work:** Tasks 1-29 completed (see git history). Sub-agent system now superseded by Claude Code agent files approach per agents-prd.md.

---

## Task 1: Create Agents Directory Structure

**Objective:** Set up directory structure for agent files and archive deprecated sub-agent files.

**Acceptance Criteria:**
- [ ] Create `.claude/agents/` directory
- [ ] Create `.claude/archive/` directory
- [ ] Create `archive/README.md` explaining what was superseded
- [ ] Move `rules/sub-agent-rules.md` to archive
- [ ] Move `templates/sub-agent-seo-content.md` to archive
- [ ] Move `templates/sub-agent-validate-content.md` to archive

**Starter Prompt:**
> Implement Task 1: Create Agents Directory Structure. Create `.claude/agents/` for agent files and `.claude/archive/` for deprecated files. Write `archive/README.md` explaining these files were superseded by the agent files approach (reference agents-prd.md). Move `rules/sub-agent-rules.md`, `templates/sub-agent-seo-content.md`, and `templates/sub-agent-validate-content.md` to archive. Commit when done.

**Status:** pending

---

## Task 2: Create SEO Writer Agent

**Objective:** Create the SEO Writer agent file with YAML frontmatter and system prompt.

**Acceptance Criteria:**
- [ ] Create `.claude/agents/seo-writer.md`
- [ ] YAML frontmatter includes: name, description, tools (Read, Glob, Grep, Write), model (sonnet), skills (seo-content)
- [ ] System prompt instructs agent to READ `universal-rules.md` and `common-mistakes.md` at runtime
- [ ] Return format matches PRD specification (PASS/FAIL + file path + word count + citations + issues + notes)

**Starter Prompt:**
> Implement Task 2: Create SEO Writer Agent. Create `.claude/agents/seo-writer.md` following the specification in `agents-prd.md` section "1. SEO Writer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Glob, Grep, Write; model: sonnet; skills: seo-content, (2) System prompt instructs agent to READ rules at runtime (not embedded), (3) Return format matches PRD exactly. Commit when done.

**Status:** pending

---

## Task 3: Create Copy Enhancer Agent

**Objective:** Create the Copy Enhancer agent file with two operational modes.

**Acceptance Criteria:**
- [ ] Create `.claude/agents/copy-enhancer.md`
- [ ] YAML frontmatter includes: name, description, tools (Read, Edit), model (sonnet), skills (direct-response-copy)
- [ ] System prompt documents Mode 1: Enhancement Pass
- [ ] System prompt documents Mode 2: Fix Mode (for validation issues)
- [ ] Return format matches PRD specification (PASS/FAIL + mode + changes + issues fixed + notes)

**Starter Prompt:**
> Implement Task 3: Create Copy Enhancer Agent. Create `.claude/agents/copy-enhancer.md` following the specification in `agents-prd.md` section "2. Copy Enhancer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Edit; model: sonnet; skills: direct-response-copy, (2) Two operational modes documented (Enhancement + Fix), (3) Return format matches PRD exactly. Commit when done.

**Status:** pending

---

## Task 4: Create Content Validator Agent

**Objective:** Create the Content Validator agent file with read-only tools and FULL output requirement.

**Acceptance Criteria:**
- [ ] Create `.claude/agents/content-validator.md`
- [ ] YAML frontmatter includes: name, description, tools (Read, Glob, Grep), disallowedTools (Write, Edit, Bash), model (sonnet), skills (validate-content)
- [ ] System prompt instructs agent to READ `universal-rules.md` and `common-mistakes.md` at runtime
- [ ] FULL OUTPUT requirement explicitly documented (never abbreviate, never summarise)
- [ ] Return format matches PRD specification (all 6 validation phases)

**Starter Prompt:**
> Implement Task 4: Create Content Validator Agent. Create `.claude/agents/content-validator.md` following the specification in `agents-prd.md` section "3. Content Validator Agent". Key requirements: (1) YAML frontmatter with tools: Read, Glob, Grep; disallowedTools: Write, Edit, Bash; model: sonnet; skills: validate-content, (2) READ rules at runtime, (3) FULL OUTPUT requirement critical, (4) Return format includes all 6 validation phases. Commit when done.

**Status:** pending

---

## Task 5: Create Content Atomizer Agent

**Objective:** Create the Content Atomizer agent file with platform specifications.

**Acceptance Criteria:**
- [ ] Create `.claude/agents/content-atomizer.md`
- [ ] YAML frontmatter includes: name, description, tools (Read, Write), model (sonnet), skills (content-atomizer)
- [ ] System prompt includes platform specifications (LinkedIn, Twitter, Instagram, Newsletter)
- [ ] Output structure documented: `distribution/{article-slug}/` with 4 platform files
- [ ] Return format matches PRD specification (PASS/FAIL + source + files created + platform summary + notes)

**Starter Prompt:**
> Implement Task 5: Create Content Atomizer Agent. Create `.claude/agents/content-atomizer.md` following the specification in `agents-prd.md` section "4. Content Atomizer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Write; model: sonnet; skills: content-atomizer, (2) Platform specifications for all 4 platforms, (3) Return format matches PRD exactly. Commit when done.

**Status:** pending

---

## Task 6: Create workflow.md

**Objective:** Create single source of truth for workflow rules, consolidating scattered documentation.

**Acceptance Criteria:**
- [ ] Create `rules/workflow.md`
- [ ] Include: 7-step workflow table (Steps 1-3 manual, Steps 4-7 agent-automated)
- [ ] Include: Main session orchestration diagram
- [ ] Include: Single article pipeline (Writer → Enhancer → Validator → Atomizer)
- [ ] Include: Retry loop logic (3 attempts max, then escalate)
- [ ] Include: Tier-based parallel execution rules
- [ ] Include: Validation checkpoints (automatic + manual)
- [ ] Include: Internal linking strategy
- [ ] Include: Error logging format (GitHub Issue)

**Starter Prompt:**
> Implement Task 6: Create workflow.md. Create `rules/workflow.md` as the single source of truth for workflow rules. Reference the "Workflow Consolidation" section in `agents-prd.md` for what to include. Key sections: 7-step workflow table, main session orchestration, single article pipeline, retry loop (3 attempts), tier-based parallel execution, validation checkpoints, internal linking strategy, error logging format. This file consolidates what was scattered across CLAUDE.md and sub-agent-rules.md. Commit when done.

**Status:** pending

---

## Task 7: Create /execute-pillar Skill

**Objective:** Create the skill that documents the full pillar execution workflow for main session orchestration.

**Acceptance Criteria:**
- [ ] Create `.claude/skills/execute-pillar/` directory
- [ ] Create `SKILL.md` with skill metadata
- [ ] Document prerequisites check (pillar brief, positioning, profile exist)
- [ ] Document tier analysis (identify article dependencies)
- [ ] Document tier-based parallel execution pattern
- [ ] Document retry loop logic (max 3 attempts per article)
- [ ] Document error logging to GitHub Issues
- [ ] Document commit/PR workflow
- [ ] Document post-pillar linking pass
- [ ] Document learning loop (extract patterns to common-mistakes.md)

**Starter Prompt:**
> Implement Task 7: Create /execute-pillar Skill. Create `.claude/skills/execute-pillar/SKILL.md` following the specification in `agents-prd.md` section "The /execute-pillar Skill". This is NOT an agent—it's a playbook for main session orchestration. Key sections: prerequisites check, tier analysis, tier-based parallel execution, retry loop (3 attempts), error logging, commit/PR workflow, post-pillar linking pass, learning loop. Triggers: "execute pillar", "run pillar", "/execute-pillar". Commit when done.

**Status:** pending

---

## Task 8: Update References

**Objective:** Update all files that reference deprecated sub-agent approach to reference new workflow.md and agent files.

**Acceptance Criteria:**
- [ ] Update `CLAUDE.md` — Replace "Sub-Agent Orchestration" section with reference to `workflow.md`
- [ ] Update `CLAUDE.md` — Add `workflow.md` to Rules section table
- [ ] Update `CLAUDE.md` — Remove sub-agent template references from Templates section
- [ ] Update `CLAUDE.md` — Document 4 agents + `/execute-pillar` skill in new "Agents" section
- [ ] Update `seo-content/SKILL.md` — Reference `workflow.md` in any pillar mode documentation
- [ ] Update `validate-content/SKILL.md` — Reference `workflow.md` in Non-Interactive Mode section
- [ ] Update `common-mistakes.md` — Rename "Sub-Agent Patterns" → "Agent Orchestration Patterns"
- [ ] Update `common-mistakes.md` — Change references from `sub-agent-rules.md` to `workflow.md`
- [ ] Update `end-to-end-example.md` — Add note about agent-automated Steps 4-7

**Starter Prompt:**
> Implement Task 8: Update References. Update all files that reference the deprecated sub-agent approach. Reference the "Workflow Consolidation" section in `agents-prd.md` for the complete list of updates. Key changes: (1) CLAUDE.md gets new Agents section and references workflow.md, (2) Remove sub-agent template references, (3) common-mistakes.md rename section to "Agent Orchestration Patterns", (4) end-to-end-example.md note about agent automation. Commit when done.

**Status:** pending

---

## Task 9: Test Auto-Delegation

**Objective:** Verify agents auto-delegate based on their description field.

**Acceptance Criteria:**
- [ ] Say "Write an article for keyword X" → auto-delegates to seo-writer
- [ ] Say "Enhance this article" → auto-delegates to copy-enhancer
- [ ] Say "Validate this article" → auto-delegates to content-validator
- [ ] Say "Create distribution content" → auto-delegates to content-atomizer
- [ ] Document test results in handoff

**Starter Prompt:**
> Implement Task 9: Test Auto-Delegation. Test that each agent auto-delegates based on task matching. Test phrases: (1) "Write an article for keyword sleep hygiene" → seo-writer, (2) "Enhance this article" → copy-enhancer, (3) "Validate this article" → content-validator, (4) "Create distribution content for this article" → content-atomizer. Document which delegations worked and any issues in the handoff.

**Status:** pending

---

## Task 10: Test Return Formats + Rules at Runtime

**Objective:** Verify agents return correct formats and read rules at runtime.

**Acceptance Criteria:**
- [ ] SEO Writer returns: PASS/FAIL + file path + word count + citations found
- [ ] Copy Enhancer returns: PASS/FAIL + mode + changes made
- [ ] Content Validator returns: FULL output (not abbreviated) with all 6 phases
- [ ] Content Atomizer returns: PASS/FAIL + files created + platform summary
- [ ] Add test rule to `universal-rules.md` → verify seo-writer and content-validator apply it
- [ ] Document test results in handoff

**Starter Prompt:**
> Implement Task 10: Test Return Formats + Rules at Runtime. Verify each agent returns the correct format per agents-prd.md. Test rules at runtime: add a temporary test rule to `universal-rules.md` (e.g., "Test: Always include word 'verified' somewhere"), run seo-writer and content-validator, confirm they applied the rule, then remove the test rule. Document results in handoff.

**Status:** pending

---

## Task 11: Full Pipeline Validation

**Objective:** Run complete pillar execution to validate the entire agent system.

**Acceptance Criteria:**
- [ ] Run `/execute-pillar` with a test pillar brief
- [ ] Verify tier analysis correctly identifies dependencies
- [ ] Verify parallel execution within tiers (multiple articles spawn together)
- [ ] Verify retry loop triggers on validation failure (intentionally create one)
- [ ] Verify error logging to GitHub Issue works
- [ ] Verify git commits happen after each validation pass
- [ ] Extract any learned patterns to common-mistakes.md
- [ ] Document full test results in handoff

**Starter Prompt:**
> Implement Task 11: Full Pipeline Validation. Run `/execute-pillar` on a test pillar with at least 3 articles. Verify: (1) tier analysis works, (2) parallel execution within tiers, (3) retry loop triggers on failure, (4) errors log to GitHub Issue, (5) commits happen after validation passes. Intentionally include one validation failure to test retry loop. Document all results and any patterns to add to common-mistakes.md.

**Status:** pending

---

**Plan reference:** /Users/jagpalkooner/.claude/plans/virtual-beaming-llama.md
