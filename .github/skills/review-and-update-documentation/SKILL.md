---
name: review-and-update-documentation
description: Systematic workflow for reviewing, validating, and improving documentation against the actual codebase. Use when creating first-pass documentation for a service/component, after major refactoring, preparing for knowledge transfer, or discovering significant documentation gaps.
metadata:
  author: orchestrator
  category: documentation
---

# Review and Update Documentation

[← Back to Skills](../README.md)

Systematic workflow for reviewing, validating, and improving documentation against the actual codebase.

## Purpose

This workflow creates the **first comprehensive version** of documentation by:
- Comparing documentation against actual code structure and behavior.
- Identifying gaps, inaccuracies, or outdated information.
- Improving clarity and usefulness for developers and AI coding agents.

## When to Use

- Creating first-pass documentation for a service/component.
- After major refactoring that requires documentation overhaul.
- Preparing for knowledge transfer.
- After discovering significant documentation gaps.

## Prerequisites

- Submodules initialized (run `make init-submodules` if not).
- Access to the full codebase.

## Workflow Steps

### Phase 1: Scope Definition

Choose the documentation area to review:
- Single service (e.g., `docs/service-a/`)
- Cross-cutting documentation (e.g., `docs/data-flow.md`)
- Specific subdirectory
- Entire documentation tree (break into iterations)

### Phase 2: Documentation Audit

**Step 2.1: Structure Validation**
- Check each `docs.md` has a corresponding code folder.
- Verify all code folders have a corresponding `docs.md`.
- Validate navigation links (parent ← child references).

**Step 2.2: Content Comparison**

For each documented folder:
- Compare file listings in docs vs actual code.
- Verify described architecture matches implementation.
- Check documented APIs against actual endpoints/exports.
- Validate configuration examples against actual configs.

**Step 2.3: Code Analysis**
- Look for `AIDEV-NOTE`, `AIDEV-TODO`, `AIDEV-QUESTION` comments.
- Identify complex logic lacking explanation.
- Find recent changes (git history) not reflected in docs.
- Check for new files/folders without documentation.

**Step 2.4: Cross-Reference Check**
- Verify cross-service references are accurate.
- Validate data flow diagrams against code.

### Phase 3: Gap Analysis

Categorize findings:
- **Missing**: Code exists but has no documentation.
- **Outdated**: Documentation describes old behavior/structure.
- **Incomplete**: Documentation exists but lacks critical details.
- **Incorrect**: Documentation contradicts actual code.

### Phase 4: Update Documentation

For each gap found:
1. Write or rewrite the affected `docs.md`.
2. Keep content high-level — describe purpose and architecture, not line-by-line implementation.
3. Use tables for structured data (tech stack, config options, API endpoints).
4. Use Mermaid diagrams for flows with 3+ components.

### Phase 5: Report

Summarize:
- Files reviewed and updated.
- Gaps found and how they were addressed.
- Open questions for the developer (things you could not determine from code alone).

Do not commit. Let the user review and commit.
