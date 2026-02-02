---
name: onboard-client
description: "Interview to build a complete client profile for SEO content generation. Guides a natural conversation about company, product, audience, competitors, and brand voice. Triggers on: onboard client, new client, create client profile, set up client. Outputs a complete profile to /clients/{name}/profile.md."
---

# Client Onboarding Workflow

Every piece of content needs context. Without knowing who you're writing for, what makes them different, and how they sound—you're guessing.

This skill runs once per client. It builds the foundation that every other skill draws from.

---

## The goal

Create a complete client profile that captures:
- What they do (and for whom)
- What makes them different
- How they should sound
- What to avoid
- What success looks like

The output is a markdown file that other skills reference. No more asking the same questions on every brief.

---

## How to run

Start with the minimum: the client's product or service description.

```
/onboard-client

Product: [paste product/service description or URL]
```

Then I'll interview you. Takes 10-15 minutes for a thorough profile.

---

## The interview

I'll ask questions in natural conversation. You don't need to answer everything—skip what doesn't apply.

### Section 1: Company Basics

- What's the company name?
- What industry are you in?
- Company size? (solo, small team, agency, enterprise)
- Website URL?
- How long have you been operating?

### Section 2: Product/Service

- What do you sell? (products, services, SaaS, consulting, etc.)
- What's the core offering?
- What problem does it solve?
- What's the price range? (if relevant to content)
- Any products/services you DON'T want mentioned?

### Section 3: Target Audience

**Who are they?**
- Job titles / roles
- Company size they work at
- Industry they're in
- Experience level (beginner, intermediate, advanced)
- Geographic focus (UK, US, global, etc.)

**What do they struggle with?**
- Top 3 pain points
- What have they tried that didn't work?
- What's holding them back?

**What do they want?**
- Immediate goals
- Long-term aspirations
- How do they measure success?

### Section 4: Competitors

Who are your top 5 competitors? (Minimum 3, aim for 5 for thorough analysis.) For each:
- Company name
- Website URL
- What they do well
- What they get wrong
- Why someone would choose you over them

### Section 5: Brand Voice

**Tone:**
- Formal or casual?
- Technical or accessible?
- Bold or conservative?
- Playful or serious?

**Personality traits:**
- Pick 3-5 adjectives that describe how you want to come across
- Examples: confident, helpful, no-nonsense, warm, authoritative, witty

**Voice examples:**
- Share 2-3 pieces of content you love (yours or others)
- What do you like about them?
- Any content you've created that captures your voice well?

**Perspective:**
- First person (I/we) or third person (the company)?
- Do you have a named author or is it brand voice?

### Section 6: Content Rules

**Words to avoid:**
- Industry jargon that doesn't land
- Competitor names (if sensitive)
- Specific claims you can't make
- Terms that don't match your brand

**Topics to avoid:**
- Controversial subjects
- Features not yet launched
- Competitor comparisons (if policy)
- Anything legally sensitive

**Signature phrases:**
- Taglines or slogans
- Phrases you repeat often
- How you refer to your customers
- How you refer to your product

**Terminology:**
- Product names (exact capitalisation)
- Feature names
- Industry terms you prefer
- Terms you use differently than industry standard

### Section 7: Conversion Elements

**Primary CTA:**
- What action do you want readers to take?
- Free trial, demo, contact, newsletter, purchase?

**CTA templates:**
- How do you phrase your calls to action?
- Examples from your existing content

**Lead magnets:**
- Any freebies to mention? (guides, tools, templates)
- Newsletter name/description

**Social proof:**
- Customer count
- Notable clients (with permission)
- Awards or recognition
- Stats you can cite

### Section 8: Goals

**Content goals:**
- Organic traffic growth
- Lead generation
- Brand awareness
- Thought leadership
- Sales enablement

**Priority keywords/topics:**
- Any keywords you're already targeting?
- Topics you want to own?
- Seasonal considerations?

**Success metrics:**
- How do you measure content performance?
- What does "winning" look like?

### Section 9: Brand Voice Extraction

This section builds a complete voice profile. The goal: anyone (human or AI) can read this and produce content that sounds distinctly like you.

**Tone spectrum:**
Where do you land on these dimensions?
- Formal ↔ Casual (contractions? slang? sentence fragments?)
- Serious ↔ Playful (humour? lightness? gravity?)
- Reserved ↔ Bold (hedging? strong claims? confidence?)
- Simple ↔ Sophisticated (everyday words? technical depth?)
- Warm ↔ Direct (friendly or to the point?)

**Personality traits:**
- What 3-5 words describe your brand's personality?
- For each trait, how does it show up in your content?
- Examples: confident but not arrogant, helpful but not hand-holding, expert but accessible

**Voice examples:**
- Share 2-3 pieces of content that nail your voice (yours or others you admire)
- What specifically do you like about how they communicate?
- Any content that sounds like "us" that we can analyse?

**Vocabulary patterns:**
- Signature words or phrases you repeat?
- Industry jargon level—heavy, moderate, light, or translated?
- Any words that feel distinctly "you"?
- Strong feelings about profanity or edgy language?

**Rhythm and structure:**
- Short punchy sentences or flowing paragraphs?
- Heavy use of lists and headers, or more prose?
- How do you typically open content? (story, question, bold statement?)
- How do you close? (CTA, summary, open loop?)

**On-brand vs off-brand:**
- Give an example of a phrase that sounds like you
- Give an example of a phrase that would never come from you
- What makes the difference?

**Relationship stance:**
- Are you the teacher, peer, guide, rebel, or insider?
- Do you address readers formally or like friends?
- First person (I) or plural (we)?

---

## Interview tips

**Be specific:** "Busy marketers" is vague. "Marketing managers at B2B SaaS companies with 50-200 employees who don't have a dedicated content team" is useful.

**Share examples:** If you love how a competitor writes, tell me. If you hate industry cliches, list them.

**It's okay to skip:** Not every section applies to every business. Skip what doesn't fit.

**Think about edge cases:** What questions do you always have to answer? What objections come up repeatedly?

---

## Output

After the interview, I'll create:

```
/clients/{client-name}/profile.md
```

This profile includes:
- All interview responses, organised
- Extracted patterns and insights
- Ready-to-reference sections for other skills

Every content skill reads this profile. Update it when things change.

---

## After onboarding

Once the profile exists, you can:

1. **Run keyword research:** `/keyword-research` reads the profile for context
2. **Generate content:** `/seo-content` matches the brand voice
3. **Write emails:** `/email-sequences` uses CTAs and tone
4. **Create social posts:** `/content-atomizer` maintains voice across platforms

The profile is the foundation. Build it once, use it everywhere.

---

## Updating profiles

Profiles aren't static. Update when:

- You launch new products/services
- Target audience shifts
- Brand voice evolves
- New competitors emerge
- Goals change

Just re-run relevant sections:

```
/onboard-client

Update: [client-name]
Section: Brand Voice

[new information]
```

---

## The test

A good profile answers these questions without needing to ask again:

1. Who is this content for? (specific audience)
2. What makes this company different? (positioning)
3. How should this sound? (voice)
4. What must we never say? (guardrails)
5. What's the goal? (success metrics)

If any answer is missing, the interview isn't complete.
