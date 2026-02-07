# Execute Pillar Troubleshooting

## Agent Not Spawning

If an agent doesn't auto-delegate:
1. Check that `.claude/agents/{agent}.md` exists
2. Verify YAML frontmatter is valid
3. Use explicit task description matching agent's `description` field

## Validation Loop Never Passes

If an article fails validation 3+ times:
1. Check if the FAIL issues are addressable by copy-fixer
2. Some issues (e.g., fundamental structure problems) may need manual rewrite
3. Log the issue and continue with other articles
4. Return to problem article manually after pillar execution

## Git Conflicts

If git operations fail:
1. Check branch status: `git status`
2. Ensure you're on the pillar branch
3. Pull latest if needed: `git pull origin pillar/{name}`
4. Resolve conflicts manually if they occur

## Context Running Low

If main session context is getting full:
1. Complete current tier
2. Commit progress
3. Document current state in PROJECT-TASKS.md
4. Start fresh session with handoff context
