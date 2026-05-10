# AGENTS.md

Guidance for AI coding agents working in this meta-repository of Git submodules.

## ⚠️ Important: Check Skills First

**Before starting any task, check the `.github/skills/` directory** for existing Agent Skills that match your requested activity. Skills provide structured, repeatable procedures for common development tasks such as scaffolding submodules, updating documentation, implementing features, reviewing code, and more.

If a skill exists for your task, follow it systematically. If no skill exists or steps are unclear, continue with the guidelines below and consult a developer when needed.

See `.github/skills/README.md` for available skills and usage instructions.

## Project Overview

<!-- CUSTOMIZE: Replace this section with your project's domain, services, and architecture. -->

This repo is a coordinator for multiple independently versioned services and applications. Each child folder is a Git submodule that holds its own code, tooling, and CI/CD. The parent repo aligns these pieces so they can be pulled, tested, and released together.

Shared documentation in `docs/` mirrors the submodule structure with high-level context for each service/application. Use this root repo to:
- Update submodule pointers
- Maintain cross-repo documentation in `docs/`
- Manage meta-level tooling in `tools/`
- Invoke AI agent skills for common workflows

**Known submodules:**
<!-- List your submodules here as you add them, e.g.: -->
<!-- - `service-a` → backend API -->
<!-- - `service-b` → frontend app -->

## Core Principles

- **Golden rule**: when unsure about implementation details or requirements, consult a developer rather than guessing.
- **Verification is mandatory**: Never invent event names, API endpoints, or service names. First, orient yourself using the existing documentation in `docs/`. Then verify details against the codebase before writing.
- Use **Conventional Commits** for all commits in this repository.
- Prefer **functional style** (`map`/`filter`/`reduce`, named arguments, minimal mutation) over OOP.
- Keep a trailing newline at the end of every file.
- For changes over 300 LOC or touching more than 3 files, ask for confirmation before proceeding.
- **Programmatic mode is opt-in**: Only skip questions and run non-interactively when the caller explicitly says "no human assistance" or "programmatic mode". If critical context is missing, stop instead of guessing.
- When adding comments aimed at AI/developers, use `AIDEV-NOTE:`, `AIDEV-TODO:`, or `AIDEV-QUESTION:` prefixes (≤120 chars).
- Before scanning files, first look for existing `AIDEV-*` anchors in relevant directories and update them when adjusting related code.
- Do not remove existing `AIDEV-NOTE`s without explicit instruction; add new anchors for long, complex, important, or confusing code sections.
- Keep documentation files in the root `docs/` tree only; mirror the repository hierarchy there so every subfolder has a `docs.md` for navigation.

## Repository Context

- **Purpose**: coordinate multiple independent services via submodule pointers; each service maintains its own history and CI/CD.
- **Layout**: mirrors `docs/docs.md` — update that file when adding new submodules.
- Do not mention `*-copy` directories in documentation; they exist only for copying artifacts when submodule code is inaccessible.
- Keep instructions focused on meta-repo tasks; service-specific work must follow that service's own guidelines inside the submodule.

## Core Rules

1. **Do NOT stage or commit changes** without explicit user permission or unless a skill explicitly instructs you to do so. The user often wants to review changes via Git before staging.
2. Stage only intended submodule pointers or files (e.g., `git add service-a`); avoid `git add .` at the root.
3. When updating a service, commit inside the service repo first, then return here to commit the pointer update.
4. Avoid modifying submodule contents directly from the parent repo unless that change is committed inside the submodule.
5. Normal directories (e.g., `docs/`) must not contain nested `.git` directories.
6. Preserve trailing newlines and avoid introducing tooling that conflicts with existing file formats.

## Working with Submodules

- Clone with `--recurse-submodules` or run `git submodule update --init --recursive` after cloning.
- To update a service pointer after new commits inside it: `git add <service>` then commit.
- To add a new service: use the **scaffold-submodule** skill (`make execute-skill-scaffold-submodule`), or manually: `git submodule add <repo-url> <folder>`.
- To remove a service: `git submodule deinit -f <folder>`, `git rm -f <folder>`, remove `.git/modules/<folder>`, then commit.
- To refresh all services to latest remote: `git submodule update --remote --merge` then update the pointer.

### Working Inside Submodules

**CRITICAL PATH RULES:**
- Always use **full absolute paths** when working in submodules: `/path/to/project/<submodule>/`
- OR change directory explicitly with `cd /full/path/to/<submodule>` before running commands.
- Never use relative paths like `cd submodule` — the shell may reject operations as "outside the project".
- Verify your working directory with `pwd` before git operations in submodules.

**Node.js/npm projects:**
- Run `nvm use` before any npm command if submodules use `.nvmrc`.
- In non-interactive shells, source nvm first: `[ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh" && nvm use`.

## Documentation (`docs/`)

- **Scope**: Includes code architecture, service documentation, AND process documentation.
- **Process Docs**: Store process, workflow, and meta-documentation in `docs/meta/`.
- Documentation mirrors the repository layout and stays in sync with corresponding folders.
- Each `docs.md` should link to its immediate child docs for navigation.
- Keep content high-level (purpose, architecture, key concepts) and update links when services change.

### Documentation Formatting

- **Be concise**: Favor brevity and clarity over verbose explanations.
- **Use structured formats**: bullet points for lists, tables for comparisons, Mermaid for diagrams.
- **Avoid long paragraphs**: Break complex information into scannable sections.
- **Manual change tracking**: Don't add revision history — Git provides this.

## File Management

- **Temporary files**: Always use the project-local `./tmp/` directory for working artifacts, analysis outputs, and draft outputs intended for copy-paste.
- **`./tmp/` already exists** in the repo — do not `mkdir` it.
- **Documentation**: Keep all documentation in `docs/` mirroring the repository structure.

## Contribution & Validation

- Run formatting or tests only when applicable to the files you touch; submodules manage their own tooling.
- Prefer concise explanations in commit messages; do not reference internal planning notes.
- After making many edits to the same file in one session, verify the exact target text before calling edit — file state drifts and a stale `old_str` will silently fail.
