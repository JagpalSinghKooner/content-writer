# Plan: Markdown to Framer CMS Export Skill

## Overview

Create a new skill `/export-framer` that converts markdown articles to a CSV file for Framer CMS import.

**Trigger:** Manual only (e.g., "export to Framer", "create Framer import")

**Output:** `{pillar}/framer/import.csv` (one row per article)

---

## CSV Structure

Based on article frontmatter and SEO requirements:

| Column | Source | Description |
|--------|--------|-------------|
| `title` | frontmatter.title | Display title (H1 with hook) |
| `slug` | frontmatter.slug | URL path |
| `meta_title` | frontmatter.meta_title | SEO title (<60 chars) |
| `meta_description` | frontmatter.meta_description | SEO description (140-160 chars) |
| `author` | frontmatter.author | Author name |
| `date` | frontmatter.date | Publication date |
| `categories` | frontmatter.categories | Comma-separated list |
| `tags` | frontmatter.tags | Comma-separated list |
| `primary_keyword` | frontmatter.primary_keyword | Target keyword |
| `og_title` | frontmatter.og_title | Open Graph title |
| `og_description` | frontmatter.og_description | Open Graph description |
| `og_image` | frontmatter.og_image | Open Graph image URL |
| `canonical_url` | frontmatter.canonical_url | Canonical URL (if set) |
| `content` | body (converted) | **HTML-formatted body content** |

---

## HTML Conversion Rules (for `content` column)

| Markdown | Framer HTML |
|----------|-------------|
| `## H2` | `<h2 dir="auto">H2</h2>` |
| `### H3` | `<h3 dir="auto">H3</h3>` |
| Paragraph text | `<p dir="auto">text</p>` |
| `[text](/slug)` (internal) | `<a href="/slug">text</a>` |
| `[text](https://...)` (external) | `<a href="https://..." target="_blank">text</a>` |
| `- bullet item` | `<ul><li data-preset-tag="p"><p dir="auto">text</p></li></ul>` |
| `1. numbered item` | `<ol><li data-preset-tag="p"><p dir="auto">text</p></li></ol>` |
| `**bold**` | `<strong>bold</strong>` |
| `*italic*` | `<em>italic</em>` |

**Link Rules:**
- **Internal links** (start with `/`) → NO `target="_blank"` (stays in same tab)
- **External links** (start with `http://` or `https://`) → ADD `target="_blank"` (opens new tab)

**Note:** H1 is NOT included in content - it goes in the `title` column.

---

## Files to Create

### 1. `.claude/skills/export-framer/SKILL.md`

Main skill file (~500 lines) containing:
- Frontmatter (name, description, triggers)
- CSV column specifications
- HTML conversion rules with examples
- Step-by-step workflow
- Example input/output

---

## Skill Workflow

1. **Input:** Pillar path or article path
   - Single article: `export-framer articles/01-adhd-child-wont-sleep.md`
   - Whole pillar: `export-framer` (exports all articles in current pillar)

2. **Read:** For each article:
   - Parse YAML frontmatter → CSV columns
   - Parse body content → convert to HTML

3. **Convert Body:** Transform markdown to Framer HTML
   - Skip frontmatter
   - Process headings (H2, H3 only - H1 is title field)
   - Process paragraphs with `<p dir="auto">`
   - Process links with `target="_blank"`
   - Process lists with `data-preset-tag="p"` structure

4. **Output:** Save CSV to `{pillar}/framer/import.csv`
   - Create `framer/` directory if needed
   - CSV with headers matching Framer CMS collection fields
   - One row per article

---

## Output File Structure

```
{pillar}/
├── articles/
│   ├── 01-adhd-child-wont-sleep.md
│   ├── 02-adhd-bedtime-routine.md
│   └── ...
├── distribution/
│   └── ...
└── framer/                          ← NEW
    └── import.csv                   ← All articles in one file
```

---

## Example Conversion

**Input Article Frontmatter:**
```yaml
title: "Why Your ADHD Child Won't Sleep (And What Actually Helps)"
meta_title: "Why Your ADHD Child Won't Sleep | What Actually Works"
meta_description: "Your ADHD child won't sleep because..."
slug: "adhd-child-wont-sleep"
author: "HushAway"
date: "2026-02-03"
categories:
  - "ADHD Sleep"
tags:
  - "adhd sleep"
  - "adhd children"
```

**Input Body (Markdown):**
```markdown
You've done everything right.

Bath. Story. Same time every night.

## Why Generic Sleep Advice Fails ADHD Children

Every sleep guide says the same things.

- Consistent bedtime
- Cool room
- No screens before bed
```

**Output CSV Row:**
```csv
title,slug,meta_title,meta_description,author,date,categories,tags,primary_keyword,og_title,og_description,og_image,canonical_url,content
"Why Your ADHD Child Won't Sleep (And What Actually Helps)","adhd-child-wont-sleep","Why Your ADHD Child Won't Sleep | What Actually Works","Your ADHD child won't sleep because...","HushAway","2026-02-03","ADHD Sleep","adhd sleep, adhd children","adhd child won't sleep","...","...","","","<p dir=""auto"">You've done everything right.</p><p dir=""auto"">Bath. Story. Same time every night.</p><h2 dir=""auto"">Why Generic Sleep Advice Fails ADHD Children</h2><p dir=""auto"">Every sleep guide says the same things.</p><ul><li data-preset-tag=""p""><p dir=""auto"">Consistent bedtime</p></li><li data-preset-tag=""p""><p dir=""auto"">Cool room</p></li><li data-preset-tag=""p""><p dir=""auto"">No screens before bed</p></li></ul>"
```

**Note:** Quotes in CSV content are escaped as `""` per CSV spec.

---

## Edge Cases

1. **FAQ sections** - H3 questions + paragraph answers (standard conversion)
2. **Internal links** - Keep `/slug` format, no `target="_blank"`
3. **External links** - Full URL with `target="_blank"`
4. **Multiple articles** - All go into single CSV, one row each
5. **Empty fields** - Leave blank in CSV (not "null" or "undefined")
6. **Commas in content** - CSV escaping handles automatically
7. **Newlines in HTML** - Remove or convert to space (single-line HTML per cell)

---

## Verification

After implementation:
1. Run `/export-framer` on the adhd-sleep pillar
2. Open CSV in spreadsheet to verify columns and content
3. Import CSV into Framer CMS
4. Check that:
   - All metadata fields populate correctly
   - HTML content renders properly in Framer
   - Internal links (`/slug`) have NO `target="_blank"`
   - External links (`https://...`) have `target="_blank"`
   - Headings have `dir="auto"`

---

## Implementation Steps

1. Create `.claude/skills/export-framer/SKILL.md` with full documentation
2. Test on adhd-sleep pillar (7 articles)
3. Import test CSV into Framer to verify compatibility
