# Conversion Gate (Gate 5) - Automated Verification

**Purpose:** Verify article content will convert readers to Sound Sanctuary sign-ups.

**This gate requires TWO steps:**
1. Run `/direct-response-copy` skill for AI-assisted conversion review
2. Run `check-conversion-gate.sh` script for automated verification

**Script:** `.claude/scripts/check-conversion-gate.sh`

**When to run:** After Content Gate (master-gate.sh) shows PASS, and after running /direct-response-copy skill.

---

## Quick Reference

```bash
# Run after Content Gate passes
.claude/scripts/check-conversion-gate.sh [article-file]

# Example
.claude/scripts/check-conversion-gate.sh src/content/pillar-5-adhd-apps/hub-adhd-apps.md
```

**Exit codes:**
- `0` = PASS (proceed to Final Gate)
- `1` = FAIL (fix issues and re-run)

---

## HushAway® Conversion Model

| Element | Detail |
|---------|--------|
| **Offer** | Free forever access to Sound Sanctuary |
| **Sign-up** | Name + email → magic link sent automatically |
| **Premium** | Coming soon (freemium model) |
| **Barrier** | Zero - no payment, no password, no commitment |

---

## Automated Checks (7 Total)

The script automatically verifies these elements:

### Check 1: Parent Objections (2+ of 4 required)

| Objection | Keywords Detected |
|-----------|-------------------|
| "Another app won't help" | passive sound, no engagement, just listen, without requiring |
| "Too tired to try" | zero learning curve, just press play, no setup, instant access |
| "Is this actually different?" | neurodivergent-first, designed specifically, not adapted, purpose-built |
| "What if my child won't use it?" | free forever, nothing to lose, no risk, costs nothing |

**Minimum:** At least 2 objections must be addressed.

### Check 2: CTA Clarity

**Must include:** "free forever", "forever free", "always free", "completely free", or "100% free"

### Check 3: Low-Friction Language

**Must NOT include:** "free trial", "subscribe", "subscription", "sign up for", "register for", "create account", "premium", "upgrade"

**Should include:** "just email", "instant access", "no credit card", "no payment", "magic link"

### Check 4: Neurodivergent-First Differentiation

**Minimum 3 mentions of:** neurodivergent, sensory-friendly, sensory processing, ADHD-friendly, autism-friendly, designed for children who

### Check 5: HushAway® Prominence

- **Minimum 5 mentions** of HushAway® total
- **Minimum 2 mentions** in conversion contexts (near "free", "try", "Sound Sanctuary", "access")

### Check 6: Sound Sanctuary CTA

**Minimum 2 mentions** of "Sound Sanctuary" as the CTA destination

### Check 7: Risk Reversal

**Must include:** "nothing to lose", "no risk", "risk-free", "no commitment", "no obligation", "costs nothing", "free to try"

---

## CTA Patterns

### Good CTAs (Script Validates)
- "Try the Sound Sanctuary free, forever. Just enter your name and email."
- "No subscription needed. No credit card. Just gentle sounds, ready when you need them."
- "See if it helps. It costs nothing to find out."
- "Enter your name and email to get instant access to the Sound Sanctuary."
- "Ready to try something different? The Sound Sanctuary is free, forever."

### Bad CTAs (Script Rejects)
- "Sign up for our premium service"
- "Start your free trial" (implies it ends)
- "Subscribe to get access"
- "Register for an account"
- "Download the app" (without mentioning free)

---

## Verification Process

### Step 1: Run Content Gate First
```bash
.claude/scripts/master-gate.sh "[filename]" [hub|cluster]
```
Content Gate must show PASS before running Conversion Gate.

### Step 2: Run /direct-response-copy Skill
Run the skill for AI-assisted conversion review. This skill runs ONCE per article.

### Step 3: Run Conversion Gate Script
```bash
.claude/scripts/check-conversion-gate.sh [article-file]
```

### Step 4: Fix Any Failures
If script shows FAIL:
1. Review specific failures in output
2. Fix affected sections in article
3. Re-run script (NOT the skill again - skill only runs once)
4. Repeat until PASS

---

## Enforcement

**THIS GATE IS MANDATORY. FULLY AUTOMATED.**

**Two-step process:**
1. **Skill:** `/direct-response-copy` - runs once for AI-assisted review
2. **Script:** `check-conversion-gate.sh` - runs for automated verification (re-run on FAIL)

**Exit codes:**
- **Exit 0:** PASS - proceed to Final Gate
- **Exit 1:** FAIL - fix and re-run script (NOT skill)

**All 7 checks must pass. No manual overrides. No exceptions.**

**Remediation:** If FAIL, fix issues and re-run ONLY the script. The skill runs once.

---

*Document updated: 2026-01-29*
*Status: MANDATORY - Gate 5 of 6 - FULLY AUTOMATED*
