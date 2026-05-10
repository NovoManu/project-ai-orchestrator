---
name: create-skill
description: Meta-skill for designing and documenting new Agent Skills that encapsulate decision logic, constraints, and tool usage. Use when a capability should be reusable, context-aware, and dynamically invoked by an agent rather than encoded as a fixed workflow.
metadata:
  author: orchestrator
  category: meta
---

# Create Skill

[← Back to Skills](../README.md)

Meta-skill for designing and documenting agent-native capabilities as reusable, context-aware Agent Skills.

## Purpose

This skill ensures new Agent Skills are clearly scoped, decision-aware, executable without external clarification, and aligned with agent-driven execution.

## When to Use

- Identifying a capability that should be reusable across contexts.
- Converting workflows, scripts, or tribal knowledge into agent-native behavior.
- Discovering gaps in existing skills coverage.

## Prerequisites

- Clear understanding of the capability to encode.
- Familiarity with existing skills in `.github/skills/`.

## Skill Design Process

### Phase 1: Validate Capability

- Does this represent a capability rather than a one-off task?
- Does it require judgment, branching, or constraints?
- Is it not already covered by an existing skill?

### Phase 2: Draft Skill

Use the canonical Agent Skill structure:
- Frontmatter: `name`, `description`, `metadata`
- Sections: Purpose, When to Use, Prerequisites, Steps, Decision Logic, Output Artifacts, Notes for AI Agents.

### Phase 3: Encode Decision Support

Include decision tables and concrete examples where non-trivial judgment is required.

### Phase 4: Quality Review

Verify naming, structure, clarity, and agent-invocation suitability. Also check:
- **Makefile target needed?** — Session-contextual skills (those requiring current session history) must NOT get a Makefile target. Stateless skills (invokable from a fresh session) should get one.

### Phase 5: Integrate

1. Create `.github/skills/<skill-name>/SKILL.md`.
2. Update `.github/skills/README.md` — add to the appropriate category.
3. Update `Makefile` (only if the skill is stateless):
   - Add `execute-skill-<skill-name>` to `.PHONY`.
   - Add target: `execute-skill-<skill-name>: copilot -i "Execute the <skill-name> skill"`.

## Output Artifacts

- `.github/skills/<skill-name>/SKILL.md`
- Updated `.github/skills/README.md`
- Updated `Makefile` *(omit target if session-contextual)*

## Best Practices

- Design for agent judgment; make constraints explicit.
- Prefer clarity over completeness.
- Avoid linear workflow modeling — use decision tables.
- Use `./tmp/` for temporary artifacts.
- Don't add revision history — Git provides this.
