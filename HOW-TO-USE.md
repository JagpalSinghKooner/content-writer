# How to Use the SEO Content System

A practical guide to creating SEO-optimised content from keyword research to distribution.

---

## Quick Start

1. **Onboard a client** → `/onboard-client`
2. **Research keywords** → `/keyword-research`
3. **Start a pillar** → `/start-pillar {pillar name}`
4. **Find your angle** → `/positioning-angles`
5. **Execute content** → `/execute-pillar` or manual workflow

---

## System Overview

This system produces SEO content through a structured workflow:

```
Client Profile → Keywords → Pillars → Articles → Distribution
```

**Three types of work:**

| Type | What It Does | Mode |
|------|--------------|------|
| **Skills** | Interactive workflows requiring decisions | Manual |
| **Agents** | Automated content generation | Automated |
| **Validation** | Quality checks against rules | Automated |

---

## Phase 1: Client Onboarding

Before creating any content, build a client profile.

### Run the Skill

```
/onboard-client
```

### What Happens

The system interviews you about:
- Company details (name, industry, website)
- Product/service (what you sell, the transformation)
- Target audience (who, their pain points, goals)
- Competitors (3-5 with URLs)
- Brand voice (tone, personality, vocabulary)

### Output

A complete profile saved to:
```
/clients/{client-name}/profile.md
```

### Example Interaction

```
> /onboard-client

What's the company name?
> Acme Fitness

What industry are you in?
> Health & fitness coaching

What's your core product or service?
> Online personal training programmes for busy professionals
```

The interview continues until all sections are complete.

---

## Phase 2: Keyword Research

Transform business context into a prioritised content plan.

### Run the Skill

```
/keyword-research
```

### What Happens

The system:
1. Expands seed keywords using the 6 Circles Method
2. Clusters keywords into content pillars
3. Analyses competition and search intent
4. Prioritises by business value

### Output

A keyword brief saved to:
```
/projects/{client}/{project}/00-keyword-brief.md
```

### What You Get

- 6-10 content pillars ranked by priority
- Keyword clusters for each pillar
- Search volume estimates
- Competition analysis
- Recommended production order

### Example Output Structure

```markdown
## Pillar 1: Home Workouts (Priority: Critical)

**Search Volume:** 8,000+ monthly UK searches
**Competition:** Medium
**Business Value:** High (direct product fit)

**Keyword Clusters:**
- home workout routine
- no equipment workouts
- 30 minute home workout
- home workout plan for beginners
```

---

## Phase 3: Start a Pillar

Extract one pillar from your keyword brief and create an actionable plan.

### Run the Skill

```
/start-pillar {pillar name}
```

### Example

```
/start-pillar Home Workouts
```

### What Happens

The system:
1. Extracts the pillar from your keyword brief
2. Runs deep competitor analysis (top 10 ranking pages)
3. Identifies content gaps and opportunities
4. Creates an article plan with priorities

### Output

A pillar brief saved to:
```
/projects/{client}/{project}/{pillar-name}/01-pillar-brief.md
```

### What You Get

- Competitor analysis (what they cover, what they miss)
- Article plan (titles, keywords, word counts)
- Internal linking strategy
- Tier assignments (for parallel execution)

---

## Phase 4: Positioning Angles

Find the hook that makes your content stand out.

### Run the Skill

```
/positioning-angles
```

### What Happens

The system:
1. Analyses your client profile and pillar brief
2. Identifies positioning opportunities
3. Creates a primary angle for the pillar guide
4. Creates secondary angles for each supporting article

### Output

A positioning document saved to:
```
/projects/{client}/{project}/{pillar-name}/02-positioning.md
```

### Example Angles

**Primary Angle (Pillar Guide):**
> "The 'No Gym Required' Framework: How busy professionals get fit in 20 minutes a day without leaving home"

**Secondary Angle (Supporting Article):**
> "Why traditional workout advice fails office workers — and what to do instead"

---

## Phase 5: Content Execution

Two options: automated execution or manual workflow.

### Option A: Automated Execution

```
/execute-pillar
```

This runs the full pipeline:
1. Writes all articles (seo-writer agent)
2. Enhances copy (copy-enhancer agent)
3. Validates content (content-validator agent)
4. Creates distribution (content-atomizer agent)

Articles execute in tiers based on internal linking dependencies.

### Option B: Manual Workflow

Run each step yourself:

**Step 1: Write an article**
```
Write an article for "home workout routine for beginners"
```
The seo-writer agent handles this.

**Step 2: Enhance the copy**
```
Enhance this article
```
The copy-enhancer agent adds persuasion elements.

**Step 3: Validate**
```
Validate this article
```
The content-validator checks all rules.

**Step 4: Create distribution**
```
Create distribution content for this article
```
The content-atomizer creates social posts.

### Output Structure

```
/projects/{client}/{project}/{pillar-name}/
├── 01-pillar-brief.md
├── 02-positioning.md
├── articles/
│   ├── 01-home-workout-routine-beginners.md
│   ├── 02-no-equipment-workouts-guide.md
│   ├── 03-30-minute-home-workout.md
│   └── 04-complete-home-workout-guide.md  (pillar guide, highest number)
└── distribution/
    └── home-workout-routine-beginners/
        ├── linkedin.md
        ├── twitter.md
        ├── newsletter.md
        └── instagram.md
```

---

## Phase 6: Validation

Content is automatically validated, but you can also run manual checks.

### Automatic Validation Points

| When | What's Checked |
|------|----------------|
| After draft | Universal rules, AI fingerprints |
| After enhancement | Brand voice alignment |
| Before publish | Final comprehensive check |

### Manual Validation

```
/validate-content
```

Or:
```
Validate this article
```

### What Gets Checked

1. **UK English** — No American spellings
2. **Banned words** — 53 AI fingerprint words
3. **Banned phrases** — AI opening clichés, padding
4. **AI patterns** — Repetitive structures, em dashes
5. **SEO requirements** — Keywords, headings, links
6. **E-E-A-T citations** — Proper source formatting
7. **Brand voice** — Matches client profile

### Validation Output

```
## Validation Result: FAIL

### FAIL Issues (must fix)
- Line 23: "color" → use "colour" (UK spelling)
- Line 45: "leverage" → use "use" (banned AI word)
- Line 67: Em dash found → restructure sentence

### WARN Issues (should fix)
- Line 12: Consider adding contraction "it's"
- Paragraph 4: All sentences similar length
```

---

## Task Tracking

Every project uses a `PROJECT-TASKS.md` file.

### File Location

```
/projects/{client}/{project}/PROJECT-TASKS.md
```

### Task Structure

```markdown
## Task 1: Keyword Research

**Objective:** Create keyword brief for content strategy

**Acceptance Criteria:**
- [ ] 6-10 pillars identified
- [ ] Clusters have search volume estimates
- [ ] Production queue prioritised

**Starter Prompt:**
> Run /keyword-research for {client name}. Focus on {industry}
> keywords with UK search volume. Prioritise by business value.

**Status:** pending | in_progress | PASS | FAIL

---

**Handoff (completed tasks only):**
- **Done:** Created keyword brief with 8 pillars
- **Decisions:** Prioritised "home workouts" first (highest volume)
- **Next:** Run /start-pillar for Home Workouts
```

### Rules

1. **Update immediately** — Mark tasks complete in the same response as finishing
2. **Write handoffs** — Always document what was done and what's next
3. **One task at a time** — Complete each task before starting the next

---

## Complete Workflow Example

Here's a full project from start to finish:

### Day 1: Setup

```
> /onboard-client

[Complete interview for "Acme Fitness"]

Output: /clients/acme-fitness/profile.md
```

### Day 2: Research

```
> /keyword-research

[System analyses industry, expands keywords, clusters into pillars]

Output: /projects/acme-fitness/seo-content/00-keyword-brief.md

Result: 8 pillars identified, "Home Workouts" is priority 1
```

### Day 3: Pillar 1 Planning

```
> /start-pillar Home Workouts

[System runs competitor analysis, creates article plan]

Output: home-workouts/01-pillar-brief.md

> /positioning-angles

[System finds differentiation angles]

Output: home-workouts/02-positioning.md
```

### Day 4-5: Content Execution

```
> /execute-pillar

[Agents write, enhance, validate, and atomise all articles]

Output:
- 4 articles (3 supporting + 1 pillar guide)
- Distribution content for each article
- All validated and ready to publish
```

### Day 6: Start Pillar 2

```
> /start-pillar Nutrition Basics

[Repeat the process for the next pillar]
```

---

## Common Commands

| Command | What It Does |
|---------|--------------|
| `/onboard-client` | Create client profile |
| `/keyword-research` | Generate keyword strategy |
| `/start-pillar {name}` | Begin a content pillar |
| `/positioning-angles` | Find differentiation hooks |
| `/execute-pillar` | Run full content pipeline |
| `/seo-content` | Write a single article |
| `/direct-response-copy` | Enhance article copy |
| `/validate-content` | Check against all rules |
| `/content-atomizer` | Create distribution content |

---

## Tips

### Start Small
Don't try to execute all pillars at once. Complete one pillar fully before starting the next.

### Read the Handoffs
Always check PROJECT-TASKS.md at the start of each session. The handoff sections contain critical context.

### Trust the Validation
If validation returns FAIL, fix the issues. Don't publish content that hasn't passed.

### Use Positioning
The `/positioning-angles` step is where good content becomes great. Don't skip it.

### Context Matters
If a session is running long, split the work. Update PROJECT-TASKS.md with where you stopped.

---

## File Reference

| File | Location | Purpose |
|------|----------|---------|
| Client profile | `/clients/{name}/profile.md` | Brand voice, audience, product |
| Keyword brief | `/projects/.../00-keyword-brief.md` | All pillars and clusters |
| Pillar brief | `{pillar}/01-pillar-brief.md` | Article plan for one pillar |
| Positioning | `{pillar}/02-positioning.md` | Angles and hooks |
| Articles | `{pillar}/articles/*.md` | The actual content |
| Distribution | `{pillar}/distribution/` | Social media content |
| Task tracking | `PROJECT-TASKS.md` | Progress and handoffs |

---

## Troubleshooting

### "Validation keeps failing"
Check for:
- American spellings (color → colour)
- Banned AI words (see universal-rules.md)
- Em dashes (restructure the sentence)

### "Content sounds generic"
- Did you run `/positioning-angles`?
- Is the brand voice complete in the client profile?
- Did you run `/direct-response-copy` enhancement?

### "Lost context between sessions"
- Read PROJECT-TASKS.md at session start
- Check the handoff section of the last completed task
- Use the starter prompt to resume

### "Not sure which pillar to do next"
Check the keyword brief (`00-keyword-brief.md`). Pillars are listed in priority order.

---

*For detailed rules, see `.claude/rules/`. For skill documentation, see `.claude/skills/`.*
