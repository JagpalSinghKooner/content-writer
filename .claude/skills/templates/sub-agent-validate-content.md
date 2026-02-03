# Sub-Agent Template: Content Validation

A prompt template for spawning validation sub-agents during pillar orchestration. The main session fills in the placeholders and spawns the sub-agent using the Task tool.

**Reference:** See `rules/sub-agent-rules.md` for orchestration principles and return format requirements.

---

## Template

```
You are a validation sub-agent responsible for validating a single article. Execute the /validate-content skill in non-interactive mode and return FULL validation output.

## CRITICAL: Full Output Required

Return the COMPLETE validation output, not a summary. The main session needs:
- Every FAIL issue with line numbers and specific fixes
- Every WARN issue with suggestions
- Full SEO checklist with actual values
- Complete readability metrics table
- Brand voice assessment

Abbreviated output prevents the main session from making retry decisions.

## Context Files

Read these files for validation:

- **Article to Validate:** {article_path}
- **Client Profile:** {profile_path}
- **Universal Rules:** .claude/rules/universal-rules.md

## Validation Parameters

- **Primary Keyword:** {primary_keyword}
- **Content Type:** {content_type}
- **Target Word Count:** {target_word_count}

## Validation Workflow

Execute these phases from /validate-content:

### Phase 1: Universal Rules Check

**1.1 UK English Spelling Scan**
Check all words against UK/US spelling pairs. Any US spelling = FAIL.

**1.2 Banned AI Words Scan (53 words)**
Check for all banned words from universal-rules.md. Any found = FAIL.

**1.3 Banned AI Phrases Scan**
Check for all banned phrases. Any found = FAIL.

**1.4 AI Pattern Detection**
Check for:
- Repetitive sentence starts (3+ consecutive same word)
- Everything in threes pattern
- Hedging overload (>5% hedging words)
- Empty transitions

**1.5 SEO Requirements Check**
- [ ] Primary keyword "{primary_keyword}" in first 150 words
- [ ] Primary keyword in at least one H2
- [ ] Keyword density 1-2%
- [ ] Minimum 1,500 words
- [ ] Meta title under 60 characters
- [ ] Meta description 140-160 characters
- [ ] At least 3 internal links
- [ ] One H1 only

### Phase 2: Client Profile Check

**2.1 Brand Voice Alignment**
Compare tone against profile voice summary.

**2.2 Terminology Consistency**
Check against client's preferred terminology.

**2.3 Avoided Words/Topics**
Check against client's "avoid" list.

### Phase 3: Human Quality Assessment

**3.1 Overall AI Detection**
Does content sound AI-generated? Flags:
- Uniform tone (no variation)
- No opinions or positions
- Generic examples
- Every claim hedged

**3.2 Natural Flow and Rhythm**
Check for varied sentence length, contractions, paragraph variation.

**3.3 Specific Examples and Opinions**
Check for specific numbers, named examples, author opinions.

### Phase 4: Schema Validation

**4.1 Required Field Check**
Verify all frontmatter fields exist and are correctly formatted.

**4.2 Slug Format Validation**
Check: lowercase, hyphens, contains keyword, under 50 chars.

**4.3 SEO Metrics Validation**
Verify word_count and keyword_density match actual content.

### Phase 5: Readability Metrics

Calculate:
- Flesch-Kincaid Grade Level (target: 6-10)
- Flesch Reading Ease (target: 60-70)
- Average sentence length (target: <20 words)
- Longest sentence (target: <40 words)

### Phase 6: Pillar Consistency (if applicable)

If positioning.md exists at the pillar level:
- Check angle alignment
- Check internal linking consistency
- Check messaging consistency

## Output Format

**YOU MUST USE THIS EXACT FORMAT. DO NOT ABBREVIATE.**

```
## Validation Result: [PASS/FAIL]

**Article:** {article_path}
**Primary Keyword:** {primary_keyword}
**Word Count:** [actual count]
**Client Profile:** {profile_path}

---

### FAIL Issues (must fix before publishing)

[List EVERY FAIL issue. Include line number and specific fix for each.]

1. **Line XX:** "[exact text]" - [issue] → [specific fix]
2. **Line XX:** "[exact text]" - [issue] → [specific fix]
[... continue for ALL FAIL issues ...]

If no FAIL issues: "None"

---

### WARN Issues (should fix for quality)

[List EVERY WARN issue. Include line number and suggestion for each.]

1. **Line XX:** [issue] → [suggestion]
2. **Line XX:** [issue] → [suggestion]
[... continue for ALL WARN issues ...]

If no WARN issues: "None"

---

### SEO Checklist

- [x/] Primary keyword in first 150 words [actual position: word X]
- [x/] Primary keyword in H2 [found in: "H2 text"]
- [x/] Keyword density 1-2% [actual: X.X%]
- [x/] Word count 1,500+ [actual: XXXX]
- [x/] Meta title under 60 chars [actual: XX chars]
- [x/] Meta description 140-160 chars [actual: XXX chars]
- [x/] 3+ internal links [actual: X links]
- [x/] Single H1 [found: X H1 tags]

---

### Schema Validation

- [x/] All required frontmatter fields present
- [x/] Slug format valid [slug: "xxx-xxx-xxx"]
- [x/] word_count matches actual [frontmatter: XXXX, actual: XXXX]
- [x/] keyword_density matches actual [frontmatter: X.X%, actual: X.X%]
- [x/] secondary_keywords found in content

Missing fields (if any): [list]

---

### Readability Metrics

| Metric | Score | Target | Status |
|--------|-------|--------|--------|
| Flesch-Kincaid Grade | X.X | 6-10 | ✓/✗ |
| Flesch Reading Ease | XX | 60-70 | ✓/✗ |
| Avg Sentence Length | XX words | <20 | ✓/✗ |
| Longest Sentence | XX words | <40 | ✓/✗ |

---

### Brand Voice

- **Aligned:** Yes / No
- **Tone Match:** [assessment]
- **Terminology:** [any violations]
- **Notes:** [any concerns]

---

### Pillar Consistency (if checked)

- [x/] Article aligns with assigned angle "[angle name]"
- [x/] Internal links reference pillar articles
- [x/] Messaging consistent with positioning.md
- [x/] No contradictions with other pillar content

If not checked: "Skipped - no positioning.md found"
```
```

---

## Placeholder Reference

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{article_path}` | Path to article to validate | `projects/hushaway/seo-content/adhd-sleep/articles/01-adhd-child-wont-sleep.md` |
| `{profile_path}` | Path to client profile | `clients/hushaway/profile.md` |
| `{primary_keyword}` | Main target keyword | `adhd child won't sleep` |
| `{content_type}` | Type of content | `Article` / `Email` / `Newsletter` / `Distribution` |
| `{target_word_count}` | Expected word count | `1,800-2,200` |

---

## Example: Filled Template

```
You are a validation sub-agent responsible for validating a single article. Execute the /validate-content skill in non-interactive mode and return FULL validation output.

## CRITICAL: Full Output Required

Return the COMPLETE validation output, not a summary. The main session needs:
- Every FAIL issue with line numbers and specific fixes
- Every WARN issue with suggestions
- Full SEO checklist with actual values
- Complete readability metrics table
- Brand voice assessment

Abbreviated output prevents the main session from making retry decisions.

## Context Files

Read these files for validation:

- **Article to Validate:** projects/hushaway/seo-content/adhd-sleep/articles/02-adhd-bedtime-routine.md
- **Client Profile:** clients/hushaway/profile.md
- **Universal Rules:** .claude/rules/universal-rules.md

## Validation Parameters

- **Primary Keyword:** adhd bedtime routine
- **Content Type:** Article
- **Target Word Count:** 1,800-2,200

[... rest of workflow phases ...]
```

---

## Usage Notes

1. **Validation sub-agents are SEPARATE from writing sub-agents** — never combine
2. **Full output is mandatory** — abbreviated output = failure
3. **Main session uses output for retry decisions** — line numbers enable targeted fixes
4. **Spawn in parallel** — validate multiple articles simultaneously
5. **Main session handles git** — validation sub-agents don't commit

---

## Why Full Output Matters

The main session needs full output to:

| Need | Why |
|------|-----|
| Line-specific FAIL issues | Decide whether to retry or escalate |
| All WARN issues | Determine if quality threshold met |
| SEO checklist values | Verify requirements without re-reading article |
| Readability metrics | Track quality across pillar |
| Brand voice assessment | Catch drift early |

**Abbreviated output forces the main session to re-validate or read the article directly, defeating the purpose of sub-agent isolation.**

---

## Failure Handling

If validation sub-agent fails to return proper output:

1. **First retry:** Re-spawn with explicit "FULL OUTPUT REQUIRED" emphasis
2. **Second retry:** Re-spawn with error context
3. **Third failure:** Escalate — main session runs validation directly

---

*Reference `rules/sub-agent-rules.md` for complete orchestration guidelines.*
