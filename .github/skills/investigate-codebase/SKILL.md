---
name: investigate-codebase
description: Systematic workflow for investigating and explaining business logic, software architecture, and code behavior. Use when users ask "how does X work?", "what does this do?", or "explain the logic behind Y".
metadata:
  author: orchestrator
  category: exploration
---

# Investigate Codebase

[← Back to Skills](../README.md)

Systematic workflow for investigating and explaining business logic, software architecture, and code behavior.

## When to Use

- "How does X work?"
- "What does this module/function/service do?"
- "Explain the flow for Y."
- "Why does the code do Z?"

## Steps

### 1. Clarify Scope

If the question is ambiguous, ask one clarifying question to narrow the scope before diving in:
- Which service? (if multiple)
- Which specific flow or feature?

### 2. Orient Using Documentation

Before reading source code:
1. Read `docs/<service>/docs.md` for the relevant service.
2. Read cross-cutting docs if the question spans services.
3. Check for `AIDEV-NOTE` comments in the relevant directory.

This gives you the map before exploring the territory.

### 3. Trace the Code

Follow the execution path relevant to the question:
1. Identify the entry point (route handler, event consumer, CLI command, exported function).
2. Read the top-level handler/controller.
3. Follow calls into services/domain logic.
4. Note data transformations, side effects, and external calls.
5. Stop when you have enough to answer the question.

### 4. Synthesize the Answer

Structure the answer for a developer audience:

- **One-line answer** — what it does.
- **How it works** — the key steps (3-7 bullets or a short prose paragraph).
- **Key files** — the 2-4 most relevant files with one-line descriptions.
- **Data flow** — a Mermaid diagram if the flow involves 3+ components.
- **Edge cases / caveats** — anything non-obvious that affects correctness.

### 5. Identify Documentation Gaps

If the investigation reveals undocumented behavior, note it. Optionally offer to update `docs/` or add an `AIDEV-NOTE` comment.

## Decision Logic

| Situation | Action |
|-----------|--------|
| Documentation covers the question | Lead with docs, add code references |
| Docs are missing or outdated | Read code directly; note the gap |
| Flow spans multiple services | Trace across submodule boundaries; use cross-cutting docs |
| Question is too broad | Ask one clarifying question to narrow scope |

## Notes for AI Agents

- Do not read entire files — target the relevant sections.
- Prefer `AIDEV-NOTE` anchors and public interfaces over implementation details.
- If the answer requires guessing, say so explicitly and recommend the developer verify.
