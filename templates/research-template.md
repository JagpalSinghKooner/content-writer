---
# Research File Metadata
articleTitle: "[Article Title from Keywords Table]"
pillar: 0
pillarName: "[Pillar Name]"
articleNumber: "[PILLAR or X.X]"
contentFile: "[relative path to content file]"
researchStatus: incomplete
gateStatus: locked
dateCreated: "[YYYY-MM-DD]"
dateCompleted: null
researcher: "[Name or Claude]"

# Content Rules Reference
# All content rules: .claude/rules/humanise-rules.md
# Gate verification: .claude/scripts/ (run gates in order)

# Keyword Research (validated by Perplexity MCP)
keywordStatus: pending
perplexityUsed: false
perplexityDate: null
targetKeyword: null
searchTrend: null
searchVolume: null

secondaryKeywords:
  # Minimum 5 required - populated by /keyword-research skill
  # - "[keyword 1]"

# PAA Questions (from Perplexity Query 2 - minimum 7 required)
paaQuestions:
  # - "[Question 1]"

# Competitor Gaps (from Perplexity Query 3 - minimum 2 required)
competitorGaps:
  # - "[Gap 1]"

# Research Sources (from Perplexity Query 4 - minimum 2 required)
researchSources:
  # - source: "[Source name]"
  #   year: [YYYY]
  #   finding: "[Key finding]"
  #   url: "[URL]"
---

# Research: [Article Title]

## Gate Check Status

**Research Status:** [ ] Incomplete / [ ] Complete
**Gate Status:** [ ] Locked / [ ] Unlocked

### Mandatory Fields Checklist

**STEP 1: Run /keyword-research skill with Perplexity MCP (populates Sections 1, 3, 4, 5, 8)**

Before article writing can begin, ALL of the following must be marked complete:

- [ ] **Perplexity MCP Used** (frontmatter: perplexityUsed: true)
- [ ] **Target Keyword Data** (Section 1) - from Perplexity Query 1
- [ ] **Search Intent Analysis** (Section 2) - manual review
- [ ] **SERP Analysis** (Section 3) - from Perplexity Query 3
- [ ] **Competitor Gap Analysis** (Section 4) - from Perplexity Query 3
- [ ] **People Also Ask Questions** (Section 5) - from Perplexity Query 2
- [ ] **E-E-A-T Planning** (Section 6) - manual planning
- [ ] **HushAway® Positioning Angle** (Section 7) - from `/positioning-angles` skill (Step 4)
- [ ] **Source Collection** (Section 8) - from Perplexity Query 4

**Keyword Gate checks (run after /keyword-research):**
- `keywordStatus: validated`
- `perplexityUsed: true`
- `perplexityDate: [date]`
- `searchTrend: [rising/stable/declining]` (recommended)
- PAA questions: 7+ required
- Competitor gaps: 2+ required
- Research sources: 2+ required

**Research Gate checks (run after completing all sections):**
- `researchStatus: complete`
- `gateStatus: unlocked`
- `dateCompleted: [today's date]`

---

## Section 1: Target Keyword Data

**Status:** [ ] Complete

### Primary Keyword

| Field | Value |
|-------|-------|
| Keyword | [primary keyword] |
| Monthly Search Volume | [X,XXX-X,XXX] |
| Keyword Difficulty | [Low/Medium/High] |
| Search Intent | [Informational/Commercial/Transactional] |

### Secondary Keywords (3-5)

| Keyword | Search Volume | Include In |
|---------|---------------|------------|
| [keyword 1] | [volume] | [H2/Intro/FAQ] |
| [keyword 2] | [volume] | [H2/Intro/FAQ] |
| [keyword 3] | [volume] | [H2/Intro/FAQ] |
| [keyword 4] | [volume] | [H2/Intro/FAQ] |
| [keyword 5] | [volume] | [H2/Intro/FAQ] |

### Long-tail Variations

- [variation 1]
- [variation 2]
- [variation 3]

---

## Section 2: Search Intent Analysis

**Status:** [ ] Complete

### Primary Intent

**Intent Type:** [Informational / Commercial / Transactional]

**User's Core Question:**
> [What is the searcher really trying to find out or accomplish?]

**User's Emotional State:**
> [Exhausted parent seeking validation? Frustrated and looking for solutions? Researching options?]

**What They Need to Feel:**
- Seen: [How will we show we understand?]
- Supported: [How will we validate their experience?]
- Informed: [What knowledge will we provide?]
- Empowered: [What can they do with this information?]
- Hopeful: [What hope can we offer?]

### Content Format Match

Based on intent, this article should be:
- [ ] Comprehensive guide (pillar hub)
- [ ] How-to tutorial
- [ ] Comparison/review
- [ ] Listicle
- [ ] Definition/explainer

---

## Section 3: SERP Analysis

**Status:** [ ] Complete
**Data Source:** Perplexity MCP (Query 3)

**Date Analysed:** [YYYY-MM-DD]
**Search Query Used:** "[exact query]"

> **Note:** This section is auto-populated by Perplexity Query 3 during /keyword-research. Review and expand as needed.

### Top 5 Ranking Results

#### Result 1: [Title]
- **URL:** [url]
- **Word Count:** [approximate]
- **Content Type:** [guide/listicle/etc.]
- **Publish/Update Date:** [date if visible]
- **What They Do Well:** [specific strengths]
- **What They Miss:** [gaps or weaknesses]
- **HushAway® Opportunity:** [how we can be better]

#### Result 2: [Title]
- **URL:** [url]
- **Word Count:** [approximate]
- **Content Type:** [type]
- **What They Do Well:** [strengths]
- **What They Miss:** [gaps]
- **HushAway® Opportunity:** [opportunity]

#### Result 3: [Title]
- **URL:** [url]
- **Word Count:** [approximate]
- **Content Type:** [type]
- **What They Do Well:** [strengths]
- **What They Miss:** [gaps]
- **HushAway® Opportunity:** [opportunity]

#### Result 4: [Title]
- **URL:** [url]
- **Word Count:** [approximate]
- **Content Type:** [type]
- **What They Do Well:** [strengths]
- **What They Miss:** [gaps]
- **HushAway® Opportunity:** [opportunity]

#### Result 5: [Title]
- **URL:** [url]
- **Word Count:** [approximate]
- **Content Type:** [type]
- **What They Do Well:** [strengths]
- **What They Miss:** [gaps]
- **HushAway® Opportunity:** [opportunity]

### SERP Features Present

- [ ] Featured Snippet (type: [paragraph/list/table])
- [ ] People Also Ask
- [ ] AI Overview
- [ ] Video carousel
- [ ] Image pack
- [ ] Knowledge panel

### Featured Snippet Opportunity

**Current Snippet Holder:** [URL or "None"]
**Snippet Format:** [paragraph/list/table]
**Content to Win Snippet:**
> [What specific content would capture the snippet?]

---

## Section 4: Competitor Gap Analysis

**Status:** [ ] Complete
**Data Source:** Perplexity MCP (Query 3)

> **Note:** Initial gaps come from Perplexity Query 3 (stored in frontmatter competitorGaps). Expand with specific positioning below.

### What Competitors Are Missing

| Gap | Opportunity for HushAway® | Where to Position in Article |
|-----|--------------------------|------------------------------|
| [Gap 1] | [How we fill this gap] | [Which H2 section] |
| [Gap 2] | [How we fill this gap] | [Which H2 section] |
| [Gap 3] | [How we fill this gap] | [Which H2 section] |
| [Gap 4] | [How we fill this gap] | [Which H2 section] |

### What's Outdated in Existing Content

- [Outdated information 1]
- [Outdated information 2]

### What's Generic That We Can Make Specific

| Generic Advice (Competitors) | Specific HushAway® Approach |
|------------------------------|----------------------------|
| [Generic advice 1] | [Neurodivergent-specific approach] |
| [Generic advice 2] | [HushAway® angle] |

### Our Unique Edge

> [What can ONLY HushAway® say about this topic? What's our proprietary advantage?]

---

## Section 5: People Also Ask Questions

**Status:** [ ] Complete
**Data Source:** Perplexity MCP (Query 2)

**Source:** Google SERP + Reddit + Mumsnet (via Perplexity)
**Date Captured:** [YYYY-MM-DD]

> **Note:** Questions come from Perplexity Query 2 (stored in frontmatter paaQuestions). Expand with answer approaches below.

### PAA Questions (Minimum 7)

1. **Q:** [Question 1]
   **Answer Approach:** [Brief note on how to answer in HushAway® voice]

2. **Q:** [Question 2]
   **Answer Approach:** [Brief note]

3. **Q:** [Question 3]
   **Answer Approach:** [Brief note]

4. **Q:** [Question 4]
   **Answer Approach:** [Brief note]

5. **Q:** [Question 5]
   **Answer Approach:** [Brief note]

### Additional Questions from Research

- [Related question from Reddit/forums]
- [Related question from parent communities]
- [Related question from existing content comments]

---

## Section 6: E-E-A-T Planning

**Status:** [ ] Complete

### Experience Signals

**How will we demonstrate first-hand experience?**

- [ ] Nicola's personal story/example relevant to this topic:
  > [Specific anecdote or experience to include]

- [ ] Parent community insight:
  > [Real experience from parent forums/communities]

- [ ] Specific scenario showing lived understanding:
  > [Relatable situation that shows we've been there]

### Expertise Signals

**How will we demonstrate knowledge depth?**

- [ ] Research/studies to cite (minimum 2):
  1. [Study/source 1 with key finding]
  2. [Study/source 2 with key finding]
  3. [Study/source 3 - optional]

- [ ] Expert perspective to reference:
  > [e.g., occupational therapists, sleep specialists, etc.]

- [ ] Technical accuracy points:
  - [Fact to verify and include]
  - [Mechanism to explain accurately]

### Authoritativeness Signals

**How will we establish authority?**

- [ ] Internal links to related HushAway® content (4-8):
  1. [Related article 1]
  2. [Related article 2]
  3. [Related article 3]
  4. [Related article 4]

- [ ] External links to UK authoritative sources only (2-4):
  1. [UK authority site 1 - e.g., NHS, ADHD UK, NICE, BPS, RCP]
  2. [UK authority site 2]
  3. [UK authority site 3]

### Trust Signals

**How will we build trust?**

- [ ] Acknowledgement of limitations:
  > [What this article doesn't cover / when to seek professional help]

- [ ] Transparency about approach:
  > [Why we recommend what we recommend]

- [ ] Parent-to-parent validation:
  > [Specific validation statement for exhausted parents]

---

## Section 7: HushAway® Positioning Angle

**Status:** [ ] Complete
**Data Source:** `/positioning-angles` skill

> **IMPORTANT:** Angles are generated dynamically by the `/positioning-angles` skill (Step 4).
> Do NOT select from a static list. Run the skill to generate article-specific angles.
> Check `.claude/angle-library.md` BEFORE running the skill to avoid reusing angles.

### From /positioning-angles Skill Output

After running the skill, document the selected angle here:

**Selected Angle Name:** [From skill output]

**Angle Description (one sentence):**
> [Core insight from skill output]

**Headline Direction:**
> [Example headline from skill output]

### Differentiation Hook

**Generic Competitor Approach:**
> [How competitors typically cover this topic - from research]

**HushAway® Hook:**
> [Our unique angle that differentiates this article - from skill output]

### Signature Phrases to Include

Check which signature phrases fit naturally in this article:

- [ ] "Big feelings"
- [ ] "Soft place to land"
- [ ] "Feel safe in their body"
- [ ] "Children who feel everything"
- [ ] "Sound Sanctuary"
- [ ] "Gentle sound support"
- [ ] "You know your child best"
- [ ] "You're not alone in this"

### Brand Prominence Planning

**IMPORTANT:** HushAway® articles are content marketing. HushAway® should be prominently positioned throughout, not just mentioned once at the end.

**Minimum requirements:**
- [ ] HushAway® mentioned in introduction (within first 500 words)
- [ ] HushAway® positioning in at least 50% of H2 sections
- [ ] Each competitor category closes with HushAway® comparison statement
- [ ] Comparison table or clear differentiation section included

**HushAway® positioning by section:**

| H2 Section | HushAway® Counter-Position |
|------------|---------------------------|
| [Section 1 title] | [How HushAway® offers something different/better] |
| [Section 2 title] | [HushAway® positioning statement] |
| [Section 3 title] | [HushAway® positioning statement] |
| [Section 4 title] | [HushAway® positioning statement] |

**Introduction HushAway® mention:**
> [Draft the callout or paragraph that introduces HushAway®'s different approach early in the article]

**Comparison element for closing:**
- [ ] Table comparing HushAway® to competitor approaches
- [ ] Checklist showing HushAway® advantages
- [ ] Side-by-side comparison

---

## Section 8: Source Collection

**Status:** [ ] Complete
**Data Source:** Perplexity MCP (Query 4)

> **Note:** Initial sources come from Perplexity Query 4 (stored in frontmatter researchSources). Expand with warm citation formats below. Also check `/research/eeat-library.md` for existing verified citations.

### Research Sources (Minimum 3)

All sources must include: Source name, Year, Verifiable link, and Warm citation format.

| Source Name | Year | Link | Key Finding | How to Cite (Warm) |
|-------------|------|------|-------------|-------------------|
| [e.g., Cleo Family Health Index] | [2024] | [URL] | [e.g., 65% of parents at higher burnout risk] | [e.g., "According to the Cleo Family Health Index, 65% of parents of neurodivergent children are at higher risk for burnout."] |
| [Source 2] | [Year] | [URL] | [Finding] | [Warm citation] |
| [Source 3] | [Year] | [URL] | [Finding] | [Warm citation] |

**Source Quality Checklist:**
- [ ] Peer-reviewed journal, government source, or recognised organisation?
- [ ] Published within last 5 years (2020+)?
- [ ] Link verified and accessible?
- [ ] Added to E-E-A-T library for reuse?

### Statistics to Include

| Statistic | Source | Year | Link | Where to Use |
|-----------|--------|------|------|--------------|
| [e.g., 35-70% of ADHD children have sleep difficulties] | [PMC Review] | [2024] | [URL] | [Opening/Sleep section] |
| [Statistic 2] | [Source] | [Year] | [URL] | [Context] |

### Expert Quotes or Perspectives

| Expert | Credentials | Quote/Insight | How to Reference |
|--------|-------------|---------------|------------------|
| [Name] | [Title/credentials] | [Relevant quote or insight] | [Warm reference approach] |
| Nicola Maria Rose | Certified ND Coach, Sound Therapy Practitioner | [Relevant insight for this topic] | [As founder voice throughout] |

### Parent Community Insights

**Source:** [Reddit r/ADHD_parents, Facebook groups, forums]

Capture real language parents use (helps with relatability and long-tail keywords):

- [Insight 1: What real parents say about this topic]
- [Insight 2: Common struggles mentioned]
- [Insight 3: What actually helps according to parents]

### After Completing This Section

- [ ] Added any new findings to `/research/eeat-library.md`
- [ ] All statistics have verifiable sources
- [ ] Warm citation format written for each source

---

## Section 9: Content Outline (Optional)

**Status:** [ ] Complete (recommended for hub articles)

### Proposed H2 Structure

Based on research above, the article should cover:

1. **H2:** [Section title with keyword]
   - Key points to cover:
   - Research to include:

2. **H2:** [PAA question from Section 5 as natural heading]
   - Key points:
   - Research:

3. **H2:** [Another PAA question as heading]
   - Key points:
   - Research:

4. **H2:** When Professional Support is Needed
   - Safe language for referrals
   - Types of professionals to mention

5. **H2:** Key Takeaways
   - 3 bullet points summarising article

**NOTE:** PAA questions from Section 5 should become natural H2/H3 headings throughout the article. Do NOT create a separate FAQ section at the bottom.

### Internal Linking Strategy

**Important:** Links should be woven naturally into content, not listed in a separate section.

For articles not yet published, use placeholder format: `[LINK TO: Article Title]`

| Link To | Anchor Text | Placement |
|---------|-------------|-----------|
| [Related article 1] | [Natural anchor text] | [Which section] |
| [Related article 2] | [Anchor text] | [Section] |
| Sound Sanctuary | "Explore the Sound Sanctuary" | Closing CTA |

**Placeholder example:**
"If burnout feels familiar, you're not alone [LINK TO: Recognising Parent Burnout]."

---

## Research Completion Sign-Off

### Final Checklist

Before marking research complete:

- [ ] All 8 mandatory sections have status "Complete"
- [ ] At least 3 research sources collected
- [ ] At least 5 PAA questions documented
- [ ] Positioning angle selected and differentiation hook defined
- [ ] E-E-A-T signals planned for all four categories
- [ ] SERP analysis is less than 30 days old
- [ ] Brand prominence planned (HushAway® in intro + 50% of H2 sections)
- [ ] HushAway® counter-position defined for each competitor category

### Sign-Off

**Research Completed By:** [Name/Claude]
**Date Completed:** [YYYY-MM-DD]
**Gate Status:** UNLOCKED - Ready for article writing

---

## Notes

[Any additional notes, thoughts, or considerations for the article writer]
