# Audit Summary Template

Templates for audit-summary.md output and user-facing report formats.

---

## Audit Summary Format

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

---

## Status Determination

- **PASS:** Zero FAILs across validation, links, and citations
- **PARTIAL:** Some articles PASS, some FAIL
- **FAIL:** All articles have at least one FAIL

---

## User Output: Validate Only

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

---

## User Output: With --fix

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

---

## Fix Results Section (append to audit-summary.md)

When `--fix` is used, append this section to `audit-summary.md`:

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
