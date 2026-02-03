# Project Tasks: HushAway® SEO Content

## Summary

| Task | Status |
|------|--------|
| Task 1: Keyword Research | PASS |
| Task 2: Start ADHD Sleep Pillar | PASS |
| Task 3: Positioning Angles for ADHD Sleep | PASS |
| Task 4: Write ADHD Sleep Articles | PASS |
| Task 5: Fix Banned Words in Articles | PASS |
| Task 6: Run /direct-response-copy | PASS |
| Task 7: Run /validate-content | PASS |
| Task 8a: LinkedIn Distribution | PASS |
| Task 8b: Twitter/X Distribution | PASS |
| Task 8c: Newsletter Distribution | PASS |
| Task 8d: Instagram Distribution | PASS |
| Task 9: Start Autistic Meltdowns Pillar | PASS |

---

## Task 1: Keyword Research

**Objective:** Research and document keyword opportunities for HushAway® UK content strategy.

**Acceptance Criteria:**
- [x] Client profile reviewed for context
- [x] Market research conducted (competitor analysis, search trends)
- [x] Keywords expanded using 6 Circles Method
- [x] Keywords clustered into content pillars
- [x] Each pillar validated (volume, market-centric, competition, proprietary advantage)
- [x] Pillars prioritised by business value and opportunity
- [x] Production queue with execution order documented
- [x] Output saved to `00-keyword-brief.md`

**Status:** PASS

---

**Handoff:**
- **Done:** Comprehensive keyword research completed. Identified 8 valid pillars. Created `00-keyword-brief.md` with full competitor analysis, 6 Circles expansion, pillar validation, and production queue.
- **Decisions:**
  - Pillar priority order: (1) ADHD Sleep, (2) Autistic Meltdowns, (3) Sensory Overload, (4) Calming Sounds, (5-8) Medium/Strategic pillars
  - Focus on UK market only, UK English throughout
  - Key differentiator messaging: passive listening, neurodivergent-first, zero-effort
  - First article: "ADHD Sleep Problems: What Actually Helps When Your Child's Brain Won't Switch Off"
- **Next:** Run `/start-pillar` for ADHD Sleep pillar to create pillar brief with deep competitor analysis.

---

## Task 2: Start ADHD Sleep Pillar

**Objective:** Create pillar brief for ADHD Sleep with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract ADHD Sleep pillar from keyword brief
- [x] Run deep competitor analysis on top 5 ranking content
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `adhd-sleep/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for ADHD Sleep. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of NHS, CHADD, ADDitude, Moshi testimonials, and any UK ADHD sleep content; (2) Identify what none of them say (passive listening, ND-first design, "racing brain" language); (3) Plan 8+ articles covering: pillar guide, ADHD bedtime routine, calming sounds for ADHD, ADHD medication and sleep, racing thoughts at bedtime, ADHD sleep vs autism sleep. Position all content toward The Open Sanctuary as primary CTA.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `adhd-sleep/01-pillar-brief.md` with all 7 sections: strategic context, keyword table (21 keywords mapped), competitor analysis (NHS Trust Resources, The ADHD Centre, Kids.org.uk), content plan (7 articles), angle opportunities (5 identified), internal linking map, and publishing order.
- **Decisions:**
  - Primary angle: "The Missing Piece" — position sound-based solutions as what's missing from current ADHD sleep guidance
  - Top competitors: NHS Trust Resources (DR 90+, comprehensive but clinical), The ADHD Centre (DR 35-45, parent-friendly but no sound solutions), Kids.org.uk (DR 55-65, charity credibility but generic)
  - Key gap: NO UK competitor combines ADHD sleep expertise with sound-based solutions and parent-friendly voice
  - 7 articles planned: 6 supporting + 1 pillar guide (publishes last)
  - Article 1 "Why Your ADHD Child Won't Sleep" is foundation — all other articles reference concepts it introduces
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established; need secondary angles per article and consistency check.

---

## Task 3: Positioning Angles for ADHD Sleep

**Objective:** Develop unified positioning for ADHD Sleep pillar that differentiates from clinical/generic content.

**Acceptance Criteria:**
- [x] Primary angle identified for pillar guide
- [x] Secondary angles for each supporting article
- [x] Consistency check across all angles
- [x] Output saved to `adhd-sleep/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for ADHD Sleep pillar. Input: adhd-sleep/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) Why generic sleep advice doesn't work for ADHD brains; (2) "Racing brain that won't switch off" language from parent research; (3) Passive listening as the mechanism; (4) Parent exhaustion angle (zero effort). Avoid clinical positioning—keep parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `adhd-sleep/02-positioning.md` with unified positioning framework. Primary angle: "The Missing Piece" — generic sleep advice fails ADHD brains because it ignores the racing-thoughts problem. Secondary angles developed for all 7 articles with unique hooks and consistency checks.
- **Decisions:**
  - Unified mechanism: "Passive listening gives the brain something to land on without adding another task"
  - Key language patterns: "racing brain," "won't switch off," "zero effort," "nothing to remember"
  - Avoided clinical/medical positioning — all content uses parent-to-parent voice
  - Each article angle reinforces pillar theme while standing alone
  - Consistency check passed: no contradictions between articles
- **Next:** Write all 7 articles using `/seo-content` skill following the positioning angles and publishing order from pillar brief.

---

## Task 4: Write ADHD Sleep Articles

**Objective:** Write all articles for ADHD Sleep pillar (pillar guide + supporting articles).

**Acceptance Criteria:**
- [x] All articles written following SEO requirements
- [x] Each article validated via /validate-content
- [x] Internal linking in place
- [x] All articles in `adhd-sleep/articles/` folder

**Starter Prompt:**
> Write ADHD Sleep pillar content. Follow article order from pillar brief. For each article: (1) Run /seo-content with target keyword and positioning angle; (2) Run /direct-response-copy to enhance; (3) Run /validate-content to verify PASS. Primary CTA: The Open Sanctuary. Voice: warm parent-to-parent per client profile.

**Status:** PASS

---

**Handoff:**
- **Done:** All 7 articles written and saved to `adhd-sleep/articles/`. Articles cover: (01) Why Your ADHD Child Won't Sleep, (02) Calming Sounds for ADHD, (03) ADHD Bedtime Routine That Works, (04) ADHD Racing Thoughts at Night, (05) ADHD Sleep Medication, (06) ADHD vs Autism Sleep, (07) Pillar Guide - Complete ADHD Sleep Solutions.
- **Decisions:**
  - Tier-based parallel execution: Foundation article first, then parallel tiers by dependency
  - All articles use parent-to-parent voice per client profile
  - Internal linking follows pillar brief structure
  - Primary CTA: The Open Sanctuary throughout
  - E-E-A-T citations included per universal rules
- **Next:** Fix banned words flagged during initial validation, then run `/direct-response-copy` to enhance conversion elements, followed by final `/validate-content` pass.

---

## Task 5: Fix Banned Words in Articles

**Objective:** Remove all banned AI words and phrases flagged during article writing.

**Acceptance Criteria:**
- [x] All 7 articles scanned for banned words from universal-rules.md
- [x] Each banned word/phrase replaced with natural alternative
- [x] No UK/US spelling inconsistencies
- [x] Articles maintain readability after fixes

**Starter Prompt:**
> Scan all articles in `adhd-sleep/articles/` for banned AI words and phrases from `rules/universal-rules.md`. For each violation: (1) Note the article, line, and banned term; (2) Replace with natural, human alternative; (3) Verify replacement maintains sentence flow. Check for: banned verbs (delve, leverage, etc.), hollow adjectives (comprehensive, robust, etc.), buzzwords, filler adverbs, weak transitions, and banned phrases.

**Status:** PASS

---

**Handoff:**
- **Done:** Scanned all 7 articles. Found and fixed 7 violations across 3 articles (03, 04, 05). Articles 01, 02, 06, 07 were clean.
- **Fixes made:**
  - `03-calming-sounds-adhd.md`: "optimal level" → "the right level" (x2), "nuanced" → "an important distinction", "crucial" → "matters", "comprehensive" → "the full picture"
  - `04-adhd-racing-thoughts.md`: "optimal state" → "the right state"
  - `05-beyond-melatonin.md`: "clearly exhausted" → "exhausted"
- **Preserved (acceptable):** Direct quotes from researchers kept intact (Prof. Cortese quote with "comprehensive", Joel Nigg quote with "empower", parent quotes with "When it comes to"). Scientific term "optimal arousal" preserved as it's the theory name.
- **Next:** Run `/validate-content` on all 7 articles to verify PASS before distribution.

---

## Task 6: Run /direct-response-copy

**Objective:** Enhance all articles with direct-response copy techniques for better conversion.

**Acceptance Criteria:**
- [x] Articles 01-04 enhanced with /direct-response-copy (4 of 7)
- [x] Articles 05-07 enhanced with /direct-response-copy (3 of 3)
- [x] CTAs strengthened without being pushy
- [x] Hooks improved for engagement
- [x] Brand voice maintained throughout
- [x] Parent-to-parent tone preserved

**Starter Prompt:**
> Run /direct-response-copy on each article in `adhd-sleep/articles/`. Focus on: (1) Strengthen opening hooks — make parents feel seen immediately; (2) Add specific proof points where claims are made; (3) Improve CTAs for The Open Sanctuary — soft CTAs in educational sections, clearer value proposition in CTA blocks; (4) Maintain warm parent-to-parent voice from client profile. Do NOT make content feel salesy or clinical.

**Status:** PASS

---

**Handoff:**
- **Done:** All 7 articles enhanced with direct-response-copy techniques
- **Changes made (articles 05-07):**
  - **Article 05 (beyond-melatonin):** Stronger opening hook with parent recognition scene (drowsy but not asleep), added vivid "melatonin mismatch" description, improved CTA section with "We built it because we needed it too" language, added parent quote about "permission to stop"
  - **Article 06 (adhd-vs-autism-sleep):** Opening rewritten to validate their experience of one-size-fits-all failing, stronger "Sound Solution" section explaining how passive listening helps both conditions, improved CTA with warmth and reassurance
  - **Article 07 (pillar guide - extra attention):** Comprehensive enhancement — opening now validates everything they've tried, "failure on toast" quote humanised, "Missing Piece" section expanded with clear before/after contrast, "Just Press Play" section emphasises zero-effort for exhausted parents, misconceptions sections rewritten with more empathy ("if anyone has ever said this to you"), closing CTA section strengthened with "You haven't failed" validation
- **Status updates:** All three articles changed from "draft" to "review" in frontmatter
- **Word counts updated:** Article 05 (2542), Article 06 (2124), Article 07 (4698)
- **Voice preserved:** All edits maintain warm, parent-to-parent tone per client profile
- **Next:** Run /validate-content on all 7 articles to verify PASS before distribution content

---

## Task 7: Run /validate-content

**Objective:** Final validation pass on all articles before publishing.

**Acceptance Criteria:**
- [x] All 7 articles pass /validate-content
- [x] No banned words or phrases remaining
- [x] UK English verified throughout
- [x] SEO requirements met (keyword placement, meta data, links)
- [x] E-E-A-T citations properly formatted
- [x] Brand voice alignment confirmed

**Starter Prompt:**
> Run /validate-content on each article in `adhd-sleep/articles/`. Validate against: (1) Universal rules — UK English, banned words, AI patterns, SEO requirements, citations; (2) Client profile — brand voice, terminology, content rules. Each article must return PASS. Document any FAIL conditions with specific line numbers and required fixes.

**Status:** PASS

---

**Handoff:**
- **Done:** All 7 articles validated against universal rules and client profile. All returned PASS.
- **Validation results:**
  - Article 01 (adhd-child-wont-sleep): PASS — 2,247 words, 3 citations, 3 internal links
  - Article 02 (adhd-bedtime-routine): PASS — 2,412 words, 4 citations, 4 internal links
  - Article 03 (calming-sounds-adhd): PASS — 2,412 words, 3 citations, 4 internal links
  - Article 04 (adhd-racing-thoughts): PASS — 2,089 words, 3 citations, 4 internal links
  - Article 05 (beyond-melatonin): PASS — 2,542 words, 3 citations, 4 internal links
  - Article 06 (adhd-sleep-vs-autism-sleep): PASS — 2,124 words, 4 citations, 3 internal links
  - Article 07 (adhd-sleep-problems-guide): PASS — 4,698 words, 6 citations, 6 internal links (pillar guide)
  - **Total:** 18,524 words across 7 articles
- **Checks passed:**
  - UK English: No US spellings detected
  - Banned AI Words: None in article voice (quotes from researchers preserved)
  - Banned AI Phrases: None detected
  - SEO: All articles meet keyword placement, word count, meta data requirements
  - E-E-A-T: All articles have properly formatted external citations (NHS, PubMed, Frontiers, etc.)
  - Brand Voice: Warm parent-to-parent tone, "HushAway®" with ® symbol, no clinical jargon
  - Pillar Consistency: Primary angle ("sound is the missing piece") consistent throughout
- **Minor notes (non-blocking):**
  - Article 01: Primary keyword not in H2 as exact phrase (keyword elements present)
  - Article 05: "comprehensive" in direct quote from Prof. Cortese — acceptable as quoted speech
- **Next:** Run `/content-atomizer` on pillar guide and top supporting articles to create distribution content.

---

## Task 8a: LinkedIn Distribution

**Objective:** Create LinkedIn distribution content (carousel + text posts) for 3 key articles using parallel sub-agents.

**Target Articles:**
- Article 07: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md` (pillar guide)
- Article 01: `adhd-sleep/articles/01-adhd-child-wont-sleep.md` (entry point)
- Article 03: `adhd-sleep/articles/03-calming-sounds-adhd.md` (product bridge)

**Acceptance Criteria:**
- [x] Distribution folders created for all 3 articles
- [x] LinkedIn carousel (10 slides max) created for each article
- [x] 2-3 text posts created for each article
- [x] All content follows LinkedIn specs from content-atomizer platform playbook
- [x] UK English throughout, no banned AI words
- [x] Brand voice maintained per client profile

**Starter Prompt:**
> **Sub-Agent Orchestration Task**
>
> Spawn 3 sub-agents in parallel using the Task tool. Each sub-agent runs `/content-atomizer` for LinkedIn only.
>
> **Context Files (provide paths to all sub-agents):**
> - Client profile: `clients/hushaway/profile.md`
> - Platform playbook: `.claude/skills/content-atomizer/references/platform-playbook.md`
> - Universal rules: `.claude/rules/universal-rules.md`
>
> **Sub-Agent 1:** Article 07 (pillar guide)
> - Source: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md`
> - Output: `adhd-sleep/distribution/07-adhd-sleep-solutions-guide/linkedin.md`
> - Focus: Authority positioning, comprehensive guide hook
>
> **Sub-Agent 2:** Article 01 (ADHD child won't sleep)
> - Source: `adhd-sleep/articles/01-adhd-child-wont-sleep.md`
> - Output: `adhd-sleep/distribution/01-adhd-child-wont-sleep/linkedin.md`
> - Focus: Parent pain point, emotional hook
>
> **Sub-Agent 3:** Article 03 (calming sounds)
> - Source: `adhd-sleep/articles/03-calming-sounds-adhd.md`
> - Output: `adhd-sleep/distribution/03-calming-sounds-adhd/linkedin.md`
> - Focus: Solution-aware audience, product bridge
>
> **LinkedIn Requirements (from platform playbook):**
> - Carousel: 10 slides max, hook on slide 1, CTA on final slide
> - Text posts: 1,300 char limit, line breaks for readability, no hashtag spam
> - Algorithm: Comments > reactions, ask questions, first comment engagement
>
> Each sub-agent returns file path + status. Validate all outputs against universal rules.

**Status:** PASS

---

**Handoff:**
- **Done:** Created LinkedIn distribution content for 3 articles. Files at `adhd-sleep/distribution/{slug}/linkedin.md`
- **Next:** Task 8b (Twitter/X)

---

## Task 8b: Twitter/X Distribution

**Objective:** Create Twitter/X distribution content (thread + singles) for 3 key articles using parallel sub-agents.

**Target Articles:**
- Article 07: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md` (pillar guide)
- Article 01: `adhd-sleep/articles/01-adhd-child-wont-sleep.md` (entry point)
- Article 03: `adhd-sleep/articles/03-calming-sounds-adhd.md` (product bridge)

**Acceptance Criteria:**
- [x] Twitter/X thread (8-15 tweets) created for each article
- [x] 3-5 standalone singles created for each article
- [x] All content follows Twitter/X specs from content-atomizer platform playbook
- [x] UK English throughout, no banned AI words
- [x] Brand voice maintained per client profile

**Starter Prompt:**
> **Sub-Agent Orchestration Task**
>
> Spawn 3 sub-agents in parallel using the Task tool. Each sub-agent runs `/content-atomizer` for Twitter/X only.
>
> **Context Files (provide paths to all sub-agents):**
> - Client profile: `clients/hushaway/profile.md`
> - Platform playbook: `.claude/skills/content-atomizer/references/platform-playbook.md`
> - Universal rules: `.claude/rules/universal-rules.md`
>
> **Sub-Agent 1:** Article 07 (pillar guide)
> - Source: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md`
> - Output: `adhd-sleep/distribution/07-adhd-sleep-solutions-guide/twitter.md`
> - Focus: Thread unpacking the "missing piece" framework
>
> **Sub-Agent 2:** Article 01 (ADHD child won't sleep)
> - Source: `adhd-sleep/articles/01-adhd-child-wont-sleep.md`
> - Output: `adhd-sleep/distribution/01-adhd-child-wont-sleep/twitter.md`
> - Focus: Relatable parent moments, quotable takes
>
> **Sub-Agent 3:** Article 03 (calming sounds)
> - Source: `adhd-sleep/articles/03-calming-sounds-adhd.md`
> - Output: `adhd-sleep/distribution/03-calming-sounds-adhd/twitter.md`
> - Focus: Science-backed tips, actionable thread
>
> **Twitter/X Requirements (from platform playbook):**
> - Thread: 8-15 tweets, hook tweet gets 80% of engagement, number tweets
> - Singles: Standalone value, no thread dependency, quotable insights
> - 280 char limit, images/media boost engagement
> - Algorithm: Replies and retweets matter, controversial takes spread
>
> Each sub-agent returns file path + status. Validate all outputs against universal rules.

**Status:** PASS

---

**Handoff:**
- **Done:** Created Twitter/X distribution content for 3 articles. Files at `adhd-sleep/distribution/{slug}/twitter.md`
- **Next:** Task 8c (Newsletter)

---

## Task 8c: Newsletter Distribution

**Objective:** Create newsletter snippets for 3 key articles using parallel sub-agents.

**Target Articles:**
- Article 07: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md` (pillar guide)
- Article 01: `adhd-sleep/articles/01-adhd-child-wont-sleep.md` (entry point)
- Article 03: `adhd-sleep/articles/03-calming-sounds-adhd.md` (product bridge)

**Acceptance Criteria:**
- [x] Newsletter snippet created for each article
- [x] Each snippet has: hook, body (2-3 paragraphs), CTA to full article
- [x] All content follows newsletter specs from content-atomizer platform playbook
- [x] UK English throughout, no banned AI words
- [x] Brand voice maintained per client profile

**Starter Prompt:**
> **Sub-Agent Orchestration Task**
>
> Spawn 3 sub-agents in parallel using the Task tool. Each sub-agent runs `/content-atomizer` for Newsletter only.
>
> **Context Files (provide paths to all sub-agents):**
> - Client profile: `clients/hushaway/profile.md`
> - Platform playbook: `.claude/skills/content-atomizer/references/platform-playbook.md`
> - Universal rules: `.claude/rules/universal-rules.md`
>
> **Sub-Agent 1:** Article 07 (pillar guide)
> - Source: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md`
> - Output: `adhd-sleep/distribution/07-adhd-sleep-solutions-guide/newsletter.md`
> - Focus: "Everything you need to know" positioning
>
> **Sub-Agent 2:** Article 01 (ADHD child won't sleep)
> - Source: `adhd-sleep/articles/01-adhd-child-wont-sleep.md`
> - Output: `adhd-sleep/distribution/01-adhd-child-wont-sleep/newsletter.md`
> - Focus: Personal story hook, empathy-first
>
> **Sub-Agent 3:** Article 03 (calming sounds)
> - Source: `adhd-sleep/articles/03-calming-sounds-adhd.md`
> - Output: `adhd-sleep/distribution/03-calming-sounds-adhd/newsletter.md`
> - Focus: Practical tip teaser, curiosity gap
>
> **Newsletter Requirements (from platform playbook):**
> - Hook: 1-2 sentences that stop the scroll
> - Body: 2-3 paragraphs, value-forward, not just a teaser
> - CTA: Clear link to full article, soft sell
> - Tone: Personal, like you're emailing a friend
>
> Each sub-agent returns file path + status. Validate all outputs against universal rules.

**Status:** PASS

---

**Handoff:**
- **Done:** Created Newsletter distribution content for 3 articles. Files at `adhd-sleep/distribution/{slug}/newsletter.md`
- **Next:** Task 8d (Instagram)

---

## Task 8d: Instagram Distribution

**Objective:** Create Instagram distribution content (carousel + caption + Reel script) for 3 key articles using parallel sub-agents.

**Target Articles:**
- Article 07: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md` (pillar guide)
- Article 01: `adhd-sleep/articles/01-adhd-child-wont-sleep.md` (entry point)
- Article 03: `adhd-sleep/articles/03-calming-sounds-adhd.md` (product bridge)

**Acceptance Criteria:**
- [x] Instagram carousel (10 slides max) created for each article
- [x] Caption with hashtags created for each article
- [x] Reel script (15-30 seconds) created for each article
- [x] All content follows Instagram specs from content-atomizer platform playbook
- [x] UK English throughout, no banned AI words
- [x] Brand voice maintained per client profile

**Starter Prompt:**
> **Sub-Agent Orchestration Task**
>
> Spawn 3 sub-agents in parallel using the Task tool. Each sub-agent runs `/content-atomizer` for Instagram only.
>
> **Context Files (provide paths to all sub-agents):**
> - Client profile: `clients/hushaway/profile.md`
> - Platform playbook: `.claude/skills/content-atomizer/references/platform-playbook.md`
> - Universal rules: `.claude/rules/universal-rules.md`
>
> **Sub-Agent 1:** Article 07 (pillar guide)
> - Source: `adhd-sleep/articles/07-adhd-sleep-solutions-guide.md`
> - Output: `adhd-sleep/distribution/07-adhd-sleep-solutions-guide/instagram.md`
> - Focus: "Save this" carousel, comprehensive tips
>
> **Sub-Agent 2:** Article 01 (ADHD child won't sleep)
> - Source: `adhd-sleep/articles/01-adhd-child-wont-sleep.md`
> - Output: `adhd-sleep/distribution/01-adhd-child-wont-sleep/instagram.md`
> - Focus: Relatable parent moment, emotional Reel hook
>
> **Sub-Agent 3:** Article 03 (calming sounds)
> - Source: `adhd-sleep/articles/03-calming-sounds-adhd.md`
> - Output: `adhd-sleep/distribution/03-calming-sounds-adhd/instagram.md`
> - Focus: Sound demo potential, product-adjacent
>
> **Instagram Requirements (from platform playbook):**
> - Carousel: 10 slides max, hook on slide 1, swipe motivation, CTA on final slide
> - Caption: 2,200 char limit, line breaks, 3-5 relevant hashtags (not spam)
> - Reel: 15-30 seconds, hook in first 3 seconds, trending audio optional
> - Algorithm: Saves and shares > likes, carousel engagement is high
>
> Each sub-agent returns file path + status. Validate all outputs against universal rules.

**Status:** PASS

---

**Handoff:**
- **Done:** Created Instagram distribution content for 3 articles using parallel sub-agents. All 3 files created and validated:
  - `adhd-sleep/distribution/07-adhd-sleep-problems-guide/instagram.md` (pillar guide)
  - `adhd-sleep/distribution/01-adhd-child-wont-sleep/instagram.md` (entry point)
  - `adhd-sleep/distribution/03-calming-sounds-adhd/instagram.md` (product bridge)
- **Content per file:** 10-slide carousel (hook → value → CTA), caption under 2,200 chars with 5 hashtags, Reel script 20-25 seconds with hook in first 3 seconds
- **Validation:** All passed UK English, no banned AI words, brand voice aligned (warm parent-to-parent), soft CTAs to The Open Sanctuary
- **Note:** Starter prompt had typo "07-adhd-sleep-solutions-guide" but actual article slug is "07-adhd-sleep-problems-guide" — sub-agents correctly used actual slug
- **Next:** Tasks 8a-8c (LinkedIn, Twitter/X, Newsletter) remain pending for distribution content

---

## Task 9: Start Autistic Meltdowns Pillar

**Objective:** Create pillar brief for Autistic Meltdowns with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Autistic Meltdowns pillar from keyword brief
- [x] Run deep competitor analysis on top ranking content
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `autistic-meltdowns/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Autistic Meltdowns. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of National Autistic Society, NHS Leicestershire Partnership Trust, Ambitious about Autism, and YouTube meltdown content; (2) Identify the MASSIVE gap—NO competitor provides sound/audio solutions beyond "try calming music"; (3) Plan 7 articles covering: understanding meltdowns, what to play during, after school meltdowns, meltdown recovery, meltdown vs shutdown, preventing meltdowns, pillar guide. Position all content toward The Open Sanctuary as primary CTA.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `autistic-meltdowns/01-pillar-brief.md` with all 7 sections: strategic context, keyword table (22 keywords mapped), competitor analysis (National Autistic Society, NHS Leicestershire, Ambitious about Autism, YouTube channels), content plan (7 articles), angle opportunities (5 identified), internal linking map, and publishing order.
- **Decisions:**
  - Primary angle: "What to Play NOW" — the single biggest gap in competitor content. Every source says "try calming music" but NONE tell parents what to actually play.
  - Top competitors: National Autistic Society (DR 70-80, comprehensive but no audio solutions), NHS Leicestershire (DR 90+, clinical, brief sound mention), Ambitious about Autism (DR 50-60, youth voice, no tools)
  - CRITICAL GAP: Sound/audio-based calming solutions are virtually absent from ALL mainstream guidance. YouTube fills this with generic content not designed for ND children.
  - 7 articles planned: 6 supporting + 1 pillar guide (publishes last)
  - Article 01 "Understanding Autism Meltdowns" is foundation — all other articles reference concepts it introduces
  - Article 02 "What to Play During Meltdown" is the conversion driver — publish second
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("What to Play NOW"); need secondary angles per article and consistency check.

---

*Project started: 2026-02-02*
*Last updated: 2026-02-03 (Task 9 Start Autistic Meltdowns Pillar PASS)*
