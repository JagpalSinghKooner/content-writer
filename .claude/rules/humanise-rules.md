# HushAway Content Rules (Single Source of Truth)

**This file is THE authoritative source for all content rules.**
- Skills MUST read this BEFORE writing content
- Gate scripts VERIFY compliance AFTER writing
- If rules here and scripts differ, THIS FILE is correct

---

## 1. Zero Tolerance Words (0 Allowed)

These words immediately flag content as AI-written. **Never use them.**

### AI-isms (Complete List)
navigate, navigating, delve, landscape, leverage, comprehensive, robust, crucial, vital, realm, multifaceted, paradigm, synergy, harness, unlock, empower, straightforward, seamless, seamlessly, utilize, utilise, facilitate, optimal, plethora, myriad, pivotal, foster, bolster, whilst, moreover, furthermore, additionally, hence, thus, therefore, consequently, nevertheless, nonetheless, notwithstanding, firstly, secondly, thirdly, aforementioned, underscore (as verb), coupled with, in essence, certainly, essentially, fundamentally, interestingly, undoubtedly, remarkably, ultimately, notably, evidently, inherently, arguably, invariably

### Hyperbolic (Banned)
amazing, literally, obviously

### Deficit Language (Banned)
fix, cure, normal, suffering from, special needs

### Clinical Terms (Banned)
disorder, patient, treatment, symptoms

### American English (Use UK)
| American | Use UK |
|----------|--------|
| mom | mum |
| color | colour |
| behavior | behaviour |
| organization | organisation |
| recognize | recognise |

---

## 2. Frequency Limits (Per Article)

| Word | Max | Use Instead |
|------|-----|-------------|
| specifically | 2 | omit or restructure |
| particularly | 2 | especially |
| significant/ly | 2 | major, notable, real |
| helpful | 3 | useful, describe HOW |
| designed to/for | 3 | built for, made for |
| effective/ly | 2 | works, successful |
| various | 1 | different, several |
| numerous | 1 | many, give a number |
| ensure/ensuring | 2 | make sure |
| key (adjective) | 2 | main, important |
| unique | 1 | be specific |
| tailored | 1 | customised, made for |
| address (verb) | 2 | deal with, help with |
| essential | 2 | needed, necessary |
| powerful | 1 | describe specifically |
| important | 3 | show importance |
| intended for | 1 | meant for |
| aimed at | 1 | for, targeting |

### Intensifier Limits

| Word | Max |
|------|-----|
| very | 3 |
| really | 2 |
| truly | 1 |
| highly | 2 |
| extremely | 1 |
| definitely | 1 |
| absolutely | 1 |
| incredible/ly | 1 |
| wonderful | 1 |
| clearly | 1 |
| actually | 2 |
| basically | 1 |

### Scaling for Longer Articles

The gate script scales limits for articles over 3,500 words:
- **Formula:** SCALE_FACTOR = (WordCount - 2000) / 1500
- Under 3,500 words: Use base limits above
- 3,500+ words: Add 1 to applicable limits

| Word | Under 3,500 words | 3,500+ words |
|------|-------------------|--------------|
| actually | 2 | 3 |
| effective/ly | 2 | 3 |
| helpful | 3 | 4 |
| important | 3 | 4 |

---

## 3. Banned Phrases (0 Allowed)

### Self-Answering Questions
Never follow a question with immediate answer in same paragraph.
- Bad: "What is the best app? The answer is..."
- Good: "Parents often ask which app is best. I wish I had a simple answer."

### Labelled Transitions
Never use: "The honest answer:", "The takeaway:", "What this means:", "The pattern we see:", "Key findings:", "Here's the thing:", "The bottom line:", "The reality is:", "The truth is:", "In other words:", "Simply put:", "Think of it this way:", "Consider this:"

### Guide-Speak Openers
Never use: "This guide will...", "In this article, we'll/you'll...", "Let's dive in", "Let's explore", "Without further ado", "First and foremost", "Last but not least", "It goes without saying", "It's worth noting that", "Needless to say"

### Banned Openers
Never use: "In today's world...", "When it comes to...", "If you're like most parents...", "You may be wondering...", "Here's everything you need to know...", "Looking for...?", "Welcome to our...", "The good/bad news is..."

### Banned Conclusions
Never use: "In conclusion...", "To sum up...", "All in all...", "In summary...", "To conclude...", "At the end of the day...", "The bottom line is...", "To wrap up...", "In closing..."

### Banned Transitions
Never use: "That said...", "That being said...", "Having said that...", "With that in mind...", "Moving forward...", "On that note...", "In light of this...", "On the other hand..."

### Banned Filler
Never use: "Let's take a closer look at...", "It's important to understand that...", "One thing to keep in mind is...", "It's safe to say that..."

### Banned Citation Phrases
Never use: "Research has consistently shown...", "Studies have repeatedly demonstrated...", "Experts agree that...", "Evidence suggests...", "According to experts..."

---

## 4. Structural Limits

| Pattern | Max |
|---------|-----|
| "This is why/where/what" | 3 per article |
| "Examples include:" | 2 per article |
| "As mentioned earlier/above" | 1 per article |
| Sentence-initial -ly adverbs | 2 per article |
| Sentences starting with "This" | 2 per H2 section |

### Global Limits (Entire Article)

These apply IN ADDITION to per-section requirements:

| Pattern | Limit |
|---------|-------|
| Short sentences (under 8 words) | Minimum 3 total |
| Sentences starting with "This" | Maximum 6 total |

### Hedging Density
- Max 8 hedges per 1000 words
- Hub (3000 words): max 24 hedges
- Cluster (1500 words): max 12 hedges
- Articles under 1000 words: minimum 8 hedges still applies (script floors at 1000)
- Hedge words: may, might, can, could, potentially, possibly, perhaps, likely, unlikely, tend to, often
- No stacked hedges (multiple hedges in one sentence)

### Redundant Phrases (Ban Completely)
completely unique, absolutely essential, very important, basic fundamentals, end result, past history, future plans, free gift, true fact, close proximity, each and every, first and foremost, advance planning, added bonus, brief moment, difficult dilemma, unexpected surprise, completely eliminate, final outcome

---

## 5. Human Voice Requirements (Mandatory)

### Contractions (Required)
- Minimum 2 per 500 words
- Use: you're, it's, don't, doesn't, can't, won't, we're, they're

**Contraction Calculation (How the Gate Script Counts):**
- Formula: (Contractions × 500) / WordCount must be ≥ 2
- 1,500 word article: minimum 6 contractions
- 2,000 word article: minimum 8 contractions
- 2,500 word article: minimum 10 contractions

### And/But Starters (Required)
- Minimum 2 sentences starting with "And" or "But" per article
- Example: "And that's exactly the problem."

### "We" Language (Required)
- Minimum 2 per article for community feel
- Example: "We've seen this pattern countless times."

### Short Sentences (Required)
- At least 1 sentence under 8 words per H2 section
- Examples: "It depends.", "Every child is different.", "That changes everything."

**CRITICAL: Script Detection Requirement**
- Short sentences MUST be standalone paragraphs (one sentence per line)
- The gate script uses regex `^[^.#]{1,40}\.$` which requires:
  - Start of line (`^`) - sentence must begin the paragraph
  - Under 40 characters total (excluding `.` and `#`)
  - Single period at end of line
  - Lines starting with `#` (markdown headers) are excluded
- Inline short sentences will NOT be counted (e.g., "It depends. Every child is different." counts as ZERO)
- Put each short sentence on its own line for detection

### Pronoun Limits
- Max 3 consecutive sentences starting with "you/your"
- Max 2 consecutive paragraphs starting with "It"

### Sentence Variety
- No section can have 3+ paragraphs starting with same word
- Lists must vary grammatical structure (no 5+ identical starts)
- Section lengths should vary (not all equal)

---

## 6. Brand Rules

### HushAway Trademark
- Always write HushAway® (with registered trademark symbol)
- Never plain "HushAway" (URLs like hushaway.com are exempt)
- Minimum 5 mentions per article

### UK English
- Use UK spellings throughout
- colour, behaviour, mum, organisation, recognise

### No Emojis
- Never use emojis anywhere in content

### No Em-Dashes
- Use commas, full stops, or semicolons instead

### Signature Phrases
See `.claude/CLAUDE.md` (Signature Phrases section) for brand-specific phrases to use naturally:
- "Big feelings", "soft place to land", "feel safe in their body"
- "Children who feel everything", "Sound Sanctuary", "gentle sound support"

---

## 7. Article Thresholds

### Word Counts
| Type | Hard Minimum | Target Range |
|------|--------------|--------------|
| Hub | 1,500 | 3,000-4,000 |
| Cluster | 1,500 | 2,000-2,500 |

**Note:** 1,500 words is the hard minimum for SEO ranking regardless of article type. Target ranges are for optimal depth and user experience.

### Required Elements Per Article
| Element | Hub | Cluster |
|---------|-----|---------|
| Community quotes | 2 | 1 |
| Dated citations (with year) | 3 | 2 |
| Internal links | 8-10 | 4-6 |
| External links (UK sources) | 3 | 2 |
| Curiosity loops | 2 | 1 |
| HushAway mentions | 5+ | 5+ |
| Sound Sanctuary CTA | 2+ | 2+ |

### Meta Requirements
| Element | Limit |
|---------|-------|
| Title | Max 60 characters |
| Meta description | 140-160 characters |
| Meta must include | Primary keyword |

### Brand Prominence
- HushAway® in introduction (first 500 words)
- HushAway® in 50%+ of H2 sections
- Comparison element near closing (table, checklist, or side-by-side)

### Keyword Placement
- Primary keyword in first 150 words
- Primary keyword in at least one H2

---

## 8. Conversion Language (Required)

### Parent Objection Counter-Phrases
Each article should naturally address **at least 2 of 4** objections:

**Objection 1: "Another app won't help"**
Counter with passive sound differentiation:
- passive sound, no engagement required, just listen, simply play
- different from apps, unlike apps that, no interaction needed

**Objection 2: "Too tired to try"**
Counter with zero learning curve:
- zero learning curve, just press play, no setup, no effort
- nothing to learn, no instructions, instant access, straight away

**Objection 3: "Is this actually different?"**
Counter with neurodivergent-first positioning:
- neurodivergent-first, built for neurodivergent, purpose-built
- not adapted, not generic, specifically created, from the ground up

**Objection 4: "What if my child won't use it?"**
Counter with free forever/no risk:
- free forever, nothing to lose, no risk, costs nothing
- no commitment, no obligation, risk-free

### Required CTA Language
- **Free Forever**: Use 1+ of: "free forever", "always free", "completely free"
- **Sound Sanctuary**: Mention 2+ times as destination
- **Risk Reversal**: Include 1+ of: "nothing to lose", "no commitment", "costs nothing"

### Low-Friction Access
Use: just enter your email, name and email, instant access, no credit card, magic link

Avoid: free trial, subscribe, subscription, sign up for, register for, premium, upgrade

### Brand Prominence in Conversion
- HushAway® mentioned 5+ times per article
- HushAway® in conversion contexts: 2+ mentions near "free", "try", "Sound Sanctuary"

---

## 9. Citation Style

### Format (Warm, Not Academic)
- Always include the year: "Research from 2024 found..."
- Good: "A 2023 study showed that..."
- Good: "According to the Cleo Family Health Index..."
- Bad: "According to a study published in the Journal of..."
- Bad: "Research conducted by the Department of..."

### UK-Approved Sources
NHS, ADHD UK, NICE guidelines, British Psychological Society, Royal College of Psychiatrists, gov.uk, PubMed

### Citation Requirements
- Hub: 3+ dated citations with source links
- Cluster: 2+ dated citations with source links

---

## 10. Community Quotes

### Quote Requirements
- Hub: 2 quotes minimum
- Cluster: 1 quote minimum

### Quote Authenticity Markers
Good quotes include:
- Contractions ("I'm", "we've", "doesn't")
- Specific details (brand names, ages, times)
- Emotional language ("exhausted", "guilt", "relief")
- UK colloquialisms ("knackered", "at my wit's end")

Bad quotes sound like:
- Perfect grammar, complete sentences
- Generic language without details
- Clinical or formal tone

### Attribution Patterns
- "One mum put it perfectly..."
- "A parent in our community shared..."
- "Parents often tell us..."

---

## 11. Curiosity Loops

### Requirements
- Hub: 2+ curiosity loops
- Cluster: 1+ curiosity loop

### Templates
- "But here is the question most guides never ask..."
- "So what actually helps? The answer might surprise you."
- "Which brings us to something most parents overlook."
- "So which type does your child actually need?"
- "Most parents try this last. It should probably come first."

### What NOT to Use
- Clickbait: "You won't believe..."
- Questions you don't answer in the following section
- More than 3 per article

---

## Quick Reference: Use Instead

| Banned | Use Instead |
|--------|-------------|
| navigate | work with, support, help |
| delve | look at, explore, dig into |
| comprehensive | complete, full, thorough |
| leverage | use, apply |
| crucial/vital | important, key |
| utilize | use |
| ensure | make sure |
| various/numerous | different, several, many |
| robust | strong, solid, reliable |
| seamless | smooth, easy |
| optimal | best, ideal |

---

## Gate Verification

After writing, content is verified by automated gate scripts:

| Gate | Script | What It Checks |
|------|--------|----------------|
| Content Gate | master-gate.sh | All rules in sections 1-7, 9-11 |
| Conversion Gate | check-conversion-gate.sh | All rules in section 8 |
| Final Gate | check-final-gate.sh | Word count, meta, links |

**Skills that read this file before writing will pass gates on the first attempt.**
