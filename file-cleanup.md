# Context Cleanup: Slim Down Auto-Loaded `.claude/` Files

## Problem

Claude Code auto-loads `.claude/CLAUDE.md` and everything in `.claude/rules/` into **every request context**. Current setup loads **2,368 lines** before a single prompt is typed. Context drowns out the actual rules. Opus 4.6 sessions degrade then die within 15 minutes.

## Root Cause

The rules ARE good. They're buried in noise: duplicate sections across files, ASCII diagrams, verbose explanatory notes, reference tables, and files that aren't actually rules.

## Principles

- **Rules = rules.** `universal-rules.md` stays as THE single source of truth. Agents read it. Word lists, banned words, UK spelling patterns stay because they ARE the rules.
- **Skills = skilled.** Agents already know their craft. No inline safety nets or scattered reference copies needed.
- **If it's not a rule, it doesn't belong in `rules/`.** Diagrams, verbose examples, terminology definitions, and reference tables are noise, not rules.

## Approach

No file splitting into slim/full versions. No reference file system with pointers everywhere. Just:

1. Move non-rule files OUT of the auto-loaded `rules/` directory
2. Remove duplicate content (same text appearing in 2+ files)
3. Trim verbose content that isn't the actual rule (explanatory notes, example tables, visual aids)
4. Slim `CLAUDE.md` to core behavioural rules only

**Target: 2,368 lines → ~999 lines (58% reduction). Zero functionality lost.**

---

## Current Auto-Loaded Footprint

| File | Lines | Content Type |
|------|-------|-------------|
| `.claude/CLAUDE.md` | 590 | Behavioural rules + duplicated reference |
| `.claude/rules/universal-rules.md` | 729 | Rules + verbose explanations between tables |
| `.claude/rules/workflow.md` | 451 | Rules + ASCII diagrams + duplicated sections |
| `.claude/rules/common-mistakes.md` | 289 | Template + 240 lines of learned patterns |
| `.claude/rules/client-profile-requirements.md` | 309 | Pure reference (no behavioural rules) |
| **TOTAL** | **2,368** | **Every single request** |

## Target After Cleanup

| File | Before | After | Saved |
|------|--------|-------|-------|
| `CLAUDE.md` | 590 | ~300 | -290 |
| `rules/universal-rules.md` | 729 | ~549 | -180 |
| `rules/workflow.md` | 451 | ~150 | -301 |
| `rules/common-mistakes.md` | 289 | 0 (moved) | -289 |
| `rules/client-profile-requirements.md` | 309 | 0 (moved) | -309 |
| **TOTAL** | **2,368** | **~999** | **-1,369** |

---

## Key Discovery: Agents Don't Rely on Auto-Loaded Context

Investigation of all 6 agent files confirmed agents read rule files **explicitly at runtime** via "Before Starting" sections. They do NOT depend on auto-loaded context:

| Agent | What It Reads at Runtime | Auto-Load Dependent? |
|-------|--------------------------|---------------------|
| `seo-writer.md` | `rules/universal-rules.md`, `rules/common-mistakes.md` | No — explicit read |
| `content-validator.md` | `rules/universal-rules.md`, `rules/common-mistakes.md` | No — explicit read ("Read them fresh each time") |
| `copy-enhancer.md` | `rules/universal-rules.md` Section 2 | No — explicit reference + inline 53-word list |
| `consistency-checker.md` | `rules/universal-rules.md` (Terminology section) | No — explicit read |
| `link-auditor.md` | `rules/universal-rules.md` (Rule 5a only) | No — explicit read |
| `content-atomizer.md` | No rule files | No — uses preloaded skill only |

**The auto-loaded context serves the main session (orchestrator), not agents.** The orchestrator spawns agents, receives PASS/FAIL, manages retries. It needs to know WHAT rules exist and HOW to orchestrate. It does not need 48+ UK word pairs or 53 banned words — those are for agents doing the actual work.

---

## Execution Steps

### Step 1: Move non-rules out of `rules/` (saves 598 lines) — ZERO RISK

Two files in `rules/` are not behavioural rules:

**`client-profile-requirements.md` (309 lines):**
- Pure reference table showing which profile fields each skill needs
- No agent reads it at runtime
- Only linked from CLAUDE.md
- Move wholesale to `.claude/references/client-profile-requirements.md`

**`common-mistakes.md` (289 lines):**
- Learned patterns file — grows over time as errors are caught
- Agents read it explicitly via "Before Starting" sections (not from auto-load)
- Move wholesale to `.claude/references/common-mistakes.md`

**Actions:**
1. Create `.claude/references/` directory
2. Move `rules/client-profile-requirements.md` → `references/client-profile-requirements.md` (content unchanged)
3. Move `rules/common-mistakes.md` → `references/common-mistakes.md` (content unchanged)
4. Update `CLAUDE.md` link for client-profile-requirements (1 line: path change)
5. Update `agents/seo-writer.md` Before Starting: change `rules/common-mistakes.md` → `references/common-mistakes.md`
6. Update `agents/content-validator.md` Before Starting: change `rules/common-mistakes.md` → `references/common-mistakes.md`

**Files changed:**
- `.claude/CLAUDE.md` — 1 line path update
- `.claude/agents/seo-writer.md` — 1 line path update
- `.claude/agents/content-validator.md` — 1 line path update
- `.claude/rules/client-profile-requirements.md` — deleted (moved)
- `.claude/rules/common-mistakes.md` — deleted (moved)
- `.claude/references/client-profile-requirements.md` — created (identical content)
- `.claude/references/common-mistakes.md` — created (identical content)

**Test:**
- Fresh session: neither file appears in auto-loaded context
- Run content-validator on any existing article: must still reference common-mistakes patterns
- Verify CLAUDE.md link to client-profile-requirements resolves

---

### Step 2: De-duplicate and trim `workflow.md` (saves ~301 lines) — LOW RISK

`workflow.md` is 451 lines. Contains large sections duplicated word-for-word from `CLAUDE.md`, ASCII pipeline diagrams that are visual aids (not rules), and supplementary implementation detail.

**Remove from workflow.md:**

| Section | Lines | Reason |
|---------|-------|--------|
| Validation Checkpoints | ~20 | Duplicate of CLAUDE.md |
| Internal Linking Strategy | ~48 | Duplicate of CLAUDE.md |
| Error Logging | ~53 | Duplicate of CLAUDE.md Rule #3 |
| File Structure + Numbering | ~27 | Duplicate of CLAUDE.md |
| Main Session Orchestration diagram | ~25 | Visual aid, not a rule |
| Single Article Pipeline diagram | ~40 | Visual aid, not a rule |
| Retry Loop diagram | ~25 | Visual aid, not a rule |
| Tier-Based Execution diagram | ~20 | Visual aid, not a rule |
| Validation file lifecycle detail | ~23 | Implementation detail |
| Auto-delegation triggers table | ~22 | Already in agent descriptions |

**Keep in workflow.md (~150 lines):**
- Workflow Overview table (7 steps: manual vs agent)
- Critical Constraint: Agents Cannot Spawn Agents (full text)
- Orchestration rules (text descriptions of how main session manages agents)
- Retry Loop rules (max 3 attempts, escalation procedure — text, not diagram)
- Tier-Based Execution rules (parallel within tiers, sequential across — text, not diagram)
- Agent Reference table + return formats

**Files changed:** `.claude/rules/workflow.md` only

**Test:**
- Verify all kept content (overview table, constraints, orchestration rules, retry rules, tier rules, agent formats) is intact
- Grep for `workflow.md` references across agents/skills — confirm nothing references the removed sections specifically
- No agent reads workflow.md directly (confirmed during investigation), so agent functionality is unaffected

> **HARD STOP after Steps 1-2.** These save 899 lines (38% reduction) at zero/low risk. Start a fresh session and assess whether:
> - Context feels noticeably lighter
> - Agents still function correctly
> - The remaining 20% reduction (Steps 3-4) is worth pursuing

---

### Step 3: Trim `universal-rules.md` (saves ~180 lines) — MEDIUM RISK

`universal-rules.md` is 729 lines. The word pair tables, banned word lists, and FAIL rule definitions ARE the rules and STAY. But ~180 lines are guidance, verbose examples, and definitions that aren't validation rules.

**Remove:**

| Content | Lines | Why It's Not a Rule |
|---------|-------|-------------------|
| Explanatory notes between UK pattern tables ("Derived forms: The -our is retained in most derivatives...", "Note: Some words are ALWAYS -ise...", "Note: US is inconsistent here...", etc.) | ~70 | The tables speak for themselves. Agents don't need etymology lessons. |
| WARN condition example tables (contraction table showing "it is → it's", sentence length examples, passive voice examples, specific examples section) | ~60 | The WARN rules stay as one-line descriptions. Agents know what contractions and passive voice are. |
| Terminology section (Hook, CTA, Soft CTA, Hard CTA definitions + CTA Placement table) | ~75 | Definitions, not validation rules. Only consistency-checker needs these — add inline to that agent. |
| Quick Validation Checklist at bottom | ~15 | Redundant summary of rules already defined above it. |
| Citation preferred/avoided source lists | ~20 | The RULE is "cite authoritative sources with format X." The LIST of which sources count as authoritative is guidance — agents already know what .gov and peer-reviewed means. |

**Keep (ALL FAIL rules intact):**
- Scope matrix (which rules apply to which content types)
- Rule 1: UK English — ALL 8 pattern tables with ALL 48+ word pairs (tables only, no explanatory notes between them)
- Rule 2: Banned AI Words — ALL 53 words categorised (Verbs, Adjectives, Buzzwords, Fillers, Transitions)
- Rule 3: Banned AI Phrases — ALL phrase lists (Opening Cliches, Throat-Clearing, Padding, Meta-Commentary, Desperate Hooks)
- Rule 4: AI Patterns — pattern descriptions (Repetitive Sentence Starts, Rule of Threes, Hedging Overload, Empty Transitions, Artificial Balance)
- Rule 4b: No Em Dashes — rule statement + detection instructions + restructuring examples
- Rule 5: SEO Requirements — full checklist (keyword placement, content length, meta data, links, structure, H1 format)
- Rule 5a: Internal Link Format — rule + format examples + validation checklist
- Rule 6: External Citations — citation format + minimum requirements (at least 2 per 1,500 words)
- WARN rule names + one-line descriptions (Missing Contractions, Monotonous Sentence Length, No Personal Voice, No Specific Examples, Passive Voice Overuse)

**One agent update:** Add terminology definitions (Hook, CTA, Soft/Hard CTA, CTA Placement table) inline to `agents/consistency-checker.md`. It's the only agent that reads the Terminology section, and the definitions are short (~30 lines when compressed).

**Files changed:**
- `.claude/rules/universal-rules.md` — trimmed from 729 to ~549 lines
- `.claude/agents/consistency-checker.md` — terminology definitions added to Before Starting section

**Test:**
1. Run content-validator on an article with deliberate US spellings ("color", "behavior") — must catch as FAIL
2. Run content-validator on an article with a banned word ("leverage") — must catch as FAIL
3. Run seo-writer to produce a test article — output must use UK English and contain zero banned words
4. Run consistency-checker on a pillar — must still check terminology consistency using its new inline definitions

---

### Step 4: Slim `CLAUDE.md` (saves ~290 lines) — LOW RISK

`CLAUDE.md` is 590 lines. Much of it is reference material that duplicates information available elsewhere (in skills, agent descriptions, workflow.md).

**Remove (~290 lines):**

| Section | Lines | Why |
|---------|-------|-----|
| Phase 2 Content Generation detailed table | ~15 | Replace with 2-line pointer to `rules/workflow.md` |
| File structure diagram | ~20 | Agents and skills already know the structure |
| Distribution folder examples | ~15 | Skills handle this (content-atomizer knows its output format) |
| Platform file format tables | ~20 | Skills handle this |
| Slug comparison table | ~10 | Keep slug rules as bullets, drop the 4-row before/after table |
| Agent-Automated Execution detail | ~30 | Replace with 3-line summary + pointer to `rules/workflow.md` |
| Skills table | ~18 | Remove entirely — skills are self-documenting via YAML descriptions in system prompt |
| Agents table | ~12 | Compress to 2 lines + "see `.claude/agents/`" |
| Templates section (shared + skill-specific) | ~30 | Compress to 2 lines + "see `.claude/skills/templates/`" |
| Reference Materials table | ~15 | Compress to 1 line |
| Rules links section | ~5 | Compress to 2 lines |
| Example Workflow reference | ~3 | Remove — file is self-documenting |

**Keep (~300 lines):**
- Task Tracking: Two Systems (explains which task file to use — critical for session start)
- Session Start Protocol (non-negotiable)
- Rule #1: Task Execution — full (governs all work: plan, document, execute, verify, handoff)
- Rule #2: Git Workflow — full (commit conventions, branch strategy, what not to auto-commit)
- Rule #3: Error Tracking — full (GitHub issue logging, pattern extraction)
- Phase 1: Client Onboarding (brief — run `/onboard-client` once per client)
- File Naming Conventions (compressed to table + slug rules as bullets + article numbering)
- Internal Linking Strategy (single source of truth — already removed from workflow.md in Step 2)
- Validation Checkpoints table (single source of truth — already removed from workflow.md in Step 2)
- Cross-Pillar Linking rules

**Files changed:** `.claude/CLAUDE.md` only

**Test:**
- Fresh session: Session Start Protocol still triggers (reads PROJECT-TASKS.md first)
- All 3 rules (Task Execution, Git Workflow, Error Tracking) fully present and functional
- File naming rules understood (test by asking about slug format)
- Internal linking rules present and complete
- Pointers to workflow.md, agents folder, and templates folder resolve correctly

---

## Summary

| Step | What | Risk | Lines Saved | Cumulative | Auto-Loaded After |
|------|------|------|-------------|------------|-------------------|
| 1 | Move non-rules out of `rules/` | ZERO | 598 | 598 | 1,770 |
| 2 | De-duplicate + trim workflow.md | LOW | 301 | 899 | 1,469 |
| — | **HARD STOP — reassess** | — | — | **38% reduction** | — |
| 3 | Trim universal-rules.md | MEDIUM | 180 | 1,079 | 1,289 |
| 4 | Slim CLAUDE.md | LOW | 290 | 1,369 | 999 |
| **TOTAL** | | | **1,369** | | **~999 lines (58%)** |

---

## What This Plan Does NOT Do (By Design)

- **Does NOT split any file into slim + full versions.** No file has a "slim" copy in `rules/` and a "full" copy in `references/`.
- **Does NOT create a scattered reference file system.** Only 2 files move to `references/` (both moved wholesale, not split). No 12-file reference directory.
- **Does NOT add inline safety nets to agents.** Agents are skilled. They read the rules and follow them.
- **Does NOT change how agents read rules.** Same mechanism (explicit "Before Starting" file reads), just 2 path updates for common-mistakes.
- **Does NOT remove any FAIL rules, word lists, or banned word lists.** Every word pair table, every banned word, every FAIL condition stays in `universal-rules.md`.

---

## What Changes for Agents

| Agent | Change | Risk |
|-------|--------|------|
| `seo-writer.md` | Path update: common-mistakes moves to `references/` | Zero (same content, different path) |
| `content-validator.md` | Path update: common-mistakes moves to `references/` | Zero (same content, different path) |
| `consistency-checker.md` | Terminology definitions added inline (~30 lines) | Low (gains self-contained data) |
| `copy-enhancer.md` | No change | None |
| `link-auditor.md` | No change | None |
| `content-atomizer.md` | No change | None |

**Skills to verify (but NOT modify unless broken):**
- `validate-content/SKILL.md` — references `rules/universal-rules.md` (file still exists, just trimmed)
- `seo-content/SKILL.md` — references `rules/universal-rules.md` (still exists)
- `audit-pillar/SKILL.md` — references both rule files (universal-rules still exists; common-mistakes path may need update)
- `execute-pillar/SKILL.md` — references `common-mistakes.md` for pattern writing (path may need update)

---

## Rollback Strategy

Each step is a separate commit on a feature branch.

- **Revert one step:** `git revert <commit>`
- **Revert everything:** `git revert HEAD~N..HEAD`
- Steps are independent. Reverting Step 3 does not break Steps 1-2.

## Branch Strategy

Feature branch `cleanup/context-slim`. Merge to `main` via PR after all steps pass testing.

**Commit message format:**
```
Cleanup Step {N}/4: {Description}

{Brief summary}
Lines saved: {N} (cumulative: {N}/1,369)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Starter Prompt (Steps 1-2 Only)

> Read `file-cleanup.md` in the project root. Execute Steps 1 and 2 only. For Step 1, move the two non-rule files to `references/` and update the 3 agent/CLAUDE.md path references. For Step 2, read `workflow.md`, identify all duplicate and non-rule content, and trim it down to ~150 lines keeping only the sections listed in the plan. Commit each step separately. After both steps, report the new auto-loaded line count.
