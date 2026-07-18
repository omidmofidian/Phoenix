> # Repository Structure

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-005 |
| Version | 2.0 |
| Status | Frozen |
| Classification | Architecture Governance |
| Owner | Architecture Team |
| Last Updated | 2026-07-08 |

---

**Scope Note**
>
> This document defines the repository structure from the Architecture Governance perspective.
>
> The canonical enterprise repository structure is maintained separately in the Project capability.

# 1. Purpose

This document defines the official repository structure of the Phoenix Platform.

It is the authoritative source governing the organization of every repository artifact.

No directory, document, source file or project artifact shall be created outside this structure without an approved Architectural Decision Record (ADR).

---

# 2. Repository Philosophy

The Phoenix repository follows five architectural layers.

```text
Knowledge
      │
      ▼
Architecture
      │
      ▼
Design
      │
      ▼
Implementation
      │
      ▼
Operations
```

Each layer has a unique responsibility.

Artifacts shall never overlap between layers.

---

# 3. Repository Principles

The repository shall follow these principles.

- Separation of Concerns
- Single Source of Truth
- Layered Architecture
- Domain Driven Organization
- Technology Independence
- Traceability
- Long-term Maintainability
- Explicit Ownership

---

# 4. Documentation Layers

## Knowledge

Business knowledge.

Financial knowledge.

Research.

Domain expertise.

---

## Architecture

Business Architecture

Domain Architecture

Service Architecture

Governance

Architectural Decisions

---

## Design

Implementation-ready specifications.

Logical models.

Physical models.

Database models.

Standards for implementation.

---

## Implementation

Source code.

Database scripts.

Infrastructure.

Deployment.

Testing.

---

## Operations

Monitoring.

Runbooks.

Maintenance.

Deployment Operations.

---

# 5. Repository Layout

```text
Phoenix
│
├── Docs
│   │
│   ├── Architecture
│   │   ├── ADR
│   │   ├── DomainModel
│   │   ├── Governance
│   │   ├── Services
│   │   └── Vision
│   │
│   ├── Design
│   │   ├── ConceptualModel
│   │   ├── LogicalModel
│   │   ├── PhysicalModel
│   │   ├── Database
│   │   │   ├── DataDictionary
│   │   │   ├── ERD
│   │   │   └── SQL
│   │   ├── DataDictionary
│   │   └── Standards
│   │
│   ├── Knowledge
│   │   ├── FinancialMarkets
│   │   ├── Trading
│   │   ├── Analytics
│   │   ├── ArtificialIntelligence
│   │   ├── DataProviders
│   │   ├── Regulations
│   │   ├── Research
│   │   └── Reference
│   │
│   └── Standards
│
├── Services
├── Database
├── Infrastructure
├── Scripts
├── Tests
├── Tools
└── src
```

---

# 6. Artifact Classification

Artifacts are classified as follows.

| Artifact Type | Location |
|--------------|----------|
| Knowledge | Docs/Knowledge |
| Architecture | Docs/Architecture |
| Design | Docs/Design |
| Repository Standards | Docs/Standards |
| Database Standards | Docs/Design/Standards |
| ERD | Docs/Design/Database/ERD |
| SQL Specification | Docs/Design/Database/SQL |
| Database Dictionary | Docs/Design/Database/DataDictionary |
| Business Dictionary | Docs/Design/DataDictionary |

---

# 7. Artifact Placement Rules

Every artifact shall belong to exactly one location.

Documents shall never be duplicated.

Cross references shall be preferred.

Every artifact shall have one owner.

---

# 8. Layer Dependency Rules

Allowed dependencies

```text
Knowledge
        ↓

Architecture
        ↓

Design
        ↓

Implementation
        ↓

Operations
```

Forbidden

Architecture shall not depend on Design.

Knowledge shall not depend on Implementation.

Implementation shall not redefine Architecture.

---

# 9. Repository Governance

Repository changes require

1. Architecture Review

2. ADR

3. Governance Approval

4. Repository Version Update

No exceptions.

---

# 10. Naming Rules

Directories

PascalCase

Documents

PascalCase

Business-oriented names

Technology-independent names whenever possible.

---

# 11. Ownership

| Layer | Owner |
|--------|-------|
| Knowledge | Domain Experts |
| Architecture | Architecture Team |
| Design | Architecture & Database Team |
| Services | Platform Team |
| Database | Database Team |

---

# 12. Repository Compliance

Every project artifact shall comply with this repository structure.

Artifacts located outside the approved structure are considered non-compliant.

---

# 13. Freeze Declaration

Repository Baseline Version 2.0 is declared Frozen.

From this version onward:

- Repository structure shall remain stable.
- New artifacts shall follow this structure.
- Structural changes require an approved ADR.
- Existing documents shall be migrated rather than duplicated.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-07 | Initial Repository Structure |
| 2.0 | 2026-07-08 | Repository Baseline Frozen |