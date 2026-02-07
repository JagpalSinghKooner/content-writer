# Workflow Optimisation: Agent Context Loading & Output Quality

## Context

Both the main orchestration session and individual agents hit context limits during 8-12 article pillar execution. Output quality is mixed across all dimensions (AI-sounding, missed SEO targets, wrong brand voice, structural issues). Root cause: agents load skills bloated with duplicated content, tables, ASCII diagrams, motivational intros, and reference material that should live elsewhere. This plan strips everything that doesn't need to be in the loaded context path.

**Scope:** Phase 1 (this plan) covers pipeline-critical files: agents, their skills, execute-pillar, workflow.md. Phase 2 (separate session) covers interactive skills, templates, and references.

---

## Principles

- No tables or ASCII diagrams anywhere — AI doesn't need visual formatting
- No motivational intros or "why" explanations — start with directives
- No duplicated content — single source of truth, reference it instead of repeating it
- Skills and agents serve the same audience — strip both equally
- Extract reference material to on-demand files not auto-loaded by agents

---

## Expected Impact

**Before:** ~91,554 lines loaded across an 8-article pillar with 3 retries
**After:** ~52,000 lines (estimated 43% reduction)

Biggest wins:
- direct-response-copy skill: 2,217 → ~590 lines (73% cut, 1,627 lines of frameworks extracted)
- seo-content skill: 995 → ~400 lines (60% cut, template/workflow/rules duplication removed)
- Content Validator agent: 585 → ~210 lines (64% cut, phase duplication with skill removed)
- Retry loop: copy-fixer at ~150 lines replaces full copy-enhancer at ~2,500 lines (87% per retry)
- execute-pillar: 791 → ~500 lines (37% cut, ASCII diagrams + duplicate checklists removed)

---

## Phase A: Create New Files (no dependencies)

### A1. Create `references/copywriting-frameworks.md` (~1,627 lines)

**Source:** `skills/direct-response-copy/SKILL.md` lines 583-2217

Everything after the `# REFERENCE MATERIAL` marker moves here:
- Classic Direct Response Frameworks (Schwartz, Hopkins, Ogilvy, Halbert, Caples, Sugarman, Collier)
- Headline Formulas and Examples
- Opening Lines and Hooks
- Curiosity Gaps and Open Loops (extended)
- Flow Techniques: The Slippery Slide (extended)
- Modern Internet-Native Copy Examples

Remove all tables from extracted content, convert to flat lists. This file is NOT auto-loaded by any agent. Available for interactive `/direct-response-copy` use only.

### A2. Create `skills/seo-content/references/eeat-patterns.md` (~80 lines)

**Source:** Condensed from `skills/seo-content/references/eeat-examples.md` (654 lines)

No tables. Use headings + bullets:
- 7 Universal Patterns (from eeat-examples.md lines 567-591)
- 5 Questions Before Writing (lines 594-604)
- Red Flags (lines 608-616)
- 20 authors as `### Author Name` + 3 bullets each (vertical, key pattern, steal-this technique)

Keep `eeat-examples.md` intact for interactive skill use. SEO Writer agent references `eeat-patterns.md` instead.

### A3. Create `agents/copy-fixer.md` (~150 lines, NEW agent)

Lightweight agent for validation fix retries. Replaces full Copy Enhancer in retry loop.

**Frontmatter:**
```yaml
name: copy-fixer
description: Fix specific validation issues in articles. Use after content-validator returns FAIL. Reads validation file and applies targeted fixes only.
tools: Read, Edit
model: sonnet
```

No `skills:` field — saves loading entire direct-response-copy skill (2,217 lines).

**Contents (extracted from copy-enhancer.md):**
- Read validation file workflow (current copy-enhancer lines 176-238)
- Banned words reference: "Read `.claude/references/banned-words-phrases.md` for the 53 banned words"
- Em dash removal with 3-4 inline restructuring examples (no table)
- Common fix types as flat list: US→UK spelling, banned phrases→rewrites, AI patterns→restructure
- Return format: `PASS` or `FAIL: {reason}`

**Reference files loaded:** banned-words-phrases.md (183 lines) + uk-english-patterns.md (96 lines) = 279 lines total context. Down from 2,974 = 87% reduction.

### A4. Create `references/execute-pillar-troubleshooting.md` (~34 lines)

**Source:** Extracted from `skills/execute-pillar/SKILL.md` lines 756-789

Covers: agent not spawning, validation loop never passes, git conflicts, context running low.

---

## Phase B: Slim Skills (depends on Phase A)

### B1. Slim `skills/direct-response-copy/SKILL.md` (2,217 → ~590 lines)

**Remove:**
- Lines 583-2217: everything after `# REFERENCE MATERIAL` (moved to `references/copywriting-frameworks.md`)
- Motivational intro (lines 8-16): "Here's what separates copy that converts..."
- All tables (CTA comparison at line 381, Voice markers at line 2186) — convert to flat lists
- Duplicate content already covered in first 580 lines (headlines, openings, curiosity, flow all have complete versions already)

**Add:**
- Start with: "Your job is to write copy that sounds like a smart friend explaining something while deploying persuasion principles the reader doesn't notice."
- One-line reference: "For extended frameworks, headline formulas, and examples, see `references/copywriting-frameworks.md`"

**Keep intact (convert tables to flat lists):**
- Headlines section (lines 20-76)
- Opening lines (lines 79-132)
- Curiosity gaps and open loops (lines 135-176)
- Flow techniques (lines 179-248)
- Pain quantification (lines 250-269)
- The So What? Chain (lines 272-289)
- Rhythm: alternation (lines 292-318)
- The founder story (lines 321-335)
- Testimonials (lines 338-353)
- Disqualification (lines 355-375)
- CTAs (lines 377-393)
- Internet-native voice markers (lines 396-417)
- The full sequence (lines 419-434)
- AI tells to avoid (lines 438-491)
- Example transformation (lines 494-511)
- The test (lines 514-528)
- Working with SEO content / frontmatter preservation (lines 532-579)

### B2. Slim `skills/seo-content/SKILL.md` (995 → ~400 lines)

**Remove (duplicates other files):**
- Template structure (lines 648-757, ~110 lines) — duplicates `templates/article-template.md`
- Humanize phase AI patterns (lines 318-465, ~147 lines) — duplicates `references/banned-words-phrases.md`
- Optimize phase SEO checklist (lines 467-587, ~120 lines) — duplicates `references/seo-requirements.md`
- Pillar mode / non-interactive mode (lines 827-864, 928-991, ~100 lines) — duplicates `rules/workflow.md`
- File naming rules (lines 806-823, ~17 lines) — duplicates `references/file-naming-conventions.md`
- Internal linking rules (lines 545-587, ~42 lines) — duplicates `references/internal-linking-strategy.md`
- Motivational intro text
- ASCII diagram: `RESEARCH → BRIEF → OUTLINE → DRAFT → HUMANIZE → OPTIMIZE → REVIEW`
- All tables

**Replace removed sections with one-line references:**
- "For article template structure, see `skills/templates/article-template.md`"
- "For banned words/phrases and AI pattern detection, see `references/banned-words-phrases.md`"
- "For SEO on-page checklist, see `references/seo-requirements.md`"
- "For internal linking rules, see `references/internal-linking-strategy.md`"

**Keep:**
- Content Brief template (lines 86-152) — manual planning step, not duplicated elsewhere
- Outline structures by article type (lines 154-266) — unique reference content
- Draft phase principles condensed (lines 270-316, trim to ~30 lines keeping First Paragraph Rule, So What Chain, Specificity)
- Quality review checklists (lines 589-639, condensed)
- E-E-A-T signals checklist (lines 629-638)

**Update reference:** `eeat-examples.md` → `eeat-patterns.md`

### B3. Slim `skills/validate-content/SKILL.md` (964 → ~700 lines)

**Remove:**
- Motivational intro (lines 1-14)
- "When to Validate" context section — condense to single directive
- "The Test" motivational checklist (lines 817-835)
- All tables — convert to flat lists
- Content type matrix table — convert to flat list

**Keep:** All 6 validation phase definitions (this is the single source of truth — the agent will reference it instead of duplicating it)

### B4. Slim `skills/content-atomizer/SKILL.md` (1,189 → ~900 lines)

**Remove:**
- Motivational intro (lines 1-12)
- Anti-patterns section — condense to 5-line bullet list
- Transformation examples (lines 756-793) — redundant with templates
- "Keeping Platform Specs Current" maintenance section (lines 1122-1174)
- All tables — convert to flat lists

**Keep:** Platform playbooks (LinkedIn, Twitter, Instagram, TikTok, YouTube) — core value, but strip tables within them

---

## Phase C: Slim Agents (depends on Phase A)

### C1. Slim `agents/seo-writer.md` (205 → ~130 lines)

**Remove:**
- Section "4. Write the Article" (lines 77-99, ~23 lines) — duplicates article template + seo-content skill
- Section "5. Write Quality Content" (lines 108-120, ~13 lines) — duplicates skill requirements
- URL status codes table (lines 136-143) — convert to flat list
- Tool usage table (lines 198-203) — convert to flat list
- "Why minimal return" explanation (lines 173-176)
- Drop `common-mistakes.md` from "Before Starting" references (mistake detection is the Validator's job)

**Replace sections 4-5 with:** "Follow the preloaded `/seo-content` skill workflow to write the article. Use `skills/templates/article-template.md` for structure."

**Update reference:** `eeat-examples.md` → `eeat-patterns.md`

**Keep intact (agent-specific, not in skill):**
- Step 1: Read Context Files (file reading workflow)
- Step 2: Research E-E-A-T Citations (web search instructions)
- Step 3: Find Existing Articles (Glob usage)
- Step 6: Verify Citation URLs (as flat list)
- Return Format (condensed)

### C2. Slim `agents/copy-enhancer.md` (290 → ~170 lines)

**Remove:**
- Mode Detection section (lines 30-39) — this agent is now enhancement-only
- All Fix Mode sections (lines 176-238) — moved to copy-fixer agent
- Common Fix Types section (lines 203-230) — moved to copy-fixer
- Banned Words replacement table (lines 58-69) — convert to "Replace per `banned-words-phrases.md`"
- Em Dash examples table (lines 140-144) — convert to inline examples
- Tool Usage table (lines 285-288) — convert to flat list
- "Why minimal return" explanation
- Drop `universal-rules.md` from "Before Starting" references (only needs banned words + UK English, which are in dedicated reference files)

**Update description:** Remove "Handles both enhancement passes and fixing specific validation issues" — now enhancement-only.

**Keep intact:**
- Enhancement Mode workflow (lines 84-173)
- Banned Words Validation checklist (lines 71-78)
- Em Dash Removal process (lines 129-146, inline examples not table)
- Preserve Frontmatter rules (lines 157-173)
- What NOT to Do (lines 148-155)
- Return Format (condensed)

### C3. Slim `agents/content-validator.md` (585 → ~210 lines)

The agent file (585 lines) and preloaded validate-content skill (964 lines) BOTH describe the same 6-phase validation workflow. Every phase is duplicated:
- Phase 1 Universal Rules: agent lines 69-233, skill lines 79-135
- Phase 2 Client Profile: agent lines 236-267, skill lines 138-183
- Phase 3 Human Quality: agent lines 269-301, skill lines 186-242
- Phase 4 Schema: agent lines 304-337, skill lines 245-324
- Phase 5 Readability: agent lines 341-369, skill lines 328-411
- Phase 6 Pillar Consistency: agent lines 373-401, skill lines 415-482

**Remove (all duplicated in validate-content skill):**
- Phase 1 checks 1.1-1.4 descriptions (lines 73-107)
- Phases 2-6 full descriptions (lines 236-401)
- Status determination section (lines 514-530)
- Missing context handling example (lines 548-570)
- "Why file-based" explanation (lines 39-42)
- All tables (H1 examples at 144, readability at 362, content type at 578, tool usage at 535)

**Keep (agent-specific, NOT in skill):**
- Agent identity and read-only constraint (line 13)
- File-based output protocol directive (lines 31-37, without the "why")
- Agent-specific additions the skill doesn't have:
  - 1.5: Em dash detection via Grep tool (lines 109-127)
  - 1.6: H1 validation with hook requirement (lines 129-153, inline examples not table)
  - 1.7: Heading uniqueness check (lines 155-169)
  - 1.8: Slug format check (lines 171-189, inline examples not table)
  - 1.10: Placeholder link handling (lines 201-233)
- Validation file format template (lines 428-510) — the output format the fixer reads
- Return format (lines 404-424, condensed)
- Content type awareness as flat list (lines 574-585)

**Add directive:** "Execute all 6 validation phases as defined in the preloaded `/validate-content` skill, with these agent-specific additions for Phase 1..."

### C4. Slim `agents/content-atomizer.md` (176 → ~110 lines)

**Remove:**
- "Your Mission" section (lines 16-24) — motivational
- Platform Voice Adjustments table (lines 111-121) — in preloaded skill
- Output Structure duplicate code block (lines 129-135) — already in workflow step 4
- Tool Usage table (lines 172-176) — convert to flat list
- "Why minimal return" explanation

**Keep:** Workflow (read article, read profile, create platform content, write files, quality check), return format

---

## Phase D: Update Orchestration (depends on Phases B and C)

### D1. Update `skills/execute-pillar/SKILL.md` (791 → ~500 lines)

**Fix contradiction (lines 408-423):**

Three sources currently disagree on how to pass validation failures to fix mode:
- execute-pillar (lines 410-421): Paste FULL validation output into prompt
- copy-enhancer agent (lines 36-38): Pass `validation_file_path`, read from file
- workflow.md: "Copy Enhancer reads issues from validation FILE, not prompt"

Resolution — file-based is correct. Replace lines 408-423 with:
```
When spawning copy-fixer for fixes, pass the validation file path:

  Task: Fix validation issues in {article_path}
  Article: {path}
  Validation File: {validation_file_path}

The copy-fixer reads the validation file directly.
Do NOT paste validation output into the prompt.
```

**Update agent references throughout:**
- Step 3 pipeline: "COPY ENHANCER (Enhancement Mode)" → "COPY ENHANCER"
- Step 4 retry loop: "Spawn COPY ENHANCER (Fix Mode)" → "Spawn COPY FIXER"
- Quick Reference: Add Copy Fixer template, remove Fix Mode from Copy Enhancer template

**Remove bloat:**
- All ASCII diagrams (lines 310-327, 333-356, 383-406 = 66 lines)
- All tables (lines 68-74, 187-192, 440-446 = 20 lines)
- Complete Execution Checklist (lines 636-677, 42 lines) — duplicates Steps 1-8
- Example Error Comments (lines 449-465, 17 lines) — format already defined
- "Context Architecture Communication" verbose output template (lines 150-178) — condense to 3-line directive
- Pseudo-code for tier validation (lines 244-259) — unnecessary, just describe the checks
- Quick Reference "Expected Output" sections (~30 lines) — return formats already in agent files
- Condense commit/PR bash blocks — use format descriptions instead of full heredocs (~30 lines)
- Troubleshooting section (lines 756-789) — moved to `references/execute-pillar-troubleshooting.md` (A4)

### D2. Update `rules/workflow.md` (~80 lines)

- Add `copy-fixer` to Agent Reference with description and return format
- Update pipeline description: 5 agents (seo-writer, copy-enhancer, content-validator, copy-fixer, content-atomizer)
- Note: copy-fixer only spawns on validation FAIL (retry loop)
- Remove block quote for architecture constraint — make it a directive
- Remove "Why minimal returns" explanation
- Confirm retry loop uses file-based issue passing

### D3. Update `CLAUDE.md` (minor)

- Update Agents section: mention copy-fixer as seventh agent
- Remove any "why" explanations that can be directives instead

---

## Phase E: Verify

**E1. Grep for stale references:**
- `eeat-examples` in agent files (should only appear in eeat-patterns.md and eeat-examples.md itself)
- `copy-enhancer.*fix` or `Fix Mode` in execute-pillar (should reference copy-fixer instead)
- `common-mistakes` in seo-writer agent (should be removed)
- Lines starting with `|` in all modified agent files (should be zero — no tables)

**E2. Verify agent frontmatter:**
- All 5 agent files have valid YAML (seo-writer, copy-enhancer, copy-fixer, content-validator, content-atomizer)
- copy-fixer has no `skills:` field
- copy-enhancer description no longer mentions "fix"

**E3. Line count audit:**
- Count lines in every modified file
- Compare to targets in this plan
- Flag any file that didn't hit within 15% of target

---

## Files Modified Summary

**New files (4):**
- `.claude/references/copywriting-frameworks.md` (~1,627 lines, extracted from DR copy skill)
- `.claude/skills/seo-content/references/eeat-patterns.md` (~80 lines, condensed from eeat-examples)
- `.claude/agents/copy-fixer.md` (~150 lines, new agent)
- `.claude/references/execute-pillar-troubleshooting.md` (~34 lines, extracted from execute-pillar)

**Modified skills (4):**
- `.claude/skills/direct-response-copy/SKILL.md` (2,217 → ~590)
- `.claude/skills/seo-content/SKILL.md` (995 → ~400)
- `.claude/skills/validate-content/SKILL.md` (964 → ~700)
- `.claude/skills/content-atomizer/SKILL.md` (1,189 → ~900)

**Modified agents (4):**
- `.claude/agents/seo-writer.md` (205 → ~130)
- `.claude/agents/copy-enhancer.md` (290 → ~170)
- `.claude/agents/content-validator.md` (585 → ~210)
- `.claude/agents/content-atomizer.md` (176 → ~110)

**Modified orchestration (3):**
- `.claude/skills/execute-pillar/SKILL.md` (791 → ~500)
- `.claude/rules/workflow.md` (87 → ~80)
- `.claude/CLAUDE.md` (minor updates)

**Total: 15 files modified/created**

---

## Risk Assessment

- **Low:** Extracting copywriting frameworks (full content preserved in reference file), condensing eeat-examples (full file kept), fixing the execute-pillar contradiction, removing tables/ASCII/intros
- **Medium:** Removing duplicated content from agents and skills (mitigated by verifying the other file covers it equivalently — verified during investigation)
- **High:** New copy-fixer agent (mitigated by testing with a known validation failure before running full pillar)

---

## Phase 2 (Deferred — separate session)

Everything NOT in the pipeline path. Same principles apply (strip tables, ASCII, intros, duplicates):
- Interactive skills: keyword-research, start-pillar, positioning-angles, brand-voice, onboard-client, orchestrator, email-sequences, lead-magnet, newsletter
- Templates: article-template, distribution-template, email-sequence-template, tasks-template
- References: common-mistakes.md, client-profile-requirements.md
- Other: audit-pillar, consistency-checker, link-auditor, examples/
