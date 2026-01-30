# HushAway®: Article Writing Workflow

**ALWAYS START WITH `/orchestrator`** - It diagnoses the optimal approach and routes to the right skills.

**Content rules:** `.claude/rules/humanise-rules.md` (single source of truth)
**Skill context files:** `.claude/context/[skill]-context.md`

---

## 6-Gate Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         6-GATE CONTENT WORKFLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

═══════════════════════════════════ SESSION 1 ═══════════════════════════════════

STEP 0: Run /orchestrator ──────────── Entry point: diagnoses needs, routes to skills
           │
STEP 1: Choose Article ─────────────── Select from ARTICLE-ORDER.md
           │
STEP 2: Run /keyword-research ──────── Validate keywords + Perplexity MCP
           │
           ▼
    ┌──────────────┐
    │ KEYWORD GATE │ ← Gate 1: check-keyword-gate.sh
    └──────────────┘
           │
STEP 3: Complete Research
           │
           ▼
    ┌──────────────┐
    │ RESEARCH GATE│ ← Gate 2: check-research-gate.sh
    └──────────────┘
           │
STEP 3b: generate-research-summary.sh ── Creates compact summary
           │
STEP 4: Run /positioning-angles ───── Generates options (does NOT select)
           │
    ══════════════════════════════ END SESSION 1 ══════════════════════════════

═══════════════════════════════════ SESSION 2 ═══════════════════════════════════
           │
STEP 5a: Select Angle ─────────────── Writer picks from generated options
           │
           ▼
    ┌──────────────┐
    │  ANGLE GATE  │ ← Gate 3: check-angle-gate.sh
    └──────────────┘
           │
STEP 5b: Write with /seo-content
           │
           ▼
    ┌──────────────┐
    │ CONTENT GATE │ ← Gate 4: master-gate.sh (23 checks)
    └──────────────┘
           │
STEP 6a: Run /direct-response-copy ─── Skill FIRST
STEP 6b: Run check-conversion-gate.sh ── Script SECOND
           │
           ▼
    ┌────────────────┐
    │ CONVERSION GATE│ ← Gate 5: 7 conversion checks
    └────────────────┘
           │
           ▼
    ┌──────────────┐
    │  FINAL GATE  │ ← Gate 6: check-final-gate.sh
    └──────────────┘
           │
STEP 7: Preview & Export
```

---

## Gate Commands

| Gate | Script | When | Exit |
|------|--------|------|------|
| 1. Keyword | `check-keyword-gate.sh [research]` | After /keyword-research | 0=PASS |
| 2. Research | `check-research-gate.sh [research]` | After research complete | 0=PASS |
| 3. Angle | `check-angle-gate.sh [research]` | After /positioning-angles | 0=PASS |
| 4. Content | `master-gate.sh [article] [hub\|cluster]` | After /seo-content | 0=PASS |
| 5. Conversion | `check-conversion-gate.sh [article]` | After /direct-response-copy | 0=PASS |
| 6. Final | `check-final-gate.sh [article] [hub\|cluster]` | Before export | 0=PASS |

**ALL 6 GATES MUST PASS. NO EXCEPTIONS.**

---

## Quick Start

**SESSION 1 (Research):**
0. Run `/orchestrator` → Entry point
1. Select article from `ARTICLE-ORDER.md`
2. Read `.claude/keyword-library.md` for existing keywords
3. Run `/keyword-research` → **Keyword Gate MUST PASS**
4. Complete research → **Research Gate MUST PASS**
5. Run `generate-research-summary.sh [research-file]`
6. Read `.claude/angle-library.md` for angles used
7. Run `/positioning-angles` (generates options, saves to files)
8. **STOP** - Start new session for writing

**SESSION 2 (Writing):**
9. Read research-summary.md → Select angle from options
10. Update libraries + run **Angle Gate MUST PASS**
11. Run `/seo-content` → **Content Gate MUST PASS**
12. Run `/direct-response-copy` (skill first)
13. Run `check-conversion-gate.sh` (script second) → **Conversion Gate MUST PASS**
14. Run `check-final-gate.sh` → **Final Gate MUST PASS**
15. Preview with `npm run dev`
16. Export to main website

---

## Skill Context Files

Skills read `.claude/context/[skill]-context.md` for HushAway-specific requirements:

| Skill | Context File |
|-------|--------------|
| /keyword-research | `keyword-research-context.md` |
| /positioning-angles | `positioning-angles-context.md` |
| /seo-content | `seo-content-context.md` |
| /direct-response-copy | `direct-response-context.md` |

**CRITICAL:** `/seo-content` MUST read `.claude/rules/humanise-rules.md` before writing.

---

## Enforcement Rules

1. **All gates automated** - Every gate has a script
2. **No partial passes** - ALL checks must pass
3. **No skipping gates** - Run in sequence
4. **No exceptions** - Every article, every time
5. **Skills mandatory** - All 4 workflow skills must run
6. **Gate 5 requires BOTH** - Skill first, then script

---

## Research Summary (Mandatory)

After Research Gate passes:
```bash
.claude/scripts/generate-research-summary.sh [research-file]
```

Creates compact summary at `.claude/scratchpad/research-summary.md` (90% smaller).
Skills read summary instead of full research file to prevent context exhaustion.

---

## Remediation

If any gate shows FAIL:
1. Review failures in output
2. Fix ALL failures in article
3. Re-run script (NOT the skill)
4. Repeat until PASS

Use `--remediate` flag to suppress verbose output on re-runs:
```bash
.claude/scripts/master-gate.sh [article] [hub|cluster] --remediate
.claude/scripts/check-conversion-gate.sh [article] --remediate
```

---

## File Locations

```
Articles:     /src/content/pillar-[N]-[topic-name]/
Research:     /research/pillar-[N]-[topic-name]/
Context:      /.claude/context/
Rules:        /.claude/rules/humanise-rules.md (single source of truth)
Libraries:    /.claude/keyword-library.md, /.claude/angle-library.md
Scripts:      /.claude/scripts/
```

---

## Skills (Mandatory Order)

| Step | Skill | Gate |
|------|-------|------|
| 0 | /orchestrator | - |
| 2 | /keyword-research | Keyword Gate |
| 4 | /positioning-angles | Angle Gate |
| 5 | /seo-content | Content Gate |
| 6 | /direct-response-copy | Conversion Gate |

Other skills: `/brand-voice`, `/email-sequences`, `/content-atomizer`, `/newsletter`, `/lead-magnet`
