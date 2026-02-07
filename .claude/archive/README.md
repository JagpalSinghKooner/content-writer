# Archive: Deprecated Files

This folder contains files that have been superseded by the Claude Code agent files approach.

**Superseded by:** Individual agent files in `.claude/agents/`

---

## What Changed

The original sub-agent system used the Task tool with `general-purpose` subagent type and manually constructed prompts. This approach has been replaced by Claude Code's native agent files system.

### Old Approach (Archived)

- Main session manually constructed prompts from templates
- Task tool spawned `general-purpose` subagents with embedded prompts
- Rules and skills were embedded in the prompt text
- Orchestration documented in `sub-agent-rules.md`

### New Approach (Agent Files)

- Agent definitions live in `.claude/agents/*.md` with YAML frontmatter
- Claude auto-delegates based on the `description` field
- Skills are preloaded via the `skills:` field in YAML
- Rules are READ at runtime (not embedded) — update once, all agents see the change
- Orchestration documented in `rules/workflow.md` and `/execute-pillar` skill

---

## Archived Files

| File | Original Location | Superseded By |
|------|-------------------|---------------|
| `sub-agent-rules.md` | `rules/sub-agent-rules.md` | `rules/workflow.md` + agent files |
| `sub-agent-seo-content.md` | `skills/templates/sub-agent-seo-content.md` | `agents/seo-writer.md` |
| `sub-agent-validate-content.md` | `skills/templates/sub-agent-validate-content.md` | `agents/content-validator.md` |

---

## Why Keep These Files?

These files are preserved for:

1. **Reference** — Understanding the evolution of the system
2. **Patterns** — Some prompt patterns may still be useful
3. **Rollback** — If agent files approach needs revision

**Do not use these files for active development.** The agent files approach is the current standard.

---

## New File Locations

| Purpose | New Location |
|---------|--------------|
| SEO article writing | `agents/seo-writer.md` |
| Copy enhancement | `agents/copy-enhancer.md` |
| Content validation | `agents/content-validator.md` |
| Distribution content | `agents/content-atomizer.md` |
| Workflow rules | `rules/workflow.md` |
| Pillar execution | `skills/execute-pillar/SKILL.md` |

---

*Archived: 2026-02-03*
