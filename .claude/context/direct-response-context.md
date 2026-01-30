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

### 1. Objection Handling (Need 2 of 4)

| Objection | Counter-Language |
|-----------|------------------|
| "Another app won't help" | passive sound, no engagement, just listen, different from apps |
| "Too tired to try" | zero learning curve, just press play, no setup, instant access |
| "Is this actually different?" | neurodivergent-first, built for, purpose-built, not adapted |
| "What if my child won't use it?" | free forever, nothing to lose, no risk, costs nothing |

### 2. CTA Clarity
- "Free forever" or equivalent must appear
- Use: "free forever", "always free", "completely free"

### 3. Low-Friction Language
- **Use:** just enter your email, instant access, no credit card, magic link
- **Avoid:** free trial, subscribe, sign up for, premium, upgrade

### 4. Differentiation
- Neurodivergent-first positioning must be clear
- 3+ mentions of neurodivergent-specific language

### 5. HushAway® Prominence
- 5+ total mentions
- 2+ mentions in conversion contexts (near "free", "try", "Sound Sanctuary")

### 6. Sound Sanctuary CTA
- 2+ mentions of "Sound Sanctuary" as destination

### 7. Risk Reversal
- 1+ of: "nothing to lose", "no risk", "costs nothing", "no commitment"

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
