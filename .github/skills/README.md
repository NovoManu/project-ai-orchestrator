# Agent Skills

This directory contains Agent Skills for AI coding agents to execute common tasks in this repository.

## What Are Agent Skills?

Agent Skills are a lightweight, open format for extending AI agent capabilities with specialized knowledge and workflows. Skills use **progressive disclosure** — agents load only skill names and descriptions at startup, then load full instructions when relevant.

This format is supported by GitHub Copilot, Claude (Anthropic), and other platforms adopting the [open standard](https://agentskills.io).

## Available Skills

### Scaffolding

- **[Scaffold Submodule](scaffold-submodule/SKILL.md)** — Add a GitHub repo as a Git submodule and generate comprehensive documentation for it in `docs/`. The primary skill for onboarding new services.

### Documentation

- **[Update Documentation](update-documentation/SKILL.md)** — Fetch recent service changes, diff against baselines, and update `docs/`. Use when docs are out of date.
- **[Review and Update Documentation](review-and-update-documentation/SKILL.md)** — Systematic first-pass documentation creation. Use after major refactors or when docs are missing.

### Development

- **[Implement Feature](implement-feature/SKILL.md)** — Systematic workflow for implementing features from tickets or requirements through working code.
- **[Code Review](code-review/SKILL.md)** — Systematic code review producing a structured report in `tmp/`. Use for PRs and feature branches.
- **[Investigate Codebase](investigate-codebase/SKILL.md)** — Explain business logic, architecture, and code behavior. Use for "how does X work?" questions.
- **[Generate PR Description](generate-pr-description/SKILL.md)** — Generate concise PR descriptions from staged changes or branch diffs.

### Meta

- **[Create Skill](create-skill/SKILL.md)** — Design and document new Agent Skills. Use when a capability should be reusable and dynamically invoked by an agent.

## How Skills Work

1. **Discovery**: Agents load skill names and descriptions to know when each might be relevant.
2. **Activation**: When a task matches a skill's description, the agent reads the full `SKILL.md`.
3. **Execution**: The agent follows the instructions, using bundled scripts or references as needed.

## Adding a New Skill

Use the **create-skill** skill:
```bash
make execute-skill-create-skill
```

Or manually:
1. Create `.github/skills/<skill-name>/SKILL.md` with proper frontmatter.
2. Add the skill to the appropriate section in this README.
3. Add a Makefile target (only if the skill is stateless and invokable from a fresh session).
