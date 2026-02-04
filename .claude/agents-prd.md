# Agents PRD: A*-Level Sub-Agent System

**Status:** Ready for Implementation
**Created:** 2026-02-03
**Updated:** 2026-02-03
**Purpose:** Complete reference document for implementing the content generation agent system

---

## CRITICAL: How Claude Code Agents Work

Before reading this document, understand these fundamental constraints:

### Agents Cannot Spawn Other Agents

> **From Claude Code documentation:** "Subagents cannot spawn other subagents. If your workflow requires nested delegation, use Skills or chain subagents from the main conversation."

This means:
- The **main session** orchestrates ALL agent spawning
- Agents return PASS/FAIL to the main session
- The main session decides what to spawn next
- The retry loop (Validator FAIL → Enhancer → Validator) is orchestrated by the main session

### Agent Files vs Task Tool Prompts

Claude Code supports two approaches for custom agents:

| Approach | How It Works | Our Choice |
|----------|--------------|------------|
| **Agent Files** | Create `.claude/agents/*.md` with YAML frontmatter. Claude auto-delegates based on `description`. Skills preload via `skills:` field. | **This is our approach** |
| Task Tool Prompts | Main session manually constructs prompts and passes to Task tool with `general-purpose` subagent. | Not used |

### Skills Stay in Project

Skills remain in `.claude/skills/`. The agent's `skills:` field in YAML frontmatter tells Claude Code to preload that skill's content into the agent's context at startup. You don't paste skill content into prompts.

### Supported YAML Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier (lowercase, hyphens) |
| `description` | Yes | When Claude should delegate to this agent |
| `tools` | No | Tools the agent can use (inherits all if omitted) |
| `disallowedTools` | No | Tools to deny |
| `model` | No | `sonnet`, `opus`, `haiku`, or `inherit` |
| `permissionMode` | No | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `skills` | No | Skills to preload into agent's context |
| `hooks` | No | Lifecycle hooks scoped to this agent |

---

## Executive Summary

This document defines a 4-agent system for high-volume SEO content generation. Each agent runs in its own fresh context window, enabling parallel execution, focused specialization, and efficient resource usage.

**Key outcomes:**
- Parallel article generation (tier-based for internal linking)
- Automatic retry loop for validation failures (orchestrated by main session)
- Learning system that improves from mistakes
- Auto-delegation based on task detection

---

## Architecture Overview

### The 4 Agents

| Agent | File | Purpose | Model | Fresh Context |
|-------|------|---------|-------|---------------|
| **SEO Writer** | `seo-writer.md` | Write articles with E-E-A-T research | Opus | Yes |
| **Copy Enhancer** | `copy-enhancer.md` | Add persuasion + fix validation issues | Opus | Yes |
| **Content Validator** | `content-validator.md` | Check rules + quality (read-only) | Sonnet | Yes |
| **Content Atomizer** | `content-atomizer.md` | Create platform distribution | Sonnet | Yes |

### Why These 4 Agents?

| Task | Frequency | Why Agent? |
|------|-----------|------------|
| Writing | 10+ per pillar | High volume, parallelizable, benefits from fresh focus |
| Enhancement | After every article | Repeatable, creative work benefits from isolation |
| Validation | After every article | Rule-checking in fresh context catches more issues |
| Atomization | After every article | Platform-specific work benefits from dedicated context |

### What Stays as Interactive Skills?

| Skill | Why NOT an Agent |
|-------|------------------|
| `/keyword-research` | One-time per project, needs user decisions |
| `/start-pillar` | Strategic, needs user input |
| `/positioning-angles` | Strategic, needs approval |
| `/onboard-client` | Interactive interview format |
| `/email-sequences` | Less frequent, more strategic |
| `/newsletter` | Less frequent, varies by edition |
| `/orchestrator` | Marketing strategist — routes to skills, doesn't execute |

### The `/execute-pillar` Skill

**File:** `.claude/skills/execute-pillar/SKILL.md`

The `/execute-pillar` skill documents the **full pillar execution workflow** that the main session follows. It is NOT an agent — it is a playbook for orchestration.

**What it documents:**
1. Prerequisites check (pillar brief, positioning, profile exist)
2. Tier analysis (identify article dependencies)
3. Tier-based parallel execution pattern
4. Retry loop logic (max 3 attempts per article)
5. Error logging to GitHub Issues
6. Commit/PR workflow
7. Post-pillar linking pass
8. Learning loop (extract patterns to common-mistakes.md)

**Why this matters:**
- **Single source of truth** for execution workflow
- Update workflow in one place, changes propagate everywhere
- Main session follows the skill's instructions step by step

**Triggers:** "execute pillar", "run pillar", "generate pillar content", "/execute-pillar"

---

## Agent Specifications

### 1. SEO Writer Agent

**File:** `.claude/agents/seo-writer.md`

**YAML Frontmatter:**
```yaml
---
name: seo-writer
description: Write SEO-optimized articles with E-E-A-T research and citations. Use proactively when writing articles, blog posts, or content for keywords.
tools: Read, Glob, Grep, Write
model: opus
skills:
  - seo-content
---
```

**Note on MCP Tools:** If Perplexity MCP is enabled at the project level, the agent will have access to `mcp__perplexity__*` tools automatically. These don't need to be listed in the `tools` field.

**System Prompt Must Include:**

The system prompt is the markdown body AFTER the YAML frontmatter. It should contain:

1. **Instructions for the agent's workflow** — Not the full skill content (that's preloaded via `skills:`)
2. **Instructions to READ rules at runtime** — Agent reads `universal-rules.md` and `common-mistakes.md` (not embedded)
3. **Return format specification** — How to structure the PASS/FAIL response
4. **Instructions to:**
   - Read client profile for brand voice
   - Read positioning document for angle
   - Read pillar brief for keyword data
   - Use web search for E-E-A-T citations (2-4 per article)
   - Follow article-template.md structure
   - Self-validate against FAIL conditions before returning

**Rules at Runtime (Not Embedded):**

The system prompt should include:
```
Before writing, read these files and apply all rules:
- `.claude/rules/universal-rules.md` — All FAIL/WARN conditions
- `.claude/rules/common-mistakes.md` — Learned patterns to avoid

Do not output content that violates FAIL conditions.
```

**Why rules are READ, not embedded:**
- Update `universal-rules.md` once → all agents see the update
- Update `common-mistakes.md` once → all agents see the update
- No need to regenerate agent files when rules change
- Single source of truth for content rules

**Tool Access:**
| Tool | Why |
|------|-----|
| Read | Read context files (profile, positioning, brief) |
| Glob | Find existing articles for internal linking |
| Grep | Search for patterns in codebase |
| Write | Create the article file |

**Note:** Web search and Perplexity tools are available if enabled at project level via MCP.

**Return Format:**
```
PASS, {file_path}
```

**Example:** `PASS, projects/client/pillar/articles/01-article-slug.md`

On FAIL: `FAIL: {brief reason}`

**Why minimal:** Content Validator is single source of truth for validation. Main session only needs file path to pass to next agent.

---

### 2. Copy Enhancer Agent

**File:** `.claude/agents/copy-enhancer.md`

**YAML Frontmatter:**
```yaml
---
name: copy-enhancer
description: Enhance articles with direct-response copy principles. Use after writing articles or when validation fails. Handles both enhancement passes and fixing specific validation issues.
tools: Read, Edit
model: opus
skills:
  - direct-response-copy
---
```

**System Prompt Must Include:**
1. Full `/direct-response-copy` skill content
2. Two operational modes:

**Mode 1: Enhancement Pass**
- Read the article
- Apply direct-response principles
- Punch up hooks, CTAs, transitions
- Add persuasion without making it salesy
- Maintain brand voice

**Mode 2: Fix Mode** (when given validation issues)
- Read the specific FAIL issues
- Make targeted fixes only
- Don't over-edit working content
- Address each issue with line-specific changes

**Tool Access:**
| Tool | Why |
|------|-----|
| Read | Read article and any reference files |
| Edit | Make changes to the article |

**Return Format:**
```
PASS
```

On FAIL: `FAIL: {brief reason}`

**Fix Mode:** Reads validation file at provided path instead of receiving issues in prompt.

**Why minimal:** Main session only needs to know edits completed. Banned word checks run internally.

---

### 3. Content Validator Agent

**File:** `.claude/agents/content-validator.md`

**YAML Frontmatter:**
```yaml
---
name: content-validator
description: Validate content against universal rules and brand voice. Use after enhancement. Read-only - never modifies content, only reports issues.
tools: Read, Glob, Grep, Write
disallowedTools: Edit, Bash
model: sonnet
skills:
  - validate-content
---
```

**System Prompt Must Include:**
1. Full `/validate-content` skill workflow
2. Instructions to READ rules at runtime (not embedded):
   ```
   Before validating, read these files:
   - `.claude/rules/universal-rules.md` — All FAIL/WARN conditions
   - `.claude/rules/common-mistakes.md` — Learned patterns to check
   ```
3. All 6 validation phases:
   - Phase 1: Universal Rules Check
   - Phase 2: Client Profile Check
   - Phase 3: Human Quality Assessment
   - Phase 4: Schema Validation
   - Phase 5: Readability Metrics
   - Phase 6: Pillar Consistency

**CRITICAL: File-Based Output**
```
Full validation output goes to {slug}.validation.md, NOT the return message.
On FAIL: Write full report to file, return minimal status.
On PASS: Delete any existing validation file, return "PASS".
```

**Why rules are READ, not embedded:**
- Update `universal-rules.md` → Validator sees the update immediately
- Update `common-mistakes.md` → Validator catches new patterns
- Single source of truth for what constitutes FAIL/WARN

**Tool Access:**
| Tool | Why |
|------|-----|
| Read | Read article, profile, rules |
| Glob | Find related files |
| Grep | Search for patterns |

**Explicitly Denied:**
- Edit (cannot modify article content)
- Bash (no shell access)

**Note:** Write tool IS available for creating/deleting validation files only.

**Return Format:**

On PASS:
```
PASS
```

On FAIL:
```
FAIL, {fail_count}, {warn_count}, {validation_file_path}
```

**Example:** `FAIL, 3, 2, projects/client/pillar/articles/01-article-slug.validation.md`

**Validation File:** Full report written to `{slug}.validation.md` alongside article on FAIL. Deleted on PASS.

**Why file-based:** Prevents main session context overflow during pillar execution. Copy Enhancer reads validation file directly.

---

### 4. Content Atomizer Agent

**File:** `.claude/agents/content-atomizer.md`

**YAML Frontmatter:**
```yaml
---
name: content-atomizer
description: Transform articles into platform-specific distribution content. Use after validation passes. Creates LinkedIn, Twitter, Instagram, and Newsletter content.
tools: Read, Write
model: sonnet
skills:
  - content-atomizer
---
```

**System Prompt Must Include:**
1. Full `/content-atomizer` skill content
2. Platform specifications:
   - LinkedIn: Carousel slides + text posts
   - Twitter/X: Thread + single tweets
   - Instagram: Carousel + Reel script
   - Newsletter: Snippet for email

**Output Structure:**
```
distribution/{article-slug}/
├── linkedin.md
├── twitter.md
├── instagram.md
└── newsletter.md
```

**Tool Access:**
| Tool | Why |
|------|-----|
| Read | Read source article |
| Write | Create distribution files |

**Return Format:**
```
PASS
```

On FAIL: `FAIL: {brief reason}`

**Why minimal:** Files written to predictable paths (`distribution/{slug}/`). Main session only needs to know completion status.

---

## Workflow Pipeline

### Main Session Orchestration (Critical)

**The main session orchestrates ALL agent spawning.** Agents return to the main session; they cannot spawn other agents.

```
MAIN SESSION receives task
    │
    ├─→ Main session spawns SEO WRITER
    │       └─→ Agent returns: PASS, {file_path}
    │           └─→ Main session receives result
    │
    ├─→ Main session spawns COPY ENHANCER
    │       └─→ Agent returns: PASS
    │           └─→ Main session receives result
    │
    ├─→ Main session spawns CONTENT VALIDATOR
    │       └─→ Agent returns: PASS or FAIL, {counts}, {validation_file_path}
    │           └─→ Main session receives result
    │                   │
    │                   ├─→ If PASS: Continue to atomizer
    │                   │
    │                   └─→ If FAIL: Main session spawns COPY ENHANCER (fix mode)
    │                               - Passes: article_path, validation_file_path
    │                               └─→ Main session spawns VALIDATOR again
    │                               └─→ Repeat up to 3 times
    │                               └─→ After 3 failures: Escalate to user
    │
    ├─→ Main session spawns CONTENT ATOMIZER
    │       └─→ Agent returns: PASS
    │           └─→ Main session receives result
    │
    └─→ Main session commits to git + updates PROJECT-TASKS.md
```

### Single Article Pipeline (Visual)

```
┌─────────────────────────────────────────────────────────────────┐
│                      MAIN SESSION                                │
│                     (Orchestrator)                               │
│                                                                  │
│  Main session SPAWNS each agent and RECEIVES results back.       │
│  Agents do NOT pass to each other — they return to main session.│
└──────────────────────────┬──────────────────────────────────────┘
                           │
                     spawns ▼ receives result
┌─────────────────────────────────────────────────────────────────┐
│  1. SEO WRITER AGENT (fresh context)                            │
│     - Reads: profile, positioning, brief                        │
│     - Has preloaded: seo-content skill                          │
│     - Reads at runtime: universal-rules, common-mistakes        │
│     - Writes: Article to disk                                   │
│     - Returns TO MAIN SESSION: PASS, {file_path}                │
└─────────────────────────────────────────────────────────────────┘
                           │
                     spawns ▼ receives result
┌─────────────────────────────────────────────────────────────────┐
│  2. COPY ENHANCER AGENT (fresh context)                         │
│     - Receives from main session: Article path                  │
│     - Has preloaded: direct-response-copy skill                 │
│     - Edits: Article in place                                   │
│     - Returns TO MAIN SESSION: PASS                             │
└─────────────────────────────────────────────────────────────────┘
                           │
                     spawns ▼ receives result
┌─────────────────────────────────────────────────────────────────┐
│  3. CONTENT VALIDATOR AGENT (fresh context)                     │
│     - Receives from main session: Article path                  │
│     - Has preloaded: validate-content skill                     │
│     - Reads at runtime: universal-rules, common-mistakes        │
│     - Checks: All 6 validation phases                           │
│     - On PASS: Deletes validation file, returns PASS            │
│     - On FAIL: Writes to {slug}.validation.md, returns minimal  │
└─────────────────────────────────────────────────────────────────┘
                           │
              ┌────────────┴────────────┐
              │                         │
           PASS                       FAIL
              │                         │
     Main session             Main session runs
     spawns next              RETRY LOOP (below)
              │                         │
              ▼                         ▼
┌─────────────────────┐    ┌─────────────────────────────────────┐
│  4. CONTENT         │    │  RETRY LOOP (main session runs):    │
│     ATOMIZER        │    │                                     │
│     (fresh context) │    │  1. Read validation file path from  │
│                     │    │     FAIL return                     │
│  Creates:           │    │  2. Spawn Copy Enhancer with:       │
│  - linkedin.md      │    │     article_path + validation_path  │
│  - twitter.md       │    │  3. Spawn Content Validator         │
│  - instagram.md     │    │  4. If PASS → continue (file deleted│
│  - newsletter.md    │    │  5. If FAIL → repeat (max 3x)       │
│  Returns: PASS      │    │  6. After 3 failures → escalate     │
└──────────────────────┘    └─────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────────────┐
│  MAIN SESSION: Git commit + update PROJECT-TASKS.md             │
└─────────────────────────────────────────────────────────────────┘
```

### Tier-Based Parallel Execution (Multiple Articles)

```
Main Session (Orchestrator)
    │
    ├─→ TIER 1: Articles with no internal link dependencies
    │   │
    │   ├─→ Article 01 pipeline (parallel)─┐
    │   ├─→ Article 02 pipeline (parallel)─┼─→ All complete → commit all
    │   └─→ Article 03 pipeline (parallel)─┘
    │
    ├─→ TIER 2: Articles that need Tier 1 links
    │   │
    │   ├─→ Article 04 pipeline (parallel)─┐
    │   └─→ Article 05 pipeline (parallel)─┴─→ All complete → commit all
    │
    └─→ FINAL TIER: Pillar Guide (needs all articles)
        │
        └─→ Pillar guide pipeline → commit → PR
```

### Tier Identification

From pillar brief, identify dependencies:

| Article | Links To | Tier |
|---------|----------|------|
| Article with no internal links needed | - | Tier 1 |
| Article that references Tier 1 articles | Tier 1 | Tier 2 |
| Pillar Guide (links to all) | All articles | Final |

---

## Error Handling & Learning

### Retry Flow (Main Session Orchestrates)

**Remember:** Agents cannot spawn agents. The main session runs this entire loop.

```
Main session receives FAIL from Validator (attempt N)
    │
    │   Validator returned: FAIL, {fail_count}, {warn_count}, {validation_file_path}
    │
    ├─ If N < 3:
    │   │
    │   ├─→ Main session SPAWNS Copy Enhancer with:
    │   │     - Article path
    │   │     - Validation file path (enhancer reads issues from file)
    │   │     - Mode: "fix"
    │   │
    │   ├─→ Copy Enhancer returns PASS to main session
    │   │
    │   ├─→ Main session SPAWNS Content Validator again
    │   │
    │   └─→ If PASS → Validator deletes validation file, main session continues to Atomizer
    │       If FAIL → Main session increments N, repeats loop
    │
    └─ If N >= 3:
        │
        ├─→ Main session logs failure to PROJECT-TASKS.md
        ├─→ Main session logs to GitHub Issue (if error tracking active)
        └─→ Main session escalates to user (validation file remains for debugging)
```

**Why main session orchestrates:** Agents have fresh context windows. They can't remember previous validation attempts or coordinate with each other. Only the main session can track retry count, pass issues between agents, and make escalation decisions.

### Error Logging

**During Pillar:**
1. All errors logged to GitHub Issue: `🔴 Errors: {Pillar Name}`
2. Errors also logged to PROJECT-TASKS.md under relevant task

**Error Log Format:**
```
**[Validation FAIL]** Line 23: "color" - US spelling → use "colour"

**[Validation FAIL]** Line 45: "leverage" - banned AI word → use "use"
```

### Learning Loop

**After Pillar Completion:**
1. Main session reviews all logged errors in GitHub Issue
2. Identifies patterns (same error 3+ times)
3. Extracts patterns to `common-mistakes.md`
4. Closes GitHub Issue with summary

**Pattern Extraction Template:**
```markdown
### [Pattern Name] (Issue #{number})

**Pattern:** What to look for

**Why it fails:** Explanation

**Fix:** How to correct

**Source:** {pillar name} — {count} occurrences
```

---

## Agent System Prompt Structure

Each agent file has two parts:

1. **YAML Frontmatter** — Configuration (name, description, tools, skills, model)
2. **Markdown Body** — The system prompt the agent receives

### What Gets Preloaded vs What Gets Read at Runtime

| Content Type | How It's Loaded | Why |
|--------------|-----------------|-----|
| **Skills** | Preloaded via `skills:` field | Claude Code automatically injects full skill content at startup |
| **Rules** | **READ at runtime** | Agent reads `universal-rules.md` when it starts — updates are automatic |
| **Common Mistakes** | **READ at runtime** | Agent reads `common-mistakes.md` when it starts — learns from new patterns |
| **Context files** | **READ at runtime** | Profile, positioning, pillar brief — passed by main session |

### Single Source of Truth

**This is a key design decision:**

| What | Source File | Update Location |
|------|-------------|-----------------|
| Content rules | `universal-rules.md` | One place |
| Learned patterns | `common-mistakes.md` | One place |
| **Workflow rules** | **`rules/workflow.md`** | **One place** |
| Execution workflow | `/execute-pillar` skill | One place |
| Agent behaviors | `.claude/agents/*.md` | One place each |

**Update the source → All agents see the change. No duplication.**

---

### Workflow Consolidation

The workflow is currently scattered across multiple files. We consolidate into `rules/workflow.md` as the single source of truth.

#### What Goes in `workflow.md`

| Section | Content |
|---------|---------|
| **Workflow Overview** | 7-step table showing manual (1-3) vs agent-automated (4-7) steps |
| **Manual Steps** | Steps 1-3: keyword-research, start-pillar, positioning-angles |
| **Agent-Automated Steps** | Steps 4-7: seo-content, direct-response-copy, content-atomizer, validate-content |
| **Main Session Orchestration** | Critical constraint: agents cannot spawn agents |
| **Single Article Pipeline** | SEO Writer → Copy Enhancer → Validator → (retry loop) → Atomizer |
| **Retry Loop** | 3 attempts max, then escalate to user |
| **Tier-Based Parallel Execution** | Tier identification, execution rules, parallel spawning within tiers |
| **Validation Checkpoints** | Post-draft, post-enhancement, pre-publish (automatic); batch review, spot check (manual) |
| **Internal Linking Strategy** | Placeholder convention, post-pillar linking pass, cross-pillar linking |
| **Error Logging** | GitHub Issue format during pillar execution |
| **Agent Reference** | Table linking to agents-prd.md for specifications |

#### What Gets Archived

| File | Reason | Superseded By |
|------|--------|---------------|
| `rules/sub-agent-rules.md` | Old Task tool approach | `rules/workflow.md` + agent files |
| `templates/sub-agent-seo-content.md` | Old prompt template | `agents/seo-writer.md` |
| `templates/sub-agent-validate-content.md` | Old prompt template | `agents/content-validator.md` |

#### What Gets Updated

| File | Change |
|------|--------|
| `CLAUDE.md` | Replace Phase 2 details with reference to `workflow.md` |
| `seo-content/SKILL.md` | Update Pillar Mode section to reference `workflow.md` |
| `validate-content/SKILL.md` | Update Non-Interactive Mode to reference `workflow.md` |
| `common-mistakes.md` | Rename "Sub-Agent Patterns" → "Agent Orchestration Patterns", update references |
| `end-to-end-example.md` | Add note about agent-automated execution for Steps 4-7 |

#### Workflow Steps (Unchanged)

The workflow itself doesn't change — only where it's documented:

| Step | Skill | Mode | Input | Output |
|------|-------|------|-------|--------|
| 1 | `/keyword-research` | Manual | Client profile | `00-keyword-brief.md` |
| 2 | `/start-pillar` | Manual | Keyword brief + pillar | `{pillar}/01-pillar-brief.md` |
| 3 | `/positioning-angles` | Manual | Pillar brief + profile | `{pillar}/02-positioning.md` |
| 4 | `/seo-content` | **Agent** | Positioning + profile | `{pillar}/articles/{nn}-{slug}.md` |
| 5 | `/direct-response-copy` | **Agent** | Draft article | Updates article in place |
| 6 | `/content-atomizer` | **Agent** | Final article | `{pillar}/distribution/{slug}/` |
| 7 | `/validate-content` | **Agent** | Final + rules | PASS/FAIL |

Steps 1-3 remain manual interactive skills (require user decisions). Steps 4-7 are automated via the 4-agent system.

### System Prompt Pattern for Agents That Need Rules

```markdown
## Before Starting

Read these files and apply all rules:
- `.claude/rules/universal-rules.md` — All FAIL/WARN conditions
- `.claude/rules/common-mistakes.md` — Learned patterns to avoid

Do not output content that violates FAIL conditions.
```

**Agents that need this:** seo-writer, content-validator

**Agents that don't need rules:** copy-enhancer (fixes issues, doesn't check rules), content-atomizer (creates distribution, different rules)

### What Each Agent Gets

| Agent | Skills (preloaded) | Rules (embedded) | Common Mistakes (embedded) |
|-------|--------|-------|-----------------|
| SEO Writer | `seo-content` | Yes | Yes |
| Copy Enhancer | `direct-response-copy` | No | No |
| Content Validator | `validate-content` | Yes | Yes |
| Content Atomizer | `content-atomizer` | No | No |

### Context Budget Estimate

| Agent | Skill Tokens | Rules Tokens | Total | % of 200K |
|-------|--------------|--------------|-------|-----------|
| SEO Writer | ~6,300 | ~3,000 | ~9,300 | 4.7% |
| Copy Enhancer | ~8,100 | 0 | ~8,100 | 4.1% |
| Content Validator | ~4,140 | ~3,000 | ~7,140 | 3.6% |
| Content Atomizer | ~7,530 | 0 | ~7,530 | 3.8% |

All agents use <5% of context for preloaded content, leaving >95% for actual work.

---

## Auto-Delegation Triggers

Claude will automatically delegate to agents based on these patterns:

| User Says | Agent Used |
|-----------|------------|
| "Write an article for keyword X" | seo-writer |
| "Create content for X" | seo-writer |
| "Write a blog post about X" | seo-writer |
| "Enhance this article" | copy-enhancer |
| "Punch up the copy" | copy-enhancer |
| "Make this more persuasive" | copy-enhancer |
| "Fix these validation issues" | copy-enhancer |
| "Validate this article" | content-validator |
| "Check this content" | content-validator |
| "Is this ready to publish?" | content-validator |
| "Create distribution content" | content-atomizer |
| "Atomize this article" | content-atomizer |
| "Create social posts" | content-atomizer |

---

## Implementation Checklist

### Phase 1: Create Agents Directory
- [ ] Create `.claude/agents/` directory

### Phase 2: Create Agent Files

Each agent file needs:
1. YAML frontmatter (name, description, tools, model, skills)
2. System prompt body with:
   - Workflow instructions
   - Instructions to READ rules at runtime (not embed)
   - Return format specification

**Files to create:**
- [ ] `seo-writer.md` — YAML + system prompt that READS universal-rules + common-mistakes at runtime
- [ ] `copy-enhancer.md` — YAML + system prompt with two modes (enhancement + fix)
- [ ] `content-validator.md` — YAML + system prompt that READS rules at runtime + FULL OUTPUT requirement
- [ ] `content-atomizer.md` — YAML + system prompt with platform specifications

### Phase 3: Create `/execute-pillar` Skill
- [ ] Create `.claude/skills/execute-pillar/` directory
- [ ] Create `SKILL.md` with full pillar execution workflow
- [ ] Document tier analysis, retry loop, error logging, commit workflow

### Phase 4: Workflow Consolidation

**Create single source of truth:**
- [ ] Create `rules/workflow.md` with consolidated workflow rules
- [ ] Include: 7-step workflow table (manual vs agent-automated)
- [ ] Include: Main session orchestration diagram
- [ ] Include: Single article pipeline
- [ ] Include: Retry loop logic (3 attempts)
- [ ] Include: Tier-based parallel execution rules
- [ ] Include: Validation checkpoints
- [ ] Include: Internal linking strategy
- [ ] Include: Error logging format

**Archive deprecated files:**
- [ ] Create `.claude/archive/` directory
- [ ] Create `archive/README.md` explaining what was superseded
- [ ] Move `rules/sub-agent-rules.md` to archive
- [ ] Move `templates/sub-agent-seo-content.md` to archive
- [ ] Move `templates/sub-agent-validate-content.md` to archive

**Update references:**
- [ ] Update `CLAUDE.md` — Replace Phase 2 details with reference to `workflow.md`
- [ ] Update `CLAUDE.md` — Add `workflow.md` to Rules section
- [ ] Update `CLAUDE.md` — Remove sub-agent template references from Templates section
- [ ] Update `seo-content/SKILL.md` — Reference `workflow.md` in Pillar Mode section
- [ ] Update `validate-content/SKILL.md` — Reference `workflow.md` in Non-Interactive Mode
- [ ] Update `common-mistakes.md` — Rename "Sub-Agent Patterns" → "Agent Orchestration Patterns"
- [ ] Update `common-mistakes.md` — Change references from `sub-agent-rules.md` to `workflow.md`
- [ ] Update `end-to-end-example.md` — Add note about agent-automated Steps 4-7

### Phase 5: Additional Documentation
- [ ] Update `CLAUDE.md` — Document the 4 agents + `/execute-pillar` skill

### Phase 6: Testing

**Auto-delegation tests:**
- [ ] Say "Write an article for keyword X" → should auto-delegate to seo-writer
- [ ] Say "Enhance this article" → should auto-delegate to copy-enhancer
- [ ] Say "Validate this article" → should auto-delegate to content-validator
- [ ] Say "Create distribution content" → should auto-delegate to content-atomizer

**Return format tests:**
- [ ] SEO Writer returns: PASS/FAIL + file path + word count
- [ ] Copy Enhancer returns: PASS/FAIL + mode + changes made
- [ ] Content Validator returns: FULL output (not abbreviated)
- [ ] Content Atomizer returns: PASS/FAIL + files created

**Rules at runtime tests:**
- [ ] Update `universal-rules.md` with a test rule
- [ ] Spawn seo-writer → should apply the new rule
- [ ] Spawn content-validator → should check the new rule

**Retry loop test:**
- [ ] Create intentionally invalid content (US spelling, banned words)
- [ ] Spawn validator → should return FAIL
- [ ] Main session spawns copy-enhancer with issues → should fix
- [ ] Spawn validator again → should return PASS

### Phase 7: `/execute-pillar` Testing
- [ ] Say "/execute-pillar" with a pillar brief → should follow full workflow
- [ ] Verify tier analysis works correctly
- [ ] Verify parallel execution within tiers

### Phase 8: Full Pipeline Validation
- [ ] Run full pillar with 3+ articles
- [ ] Verify tier-based parallel execution works
- [ ] Verify error logging to GitHub Issue works
- [ ] Verify git commits happen after validation passes
- [ ] Verify learning loop extracts patterns to common-mistakes.md

---

## Interview Decisions Summary

These decisions were made during the requirements interview:

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Number of agents | 4 | Writer, Enhancer, Validator, Atomizer cover high-volume work |
| Model for all | Sonnet | No compromise on quality |
| Execution mode | Background parallel | Maximum efficiency |
| Research capability | MCP tools (Perplexity if enabled) | Better E-E-A-T citations |
| Failure handling | Auto-retry (3x) | Main session orchestrates retry loop |
| Learning system | GitHub Issue → common-mistakes.md | System improves over time |
| Skill loading | Preloaded via `skills:` field | Claude Code injects skill content at startup |
| **Rules loading** | **READ at runtime** | **Update once, all agents see change** |
| Agent scope | Project-level (`.claude/agents/`) | Version controlled with the system |
| Naming | Descriptive | seo-writer, copy-enhancer, etc. |
| Delegation | Auto based on `description` | Claude routes based on task matching |
| Orchestration | Main session orchestrates | **Agents cannot spawn agents** |
| **Execution workflow** | **`/execute-pillar` skill** | **Single source of truth** |
| **Workflow documentation** | **`rules/workflow.md`** | **Consolidate scattered workflow rules into one file** |
| Parallel execution | Tier-based | Groups articles by internal linking dependencies |
| Git workflow | Main session commits | After validation passes |
| `/orchestrator` role | Marketing strategist only | Routes to skills, doesn't execute pipelines |

### Key Constraint: Agents Cannot Spawn Agents

This constraint from Claude Code's architecture shapes our entire workflow:

- Main session spawns each agent individually
- Main session receives PASS/FAIL results
- Main session decides what to spawn next
- Main session runs the retry loop
- Main session handles git commits

Agents are isolated workers. The main session is the orchestrator.

### Key Design: Single Source of Truth

Every piece of configuration lives in ONE place:

| What | Where | Effect |
|------|-------|--------|
| Content rules | `universal-rules.md` | Update once → all agents see the change |
| Learned patterns | `common-mistakes.md` | Update once → all agents see the change |
| **Workflow rules** | **`rules/workflow.md`** | **Update once → all files reference it** |
| Execution workflow | `/execute-pillar` skill | Update once → workflow changes everywhere |
| Agent behaviors | `.claude/agents/*.md` | Update one agent file → that agent changes |

**No duplication. No sync issues. Update one place, everything follows.**

---

## File Structure After Implementation

```
.claude/
├── agents/                              # NEW: Agent definitions
│   ├── seo-writer.md                    # YAML frontmatter + system prompt
│   ├── copy-enhancer.md                 # YAML frontmatter + system prompt
│   ├── content-validator.md             # YAML frontmatter + system prompt
│   └── content-atomizer.md              # YAML frontmatter + system prompt
│
├── archive/                             # NEW: Archived files
│   ├── README.md                        # Explains what was superseded
│   ├── sub-agent-rules.md               # Old Task tool approach (reference only)
│   ├── sub-agent-seo-content.md         # Old prompt template (reference only)
│   └── sub-agent-validate-content.md    # Old prompt template (reference only)
│
├── agents-prd.md                        # This file (updated)
│
├── rules/
│   ├── universal-rules.md               # READ by agents at runtime (single source of truth)
│   ├── common-mistakes.md               # READ by agents at runtime (grows over time)
│   ├── workflow.md                      # NEW: Single source of truth for workflow rules
│   └── client-profile-requirements.md
│
├── skills/
│   ├── execute-pillar/                  # NEW: Pillar execution workflow
│   │   └── SKILL.md                     # Single source of truth for execution pattern
│   ├── seo-content/                     # Preloaded into seo-writer agent
│   ├── direct-response-copy/            # Preloaded into copy-enhancer agent
│   ├── validate-content/                # Preloaded into content-validator agent
│   ├── content-atomizer/                # Preloaded into content-atomizer agent
│   ├── orchestrator/                    # Marketing strategist (unchanged)
│   └── templates/
│       ├── article-template.md
│       ├── distribution-template.md
│       └── tasks-template.md
│
└── CLAUDE.md                            # Updated with agents + execute-pillar docs
```

**Key architectural changes:**
- `.claude/agents/` — Agent definitions with skills preloaded
- `.claude/rules/workflow.md` — Single source of truth for workflow rules (consolidates scattered documentation)
- `.claude/skills/execute-pillar/` — Single source of truth for pillar execution workflow
- Rules READ at runtime — Update `universal-rules.md` once, all agents see the change
- `.claude/archive/` — Deprecated files (sub-agent-rules.md, old templates)

**Single source of truth principle:**
| What | Where | Update here → changes everywhere |
|------|-------|----------------------------------|
| Content rules | `universal-rules.md` | Agents read at runtime |
| Learned patterns | `common-mistakes.md` | Agents read at runtime |
| **Workflow rules** | **`rules/workflow.md`** | **All files reference it** |
| Execution workflow | `execute-pillar/SKILL.md` | Main session follows |
| Agent behaviors | `agents/*.md` | Claude auto-delegates |

---

## Quick Reference: Starting a New Session

When starting a fresh context window to implement or use this system:

1. **Read this file:** `.claude/agents-prd.md`
2. **Check agent status:** Run `/agents` to see available agents
3. **For content generation:** Just describe the task—agents auto-delegate
4. **For pillar execution:** Follow tier-based parallel pattern
5. **For debugging:** Check agent return formats, error logs

---

*This PRD is the single source of truth for the agent system. All implementation should reference this document.*
