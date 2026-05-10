# Project AI Orchestrator

A meta-repository for coordinating multiple independently versioned services via Git submodules.

**Repository:** [github.com/NovoManu/project-ai-orchestrator](https://github.com/NovoManu/project-ai-orchestrator)

## What This Is

This repo is a **coordinator** — a parent that holds submodule pointers, cross-repo documentation, AI agent skills, and shared tooling, without containing application code itself.

Use it as the starting point when you need to orchestrate multiple repositories.

## Quick Start

Use this repo as a **scaffold**: copy the tree, drop its Git history, add your services as submodules, and push to **your** Git host (you are not continuing the upstream repo).

**1. Clone this project**

```bash
git clone git@github.com:NovoManu/project-ai-orchestrator.git my-project
cd my-project
```

HTTPS:

```bash
git clone https://github.com/NovoManu/project-ai-orchestrator.git my-project
cd my-project
```

**2. Remove Git history and start a new repository**

```bash
rm -rf .git
git init
```

**3. Add submodules**

Option A — **GitHub Copilot CLI** (what `make execute-skill-*` runs): install the `copilot` command, then:

```bash
make execute-skill-scaffold-submodule
```

Install: [GitHub Copilot CLI](https://docs.github.com/copilot/how-tos/use-cli/install-copilot-cli) (e.g. `brew install copilot-cli` or `npm install -g @github/copilot`). You need a Copilot subscription for the CLI.

Option B — **Git only** (no Copilot):

```bash
git submodule add https://github.com/your-org/your-service service-name
git submodule update --init service-name
```

Then follow [`.github/skills/scaffold-submodule/SKILL.md`](.github/skills/scaffold-submodule/SKILL.md) to add `docs/` and update `doc-refs.yaml` by hand (or ask an AI agent in Cursor to execute that skill).

**4. Commit and push to your new remote**

Create an empty repository on your host (for example GitHub), then:

```bash
git add .
git commit -m "chore: initial orchestrator project"
git branch -M main
git remote add origin git@github.com:your-org/your-orchestrator.git
git push -u origin main
```

Replace `git@github.com:your-org/your-orchestrator.git` with your repository URL (HTTPS works too).

Then update **`AGENTS.md`** and **`docs/docs.md`** for your system.

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

After cloning this repo (or using it as a template elsewhere):

1. **`AGENTS.md`** — Replace placeholder sections with your project's domain, services, and team conventions.
2. **`docs/docs.md`** — Replace the placeholder overview with your system description.
3. **`Makefile` `add` target** — Update the list of excluded submodule folders once you know your service names.
4. **`.github/skills/README.md`** — Remove skills you don't need; add domain-specific ones via `make execute-skill-create-skill`.
