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
| Task 8: Create Distribution Content | pending |

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

## Task 8: Create Distribution Content

**Objective:** Atomise pillar guide and key supporting articles into platform-specific distribution content.

**Acceptance Criteria:**
- [ ] Distribution folder created for pillar guide
- [ ] LinkedIn carousel + text posts created
- [ ] Twitter/X thread + singles created
- [ ] Newsletter snippet created
- [ ] Instagram carousel + caption created
- [ ] All content follows platform specs from content-atomizer skill

**Starter Prompt:**
> Run /content-atomizer on the pillar guide (`07-adhd-sleep-solutions-guide.md`) and top 2 supporting articles. Create distribution content for: LinkedIn (carousel + 2-3 text posts), Twitter/X (thread + 3-5 singles), Newsletter (snippet with hook), Instagram (carousel + caption). Follow platform playbook from skill references. Save to `adhd-sleep/distribution/{article-slug}/` folders.

**Status:** pending

---

*Project started: 2026-02-02*
*Last updated: 2026-02-03 (Task 7 PASS — all 7 articles validated)*
