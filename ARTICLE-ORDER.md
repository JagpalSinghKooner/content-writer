# HushAway® Article Generation Order

**Total Articles:** 77 (7 Hubs + 70 Clusters)
**Completed:** 6 / 77

---

## How to Use This Document

1. Work through articles in order (highest search volume first)
2. Mark checkboxes as you complete each article
3. Copy the prompt from the right column to start a new context window
4. **Include the Standard Notes below with every prompt**
5. Each prompt includes the research file creation + article writing workflow

---

## 2-Session Workflow (Optimal Quality)

Split research and writing into separate sessions for better output quality.

---

### SESSION 1: Research Phase

Copy this prompt to start research on the NEXT article:

```
Research the next article in the pipeline.

STEP 1: Find next article
- Read ARTICLE-ORDER.md
- Find the FIRST row with ⬜ status
- That is your target article

STEP 2: Research phase (Gates 1-3)
1. Run /keyword-research with Perplexity MCP
2. Create research file at the path shown in ARTICLE-ORDER.md prompt column
3. Update keyword-library.md with validated keyword
4. Pass Keyword Gate (check-keyword-gate.sh)
5. Complete full research using Perplexity
6. Pass Research Gate (check-research-gate.sh)
7. Run generate-research-summary.sh [research-file]
8. Run /positioning-angles (generates options, does NOT select)

STOP HERE. Angle options saved. Start new session for writing.
```

---

### SESSION 2: Writing Phase

Copy this prompt in a NEW session to write the article:

```
Write the article that has research completed.

STEP 1: Select Angle
- Read .claude/scratchpad/research-summary.md (has keywords + angle options)
- Read research file for full angle option details (psychology, patterns)
- Present ALL angle options to writer with their psychology/reasoning
- Use AskUserQuestion to let writer choose which angle to use
- Once writer selects:
  1. Update research file frontmatter:
     - angleStatus: selected
     - selectedAngle: "[chosen angle name]"
     - angleDescription: "[one sentence from chosen option]"
     - headlineDirection: "[headline from chosen option]"
     - counterPositions: [extract from research competitor gaps]
  2. Add row to .claude/angle-library.md (all 6 columns)
  3. Update research-summary.md Positioning section with selected angle
  4. Run Angle Gate: .claude/scripts/check-angle-gate.sh [research-file]
  5. Gate MUST show PASS before proceeding

STEP 2: Writing phase (Gates 4-6)
1. Run /seo-content to write article
2. Save to path shown in ARTICLE-ORDER.md prompt column
3. Pass Content Gate (master-gate.sh [file] [hub|cluster] --summary)
   - Use --diff on re-runs to see FIXED/STILL FAILING/NEW
4. Run /direct-response-copy
5. Pass Conversion Gate (check-conversion-gate.sh --summary)
6. Pass Final Gate (check-final-gate.sh)
7. Mark article ✅ in ARTICLE-ORDER.md

IMPORTANT REMINDERS:
- Avoid commitment language: subscription, premium, free trial, sign up for, register
- Monitor frequency words: actually (max 3), designed to/for (max 3)
- Use frontmatter from templates/article-template.md
- Community quotes: 2 for hub, 1 for cluster
- Sound Sanctuary: mention 2+ times in conversion contexts
- Risk reversal: include "nothing to lose", "costs nothing to try"
- All 6 gates must pass before marking complete
```

---

## Quick Stats

| Pillar | Name | Hub Status | Clusters Done | Total |
|--------|------|------------|---------------|-------|
| 5 | ADHD Apps | ✅ | 3/10 | 4/11 |
| 2 | Sleep Apps for Kids | ⬜ | 0/10 | 0/11 |
| 1 | ADHD Sleep Support | ⬜ | 0/10 | 0/11 |
| 3 | Anxiety Apps for Children | ⬜ | 0/10 | 0/11 |
| 4 | Sensory Friendly Apps | ⬜ | 0/10 | 0/11 |
| 7 | Neurodivergent Parenting | ⬜ | 0/10 | 0/11 |
| 6 | Emotional Regulation | ⬜ | 0/10 | 0/11 |

---

## Pillar 5: ADHD Apps (25,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 1 | ✅ | HUB: ADHD Apps | ADHD apps | 25,000 | `Create research file at research/pillar-5-adhd-apps/hub-research.md using the template, then write hub article for "ADHD apps" targeting parents of ADHD children. Save to src/content/pillar-5-adhd-apps/hub-adhd-apps.md. Run all 6 gates before finalising.` |
| 2 | ✅ | 5.1 Focus Apps ADHD | Focus apps ADHD | 600-1,200 | `Create research file at research/pillar-5-adhd-apps/5.1-focus-apps-research.md using the template, then write cluster article for "Focus apps ADHD" targeting parents of ADHD children. Save to src/content/pillar-5-adhd-apps/5.1-focus-apps-adhd.md. Run all gates before finalising.` |
| 3 | ✅ | 5.2 Task Management Apps | Task management apps kids | 400-900 | `Create research file at research/pillar-5-adhd-apps/5.2-task-management-research.md using the template, then write cluster article for "Task management apps kids" targeting parents. Save to src/content/pillar-5-adhd-apps/5.2-task-management-apps.md. Run all gates before finalising.` |
| 4 | ✅ | 5.3 Executive Function Apps | Executive function ADHD apps | 300-700 | `Create research file at research/pillar-5-adhd-apps/5.3-executive-function-research.md using the template, then write cluster article for "Executive function ADHD apps" targeting parents. Save to src/content/pillar-5-adhd-apps/5.3-executive-function-apps.md. Run all gates before finalising.` |
| 5 | ✅ | 5.4 Behavior Tracking | Behavior tracking ADHD | 300-700 | `Create research file at research/pillar-5-adhd-apps/5.4-behavior-tracking-research.md using the template, then write cluster article for "Behavior tracking ADHD" (use UK spelling "behaviour" in content) targeting parents. Save to src/content/pillar-5-adhd-apps/5.4-behaviour-tracking-adhd.md. Run all gates before finalising.` |
| 6 | ⬜ | 5.5 Organization Apps | Organization apps ADHD children | 400-800 | `Create research file at research/pillar-5-adhd-apps/5.5-organisation-apps-research.md using the template, then write cluster article for "Organization apps ADHD children" (use UK spelling "organisation" in content) targeting parents. Save to src/content/pillar-5-adhd-apps/5.5-organisation-apps-adhd.md. Run all gates before finalising.` |
| 7 | ⬜ | 5.6 Treatment Apps | ADHD treatment medication therapy apps | 400-900 | `Create research file at research/pillar-5-adhd-apps/5.6-treatment-apps-research.md using the template, then write cluster article for "ADHD treatment medication therapy apps" targeting parents seeking complementary support. Save to src/content/pillar-5-adhd-apps/5.6-adhd-treatment-apps.md. Run all gates before finalising.` |
| 8 | ⬜ | 5.7 FDA Approved Game | FDA approved ADHD game | 300-600 | `Create research file at research/pillar-5-adhd-apps/5.7-fda-approved-game-research.md using the template, then write cluster article for "FDA approved ADHD game" (EndeavorRx focus) targeting parents. Save to src/content/pillar-5-adhd-apps/5.7-fda-approved-adhd-game.md. Run all gates before finalising.` |
| 9 | ⬜ | 5.8 School Apps | ADHD apps school classroom | 400-900 | `Create research file at research/pillar-5-adhd-apps/5.8-school-apps-research.md using the template, then write cluster article for "ADHD apps school classroom" targeting parents and educators. Save to src/content/pillar-5-adhd-apps/5.8-adhd-apps-school.md. Run all gates before finalising.` |
| 10 | ⬜ | 5.9 Apps by Age | ADHD apps by age | 300-700 | `Create research file at research/pillar-5-adhd-apps/5.9-apps-by-age-research.md using the template, then write cluster article for "ADHD apps by age" covering toddlers through teens. Save to src/content/pillar-5-adhd-apps/5.9-adhd-apps-by-age.md. Run all gates before finalising.` |
| 11 | ⬜ | 5.10 Emotional Dysregulation | Emotional dysregulation ADHD apps | 400-800 | `Create research file at research/pillar-5-adhd-apps/5.10-emotional-dysregulation-research.md using the template, then write cluster article for "Emotional dysregulation ADHD apps" targeting parents. Save to src/content/pillar-5-adhd-apps/5.10-emotional-dysregulation-apps.md. Run all gates before finalising.` |

---

## Pillar 2: Sleep Apps for Kids (8,000-12,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 12 | ⬜ | HUB: Sleep Apps for Kids | Sleep apps for kids | 8,000-12,000 | `Create research file at research/pillar-2-sleep-apps/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "Sleep apps for kids" targeting parents of children with sleep difficulties. Save to src/content/pillar-2-sleep-apps/hub-sleep-apps-kids.md. Run all gates before finalising.` |
| 13 | ⬜ | 2.1 Stories vs Meditation | Bedtime stories vs meditation apps kids | 300-600 | `Create research file at research/pillar-2-sleep-apps/2.1-stories-vs-meditation-research.md using the template, then write cluster article for "Bedtime stories vs meditation apps kids" targeting parents. Save to src/content/pillar-2-sleep-apps/2.1-stories-vs-meditation.md. Run all gates before finalising.` |
| 14 | ⬜ | 2.2 Sleep Apps Toddlers | Sleep apps for toddlers | 1,000-2,000 | `Create research file at research/pillar-2-sleep-apps/2.2-toddler-sleep-apps-research.md using the template, then write cluster article for "Sleep apps for toddlers" targeting parents of 1-3 year olds. Save to src/content/pillar-2-sleep-apps/2.2-sleep-apps-toddlers.md. Run all gates before finalising.` |
| 15 | ⬜ | 2.3 School Age Sleep | Sleep apps for school age children | 800-1,500 | `Create research file at research/pillar-2-sleep-apps/2.3-school-age-research.md using the template, then write cluster article for "Sleep apps for school age children" targeting parents of 5-12 year olds. Save to src/content/pillar-2-sleep-apps/2.3-sleep-apps-school-age.md. Run all gates before finalising.` |
| 16 | ⬜ | 2.4 Sleep Apps Teens | Sleep apps for teens | 600-1,200 | `Create research file at research/pillar-2-sleep-apps/2.4-teen-sleep-apps-research.md using the template, then write cluster article for "Sleep apps for teens" targeting parents of teenagers. Save to src/content/pillar-2-sleep-apps/2.4-sleep-apps-teens.md. Run all gates before finalising.` |
| 17 | ⬜ | 2.5 Sleep Routine | Sleep routine for kids | 1,500-2,500 | `Create research file at research/pillar-2-sleep-apps/2.5-sleep-routine-research.md using the template, then write cluster article for "Sleep routine for kids" targeting parents seeking bedtime structure. Save to src/content/pillar-2-sleep-apps/2.5-sleep-routine-kids.md. Run all gates before finalising.` |
| 18 | ⬜ | 2.6 White Noise vs Guided | White noise vs guided sleep apps | 200-500 | `Create research file at research/pillar-2-sleep-apps/2.6-white-noise-vs-guided-research.md using the template, then write cluster article for "White noise vs guided sleep apps" comparing approaches. Save to src/content/pillar-2-sleep-apps/2.6-white-noise-vs-guided.md. Run all gates before finalising.` |
| 19 | ⬜ | 2.7 Screen Time Before Bed | Screen time before bed kids | 1,000-2,000 | `Create research file at research/pillar-2-sleep-apps/2.7-screen-time-research.md using the template, then write cluster article for "Screen time before bed kids" addressing the paradox of sleep apps. Save to src/content/pillar-2-sleep-apps/2.7-screen-time-before-bed.md. Run all gates before finalising.` |
| 20 | ⬜ | 2.8 Free Sleep Apps | Best free sleep apps for kids | 800-1,500 | `Create research file at research/pillar-2-sleep-apps/2.8-free-sleep-apps-research.md using the template, then write cluster article for "Best free sleep apps for kids" with honest assessments. Save to src/content/pillar-2-sleep-apps/2.8-free-sleep-apps-kids.md. Run all gates before finalising.` |
| 21 | ⬜ | 2.9 Sleep Training | Sleep apps and sleep training | 300-700 | `Create research file at research/pillar-2-sleep-apps/2.9-sleep-training-research.md using the template, then write cluster article for "Sleep apps and sleep training" for parents of younger children. Save to src/content/pillar-2-sleep-apps/2.9-sleep-apps-training.md. Run all gates before finalising.` |
| 22 | ⬜ | 2.10 Sleep Tracking | Sleep tracking apps for kids | 400-800 | `Create research file at research/pillar-2-sleep-apps/2.10-sleep-tracking-research.md using the template, then write cluster article for "Sleep tracking apps for kids" with privacy considerations. Save to src/content/pillar-2-sleep-apps/2.10-sleep-tracking-apps.md. Run all gates before finalising.` |

---

## Pillar 1: ADHD Sleep Support (5,000-8,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 23 | ⬜ | HUB: ADHD Sleep | ADHD sleep dysregulation | 5,000-8,000 | `Create research file at research/pillar-1-adhd-sleep/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "ADHD sleep dysregulation" targeting exhausted parents. Save to src/content/pillar-1-adhd-sleep/hub-adhd-sleep.md. Run all gates before finalising.` |
| 24 | ⬜ | 1.1 Bedtime Resistance | ADHD bedtime resistance | 1,500-2,000 | `Create research file at research/pillar-1-adhd-sleep/1.1-bedtime-resistance-research.md using the template, then write cluster article for "ADHD bedtime resistance" targeting frustrated parents. Save to src/content/pillar-1-adhd-sleep/1.1-bedtime-resistance.md. Run all gates before finalising.` |
| 25 | ⬜ | 1.2 Help Fall Asleep | How to help ADHD child fall asleep | 1,200-1,800 | `Create research file at research/pillar-1-adhd-sleep/1.2-help-fall-asleep-research.md using the template, then write cluster article for "How to help ADHD child fall asleep" with practical strategies. Save to src/content/pillar-1-adhd-sleep/1.2-help-adhd-child-fall-asleep.md. Run all gates before finalising.` |
| 26 | ⬜ | 1.3 Sleep Schedule | ADHD sleep schedule | 800-1,200 | `Create research file at research/pillar-1-adhd-sleep/1.3-sleep-schedule-research.md using the template, then write cluster article for "ADHD sleep schedule" with routine-building advice. Save to src/content/pillar-1-adhd-sleep/1.3-adhd-sleep-schedule.md. Run all gates before finalising.` |
| 27 | ⬜ | 1.4 Sensory Bedroom | Sensory bedroom ADHD | 600-1,000 | `Create research file at research/pillar-1-adhd-sleep/1.4-sensory-bedroom-research.md using the template, then write cluster article for "Sensory bedroom ADHD" with environment design tips. Save to src/content/pillar-1-adhd-sleep/1.4-sensory-bedroom-adhd.md. Run all gates before finalising.` |
| 28 | ⬜ | 1.5 Medication Side Effects | ADHD medication sleep side effects | 400-700 | `Create research file at research/pillar-1-adhd-sleep/1.5-medication-sleep-research.md using the template, then write cluster article for "ADHD medication sleep side effects" with balanced information. Save to src/content/pillar-1-adhd-sleep/1.5-medication-sleep-effects.md. Run all gates before finalising.` |
| 29 | ⬜ | 1.6 Melatonin | Melatonin ADHD children | 400-600 | `Create research file at research/pillar-1-adhd-sleep/1.6-melatonin-research.md using the template, then write cluster article for "Melatonin ADHD children" with research-backed guidance. Save to src/content/pillar-1-adhd-sleep/1.6-melatonin-adhd-children.md. Run all gates before finalising.` |
| 30 | ⬜ | 1.7 Night Waking | ADHD night waking | 500-900 | `Create research file at research/pillar-1-adhd-sleep/1.7-night-waking-research.md using the template, then write cluster article for "ADHD night waking" addressing middle-of-night challenges. Save to src/content/pillar-1-adhd-sleep/1.7-adhd-night-waking.md. Run all gates before finalising.` |
| 31 | ⬜ | 1.8 Anxiety Sleep | ADHD anxiety sleep children | 600-1,000 | `Create research file at research/pillar-1-adhd-sleep/1.8-anxiety-sleep-research.md using the template, then write cluster article for "ADHD anxiety sleep children" addressing comorbid challenges. Save to src/content/pillar-1-adhd-sleep/1.8-adhd-anxiety-sleep.md. Run all gates before finalising.` |
| 32 | ⬜ | 1.9 Early Morning | ADHD early morning dysregulation | 300-600 | `Create research file at research/pillar-1-adhd-sleep/1.9-early-morning-research.md using the template, then write cluster article for "ADHD early morning dysregulation" for difficult mornings. Save to src/content/pillar-1-adhd-sleep/1.9-early-morning-dysregulation.md. Run all gates before finalising.` |
| 33 | ⬜ | 1.10 Screen Time Sleep | ADHD screen time sleep | 400-700 | `Create research file at research/pillar-1-adhd-sleep/1.10-screen-time-sleep-research.md using the template, then write cluster article for "ADHD screen time sleep" with practical boundaries. Save to src/content/pillar-1-adhd-sleep/1.10-adhd-screen-time-sleep.md. Run all gates before finalising.` |

---

## Pillar 3: Anxiety Apps for Children (4,000-6,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 34 | ⬜ | HUB: Anxiety Apps | Anxiety apps for children | 4,000-6,000 | `Create research file at research/pillar-3-anxiety-apps/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "Anxiety apps for children" targeting worried parents. Save to src/content/pillar-3-anxiety-apps/hub-anxiety-apps.md. Run all gates before finalising.` |
| 35 | ⬜ | 3.1 Anxiety Autism | Anxiety autism children | 700-1,400 | `Create research file at research/pillar-3-anxiety-apps/3.1-anxiety-autism-research.md using the template, then write cluster article for "Anxiety autism children" addressing unique needs. Save to src/content/pillar-3-anxiety-apps/3.1-anxiety-autism-children.md. Run all gates before finalising.` |
| 36 | ⬜ | 3.2 CBT Apps | CBT apps for kids anxiety | 400-900 | `Create research file at research/pillar-3-anxiety-apps/3.2-cbt-apps-research.md using the template, then write cluster article for "CBT apps for kids anxiety" with evidence-based focus. Save to src/content/pillar-3-anxiety-apps/3.2-cbt-apps-kids-anxiety.md. Run all gates before finalising.` |
| 37 | ⬜ | 3.3 Grounding Techniques | Grounding techniques anxious kids | 600-1,200 | `Create research file at research/pillar-3-anxiety-apps/3.3-grounding-techniques-research.md using the template, then write cluster article for "Grounding techniques anxious kids" with practical exercises. Save to src/content/pillar-3-anxiety-apps/3.3-grounding-techniques.md. Run all gates before finalising.` |
| 38 | ⬜ | 3.4 Social Anxiety ADHD | Social anxiety ADHD children | 500-1,100 | `Create research file at research/pillar-3-anxiety-apps/3.4-social-anxiety-research.md using the template, then write cluster article for "Social anxiety ADHD children" addressing comorbidity. Save to src/content/pillar-3-anxiety-apps/3.4-social-anxiety-adhd.md. Run all gates before finalising.` |
| 39 | ⬜ | 3.5 Separation Anxiety | Separation anxiety apps kids | 400-900 | `Create research file at research/pillar-3-anxiety-apps/3.5-separation-anxiety-research.md using the template, then write cluster article for "Separation anxiety apps kids" for school transitions. Save to src/content/pillar-3-anxiety-apps/3.5-separation-anxiety-apps.md. Run all gates before finalising.` |
| 40 | ⬜ | 3.6 Panic Attacks | Panic attacks children | 1,000-2,000 | `Create research file at research/pillar-3-anxiety-apps/3.6-panic-attacks-research.md using the template, then write cluster article for "Panic attacks children" with calming strategies. Save to src/content/pillar-3-anxiety-apps/3.6-panic-attacks-children.md. Run all gates before finalising.` |
| 41 | ⬜ | 3.7 Anxiety Medication Apps | Anxiety medication children apps | 300-700 | `Create research file at research/pillar-3-anxiety-apps/3.7-anxiety-medication-research.md using the template, then write cluster article for "Anxiety medication children apps" as complementary support. Save to src/content/pillar-3-anxiety-apps/3.7-anxiety-medication-apps.md. Run all gates before finalising.` |
| 42 | ⬜ | 3.8 Parent Anxiety | Parent anxiety child anxiety | 400-900 | `Create research file at research/pillar-3-anxiety-apps/3.8-parent-anxiety-research.md using the template, then write cluster article for "Parent anxiety child anxiety" addressing the connection. Save to src/content/pillar-3-anxiety-apps/3.8-parent-anxiety-child.md. Run all gates before finalising.` |
| 43 | ⬜ | 3.9 School Anxiety | School anxiety children apps | 400-900 | `Create research file at research/pillar-3-anxiety-apps/3.9-school-anxiety-research.md using the template, then write cluster article for "School anxiety children apps" for school-related worries. Save to src/content/pillar-3-anxiety-apps/3.9-school-anxiety-apps.md. Run all gates before finalising.` |
| 44 | ⬜ | 3.10 Performance Anxiety | Performance anxiety neurodivergent children | 200-500 | `Create research file at research/pillar-3-anxiety-apps/3.10-performance-anxiety-research.md using the template, then write cluster article for "Performance anxiety neurodivergent children" for tests and performances. Save to src/content/pillar-3-anxiety-apps/3.10-performance-anxiety.md. Run all gates before finalising.` |

---

## Pillar 4: Sensory Friendly Apps (2,000-3,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 45 | ⬜ | HUB: Sensory Apps | Sensory apps for children | 2,000-3,000 | `Create research file at research/pillar-4-sensory-apps/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "Sensory apps for children" targeting parents of sensory-sensitive kids. Save to src/content/pillar-4-sensory-apps/hub-sensory-apps.md. Run all gates before finalising.` |
| 46 | ⬜ | 4.1 Overload vs Seeking | Sensory overload vs sensory seeking | 300-700 | `Create research file at research/pillar-4-sensory-apps/4.1-overload-vs-seeking-research.md using the template, then write cluster article for "Sensory overload vs sensory seeking" explaining the difference. Save to src/content/pillar-4-sensory-apps/4.1-overload-vs-seeking.md. Run all gates before finalising.` |
| 47 | ⬜ | 4.2 Binaural Beats Kids | Binaural beats kids | 400-800 | `Create research file at research/pillar-4-sensory-apps/4.2-binaural-beats-research.md using the template, then write cluster article for "Binaural beats kids" with research backing. Save to src/content/pillar-4-sensory-apps/4.2-binaural-beats-kids.md. Run all gates before finalising.` |
| 48 | ⬜ | 4.3 ASMR Kids | ASMR kids | 600-1,200 | `Create research file at research/pillar-4-sensory-apps/4.3-asmr-kids-research.md using the template, then write cluster article for "ASMR kids" with sensory-friendly focus. Save to src/content/pillar-4-sensory-apps/4.3-asmr-kids.md. Run all gates before finalising.` |
| 49 | ⬜ | 4.4 Autism Sensory | Autism sensory regulation apps | 400-900 | `Create research file at research/pillar-4-sensory-apps/4.4-autism-sensory-research.md using the template, then write cluster article for "Autism sensory regulation apps" for autistic children. Save to src/content/pillar-4-sensory-apps/4.4-autism-sensory-apps.md. Run all gates before finalising.` |
| 50 | ⬜ | 4.5 ADHD Stimming | ADHD stimming apps | 300-700 | `Create research file at research/pillar-4-sensory-apps/4.5-stimming-apps-research.md using the template, then write cluster article for "ADHD stimming apps" with affirming approach. Save to src/content/pillar-4-sensory-apps/4.5-adhd-stimming-apps.md. Run all gates before finalising.` |
| 51 | ⬜ | 4.6 Sensory Toolkit | Sensory toolkit children | 200-500 | `Create research file at research/pillar-4-sensory-apps/4.6-sensory-toolkit-research.md using the template, then write cluster article for "Sensory toolkit children" with practical ideas. Save to src/content/pillar-4-sensory-apps/4.6-sensory-toolkit.md. Run all gates before finalising.` |
| 52 | ⬜ | 4.7 Sensory Diet | Sensory diet children | 300-600 | `Create research file at research/pillar-4-sensory-apps/4.7-sensory-diet-research.md using the template, then write cluster article for "Sensory diet children" explaining the concept. Save to src/content/pillar-4-sensory-apps/4.7-sensory-diet-children.md. Run all gates before finalising.` |
| 53 | ⬜ | 4.8 Weighted Blankets | Weighted blankets anxiety sleep | 800-1,500 | `Create research file at research/pillar-4-sensory-apps/4.8-weighted-blankets-research.md using the template, then write cluster article for "Weighted blankets anxiety sleep" with evidence-based info. Save to src/content/pillar-4-sensory-apps/4.8-weighted-blankets.md. Run all gates before finalising.` |
| 54 | ⬜ | 4.9 Sensory Home | Sensory friendly home design | 200-500 | `Create research file at research/pillar-4-sensory-apps/4.9-sensory-home-research.md using the template, then write cluster article for "Sensory friendly home design" with room-by-room tips. Save to src/content/pillar-4-sensory-apps/4.9-sensory-friendly-home.md. Run all gates before finalising.` |
| 55 | ⬜ | 4.10 School Accommodations | School sensory accommodations | 300-700 | `Create research file at research/pillar-4-sensory-apps/4.10-school-accommodations-research.md using the template, then write cluster article for "School sensory accommodations" for advocacy. Save to src/content/pillar-4-sensory-apps/4.10-school-sensory-accommodations.md. Run all gates before finalising.` |

---

## Pillar 7: Neurodivergent Parenting (2,000-4,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 56 | ⬜ | HUB: ND Parenting | Neurodivergent parenting | 2,000-4,000 | `Create research file at research/pillar-7-neurodivergent-parenting/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "Neurodivergent parenting" targeting exhausted parents. Save to src/content/pillar-7-neurodivergent-parenting/hub-neurodivergent-parenting.md. Run all gates before finalising.` |
| 57 | ⬜ | 7.1 Parent Burnout | Parent burnout ADHD | 500-1,100 | `Create research file at research/pillar-7-neurodivergent-parenting/7.1-parent-burnout-research.md using the template, then write cluster article for "Parent burnout ADHD" with compassionate approach. Save to src/content/pillar-7-neurodivergent-parenting/7.1-parent-burnout-adhd.md. Run all gates before finalising.` |
| 58 | ⬜ | 7.2 Sleep Deprivation | ADHD parent sleep deprivation | 300-700 | `Create research file at research/pillar-7-neurodivergent-parenting/7.2-sleep-deprivation-research.md using the template, then write cluster article for "ADHD parent sleep deprivation" addressing parent exhaustion. Save to src/content/pillar-7-neurodivergent-parenting/7.2-parent-sleep-deprivation.md. Run all gates before finalising.` |
| 59 | ⬜ | 7.3 Respite Care | Respite care ADHD children | 200-500 | `Create research file at research/pillar-7-neurodivergent-parenting/7.3-respite-care-research.md using the template, then write cluster article for "Respite care ADHD children" with UK resources. Save to src/content/pillar-7-neurodivergent-parenting/7.3-respite-care-adhd.md. Run all gates before finalising.` |
| 60 | ⬜ | 7.4 Co-Parenting | Co-parenting ADHD | 300-700 | `Create research file at research/pillar-7-neurodivergent-parenting/7.4-co-parenting-research.md using the template, then write cluster article for "Co-parenting ADHD" for separated or partnered parents. Save to src/content/pillar-7-neurodivergent-parenting/7.4-co-parenting-adhd.md. Run all gates before finalising.` |
| 61 | ⬜ | 7.5 Parent Therapy | Parent therapy counseling | 400-900 | `Create research file at research/pillar-7-neurodivergent-parenting/7.5-parent-therapy-research.md using the template, then write cluster article for "Parent therapy counseling" (UK spelling: counselling) for parent wellbeing. Save to src/content/pillar-7-neurodivergent-parenting/7.5-parent-therapy.md. Run all gates before finalising.` |
| 62 | ⬜ | 7.6 Community Support | ADHD parenting community support | 300-700 | `Create research file at research/pillar-7-neurodivergent-parenting/7.6-community-support-research.md using the template, then write cluster article for "ADHD parenting community support" with UK groups. Save to src/content/pillar-7-neurodivergent-parenting/7.6-community-support.md. Run all gates before finalising.` |
| 63 | ⬜ | 7.7 Self-Compassion | Self-compassion parents | 300-700 | `Create research file at research/pillar-7-neurodivergent-parenting/7.7-self-compassion-research.md using the template, then write cluster article for "Self-compassion parents" with gentle strategies. Save to src/content/pillar-7-neurodivergent-parenting/7.7-self-compassion-parents.md. Run all gates before finalising.` |
| 64 | ⬜ | 7.8 Self-Care Apps | Parent self-care apps | 300-700 | `Create research file at research/pillar-7-neurodivergent-parenting/7.8-self-care-apps-research.md using the template, then write cluster article for "Parent self-care apps" for overwhelmed parents. Save to src/content/pillar-7-neurodivergent-parenting/7.8-parent-self-care-apps.md. Run all gates before finalising.` |
| 65 | ⬜ | 7.9 Stress Management | Stress management parents | 500-1,100 | `Create research file at research/pillar-7-neurodivergent-parenting/7.9-stress-management-research.md using the template, then write cluster article for "Stress management parents" with practical techniques. Save to src/content/pillar-7-neurodivergent-parenting/7.9-stress-management-parents.md. Run all gates before finalising.` |
| 66 | ⬜ | 7.10 ND Parent ADHD | Neurodivergent parent ADHD | 400-900 | `Create research file at research/pillar-7-neurodivergent-parenting/7.10-nd-parent-research.md using the template, then write cluster article for "Neurodivergent parent ADHD" for parents who are also ND. Save to src/content/pillar-7-neurodivergent-parenting/7.10-neurodivergent-parent-adhd.md. Run all gates before finalising.` |

---

## Pillar 6: Emotional Regulation (1,000-2,000 monthly searches)

| # | Status | Article | Keyword | Volume | Prompt |
|---|--------|---------|---------|--------|--------|
| 67 | ⬜ | HUB: Emotional Regulation | Emotional regulation apps children | 1,000-2,000 | `Create research file at research/pillar-6-emotional-regulation/hub-research.md using the template with all 9 sections, then write hub article (min 3,000 words) for "Emotional regulation apps children" targeting parents. Save to src/content/pillar-6-emotional-regulation/hub-emotional-regulation.md. Run all gates before finalising.` |
| 68 | ⬜ | 6.1 Dysregulation ADHD | Emotional dysregulation ADHD children | 400-800 | `Create research file at research/pillar-6-emotional-regulation/6.1-dysregulation-adhd-research.md using the template, then write cluster article for "Emotional dysregulation ADHD children" with understanding focus. Save to src/content/pillar-6-emotional-regulation/6.1-dysregulation-adhd.md. Run all gates before finalising.` |
| 69 | ⬜ | 6.2 Regulation Autism | Emotional regulation autism | 300-700 | `Create research file at research/pillar-6-emotional-regulation/6.2-regulation-autism-research.md using the template, then write cluster article for "Emotional regulation autism" for autistic children. Save to src/content/pillar-6-emotional-regulation/6.2-emotional-regulation-autism.md. Run all gates before finalising.` |
| 70 | ⬜ | 6.3 Affirmations | Affirmations anxious children | 300-700 | `Create research file at research/pillar-6-emotional-regulation/6.3-affirmations-research.md using the template, then write cluster article for "Affirmations anxious children" with gentle approach. Save to src/content/pillar-6-emotional-regulation/6.3-affirmations-anxious-children.md. Run all gates before finalising.` |
| 71 | ⬜ | 6.4 Mindfulness ADHD | Mindfulness ADHD children | 600-1,200 | `Create research file at research/pillar-6-emotional-regulation/6.4-mindfulness-adhd-research.md using the template, then write cluster article for "Mindfulness ADHD children" with realistic expectations. Save to src/content/pillar-6-emotional-regulation/6.4-mindfulness-adhd-children.md. Run all gates before finalising.` |
| 72 | ⬜ | 6.5 Anger Management | Anger management apps kids | 500-1,100 | `Create research file at research/pillar-6-emotional-regulation/6.5-anger-management-research.md using the template, then write cluster article for "Anger management apps kids" with compassionate framing. Save to src/content/pillar-6-emotional-regulation/6.5-anger-management-apps.md. Run all gates before finalising.` |
| 73 | ⬜ | 6.6 Emotional Vocabulary | Emotional vocabulary children | 300-700 | `Create research file at research/pillar-6-emotional-regulation/6.6-emotional-vocabulary-research.md using the template, then write cluster article for "Emotional vocabulary children" for naming feelings. Save to src/content/pillar-6-emotional-regulation/6.6-emotional-vocabulary.md. Run all gates before finalising.` |
| 74 | ⬜ | 6.7 Self-Compassion Kids | Self-compassion children | 300-700 | `Create research file at research/pillar-6-emotional-regulation/6.7-self-compassion-kids-research.md using the template, then write cluster article for "Self-compassion children" with gentle strategies. Save to src/content/pillar-6-emotional-regulation/6.7-self-compassion-children.md. Run all gates before finalising.` |
| 75 | ⬜ | 6.8 Emotional Resilience | Emotional resilience children | 400-900 | `Create research file at research/pillar-6-emotional-regulation/6.8-resilience-research.md using the template, then write cluster article for "Emotional resilience children" with building capacity. Save to src/content/pillar-6-emotional-regulation/6.8-emotional-resilience.md. Run all gates before finalising.` |
| 76 | ⬜ | 6.9 Breathing Exercises | Breathing exercises kids anxiety | 600-1,200 | `Create research file at research/pillar-6-emotional-regulation/6.9-breathing-exercises-research.md using the template, then write cluster article for "Breathing exercises kids anxiety" with practical techniques. Save to src/content/pillar-6-emotional-regulation/6.9-breathing-exercises-kids.md. Run all gates before finalising.` |
| 77 | ⬜ | 6.10 Coping Strategies | Coping strategies apps kids | 300-700 | `Create research file at research/pillar-6-emotional-regulation/6.10-coping-strategies-research.md using the template, then write cluster article for "Coping strategies apps kids" with toolkit approach. Save to src/content/pillar-6-emotional-regulation/6.10-coping-strategies-apps.md. Run all gates before finalising.` |

---


*Last Updated: 2026-01-29*
