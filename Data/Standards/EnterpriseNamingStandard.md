# Enterprise Naming Standard

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-001 |
| Document | EnterpriseNamingStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/EnterpriseNamingStandard.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the enterprise naming architecture of the Phoenix Platform.

Its purpose is to establish a unified, business-oriented naming framework that ensures consistency, semantic clarity, and long-term maintainability across all enterprise artifacts.

Enterprise naming provides the common vocabulary used by business architecture, information architecture, solution design, database engineering, software services, and operational assets.

Rather than prescribing technology-specific syntax alone, this standard governs the semantic identity of names throughout the platform.

---

# 2. Scope

This standard applies to every named artifact maintained within the Phoenix Platform repository.

The scope includes, but is not limited to:

- Business Capabilities
- Business Domains
- Bounded Contexts
- Aggregates
- Business Entities
- Business Attributes
- Value Objects
- Services
- APIs
- Events
- Database Objects
- Data Dictionary
- SQL Artifacts
- Source Code
- Configuration
- Documentation
- Repository Structure

The standard defines enterprise naming principles independently of implementation technologies.

Technology-specific conventions shall conform to this enterprise standard rather than replace it.

---

# 3. Objectives

The Enterprise Naming Standard establishes a common naming architecture with the following objectives:

- establish a single enterprise vocabulary;
- preserve semantic consistency across all domains;
- improve readability and discoverability;
- support architectural traceability;
- reduce ambiguity;
- encourage reuse of approved business terminology;
- simplify communication between business and technical stakeholders;
- provide a stable foundation for future platform evolution.

---

# 4. Enterprise Naming Philosophy

Names are enterprise assets.

Every approved name represents a business concept before it represents a technical implementation.

Accordingly, business semantics shall always take precedence over implementation convenience.

Naming decisions shall remain stable even when technologies, programming languages, databases, or deployment environments evolve.

The same business concept shall always be represented by one canonical enterprise name.

Different representations may exist for different implementation technologies, but their underlying business meaning shall remain unchanged.

---

# 5. Position within Enterprise Data Architecture

Enterprise Naming forms the semantic foundation of the Phoenix Enterprise Data capability.

```text
Enterprise Architecture
            │
            ▼
Business Vocabulary
            │
            ▼
Enterprise Naming
            │
            ▼
Business Attributes
            │
            ▼
Logical Data Models
            │
            ▼
Physical Database Models
            │
            ▼
Implementation
```

Every design and implementation artifact derives its terminology from the enterprise naming architecture.

Consistent naming enables complete traceability across business architecture, information architecture, software design, and implementation.

---

# 6. Enterprise Naming Architecture

Enterprise naming is organized into multiple architectural layers.

Each layer represents the same business concept while adopting the naming convention appropriate to its context.

Naming transformations shall affect only representation.

Business meaning shall remain unchanged across all layers.

---

# 7. Naming Layers

The Phoenix Platform distinguishes several naming layers.

| Layer | Purpose | Recommended Convention |
|------|---------|------------------------|
| Business Vocabulary | Business communication | Title Case |
| Architecture Models | Domain modeling | PascalCase |
| Enterprise Data Models | Entity and attribute modeling | PascalCase |
| Database Objects | Physical implementation | snake_case |
| SQL Artifacts | Database scripts | snake_case |
| Source Code | Language-specific implementation | Language convention |
| REST APIs | Resource naming | kebab-case |
| Configuration | Configuration parameters | snake_case |
| Environment Variables | Deployment configuration | UPPER_SNAKE_CASE |
| Repository Artifacts | Documents and folders | Repository Standard |

Each layer represents the same canonical enterprise terminology.

Only the presentation changes according to implementation context.

---

# 8. Canonical Naming Principles

Every enterprise name shall satisfy the following principles.

## Principle 1 — Business First

Names shall represent business concepts rather than technical implementations.

Business terminology always has priority over technology-specific terminology.

---

## Principle 2 — One Concept, One Name

A business concept shall have exactly one canonical enterprise name.

Synonyms shall not be used within enterprise models.

---

## Principle 3 — Semantic Stability

Approved names shall remain stable throughout the lifecycle of the platform.

Technology changes shall not require business terminology to change.

---

## Principle 4 — Clarity

Names shall be immediately understandable by both business and technical stakeholders.

Ambiguous terminology shall not be introduced.

---

## Principle 5 — Reusability

Approved enterprise names shall be reused consistently across:

- Architecture
- Data Models
- Services
- APIs
- Database Objects
- Documentation
- Source Code

---

# 9. Naming Characteristics

Enterprise names shall exhibit the following characteristics.

They shall be:

- meaningful;
- descriptive;
- concise;
- business-oriented;
- implementation independent;
- grammatically consistent;
- reusable;
- stable throughout their lifecycle.

Names shall avoid unnecessary complexity while preserving business precision.

---

# 10. Language Policy

English is the canonical language of the Phoenix Platform.

Enterprise identifiers shall always be expressed in English.

Documentation may contain explanatory translations when required, but translated terminology shall never replace the approved enterprise vocabulary.

All business terms shall follow a consistent English vocabulary throughout the repository.

---

# 11. Naming Transformations

The same business concept may appear in different implementation layers using different syntactic conventions.

Example:

```text
Business Vocabulary
Market Symbol

        │

Architecture
MarketSymbol

        │

Logical Model
MarketSymbol

        │

Database
market_symbol

        │

Python
MarketSymbol

        │

REST API
market-symbols
```

These transformations affect only representation.

The canonical business meaning shall remain identical across every layer.

---

# 12. Naming Governance

Enterprise naming is governed through the Phoenix Architecture Governance framework.

Every new enterprise term shall undergo architectural review before becoming part of the canonical vocabulary.

Architecture reviews shall verify that each proposed name:

- represents a unique business concept;
- does not duplicate an existing enterprise term;
- follows approved naming principles;
- is consistent with the Enterprise Business Glossary;
- remains implementation independent;
- supports long-term maintainability.

Changes to established enterprise terminology require formal architectural approval and documented impact assessment.

---

# 13. Relationship with Enterprise Data Standards

The Enterprise Naming Standard serves as the semantic foundation for the complete Enterprise Data Standards framework.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Enterprise naming architecture |
| DST-002 — Enterprise Data Type Standard | Enterprise data type architecture |
| DST-003 — Base Entity Standard | Canonical entity structure |
| DST-004 — Audit Model Standard | Enterprise audit metadata |
| DST-005 — Identifier Strategy | Identifier generation and implementation |
| DST-006 — Enterprise Data Dictionary Standard | Enterprise business metadata |
| DST-007 — Enterprise Database Design Standard | Database engineering standards |
| DST-008 — Enterprise Attribute Standard | Business attribute architecture |
| DST-009 — Enterprise Identity Architecture Standard | Enterprise identity architecture |

Together, these standards establish a coherent and governed Enterprise Data Architecture for the Phoenix Platform.

---

# 14. Repository Integration

This standard is maintained within the Enterprise Data capability.

```text
Data/
└── Standards/
    └── EnterpriseNamingStandard.md
```

The standard governs naming across:

- Business Architecture
- Knowledge Artifacts
- Enterprise Data Dictionary
- Logical Data Models
- Physical Database Models
- Database Objects
- Service Contracts
- APIs
- Source Code
- Repository Structure
- Technical Documentation

Every repository artifact shall conform to the enterprise naming principles defined in this document.

---

# 15. Compliance

Compliance with this standard is mandatory.

Architecture reviews, design reviews, repository audits, database reviews, and code reviews shall verify adherence to this standard.

Non-compliant artifacts shall be corrected before approval unless a formal architectural exception has been granted.

Exceptions shall be:

- documented;
- justified;
- impact assessed;
- approved through the Architecture Governance process.

---

# 16. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Naming Standard. |
| 2026.2 | 2026-07-22 | Complete redesign as an Enterprise Data Standard. Introduced enterprise naming architecture, governance model, naming philosophy, repository integration, semantic traceability, and alignment with the Enterprise Data Standards framework. |

---

# 17. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative naming architecture governing business concepts, information models, database objects, services, APIs, source code, and repository artifacts.

All naming decisions throughout the Phoenix Platform shall comply with this standard unless an approved architectural exception has been granted.

This standard remains the authoritative reference for enterprise naming until superseded by a formally approved revision.

---

# End of Document