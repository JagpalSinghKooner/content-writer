# Implementation Plan: Minimal Agent Returns

**Objective:** Reduce agent return verbosity to prevent main session context overflow during pillar execution.

**Root Cause:** Agents return full reports (validation reports ~1000+ words, self-validation checklists, banned word checks, platform summaries) to main session. 32 verbose returns = context explosion by Tier 5.

**Solution:** Minimal returns. Main session only needs PASS/FAIL to orchestrate. Detailed output goes to files for consuming agents to read.

---

## Changes by File

### 1. `.claude/agents/content-validator.md` (HIGH PRIORITY)

**Current:** Returns full 6-section validation report (~500 lines of format definition)

**Change:**
- On FAIL: Write full validation output to `{article-slug}.validation.md` alongside article
- On PASS: Delete any existing validation file, return `PASS`
- Return format: `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}`

**Specific edits:**
- Update "Critical: Full Output Required" section (lines 28-37) to write to file instead
- Add file writing logic in return format section (lines 434-516)
- Add cleanup logic: delete validation file when returning PASS

---

### 2. `.claude/agents/copy-enhancer.md` (HIGH PRIORITY)

**Current:** Returns PASS/FAIL + mode + banned words check section + changes made

**Change:**
- In Fix mode: Read validation file from `{validation_file_path}` provided by main session
- Remove banned words check from return (still runs internally)
- Return only: `PASS`

**Specific edits:**
- Update Fix Mode section to read from validation file path
- Update return format section (lines 250-275) to minimal format
- Keep banned word checking internally, just don't return it

---

### 3. `.claude/agents/seo-writer.md` (MEDIUM PRIORITY)

**Current:** Returns PASS/FAIL + file path + word count + citations + 8-item self-validation checklist

**Change:**
- Remove self-validation checklist entirely (Content Validator is single source of truth)
- Return only: `PASS, {file_path}`

**Specific edits:**
- Remove "Pre-Return Self-Validation Checklist" section (lines 127-155)
- Remove self-validation output instructions (lines 156-173)
- Simplify return format section (lines 183-212)

---

### 4. `.claude/agents/content-atomizer.md` (LOW PRIORITY)

**Current:** Returns PASS/FAIL + source article + files created + platform summary

**Change:**
- Return only: `PASS`

**Specific edits:**
- Simplify return format section (lines 139-162)

---

### 5. `.claude/agents-prd.md` (HIGH PRIORITY)

**Current:** Documents verbose return formats for all 4 agents

**Change:**
- Update all 4 return format specs to minimal versions
- Update note about "main session REQUIRES full validation output" → now reads from file
- Document validation file lifecycle

**Sections to update:**
- SEO Writer (lines 183-198)
- Copy Enhancer (lines 241-255)
- Content Validator (lines 315-388)
- Content Atomizer (lines 431-451)
- Main session requirements note (lines 292-295)

---

### 6. `.claude/rules/workflow.md` (HIGH PRIORITY)

**Current:** Agent Return Formats section shows verbose formats

**Change:**
- Update Agent Return Formats table to minimal versions
- Update retry logic: 3 attempts max, no fail_count threshold
- Add validation file lifecycle documentation
- Update copy-enhancer issue reception: reads from file, not prompt

**Sections to update:**
- Agent Return Formats table (around line 175)
- Retry Loop section (update logic)
- Add new section: Validation File Lifecycle

---

## New Minimal Return Formats

| Agent | New Return Format |
|-------|-------------------|
| SEO Writer | `PASS, {file_path}` |
| Copy Enhancer | `PASS` |
| Content Validator | `PASS` or `FAIL, {fail_count}, {warn_count}, {validation_file_path}` |
| Content Atomizer | `PASS` |

---

## Validation File Lifecycle

```
1. Validator runs on article
   ├── PASS → Delete any existing validation file, return "PASS"
   └── FAIL → Write full report to {slug}.validation.md, return "FAIL, {counts}, {path}"

2. Main session receives FAIL
   └── Spawns copy-enhancer with: article_path, validation_file_path

3. Copy-enhancer runs
   ├── Reads validation file
   ├── Fixes issues
   └── Returns "PASS"

4. Main session spawns validator again
   ├── PASS → Validator deletes validation file, returns "PASS"
   └── FAIL → Cycle repeats (max 3 attempts)

5. After 3 failures → Escalate to user (validation file remains for debugging)
```

---

## Retry Logic Update

**Current:** Retry if fail_count <= 10 AND attempt < 3

**New:** Retry if attempt < 3, escalate after 3 failures (no fail_count threshold)

---

## Implementation Order

1. **content-validator.md** - Highest impact, enables file-based communication
2. **copy-enhancer.md** - Must update to read from file
3. **seo-writer.md** - Remove self-validation checklist
4. **content-atomizer.md** - Simplify return
5. **agents-prd.md** - Update documented specs
6. **workflow.md** - Update orchestration docs

---

## Verification

After implementation:
1. Run Calming Sounds pillar (next scheduled pillar)
2. Monitor main session context usage throughout execution
3. Verify validation files created on FAIL, deleted on PASS
4. Verify copy-enhancer successfully reads and fixes from validation files
5. Confirm no quality degradation (same validation thoroughness, just different delivery)

---

## Files Modified

```
.claude/agents/content-validator.md
.claude/agents/copy-enhancer.md
.claude/agents/seo-writer.md
.claude/agents/content-atomizer.md
.claude/agents-prd.md
.claude/rules/workflow.md
```

---

## Decisions Made (from interview)

| Decision | Choice |
|----------|--------|
| Validation file on PASS | No file created, existing file deleted |
| Retry logic | 3 attempts max, no fail_count threshold |
| SEO Writer self-validation | Remove entirely |
| Validation file location | Alongside articles, ephemeral |
| Cleanup responsibility | Validator deletes on PASS |
| Rollout | All 6 files together, single PR |
| Testing | Calming Sounds pillar |
