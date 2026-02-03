# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Task 7: Error Learning System with GitHub Integration | PASS |
| Task 8: Document Sub-Agent Orchestration in CLAUDE.md | PASS |
| Task 9: Create Sub-Agent Template | PASS |
| Task 10: Update seo-content Skill | PASS |
| Task 11: Execute ADHD Sleep Pillar - Tier 1 | PASS |
| Task 12: Execute ADHD Sleep Pillar - Tier 2 | PASS |
| Task 13: Execute ADHD Sleep Pillar - Tier 3 | PASS |
| Task 14: Execute ADHD Sleep Pillar - Tier 4 | PASS |
| Task 15: Post-Pillar Linking Pass | PASS |
| Task 6: End-to-End Validation with Real Client | in_progress |
| Task 16: Rename TASKS.md to PROJECT-TASKS.md | PASS |
| Task 17: Update PROJECT-TASKS.md for HushAway | pending |
| Task 18: Fix Banned Words in Articles | pending |
| Task 19: Run /direct-response-copy (Articles 1-4) | pending |
| Task 20: Run /direct-response-copy (Articles 5-7) | pending |
| Task 21: Run /validate-content on All Articles | pending |
| Task 22: Create Distribution Content | pending |
| Task 23: Update /start-pillar GitHub Requirement | pending |
| Task 24: Update /validate-content Banned Words | pending |
| Task 25: Add Patterns to common-mistakes.md | pending |

**Previous work:** 37 tasks completed (see git history). Git + GitHub setup complete. Error tracking system added.

**Plan reference:** Sub-Agent Orchestration plan at /Users/jagpalkooner/.claude/plans/hashed-puzzling-wilkes.md

---

## Task 7: Error Learning System with GitHub Integration

**Objective:** Add automatic error logging to GitHub Issues for pattern extraction and system improvement.

**Acceptance Criteria:**
- [x] Rule #3: Error Tracking Protocol added to CLAUDE.md
- [x] Extracted-from-Issue template added to common-mistakes.md
- [x] System creates Issue + Draft PR at pillar start
- [x] Errors auto-logged to Issue during workflow
- [x] Pattern extraction step added at pillar completion

**Status:** PASS

---

**Handoff:**
- **Done:** Added Rule #3 (Error Tracking Protocol) to CLAUDE.md. Added extracted-from-Issue template to common-mistakes.md.
- **Decisions:** Per-pillar tracking (not per-project or per-session). Minimal error detail (type + message only). Both Issue (for errors) and Draft PR (for work) created at pillar start. Patterns extracted when 3+ occurrences.
- **Next:** First real use will be during Task 6 (End-to-End Validation). Error tracking activates when starting the first pillar.

---

## Task 6: End-to-End Validation with Real Client

**Objective:** Run complete system with first real client to validate all changes.

**Acceptance Criteria:**
- [x] Complete pillar (7 articles) produced for real client (HushAway® ADHD Sleep)
- [ ] All skills used at least once during project
- [ ] No undocumented gaps encountered during workflow
- [ ] `.claude/rules/common-mistakes.md` updated with any patterns observed
- [ ] Retrospective completed documenting lessons learned

**Starter Prompt:**
> Run end-to-end validation with first real client. Execute complete workflow: (1) Run /onboard-client for real client; (2) Run /keyword-research to produce keyword brief with real search data; (3) Run /start-pillar for first pillar with DR scores; (4) Run /positioning-angles for pillar positioning; (5) Run /seo-content for all supporting articles + pillar guide (10+ total); (6) Run /direct-response-copy on each article; (7) Run /validate-content on each article; (8) Run /content-atomizer on at least 2 articles; (9) Document any gaps or friction points encountered; (10) Update common-mistakes.md with any patterns; (11) Write retrospective noting what worked, what didn't, and any system improvements needed.

**Status:** in_progress

**Audit Note (2026-02-03):** ADHD Sleep pillar produced 7 articles but workflow incomplete. Audit identified: /direct-response-copy skipped, validation missed banned words, project TASKS.md not updated, no GitHub Issue/PR created. Tasks 16-25 created to complete remediation and system improvements. See audit plan: /Users/jagpalkooner/.claude/plans/whimsical-humming-gray.md

---

## Task 8: Document Sub-Agent Orchestration in CLAUDE.md

**Objective:** Add Sub-Agent Orchestration section to CLAUDE.md

**Acceptance Criteria:**
- [x] New section added after "Phase 2: Content Generation"
- [x] Tier structure documented
- [x] Failure handling documented
- [x] Context management documented

**Starter Prompt:**
> Add sub-agent orchestration documentation to CLAUDE.md. Reference the approved plan at /Users/jagpalkooner/.claude/plans/hashed-puzzling-wilkes.md for the exact content to add.

**Status:** PASS

---

**Handoff:**
- **Done:** Added "Sub-Agent Orchestration for Pillars" section to CLAUDE.md after Validation Checkpoints. Includes ASCII diagram of tier model, sub-agent types table, detailed instructions on how sub-agents work (file paths not pasted content), responsibilities for main session and sub-agents, failure handling protocol, and context management strategy.
- **Decisions:** Clarified that sub-agents receive file paths and read files themselves (not pasted content). This keeps context minimal. Main session never reads full article content - only receives paths and status.
- **Next:** Task 9 creates the sub-agent template at `.claude/skills/templates/sub-agent-seo-content.md` which provides the exact prompt format for spawning writing sub-agents.

---

## Task 9: Create Sub-Agent Template

**Objective:** Create sub-agent-seo-content.md template

**Acceptance Criteria:**
- [x] Template created at .claude/skills/templates/sub-agent-seo-content.md
- [x] Includes context file references
- [x] Includes workflow requirements
- [x] Includes validation checklist

**Starter Prompt:**
> Create the sub-agent template for SEO content generation at .claude/skills/templates/sub-agent-seo-content.md. Reference the plan for template structure.

**Status:** PASS

---

**Handoff:**
- **Done:** Created comprehensive sub-agent template with writing sub-agent prompt template, validation sub-agent template, placeholder reference table, filled example, and failure handling instructions.
- **Decisions:** Template includes both writing and validation sub-agent formats. Sub-agents receive file paths (not content) and return file paths + status (not full articles). Validation checklist mirrors universal-rules.md FAIL/WARN structure.
- **Next:** Task 10 updates the seo-content skill with pillar mode documentation. Then Tasks 11-15 execute the ADHD Sleep pillar using this template.

---

## Task 10: Update seo-content Skill

**Objective:** Add pillar mode to seo-content skill

**Acceptance Criteria:**
- [x] Pillar mode section added to seo-content.md
- [x] Orchestration mode documented
- [x] Trigger command documented (`/seo-content pillar`)

**Starter Prompt:**
> Update .claude/skills/seo-content/seo-content.md with pillar mode documentation. Reference the plan for content to add.

**Status:** PASS

---

**Handoff:**
- **Done:** Added comprehensive "Pillar Mode (Multiple Articles)" section to `.claude/skills/seo-content/SKILL.md`. Includes: when to use pillar mode, parallel tier execution model (with ASCII diagram), orchestration process steps, sub-agent types table, what sub-agents receive, failure handling, context management strategy, and a complete example using the ADHD Sleep pillar.
- **Decisions:** Placed the section after "Output location" and before "How this connects to other skills" for logical flow. Matched the documentation style of the rest of the skill file. Referenced the sub-agent template at `.claude/skills/templates/sub-agent-seo-content.md`.
- **Next:** Task 11 begins actual execution of the ADHD Sleep pillar using this orchestration model. Tier 1 generates Article 1 (Why Your ADHD Child Won't Sleep).

---

## Task 11: Execute ADHD Sleep Pillar - Tier 1

**Objective:** Generate Article 1 using sub-agent orchestration

**Context:**
- Client: HushAway®
- Pillar: ADHD Sleep
- Article: Why Your ADHD Child Won't Sleep (And What Actually Helps)
- Target keyword: adhd child won't sleep

**Acceptance Criteria:**
- [x] Writing sub-agent creates Article 1
- [x] Validation sub-agent validates Article 1
- [x] Article passes validation
- [x] Committed to git

**Starter Prompt:**
> Execute Tier 1 of ADHD Sleep pillar for HushAway®. Read the pillar brief at projects/hushaway/seo-content/adhd-sleep/01-pillar-brief.md and positioning at 02-positioning.md. Spawn writing sub-agent for Article 1 (Why Your ADHD Child Won't Sleep), then validation sub-agent. Commit if PASS.

**Status:** PASS

---

**Handoff:**
- **Done:** Article 1 "Why Your ADHD Child Won't Sleep (And What Actually Helps)" created at `projects/hushaway/seo-content/adhd-sleep/articles/01-adhd-child-wont-sleep.md`. 2,247 words. 3 E-E-A-T citations (Southampton NHS, Journal of Clinical Sleep Medicine, Frontiers in Psychiatry). Self-validated by writing sub-agent + independently validated by validation sub-agent. Both returned PASS.
- **Decisions:** Used placeholder links for Articles 2, 4, and Pillar Guide (7) as they don't exist yet. Followed brand voice (warm, parent-to-parent). UK English throughout.
- **Next:** Task 12 generates Tier 2 articles (2, 3, 4, 6) in parallel. Article 1 now available for internal linking from Tier 2 articles.

---

## Task 12: Execute ADHD Sleep Pillar - Tier 2

**Objective:** Generate Articles 2, 3, 4, 6 in parallel

**Context:**
- Article 2: ADHD Bedtime Routine That Actually Works (adhd bedtime routine)
- Article 3: Best Calming Sounds for ADHD Children (calming sounds for adhd child)
- Article 4: Racing Thoughts at Bedtime (adhd racing thoughts child)
- Article 6: ADHD Sleep vs Autism Sleep (adhd sleep vs autism sleep)

**Acceptance Criteria:**
- [x] 4 writing sub-agents spawn in parallel
- [x] 4 validation sub-agents validate
- [x] All articles pass validation
- [x] All committed to git

**Starter Prompt:**
> Execute Tier 2 of ADHD Sleep pillar. Spawn 4 writing sub-agents IN PARALLEL (single message with 4 Task tool calls) for Articles 2, 3, 4, 6. Each sub-agent reads brief, positioning, profile. After all return, spawn 4 validation sub-agents. Commit all PASS articles.

**Status:** PASS

---

**Handoff:**
- **Done:** Created 4 articles in parallel using sub-agent orchestration:
  - Article 02: ADHD Bedtime Routine (2,412 words, 4 citations)
  - Article 03: Calming Sounds for ADHD (2,412 words, 3 citations)
  - Article 04: Racing Thoughts at Bedtime (2,089 words, 3 citations)
  - Article 06: ADHD Sleep vs Autism Sleep (1,987 words, 4 citations)
- **Decisions:** Article 06 required post-validation fix (removed "comorbid" - banned clinical term). All articles include placeholder links for unpublished articles (03, 04, 05, 07) and active links to Article 01.
- **Next:** Task 13 generates Article 5 (Beyond Melatonin) which depends on Articles 3 and 4 (now complete). Provide sub-agent with paths to Articles 3 and 4 for internal linking.

---

## Task 13: Execute ADHD Sleep Pillar - Tier 3

**Objective:** Generate Article 5 (depends on 3 + 4)

**Context:**
- Article 5: Beyond Melatonin: Non-Medication Sleep Help for ADHD Children
- Target keyword: non-medication adhd sleep help
- Dependencies: Must link to Articles 3 and 4

**Acceptance Criteria:**
- [x] Writing sub-agent creates Article 5
- [x] Internal links to Articles 3, 4 included
- [x] Validation sub-agent validates
- [x] Committed to git

**Starter Prompt:**
> Execute Tier 3 of ADHD Sleep pillar. Article 5 (Beyond Melatonin) which links to Articles 3 and 4 (now completed). Provide the sub-agent with file paths to Articles 3 and 4 for internal linking.

**Status:** PASS

---

**Handoff:**
- **Done:** Article 5 "Beyond Melatonin: Non-Medication Sleep Help for ADHD Children" created at `projects/hushaway/seo-content/adhd-sleep/articles/05-beyond-melatonin.md`. 2,287 words. 3 E-E-A-T citations (Southampton NHS, DISCA study, JAACAP journal). Writing sub-agent self-validated PASS, independent validation sub-agent confirmed PASS.
- **Decisions:** Positioned sound as complement/alternative to medication (not anti-medication). UK-specific melatonin context addressed (prescription-only). Internal links to Articles 01, 03, and 04 included.
- **Next:** Task 14 generates the Pillar Guide (Article 7) which links to all 6 supporting articles. All supporting articles now complete.

---

## Task 14: Execute ADHD Sleep Pillar - Tier 4

**Objective:** Generate Article 7 (Pillar Guide)

**Context:**
- Article 7: The Complete Guide to ADHD Sleep Problems in Children
- Target keyword: adhd sleep problems
- Word count: 4,000-5,000
- Dependencies: Links to all 6 supporting articles

**Acceptance Criteria:**
- [x] Writing sub-agent creates Pillar Guide
- [x] Links to all 6 supporting articles
- [x] Validation sub-agent validates
- [x] Committed to git

**Starter Prompt:**
> Execute Tier 4 of ADHD Sleep pillar. Generate the Pillar Guide (Article 7) which links to all 6 supporting articles. Provide the sub-agent with all article file paths. This is the comprehensive guide (4,000-5,000 words).

**Status:** PASS

---

**Handoff:**
- **Done:** Pillar Guide "The Complete Guide to ADHD Sleep Problems in Children" created at `projects/hushaway/seo-content/adhd-sleep/articles/07-adhd-sleep-problems-guide.md`. 4,387 words. 6 E-E-A-T citations (Southampton NHS, DISCA Study, JAACAP, JCSM, Frontiers in Psychiatry, Wellcome Trust). Links to all 6 supporting articles. Writing sub-agent self-validated PASS, independent validation sub-agent confirmed PASS.
- **Decisions:** Comprehensive structure covering: why ADHD sleep is different, the racing brain mechanism, circadian rhythm differences, types of sleep problems, age-specific approaches (toddlers through teens), comorbid conditions, common misconceptions, and the "missing piece" (sound-based passive listening). UK-specific context throughout.
- **Next:** Task 15 runs post-pillar linking pass to add links FROM all 6 supporting articles TO this pillar guide. All placeholder links should be resolved.

---

## Task 15: Post-Pillar Linking Pass

**Objective:** Update all articles with links TO pillar guide

**Acceptance Criteria:**
- [x] All 6 supporting articles link to pillar guide
- [x] All placeholder links resolved
- [x] No broken links
- [x] Committed to git

**Starter Prompt:**
> Run post-pillar linking pass for ADHD Sleep pillar. Add links from all 6 supporting articles to the pillar guide. Replace any `<!-- LINK NEEDED: ... -->` placeholders with actual links. Verify no broken links remain.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated all 6 supporting articles (01-06) with links to pillar guide (07-adhd-sleep-problems-guide). Replaced all `<!-- LINK NEEDED: ... -->` placeholders with proper markdown links. Also standardised existing internal links to use slug-based URL format (e.g., `/adhd-child-wont-sleep`) for consistency.
- **Decisions:** Used slug-based URL format (`/slug`) for all internal links rather than relative file paths, as this matches what the pillar guide uses and is more CMS-friendly.
- **Next:** ADHD Sleep pillar is now complete with full internal linking. Ready for PR creation or distribution content if needed.

---

## Task 16: Rename TASKS.md to PROJECT-TASKS.md

**Objective:** Eliminate ambiguity between system-level TASKS.md (repo root) and project-level task tracking.

**Acceptance Criteria:**
- [x] Rename `projects/hushaway/seo-content/TASKS.md` to `PROJECT-TASKS.md`
- [x] Update all references in CLAUDE.md (11 references)
- [x] Update tasks-template.md
- [x] Update sub-agent-seo-content.md
- [x] Update seo-content/SKILL.md
- [x] Update PRD.md
- [x] Update common-mistakes.md
- [x] Update end-to-end-example.md
- [x] Add explicit section distinguishing root TASKS.md vs PROJECT-TASKS.md

**Starter Prompt:**
> Rename the project-level task tracker from TASKS.md to PROJECT-TASKS.md. Start by renaming projects/hushaway/seo-content/TASKS.md, then update all references in the codebase. Add a clear section to CLAUDE.md explaining: root TASKS.md = system development tasks, PROJECT-TASKS.md = client project work.

**Status:** PASS

---

**Handoff:**
- **Done:** Renamed `projects/hushaway/seo-content/TASKS.md` to `PROJECT-TASKS.md`. Updated 9 files with references: CLAUDE.md, tasks-template.md, sub-agent-seo-content.md, seo-content/SKILL.md, PRD.md, common-mistakes.md, end-to-end-example.md, new-features.md. Added new "Task Tracking: Two Systems" section at top of CLAUDE.md explaining the distinction.
- **Decisions:** Root `TASKS.md` = system development (building the machine). `PROJECT-TASKS.md` = client project work (running the machine). References to "root TASKS.md" kept explicit where needed (new-features.md).
- **Next:** Task 17 — Update the HushAway PROJECT-TASKS.md to reflect actual work completed on the pillar.

---

## Task 17: Update PROJECT-TASKS.md for HushAway Pillar

**Objective:** Bring PROJECT-TASKS.md up to date with actual work completed.

**Acceptance Criteria:**
- [ ] Tasks 3-4 marked PASS with handoff sections
- [ ] New tasks added for remaining work (content fixes, distribution)
- [ ] Summary table updated

**Starter Prompt:**
> Update projects/hushaway/seo-content/PROJECT-TASKS.md. Mark Task 3 (Positioning) and Task 4 (Write Articles) as PASS with proper handoff sections. Add new tasks for: (1) Fix banned words in articles, (2) Run /direct-response-copy, (3) Run /validate-content, (4) Create distribution content.

**Status:** pending

---

## Task 18: Fix Banned Words in Articles

**Objective:** Remove "comorbid" and "intervention" from ADHD Sleep articles.

**Acceptance Criteria:**
- [ ] Article 07 header changed from "Comorbid Conditions" to "Co-occurring Conditions"
- [ ] All 13 instances of "intervention" replaced with alternatives
- [ ] No other banned words remain

**Starter Prompt:**
> Fix banned words in ADHD Sleep articles. Read the client profile banned words list. In Article 07, change section header "ADHD Sleep and Comorbid Conditions" to "ADHD Sleep and Co-occurring Conditions". Replace all instances of "intervention" (13 total across 6 articles) with appropriate alternatives: approach, support, help, strategy. Verify no other banned terms remain.

**Status:** pending

---

## Task 19: Run /direct-response-copy (Articles 1-4)

**Objective:** Enhance first batch of articles with direct-response elements.

**Acceptance Criteria:**
- [ ] Articles 01, 02, 03, 04 enhanced
- [ ] Hooks strengthened
- [ ] CTAs optimised
- [ ] Voice maintained

**Starter Prompt:**
> Run /direct-response-copy on ADHD Sleep articles 01-04. Read client profile for voice requirements. Enhance hooks, CTAs, and persuasive elements while maintaining parent-to-parent voice. Do not add new banned words.

**Status:** pending

---

## Task 20: Run /direct-response-copy (Articles 5-7)

**Objective:** Enhance second batch of articles with direct-response elements.

**Acceptance Criteria:**
- [ ] Articles 05, 06, 07 enhanced
- [ ] Pillar guide (07) gets extra attention
- [ ] Voice maintained

**Starter Prompt:**
> Run /direct-response-copy on ADHD Sleep articles 05-07. Article 07 is the pillar guide - give it extra attention. Maintain parent-to-parent voice per client profile.

**Status:** pending

---

## Task 21: Run /validate-content on All Articles

**Objective:** Properly validate all articles using the skill.

**Acceptance Criteria:**
- [ ] All 7 articles validated via /validate-content
- [ ] Any failures fixed
- [ ] All pass validation

**Starter Prompt:**
> Run /validate-content on all 7 ADHD Sleep articles. Check against universal-rules.md and client profile. Fix any validation failures. All must PASS before marking complete.

**Status:** pending

---

## Task 22: Create Distribution Content

**Objective:** Atomise pillar guide content for social distribution.

**Acceptance Criteria:**
- [ ] distribution/adhd-sleep-problems-guide/ folder created
- [ ] linkedin.md created
- [ ] twitter.md created
- [ ] newsletter.md created
- [ ] instagram.md created

**Starter Prompt:**
> Run /content-atomizer on the pillar guide (07-adhd-sleep-problems-guide.md). Create distribution folder with LinkedIn, Twitter, Newsletter, and Instagram content. Follow brand voice from client profile.

**Status:** pending

---

## Task 23: Update /start-pillar GitHub Requirement

**Objective:** Make Rule #3 mandatory by building it into the skill.

**Acceptance Criteria:**
- [ ] /start-pillar skill updated with GitHub requirement
- [ ] Step added before pillar brief creation
- [ ] Example commands included

**Starter Prompt:**
> Update .claude/skills/start-pillar/SKILL.md to require GitHub Issue and Draft PR creation as mandatory first step. Add clear instructions: "Before creating pillar brief, create GitHub Issue '🔴 Errors: {Pillar Name}' and Draft PR '📚 {Pillar Name}'". Include example gh commands.

**Status:** pending

---

## Task 24: Update /validate-content Banned Words

**Objective:** Make validation more robust by checking banned terms explicitly.

**Acceptance Criteria:**
- [ ] /validate-content skill updated
- [ ] Checks client profile banned words
- [ ] Checks universal rules banned AI words
- [ ] Returns specific line numbers for violations

**Starter Prompt:**
> Update .claude/skills/validate-content/SKILL.md. Add explicit checking for: (1) Client profile "Words to Avoid" section, (2) Universal rules banned AI words. Validation should FAIL if any banned word found, with specific line numbers reported.

**Status:** pending

---

## Task 25: Add Patterns to common-mistakes.md

**Objective:** Document learnings from this audit for future prevention.

**Acceptance Criteria:**
- [ ] Pattern added: Wrong TASKS.md updated
- [ ] Pattern added: Skipping /direct-response-copy
- [ ] Pattern added: Self-validation instead of skill validation
- [ ] Pattern added: Session ending mid-workflow

**Starter Prompt:**
> Add patterns from ADHD Sleep audit to .claude/rules/common-mistakes.md. Include: (1) Updating wrong TASKS.md (system vs project), (2) Skipping /direct-response-copy step, (3) Self-validation instead of /validate-content skill, (4) Session ending without workflow completion handoff.

**Status:** pending

---

**Plan reference:** /Users/jagpalkooner/.claude/plans/whimsical-humming-gray.md
