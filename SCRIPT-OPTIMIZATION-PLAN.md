# Gate Script Optimization Plan

**Created:** 2026-01-30
**Purpose:** Reduce context usage and improve gate script efficiency
**Status:** Planning document for implementation

---

## Table of Contents

1. [Background: The Problem](#background-the-problem)
2. [Completed Work: Documentation Alignment](#completed-work-documentation-alignment)
3. [How Context Gets Consumed](#how-context-gets-consumed)
4. [Optimization Opportunities](#optimization-opportunities)
5. [Implementation Details](#implementation-details)
6. [Testing Plan](#testing-plan)
7. [File Reference](#file-reference)

---

## Background: The Problem

### Article 5.3 Session Analysis

During the Article 5.3 writing session, we experienced:
- **4 gate iterations** (3 Content Gate + 1 Conversion Gate)
- **15 total issues fixed**
- **~65% of context consumed by rework**
- **Session ran out of context** mid-way through

### Root Causes Identified

| Issue | Impact |
|-------|--------|
| Rules not applied during writing | Failures discovered at gate time |
| Script behaviors undocumented | Short sentence detection misunderstood |
| Full gate output every run | Redundant information repeated |
| No state between runs | Can't show "what changed" |

---

## Completed Work: Documentation Alignment

### Changes Made (Session 2026-01-30)

**1. `.claude/rules/humanise-rules.md`** (Source of Truth)

Added to Section 2 (Frequency Limits):
```markdown
### Scaling for Longer Articles

The gate script scales limits for articles over 3,500 words:
- **Formula:** SCALE_FACTOR = (WordCount - 2000) / 1500
- Under 3,500 words: Use base limits above
- 3,500+ words: Add 1 to applicable limits

| Word | Under 3,500 words | 3,500+ words |
|------|-------------------|--------------|
| actually | 2 | 3 |
| effective/ly | 2 | 3 |
| helpful | 3 | 4 |
| important | 3 | 4 |
```

Added to Section 5 (Human Voice Requirements):
```markdown
**Contraction Calculation (How the Gate Script Counts):**
- Formula: (Contractions × 500) / WordCount must be ≥ 2
- 1,500 word article: minimum 6 contractions
- 2,000 word article: minimum 8 contractions
- 2,500 word article: minimum 10 contractions

**CRITICAL: Script Detection Requirement**
- Short sentences MUST be standalone paragraphs (one sentence per line)
- The gate script uses regex `^[^.]{1,40}\.$` which requires:
  - Start of line (`^`) - sentence must begin the paragraph
  - Under 40 characters total
  - Single period at end of line
- Inline short sentences will NOT be counted
```

**2. `.claude/context/seo-content-context.md`**

Replaced duplicated frequency table with reference:
```markdown
### Word Frequency Tracking

Track frequency-limited words as you write. See `.claude/rules/humanise-rules.md` Section 2 for:
- Full list of limited words and their maximums
- Scaling rules for articles over 3,500 words

**Most commonly exceeded (quick reference):**
- actually: 2 max
- specifically: 2 max
- helpful: 3 max
```

Added active writing checklists and `--remediate` flag documentation.

**3. `.claude/context/direct-response-context.md`**

Added table content restrictions:
```markdown
### Table Content Restrictions (CRITICAL)

**Commitment words are banned EVERYWHERE, including comparison tables.**

| Avoid | Use Instead |
|-------|-------------|
| subscription, subscription-based | paid monthly |
| subscribe | join, access |
| trial, free trial | free tier |
| premium | full version |
| upgrade | access more |
| sign up, register | enter your email |
```

### Alignment Principle Established

| Rule Type | Location | Context Files |
|-----------|----------|---------------|
| Definitions & thresholds | humanise-rules.md | Reference only |
| Practical checklists | Context files | Allowed |
| Practical extensions | Context files | Allowed (e.g., table alternatives) |

---

## How Context Gets Consumed

### Scripts Are Stateless

Gate scripts (`master-gate.sh`, `check-conversion-gate.sh`) have:
- **No database** of previous runs
- **No log** of what failed before
- **No comparison** to last run
- **No "fixed since last time"** notices

Each run:
1. Reads current article file
2. Runs all checks
3. Outputs full results
4. Exits (no memory retained)

### What Actually Uses Tokens

| Activity | Token Cost | Why |
|----------|------------|-----|
| Script execution | 0 | Runs outside context |
| Script OUTPUT | ~500-1000 | Returns to conversation |
| Reading output | Included above | Part of conversation |
| Analyzing failures | ~200-500 | My reasoning |
| Making fixes | ~300-500 per fix | Edit tool calls |
| Re-reading rules | ~2000 | If unsure about threshold |

### Multiplication Effect

```
Iteration 1: Output (800) + 12 fixes (4000) + analysis (500) = ~5300 tokens
Iteration 2: Output (800) + 2 fixes (700) + analysis (300) = ~1800 tokens
Iteration 3: Output (800) + 1 fix (350) + analysis (200) = ~1350 tokens
Iteration 4: Output (500) = ~500 tokens

Total overhead from iterations: ~9000 tokens
Pass on first attempt: ~1300 tokens
Wasted: ~7700 tokens (85% reduction possible)
```

---

## Optimization Opportunities

### Priority 1: Diff-Based Output (HIGH IMPACT)

**Current Behavior:**
- Every run outputs all 30+ check results
- PASS messages repeated even if nothing changed
- No indication of what was fixed

**Proposed Behavior:**
- Store last run results in temp file
- Compare current vs previous
- Output only: FIXED, STILL FAILING, NEW FAILURE

**Expected Savings:** ~60% reduction in output per iteration

### Priority 2: Summary Mode (MEDIUM IMPACT)

**Current Behavior:**
```
>>> CHECK 1: AI-isms
PASS: No AI-isms found
>>> CHECK 2: Frequency Limits
PASS: "actually" (2) within limit (2)
PASS: "specifically" (1) within limit (2)
... (30 more lines)
```

**Proposed Behavior (`--summary`):**
```
GATE: FAIL (2 issues)
- actually: 6 (max 2)
- short sentences: 0 (need 3)
```

**Expected Savings:** ~80% reduction in output

### Priority 3: Pre-Flight Quick Check (HIGH IMPACT)

**New Script:** `quick-check.sh`

Purpose: Catch top 10 most common failures DURING writing, not after.

Checks only:
1. AI-isms (navigate, delve, comprehensive, robust)
2. HushAway® trademark
3. "actually" count
4. "specifically" count
5. Short sentence count (standalone paragraphs)
6. Contraction count
7. Community quote present
8. HushAway in intro
9. Commitment language in tables
10. Keyword in H2

**Expected Savings:** Prevents most gate failures before they happen

### Priority 4: Fail-Fast Mode (MEDIUM IMPACT)

**Current Behavior:**
- Runs all 30+ checks even if first 5 fail
- Full output regardless of failure count

**Proposed Behavior (`--fail-fast`):**
- Stop after 3 failures
- Output: "3 failures found. Fix these first, then re-run."

**Expected Savings:** Faster feedback, less output

### Priority 5: Parallel Checks (LOW IMPACT)

**Current Behavior:**
```bash
check_aiisms      # runs
check_frequency   # waits, then runs
check_contractions # waits, then runs
```

**Proposed Behavior:**
```bash
check_aiisms &
check_frequency &
check_contractions &
wait
```

**Expected Savings:** ~3x faster execution (marginal benefit)

---

## Implementation Details

### 1. Diff-Based Output Implementation

**Files to modify:** `master-gate.sh`, `check-conversion-gate.sh`

**Add at script start:**
```bash
# State file for diff tracking
SCRIPT_NAME=$(basename "$0")
FILE_HASH=$(echo "$FILE" | md5)
STATE_DIR="/tmp/gate-state"
LAST_RUN="$STATE_DIR/${SCRIPT_NAME}-${FILE_HASH}.txt"

mkdir -p "$STATE_DIR"
```

**Add at each check:**
```bash
# Instead of just echoing result, store it
CURRENT_RESULTS+=("CHECK_NAME:$STATUS:$DETAILS")
```

**Add at script end:**
```bash
# Compare to last run
if [ -f "$LAST_RUN" ]; then
    echo ""
    echo "=== CHANGES FROM LAST RUN ==="

    # Show fixed items
    while read -r line; do
        CHECK=$(echo "$line" | cut -d: -f1)
        if ! grep -q "^$CHECK:FAIL" <<< "${CURRENT_RESULTS[*]}"; then
            echo "FIXED: $CHECK"
        fi
    done < <(grep ":FAIL:" "$LAST_RUN")

    # Show still failing
    for result in "${CURRENT_RESULTS[@]}"; do
        if [[ "$result" == *":FAIL:"* ]]; then
            CHECK=$(echo "$result" | cut -d: -f1)
            if grep -q "^$CHECK:FAIL" "$LAST_RUN"; then
                echo "STILL FAILING: $result"
            else
                echo "NEW FAILURE: $result"
            fi
        fi
    done
fi

# Save current for next run
printf '%s\n' "${CURRENT_RESULTS[@]}" > "$LAST_RUN"
```

### 2. Summary Mode Implementation

**Add flag parsing:**
```bash
SUMMARY_MODE=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --summary) SUMMARY_MODE=true; shift ;;
        --remediate) QUIET_PASS=true; shift ;;
        --fail-fast) FAIL_FAST=true; shift ;;
        *) FILE="$1"; shift ;;
    esac
done
```

**Add at script end:**
```bash
if [ "$SUMMARY_MODE" = true ]; then
    echo "============================================"
    if [ "$FAILS" -eq 0 ]; then
        echo "GATE: PASS"
    else
        echo "GATE: FAIL ($FAILS issues)"
        for failure in "${FAILURES[@]}"; do
            echo "- $failure"
        done
    fi
    echo "============================================"
    exit $FAILS
fi
```

### 3. Pre-Flight Quick Check Script

**New file:** `.claude/scripts/quick-check.sh`

```bash
#!/bin/bash
# ============================================================================
# QUICK CHECK - Pre-Flight Validation (Top 10 Failures Only)
# ============================================================================
# Usage: ./quick-check.sh <article-file>
# Run DURING writing to catch obvious issues before full gate
# ============================================================================

FILE="$1"
FAILS=0

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
    echo "Usage: ./quick-check.sh <article-file>"
    exit 1
fi

echo "Quick Check: $FILE"
echo "---"

# 1. AI-isms (most common failure)
AIISMS=$(grep -ciE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital" "$FILE") || AIISMS=0
if [ "$AIISMS" -gt 0 ]; then
    echo "FAIL: AI-isms found ($AIISMS instances)"
    grep -niE "navigate|navigating|delve|landscape|leverage|comprehensive|robust|crucial|vital" "$FILE" | head -3
    FAILS=$((FAILS+1))
fi

# 2. HushAway trademark
MISSING_TM=$(grep -c "HushAway[^®]" "$FILE" 2>/dev/null) || MISSING_TM=0
# Exclude URLs
MISSING_TM=$(grep "HushAway[^®]" "$FILE" 2>/dev/null | grep -v "hushaway.com" | wc -l) || MISSING_TM=0
MISSING_TM=$(echo "$MISSING_TM" | tr -d ' ')
if [ "$MISSING_TM" -gt 0 ]; then
    echo "FAIL: HushAway missing ® symbol ($MISSING_TM instances)"
    FAILS=$((FAILS+1))
fi

# 3. "actually" count (max 2)
ACTUALLY=$(grep -ciE "\bactually\b" "$FILE") || ACTUALLY=0
if [ "$ACTUALLY" -gt 2 ]; then
    echo "FAIL: 'actually' exceeds limit ($ACTUALLY found, max 2)"
    FAILS=$((FAILS+1))
fi

# 4. "specifically" count (max 2)
SPECIFICALLY=$(grep -ciE "\bspecifically\b" "$FILE") || SPECIFICALLY=0
if [ "$SPECIFICALLY" -gt 2 ]; then
    echo "FAIL: 'specifically' exceeds limit ($SPECIFICALLY found, max 2)"
    FAILS=$((FAILS+1))
fi

# 5. Short sentences (standalone paragraphs under 40 chars)
SHORT=$(grep -cE "^[^.]{1,40}\.$" "$FILE") || SHORT=0
if [ "$SHORT" -lt 3 ]; then
    echo "FAIL: Short sentences ($SHORT found, need 3+ standalone paragraphs)"
    FAILS=$((FAILS+1))
fi

# 6. Contractions
WORD_COUNT=$(wc -w < "$FILE" | tr -d ' ')
CONTRACTIONS=$(grep -ciE "you're|it's|don't|doesn't|can't|won't|we're|they're|I'm|he's|she's|that's|there's|here's|what's|who's|isn't|aren't|wasn't|weren't|haven't|hasn't|hadn't|couldn't|wouldn't|shouldn't" "$FILE") || CONTRACTIONS=0
MIN_CONTRACTIONS=$((WORD_COUNT * 2 / 500))
if [ "$CONTRACTIONS" -lt "$MIN_CONTRACTIONS" ]; then
    echo "FAIL: Contractions ($CONTRACTIONS found, need $MIN_CONTRACTIONS for $WORD_COUNT words)"
    FAILS=$((FAILS+1))
fi

# 7. Community quote
QUOTES=$(grep -ciE "one mum|one parent|as one parent|parent shared|parents in our community|mum put it|parent told" "$FILE") || QUOTES=0
if [ "$QUOTES" -lt 1 ]; then
    echo "FAIL: No community quote with attribution found"
    FAILS=$((FAILS+1))
fi

# 8. HushAway in intro (first 500 words approximation - first 3000 chars)
INTRO=$(head -c 3000 "$FILE")
HUSHAWAY_INTRO=$(echo "$INTRO" | grep -c "HushAway®") || HUSHAWAY_INTRO=0
if [ "$HUSHAWAY_INTRO" -lt 1 ]; then
    echo "FAIL: HushAway® not in introduction"
    FAILS=$((FAILS+1))
fi

# 9. Commitment language in tables
TABLE_COMMIT=$(grep -E "^\|" "$FILE" | grep -ciE "subscription|subscribe|trial|premium|upgrade|sign up|register") || TABLE_COMMIT=0
if [ "$TABLE_COMMIT" -gt 0 ]; then
    echo "FAIL: Commitment language in table ($TABLE_COMMIT instances)"
    grep -E "^\|" "$FILE" | grep -iE "subscription|subscribe|trial|premium|upgrade|sign up|register"
    FAILS=$((FAILS+1))
fi

# 10. Primary keyword in H2 (check for any H2 with common ADHD terms)
H2_KEYWORD=$(grep -cE "^## .*" "$FILE") || H2_KEYWORD=0
if [ "$H2_KEYWORD" -lt 1 ]; then
    echo "WARNING: Check that primary keyword appears in at least one H2"
fi

echo "---"
if [ "$FAILS" -eq 0 ]; then
    echo "QUICK CHECK: PASS (0 issues)"
    echo "Ready for full gate check."
else
    echo "QUICK CHECK: $FAILS issue(s) found"
    echo "Fix these before running full gate."
fi

exit $FAILS
```

### 4. Fail-Fast Implementation

**Add to existing scripts:**
```bash
FAIL_FAST=false
MAX_FAILS_BEFORE_STOP=3

# In flag parsing
--fail-fast) FAIL_FAST=true; shift ;;

# After each check
if [ "$FAIL_FAST" = true ] && [ "$FAILS" -ge "$MAX_FAILS_BEFORE_STOP" ]; then
    echo ""
    echo "============================================"
    echo "FAIL-FAST: $FAILS failures found"
    echo "Fix these issues first, then re-run gate."
    echo "============================================"
    exit 1
fi
```

---

## Testing Plan

### Test 1: Verify Documentation Alignment
```bash
# Check rules file has scaling factor
grep -A 10 "Scaling for Longer Articles" .claude/rules/humanise-rules.md

# Check context file references (doesn't duplicate)
grep -c "See.*humanise-rules.md" .claude/context/seo-content-context.md
```

### Test 2: Quick Check Script
```bash
# Create test article with known issues
echo "This is a comprehensive guide that will navigate you through..." > /tmp/test-article.md

# Run quick check
.claude/scripts/quick-check.sh /tmp/test-article.md
# Expected: FAIL on AI-isms
```

### Test 3: Summary Mode
```bash
# After implementing, test on existing article
.claude/scripts/master-gate.sh src/content/pillar-5-adhd-apps/5.3-executive-function-apps.md cluster --summary
```

### Test 4: Diff Mode
```bash
# Run gate twice, second should show "no changes"
.claude/scripts/master-gate.sh article.md cluster
# Make a fix
.claude/scripts/master-gate.sh article.md cluster
# Should show: FIXED: [whatever was fixed]
```

### Test 5: Full Article Workflow
Write Article 5.4 with optimizations in place:
1. Use quick-check.sh during writing
2. Run full gate with --summary first
3. If failures, run without --summary for details
4. Track: How many iterations? How much context used?

---

## File Reference

### Scripts to Modify

| File | Changes |
|------|---------|
| `.claude/scripts/master-gate.sh` | Add --summary, --fail-fast, diff tracking |
| `.claude/scripts/check-conversion-gate.sh` | Add --summary, --fail-fast, diff tracking |

### New Scripts to Create

| File | Purpose |
|------|---------|
| `.claude/scripts/quick-check.sh` | Pre-flight top 10 check |

### Documentation Files

| File | Status |
|------|--------|
| `.claude/rules/humanise-rules.md` | Updated (source of truth) |
| `.claude/context/seo-content-context.md` | Updated (references rules) |
| `.claude/context/direct-response-context.md` | Updated (table restrictions) |

### Reference Files

| File | Purpose |
|------|--------|
| `/Users/jagpalkooner/.claude/plans/sunny-wiggling-squid.md` | Session analysis and learnings |
| `SCRIPT-OPTIMIZATION-PLAN.md` | This document |

---

## Implementation Order

1. **Create `quick-check.sh`** - Immediate value, no risk
2. **Add `--summary` flag** - Low risk, high value
3. **Add `--fail-fast` flag** - Low risk, medium value
4. **Add diff tracking** - Medium risk, high value (requires state management)
5. **Test with Article 5.4** - Validate improvements

---

## Expected Outcomes

| Metric | Before | After |
|--------|--------|-------|
| Gate iterations per article | 4 | 1-2 |
| Tokens per gate run | ~800 | ~200 (summary mode) |
| Total context per article | ~39,000 | ~20,000 |
| Failures caught during writing | 0% | 80% (quick-check) |

---

## Notes for Next Session

When continuing this work:

1. **Read this document first** - Contains all context
2. **Start with quick-check.sh** - Easiest win, no existing code changes
3. **Test on Article 5.4** - Real-world validation
4. **The `--remediate` flag already exists** - Use it on 2nd+ runs

The documentation alignment is COMPLETE. Focus on script improvements.
