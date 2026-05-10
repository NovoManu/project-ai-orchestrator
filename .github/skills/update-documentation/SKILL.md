---
name: update-documentation
description: Workflow for updating the root docs/ to reflect recent changes in one or more submodules. Fetches the latest commits from the remote, generates diffs against the doc-refs.yaml baseline, reviews changes, and updates documentation. Does not modify submodule pointers. Use when documentation is out of date for a service.
metadata:
  author: orchestrator
  category: documentation
---

# Update Documentation

[← Back to Skills](../README.md)

Workflow for reviewing recent service changes and updating the root `docs/` to reflect them. Does **not** modify submodule pointers — documentation and code pointers are fully independent.

## When to Use

- Documentation is out of date for one or more services.
- On a regular schedule (e.g., weekly) to keep docs in sync with service changes.

## Prerequisites

- Clean git working directory in the coordinator root.
- Network access to the submodule repositories.

## Invocation Modes

### Interactive Mode

Default mode for manual usage:
- Ask the user which service(s) to update.
- Ask follow-up questions when scope is unclear.

### Programmatic Mode

Use when the caller explicitly says "no human assistance" or "programmatic mode":
- Do not ask follow-up questions when scope is already provided.
- If scope is missing, stop and report the missing input.

## Steps

### 1. Choose Services to Update

Ask the user which service(s) to update, or whether to update all.

### 2. Generate Diff Artifacts

```bash
# All services
make generate-doc-diffs

# Single service
make generate-doc-diffs SERVICE=service-name
```

This fetches `origin/master` (or `origin/main`), diffs against the `doc-refs.yaml` baseline, and saves results to `tmp/diffs/`. `doc-refs.yaml` is automatically advanced.

### 3. Review Changes

```bash
ls -lh tmp/diffs/
cat tmp/diffs/service-name.diff
```

For each changed file in the diff:
- Identify what changed (new files, modified logic, renamed things).
- Determine if the change affects public interfaces, data models, or configuration.

### 4. Update Documentation

For each affected service:
- Update `docs/<service>/docs.md` to reflect structural or behavioral changes.
- Update cross-cutting docs (`docs/docs.md`, entity models, data flow diagrams) if shared concepts changed.
- Add new subdirectory `docs.md` files for new folders that warrant documentation.
- Remove documentation for deleted files or modules.

### 5. Report

Summarize:
- Which services were reviewed.
- Which docs were updated and why.
- Any changes in the diff that are unclear and may need developer input.

Do not commit. Let the user review and commit.

## Output Artifacts

- Updated files in `docs/<service>/`
- Updated `doc-refs.yaml` (advanced by `generate-doc-diffs`)
- Diff artifacts in `tmp/diffs/` (review only, not committed)
