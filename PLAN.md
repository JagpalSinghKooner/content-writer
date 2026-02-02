# SEO Content System - Implementation Plan

## Status Tracker

| # | Task | Status | Test |
|---|------|--------|------|
| 1 | Create CLAUDE.md | ✅ Done | Can read and understand workflow |
| 2 | Create universal-rules.md | ✅ Done | Contains 50+ banned words, UK rules, SEO rules |
| 3 | Create common-mistakes.md | ✅ Done | File exists with template |
| 4 | Create onboard-client skill | ✅ Done | `/onboard-client` works in Claude |
| 5 | Create clients/projects dirs | ✅ Done | Directories exist |
| 6 | Create validate-content skill | ✅ Done | `/validate-content` checks rules + profile |
| 7 | E2E: Onboard client | ⬜ Pending | profile.md created |
| 8 | E2E: Keyword research | ⬜ Pending | 01-keyword-brief.md created |
| 9 | E2E: Positioning angles | ⬜ Pending | 02-positioning-brief.md created |
| 10 | E2E: SEO content | ⬜ Pending | 03-draft.md created (1,500+ words) |
| 11 | E2E: Direct response copy | ⬜ Pending | 04-final.md created |
| 12 | E2E: Validate content | ⬜ Pending | PASS or fixable FAIL |

---

## Task 6: Create Validation Skill

### What
Create `/validate-content` skill that checks content against universal rules and client profile, outputting PASS/FAIL with line-specific issues.

### File to Create
`.claude/skills/validate-content/SKILL.md`

### Content Requirements

**Validation Checks:**
1. Universal rules (from universal-rules.md):
   - UK English spelling
   - 53 banned AI words
   - Banned AI phrases
   - AI patterns (repetitive starts, rule of threes, hedging, etc.)
   - SEO requirements (keyword placement, word count, meta data, links)
2. Client profile checks:
   - Brand voice match
   - Terminology consistency
   - Avoided words/topics
3. Human quality assessment:
   - Does it sound like AI wrote it?
   - Natural flow and rhythm

**Output Format:**
```markdown
## Validation Result: [PASS/FAIL]

### FAIL Issues (must fix)
- Line 23: "utilize" - banned AI word → use "use"
- Line 45: "color" - US spelling → use "colour"
- Missing: Primary keyword not in first 150 words

### WARN Issues (should fix)
- Line 67: No contraction used → "it is" could be "it's"
- Passive voice in 4 consecutive sentences

### Suggested Pattern (for common-mistakes.md)
[If recurring issue detected, suggest addition]
```

**Failure Handling:**
- Auto-retry once with specific fixes
- If still fails: flag for human review
- Suggest pattern for common-mistakes.md (human approves)

### Test
- Run `/validate-content` on sample article with intentional errors
- Catches: US spelling, banned words, missing SEO requirements
- Outputs PASS/FAIL with line numbers

### Starter Prompt
```
Create the /validate-content skill for the SEO Content System.

Read these files for context:
- /PRD.md (validation requirements in "Validation" section)
- /.claude/rules/universal-rules.md (all rules to check against)
- /.claude/skills/seo-content/SKILL.md (format reference for SKILL.md)

Create .claude/skills/validate-content/SKILL.md with:

1. Frontmatter (name: validate-content, description with triggers)

2. The Core Job: Check content against universal rules + client profile, output PASS/FAIL with line-specific issues

3. Input requirements:
   - Article to validate (file path or content)
   - Client profile path (optional but recommended)
   - Primary keyword (for SEO checks)

4. Validation Phases:
   - PHASE 1: Universal Rules Check
     - UK English spelling scan
     - Banned AI words scan (53 words)
     - Banned AI phrases scan
     - AI pattern detection
     - SEO requirements check
   - PHASE 2: Client Profile Check (if profile provided)
     - Brand voice alignment
     - Terminology consistency
     - Avoided words/topics check
   - PHASE 3: Human Quality Assessment
     - Overall "does this sound like AI?" gut check
     - Natural flow and rhythm
     - Specific examples and opinions present

5. Output Format:
   - PASS or FAIL verdict
   - FAIL issues with line numbers and fixes
   - WARN issues with recommendations
   - Suggested pattern for common-mistakes.md (if recurring issue)

6. Failure Workflow:
   - Auto-retry once: Apply specific fixes, re-validate
   - If still fails: Flag for human review with issues list
   - Pattern suggestion: If same issue appears 3+ times, suggest addition to common-mistakes.md

7. How This Connects:
   - Input from: /direct-response-copy (04-final.md)
   - Output to: PASS (ready to publish) or FAIL (needs fixes)
   - Feeds: common-mistakes.md (pattern suggestions)

Follow the existing SKILL.md conventions (frontmatter, phases, output format, connections, test section).

ONCE COMPLETE: Write a summary below the Task 6 section in PLAN.md
```

### Summary

**Completed:** Created `.claude/skills/validate-content/SKILL.md`

**What it does:**
- 3-phase validation: Universal Rules → Client Profile → Human Quality
- Checks all 53 banned AI words, AI phrases, AI patterns
- Verifies UK English spelling (24 US→UK pairs)
- Validates SEO requirements (keyword placement, word count, meta data, links, structure)
- Checks client profile for brand voice, terminology, avoided words/topics
- Human quality assessment (AI detection, natural flow, specific examples)

**Output format:**
- PASS/FAIL verdict with line-specific issues
- Each FAIL issue includes line number, problem, and fix
- WARN issues for quality improvements
- SEO checklist with checkbox status
- Pattern suggestion for common-mistakes.md (if recurring issue)

**Failure workflow:**
- Auto-retry once with specific fixes
- If still fails, escalate to human review
- Suggests patterns for common-mistakes.md when same issue appears 3+ times

**Skill is now registered** and shows in available skills list with trigger: "validate this content, check this article, validate content, content check, is this ready to publish, check for AI words"

---

## Task 7: E2E - Onboard Client

### What
Run `/onboard-client` to create a complete client profile for testing the workflow.

### Input
- Your business details (provided during interview)

### Output
- `/clients/{name}/profile.md`

### Starter Prompt
```
Run /onboard-client to create a client profile.

This is Task 7 of the end-to-end test. I'll provide my business details.

Save the profile to /clients/{name}/profile.md

ONCE COMPLETE: Write a handoff note below Task 7 in PLAN.md with:
- Client name used
- Profile file location
- Any notes for keyword research
```

### Handoff
[To be completed after task execution]

---

## Task 8: E2E - Keyword Research

### What
Run `/keyword-research` using the client profile to generate a keyword brief.

### Input
- `/clients/{name}/profile.md` (from Task 7)

### Output
- `/projects/{name}/{project}/01-keyword-brief.md`

### Starter Prompt
```
Run /keyword-research for the end-to-end test.

This is Task 8. Read the handoff from Task 7 in PLAN.md for client details.

Input: [CLIENT PROFILE PATH FROM TASK 7 HANDOFF]

Save output to /projects/{name}/{project}/01-keyword-brief.md

ONCE COMPLETE: Write a handoff note below Task 8 in PLAN.md with:
- Primary keyword selected
- Brief file location
- Any notes for positioning
```

### Handoff
[To be completed after task execution]

---

## Task 9: E2E - Positioning Angles

### What
Run `/positioning-angles` to find the hook that differentiates.

### Input
- `/clients/{name}/profile.md` (from Task 7)
- `/projects/{name}/{project}/01-keyword-brief.md` (from Task 8)

### Output
- `/projects/{name}/{project}/02-positioning-brief.md`

### Starter Prompt
```
Run /positioning-angles for the end-to-end test.

This is Task 9. Read the handoffs from Tasks 7 and 8 in PLAN.md.

Inputs:
- Client profile: [PATH FROM TASK 7]
- Keyword brief: [PATH FROM TASK 8]

Save output to /projects/{name}/{project}/02-positioning-brief.md

ONCE COMPLETE: Write a handoff note below Task 9 in PLAN.md with:
- Chosen angle/hook
- Brief file location
- Any notes for content writing
```

### Handoff
[To be completed after task execution]

---

## Task 10: E2E - SEO Content

### What
Run `/seo-content` to write the draft article (1,500+ words).

### Input
- `/clients/{name}/profile.md` (from Task 7)
- `/projects/{name}/{project}/02-positioning-brief.md` (from Task 9)

### Output
- `/projects/{name}/{project}/03-draft.md`

### Starter Prompt
```
Run /seo-content for the end-to-end test.

This is Task 10. Read the handoffs from Tasks 7 and 9 in PLAN.md.

Inputs:
- Client profile: [PATH FROM TASK 7]
- Positioning brief: [PATH FROM TASK 9]
- Primary keyword: [FROM TASK 8 HANDOFF]

Write a 1,500+ word SEO article following universal-rules.md.

Save output to /projects/{name}/{project}/03-draft.md

ONCE COMPLETE: Write a handoff note below Task 10 in PLAN.md with:
- Word count achieved
- Draft file location
- Any concerns for direct response pass
```

### Handoff
[To be completed after task execution]

---

## Task 11: E2E - Direct Response Copy

### What
Run `/direct-response-copy` to add conversion elements to the draft.

### Input
- `/clients/{name}/profile.md` (from Task 7)
- `/projects/{name}/{project}/03-draft.md` (from Task 10)

### Output
- `/projects/{name}/{project}/04-final.md`

### Starter Prompt
```
Run /direct-response-copy for the end-to-end test.

This is Task 11. Read the handoffs from Tasks 7 and 10 in PLAN.md.

Inputs:
- Client profile: [PATH FROM TASK 7]
- Draft article: [PATH FROM TASK 10]

Add conversion elements (CTAs, hooks, persuasion) while maintaining SEO.

Save output to /projects/{name}/{project}/04-final.md

ONCE COMPLETE: Write a handoff note below Task 11 in PLAN.md with:
- Final file location
- Conversion elements added
- Ready for validation
```

### Handoff
[To be completed after task execution]

---

## Task 12: E2E - Validate Content

### What
Run `/validate-content` to check the final article against rules and profile.

### Input
- `/.claude/rules/universal-rules.md`
- `/clients/{name}/profile.md` (from Task 7)
- `/projects/{name}/{project}/04-final.md` (from Task 11)
- Primary keyword (from Task 8 handoff)

### Output
- PASS or FAIL with specific issues

### Starter Prompt
```
Run /validate-content for the end-to-end test.

This is Task 12 (final task). Read all handoffs from Tasks 7-11 in PLAN.md.

Inputs:
- Universal rules: /.claude/rules/universal-rules.md
- Client profile: [PATH FROM TASK 7]
- Final article: [PATH FROM TASK 11]
- Primary keyword: [FROM TASK 8 HANDOFF]

Validate and output PASS/FAIL with line-specific issues.

ONCE COMPLETE: Write final summary below Task 12 in PLAN.md with:
- Validation result (PASS/FAIL)
- Issues found (if any)
- Overall workflow assessment
- Improvements needed for production use
```

### Summary
[To be completed after task execution]

---

## How to Use This Plan

1. Copy the **Starter Prompt** for the current task
2. Open new Claude session
3. Paste the prompt
4. Complete the task
5. Run the test
6. Update status in this file (⬜ → ✅)
7. Move to next task
