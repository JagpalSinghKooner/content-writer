---
name: audit-pillar
description: "Re-validate existing pillar content against current rules, check link integrity and citation URLs, then auto-fix issues. Triggers on: audit pillar, validate pillar, re-validate pillar, /audit-pillar. Outputs: audit-summary.md."
---

# Audit Pillar

Orchestration playbook for the main session. NOT an agent.

---

## When to Use

- Re-validate a complete pillar against current rules
- Universal rules or common mistakes updated since content was written
- Suspect link rot or broken citations

Do NOT use for unwritten content (`/execute-pillar`) or single articles (content-validator agent directly).

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
2. **File-based communication** — Pass file paths, not content
3. **Parallel validation** — Spawn all validators for a pillar simultaneously
4. **Max 3 retry attempts** — Per article validation failure before escalation
5. **Link/citation issues cannot auto-fix** — Always escalated for manual review
6. **Cross-article consistency runs as consistency-checker agent** — Offloaded to own context window

---

## Phase 1: Discovery

1. Parse invocation arguments (`{pillar-name}`, `--all`, `--fix`)
2. Verify pillar exists: `projects/hushaway/seo-content/{pillar}/articles/`
3. Glob `{pillar}/articles/*.md` (exclude `.validation.md`), sort by number prefix
4. Identify pillar guide (highest numbered article)
5. Load context: `clients/hushaway/profile.md`, `{pillar}/02-positioning.md`

**For `--all`, process pillars sequentially** (parallel exhausts context).

Output discovery summary to user before proceeding.

---

## Phase 2: Parallel Validation

Spawn one `content-validator` agent per article, all in parallel.

**Per agent:** `subagent_type: content-validator`
- Article path: `{pillar}/articles/{filename}`
- Client profile: `clients/hushaway/profile.md`
- Positioning: `{pillar}/02-positioning.md`
- Content type: Article
- Expected return: `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}`

After all return: Build results map. Store FAIL validation file paths for Phase 7.

---

## Phase 3: Link Audit

Spawn one `link-auditor` agent for the pillar.

**Agent:** `subagent_type: link-auditor`
- Pillar path: `{pillar}`
- All pillar paths: [all 8 pillar directories]
- Expected return: `PASS` or `FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md`

---

## Phase 4: Citation URL Validation

Runs in main session via Bash (no agent needed).

1. Extract URLs from frontmatter `external_citations` and grep markdown links with `http`
2. De-duplicate, mapping each URL to source articles
3. Batch HTTP HEAD requests (max 10 parallel):
   ```bash
   curl -s -o /dev/null -w "%{http_code}|%{url_effective}|%{redirect_url}\n" -L -m 10 -I "{url}"
   ```
4. Parse responses: 200=PASS, 301/302=WARN (capture redirect), 403=retry GET before WARN, 404/5xx=FAIL, timeout=WARN
5. Check domain frequency (>2 citations from same domain in one article = WARN)
6. Map results back to articles

---

## Phase 5: Cross-Article Consistency

Spawn one `consistency-checker` agent for the pillar.

**Agent:** `subagent_type: consistency-checker`
- Pillar path: `{pillar}`
- Client profile: `clients/hushaway/profile.md`
- Positioning: `{pillar}/02-positioning.md`
- Expected return: `PASS` or `FAIL, {term_issues}, {claim_issues}, {alignment_issues}, {pillar}/consistency-check.md`

---

## Phase 6: Aggregation

Compile all results into `{pillar}/audit-summary.md`.

1. Collect validation returns (PASS/FAIL + counts)
2. Merge link audit findings
3. Merge citation URL results
4. Read `{pillar}/consistency-check.md` for cross-article findings (if FAIL)
5. Categorise issues by type
6. Identify patterns (3+ occurrences)
7. Write audit-summary.md

> For output format, see `templates/audit-summary-template.md`

---

## Phase 7: Auto-Fix (if --fix)

**Only runs if `--fix` flag was provided.** Otherwise skip to Phase 8.

**Can auto-fix:** Banned AI words, em dashes, UK spelling, AI patterns, frontmatter accuracy, brand voice issues.

**Cannot auto-fix (escalate):** Broken internal links, stale placeholders, missing bidirectional links, incorrect URL format, citation URL errors, cross-article consistency, positioning misalignment.

### Fix loop

For each FAIL article, run the retry loop (max 3 attempts per article). See `rules/workflow.md` > Retry Loop.

**Copy Enhancer invocation (per article):** `subagent_type: copy-enhancer`
- Mode: Fix
- Article path: `{article_path}`
- Validation file path: `{validation_file_path}`
- Read validation file and fix each issue
- Expected return: `PASS` or `FAIL: {reason}`

**Parallel execution:** Spawn all copy-enhancer agents in parallel (one per FAIL article), wait, then spawn all validators in parallel, check results. Repeat until all PASS or 3 attempts hit.

**After 3 failures:** Mark as "Escalated", log to audit-summary.md, continue with remaining articles.

---

## Phase 8: Report

1. Output summary to user
2. List all escalated articles with reasons
3. List link/citation issues requiring manual fix
4. Suggest patterns for common-mistakes.md (3+ occurrences)

When `--fix` is used, append Fix Results section to audit-summary.md. See `templates/audit-summary-template.md`.

---

## Multi-Pillar (--all)

Run Phase 1-8 sequentially for each pillar. After each pillar, output progress:
```
✅ Pillar 1/8: adhd-sleep — PARTIAL (5/7 PASS, 2 escalated)
🔄 Starting pillar 2/8: autistic-meltdowns...
```

After all pillars complete, output cross-pillar summary table. See `templates/audit-summary-template.md`.

---

## Error Handling

- **Article validation FAIL** — Store issues, continue to next article
- **Link audit FAIL** — Store issues, continue to Phase 4
- **Citation URL unreachable** — Mark as FAIL, continue checking others
- **Copy-enhancer FAIL** — Log error, mark article as "Escalated"
- **3 retry attempts exhausted** — Mark as "Escalated", continue with other articles
- **Missing positioning.md** — Skip positioning alignment check, WARN
- **Empty pillar (no articles)** — Return error: "No articles found in pillar"
- **Curl timeout on citation** — Mark as WARN, continue
- **403 on HEAD request** — Retry with GET before marking as WARN
- **Agent spawn failure** — Log error, continue with next agent

---

## Git Workflow

### After Successful --fix

Stage `{pillar}/articles/*.md` and `{pillar}/audit-summary.md`. Commit:
```
🔍 Audit Fix: {Pillar Name}

Fixed {count} articles against current validation rules.
Escalated {count} articles for manual review.
```

**Do NOT commit:** `.validation.md` files (temporary), `link-audit.md` (reference only). DO commit `audit-summary.md` (audit trail).

---

## Reference Files

- `rules/universal-rules.md` — Validation checks
- `references/common-mistakes.md` — Learned patterns
- `rules/workflow.md` — Orchestration patterns, retry loop
- `agents/content-validator.md`, `agents/copy-enhancer.md`, `agents/link-auditor.md`, `agents/consistency-checker.md`
- `skills/audit-pillar/templates/audit-summary-template.md` — Output format
- `clients/hushaway/profile.md` — Brand voice
