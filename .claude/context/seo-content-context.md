# SEO Content Context (HushAway)

**Skill:** /seo-content
**Gate:** Content Gate (master-gate.sh)

---

## MANDATORY: Read Before Writing

**You MUST read these files before generating any content:**

1. **`.claude/scratchpad/research-summary.md`** - Article data
2. **`.claude/rules/humanise-rules.md`** - ALL content rules

**Writing without reading humanise-rules.md WILL result in gate failures.**

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

### Word Frequency Tracking

Track frequency-limited words as you write. See `.claude/rules/humanise-rules.md` Section 2 for:
- Full list of limited words and their maximums
- Scaling rules for articles over 3,500 words

**Most commonly exceeded (quick reference):**
- actually: 2 max
- specifically: 2 max
- helpful: 3 max

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

**Run gate script:**
```bash
.claude/scripts/master-gate.sh [article-file] [hub|cluster]
```

**MUST show:** `GATE STATUS: OPEN`

If gate shows CLOSED:
1. Fix ALL failures listed
2. Re-run script with `--remediate` flag
3. Repeat until OPEN

---

## Common Failures

- Using banned AI-isms (navigate, delve, comprehensive)
- Exceeding frequency limits (too many "specifically", "helpful")
- Missing contractions or And/But starters
- HushAway without ® symbol
- Missing community quotes
- Fewer than minimum word count
