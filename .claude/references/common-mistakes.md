# Common Mistakes

A learning file that grows over time. When validation catches recurring issues, add them here so they're caught earlier in future content.

---

## How to Add Patterns

When you spot a mistake appearing across multiple pieces of content:

1. Copy the template below
2. Fill in the three fields
3. Add under the Patterns section

### Template

```markdown
### [Short descriptive name]

**Pattern:** What to look for (example of the bad thing)

**Why it fails:** Brief explanation of why this is a problem

**Fix:** How to correct it (example of the good version)
```

### Template (Extracted from Issue)

Use this template when extracting patterns from a GitHub Issue during pillar completion:

```markdown
### [Short descriptive name] (Issue #{number})

**Pattern:** What to look for (example of the bad thing)

**Why it fails:** Brief explanation of why this is a problem

**Fix:** How to correct it (example of the good version)

**Source:** {pillar name} — {count} occurrences
```

The Issue number links back to the original error log for context.

---

## Patterns

<!-- Add new patterns below this line -->

### Skipping PROJECT-TASKS.md updates

**Pattern:** Completing work without updating PROJECT-TASKS.md (checkboxes, status, handoff section)

**Why it fails:** Violates Rule #1. Breaks audit trail. Next session has no context. Work appears incomplete even when done.

**Fix:** After ANY task completion:
1. Check all acceptance criteria boxes
2. Change status to PASS
3. Write handoff section (Done, Decisions, Next)
4. Update summary table

---

### Updating wrong TASKS.md file (ADHD Sleep Audit)

**Pattern:** Updating root `TASKS.md` (system development tasks) instead of project-level `PROJECT-TASKS.md` (client work)

**Why it fails:** Two different task tracking systems exist for different purposes. Root TASKS.md tracks system improvements (building the machine). PROJECT-TASKS.md tracks client work (running the machine). Updating the wrong file means work isn't tracked where it should be, breaking continuity for future sessions.

**Fix:** Before updating any task file:
1. Ask: "Am I doing client project work or system development?"
2. Client work → Update `projects/{client}/{project}/PROJECT-TASKS.md`
3. System work → Update root `TASKS.md`
4. When in doubt, check CLAUDE.md "Task Tracking: Two Systems" section

---

### Skipping /direct-response-copy step (ADHD Sleep Audit)

**Pattern:** Moving directly from `/seo-content` to `/validate-content`, skipping the `/direct-response-copy` enhancement step

**Why it fails:** The workflow is sequential for a reason. `/seo-content` creates the SEO-optimised draft. `/direct-response-copy` adds conversion elements, punches up the copy, and makes it persuasive. Skipping this step produces content that ranks but doesn't convert.

**Fix:** Follow the complete content workflow:
1. `/seo-content` → Creates draft
2. `/direct-response-copy` → Enhances for conversion
3. `/validate-content` → Final quality check

Never skip step 2. It's where good content becomes great content.

---

### Self-validation instead of /validate-content skill (ADHD Sleep Audit)

**Pattern:** Manually checking content against rules instead of running the `/validate-content` skill

**Why it fails:** Self-validation is inconsistent and incomplete. The `/validate-content` skill runs ALL universal rules, checks brand voice alignment, and catches patterns human review misses. Manual checking often misses banned words, AI phrases, or SEO requirements.

**Fix:** Always run `/validate-content` as the final step:
1. Never declare content "validated" without running the skill
2. The skill produces PASS/FAIL with specific line issues
3. If FAIL, fix issues and re-run until PASS
4. Only the skill output counts as validation

---

### Session ending without workflow completion handoff (ADHD Sleep Audit)

**Pattern:** Ending a session mid-workflow without documenting where to resume, what's done, and what remains

**Why it fails:** Next session starts with zero context. Work gets duplicated or skipped. Decisions made earlier are forgotten or contradicted. The 45% context rule exists to prevent this—if you're running out of context, you should have already written the handoff.

**Fix:** Before ANY session ends:
1. Update PROJECT-TASKS.md with current status
2. If mid-task: Document exactly where you stopped
3. Write "Handoff" section with Done/Decisions/Next
4. If workflow incomplete: Create clear starter prompt for resumption
5. Never assume "I'll remember" or "it's obvious"

---

### Em dash overuse

**Pattern:** Using em dashes "—" for pauses, asides, or emphasis

**Why it fails:** Em dashes are an AI writing fingerprint. They interrupt flow and feel overly dramatic. Professional copywriters avoid them.

**Fix:** Restructure as separate sentences or use periods. Never replace with other punctuation.

---

### Keyword-only slugs

**Pattern:** Slugs that are just the primary keyword (e.g., `adhd-sleep`, `calming-sounds`)

**Why it fails:** Misses SEO opportunity. Descriptive slugs tell readers and search engines what the article is about. Keyword-only slugs are ambiguous.

**Fix:** Use descriptive-first format: `understanding-adhd-sleep-problems`, `guide-to-calming-sounds-adhd`

---

### H1 without hook

**Pattern:** H1 that is just the keyword without context or intrigue

**Why it fails:** Misses opportunity to capture attention. "ADHD Sleep Problems" tells you the topic but doesn't make you want to read. "ADHD Sleep Problems: Why Your Child's Brain Won't Switch Off" does.

**Fix:** Always pair keyword with a hook that creates curiosity or promises value.

---

## Agent Orchestration Patterns

The following patterns relate to agent orchestration. See [Workflow Rules](workflow.md) for the complete guidelines.

---

### Asking clarifying questions in agent context

**Pattern:** Agent attempts to ask a question ("Should I include X?" or "Which format do you prefer?") during execution

**Why it fails:** Agents operate in fresh context windows with no memory of the main session. They cannot receive answers to questions. Any question asked hangs forever, blocking the agent. The main session never sees the question because agents run autonomously.

**Fix:** All clarifying questions must be resolved BEFORE spawning agents:
1. Main session gathers all requirements upfront
2. Resolve ambiguities with the user before orchestration begins
3. Agent prompts include complete, unambiguous instructions
4. If agent encounters missing context, it returns FAIL with the missing item listed—never asks

**Reference:** `rules/workflow.md` → Agent orchestration section

---

### Returning abbreviated validation output

**Pattern:** Validation agent returns "PASS" or "FAIL" without full details, or summarises issues instead of listing them all with line numbers

**Why it fails:** The main session needs full validation output to make retry decisions. Without line-specific issues, the main session cannot determine whether to retry, which fixes to apply, or whether to escalate. Abbreviated output forces the main session to re-validate or read the article directly, defeating the purpose of agent isolation.

**Fix:** Validation agents must return the COMPLETE output format:
1. Every FAIL issue with line number and specific fix
2. Every WARN issue with suggestion
3. Full SEO checklist with actual values
4. Complete readability metrics table
5. Brand voice alignment assessment

Never abbreviate. Never summarise. Return everything.

**Reference:** `rules/workflow.md` → Agent return formats section; `agents/content-validator.md`

---

### Combining writing and validation in single agent

**Pattern:** Spawning one agent to both write an article AND validate it, or asking the writing agent to "self-validate before returning"

**Why it fails:** Combining roles breaks isolation and loses the benefits of agent architecture:
- Self-validation bias: writers miss their own mistakes
- Context bloat: combined tasks use more context, increasing failure risk
- Unclear failure handling: if validation fails, do you re-run the whole thing?
- No parallel validation: can't validate multiple articles simultaneously

**Fix:** Always use SEPARATE agents:
1. seo-writer agent: Creates article, returns file path + status
2. content-validator agent: Reads article from path, validates, returns full output
3. Main session: Decides retry strategy based on validation output

Separate agents per task. Always separate. No exceptions.

**Reference:** `rules/workflow.md` → Single article pipeline section

---

### Passing content instead of file paths

**Pattern:** Including full article content in the agent prompt or expecting agents to return full article text in their response

**Why it fails:** Passing content instead of paths wastes context:
- Main session context: Article text (2000+ words) bloats the orchestrator
- Agent prompt: Already has context files to read; adding content is redundant
- Return payload: Full article in response prevents orchestrating many articles

The whole point of agents is keeping the main session context minimal for orchestration.

**Fix:** Always pass file paths, never content:
1. Agents receive paths to context files (profile, positioning, brief)
2. Agents read those files themselves
3. Writing agents return: file path + status (not content)
4. Validation agents read from path, return validation output (not article)
5. Main session never reads article content directly

If main session needs article details, read from the file path after orchestration completes.

**Reference:** `rules/workflow.md` → Agent orchestration section

---

### Primary Keyword Frontmatter Mismatch (Issue #3)

**Pattern:** Frontmatter `primary_keyword` field contains one keyword variation, but article content uses a different variation

**Why it fails:** SEO inconsistency. Google doesn't see clear keyword targeting when frontmatter and content don't match.

**Fix:** Before writing agent returns PASS, validate that frontmatter primary keyword appears verbatim in:
- First 150 words of content
- At least one H2 heading
- Meta title and description

**Example:**
- ❌ Frontmatter says `autism meltdown child` but content uses `autism meltdown` throughout
- ✓ Frontmatter says `autism meltdown` and content uses exact phrase in intro, H2s, meta

**Source:** Autistic Meltdowns pillar — Article 01, caught in validation retry

---

### Slug Format: Keyword-Only Instead of Descriptive-First (Issue #3)

**Pattern:** Slug is just the keyword (e.g., `what-to-play-during-meltdown`) without descriptive context

**Why it fails:** Violates slug rules in universal-rules.md. Descriptive-first format (`{context}-{keyword}`) provides clarity and SEO benefit.

**Fix:** Writing agent validates slug format before returning:
- Must follow pattern: `{context}-{keyword}`
- Cannot be keyword-only
- Max 50 characters
- Examples:
  - ❌ `adhd-sleep`
  - ✓ `understanding-adhd-sleep-problems`
  - ❌ `email-marketing`
  - ✓ `complete-guide-email-marketing`

**Source:** Autistic Meltdowns pillar — Article 02, caught in validation retry

---

### Banned Word Slips Through Enhancement (Issue #3)

**Pattern:** Banned AI word (e.g., "navigate") appears in article after copy-enhancer runs

**Why it fails:** Copy Enhancer is supposed to catch and replace banned words but isn't doing so consistently

**Fix:** Copy Enhancer must run banned words check BEFORE returning PASS:
1. Search article for all 53 banned words (case-insensitive)
2. Replace each instance with natural alternative
3. Confirm zero banned words remain before returning

**Source:** Autistic Meltdowns pillar — Article 01, word "navigate" on line 115, caught in validation retry
