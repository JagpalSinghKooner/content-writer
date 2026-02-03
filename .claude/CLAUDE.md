# SEO Content System

A content production system that creates SEO-optimised articles for any client. Uses client profiles for brand consistency, universal rules for quality control, and a structured workflow from keyword to publish-ready content.

---

## Task Tracking: Two Systems

This project uses **two separate task tracking files** for different purposes:

| File | Location | Purpose |
|------|----------|---------|
| `TASKS.md` | Repository root | **System development tasks** — Building skills, rules, templates, and infrastructure for the content system itself |
| `PROJECT-TASKS.md` | `/projects/{client}/{project}/` | **Client project work** — Tracking content creation tasks for specific client projects (keyword research, articles, distribution) |

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

See [Common Mistakes](rules/common-mistakes.md) for recurring violations of this rule.

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

| Scenario | Branch |
|----------|--------|
| Single pillar | Work on `main` or current branch |
| Multiple pillars | Create `pillar/{pillar-name}` branch |
| Client project | Create `client/{client-name}` branch |

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
| Type | When |
|------|------|
| `Validation FAIL` | `/validate-content` returns FAIL |
| `Git Error` | Any git operation fails |
| `Skill FAIL` | Any skill fails to complete |

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

| Step | Skill | Input | Output |
|------|-------|-------|--------|
| 1 | `/keyword-research` | Client profile | `00-keyword-brief.md` |
| 2 | `/start-pillar` | Keyword brief + pillar name | `{pillar}/01-pillar-brief.md` |
| 3 | `/positioning-angles` | Pillar brief + profile | `{pillar}/02-positioning.md` |
| 4 | `/seo-content` | Positioning + profile | `{pillar}/articles/{nn}-{slug}.md` |
| 5 | `/direct-response-copy` | Draft article | Updates article in place |
| 6 | `/content-atomizer` | Final article | `{pillar}/distribution/{slug}/` |
| 7 | `/validate-content` | Final + rules | PASS/FAIL |

### File Structure

```
/projects/{client}/{project}/
├── PROJECT-TASKS.md
├── 00-keyword-brief.md
└── {pillar-name}/
    ├── 01-pillar-brief.md
    ├── 02-positioning.md
    ├── articles/
    │   ├── 01-{slug}.md
    │   ├── 02-{slug}.md
    │   └── ...
    └── distribution/
        └── {article-slug}/
            ├── linkedin.md
            ├── twitter.md
            ├── newsletter.md
            └── instagram.md
```

### File Naming Conventions

**Strict naming rules for all project files:**

| File Type | Naming Pattern | Example |
|-----------|----------------|---------|
| Keyword brief | `00-keyword-brief.md` | `00-keyword-brief.md` |
| Pillar brief | `01-pillar-brief.md` | `01-pillar-brief.md` |
| Positioning | `02-positioning.md` | `02-positioning.md` |
| Supporting articles | `{nn}-{slug}.md` | `01-what-is-seo.md` |
| Pillar guide | `{nn}-{slug}.md` (highest number) | `11-ai-marketing-strategy-guide.md` |
| Distribution | `distribution/{slug}/{platform}.md` | `distribution/what-is-seo/linkedin.md` |

**Article Numbering:**

Supporting articles and the pillar guide are numbered sequentially:

1. **Supporting articles** numbered `01`, `02`, `03`... in priority/publishing order
2. **Pillar guide** always gets the **highest number** (publishes last)
3. **Example:** 10 supporting articles + pillar guide = supporting articles are `01`-`10`, pillar guide is `11-{slug}.md`

The pillar guide publishes last because it links to all supporting articles—those articles must exist first.

**Slug Rules:**
- Lowercase only
- Hyphens between words (no underscores or spaces)
- Contains primary keyword
- Max 50 characters
- No stop words unless essential for meaning

**Distribution Folder:**

When atomising content for social distribution, create a folder per article:

```
distribution/{article-slug}/
├── linkedin.md      # LinkedIn post(s)
├── twitter.md       # Twitter/X thread
├── newsletter.md    # Newsletter snippet
└── instagram.md     # Instagram caption + carousel notes
```

Each platform file follows its own format but references the source article slug in the filename structure.

**Platform File Formats:**

Each distribution file uses a consistent format with YAML frontmatter:

| File | Contains | Key Sections |
|------|----------|--------------|
| `linkedin.md` | Carousel slides + text posts | Carousel (slides 1-10), Text Posts (2-3 standalone) |
| `twitter.md` | Thread + single tweets | Thread (8-15 tweets), Singles (3-5 standalone) |
| `newsletter.md` | Newsletter snippet | Hook, Body (2-3 paragraphs), CTA |
| `instagram.md` | Carousel + Reel script | Carousel (slides 1-10), Caption, Reel Script (15-30s) |

**Standard frontmatter for all platform files:**

```yaml
---
source_article: "{slug}"
platform: "{platform}"
created: "YYYY-MM-DD"
status: draft | ready | published
---
```

### Pillar-First Execution

Complete ALL articles for one pillar before moving to the next. This ensures:
- Internal linking is coherent
- Positioning stays consistent across related content
- Pillar guide can reference all supporting articles when written last

### Internal Linking Strategy

Internal links are added at different times depending on link type:

| Link Type | When to Add | Notes |
|-----------|-------------|-------|
| Links TO pillar guide | After pillar guide published | Go back and update all supporting articles |
| Links BETWEEN supporting articles | During writing if target exists, or after both published | Use placeholder if target doesn't exist yet |
| Links FROM pillar guide | During pillar guide writing | All supporting articles exist at this point |
| Links FROM outside pillar | After pillar complete | Cross-pillar linking pass |

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

| Scenario | Example |
|----------|---------|
| Topics naturally overlap | AI marketing tools article links to automation pillar guide |
| Article mentions concept from another pillar | SEO article references email marketing best practices |
| Supporting article could benefit from related pillar guide | How-to article links to comprehensive guide in adjacent topic |

**Cross-Pillar Linking Pass:**

After completing the current pillar:
1. Review other completed pillars for linking opportunities
2. Add 1-2 cross-pillar links maximum per article (more dilutes internal link equity)
3. Update frontmatter `internal_links` arrays with new cross-pillar links
4. Use anchor text that clarifies the pillar context (not just generic keywords)

**Anchor Text for Cross-Pillar Links:**

- ✓ "our guide to building email sequences" (clarifies different topic)
- ✓ "the automation workflow pillar" (explicitly names the pillar)
- ✗ "click here" (no context)
- ✗ "marketing" (too generic)

**Don't Over-Link:**

- Each article primarily links within its own pillar (maintains topical authority)
- Cross-pillar links are supplementary, not primary
- If you're adding more than 2 cross-pillar links, reconsider—one pillar shouldn't depend heavily on another

### Validation Checkpoints

Content validation happens at specific points in the workflow. Some checkpoints are automatic (run every time), others are manual (run on request).

| Checkpoint | Trigger | What to Validate | Type |
|------------|---------|------------------|------|
| Post-draft | After `/seo-content` | Full article against universal rules | Automatic |
| Post-enhancement | After `/direct-response-copy` | Full article + brand voice alignment | Automatic |
| Pre-publish | Before changing status to "published" | Final validation (all checks) | Automatic |
| Batch review | After pillar complete | All pillar articles for cross-article consistency | Manual |
| Spot check | When issues suspected | Specific content on request | Manual |

**Automatic Checkpoints:**

These run without being asked:
- **Post-draft:** Catches AI fingerprints and rule violations early, before enhancement work
- **Post-enhancement:** Ensures direct-response-copy changes didn't introduce issues
- **Pre-publish:** Final gate before content goes live

**Manual Checkpoints:**

These run when explicitly requested:
- **Batch review:** After completing a pillar, review all articles together for consistency, contradictions, and cross-linking
- **Spot check:** When client feedback suggests issues, when revisiting old content, or when quality is questioned

### Sub-Agent Orchestration for Pillars

When generating multiple articles for a pillar, use the Parallel by Dependency Tier model:

```
Main Session (Orchestrator)
    │
    ├─→ Tier 1: Foundation article(s)
    │   ├─→ Writing Sub-Agent: Creates article, returns file path
    │   ├─→ Validation Sub-Agent: Validates article, returns PASS/FAIL
    │   └─→ Main commits if PASS
    │
    ├─→ Tier 2: Articles with no inter-dependencies (parallel)
    │   ├─→ Writing Sub-Agents (parallel): Each creates article
    │   ├─→ Validation Sub-Agents (parallel): Each validates
    │   └─→ Main commits all PASS articles
    │
    ├─→ Tier 3+: Articles with dependencies on previous tiers
    │   └─→ Same pattern: write → validate → commit
    │
    └─→ Final Tier: Pillar Guide (depends on all)
        ├─→ Writing Sub-Agent: Creates pillar guide
        ├─→ Validation Sub-Agent: Validates guide
        └─→ Main commits if PASS
```

**Tier Structure:**

1. Identify article dependencies from pillar brief
2. Group articles into tiers (articles in same tier have no inter-dependencies)
3. Run Tier 1 first (foundation articles)
4. Run remaining tiers in order, parallel within each tier

**Sub-Agent Types:**

| Type | Role | Returns |
|------|------|---------|
| Writing | Creates article following /seo-content workflow | File path + status |
| Validation | Validates against universal rules + brand voice | PASS/FAIL + issues |

**How Sub-Agents Work:**

Sub-agents receive **file paths**, not pasted content. Each sub-agent:
1. Receives paths to: client profile, positioning doc, pillar brief
2. Reads those files itself using the Read tool
3. Executes the `/seo-content` workflow autonomously
4. Returns file path + status (not full article content)

**Sub-Agent Instructions Include:**

- Client profile path (e.g., `clients/hushaway/profile.md`)
- Positioning document path (e.g., `{pillar}/02-positioning.md`)
- Pillar brief path (e.g., `{pillar}/01-pillar-brief.md`)
- Target article details (keyword, angle, word count)
- Completed articles list (paths for internal linking)
- Instruction to execute `/seo-content` workflow

**Main Session Responsibilities:**

- Orchestrate tier execution order
- Spawn sub-agents (parallel within tier) using Task tool
- Receive file paths and status from completed sub-agents
- Commit after each tier completes
- Handle any sub-agent failures

**Sub-Agent Responsibilities:**

- Read all context files from provided paths
- Research phase (E-E-A-T citations)
- Write complete article to disk
- Self-validate against universal rules
- Return file path + status to main session

**Failure Handling:**

- If sub-agent fails: Retry with same instructions
- If retry fails: Retry once more with error context
- If second retry fails: Escalate to user, continue with other articles
- Log all failures to PROJECT-TASKS.md

**Context Management:**

- Writing sub-agents return: file path + basic status (not full article text)
- Validation sub-agents read article from path, validate, return PASS/FAIL
- Main session never reads full article content directly
- This keeps main session context minimal for orchestration

---

## Skills

| Skill | Purpose |
|-------|---------|
| `/onboard-client` | Interview to build client profile |
| `/keyword-research` | Find high-opportunity keywords |
| `/start-pillar` | Extract pillar + competitor analysis |
| `/positioning-angles` | Find the hook that differentiates |
| `/seo-content` | Write SEO articles that sound human |
| `/direct-response-copy` | Add conversion elements |
| `/brand-voice` | Voice refinement or evolution (initial voice captured in `/onboard-client`) |
| `/email-sequences` | Build email sequences that convert |
| `/content-atomizer` | Repurpose content across platforms |
| `/lead-magnet` | Generate lead magnet concepts |
| `/newsletter` | Create newsletters people want to read |
| `/validate-content` | Check content against rules before publishing |
| `/orchestrator` | Route to correct skill when unsure where to start |

---

## Rules

- [Universal Rules](rules/universal-rules.md) - UK English, banned AI words, SEO requirements
- [Common Mistakes](rules/common-mistakes.md) - Learned patterns (grows over time)
- [Client Profile Requirements](rules/client-profile-requirements.md) - Which profile fields each skill needs

---

## Templates

Reusable templates for common project needs. Copy and customise for each project.

### Shared Templates

Located in `.claude/skills/templates/`:

| Template | Purpose |
|----------|---------|
| [tasks-template.md](skills/templates/tasks-template.md) | PROJECT-TASKS.md starter for new projects |
| [article-template.md](skills/templates/article-template.md) | SEO article structure with frontmatter |
| [distribution-template.md](skills/templates/distribution-template.md) | Platform files for content atomisation |
| [email-sequence-template.md](skills/templates/email-sequence-template.md) | Email sequence structures by type |

### Skill-Specific Templates

Some skills have their own templates:

| Skill | Template | Purpose |
|-------|----------|---------|
| `/onboard-client` | [profile-template.md](skills/onboard-client/profile-template.md) | Client profile structure |
| `/start-pillar` | [pillar-brief-template.md](skills/start-pillar/templates/pillar-brief-template.md) | Pillar brief structure |

### Reference Materials

Some skills include `/references/` folders with detailed guidance:

| Skill | References | Contents |
|-------|------------|----------|
| `/positioning-angles` | 5 files | Angle frameworks, Dunford positioning, Hormozi offer, Schwartz sophistication, unique mechanism |
| `/lead-magnet` | 5 files | Format examples, psychology, SaaS/services/info-product magnets |
| `/content-atomizer` | 1 file | Platform playbook with specs and best practices |
| `/seo-content` | 1 file | E-E-A-T examples and citation patterns |
| `/newsletter` | 1 file | Newsletter examples from top creators |

Reference materials are loaded automatically when running the relevant skill.

---

## Example Workflow

For a complete end-to-end example showing all phases from onboarding to distribution, see [End-to-End Example](examples/end-to-end-example.md).
