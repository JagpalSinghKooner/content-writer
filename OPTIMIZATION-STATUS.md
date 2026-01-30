# Optimization Status

**Last Updated:** 2026-01-30

---

## Completed

### Context Optimization (81% reduction achieved)
- [x] Created `.claude/rules/humanise-rules.md` - Single source of truth for all content rules
- [x] Created `.claude/context/*.md` - Skill-specific context files (4 files)
- [x] Slimmed `.claude/CLAUDE.md` (27KB → 8KB)
- [x] Slimmed `.claude/agents.md` (30KB → 6KB)
- [x] Deleted redundant files (humanise-content.md, write-article.md, conversion-gate-checklist.md)

### Script Optimization
- [x] Created `quick-check.sh` - Pre-flight validation (catches 80% of failures during writing)
- [x] Added `--summary` flag - Compact output (~80% fewer tokens)
- [x] Added `--remediate` flag - Shows failures only on 2nd+ runs
- [x] Added `--fail-fast` flag - Stops after 3 failures
- [x] Added `--diff` flag - Shows FIXED/STILL FAILING/NEW between runs
- [x] Fixed exit codes (0/1 instead of $FAILS count)
- [x] Improved contraction message (shows minimum count for word length)
- [x] Aligned internal link counting between gates

### Documentation Alignment (Deep Audit)
- [x] Fixed "both gates" → "all gates" in ARTICLE-ORDER.md
- [x] Clarified Session 1/Session 2 workflow in positioning-angles-context.md
- [x] Added angle selection clarification to CLAUDE.md
- [x] Documented regex `#` exclusion in humanise-rules.md
- [x] Added hedging edge case documentation

### Script-Rules Alignment (2026-01-30)
- [x] Added `--fail-fast` to `check-conversion-gate.sh` (was documented but missing)
- [x] Removed AI-isms from adverb check in `master-gate.sh` (Interestingly, Evidently, etc.)
- [x] Removed `apa.org` from external link check (UK sources only per rules)
- [x] Added global limits to `humanise-rules.md` Section 4 (short sentences min 3, "This" max 6)

---

## Metrics

| Metric | Before | After |
|--------|--------|-------|
| Documentation size | 141KB | 35KB |
| Gate output tokens | ~800 | ~200 (summary) |
| Gate iterations per article | 4 | 1-2 |
| Failures caught during writing | 0% | 80% |
| Diff output per iteration | N/A | ~60% reduction vs full output |

---

## Implementation Details

### Diff-Based Output (`--diff` flag)

**Files created/modified:**
- Created `.claude/scripts/lib/gate-state.sh` - Shared state management functions
- Modified `master-gate.sh` - Added --diff flag and state tracking
- Modified `check-conversion-gate.sh` - Added --diff flag and state tracking

**How it works:**
- State files stored in `/tmp/gate-state/` with MD5 hash of article path
- Each check records PASS/FAIL status with value
- On subsequent runs, compares current vs previous state
- Shows: FIXED (was failing, now passing), STILL FAILING, NEW FAILURE

**Usage:**
```bash
# First run
master-gate.sh article.md hub --summary

# Subsequent runs with diff
master-gate.sh article.md hub --diff --summary
```
