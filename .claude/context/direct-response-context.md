# Direct Response Copy Context (HushAway)

**Skill:** /direct-response-copy
**Gate:** Conversion Gate (check-conversion-gate.sh)

---

## Prerequisites

**Content Gate MUST pass before running this skill.**

Run this skill AFTER `/seo-content` passes the Content Gate (master-gate.sh).

---

## Input

**Read:** `.claude/scratchpad/research-summary.md`

Also review the article that just passed Content Gate.

**Product Reference (MANDATORY):** `HushAway.md`

Use the sound library to understand what HushAway® offers:
- Sleep support (Night Time Stories, Sleep audio, Frequencies)
- Sensory calming (ASMR Sounds, ASMR Soundscapes, Kaleidoscopes)
- Focus and regulation (Binaural Beats, Brainwave Beats)
- Daytime calm (Peace Time, Daytime Stories)

**CTAs always point to Sound Sanctuary** - never reference product series names directly. Readers don't know them. Instead, describe the benefit:
- Good: "Explore the Sound Sanctuary for gentle sleep support"
- Bad: "Try the Night Time Stories series"

---

## Purpose

Review article for conversion effectiveness. This skill does NOT rewrite the article - it identifies conversion gaps for you to fix.

---

## 7 Conversion Checks

**Full conversion language requirements:** See `.claude/rules/humanise-rules.md` Section 8 for complete objection handling (4 objections with counter-phrases), CTA patterns, and banned words.

**Quick reference (what gate script checks):**

1. **Objection handling:** 2 of 4 objections addressed with counter-language
2. **CTA clarity:** "free forever" or equivalent present
3. **Low-friction language:** avoid trial, subscribe, premium, upgrade
4. **Differentiation:** 3+ neurodivergent-first mentions
5. **HushAway® prominence:** 5+ total, 2+ in conversion contexts
6. **Sound Sanctuary CTA:** 2+ mentions as destination
7. **Risk reversal:** 1+ of: nothing to lose, no risk, costs nothing

---

## After Skill Completes

**Run gate script with --summary (default):**
```bash
.claude/scripts/check-conversion-gate.sh [article-file] --summary
```

**MUST show:** `CONVERSION GATE: PASS`

If gate shows FAIL:
1. Run without `--summary` to see full details
2. Fix specific failures listed
3. Re-run with `--remediate` flag
4. Repeat until PASS

---

## Common Failures

- Fewer than 2 objections addressed
- Missing "free forever" language
- Using commitment language (trial, subscribe)
- HushAway not in conversion contexts
- Missing Sound Sanctuary mentions
- No risk reversal language

### Table Content Restrictions (CRITICAL)

**Commitment words are banned EVERYWHERE, including comparison tables.**

The conversion gate scans ALL text including table cells. Words that trigger failure:

| Avoid | Use Instead |
|-------|-------------|
| subscription, subscription-based | paid monthly |
| subscribe | join, access |
| trial, free trial | free tier |
| premium | full version |
| upgrade | access more |
| sign up, register | enter your email |

**Example fix from Article 5.3:**
- Failed: "subscription-based" in comparison table
- Fixed: "paid monthly"
