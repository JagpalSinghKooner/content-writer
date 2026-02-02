# TASKS.md Starter Template

A ready-to-copy template for tracking project tasks. Follows the TASKS.md specification from CLAUDE.md Rule #1.

---

## Usage Notes

1. **Copy** this file to your project root
2. **Rename** to `TASKS.md`
3. **Replace** placeholders with project-specific content:
   - `[Project Name]` → Your project name
   - `[Task Title]` → Descriptive task name
   - `[Single focused goal]` → What this task achieves
   - `[Specific measurable outcome]` → Checkable criteria
4. **Update** the summary table as you add/complete tasks
5. **Add handoff sections** only after tasks complete (not before)

**Key Rules:**
- Every task must complete under 45% context window
- A task is NOT complete until TASKS.md shows PASS with handoff section
- The TASKS.md update is part of the task, not after it

---

## Template

Copy everything below this line:

---

# Project Tasks: [Project Name]

## Summary

| Task | Status |
|------|--------|
| Task 1: [Task Title] | pending |
| Task 2: [Task Title] | pending |

---

## Task 1: [Task Title]

**Objective:** [Single focused goal]

**Acceptance Criteria:**
- [ ] [Specific measurable outcome]
- [ ] [Specific measurable outcome]
- [ ] [Specific measurable outcome]

**Starter Prompt:**
> [Ready-to-paste prompt with all context needed to begin this task fresh. Include file paths, dependencies, and any context a fresh session would need to complete this task without reading previous conversation.]

**Status:** pending

---

## Task 2: [Task Title]

**Objective:** [Single focused goal]

**Acceptance Criteria:**
- [ ] [Specific measurable outcome]
- [ ] [Specific measurable outcome]

**Starter Prompt:**
> [Ready-to-paste prompt with all context needed]

**Status:** pending

---

## Example: Completed Task

Below is an example showing how a completed task looks with all sections filled in.

---

## Task 1: Set Up Project Structure

**Objective:** Create the initial folder structure and configuration files for the project.

**Acceptance Criteria:**
- [x] Created `/src` directory with subdirectories for components, utils, and styles
- [x] Added `package.json` with required dependencies
- [x] Created `.env.example` with placeholder environment variables
- [x] Added `README.md` with setup instructions

**Starter Prompt:**
> Set up the initial project structure for a React application. Create `/src` with subdirectories for `components/`, `utils/`, and `styles/`. Add a `package.json` with React 18, TypeScript, and Tailwind CSS. Create `.env.example` with placeholders for API_URL and AUTH_SECRET. Add a basic README.md with installation and development server instructions.

**Status:** PASS

---

**Handoff:**
- **Done:** Created complete project structure with src/components, src/utils, src/styles directories. Added package.json with React 18.2.0, TypeScript 5.0, and Tailwind 3.3. Created .env.example with API_URL and AUTH_SECRET placeholders. README includes npm install and npm run dev instructions.
- **Decisions:** Used Tailwind over styled-components for faster iteration. Chose flat component structure (no nested folders) since project is small. Used .env.example pattern rather than .env.template for GitHub compatibility.
- **Next:** Task 2 - Build authentication flow. Note: AUTH_SECRET in .env.example needs real value before auth work begins.

---

## Example: Pending Task

Below is an example showing how a pending task looks before work begins.

---

## Task 2: Build Authentication Flow

**Objective:** Implement user login and registration with JWT tokens.

**Acceptance Criteria:**
- [ ] Login form accepts email and password
- [ ] Registration form includes email, password, and password confirmation
- [ ] JWT token stored in httpOnly cookie
- [ ] Protected routes redirect to login when unauthenticated
- [ ] Logout clears token and redirects to home

**Starter Prompt:**
> Build the authentication flow for the React application. Create login and registration forms in `src/components/auth/`. Use the API_URL from .env for auth endpoints (POST /auth/login, POST /auth/register). Store JWT in httpOnly cookie (not localStorage). Create a useAuth hook in `src/utils/auth.ts` that provides user state and login/logout functions. Wrap protected routes with an AuthGuard component that redirects to /login when no valid token exists. Project structure from Task 1 is complete - see handoff for details.

**Status:** pending

---

## Handoff Section Template

Add this section immediately after the `---` following a completed task:

```markdown
**Handoff:**
- **Done:** [What was actually completed - be specific about files, values, choices made]
- **Decisions:** [Key choices and why - patterns established, tradeoffs accepted, alternatives rejected]
- **Next:** [Context the next task needs - dependencies, blockers, things to watch out for]
```

**Handoff Tips:**
- **Done** should let someone verify the work without reading code
- **Decisions** should explain "why" not just "what" - future you will forget the reasoning
- **Next** should give the next task a head start - mention gotchas, prerequisites, or related context

---

## Summary Table Template

Update this table as tasks are added and completed:

```markdown
## Summary

| Task | Status |
|------|--------|
| Task 1: Set Up Project Structure | PASS |
| Task 2: Build Authentication Flow | in_progress |
| Task 3: Create User Dashboard | pending |
| Task 4: Add Payment Integration | pending |
```

**Status Values:**
- `pending` — Not started
- `in_progress` — Currently being worked on
- `PASS` — Completed successfully (handoff section added)
- `FAIL` — Did not meet acceptance criteria (needs rework)

---

## Quick Reference

**Task Lifecycle:**
1. Add task with `pending` status
2. Change to `in_progress` when starting
3. Check all acceptance criteria boxes as completed
4. Change to `PASS` when all criteria met
5. Add handoff section with Done/Decisions/Next
6. Update summary table

**Starter Prompt Best Practices:**
- Include all file paths explicitly
- Reference previous task handoffs for context
- Make it copy-pasteable for a fresh session
- Include "why" context, not just "what" instructions

**Context Management:**
- If task will exceed 45% context: stop, split into 2-3 tasks
- Each task should be completable in one session
- Starter prompts enable pause/resume at any point
