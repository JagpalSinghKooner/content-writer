# Audit Pillar Skill Specification

Re-validate existing articles against current universal-rules.md and common-mistakes.md, then auto-fix issues using the copy-enhancer agent.

---

## Invocation

```
/audit-pillar {pillar-name}           # Validate only
/audit-pillar {pillar-name} --fix     # Validate + auto-fix
/audit-pillar --all                   # All pillars, validate only
/audit-pillar --all --fix             # All pillars, validate + fix
```

---

## Scope

4 pillars, 29 articles:
- adhd-sleep: 7 articles
- autistic-meltdowns: 7 articles
- calming-sounds: 7 articles
- sensory-overload: 8 articles

---

## Workflow

### Phase 1: Discovery

1. Verify pillar exists at `projects/hushaway/seo-content/{pillar}/articles/`
2. Glob all `.md` files, sort by number
3. Load client profile from `clients/hushaway/profile.md`

### Phase 2: Parallel Validation

1. Spawn content-validator agents IN PARALLEL for all articles
2. Each agent reads: article, universal-rules, common-mistakes, profile
3. Returns: `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}`
4. Writes `{slug}.validation.md` on FAIL

### Phase 3: Aggregation

1. Collect all returns
2. Read validation files for FAILs
3. Categorise issues by type
4. Identify patterns (3+ occurrences)
5. Write `{pillar}/audit-summary.md`

### Phase 4: Auto-Fix (if --fix)

For each FAIL:
1. Spawn copy-enhancer with article_path + validation_file_path
2. Spawn content-validator again
3. PASS: delete validation file
4. FAIL: retry (max 3)
5. After 3 failures: mark "Escalated"

### Phase 5: Report

1. Output summary to user
2. List escalated articles
3. Suggest patterns for common-mistakes.md

---

## Agent Returns

| Agent | PASS | FAIL |
|-------|------|------|
| content-validator | `PASS` | `FAIL, {fail}, {warn}, {path}` |
| copy-enhancer | `PASS` | `FAIL: {reason}` |

---

## Audit Summary Format

Written to `{pillar}/audit-summary.md`:

```markdown
# Pillar Audit: {Name}

**Date:** YYYY-MM-DD
**Articles:** N
**Status:** PASS | PARTIAL | FAIL

## Results

| # | Article | Status | FAILs | WARNs |
|---|---------|--------|-------|-------|
| 01 | slug | PASS | 0 | 1 |
| 02 | slug | FAIL | 3 | 2 |

## Issue Categories

| Category | Count | Articles |
|----------|-------|----------|
| Banned AI Words | 12 | 01, 03, 07 |
| Em Dashes | 8 | 02, 05 |

## Patterns (3+ occurrences)

### [Pattern Name]
- Articles: 01, 03, 05
- Count: 7
- Recommend for common-mistakes.md: Yes

## Fix Results (if --fix)

| Article | Attempts | Final | Notes |
|---------|----------|-------|-------|
| 01-slug | 1 | PASS | - |
| 03-slug | 3 | FAIL | Escalated |
```

---

## Reference Files

- `.claude/rules/universal-rules.md` - Validation checks
- `.claude/rules/common-mistakes.md` - Learned patterns
- `.claude/agents/content-validator.md` - Agent spec
- `.claude/agents/copy-enhancer.md` - Agent spec
- `.claude/skills/execute-pillar/SKILL.md` - Orchestration pattern
- `clients/hushaway/profile.md` - Brand voice
