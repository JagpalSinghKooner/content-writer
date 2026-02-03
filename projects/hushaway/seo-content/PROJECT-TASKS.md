# Project Tasks: HushAway® SEO Content

## Summary

| Task | Status |
|------|--------|
| Task 1: Keyword Research | PASS |
| Task 2: Start ADHD Sleep Pillar | PASS |
| Task 3: Positioning Angles for ADHD Sleep | pending |
| Task 4: Write ADHD Sleep Articles | pending |

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
- [ ] Primary angle identified for pillar guide
- [ ] Secondary angles for each supporting article
- [ ] Consistency check across all angles
- [ ] Output saved to `adhd-sleep/02-positioning.md`

**Starter Prompt:**
> Run /positioning-angles for ADHD Sleep pillar. Input: adhd-sleep/01-pillar-brief.md + clients/hushaway/profile.md. Focus on: (1) Why generic sleep advice doesn't work for ADHD brains; (2) "Racing brain that won't switch off" language from parent research; (3) Passive listening as the mechanism; (4) Parent exhaustion angle (zero effort). Avoid clinical positioning—keep parent-to-parent voice.

**Status:** pending

---

## Task 4: Write ADHD Sleep Articles

**Objective:** Write all articles for ADHD Sleep pillar (pillar guide + supporting articles).

**Acceptance Criteria:**
- [ ] All articles written following SEO requirements
- [ ] Each article validated via /validate-content
- [ ] Internal linking in place
- [ ] All articles in `adhd-sleep/articles/` folder

**Starter Prompt:**
> Write ADHD Sleep pillar content. Follow article order from pillar brief. For each article: (1) Run /seo-content with target keyword and positioning angle; (2) Run /direct-response-copy to enhance; (3) Run /validate-content to verify PASS. Primary CTA: The Open Sanctuary. Voice: warm parent-to-parent per client profile.

**Status:** pending

---

*Project started: 2026-02-02*
*Last updated: 2026-02-03*
