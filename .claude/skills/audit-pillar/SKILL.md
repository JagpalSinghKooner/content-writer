---
name: audit-pillar
description: "Re-validate existing pillar content against current universal-rules.md and common-mistakes.md, check link integrity and citation URLs, then auto-fix issues using the copy-enhancer agent. Triggers on: audit pillar, validate pillar, re-validate pillar, check pillar quality, /audit-pillar. Outputs: audit-summary.md with full results per pillar."
---

# Audit Pillar

Orchestration playbook for the main session. NOT an agent.

---

## When to Use

Use `/audit-pillar` when:
- A pillar is complete and you want to re-validate against current rules
- Universal rules or common mistakes have been updated since content was written
- You suspect link rot or broken citations

Do NOT use when:
- Content hasn't been written yet (use `/execute-pillar`)
- You only need to validate a single article (use content-validator agent directly)

---

## Invocation

```
/audit-pillar {pillar-name}           # Validate only (single pillar)
/audit-pillar {pillar-name} --fix     # Validate + auto-fix (single pillar)
/audit-pillar --all                   # All pillars, validate only
/audit-pillar --all --fix             # All pillars, validate + fix
```

---

## Critical Constraints

1. **Agents cannot spawn agents** — Main session orchestrates ALL agent spawning
2. **File-based communication** — Pass file paths, not content (prevents context overflow)
3. **Parallel validation** — Spawn all validators for a pillar simultaneously
4. **Max 3 retry attempts** — Per article validation failure before escalation
5. **Link/citation issues cannot auto-fix** — Always escalated for manual review
6. **Cross-article consistency runs as consistency-checker agent** — Offloaded to its own context window to avoid main session overflow

---

## Phase 1: Discovery

1. Parse invocation arguments (`{pillar-name}`, `--all`, `--fix`)
2. Verify pillar exists: `projects/hushaway/seo-content/{pillar}/articles/`
3. Glob `{pillar}/articles/*.md` (exclude `.validation.md`), sort by number prefix
4. Identify pillar guide (highest numbered article)
5. Load context: `clients/hushaway/profile.md`, `{pillar}/02-positioning.md`

**For `--all`, process pillars sequentially** (parallel exhausts context):
adhd-sleep, autistic-meltdowns, sensory-overload, calming-sounds, emotional-regulation, bedtime-routines, sound-therapy, app-comparisons

Output discovery summary to user before proceeding.

---

## Phase 2: Parallel Validation

Spawn one `content-validator` agent per article, all in parallel.

**Per agent:**
```
subagent_type: content-validator

Task: Validate article at {article_path}

Inputs:
- Article path: projects/hushaway/seo-content/{pillar}/articles/{filename}
- Client profile: clients/hushaway/profile.md
- Positioning: projects/hushaway/seo-content/{pillar}/02-positioning.md
- Content type: Article

Expected Return: PASS or FAIL, {fail_count}, {warn_count}, {validation_file_path}
```

> For validator check details, see `.claude/agents/content-validator.md`

**After all return:** Build results map. Store FAIL validation file paths for Phase 7.

---

## Phase 3: Link Audit

Spawn one `link-auditor` agent for the pillar.

```
subagent_type: link-auditor

Task: Audit internal links for pillar at {pillar_path}

Inputs:
- Pillar path: projects/hushaway/seo-content/{pillar}
- All pillar paths: [all 8 pillar directories]

Expected Return: PASS or FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md
```

> For link-auditor check details, see `.claude/agents/link-auditor.md`

---

## Phase 4: Citation URL Validation

Runs in main session via Bash (no agent needed).

1. Extract URLs from frontmatter `external_citations` and grep markdown links with `http`
2. De-duplicate, mapping each URL to its source articles
3. Batch HTTP HEAD requests (max 10 parallel):
   ```bash
   curl -s -o /dev/null -w "%{http_code}|%{url_effective}|%{redirect_url}\n" -L -m 10 -I "{url}"
   ```
4. Parse responses:
   - 200 = PASS
   - 301/302 = WARN (capture redirect URL)
   - 403 = Retry with GET before marking WARN
   - 404/5xx = FAIL
   - Timeout = WARN
5. Check domain frequency (>2 citations from same domain in one article = WARN)
6. Map results back to articles

---

## Phase 5: Cross-Article Consistency

Spawn one `consistency-checker` agent for the pillar.

```
subagent_type: consistency-checker

Task: Check cross-article consistency for pillar at {pillar_path}

Inputs:
- Pillar path: projects/hushaway/seo-content/{pillar}
- Client profile: clients/hushaway/profile.md
- Positioning: projects/hushaway/seo-content/{pillar}/02-positioning.md

Expected Return: PASS or FAIL, {term_issues}, {claim_issues}, {alignment_issues}, {pillar}/consistency-check.md
```

> For consistency-checker check details, see `.claude/agents/consistency-checker.md`

---

## Phase 6: Aggregation

Compile all results into `{pillar}/audit-summary.md`.

1. Collect validation returns (PASS/FAIL + counts)
2. Merge link audit findings
3. Merge citation URL results
4. Read `{pillar}/consistency-check.md` for cross-article findings (if consistency-checker returned FAIL)
5. Categorise issues by type
6. Identify patterns (3+ occurrences)
7. Write audit-summary.md

> For output format, see `templates/audit-summary-template.md`

---

## Phase 7: Auto-Fix (if --fix)

**Only runs if `--fix` flag was provided.** Otherwise skip to Phase 8.

### What CAN be auto-fixed

Banned AI words, em dashes, UK spelling, AI patterns, frontmatter accuracy, brand voice issues.

### What CANNOT be auto-fixed (escalate immediately)

Broken internal links, stale placeholders, missing bidirectional links, incorrect URL format, citation URL errors, cross-article consistency, positioning misalignment.

### Fix loop

For each FAIL article, run the retry loop (max 3 attempts per article):

> For retry loop flow diagram, see `rules/workflow.md` > Retry Loop

**Copy Enhancer invocation (per article):**
```
subagent_type: copy-enhancer

Task: Fix validation issues in {article_path}

Mode: Fix
Article path: {article_path}
Validation file path: {validation_file_path}

The validation file contains all FAIL issues with line numbers. Read it and fix each issue.

Expected Return: PASS or FAIL: {reason}
```

**Parallel fix execution:** Spawn all copy-enhancer agents in parallel (one per FAIL article), wait, then spawn all validators in parallel, wait, check results. Repeat until all PASS or all hit 3 attempts.

**After 3 failures:** Mark as "Escalated", log to audit-summary.md, continue with remaining articles.

---

## Phase 8: Report

1. Output summary to user
2. List all escalated articles with reasons
3. List link/citation issues requiring manual fix
4. Suggest patterns for common-mistakes.md (3+ occurrences)

> For user output formats (validate-only and --fix), see `templates/audit-summary-template.md`

When `--fix` is used, append Fix Results section to audit-summary.md.

> For fix results format, see `templates/audit-summary-template.md` > Fix Results Section

---

## Multi-Pillar (--all)

Run Phase 1-8 sequentially for each pillar. After each pillar, output progress:
```
✅ Pillar 1/8: adhd-sleep — PARTIAL (5/7 PASS, 2 escalated)
🔄 Starting pillar 2/8: autistic-meltdowns...
```

After all pillars complete, output cross-pillar summary table.

> For summary format, see `templates/audit-summary-template.md`

---

## Error Handling

| Scenario | Action |
|----------|--------|
| Article validation FAIL | Store issues, continue to next article |
| Link audit FAIL | Store issues, continue to Phase 4 |
| Citation URL unreachable | Mark as FAIL, continue checking others |
| Copy-enhancer FAIL | Log error, mark article as "Escalated" |
| 3 retry attempts exhausted | Mark as "Escalated", continue with other articles |
| Missing positioning.md | Skip positioning alignment check, WARN |
| Empty pillar (no articles) | Return error: "No articles found in pillar" |
| Curl timeout on citation | Mark as WARN, continue |
| 403 on HEAD request | Retry with GET before marking as WARN |
| Agent spawn failure | Log error, continue with next agent |

---

## Git Workflow

### After Successful --fix

```bash
git add {pillar}/articles/*.md
git add {pillar}/audit-summary.md

git commit -m "$(cat <<'EOF'
🔍 Audit Fix: {Pillar Name}

Fixed {count} articles against current validation rules.
Escalated {count} articles for manual review.

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"

git push
```

### What NOT to Commit

- `.validation.md` files (temporary, deleted on PASS)
- `link-audit.md` (reference only)
- `audit-summary.md` — DO commit (audit trail)

---

## Reference Files

- `rules/universal-rules.md` — Validation checks
- `rules/common-mistakes.md` — Learned patterns
- `rules/workflow.md` — Orchestration patterns, retry loop, agent return formats
- `agents/content-validator.md` — Validation agent spec
- `agents/copy-enhancer.md` — Auto-fix agent spec
- `agents/link-auditor.md` — Link audit agent spec
- `agents/consistency-checker.md` — Cross-article consistency agent spec
- `skills/audit-pillar/templates/audit-summary-template.md` — Output format templates
- `clients/hushaway/profile.md` — Brand voice
