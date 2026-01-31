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
| 1. Keyword (V3) | `check-keyword-gate-v3.sh [research]` | After /keyword-research |
| 2. Research | `check-research-gate.sh [research]` | After research complete |
| 3. Angle | `check-angle-gate.sh [research]` | After /positioning-angles |
| Pre-flight | `quick-check.sh [article]` | During /seo-content writing |
| 4. Content | `master-gate.sh [article] [hub\|cluster] --summary` | After /seo-content |
| 5. Conversion | `check-conversion-gate.sh [article] --summary` | After /direct-response-copy |
| 6. Final | `check-final-gate.sh [article] [hub\|cluster]` | Before export |

**ALL 6 GATES MUST PASS. NO EXCEPTIONS.**

### Keyword Validation V3

The V3 keyword system includes:
- **Pre-API filters:** Brand alignment, negative/rejected keyword checks (saves API costs)
- **Mandatory APIs:** Both DataForSEO AND Perplexity MCP required
- **Intent-tiered volume floors:** 50 (transactional), 100 (commercial), 200 (info+product), 500 (informational)
- **Opportunity scoring:** Formula-based score must be 15+ to pass
- **Supporting libraries:** `.claude/negative-keywords.md`, `.claude/rejected-keywords.md`
- **Full spec:** `KEYWORD-VALIDATION-SYSTEM-V2.md`

### Script Flags

| Flag | Purpose | When to Use |
|------|---------|-------------|
| `--summary` | Compact output (~80% fewer tokens) | Default for gate runs |
| `--remediate` | Shows failures only | 2nd+ runs after fixing |
| `--fail-fast` | Stops after 3 failures | When many failures expected |
| `--diff` | Shows FIXED/STILL FAILING/NEW between runs | Iterative fixing sessions |

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

**Sound Library (Mandatory Reference):**
`HushAway.md` contains the complete sound library with all product series, usage contexts, and terminology. Content skills MUST reference this for accurate product descriptions.

**Note:** Product series names are internal references. CTAs always direct to the Sound Sanctuary, not specific products.

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

**Full requirements:** See `.claude/rules/humanise-rules.md` Section 9 for citation style, format examples, and UK-approved sources.

**Quick reference:**
- Use warm format: "Research from 2024 found..." (not academic style)
- Always include the year in citations
- UK sources only: NHS, ADHD UK, NICE, BPS, RCP, gov.uk, PubMed

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
5. Run `/positioning-angles` (generates options; writer selects before Angle Gate)
6. Run `/seo-content` (with `quick-check.sh` after each section) → Content Gate
7. Run `/direct-response-copy` → Conversion Gate
8. Final Gate → Export

**Pre-flight validation:** Run `quick-check.sh [article]` during writing to catch 80% of failures early.

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
/.claude/keyword-library.md             - Validated keywords (V3 schema)
/.claude/negative-keywords.md           - Blocked keywords (brand conflicts, medical, off-topic)
/.claude/rejected-keywords.md           - Failed keywords with revisit strategies
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

### Live Data (API Integration)

**Both APIs are MANDATORY in V3.** Keywords cannot be validated without both.

**Perplexity MCP** (MANDATORY) - Provides PAA questions, competitor analysis, research sources, trends.

```bash
claude mcp add perplexity --env PERPLEXITY_API_KEY=<your-key>
```

**DataForSEO API** (MANDATORY in V3) - Provides exact search volumes, keyword difficulty scores, CPC.

Create `.env` file in project root:
```
DATAFORSEO_LOGIN=your_login_here
DATAFORSEO_PASSWORD=your_password_here
```

**V3 Change:** DataForSEO is no longer optional. Both APIs must succeed for keyword validation to pass.

**Full spec:** `KEYWORD-VALIDATION-SYSTEM-V2.md`
