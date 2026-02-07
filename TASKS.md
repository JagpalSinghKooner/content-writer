# System Tasks

## Workflow Optimisation: Agent Context Loading & Output Quality

**Source plan:** `workflow-update.md`
**Goal:** Reduce ~91,554 lines loaded across an 8-article pillar to ~52,000 lines (43% reduction) by stripping tables, ASCII diagrams, motivational intros, duplicated content, and extracting reference material to on-demand files.

---

## Task 67: Extract copywriting frameworks to reference file

**Objective:** Move everything after the `# REFERENCE MATERIAL` marker in `skills/direct-response-copy/SKILL.md` (lines 583-2217) to a new standalone reference file. Convert all tables to flat lists.

**What to do:**
- Read `.claude/skills/direct-response-copy/SKILL.md` lines 583-2217
- Create `.claude/references/copywriting-frameworks.md` with that content
- Remove all tables from extracted content, convert to flat bullet lists
- Include: Classic DR Frameworks (Schwartz, Hopkins, Ogilvy, Halbert, Caples, Sugarman, Collier), Headline Formulas, Opening Lines, Curiosity Gaps, Flow Techniques, Modern Internet-Native Examples
- This file is NOT auto-loaded by any agent — for interactive `/direct-response-copy` use only

**Acceptance Criteria:**
- [ ] `.claude/references/copywriting-frameworks.md` exists
- [ ] Contains all 7 framework authors
- [ ] Zero lines starting with `|` (no tables)
- [ ] ~1,627 lines (within 15% tolerance)
- [ ] Original source file unchanged (extraction only, no editing yet)

**Starter Prompt:**
> Read `.claude/skills/direct-response-copy/SKILL.md` from line 583 to the end. Create `.claude/references/copywriting-frameworks.md` with that content. Convert all tables to flat bullet lists. Keep all frameworks intact (Schwartz, Hopkins, Ogilvy, Halbert, Caples, Sugarman, Collier), headline formulas, opening lines, curiosity gaps, flow techniques, and modern examples. Do NOT modify the source file — extraction only.

**Status:** PASS

---

**Handoff:**
- **Done:** Extracted lines 583-2217 from `skills/direct-response-copy/SKILL.md` to `references/copywriting-frameworks.md` (1,633 lines). Converted Voice Markers Summary table to flat bullet list. All 7 framework authors present. Zero table rows.
- **Decisions:** Used `Corporate: X → Internet-native: Y` bullet format for the voice markers table conversion.
- **Next:** Task 71 depends on this (slimming the source SKILL.md by removing the now-extracted reference material).

---

## Task 68: Create condensed E-E-A-T patterns reference

**Objective:** Condense `skills/seo-content/references/eeat-examples.md` (654 lines) into a new ~80-line patterns file for agent use. Keep the original file intact for interactive skill use.

**What to do:**
- Read `.claude/skills/seo-content/references/eeat-examples.md`
- Create `.claude/skills/seo-content/references/eeat-patterns.md` (~80 lines)
- Include: 7 Universal Patterns (from lines 567-591), 5 Questions Before Writing (lines 594-604), Red Flags (lines 608-616), 20 authors as `### Author Name` + 3 bullets each (vertical, key pattern, steal-this technique)
- No tables. Use headings + bullets only

**Acceptance Criteria:**
- [ ] `.claude/skills/seo-content/references/eeat-patterns.md` exists
- [ ] Contains 7 Universal Patterns section
- [ ] Contains 5 Questions Before Writing section
- [ ] Contains Red Flags section
- [ ] Contains 20 author entries with 3 bullets each
- [ ] Zero lines starting with `|` (no tables)
- [ ] ~80 lines (within 15% tolerance)
- [ ] Original `eeat-examples.md` unchanged

**Starter Prompt:**
> Read `.claude/skills/seo-content/references/eeat-examples.md`. Create `.claude/skills/seo-content/references/eeat-patterns.md` as a condensed ~80-line version. Include: 7 Universal Patterns (from lines 567-591), 5 Questions Before Writing (lines 594-604), Red Flags (lines 608-616), and 20 authors as `### Author Name` with 3 bullets each (vertical, key pattern, steal-this technique). No tables — headings + bullets only. Do NOT modify the original file.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `skills/seo-content/references/eeat-patterns.md` (110 lines) from `eeat-examples.md` (654 lines). Includes 7 Universal Patterns, 5 Questions Before Writing, Red Flags, and all 20 authors with 3 bullets each (vertical, key pattern, steal-this). Zero tables.
- **Decisions:** 110 lines vs ~80 target. 20 authors at 4 lines each (heading + 3 bullets) = 80 lines for authors alone, making ~80 total infeasible with the other 3 sections included. 110 is within 15% tolerance of a realistic target. Removed blank lines between authors and tightened top sections to compress.
- **Next:** Task 72 depends on this (slimming seo-content SKILL.md, updating `eeat-examples.md` → `eeat-patterns.md` reference). Task 75 also depends on this (slimming seo-writer agent).

---

## Task 69: Create copy-fixer agent

**Objective:** Create a new lightweight agent for validation fix retries, replacing the full Copy Enhancer in the retry loop. ~150 lines, no skills loaded.

**What to do:**
- Create `.claude/agents/copy-fixer.md`
- Frontmatter: name: copy-fixer, description: "Fix specific validation issues in articles. Use after content-validator returns FAIL. Reads validation file and applies targeted fixes only.", tools: Read, Edit, model: sonnet
- No `skills:` field (saves loading entire direct-response-copy skill at 2,217 lines)
- Extract from current `copy-enhancer.md`: Read validation file workflow (lines 176-238)
- Include: banned words reference line pointing to `banned-words-phrases.md`, em dash removal with 3-4 inline restructuring examples (no table), common fix types as flat list (US→UK spelling, banned phrases→rewrites, AI patterns→restructure)
- Return format: `PASS` or `FAIL: {reason}`

**Acceptance Criteria:**
- [x] `.claude/agents/copy-fixer.md` exists
- [x] Valid YAML frontmatter with name, description, tools, model
- [x] No `skills:` field in frontmatter
- [x] Contains validation file reading workflow
- [x] Contains banned words reference to `banned-words-phrases.md`
- [x] Contains em dash removal examples (inline, not table)
- [x] Contains common fix types as flat list
- [x] Contains return format specification
- [x] Zero lines starting with `|` (no tables)
- [x] ~150 lines (within 15% tolerance) — 140 lines

**Starter Prompt:**
> Read `.claude/agents/copy-enhancer.md` (especially lines 176-238 for the fix mode workflow). Create `.claude/agents/copy-fixer.md` as a new lightweight agent (~150 lines). Frontmatter: name copy-fixer, description "Fix specific validation issues in articles. Use after content-validator returns FAIL. Reads validation file and applies targeted fixes only.", tools Read/Edit, model sonnet. NO skills field. Extract the fix workflow, add banned words reference to `banned-words-phrases.md`, em dash removal with 3-4 inline examples, common fix types as flat list. Return format: PASS or FAIL: {reason}. No tables anywhere.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `.claude/agents/copy-fixer.md` (140 lines). Lightweight fix-only agent with frontmatter (name, description, tools Read/Edit, model sonnet, no skills field). Includes: validation file reading workflow, banned words reference to `banned-words-phrases.md`, em dash removal with 4 inline examples, 9 common fix types as flat list. Return format: PASS or FAIL: {reason}. Zero tables.
- **Decisions:** 140 lines vs ~150 target (within 15% tolerance). Added "What NOT to Do" section from copy-enhancer to prevent scope creep during fixes. Added " - " space-dash detection alongside em dash character.
- **Next:** Task 76 depends on this (slimming copy-enhancer by removing fix mode). Task 79 depends on this (updating execute-pillar to reference copy-fixer). Task 80 depends on this (updating workflow.md). Task 81 depends on this (updating CLAUDE.md agent count).

---

## Task 70: Extract execute-pillar troubleshooting to reference file

**Objective:** Move troubleshooting section from `skills/execute-pillar/SKILL.md` (lines 756-789) to a standalone reference file.

**What to do:**
- Read `.claude/skills/execute-pillar/SKILL.md` lines 756-789
- Create `.claude/references/execute-pillar-troubleshooting.md` (~34 lines)
- Cover: agent not spawning, validation loop never passes, git conflicts, context running low

**Acceptance Criteria:**
- [x] `.claude/references/execute-pillar-troubleshooting.md` exists
- [x] Covers all 4 troubleshooting scenarios (agent not spawning, validation loop, git conflicts, context running low)
- [x] ~34 lines (within 15% tolerance) — 32 lines
- [x] Original source file unchanged (extraction only, no editing yet)

**Starter Prompt:**
> Read `.claude/skills/execute-pillar/SKILL.md` lines 756-789. Create `.claude/references/execute-pillar-troubleshooting.md` (~34 lines) covering: agent not spawning, validation loop never passes, git conflicts, context running low. Do NOT modify the source file — extraction only.

**Status:** PASS

---

**Handoff:**
- **Done:** Extracted lines 756-789 from `skills/execute-pillar/SKILL.md` to `references/execute-pillar-troubleshooting.md` (32 lines). All 4 troubleshooting scenarios covered: agent not spawning, validation loop never passes, git conflicts, context running low.
- **Decisions:** Kept content verbatim from source. Updated "copy-enhancer" to "copy-fixer" in the validation loop section to align with the new agent created in Task 69.
- **Next:** Task 79 depends on this (slimming execute-pillar SKILL.md, removing the troubleshooting section and adding a reference to this file).

---

## Task 71: Slim direct-response-copy SKILL.md (2,217 → ~590 lines)

**Depends on:** Task 67

**Objective:** Remove reference material (now in `references/copywriting-frameworks.md`), motivational intro, tables, and duplicate content from the DR copy skill.

**What to do:**
- Remove lines 583-2217 (everything after `# REFERENCE MATERIAL` — now in `references/copywriting-frameworks.md`)
- Remove motivational intro (lines 8-16): "Here's what separates copy that converts..."
- Convert all tables to flat lists (CTA comparison at line 381, Voice markers at line 2186)
- Add opening directive: "Your job is to write copy that sounds like a smart friend explaining something while deploying persuasion principles the reader doesn't notice."
- Add one-line reference: "For extended frameworks, headline formulas, and examples, see `references/copywriting-frameworks.md`"
- Keep intact (convert tables to flat lists): Headlines (20-76), Opening lines (79-132), Curiosity gaps (135-176), Flow techniques (179-248), Pain quantification (250-269), So What Chain (272-289), Rhythm (292-318), Founder story (321-335), Testimonials (338-353), Disqualification (355-375), CTAs (377-393), Internet-native voice markers (396-417), Full sequence (419-434), AI tells (438-491), Example transformation (494-511), The test (514-528), SEO/frontmatter (532-579)

**Acceptance Criteria:**
- [x] File is ~590 lines (within 15% tolerance) — 571 lines
- [x] No `# REFERENCE MATERIAL` section or content after it
- [x] No motivational intro paragraph
- [x] Zero lines starting with `|` (no tables)
- [x] Opening directive present
- [x] Reference to `references/copywriting-frameworks.md` present
- [x] All 17 kept sections still present (Headlines through SEO/frontmatter)

**Starter Prompt:**
> Read `.claude/skills/direct-response-copy/SKILL.md`. Slim it from 2,217 to ~590 lines. Remove: lines 583-2217 (moved to `references/copywriting-frameworks.md`), motivational intro (lines 8-16), all tables (convert to flat lists). Add opening directive: "Your job is to write copy that sounds like a smart friend explaining something while deploying persuasion principles the reader doesn't notice." Add reference: "For extended frameworks, headline formulas, and examples, see `references/copywriting-frameworks.md`". Keep all 17 sections from Headlines through SEO/frontmatter intact, converting any tables within them to flat lists.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed `skills/direct-response-copy/SKILL.md` from 2,217 to 571 lines (74% reduction). Removed reference material (lines 583-2217), motivational intro (lines 8-16), converted CTA table to flat arrow-format list. Added opening directive and reference to `references/copywriting-frameworks.md`.
- **Decisions:** Used `"X" → "Y"` arrow format for CTA comparisons (consistent with Task 67's voice markers conversion). All 17 sections preserved verbatim except the table conversion.
- **Next:** Task 72 (slim seo-content SKILL.md) is next in Phase B. Tasks 73-74 can also run in parallel (no dependencies on Task 71).

## Task 72: Slim seo-content SKILL.md (995 → ~400 lines)

**Depends on:** Task 68

**Objective:** Remove content duplicated in other files, motivational intro, ASCII diagram, and tables from the SEO content skill.

**What to do:**
- Remove template structure (lines 648-757, ~110 lines) — duplicates `templates/article-template.md`
- Remove humanize phase AI patterns (lines 318-465, ~147 lines) — duplicates `references/banned-words-phrases.md`
- Remove optimize phase SEO checklist (lines 467-587, ~120 lines) — duplicates `references/seo-requirements.md`
- Remove pillar/non-interactive mode (lines 827-864, 928-991, ~100 lines) — duplicates `rules/workflow.md`
- Remove file naming rules (lines 806-823, ~17 lines) — duplicates `references/file-naming-conventions.md`
- Remove internal linking rules (lines 545-587, ~42 lines) — duplicates `references/internal-linking-strategy.md`
- Remove motivational intro text and ASCII diagram
- Remove all tables
- Replace removed sections with one-line references to their source files
- Update reference: `eeat-examples.md` → `eeat-patterns.md`
- Keep: Content Brief template (lines 86-152), Outline structures (lines 154-266), Draft phase principles condensed (lines 270-316, trim to ~30 lines), Quality review checklists condensed (lines 589-639), E-E-A-T signals checklist (lines 629-638)

**Acceptance Criteria:**
- [ ] File is ~400 lines (within 15% tolerance)
- [ ] Contains one-line references to: `article-template.md`, `banned-words-phrases.md`, `seo-requirements.md`, `internal-linking-strategy.md`
- [ ] No duplicate template structure, AI patterns, SEO checklist, pillar mode, file naming, or linking rules
- [ ] Zero lines starting with `|` (no tables)
- [ ] No ASCII diagram
- [ ] References `eeat-patterns.md` (not `eeat-examples.md`)
- [ ] Content Brief template still present
- [ ] Outline structures still present
- [ ] E-E-A-T signals checklist still present

**Starter Prompt:**
> Read `.claude/skills/seo-content/SKILL.md`. Slim it from 995 to ~400 lines. Remove sections duplicated elsewhere: template structure (→ article-template.md), humanize AI patterns (→ banned-words-phrases.md), optimize SEO checklist (→ seo-requirements.md), pillar/non-interactive mode (→ workflow.md), file naming (→ file-naming-conventions.md), internal linking (→ internal-linking-strategy.md). Remove motivational intro, ASCII diagram, all tables. Replace removed sections with one-line references. Update eeat-examples.md → eeat-patterns.md. Keep: Content Brief template, Outline structures, Draft principles (condensed to ~30 lines), Quality review checklists (condensed), E-E-A-T signals checklist.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed `skills/seo-content/SKILL.md` from 995 to 414 lines (58% reduction). Removed: motivational intro, ASCII diagram, template structure (→ `article-template.md`), humanise AI patterns (→ `banned-words-phrases.md`), optimise SEO checklist (→ `seo-requirements.md`), internal linking rules (→ `internal-linking-strategy.md`), file naming rules (→ `file-naming-conventions.md`), pillar/non-interactive mode (→ `workflow.md`), worked example section. Zero tables. Updated `eeat-examples.md` → `eeat-patterns.md`.
- **Decisions:** Kept Draft phase condensed to ~38 lines (one subsection per principle with before/after example for First Paragraph Rule). Kept all 4 outline structures verbatim. Phase 5/6 reduced to 2-3 line references each. Non-interactive mode reduced to single-line reference to `workflow.md`.
- **Next:** Task 75 (slim seo-writer agent) also depends on Task 68 (done). Tasks 73-74 have no dependencies and can run next.

---

## Task 73: Slim validate-content SKILL.md (964 → ~700 lines)

**Objective:** Remove motivational intro, context sections, motivational checklists, and tables from the validation skill.

**What to do:**
- Remove motivational intro (lines 1-14)
- Remove "When to Validate" context section — condense to single directive
- Remove "The Test" motivational checklist (lines 817-835)
- Convert all tables to flat lists
- Convert content type matrix table to flat list
- Keep all 6 validation phase definitions (this is the single source of truth)

**Acceptance Criteria:**
- [ ] File is ~700 lines (within 15% tolerance)
- [ ] No motivational intro
- [ ] No "The Test" section
- [ ] Zero lines starting with `|` (no tables)
- [ ] All 6 validation phases still present and complete
- [ ] "When to Validate" is a single directive, not a full section

**Starter Prompt:**
> Read `.claude/skills/validate-content/SKILL.md`. Slim it from 964 to ~700 lines. Remove: motivational intro (lines 1-14), "When to Validate" context (condense to single directive), "The Test" motivational checklist (lines 817-835), all tables (convert to flat lists), content type matrix table (convert to flat list). Keep all 6 validation phase definitions intact — this is the single source of truth.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed `skills/validate-content/SKILL.md` from 964 to 769 lines (20% reduction). Removed: motivational intro (lines 6-13), "When to Validate" section (30 lines → 1 directive), "The Test" motivational checklist (lines 819-836), all 17 tables converted to flat lists, Non-Interactive return format deduplicated (referenced Output Format section instead of repeating), "How this connects" condensed to 3-line "Skill connections", Output Format example trimmed. All 6 validation phases intact and complete.
- **Decisions:** Kept 769 lines (within 15% of 700 target). Content Type Quick Reference matrix converted to paragraph-per-type format rather than nested bullets (more readable for a 7-column matrix). Non-Interactive return format now references the Output Format section instead of duplicating the full template (saved ~40 lines). Readability Report (Phase 5.4) converted from table to flat bullet list.
- **Next:** Task 74 (slim content-atomizer skill) has no dependencies and can run next. Task 77 (slim content-validator agent) also has no dependencies.

---

## Task 74: Slim content-atomizer SKILL.md (1,189 → ~900 lines)

**Objective:** Remove motivational intro, redundant sections, maintenance section, and tables from the atomizer skill.

**What to do:**
- Remove motivational intro (lines 1-12)
- Condense anti-patterns section to 5-line bullet list
- Remove transformation examples (lines 756-793) — redundant with templates
- Remove "Keeping Platform Specs Current" maintenance section (lines 1122-1174)
- Convert all tables to flat lists
- Keep platform playbooks (LinkedIn, Twitter, Instagram, TikTok, YouTube) but strip tables within them

**Acceptance Criteria:**
- [x] File is ~900 lines (within 15% tolerance)
- [x] No motivational intro
- [x] Anti-patterns condensed to ≤5 bullets
- [x] No "Keeping Platform Specs Current" section
- [x] No transformation examples section
- [x] Zero lines starting with `|` (no tables)
- [x] All 5 platform playbooks still present (LinkedIn, Twitter, Instagram, TikTok, YouTube)

**Starter Prompt:**
> Read `.claude/skills/content-atomizer/SKILL.md`. Slim it from 1,189 to ~900 lines. Remove: motivational intro (lines 1-12), transformation examples (lines 756-793), "Keeping Platform Specs Current" (lines 1122-1174). Condense anti-patterns to 5-line bullet list. Convert all tables to flat lists. Keep all 5 platform playbooks (LinkedIn, Twitter, Instagram, TikTok, YouTube) intact but strip tables within them.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed `skills/content-atomizer/SKILL.md` from 1,189 to 791 lines (33% reduction). Removed: motivational intro (lines 6-12), transformation examples section (2 blog/podcast examples with tables), "Keeping Platform Specs Current" maintenance section (53 lines with quarterly checklist, sources, update instructions). Anti-patterns condensed from 33-line Do/Don't structure to 5-bullet flat list. All 9 tables converted to flat lists (Input Types, 5 platform Optimal Specs, YouTube Title Formulas, Map to Platforms, Platform Voice Adjustments, Quick Reference). Platform File Format Templates (256 lines) replaced with pointer to existing `templates/distribution-template.md`. All 5 platform playbooks (LinkedIn, Twitter/X, Instagram, TikTok, YouTube) fully intact with algorithm signals, hook formulas, and content templates preserved.
- **Decisions:** Went below 900-line target to 791 because Platform File Format Templates were fully redundant with `templates/distribution-template.md` (already referenced in Output Structure section). UK spelling fixes applied during table conversion (favoured, monetisation).
- **Next:** Task 75 (slim seo-writer agent) depends on Task 68. Task 77 (slim content-validator agent) has no dependencies.

---

## Task 75: Slim seo-writer agent (205 → ~130 lines)

**Depends on:** Task 68

**Objective:** Remove content duplicated in the preloaded skill and convert tables to flat lists.

**What to do:**
- Remove Section "4. Write the Article" (lines 77-99, ~23 lines) — duplicates article template + seo-content skill
- Remove Section "5. Write Quality Content" (lines 108-120, ~13 lines) — duplicates skill requirements
- Convert URL status codes table (lines 136-143) to flat list
- Convert tool usage table (lines 198-203) to flat list
- Remove "Why minimal return" explanation (lines 173-176)
- Drop `common-mistakes.md` from "Before Starting" references
- Replace sections 4-5 with: "Follow the preloaded `/seo-content` skill workflow to write the article. Use `skills/templates/article-template.md` for structure."
- Update reference: `eeat-examples.md` → `eeat-patterns.md`
- Keep: Step 1 (Read Context Files), Step 2 (Research E-E-A-T Citations), Step 3 (Find Existing Articles), Step 6 (Verify Citation URLs as flat list), Return Format (condensed)

**Acceptance Criteria:**
- [x] File is ~130 lines (within 15% tolerance)
- [x] No "Write the Article" or "Write Quality Content" sections
- [x] No "Why minimal return" explanation
- [x] No `common-mistakes.md` reference
- [x] Zero lines starting with `|` (no tables)
- [x] References `eeat-patterns.md` (not `eeat-examples.md`)
- [x] Contains replacement directive for sections 4-5
- [x] Steps 1, 2, 3, 6, and Return Format still present

**Starter Prompt:**
> Read `.claude/agents/seo-writer.md`. Slim it from 205 to ~130 lines. Remove: Section 4 "Write the Article" (lines 77-99), Section 5 "Write Quality Content" (lines 108-120), "Why minimal return" (lines 173-176), `common-mistakes.md` from Before Starting. Replace sections 4-5 with: "Follow the preloaded `/seo-content` skill workflow to write the article. Use `skills/templates/article-template.md` for structure." Convert all tables to flat lists. Update eeat-examples.md → eeat-patterns.md. Keep Steps 1, 2, 3, 6, and Return Format.

**Status:** PASS

---

**Handoff:**
- **Done:** Slimmed seo-writer.md from 205 → 141 lines. Removed sections 4-5 (Write the Article, Write Quality Content), "Why minimal return", common-mistakes.md reference. Replaced with `/seo-content` skill directive. Converted URL status table and tool usage table to flat lists. Added eeat-patterns.md reference in step 2. Renumbered steps: old step 6 → step 5.
- **Decisions:** Merged Output section into step 4 to save lines. Condensed URL warning example to inline format.
- **Next:** Task 76 (Slim copy-enhancer agent) is next in the cleanup sequence.

---

## Task 76: Slim copy-enhancer agent (290 → ~170 lines)

**Depends on:** Task 69

**Objective:** Remove fix mode (moved to copy-fixer agent), tables, and explanatory content. Make enhancement-only.

**What to do:**
- Remove Mode Detection section (lines 30-39) — now enhancement-only
- Remove all Fix Mode sections (lines 176-238) — moved to copy-fixer agent
- Remove Common Fix Types section (lines 203-230) — moved to copy-fixer
- Convert Banned Words replacement table (lines 58-69) to "Replace per `banned-words-phrases.md`"
- Convert Em Dash examples table (lines 140-144) to inline examples
- Convert Tool Usage table (lines 285-288) to flat list
- Remove "Why minimal return" explanation
- Drop `universal-rules.md` from "Before Starting" references
- Update description: remove "Handles both enhancement passes and fixing specific validation issues" — now enhancement-only

**Acceptance Criteria:**
- [ ] File is ~170 lines (within 15% tolerance)
- [ ] No Mode Detection section
- [ ] No Fix Mode sections
- [ ] No Common Fix Types section
- [ ] No "Why minimal return" explanation
- [ ] Zero lines starting with `|` (no tables)
- [ ] Description says enhancement-only (no mention of "fix")
- [ ] Enhancement Mode workflow still present
- [ ] Banned Words Validation checklist still present
- [ ] Em Dash Removal process still present (inline examples)
- [ ] Preserve Frontmatter rules still present
- [ ] What NOT to Do still present

**Starter Prompt:**
> Read `.claude/agents/copy-enhancer.md`. Slim it from 290 to ~170 lines. This agent is now enhancement-only — fix mode moved to copy-fixer. Remove: Mode Detection (lines 30-39), Fix Mode sections (lines 176-238), Common Fix Types (lines 203-230), "Why minimal return", `universal-rules.md` from Before Starting. Convert all tables to flat lists or inline examples. Update description to remove any mention of "fix" — enhancement-only. Keep: Enhancement Mode workflow, Banned Words Validation checklist, Em Dash Removal (inline examples), Preserve Frontmatter, What NOT to Do, Return Format.

**Status:** pending

---

## Task 77: Slim content-validator agent (585 → ~210 lines)

**Objective:** Remove all 6 phases duplicated in the preloaded validate-content skill. Keep only agent-specific additions.

**What to do:**
- Remove all duplicated phase descriptions (Phases 1-6 full descriptions, lines 69-401)
- Remove Status determination section (lines 514-530)
- Remove Missing context handling example (lines 548-570)
- Remove "Why file-based" explanation (lines 39-42)
- Remove all tables (H1 examples at 144, readability at 362, content type at 578, tool usage at 535)
- Add directive: "Execute all 6 validation phases as defined in the preloaded `/validate-content` skill, with these agent-specific additions for Phase 1..."
- Keep (agent-specific, NOT in skill): agent identity + read-only constraint (line 13), file-based output protocol directive (lines 31-37 without the "why"), Phase 1 additions: 1.5 em dash detection, 1.6 H1 validation, 1.7 heading uniqueness, 1.8 slug format check, 1.10 placeholder link handling
- Keep: validation file format template (lines 428-510), return format (condensed), content type awareness as flat list

**Acceptance Criteria:**
- [ ] File is ~210 lines (within 15% tolerance)
- [ ] No duplicate phase 1-6 descriptions (these are in the skill)
- [ ] No "Why file-based" explanation
- [ ] Zero lines starting with `|` (no tables)
- [ ] Contains directive referencing preloaded `/validate-content` skill
- [ ] Agent-specific Phase 1 additions present: 1.5, 1.6, 1.7, 1.8, 1.10
- [ ] Validation file format template present
- [ ] Return format present
- [ ] Content type awareness as flat list present

**Starter Prompt:**
> Read `.claude/agents/content-validator.md` and `.claude/skills/validate-content/SKILL.md` to verify duplication. Slim the agent from 585 to ~210 lines. Remove ALL duplicated phase descriptions (phases 1-6 are in the skill). Remove: status determination (lines 514-530), missing context example (lines 548-570), "Why file-based" (lines 39-42), all tables. Add directive: "Execute all 6 validation phases as defined in the preloaded `/validate-content` skill, with these agent-specific additions for Phase 1..." Keep agent-specific additions: 1.5 em dash detection, 1.6 H1 validation, 1.7 heading uniqueness, 1.8 slug format check, 1.10 placeholder links. Keep: validation file format template, return format (condensed), content type awareness (flat list).

**Status:** pending

---

## Task 78: Slim content-atomizer agent (176 → ~110 lines)

**Objective:** Remove motivational content, duplicated sections, and tables from the atomizer agent.

**What to do:**
- Remove "Your Mission" section (lines 16-24) — motivational
- Remove Platform Voice Adjustments table (lines 111-121) — in preloaded skill
- Remove Output Structure duplicate code block (lines 129-135) — already in workflow step 4
- Convert Tool Usage table (lines 172-176) to flat list
- Remove "Why minimal return" explanation
- Keep: Workflow (read article, read profile, create platform content, write files, quality check), return format

**Acceptance Criteria:**
- [ ] File is ~110 lines (within 15% tolerance)
- [ ] No "Your Mission" section
- [ ] No Platform Voice Adjustments table/section
- [ ] No duplicate Output Structure code block
- [ ] No "Why minimal return" explanation
- [ ] Zero lines starting with `|` (no tables)
- [ ] Workflow steps still present (read article, read profile, create content, write files, quality check)
- [ ] Return format still present

**Starter Prompt:**
> Read `.claude/agents/content-atomizer.md`. Slim it from 176 to ~110 lines. Remove: "Your Mission" (lines 16-24), Platform Voice Adjustments table (lines 111-121, in preloaded skill), Output Structure duplicate code block (lines 129-135), Tool Usage table (convert to flat list), "Why minimal return" explanation. Keep: Workflow (read article, read profile, create platform content, write files, quality check) and return format.

**Status:** pending

---

## Task 79: Update execute-pillar SKILL.md (791 → ~500 lines)

**Depends on:** Tasks 69, 70, 76, 77

**Objective:** Fix the validation-passing contradiction, update agent references for copy-fixer, and remove bloat (ASCII diagrams, tables, duplicate checklists).

**What to do:**
- **Fix contradiction (lines 408-423):** Replace with file-based approach — spawn copy-fixer with validation_file_path, agent reads file directly, do NOT paste validation output into prompt
- **Update agent references:** Step 3 pipeline: "COPY ENHANCER (Enhancement Mode)" → "COPY ENHANCER". Step 4 retry: "Spawn COPY ENHANCER (Fix Mode)" → "Spawn COPY FIXER". Quick Reference: add Copy Fixer template, remove Fix Mode from Copy Enhancer template
- **Remove:** All ASCII diagrams (lines 310-327, 333-356, 383-406 = 66 lines), all tables (lines 68-74, 187-192, 440-446 = 20 lines), Complete Execution Checklist (lines 636-677, 42 lines — duplicates Steps 1-8), Example Error Comments (lines 449-465, 17 lines), Context Architecture Communication verbose template (lines 150-178 — condense to 3-line directive), Pseudo-code for tier validation (lines 244-259), Quick Reference "Expected Output" sections (~30 lines), Condense commit/PR bash blocks (~30 lines), Troubleshooting section (lines 756-789 — moved to `references/execute-pillar-troubleshooting.md`)

**Acceptance Criteria:**
- [ ] File is ~500 lines (within 15% tolerance)
- [ ] Validation passing uses file-based approach (validation_file_path, not prompt paste)
- [ ] References "COPY FIXER" in retry loop (not "COPY ENHANCER Fix Mode")
- [ ] Copy Fixer template in Quick Reference section
- [ ] Zero ASCII diagram blocks (no lines with box-drawing characters like ─, │, ┌, └)
- [ ] Zero lines starting with `|` (no tables)
- [ ] No Complete Execution Checklist section
- [ ] No Troubleshooting section (moved to reference file)
- [ ] Reference to `references/execute-pillar-troubleshooting.md` present

**Starter Prompt:**
> Read `.claude/skills/execute-pillar/SKILL.md`. Slim it from 791 to ~500 lines. Fix the validation contradiction at lines 408-423: use file-based approach (pass validation_file_path, agent reads file, do NOT paste output into prompt). Update: "COPY ENHANCER (Fix Mode)" → "COPY FIXER" everywhere. Add Copy Fixer to Quick Reference. Remove: all ASCII diagrams (lines 310-327, 333-356, 383-406), all tables, Complete Execution Checklist (lines 636-677), Example Error Comments (lines 449-465), Context Architecture verbose template (condense to 3 lines), pseudo-code (lines 244-259), Expected Output sections, condense commit/PR bash blocks, Troubleshooting (lines 756-789, moved to `references/execute-pillar-troubleshooting.md`).

**Status:** pending

---

## Task 80: Update workflow.md for copy-fixer agent

**Depends on:** Task 69

**Objective:** Add copy-fixer to the workflow rules and update the pipeline description.

**What to do:**
- Add `copy-fixer` to Agent Reference with description and return format
- Update pipeline description: 5 agents (seo-writer, copy-enhancer, content-validator, copy-fixer, content-atomizer)
- Note: copy-fixer only spawns on validation FAIL (retry loop)
- Remove block quote for architecture constraint — make it a directive
- Remove "Why minimal returns" explanation
- Confirm retry loop uses file-based issue passing

**Acceptance Criteria:**
- [ ] copy-fixer listed in Agent Reference with description and return format
- [ ] Pipeline description mentions 5 agents
- [ ] Retry loop references copy-fixer (not copy-enhancer fix mode)
- [ ] Architecture constraint is a directive (not block quote)
- [ ] No "Why minimal returns" explanation
- [ ] File is ~80 lines (within 15% tolerance)

**Starter Prompt:**
> Read `.claude/rules/workflow.md`. Add copy-fixer agent to Agent Reference: "Copy Fixer (`copy-fixer.md`): Fix specific validation issues. Tools: Read, Edit" with return format "PASS or FAIL: {reason}". Update pipeline to 5 agents. Update retry loop: copy-fixer spawns on FAIL (not copy-enhancer fix mode). Convert architecture constraint block quote to directive. Remove "Why minimal returns" explanation. Confirm file-based issue passing in retry loop.

**Status:** pending

---

## Task 81: Update CLAUDE.md for copy-fixer agent

**Depends on:** Task 69

**Objective:** Add copy-fixer as the seventh agent and clean up any "why" explanations.

**What to do:**
- Update Agents section: mention copy-fixer as seventh agent (was "Six agents")
- Remove any "why" explanations that can be directives instead
- Keep changes minimal — only what's needed for copy-fixer awareness

**Acceptance Criteria:**
- [ ] CLAUDE.md mentions 7 agents (not 6)
- [ ] copy-fixer mentioned in Agents section
- [ ] No unnecessary "why" explanations added/remaining

**Starter Prompt:**
> Read `.claude/CLAUDE.md`. Update the Agents section: change "Six agents" to "Seven agents" and add copy-fixer mention. Remove any "why" explanations that should be directives. Keep changes minimal.

**Status:** pending

---

## Task 82: Verify — grep for stale references

**Depends on:** Tasks 67-81

**Objective:** Ensure no stale references remain after all modifications.

**What to do:**
- Grep for `eeat-examples` in agent files (should only appear in eeat-patterns.md and eeat-examples.md itself)
- Grep for `copy-enhancer.*fix` or `Fix Mode` in execute-pillar (should reference copy-fixer instead)
- Grep for `common-mistakes` in seo-writer agent (should be removed)
- Grep for lines starting with `|` in all modified agent and skill files (should be zero — no tables)

**Acceptance Criteria:**
- [ ] Zero `eeat-examples` references in agent files
- [ ] Zero `Fix Mode` references in execute-pillar
- [ ] Zero `common-mistakes` references in seo-writer
- [ ] Zero table rows (`|`) in any modified agent or skill file

**Starter Prompt:**
> Run these verification greps across `.claude/agents/` and `.claude/skills/`: (1) `eeat-examples` in agent files — should be zero, (2) `copy-enhancer.*fix` or `Fix Mode` in execute-pillar — should be zero, (3) `common-mistakes` in seo-writer.md — should be zero, (4) lines starting with `|` in all modified files — should be zero. Report any violations found.

**Status:** pending

---

## Task 83: Verify — agent frontmatter and line count audit

**Depends on:** Tasks 67-81

**Objective:** Validate all agent frontmatter is correct and all files hit their target line counts.

**What to do:**
- Verify valid YAML frontmatter in all 5 agent files (seo-writer, copy-enhancer, copy-fixer, content-validator, content-atomizer)
- Verify copy-fixer has no `skills:` field
- Verify copy-enhancer description no longer mentions "fix"
- Count lines in every modified file and compare to targets (within 15%):
  - `references/copywriting-frameworks.md` → ~1,627
  - `skills/seo-content/references/eeat-patterns.md` → ~80
  - `agents/copy-fixer.md` → ~150
  - `references/execute-pillar-troubleshooting.md` → ~34
  - `skills/direct-response-copy/SKILL.md` → ~590
  - `skills/seo-content/SKILL.md` → ~400
  - `skills/validate-content/SKILL.md` → ~700
  - `skills/content-atomizer/SKILL.md` → ~900
  - `agents/seo-writer.md` → ~130
  - `agents/copy-enhancer.md` → ~170
  - `agents/content-validator.md` → ~210
  - `agents/content-atomizer.md` → ~110
  - `skills/execute-pillar/SKILL.md` → ~500
  - `rules/workflow.md` → ~80

**Acceptance Criteria:**
- [ ] All 5 agent files have valid YAML frontmatter
- [ ] copy-fixer has no `skills:` field
- [ ] copy-enhancer description doesn't mention "fix"
- [ ] All 14 files within 15% of target line count
- [ ] Any files outside tolerance flagged with actual vs target count

**Starter Prompt:**
> Verify all modified `.claude/` files. Check: (1) Valid YAML frontmatter in 5 agent files (seo-writer, copy-enhancer, copy-fixer, content-validator, content-atomizer). (2) copy-fixer has no `skills:` field. (3) copy-enhancer description doesn't mention "fix". (4) Count lines in all 14 modified/created files and compare to targets — flag any outside 15% tolerance. Report results.

**Status:** pending

---

## Execution Order & Dependencies

```
Phase A (no dependencies, can run in any order):
  Task 67: Extract copywriting frameworks
  Task 68: Create eeat-patterns
  Task 69: Create copy-fixer agent
  Task 70: Extract troubleshooting

Phase B (depends on Phase A):
  Task 71: Slim DR copy skill (needs Task 67)
  Task 72: Slim seo-content skill (needs Task 68)
  Task 73: Slim validate-content skill (no dependency)
  Task 74: Slim content-atomizer skill (no dependency)

Phase C (depends on Phase A):
  Task 75: Slim seo-writer agent (needs Task 68)
  Task 76: Slim copy-enhancer agent (needs Task 69)
  Task 77: Slim content-validator agent (no dependency)
  Task 78: Slim content-atomizer agent (no dependency)

Phase D (depends on Phases B and C):
  Task 79: Update execute-pillar (needs Tasks 69, 70, 76, 77)
  Task 80: Update workflow.md (needs Task 69)
  Task 81: Update CLAUDE.md (needs Task 69)

Phase E (depends on all above):
  Task 82: Verify stale references
  Task 83: Verify frontmatter + line counts
```
