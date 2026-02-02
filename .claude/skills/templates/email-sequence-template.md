# Email Sequence Templates

Reference templates for building email sequences that convert. Use these when creating welcome, nurture, conversion, launch, or re-engagement sequences.

---

## Usage Notes

**How to use this template:**

1. **As part of email-sequences workflow:** Run `/email-sequences` with your context and the skill will create sequences using these formats automatically

2. **Independently:** Copy the relevant sequence template below and customise:
   - Replace placeholder text `{...}` with your actual content
   - Adjust email count based on your offer complexity
   - Modify timing based on your audience behaviour

3. **File location:** Save sequences to:
   ```
   /projects/{client}/{project}/sequences/
   └── {sequence-name}.md
   ```

**Status values:** `draft` | `ready` | `scheduled` | `live` | `paused`

**Timing guidance:**
- Higher price = more trust-building emails before pitch
- B2B = weekday mornings work best
- B2C = test evenings and weekends

---

## Sequence YAML Frontmatter

All email sequences use this frontmatter:

```yaml
---
sequence_type: "{welcome | nurture | conversion | launch | re-engagement}"
goal: "{What this sequence accomplishes}"
emails_count: {number}
timing: "{e.g., Days 0, 2, 4, 6, 8}"
trigger: "{What starts this sequence}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

| Field | Description | Example |
|-------|-------------|---------|
| `sequence_type` | Category of sequence | `welcome`, `nurture`, `conversion`, `launch`, `re-engagement` |
| `goal` | Primary objective | `"Convert free trial users to paid"` |
| `emails_count` | Total emails in sequence | `5` |
| `timing` | Send schedule | `"Days 0, 2, 4, 7, 10"` |
| `trigger` | What initiates the sequence | `"Lead magnet download"` |
| `status` | Current state | `draft`, `ready`, `scheduled`, `live`, `paused` |

---

## Individual Email Template

Use this format for each email in any sequence:

```markdown
### Email {#}: {Name/Purpose}

**Send:** {Day X or trigger condition}
**Subject:** {Subject line - under 50 chars ideal}
**Preview:** {Preview text - first 40-90 chars visible in inbox}
**Purpose:** {What this email accomplishes}
**CTA:** {The one action you want them to take}

---

{OPENING - Hook or greeting}

{BODY - Main content, 3-5 short paragraphs}

{CLOSE - Transition to CTA}

{CTA - Clear call to action}

{SIGN OFF}

---

**P.S.** {Optional - 40% of readers see this first. Use for CTA reinforcement, second hook, or deadline reminder.}
```

---

## Welcome Sequence Template (3-5 emails)

**Purpose:** Deliver lead magnet, build relationship, introduce paid offer.

```yaml
---
sequence_type: welcome
goal: "{Transform new subscriber into warm prospect ready for offer}"
emails_count: 5
timing: "Days 0, 2, 4, 7, 10"
trigger: "{Lead magnet download / Newsletter signup}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

# Welcome Sequence: {Lead Magnet Name}

## Sequence Overview

| Field | Value |
|-------|-------|
| **Goal** | {e.g., Deliver value, build trust, introduce paid offer} |
| **Lead Magnet** | {What they downloaded} |
| **Paid Offer** | {What you're eventually selling} |
| **Bridge** | {How free → paid makes logical sense} |
| **Emails** | 5 |
| **Timing** | Days 0, 2, 4, 7, 10 |

---

### Email 1: Delivery

**Send:** Immediately (Day 0)
**Subject:** {Your [lead magnet] is inside}
**Preview:** {Here's how to use it in 60 seconds}
**Purpose:** Deliver the goods, set expectations, get first micro-engagement
**CTA:** Download + Reply with a question

---

{Greeting}

{Deliver the lead magnet - link prominently}

{Quick start - ONE action they can take in the next 5 minutes}

{Set expectations - what emails are coming and when}

{Micro-CTA - ask them to reply, answer a question, or take one small action}

{Sign off}

---

**P.S.** {Optional - reinforce quick start or tease tomorrow's email}

---

### Email 2: Connection

**Send:** Day 2
**Subject:** {Why I created [lead magnet] / Quick story about [topic]}
**Preview:** {Intriguing detail that continues the curiosity}
**Purpose:** Build rapport through story and shared experience
**CTA:** Soft - read tomorrow's email

---

{Story hook - specific moment, failure, or realisation}

{The struggle - what you went through}

{The insight - what you learned}

{The connection - how this relates to them and the lead magnet}

{Soft forward reference - tease what's coming}

{Sign off}

---

### Email 3: Value

**Send:** Day 4
**Subject:** {The [X] mistake everyone makes / Try this: [tactic]}
**Preview:** {Specific result or insight}
**Purpose:** Teach something useful, create a quick win, demonstrate expertise
**CTA:** Apply the insight

---

{Hook - counterintuitive insight or observation}

{The problem - what most people get wrong}

{The solution - what to do instead}

{Example or proof - show it working (case study, your experience, data)}

{Action step - what they can do right now}

{Sign off}

---

**P.S.** {Tease next email - "Tomorrow: what [lead magnet] can't do (and why it matters)"}

---

### Email 4: Bridge

**Send:** Day 7
**Subject:** {You can [do X] now. But can you [do Y]?}
**Preview:** {What one piece doesn't cover}
**Purpose:** Show the gap between where they are and where they could be
**CTA:** Soft - stay tuned for more

---

{Acknowledge progress - what they can now do with the lead magnet}

{Reveal the gap - what they still can't do / what's missing}

{Paint the picture - what's possible with the full solution}

{Soft mention - the paid offer exists, but no hard sell yet}

{Sign off}

---

### Email 5: Soft Pitch

**Send:** Day 10
**Subject:** {The full [solution] (if you want it)}
**Preview:** {Brief offer summary}
**Purpose:** Introduce the offer properly, let them self-select
**CTA:** Check out the offer (no urgency yet)

---

{Transition - build on the bridge email}

{The offer - what it is, what's included, price}

{Who it's for - specific situations where this helps}

{Who it's NOT for - honest disqualification}

{Social proof - if available (testimonial, number of customers, results)}

{Soft CTA - link to offer page, no urgency}

{Sign off}

---

**P.S.** {Reinforce no pressure - "The free [lead magnet] is yours either way."}

---

## Nurture Sequence Template (5-7 emails)

**Purpose:** Provide ongoing value, stay top of mind, build authority between campaigns.

```yaml
---
sequence_type: nurture
goal: "{Keep subscribers engaged and build trust over time}"
emails_count: 6
timing: "Weekly (or 2x per week)"
trigger: "{After welcome sequence completes / Ongoing}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

# Nurture Sequence: {Topic/Theme}

## Sequence Overview

| Field | Value |
|-------|-------|
| **Goal** | {Provide value, build trust, stay top of mind} |
| **Audience** | {Subscribers who completed welcome sequence} |
| **Theme** | {Overarching topic or angle} |
| **Emails** | 6 |
| **Timing** | Weekly |

---

### Email 1: Framework/Model

**Send:** Week 1
**Subject:** {The [X] framework that changed how I think about [topic]}
**Preview:** {Specific insight or result}
**Purpose:** Share a mental model or framework they can apply
**CTA:** Try the framework

---

{Hook - why this framework matters}

{The framework - explain it simply (3-5 steps or components)}

{Example - show it in action}

{How to apply - what they should do}

{Sign off}

---

### Email 2: Mistake/Lesson

**Send:** Week 2
**Subject:** {The [X] mistake I made (so you don't have to)}
**Preview:** {What it cost you}
**Purpose:** Share a failure and the lesson learned
**CTA:** Avoid the mistake

---

{The mistake - what you did wrong}

{The cost - what it cost you (time, money, reputation)}

{The lesson - what you learned}

{The fix - what to do instead}

{Sign off}

---

### Email 3: How-To

**Send:** Week 3
**Subject:** {How to [achieve specific result] in [timeframe]}
**Preview:** {Step 1 of the process}
**Purpose:** Teach a tactical skill they can use immediately
**CTA:** Implement the tactic

---

{Why this matters - the problem this solves}

{Step 1 - first action}

{Step 2 - second action}

{Step 3 - third action}

{Common mistake - what to avoid}

{Sign off}

---

### Email 4: Contrarian Take

**Send:** Week 4
**Subject:** {Unpopular opinion: [contrarian statement]}
**Preview:** {Why most people get this wrong}
**Purpose:** Challenge conventional wisdom, show independent thinking
**CTA:** Consider the alternative

---

{The conventional wisdom - what most people believe}

{Why it's wrong - the flaw in this thinking}

{The alternative - what's actually true}

{The evidence - why you believe this}

{Sign off}

---

### Email 5: Case Study/Story

**Send:** Week 5
**Subject:** {How [person/company] achieved [result]}
**Preview:** {The key insight from their approach}
**Purpose:** Share a success story with actionable insights
**CTA:** Apply the insight

---

{The situation - where they started}

{The challenge - what they were struggling with}

{The approach - what they did differently}

{The result - what happened}

{The takeaway - what readers can learn}

{Sign off}

---

### Email 6: Curated Resources

**Send:** Week 6
**Subject:** {[Number] things worth your time this week}
**Preview:** {First item preview}
**Purpose:** Provide value through curation, show breadth of knowledge
**CTA:** Explore the resources

---

{Brief intro - theme connecting these resources}

{Resource 1 - what it is, why it's valuable, link}

{Resource 2 - what it is, why it's valuable, link}

{Resource 3 - what it is, why it's valuable, link}

{Your take - one insight from consuming these}

{Sign off}

---

### Email 7: Q&A / FAQ (Optional)

**Send:** Week 7
**Subject:** {The question I get asked most}
**Preview:** {The short answer}
**Purpose:** Address common questions, show you understand their challenges
**CTA:** Reply with their questions

---

{The question - what people ask you}

{The short answer - direct response}

{The nuance - "but it depends on..."}

{The deeper answer - full explanation}

{Invitation - ask them to reply with their questions}

{Sign off}

---

## Conversion Sequence Template (3-5 emails)

**Purpose:** Sell the product through a focused pitch sequence.

```yaml
---
sequence_type: conversion
goal: "{Convert warm subscribers into customers}"
emails_count: 5
timing: "Days 0, 2, 4, 6, 7"
trigger: "{After nurture sequence / After specific engagement action}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

# Conversion Sequence: {Product Name}

## Sequence Overview

| Field | Value |
|-------|-------|
| **Goal** | {Convert subscribers to customers} |
| **Product** | {What you're selling} |
| **Price** | {Price point} |
| **Urgency** | {Real deadline or ongoing offer?} |
| **Emails** | 5 |
| **Timing** | Days 0, 2, 4, 6, 7 |

---

### Email 1: Open

**Send:** Day 0
**Subject:** {Introducing [product] / [Product] is here}
**Preview:** {Core transformation in one line}
**Purpose:** Announce the offer, establish the core promise
**CTA:** Learn more / See the offer

---

{Hook - the transformation or result they want}

{The problem - what's standing in their way}

{The solution - introduce your product}

{What it is - brief description}

{What's included - key components}

{The promise - what they'll be able to do}

{CTA - link to sales page}

{Sign off}

---

### Email 2: Desire

**Send:** Day 2
**Subject:** {Imagine [desired outcome] / What if you could [result]?}
**Preview:** {Paint the picture}
**Purpose:** Build desire by painting the transformation
**CTA:** Get the transformation

---

{Paint the "before" - where they are now, the frustration}

{Paint the "after" - where they could be}

{The gap - why they haven't bridged it yet}

{How the product bridges it - specific mechanism}

{CTA - link to offer}

{Sign off}

---

### Email 3: Proof

**Send:** Day 4
**Subject:** {How [person] achieved [specific result]}
**Preview:** {The key number or outcome}
**Purpose:** Provide social proof through testimonials or case studies
**CTA:** Join them

---

{Testimonial or case study - real results}

{Their situation before - relatable starting point}

{What they did - used your product}

{The result - specific, quantified if possible}

{More proof - additional testimonials or data}

{CTA - link to offer}

{Sign off}

---

**P.S.** {Include a second testimonial or stat}

---

### Email 4: Objection

**Send:** Day 6
**Subject:** {"But what if [objection]?" / The question everyone asks}
**Preview:** {Address the hesitation}
**Purpose:** Handle the biggest objection preventing purchase
**CTA:** Remove the barrier

---

{Acknowledge the objection - "You might be thinking..."}

{Validate it - show you understand why they'd think that}

{Address it - why it's not actually a barrier}

{Proof - evidence that supports your answer}

{Risk reversal - guarantee, refund policy, or safety net}

{CTA - link to offer}

{Sign off}

---

### Email 5: Close

**Send:** Day 7
**Subject:** {Last chance / Decision time / [Product] - yes or no?}
**Preview:** {Clear summary}
**Purpose:** Final push with urgency (if authentic)
**CTA:** Buy now

---

{Direct opener - no buildup, get to the point}

{Restate core value - one sentence}

{Urgency - if real (price increase, bonus deadline, limited spots)}

{Handle final hesitation - "If you're on the fence..."}

{Clear CTA - exactly what to do}

{Final thought - personal note}

{Sign off}

---

**P.S.** {Deadline reminder or final benefit}

---

## Launch Sequence Template (5-7 emails)

**Purpose:** Time-bound campaign for product launches, promotions, or cohort opens.

```yaml
---
sequence_type: launch
goal: "{Maximise conversions during limited-time launch window}"
emails_count: 7
timing: "Day -1, 0, 2, 4, 5, 6, 7"
trigger: "{Launch date}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

# Launch Sequence: {Product Name} Launch

## Sequence Overview

| Field | Value |
|-------|-------|
| **Goal** | {Maximise launch conversions} |
| **Product** | {What you're launching} |
| **Launch Window** | {e.g., 7 days} |
| **Cart Open** | {Date} |
| **Cart Close** | {Date} |
| **Emails** | 7 |
| **Timing** | Day -1, 0, 2, 4, 5, 6, 7 |

---

### Email 1: Pre-Launch Seed

**Send:** Day -1 (day before launch)
**Subject:** {Tomorrow: [teaser] / Something's coming}
**Preview:** {Build anticipation}
**Purpose:** Build anticipation, prime the audience
**CTA:** Watch for tomorrow's email

---

{Tease what's coming - without revealing everything}

{Why it matters - what problem this solves}

{What to expect - when they'll hear from you}

{Sign off}

---

### Email 2: Cart Open

**Send:** Day 0 (launch day, morning)
**Subject:** {[Product] is live / Doors are open}
**Preview:** {Core offer summary}
**Purpose:** Announce the launch, full offer details
**CTA:** Get it now

---

{Announcement - it's here}

{The offer - full details}

{What's included - everything they get}

{The price - be clear}

{Launch bonus - if applicable (early bird, bonus, limited)}

{CTA - link to buy}

{Sign off}

---

**P.S.** {Launch bonus deadline if applicable}

---

### Email 3: Value Deep-Dive

**Send:** Day 2
**Subject:** {What you get with [product] / Inside look at [product]}
**Preview:** {Most valuable component}
**Purpose:** Go deeper on value, address "what do I actually get?"
**CTA:** See everything included

---

{Focus on the most valuable component}

{Explain it in detail - what it is, how it works}

{Show the transformation - what they'll be able to do}

{List other components briefly}

{CTA - link to offer}

{Sign off}

---

### Email 4: Social Proof

**Send:** Day 4
**Subject:** {What [customers] are saying / [Number] people already joined}
**Preview:** {Best testimonial snippet}
**Purpose:** Build trust through results and testimonials
**CTA:** Join them

---

{Lead with strongest testimonial}

{Share 2-3 more testimonials or results}

{Quantify if possible - number of customers, results achieved}

{CTA - link to offer}

{Sign off}

---

### Email 5: Objection/FAQ

**Send:** Day 5
**Subject:** {Your questions answered / "Is this right for me?"}
**Preview:** {Most common question}
**Purpose:** Handle objections, answer FAQs
**CTA:** Remove barriers to purchase

---

{Q1: Most common objection - address it}

{Q2: Second most common - address it}

{Q3: "Is this for me?" - who it's for and not for}

{Risk reversal - guarantee, refund policy}

{CTA - link to offer}

{Sign off}

---

### Email 6: 24-Hour Warning

**Send:** Day 6 (24 hours before close)
**Subject:** {24 hours left / Closing tomorrow}
**Preview:** {What they'll miss}
**Purpose:** Create urgency with deadline
**CTA:** Last chance to join

---

{Deadline reminder - 24 hours}

{What they'll miss - bonus, price, or access}

{Quick recap - what they get}

{CTA - link to offer}

{Sign off}

---

**P.S.** {Exact deadline time and timezone}

---

### Email 7: Final Hours

**Send:** Day 7 (launch day close, evening)
**Subject:** {Final hours / Closing tonight}
**Preview:** {Last chance}
**Purpose:** Last call before cart closes
**CTA:** Buy before it's gone

---

{Direct - this is it}

{Hours remaining - be specific}

{Last testimonial or result}

{CTA - clear link}

{Sign off}

---

**P.S.** {Exact close time: "Doors close at midnight [timezone]"}

---

## Re-engagement Sequence Template (2-3 emails)

**Purpose:** Win back subscribers who haven't opened in 30+ days.

```yaml
---
sequence_type: re-engagement
goal: "{Re-activate cold subscribers or clean the list}"
emails_count: 3
timing: "Days 0, 3, 7"
trigger: "{No email opens in 30+ days}"
status: draft
created: "YYYY-MM-DD"
last_updated: "YYYY-MM-DD"
---
```

# Re-engagement Sequence: {List Name}

## Sequence Overview

| Field | Value |
|-------|-------|
| **Goal** | {Win back inactive subscribers or clean list} |
| **Trigger** | {No opens in 30+ days} |
| **Outcome** | {Re-engage or unsubscribe} |
| **Emails** | 3 |
| **Timing** | Days 0, 3, 7 |

---

### Email 1: Pattern Interrupt

**Send:** Day 0
**Subject:** {Did I do something wrong? / [First name], still there?}
**Preview:** {Haven't heard from you}
**Purpose:** Break the pattern, get attention, show you noticed
**CTA:** Click to stay subscribed

---

{Acknowledge the silence - "I noticed you haven't opened my emails lately"}

{No guilt - "Totally fine, inboxes are overwhelming"}

{Offer value - "In case you missed it, here's [best recent content]"}

{Easy out - "If you're no longer interested, no hard feelings"}

{CTA - click to confirm they want to stay}

{Sign off}

---

### Email 2: Best Content

**Send:** Day 3
**Subject:** {In case you missed it / My best stuff from this month}
**Preview:** {Most valuable piece}
**Purpose:** Provide pure value, remind them why they subscribed
**CTA:** Engage with content

---

{No preamble - straight to value}

{Share your 2-3 best pieces of content}

{Brief description of each - why it's worth their time}

{CTA - links to content}

{Sign off}

---

**P.S.** {Mention this is a check-in, not spam}

---

### Email 3: Final Decision

**Send:** Day 7
**Subject:** {Should I stop emailing you? / Breaking up is hard}
**Preview:** {Last chance to stay}
**Purpose:** Force a decision - stay or go
**CTA:** Click to stay OR do nothing to unsubscribe

---

{Direct - "I'm going to remove you from my list unless you want to stay"}

{Why - "I only want to email people who want to hear from me"}

{The offer - "Click below if you want to keep getting emails"}

{The alternative - "If I don't hear from you, I'll remove you in 48 hours"}

{No hard feelings - "Either way, I wish you well"}

{CTA - clear "Keep me subscribed" button}

{Sign off}

---

## Quick Reference: Content Focus by Email

### Welcome Sequence (5 emails)
| Email | Focus | Goal |
|-------|-------|------|
| 1 | Delivery | Get them using the lead magnet |
| 2 | Connection | Build rapport through story |
| 3 | Value | Teach something, create quick win |
| 4 | Bridge | Show the gap to paid offer |
| 5 | Soft Pitch | Introduce offer without pressure |

### Nurture Sequence (6 emails)
| Email | Focus | Goal |
|-------|-------|------|
| 1 | Framework | Share a mental model |
| 2 | Mistake | Teach through failure |
| 3 | How-To | Tactical skill transfer |
| 4 | Contrarian | Challenge assumptions |
| 5 | Case Study | Proof through story |
| 6 | Curation | Value through resources |

### Conversion Sequence (5 emails)
| Email | Focus | Goal |
|-------|-------|------|
| 1 | Open | Announce and promise |
| 2 | Desire | Paint transformation |
| 3 | Proof | Show it works |
| 4 | Objection | Remove barriers |
| 5 | Close | Final push |

### Launch Sequence (7 emails)
| Email | Focus | Goal |
|-------|-------|------|
| 1 | Seed | Build anticipation |
| 2 | Open | Full announcement |
| 3 | Deep-Dive | Explain value |
| 4 | Proof | Social validation |
| 5 | FAQ | Handle objections |
| 6 | Warning | 24-hour urgency |
| 7 | Close | Last call |

### Re-engagement Sequence (3 emails)
| Email | Focus | Goal |
|-------|-------|------|
| 1 | Interrupt | Get attention |
| 2 | Value | Remind why they subscribed |
| 3 | Decision | Stay or go |

---

## Subject Line Formulas

Quick reference for each email type:

| Type | Formula Examples |
|------|------------------|
| Delivery | "[Lead magnet] is inside", "Your [thing] + quick start" |
| Connection | "Why I created [X]", "Quick story about [topic]" |
| Value | "The [X] mistake everyone makes", "Try this: [tactic]" |
| Bridge | "You can [X] now. But can you [Y]?", "What [thing] doesn't do" |
| Pitch | "The full [solution] (if you want it)", "[Product] - yes or no?" |
| Urgency | "[X] hours left", "Closing tonight", "Last chance" |
| Re-engage | "Did I do something wrong?", "Should I stop emailing you?" |

---

## Timing Guidelines

| Sequence | Spacing | Total Duration |
|----------|---------|----------------|
| Welcome | Days 0, 2, 4, 7, 10 | ~10 days |
| Nurture | Weekly | Ongoing |
| Conversion | Every 2 days | ~7 days |
| Launch | Daily at key moments | 7-10 days |
| Re-engagement | Days 0, 3, 7 | 7 days |

**Trust-building required by price:**
- Under $100: 3-5 value emails before pitch
- $100-500: 5-7 value emails before pitch
- Over $500: 7-10 value emails or sales call
