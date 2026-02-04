# Workflow Rules

The single source of truth for content generation workflow. All agents and skills reference this document.

---

## Workflow Overview

The content workflow has 7 steps: 3 manual (require user decisions) and 4 agent-automated.

| Step | Skill | Mode | Input | Output |
|------|-------|------|-------|--------|
| 1 | `/keyword-research` | Manual | Client profile | `00-keyword-brief.md` |
| 2 | `/start-pillar` | Manual | Keyword brief + pillar | `{pillar}/01-pillar-brief.md` |
| 3 | `/positioning-angles` | Manual | Pillar brief + profile | `{pillar}/02-positioning.md` |
| 4 | `/seo-content` | **Agent** | Positioning + profile | `{pillar}/articles/{nn}-{slug}.md` |
| 5 | `/direct-response-copy` | **Agent** | Draft article | Updates article in place |
| 6 | `/validate-content` | **Agent** | Final + rules | PASS/FAIL |
| 7 | `/content-atomizer` | **Agent** | Final article | `{pillar}/distribution/{slug}/` |

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

The main session receives tasks and spawns agents. Agents return results to the main session—they cannot pass work to each other.

```
MAIN SESSION receives task
    │
    ├─→ Main session spawns SEO WRITER
    │       └─→ Agent returns: PASS/FAIL + file path + word count
    │           └─→ Main session receives result
    │
    ├─→ Main session spawns COPY ENHANCER
    │       └─→ Agent returns: PASS/FAIL + changes made
    │           └─→ Main session receives result
    │
    ├─→ Main session spawns CONTENT VALIDATOR
    │       └─→ Agent returns: PASS/FAIL + FULL issues list
    │           └─→ Main session receives result
    │                   │
    │                   ├─→ If PASS: Continue to atomizer
    │                   │
    │                   └─→ If FAIL: Main session spawns COPY ENHANCER (fix mode)
    │                               └─→ Main session spawns VALIDATOR again
    │                               └─→ Repeat up to 3 times
    │                               └─→ After 3 failures: Escalate to user
    │
    ├─→ Main session spawns CONTENT ATOMIZER
    │       └─→ Agent returns: PASS/FAIL + files created
    │           └─→ Main session receives result
    │
    └─→ Main session commits to git + updates PROJECT-TASKS.md
```

---

## Single Article Pipeline

Each article follows this pipeline. The main session orchestrates each step.

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
│     - Returns TO MAIN SESSION: file path + status + word count  │
└─────────────────────────────────────────────────────────────────┘
                           │
                     spawns ▼ receives result
┌─────────────────────────────────────────────────────────────────┐
│  2. COPY ENHANCER AGENT (fresh context)                         │
│     - Receives from main session: Article path                  │
│     - Has preloaded: direct-response-copy skill                 │
│     - Edits: Article in place                                   │
│     - Returns TO MAIN SESSION: status + changes made            │
└─────────────────────────────────────────────────────────────────┘
                           │
                     spawns ▼ receives result
┌─────────────────────────────────────────────────────────────────┐
│  3. CONTENT VALIDATOR AGENT (fresh context, READ-ONLY)          │
│     - Receives from main session: Article path                  │
│     - Has preloaded: validate-content skill                     │
│     - Reads at runtime: universal-rules, common-mistakes        │
│     - Checks: All 6 validation phases                           │
│     - Returns TO MAIN SESSION: FULL output (PASS/FAIL + issues) │
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

---

## Retry Loop

When validation fails, the main session orchestrates a retry loop. Maximum 3 attempts per article.

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

**Why file-based issue passing:** Copy Enhancer reads issues directly from the validation file instead of receiving them in the prompt. This prevents main session context overflow when orchestrating 32+ articles.

---

## Tier-Based Parallel Execution

When generating multiple articles, execute in tiers based on internal linking dependencies.

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

From the pillar brief, identify article dependencies:

| Article Type | Links To | Tier |
|--------------|----------|------|
| Articles with no internal links needed | - | Tier 1 |
| Articles that reference Tier 1 articles | Tier 1 | Tier 2 |
| Articles that reference Tier 2 articles | Tier 2 | Tier 3 |
| Pillar Guide (links to all) | All articles | Final |

### Execution Rules

1. **Parallel within tiers:** All articles in the same tier can run simultaneously
2. **Sequential across tiers:** Wait for all Tier N articles to complete before starting Tier N+1
3. **Commit per tier:** After all articles in a tier pass validation, commit them together
4. **Pillar guide last:** Always executes in the final tier (needs to link to all articles)

---

## Validation Checkpoints

Content validation happens at specific points. Some are automatic, others are manual.

| Checkpoint | Trigger | What to Validate | Type |
|------------|---------|------------------|------|
| Post-draft | After seo-writer agent | Full article against universal rules | Automatic |
| Post-enhancement | After copy-enhancer agent | Full article + brand voice alignment | Automatic |
| Pre-publish | Before changing status to "published" | Final validation (all checks) | Automatic |
| Batch review | After pillar complete | All pillar articles for cross-article consistency | Manual |
| Spot check | When issues suspected | Specific content on request | Manual |

**Automatic Checkpoints:** Run without being asked.
- **Post-draft:** Catches AI fingerprints and rule violations early
- **Post-enhancement:** Ensures direct-response-copy changes didn't introduce issues
- **Pre-publish:** Final gate before content goes live

**Manual Checkpoints:** Run when explicitly requested.
- **Batch review:** After completing a pillar, review all articles together
- **Spot check:** When client feedback suggests issues or quality is questioned

---

## Internal Linking Strategy

Internal links are added at different times depending on link type.

| Link Type | When to Add | Notes |
|-----------|-------------|-------|
| Links TO pillar guide | After pillar guide published | Go back and update all supporting articles |
| Links BETWEEN supporting articles | During writing if target exists, or after both published | Use placeholder if target doesn't exist yet |
| Links FROM pillar guide | During pillar guide writing | All supporting articles exist at this point |
| Links FROM outside pillar | After pillar complete | Cross-pillar linking pass |

### Placeholder Convention

When referencing an article that doesn't exist yet:

```html
<!-- LINK NEEDED: [slug] when published -->
```

**Example:** Writing article 01 and want to reference article 05:

```markdown
For advanced techniques, see our guide on automation workflows<!-- LINK NEEDED: 05-automation-workflows when published -->.
```

### Post-Pillar Linking Pass

After the pillar guide is published:

1. Replace all `<!-- LINK NEEDED: ... -->` placeholders with actual links
2. Add links TO the pillar guide from all supporting articles
3. Update frontmatter `internal_links` arrays
4. Verify no broken links remain

### Cross-Pillar Linking

Cross-pillar links connect related content across different topic clusters. Use sparingly—each article should primarily link within its own pillar.

**When to Cross-Link:**
- Topics naturally overlap
- Article mentions concept from another pillar
- Supporting article could benefit from related pillar guide

**Rules:**
- Maximum 1-2 cross-pillar links per article
- Use anchor text that clarifies the pillar context
- Don't over-link (each article primarily links within its own pillar)

---

## Error Logging

### During Pillar Execution

All errors are logged to a GitHub Issue for the pillar.

**Issue Title:** `🔴 Errors: {Pillar Name}`

**Error Log Format:**

```
**[Error Type]** {message}
```

**Error Types:**

| Type | When |
|------|------|
| `Validation FAIL` | `/validate-content` returns FAIL |
| `Git Error` | Any git operation fails |
| `Agent FAIL` | Any agent fails to complete |

**Examples:**

```
**[Validation FAIL]** Line 23: "color" - US spelling → use "colour"

**[Validation FAIL]** Line 45: "leverage" - banned AI word → use "use"

**[Agent FAIL]** seo-writer failed: missing positioning.md
```

### After Pillar Completion

1. Review all errors logged to the Issue
2. Extract recurring patterns (3+ occurrences) to `common-mistakes.md`
3. Convert Draft PR to Ready for Review
4. Close the Issue with summary

**Pattern Extraction Template:**

```markdown
### [Pattern Name] (Issue #{number})

**Pattern:** What to look for

**Why it fails:** Explanation

**Fix:** How to correct

**Source:** {pillar name} — {count} occurrences
```

---

## Agent Reference

For full agent specifications, see [agents-prd.md](../agents-prd.md).

| Agent | File | Purpose | Tools |
|-------|------|---------|-------|
| SEO Writer | `seo-writer.md` | Write articles with E-E-A-T research | Read, Glob, Grep, Write |
| Copy Enhancer | `copy-enhancer.md` | Add persuasion + fix validation issues | Read, Edit |
| Content Validator | `content-validator.md` | Check rules + quality, write validation file | Read, Glob, Grep, Write |
| Content Atomizer | `content-atomizer.md` | Create platform distribution | Read, Write |

### Agent Return Formats

| Agent | Returns |
|-------|---------|
| SEO Writer | `PASS, {file_path}` |
| Copy Enhancer | `PASS` |
| Content Validator | `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}` |
| Content Atomizer | `PASS` |

**Why minimal returns:** Prevents main session context overflow during pillar execution (32+ articles). Full validation output goes to files, not return messages.

### Validation File Lifecycle

```
1. Validator runs on article
   ├── PASS → Delete any existing validation file, return "PASS"
   └── FAIL → Write full report to {slug}.validation.md, return "FAIL, {counts}, {path}"

2. Main session receives FAIL
   └── Spawns copy-enhancer with: article_path, validation_file_path

3. Copy-enhancer runs
   ├── Reads validation file for issues
   ├── Fixes issues
   └── Returns "PASS"

4. Main session spawns validator again
   ├── PASS → Validator deletes validation file, returns "PASS"
   └── FAIL → Cycle repeats (max 3 attempts)

5. After 3 failures → Escalate to user (validation file remains for debugging)
```

**File location:** `{slug}.validation.md` written alongside the article (same directory).

### Auto-Delegation Triggers

Claude automatically delegates to agents based on these patterns:

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

## File Structure

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

### Article Numbering

1. **Supporting articles** numbered `01`, `02`, `03`... in priority/publishing order
2. **Pillar guide** always gets the **highest number** (publishes last)
3. **Example:** 10 supporting articles + pillar guide = supporting articles are `01`-`10`, pillar guide is `11-{slug}.md`

---

*This file is the single source of truth for workflow rules. All agents and skills reference this document. Update here → changes propagate everywhere.*
