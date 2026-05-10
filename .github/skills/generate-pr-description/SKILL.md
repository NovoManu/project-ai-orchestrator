---
name: generate-pr-description
description: Generate concise, informative PR descriptions from staged changes, submodule changes, or branch diffs. Use when preparing to create a pull request or when you need to summarize code changes for review.
metadata:
  author: orchestrator
  category: development
---

# Generate PR Description

[← Back to Skills](../README.md)

Generate a clear, informative PR description from code changes.

## When to Use

- Preparing to open a pull request.
- Summarizing code changes for team review.
- Updating a PR description after additional commits.

## Steps

### 1. Identify the Diff

```bash
# Changes staged vs main/master
git diff main

# Changes in a specific submodule
cd <submodule> && git diff main...<branch>

# Recent commits
git log --oneline -10
git show HEAD
```

### 2. Understand the Changes

Read the diff and identify:
- What changed (files, modules, behaviors).
- Why it changed (the business or technical motivation).
- Any risks or caveats.

Read surrounding code or `docs/<service>/docs.md` if context is unclear.

### 3. Write the Description

Use this structure:

```markdown
## What

One paragraph describing what was changed. Be concrete — name the files, endpoints, or behaviors that changed.

## Why

One paragraph explaining the motivation. Reference the ticket/issue if applicable.

## How to Test

Step-by-step instructions for a reviewer to verify the change works.

## Notes

- Any non-obvious decisions made.
- Known limitations or follow-up tasks.
- Breaking changes, if any.
```

Keep the total description under 400 words. Reviewers should be able to understand the PR in 2 minutes.

### 4. Output

Print the description directly. The user can copy-paste it into their PR.

## Notes for AI Agents

- Do not pad descriptions with filler ("This PR addresses...").
- Be specific: name the changed components, not just "the code was updated".
- If the change is a submodule pointer update, describe what changed inside the submodule.
