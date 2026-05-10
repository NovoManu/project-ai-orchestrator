---
name: scaffold-submodule
description: Add a GitHub repository as a Git submodule and generate comprehensive documentation for it in docs/. Asks for the repo URL and optional folder name, clones the submodule, explores its structure, and writes docs/service-name/docs.md (plus subdirectory docs as needed). Use when onboarding a new service into the coordinator.
metadata:
  author: orchestrator
  category: scaffolding
---

# Scaffold Submodule

[← Back to Skills](../README.md)

Add a GitHub repository as a Git submodule and generate its full documentation in `docs/`.

## Purpose

This skill automates the two most tedious parts of onboarding a service into an orchestrator:

1. **Adding the submodule** — runs `git submodule add` with the correct path and verifies it works.
2. **Generating documentation** — explores the cloned code, infers architecture and purpose, and writes comprehensive `docs/` files that mirror the submodule structure.

The result: an AI agent (or a new developer) can open the coordinator and immediately understand what every service does without reading the source code.

## When to Use

- Adding a new GitHub repo to this coordinator for the first time.
- Re-generating documentation for an existing submodule after a major refactor.

## Prerequisites

- Network access to GitHub (or the target Git host).
- `git` available in the shell.
- The coordinator root is a git repository.

## Steps

### Phase 1: Gather Input

Ask the user:

1. **GitHub repo URL(s)** — full HTTPS or SSH URL (e.g., `https://github.com/org/repo`). Accept multiple URLs (comma-separated or one per line) to scaffold several at once.
2. **Local folder name** (optional) — defaults to the repo name from the URL (e.g., `repo` from `.../repo.git`). Suggest the default and let the user override.
3. **Brief description** (optional) — one sentence about what the service does. If omitted, infer from the code.

If the user provided URLs up-front (e.g., in the invocation message), skip asking for them again.

### Phase 2: Add the Submodule

For each repo:

```bash
# Add the submodule
git submodule add <repo-url> <folder-name>

# Initialize it
git submodule update --init <folder-name>
```

Verify:
- The folder exists and is non-empty.
- `.gitmodules` now contains the entry.

If `git submodule add` fails (e.g., folder already exists), report the error and ask the user whether to skip or remove and re-add.

### Phase 3: Explore the Submodule

Read the submodule to understand its structure and purpose. Work through these sources in order, stopping when you have enough context:

1. **`README.md`** — purpose, tech stack, quickstart.
2. **`package.json` / `pyproject.toml` / `go.mod` / etc.** — language, framework, scripts.
3. **Top-level source directory** (`src/`, `lib/`, `app/`, etc.) — list folders and read entry points.
4. **Key source files** — entry point (`index.ts`, `main.go`, `app.py`, `server.ts`, etc.), config, and 2-3 representative modules.
5. **Infrastructure** (`infrastructure/`, `Dockerfile`, `docker-compose.yml`) — deployment context.
6. **Test directory** — test structure reveals domain concepts.

**Goal**: understand enough to answer:
- What problem does this service solve?
- What are its main responsibilities?
- What is the tech stack?
- What are the key modules / layers?
- How does it expose its functionality (HTTP API, events, CLI, library)?
- How does it connect to other services?

### Phase 4: Generate Documentation

Create a documentation tree under `docs/<folder-name>/` that mirrors the submodule's folder structure.

#### Required: `docs/<folder-name>/docs.md`

This is the entry point. It must cover:

```markdown
# <Service Name>

[← Back to docs](../docs.md)

One-sentence description of what this service does and why it exists.

## Purpose

2-4 sentences on the problem this service solves and its role in the system.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | e.g., TypeScript / Node.js |
| Framework | e.g., Express, Fastify, NestJS |
| Database | e.g., PostgreSQL via Prisma |
| Messaging | e.g., Kafka, RabbitMQ, none |
| Transport | e.g., REST API, gRPC, events only |

## Architecture

High-level description of the main layers/modules (2-5 bullets or a short Mermaid diagram).

## Key Concepts

Domain terms and entities specific to this service (3-8 bullets).

## Entry Points

How to run, test, and build:
- `npm run dev` / `npm start` / equivalent
- `npm test`
- `npm run build`

## Directory Structure

\`\`\`
src/
  handlers/    ← HTTP route handlers
  services/    ← Business logic
  database/    ← DB access layer
  ...
\`\`\`

## Subfolders

Links to subdirectory docs when they exist:
- [src/](src/docs.md)
- [src/handlers/](src/handlers/docs.md)
```

#### Optional: Subdirectory docs

Create `docs/<folder-name>/src/docs.md` (and deeper) for directories that have enough complexity to warrant their own explanation. A subdirectory doc is warranted if:
- It contains more than 5 files, OR
- It implements a non-obvious architectural pattern, OR
- It contains domain logic that would take > 5 minutes to understand from code alone.

For each such directory, write a brief `docs.md` (purpose, key files, key concepts — keep it under 60 lines).

#### Update root `docs/docs.md`

Add the new service to the appropriate section (Backend Services, Frontend Apps, Tools, etc.):

```markdown
- **[service-name](service-name/docs.md)** — One-line description
```

If no section fits, create one.

### Phase 5: Update `doc-refs.yaml`

Seed the documentation baseline commit so future diff-based updates work:

```bash
# Get the current HEAD commit of the submodule
cd <folder-name> && git rev-parse HEAD
```

Add to `doc-refs.yaml`:
```yaml
<folder-name>: <commit-sha>
```

If the entry already exists, leave it unchanged.

### Phase 6: Report

Summarize what was done:

```
✅ Scaffolded <folder-name>
   - Submodule added: <repo-url>
   - Documentation created:
     - docs/<folder-name>/docs.md
     - docs/<folder-name>/src/docs.md  (if created)
   - doc-refs.yaml seeded: <sha>
   - docs/docs.md updated

Next steps:
   - Review the generated docs for accuracy
   - Commit: git add <folder-name> docs/ doc-refs.yaml .gitmodules
```

## Decision Logic

| Situation | Action |
|-----------|--------|
| Repo URL not provided | Ask before proceeding |
| Folder name conflicts with existing submodule | Ask: skip or remove and re-add |
| README.md is missing or very sparse | Read more source files to compensate |
| Service has no clear entry point | Document what you find; note ambiguity in the docs |
| Multiple repos provided | Process them sequentially, one at a time |
| Submodule already exists in `.gitmodules` | Skip `git submodule add`; only regenerate docs |

## Output Artifacts

- `<folder-name>/` — Initialized submodule directory
- `.gitmodules` — Updated with the new submodule entry
- `docs/<folder-name>/docs.md` — Service entry-point documentation
- `docs/<folder-name>/src/docs.md` (optional) — Source structure docs
- `docs/docs.md` — Updated with new service entry
- `doc-refs.yaml` — Seeded with current HEAD commit

## Notes for AI Agents

- **Do not commit** automatically. Report what was done and let the user review and commit.
- Infer documentation from code when `README.md` is missing or thin. Focus on what the code actually does, not what it could do.
- Use Mermaid diagrams for architecture when the service has 3+ interacting components.
- Keep documentation high-level. Avoid describing implementation details that change frequently.
- If the repository is private and the clone fails due to auth, report the error and instruct the user to set up SSH keys or a personal access token.
