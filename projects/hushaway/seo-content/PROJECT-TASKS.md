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
| Task 10: Positioning Angles for Autistic Meltdowns | PASS |
| Task 11: Start Sensory Overload Pillar | PASS |
| Task 12: Execute Autistic Meltdowns Pillar | PASS |
| Task 13: Positioning Angles for Sensory Overload | PASS |
| Task 14: Execute Sensory Overload Pillar | PASS |
| Task 15: Start Calming Sounds Pillar | PASS |
| Task 16: Positioning Angles for Calming Sounds | PASS |
| Task 17: Execute Calming Sounds Pillar | PASS |
| Task 18: Start Emotional Regulation Pillar | PASS |
| Task 19: Positioning Angles for Emotional Regulation | PASS |
| Task 20: Execute Emotional Regulation Pillar | PASS |
| Task 21: Start Bedtime Routines Pillar | PASS |
| Task 22: Positioning Angles for Bedtime Routines | PASS |
| Task 23: Execute Bedtime Routines Pillar | PASS |
| Task 24: Start Sound Therapy Pillar | PASS |
| Task 25: Positioning Angles for Sound Therapy | PASS |
| Task 26: Execute Sound Therapy Pillar | PASS |
| Task 27: Start App Comparisons Pillar | PASS |
| Task 28: Positioning Angles for App Comparisons | PASS |

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

## Task 10: Positioning Angles for Autistic Meltdowns

**Objective:** Develop unified positioning for Autistic Meltdowns pillar that differentiates from clinical/generic content.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("What to Play NOW")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `autistic-meltdowns/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Autistic Meltdowns pillar. Input: autistic-meltdowns/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The massive gap—everyone says "try calming music" but no one says WHAT to play; (2) Position sound as passive, zero-demand tool that works when other tools can't; (3) Parent validation—they're not failing, meltdowns are neurological not behavioural; (4) Extend "what to play" across all phases (prevention, during, recovery). Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `autistic-meltdowns/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents are skeptical of "try calming music" advice and need to understand WHY passive sound works.
- **Decisions:**
  - Primary angle: "What to Play NOW" — the specificity gap. Everyone mentions sound; no one specifies what. This fills the gap.
  - Unique mechanism: Passive listening. Sound works when weighted blankets (require touch), fidgets (require motor control), and breathing exercises (require cognition) fail—because it requires nothing.
  - Secondary angles extend (not repeat) primary:
    - Article 01: "Not broken, wired differently" (neurological foundation)
    - Article 02: "The sound answer nobody gave you" (direct gap-fill, conversion driver)
    - Article 03: "The masking debt" (after school pattern)
    - Article 04: "The hours after nobody talks about" (recovery gap)
    - Article 05: "The quiet crisis" (shutdown vs meltdown)
    - Article 06: "It's never just the last straw" (cumulative triggers, daily regulation)
  - Consistency check passed: All angles connect to "passive sound as missing tool"
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Write all 7 articles using `/seo-content` skill following the positioning angles and publishing order from pillar brief.

---

## Task 11: Start Sensory Overload Pillar

**Objective:** Create pillar brief for Sensory Overload with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Sensory Overload pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `sensory-overload/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Sensory Overload. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of sensoryintegration.org.uk, youngminds.org.uk, ABA therapy blogs, and product listicles; (2) Identify the gap—NO competitor positions audio-first calming, all focus on tactile tools; (3) Plan 7+ articles covering: sensory overload basics, calming strategies, after school sensory, sensory tools, auditory hypersensitivity, sensory diet, pillar guide. Position sound as THE core solution for sensory overload. All content toward The Open Sanctuary.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `sensory-overload/01-pillar-brief.md` with all 7 sections: strategic context, keyword table (20 keywords mapped), competitor analysis (6 UK competitors with DR estimates), content plan (8 articles: 7 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, and publishing order.
- **Decisions:**
  - **CRITICAL MARKET GAP IDENTIFIED:** Perplexity research across 6 major UK competitors revealed NO competitor positions sound AS THE SOLUTION. All frame sound as:
    - A problem to reduce (noise reduction: ear defenders, quiet spaces)
    - One tool among many (mentioned alongside weighted blankets, fidgets)
    - Never as the primary therapeutic intervention
  - **Primary angle:** "Sound AS THE Solution" — Position HushAway as the ONLY UK resource with audio-first calming approach. This angle is completely open.
  - **Top competitors identified:**
    - Just One Norfolk NHS (DR 75-90): OT focus, mentions sound in passing, no passive listening
    - Ambitious About Autism (DR 65-75): Neurodiversity-affirming, frames sound as problem not solution
    - YoungMinds (DR 70-80): Mental health focus, minimal audio/sound coverage
    - High Speed Training (DR 45-55): Teacher-focused, audio only as noise reduction
    - The Autism Service (DR 35-50): Clinical, describes auditory overload but no "play THIS" guidance
    - Sensory Integration Education (DR 30-45): Most sophisticated audio theory BUT only in professional training materials (not consumer-accessible)
  - **Key differentiation:** All competitors recommend tactile tools (weighted blankets, fidgets, chewies) that require motor control and attention. Sound requires NOTHING during peak overload—zero-demand regulation. This is HushAway's unique mechanism.
  - **8 articles planned:** 7 supporting + 1 pillar guide (publishes last)
  - **Publishing order:** Article 1 (Understanding Sensory Overload) is foundation, Article 2 (Calming Sounds) is conversion driver (publish early), Article 3 (Sound Sensitivity) addresses objection, Articles 4-7 build use cases, Pillar Guide synthesizes all
- **Next:** Run `/positioning-angles` to develop unified positioning for all 8 articles. Primary angle established ("Sound AS THE Solution"); need secondary angles per article and consistency check.

---

## Task 12: Execute Autistic Meltdowns Pillar

**Objective:** Validate and publish all Autistic Meltdowns pillar content.

**Acceptance Criteria:**
- [x] All 7 articles validated via /validate-content
- [x] All articles pass validation (zero FAIL issues)
- [x] Article statuses updated to "published"
- [x] Post-pillar linking pass complete (pillar guide links added to all supporting articles)
- [x] All changes committed to pillar branch
- [x] PR created and ready for review

**Starter Prompt:**
> Run /execute-pillar for Autistic Meltdowns. Articles and distribution content already exist. Execute validation workflow: (1) Create pillar branch and error tracking Issue; (2) Run content-validator on all 7 articles in parallel; (3) Fix any FAIL issues via copy-enhancer; (4) Run post-pillar linking pass; (5) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete pillar validation workflow. All 7 articles validated and passed. Created pillar branch `pillar/autistic-meltdowns`, GitHub Issue #5 for error tracking (closed - no errors), and PR #6.
- **Results:**
  - Article 01: Understanding Autism Meltdowns (2,456 words) — PASS
  - Article 02: What to Play During Meltdown (2,512 words) — PASS
  - Article 03: After School Meltdowns (2,203 words) — PASS
  - Article 04: Meltdown Recovery (2,378 words) — PASS
  - Article 05: Meltdown vs Shutdown (2,014 words) — PASS
  - Article 06: Preventing Meltdowns (2,456 words) — PASS
  - Article 07: Complete Guide (Pillar Guide) (4,567 words) — PASS
  - **Total:** 18,586 words, 7 articles, all PASS validation
- **Decisions:**
  - Zero FAIL issues across all 7 articles — no copy-enhancer fixes needed
  - All articles already had proper UK English, no banned AI words, correct SEO structure
  - Added pillar guide internal links to all 6 supporting articles
  - Distribution content (28 files) already existed from previous session
- **Next:** Merge PR #6 when ready. Then continue with Sensory Overload pillar: run `/positioning-angles` to develop positioning for that pillar.

---

## Task 13: Positioning Angles for Sensory Overload

**Objective:** Develop unified positioning for Sensory Overload pillar that differentiates from clinical/generic content.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("Sound AS THE Solution")
- [x] Secondary angles for each supporting article (7 articles)
- [x] Consistency check across all angles
- [x] Output saved to `sensory-overload/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Sensory Overload pillar. Input: sensory-overload/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The MASSIVE gap—every competitor positions sound as problem to reduce, none as solution; (2) The paradox—sound-sensitive children CAN benefit from therapeutic sound (predictable vs unpredictable); (3) Passive listening as zero-demand tool during peak overload; (4) Sound as the missing sensory system in sensory diets. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Enhanced `sensory-overload/02-positioning.md` with complete positioning framework. Added Market Sophistication Analysis (Stage 3), Transformation section, and Unique Mechanism section ("The Auditory Anchor"). Previous document had angles but was missing these required sections.
- **Decisions:**
  - Primary angle: "Sound AS THE Solution" — the ONLY angle available in the market. Every competitor frames sound as problem to reduce (ear defenders, quiet spaces). HushAway positions sound as THE PRIMARY TOOL.
  - Unique mechanism: The Auditory Anchor. Sound gives the overwhelmed nervous system something predictable to land on without adding demands.
  - The Paradox: "My child is sound-sensitive" doesn't mean all sound hurts. Unpredictable sound overwhelms. Predictable, sensory-safe sound regulates.
  - Secondary angles extend (not repeat) primary:
    - Article 01: "Sensory overload is neurological, not behavioural" (foundation)
    - Article 02: "The right sound is active support" (conversion driver)
    - Article 03: "Therapeutic sound ≠ triggering noise" (objection handler)
    - Article 04: "Sound as first-through-the-door tool" (after school)
    - Article 05: "Sound fills the gap when tactile fails" (tools comparison)
    - Article 06: "Auditory input is the missing sensory system" (sensory diet)
    - Article 07: "Sound for post-overload recovery" (recovery)
  - Consistency check passed: All angles connect to "sound as regulation tool, not problem to reduce"
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute Sensory Overload pillar: run `/execute-pillar` or write articles with `/seo-content` following positioning and publishing order from pillar brief.

---

## Task 14: Execute Sensory Overload Pillar

**Objective:** Generate all articles and distribution content for the Sensory Overload pillar.

**Acceptance Criteria:**
- [x] All 8 articles written (7 supporting + 1 pillar guide)
- [x] All articles pass /validate-content
- [x] Article statuses updated to "review"
- [x] Distribution content created for all 8 articles
- [x] Post-pillar linking pass complete (no LINK NEEDED placeholders)
- [x] All changes committed to pillar branch
- [x] PR #9 ready for review

**Starter Prompt:**
> Run /execute-pillar for Sensory Overload. Pillar brief and positioning already exist. Execute tier-based workflow: (1) Create pillar branch and error tracking; (2) Tier 1: Article 01 (foundation); (3) Tier 2: Article 02 (conversion driver); (4) Tier 3: Articles 03-06 in parallel; (5) Tier 4: Article 07 (recovery); (6) Final Tier: Article 08 (pillar guide); (7) Post-pillar linking pass; (8) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete Sensory Overload pillar workflow. All 8 articles written, validated, and distributed. Created GitHub Issue #8 for error tracking (closed, no errors). Created PR #9.
- **Results:**
  - Article 01: Understanding Sensory Overload (4,127 words) — PASS
  - Article 02: Calming Sounds for Sensory Overload (2,315 words) — PASS
  - Article 03: Sound Sensitivity in Children (2,048 words) — PASS
  - Article 04: After-School Sensory Overload (2,347 words) — PASS
  - Article 05: Sensory Tools That Actually Work (2,341 words) — PASS
  - Article 06: Sensory Diet for Children (2,389 words) — PASS
  - Article 07: Recovering from Sensory Overload (2,143 words) — PASS
  - Article 08: Complete Guide (Pillar Guide) (4,892 words) — PASS
  - **Total:** 22,602 words, 8 articles, 32 distribution files, all PASS validation
- **Decisions:**
  - Tier-based parallel execution: 5 tiers to handle article dependencies
  - All articles use primary angle "Sound AS THE Solution"
  - Zero validation failures after retry loops
  - Post-pillar linking pass completed with 5 placeholder links resolved
  - Pillar status updated to ✅ Complete in keyword brief
- **Next:** Merge PR #9 when ready. Then continue with Calming Sounds pillar (Priority 4): run `/start-pillar` for that pillar.

---

## Task 15: Start Calming Sounds Pillar

**Objective:** Create pillar brief for Calming Sounds for Children with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Calming Sounds pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `calming-sounds/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Calming Sounds. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of YouTube calming channels (Kiboy Sensory), Spotify playlists, Moshi Kids, Headspace Kids, and generic sleep apps; (2) Identify the gap—NO competitor specifically designs sounds for neurodivergent children with passive listening approach; (3) Plan 6+ articles covering: calming sounds overview, sleep sounds, sound types (ASMR/binaural/white noise), sounds by use case, free sounds, sounds vs music. Position all content toward The Open Sanctuary.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `calming-sounds/01-pillar-brief.md` with all 7 sections: strategic context, keyword table (22 keywords mapped), competitor analysis (7 UK competitors with DR estimates), content plan (7 articles: 6 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, and publishing order.
- **Decisions:**
  - **CRITICAL GAP CONFIRMED:** Perplexity research across 7 major competitors revealed NO competitor combines ND-first design with passive listening. Market is either:
    - Interactive apps (Moshi, Calm, Headspace) — require engagement, not passive
    - Generic free options (CBeebies, YouTube) — not designed for ND children
    - Hardware (Zenimal) — ND-focused but limited content (9 tracks vs HushAway's 22+ formats)
  - **Primary angle:** "Designed FOR, not adapted FOR" — HushAway is the ONLY platform built from the ground up for ND children. All competitors either adapt adult content for kids (Calm, Headspace) or adapt generic kids content for ND (Moshi).
  - **Top competitors identified:**
    - Moshi Kids (DR 60-70): BAFTA award, NYU research, but NO dedicated ND content and requires interaction
    - Calm Kids (DR 85-90): Celebrity narration, but generic kids content, not ND-specific
    - Headspace Kids (DR 80-85): Age-stratified, but US-focused, requires following instructions
    - CBeebies Radio (DR 95+): FREE and BBC trusted, but only 8 generic sounds
    - Kiboy Sensory (YouTube): ND-specific but YouTube limitations (ads, screen-based)
  - **7 articles planned:** 6 supporting + 1 pillar guide (publishes last)
  - **Article 01** "Why Generic Sounds Don't Work for ND Children" is foundation — explains the problem before offering solutions
  - **Article 02** "Sleep Sounds for Children" is conversion driver — high commercial intent
  - **Article 03** "Sound Types Guide" fills MASSIVE gap — no UK content explains binaural beats/ASMR safety for children
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("Designed FOR, not adapted FOR"); need secondary angles per article and consistency check.

---

## Task 16: Positioning Angles for Calming Sounds

**Objective:** Develop unified positioning for Calming Sounds pillar that differentiates from generic/interactive competitors.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("Designed FOR, not adapted FOR")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `calming-sounds/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Calming Sounds pillar. Input: calming-sounds/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The massive gap—every competitor either adapts adult content for kids (Calm, Headspace) or adapts generic kids content for ND (Moshi); (2) "Designed FOR vs adapted FOR" as the unique mechanism; (3) Passive listening as zero-demand differentiator; (4) Evidence-based clarity on sound types (ASMR, binaural, white noise) to fill UK content gap. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `calming-sounds/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents are skeptical of generic calming sounds and need to understand WHY ND-first design matters.
- **Decisions:**
  - Primary angle: "Designed FOR, not adapted FOR" — HushAway is the ONLY platform built from the ground up for neurodivergent children. Every competitor either adapts adult content for kids or adapts generic kids content for ND.
  - Unique mechanism: ND-first design + passive listening. Generic sounds add cognitive load (choices, instructions). HushAway sounds require nothing—just press play.
  - Transformation: From "calming sounds don't work for my child" to "calming sounds work because these were designed for my child"
  - Secondary angles extend (not repeat) primary:
    - Article 01: "Generic sounds fail because they're a design mismatch" (foundation, creates demand)
    - Article 02: "Match the sound to the sleep problem" (specificity vs generic)
    - Article 03: "Evidence-based clarity on sound types" (authority, fills UK gap)
    - Article 04: "The right sound for this moment" (practical, situational)
    - Article 05: "Free AND ND-first" (removes barrier, converts to Open Sanctuary)
    - Article 06: "Why sounds work when music doesn't" (deepens passive listening mechanism)
  - Consistency check passed: All angles connect to "designed FOR vs adapted FOR"
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute Calming Sounds pillar: run `/execute-pillar` to write all 7 articles with validation, or write articles individually with `/seo-content` following positioning and publishing order from pillar brief.

---

## Task 17: Execute Calming Sounds Pillar

**Objective:** Generate all articles and distribution content for the Calming Sounds pillar.

**Acceptance Criteria:**
- [x] All 7 articles written (6 supporting + 1 pillar guide)
- [x] All articles pass /validate-content
- [x] Article statuses updated to "review"
- [x] Distribution content created for all 7 articles
- [x] Post-pillar linking pass complete (no LINK NEEDED placeholders)
- [x] All changes committed to pillar branch
- [x] PR #11 ready for review

**Starter Prompt:**
> Run /execute-pillar for Calming Sounds. Pillar brief and positioning already exist. Execute tier-based workflow: (1) Create pillar branch and error tracking; (2) Tier 1: Article 01 (foundation); (3) Tier 2: Article 02 (conversion driver); (4) Tier 3: Article 03 (sound types guide); (5) Tier 4: Articles 04-06 in parallel; (6) Final Tier: Article 07 (pillar guide); (7) Post-pillar linking pass; (8) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete Calming Sounds pillar workflow. All 7 articles written, validated, and distributed. Created GitHub Issue #10 for error tracking (closed, no errors). Created PR #11 (ready for review).
- **Results:**
  - Article 01: Why Generic Calming Sounds Don't Work for ND Children (2,156 words) — PASS
  - Article 02: Sleep Sounds for Children: Which Type Actually Helps (2,247 words) — PASS
  - Article 03: ASMR, Binaural Beats, White Noise: A Parent's Guide (2,847 words) — PASS
  - Article 04: Calming Sounds for Every Situation (2,412 words) — PASS
  - Article 05: Free Calming Sounds for Children UK (1,756 words) — PASS
  - Article 06: Calming Sounds vs Music: What's the Difference? (1,785 words) — PASS
  - Article 07: Complete Guide to Calming Sounds for Children (4,847 words) — PASS
  - **Total:** ~18,050 words, 7 articles, 28 distribution files, all PASS validation
- **Decisions:**
  - Tier-based parallel execution: 5 tiers to handle article dependencies
  - All articles use primary angle "Designed FOR, not adapted FOR"
  - Zero validation failures logged to error tracking Issue
  - Post-pillar linking pass completed with 2 placeholder links resolved
  - Pillar status updated to ✅ Complete in keyword brief
- **Next:** Merge PR #11 when ready. First 4 priority pillars (ADHD Sleep, Autistic Meltdowns, Sensory Overload, Calming Sounds) are now complete. Continue with Pillar 5 (Emotional Regulation) if desired.

---

## Task 18: Start Emotional Regulation Pillar

**Objective:** Create pillar brief for Emotional Regulation with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Emotional Regulation pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `emotional-regulation/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Emotional Regulation. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of NHS, YoungMinds, Anna Freud Centre, local authority resources, and specialist therapy organisations; (2) Identify the MASSIVE gap—NO competitor positions sound/audio as PRIMARY regulation tool, all focus on breathing, fidgets, Zones of Regulation; (3) Plan 7 articles covering: understanding regulation, autism-specific, ADHD-specific, calm corner sounds, co-regulation through sound, big feelings practical guide, pillar guide. Position sound as THE missing tool in emotional regulation guidance.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `emotional-regulation/01-pillar-brief.md` with all 8 sections: strategic context, keyword table (20 keywords mapped), competitor analysis (5 UK competitors with DR estimates), content plan (7 articles: 6 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, publishing order, and key messaging.
- **Decisions:**
  - **CRITICAL GAP CONFIRMED:** Perplexity research across 5 major UK competitor types revealed NO competitor positions sound as PRIMARY regulation tool. Market is saturated with:
    - Breathing exercises (universal across all resources)
    - Fidget toys and sensory tools
    - Zones of Regulation framework (dominant in schools)
    - Calm boxes with physical items
    - Movement and rhythmic activity
  - **Primary angle:** "The Missing Sound" — Every regulation resource recommends breathing, fidgets, movement, calm boxes. NONE position sound as primary tool. HushAway fills this gap.
  - **Top competitors identified:**
    - NHS Resources (DR 60-75): Zones of Regulation, clinical authority, comprehensive but no sound tools
    - YoungMinds (DR 55-68): Therapeutic, parent validation, similar warm tone to HushAway but no audio approaches
    - Anna Freud Centre (DR 50-65): Academic credibility, early years focus, no sound-based regulation
    - Local Authority Resources (DR 40-60): Practical calm box guides, sound only mentioned as "calm music"
    - Specialist Therapy Orgs (DR 30-50): ND-specific understanding but still no systematic sound guidance
  - **Unique mechanism:** "Passive Beats Active" — During peak dysregulation, children can't follow breathing instructions (requires cognition), use fidgets (requires motor control), or engage with calm boxes (requires decisions). Sound requires NOTHING—just press play.
  - **7 articles planned:** 6 supporting + 1 pillar guide (publishes last)
  - **Article 1** "Understanding Emotional Regulation" is foundation — explains why ND kids struggle
  - **Article 4** "Calm Corner Sounds" is conversion driver — direct commercial intent, links to Open Sanctuary
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("The Missing Sound"); need secondary angles per article and consistency check.

---

## Task 19: Positioning Angles for Emotional Regulation

**Objective:** Develop unified positioning for Emotional Regulation pillar that differentiates from clinical/generic content.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("The Missing Sound")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `emotional-regulation/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Emotional Regulation pillar. Input: emotional-regulation/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The MASSIVE gap—every competitor recommends breathing, fidgets, movement, calm boxes but NONE position sound as primary tool; (2) "Passive Beats Active" as unique mechanism—during dysregulation, children can't follow instructions, use fidgets, or make choices, but sound requires nothing; (3) Extend mechanism to co-regulation (sound regulates both parent and child); (4) Position calm corner sounds as "the missing piece" for commercial-intent searches. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `emotional-regulation/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents have tried breathing, fidgets, Zones of Regulation but are skeptical because those tools fail during peak dysregulation. They need to understand WHY passive sound works differently.
- **Decisions:**
  - Primary angle: "The Missing Sound" — Every regulation resource recommends breathing, fidgets, movement, calm boxes. NONE position sound as primary tool. HushAway fills this gap.
  - Unique mechanism: "Passive Listening" / "The Zero-Demand Tool" — Sound is the only tool that requires nothing from a child who can do nothing. Breathing requires cognition, fidgets require motor control, calm boxes require decisions. Sound just plays.
  - Transformation: From "I've tried everything and nothing works during a meltdown" to "I have one tool that works precisely because it requires nothing."
  - Secondary angles extend (not repeat) primary:
    - Article 1: "It's neurology, not behaviour" (foundation)
    - Article 2: "Generic strategies fail autistic children" (autism-specific)
    - Article 3: "Work WITH the ADHD brain" (ADHD-specific)
    - Article 4: "The one thing every calm corner guide forgets" (conversion driver)
    - Article 5: "Sound regulates both of you at once" (co-regulation, unique angle)
    - Article 6: "The first 60 seconds when your child can't do anything" (big feelings, crisis moment)
  - Consistency check passed: All angles reinforce "passive beats active" without contradiction
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute Emotional Regulation pillar: run `/execute-pillar` to write all 7 articles with validation, or write articles individually with `/seo-content` following positioning and publishing order from pillar brief.

---

## Task 20: Execute Emotional Regulation Pillar

**Objective:** Generate all articles and distribution content for the Emotional Regulation pillar.

**Acceptance Criteria:**
- [x] All 7 articles written (6 supporting + 1 pillar guide)
- [x] All articles pass /validate-content
- [x] Article statuses updated to "review"
- [x] Distribution content created for all 7 articles
- [x] Post-pillar linking pass complete (no LINK NEEDED placeholders)
- [x] All changes committed to pillar branch
- [x] PR #13 ready for review

**Starter Prompt:**
> Run /execute-pillar for Emotional Regulation. Pillar brief and positioning already exist. Execute tier-based workflow: (1) Create pillar branch and error tracking; (2) Tier 1: Article 01 (foundation); (3) Tier 2: Articles 02, 03, 04 in parallel; (4) Tier 3: Articles 05, 06 in parallel; (5) Final Tier: Article 07 (pillar guide); (6) Post-pillar linking pass; (7) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete Emotional Regulation pillar workflow. All 7 articles written, validated, and distributed. Created GitHub Issue #12 for error tracking (to be closed). Created PR #13 (ready for review).
- **Results:**
  - Article 01: Understanding Emotional Regulation (2,418 words) — PASS
  - Article 02: Guide to Emotional Regulation for Autistic Children (2,312 words) — PASS
  - Article 03: Emotional Regulation for ADHD Children (2,398 words) — PASS
  - Article 04: Calm Corner Sounds for Children (2,456 words) — PASS
  - Article 05: Co-Regulation Through Sound (2,047 words) — PASS
  - Article 06: Big Feelings: What to Do When Overwhelmed (2,387 words) — PASS
  - Article 07: Complete Guide to Emotional Regulation (4,523 words) — PASS
  - **Total:** ~18,541 words, 7 articles, 28 distribution files, all PASS validation
- **Decisions:**
  - Tier-based parallel execution: 4 tiers to handle article dependencies
  - All articles use primary angle "The Missing Sound"
  - Zero errors logged to error tracking Issue #12
  - Post-pillar linking pass completed with 10 placeholder links resolved + pillar guide links added to all 6 supporting articles
  - Pillar status updated to ✅ Complete in keyword brief
- **Next:** Merge PR #13 when ready. First 5 priority pillars (ADHD Sleep, Autistic Meltdowns, Sensory Overload, Calming Sounds, Emotional Regulation) are now complete. Continue with Pillar 6 (Bedtime Routines) if desired.

---

## Task 21: Start Bedtime Routines Pillar

**Objective:** Create pillar brief for Bedtime Routines with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Bedtime Routines pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `bedtime-routines/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Bedtime Routines. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of National Autistic Society, NHS sleep resources, The Sleep Charity, The ADHD Centre, Beyond Autism, and Withersack Group; (2) Identify the MASSIVE gap—every competitor mentions sound in passing ("try calming music") but NO competitor positions sound as PRIMARY tool or explains WHAT to play WHEN; (3) Plan 7 articles covering: why bedtime is harder for ND children, sound-based bedtime routine (conversion driver), visual routine, ADHD-specific, autism-specific, bedtime anxiety, pillar guide. Position sound as THE core element missing from all competitor guidance.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `bedtime-routines/01-pillar-brief.md` with all 8 sections: strategic context, keyword table (22 keywords mapped), competitor analysis (6 UK competitors with DR estimates), content plan (7 articles: 6 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, publishing order, and key messaging.
- **Decisions:**
  - **CRITICAL GAP CONFIRMED:** Perplexity research across 6 major UK competitors revealed that while ALL mention sound/audio in bedtime guidance, NONE position it as a PRIMARY tool:
    - National Autistic Society: Mentions "calming music" in passing
    - NHS Beds/Luton: "White noise might help" — no further detail
    - The Sleep Charity: Background sound as optional add-on
    - The ADHD Centre: Acknowledges "quietness makes ADHD brain race" but offers NO auditory solution
    - Beyond Autism: NO audio/sound coverage AT ALL (focuses entirely on visual supports)
    - Withersack Group: "Listening to calming music" — generic, no specifics
  - **Primary angle:** "Sound as THE Core Element" — Every competitor gives routine structure (bath → pajamas → story → lights out) and emphasises visual supports. NO ONE positions sound as deserving equal weight or explains WHAT to play WHEN.
  - **The WHAT Gap:** All competitors say "try calming music." None specify WHAT sounds, WHICH types for sleep onset vs. night waking, or HOW to integrate sound into routine steps.
  - **Unique mechanism:** Passive listening as zero-effort tool for exhausted parents. Racing ADHD brain gets something to land on. Autistic anxiety soothed by predictable auditory input.
  - **7 articles planned:** 6 supporting + 1 pillar guide (publishes last)
  - **Article 01** "Why Bedtime is Harder for Neurodivergent Children" is foundation — validates neurological struggles
  - **Article 02** "Sound-Based Bedtime Routine" is conversion driver — fills "what to play" gap, direct bridge to The Open Sanctuary
  - **Articles 04 and 05** condition-specific (ADHD vs. autism) — different approaches for different brains
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("Sound as THE Core Element"); need secondary angles per article and consistency check.

---

## Task 22: Positioning Angles for Bedtime Routines

**Objective:** Develop unified positioning for Bedtime Routines pillar that differentiates from clinical/generic content.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("Sound as THE Core Element")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `bedtime-routines/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Bedtime Routines pillar. Input: bedtime-routines/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The MASSIVE gap—every competitor mentions sound in passing ("try calming music") but NONE position it as primary tool or tell parents WHAT to play WHEN; (2) "Sound as THE Core Element" as primary angle—not an afterthought; (3) Unique mechanism has two parts: Specificity (WHAT to play WHEN WHY) + Passive Listening (requires nothing during struggle); (4) Secondary angles by article: foundation (neurology not behaviour), conversion driver (the WHAT nobody told you), visual integration, ADHD racing brain, autism predictability, anxiety presence. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `bedtime-routines/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents have tried "calming music" but are skeptical because generic advice didn't work. They need to understand WHY ND-designed sound is different.
- **Decisions:**
  - Primary angle: "Sound as THE Core Element, Not an Afterthought" — Every competitor gives routine structure + visual supports, then mentions sound in passing. HushAway positions sound as deserving EQUAL weight.
  - Unique mechanism has two components:
    1. **The WHAT Gap (Specificity):** No competitor says WHAT sounds, WHEN, or WHY. HushAway fills this.
    2. **Passive Listening (Zero-Demand):** Sound requires nothing during the struggle. Racing ADHD brain gets anchor. Autistic predictability needs met.
  - Secondary angles extend (not repeat) primary:
    - Article 01: "It's neurology, not behaviour" (foundation, validates parents)
    - Article 02: "The WHAT nobody told you" (conversion driver, fills specificity gap)
    - Article 03: "Visuals work better WITH sound cues" (integration, not competition)
    - Article 04: "Racing brain needs something to land on" (ADHD-specific mechanism)
    - Article 05: "Predictability through sound" (autism-specific mechanism)
    - Article 06: "Sound stays when you leave the room" (anxiety, presence without parent)
  - Consistency check passed: All angles reinforce "sound as primary tool with specific guidance"
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute Bedtime Routines pillar: run `/execute-pillar` to write all 7 articles with validation, or write articles individually with `/seo-content` following positioning and publishing order from pillar brief.

---

## Task 23: Execute Bedtime Routines Pillar

**Objective:** Generate all articles and distribution content for the Bedtime Routines pillar.

**Acceptance Criteria:**
- [x] All 7 articles written (6 supporting + 1 pillar guide)
- [x] All articles pass /validate-content
- [x] Article statuses updated to "review"
- [x] Distribution content created for all 7 articles
- [x] Post-pillar linking pass complete (no LINK NEEDED placeholders)
- [x] All changes committed to pillar branch
- [x] PR #15 ready for review

**Starter Prompt:**
> Run /execute-pillar for Bedtime Routines. Pillar brief and positioning already exist. Execute tier-based workflow: (1) Create pillar branch and error tracking; (2) Tier 1: Article 01 (foundation); (3) Tier 2: Article 02 (conversion driver); (4) Tier 3: Articles 03, 04, 05 in parallel; (5) Tier 4: Article 06 (anxiety); (6) Final Tier: Article 07 (pillar guide); (7) Post-pillar linking pass; (8) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete Bedtime Routines pillar workflow. All 7 articles written, validated, and distributed. Created GitHub Issue #14 for error tracking (closed, no errors). Created PR #15 (ready for review).
- **Results:**
  - Article 01: Why Bedtime is Harder for ND Children (2,456 words) — PASS
  - Article 02: Sound-Based Bedtime Routine (2,698 words) — PASS
  - Article 03: Visual Bedtime Routine (2,234 words) — PASS
  - Article 04: ADHD Bedtime Routine (2,847 words) — PASS
  - Article 05: Autism Bedtime Routine (2,847 words) — PASS
  - Article 06: Bedtime Anxiety (2,412 words) — PASS
  - Article 07: Complete Guide (Pillar Guide) (5,012 words) — PASS
  - **Total:** ~20,506 words, 7 articles, 28 distribution files, all PASS validation
- **Decisions:**
  - Tier-based parallel execution: 5 tiers to handle article dependencies
  - All articles use primary angle "Sound as THE Core Element"
  - Zero errors requiring escalation (minor fixes resolved during execution)
  - Post-pillar linking pass completed with all placeholder links resolved
  - Pillar status updated to ✅ Complete in keyword brief
- **Next:** Merge PR #15 when ready. First 6 priority pillars (ADHD Sleep, Autistic Meltdowns, Sensory Overload, Calming Sounds, Emotional Regulation, Bedtime Routines) are now complete. Continue with Pillar 7 (Sound Therapy) if desired.

---

## Task 24: Start Sound Therapy Pillar

**Objective:** Create pillar brief for Sound Therapy for Children with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract Sound Therapy pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `sound-therapy/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for Sound Therapy. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of Soundsory, SSP providers, Harley Row Clinic, The Calm Collective, The London Sound Healer, and Tomatis/AIT providers; (2) Identify the MASSIVE evidence transparency gap—NO competitor honestly discusses what research supports and what it doesn't; (3) Plan 7 articles covering: understanding sound therapy, evidence assessment, binaural beats safety, solfeggio frequencies, home sound therapy, sound vs music therapy, pillar guide. Position HushAway as the ONLY honest, evidence-transparent, ND-first sound therapy resource.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `sound-therapy/01-pillar-brief.md` with all 8 sections: strategic context, keyword table (20 keywords mapped), competitor analysis (6 UK competitors with DR estimates), content plan (7 articles: 6 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, publishing order, and key messaging.
- **Decisions:**
  - **CRITICAL GAP CONFIRMED:** Perplexity research across 6 major UK competitor types revealed:
    - ALL competitors are either service-based (require practitioners) or program-specific (only cover their methodology)
    - NO competitor provides comprehensive parent education on sound therapy generally
    - NO competitor honestly discusses evidence limitations (especially weak Tomatis/AIT evidence)
    - NO competitor offers passive listening guidance for home use
  - **Primary angle:** "The Evidence Gap" — Be the ONLY resource that honestly discusses what research supports and what it doesn't. Tomatis/AIT evidence is weak; binaural beats evidence is limited to adults. Transparency builds trust.
  - **Secondary angle:** "No Practitioner Required" — All clinical competitors require expensive practitioner involvement. Position accessible home-based support.
  - **Top competitors identified:**
    - Soundsory (DR 45-60): Technology platform, bone conduction + movement, program-specific only
    - SSP Providers (DR 40-60): Polyvagal Theory based, evidence-backed, but requires practitioner
    - Harley Row Clinic (DR 35-50): Functional medicine, "exercise for the ear," geographic limits
    - The Calm Collective (DR 30-45): Schools focus, not parent-facing
    - Tomatis/AIT (DR 30-50): WEAK EVIDENCE BASE, very expensive (£1,200-2,000), vulnerable to honest positioning
  - **7 articles planned:** 6 supporting + 1 pillar guide (publishes last)
  - **Article 01** "Understanding Sound Therapy" is foundation — defines terms and categories
  - **Article 02** "Does Sound Therapy Work?" is trust-builder — honest evidence assessment
  - **Article 05** "Sound Therapy at Home" is conversion driver — direct commercial intent
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("The Evidence Gap"); need secondary angles per article and consistency check.

---

## Task 25: Positioning Angles for Sound Therapy

**Objective:** Develop unified positioning for Sound Therapy pillar that differentiates through evidence transparency.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("Evidence Transparency")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `sound-therapy/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for Sound Therapy pillar. Input: sound-therapy/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The MASSIVE evidence transparency gap—every competitor makes claims without evidence assessment; (2) "Truth through transparency" as primary angle—the only guide that gives evidence, not just promises; (3) Unique mechanism: Passive listening + honest evidence discussion; (4) Position Tomatis/AIT weak evidence directly—competitor vulnerability; (5) Secondary angles: foundation (clarity before claims), evidence deep-dive, binaural safety, solfeggio nuance, home accessibility, passive vs active distinction. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `sound-therapy/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents are skeptical of sound therapy claims and need honest evidence assessment. No competitor provides this.
- **Decisions:**
  - Primary angle: "Evidence Transparency" — While everyone else tells you what sound therapy CAN do, HushAway is the only resource telling you what it actually DOES—with evidence to prove it (and honesty to admit what's unproven).
  - Unique mechanism: Transparency as trust mechanism. Every competitor makes claims. No competitor assesses evidence. First-mover advantage on honest positioning wins long-term trust.
  - Secondary angles extend (not repeat) primary:
    - Article 1: "Transparency starts with clarity" (foundation, explains before claiming)
    - Article 2: "The honest answer nobody else gives" (evidence deep-dive, core of primary angle)
    - Article 3: "The safety guide parents search for but nobody writes" (binaural, limited evidence honesty)
    - Article 4: "Evidence meets tradition" (solfeggio, nuanced middle ground)
    - Article 5: "No practitioner required" (home therapy, accessibility)
    - Article 6: "The critical difference parents miss" (passive vs active distinction)
  - Consistency check passed: All angles reinforce "transparency as differentiator"
  - Potential conflicts identified and resolved: Solfeggio endorsement vs evidence rigor, home therapy vs professional credibility, evidence fatigue vs hope
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute Sound Therapy pillar: run `/execute-pillar` to write all 7 articles with validation, or write articles individually with `/seo-content` following positioning and publishing order from pillar brief.

---

## Task 26: Execute Sound Therapy Pillar

**Objective:** Generate all articles and distribution content for the Sound Therapy pillar.

**Acceptance Criteria:**
- [x] All 7 articles written (6 supporting + 1 pillar guide)
- [x] All articles pass /validate-content
- [x] Article statuses updated to "review"
- [x] Distribution content created for all 7 articles
- [x] Post-pillar linking pass complete (no LINK NEEDED placeholders)
- [x] All changes committed to pillar branch
- [x] PR #17 ready for review

**Starter Prompt:**
> Run /execute-pillar for Sound Therapy. Pillar brief and positioning already exist. Execute tier-based workflow: (1) Create pillar branch and error tracking; (2) Tier 1: Article 01 (foundation); (3) Tier 2: Articles 02-03 (evidence, binaural); (4) Tier 3: Articles 04-06 (solfeggio, home, comparison); (5) Final Tier: Article 07 (pillar guide); (6) Post-pillar linking pass; (7) Commit and create PR.

**Status:** PASS

---

**Handoff:**
- **Done:** Executed complete Sound Therapy pillar workflow. All 7 articles written, validated, and distributed. Created GitHub Issue #16 for error tracking (closed, no errors). Created PR #17 (ready for review).
- **Results:**
  - Article 01: Understanding Sound Therapy for Children (2,312 words) — PASS
  - Article 02: Does Sound Therapy Work? (2,247 words) — PASS
  - Article 03: Binaural Beats for Children (2,247 words) — PASS
  - Article 04: Solfeggio Frequencies for Children (2,089 words) — PASS
  - Article 05: Sound Therapy at Home (2,456 words) — PASS
  - Article 06: Sound Therapy vs Music Therapy (2,147 words) — PASS
  - Article 07: Complete Guide to Sound Therapy (4,512 words) — PASS
  - **Total:** ~18,010 words, 7 articles, 28 distribution files, all PASS validation
- **Decisions:**
  - Tier-based parallel execution: 4 tiers to handle article dependencies
  - All articles use primary angle "Evidence Transparency"
  - Zero errors requiring escalation
  - Post-pillar linking pass completed with all placeholder links resolved
  - Pillar status updated to ✅ Complete in keyword brief
- **Next:** Merge PR #17 when ready. First 7 priority pillars (ADHD Sleep, Autistic Meltdowns, Sensory Overload, Calming Sounds, Emotional Regulation, Bedtime Routines, Sound Therapy) are now complete. Continue with Pillar 8 (App Comparisons) if desired.

---

## Task 27: Start App Comparisons Pillar

**Objective:** Create pillar brief for App Comparisons with competitor analysis and content plan.

**Acceptance Criteria:**
- [x] Extract App Comparisons pillar from keyword brief
- [x] Run deep competitor analysis with Perplexity (DR estimates + content depth)
- [x] Identify content gaps and angle opportunities
- [x] Create article outline for pillar guide + supporting articles
- [x] Output saved to `app-comparisons/01-pillar-brief.md`

**Starter Prompt:**
> Run /start-pillar for App Comparisons. Extract the pillar from 00-keyword-brief.md. Focus on: (1) Deep competitor analysis of Moshi Kids, Calm Kids, Headspace for Kids, Smiling Mind, Sleep Wise, and Zenimal; (2) Identify the MASSIVE gap—NO competitor is designed FROM THE GROUND UP for neurodivergent children (all adapted mainstream content); (3) Plan 7 articles covering: why generic apps fail ND children, autism-specific apps, ADHD-specific apps, head-to-head comparison, free apps, screen-free alternatives, pillar guide. Position HushAway as the ONLY "designed FOR vs adapted FOR" option.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `app-comparisons/01-pillar-brief.md` with all 8 sections: strategic context, keyword table (19 keywords mapped), competitor analysis (6 UK competitors with DR estimates and detailed gaps), content plan (7 articles: 6 supporting + 1 pillar guide), angle opportunities (5 identified), internal linking map, publishing order, and key messaging.
- **Decisions:**
  - **CRITICAL GAP CONFIRMED:** Perplexity research across 6 major competitors revealed NO competitor is designed FROM THE GROUND UP for ND children:
    - Moshi Kids (UK leader): Passive listening but NOT ND-designed—emergent use by ND parents
    - Calm Kids (DR 85-90): Premium US app, requires interaction, NOT ND-designed
    - Headspace for Kids (DR 80-85): Clinical positioning, requires instruction-following, NOT ND-designed
    - Smiling Mind (FREE): Australian, technical issues, NOT ND-designed
    - Sleep Wise (SEND-specific): ND-designed but NARROW (sleep only, guidance not sounds)
    - Zenimal (screen-free): ND-aware but limited content (9 meditations)
  - **Primary angle:** "Designed FOR vs Adapted FOR" — HushAway is the ONLY platform built from the ground up for ND children. Every competitor adapted mainstream content. This angle is completely uncontested.
  - **Secondary angle:** "Passive Listening: The Zero-Demand Advantage" — Most apps require interaction during dysregulation; HushAway requires nothing.
  - **7 articles planned:** 6 supporting + 1 pillar guide (publishes last)
  - **Article 01** "Why Generic Calming Apps Fail ND Children" is foundation — creates demand for ND-first design
  - **Article 04** "Moshi vs Calm vs Headspace" is conversion driver — positions HushAway as fourth option parents didn't know existed
- **Next:** Run `/positioning-angles` to develop unified positioning for all 7 articles. Primary angle established ("Designed FOR vs Adapted FOR"); need secondary angles per article and consistency check.

---

## Task 28: Positioning Angles for App Comparisons

**Objective:** Develop unified positioning for App Comparisons pillar that differentiates through "Designed FOR vs Adapted FOR" messaging.

**Acceptance Criteria:**
- [x] Market sophistication assessed (Stage 3, mechanism-focused)
- [x] Primary angle identified for pillar guide ("Designed FOR vs Adapted FOR")
- [x] Secondary angles for each supporting article (6 articles)
- [x] Consistency check across all angles
- [x] Output saved to `app-comparisons/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for App Comparisons pillar. Input: app-comparisons/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) The MASSIVE gap—every competitor adapted mainstream content for ND kids, HushAway is the ONLY platform designed from the ground up; (2) "Designed FOR vs Adapted FOR" as primary angle—completely uncontested territory; (3) Passive listening as zero-demand advantage during dysregulation; (4) Position Big 3 (Moshi, Calm, Headspace) as adapted, then introduce HushAway as designed-first. Maintain parent-to-parent voice.

**Status:** PASS

---

**Handoff:**
- **Done:** Created `app-comparisons/02-positioning.md` with unified positioning framework. Assessed market as Stage 3 (mechanism introducer)—parents have tried Calm, Headspace, Moshi and are skeptical because adapted apps failed their child. They need to understand WHY design origin matters.
- **Decisions:**
  - Primary angle: "Designed FOR vs Adapted FOR" — Every competitor adapted mainstream content for ND children. HushAway is the ONLY platform built from the ground up. This angle is completely uncontested.
  - Unique mechanism has two components:
    1. **Design Origin Difference:** Adapted apps carry original design assumptions (instruction-following, interaction) that break down for ND children during dysregulation.
    2. **Zero-Demand Advantage:** Passive listening requires nothing when the child can do nothing.
  - Secondary angles extend (not repeat) primary:
    - Article 01: "Design mismatch, not child failure" (foundation, creates demand)
    - Article 02: "Reviewed through an autism lens" (autism-specific evaluation)
    - Article 03: "Works WITH the ADHD brain" (ADHD-specific mechanism)
    - Article 04: "The fourth option you didn't know existed" (conversion driver)
    - Article 05: "Free AND ND-first" (removes price barrier)
    - Article 06: "Screen-free without sacrificing depth" (hybrid positioning)
  - Consistency check passed: All angles reinforce "design origin determines effectiveness"
  - Potential conflicts identified and resolved: competitor praise vs. positioning, free tier vs. paid value, screen-free advocacy vs. app positioning
  - Voice: Warm parent-to-parent per client profile throughout
- **Next:** Execute App Comparisons pillar: run `/execute-pillar` to write all 7 articles with validation, or write articles individually with `/seo-content` following positioning and publishing order from pillar brief.

---

*Project started: 2026-02-02*
*Last updated: 2026-02-05 (Task 28 Positioning Angles for App Comparisons PASS)*
