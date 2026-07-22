# Identifier Strategy

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-005 |
| Document | IdentifierStrategy |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/IdentifierStrategy.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the enterprise strategy for generating, assigning, managing, and governing identifiers throughout the Phoenix Platform.

Its purpose is to establish a consistent, scalable, technology-independent identifier architecture that guarantees global uniqueness, long-term stability, interoperability, and architectural consistency across all enterprise domains.

While the Enterprise Identity Architecture Standard defines **what an identity is**, this standard defines **how canonical identifiers are generated, assigned, managed, and used**.

---

# 2. Scope

This standard applies to every persistent enterprise object requiring a canonical identifier, including:

- Business Entities
- Aggregate Roots
- Reference Data
- Configuration Entities
- Integration Entities
- Metadata
- Logical Data Models
- Physical Database Models
- APIs
- Services
- Data Exchange
- Distributed Processing

Temporary runtime objects and transient messages are outside the scope of this standard.

---

# 3. Objectives

The Identifier Strategy is designed to achieve the following objectives:

- guarantee global uniqueness;
- preserve identifier immutability;
- support distributed architectures;
- eliminate identifier collisions;
- separate identity from business semantics;
- simplify service integration;
- enable future scalability;
- maintain long-term architectural stability.

---

# 4. Position within Enterprise Identity Architecture

Identifier Strategy is one component of the broader Enterprise Identity Architecture.

```text
Business Concept
        │
        ▼
Business Identity
        │
        ▼
Enterprise Identity
        │
        ▼
Identifier Strategy
        │
        ▼
Physical Implementation
```

Identity defines **who** an entity is.

Identifier Strategy defines **how that identity is represented and managed**.

---

# 5. Enterprise Identifier Principles

The Phoenix Platform adopts the following enterprise principles.

## Principle 1 — One Canonical Identifier

Every persistent enterprise entity shall possess exactly one canonical identifier.

---

## Principle 2 — Immutability

Canonical identifiers shall never change after assignment.

---

## Principle 3 — Business Independence

Identifiers shall contain no business meaning.

Business semantics belong to business attributes rather than identifiers.

---

## Principle 4 — Global Uniqueness

Canonical identifiers shall remain globally unique across the entire enterprise.

---

## Principle 5 — Technology Independence

Identifier semantics shall remain independent of programming languages, databases, messaging systems, and deployment environments.

---

# 6. Canonical Identifier Model

Every persistent enterprise entity shall implement the following canonical identifier model.

| Property | Value |
|----------|-------|
| Logical Name | id |
| Business Meaning | Canonical Enterprise Identifier |
| Logical Type | Identifier |
| Physical Type | UUID |
| PostgreSQL Type | uuid |
| Nullable | No |
| Mutable | No |
| Unique | Yes |

The `id` attribute represents the canonical identity of the entity throughout the Phoenix Platform.

No alternative attribute shall replace the canonical identifier.

---

# 7. UUID Strategy

Phoenix adopts UUID as the enterprise identifier format.

Recommended implementation:

| Priority | Standard |
|----------|----------|
| Preferred | UUID Version 7 |
| Acceptable | UUID Version 4 |

UUID Version 7 is preferred because it provides:

- global uniqueness;
- chronological ordering;
- improved database index locality;
- better insertion performance;
- suitability for distributed systems.

UUID Version 4 remains acceptable where Version 7 is not yet supported.

The UUID implementation may evolve without affecting the logical identifier architecture.

---

# 8. Identifier Assignment

Canonical identifiers shall be assigned exactly once during entity creation.

Assignment responsibilities belong to the service responsible for creating the entity.

The database shall validate uniqueness but shall not define business-level identifier policies.

This strategy supports:

- distributed services;
- offline processing;
- asynchronous workflows;
- batch imports;
- future cloud-native deployments.

---

# 9. Identifier Lifecycle

The lifecycle of a canonical identifier is:

```text
Generated
      │
      ▼
Assigned
      │
      ▼
Persisted
      │
      ▼
Referenced
      │
      ▼
Archived
```

A canonical identifier is never:

- modified;
- recycled;
- reassigned;
- reused.

Even after an entity has been archived, its identifier shall remain permanently reserved.

---

# 10. Relationship Strategy

All logical relationships shall reference canonical identifiers.

Business identifiers, natural identifiers, and external identifiers shall not be used as enterprise foreign keys except where explicitly required for external integration.

This policy guarantees:

- loose coupling;
- semantic consistency;
- implementation independence;
- simplified migrations;
- stable long-term relationships.

---

# 11. Composite Key Policy

Composite primary keys are prohibited.

Every enterprise entity shall possess one canonical identifier.

Business uniqueness involving multiple attributes shall be enforced through unique constraints rather than composite primary keys.

Examples include:

- exchange + symbol;
- market + board;
- company + listing.

These combinations represent business rules rather than enterprise identity.

---

# 12. Relationship with Enterprise Identity

The Identifier Strategy operates together with the Enterprise Identity Architecture.

Their responsibilities remain distinct.

| Standard | Responsibility |
|----------|----------------|
| Enterprise Identity Standard | Identity architecture |
| Identifier Strategy | Identifier generation and governance |

Identity defines the enterprise concept of identity.

Identifier Strategy defines the implementation rules governing canonical identifiers.

Together they establish a complete enterprise identity framework.

---

# 13. Relationship with Enterprise Data Standards

This standard forms part of the Enterprise Data Standards framework.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Enterprise naming architecture |
| DST-002 — Enterprise Data Type Standard | Enterprise data type architecture |
| DST-003 — Base Entity Standard | Canonical entity structure |
| DST-004 — Audit Model Standard | Audit metadata |
| DST-005 — Identifier Strategy | Canonical identifier strategy |
| DST-006 — Enterprise Data Dictionary Standard | Enterprise metadata |
| DST-007 — Enterprise Database Design Standard | Database engineering |
| DST-008 — Enterprise Identity Standard | Enterprise identity architecture |
| DST-009 — Enterprise Attribute Standard | Enterprise attribute architecture |

Collectively, these standards establish a consistent and governed Enterprise Data Architecture for the Phoenix Platform.

---

# 14. Repository Integration

This standard is maintained within the Enterprise Data capability.

```text
Data/
└── Standards/
    └── IdentifierStrategy.md
```

The Identifier Strategy governs identifiers used by:

- Enterprise Data Dictionary
- Logical Data Models
- Physical Database Models
- Database Objects
- Services
- APIs
- Integration Components
- Reference Data
- Configuration Data

Every persistent enterprise entity shall comply with this strategy.

---

# 15. Compliance

Compliance with this standard is mandatory.

Architecture reviews, logical data model reviews, database design reviews, repository audits, and implementation reviews shall verify conformance.

Exceptions shall:

- be documented;
- include architectural justification;
- undergo impact assessment;
- receive formal Architecture Governance approval.

---

# 16. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Identifier Strategy. |
| 2026.2 | 2026-07-22 | Complete redesign as an Enterprise Data Standard. Introduced enterprise identifier architecture, UUID strategy, lifecycle model, governance rules, repository integration, and alignment with the Enterprise Data Standards framework. |

---

# 17. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative strategy for generating, assigning, governing, and maintaining canonical identifiers across all enterprise domains.

All persistent entities, logical models, physical database designs, services, APIs, and integration components shall comply with this standard unless an approved architectural exception has been granted.

This document remains the authoritative reference for enterprise identifier management until superseded by a formally approved revision.

---

# End of Document