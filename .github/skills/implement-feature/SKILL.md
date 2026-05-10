---
name: implement-feature
description: Systematic workflow for implementing features from requirements or tickets. Use when adding new functionality or building components. Emphasizes exploration, planning approval, and draft-first implementation.
metadata:
  author: orchestrator
  category: development
---

# Implement Feature

[← Back to Skills](../README.md)

Systematic workflow for implementing features from requirements through working code.

## When to Use

- Implementing a new feature from a ticket, issue, or written requirement.
- Building a new component or module.
- Extending existing functionality.

## Steps

### Phase 1: Understand the Requirement

Read the provided ticket/issue/requirement carefully. Identify:
- What user need or business problem is being solved?
- What are the acceptance criteria?
- What is explicitly out of scope?

If requirements are ambiguous, ask one clarifying question before proceeding.

### Phase 2: Explore the Codebase

Before writing any code:
1. Read `docs/<service>/docs.md` for the relevant service.
2. Find the files most likely to be affected.
3. Read those files to understand existing patterns (naming, error handling, data access, testing style).
4. Look for `AIDEV-NOTE` anchors near the relevant area.

**Goal**: Write code that looks like it belongs here, not like it was imported from another project.

### Phase 3: Create a Plan

Write a short implementation plan (3-10 bullet points):
- What files will be created or modified.
- What the core logic change is.
- How the feature will be tested.

**Present the plan to the user and wait for approval before writing code.**

If the plan touches more than 3 files or 300 lines, this is mandatory.

### Phase 4: Implement (Draft First)

Write the implementation file by file, following the plan. After each file:
- Check for type errors or obvious bugs.
- Ensure consistency with surrounding code.

Do not over-engineer. Only implement what the requirement asks for.

### Phase 5: Tests

After the implementation is reviewed:
- Write tests for the new behavior.
- Follow existing test patterns (file location, naming, assertion style).
- Cover happy path and key edge cases.

### Phase 6: Report

Summarize:
- Files created/modified.
- How the feature works (2-4 sentences).
- How to test it manually.
- Any open questions or follow-up tasks.

Do not commit without user permission.

## Decision Logic

| Situation | Action |
|-----------|--------|
| Requirement is ambiguous | Ask one clarifying question |
| Plan touches >3 files or >300 LOC | Mandatory plan approval |
| Existing pattern conflicts with best practice | Follow existing pattern; note the conflict |
| Feature requires a new dependency | Flag it in the plan; get approval |

## Notes for AI Agents

- **Prefer editing existing files over creating new ones.**
- Do not add docstrings, comments, or type annotations to code you didn't change.
- Do not add error handling for scenarios that can't happen in practice.
- Do not add features beyond what was asked.
