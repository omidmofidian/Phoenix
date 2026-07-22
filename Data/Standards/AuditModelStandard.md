# Audit Model Standard

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-004 |
| Document | AuditModelStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/AuditModelStandard.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the canonical enterprise audit model used throughout the Phoenix Platform.

Its purpose is to establish a consistent, technology-independent framework for recording the lifecycle of persistent enterprise data while ensuring traceability, accountability, governance, and long-term maintainability.

The canonical audit model provides a common set of audit metadata that shall be applied consistently across enterprise information assets without introducing business-specific semantics into individual entities.

This standard governs enterprise audit metadata only.

It does not define operational logging, application diagnostics, monitoring, event sourcing, security auditing, or historical change management, all of which are governed by separate enterprise standards.

---

# 2. Scope

This standard applies to all persistent enterprise information managed by the Data capability.

Its scope includes:

- Enterprise Data Models
- Enterprise Data Dictionary
- Logical Data Models
- Physical Database Models
- Database Engineering
- Database Implementation
- Business Entities
- Reference Entities
- Configuration Entities
- Service Metadata
- Database Validation

The standard applies equally to manually maintained data and automatically generated data.

This standard does **not** apply to:

- Application Logs
- Operational Logs
- Security Audit Logs
- Monitoring Systems
- Event Streams
- Message Queues
- Distributed Tracing
- Performance Metrics

These concerns belong to separate enterprise capabilities and governance standards.

---

# 3. Audit Objectives

The canonical audit model has the following objectives:

- establish a consistent enterprise audit framework;
- ensure complete lifecycle traceability for persistent business entities;
- support enterprise governance and compliance;
- separate audit metadata from business data;
- minimize duplication across enterprise data models;
- provide implementation-independent audit semantics;
- enable consistent database engineering throughout the platform;
- support future extensibility without impacting existing business models.

The audit model shall remain stable across all implementation technologies adopted by the Phoenix Platform.

---

# 4. Fundamental Principles

The Enterprise Audit Model is governed by the following principles.

### Enterprise Consistency

Every applicable entity shall implement the canonical audit model consistently throughout the platform.

---

### Separation of Concerns

Audit metadata shall remain completely independent of business attributes.

Business entities shall not redefine audit semantics.

---

### Technology Independence

The logical audit model is independent of any database platform, programming language, ORM framework, or implementation technology.

Technology-specific mappings shall be defined separately during physical implementation.

---

### Immutability

Audit information describing entity creation shall never be modified after it has been recorded.

Creation metadata represents historical facts rather than business state.

---

### Automation

Canonical audit metadata shall be generated automatically whenever technically feasible.

Business services shall not manually populate audit attributes except through approved infrastructure mechanisms.

---

### Traceability

Every persistent business entity shall maintain sufficient audit metadata to identify:

- when the entity was created;
- who created it;
- when it was last modified, where applicable;
- who performed the latest successful modification.

These principles establish the foundation for enterprise-wide audit consistency throughout the Phoenix Platform.

---

# 5. Canonical Audit Model

The Phoenix Platform adopts a single canonical audit model for all applicable persistent entities.

The canonical model defines the minimum enterprise audit metadata required to establish lifecycle traceability while remaining independent of business semantics and implementation technologies.

The audit model consists of four standard attributes.

| Attribute | Mandatory | Mutable Entities | Immutable Entities | Description |
|-----------|-----------|------------------|--------------------|-------------|
| `created_at` | Yes | Yes | Yes | Timestamp when the entity was created |
| `created_by` | Yes | Yes | Yes | Actor responsible for entity creation |
| `updated_at` | Conditional | Yes | No | Timestamp of the latest successful modification |
| `updated_by` | Conditional | Yes | No | Actor responsible for the latest successful modification |

These attributes constitute the enterprise audit baseline.

Additional audit attributes shall not be introduced into the canonical model without formal architectural approval.

---

# 6. Canonical Audit Attribute Definitions

## 6.1 created_at

Represents the exact point in time at which the entity first became persistent within the enterprise data store.

Characteristics:

- Mandatory
- Immutable
- Automatically assigned
- Never modified
- Represents a historical fact

---

## 6.2 created_by

Represents the logical actor responsible for creating the entity.

Possible actors include:

- End User
- Internal Service
- Integration Service
- Synchronization Service
- Scheduled Job
- System Process

The attribute shall reference the canonical identity of the originating actor rather than implementation-specific identifiers.

---

## 6.3 updated_at

Represents the timestamp of the latest successful modification to the entity.

Characteristics:

- Applicable only to mutable entities
- Automatically maintained
- Shall remain `NULL` if no update has occurred since creation
- Always corresponds to the most recent committed update

---

## 6.4 updated_by

Represents the logical actor responsible for the modification identified by `updated_at`.

Characteristics:

- Applicable only to mutable entities
- Automatically maintained
- Shall always correspond to the value recorded in `updated_at`
- Shall remain `NULL` when the entity has never been modified

---

# 7. Mutable and Immutable Entities

The Phoenix Platform classifies persistent entities according to their lifecycle characteristics.

---

## Mutable Entities

Mutable entities represent business information that may legitimately change throughout its lifecycle.

Examples include:

- Exchange
- Market
- Board
- Company
- Instrument
- InstrumentListing
- TradingCalendar
- User
- Configuration

Mutable entities shall implement the complete canonical audit model.

---

## Immutable Entities

Immutable entities represent historical facts that shall never change once recorded.

Examples include:

- DailyMarketData
- Historical Market Data
- Imported Trading Sessions
- Historical Financial Statements
- Snapshot Data

Immutable entities shall contain only the creation audit attributes:

- `created_at`
- `created_by`

The update attributes shall be omitted unless an approved architectural exception exists.

---

# 8. Canonical Audit Model Summary

The following diagram illustrates the canonical audit model adopted by the Phoenix Platform.

```text
                   Audit Metadata
                         │
        ┌────────────────┴────────────────┐
        │                                 │
   Creation Metadata                Update Metadata
        │                                 │
   ┌────┴────┐                     ┌──────┴──────┐
   │         │                     │             │
created_at created_by        updated_at   updated_by
```

This model represents the minimum enterprise audit metadata required for persistent information and shall remain consistent across all enterprise data assets.

---

# 9. Audit Lifecycle

The canonical audit lifecycle describes the evolution of persistent enterprise data from creation through its operational lifetime.

The audit model records lifecycle events without defining business workflow or state transitions.

The standard lifecycle is illustrated below.

```text
Create
   │
   ▼
Read
   │
   ▼
Update (optional)
   │
   ▼
Deactivate (optional)
   │
   ▼
Archive (optional)
```

Deletion is intentionally excluded from the canonical audit lifecycle.

Where permanent deletion is permitted by approved business rules, its implementation shall be governed by entity-specific requirements rather than the common audit model.

---

# 10. Time Standard

All audit timestamps shall comply with the Enterprise Time Standard adopted by the Phoenix Platform.

## Canonical Logical Representation

- Event Timestamp

## Canonical Physical Representation

- `timestamp with time zone`

## Time Standard Requirements

- All timestamps shall be stored in Coordinated Universal Time (UTC).
- UTC is the canonical persistence time standard across the Phoenix Platform.
- Applications are responsible for converting UTC values into user-specific local time zones for presentation.
- Business logic shall never rely on client-local timestamps for persistence.

Using a single enterprise time standard guarantees consistency across distributed services, integrations, synchronization processes, and historical datasets.

---

# 11. Actor Identification

Audit metadata shall identify the logical originator of an operation rather than a technology-specific implementation identifier.

Typical enterprise actors include:

- End User
- Internal Service
- Import Service
- Synchronization Service
- Integration Service
- Scheduled Job
- Background Worker
- System Process

The mapping between logical actors and implementation-specific identities (such as user IDs, service accounts, API keys, or authentication principals) shall be defined during implementation.

The canonical audit model remains independent of authentication and identity management technologies.

---

# 12. Audit Responsibility

The responsibility for maintaining canonical audit metadata belongs to the enterprise infrastructure rather than business services.

Accordingly:

- audit attributes shall be populated automatically whenever technically feasible;
- application services shall not manually assign canonical audit metadata;
- audit metadata shall be generated consistently regardless of the application consuming the database;
- implementation mechanisms may include database defaults, triggers, ORM infrastructure, middleware, or approved platform services.

Business logic shall remain focused on business behavior and shall not duplicate infrastructure responsibilities.

This separation improves consistency, reduces implementation errors, and preserves maintainability across the platform.

---

# 13. Relationship with Versioning

Audit metadata and versioning metadata address different architectural concerns and shall remain independent.

| Concern | Purpose |
|----------|---------|
| Audit Metadata | Records **who** performed an operation and **when** it occurred |
| Version Metadata | Records **which version** of an entity is current for concurrency management |
| Change History | Records **how** entity values evolved over time |
| Event Sourcing | Records business events that produced state transitions |

These mechanisms complement one another but shall not be merged into a single enterprise model.

Where optimistic concurrency control is required, version identifiers (such as `row_version` or equivalent mechanisms) shall be governed by a separate enterprise standard rather than the Audit Model Standard.

---

# 14. Compliance

Compliance with this standard is mandatory for all enterprise data artifacts within the Phoenix Platform unless an approved architectural exception has been granted.

Specifically:

- every mutable entity shall implement the complete canonical audit model;
- every immutable entity shall implement the minimum required creation audit metadata;
- audit metadata shall remain independent of business attributes;
- audit semantics shall not be redefined by individual applications or services;
- implementation shall remain consistent across all enterprise domains.

Any deviation from this standard shall:

- undergo architectural review;
- include documented justification;
- include impact assessment;
- receive formal approval from the Enterprise Architecture Team before implementation.

---

# 15. Repository Integration

This standard forms part of the Enterprise Data Standards maintained within the Data capability.

Repository location:

```text
Data/
└── Standards/
    └── AuditModelStandard.md
```

The standard governs audit metadata across multiple repository areas, including:

- Data/Dictionary
- Data/Database
- Data/Models
- Database DDL
- Database Validation
- Database Migration

All implementation artifacts shall derive their audit behavior from this standard rather than defining independent audit mechanisms.

---

# 16. Relationship with Enterprise Standards

The Audit Model Standard is one component of the Enterprise Data Standards framework.

It complements other enterprise standards while maintaining a clearly defined responsibility.

| Standard | Responsibility |
|----------|----------------|
| Enterprise Naming Standard | Naming conventions for enterprise data artifacts |
| Enterprise Data Type Standard | Canonical logical and physical data types |
| Enterprise Identity Standard | Enterprise identity concepts and identifiers |
| Base Entity Standard | Common enterprise entity structure |
| Identifier Strategy | Canonical identifier generation and usage |
| Enterprise Data Dictionary Standard | Business definitions and enterprise terminology |
| Audit Model Standard | Lifecycle audit metadata |

Together, these standards establish a consistent enterprise foundation for data modeling, database engineering, and future platform implementation.

---

# 17. Related Documents

The following documents are directly related to this standard.

## Enterprise Architecture

- Architecture/Enterprise/Governance/EnterpriseArchitectureBaseline.md
- Architecture/Enterprise/Governance/RepositoryArchitecture.md
- Architecture/Enterprise/Governance/STA-001-StandardsArchitecture.md

## Enterprise Data Standards

- Data/Standards/EnterpriseNamingStandard.md
- Data/Standards/EnterpriseDataTypeStandard.md
- Data/Standards/BaseEntityStandard.md
- Data/Standards/EnterpriseIdentityStandard.md
- Data/Standards/IdentifierStrategy.md
- Data/Standards/EnterpriseDataDictionaryStandard.md

## Enterprise Data Models

- Data/Dictionary/
- Data/Database/
- Data/Models/

These documents collectively define the enterprise data architecture adopted by the Phoenix Platform.

---

# 18. Implementation Guidance

This document defines **what** constitutes the canonical enterprise audit model.

It intentionally does not prescribe **how** the model shall be implemented.

Approved implementation mechanisms may include:

- database default values;
- database triggers;
- ORM lifecycle events;
- middleware;
- application infrastructure services;
- platform-level auditing services.

Implementation teams may choose the most appropriate technical mechanism provided that the resulting behavior remains fully compliant with this standard.

Technology-specific implementation decisions shall not alter the logical semantics defined herein.

---

# 19. Architectural Decisions

The Enterprise Audit Model is governed by the following architectural decisions.

---

## Canonical Audit Model

The Phoenix Platform adopts a single enterprise audit model applicable to all persistent data assets.

Multiple audit models for different domains are prohibited unless explicitly approved through the architecture governance process.

---

## Separation of Responsibilities

Audit metadata records lifecycle information only.

The following concerns are governed independently:

- Business State
- Business Workflow
- Soft Delete
- Version Control
- Historical Change Tracking
- Event Sourcing
- Operational Logging
- Security Auditing

This separation preserves architectural clarity and minimizes coupling between enterprise capabilities.

---

## Immutable Historical Data

Historical information represents business facts and shall remain immutable after successful persistence.

Consequently, immutable entities shall only record creation metadata unless a formally approved architectural exception exists.

---

## Infrastructure Responsibility

Generation and maintenance of canonical audit metadata is an infrastructure responsibility.

Business services, application components, and client applications shall not implement independent audit mechanisms that duplicate or contradict the enterprise audit model.

---

## Enterprise Consistency

Every implementation technology adopted by the Phoenix Platform shall preserve the logical semantics defined by this standard.

Technology-specific implementation details shall never alter the meaning of the canonical audit attributes.

---

# 20. Future Evolution

The Enterprise Audit Model is intentionally designed to remain compact, stable, and extensible.

Future enhancements may include:

- Audit Event Catalog
- Audit Policy Framework
- Data Retention Standard
- Historical Change Tracking Standard
- Temporal Data Standard
- Soft Delete Standard
- Data Archiving Standard
- Enterprise Data Lifecycle Standard

These capabilities shall be defined as independent enterprise standards rather than incorporated into the canonical audit model.

This approach preserves the simplicity and long-term stability of the Enterprise Audit Model while allowing the overall governance framework to evolve.

---

# 21. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Audit Model Standard. |
| 2026.2 | 2026-07-22 | Comprehensive revision aligned with the Enterprise Data capability. Updated document classification, governance metadata, repository integration, enterprise audit principles, canonical audit model, implementation guidance, compliance requirements, cross-references, architectural decisions, and future evolution roadmap. |

---

# 22. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative audit model governing persistent enterprise data throughout the platform.

All enterprise data models, database designs, and implementation artifacts shall comply with this standard unless an approved architectural exception has been granted.

This standard shall serve as the authoritative reference for audit metadata within the Enterprise Data capability and shall remain in force until superseded by a formally approved revision.

---

# End of Document