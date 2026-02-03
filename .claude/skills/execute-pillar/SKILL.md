---
name: execute-pillar
description: "Execute full pillar content generation workflow. Use when ready to generate all articles for a pillar after positioning is complete. Orchestrates seo-writer, copy-enhancer, content-validator, and content-atomizer agents in tier-based parallel execution. Triggers on: execute pillar, run pillar, generate pillar content, /execute-pillar. Outputs: Complete pillar with articles, distribution content, and PR."
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

**If any prerequisite is missing:**
1. Stop execution
2. Report missing items to user
3. Do NOT proceed until all prerequisites pass

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

**PR Body:**
```markdown
## Pillar: {Pillar Name}

### Articles
- [ ] Article 01: {title}
- [ ] Article 02: {title}
...

### Error Tracking
Issue: #{issue-number}

---

🤖 Generated with Claude Code
```

---

## Step 2: Tier Analysis

Identify article dependencies from the pillar brief to determine execution order.

### Dependency Rules

| Article Type | Links To | Tier |
|--------------|----------|------|
| Articles with no internal link dependencies | Nothing | Tier 1 |
| Articles that reference Tier 1 articles | Tier 1 | Tier 2 |
| Articles that reference Tier 2 articles | Tier 2 | Tier 3 |
| Pillar Guide (links to all articles) | All articles | Final Tier |

### How to Identify Tiers

1. Read the pillar brief's article list
2. Check positioning document for internal linking strategy
3. For each article, ask: "Does this need to link to any other article in the pillar?"
4. If no: Tier 1
5. If yes: Tier = (highest tier of articles it links to) + 1
6. Pillar guide is always Final Tier

### Tier Analysis Output

Document the tier analysis before execution:

```markdown
## Tier Analysis: {Pillar Name}

### Tier 1 (No Dependencies)
- Article 01: {title} - {primary keyword}
- Article 02: {title} - {primary keyword}
- Article 03: {title} - {primary keyword}

### Tier 2 (Depends on Tier 1)
- Article 04: {title} - Links to: 01, 02
- Article 05: {title} - Links to: 03

### Final Tier (Pillar Guide)
- Article NN: {pillar guide title} - Links to: all articles
```

---

## Step 3: Tier-Based Parallel Execution

Execute articles in tiers. Parallel within tiers, sequential across tiers.

### Execution Pattern

```
Main Session (Orchestrator)
    │
    ├─→ TIER 1: All articles in parallel
    │   │
    │   ├─→ Article 01 pipeline ─┐
    │   ├─→ Article 02 pipeline ─┼─→ All PASS → commit tier
    │   └─→ Article 03 pipeline ─┘
    │
    ├─→ TIER 2: All articles in parallel (after Tier 1 committed)
    │   │
    │   ├─→ Article 04 pipeline ─┐
    │   └─→ Article 05 pipeline ─┴─→ All PASS → commit tier
    │
    └─→ FINAL TIER: Pillar Guide (after all articles committed)
        │
        └─→ Pillar guide pipeline → commit → convert PR to ready
```

### Single Article Pipeline

Each article goes through 4 agents, spawned sequentially by the main session:

```
Article Pipeline (main session orchestrates)
    │
    ├─→ 1. SEO WRITER AGENT
    │       Input: Profile path, positioning path, brief path, keyword, slug
    │       Output: PASS/FAIL + file path + word count + citations
    │       └─→ If FAIL: Log error, skip to next article
    │
    ├─→ 2. COPY ENHANCER AGENT (Enhancement Mode)
    │       Input: Article path
    │       Output: PASS/FAIL + changes made
    │       └─→ If FAIL: Log error, continue to validation
    │
    ├─→ 3. CONTENT VALIDATOR AGENT
    │       Input: Article path
    │       Output: PASS/FAIL + FULL issues list
    │       └─→ If PASS: Continue to atomizer
    │       └─→ If FAIL: Enter retry loop (see Step 4)
    │
    └─→ 4. CONTENT ATOMIZER AGENT
            Input: Article path
            Output: PASS/FAIL + files created + platform summary
            └─→ If FAIL: Log error, mark article complete anyway
```

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

**Important:** You can spawn multiple agents in the same message using multiple Task tool calls. This maximizes parallelism.

---

## Step 4: Retry Loop

When validation fails, the main session orchestrates a retry loop. Maximum 3 attempts per article.

### Retry Flow

```
Main session receives FAIL from Validator (attempt N)
    │
    ├─ If N < 3:
    │   │
    │   ├─→ Extract FAIL issues from validator output
    │   │
    │   ├─→ Spawn COPY ENHANCER (Fix Mode) with:
    │   │     - Article path
    │   │     - List of specific FAIL issues
    │   │
    │   ├─→ Wait for Copy Enhancer to return PASS
    │   │
    │   ├─→ Spawn CONTENT VALIDATOR again
    │   │
    │   └─→ If PASS → Continue to atomizer
    │       If FAIL → Increment N, repeat loop
    │
    └─ If N >= 3:
        │
        ├─→ Log to PROJECT-TASKS.md: "Article {slug} failed validation after 3 attempts"
        ├─→ Log to GitHub Issue with full issue list
        └─→ Continue with remaining articles (don't block the pillar)
```

### Passing Issues to Copy Enhancer (Fix Mode)

When spawning copy-enhancer for fixes, include the FULL validation output:

```
Mode: Fix

Article: {path}

FAIL Issues to Fix:
1. Line 23: "color" - US spelling → use "colour"
2. Line 45: "leverage" - banned AI word → use "use"
3. Line 67: Em dash found - restructure sentence
...
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

| Type | When |
|------|------|
| `Validation FAIL` | Content validator returns FAIL |
| `Git Error` | Any git operation fails |
| `Agent FAIL` | Any agent fails to complete |
| `Retry Exhausted` | Article failed after 3 retry attempts |

### Example Error Comments

```markdown
**[Validation FAIL]** Article: 01-understanding-adhd-sleep.md
- Line 23: "color" - US spelling → use "colour"
- Line 45: "leverage" - banned AI word
```

```markdown
**[Retry Exhausted]** Article: 03-sleep-hygiene-tips.md
Failed validation 3 times. Remaining issues:
- Line 12: H1 missing hook (keyword-only)
- Line 89: Em dash in paragraph 5
```

```markdown
**[Agent FAIL]** seo-writer failed for article 05-white-noise-benefits.md
Reason: Missing positioning angle for this keyword
```

---

## Step 6: Commit/PR Workflow

### Commit After Each Tier

After all articles in a tier pass validation and atomization:

```bash
# Stage all files in the pillar
git add {pillar}/articles/*.md
git add {pillar}/distribution/**/*

# Commit with tier information
git commit -m "$(cat <<'EOF'
✅ Tier {N}: {Pillar Name} - {article count} articles

Articles:
- {slug-1}
- {slug-2}
- ...

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

# Push to pillar branch
git push origin pillar/{pillar-name}
```

### After Final Tier (Pillar Guide)

1. Commit the pillar guide
2. Run post-pillar linking pass (Step 7)
3. Commit linking updates
4. Convert Draft PR to Ready for Review

```bash
# Final commit
git commit -m "$(cat <<'EOF'
✅ Complete: {Pillar Name} pillar guide

Total articles: {count}
Total word count: {sum}
Distribution assets: {count} files

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
```

---

## Step 7: Post-Pillar Linking Pass

After the pillar guide is written, run a linking pass to complete internal links.

### Linking Tasks

1. **Replace Placeholders:** Find all `<!-- LINK NEEDED: ... -->` comments and replace with actual links

2. **Add Links TO Pillar Guide:** Update each supporting article to link to the pillar guide where appropriate

3. **Verify All Links:** Check that no broken links exist

### Placeholder Search

```bash
# Find all placeholder links
grep -r "LINK NEEDED" {pillar}/articles/
```

### Link Format

When adding internal links:

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

After extracting patterns, close the GitHub Issue with a summary:

```markdown
## Summary

- Total errors logged: {count}
- Patterns extracted: {count}
- Added to common-mistakes.md: {list pattern names}

Closing as pillar is complete.
```

---

## Complete Execution Checklist

Use this checklist to track pillar execution:

```markdown
## Pillar Execution: {Pillar Name}

### Setup
- [ ] Prerequisites verified
- [ ] Pillar branch created
- [ ] Error tracking Issue created
- [ ] Draft PR created

### Tier Analysis
- [ ] Dependencies identified
- [ ] Articles assigned to tiers
- [ ] Execution order documented

### Tier 1
- [ ] All articles written (seo-writer)
- [ ] All articles enhanced (copy-enhancer)
- [ ] All articles validated (content-validator)
- [ ] Retries completed (if needed)
- [ ] All articles atomized (content-atomizer)
- [ ] Tier committed

### Tier 2 (if applicable)
- [ ] Same as Tier 1...

### Final Tier (Pillar Guide)
- [ ] Pillar guide written
- [ ] Pillar guide enhanced
- [ ] Pillar guide validated
- [ ] Pillar guide atomized
- [ ] Post-pillar linking complete
- [ ] Final commit pushed

### Completion
- [ ] PR converted to Ready for Review
- [ ] Error patterns extracted
- [ ] GitHub Issue closed
- [ ] PROJECT-TASKS.md updated
```

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

Expected Output:
- Status: PASS/FAIL
- File Path: {path}
- Word Count: {count}
- Citations Found: {count}
```

### Copy Enhancer (Enhancement Mode)

```
Task: Enhance article at {article_path}

Mode: Enhancement

Expected Output:
- Status: PASS/FAIL
- Mode: Enhancement
- Changes Made: [list]
```

### Copy Enhancer (Fix Mode)

```
Task: Fix validation issues in {article_path}

Mode: Fix

FAIL Issues:
{paste full validation FAIL output}

Expected Output:
- Status: PASS/FAIL
- Mode: Fix
- Issues Fixed: [list]
```

### Content Validator

```
Task: Validate article at {article_path}

Expected Output:
- FULL validation output (never abbreviated)
- All 6 phases
- All FAIL/WARN issues with line numbers
```

### Content Atomizer

```
Task: Create distribution content for {article_path}

Expected Output:
- Status: PASS/FAIL
- Files Created: [list]
- Platform Summary: {counts}
```

---

## Troubleshooting

### Agent Not Spawning

If an agent doesn't auto-delegate:
1. Check that `.claude/agents/{agent}.md` exists
2. Verify YAML frontmatter is valid
3. Use explicit task description matching agent's `description` field

### Validation Loop Never Passes

If an article fails validation 3+ times:
1. Check if the FAIL issues are addressable by copy-enhancer
2. Some issues (e.g., fundamental structure problems) may need manual rewrite
3. Log the issue and continue with other articles
4. Return to problem article manually after pillar execution

### Git Conflicts

If git operations fail:
1. Check branch status: `git status`
2. Ensure you're on the pillar branch
3. Pull latest if needed: `git pull origin pillar/{name}`
4. Resolve conflicts manually if they occur

### Context Running Low

If main session context is getting full:
1. Complete current tier
2. Commit progress
3. Document current state in PROJECT-TASKS.md
4. Start fresh session with handoff context

---

*This skill is the single source of truth for pillar execution. The main session follows these steps exactly. Agents do NOT orchestrate each other—all coordination happens here.*
