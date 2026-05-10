# Orchestrator Template

A meta-repository template for coordinating multiple independently versioned services via Git submodules.

## What This Is

This template gives you a **coordinator repo** — a parent that holds submodule pointers, cross-repo documentation, AI agent skills, and shared tooling, without containing any application code itself.

Copy this projec and use it as the starting point for any project where you need to orchestrate multiple repositories.

## Quick Start

```bash
# 1. Copy this template to your new project
cp -r orchestrator-orchestrator/ my-project
cd my-project

# 2. Initialize git
git init
git commit -m "chore: initial orchestrator scaffold"

# 3. Add your first submodule (via the scaffold-submodule skill, or manually)
make execute-skill-scaffold-submodule
# OR manually:
# git submodule add https://github.com/your-org/your-service service-name

# 4. Update AGENTS.md with project-specific context
# 5. Edit docs/docs.md to describe your system
```

## Project Layout

```
.
├── AGENTS.md                  # AI agent entry point & coding guidelines
├── Makefile                   # Common commands for submodule & doc management
├── doc-refs.yaml              # Documentation baseline commit tracking
├── .gitmodules                # Git submodule registry
├── .github/
│   └── skills/                # Agent Skills for AI coding agents
│       ├── README.md
│       ├── scaffold-submodule/ ← KEY: adds repos & creates their docs
│       ├── update-documentation/
│       ├── review-and-update-documentation/
│       ├── create-skill/
│       ├── code-review/
│       ├── implement-feature/
│       ├── investigate-codebase/
│       └── generate-pr-description/
├── docs/                      # Root documentation (mirrors submodule structure)
│   ├── docs.md                # Navigation root
│   └── meta/                  # Process & workflow docs
├── tools/
│   └── generate_diffs.sh      # Generates code diffs for doc update workflows
└── tmp/                       # Temporary skill artifacts (not committed)
```

## Core Commands

| Command | Description |
|---------|-------------|
| `make execute-skill-scaffold-submodule` | Add a new submodule and generate its documentation |
| `make generate-doc-diffs` | Diff submodules against doc baselines, output to `tmp/diffs/` |
| `make generate-doc-diffs SERVICE=name` | Diff a single submodule |
| `make execute-skill-update-documentation` | Update docs based on recent code changes |
| `make init-submodules` | Initialize all submodules after cloning |
| `make pull-all` | Pull latest for parent + all submodules |
| `make clean-tmp` | Clear tmp/ directory |

## AI Agent Skills

Skills are the primary interface for AI agents. When an agent opens this repo, it reads `AGENTS.md`, which points to `.github/skills/`. The key skill for new projects is **scaffold-submodule** — it interactively adds a GitHub repo as a submodule and creates comprehensive documentation for it.

See [.github/skills/README.md](.github/skills/README.md) for the full list.

## Customization

After copying the template:

1. **`AGENTS.md`** — Replace placeholder sections with your project's domain, services, and team conventions.
2. **`docs/docs.md`** — Replace the placeholder overview with your system description.
3. **`Makefile` `add` target** — Update the list of excluded submodule folders once you know your service names.
4. **`.github/skills/README.md`** — Remove skills you don't need; add domain-specific ones via `make execute-skill-create-skill`.
