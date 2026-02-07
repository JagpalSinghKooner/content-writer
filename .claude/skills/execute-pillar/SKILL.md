---
name: execute-pillar
description: "Execute full pillar content generation workflow. Use when ready to generate all articles for a pillar after positioning is complete. Orchestrates seo-writer, copy-enhancer, copy-fixer, content-validator, and content-atomizer agents in tier-based parallel execution. Triggers on: execute pillar, run pillar, generate pillar content, /execute-pillar. Outputs: Complete pillar with articles, distribution content, and PR."
---

# Execute Pillar

This skill documents the **full pillar execution workflow** that the main session follows. It is NOT an agent. It is a playbook for orchestration.

**Critical Constraint:** Agents cannot spawn other agents. The main session orchestrates ALL agent spawning. This entire workflow runs from the main session.

---

## When to Use This Skill

Use `/execute-pillar` when:
- Pillar brief (`01-pillar-brief.md`) exists
- Positioning (`02-positioning.md`) is approved
- Client profile is complete (brand voice, content rules, CTAs)
- You're ready to generate ALL articles for the pillar

Do NOT use when:
- Missing prerequisites (brief, positioning, profile)
- You only need one article (use seo-writer agent directly)
- You need to revise positioning or brief

---

## Prerequisites Check

**Before starting execution, verify ALL prerequisites exist:**

```
PREREQUISITES CHECKLIST

Project Structure:
[ ] PROJECT-TASKS.md exists in project root
[ ] Client profile exists: clients/{client}/profile.md
[ ] Keyword brief exists: 00-keyword-brief.md

Pillar Status (check Production Queue in keyword brief):
[ ] Pillar status is "🎯 Positioned" (ready for execution)
[ ] Previous pillars in queue are ✅ Complete (no skipping)

Pillar Files:
[ ] Pillar brief: {pillar}/01-pillar-brief.md
[ ] Positioning: {pillar}/02-positioning.md
[ ] Articles directory: {pillar}/articles/

Profile Sections (required):
[ ] Company information
[ ] Product/Service details
[ ] Target audience
[ ] Brand voice (complete with traits, spectrum, examples)
[ ] Content rules (avoided words, terminology)
[ ] Conversion elements (CTAs, lead magnets)
```

### Pillar Status Verification

Before executing, read the Production Queue table in `00-keyword-brief.md` and verify:

1. **Target pillar status:** Must be `🎯 Positioned` to execute
2. **Previous pillars:** All earlier priorities should be `✅ Complete` (pillars are designed to build on each other)

**Status values:** ⏳ Pending (no brief) → 📋 Brief (no positioning) → 🎯 Positioned (ready) → 🔄 In Progress → ✅ Complete

**If any prerequisite is missing:** Stop execution, report missing items to user, do NOT proceed.

---

## Step 1: Setup Error Tracking

Before generating any content, create GitHub infrastructure for error logging.

### 1.1 Create Pillar Branch

```bash
git checkout -b pillar/{pillar-name}
```

### 1.2 Create Error Tracking Issue

Create GitHub Issue with title: `🔴 Errors: {Pillar Name}`

**Issue Body:**
```markdown
Tracking errors for the {Pillar Name} pillar.

Errors are logged automatically. When the pillar completes, recurring patterns will be extracted to `common-mistakes.md`.

Related PR: #{pr-number}
```

### 1.3 Create Draft PR

Create Draft Pull Request with title: `📚 {Pillar Name}`

**PR Body:** List all articles as checkboxes, link to error tracking Issue, add `🤖 Generated with Claude Code` footer.

### 1.4 Context Architecture Communication

After creating the draft PR, proactively tell the user: how many articles × 4 agents = total spawns, that each agent runs in isolated context, and estimated execution time ({tier_count} tiers × ~5-10 min per tier).

---

## Step 2: Tier Analysis

Identify article dependencies from the pillar brief to determine execution order.

### Dependency Rules

- **Tier 1:** Articles with no internal link dependencies
- **Tier 2:** Articles that reference Tier 1 articles
- **Tier 3:** Articles that reference Tier 2 articles
- **Final Tier:** Pillar Guide (links to all articles, always last)

### How to Identify Tiers

1. Read the pillar brief's article list
2. Check positioning document for internal linking strategy
3. For each article: no links to other pillar articles = Tier 1; otherwise Tier = (highest tier of linked articles) + 1
4. Pillar guide is always Final Tier

### Tier Analysis Output

Document the tier analysis before execution:

```markdown
## Tier Analysis: {Pillar Name}

### Tier 1 (No Dependencies)
- Article 01: {title} - {primary keyword}
- Article 02: {title} - {primary keyword}

### Tier 2 (Depends on Tier 1)
- Article 04: {title} - Links to: 01, 02

### Final Tier (Pillar Guide)
- Article NN: {pillar guide title} - Links to: all articles
```

---

## Step 2B: Pre-Execution Tier Validation (Automated)

Before spawning any agents, validate the tier structure automatically.

### Validation Checks

1. **Completeness:** All articles from pillar brief are assigned to a tier
2. **No Orphans:** Every article appears in exactly one tier
3. **Dependency Validity:** Tier N+1 articles only reference articles in Tiers 1 through N
4. **No Circular References:** Article A links to Article B which links back to Article A
5. **Tier 1 Identified:** At least 1 article has no dependencies

### Error Output Format

If validation fails:

```
❌ Tier Validation FAILED

Issues found:
1. {description of each issue}

EXECUTION BLOCKED. Fix tier structure before proceeding.
```

If validation passes:

```
✅ Tier Validation PASSED

Tier Structure:
- Tier 1: Articles 01, 02 (no dependencies) → {agent count} agents
- Tier 2: Articles 03, 04 (depend on Tier 1) → {agent count} agents
- Final: Article 05 (pillar guide) → 4 agents

Total: {total} agent spawns across {tier_count} tiers
Proceeding to execution...
```

---

## Step 3: Tier-Based Parallel Execution

Execute articles in tiers. Parallel within tiers, sequential across tiers.

### Spawning Articles in Parallel

When spawning multiple articles in the same tier:

1. **Spawn all seo-writer agents in parallel** (one per article)
2. Wait for ALL to return
3. **Spawn all copy-enhancer agents in parallel**
4. Wait for ALL to return
5. **Spawn all content-validator agents in parallel**
6. Wait for ALL to return
7. Handle retries for any FAILs (see Step 4)
8. **Spawn all content-atomizer agents in parallel**
9. Wait for ALL to return
10. Commit the tier

**Important:** You can spawn multiple agents in the same message using multiple Task tool calls. This maximises parallelism.

### Single Article Pipeline

Each article goes through 4 agents, spawned sequentially by the main session:

1. **SEO Writer** → receives file path + status + word count. If FAIL: log error, skip article.
2. **Copy Enhancer** (Enhancement Mode) → receives status + changes. If FAIL: log error, continue to validation.
3. **Content Validator** → receives PASS/FAIL + issues. If PASS: continue to atomiser. If FAIL: enter retry loop (Step 4).
4. **Content Atomiser** → receives status + files created. If FAIL: log error, mark article complete anyway.

---

## Step 4: Retry Loop

When validation fails, the main session orchestrates a retry loop. Maximum 3 attempts per article.

### Retry Flow

On validator FAIL (attempt N < 3):

1. Spawn **Copy Fixer** with article path + validation file path
2. Copy Fixer reads the validation file itself (file-based, not prompt-based)
3. Wait for Copy Fixer to return PASS
4. Spawn **Content Validator** again
5. If PASS → continue to atomiser. If FAIL → increment N, repeat.

On attempt N >= 3:

1. Log to PROJECT-TASKS.md: "Article {slug} failed validation after 3 attempts"
2. Log to GitHub Issue with full issue list
3. Continue with remaining articles (don't block the pillar)

### Passing Issues to Copy Fixer

**File-based approach (prevents context overflow):**

The Content Validator writes issues to a validation file at `{pillar}/articles/{slug}-validation.md`. The main session passes only the **validation file path** to Copy Fixer. Copy Fixer reads the file itself. Do NOT paste validation output into the prompt.

```
Task: Fix validation issues in {article_path}
Validation file: {validation_file_path}
```

---

## Step 5: Error Logging

All errors are logged to the GitHub Issue created in Step 1.

### Error Log Format

Add a comment to the Issue for each error:

```markdown
**[Error Type]** {message}
```

### Error Types

- **`Validation FAIL`** — Content validator returns FAIL
- **`Git Error`** — Any git operation fails
- **`Agent FAIL`** — Any agent fails to complete
- **`Retry Exhausted`** — Article failed after 3 retry attempts

---

## Step 6: Commit/PR Workflow

### Commit After Each Tier

After all articles in a tier pass validation and atomisation:

```bash
git add {pillar}/articles/*.md {pillar}/distribution/**/*
git commit -m "$(cat <<'EOF'
✅ Tier {N}: {Pillar Name} - {article count} articles

Articles: {slug-1}, {slug-2}, ...

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
git push origin pillar/{pillar-name}
```

### After Final Tier (Pillar Guide)

1. Commit the pillar guide
2. Run post-pillar linking pass (Step 7)
3. Commit linking updates
4. Convert Draft PR to Ready for Review

```bash
git commit -m "$(cat <<'EOF'
✅ Complete: {Pillar Name} pillar guide

Total articles: {count} | Words: {sum} | Distribution: {count} files

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
git push origin pillar/{pillar-name}
```

### PR Ready Checklist

Before converting to Ready for Review:

```
[ ] All articles pass validation
[ ] All distribution content created
[ ] Post-pillar linking complete
[ ] No placeholder links remain (<!-- LINK NEEDED: ... -->)
[ ] Error tracking issue reviewed
[ ] Common mistakes extracted (if any)
[ ] Pillar status updated to ✅ Complete in 00-keyword-brief.md
```

### Update Pillar Status

After pillar execution completes, update the Production Queue table in `00-keyword-brief.md`:

- `🎯 Positioned` → `🔄 In Progress` (when execution starts)
- `🔄 In Progress` → `✅ Complete` (when PR is ready for review)

---

## Step 7: Post-Pillar Linking Pass

After the pillar guide is written, run a linking pass to complete internal links.

### Linking Tasks

1. **Replace Placeholders:** Find all `<!-- LINK NEEDED: ... -->` comments and replace with actual links
2. **Add Links TO Pillar Guide:** Update each supporting article to link to the pillar guide where appropriate
3. **Verify All Links:** Check that no broken links exist

### Link Format

```markdown
For a complete overview, see our [comprehensive guide to {topic}]({pillar-guide-slug}).
```

### Update Frontmatter

After adding links, update each article's frontmatter:

```yaml
internal_links:
  - slug: "{linked-article-slug}"
    context: "{why this link exists}"
```

---

## Step 8: Learning Loop

After pillar completion, extract patterns from errors to improve future content.

### Review Error Log

1. Open the GitHub Issue for this pillar
2. Review all logged errors
3. Identify patterns (same error 3+ times)

### Extract Patterns

For each pattern with 3+ occurrences, add to `common-mistakes.md`:

```markdown
### {Pattern Name} (Issue #{number})

**Pattern:** What to look for
**Why it fails:** Explanation
**Fix:** How to correct
**Source:** {pillar name} — {count} occurrences
```

### Close the Issue

Close the GitHub Issue with a summary: total errors logged, patterns extracted, additions to common-mistakes.md.

---

## Quick Reference: Agent Invocation

### SEO Writer

```
Task: Write article for keyword "{keyword}"

Inputs:
- Profile: {profile_path}
- Positioning: {positioning_path}
- Brief: {brief_path}
- Keyword: {primary_keyword}
- Slug: {article_slug}
- Article Number: {NN}
```

### Copy Enhancer (Enhancement Mode)

```
Task: Enhance article at {article_path}
Mode: Enhancement
```

### Copy Fixer

```
Task: Fix validation issues in {article_path}
Validation file: {validation_file_path}
```

Copy Fixer reads the validation file itself. Do NOT paste issues into the prompt.

### Content Validator

```
Task: Validate article at {article_path}
```

### Content Atomiser

```
Task: Create distribution content for {article_path}
```

---

## Troubleshooting

See [Execute Pillar Troubleshooting](../../references/execute-pillar-troubleshooting.md).

---

*This skill is the single source of truth for pillar execution. The main session follows these steps exactly. Agents do NOT orchestrate each other—all coordination happens here.*
