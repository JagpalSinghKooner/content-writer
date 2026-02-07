# Article Template

All SEO content articles must output in this format. The YAML frontmatter ensures CMS-ready publishing with complete metadata.

---

## Template

```markdown
---
# Core metadata
title: "[Article Title]"
meta_title: "[SEO title, under 60 characters]"
meta_description: "[150-160 characters with primary keyword]"
slug: "[lowercase-hyphenated-keyword-url]"
author: "[Author name from client profile]"
date: "[YYYY-MM-DD]"
status: "draft | review | published"

# Taxonomy
categories:
  - "[Primary category]"
tags:
  - "[tag1]"
  - "[tag2]"
  - "[tag3]"

# SEO metadata
primary_keyword: "[Main target keyword]"
secondary_keywords_used:
  - "[keyword1]"
  - "[keyword2]"
  - "[keyword3]"
keyword_density: "[X.X%]"
word_count: "[XXXX]"

# Open Graph
og_title: "[Social sharing title, can differ from meta_title]"
og_description: "[Social sharing description]"
og_image: "[URL or path to featured image]"
canonical_url: "[Full canonical URL if different from default]"

# Schema
schema_type: "Article | HowTo | FAQ | Product | Review"

# Links
internal_links:
  - url: "[/path/to/page]"
    anchor: "[anchor text used]"
  - url: "[/path/to/page]"
    anchor: "[anchor text used]"
external_citations:
  - url: "[https://source.com/page]"
    author: "[Author or Organisation]"
    year: "[YYYY]"
    title: "[Source title]"
---

[Article content here]

## Table of Contents (for articles 3000+ words)

- [Section One](#section-one)
- [Section Two](#section-two)
- [Section Three](#section-three)

---

[Full article body with H2/H3 structure]

---

## FAQ

### [Question 1]

[Answer]

### [Question 2]

[Answer]

```

---

## Field Definitions

### Core Metadata
- **title** (required): Article H1, primary headline
- **meta_title** (required): SEO title for search results, max 60 chars
- **meta_description** (required): Search result snippet, 150-160 chars, include keyword
- **slug** (required): URL path, lowercase, hyphenated, include keyword
- **author** (required): Author name from client profile
- **date** (required): Publication date in YYYY-MM-DD format
- **status** (required): draft, review, or published
### Taxonomy
- **categories** (required): Primary content category (1-2)
- **tags** (optional): Topic tags for filtering (3-5 recommended)
### SEO Metadata
- **primary_keyword** (required): Main target keyword for this article
- **secondary_keywords_used** (required): Related keywords naturally included
- **keyword_density** (required): Primary keyword density percentage
- **word_count** (required): Total word count of article body
### Open Graph
- **og_title** (required): Social sharing title (can be more engaging than meta_title)
- **og_description** (required): Social sharing description
- **og_image** (optional): Featured image URL for social cards
- **canonical_url** (optional): Only if different from default URL
### Schema
- **schema_type** (required): Article, HowTo, FAQ, Product, or Review
### Links
- **internal_links** (required): Minimum 3, list with url and anchor text
- **external_citations** (recommended): E-E-A-T sources with author, year, title, URL
