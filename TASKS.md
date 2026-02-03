# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 1: Create Agents Directory Structure | PASS |
| Task 2: Create SEO Writer Agent | PASS |
| Task 3: Create Copy Enhancer Agent | PASS |
| Task 4: Create Content Validator Agent | PASS |
| Task 5: Create Content Atomizer Agent | PASS |
| Task 6: Create workflow.md | PASS |
| Task 7: Create /execute-pillar Skill | pending |
| Task 8: Update References | pending |
| Task 9: Test Auto-Delegation | pending |
| Task 10: Test Return Formats + Rules at Runtime | pending |
| Task 11: Full Pipeline Validation | pending |
| Task 12: Update universal-rules.md - Em Dash & Heading Rules | pending |
| Task 13: Update CLAUDE.md - Slug Format Rules | pending |
| Task 14: Update content-validator.md - New Validation Checks | pending |
| Task 15: Update seo-writer.md - H1/Slug/Em-Dash Instructions | pending |
| Task 16: Update copy-enhancer.md - Em Dash Fix Mode | pending |
| Task 17: Update common-mistakes.md - New Patterns | pending |
| Task 18: Fix HushAway Profile CTAs | pending |

**Previous work:** Tasks 1-29 completed (see git history). Sub-agent system now superseded by Claude Code agent files approach per agents-prd.md.

---

## Task 1: Create Agents Directory Structure

**Objective:** Set up directory structure for agent files and archive deprecated sub-agent files.

**Acceptance Criteria:**
- [x] Create `.claude/agents/` directory
- [x] Create `.claude/archive/` directory
- [x] Create `archive/README.md` explaining what was superseded
- [x] Move `rules/sub-agent-rules.md` to archive
- [x] Move `templates/sub-agent-seo-content.md` to archive
- [x] Move `templates/sub-agent-validate-content.md` to archive

**Starter Prompt:**
> Implement Task 1: Create Agents Directory Structure. Create `.claude/agents/` for agent files and `.claude/archive/` for deprecated files. Write `archive/README.md` explaining these files were superseded by the agent files approach (reference agents-prd.md). Move `rules/sub-agent-rules.md`, `templates/sub-agent-seo-content.md`, and `templates/sub-agent-validate-content.md` to archive. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/` and `.claude/archive/` directories. Wrote comprehensive `archive/README.md` explaining the old vs new approach with file mapping table. Moved all 3 deprecated files using `git mv`.
- **Decisions:** Used `git mv` to preserve git history for moved files. Archive README includes rationale for keeping files (reference, patterns, rollback) and clear mapping to new locations.
- **Next:** Task 2 creates the first agent file (`seo-writer.md`). The `agents/` directory is now ready to receive agent definitions.

---

## Task 2: Create SEO Writer Agent

**Objective:** Create the SEO Writer agent file with YAML frontmatter and system prompt.

**Acceptance Criteria:**
- [x] Create `.claude/agents/seo-writer.md`
- [x] YAML frontmatter includes: name, description, tools (Read, Glob, Grep, Write), model (sonnet), skills (seo-content)
- [x] System prompt instructs agent to READ `universal-rules.md` and `common-mistakes.md` at runtime
- [x] Return format matches PRD specification (PASS/FAIL + file path + word count + citations + issues + notes)

**Starter Prompt:**
> Implement Task 2: Create SEO Writer Agent. Create `.claude/agents/seo-writer.md` following the specification in `agents-prd.md` section "1. SEO Writer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Glob, Grep, Write; model: sonnet; skills: seo-content, (2) System prompt instructs agent to READ rules at runtime (not embedded), (3) Return format matches PRD exactly. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/seo-writer.md` with complete YAML frontmatter and system prompt. YAML includes name, description, tools (Read, Glob, Grep, Write), model (sonnet), and skills (seo-content). System prompt instructs agent to READ rules at runtime (not embedded), includes 5-step workflow (read context, research E-E-A-T, find internal links, write article, self-validate), and return format matches PRD exactly.
- **Decisions:** Included detailed self-validation checklist in system prompt so agent catches FAIL conditions before returning. Added explicit tool usage table and note about Perplexity MCP fallback to WebSearch.
- **Next:** Task 3 creates Copy Enhancer Agent with two operational modes (Enhancement + Fix).

---

## Task 3: Create Copy Enhancer Agent

**Objective:** Create the Copy Enhancer agent file with two operational modes.

**Acceptance Criteria:**
- [x] Create `.claude/agents/copy-enhancer.md`
- [x] YAML frontmatter includes: name, description, tools (Read, Edit), model (sonnet), skills (direct-response-copy)
- [x] System prompt documents Mode 1: Enhancement Pass
- [x] System prompt documents Mode 2: Fix Mode (for validation issues)
- [x] Return format matches PRD specification (PASS/FAIL + mode + changes + issues fixed + notes)

**Starter Prompt:**
> Implement Task 3: Create Copy Enhancer Agent. Create `.claude/agents/copy-enhancer.md` following the specification in `agents-prd.md` section "2. Copy Enhancer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Edit; model: sonnet; skills: direct-response-copy, (2) Two operational modes documented (Enhancement + Fix), (3) Return format matches PRD exactly. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/copy-enhancer.md` with complete YAML frontmatter and comprehensive system prompt. YAML includes name, description, tools (Read, Edit), model (sonnet), and skills (direct-response-copy). System prompt documents both operational modes with detailed workflows: Enhancement Pass (punch up hooks, CTAs, transitions, apply direct-response principles) and Fix Mode (targeted fixes for validation issues with common fix types table).
- **Decisions:** Included mode detection section so agent can determine which mode from instructions. Added "What NOT to do" sections for both modes to prevent overreach. Added frontmatter preservation guidance for Enhancement mode. Tool usage explicitly notes Edit-only (no Write) to ensure modifications not rewrites.
- **Next:** Task 4 creates Content Validator Agent with read-only tools and FULL output requirement.

---

## Task 4: Create Content Validator Agent

**Objective:** Create the Content Validator agent file with read-only tools and FULL output requirement.

**Acceptance Criteria:**
- [x] Create `.claude/agents/content-validator.md`
- [x] YAML frontmatter includes: name, description, tools (Read, Glob, Grep), disallowedTools (Write, Edit, Bash), model (sonnet), skills (validate-content)
- [x] System prompt instructs agent to READ `universal-rules.md` and `common-mistakes.md` at runtime
- [x] FULL OUTPUT requirement explicitly documented (never abbreviate, never summarise)
- [x] Return format matches PRD specification (all 6 validation phases)

**Starter Prompt:**
> Implement Task 4: Create Content Validator Agent. Create `.claude/agents/content-validator.md` following the specification in `agents-prd.md` section "3. Content Validator Agent". Key requirements: (1) YAML frontmatter with tools: Read, Glob, Grep; disallowedTools: Write, Edit, Bash; model: sonnet; skills: validate-content, (2) READ rules at runtime, (3) FULL OUTPUT requirement critical, (4) Return format includes all 6 validation phases. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/content-validator.md` with complete YAML frontmatter and comprehensive system prompt. YAML includes name, description, tools (Read, Glob, Grep), disallowedTools (Write, Edit, Bash), model (sonnet), and skills (validate-content). System prompt instructs agent to READ rules at runtime with prominent "CRITICAL: Full Output Required" section. All 6 validation phases documented: Universal Rules, Client Profile, Human Quality, Schema Validation, Readability Metrics, Pillar Consistency. Return format matches PRD exactly with all sections.
- **Decisions:** Added prominent "CRITICAL" section at top of system prompt emphasising never abbreviate/summarise requirement. Included content type awareness table for different validation rules per content type. Added missing context handling section showing how to return FAIL when required inputs missing. Used explicit tool denial list (Write, Edit, Bash) via disallowedTools field.
- **Next:** Task 5 creates Content Atomizer Agent with platform specifications for LinkedIn, Twitter, Instagram, and Newsletter.

---

## Task 5: Create Content Atomizer Agent

**Objective:** Create the Content Atomizer agent file with platform specifications.

**Acceptance Criteria:**
- [x] Create `.claude/agents/content-atomizer.md`
- [x] YAML frontmatter includes: name, description, tools (Read, Write), model (sonnet), skills (content-atomizer)
- [x] System prompt includes platform specifications (LinkedIn, Twitter, Instagram, Newsletter)
- [x] Output structure documented: `distribution/{article-slug}/` with 4 platform files
- [x] Return format matches PRD specification (PASS/FAIL + source + files created + platform summary + notes)

**Starter Prompt:**
> Implement Task 5: Create Content Atomizer Agent. Create `.claude/agents/content-atomizer.md` following the specification in `agents-prd.md` section "4. Content Atomizer Agent". Key requirements: (1) YAML frontmatter with tools: Read, Write; model: sonnet; skills: content-atomizer, (2) Platform specifications for all 4 platforms, (3) Return format matches PRD exactly. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/content-atomizer.md` with complete YAML frontmatter and comprehensive system prompt. YAML includes name, description, tools (Read, Write), model (sonnet), and skills (content-atomizer). System prompt includes detailed platform specifications for all 4 platforms (LinkedIn, Twitter/X, Instagram, Newsletter) with character limits, format requirements, and content structure. Output structure documented with `distribution/{article-slug}/` folder containing 4 platform files.
- **Decisions:** Included comprehensive platform specs with character limits, carousel slide counts, thread lengths, and reel durations. Added voice adaptation guidance for each platform. Return format matches PRD exactly with platform summary showing counts for each content type.
- **Next:** Task 6 creates workflow.md as single source of truth for workflow rules.

---

## Task 6: Create workflow.md

**Objective:** Create single source of truth for workflow rules, consolidating scattered documentation.

**Acceptance Criteria:**
- [x] Create `rules/workflow.md`
- [x] Include: 7-step workflow table (Steps 1-3 manual, Steps 4-7 agent-automated)
- [x] Include: Main session orchestration diagram
- [x] Include: Single article pipeline (Writer → Enhancer → Validator → Atomizer)
- [x] Include: Retry loop logic (3 attempts max, then escalate)
- [x] Include: Tier-based parallel execution rules
- [x] Include: Validation checkpoints (automatic + manual)
- [x] Include: Internal linking strategy
- [x] Include: Error logging format (GitHub Issue)

**Starter Prompt:**
> Implement Task 6: Create workflow.md. Create `rules/workflow.md` as the single source of truth for workflow rules. Reference the "Workflow Consolidation" section in `agents-prd.md` for what to include. Key sections: 7-step workflow table, main session orchestration, single article pipeline, retry loop (3 attempts), tier-based parallel execution, validation checkpoints, internal linking strategy, error logging format. This file consolidates what was scattered across CLAUDE.md and sub-agent-rules.md. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `rules/workflow.md` as the single source of truth for workflow rules. Includes all required sections: 7-step workflow table (manual vs agent-automated), main session orchestration diagram, single article pipeline, retry loop (3 attempts max), tier-based parallel execution with tier identification rules, validation checkpoints (automatic + manual), internal linking strategy with placeholder convention, error logging format for GitHub Issues. Also includes agent reference table and auto-delegation triggers.
- **Decisions:** Added file structure section and article numbering conventions. Included cross-pillar linking guidance. Used ASCII diagrams for orchestration flows to match PRD style. Added agent return formats table for quick reference.
- **Next:** Task 7 creates /execute-pillar skill as the playbook for main session orchestration.

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

## Task 12: Update universal-rules.md - Em Dash & Heading Rules

**Objective:** Add em dash ban, H1 keyword+hook requirement, heading uniqueness rule, and fix citation format.

**Acceptance Criteria:**
- [x] Add new FAIL rule: No Em Dashes (Rule 4b after AI Patterns)
- [x] Include restructuring examples (not replacement with other punctuation)
- [x] Update Rule 5 (SEO Requirements) Structure section with H1 keyword+hook requirement
- [x] Add H1 format examples showing bad (keyword-only) vs good (keyword+hook)
- [x] Add heading uniqueness rule (no duplicate text across H1/H2/H3)
- [x] Fix citation format: change em dash to colon `[Author], [Year]: [title](URL)`

**Starter Prompt:**
> Implement Task 12: Update universal-rules.md with em dash and heading rules. Add Rule 4b "No Em Dashes" as a FAIL condition after Rule 4 (AI Patterns). Include table of restructuring examples (not replacements). Update Rule 5 Structure section: H1 must contain primary keyword + hook, add examples table, add heading uniqueness rule. Fix citation format on line ~269 to use colon instead of em dash. Reference plan file for exact content. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated universal-rules.md with 6 changes: (1) Added Rule 4b "No Em Dashes" with restructuring examples table, (2) Updated Scope table to include Rule 4b, (3) Updated Rule 5 Structure section with H1 keyword+hook requirement, (4) Added H1 format examples table (bad vs good), (5) Added heading uniqueness rule, (6) Fixed citation format from em dash to colon
- **Decisions:** Em dashes apply to ALL content types (marked ✓ across the board in Scope table). Restructuring examples show full sentence rewrites, not simple punctuation swaps.
- **Next:** Task 13 updates CLAUDE.md slug format rules

---

## Task 13: Update CLAUDE.md - Slug Format Rules

**Objective:** Change slug rules from "contains keyword" to descriptive-first format.

**Acceptance Criteria:**
- [ ] Update Slug Rules section (around line 310-315)
- [ ] Change rule from "Contains primary keyword" to "Descriptive-first format"
- [ ] Add format pattern: `{context}-{keyword}`
- [ ] Add examples showing bad (keyword-only) vs good (descriptive-first)
- [ ] Update any slug examples elsewhere in file to match new format

**Starter Prompt:**
> Implement Task 13: Update CLAUDE.md slug format rules. Find the Slug Rules section (~line 310) and change the "Contains primary keyword" rule to require descriptive-first format. Add format: `{context}-{keyword}` with examples like "understanding-adhd-sleep-problems" NOT "adhd-sleep". Search for other slug examples in the file and update them to match. Commit when done.

**Status:** pending

---

## Task 14: Update content-validator.md - New Validation Checks

**Objective:** Add 5 new validation checks: em dash, H1 keyword, H1 hook, heading uniqueness, slug format.

**Acceptance Criteria:**
- [ ] Add Em Dash Check to Phase 1 (Universal Rules) - FAIL if any "—" found
- [ ] Add H1 Validation - FAIL if keyword missing or H1 is keyword-only
- [ ] Add Heading Uniqueness - FAIL if duplicate heading text found
- [ ] Add Slug Format check - WARN if slug appears keyword-only
- [ ] Each check includes clear pass/fail criteria with line number reporting

**Starter Prompt:**
> Implement Task 14: Update content-validator.md with new validation checks. Add to Phase 1 (Universal Rules): (1) Em dash check - FAIL if any "—" found with line numbers, (2) H1 validation - FAIL if keyword missing or no hook, (3) Heading uniqueness - FAIL if duplicate text across H1/H2/H3, (4) Slug format - WARN if keyword-only. Reference plan file for exact check format. Commit when done.

**Status:** pending

---

## Task 15: Update seo-writer.md - H1/Slug/Em-Dash Instructions

**Objective:** Add explicit instructions for H1 format, slug format, and em dash ban.

**Acceptance Criteria:**
- [ ] Add H1 Format section with formula: [Keyword]: [Hook]
- [ ] Include H1 examples (good and bad)
- [ ] Add Slug Format section with descriptive-first pattern
- [ ] Include slug examples (good and bad)
- [ ] Add No Em Dashes section with restructuring guidance
- [ ] These instructions appear in the agent's system prompt (not just referenced)

**Starter Prompt:**
> Implement Task 15: Update seo-writer.md with H1, slug, and em dash instructions. Add three new sections to the system prompt: (1) H1 Format - formula [Keyword]: [Hook] with examples, (2) Slug Format - descriptive-first pattern with examples, (3) No Em Dashes - restructure sentences, never use "—". These must be explicit instructions the agent follows, not references to other files. Reference plan file for exact content. Commit when done.

**Status:** pending

---

## Task 16: Update copy-enhancer.md - Em Dash Fix Mode

**Objective:** Add em dash detection and fix to the copy enhancer's enhancement checklist.

**Acceptance Criteria:**
- [ ] Add Em Dash Removal section to Enhancement Pass workflow
- [ ] Document as FAIL condition that must be fixed
- [ ] Include process: find → restructure (not replace)
- [ ] Include before/after examples
- [ ] Ensure this check runs in both Enhancement and Fix modes

**Starter Prompt:**
> Implement Task 16: Update copy-enhancer.md with em dash fix capability. Add "Em Dash Removal (FAIL Condition)" section to the Enhancement Pass. Document process: scan for "—", restructure each sentence (not replace with other punctuation), split into separate sentences or reword. Include before/after table. Ensure this check applies to both Enhancement and Fix modes. Reference plan file for exact content. Commit when done.

**Status:** pending

---

## Task 17: Update common-mistakes.md - New Patterns

**Objective:** Add three new patterns: em dash overuse, keyword-only slugs, H1 without hook.

**Acceptance Criteria:**
- [ ] Add "Em dash overuse" pattern with Pattern/Why it fails/Fix format
- [ ] Add "Keyword-only slugs" pattern with examples
- [ ] Add "H1 without hook" pattern with examples
- [ ] Patterns follow existing format in the file
- [ ] Patterns are actionable and include clear fixes

**Starter Prompt:**
> Implement Task 17: Update common-mistakes.md with three new patterns. Add: (1) "Em dash overuse" - using "—" for pauses/asides, fix is restructure not replace, (2) "Keyword-only slugs" - slugs that are just keywords, fix is descriptive-first format, (3) "H1 without hook" - H1 that's just keyword, fix is add curiosity/value hook. Follow existing pattern format in the file. Reference plan file for exact content. Commit when done.

**Status:** pending

---

## Task 18: Fix HushAway Profile CTAs

**Objective:** Fix incorrect CTA templates in HushAway client profile.

**Acceptance Criteria:**
- [ ] Remove CTA templates that say "no signup" (incorrect - users DO sign up)
- [ ] Remove CTA templates that mention "free" or pricing
- [ ] Remove em dashes from any CTA templates
- [ ] Add new CTA templates focused on benefit/experience
- [ ] Add CTA Rules section documenting what to avoid

**Starter Prompt:**
> Implement Task 18: Fix HushAway Profile CTAs. Edit clients/hushaway/profile.md lines 339-342. Remove current CTAs that incorrectly say "no signup" or mention "free". Replace with benefit-focused CTAs: "Explore The Open Sanctuary", "Try a sound from The Open Sanctuary tonight", "Enter The Open Sanctuary", "Discover sounds in The Open Sanctuary". Add CTA Rules: never mention pricing, never say "no signup", focus on benefit not transaction. Commit when done.

**Status:** pending

---

**Plan reference:** /Users/jagpalkooner/.claude/plans/lovely-enchanting-cray.md
