# Client Profile Requirements

Which profile fields each skill needs. Use this to ensure the right information is captured before running any skill.

---

## Quick Reference Matrix

| Skill | Company | Product | Audience | Competitors | Brand Voice | Content Rules | Conversion | Goals |
|-------|:-------:|:-------:|:--------:|:-----------:|:-----------:|:-------------:|:----------:|:-----:|
| keyword-research | Required | Required | Required | Required | - | - | Optional | Required |
| start-pillar | Optional | Required | Required | Required | - | - | - | Required |
| positioning-angles | - | Required | Required | Required | Optional | - | - | Required |
| seo-content | Optional | Required | Required | - | Required | Required | Required | Optional |
| direct-response-copy | Optional | Required | Required | Optional | Required | Required | Required | Required |
| email-sequences | Optional | Required | Required | - | Required | Required | Required | Required |
| newsletter | - | Required | Required | - | Required | Required | Optional | - |
| lead-magnet | Optional | Required | Required | - | - | - | Required | Required |
| content-atomizer | - | Optional | Optional | - | Required | Required | Optional | - |
| validate-content | - | Optional | - | Optional | Required | Required | - | - |

**Legend:**
- **Required** — Skill will fail or produce poor results without this
- **Optional** — Improves output but skill can run without it
- **-** — Not used by this skill

---

## Detailed Breakdowns by Skill

### keyword-research

**Purpose:** Transform business context into a prioritised content plan with keyword clusters.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Required | Industry and business type determine keyword categories and competitive landscape |
| **Product/Service** | Required | Core offering and problem solved generate seed keywords for expansion |
| **Target Audience** | Required | Who you're reaching determines search intent and keyword modifiers |
| **Competitors** | Required | Competitor URLs needed for competitive analysis and gap identification |
| **Brand Voice** | - | Not relevant to keyword selection |
| **Content Rules** | - | Not relevant to keyword selection |
| **Conversion Elements** | Optional | Understanding CTAs helps identify commercial-intent keywords |
| **Goals** | Required | Content goals (traffic, leads, sales) determine keyword prioritisation |

**If missing required fields:**
- Without Company: Can't assess industry competition or business context
- Without Product/Service: No seed keywords, can't generate meaningful clusters
- Without Target Audience: Keywords may target wrong search intent
- Without Competitors: Can't validate pillar opportunities or identify gaps
- Without Goals: Can't prioritise keywords by business value

---

### start-pillar

**Purpose:** Extract a single pillar from keyword research and create an actionable brief with competitor analysis.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Optional | Helps identify proprietary advantage for positioning |
| **Product/Service** | Required | Unique angle and expertise determine content differentiation |
| **Target Audience** | Required | Content plan must align with who will read it |
| **Competitors** | Required | Deep competitor analysis is core to this skill |
| **Brand Voice** | - | Not directly used (voice comes later in seo-content) |
| **Content Rules** | - | Not directly used at planning stage |
| **Conversion Elements** | - | Not directly used at planning stage |
| **Goals** | Required | Strategic context ("why this pillar, why now") requires goal alignment |

**If missing required fields:**
- Without Product/Service: Can't identify what makes your content different
- Without Target Audience: Content plan may target wrong reader
- Without Competitors: Can't identify gaps or angle opportunities
- Without Goals: Can't explain strategic rationale for pillar

---

### positioning-angles

**Purpose:** Find the angle that makes content sell. Develops unified positioning across an entire pillar.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | - | Not directly used (covered by Product/Service) |
| **Product/Service** | Required | Transformation and mechanism are raw material for angles |
| **Target Audience** | Required | Understanding what they believe and want shapes angle selection |
| **Competitors** | Required | Competitive landscape determines which angles are available |
| **Brand Voice** | Optional | Can help refine angle expression, but not core to finding angles |
| **Content Rules** | - | Not relevant to angle discovery |
| **Conversion Elements** | - | Not directly used (angles are about positioning, not CTAs) |
| **Goals** | Required | What you're ultimately selling informs angle direction |

**If missing required fields:**
- Without Product/Service: No transformation to position, no mechanism to differentiate
- Without Target Audience: Angles may not resonate with actual readers
- Without Competitors: May choose angles already claimed by others
- Without Goals: Angles may not lead toward conversion

---

### seo-content

**Purpose:** Create publication-ready SEO content that ranks AND reads like a human wrote it.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Optional | Author credentials for E-E-A-T signals |
| **Product/Service** | Required | Content must accurately represent what you offer |
| **Target Audience** | Required | Writing level, examples, and tone must match reader |
| **Competitors** | - | Already handled in start-pillar research phase |
| **Brand Voice** | Required | Ensures content sounds human and matches brand |
| **Content Rules** | Required | Terminology, avoided words, and style requirements |
| **Conversion Elements** | Required | CTAs and internal links needed in content |
| **Goals** | Optional | Helps with CTA selection but not critical |

**If missing required fields:**
- Without Product/Service: Content may misrepresent offerings
- Without Target Audience: Tone and examples may miss the mark
- Without Brand Voice: Content sounds generic or AI-generated
- Without Content Rules: May use wrong terminology or banned words
- Without Conversion Elements: No CTAs, missing lead magnets to reference

---

### direct-response-copy

**Purpose:** Write copy that converts. Used for landing pages, emails, sales copy, and persuasive content.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Optional | Founder story adds credibility and humanises the pitch |
| **Product/Service** | Required | Transformation and mechanism drive all copy angles |
| **Target Audience** | Required | Pain points, desires, and objections shape messaging |
| **Competitors** | Optional | Alternatives help with positioning against the "do nothing" option |
| **Brand Voice** | Required | Copy must sound like the brand, not generic marketing |
| **Content Rules** | Required | Terminology and style must be consistent |
| **Conversion Elements** | Required | CTAs, testimonials, and social proof are essential |
| **Goals** | Required | Conversion goal determines copy intensity and CTA type |

**If missing required fields:**
- Without Product/Service: No transformation to sell, copy falls flat
- Without Target Audience: Can't quantify pain or speak to desires
- Without Brand Voice: Copy sounds like every other sales page
- Without Content Rules: May use wrong terminology or style
- Without Conversion Elements: No CTAs or proof to close
- Without Goals: Don't know if this is soft CTA or hard sell

---

### email-sequences

**Purpose:** Build email sequences that convert subscribers into customers.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Optional | Company story can build credibility in connection emails |
| **Product/Service** | Required | Price point affects trust-building required, offer details needed |
| **Target Audience** | Required | Objections and desires shape email content |
| **Competitors** | - | Not directly relevant to email sequences |
| **Brand Voice** | Required | Email voice must match brand personality |
| **Content Rules** | Required | Terminology must be consistent across emails |
| **Conversion Elements** | Required | Lead magnets, CTAs, and offers are core to sequences |
| **Goals** | Required | Sequence type (welcome, nurture, conversion) depends on goals |

**If missing required fields:**
- Without Product/Service: Can't bridge from lead magnet to paid offer
- Without Target Audience: Can't address objections or speak to desires
- Without Brand Voice: Emails sound generic, lose personality
- Without Content Rules: Inconsistent terminology breaks trust
- Without Conversion Elements: No lead magnet to deliver, no CTA to use
- Without Goals: Don't know what sequence type to build

---

### newsletter

**Purpose:** Create newsletters people actually want to read.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | - | Not directly used (covered by Product/Service) |
| **Product/Service** | Required | Expertise area determines newsletter content focus |
| **Target Audience** | Required | Newsletter format and topics must match reader interests |
| **Competitors** | - | Not directly used for newsletter creation |
| **Brand Voice** | Required | Newsletter voice is critical for reader connection |
| **Content Rules** | Required | Terminology and style must be consistent |
| **Conversion Elements** | Optional | CTAs can be included but newsletters are primarily value |
| **Goals** | - | Newsletter goals are implicit (engagement, relationship) |

**If missing required fields:**
- Without Product/Service: Don't know what expertise to share
- Without Target Audience: Content may not interest readers
- Without Brand Voice: Newsletter sounds generic, no personality
- Without Content Rules: Inconsistent style breaks recognition

---

### lead-magnet

**Purpose:** Generate compelling lead magnet concepts that build lists and convert to paid offers.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | Optional | Business type influences format selection |
| **Product/Service** | Required | Lead magnet must bridge to paid offer; transformation drives hook |
| **Target Audience** | Required | What they want determines what to create |
| **Competitors** | - | Not directly used for lead magnet ideation |
| **Brand Voice** | - | Not relevant to concept generation (applied in creation) |
| **Content Rules** | - | Not relevant to concept generation |
| **Conversion Elements** | Required | Paid offer details needed to design the bridge |
| **Goals** | Required | List building goals shape lead magnet strategy |

**If missing required fields:**
- Without Product/Service: Can't design bridge to paid offer
- Without Target Audience: May create something they don't want
- Without Conversion Elements: No paid offer to bridge to
- Without Goals: Can't prioritise lead magnet concepts

---

### content-atomizer

**Purpose:** Transform one piece of content into platform-optimised assets.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | - | Not directly used (atomises existing content) |
| **Product/Service** | Optional | Context helps with relevant CTAs per platform |
| **Target Audience** | Optional | Platform preferences can guide format choices |
| **Competitors** | - | Not relevant to content atomisation |
| **Brand Voice** | Required | Each platform needs voice adjustment while staying on-brand |
| **Content Rules** | Required | Terminology must be consistent across platforms |
| **Conversion Elements** | Optional | CTAs need to be platform-appropriate |
| **Goals** | - | Not directly used (goal is distribution) |

**If missing required fields:**
- Without Brand Voice: Platform content sounds off-brand or inconsistent
- Without Content Rules: Terminology varies across platforms

---

### validate-content

**Purpose:** Check content against universal rules and client profile, outputting PASS/FAIL.

| Field | Status | Why |
|-------|--------|-----|
| **Company** | - | Not used for validation |
| **Product/Service** | Optional | Terminology validation (product names) |
| **Target Audience** | - | Not used for validation |
| **Competitors** | Optional | Validates no competitor mentions if profile says to avoid |
| **Brand Voice** | Required | Core validation check for voice alignment |
| **Content Rules** | Required | All rules are validated against this section |
| **Conversion Elements** | - | Not validated (handled by other skills) |
| **Goals** | - | Not used for validation |

**If missing required fields:**
- Without Brand Voice: Can't validate tone and personality alignment
- Without Content Rules: Can only validate universal rules, not client-specific

---

## Profile Completeness by Use Case

### Minimum Viable Profile (keyword research only)

Essential fields to start any project:

- **Company:** Name, industry, website
- **Product/Service:** Core offering, problem solved
- **Target Audience:** Primary audience, pain points
- **Competitors:** At least 2-3 with URLs
- **Goals:** Primary content goal

### Content Creation Profile

Add these for writing SEO content:

- **Brand Voice:** Full voice profile (summary, traits, tone spectrum, vocabulary, examples)
- **Content Rules:** Words to avoid, terminology, signature phrases
- **Conversion Elements:** Primary CTA, CTA templates

### Full Marketing Profile

Add these for emails, lead magnets, and conversion:

- **Conversion Elements:** All CTA types, lead magnets, social proof
- **Goals:** Full content goals with metrics

---

## Onboarding Coverage Checklist

Use this to verify onboarding captured everything needed:

```
[ ] Company — Name, industry, size, website, years
[ ] Product/Service — Core offering, problem, price range, do not mention
[ ] Target Audience — Job titles, pain points, failed solutions, goals
[ ] Competitors — 3-5 with URLs, strengths, weaknesses, advantages
[ ] Brand Voice — Summary, traits, tone spectrum, vocabulary, rhythm, examples, do's/don'ts
[ ] Content Rules — Avoided words, topics, signature phrases, terminology
[ ] Conversion Elements — Primary CTA, templates, lead magnets, social proof
[ ] Goals — Content goals, priority topics, success metrics
```

---

*Reference this document when a skill produces poor output—the cause is often a missing profile field.*
