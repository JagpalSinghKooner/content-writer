# Sub-Agent Rules

The single source of truth for sub-agent orchestration. All sub-agent behaviour is defined here. Other files reference this document.

---

## Core Principle: Fresh Context Windows

**Sub-agents operate in fresh context windows. They have no memory of the main session.**

This is not a limitation—it's the foundation of reliable orchestration:

- **Main session context stays minimal** — Orchestration of 7+ articles without context exhaustion
- **Each sub-agent gets full focus** — Dedicated context for a single task
- **Failures are isolated** — One sub-agent failing doesn't corrupt others
- **Reproducibility** — Any sub-agent can be re-spawned with identical instructions

**Because sub-agents have fresh context:**

1. They cannot answer questions—all clarification happens BEFORE spawning
2. They must receive complete instructions—no follow-up possible
3. They must read all context files themselves—nothing is "remembered"
4. They return structured output—the main session parses the result

---

## Sub-Agent Types

Two sub-agent types, always used separately:

### Writing Sub-Agent

**Role:** Creates a single article following the `/seo-content` workflow

**Invokes:** The `/seo-content` skill directly

**Receives:**
- File paths to context documents (profile, positioning, pillar brief)
- Target article details (keyword, angle, word count)
- List of completed articles for internal linking
- Output path for the finished article

**Returns:**
- File path to written article
- Status: PASS or FAIL
- Word count
- Issues list (if FAIL)
- Notes (optional context for main session)

**Does NOT return:** Full article content (keeps main session context minimal)

### Validation Sub-Agent

**Role:** Validates a single article against universal rules and brand voice

**Invokes:** The `/validate-content` skill directly

**Receives:**
- Path to article to validate
- Path to client profile (for brand voice)
- Primary keyword (for SEO checks)

**Returns:**
- Status: PASS or FAIL
- Full FAIL issues with line numbers and fixes
- Full WARN issues with suggestions
- SEO checklist status
- Readability metrics
- Brand voice alignment assessment

**Critical:** Returns FULL validation output, not abbreviated. Main session needs line-specific issues to decide on retry strategy.

---

## Complete Context Upfront

**All clarifying questions must be resolved BEFORE spawning sub-agents.**

### Pre-Spawn Checklist

Before spawning any sub-agent, verify:

- [ ] Client profile exists and has required fields for the skill
- [ ] Positioning document exists with angles defined
- [ ] Pillar brief exists with article details
- [ ] Target keyword is confirmed
- [ ] Word count target is set
- [ ] Output path is determined
- [ ] All ambiguities resolved with user

### What Sub-Agents Must NOT Do

Sub-agents cannot:

1. **Ask clarifying questions** — No way to receive answers in fresh context
2. **Request missing information** — Must fail if required context is missing
3. **Make assumptions about ambiguous requirements** — Should have been clarified beforehand
4. **Modify files outside their scope** — Only write to their designated output path
5. **Spawn other sub-agents** — Only main session orchestrates

If a sub-agent encounters ambiguity, it should:
- Return FAIL status
- List the ambiguity in issues
- Main session resolves and re-spawns

---

## Task Tool Invocation

Sub-agents are spawned using the Task tool with `subagent_type: "general-purpose"`.

### Spawning a Writing Sub-Agent

```
Task tool parameters:
- subagent_type: "general-purpose"
- description: "Write article: [article-slug]"
- prompt: [Full prompt from sub-agent-seo-content.md template]
```

### Spawning a Validation Sub-Agent

```
Task tool parameters:
- subagent_type: "general-purpose"
- description: "Validate article: [article-slug]"
- prompt: [Full prompt from sub-agent-validate-content.md template]
```

### Parallel Spawning

Sub-agents within the same tier can be spawned in parallel:

```
Single message with multiple Task tool calls:
- Task 1: Write article 02
- Task 2: Write article 03
- Task 3: Write article 04
```

---

## Orchestration Patterns

### Parallel by Dependency Tier

The standard pattern for pillar content generation:

```
Main Session (Orchestrator)
    │
    ├─→ Tier 1: Foundation article(s)
    │   ├─→ Writing Sub-Agent → creates article, returns file path
    │   ├─→ Validation Sub-Agent → validates, returns PASS/FAIL + full output
    │   └─→ Main commits if PASS
    │
    ├─→ Tier 2: Articles with no inter-dependencies (parallel)
    │   ├─→ Writing Sub-Agents (parallel) → each creates article
    │   ├─→ Validation Sub-Agents (parallel) → each validates
    │   └─→ Main commits all PASS articles
    │
    ├─→ Tier 3+: Articles with dependencies on previous tiers
    │   └─→ Same pattern: write → validate → commit
    │
    └─→ Final Tier: Pillar Guide (depends on all)
        ├─→ Writing Sub-Agent → creates pillar guide
        ├─→ Validation Sub-Agent → validates guide
        └─→ Main commits if PASS
```

### Tier Identification

From the pillar brief, identify dependencies:

| Article | Depends On | Tier |
|---------|------------|------|
| No dependencies | - | Tier 1 |
| Depends on Tier 1 | Tier 1 articles | Tier 2 |
| Depends on Tier 2 | Tier 2 articles | Tier 3 |
| Pillar Guide | All articles | Final Tier |

### Execution Rules

1. **Complete each tier before starting the next**
2. **Parallel within tiers** — spawn all tier articles simultaneously
3. **Sequential between tiers** — wait for tier completion before next
4. **Validation follows writing** — validate immediately after each write
5. **Commit after validation passes** — main session handles git

---

## Return Data Formats

### Writing Sub-Agent Return

```
**Status:** PASS | FAIL

**File Path:** {output_path}

**Word Count:** {actual_word_count}

**Issues (if FAIL):**
- [List any validation failures that prevented PASS]

**Notes:**
- [Any relevant context for the main session]
```

### Validation Sub-Agent Return

**Critical:** Full output required. Do not abbreviate.

```
## Validation Result: [PASS/FAIL]

**Article:** [filename]
**Primary Keyword:** [keyword]
**Word Count:** [count]

---

### FAIL Issues (must fix before publishing)

1. **Line 23:** "color" - US spelling → use "colour"
2. **Line 45:** "leverage" - banned AI word → use "use" or rephrase
[... all FAIL issues with line numbers and fixes ...]

---

### WARN Issues (should fix for quality)

1. **Line 89:** No contraction used → "it is" could be "it's"
[... all WARN issues ...]

---

### SEO Checklist

- [x] Primary keyword in first 150 words
- [x] Primary keyword in H2
- [ ] Word count 1,500+ (currently 1,234)
[... full checklist ...]

---

### Readability Metrics

| Metric | Score | Target | Status |
|--------|-------|--------|--------|
| Flesch-Kincaid Grade | 7.2 | 6-8 | ✓ |
[... full metrics table ...]

---

### Brand Voice

- Aligned: Yes | No
- Notes: [Any voice concerns]
```

---

## Failure Handling

### Retry Strategy

| Attempt | Action |
|---------|--------|
| First failure | Re-spawn with same instructions |
| Second failure | Re-spawn with error context from first attempt |
| Third failure | Escalate to user, continue with other articles |

### Error Context for Retry

When retrying after failure, add to the prompt:

```
## Previous Attempt Failed

The previous attempt returned these issues:
{issues_from_failed_attempt}

Please address these specific issues in this attempt.
```

### Escalation

If third attempt fails:

1. Log failure to PROJECT-TASKS.md
2. Inform user of the failure
3. Continue with other articles in the tier
4. Return to failed article after tier completes (user decision)

### Logging

All failures are logged to:
- PROJECT-TASKS.md under the relevant task
- GitHub Issue (if error tracking is active for the pillar)

---

## Context Management

### Main Session Budget

The main session orchestrates without reading article content:

| Data | Main Session Reads | Why |
|------|-------------------|-----|
| File paths | Yes | Needed for spawning and tracking |
| Article status | Yes | Needed for decision making |
| Validation issues | Yes | Needed for retry decisions |
| Full article content | **No** | Sub-agents handle content |

This keeps main session context available for orchestrating many articles.

### Sub-Agent Budget

Each sub-agent gets full context for its single task:

| Data | Sub-Agent Reads | Why |
|------|-----------------|-----|
| Client profile | Yes | Brand voice and requirements |
| Positioning document | Yes | Angle for this article |
| Pillar brief | Yes | Keyword and structure data |
| Universal rules | Yes | Validation requirements |
| Previous articles (paths) | Yes | For internal linking |
| Previous articles (content) | **No** | Only paths for linking |

---

## Skill Invocation

Sub-agents invoke skills directly rather than following manual instructions:

### Writing Sub-Agent

```
Invoke the /seo-content skill with these parameters:
- Target keyword: {keyword}
- Angle: {angle}
- Word count: {word_count}
- Output path: {output_path}
```

The sub-agent runs the full skill workflow autonomously.

### Validation Sub-Agent

```
Invoke the /validate-content skill with these parameters:
- Article path: {article_path}
- Primary keyword: {keyword}
- Client profile: {profile_path}
```

The sub-agent runs the full validation workflow and returns complete output.

### Non-Interactive Mode

When skills are invoked by sub-agents, they run in **non-interactive mode**:

- No clarifying questions asked
- All required context must be in the prompt
- Structured return format only
- No user confirmations requested

Skills document their non-interactive behaviour in a dedicated section.

---

## Template References

- **Writing Sub-Agent:** See `templates/sub-agent-seo-content.md`
- **Validation Sub-Agent:** See `templates/sub-agent-validate-content.md`

These templates include all placeholders and example filled prompts.

---

## Quick Reference: Do's and Don'ts

### Do

- Resolve all questions before spawning
- Pass file paths, not content
- Spawn parallel sub-agents where possible
- Require full validation output
- Keep writing and validation separate
- Log all failures

### Don't

- Ask clarifying questions in sub-agent context
- Pass full article content to main session
- Combine writing and validation in one sub-agent
- Abbreviate validation output
- Skip the retry strategy on failure
- Forget to commit after validation passes

---

## Anti-Patterns

These patterns cause failures. See `common-mistakes.md` for details:

1. **Asking clarifying questions in sub-agent context** — Sub-agents can't receive answers
2. **Returning abbreviated validation output** — Main session needs full details for retry
3. **Combining writing and validation in single sub-agent** — Loses isolation benefits
4. **Passing content instead of file paths** — Wastes main session context

---

*This file is the single source of truth. CLAUDE.md references this file rather than duplicating content.*
