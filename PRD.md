# SEO Content System

## Overview

**Goal:** A content development system that identifies competitor gaps, finds high-opportunity keywords, writes SEO content that ranks, and converts traffic - for any client.

**Principles:**
- Simple: 1 workflow, pillar-based structure, document-based handoffs
- Fast: Article from keyword to publish-ready efficiently
- Quality: Human-sounding content that passes validation first time
- Scalable: Works for 10+ clients with same workflow

**Full documentation:** [.claude/CLAUDE.md](.claude/CLAUDE.md)

---

## Rule #1: Task Execution

Every task follows this pattern — no exceptions:

1. **Plan** — Break work into discrete tasks
2. **Document** — Write tasks to `PROJECT-TASKS.md` in project root
3. **Execute** — Complete one task at a time
4. **Verify** — Each task must 100% PASS before proceeding
5. **Handoff** — Document completion with context for next task

See [CLAUDE.md](.claude/CLAUDE.md) for PROJECT-TASKS.md template and full requirements.

---

## The Workflow

### Phase 1: Client Onboarding (once per client)

**Skill:** `/onboard-client`

1. You provide: product/service description (minimum input)
2. Claude interviews you about: company, product, audience, competitors, goals, brand voice
3. Output: Complete client profile in `/clients/{client-name}/profile.md`

### Phase 2: Content Generation (per pillar)

| Step | Skill | Input | Output |
|------|-------|-------|--------|
| 1 | `/keyword-research` | Client profile | `00-keyword-brief.md` |
| 2 | `/start-pillar` | Keyword brief + pillar name | `{pillar}/01-pillar-brief.md` |
| 3 | `/positioning-angles` | Pillar brief + profile | `{pillar}/02-positioning.md` |
| 4 | `/seo-content` | Positioning + profile | `{pillar}/articles/{nn}-{slug}.md` |
| 5 | `/direct-response-copy` | Draft article | Updates article in place |
| 6 | `/content-atomizer` | Final article | `{pillar}/distribution/{slug}/` |
| 7 | `/validate-content` | Final + rules | PASS/FAIL |

**Pillar-first execution:** Complete ALL articles for one pillar before moving to the next.

---

## File Structure

```
/clients/
└── {client-name}/
    └── profile.md

/projects/
└── {client-name}/
    └── {project-name}/
        ├── PROJECT-TASKS.md
        ├── 00-keyword-brief.md
        └── {pillar-name}/
            ├── 01-pillar-brief.md
            ├── 02-positioning.md
            ├── articles/
            │   ├── 01-{slug}.md
            │   ├── 02-{slug}.md
            │   └── ...
            └── distribution/
                └── {article-slug}/
                    ├── linkedin.md
                    ├── twitter.md
                    ├── newsletter.md
                    └── instagram.md

/.claude/
├── CLAUDE.md
├── rules/
│   ├── universal-rules.md
│   ├── common-mistakes.md
│   └── client-profile-requirements.md
└── skills/
    └── {skill-name}/
        └── SKILL.md
```

---

## File Naming Conventions

| File Type | Pattern | Example |
|-----------|---------|---------|
| Keyword brief | `00-keyword-brief.md` | `00-keyword-brief.md` |
| Pillar brief | `01-pillar-brief.md` | `01-pillar-brief.md` |
| Positioning | `02-positioning.md` | `02-positioning.md` |
| Supporting articles | `{nn}-{slug}.md` | `01-what-is-seo.md` |
| Pillar guide | `{nn}-{slug}.md` (highest number) | `11-complete-guide.md` |
| Distribution | `distribution/{slug}/{platform}.md` | `distribution/what-is-seo/linkedin.md` |

**Slug rules:** Lowercase, hyphens between words, contains primary keyword, max 50 characters.

---

## Skills

| Skill | Purpose |
|-------|---------|
| `/onboard-client` | Interview to build client profile |
| `/keyword-research` | Find high-opportunity keywords |
| `/start-pillar` | Extract pillar + competitor analysis |
| `/positioning-angles` | Find the hook that differentiates |
| `/seo-content` | Write SEO articles that sound human |
| `/direct-response-copy` | Add conversion elements |
| `/brand-voice` | Voice refinement or evolution |
| `/email-sequences` | Build email sequences that convert |
| `/content-atomizer` | Repurpose content across platforms |
| `/lead-magnet` | Generate lead magnet concepts |
| `/newsletter` | Create newsletters people want to read |
| `/validate-content` | Check content against rules |
| `/orchestrator` | Route to correct skill when unsure |

---

## Content Rules

### Universal Rules (all clients)

**File:** `.claude/rules/universal-rules.md`

**FAIL if violated:**
1. UK English (colour, behaviour, organisation)
2. Banned AI words (53 words including: navigate, delve, leverage, comprehensive, robust)
3. Banned AI phrases (throat-clearing, meta-commentary, desperate hooks)
4. AI patterns (repetitive starts, perfect threes, hedging overload)
5. SEO requirements (keyword placement, meta data, structure)
6. E-E-A-T citations (proper sourcing with hyperlinks)

**WARN (recommendations):**
- Use contractions
- Vary sentence length
- Personal voice present
- Specific examples included
- Active voice dominant

### Client-Specific Rules

**File:** `/clients/{client-name}/profile.md`

- Brand voice and tone
- Signature phrases
- Words/topics to avoid
- Product terminology
- CTA templates

---

## Validation

**Skill:** `/validate-content`

1. Check against universal rules
2. Check against client profile (brand voice match)
3. Assess overall quality (does it sound human?)
4. Output: PASS/FAIL with specific issues and line numbers

**Checkpoints:** Post-draft (automatic), post-enhancement (automatic), pre-publish (automatic), batch review (manual).

---

## Learning System

**File:** `.claude/rules/common-mistakes.md`

When validation identifies recurring issues:
1. AI suggests addition to common-mistakes.md
2. Human approves/rejects
3. Future content avoids the pattern

---

## APIs Required

- **DataForSEO:** Search volumes, keyword difficulty, domain ratings
- **Perplexity MCP:** Competitor analysis, research, trends

---

## Success Criteria

| Metric | Target |
|--------|--------|
| Iterations to pass validation | 0-1 |
| Content quality | Human, not robotic |
| Client switching | Seamless via profiles |
