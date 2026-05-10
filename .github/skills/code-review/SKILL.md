---
name: code-review
description: Systematic code review of changes in one or more submodules. Analyzes diffs against documentation and codebase patterns, and produces a structured review report with actionable feedback. Use when reviewing a PR, a feature branch, or staged changes in a submodule before merging.
metadata:
  author: orchestrator
  category: development
---

# Code Review

[← Back to Skills](../README.md)

Systematic code review of changes in one or more submodules. Produces a structured report in `./tmp/`.

## When to Use

- Reviewing a pull request in a submodule.
- Reviewing a feature branch before merging.
- Reviewing staged changes before committing.

## Prerequisites

- Submodule initialized and the target branch/commit checked out.
- Access to the diff (via `git diff`, `git log -p`, or a PR URL).

## Steps

### 1. Identify the Scope

Ask the user:
- Which submodule and which PR/branch/commit range to review.
- Any specific concerns to focus on (security, performance, correctness, style).

### 2. Read the Diff

```bash
cd <submodule>
git diff main...<branch>         # branch changes
git diff HEAD~1                  # last commit
git log --oneline -10            # recent commits
```

### 3. Understand Context

Before evaluating the changes:
- Read `docs/<submodule>/docs.md` for architecture context.
- Read existing code around the changed files to understand patterns and conventions.
- Look for `AIDEV-NOTE` anchors near changed areas.

### 4. Evaluate Changes

Assess each changed file against these dimensions:

| Dimension | Questions to Ask |
|-----------|-----------------|
| Correctness | Does the code do what it claims? Are edge cases handled? |
| Security | Any OWASP Top 10 issues? Input validation at boundaries? |
| Readability | Is the intent clear? Are names meaningful? |
| Consistency | Does it follow existing patterns in the codebase? |
| Test coverage | Are new behaviors tested? Are tests meaningful? |
| Documentation | Are `AIDEV-NOTE`s needed? Should docs/ be updated? |

### 5. Produce the Report

Save the report to `./tmp/code-review-<service>-<identifier>.md`.

Structure:

```markdown
# Code Review: <Service> — <PR/Branch>

## Summary
One paragraph overview of the changes and overall assessment.

## Strengths
- What was done well.

## Issues

### Critical (must fix before merge)
- **[File:line]** Issue description and suggested fix.

### Suggestions (non-blocking improvements)
- **[File:line]** Suggestion with rationale.

## Documentation Updates Needed
- List any docs/ files that should be updated to reflect these changes.
```

### 6. Report Back

Tell the user where the report was saved and highlight the most important findings.

## Decision Logic

| Situation | Action |
|-----------|--------|
| PR URL provided | Fetch diff from GitHub; note you're using the fetched diff |
| Only branch name provided | Use `git diff main...<branch>` |
| No submodule specified | Ask before proceeding |
| Security issue found | Mark as Critical regardless of size |

## Notes for AI Agents

- Do not mark issues as Critical unless they could cause data loss, security vulnerabilities, or incorrect behavior.
- Focus on substance over style (style is for linters).
- Do not suggest refactors unrelated to the PR scope.
