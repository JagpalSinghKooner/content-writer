# HushAway®: Local Article Writing Environment

This is a local development folder for writing and previewing SEO articles. Articles created here will be copied to the main HushAway® website.

**Purpose:** Write high-quality SEO content and visually preview it before publishing to the main site.

---

## Quick Reference (Critical Rules)

### NEVER Use
- "HushAway" without the ® symbol (always write HushAway®)
- Emojis (anywhere, ever)
- Em-dashes (use commas, full stops, or semicolons instead)
- American English (always UK: colour, behaviour, mum, organisation, recognise)
- Deficit language: "fix," "cure," "normal," "suffering from," "special needs"
- Clinical terms: "disorder," "patient," "treatment," "symptoms"
- AI-isms: "delve," "landscape," "leverage," "comprehensive," "robust," "crucial," "vital," "navigate"

### ALWAYS Include
- HushAway® (every instance, never just "HushAway" - URLs like hushaway.com are exempt)
- UK English spelling and terminology
- Primary keyword in first 100-150 words
- Empathy before solutions (acknowledge parent struggle first)
- Signature phrases: "big feelings," "soft place to land," "feel safe in their body"

---

## Content Rules (Single Source of Truth)

**All content rules:** `.claude/rules/humanise-rules.md`

This file contains all banned words, frequency limits, structural rules, conversion language, and thresholds. Skills MUST read it before writing.

---

## 6-Gate Verification

| Gate | Script | When |
|------|--------|------|
| 1. Keyword | `check-keyword-gate.sh` | After /keyword-research |
| 2. Research | `check-research-gate.sh` | After research complete |
| 3. Angle | `check-angle-gate.sh` | After /positioning-angles |
| 4. Content | `master-gate.sh` | After /seo-content |
| 5. Conversion | `check-conversion-gate.sh` | After /direct-response-copy |
| 6. Final | `check-final-gate.sh` | Before export |

**ALL 6 GATES MUST PASS. NO EXCEPTIONS.**

---

## Brand Voice

HushAway® sounds like a warm, understanding friend who has been there, knows what it is like to parent a child with big feelings, and wants to share what actually helps. Gentle but credible. Soft but confident. Empathetic but never clinical. Parent-to-parent, never expert-to-patient.

**Core traits:**
1. Gentle confidence: Soft delivery backed by research
2. Empathetic understanding: Validates struggle before offering solutions
3. Neurodiversity-affirming: Support not "fix", celebrate neurodivergence
4. Supportive ally: Relatable, real, honest about what is hard

### Voice Attribution

**Nicola has professional expertise, not personal lived experience as a neurodivergent parent.**

- Nicola: "The families I work with often tell me..." / "In my years running a nursery..."
- Community: "Parents in our community describe..." / "One mum put it perfectly..."

---

## HushAway® Product

**Website:** hushaway.com

**What is HushAway®?**
A sound therapy platform (mobile app + web app) designed specifically for neurodivergent children, with a free forever tier.

**Pricing Model:**
- **Free Forever:** Full access to the Sound Sanctuary
- **Sign-up:** Name + email → magic link (no password required)

**Sound Types:**
- Sleep soundscapes (ambient sounds, white noise, nature sounds)
- ASMR content (gentle sounds for sensory comfort)
- Binaural beats (frequency-based sounds for focus or calm)
- Guided content (narrated meditations, stories, breathing exercises)

**What Makes It Neurodivergent-Specific:**
- Sensory-friendly design: No sudden sounds, predictable patterns
- Created by a Certified Neurodivergent Inclusive Coach
- Sounds specifically chosen for sensory processing differences

**Key Pages:**
- About Nicola: hushaway.com/about
- Sound Sanctuary: hushaway.com/sound-sanctuary (CTA destination)
- Blog: hushaway.com/blog

---

## Signature Phrases

**Use these naturally:**
- "Big feelings" (instead of "emotions" or "meltdowns")
- "Soft place to land" (safe space metaphor)
- "Feel safe in their body" (sensory safety)
- "Children who feel everything" (empowering framing)
- "Sound Sanctuary" (brand concept and CTA destination)
- "Gentle sound support" (what we offer)
- "Mum" (not "mom", UK English)
- "You know your child best"

---

## Content Requirements

**All thresholds and requirements:** See `.claude/rules/humanise-rules.md` Section 7

### Article Structure
**Opening (First 100-150 words):**
1. Acknowledge parent's experience/struggle (empathy first)
2. Validate that this is common/real
3. Introduce what article covers
4. Include primary keyword naturally

**Closing:**
1. Summarise key takeaways (2-3 main points)
2. Offer reassurance and validation
3. Gentle CTA: "Explore the Sound Sanctuary"

---

## E-E-A-T and Citations

**E-E-A-T is essential for ranking.**

### Citation Style (Warm, Not Academic)

**Good examples:**
- "Research from 2024 found that parents of children with ADHD are more than four times more likely to experience depression."
- "A large Swedish study found that children with ADHD are eight times more likely to have a sleep disorder."

**NOT:**
- "According to a study published in the Journal of Sleep Research (Smith et al., 2023)..."

### Requirements
See `.claude/rules/humanise-rules.md` Section 7 for citation, quote, and link requirements.

### UK-Approved Sources
NHS, ADHD UK, NICE guidelines, British Psychological Society, Royal College of Psychiatrists, gov.uk, PubMed

---

## Internal Linking

**Links woven naturally into content**, not listed at the bottom.

**Placeholder convention:**
```
[LINK TO: Article Title]
```

**What to link to:**
- Related cluster articles in same pillar
- Hub article for the pillar
- Relevant articles in other pillars
- Sound Sanctuary page (closing CTA)

---

## Article Workflow

**Full workflow:** `.claude/agents.md`

**Quick Start:**
1. Select article from `ARTICLE-ORDER.md`
2. Run `/keyword-research` → Keyword Gate
3. Complete research → Research Gate
4. Run `generate-research-summary.sh`
5. Run `/positioning-angles` → Angle Gate
6. Run `/seo-content` → Content Gate
7. Run `/direct-response-copy` → Conversion Gate
8. Final Gate → Export

**Skills read context files:** `.claude/context/[skill]-context.md`

---

## File Structure

```
/src/content/pillar-[N]-[topic-name]/   - Article markdown files
/research/pillar-[N]-[topic-name]/      - Research files
/templates/                              - Quality checklist and research template
/.claude/skills/                         - Marketing skills
/.claude/context/                        - Skill-specific context files
/.claude/rules/                          - Authoritative rules (single source of truth)
```

---

## URL Structure

**Format:** `/blog/[pillar-keyword]/[article-slug]`

**Rules:**
- All lowercase
- Hyphens between words (no underscores)
- No stop words unless essential
- Include primary keyword
- See `.claude/rules/humanise-rules.md` for character limits

---

## Skills Available

### Entry Point
**`/orchestrator`** - Marketing strategist that diagnoses needs and routes to skills

### Article Workflow (Mandatory Order)
1. `/keyword-research` → Keyword Gate
2. `/positioning-angles` → Angle Gate
3. `/seo-content` → Content Gate
4. `/direct-response-copy` → Conversion Gate

### Other Skills
`/brand-voice`, `/email-sequences`, `/content-atomizer`, `/newsletter`, `/lead-magnet`

### Live Data (MCP)
**Perplexity MCP** is mandatory for keyword research. Provides PAA questions, competitor analysis, research sources.

```bash
claude mcp add perplexity --env PERPLEXITY_API_KEY=<your-key>
```
