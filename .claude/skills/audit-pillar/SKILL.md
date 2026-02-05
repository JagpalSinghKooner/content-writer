---
name: audit-pillar
description: "Re-validate existing pillar content against current universal-rules.md and common-mistakes.md, check link integrity and citation URLs, then auto-fix issues using the copy-enhancer agent. Triggers on: audit pillar, validate pillar, re-validate pillar, check pillar quality, /audit-pillar. Outputs: audit-summary.md with full results per pillar."
---

# Audit Pillar

This skill documents the **full pillar audit workflow** that the main session follows. It is NOT an agent. It is a playbook for orchestration.

**Critical Constraint:** Agents cannot spawn other agents. The main session orchestrates ALL agent spawning. This entire workflow runs from the main session.

---

## When to Use This Skill

Use `/audit-pillar` when:
- A pillar is complete and you want to re-validate against current rules
- Universal rules or common mistakes have been updated since content was written
- You suspect link rot or broken citations
- You want a quality baseline across all content

Do NOT use when:
- Content hasn't been written yet (use `/execute-pillar` instead)
- You only need to validate a single article (use content-validator agent directly)
- You're writing new content (this skill is for existing content only)

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

These constraints govern ALL audit operations:

1. **Agents cannot spawn agents** — Main session orchestrates ALL agent spawning
2. **File-based communication** — Pass file paths, not content (prevents context overflow)
3. **Parallel validation** — Spawn all validators for a pillar simultaneously
4. **Max 3 retry attempts** — Per article validation failure before escalation
5. **Link/citation issues cannot auto-fix** — Always escalated for manual review
6. **Cross-article consistency runs in main session** — Requires comparing multiple articles

---

## Phase 1: Discovery

**Purpose:** Identify articles to audit and load context files.

### Steps

1. **Parse invocation arguments:**
   - `{pillar-name}` — Single pillar audit
   - `--all` — All 8 pillars
   - `--fix` — Enable auto-fix mode (Phase 7)

2. **Verify pillar exists:**
   - Check `projects/hushaway/seo-content/{pillar}/articles/` exists
   - If `--all`, verify all pillar directories

3. **Find articles:**
   - Glob `{pillar}/articles/*.md` (exclude `.validation.md` files)
   - Sort by number prefix
   - Identify the pillar guide (highest numbered article)

4. **Load context files:**
   - Client profile: `clients/hushaway/profile.md`
   - Positioning: `{pillar}/02-positioning.md` (if exists)

5. **Build pillar list (for `--all`):**

```
Pillars to audit:
- adhd-sleep
- autistic-meltdowns
- sensory-overload
- calming-sounds
- emotional-regulation
- bedtime-routines
- sound-therapy
- app-comparisons
```

### Discovery Output

```
📂 Audit Discovery: {Pillar Name}

Articles found: {count}
- 01-{slug}.md (pillar guide: No)
- 02-{slug}.md (pillar guide: No)
...
- 07-{slug}.md (pillar guide: Yes)

Client profile: clients/hushaway/profile.md
Positioning: {pillar}/02-positioning.md

Mode: Validate Only | Validate + Auto-Fix

Proceeding to validation...
```

---

## Phase 2: Parallel Validation

**Purpose:** Validate all articles against universal rules and brand voice.

### Orchestration Pattern

```
Main session receives article list from Phase 1
    │
    ├─→ Spawn content-validator agents IN PARALLEL (all articles)
    │   │
    │   ├─→ Article 01 validator ─┐
    │   ├─→ Article 02 validator ─┼─→ Wait for ALL to return
    │   ├─→ Article 03 validator ─│
    │   └─→ ... (up to N)        ─┘
    │
    └─→ Collect all returns:
        - PASS articles → Mark as validated
        - FAIL articles → Store validation_file_path for Phase 7
```

### Agent Invocation (per Article)

Spawn one `content-validator` agent per article using the Task tool:

```
Task: Validate article at {article_path}

Inputs:
- Article path: projects/hushaway/seo-content/{pillar}/articles/{filename}
- Client profile: clients/hushaway/profile.md
- Positioning: projects/hushaway/seo-content/{pillar}/02-positioning.md
- Content type: Article

Expected Return: PASS or FAIL, {fail_count}, {warn_count}, {validation_file_path}
```

**Agent type:** `content-validator`

**What Content-Validator Checks (6 Phases):**

1. **Universal Rules:** UK English, banned words/phrases, AI patterns, em dashes, H1 validation, SEO requirements
2. **Client Profile:** Brand voice alignment, terminology, avoided topics
3. **Human Quality:** AI detection, natural flow, specific examples
4. **Schema Validation:** Frontmatter fields, slug format, word_count accuracy, keyword_density accuracy
5. **Readability Metrics:** Flesch-Kincaid, sentence length
6. **Pillar Consistency:** Angle alignment, internal linking, messaging

### Collecting Results

After all validators return, build a results map:

```
validation_results = {
    "01-{slug}.md": { status: "PASS" },
    "02-{slug}.md": { status: "FAIL", fails: 3, warns: 2, path: "02-{slug}.validation.md" },
    "03-{slug}.md": { status: "PASS" },
    ...
}
```

Store FAIL validation file paths for use in Phase 7 (auto-fix).

---

## Phase 3: Link Audit

**Purpose:** Check internal link integrity across the pillar.

### Orchestration

Spawn a single `link-auditor` agent for the pillar:

```
Task: Audit internal links for pillar at {pillar_path}

Inputs:
- Pillar path: projects/hushaway/seo-content/{pillar}
- All pillar paths: [
    projects/hushaway/seo-content/adhd-sleep,
    projects/hushaway/seo-content/autistic-meltdowns,
    projects/hushaway/seo-content/sensory-overload,
    projects/hushaway/seo-content/calming-sounds,
    projects/hushaway/seo-content/emotional-regulation,
    projects/hushaway/seo-content/bedtime-routines,
    projects/hushaway/seo-content/sound-therapy,
    projects/hushaway/seo-content/app-comparisons
  ]

Expected Return: PASS or FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md
```

**Agent type:** `link-auditor`

### What Link-Auditor Checks

| Check | Description | Severity |
|-------|-------------|----------|
| Broken internal links | href points to non-existent article | FAIL |
| Incorrect URL format | Link uses file path instead of `/{slug}` | FAIL |
| Stale placeholders | `<!-- LINK NEEDED: ... -->` for articles that now exist | FAIL |
| Valid placeholders | Placeholders for articles not yet published | INFO |
| Cross-pillar outbound | Links FROM this pillar TO other pillars | INFO |
| Cross-pillar inbound | Links FROM other pillars TO this pillar | INFO |
| Guide → Supporting | Pillar guide links to all supporting articles | FAIL if missing |
| Supporting → Guide | All supporting articles link back to pillar guide | FAIL if missing |

### Link Audit Returns

- `PASS` — No link issues found
- `FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md` — Issues found, full report written

---

## Phase 4: Citation URL Validation

**Purpose:** Verify all external citation URLs are working.

**Implementation:** Bash HTTP HEAD requests (not an agent). Simple HTTP checks don't need agent overhead.

### Steps

#### 4.1 Extract URLs

Read `external_citations` from all article frontmatter in the pillar. Also grep for citation URLs in article content (markdown link format with `http` prefix).

#### 4.2 De-duplicate

Same URL may appear in multiple articles. Build a map:

```
url_map = {
    "https://example.com/study": ["01-slug.md", "03-slug.md"],
    "https://example.com/other": ["02-slug.md"],
    ...
}
```

#### 4.3 Batch HTTP HEAD Requests

Run concurrent HTTP HEAD requests (max 10 parallel):

```bash
curl -s -o /dev/null -w "%{http_code}|%{url_effective}|%{redirect_url}\n" -L -m 10 -I "{url}"
```

Use `xargs -P 10` or a loop to process all URLs.

#### 4.4 Parse Responses

| Status | Result | Action |
|--------|--------|--------|
| 200 OK | PASS | No action needed |
| 301/302 Redirect | WARN | Capture new URL for manual update |
| 403 Forbidden | WARN | May block HEAD requests, try GET |
| 404 Not Found | FAIL | Broken citation, escalate |
| 500+ Server Error | FAIL | Broken citation, escalate |
| Timeout (>10s) | WARN | May be temporarily down |

#### 4.5 Domain Frequency Check

Check for over-citation from a single domain:

| Violation | Result |
|-----------|--------|
| >2 citations from same domain in one article | WARN |

#### 4.6 Map Results Back

Track which articles use which URLs so issues can be traced to specific articles.

### Citation Results Structure

```
citation_results = {
    working: [{ url, status: 200 }],
    redirects: [{ url, status: 301, new_url, articles: [...] }],
    broken: [{ url, status: 404, articles: [...] }],
    timeout: [{ url, articles: [...] }],
    domain_warnings: [{ domain, count, article }]
}
```

---

## Phase 5: Cross-Article Consistency

**Purpose:** Ensure consistency across all articles in the pillar.

**Runs in main session (not agent)** — requires comparing multiple articles simultaneously.

### 5.1 Terminology Consistency

1. Read `{pillar}/02-positioning.md`
2. Extract key terms from positioning document
3. Scan all articles for term variations
4. Flag inconsistencies

**Output format:**

```
| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| Brain activity | "racing mind", "racing thoughts" | 01, 03 | Standardise |
```

### 5.2 Conflicting Claims

1. Extract statistics, percentages, and specific recommendations from each article
2. Compare across articles
3. Flag contradictions

**Output format:**

```
| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| ADHD sleep % | "75%" vs "over half" | 01, 05 | Align to same source |
```

### 5.3 Positioning Alignment

1. Load assigned angle for each article from positioning.md
2. Check article intro/conclusion aligns with angle
3. Rate alignment: Strong / Moderate / Weak

**Output format:**

```
| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Parents blamed | Strong |
| 02 | Routine isn't enough | Weak |
```

---

## Phase 6: Aggregation

**Purpose:** Compile all results into a single audit summary.

### Steps

1. Collect all validation returns (PASS/FAIL + counts)
2. Merge link audit findings
3. Merge citation URL results
4. Add cross-article consistency findings
5. Categorise issues by type:
   - Banned AI Words
   - Em Dashes
   - UK Spelling
   - AI Patterns
   - Broken Internal Links
   - Incorrect URL Format
   - Stale Placeholders
   - Citation URL Errors
   - Frontmatter Mismatch
   - Positioning Misalignment
6. Identify patterns (3+ occurrences of same issue type)
7. Write `{pillar}/audit-summary.md`

### Audit Summary Format

Write to `{pillar}/audit-summary.md`:

```markdown
# Pillar Audit: {Name}

**Date:** YYYY-MM-DD
**Articles:** N
**Total Word Count:** {sum}
**Status:** PASS | PARTIAL | FAIL

---

## Article Results

| # | Article | Validation | Links | Citations | Frontmatter | Final |
|---|---------|------------|-------|-----------|-------------|-------|
| 01 | slug | PASS | PASS | PASS | PASS | PASS |
| 02 | slug | FAIL (2) | PASS | WARN (1) | PASS | FAIL |

---

## Issue Categories

| Category | FAILs | WARNs | Articles |
|----------|-------|-------|----------|
| Banned AI Words | 12 | 0 | 01, 03, 07 |
| Em Dashes | 8 | 0 | 02, 05 |
| Broken Internal Links | 2 | 0 | 02, 04 |
| Incorrect URL Format | 3 | 0 | 01, 03, 05 |
| Citation URL Errors | 0 | 4 | 01, 03, 05, 06 |
| Frontmatter Mismatch | 3 | 2 | 01, 02, 07 |

---

## Link Audit Summary

### Internal Links

| Check | Count | Status | Articles |
|-------|-------|--------|----------|
| Broken links | 0 | PASS | - |
| Incorrect URL format | 3 | FAIL | 01, 03, 05 |
| Stale placeholders | 2 | FAIL | 03, 05 |
| Valid placeholders | 0 | INFO | - |

### Cross-Pillar Links

| Direction | Count | Target Pillars |
|-----------|-------|----------------|
| Outbound | 4 | calming-sounds, sensory-overload |
| Inbound | 3 | autistic-meltdowns, bedtime-routines |

### Pillar Guide Coverage

| Check | Value | Status |
|-------|-------|--------|
| Guide → Supporting | 6/6 | PASS |
| Supporting → Guide | 4/6 | FAIL |

**Missing links TO pillar guide:**
- 02-{slug}.md
- 05-{slug}.md

---

## External Citations

| Status | Count | Details |
|--------|-------|---------|
| Working (200) | 12 | - |
| Redirects (301/302) | 2 | [list old → new URLs] |
| Broken (4xx/5xx) | 1 | [list URLs + articles] |
| Timeout | 0 | - |

**Domain Frequency Issues:**
- Article 05: pubmed.ncbi.nlm.nih.gov cited 4 times (max 2)

---

## Frontmatter Accuracy

| Article | word_count | keyword_density | Keywords |
|---------|------------|-----------------|----------|
| 01-slug | PASS | PASS | PASS |
| 02-slug | FAIL (2500 → 2247) | PASS | FAIL (missing "term") |

---

## Cross-Article Consistency

### Terminology Variations

| Term Cluster | Variations | Articles | Action |
|--------------|------------|----------|--------|
| Brain activity | "racing mind", "racing thoughts" | 01, 03 | Standardise |

### Conflicting Claims

| Topic | Conflict | Articles | Resolution |
|-------|----------|----------|------------|
| ADHD sleep % | "75%" vs "over half" | 01, 05 | Align to same source |

### Positioning Alignment

| Article | Assigned Angle | Alignment |
|---------|---------------|-----------|
| 01 | Parents blamed | Strong |
| 02 | Routine isn't enough | Weak |

---

## Patterns (3+ occurrences)

### [Pattern Name]
- Articles: 01, 03, 05
- Count: 7
- Recommend for common-mistakes.md: Yes
```

### Status Determination

- **PASS:** Zero FAILs across validation, links, and citations
- **PARTIAL:** Some articles PASS, some FAIL
- **FAIL:** All articles have at least one FAIL

---

## Phase 7: Auto-Fix (if --fix)

**Purpose:** Automatically fix validation issues where possible.

**Only runs if `--fix` flag was provided.** If no `--fix`, skip to Phase 8.

### What CAN Be Auto-Fixed

| Issue Type | Fix Agent | Notes |
|------------|-----------|-------|
| Banned AI words | copy-enhancer | Replaces with natural alternatives |
| Em dashes | copy-enhancer | Restructures sentences |
| UK spelling | copy-enhancer | Fixes US → UK |
| AI patterns | copy-enhancer | Varies sentence structure |
| Frontmatter accuracy | copy-enhancer | Updates word_count, keyword_density |
| Brand voice issues | copy-enhancer | Adjusts tone and terminology |

### What CANNOT Be Auto-Fixed (Escalate Immediately)

| Issue Type | Why | Resolution |
|------------|-----|------------|
| Broken internal links | Requires knowing correct target | Manual link update |
| Stale placeholders | Requires knowing link text/context | Manual link insertion |
| Missing bidirectional links | Requires editorial decision on placement | Manual link insertion |
| Incorrect URL format | Requires verifying correct slug | Manual URL update |
| Citation URL errors | Requires finding replacement source | Manual research |
| Cross-article consistency | Requires editorial decision on which version is correct | Manual review |
| Positioning misalignment | May require significant rewrite | Manual review |

### Retry Loop

For each article that FAILED validation in Phase 2:

```
Main session receives FAIL from Phase 2 (attempt N = 1)
    │
    │   Stored: validation_file_path from Phase 2
    │
    ├─ If N < 3:
    │   │
    │   ├─→ Main session SPAWNS Copy Enhancer (Fix Mode) with:
    │   │     - Article path: {article_path}
    │   │     - Validation file path: {validation_file_path}
    │   │     - Mode: "fix"
    │   │
    │   │   Copy Enhancer reads the validation file for issues.
    │   │   Copy Enhancer fixes issues and returns PASS/FAIL.
    │   │
    │   ├─→ Copy Enhancer returns to main session
    │   │
    │   ├─→ Main session SPAWNS Content Validator again with:
    │   │     - Same article path
    │   │     - Same profile/positioning paths
    │   │
    │   └─→ Validator returns:
    │       - If PASS → Validator deletes validation file, article is fixed
    │       - If FAIL → Main session increments N, repeats loop
    │
    └─ If N >= 3:
        │
        ├─→ Log failure to audit-summary.md
        ├─→ Mark article as "Escalated"
        └─→ Continue with remaining articles (don't block the audit)
```

### Copy Enhancer (Fix Mode) Invocation

```
Task: Fix validation issues in {article_path}

Mode: Fix

Article path: projects/hushaway/seo-content/{pillar}/articles/{filename}
Validation file path: projects/hushaway/seo-content/{pillar}/articles/{slug}.validation.md

The validation file contains all FAIL issues with line numbers. Read it and fix each issue.

Expected Return: PASS or FAIL: {reason}
```

**Agent type:** `copy-enhancer`

### Fix Loop Tracking

Track attempt count per article:

```
fix_attempts = {
    "01-{slug}.md": { attempts: 0, status: "PASS" },
    "02-{slug}.md": { attempts: 2, status: "PASS" },
    "03-{slug}.md": { attempts: 3, status: "Escalated" },
    ...
}
```

### Parallel Fix Execution

When multiple articles need fixing, run fix loops in parallel:

1. Spawn all copy-enhancer agents in parallel (one per FAIL article)
2. Wait for ALL to return
3. Spawn all content-validator agents in parallel (one per fixed article)
4. Wait for ALL to return
5. Check results: any remaining FAILs → next attempt round
6. Repeat until all PASS or all hit 3 attempts

---

## Phase 8: Report

**Purpose:** Output final audit results to user.

### Steps

1. Output summary table to user
2. List all escalated articles with reasons
3. List link/citation issues requiring manual fix
4. Suggest patterns for common-mistakes.md (3+ occurrences)

### User Output (Validate Only)

```
📊 Audit Complete: {Pillar Name}

Status: PASS | PARTIAL | FAIL
Articles: {count}
Total Word Count: {sum}

Results:
- Validation: {pass}/{total} PASS
- Links: PASS | FAIL ({broken} broken, {format} format, {placeholder} stale)
- Citations: {working}/{total} working ({warn} warnings)
- Consistency: {issues} issues found

Full report: {pillar}/audit-summary.md

{If escalated issues:}
⚠️ Issues Requiring Manual Review:

Link Issues:
- {article}: {issue description}

Citation Issues:
- {article}: {url} returned {status}

Consistency Issues:
- {articles}: {description}

{If patterns found:}
📝 Patterns for common-mistakes.md:
- {pattern name}: {count} occurrences across articles {list}
```

### User Output (With --fix)

```
📊 Audit Complete: {Pillar Name}

Status: PASS | PARTIAL | FAIL
Articles: {count}
Total Word Count: {sum}

Validation Results:
- Validation: {pass}/{total} PASS
- Links: PASS | FAIL ({broken} broken, {format} format, {placeholder} stale)
- Citations: {working}/{total} working ({warn} warnings)
- Consistency: {issues} issues found

Auto-Fix Results:
- Fixed: {count} articles ({total_attempts} total attempts)
- Escalated: {count} articles (manual review required)
- No issues: {count} articles (passed first time)

{If escalated issues:}
⚠️ Escalated Issues (Manual Review Required):

Content Issues (failed after 3 fix attempts):
- {article}: {remaining issues summary}

Link Issues (cannot auto-fix):
- {article}: {issue description}

Citation Issues (cannot auto-fix):
- {article}: {url} returned {status}

Consistency Issues (cannot auto-fix):
- {articles}: {description}

{If patterns found:}
📝 Patterns for common-mistakes.md:
- {pattern name}: {count} occurrences across articles {list}

Full report: {pillar}/audit-summary.md
```

### Audit Summary Update (--fix mode)

When `--fix` is used, append a Fix Results section to `audit-summary.md`:

```markdown
---

## Fix Results

| Article | Attempts | Final | Notes |
|---------|----------|-------|-------|
| 01-slug | 0 | PASS | Passed first time |
| 02-slug | 1 | PASS | Fixed on first attempt |
| 03-slug | 3 | Escalated | H1 structural issue |

### Escalated Issues (Manual Review Required)

**Content Issues:**
- 03-slug: H1 structural issue (line 1)

**Link Issues:**
- 02-slug: Missing link to pillar guide
- 05-slug: Missing link to pillar guide

**Citation Issues:**
- 04-slug: Broken URL https://example.com/removed (line 89)

**Consistency Issues:**
- 01, 05: Conflicting ADHD sleep percentage claims
```

---

## Multi-Pillar Execution (--all)

When `--all` is specified, run the entire Phase 1-8 workflow for each pillar sequentially.

### Why Sequential (Not Parallel)

Running multiple pillars in parallel would:
- Exhaust main session context (8 pillars x 7 articles x validation output)
- Create too many concurrent agent spawns
- Make error tracking harder to follow

### Execution Order

Process pillars in this order (matches production queue):

1. adhd-sleep
2. autistic-meltdowns
3. sensory-overload
4. calming-sounds
5. emotional-regulation
6. bedtime-routines
7. sound-therapy
8. app-comparisons

### Inter-Pillar Output

After each pillar completes, output a progress summary:

```
✅ Pillar 1/8: adhd-sleep — PARTIAL (5/7 PASS, 2 escalated)
🔄 Starting pillar 2/8: autistic-meltdowns...
```

### Final Summary (--all)

After all pillars complete:

```
📊 Full Audit Complete

| Pillar | Articles | Validation | Links | Citations | Status |
|--------|----------|------------|-------|-----------|--------|
| adhd-sleep | 7 | 5/7 | FAIL | 12/14 | PARTIAL |
| autistic-meltdowns | 7 | 7/7 | PASS | 10/10 | PASS |
| ... | ... | ... | ... | ... | ... |

Total: {total_articles} articles across {pillar_count} pillars
Overall: {pass_count} PASS, {partial_count} PARTIAL, {fail_count} FAIL

{If --fix:}
Auto-Fix Summary:
- Total fixed: {count}
- Total escalated: {count}
- Total attempts: {count}

Audit summaries written to each pillar directory.
```

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
| Curl timeout on citation | Mark as WARN (timeout), continue |
| 403 on HEAD request | Retry with GET before marking as WARN |
| Agent spawn failure | Log error, continue with next agent |

---

## Git Workflow

### After Successful --fix

If `--fix` was used and articles were modified:

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

- Validation files (`.validation.md`) — Temporary, deleted on PASS
- Link audit files (`link-audit.md`) — Reference only, may re-run
- Audit summary (`audit-summary.md`) — DO commit (audit trail)

---

## Quick Reference: Agent Invocations

### Content Validator

```
subagent_type: content-validator

Task: Validate article at {article_path}

Inputs:
- Article path: {path}
- Client profile: clients/hushaway/profile.md
- Positioning: {pillar}/02-positioning.md
- Content type: Article

Expected Return: PASS or FAIL, {fail_count}, {warn_count}, {validation_file_path}
```

### Link Auditor

```
subagent_type: link-auditor

Task: Audit internal links for pillar at {pillar_path}

Inputs:
- Pillar path: {pillar_path}
- All pillar paths: [list of all pillar directories]

Expected Return: PASS or FAIL, {broken_count}, {format_count}, {placeholder_count}, {pillar}/link-audit.md
```

### Copy Enhancer (Fix Mode)

```
subagent_type: copy-enhancer

Task: Fix validation issues in {article_path}

Mode: Fix

Article path: {article_path}
Validation file path: {validation_file_path}

The validation file contains all FAIL issues with line numbers. Read it and fix each issue.

Expected Return: PASS or FAIL: {reason}
```

---

## Complete Execution Checklist

Use this checklist to track audit execution:

```markdown
## Pillar Audit: {Pillar Name}

### Phase 1: Discovery
- [ ] Arguments parsed (pillar name, --fix flag)
- [ ] Pillar directory verified
- [ ] Articles found and listed
- [ ] Context files loaded (profile, positioning)

### Phase 2: Parallel Validation
- [ ] Content-validator spawned for each article (parallel)
- [ ] All validators returned
- [ ] Results collected (PASS/FAIL per article)
- [ ] FAIL validation file paths stored

### Phase 3: Link Audit
- [ ] Link-auditor spawned for pillar
- [ ] Link audit returned (PASS/FAIL)
- [ ] Link audit report reviewed (if FAIL)

### Phase 4: Citation URL Validation
- [ ] External URLs extracted from all articles
- [ ] URLs de-duplicated
- [ ] HTTP HEAD requests completed
- [ ] Results mapped back to articles
- [ ] Domain frequency checked

### Phase 5: Cross-Article Consistency
- [ ] Terminology consistency checked
- [ ] Conflicting claims identified
- [ ] Positioning alignment assessed

### Phase 6: Aggregation
- [ ] All results compiled
- [ ] Issues categorised by type
- [ ] Patterns identified (3+ occurrences)
- [ ] audit-summary.md written

### Phase 7: Auto-Fix (if --fix)
- [ ] FAIL articles identified for fix loop
- [ ] Copy-enhancer spawned for each FAIL article
- [ ] Validation re-run after fixes
- [ ] Retry loop completed (max 3 per article)
- [ ] Escalated articles documented

### Phase 8: Report
- [ ] Summary output to user
- [ ] Escalated issues listed
- [ ] Patterns suggested for common-mistakes.md
- [ ] Git commit (if --fix and files changed)
```

---

## Reference Files

- `.claude/rules/universal-rules.md` — Validation checks
- `.claude/rules/common-mistakes.md` — Learned patterns
- `.claude/agents/content-validator.md` — Article validation agent (returns: `PASS` or `FAIL, {fail_count}, {warn_count}, {path}`)
- `.claude/agents/copy-enhancer.md` — Auto-fix agent (returns: `PASS` or `FAIL: {reason}`)
- `.claude/agents/link-auditor.md` — Link audit agent (returns: `PASS` or `FAIL, {broken}, {format}, {placeholders}, {path}`)
- `.claude/skills/execute-pillar/SKILL.md` — Orchestration pattern reference
- `clients/hushaway/profile.md` — Brand voice

---

*This skill is the single source of truth for pillar auditing. The main session follows these phases exactly. Agents do NOT orchestrate each other. All coordination happens here.*
