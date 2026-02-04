# Agent Audit 2: Context Window Analysis

**What this is:** Post-mortem analysis of why the Sensory Overload pillar execution hit 100% context window.

**Root cause:** Agent returns are too verbose. The main session accumulates 32 agent returns but only uses PASS/FAIL for orchestration decisions. Full validation reports (~1,000+ words each) sit unused in context.

**The fix:** Minimal agent returns + file-based validation output. Validators write full reports to `{article}.validation.md`, return only `PASS` or `FAIL, {count}, {file_path}`. Copy-enhancer reads the file in its own context.

**Implementation priority:** content-validator.md (HIGH) → copy-enhancer.md (HIGH) → workflow.md (HIGH) → agents-prd.md (HIGH) → seo-writer.md (MEDIUM) → content-atomizer.md (LOW)

**Status:** Analysis complete. Ready for implementation.

---

# Workflow Analysis: Sensory Overload Pillar Execution

## Executive Summary

The sensory-overload pillar execution hit **100% context window** in the main session. This analysis identifies the root cause and proposes a fix.

**Bottom line:** Agents returned too much data to the main session. The main session is a project manager - it only needs PASS/FAIL to orchestrate. Fix: minimal agent returns.

---

## What Went Well

### 1. Clean Execution Quality
- **Zero escalated validation failures** - All 8 articles passed validation (2 failed initially but fixed in retry loop)
- **Consistent brand voice** - All articles maintained parent-to-parent tone
- **Proper E-E-A-T citations** - 25 citations across 8 articles (3+ per article average)

### 2. Tier-Based Parallel Execution Worked
The 5-tier model grouped articles by internal linking dependencies:

| Tier | Articles | Duration | Strategy |
|------|----------|----------|----------|
| 1 | Article 01 (foundation) | 33 min | Sequential |
| 2 | Article 02 (conversion driver) | 13 min | Sequential |
| 3 | Articles 03-06 | 30 min | **Parallel (4 at once)** |
| 4 | Article 07 (recovery) | 8 min | Sequential |
| 5 | Article 08 (pillar guide) | 14 min | Sequential |

Tier 3's parallel execution of 4 articles in 30 minutes shows the system CAN handle concurrent work.

### 3. Complete Output
- **22,602 words** across 8 articles
- **32 distribution files** (4 platforms × 8 articles)
- **Post-pillar linking pass** completed (3 placeholders resolved)
- **7 git commits** with clean tier-based structure
- **PR #9** ready for review

### 4. Workflow Compliance
All workflow rules followed correctly:
- Git commits per tier
- PROJECT-TASKS.md updated with handoff
- GitHub Issue #8 created for error tracking
- Pillar status marked complete in keyword brief

---

## What Went Wrong: 100% Context Window

### Why Context Exploded

**Critical Understanding:** Agents use their own fresh context windows. The problem is entirely in the **main session context** accumulating agent returns.

```
Agent spawns → Uses fresh context (isolated, clean)
Agent returns → Result goes to MAIN SESSION
Main session → Keeps ALL results from ALL agents
```

**The main session accumulated 32 agent returns without any mechanism to "forget" earlier results.**

| Factor | Context Cost | Cumulative Impact |
|--------|--------------|-------------------|
| **Agent result accumulation** | Each of 32 agent spawns returns results to main session | **CRITICAL** - results never disappear |
| **Full validation output** | 8 complete validation reports (never abbreviated) | High - ~2,000 words per report |
| **Orchestration decisions** | "Article X passed, moving to Y, spawning Z agent..." | Medium - conversational overhead |
| **Tier tracking** | Decision tracking, retry counts, error handling | Medium |
| **Context files** | Profile, positioning, brief | Low (agents read these, main session doesn't need to hold full content)

### Comparison: Previous Pillars vs Sensory Overload

| Metric | ADHD Sleep | Autistic Meltdowns | Sensory Overload |
|--------|------------|-------------------|------------------|
| Articles | 7 | 7 | **8** |
| Words | 18,524 | 18,586 | **22,602** |
| Distribution files | 12 (3 articles) | 28 | **32** |
| Agent spawns | ~28 | ~28 | **~32** |
| Context usage | Lower | Lower | **100%** |

**Key difference:** Sensory Overload had:
- 1 more article (+14%)
- 4,000 more words (+22%)
- Full distribution for all articles (not selective)
- All execution in one session

### The Accumulation Problem

**Agents don't accumulate** - each agent gets a fresh context window, does its work, and returns. The agent's context is released after it returns.

**The main session DOES accumulate** - it never "forgets" agent results. Each spawn adds to the main session's context:

```
Tier 1: Spawn 4 agents → Agents work in isolation → 4 results return to MAIN SESSION
Tier 2: Spawn 4 agents → Agents work in isolation → 4 more results (main session now has 8)
Tier 3: Spawn 16 agents → Agents work in isolation → 16 more results (main session now has 24)
Tier 4: Spawn 4 agents → Agents work in isolation → 4 more results (main session now has 28)
Tier 5: Spawn 4 agents → Agents work in isolation → 4 more results (main session now has 32)
```

**By Tier 5, the main session held results from all 32 agent spawns, plus all the orchestration conversation ("spawning agent X...", "Article Y passed, moving to Z...").**

The agents themselves were fine. The orchestrator (main session) was drowning in accumulated returns.

---

## The Fix: Minimal Agent Returns

**The main session is a project manager.** Its job is to orchestrate agents based on PASS/FAIL decisions. It doesn't need word counts, change lists, or full validation reports in its context.

### Current Problem: Agents Return Too Much

```
SEO Writer returns:
  "PASS. Created file at /path/to/article.md. Word count: 2,347.
   Citations found: 3 (NHS 2024, Porges 2017, Thye 2018).
   Primary keyword density: 1.4%. Internal links: 3..."

Copy Enhancer returns:
  "PASS. Enhanced article. Changes made: Strengthened opening hook,
   added proof point in paragraph 3, improved CTA section with
   'We built it because we needed it too' language..."

Validator returns:
  "PASS. Full validation report:
   [2,000 words of validation output including every check,
   every line number, every metric, brand voice analysis...]"
```

**32 of these verbose returns = context explosion.**

### The Fix: Return Only What the Project Manager Needs

The main session only needs to answer: **"Did it pass? What's next?"**

```
SEO Writer:     → PASS, file_path
Copy Enhancer:  → PASS
Validator:      → PASS (or FAIL + issue_count)
Atomizer:       → PASS
```

**If FAIL:** The main session spawns copy-enhancer with just the file path. The copy-enhancer reads the validation output file (written by validator) in its own fresh context.

### Implementation

**1. Update agent return formats in agents-prd.md:**

| Agent | Current Return | New Return |
|-------|----------------|------------|
| SEO Writer | PASS/FAIL + file path + word count + citations + density | `PASS, {file_path}` |
| Copy Enhancer | PASS/FAIL + mode + changes made | `PASS` |
| Content Validator | PASS/FAIL + FULL validation report | `PASS` or `FAIL, {issue_count}, {validation_file_path}` |
| Content Atomizer | PASS/FAIL + files created + platform summary | `PASS` |

**2. Validators write full output to file:**

Instead of returning the full validation report to the main session, validators write it to:
```
{article_path}.validation.md
```

The main session only sees `PASS` or `FAIL, 3 issues, /path/to/article.validation.md`.

If FAIL, the copy-enhancer reads the validation file in its own context (not the main session's).

**3. Update agent system prompts:**

Add to each agent's system prompt:
```
CRITICAL: Return MINIMAL data to the main session.
- The main session is a project manager making PASS/FAIL decisions
- It does NOT need details, word counts, change lists, or full reports
- Write detailed output to files if needed for other agents
- Return only: PASS/FAIL + file path (if creating) + issue count (if failing)
```

### Why This Works

| Before | After |
|--------|-------|
| 32 verbose returns in main session | 32 one-line returns in main session |
| Main session holds validation reports | Validators write reports to files |
| Copy-enhancer gets issues from main session | Copy-enhancer reads validation file directly |
| Context fills by Tier 5 | Context stays lean throughout |

**The main session becomes a thin orchestration layer.** All the heavy context work happens in agent contexts (which reset after each spawn).

---

## Additional Observations

### The Validation Output Problem

workflow.md explicitly says validators must return **FULL OUTPUT**:

> "Validation agents must return the COMPLETE output format... Never abbreviate. Never summarise. Return everything."

**This rule is wrong for the main session.** Full output is needed for fixing issues - but the copy-enhancer (not the main session) does the fixing.

**New rule:** Validators write full output to `{article-path}.validation.md`. Return only PASS/FAIL + issue count to main session. Copy-enhancer reads the validation file in its own context.

### Distribution Stays in Pipeline

Current workflow: Write article → enhance → validate → atomize (all in same pipeline).

**This is fine** if atomizer returns only `PASS`. The issue wasn't the number of agent spawns - it was the verbosity of returns.

---

## Files to Modify

| File | Change |
|------|--------|
| `.claude/agents-prd.md` | Update all 4 agent return formats to minimal |
| `.claude/agents/seo-writer.md` | Return only `PASS, {file_path}` |
| `.claude/agents/copy-enhancer.md` | Return only `PASS` |
| `.claude/agents/content-validator.md` | Write full report to file, return `PASS` or `FAIL, {count}, {file}` |
| `.claude/agents/content-atomizer.md` | Return only `PASS` |
| `.claude/rules/workflow.md` | Update "Agent Return Formats" section |

---

## Verification

After implementing fixes, verify by:

1. Run execute-pillar on a 7+ article pillar
2. Check main session context usage stays reasonable throughout
3. Verify validation files are written correctly
4. Verify copy-enhancer can read validation files when fixing FAIL issues
5. Confirm no quality degradation (agents still do full work, just return less)

---

## Summary

**Root cause:** Agents returned too much information to the main session. The main session is a project manager - it only needs PASS/FAIL to orchestrate.

**The fix:** Minimal agent returns.

| Change | Before | After |
|--------|--------|-------|
| SEO Writer return | PASS + file + word count + citations + density | `PASS, {file_path}` |
| Copy Enhancer return | PASS + mode + changes made | `PASS` |
| Validator return | PASS + 2,000 word report | `PASS` or `FAIL, {count}, {file}` |
| Atomizer return | PASS + files created + summary | `PASS` |
| Main session context | Fills with 32 verbose returns | Stays lean with 32 one-liners |

**Key insight:** The main session should be a thin orchestration layer. It decides "what next?" based on PASS/FAIL. All detail work happens in agent contexts (which reset after each spawn).

**No session splitting needed.** The workflow can run continuously if the main session only accumulates minimal return data.

---

## Audit Review: Gaps and Refinements

### Gaps in Original Analysis

**1. No Measurements**

The diagnosis is inference-based, not data-driven:
- "~2,000 words per validation report" is an estimate, not measured
- No token count comparison between agent returns vs orchestration overhead
- The "orchestration overhead" (spawning X, waiting for Y, completed Z) also accumulates but isn't quantified

**2. Invalid Baseline Comparison**

The comparison table (ADHD Sleep vs Autistic Meltdowns vs Sensory Overload) is misleading:
- Previous pillars were executed differently (different workflow version)
- Cannot use them as baseline for "lower context usage"
- The only valid comparison would be same workflow, different pillar sizes

**3. Retry Factor Doesn't Explain It**

Sensory Overload had **fewer** validation failures than previous pillars, yet hit 100% context. This suggests:
- The problem isn't retry volume
- The base case (no retries) already accumulates too much

**4. Post-Pillar Linking Pass**

The audit notes the linking pass ran after all 32 spawns. If context was already at 95%, the linking pass (which reads articles) could have been the final straw. This wasn't analysed.

---

### Missing Implementation Details

**1. Retry Decision Logic**

Original proposal: Return `FAIL, {issue_count}, {validation_file_path}`

**Gap:** How does the main session decide retry vs escalate without seeing the issues?

**Resolution:** Use fail_count threshold:
```
IF fail_count <= 10 AND attempt < 3:
    retry with copy-enhancer
ELSE:
    escalate to user
```

**2. File Cleanup**

Original proposal: Write validation to `{article_path}.validation.md`

**Gap:** What happens to validation files after success? Do they accumulate?

**Resolution:**
- Validator deletes existing validation file before writing new one
- On PASS, no validation file is created (nothing to fix)
- On final PASS after retry, validation file remains as audit trail

**3. Parallel Execution File Conflicts**

Original proposal didn't address: What if two articles validate in parallel and both fail?

**Resolution:** Each article gets unique validation file based on article path:
- `01-article.md` → `01-article.validation.md`
- `02-article.md` → `02-article.validation.md`
- No conflicts possible

**4. Copy-Enhancer File Reading**

Original proposal: Copy-enhancer reads validation file

**Gap:** What if the file doesn't exist or is corrupted?

**Resolution:** Copy-enhancer returns `FAIL, validation file not found` and main session escalates

---

### Current Agent Return Formats (Actual)

Exploration of agent files revealed the **actual** return formats differ from PRD:

| Agent | PRD Says | Agent File Actually Returns |
|-------|----------|----------------------------|
| SEO Writer | PASS + file + word count + citations | PASS + file + word count + citations + **8-item self-validation checklist** |
| Copy Enhancer | PASS + mode + changes | PASS + mode + **banned words check section** + changes |
| Content Validator | Full report (6 sections) | Full report (6 sections) - **matches PRD** |
| Content Atomizer | PASS + files + summary | PASS + files + summary - **matches PRD** |

**Key finding:** SEO Writer and Copy Enhancer return MORE than documented. Validator is the main offender (6 full sections = ~1,000+ words).

---

### Refined Implementation Plan

**1. Content Validator** (highest impact)
- Write full output to `{article-name}.validation.md`
- Return only: `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}`
- Delete old validation file before writing new one

**2. Copy Enhancer**
- Remove banned words check from return (still runs internally)
- Add instruction: When in fix mode, read validation file path provided
- Return only: `PASS`

**3. SEO Writer**
- Remove self-validation checklist from return (still runs internally)
- Return only: `PASS, {file_path}`

**4. Content Atomizer**
- Already minimal, simplify slightly
- Return only: `PASS`

---

### Risks

1. **Copy-enhancer may produce worse fixes** without seeing issues in prompt
   - Mitigation: It reads the same information from file, just in its own context

2. **Validation file may have stale data** if cleanup fails
   - Mitigation: Always delete before write; timestamp could be added if needed

3. **This is untested** - Based on reasonable inference but no measurements
   - Mitigation: Monitor context during next pillar, adjust if needed

4. **Post-pillar linking pass not addressed** - If context is still tight after these changes, the linking pass could overflow
   - Mitigation: Monitor; consider running linking pass in fresh session if needed

5. **Orchestration overhead not addressed** - "Spawning X, waiting for Y" text also accumulates
   - Mitigation: Could add instruction to keep orchestration messages brief; monitor first

---

### Files to Modify (Updated)

| File | Change | Priority |
|------|--------|----------|
| `.claude/agents/content-validator.md` | Write to file, return minimal | **HIGH** - largest context savings |
| `.claude/agents/copy-enhancer.md` | Read validation file, return minimal | HIGH |
| `.claude/agents/seo-writer.md` | Remove self-validation from return | MEDIUM |
| `.claude/agents/content-atomizer.md` | Simplify return | LOW |
| `.claude/agents-prd.md` | Update all return format specs | HIGH |
| `.claude/rules/workflow.md` | Update retry logic, return formats | HIGH |

---

## Next Steps (New Session)

1. Read this file for context
2. Enter plan mode to implement changes
3. Start with content-validator.md (highest impact)
4. Update copy-enhancer.md to read validation files
5. Update remaining agent files
6. Update PRD and workflow.md
7. Test with next pillar (Calming Sounds)
