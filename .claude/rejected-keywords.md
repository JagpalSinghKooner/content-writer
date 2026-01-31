# Rejected Keyword Library

**Purpose:** Track keywords that were researched but rejected. Prevents re-research and documents revisit strategies.

**Updated:** 2026-01-30

---

## Rejected Keywords

| Keyword | Date | Rejection Reason | Volume | Score | Revisit |
|---------|------|------------------|-------:|------:|---------|
| | | | | | |

**Note:** This table is auto-populated by the keyword gate script when keywords fail validation.

---

## Revisit Classifications

| Classification | Meaning | Action |
|----------------|---------|--------|
| No | Fundamentally unviable | Never revisit - volume or score too low |
| Never | Brand/value conflict | Permanently blocked - moved to negative-keywords.md |
| Merge | Should be secondary keyword | Add as secondary to existing article |
| Monitor | May become viable | Check quarterly for trend/score changes |
| If [condition] | Conditionally viable | Revisit when specific condition is met |
| Seasonal | Cyclically viable | Revisit 8-12 weeks before peak season |

---

## Rejection Reasons Reference

### Hard Gate Failures

| Reason | Threshold | Revisit Strategy |
|--------|-----------|------------------|
| Volume too low (transactional) | <50 | Monitor - may increase |
| Volume too low (commercial) | <100 | Monitor - may increase |
| Volume too low (info+product) | <200 | Monitor - may increase |
| Volume too low (informational) | <500 | Monitor - may increase |
| Opportunity score too low | <15 | Monitor - difficulty may decrease |
| Insufficient PAA questions | <7 | No - insufficient search interest |
| Insufficient competitor gaps | <2 | No - no differentiation possible |
| Insufficient research sources | <2 | No - weak E-E-A-T potential |
| Low differentiation + high difficulty | Diff <5, KD >40 | If angle found |
| Hub low differentiation | Diff <7 for hub | If angle found |
| Declining trend + marginal score | Declining + score <25 | Monitor |
| Content type incompatible | Shopping/video dominant | If content strategy changes |
| DataForSEO required | API failure | Retry - technical issue |
| Perplexity required | MCP failure | Retry - technical issue |

### Pre-API Rejections

| Reason | Revisit Strategy |
|--------|------------------|
| Brand conflict (deficit language) | Never |
| Medical overreach | Never |
| Off-topic (not target audience) | Never |
| Harmful practices | Never |
| In negative keyword library | Check if temporary |
| Previously rejected | Check revisit classification |
| Format invalid (sentence) | No - not a keyword |

---

## Quarterly Review Process

Every quarter (Jan, Apr, Jul, Oct):

1. Filter table for "Monitor" and "If [condition]" classifications
2. Re-validate keywords that may have become viable:
   - Volume increases
   - Difficulty decreases
   - Trend reversal
   - Condition met
3. Update or remove entries as appropriate
4. Move any new brand conflicts to negative-keywords.md

---

## How to Use This File

### When Adding Rejections (Automated)
The keyword gate script (`check-keyword-gate-v3.sh`) automatically adds entries when:
- A keyword fails hard gate validation
- Pre-API filters detect issues

### When Researching Keywords (Manual Check)
1. Check if keyword exists in this table
2. If found with "Never" revisit: Do not proceed
3. If found with "Monitor": Check if conditions have changed
4. If found with "If [condition]": Check if condition is met
5. If found with "Seasonal": Check if within publish window

### Removing Entries
- Keywords that become viable: Remove from table, proceed with validation
- Keywords that become permanent negatives: Move to negative-keywords.md, remove from here
- Merged keywords: Remove after adding as secondary to target article

---

## Statistics (Auto-Updated)

| Metric | Count |
|--------|------:|
| Total rejected | 0 |
| Never revisit | 0 |
| Monitoring | 0 |
| Conditional | 0 |
| Seasonal | 0 |

---

## Version History

| Date | Change |
|------|--------|
| 2026-01-30 | Initial V3 library created |
