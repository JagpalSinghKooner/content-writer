# Internal Linking Strategy

Internal links are added at different times depending on link type:

- **Links TO pillar guide:** Add after pillar guide is published. Go back and update all supporting articles.
- **Links BETWEEN supporting articles:** Add during writing if target exists, or after both are published. Use placeholder if target doesn't exist yet.
- **Links FROM pillar guide:** Add during pillar guide writing. All supporting articles exist at this point.
- **Links FROM outside pillar:** Add after pillar is complete (cross-pillar linking pass).

## Placeholder Convention

When referencing an article that doesn't exist yet, use this placeholder:

```html
<!-- LINK NEEDED: [slug] when published -->
```

**Example:** Writing article 01 and want to reference article 05:

```markdown
For advanced techniques, see our guide on automation workflows<!-- LINK NEEDED: 05-automation-workflows when published -->.
```

## Post-Pillar Linking Pass

After the pillar guide is published, run a linking pass:
1. Replace all `<!-- LINK NEEDED: ... -->` placeholders with actual links
2. Add links TO the pillar guide from all supporting articles
3. Update frontmatter `internal_links` arrays
4. Verify no broken links remain

---

## Cross-Pillar Linking

Cross-pillar links connect related content across different topic clusters. Use them sparingly—each article should primarily link within its own pillar.

### When to Cross-Link

- Topics naturally overlap (e.g. AI marketing tools article links to automation pillar guide)
- Article mentions a concept from another pillar (e.g. SEO article references email marketing best practices)
- Supporting article could benefit from a related pillar guide (e.g. how-to article links to guide in adjacent topic)

### Cross-Pillar Linking Pass

After completing the current pillar:
1. Review other completed pillars for linking opportunities
2. Add 1-2 cross-pillar links maximum per article (more dilutes internal link equity)
3. Update frontmatter `internal_links` arrays with new cross-pillar links
4. Use anchor text that clarifies the pillar context (not just generic keywords)

### Anchor Text for Cross-Pillar Links

- Good: "our guide to building email sequences" (clarifies different topic)
- Good: "the automation workflow pillar" (explicitly names the pillar)
- Bad: "click here" (no context)
- Bad: "marketing" (too generic)

### Don't Over-Link

- Each article primarily links within its own pillar (maintains topical authority)
- Cross-pillar links are supplementary, not primary
- If you're adding more than 2 cross-pillar links, reconsider
