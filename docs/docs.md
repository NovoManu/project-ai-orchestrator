# Documentation

This folder contains high-level architecture documentation for all services and applications coordinated by this repository.

## System Overview

<!-- CUSTOMIZE: Replace this section with your project's domain, purpose, and key concepts. -->

This repository coordinates multiple independently versioned services. Each submodule maintains its own history, CI/CD, and tooling. The coordinator holds cross-repo documentation and shared operational tooling.

**Key concepts to document here:**
- What problem does this system solve?
- Who are the users/actors?
- What are the core business entities?
- How do services interact?

---

## Documentation Structure

### Cross-Cutting Documentation

<!-- Add links as you create them, e.g.: -->
<!-- - [Entity Model](entity-model.md) - Core business entities and their relationships -->
<!-- - [Data Flow](data-flow.md) - End-to-end data movement across services -->
<!-- - [Glossary](glossary.md) - Domain terminology and definitions -->
<!-- - [Infrastructure](infrastructure.md) - Shared infrastructure, environments, and deployment -->

### Process Documentation

- [Meta docs](meta/) — Process, workflow, and operational documentation

### Service Documentation

The docs folder mirrors the structure of actual project folders:

- **Mirror project structure**: `docs/service-a/docs.md` → documents `service-a/`
- **Hierarchical references**: Each `docs.md` links to its children for navigation
- **High-level focus**: Each `docs.md` provides high-level overview of its folder's purpose and architecture

---

## Services & Applications

<!-- CUSTOMIZE: Add entries for each submodule as you scaffold them. -->
<!-- Example:
### Backend Services
- **[service-a](service-a/docs.md)** — Description of service-a
- **[service-b](service-b/docs.md)** — Description of service-b

### Frontend Applications
- **[app-ui](app-ui/docs.md)** — Description of the frontend app
-->

> **Getting started**: Use `make execute-skill-scaffold-submodule` to add a GitHub repo as a submodule. The skill will generate the documentation structure here automatically.
