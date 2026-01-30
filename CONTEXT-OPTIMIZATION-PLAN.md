# Context Window Optimization Plan

**Status:** IMPLEMENTED
**Problem:** Article workflow exhausts context window before completion
**Goal:** 81% reduction in context consumption per article (280-320KB → 53KB)
**Implemented:** 2026-01-30

---

## Implementation Results

| File | Before | After | Reduction |
|------|--------|-------|-----------|
| `.claude/claude.md` | 27KB | 8.1KB | 70% |
| `.claude/agents.md` | 30KB | 6.3KB | 79% |
| `.claude/rules/humanise-rules.md` | (new) | 12KB | Single source of truth |
| `.claude/context/*.md` | (new) | 8KB total | Skill-specific context |

**Total documentation: ~35KB** (down from 141KB read multiple times)

### Files Created
- `.claude/rules/humanise-rules.md` - Single source of truth for ALL content rules
- `.claude/context/keyword-research-context.md`
- `.claude/context/positioning-angles-context.md`
- `.claude/context/seo-content-context.md`
- `.claude/context/direct-response-context.md`

### Files Deprecated (renamed to -reference)
- `.claude/humanise-content-reference.md`
- `.claude/skills/write-article-reference.md`

### Gap Fixes Applied
1. Conversion rules (36+ patterns) added to humanise-rules.md Section 8
2. Thresholds consolidated into humanise-rules.md Section 7
3. Pre-writing mandates added to all SKILL.md files
4. Gate scripts now reference humanise-rules.md as source of truth

---

## The Problem

Current workflow consumes **~280-320KB** of context per article:

| File | Size | Times Read | Total Context |
|------|------|------------|---------------|
| `.claude/claude.md` | 27KB | 1 (auto-loaded) | 27KB |
| `.claude/agents.md` | 30KB | 3-4 times | ~100KB |
| `.claude/skills/write-article.md` | 44KB | 4 times | ~176KB |
| `.claude/humanise-content.md` | 40KB | 2-3 times | ~100KB |
| **TOTAL** | | | **~280-320KB** |

**Root causes:**
1. `write-article.md` (44KB) is read before EVERY skill invocation
2. `humanise-content.md` (40KB) is re-parsed by multiple gates
3. Massive duplication across claude.md, agents.md, and write-article.md
4. Skills read entire documentation when they only need specific sections
5. **Rules exist in TWO places** (documentation AND scripts) with no single source of truth

**The "Forever Fixing Loop" Problem:**
If skills don't know the rules upfront, they write content → gate fails → fix → gate fails again → repeat. Gates should be a **safety net**, not the primary teacher. Skills must have enough context to write correctly the FIRST time.

**What's working well (preserve):**
- `generate-research-summary.sh` creates 2.7KB from 30KB research (90% reduction)
- Gate scripts are targeted and enforce rules automatically
- E-E-A-T citations auto-pulled into summaries

---

## Proposed Solution

### Core Principle: Single Source of Truth

**Problem:** Rules currently exist in two places that can drift apart:
- `humanise-content.md` (40KB) - documentation for writers
- `master-gate.sh` (40KB) - enforcement via regex patterns

If these diverge, skills follow outdated rules and gates catch violations they didn't know about.

**Solution:** Create ONE authoritative rules file that BOTH skills and gates reference:

```
.claude/rules/humanise-rules.md  ← Single source of truth
        ↓                    ↓
   Skills READ          Gates ENFORCE
   (before writing)     (after writing)
```

**Critical change in philosophy:**
- OLD: "Gates will catch errors" → forever fixing loop
- NEW: "Skills know rules upfront, gates verify" → write correctly first time

This means:
1. `/seo-content` skill MUST read `humanise-rules.md` BEFORE writing
2. Gate scripts verify compliance, but skills already know what's required
3. Gates become a safety net, not the primary teacher

---

### Phase 1: Create Skill-Specific Context Files

Create `.claude/context/` directory with 4 focused files (~11KB total):

#### `keyword-research-context.md` (~3KB)
```markdown
# Keyword Research Context

## Input Requirements
- Seed keyword from ARTICLE-ORDER.md
- Pillar topic and article type

## Perplexity MCP Queries (4 Required)
1. Keyword validation + trends
2. PAA discovery (7+ questions)
3. Competitor SERP analysis
4. Research source discovery

## Output Requirements
- perplexityUsed: true
- Target keyword validated
- Secondary keywords (5+)
- PAA questions (7+)
- Competitor gaps (3+)
- Research sources with URLs

## After Skill
1. Update keyword-library.md
2. Run: .claude/scripts/check-keyword-gate.sh [research-file]
3. MUST show KEYWORD GATE: PASS
```

#### `positioning-angles-context.md` (~2KB)
```markdown
# Positioning Angles Context

## Input
Read: .claude/scratchpad/research-summary.md (NOT full research file)

## Check Before Running
- angle-library.md for patterns already used
- Avoid reusing within same pillar

## Output
- 3-5 angle options with:
  - One sentence angle
  - Psychology/reasoning
  - Headline direction

## After Skill
1. Select ONE angle
2. Update research file frontmatter
3. Update angle-library.md
4. Run: .claude/scripts/check-angle-gate.sh [research-file]
```

#### `seo-content-context.md` (~5KB)
```markdown
# SEO Content Context

## MANDATORY: Read Before Writing
1. .claude/scratchpad/research-summary.md (article data)
2. .claude/rules/humanise-rules.md (content rules)

Without reading humanise-rules.md, you WILL fail the content gate.

## CRITICAL: Verify Libraries First
- keyword-library.md MUST have entry for this article
- angle-library.md MUST have entry for this article
STOP if either is missing.

## Word Counts
- Hub: 3000+ words (target 3500-4000)
- Cluster: 1500+ words (target 2000-2500)

## Required Elements
- HushAway® in intro (first 500 words)
- HushAway® in 50%+ of H2 sections
- Community quotes: 2 hub / 1 cluster
- Dated citations: 3 hub / 2 cluster
- Curiosity loops: 2 hub / 1 cluster
- Internal links: 8-10 hub / 4-6 cluster

## Content Rules Summary (full list in humanise-rules.md)
- Zero tolerance: navigate, delve, landscape, leverage, comprehensive, robust, vital, crucial
- Frequency limits: specifically (max 2), helpful (max 3), very (max 3)
- Required: contractions, And/But starters, "we" language
- Forbidden: emojis, em-dashes, American spellings

## After Skill
Run: .claude/scripts/master-gate.sh [article] [hub|cluster]
```

#### `direct-response-context.md` (~2KB)
```markdown
# Direct Response Copy Context

## Input
Read: .claude/scratchpad/research-summary.md

## Purpose
Review article for conversion effectiveness AFTER Content Gate passes.

## 7 Conversion Checks
1. Objection handling (2+ of 4)
2. CTA clarity ("free forever")
3. Low-friction (no "trial", "subscribe")
4. Differentiation (neurodivergent-first)
5. HushAway® prominence (5+ mentions)
6. Sound Sanctuary CTA (2+ mentions)
7. Risk reversal

## After Skill
Run: .claude/scripts/check-conversion-gate.sh [article]
```

---

### Phase 2: Create Authoritative Rules File

Create `.claude/rules/humanise-rules.md` (~6KB) - **THE single source of truth for content rules:**

```markdown
# Humanise Content Rules

**This file is the SINGLE SOURCE OF TRUTH.** Skills read this BEFORE writing. Gates verify AFTER writing.

## Zero Tolerance Words (0 allowed)

These words immediately flag content as AI-written. Never use them.

**AI-isms:**
navigate, delve, landscape, leverage, comprehensive, robust, crucial, vital,
realm, multifaceted, paradigm, synergy, harness, unlock, empower, straightforward,
seamless, utilize, facilitate, optimal, plethora, myriad, pivotal, foster, bolster,
moreover, furthermore, hence, thus, consequently, nevertheless, nonetheless,
firstly, secondly, thirdly, aforementioned, coupled with, in essence, certainly,
undoubtedly, remarkably, notably, evidently, interestingly, additionally

**Hyperbolic:** amazing, literally, obviously

**Deficit language:** fix, cure, normal, suffering from, special needs

**Clinical terms:** disorder, patient, treatment, symptoms

**American English:** mom, color, behavior (use UK: mum, colour, behaviour)

## Frequency Limits (Per Article)

| Word | Max | Word | Max |
|------|-----|------|-----|
| specifically | 2 | particularly | 2 |
| significant | 2 | helpful | 3 |
| designed to/for | 3 | effective | 2 |
| various | 1 | numerous | 1 |
| ensure | 2 | key | 2 |
| unique | 1 | tailored | 1 |
| important | 3 | essential | 2 |
| very | 3 | really | 2 |
| truly | 1 | highly | 2 |
| extremely | 1 | definitely | 1 |
| absolutely | 1 | incredible | 1 |

## Human Voice (Required)

Without these, content sounds robotic:
- Contractions: 2+ per 500 words (you're, it's, don't)
- And/But starters: 2+ per article
- "We" language: 2+ per article
- Community quotes: 2 hub / 1 cluster
- Short sentences (<8 words): 1+ per H2 section

## Brand Rules

- HushAway® (always with ®, never plain "HushAway")
- UK English throughout
- No emojis anywhere
- No em-dashes (use commas, full stops, semicolons)

## Use Instead Reference

| Banned | Use Instead |
|--------|-------------|
| navigate | work with, support, help |
| delve | look at, explore, dig into |
| comprehensive | complete, full, thorough |
| leverage | use, apply |
| crucial/vital | important, key |
| utilize | use |
| ensure | make sure |
| various/numerous | different, several, many |
```

**Why this file matters:**
- `/seo-content` skill reads this BEFORE writing = fewer gate failures
- `master-gate.sh` enforces these exact rules = no drift
- Writers understand WHY words are banned = better choices

---

### Phase 3: Slim Master Files

#### `.claude/claude.md` (27KB → 15KB)

**REMOVE:**
- 6-gate workflow diagram (duplicates agents.md)
- Step-by-step gate commands (in agents.md)
- Enforcement Summary table (gates enforce automatically)
- Context Optimization section (skills read context files)
- Conversion Requirements detail (in direct-response-context.md)
- Human Voice Guidelines (gates enforce automatically)
- Mid-Article Engagement section (in seo-content-context.md)

**KEEP:**
- Quick Reference (Critical Rules)
- Brand Voice
- HushAway® Product
- Signature Phrases
- Content Requirements (word counts, structure)
- Research Citations style
- E-E-A-T guidance
- URL Structure
- Skills Available (list only)

#### `.claude/agents.md` (30KB → 8KB)

**TRANSFORM TO:**
```markdown
# HushAway Article Workflow

## 6-Gate Diagram
[Keep the workflow diagram]

## Gate Commands
| Gate | Command | When |
|------|---------|------|
| 1. Keyword | check-keyword-gate.sh | After /keyword-research |
| 2. Research | check-research-gate.sh | After research complete |
| 3. Angle | check-angle-gate.sh | After /positioning-angles |
| 4. Content | master-gate.sh [hub|cluster] | After /seo-content |
| 5. Conversion | check-conversion-gate.sh | After /direct-response-copy |
| 6. Final | check-final-gate.sh | Before export |

## Quick Start
0. Run /orchestrator
1. Select article from ARTICLE-ORDER.md
2. Run /keyword-research → Keyword Gate
3. Complete research → Research Gate
4. Run generate-research-summary.sh
5. Run /positioning-angles → Angle Gate
6. Run /seo-content → Content Gate
7. Run /direct-response-copy → Conversion Gate
8. Final Gate → Export

## Skills Read Context Files
Skills read .claude/context/[skill]-context.md instead of this file.
```

**REMOVE:**
- Step-by-step instructions for each gate
- Detailed explanations of what gates check
- File structure section
- Skills Reference details
- Common Issues section

#### `.claude/skills/write-article.md` (44KB → 0KB)

**DEPRECATE:** Rename to `write-article-reference.md`

This becomes a reference-only file, NOT read during workflow.

---

### Phase 4: Enhance Research Summary

Update `generate-research-summary.sh` to include:
- Word count targets (hub/cluster)
- Required element counts (quotes, citations, links)
- Brand prominence reminders
- Human voice requirements

Makes the summary self-contained for writing skills.

---

### Phase 5: Update Skill SKILL.md Files

Each skill file adds one line:
```markdown
Read `.claude/context/[skill]-context.md` for HushAway-specific requirements.
```

Update these files:
- `.claude/skills/keyword-research/SKILL.md`
- `.claude/skills/positioning-angles/SKILL.md`
- `.claude/skills/seo-content/SKILL.md`
- `.claude/skills/direct-response-copy/SKILL.md`

---

## Expected Results

### Context Consumption After Optimization

| File | Size | Times Read | Total Context |
|------|------|------------|---------------|
| `.claude/claude.md` (slim) | 15KB | 1 | 15KB |
| `.claude/agents.md` (slim) | 8KB | 1 | 8KB |
| `.claude/context/*.md` | 12KB | 1 each | 12KB |
| `.claude/scratchpad/research-summary.md` | 3KB | 4 | 12KB |
| `.claude/rules/humanise-rules.md` | 6KB | 1 | 6KB |
| **TOTAL** | | | **~53KB** |

**Reduction: 280-320KB → 53KB = 81%**

**Key difference:** Skills now read rules BEFORE writing, so they write correctly the first time. This may add 1-2 remediation cycles in edge cases vs. 3-5 cycles without upfront rules.

---

## Implementation Checklist

### Step 1: Create Directory Structure
```bash
mkdir -p .claude/context
mkdir -p .claude/rules
```
- [ ] `.claude/context/` directory created
- [ ] `.claude/rules/` directory created

### Step 2: Create Authoritative Rules File (SINGLE SOURCE OF TRUTH)
- [ ] `.claude/rules/humanise-rules.md` - Create with full content from Phase 2 above

### Step 3: Create Skill-Specific Context Files
- [ ] `.claude/context/keyword-research-context.md` - Create with content from Phase 1
- [ ] `.claude/context/positioning-angles-context.md` - Create with content from Phase 1
- [ ] `.claude/context/seo-content-context.md` - Create with content from Phase 1 (MUST include mandatory rules read)
- [ ] `.claude/context/direct-response-context.md` - Create with content from Phase 1

### Step 4: Slim Master Files
- [ ] `.claude/claude.md` - Remove duplicated sections (27KB → 15KB)
  - Remove: 6-gate workflow diagram, step-by-step gate commands, Enforcement Summary table, Context Optimization section, Conversion Requirements detail, Human Voice Guidelines, Mid-Article Engagement
  - Keep: Quick Reference, Brand Voice, HushAway® Product, Signature Phrases, Content Requirements, Research Citations, E-E-A-T, URL Structure, Skills list
- [ ] `.claude/agents.md` - Transform to compact format (30KB → 8KB)
  - Keep: 6-Gate Diagram, Gate Commands table, Quick Start checklist
  - Remove: Detailed instructions, explanations, file structure, skills reference details

### Step 5: Update Skill SKILL.md Files
Add this line to each skill file:
```markdown
Read `.claude/context/[skill]-context.md` for HushAway-specific requirements.
```
- [ ] `.claude/skills/keyword-research/SKILL.md` - Add context file pointer
- [ ] `.claude/skills/positioning-angles/SKILL.md` - Add context file pointer
- [ ] `.claude/skills/seo-content/SKILL.md` - Add context file pointer
- [ ] `.claude/skills/direct-response-copy/SKILL.md` - Add context file pointer

### Step 6: Deprecate Old Files
- [ ] Rename `.claude/skills/write-article.md` → `.claude/skills/write-article-reference.md`
- [ ] Rename `.claude/humanise-content.md` → `.claude/humanise-content-reference.md`

### Step 7: Verify Implementation
- [ ] Test full 6-gate workflow on new article
- [ ] Confirm context stays under 60KB for documentation
- [ ] Verify all gates still pass
- [ ] Confirm skills get correct context from new files
- [ ] **Verify /seo-content reads humanise-rules.md BEFORE writing** (check tool calls)
- [ ] **Confirm first-pass gate success rate improves** (fewer remediation cycles)
- [ ] **Audit: Rules in humanise-rules.md match regexes in master-gate.sh**

---

## Complete File Manifest

### Files to CREATE (6 files)

| File Path | Size | Purpose |
|-----------|------|---------|
| `.claude/rules/humanise-rules.md` | ~6KB | **SINGLE SOURCE OF TRUTH** for all content rules |
| `.claude/context/keyword-research-context.md` | ~3KB | Context for /keyword-research skill |
| `.claude/context/positioning-angles-context.md` | ~2KB | Context for /positioning-angles skill |
| `.claude/context/seo-content-context.md` | ~5KB | Context for /seo-content skill (includes MANDATORY rules read) |
| `.claude/context/direct-response-context.md` | ~2KB | Context for /direct-response-copy skill |

### Files to MODIFY (6 files)

| File Path | Current Size | Target Size | Action |
|-----------|--------------|-------------|--------|
| `.claude/claude.md` | 27KB | 15KB | Remove duplicated sections |
| `.claude/agents.md` | 30KB | 8KB | Transform to compact format |
| `.claude/skills/keyword-research/SKILL.md` | varies | +1 line | Add context file pointer |
| `.claude/skills/positioning-angles/SKILL.md` | varies | +1 line | Add context file pointer |
| `.claude/skills/seo-content/SKILL.md` | varies | +1 line | Add context file pointer |
| `.claude/skills/direct-response-copy/SKILL.md` | varies | +1 line | Add context file pointer |

### Files to RENAME (2 files)

| From | To | Reason |
|------|-----|--------|
| `.claude/skills/write-article.md` | `.claude/skills/write-article-reference.md` | Deprecate - reference only |
| `.claude/humanise-content.md` | `.claude/humanise-content-reference.md` | Deprecate - rules file is now authoritative |

---

## Questions Resolved

1. **Should we keep `humanise-content.md` as reference, or fully replace with compact version?**
   → Keep as reference (`humanise-content-reference.md`), but `humanise-rules.md` is the authoritative source. The reference file explains WHY; the rules file lists WHAT.

2. **Should context files be auto-generated from master files, or maintained separately?**
   → **Maintain separately.** Auto-generation creates hidden dependencies and drift risk. Single source of truth is clearer: edit `humanise-rules.md` → both skills and gates use it.

3. **Are there other files being read that we haven't identified?**
   → Explore agent confirmed main consumers. May need to audit after implementation.

4. **Should we add context consumption logging to track improvements?**
   → Yes, but as a future enhancement. Focus on reduction first.

---

## Gap Fixed: "Forever Fixing Loop"

**Original gap:** Phase 2 said "Gate Handles Everything Else - Do not manually check what the gate checks."

**Problem:** This creates a fix-fail-fix loop because skills don't know rules upfront.

**Solution applied:**
1. Added "Single Source of Truth" principle section
2. Changed `humanise-rules-compact.md` → `humanise-rules.md` (authoritative, not reference)
3. Updated `seo-content-context.md` to MANDATE reading rules file before writing
4. Added content rules summary in context file for quick reference
5. Changed philosophy: "Skills know rules upfront, gates verify" not "gates will catch it"

**Expected outcome:** Skills write correctly the first time. Gates catch edge cases, not obvious violations.

---

---

## Verification Test Plan

### Test 1: Context Consumption Check
After implementation, run a new article through the workflow and verify:
```
Expected reads:
- .claude/claude.md (15KB) x1 = 15KB
- .claude/agents.md (8KB) x1 = 8KB
- .claude/context/*.md (12KB) x1 = 12KB
- .claude/scratchpad/research-summary.md (3KB) x4 = 12KB
- .claude/rules/humanise-rules.md (6KB) x1 = 6KB
TOTAL: ~53KB (vs 280-320KB before)
```

### Test 2: First-Pass Gate Success
Run /seo-content and check:
- [ ] Content Gate passes on 1st or 2nd attempt (not 3-5)
- [ ] No "unknown rule" violations
- [ ] Banned words caught by skill, not gate

### Test 3: Rules Consistency Audit
Compare `.claude/rules/humanise-rules.md` against `.claude/scripts/master-gate.sh`:
- [ ] All banned words in rules file appear in gate script
- [ ] All frequency limits match between files
- [ ] No rules in gate script missing from rules file

### Test 4: Skill Context Loading
Verify each skill reads its context file:
- [ ] /keyword-research reads `keyword-research-context.md`
- [ ] /positioning-angles reads `positioning-angles-context.md`
- [ ] /seo-content reads `seo-content-context.md` AND `humanise-rules.md`
- [ ] /direct-response-copy reads `direct-response-context.md`

---

## Rollback Plan

If issues occur after implementation:

1. **Restore renamed files:**
   ```bash
   mv .claude/skills/write-article-reference.md .claude/skills/write-article.md
   mv .claude/humanise-content-reference.md .claude/humanise-content.md
   ```

2. **Keep new files** (they don't break anything)

3. **Revert claude.md and agents.md** from git:
   ```bash
   git checkout -- .claude/claude.md .claude/agents.md
   ```

---

## Notes

_Plan updated 2026-01-30:_
- Added single source of truth principle and mandatory rules reading to prevent forever-fixing loop
- Added complete file manifest with CREATE/MODIFY/RENAME sections
- Added 7-step implementation checklist with bash commands
- Added verification test plan with 4 specific tests
- Added rollback plan for safety
- Changed status to "Ready for Implementation"
