# HushAway Article Generation Order

**Total Articles:** 110 (8 Hubs + 102 Clusters)
**Completed:** 0 / 110
**Structure:** Validated via DataForSEO + Perplexity MCP (2026-01-31)
**Keyword Rules:** V3.1 (crisis intent, lowered info floor)

---

## How to Use This Document

1. Work through articles in execution priority order
2. Mark checkboxes as you complete each article
3. Run `/keyword-research [keyword]` to start validation
4. **Follow the 4-Session Workflow below**
5. All 6 gates must pass before marking complete

---

## 4-Session Workflow

| Session | Focus | Gate | Est. Tokens |
|---------|-------|------|-------------|
| 1 | Keyword validation | Keyword Gate V3.1 | ~25,000 |
| 2 | Research completion | Research Gate | ~20,000 |
| 3 | Positioning angles | Angle Gate | ~15,000 |
| 4 | Writing + conversion | Content/Conversion/Final | ~40,000 |

---

## Session Start Prompts

Copy-paste the appropriate prompt when starting each session to manage context window.

### Session 1: Keyword Validation

```
ARTICLE: [Article Name] - [Keyword]
PILLAR: [N]

SESSION 1: KEYWORD VALIDATION

READ THESE FILES:
- .claude/keyword-library.md (check existing keywords)
- .claude/negative-keywords.md (check blocked terms)
- .claude/rejected-keywords.md (check previous failures)
- ARTICLE-ORDER.md (article details)

DO NOT READ:
- Full research files
- Article content files
- HushAway.md (not needed yet)
- humanise-rules.md (not needed yet)

RUN:
1. /keyword-research [keyword]
2. .claude/scripts/check-keyword-gate-v3.sh [research-file]

GATE: Keyword Gate V3.1 must PASS before Session 2
```

### Session 2: Research Completion

```
ARTICLE: [Article Name] - [Keyword]
PILLAR: [N]

SESSION 2: RESEARCH COMPLETION

READ THESE FILES:
- Research file from Session 1
- .claude/context/keyword-research-context.md

DO NOT READ:
- Other research files
- Article content files
- HushAway.md (not needed yet)
- humanise-rules.md (not needed yet)

RUN:
1. Complete research sections (PAA, competitors, sources)
2. .claude/scripts/check-research-gate.sh [research-file]
3. .claude/scripts/generate-research-summary.sh [research-file]

GATE: Research Gate must PASS before Session 3
OUTPUT: research-summary.md in .claude/scratchpad/
```

### Session 3: Positioning Angles

```
ARTICLE: [Article Name] - [Keyword]
PILLAR: [N]

SESSION 3: POSITIONING ANGLES

READ THESE FILES:
- .claude/scratchpad/research-summary.md (NOT full research)
- .claude/angle-library.md (avoid duplicate angles)
- .claude/context/positioning-angles-context.md

DO NOT READ:
- Full research file (use summary instead)
- Article content files
- HushAway.md (not needed yet)
- humanise-rules.md (not needed yet)

RUN:
1. /positioning-angles
2. Select angle from generated options
3. Update .claude/angle-library.md with selection
4. .claude/scripts/check-angle-gate.sh [research-file]

GATE: Angle Gate must PASS before Session 4
```

### Session 4: Writing + Conversion

```
ARTICLE: [Article Name] - [Keyword]
PILLAR: [N]

SESSION 4: WRITING + CONVERSION

READ THESE FILES:
- .claude/scratchpad/research-summary.md (compact data)
- .claude/rules/humanise-rules.md (CRITICAL - all content rules)
- HushAway.md (product details for CTAs)
- .claude/context/seo-content-context.md
- .claude/context/direct-response-context.md

DO NOT READ:
- Full research file (summary has all data)
- Other article files
- Keyword library (not needed)

RUN:
1. /seo-content (run quick-check.sh after each H2 section)
2. .claude/scripts/master-gate.sh [article] [hub|cluster] --summary
3. /direct-response-copy
4. .claude/scripts/check-conversion-gate.sh [article] --summary
5. .claude/scripts/check-final-gate.sh [article] [hub|cluster]

GATES: Content, Conversion, Final must ALL PASS
```

---

## Quick Stats

| Pillar | Name | Hub Keyword | Volume | Diff | Score | Hub | Clusters | Total |
|--------|------|-------------|--------|------|-------|-----|----------|-------|
| 1 | Sleep and Bedtime | ADHD sleep | 2,400 | 5 | 400 | ⬜ | 0/15 | 0/16 |
| 2 | Meltdowns | autistic meltdown | 3,600 | 10 | 450 | ⬜ | 0/15 | 0/16 |
| 3 | Emotional Regulation | emotional dysregulation | 9,900 | 42 | 457 | ⬜ | 0/12 | 0/13 |
| 4 | Transitions and Routines | autism routine | 390 | 12 | 35 | ⬜ | 0/15 | 0/16 |
| 5 | Focus and Concentration | ADHD focus | 260 | 16 | 20 | ⬜ | 0/12 | 0/13 |
| 6 | Sensory Processing | sensory overload | 3,600 | 46 | 161 | ⬜ | 0/15 | 0/16 |
| 7 | Sound Therapy | sound therapy | 1,600 | 41 | 63 | ⬜ | 0/10 | 0/11 |
| 8 | Comparisons | calm apps | 4,400 | 47 | 193 | ⬜ | 0/8 | 0/9 |

**Execution Priority:** 1 > 2 > 6 > 4 > 3 > 5 > 7 > 8 (crisis intent first, comparisons last)

---

## Pillar 1: Sleep and Bedtime

**Hub Keyword:** ADHD sleep (2,400/mo, KD 5, Easy)
**V3 Score:** 400 | **Intent:** Crisis | **Trend:** Stable
**Product Fit:** Night Time Stories, Sleep Audio, Sound Garden, Binaural Beats

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 1.0 | ⬜ | HUB: When Your Neurodivergent Child Won't Sleep | ADHD sleep | `/keyword-research ADHD sleep` |
| 1.1 | ⬜ | ADHD child won't sleep | ADHD child won't sleep | `/keyword-research ADHD child won't sleep` |
| 1.2 | ⬜ | Autistic child sleep problems | autistic child sleep problems | `/keyword-research autistic child sleep problems` |
| 1.3 | ⬜ | ADHD bedtime routine | ADHD bedtime routine | `/keyword-research ADHD bedtime routine` |
| 1.4 | ⬜ | Autism bedtime routine | autism bedtime routine | `/keyword-research autism bedtime routine` |
| 1.5 | ⬜ | Sensory bedroom setup | sensory bedroom setup | `/keyword-research sensory bedroom setup` |
| 1.6 | ⬜ | Melatonin alternatives children | melatonin alternatives children | `/keyword-research melatonin alternatives children` |
| 1.7 | ⬜ | Child wakes up all night | child wakes up all night | `/keyword-research child wakes up all night` |
| 1.8 | ⬜ | ADHD child anxious about sleeping alone | ADHD child anxious sleeping alone | `/keyword-research ADHD child anxious sleeping alone` |
| 1.9 | ⬜ | Racing thoughts at bedtime | racing thoughts at bedtime child | `/keyword-research racing thoughts at bedtime child` |
| 1.10 | ⬜ | Weighted blanket autism sleep | weighted blanket autism sleep | `/keyword-research weighted blanket autism sleep` |
| 1.11 | ⬜ | Why do ADHD children struggle with sleep | why do ADHD children struggle with sleep | `/keyword-research why do ADHD children struggle with sleep` |
| 1.12 | ⬜ | NHS sleep clinic autism | NHS sleep clinic autism | `/keyword-research NHS sleep clinic autism` |
| 1.13 | ⬜ | Screen time before bed autism | screen time before bed autism | `/keyword-research screen time before bed autism` |
| 1.14 | ⬜ | Bedwetting ADHD autism | bedwetting ADHD autism | `/keyword-research bedwetting ADHD autism` |
| 1.15 | ⬜ | Sound therapy for sleep | sound therapy for sleep children | `/keyword-research sound therapy for sleep children` |

---

## Pillar 2: Meltdowns

**Hub Keyword:** autistic meltdown (3,600/mo, KD 10, Easy)
**V3 Score:** 450 | **Intent:** Crisis | **Trend:** Stable
**Product Fit:** Frequencies, Peace Time, Kaleidoscopes

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 2.0 | ⬜ | HUB: Meltdowns: What's Really Happening and How to Help | autistic meltdown | `/keyword-research autistic meltdown` |
| 2.1 | ⬜ | Autistic meltdown strategies | autistic meltdown strategies | `/keyword-research autistic meltdown strategies` |
| 2.2 | ⬜ | ADHD meltdown | ADHD meltdown | `/keyword-research ADHD meltdown` |
| 2.3 | ⬜ | Meltdown vs tantrum | meltdown vs tantrum | `/keyword-research meltdown vs tantrum` |
| 2.4 | ⬜ | Sensory meltdown | sensory meltdown | `/keyword-research sensory meltdown` |
| 2.5 | ⬜ | How to calm child during meltdown | how to calm child during meltdown | `/keyword-research how to calm child during meltdown` |
| 2.6 | ⬜ | Meltdown triggers autism | meltdown triggers autism | `/keyword-research meltdown triggers autism` |
| 2.7 | ⬜ | Meltdown at school | meltdown at school | `/keyword-research meltdown at school` |
| 2.8 | ⬜ | After meltdown recovery | after meltdown recovery | `/keyword-research after meltdown recovery` |
| 2.9 | ⬜ | Public meltdown autism | public meltdown autism | `/keyword-research public meltdown autism` |
| 2.10 | ⬜ | Meltdown survival guide parents | meltdown survival guide parents | `/keyword-research meltdown survival guide parents` |
| 2.11 | ⬜ | Shutdown vs meltdown | shutdown vs meltdown autism | `/keyword-research shutdown vs meltdown autism` |
| 2.12 | ⬜ | Bedtime meltdowns | bedtime meltdowns | `/keyword-research bedtime meltdowns` |
| 2.13 | ⬜ | Sound for meltdown recovery | sound for meltdown recovery | `/keyword-research sound for meltdown recovery` |
| 2.14 | ⬜ | Meltdown prevention strategies | meltdown prevention strategies | `/keyword-research meltdown prevention strategies` |
| 2.15 | ⬜ | Am I making meltdowns worse | am I making meltdowns worse | `/keyword-research am I making meltdowns worse` |

---

## Pillar 3: Emotional Regulation

**Hub Keyword:** emotional dysregulation (9,900/mo, KD 42, Medium)
**V3 Score:** 457 | **Intent:** Info-product | **Trend:** Rising
**Product Fit:** Emotions series, Affirmations, Peace Time

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 3.0 | ⬜ | HUB: Big Feelings: Understanding and Supporting Emotional Regulation | emotional dysregulation | `/keyword-research emotional dysregulation` |
| 3.1 | ⬜ | Emotional dysregulation ADHD | emotional dysregulation ADHD | `/keyword-research emotional dysregulation ADHD` |
| 3.2 | ⬜ | Big feelings autism | big feelings autism | `/keyword-research big feelings autism` |
| 3.3 | ⬜ | ADHD mood swings child | ADHD mood swings child | `/keyword-research ADHD mood swings child` |
| 3.4 | ⬜ | Calming strategies children | calming strategies children | `/keyword-research calming strategies children` |
| 3.5 | ⬜ | Angry outbursts ADHD child | angry outbursts ADHD child | `/keyword-research angry outbursts ADHD child` |
| 3.6 | ⬜ | Emotional regulation tools | emotional regulation tools children | `/keyword-research emotional regulation tools children` |
| 3.7 | ⬜ | Co-regulation parent child | co-regulation parent child | `/keyword-research co-regulation parent child` |
| 3.8 | ⬜ | Nervous system regulation children | nervous system regulation children | `/keyword-research nervous system regulation children` |
| 3.9 | ⬜ | Rejection sensitivity dysphoria | rejection sensitivity dysphoria | `/keyword-research rejection sensitivity dysphoria` |
| 3.10 | ⬜ | Anxiety and ADHD child | anxiety and ADHD child | `/keyword-research anxiety and ADHD child` |
| 3.11 | ⬜ | Sound therapy emotional regulation | sound therapy emotional regulation | `/keyword-research sound therapy emotional regulation` |
| 3.12 | ⬜ | Helping child identify emotions | helping child identify emotions | `/keyword-research helping child identify emotions` |

---

## Pillar 4: Transitions and Routines

**Hub Keyword:** autism routine (390/mo, KD 12, Easy)
**V3 Score:** 35 | **Intent:** Info-product | **Trend:** Stable
**Product Fit:** All products (transition support)

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 4.0 | ⬜ | HUB: Why Transitions Are So Hard (And What Actually Helps) | autism routine | `/keyword-research autism routine` |
| 4.1 | ⬜ | Morning routine ADHD child | morning routine ADHD child | `/keyword-research morning routine ADHD child` |
| 4.2 | ⬜ | Autistic child morning struggles | autistic child morning struggles | `/keyword-research autistic child morning struggles` |
| 4.3 | ⬜ | After school meltdowns | after school meltdowns | `/keyword-research after school meltdowns` |
| 4.4 | ⬜ | After school routine autism | after school routine autism | `/keyword-research after school routine autism` |
| 4.5 | ⬜ | School refusal autism | school refusal autism | `/keyword-research school refusal autism` |
| 4.6 | ⬜ | Transition to secondary school autism | transition to secondary school autism | `/keyword-research transition to secondary school autism` |
| 4.7 | ⬜ | Visual timetable autism | visual timetable autism | `/keyword-research visual timetable autism` |
| 4.8 | ⬜ | ADHD child won't get ready | ADHD child won't get ready | `/keyword-research ADHD child won't get ready` |
| 4.9 | ⬜ | Transition between activities | transition between activities ADHD | `/keyword-research transition between activities ADHD` |
| 4.10 | ⬜ | Low demand parenting | low demand parenting | `/keyword-research low demand parenting` |
| 4.11 | ⬜ | Routine changes ADHD anxiety | routine changes ADHD anxiety | `/keyword-research routine changes ADHD anxiety` |
| 4.12 | ⬜ | School uniform sensory issues | school uniform sensory issues | `/keyword-research school uniform sensory issues` |
| 4.13 | ⬜ | Holiday routine autism | holiday routine autism | `/keyword-research holiday routine autism` |
| 4.14 | ⬜ | Sound for transitions | sound for transitions | `/keyword-research sound for transitions` |
| 4.15 | ⬜ | Time blindness ADHD morning | time blindness ADHD morning | `/keyword-research time blindness ADHD morning` |

---

## Pillar 5: Focus and Concentration

**Hub Keyword:** ADHD focus (260/mo, KD 16, Easy)
**V3 Score:** 20 | **Intent:** Info-product | **Trend:** Stable
**Product Fit:** Frequencies, Focus series, Binaural Beats

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 5.0 | ⬜ | HUB: Beyond 'Just Focus': What ADHD Attention Actually Looks Like | ADHD focus | `/keyword-research ADHD focus` |
| 5.1 | ⬜ | ADHD child won't do homework | ADHD child won't do homework | `/keyword-research ADHD child won't do homework` |
| 5.2 | ⬜ | Homework battles ADHD | homework battles ADHD | `/keyword-research homework battles ADHD` |
| 5.3 | ⬜ | Fidget tools focus ADHD | fidget tools focus ADHD | `/keyword-research fidget tools focus ADHD` |
| 5.4 | ⬜ | How long can ADHD child focus | how long can ADHD child focus | `/keyword-research how long can ADHD child focus` |
| 5.5 | ⬜ | Distraction free homework space | distraction free homework space | `/keyword-research distraction free homework space` |
| 5.6 | ⬜ | ADHD medication homework timing | ADHD medication homework timing | `/keyword-research ADHD medication homework timing` |
| 5.7 | ⬜ | Focus inconsistency ADHD | focus inconsistency ADHD | `/keyword-research focus inconsistency ADHD` |
| 5.8 | ⬜ | Exam accommodations ADHD UK | exam accommodations ADHD UK | `/keyword-research exam accommodations ADHD UK` |
| 5.9 | ⬜ | Handwriting difficulties ADHD | handwriting difficulties ADHD | `/keyword-research handwriting difficulties ADHD` |
| 5.10 | ⬜ | Background noise helps ADHD | background noise helps ADHD | `/keyword-research background noise helps ADHD` |
| 5.11 | ⬜ | Sound therapy focus | sound therapy focus | `/keyword-research sound therapy focus` |
| 5.12 | ⬜ | SATs stress ADHD autism | SATs stress ADHD autism | `/keyword-research SATs stress ADHD autism` |

---

## Pillar 6: Sensory Processing

**Hub Keyword:** sensory overload (3,600/mo, KD 46, Medium)
**V3 Score:** 161 | **Intent:** Crisis | **Trend:** Stable
**Product Fit:** ASMR Kaleidoscopes, Frequencies, ASMR Soundscapes

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 6.0 | ⬜ | HUB: Sensory Overload: What Your Child Experiences and How to Help | sensory overload | `/keyword-research sensory overload` |
| 6.1 | ⬜ | Sensory overload symptoms | sensory overload symptoms | `/keyword-research sensory overload symptoms` |
| 6.2 | ⬜ | ADHD overstimulation | ADHD overstimulation | `/keyword-research ADHD overstimulation` |
| 6.3 | ⬜ | Sensory seeking child | sensory seeking child | `/keyword-research sensory seeking child` |
| 6.4 | ⬜ | Sensory avoiding child | sensory avoiding child | `/keyword-research sensory avoiding child` |
| 6.5 | ⬜ | Noise sensitivity ADHD | noise sensitivity ADHD | `/keyword-research noise sensitivity ADHD` |
| 6.6 | ⬜ | Light sensitivity autism | light sensitivity autism | `/keyword-research light sensitivity autism` |
| 6.7 | ⬜ | Sensory diet activities | sensory diet activities | `/keyword-research sensory diet activities` |
| 6.8 | ⬜ | Sensory friendly environment | sensory friendly environment | `/keyword-research sensory friendly environment` |
| 6.9 | ⬜ | Sensory overload school | sensory overload school | `/keyword-research sensory overload school` |
| 6.10 | ⬜ | AuDHD sensory | AuDHD sensory | `/keyword-research AuDHD sensory` |
| 6.11 | ⬜ | Sensory meltdown triggers | sensory meltdown triggers | `/keyword-research sensory meltdown triggers` |
| 6.12 | ⬜ | Calming sensory input | calming sensory input | `/keyword-research calming sensory input` |
| 6.13 | ⬜ | Interoception children | interoception children | `/keyword-research interoception children` |
| 6.14 | ⬜ | Sound therapy sensory overload | sound therapy sensory overload | `/keyword-research sound therapy sensory overload` |
| 6.15 | ⬜ | Sensory processing differences explained | sensory processing differences explained | `/keyword-research sensory processing differences explained` |

---

## Pillar 7: Sound Therapy

**Hub Keyword:** sound therapy (1,600/mo, KD 41, Medium)
**V3 Score:** 63 | **Intent:** Info-product | **Trend:** Stable
**Product Fit:** All HushAway products

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 7.0 | ⬜ | HUB: Sound Therapy for Neurodivergent Children: What the Research Shows | sound therapy | `/keyword-research sound therapy` |
| 7.1 | ⬜ | White noise autism sleep | white noise autism sleep | `/keyword-research white noise autism sleep` |
| 7.2 | ⬜ | ASMR for children | ASMR for children | `/keyword-research ASMR for children` |
| 7.3 | ⬜ | Binaural beats children | binaural beats children | `/keyword-research binaural beats children` |
| 7.4 | ⬜ | Nature sounds calm children | nature sounds calm children | `/keyword-research nature sounds calm children` |
| 7.5 | ⬜ | Sound for sensory regulation | sound for sensory regulation | `/keyword-research sound for sensory regulation` |
| 7.6 | ⬜ | Passive listening vs apps | passive listening vs apps | `/keyword-research passive listening vs apps` |
| 7.7 | ⬜ | HushAway sound sanctuary | HushAway sound sanctuary | `/keyword-research HushAway sound sanctuary` |
| 7.8 | ⬜ | Sound therapy vs meditation | sound therapy vs meditation | `/keyword-research sound therapy vs meditation` |
| 7.9 | ⬜ | Calming sounds vs silence | calming sounds vs silence | `/keyword-research calming sounds vs silence` |
| 7.10 | ⬜ | Sound sensitivity and sound therapy | sound sensitivity and sound therapy | `/keyword-research sound sensitivity and sound therapy` |

---

## Pillar 8: Comparisons

**Hub Keyword:** calm apps (4,400/mo, KD 47, Medium)
**V3 Score:** 193 | **Intent:** Commercial | **Trend:** Stable
**Product Fit:** All HushAway products

| # | Status | Article | Keyword | Prompt |
|---|--------|---------|---------|--------|
| 8.0 | ⬜ | HUB: Finding the Right Sound App for Your Neurodivergent Child | calm apps | `/keyword-research calm apps` |
| 8.1 | ⬜ | HushAway vs Calm | HushAway vs Calm | `/keyword-research HushAway vs Calm` |
| 8.2 | ⬜ | HushAway vs Moshi | HushAway vs Moshi | `/keyword-research HushAway vs Moshi` |
| 8.3 | ⬜ | HushAway vs Headspace | HushAway vs Headspace | `/keyword-research HushAway vs Headspace` |
| 8.4 | ⬜ | Free ADHD apps children | free ADHD apps children | `/keyword-research free ADHD apps children` |
| 8.5 | ⬜ | Best sleep apps autism UK | best sleep apps autism UK | `/keyword-research best sleep apps autism UK` |
| 8.6 | ⬜ | Sound apps vs meditation apps | sound apps vs meditation apps | `/keyword-research sound apps vs meditation apps` |
| 8.7 | ⬜ | Generic calm apps don't work | generic calm apps don't work | `/keyword-research generic calm apps don't work` |
| 8.8 | ⬜ | Screen-free sound options | screen-free sound options | `/keyword-research screen-free sound options` |

---

## Validation Data Summary

| Pillar | Hub Keyword | UK Volume | Difficulty | Trend | V3 Score | Priority |
|--------|-------------|-----------|------------|-------|----------|----------|
| 1 | ADHD sleep | 2,400 | 5 (Easy) | Stable | 400 | 1st |
| 2 | autistic meltdown | 3,600 | 10 (Easy) | Stable | 450 | 2nd |
| 3 | emotional dysregulation | 9,900 | 42 (Medium) | Rising | 457 | 5th |
| 4 | autism routine | 390 | 12 (Easy) | Stable | 35 | 4th |
| 5 | ADHD focus | 260 | 16 (Easy) | Stable | 20 | 6th |
| 6 | sensory overload | 3,600 | 46 (Medium) | Stable | 161 | 3rd |
| 7 | sound therapy | 1,600 | 41 (Medium) | Stable | 63 | 7th |
| 8 | calm apps | 4,400 | 47 (Medium) | Stable | 193 | 8th |

**Total Validated Hub Volume:** 26,050
**Data Source:** DataForSEO + Perplexity MCP (UK location 2826)
**Validation Date:** 2026-01-31

---

## File Structure

Articles are stored in: `/src/content/pillar-[N]-[topic-name]/`
Research files are stored in: `/research/pillar-[N]-[topic-name]/`

Example paths:
- Hub: `src/content/pillar-1-sleep-bedtime/hub-adhd-sleep.md`
- Cluster: `src/content/pillar-1-sleep-bedtime/1.1-adhd-child-wont-sleep.md`
- Research: `research/pillar-1-sleep-bedtime/hub-research.md`

---

*Last Updated: 2026-01-31*
