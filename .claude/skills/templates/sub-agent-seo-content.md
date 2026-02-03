# Sub-Agent Template: SEO Content Generation

A prompt template for spawning writing sub-agents during pillar orchestration. The main session fills in the placeholders and spawns the sub-agent using the Task tool.

**Reference:** See `rules/sub-agent-rules.md` for orchestration principles and fresh context window documentation.

---

## Key Principles

1. **Fresh context window** — This sub-agent has no memory of the main session
2. **Invoke /seo-content directly** — Execute the skill, don't follow manual instructions
3. **No clarifying questions** — All context must be in this prompt
4. **Return path, not content** — Keep main session context minimal

---

## Template

```
You are a writing sub-agent responsible for creating a single SEO article. Execute the /seo-content workflow autonomously and return the file path when complete.

## Context Files

Read these files to understand brand voice, positioning, and content requirements:

- **Client Profile:** {profile_path}
- **Positioning Document:** {positioning_path}
- **Pillar Brief:** {brief_path}
- **Universal Rules:** .claude/rules/universal-rules.md

## Target Article

- **Article Number:** {article_number}
- **Title:** {article_title}
- **Target Keyword:** {target_keyword}
- **Secondary Keywords:** {secondary_keywords}
- **Angle:** {angle_from_positioning}
- **Word Count:** {word_count}
- **Output Path:** {output_path}

## Completed Articles (for internal linking)

{completed_articles_list}

Use these for internal linking. If no articles listed, use placeholder format for future links:
`<!-- LINK NEEDED: [slug] when published -->`

## Workflow Requirements

Execute these steps in order:

### 1. Read Context

- Read client profile for brand voice, terminology, CTAs
- Read positioning document for this article's angle and hook
- Read pillar brief for keyword data and content structure
- Read universal rules for validation requirements

### 2. Research Phase

Find 2-4 E-E-A-T citations that support key claims:

- Prefer UK-specific sources (.gov.uk, NHS, UK institutions)
- Include author/organisation, year, and working URL
- Use citation format: Author/Org, Year — [Title](URL)

### 3. Write Article

Follow article-template.md structure:

- Complete YAML frontmatter (all required fields)
- Primary keyword in first 150 words
- Primary keyword in at least one H2
- Minimum 3 internal links (use completed articles or placeholders)
- Short paragraphs (3-4 sentences max)
- Apply brand voice from client profile
- Include FAQ section (3-5 questions)

### 4. Self-Validate

Check against universal rules before returning:

**FAIL Conditions (must fix):**
- [ ] UK English spelling (no American spellings)
- [ ] No banned AI words (53 words — see universal-rules.md)
- [ ] No banned AI phrases
- [ ] No AI patterns (repetitive sentence starts, everything in threes)
- [ ] SEO requirements met (keyword placement, meta lengths)
- [ ] E-E-A-T citations present with proper format

**WARN Conditions (fix if possible):**
- [ ] Using contractions naturally
- [ ] Varied sentence length
- [ ] Personal voice present
- [ ] Specific examples included
- [ ] Active voice dominant

### 5. Return

After writing the article to disk:

- Return the file path: `{output_path}`
- Return status: `PASS` (all FAIL conditions cleared) or `FAIL` (with issues list)
- Do NOT return the full article content (keeps context minimal)

## Output Format

When complete, respond with:

```
**Status:** PASS | FAIL

**File Path:** {output_path}

**Word Count:** {actual_word_count}

**Issues (if FAIL):**
- [List any validation failures]

**Notes:**
- [Any relevant context for the main session]
```
```

---

## Placeholder Reference

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{profile_path}` | Path to client profile | `clients/hushaway/profile.md` |
| `{positioning_path}` | Path to positioning document | `projects/hushaway/seo-content/adhd-sleep/02-positioning.md` |
| `{brief_path}` | Path to pillar brief | `projects/hushaway/seo-content/adhd-sleep/01-pillar-brief.md` |
| `{article_number}` | Sequential article number | `01` |
| `{article_title}` | Full article title | `Why Your ADHD Child Won't Sleep (And What Actually Helps)` |
| `{target_keyword}` | Primary keyword | `adhd child won't sleep` |
| `{secondary_keywords}` | Related keywords | `adhd sleep problems, adhd bedtime struggles` |
| `{angle_from_positioning}` | Angle from positioning doc | `The hidden sensory overload angle` |
| `{word_count}` | Target word count | `1,800-2,200` |
| `{output_path}` | Where to write the article | `projects/hushaway/seo-content/adhd-sleep/articles/01-adhd-child-wont-sleep.md` |
| `{completed_articles_list}` | List of completed articles with paths | See example below |

### Completed Articles List Format

```
- Article 01: [01-adhd-child-wont-sleep.md](articles/01-adhd-child-wont-sleep.md) — "adhd child won't sleep"
- Article 02: [02-adhd-bedtime-routine.md](articles/02-adhd-bedtime-routine.md) — "adhd bedtime routine"
```

If no articles completed yet:
```
None yet. Use placeholder format for all internal links.
```

---

## Example: Filled Template

```
You are a writing sub-agent responsible for creating a single SEO article. Execute the /seo-content workflow autonomously and return the file path when complete.

## Context Files

Read these files to understand brand voice, positioning, and content requirements:

- **Client Profile:** clients/hushaway/profile.md
- **Positioning Document:** projects/hushaway/seo-content/adhd-sleep/02-positioning.md
- **Pillar Brief:** projects/hushaway/seo-content/adhd-sleep/01-pillar-brief.md
- **Universal Rules:** .claude/rules/universal-rules.md

## Target Article

- **Article Number:** 02
- **Title:** The ADHD Bedtime Routine That Actually Works (From Parents Who've Tried Everything)
- **Target Keyword:** adhd bedtime routine
- **Secondary Keywords:** adhd sleep routine, bedtime routine for adhd child, adhd night routine
- **Angle:** Structure without rigidity — the flexible framework approach
- **Word Count:** 1,800-2,200
- **Output Path:** projects/hushaway/seo-content/adhd-sleep/articles/02-adhd-bedtime-routine.md

## Completed Articles (for internal linking)

- Article 01: [01-adhd-child-wont-sleep.md](articles/01-adhd-child-wont-sleep.md) — "adhd child won't sleep"

Use these for internal linking. Link to Article 01 where relevant.

[... rest of workflow requirements ...]
```

---

## Validation Sub-Agent Template

**See `templates/sub-agent-validate-content.md` for the full validation sub-agent template.**

The validation template includes:
- Complete 6-phase validation workflow
- Required return format (FULL output, not abbreviated)
- All placeholders with examples
- Usage notes for main session

---

## Usage Notes

1. **Main session spawns sub-agents** using the Task tool with `subagent_type: "general-purpose"`
2. **One sub-agent per article** — never ask a sub-agent to write multiple articles
3. **Sub-agents read files themselves** — pass paths, not content
4. **Sub-agents return paths, not content** — keeps main session context minimal
5. **Validation is SEPARATE** — use a different sub-agent for validation (see `sub-agent-validate-content.md`)
6. **Commit after validation passes** — main session handles git, not sub-agents

---

## Failure Handling

If a writing sub-agent returns FAIL:

1. **First retry:** Re-spawn with same instructions
2. **Second retry:** Re-spawn with error context from first attempt
3. **Third failure:** Escalate to user, continue with other articles

Log all failures to PROJECT-TASKS.md under the relevant task.

---

*Reference `rules/sub-agent-rules.md` for complete orchestration guidelines.*
