---
name: positioning-angles
description: "Find the angle that makes content sell. Use after /start-pillar to develop unified positioning across an entire pillar. Takes pillar-brief.md + client profile as input. Outputs a PRIMARY ANGLE for the pillar guide, SECONDARY ANGLES for each supporting article, and a CONSISTENCY CHECK ensuring all angles reinforce rather than contradict."
---

# Positioning & Angles

The same content can perform 100x better with a different angle. Not different information. Not better research. Just a different way of framing what it already covers.

This skill finds those angles—for an entire pillar at once.

---

## The core job

For pillar-based content, the goal is **unified positioning across all articles**. The pillar guide establishes the primary angle; supporting articles extend and reinforce it from different entry points.

**Input required:**
- `01-pillar-brief.md` from the current pillar folder
- Client profile from `/clients/{name}/profile.md`

**Output:** A positioning document with:
1. **Primary Angle** — The core positioning for the pillar guide article
2. **Secondary Angles** — One angle per supporting article, mapped to the content plan
3. **Consistency Check** — Verification that all angles work together

---

## The angle-finding process

### Step 1: Identify what they're actually selling

Not the product. The transformation.

Ask: What does the customer's life look like AFTER? What pain disappears? What capability appears? What status changes?

A fitness program doesn't sell workouts. It sells "fit into your old jeans" or "keep up with your kids" or "look good naked."

A SaaS tool doesn't sell features. It sells "close your laptop at 5pm" or "never lose a lead" or "stop the spreadsheet chaos."

**The transformation is the raw material for angles.**

---

### Step 2: Map the competitive landscape

What would customers do if this didn't exist? Not competitors—alternatives.

- Do nothing (live with the problem)
- DIY (cobble together a solution)
- Hire someone (consultant, freelancer, agency)
- Buy a different category (different approach entirely)
- Buy a direct competitor

Each alternative has weaknesses. Those weaknesses become angle opportunities.

**Angle opportunity:** What's frustrating about each alternative that this solves?

---

### Step 3: Find the unique mechanism

The mechanism is HOW the product delivers results differently.

Not "we help you lose weight" (that's the promise).
"We help you lose weight through intermittent fasting optimized for your metabolic type" (that's the mechanism).

The mechanism makes the promise believable. It answers: "Why will this work when other things haven't?"

**Questions to surface the mechanism:**
- What's the proprietary process, method, or system?
- What do you do differently than the obvious approach?
- What's the counterintuitive insight that makes this work?
- What's the "secret" ingredient, step, or element?

Even if nothing is truly proprietary, there's always a mechanism. Name it.

---

### Step 4: Assess market sophistication

Where is the market on Schwartz's awareness scale?

**Stage 1 (New category):** The market hasn't seen this before.
→ Angle: Simple announcement. "Now you can [do thing]."

**Stage 2 (Growing awareness):** Competition exists, market is warming.
→ Angle: Claim superiority. "The fastest/easiest/most complete way to [outcome]."

**Stage 3 (Crowded):** Many players, similar claims, skepticism rising.
→ Angle: Explain the mechanism. "Here's WHY this works when others don't."

**Stage 4 (Jaded):** Market has seen everything, needs new frame.
→ Angle: Identity and belonging. "For people who [identity marker]."

**Stage 5 (Iconic):** Established leaders, brand loyalty matters.
→ Angle: Exclusive access. "Join the [tribe/movement]."

**The market stage determines which angle TYPE will work.**

---

### Step 5: Run the angle generators

Now generate options using multiple frameworks:

#### The Contrarian Angle
What does everyone in this market believe that might not be true?
Challenge that assumption directly.

> "Everything you've been told about [topic] is wrong."
> "Stop [common practice]. Here's what actually works."

Works when: Market is frustrated with conventional approaches. Audience sees themselves as independent thinkers.

#### The Unique Mechanism Angle
Lead with the HOW, not just the WHAT.
Name the proprietary process or insight.

> "The [Named Method] that [specific result]"
> "How [mechanism] lets you [outcome] without [usual sacrifice]"

Works when: Market is sophisticated (Stage 3+). Similar promises exist. Need to differentiate.

#### The Transformation Angle
Before and after. The gap between current state and desired state.

> "From [painful current state] to [desired outcome]"
> "Go from [specific bad metric] to [specific good metric] in [timeframe]"

Works when: The transformation is dramatic and specific. Market is problem-aware.

#### The Enemy Angle
Position against a common enemy (not a competitor—a problem, a mindset, an obstacle).

> "Stop letting [enemy] steal your [valuable thing]"
> "The [enemy] is lying to you. Here's the truth."

Works when: Audience has shared frustrations. There's a clear villain to rally against.

#### The Speed/Ease Angle
Compress the time or reduce the effort.

> "[Outcome] in [surprisingly short time]"
> "[Outcome] without [expected sacrifice]"

Works when: Alternatives require significant time or effort. Speed/ease is genuinely differentiated.

#### The Specificity Angle
Get hyper-specific about who it's for or what it delivers.

> "For [very specific avatar] who want [very specific outcome]"
> "The [specific number] [specific things] that [specific result]"

Works when: Competing with generic offerings. Want to signal "this is built for YOU."

#### The Social Proof Angle
Lead with evidence, not claims.

> "[Specific result] for [number] [type of people]"
> "How [credible person/company] achieved [specific outcome]"

Works when: Have strong proof. Market is skeptical. Trust is the primary barrier.

#### The Risk Reversal Angle
Make the guarantee the headline.

> "[Outcome] or [dramatic consequence for seller]"
> "Try it for [time period]. [Specific guarantee]."

Works when: Risk is the primary objection. Confidence in delivery is high.

---

## Output format

Save to `{pillar}/02-positioning.md` in the project folder.

```markdown
# Positioning: [Pillar Name]

## Primary Angle (Pillar Guide)

**Article:** [Pillar guide title from content plan]
**Target keyword:** [Primary pillar keyword]

**The angle:** [One sentence positioning for the entire pillar]
**Why it works:** [Psychology/market insight]
**Headline direction:** "[Example headline]"

**This angle claims:** [The territory you're staking out]
**This angle rejects:** [What you're positioning against]

---

## Secondary Angles

### Article: [Article title from content plan]
**Target keyword:** [Keyword]

**The angle:** [One sentence positioning]
**Why it works:** [How this supports the primary angle]
**Headline direction:** "[Example headline]"
**Reinforces primary via:** [How this angle connects back]

---

### Article: [Next article title]
**Target keyword:** [Keyword]

**The angle:** [One sentence positioning]
**Why it works:** [How this supports the primary angle]
**Headline direction:** "[Example headline]"
**Reinforces primary via:** [How this angle connects back]

---

[Continue for ALL supporting articles in the content plan]

**For /seo-content:** When writing each article, reference its assigned angle from this document. The angle drives the hook, framing, and conclusion. Extract "This angle claims," "This angle rejects," and "Reinforces primary via" to ensure consistent positioning throughout the content.

---

## Consistency Check

**All angles share:** [The common thread running through every piece]

**Primary angle establishes:** [The core positioning claim]

**Supporting angles extend via:**
- [Article 1]: [How it builds on primary]
- [Article 2]: [How it builds on primary]
- [Article 3]: [How it builds on primary]
[Continue for all articles]

**Potential conflicts:** [Any angles that risk contradicting each other — and how to resolve]

**Reader journey:** [How someone moving through these articles experiences consistent positioning]
```

---

## Example: Pillar positioning for "AI Marketing Strategy"

### Input
- Pillar brief: `ai-marketing-strategy/pillar-brief.md`
- Content plan includes:
  - Pillar Guide: "AI Marketing Strategy: The Complete Guide"
  - Article 1: "AI Marketing Tools Comparison 2025"
  - Article 2: "How to Build an AI Marketing Team"
  - Article 3: "AI Marketing ROI: Measuring What Matters"
  - Article 4: "AI Marketing for Small Business"

### Output: positioning.md

## Primary Angle (Pillar Guide)

**Article:** AI Marketing Strategy: The Complete Guide
**Target keyword:** ai marketing strategy

**The angle:** AI marketing isn't about tools—it's about building a system where AI amplifies human creativity instead of replacing it.
**Why it works:** Positions against the "replace marketers with AI" narrative that scares people. Reframes AI as an amplifier.
**Headline direction:** "AI Marketing Strategy: Build a System That Amplifies Your Team (Not Replaces It)"

**This angle claims:** Human-AI collaboration beats pure automation
**This angle rejects:** The "fire your marketing team" AI hype

---

## Secondary Angles

### Article: AI Marketing Tools Comparison 2025
**Target keyword:** ai marketing tools

**The angle:** The best AI tool is the one your team will actually use—not the one with the most features.
**Why it works:** Cuts through feature-comparison paralysis. Focuses on adoption, not specs.
**Headline direction:** "AI Marketing Tools 2025: Which One Will Your Team Actually Use?"
**Reinforces primary via:** Tools serve the human-AI system, not the other way around.

---

### Article: How to Build an AI Marketing Team
**Target keyword:** ai marketing team

**The angle:** You don't need AI specialists—you need marketers who know how to work with AI.
**Why it works:** Makes AI accessible to existing teams. Removes the "hire expensive talent" barrier.
**Headline direction:** "Building an AI Marketing Team: Why Your Existing Marketers Are Your Best Bet"
**Reinforces primary via:** Amplification framing—upskill humans rather than replace them.

---

### Article: AI Marketing ROI: Measuring What Matters
**Target keyword:** ai marketing roi

**The angle:** Most AI marketing ROI metrics measure the wrong thing—efficiency when you should measure effectiveness.
**Why it works:** Contrarian position. Makes readers question their current approach.
**Headline direction:** "AI Marketing ROI: Why Your Metrics Are Lying to You"
**Reinforces primary via:** Human judgment still needed to measure what matters.

---

### Article: AI Marketing for Small Business
**Target keyword:** ai marketing small business

**The angle:** Small businesses have an AI advantage big companies don't—speed and no legacy systems.
**Why it works:** Flips the "big companies have more resources" disadvantage into an advantage.
**Headline direction:** "AI Marketing for Small Business: Your Size Is Your Secret Weapon"
**Reinforces primary via:** Small teams can amplify faster than bloated enterprise teams.

---

## Consistency Check

**All angles share:** Human agency and judgment remain central; AI amplifies rather than replaces.

**Primary angle establishes:** The collaboration > automation positioning.

**Supporting angles extend via:**
- Tools article: Tool selection based on team usability, not features
- Team article: Upskilling existing people, not replacing them
- ROI article: Human judgment needed to measure what matters
- Small business article: Smaller teams amplify faster

**Potential conflicts:** ROI article's "metrics are lying" angle could feel negative. Resolution: Frame as empowering (now you know what to measure) rather than discouraging.

**Reader journey:** Someone landing on any article encounters the same core message—AI works best when it amplifies human capability. They can enter at any point and get consistent positioning.

---

## How this skill gets invoked

This skill activates when:
- User runs `/positioning-angles` after completing a pillar brief
- User asks "what's the angle for this pillar"
- User asks "how should I position these articles"
- `/start-pillar` has completed and positioning is the next step
- User needs unified positioning across multiple related articles

**Required before running:**
- A `pillar-brief.md` must exist in the pillar folder
- Client profile must exist at `/clients/{name}/profile.md`

**Workflow position:**
```
/start-pillar → /positioning-angles → /seo-content
```

Run this AFTER pillar brief is complete, BEFORE writing any content.

---

## What this skill is NOT

This skill finds positioning for pillar content. It does NOT:
- Write the actual content (that's /seo-content)
- Research competitors (that's already done in /start-pillar)
- Create the pillar brief (run /start-pillar first)
- Work without a pillar brief (the content plan is required input)

The output is unified positioning across all pillar articles, not finished content.

---

## The test

Before delivering pillar positioning, verify:

**For each individual angle:**
1. **Is it specific?** Vague angles ("better results") fail. Specific angles ("20 lbs in 6 weeks") convert.
2. **Is it differentiated?** Could a competitor claim the same thing? If yes, sharpen it.
3. **Is it believable?** Does the mechanism or proof support the claim?
4. **Does it lead somewhere?** Can you imagine the headline and the article? If not, it's too abstract.

**For the pillar as a whole:**
5. **Do all angles share a common thread?** Someone reading any two articles should sense the same underlying positioning.
6. **Do secondary angles extend (not repeat) the primary?** Each supporting article should approach from a different entry point while reinforcing the core.
7. **Are there any contradictions?** If the primary says "collaboration beats automation" but a supporting article says "automate everything," that's a problem.
8. **Does the reader journey make sense?** Someone moving through the pillar should experience consistent, reinforcing positioning.

---

## References

For deeper frameworks, see the `references/` folder:
- `dunford-positioning.md` — April Dunford's 5-component positioning methodology
- `schwartz-sophistication.md` — Eugene Schwartz's market awareness levels
- `unique-mechanism.md` — How to find and name your mechanism
- `angle-frameworks.md` — Halbert, Ogilvy, Hopkins, Bencivenga, Kennedy approaches
- `hormozi-offer.md` — Value equation and Grand Slam Offer thinking
