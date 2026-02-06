# Project Tasks: Content-Writer System

## Summary

| Task | Status |
|------|--------|
| Tasks 20-25h: Audit System Build + Full Audit | PASS (all completed) |
| Task 26: Auto-Fix All Pillars + Extract Patterns | superseded |
| Task 27: Fix Content-Validator Em Dash Detection | PASS |
| Task 28: Fix SEO-Writer Agent Citation Format + URL Verification | PASS |
| Task 29: Fix Em Dashes — ADHD Sleep Article 01 | PASS |
| Task 30: Fix Em Dashes — ADHD Sleep Article 02 | PASS |
| Task 31: Fix Em Dashes — ADHD Sleep Article 03 | PASS |
| Task 32: Fix Em Dashes — ADHD Sleep Article 04 | PASS |
| Task 33: Fix Em Dashes — ADHD Sleep Article 05 | PASS |
| Task 34: Fix Em Dashes — ADHD Sleep Article 06 | PASS |
| Task 35: Fix Em Dashes — ADHD Sleep Article 07 | PASS |
| Task 36: Fix Em Dashes — Bedtime Routines Article 07 | PASS |
| Task 37: Apply Approved Slug Changes (28 articles) | pending |
| Task 38: Cascade Slug References Across All Files | pending |
| Task 39: Fix Internal Link Format (/{slug}) | pending |
| Task 40: Fix HushAway Internal URL | pending |
| Task 41: Add Missing Bidirectional Guide Links (14 articles) | pending |
| Task 42: Fix Clinical Terminology | pending |
| Task 43: Delete Stale Validation Files | pending |
| Task 44: Full Re-Audit All 57 Articles | pending |
| Task 45: Regenerate Cross-Pillar Summary + Create PR | pending |

### Completed Work (Tasks 20-25h)

Built the audit system (link-auditor agent, consistency-checker agent, audit-pillar skill) and ran validation-only audits across all 8 HushAway pillars (57 articles, 155,336 words). Results: 9 PASS, 48 FAIL. App Comparisons auto-fixed (51 link format issues corrected). Cross-pillar summary compiled at `projects/hushaway/seo-content/cross-pillar-summary.md`.

### Verified Issue Scale (from raw grep, not audit tool)

| Issue | Real Count | Source |
|-------|:----------:|--------|
| Em dashes | ~~172~~ 0 remaining | `grep "—"` across all articles |
| Non-compliant slugs | 28 articles | Frontmatter extraction of all 57 |
| Internal link format wrong | ~314 links across 7 pillars | Cross-pillar summary |
| Missing guide links | 14 articles across 4 pillars | Link auditor |
| Clinical terminology | ~30 instances across 2 pillars | Consistency checker |
| Stale validation files | 6 files | Git status |
| Broken HushAway URL | 1 | Citation check |

**Deferred:** 19 broken citation URLs (404s) — separate future task.

### Execution Rules

- **Branch:** `fix/cross-pillar-cleanup` (single branch, single PR)
- **Verification:** Raw grep output for every task (no relying on audit tool)
- **Sequence:** One task at a time, verify, commit, then next
- **Filenames:** Keep current filenames, only change frontmatter slugs
- **Plan file:** `~/.claude/plans/fluffy-fluttering-peach.md` (includes slug mapping table)

---

## Task 26: Auto-Fix All Pillars + Extract Patterns

**Objective:** Run auto-fix mode across all pillars, fix validation issues, and extract recurring patterns to common-mistakes.md.

**Status:** superseded (replaced by Tasks 27-45 after investigation revealed the audit missed 172 em dashes, 28 non-compliant slugs were actually 28, and the seo-writer agent had a citation format bug)

---

## Task 27: Fix Content-Validator Em Dash Detection

**Objective:** Add em dash detection rules to the content-validator agent so future audits catch em dashes. The audit reported 0 em dashes across all 57 articles, but raw grep found 172.

**Acceptance Criteria:**
**Acceptance Criteria:**
- [x] content-validator.md includes em dash (—) detection in validation checks
- [x] Detection covers both the — character and " - " substitute pattern
- [x] Detection is in the correct validation phase (structural checks)
- [x] FAIL severity assigned (per Rule 4b)
- [x] Git commit created

**Starter Prompt:**
> Read `.claude/agents/content-validator.md`. The validator currently misses em dashes entirely (audit reported 0 but grep found 172). Add em dash detection to the validation phases. The validator should: (1) search for the — character (U+2014), (2) search for " - " (space-hyphen-space) as a substitute pattern, (3) flag any occurrence as FAIL per universal-rules.md Rule 4b. Include line numbers in the report. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated section 1.5 of `.claude/agents/content-validator.md` with explicit Grep-based em dash detection. The old instruction was "Scan for em dashes" (vague, agent relied on visual scanning and missed all 172). New instruction mandates using Grep tool for both `—` (U+2014) and ` - ` (space-hyphen-space substitute), with exclusions for YAML frontmatter and markdown list items.
- **Decisions:** Kept the check in Phase 1 (Universal Rules Check) at position 1.5 where it already existed. Added exclusion guidance for space-hyphen-space to prevent false positives on list items.
- **Next:** Task 28 (Fix SEO-Writer citation format + URL verification) or Tasks 29-36 (fix actual em dashes in articles).

---

## Task 28: Fix SEO-Writer Agent Citation Format + URL Verification

**Objective:** Fix two issues in the seo-writer agent: (1) citation template uses em dashes instead of colons, violating Rule 4b, (2) no URL verification before returning PASS, causing 19 broken citation URLs across 7 pillars.

**Acceptance Criteria:**
- [x] Citation format template changed from `[Author], [Year] — [Title](URL)` to `[Author], [Year]: [Title](URL)`
- [x] All citation format examples in the agent spec updated to use colons
- [x] URL verification step added: check each citation URL returns 200 before returning PASS
- [x] 403 responses flagged as WARN (bot protection, likely valid)
- [x] 404 responses flagged as FAIL (broken URL, must replace)
- [x] Git commit created

**Starter Prompt:**
> Read `.claude/agents/seo-writer.md`. Fix two issues: (1) Change ALL citation format references from em dash separator `— [Title](URL)` to colon separator `: [Title](URL)` to match universal-rules.md Rule 6. Search the entire file for em dashes and replace in citation contexts. (2) Add a URL verification step: before the agent returns PASS, it must check that all external citation URLs return HTTP 200. Flag 403s as WARN (bot protection), flag 404s as FAIL (broken). Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated `.claude/agents/seo-writer.md` with two changes: (1) Replaced all 6 em dashes in the file. Citation format on line 63 changed from `— [hyperlinked title](URL)` to `: [hyperlinked title](URL)`. Five other em dashes (descriptive separators on lines 20-21 and 33-35) replaced with parenthetical format to comply with Rule 4b. (2) Added new section "6. Verify Citation URLs" between Output and Return Format. Agent must now check every citation URL before returning PASS, with a status table (200=PASS, 403=WARN, 404=FAIL with replacement required, 5xx/timeout=WARN). Return format updated to support WARN annotations.
- **Decisions:** Used parenthetical format `(description)` instead of colons for non-citation em dashes, keeping consistency with the descriptive style. 5xx and timeout responses treated as WARN (not FAIL) since they're typically temporary.
- **Next:** Tasks 29-36 (fix em dashes in actual articles) or Task 37 (slug changes).

---

## Task 29: Fix Em Dashes — ADHD Sleep Article 01

**Objective:** Remove all 21 em dashes from `01-adhd-child-wont-sleep.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 21 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/01-adhd-child-wont-sleep.md`. Find all 21 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: e.g. "You can hear them up there — tossing, turning" → restructure the sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons in body text — rewrite the sentence so it reads naturally without any dash. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all 21 em dashes from `01-adhd-child-wont-sleep.md`. 3 citation-format em dashes replaced with colons (lines 82, 104, 124). 18 body-text em dashes restructured into natural sentences (split into separate sentences, removed parenthetical asides, etc.).
- **Decisions:** Body text restructures used sentence splits (periods) rather than punctuation swaps. Quote on line 92 restructured with "because" to maintain natural speech pattern. Line 118 (double em dash parenthetical) rewritten as staccato fragments for emphasis.
- **Next:** Task 30 (Fix em dashes in ADHD Sleep Article 02, 31 em dashes).

## Task 30: Fix Em Dashes — ADHD Sleep Article 02

**Objective:** Remove all 31 em dashes from `02-adhd-bedtime-routine.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 31 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/02-adhd-bedtime-routine.md`. Find all 31 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all em dashes from 31 lines in `02-adhd-bedtime-routine.md`. 4 citation-format em dashes replaced with colons (lines 92, 110, 122, 132). 6 time-label em dashes replaced with colons (lines 130, 134, 138, 142, 148, 156). 21 body-text em dashes restructured into natural sentences (split into separate sentences, rewrote parenthetical asides, converted inline lists).
- **Decisions:** Time labels (e.g. `**6:30pm — Physical wind-down**`) treated as a third category alongside citations and body text. Colons are the natural format for schedule labels. Line 268 (triple em dash) fully restructured into staccato fragments for emotional impact rather than keeping the listing pattern.
- **Next:** Task 31 (Fix em dashes in ADHD Sleep Article 03, 25 em dashes).

## Task 31: Fix Em Dashes — ADHD Sleep Article 03

**Objective:** Remove all 25 em dashes from `03-calming-sounds-adhd.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 25 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/03-calming-sounds-adhd.md`. Find all 25 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all 25 em dashes from `03-calming-sounds-adhd.md`. Citation em dashes converted to colons. Body text em dashes restructured naturally. Grep confirms 0 remain. Committed as `e7829ab`.
- **Decisions:** Followed same patterns as prior articles (sentence splits for standalone clauses, commas for natural continuations, colons for citations).
- **Next:** Task 32 (Fix em dashes in ADHD Sleep Article 04).

## Task 32: Fix Em Dashes — ADHD Sleep Article 04

**Objective:** Remove all 21 em dashes from `04-adhd-racing-thoughts.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 21 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/04-adhd-racing-thoughts.md`. Find all 21 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all em dashes from 04-adhd-racing-thoughts.md. 3 citation em dashes converted to colon format (lines 90, 102, 138). 18 body text em dashes restructured as separate sentences, punchy fragments, or reworded phrases. Grep confirms 0 remain. Committed as `4e94ad2`.
- **Decisions:** Line 102 had two em dashes framing a citation link — restructured to separate the introductory sentence from the citation. Line 120 converted to punchy single-word fragments for rhythm. Line 201 switched from third-person "parents" framing to direct "you" address to match article voice.
- **Next:** Task 33 — Fix em dashes in 05-beyond-melatonin.md (5 em dashes).

---

## Task 33: Fix Em Dashes — ADHD Sleep Article 05

**Objective:** Remove all 5 em dashes from `05-beyond-melatonin.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 5 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/05-beyond-melatonin.md`. Find all 5 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all 5 em dashes from `05-beyond-melatonin.md`. 1 citation em dash replaced with colon (line 111, DISCA citation). 4 body text em dashes restructured: line 75 (comma join), line 215 (split to separate sentence), line 226 (comma join), line 256 (split to separate sentence). Grep confirms 0 remain. Committed as `b710dbe`.
- **Decisions:** Lines 75 and 226 used commas because the clause was a natural continuation. Lines 215 and 256 used sentence splits because the second clause was strong enough to stand alone.
- **Next:** Task 34 (Fix em dashes in ADHD Sleep Article 06, 24 em dashes).

## Task 34: Fix Em Dashes — ADHD Sleep Article 06

**Objective:** Remove all 24 em dashes from `06-adhd-sleep-vs-autism-sleep.md` by restructuring sentences (body text) and replacing with colons (citations).

**Acceptance Criteria:**
- [x] All 24 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/06-adhd-sleep-vs-autism-sleep.md`. Find all 24 em dashes (—). Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all 24 em dashes from `06-adhd-sleep-vs-autism-sleep.md`. 4 citation em dashes replaced with colons (lines 79, 103, 122, 167). 20 body text em dashes restructured: sentence splits for standalone clauses (lines 73, 85, 129, 133, 139, 145, 165, 191, 234), period-separated list labels (lines 178-181), and reworded phrasing for parenthetical asides (lines 107, 216, 220, 224, 238, 262). Grep confirms 0 remain. Committed as `9b20cf4`.
- **Decisions:** Line 73 (double em dash framing "your child won't sleep") split into three punchy sentences. Lines 178-181 (numbered list with bold labels) used periods after bold text instead of em dashes. Line 224 (double em dash parenthetical defining "passive listening") restructured by moving the definition to a second sentence.
- **Next:** Task 35 (Fix em dashes in ADHD Sleep Article 07, 44 em dashes — highest count article).

---

## Task 35: Fix Em Dashes — ADHD Sleep Article 07

**Objective:** Remove all 44 em dashes from `07-adhd-sleep-problems-guide.md` by restructuring sentences (body text) and replacing with colons (citations). This is the highest count article.

**Acceptance Criteria:**
- [x] All 44 em dashes removed from article
- [x] Citation em dashes replaced with colons: `[Author], [Year]: [Title](URL)`
- [x] Body text em dashes restructured into separate sentences or natural alternatives (not just swapped for commas/colons)
- [x] Content meaning preserved — no information lost
- [x] Grep for "—" in file returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/adhd-sleep/articles/07-adhd-sleep-problems-guide.md`. Find all 44 em dashes (—). This is the pillar guide with the highest em dash count. Two types exist: (1) Citation format: `Research from X, 2024 — [Title](URL)` → replace `—` with `:` so it becomes `Research from X, 2024: [Title](URL)`. (2) Body text: restructure each sentence naturally per Rule 4b. Do NOT just swap em dashes for commas or colons — rewrite naturally. After all changes, run grep for "—" to verify 0 remain. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed all 44 em dashes from `07-adhd-sleep-problems-guide.md`. 6 citation em dashes replaced with colons (lines 104, 118, 126, 138, 181, 213). Line 118 had two em dashes framing a citation link (University of Nottingham / Wellcome Trust) and was restructured to match the standard citation pattern with year added. 38 body text em dashes restructured: sentence splits for standalone clauses, punchy fragments for emphasis, rewording for parenthetical asides. Grep confirms 0 remain. Committed as `7b88adc`.
- **Decisions:** Line 118 (double em dash around citation) restructured from narrative framing to standard citation format, adding the year (2011) from frontmatter. Line 145 ("That phrase — 'failure on toast' — probably resonates") inverted to lead with the quote. Line 219 (double em dash parenthetical describing input qualities) collapsed into a tighter sentence. Line 432 (double em dash parenthetical) restructured from "Starting X — condition — means Y" to "If you start X, condition, Y" pattern.
- **Next:** Task 36 (Fix 1 em dash in Bedtime Routines Article 07, then FINAL VERIFICATION across all 8 pillars).

---

## Task 36: Fix Em Dashes — Bedtime Routines Article 07

**Objective:** Remove the 1 em dash from `07-complete-guide-bedtime-routines-neurodivergent-children.md`.

**Acceptance Criteria:**
- [x] Em dash removed from article
- [x] Sentence restructured naturally (not just swapped for other punctuation)
- [x] Grep for "—" in file returns 0 matches
- [x] Final check: grep for "—" across ALL articles in entire seo-content/ directory returns 0 matches (confirms all em dashes across all pillars are now gone)
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/bedtime-routines/articles/07-complete-guide-bedtime-routines-neurodivergent-children.md`. Find the 1 em dash (—) and restructure the sentence naturally per Rule 4b. After fixing, run a FINAL VERIFICATION: grep for "—" across ALL article files in the entire `projects/hushaway/seo-content/` directory to confirm 0 em dashes remain in any article across all 8 pillars. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Removed the 1 em dash from line 352 of `07-complete-guide-bedtime-routines-neurodivergent-children.md`. Restructured `"revenge bedtime procrastination" —` into a full stop followed by a new sentence. Final verification: grepped all `**/articles/*.md` files across `projects/hushaway/seo-content/`. Zero em dashes in any article across all 8 pillars (only matches were in `.validation.md` report files). Committed as `ea8120e`.
- **Decisions:** Used full stop + new sentence ("It means staying awake...") rather than a colon, because the definition clause was long enough to stand alone.
- **Next:** Task 37 (Apply approved slug changes to 28 articles).

---

## Task 37: Apply Approved Slug Changes (28 articles)

**Objective:** Update the frontmatter `slug` field in 28 articles per the approved mapping table. Do NOT change filenames.

**Slug Mapping Table:**

| Pillar | # | Current Slug | New Slug | Chars |
|--------|:-:|-------------|----------|:-----:|
| ADHD Sleep | 01 | `adhd-child-wont-sleep` | `why-your-adhd-child-wont-sleep` | 30 |
| ADHD Sleep | 02 | `adhd-bedtime-routine` | `parents-guide-adhd-bedtime-routine` | 35 |
| ADHD Sleep | 03 | `calming-sounds-adhd` | `best-calming-sounds-adhd-children` | 34 |
| ADHD Sleep | 05 | `beyond-melatonin` | `beyond-melatonin-adhd-sleep-alternatives` | 41 |
| ADHD Sleep | 06 | `adhd-sleep-vs-autism-sleep` | `parents-guide-adhd-vs-autism-sleep` | 34 |
| ADHD Sleep | 07 | `adhd-sleep-problems-guide` | `complete-guide-adhd-sleep-problems-uk` | 37 |
| Autistic Meltdowns | 04 | `autism-meltdown-recovery-guide` | `helping-child-recover-after-meltdown` | 36 |
| Autistic Meltdowns | 05 | `autism-meltdown-vs-shutdown-difference` | `understanding-meltdown-vs-shutdown` | 34 |
| Bedtime Routines | 04 | `adhd-bedtime-routine-that-works` | `sound-anchored-adhd-bedtime-routine` | 35 |
| Bedtime Routines | 07 | `complete-guide-bedtime-routines-neurodivergent-children` | `complete-guide-nd-bedtime-routines` | 34 |
| Calming Sounds | 02 | `sleep-sounds-children-which-type-helps` | `guide-matching-sleep-sounds-children` | 36 |
| Calming Sounds | 03 | `asmr-binaural-beats-white-noise-parents-guide-sound-types` | `parents-guide-asmr-children-research` | 36 |
| Calming Sounds | 04 | `calming-sounds-every-situation-anxiety-focus-transitions` | `guide-calming-sounds-every-situation` | 36 |
| Emotional Reg | 03 | `emotional-regulation-adhd-children` | `tools-emotional-regulation-adhd-children` | 41 |
| Emotional Reg | 04 | `calm-corner-sounds-children` | `guide-calm-corner-sounds-children` | 34 |
| Sensory Overload | 01 | `01-understanding-sensory-overload-children` | `understanding-sensory-overload-children` | 39 |
| Sensory Overload | 02 | `02-guide-calming-sounds-sensory-overload` | `guide-calming-sounds-sensory-overload` | 37 |
| Sensory Overload | 03 | `03-sound-sensitivity-children-auditory-hypersensitivity` | `understanding-sound-sensitivity-children` | 41 |
| Sensory Overload | 04 | `04-understanding-after-school-sensory-overload` | `understanding-after-school-sensory-overload` | 44 |
| Sensory Overload | 05 | `05-sensory-tools-children-sound-works` | `sensory-tools-children-why-sound-works` | 38 |
| Sensory Overload | 06 | `06-sensory-diet-children-missing-system` | `sensory-diet-children-missing-system` | 36 |
| Sensory Overload | 07 | `07-recovering-sensory-overload-hours-after` | `recovering-sensory-overload-hours-after` | 39 |
| Sensory Overload | 08 | `08-complete-guide-sensory-overload-children` | `complete-guide-sensory-overload-children` | 40 |
| Sound Therapy | 03 | `binaural-beats-children` | `safety-guide-binaural-beats-children` | 36 |
| Sound Therapy | 06 | `sound-therapy-vs-music-therapy` | `parents-guide-sound-vs-music-therapy` | 36 |
| Sound Therapy | 07 | `07-complete-guide-sound-therapy-children` | `complete-guide-sound-therapy-children` | 37 |
| App Comparisons | 04 | `honest-comparison-moshi-vs-calm-vs-headspace-nd-kids` | `comparing-moshi-calm-headspace-nd-kids` | 38 |
| App Comparisons | 05 | `free-calming-apps-kids-uk` | `guide-free-calming-apps-kids-uk` | 31 |

**Acceptance Criteria:**
- [x] All 28 articles have new slug in frontmatter `slug:` field
- [x] Grep for each of the 28 old slugs in frontmatter returns 0 matches
- [x] Grep for each new slug returns exactly 1 match per slug
- [x] All new slugs are under 50 characters
- [x] No filenames changed
- [x] Git commit created

**Starter Prompt:**
> Apply the slug mapping table from TASKS.md Task 37. For each of the 28 articles, edit ONLY the frontmatter `slug:` field to the new value. Do NOT rename any files. After all changes, verify: (1) grep for each old slug value in frontmatter across all articles — expect 0, (2) grep for each new slug — expect exactly 1 match each. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated frontmatter `slug:` field in all 28 articles across 8 pillars (ADHD Sleep: 6, Autistic Meltdowns: 2, Bedtime Routines: 2, Calming Sounds: 3, Emotional Regulation: 2, Sensory Overload: 8, Sound Therapy: 3, App Comparisons: 2). No filenames changed. Verified: all 28 old slugs return 0 frontmatter matches, all 28 new slugs return exactly 1 match each. Committed as `fb15cba`.
- **Decisions:** Only frontmatter `slug:` fields edited. Internal links and other references to old slugs still use old values (Task 38 handles cascading those changes).
- **Next:** Task 38 (Cascade slug references across all files — update internal links, frontmatter `internal_links` arrays, and distribution `source_article` fields to use the new slugs).

---

## Task 38: Cascade Slug References Across All Files

**Objective:** Update all references to the 28 changed slugs across all articles, frontmatter `internal_links` arrays, and distribution files. Uses the mapping table from Task 37.

**Acceptance Criteria:**
- [x] All internal links in article bodies using old slugs updated to new slugs
- [x] All frontmatter `internal_links` arrays updated with new slugs
- [x] All distribution file `source_article` frontmatter fields updated
- [x] Grep for each of the 28 old slugs across entire `projects/hushaway/seo-content/` directory returns 0 matches
- [x] No broken links introduced (every link slug matches a known frontmatter slug)
- [x] Git commit created

**Starter Prompt:**
> Using the old-to-new slug mapping table from Task 37 in TASKS.md, search the entire `projects/hushaway/seo-content/` directory for any reference to each of the 28 old slugs. Replace with the corresponding new slug. Check these locations: (1) article body markdown links `](/old-slug)`, (2) frontmatter `internal_links` arrays, (3) distribution file `source_article` fields. After all replacements, verify: grep for each old slug across the entire seo-content directory — expect 0 matches for every single old slug. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Updated all references to the 28 changed slugs across 25 files in the seo-content directory. Article files (8): updated internal links and frontmatter internal_links arrays in emotional-regulation and sound-therapy articles. Audit/report files (11): updated slug references in audit-summary.md, consistency-check.md, link-audit.md, and cross-pillar-summary.md across all 8 pillars. Validation files (5): updated autistic-meltdowns validation files. Distribution source_article fields were already correct (updated during Task 37). Committed as `216e987`.
- **Decisions:** Preserved PROJECT-TASKS.md (historical tracking) and filename references in reports (filenames not changing per Task 37). Old slugs appearing as substrings of new slugs were correctly handled (not double-replaced). "Found" descriptions in audit reports that document what was literally in the article files at audit time were left as-is when they describe the file path (not the slug).
- **Next:** Task 39 (Fix internal link format — convert directory-structure URLs like `/pillar/articles/nn-slug` to `/{slug}` format across 7 pillars).

---

## Task 39: Fix Internal Link Format (/{slug})

**Objective:** Convert all internal links from directory-structure format to `/{slug}` format across 7 pillars (App Comparisons already fixed in Task 25).

**Patterns to fix:**
- `](/adhd-sleep/articles/{nn}-{slug})` → `](/{slug})`
- `](/autistic-meltdowns/articles/{nn}-{slug})` → `](/{slug})`
- `](/sensory-overload/articles/{nn}-{slug})` → `](/{slug})`
- `](/calming-sounds/articles/{nn}-{slug})` → `](/{slug})`
- `](/emotional-regulation/articles/{nn}-{slug})` → `](/{slug})`
- `](/bedtime-routines/articles/{nn}-{slug})` → `](/{slug})`
- `](/sound-therapy/articles/{nn}-{slug})` → `](/{slug})`
- Also: `](/{pillar}/{slug})` → `](/{slug})`
- Also: strip any `nn-` number prefix from slugs in links

**Acceptance Criteria:**
- [x] All internal links follow `/{slug}` format (single path segment after leading slash)
- [x] No directory paths remain in any internal link URL
- [x] No file extensions (.md) in any link URL
- [x] No number prefixes (01-, 02-, etc.) in any link slug
- [x] Grep for `/adhd-sleep/` in markdown links returns 0
- [x] Grep for `/autistic-meltdowns/` in markdown links returns 0
- [x] Grep for `/sensory-overload/` in markdown links returns 0
- [x] Grep for `/calming-sounds/` in markdown links returns 0
- [x] Grep for `/emotional-regulation/` in markdown links returns 0
- [x] Grep for `/bedtime-routines/` in markdown links returns 0
- [x] Grep for `/sound-therapy/` in markdown links returns 0
- [x] Every resulting link slug matches a known frontmatter slug from an actual article
- [x] Git commit created

**Starter Prompt:**
> Fix internal link format across 7 pillars in `projects/hushaway/seo-content/` (App Comparisons already done). For each article, find all markdown links that use directory-structure URLs like `](/pillar/articles/nn-slug)` or `](/pillar/slug)` and replace with `](/slug)`. Strip any number prefixes (01-, 02-, etc.) from the slug portion. After all changes, verify: (1) grep for each pillar name followed by `/` in markdown link URLs — expect 0 matches for all 7 pillars, (2) cross-reference every resulting link slug against the master list of all 57 frontmatter slugs to confirm no broken links. Commit when done.

**Status:** PASS

---

**Handoff:**
- **Done:** Fixed internal link format across all 8 pillars (7 remaining + 1 leftover in App Comparisons). 50 files modified total (46 articles/distribution + 4 additional broken slug fixes). Converted 61 unique URL patterns from directory-structure format (`/pillar/articles/nn-slug`, `/pillar/nn-slug`, `/pillar/slug`) to clean `/{slug}` format. Also fixed 4 instances of `/adhd-racing-thoughts` (wrong slug) → `/quieting-adhd-racing-thoughts-bedtime` (correct frontmatter slug).
- **Decisions:** Left `/the-open-sanctuary` links untouched (2 occurrences) — these are CMS product links, not article slugs. Left `.validation.md` files untouched (old artifacts, not publishable content). Mapped old file-based slugs to current frontmatter slugs where they differed (e.g., `02-what-to-play-during-meltdown` → `sounds-to-play-autism-meltdown`).
- **Next:** Task 40 (Fix HushAway Internal URL — replace `the-open-sanctuary` with waitlist URL in emotional-regulation article 05).

---

## Task 40: Fix HushAway Internal URL

**Objective:** Replace the broken `hushaway.com/the-open-sanctuary/` URL with the correct waitlist URL `https://www.hushaway.com/join-the-waitlist` in Emotional Regulation article 05.

**Acceptance Criteria:**
- [x] URL replaced in `projects/hushaway/seo-content/emotional-regulation/articles/05-co-regulation-through-sound-parent-child.md`
- [x] New URL is `https://www.hushaway.com/join-the-waitlist`
- [x] Grep for "the-open-sanctuary" across ALL articles returns 0 matches
- [x] Git commit created

**Starter Prompt:**
> Read `projects/hushaway/seo-content/emotional-regulation/articles/05-co-regulation-through-sound-parent-child.md`. Find the reference to `hushaway.com/the-open-sanctuary/` and replace the full URL with `https://www.hushaway.com/join-the-waitlist`. After fixing, grep for "the-open-sanctuary" across all articles in the entire seo-content directory to confirm 0 matches. Commit when done.

**Status:** PASS

**Handoff:**
- **Done:** Replaced all `the-open-sanctuary` URLs across 3 articles: emotional-regulation/05 (2 full URLs), autistic-meltdowns/02 (1 frontmatter + 1 body link), app-comparisons/02 (1 frontmatter + 1 body link). All now point to `https://www.hushaway.com/join-the-waitlist`. Grep confirms 0 matches in articles (remaining matches only in audit/summary report files).
- **Decisions:** Updated all 3 articles, not just article 05, to achieve 0 grep matches across all articles. Kept anchor text "The Open Sanctuary" unchanged. Left audit-summary.md and link-audit.md references untouched (historical reports, not publishable content).
- **Next:** Task 41 (Add Missing Bidirectional Guide Links).

---

## Task 41: Add Missing Bidirectional Guide Links (14 articles)

**Objective:** Add a contextual link to the pillar guide in 14 articles that are missing it. Each supporting article should link to its pillar guide.

**Articles missing guide links:**
- Sensory Overload: articles 01, 02, 03, 04, 05, 06, 07 (7 articles) → link to `complete-guide-sensory-overload-children`
- Calming Sounds: articles 01, 03, 04, 06 (4 articles) → link to `complete-guide-calming-sounds-children`
- Bedtime Routines: articles 04, 05 (2 articles) → link to `complete-guide-nd-bedtime-routines`
- Autistic Meltdowns: article 02 (1 article) → link to `complete-guide-autism-meltdowns-uk-parents`

**Acceptance Criteria:**
- [ ] All 7 Sensory Overload supporting articles contain link to pillar guide
- [ ] All 4 Calming Sounds supporting articles contain link to pillar guide
- [ ] Both Bedtime Routines supporting articles contain link to pillar guide
- [ ] Autistic Meltdowns article 02 contains link to pillar guide
- [ ] Links use correct `/{slug}` format with the pillar guide's current frontmatter slug
- [ ] Links are placed contextually in the conclusion/final section (not just appended)
- [ ] All 14 articles verified via grep to contain their pillar guide slug
- [ ] Git commit created

**Starter Prompt:**
> Add a contextual link to the pillar guide in the conclusion or final section of each of these 14 articles. Use natural anchor text like "For the complete guide, see our [comprehensive guide to {topic}](/{pillar-guide-slug})." Use the pillar guide's CURRENT frontmatter slug (after Task 37 changes). Verify each article contains its guide link via grep. Commit when done.

**Status:** pending

---

## Task 42: Fix Clinical Terminology

**Objective:** Replace "dysregulation" / "dysregulated" with "overwhelm" / "overwhelmed" in parent-facing body text across Calming Sounds and Emotional Regulation pillars. Clinical terms may be kept only in FAQ schema or SEO keyword contexts where the term IS the search keyword.

**Acceptance Criteria:**
- [ ] All "dysregulation" in body text replaced with "overwhelm"
- [ ] All "dysregulated" in body text replaced with "overwhelmed"
- [ ] Clinical terms retained ONLY in FAQ schema or primary_keyword frontmatter where the term is the actual search keyword
- [ ] Grep for "dysregulat" across all articles shows 0 matches in body text
- [ ] Replacements read naturally in context (not just mechanical find-and-replace)
- [ ] Git commit created

**Starter Prompt:**
> Search all articles in `projects/hushaway/seo-content/calming-sounds/articles/` and `projects/hushaway/seo-content/emotional-regulation/articles/` for "dysregulation" and "dysregulated". Replace with "overwhelm" / "overwhelmed" in parent-facing body text. Keep clinical terms ONLY in: (1) FAQ schema where the question uses the clinical term, (2) frontmatter primary_keyword if it contains the clinical term. Read each replacement in context to ensure it reads naturally. Verify with grep. Commit when done.

**Status:** pending

---

## Task 43: Delete Stale Validation Files

**Objective:** Remove 6 leftover `.validation.md` files from the autistic-meltdowns pillar. These are artifacts from a previous audit run and should have been deleted on PASS.

**Files to delete:**
- `projects/hushaway/seo-content/autistic-meltdowns/articles/01-understanding-autism-meltdowns.validation.md`
- `projects/hushaway/seo-content/autistic-meltdowns/articles/02-what-to-play-during-meltdown.validation.md`
- `projects/hushaway/seo-content/autistic-meltdowns/articles/03-after-school-autism-meltdown-why.validation.md`
- `projects/hushaway/seo-content/autistic-meltdowns/articles/04-autism-meltdown-recovery-guide.validation.md`
- `projects/hushaway/seo-content/autistic-meltdowns/articles/05-autism-meltdown-vs-shutdown-difference.validation.md`
- `projects/hushaway/seo-content/autistic-meltdowns/articles/06-preventing-autism-meltdowns-warning-signs.validation.md`

**Acceptance Criteria:**
- [ ] All 6 .validation.md files deleted
- [ ] Grep/glob for `*.validation.md` across entire seo-content directory returns 0 files
- [ ] Git commit created

**Starter Prompt:**
> Delete the 6 .validation.md files listed in Task 43 of TASKS.md. After deletion, verify: glob for `*.validation.md` across the entire `projects/hushaway/seo-content/` directory — expect 0 files found anywhere. Commit when done.

**Status:** pending

---

## Task 44: Full Re-Audit All 57 Articles

**Objective:** Run content-validator on every article across all 8 pillars. Independently verify results with raw grep before trusting audit output.

**Acceptance Criteria:**
- [ ] Content-validator run on all 57 articles
- [ ] All 57 articles PASS validation
- [ ] Independent grep verification confirms:
  - [ ] 0 em dashes (—) across all article files
  - [ ] 0 references to any of the 28 old slugs
  - [ ] 0 directory-structure internal links
  - [ ] 0 "dysregulat" in body text
  - [ ] 0 "the-open-sanctuary" references
  - [ ] 0 .validation.md files remaining
- [ ] Any remaining issues documented with specific file and line numbers
- [ ] Git commit created

**Starter Prompt:**
> Run content-validator on all 57 articles across all 8 pillars in `projects/hushaway/seo-content/`. BEFORE trusting the validator output, run independent grep checks: (1) grep for "—" across all articles — expect 0, (2) grep for each of the 28 old slugs — expect 0, (3) grep for pillar directory names in link URLs — expect 0, (4) grep for "dysregulat" — expect 0 in body text, (5) grep for "the-open-sanctuary" — expect 0, (6) glob for *.validation.md — expect 0 files. Document full results. If any article FAILs, document the specific issues. Commit when done.

**Status:** pending

---

## Task 45: Regenerate Cross-Pillar Summary + Create PR

**Objective:** Update `cross-pillar-summary.md` to reflect the clean state after all fixes. Create the pull request for the `fix/cross-pillar-cleanup` branch.

**Acceptance Criteria:**
- [ ] `cross-pillar-summary.md` accurately reflects current state of all 8 pillars
- [ ] All previously-failing checks now show PASS
- [ ] Em dash count shows 0 (verified, not assumed)
- [ ] Slug compliance shows 57/57 PASS
- [ ] Internal link format shows all compliant
- [ ] Deferred items clearly documented: 19 broken citation URLs (404s) for future task
- [ ] 43 bot-blocked URLs (403s) documented as acceptable (WARN, not FAIL)
- [ ] Git commit created
- [ ] PR created for `fix/cross-pillar-cleanup` branch with summary of all changes

**Starter Prompt:**
> Regenerate `projects/hushaway/seo-content/cross-pillar-summary.md` based on the re-audit results from Task 44. Update all tables to show current PASS/FAIL status for each pillar. Show verified counts: 0 em dashes, 57/57 compliant slugs, 0 directory-structure links, 14/14 guide links added, 0 clinical terminology in body text. Document deferred items: 19 broken citation URLs (separate future task) and 43 bot-blocked URLs (acceptable WARN). Commit, then create a PR for the `fix/cross-pillar-cleanup` branch with a summary covering all 19 tasks completed.

**Status:** pending
