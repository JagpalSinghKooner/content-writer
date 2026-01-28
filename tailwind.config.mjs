/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        // Primary - Sage tones
        sage: {
          DEFAULT: '#7A9E8E',
          50: '#F0F5F3',
          100: '#DCE8E2',
          200: '#BDD4C8',
          300: '#A8C4B8',
          400: '#8EB4A3',
          500: '#7A9E8E',
          600: '#5F7F6F',
          700: '#4A6458',
          800: '#354A41',
          900: '#21302A',
        },
        // Warm neutrals
        linen: '#FAF8F5',
        cream: '#F5F1EC',
        parchment: '#EDE8E1',
        stone: '#D4CEC6',
        // Text colours
        ink: '#2C3E42',
        charcoal: '#4A5568',
        slate: '#718096',
        mist: '#A0AEC0',
        // Accent colours
        coral: {
          DEFAULT: '#E8A598',
          light: '#F2C4BA',
          dark: '#D88A7C',
        },
        lavender: {
          DEFAULT: '#B8A8C8',
          light: '#D4C8E0',
          dark: '#9A88B0',
        },
        amber: {
          DEFAULT: '#E8C478',
          light: '#F2D89C',
          dark: '#D4B060',
        },
        mint: {
          DEFAULT: '#8FBCAA',
          light: '#B0D4C6',
          dark: '#6FA490',
        },
      },
      fontFamily: {
        heading: ['Fraunces', 'Georgia', 'serif'],
        body: ['Source Sans 3', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      fontSize: {
        'xs': ['0.75rem', { lineHeight: '1.5' }],
        'sm': ['0.875rem', { lineHeight: '1.5' }],
        'base': ['1rem', { lineHeight: '1.8' }],
        'lg': ['1.125rem', { lineHeight: '1.75' }],
        'xl': ['1.25rem', { lineHeight: '1.6' }],
        '2xl': ['1.5rem', { lineHeight: '1.4' }],
        '3xl': ['1.875rem', { lineHeight: '1.3' }],
        '4xl': ['2.25rem', { lineHeight: '1.2' }],
        '5xl': ['3rem', { lineHeight: '1.1' }],
      },
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '128': '32rem',
      },
      maxWidth: {
        'article': '680px',
        'content': '1200px',
      },
      borderRadius: {
        'xl': '12px',
        '2xl': '16px',
        '3xl': '24px',
      },
      boxShadow: {
        'soft': '0 2px 8px rgba(44, 62, 66, 0.06)',
        'medium': '0 4px 16px rgba(44, 62, 66, 0.08)',
        'large': '0 8px 32px rgba(44, 62, 66, 0.12)',
      },
      typography: ({ theme }) => ({
        DEFAULT: {
          css: {
            '--tw-prose-body': theme('colors.charcoal'),
            '--tw-prose-headings': theme('colors.ink'),
            '--tw-prose-links': theme('colors.sage.DEFAULT'),
            '--tw-prose-bold': theme('colors.ink'),
            '--tw-prose-quotes': theme('colors.charcoal'),
            '--tw-prose-quote-borders': theme('colors.coral.DEFAULT'),
            '--tw-prose-counters': theme('colors.slate'),
            '--tw-prose-bullets': theme('colors.sage.DEFAULT'),
            '--tw-prose-hr': theme('colors.parchment'),
            '--tw-prose-th-borders': theme('colors.stone'),
            '--tw-prose-td-borders': theme('colors.parchment'),
            maxWidth: '680px',
            fontSize: '1.0625rem',
            lineHeight: '1.8',
            a: {
              color: theme('colors.sage.DEFAULT'),
              textDecoration: 'none',
              fontWeight: '500',
              '&:hover': {
                textDecoration: 'underline',
                color: theme('colors.sage.600'),
              },
            },
            'h1, h2, h3, h4': {
              color: theme('colors.ink'),
              fontFamily: 'Fraunces, Georgia, serif',
              fontWeight: '600',
            },
            h1: {
              fontSize: '2.25rem',
              marginTop: '0',
              marginBottom: '1.5rem',
            },
            h2: {
              fontSize: '1.75rem',
              marginTop: '2.5rem',
              marginBottom: '1rem',
            },
            h3: {
              fontSize: '1.375rem',
              marginTop: '2rem',
              marginBottom: '0.75rem',
            },
            p: {
              marginTop: '1.25rem',
              marginBottom: '1.25rem',
            },
            blockquote: {
              borderLeftWidth: '4px',
              borderLeftColor: theme('colors.coral.DEFAULT'),
              backgroundColor: theme('colors.cream'),
              padding: '1.25rem 1.5rem',
              borderRadius: '0 12px 12px 0',
              fontStyle: 'italic',
              marginTop: '1.5rem',
              marginBottom: '1.5rem',
              'p:first-of-type::before': { content: 'none' },
              'p:last-of-type::after': { content: 'none' },
            },
            table: {
              fontSize: '0.9375rem',
            },
            thead: {
              borderBottomColor: theme('colors.stone'),
            },
            'thead th': {
              color: theme('colors.ink'),
              fontWeight: '600',
              backgroundColor: theme('colors.cream'),
              padding: '0.75rem 1rem',
            },
            'tbody td': {
              padding: '0.75rem 1rem',
            },
            'tbody tr': {
              borderBottomColor: theme('colors.parchment'),
            },
            'tbody tr:nth-child(even)': {
              backgroundColor: theme('colors.linen'),
            },
            code: {
              color: theme('colors.ink'),
              backgroundColor: theme('colors.cream'),
              padding: '0.2em 0.4em',
              borderRadius: '4px',
              fontWeight: '400',
              fontSize: '0.875em',
            },
            'code::before': { content: 'none' },
            'code::after': { content: 'none' },
            strong: {
              color: theme('colors.ink'),
              fontWeight: '600',
            },
            ul: {
              paddingLeft: '1.5rem',
            },
            'ul > li': {
              paddingLeft: '0.5rem',
            },
            'ul > li::marker': {
              color: theme('colors.sage.DEFAULT'),
            },
            hr: {
              borderColor: theme('colors.parchment'),
              marginTop: '2.5rem',
              marginBottom: '2.5rem',
            },
          },
        },
      }),
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ],
}
