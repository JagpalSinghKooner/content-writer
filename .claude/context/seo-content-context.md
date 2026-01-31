# SEO Content Context (HushAway)

**Skill:** /seo-content
**Gate:** Content Gate (master-gate.sh)

---

## MANDATORY: Read Before Writing

**You MUST read these files before generating any content:**

1. **`.claude/scratchpad/research-summary.md`** - Article data
2. **`.claude/rules/humanise-rules.md`** - ALL content rules
3. **`HushAway.md`** - Sound library (MANDATORY)

**Writing without reading these files WILL result in gate failures.**

**Using the Sound Library:**
- Match article problems to sound types (column: "When it's used")
- Understand what HushAway® offers for specific needs (column: "Why it's used")
- Reference usage contexts accurately (column: "Where it's used")
- **CTAs always point to Sound Sanctuary** - never use product series names in CTAs (readers don't know them)

---

## CRITICAL: Verify Libraries First

Before writing, confirm both libraries have entries for this article:
- `.claude/keyword-library.md` MUST have entry for this article's keyword
- `.claude/angle-library.md` MUST have entry for this article's angle

**STOP if either is missing.** Run the prerequisite skills first.

---

## All Thresholds and Rules

**Single source of truth:** `.claude/rules/humanise-rules.md`

- Section 7: Word counts, required elements, brand prominence
- Sections 1-6: Banned words, frequency limits, human markers
- Section 8: Conversion language

Do not duplicate rules here. Read the rules file before writing.

---

## Active Checks During Writing (CRITICAL)

**These checks prevent gate failures. Apply during writing, not after.**

### Pre-Flight Check (MANDATORY)

**Run quick-check.sh after completing each major section:**
```bash
.claude/scripts/quick-check.sh [article-file]
```

This catches 90%+ of Content Gate failures DURING writing, preventing iteration loops.

**16 checks including:**
- AI-isms, deficit language (0 tolerance)
- Hedging density (max 8 per 1000 words)
- Stacked hedges (no multiple per sentence)
- Paragraph variety (no 3+ same starts per section)
- Primary keyword in H2
- Meta description length (140-160)
- Commitment language in tables

**Run after:** intro complete, each H2 section, before final submission.

### Word Frequency Tracking

Track frequency-limited words as you write. See `.claude/rules/humanise-rules.md` Section 2 for:
- Full list of 18 limited words and their maximums
- 12 intensifier limits
- **Scaling formula for articles 3,500+ words** (limits increase by 1)

**Most commonly exceeded (quick reference):**
- actually: 2 max (3 for 3,500+ words)
- specifically: 2 max
- helpful: 3 max (4 for 3,500+ words)

### Before Completing Each H2 Section

- [ ] At least 1 short sentence AS STANDALONE PARAGRAPH (own line, under 40 chars)
- [ ] 1-2 contractions included (you're, it's, don't, etc.)
- [ ] No AI-isms used (navigate, delve, comprehensive, robust)

### Before Submitting Article

- [ ] HushAway® in first 500 words
- [ ] Comparison table included (required for brand prominence)
- [ ] Primary keyword in at least one H2
- [ ] Community quote with attribution phrase ("One mum...", "A parent in our community...")
- [ ] All citations have hyperlinks (E-E-A-T requirement)
- [ ] `[LINK TO:]` placeholders = 4+ (cluster) or 8+ (hub)
- [ ] Total contractions meet formula: (count × 500 / words) ≥ 2

### Gate Efficiency

On 2nd+ gate runs, use `--remediate` flag to reduce output:
```bash
.claude/scripts/master-gate.sh [file] [type] --remediate
```

---

## After Skill Completes

**Run gate script with --summary (default):**
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster] --summary
```

**MUST show:** `CONTENT GATE: PASS`

If gate shows FAIL:
1. Run without `--summary` to see full details
2. Fix ALL failures listed
3. Re-run with `--remediate` flag
4. Repeat until PASS

---

## Common Failures

**Previously caught by quick-check (10 checks):**
- Using banned AI-isms (navigate, delve, comprehensive)
- Exceeding frequency limits (too many "specifically", "helpful")
- Missing contractions or And/But starters
- HushAway without ® symbol
- Missing community quotes

**NEW: Now also caught by quick-check (6 additional checks):**
- Deficit language ("disability", "fix", "cure", "normal")
- Too many hedges (may, might, could, potentially, often)
- Stacked hedges (2+ hedges in one sentence)
- 3+ paragraphs starting with same word in a section
- Primary keyword missing from all H2 headings
- Meta description outside 140-160 character range
- Commitment language in tables (subscription, trial, premium)
