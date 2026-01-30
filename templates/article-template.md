---
# Article Frontmatter
title: "[Article Title - Under 60 characters, front-loaded with keyword]"
pillar: 0
pillarName: "[Pillar Name]"
articleNumber: "[PILLAR or X.X]"
targetKeyword: "[Primary Keyword]"
secondaryKeywords:
  - "[Secondary keyword 1]"
  - "[Secondary keyword 2]"
  - "[Secondary keyword 3]"
metaDescription: "[Question + soft answer format, 140-160 characters, includes primary keyword]"
status: draft
wordCount: 0
minimumWordCount: 3000  # 3000 for hub, 1500 for cluster
dateCreated: "[YYYY-MM-DD]"
dateUpdated: "[YYYY-MM-DD]"
urlSlug: "[lowercase-with-hyphens-under-60-chars-include-keyword]"
---

# [Article Title]

<!--
VOICE ATTRIBUTION NOTE:
Nicola has professional expertise, not personal lived experience as a neurodivergent parent.
- Nicola's voice: "In my years working with families..." / "The families I work with often tell me..."
- Community voice for lived experience: "Parents in our community describe..." / "One mum put it perfectly..."
- Do NOT use first-person parenting stories as Nicola's own

OPENING (First 100-150 words)
- Acknowledge parent's experience/struggle (empathy first)
- Validate that this is common/real
- Include primary keyword naturally in first 2 sentences
- Introduce what article covers

Example opening (using community voice):
"So many parents tell me the same thing: 'I'm exhausted, and I feel like I'm the only one who finds this so hard.' If that sounds familiar, please hear this first: you're not alone. Neurodivergent parenting is uniquely demanding, and in my years working with families, I've seen how isolating it can feel. The fact that you're here looking for support shows how much you care."
-->

[Your empathy-first opening paragraph here. Include primary keyword naturally.]

[Second paragraph introducing what the article covers.]

---

## [H2: First PAA Question as Natural Heading]

<!--
Use PAA questions from research as natural H2/H3 headings throughout.
Example: "What Is Neurodivergent Parenting?" or "Is It Harder to Parent a Neurodivergent Child?"
-->

[Content answering the PAA question. Aim to answer search query in first 300 words of article.]

<!--
FEATURED SNIPPET OPTIMISATION:
- For "what is" questions: Include 40-60 word definition immediately after H2
- For "how to" questions: Use numbered steps with clear action verbs
- For lists: 5-8 bullet points with consistent formatting
- For comparisons: Use tables with clear headers
-->

---

## [H2: Second Major Section - Include Secondary Keyword if Natural]

[Content with research cited warmly]

Research shows that [finding] (Source, Year).

<!--
Warm citation style examples:
- "Research tells us that..."
- "Evidence shows that..."
- "Studies suggest that..."

NOT academic style like:
- "According to Smith et al. (2023)..."
-->

---

## [H2: Another PAA Question as Heading]

[Content addressing the question]

### [H3: Sub-question or Related Topic]

[More detailed content]

---

## [H2: Practical Section with Actionable Content]

<!-- Include 3+ specific examples or numbers -->

Here are some strategies that many parents find helpful:

- **[Strategy 1]:** [Brief explanation with specific detail]
- **[Strategy 2]:** [Brief explanation with specific detail]
- **[Strategy 3]:** [Brief explanation with specific detail]

---

## When Professional Support is Needed

<!-- Always include this section with safe, gentle language -->

Sometimes, the support we need goes beyond what we can manage alone, and that's okay. If you're experiencing [signs], reaching out to a professional can make a real difference.

**UK Resources:**
- Your GP can refer you to appropriate services
- [ADHD UK](https://adhduk.co.uk/) offers support and resources
- [NHS mental health services](https://www.nhs.uk/mental-health/)

You know your child best. Trust your instincts about when extra support would help.

---

## Key Takeaways

<!-- 2-3 bullet points summarising the main messages -->

- [Key message 1 - validation or reassurance]
- [Key message 2 - practical insight]
- [Key message 3 - hope or encouragement]

---

<!--
CLOSING
- Reassurance and validation
- "You know your child best"
- Gentle CTA: "Explore the Sound Sanctuary"
-->

[Reassurance paragraph acknowledging the reader's journey]

You know your child best, and finding what works for your family is a process, not a destination. If you're looking for gentle support that meets your child where they are, [Explore the Sound Sanctuary].

---

<!--
INTERNAL LINKING CHECKLIST
- [ ] 4-8 internal links woven naturally throughout
- [ ] Use [LINK TO: Article Title] for unpublished articles
- [ ] Link to related cluster articles in same pillar
- [ ] Link to hub article for the pillar
- [ ] Link to Sound Sanctuary in closing CTA

EXTERNAL LINKING CHECKLIST
- [ ] 2-4 external links to UK authoritative sources only
- [ ] NHS, ADHD UK, NICE guidelines, BPS, RCP (no US sources)
- [ ] Woven into content, not listed separately
-->

---

<!--
SIGNATURE PHRASES TO INCLUDE (use 3-5 naturally)
- [ ] "big feelings"
- [ ] "soft place to land"
- [ ] "feel safe in their body"
- [ ] "children who feel everything"
- [ ] "Sound Sanctuary"
- [ ] "gentle sound support"
- [ ] "mum"
- [ ] "you know your child best"
-->

---

<!--
BEFORE SAVING

Run gate scripts from: .claude/scripts/

1. Pre-flight check during writing:
   .claude/scripts/quick-check.sh [article-file]

2. Content Gate (after /seo-content):
   .claude/scripts/master-gate.sh [article-file] [hub|cluster] --summary
   Re-runs with diff: --diff --summary (shows FIXED/STILL FAILING/NEW)

3. Conversion Gate (after /direct-response-copy):
   .claude/scripts/check-conversion-gate.sh [article-file] --summary
   Re-runs with diff: --diff --summary

4. Final Gate (before export):
   .claude/scripts/check-final-gate.sh [article-file] [hub|cluster]

See .claude/agents.md for full 6-gate workflow.
See .claude/rules/humanise-rules.md for all content rules.
-->
