# Negative Keyword Library

**Purpose:** Keywords that should NEVER be targeted, either permanently or temporarily. Check this library BEFORE making API calls to save costs.

**Updated:** 2026-01-30

---

## Permanent Negatives

### Brand Conflict (Deficit Language)

| Keyword | Reason | Added |
|---------|--------|-------|
| cure ADHD | Deficit language - implies ADHD needs curing | 2026-01-30 |
| fix autism | Deficit language - implies autism is broken | 2026-01-30 |
| fix ADHD | Deficit language - implies ADHD is broken | 2026-01-30 |
| normal child ADHD | Deficit language - implies neurodivergent children are abnormal | 2026-01-30 |
| stop ADHD | Deficit language - implies ADHD should be eliminated | 2026-01-30 |
| get rid of ADHD | Deficit language - implies ADHD should be eliminated | 2026-01-30 |
| make child normal | Deficit language - harmful framing | 2026-01-30 |
| ADHD cure apps | Deficit language - no cures exist | 2026-01-30 |
| autism cure | Deficit language - harmful framing | 2026-01-30 |

### Medical Overreach

| Keyword | Reason | Added |
|---------|--------|-------|
| ADHD medication | Medical advice territory - outside brand scope | 2026-01-30 |
| ADHD diagnosis | Medical advice territory - requires healthcare professional | 2026-01-30 |
| autism treatment | Medical advice territory - outside brand scope | 2026-01-30 |
| prescription for ADHD | Medical advice territory - outside brand scope | 2026-01-30 |
| ADHD medication side effects | Medical advice territory - requires healthcare professional | 2026-01-30 |
| Ritalin vs Concerta | Medical advice territory - medication comparison | 2026-01-30 |
| ADHD diagnosis UK cost | Medical advice territory - diagnostic process | 2026-01-30 |
| private ADHD assessment | Medical advice territory - diagnostic process | 2026-01-30 |

### Off-Topic (Not Target Audience)

| Keyword | Reason | Added |
|---------|--------|-------|
| adult ADHD apps | Not target audience - HushAway is for children | 2026-01-30 |
| ADHD workplace | Not target audience - adult/workplace focus | 2026-01-30 |
| teacher ADHD resources | Not target audience - teacher-focused, not parent | 2026-01-30 |
| ADHD school interventions | Not target audience - school/institutional focus | 2026-01-30 |
| ADHD college students | Not target audience - adult focus | 2026-01-30 |
| ADHD dating | Not target audience - adult focus | 2026-01-30 |
| ADHD marriage | Not target audience - adult focus | 2026-01-30 |

### Harmful Practices

| Keyword | Reason | Added |
|---------|--------|-------|
| punish ADHD child | Harmful practice - punishment-based approach | 2026-01-30 |
| force ADHD child | Harmful practice - coercion | 2026-01-30 |
| discipline ADHD | Harmful practice (context-dependent) - often punitive framing | 2026-01-30 |
| consequences ADHD behaviour | Harmful practice - punitive framing | 2026-01-30 |
| make child behave | Harmful practice - compliance-focused | 2026-01-30 |

---

## Temporary Negatives

| Keyword | Reason | Revisit Date | Condition |
|---------|--------|--------------|-----------|
| | | | |

**Note:** Add keywords here that are temporarily blocked due to:
- Competitor-dominated SERPs (review quarterly)
- Resource mismatch (e.g., requires video content)
- Seasonal timing (revisit before peak)

---

## Brand Conflict Detection Patterns

These patterns trigger immediate rejection at Step 0 (Pre-API filters):

### Deficit Language Patterns
```
cure, curing, cured
fix, fixing, fixed (when applied to children/conditions)
treat, treating, treatment (medical context)
disorder (except in educational "what is" context)
normal, abnormal (comparing children)
suffering from
special needs (use "additional needs" or specific terms)
```

### Medical Implication Patterns
```
medication, medicine, meds
diagnosis, diagnose, diagnosed
clinical
prescription, prescribe
therapy (medical therapy - CBT, OT acceptable in educational context)
```

### Harmful Practice Patterns
```
punishment, punish
force, forcing, forced
make them (compliance)
discipline (when punitive)
consequences (when punitive)
```

---

## How to Use This File

### For Pre-API Validation (Step 0)
1. Check seed keyword against "Permanent Negatives" tables
2. Check for pattern matches in "Detection Patterns"
3. Check "Temporary Negatives" for time-blocked keywords
4. If ANY match found: REJECT immediately, do not proceed to API calls

### Adding New Negatives
1. Discover keyword that conflicts with brand values
2. Determine category (brand conflict, medical, off-topic, harmful, temporary)
3. Add to appropriate table with reason and date
4. If temporary: include revisit date and condition

### Removing Negatives
1. Temporary negatives can be removed when condition is met
2. Permanent negatives should NEVER be removed (brand protection)
3. Document removal in version history if needed

---

## Version History

| Date | Change |
|------|--------|
| 2026-01-30 | Initial V3 library created with core patterns |
