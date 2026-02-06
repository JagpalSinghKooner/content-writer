# SEO Content System

A content production system that creates SEO-optimised articles for any client. Uses client profiles for brand consistency, universal rules for quality control, and a structured workflow from keyword to publish-ready content.

---

## Task Tracking: Two Systems

This project uses **two separate task tracking files** for different purposes:

- **`TASKS.md`** (repository root): System development tasks. Building skills, rules, templates, and infrastructure for the content system itself.
- **`PROJECT-TASKS.md`** (`/projects/{client}/{project}/`): Client project work. Tracking content creation tasks for specific client projects (keyword research, articles, distribution).

**Why two files?**

- **TASKS.md (root):** Tracks work on the content system itself — new skills, rule updates, template improvements, bug fixes. This is *building the machine*.
- **PROJECT-TASKS.md:** Tracks work *using* the system for clients — researching keywords, writing articles, creating distribution content. This is *running the machine*.

**When starting a session:**
- Working on a client project? → Read the project's `PROJECT-TASKS.md`
- Working on system improvements? → Read the root `TASKS.md`

---

## FIRST: Session Start Protocol

**Before doing ANY work, read these files in order:**

1. `PROJECT-TASKS.md` in the project root — Check current task status, read handoff context from completed tasks
2. Client profile (if working on a project) — Restore brand voice and requirements

**If PROJECT-TASKS.md doesn't exist for the current project, create it before starting work.**

This is non-negotiable. Without reading PROJECT-TASKS.md, you have no context about what's been done, what's in progress, or what decisions were made. You will duplicate work or contradict previous decisions.

---

## Rule #1: Task Execution (Applies to Everything)

**This rule governs ALL work. Every task. Every phase. Every skill. No exceptions.**

### How All Work Gets Done

1. **Plan** → Break work into discrete tasks
2. **Document** → Write tasks to `PROJECT-TASKS.md` in project root
3. **Execute** → Complete one task at a time
4. **Verify** → Each task must 100% PASS before proceeding
5. **Handoff** → Document completion with context for next task

**CRITICAL: NEVER tell the user a task is complete without FIRST updating PROJECT-TASKS.md. The update happens IN THE SAME RESPONSE as the task completion, not after. Failure to do this breaks the entire system.**

### Context Management

- Every task must complete under 45% context window
- If a task will exceed 45%: stop, re-plan, split into 2-3 sessions
- Never push through with degraded context—split the work instead

### PROJECT-TASKS.md Template

Every project uses this structure:

```
# Project Tasks: [Project Name]

## Task 1: [Task Title]

**Objective:** [Single focused goal]

**Acceptance Criteria:**
- [ ] [Specific measurable outcome]
- [ ] [Specific measurable outcome]

**Starter Prompt:**
> [Ready-to-paste prompt with all context needed to begin this task fresh]

**Status:** pending | in_progress | PASS | FAIL

---

**Handoff (completed tasks only):**
- **Done:** [What was completed]
- **Decisions:** [Key choices, patterns established]
- **Next:** [Context for next task]
```

### Why This Rule Exists

- Prevents context rot
- Maintains consistent quality
- Creates clear audit trail
- Enables pause/resume at any point
- Every task is reproducible with its starter prompt

**If you skip this rule, the work fails.**

See [Common Mistakes](references/common-mistakes.md) for recurring violations of this rule.

### STOP: Before Completing Any Task

Before responding that a task is done, verify:

- [ ] PROJECT-TASKS.md acceptance criteria boxes are checked
- [ ] PROJECT-TASKS.md status changed to PASS
- [ ] PROJECT-TASKS.md handoff section written (Done, Decisions, Next)
- [ ] Git commit created and pushed
- [ ] PR created (if pillar complete)

**A task is NOT complete until this checklist passes. Do this update IN THE SAME RESPONSE as the task completion, not separately.**

---

## Rule #2: Git Workflow (Automatic)

**Claude handles all git operations automatically. You don't need to ask.**

### When a Task Passes

Immediately after updating PROJECT-TASKS.md with PASS status:

1. Stage all changed files in the project folder
2. Commit with message format:
   ```
   ✅ {Task Title}

   {Brief description of what was done}

   Co-Authored-By: Claude <noreply@anthropic.com>
   ```
3. Push to the current branch

**Example commit:**
```
✅ Complete pillar brief for AI Marketing

Created 01-pillar-brief.md with competitor analysis and content plan.

Co-Authored-By: Claude <noreply@anthropic.com>
```

### When a Pillar is Complete

After the final task in a pillar passes (pillar guide + distribution done):

1. Create a Pull Request with:
   - **Title:** `📚 {Pillar Name} - Complete`
   - **Body:** Summary of all articles, word counts, and distribution assets
2. Inform the user the PR is ready for review

**PR triggers when:**
- Pillar guide is written and validated
- All supporting articles are written and validated
- Distribution content is created (if requested)

### Branch Strategy

- Single pillar: work on `main` or current branch
- Multiple pillars: create `pillar/{pillar-name}` branch
- Client project: create `client/{client-name}` branch

### What NOT to Auto-Commit

- Work in progress (only commit on PASS)
- Failed tasks (FAIL status = no commit)
- Exploratory changes or drafts

---

## Rule #3: Error Tracking (Automatic)

**Every error is logged to GitHub for pattern extraction. This is how the system learns.**

### When Starting a Pillar

1. Create branch `pillar/{pillar-name}`
2. Create GitHub Issue: `🔴 Errors: {Pillar Name}`
3. Create Draft PR: `📚 {Pillar Name}` with Issue link in description

**Issue Description Template:**
```
Tracking errors for the {Pillar Name} pillar.

Errors are logged automatically. When the pillar completes, recurring patterns will be extracted to `common-mistakes.md`.

Related PR: #{pr-number}
```

### When Any Error Occurs

Auto-comment to the Issue with this format:

```
**[Error Type]** {message}
```

**Error Types:**
- `Validation FAIL`: `/validate-content` returns FAIL
- `Git Error`: any git operation fails
- `Skill FAIL`: any skill fails to complete

**Examples:**
```
**[Validation FAIL]** Banned word "leverage" in paragraph 3

**[Git Error]** Merge conflict in 01-pillar-brief.md

**[Skill FAIL]** /seo-content failed: missing brand voice in profile
```

### When Pillar Completes

1. Review all errors logged to the Issue
2. Extract recurring patterns (3+ occurrences) to `common-mistakes.md`
3. Convert Draft PR to Ready for Review
4. Close the Issue with summary comment

**Closing Comment Template:**
```
## Summary

- Total errors logged: {count}
- Patterns extracted: {count}
- Added to common-mistakes.md: {list pattern names}

Closing as pillar is complete.
```

### Why This Rule Exists

- **Captures everything** — No error lost between sessions
- **Patterns emerge** — Same error 5 times = obvious pattern
- **System improves** — common-mistakes.md grows with real data
- **Errors decrease** — Future validation catches known patterns

---

## Phase 1: Client Onboarding

Run `/onboard-client` once per client to create their profile:

1. Provide product/service description
2. Answer interview questions (company, audience, competitors, voice)
3. Output saved to `/clients/{name}/profile.md`

**Note:** Brand voice is captured during onboarding (not a separate step). The profile includes a complete voice profile with tone spectrum, personality traits, vocabulary, rhythm patterns, and example phrases.

---

## Phase 2: Content Generation

Follow the 7-step workflow: keyword research → start pillar → positioning → seo-content → direct-response-copy → validate → atomize. Steps 1-3 are manual (require user decisions); steps 4-7 are agent-automated via `/execute-pillar`. See [Workflow Rules](rules/workflow.md) for the full pipeline, agent orchestration, retry logic, and tier-based parallel execution.

### File Naming Conventions

- Keyword brief: `00-keyword-brief.md`
- Pillar brief: `01-pillar-brief.md`
- Positioning: `02-positioning.md`
- Supporting articles: `{nn}-{slug}.md` (e.g. `01-beginners-guide-what-is-seo.md`)
- Pillar guide: `{nn}-{slug}.md` with highest number (e.g. `11-complete-guide-ai-marketing-strategy.md`)
- Distribution: `distribution/{slug}/{platform}.md` (e.g. `distribution/beginners-guide-what-is-seo/linkedin.md`)

**Article Numbering:**

1. **Supporting articles** numbered `01`, `02`, `03`... in priority/publishing order
2. **Pillar guide** always gets the **highest number** (publishes last)
3. **Example:** 10 supporting articles + pillar guide = articles `01`-`10`, pillar guide is `11-{slug}.md`

The pillar guide publishes last because it links to all supporting articles.

**Slug Rules:**
- Lowercase only
- Hyphens between words (no underscores or spaces)
- Descriptive-first format: `{context}-{keyword}` (not keyword-only)
- Max 50 characters
- No stop words unless essential for meaning

### Pillar-First Execution

Complete ALL articles for one pillar before moving to the next. This ensures:
- Internal linking is coherent
- Positioning stays consistent across related content
- Pillar guide can reference all supporting articles when written last

### Internal Linking Strategy

Internal links are added at different times depending on link type:

- **Links TO pillar guide:** Add after pillar guide is published. Go back and update all supporting articles.
- **Links BETWEEN supporting articles:** Add during writing if target exists, or after both are published. Use placeholder if target doesn't exist yet.
- **Links FROM pillar guide:** Add during pillar guide writing. All supporting articles exist at this point.
- **Links FROM outside pillar:** Add after pillar is complete (cross-pillar linking pass).

**Placeholder Convention:**

When referencing an article that doesn't exist yet, use this placeholder:

```html
<!-- LINK NEEDED: [slug] when published -->
```

**Example:** Writing article 01 and want to reference article 05:

```markdown
For advanced techniques, see our guide on automation workflows<!-- LINK NEEDED: 05-automation-workflows when published -->.
```

**Post-Pillar Linking Pass:**

After the pillar guide is published, run a linking pass:
1. Replace all `<!-- LINK NEEDED: ... -->` placeholders with actual links
2. Add links TO the pillar guide from all supporting articles
3. Update frontmatter `internal_links` arrays
4. Verify no broken links remain

#### Cross-Pillar Linking

Cross-pillar links connect related content across different topic clusters. Use them sparingly—each article should primarily link within its own pillar.

**When to Cross-Link:**

- Topics naturally overlap (e.g. AI marketing tools article links to automation pillar guide)
- Article mentions a concept from another pillar (e.g. SEO article references email marketing best practices)
- Supporting article could benefit from a related pillar guide (e.g. how-to article links to guide in adjacent topic)

**Cross-Pillar Linking Pass:**

After completing the current pillar:
1. Review other completed pillars for linking opportunities
2. Add 1-2 cross-pillar links maximum per article (more dilutes internal link equity)
3. Update frontmatter `internal_links` arrays with new cross-pillar links
4. Use anchor text that clarifies the pillar context (not just generic keywords)

**Anchor Text for Cross-Pillar Links:**

- Good: "our guide to building email sequences" (clarifies different topic)
- Good: "the automation workflow pillar" (explicitly names the pillar)
- Bad: "click here" (no context)
- Bad: "marketing" (too generic)

**Don't Over-Link:**

- Each article primarily links within its own pillar (maintains topical authority)
- Cross-pillar links are supplementary, not primary
- If you're adding more than 2 cross-pillar links, reconsider

### Validation Checkpoints

Content validation happens at specific points in the workflow. Some checkpoints are automatic (run every time), others are manual (run on request).

- **Post-draft** (Automatic): After `/seo-content`, validate full article against universal rules
- **Post-enhancement** (Automatic): After `/direct-response-copy`, validate full article + brand voice alignment
- **Pre-publish** (Automatic): Before changing status to "published", run final validation (all checks)
- **Batch review** (Manual): After pillar complete, review all pillar articles for cross-article consistency
- **Spot check** (Manual): When issues suspected, validate specific content on request

**Automatic Checkpoints:**

These run without being asked:
- **Post-draft:** Catches AI fingerprints and rule violations early, before enhancement work
- **Post-enhancement:** Ensures direct-response-copy changes didn't introduce issues
- **Pre-publish:** Final gate before content goes live

**Manual Checkpoints:**

These run when explicitly requested:
- **Batch review:** After completing a pillar, review all articles together for consistency, contradictions, and cross-linking
- **Spot check:** When client feedback suggests issues, when revisiting old content, or when quality is questioned

---

## Agents

Six agents handle automated workflows. Agents cannot spawn other agents; the main session orchestrates all spawning, retry loops, and commits. Agent files in `.claude/agents/`. See [Agents PRD](agents-prd.md) for full specifications.

---

## Rules & References

- [Universal Rules](rules/universal-rules.md) — UK English, banned AI words, SEO requirements
- [Workflow Rules](rules/workflow.md) — Agent orchestration, execution pipeline, retry loops
- [Common Mistakes](references/common-mistakes.md) and [Client Profile Requirements](references/client-profile-requirements.md) in `references/`

---

## Templates

Located in `.claude/skills/templates/`. Skills load their own templates and reference materials automatically.
