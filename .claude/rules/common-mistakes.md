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
