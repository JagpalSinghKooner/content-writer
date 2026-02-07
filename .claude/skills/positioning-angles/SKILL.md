---
name: positioning-angles
description: "Find the angle that makes content sell. Use after /start-pillar to develop unified positioning across an entire pillar. Takes pillar-brief.md + client profile as input. Outputs a PRIMARY ANGLE for the pillar guide, SECONDARY ANGLES for each supporting article, and a CONSISTENCY CHECK ensuring all angles reinforce rather than contradict."
---

# Positioning & Angles

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

A fitness program sells "fit into your old jeans." A SaaS tool sells "close your laptop at 5pm."

**The transformation is the raw material for angles.**

---

### Step 2: Map the competitive landscape

What would customers do if this didn't exist? Not competitors — alternatives:

- Do nothing (live with the problem)
- DIY (cobble together a solution)
- Hire someone (consultant, freelancer, agency)
- Buy a different category (different approach entirely)
- Buy a direct competitor

Each alternative has weaknesses. Those weaknesses become angle opportunities.

---

### Step 3: Find the unique mechanism

The mechanism is HOW the product delivers results differently.

Not "we help you lose weight" (that's the promise).
"We help you lose weight through intermittent fasting optimised for your metabolic type" (that's the mechanism).

**Questions to surface the mechanism:**
- What's the proprietary process, method, or system?
- What do you do differently than the obvious approach?
- What's the counterintuitive insight that makes this work?
- What's the "secret" ingredient, step, or element?

Even if nothing is truly proprietary, there's always a mechanism. Name it.

---

### Step 4: Assess market sophistication

Where is the market on Schwartz's awareness scale?

**Stage 1 (New category):** Simple announcement. "Now you can [do thing]."

**Stage 2 (Growing awareness):** Claim superiority. "The fastest/easiest/most complete way to [outcome]."

**Stage 3 (Crowded):** Explain the mechanism. "Here's WHY this works when others don't."

**Stage 4 (Jaded):** Identity and belonging. "For people who [identity marker]."

**Stage 5 (Iconic):** Exclusive access. "Join the [tribe/movement]."

**The market stage determines which angle TYPE will work.**

---

### Step 5: Run the angle generators

Generate options using multiple frameworks:

#### The Contrarian Angle
Challenge what everyone in this market believes that might not be true.
> "Everything you've been told about [topic] is wrong."

Works when: Market is frustrated with conventional approaches.

#### The Unique Mechanism Angle
Lead with the HOW, not just the WHAT. Name the proprietary process.
> "The [Named Method] that [specific result]"

Works when: Market is sophisticated (Stage 3+). Similar promises exist.

#### The Transformation Angle
Before and after. The gap between current state and desired state.
> "From [painful current state] to [desired outcome]"

Works when: The transformation is dramatic and specific. Market is problem-aware.

#### The Enemy Angle
Position against a common enemy (not a competitor — a problem, a mindset, an obstacle).
> "Stop letting [enemy] steal your [valuable thing]"

Works when: Audience has shared frustrations. Clear villain to rally against.

#### The Speed/Ease Angle
Compress the time or reduce the effort.
> "[Outcome] in [surprisingly short time]"

Works when: Alternatives require significant time or effort.

#### The Specificity Angle
Get hyper-specific about who it's for or what it delivers.
> "For [very specific avatar] who want [very specific outcome]"

Works when: Competing with generic offerings. Signal "this is built for YOU."

#### The Social Proof Angle
Lead with evidence, not claims.
> "[Specific result] for [number] [type of people]"

Works when: Have strong proof. Market is skeptical. Trust is the primary barrier.

#### The Risk Reversal Angle
Make the guarantee the headline.
> "[Outcome] or [dramatic consequence for seller]"

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

## The test

Before delivering pillar positioning, verify:

- **Specific?** Vague angles ("better results") fail. Specific angles ("20 lbs in 6 weeks") convert.
- **Differentiated?** Could a competitor claim the same thing? If yes, sharpen it.
- **Believable?** Does the mechanism or proof support the claim?
- **Common thread?** Someone reading any two articles should sense the same underlying positioning.
- **No contradictions?** Secondary angles extend the primary — never undermine it.

---

## References

For deeper frameworks, see the `references/` folder:
- `dunford-positioning.md` — April Dunford's 5-component positioning methodology
- `schwartz-sophistication.md` — Eugene Schwartz's market awareness levels
- `unique-mechanism.md` — How to find and name your mechanism
- `angle-frameworks.md` — Halbert, Ogilvy, Hopkins, Bencivenga, Kennedy approaches
- `hormozi-offer.md` — Value equation and Grand Slam Offer thinking
