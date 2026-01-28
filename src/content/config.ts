import { defineCollection, z } from 'astro:content';

// Flexible schema that accepts various frontmatter fields
const articles = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    pillar: z.number().optional(),
    pillarName: z.string().optional(),
    articleNumber: z.string().optional(),
    targetKeyword: z.string().optional(),
    secondaryKeywords: z.union([z.string(), z.array(z.string())]).optional(),
    searchVolume: z.string().optional(),
    contentType: z.string().optional(),
    status: z.string().default('draft'),
    wordCount: z.number().default(0),
    minimumWordCount: z.number().optional(),
    priority: z.string().optional(),
    author: z.string().optional(),
    dateCreated: z.coerce.string().optional(),
    dateUpdated: z.coerce.string().optional(),
    datePublished: z.coerce.string().nullable().optional(),
    effectiveDate: z.coerce.string().optional(),
    framerUrl: z.string().nullable().optional(),
  }).passthrough(), // Allow additional fields
});

// All 7 content pillars for SEO articles
export const collections = {
  'pillar-1-adhd-sleep': articles,
  'pillar-2-sleep-apps': articles,
  'pillar-3-anxiety-apps': articles,
  'pillar-4-sensory-apps': articles,
  'pillar-5-adhd-apps': articles,
  'pillar-6-emotional-regulation': articles,
  'pillar-7-neurodivergent-parenting': articles,
};
