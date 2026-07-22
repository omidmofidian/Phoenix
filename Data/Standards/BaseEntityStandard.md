# Base Entity Standard

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-003 |
| Document | BaseEntityStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/BaseEntityStandard.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the canonical Base Entity model for the Phoenix Platform.

Its purpose is to establish a consistent enterprise foundation for all persistent business entities by defining the common attributes shared across the Enterprise Data capability.

The Base Entity promotes consistency, maintainability, traceability, interoperability, and governance while eliminating unnecessary duplication across enterprise data models.

The Base Entity represents the minimum common structure inherited by applicable enterprise entities before domain-specific attributes are introduced.

This standard defines logical enterprise concepts only.

Technology-specific implementation details shall be specified separately during physical database design and implementation.

---

# 2. Scope

This standard applies to all persistent enterprise entities managed within the Phoenix Platform.

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
- Database Migration

This standard governs the common enterprise entity structure regardless of implementation technology.

Exceptions shall require formal architectural review and approval.

---

# 3. Objectives

The Enterprise Base Entity model has the following objectives:

- establish a common enterprise entity structure;
- eliminate duplication across business domains;
- ensure consistent identity management;
- standardize business metadata;
- integrate the canonical audit model;
- support optimistic concurrency;
- improve maintainability and traceability;
- provide a stable foundation for enterprise data modeling;
- support future platform evolution without affecting existing business semantics.

---

# 4. Fundamental Principles

The Enterprise Base Entity is governed by the following principles.

### Enterprise Consistency

Every applicable enterprise entity shall inherit the canonical Base Entity unless an approved architectural exception exists.

---

### Technology Independence

The Base Entity defines logical enterprise concepts independent of database technology, programming language, ORM framework, or implementation platform.

---

### Separation of Concerns

The Base Entity contains only infrastructure-level attributes that are common across enterprise entities.

Business-specific attributes shall remain within their respective business entities.

---

### Reusability

The Base Entity shall maximize reuse across all enterprise domains while minimizing duplicated definitions.

---

### Stability

The canonical Base Entity shall remain stable throughout the lifetime of the platform.

Changes affecting the Base Entity require enterprise architectural review because they potentially impact every persistent entity.

---

### Extensibility

Additional attributes may be introduced by derived entities where required by business rules.

Such extensions shall not modify or redefine the semantics of the canonical Base Entity.

---

# 5. Canonical Base Entity Overview

The Base Entity is composed of four logical categories.

```text
                 Base Entity
                      │
     ┌────────────────┼────────────────┐
     │                │                │
 Identity      Business Metadata   Infrastructure Metadata
                                         │
                              ┌──────────┴──────────┐
                              │                     │
                        Audit Metadata      Version Metadata
```

These categories collectively define the minimum enterprise structure that provides identity, lifecycle traceability, business validity, and concurrency support for persistent enterprise entities.

---

# 6. Canonical Base Entity

The Phoenix Platform adopts a single canonical Base Entity model for all applicable persistent enterprise entities.

The Base Entity defines the minimum set of infrastructure attributes that provide:

- enterprise identity;
- business validity metadata;
- lifecycle audit information;
- optimistic concurrency control.

Business-specific attributes shall never be included in the Base Entity.

The canonical Base Entity is defined below.

| Attribute | Category | Mutable | Immutable | Mandatory | Description |
|-----------|----------|----------|------------|-----------|-------------|
| `id` | Identity | Yes | Yes | Yes | Canonical enterprise identifier |
| `external_code` | Business Metadata | Optional | Optional | No | External business identifier |
| `effective_from` | Business Metadata | Optional | Optional | No | Business validity start |
| `effective_to` | Business Metadata | Optional | Optional | No | Business validity end |
| `is_active` | Business Metadata | Yes | Optional | Yes | Business activity indicator |
| `created_at` | Audit | Yes | Yes | Yes | Creation timestamp |
| `created_by` | Audit | Yes | Yes | Yes | Creator identity |
| `updated_at` | Audit | Yes | No | Conditional | Last update timestamp |
| `updated_by` | Audit | Yes | No | Conditional | Last update actor |
| `version` | Concurrency | Yes | No | Yes | Optimistic concurrency version |

These attributes constitute the enterprise Base Entity baseline.

Additional common attributes shall not be introduced without formal architectural approval.

---

# 7. Identity

Every persistent enterprise entity shall possess exactly one canonical identifier.

The enterprise identifier shall be:

- globally unique;
- immutable;
- business-independent;
- stable throughout the entity lifecycle;
- never reused.

The generation, format, and lifecycle of identifiers are governed by the **Identifier Strategy Standard**.

External identifiers shall complement—but never replace—the canonical enterprise identifier.

---

# 8. Business Metadata

Business metadata describes the operational state and validity of an entity without affecting its identity.

## 8.1 external_code

Represents an identifier assigned by an external organization or information provider.

Examples include:

- Exchange Code
- Market Code
- Board Code
- ISIN
- TSETMC Identifier
- Broker Identifier
- External Vendor Identifier

The meaning of `external_code` is defined by the corresponding business entity.

---

## 8.2 effective_from

Represents the date and time from which the entity becomes valid for business use.

---

## 8.3 effective_to

Represents the date and time until which the entity remains valid.

A NULL value indicates that the entity remains valid indefinitely.

---

## 8.4 is_active

Indicates whether the entity is currently active from a business perspective.

This attribute shall not be interpreted as a deletion indicator.

Business inactivity and data deletion are separate concepts governed by different standards.

---

# 9. Audit Metadata

The Base Entity incorporates the canonical enterprise audit model.

Mandatory creation metadata:

- `created_at`
- `created_by`

Conditional update metadata:

- `updated_at`
- `updated_by`

Audit metadata shall comply with **AuditModelStandard.md**.

Business entities shall not redefine audit semantics or implement alternative audit mechanisms.

---

# 10. Version Metadata

Every mutable enterprise entity shall contain a version attribute supporting optimistic concurrency control.

Characteristics:

- automatically maintained;
- incremented after every successful update;
- independent of audit metadata;
- independent of business versioning.

The `version` attribute protects enterprise data from lost updates in concurrent environments.

Historical version management and change history are governed by separate enterprise standards.

---

# 11. Mutable and Immutable Entities

Enterprise entities are classified according to their lifecycle behavior.

## Mutable Entities

Examples:

- Exchange
- Market
- TradingBoard
- Company
- Instrument
- InstrumentListing
- TradingCalendar
- Configuration

Mutable entities shall implement the complete Base Entity.

---

## Immutable Entities

Examples:

- DailyMarketData
- Historical Market Data
- Historical Financial Statements
- Imported Snapshot Data

Immutable entities may omit update-related attributes because their state never changes after successful persistence.

The minimum required attributes are:

- Identity
- Business Metadata (where applicable)
- Creation Audit Metadata

---

# 12. Entity Lifecycle

The canonical enterprise lifecycle is illustrated below.

```text
Created
    │
    ▼
Active
    │
    ▼
Updated (optional)
    │
    ▼
Inactive (optional)
    │
    ▼
Archived (optional)
```

Deletion is intentionally excluded from the canonical Base Entity model.

Where business rules require soft deletion or physical deletion, those behaviors shall be defined by separate enterprise standards.

---

# 13. Inheritance Rules

The Base Entity shall be inherited by every applicable enterprise entity.

Inheritance shall follow these rules:

- every mutable entity shall implement the complete Base Entity;
- immutable entities may omit update-related attributes where justified;
- reference entities shall follow the same rules based on their lifecycle characteristics;
- business entities may extend the Base Entity with additional business attributes;
- extensions shall never redefine or override the semantics of canonical Base Entity attributes.

These rules ensure enterprise-wide consistency while allowing domain-specific specialization where required.

---

# 14. Compliance

Compliance with this standard is mandatory for all enterprise data models and persistent entities within the Phoenix Platform.

The following requirements shall be satisfied:

- every applicable enterprise entity shall inherit the canonical Base Entity;
- identity attributes shall comply with the Enterprise Identifier Strategy;
- audit attributes shall comply with the Audit Model Standard;
- business metadata shall preserve its defined enterprise semantics;
- version metadata shall be implemented for all mutable entities;
- business entities shall not redefine canonical Base Entity attributes.

Any exception shall:

- be documented;
- include architectural justification;
- undergo impact analysis;
- receive formal approval through the Enterprise Architecture Governance process.

---

# 15. Repository Integration

This standard is part of the Enterprise Data Standards maintained within the Data capability.

Repository location:

```text
Data/
└── Standards/
    └── BaseEntityStandard.md
```

The Base Entity Standard provides the common enterprise foundation for multiple repository areas, including:

- Data/Dictionary
- Data/Database
- Data/Models
- Database DDL
- Database Validation
- Database Migration

All enterprise data models shall derive their common infrastructure attributes from this standard.

---

# 16. Relationship with Enterprise Standards

The Base Entity Standard is one component of the Enterprise Data Standards framework.

Its relationship with other standards is summarized below.

| Standard | Responsibility |
|----------|----------------|
| Enterprise Naming Standard | Enterprise naming conventions |
| Enterprise Data Type Standard | Canonical logical and physical data types |
| Enterprise Identity Standard | Enterprise identity concepts |
| Identifier Strategy | Identifier generation and lifecycle |
| Audit Model Standard | Enterprise audit metadata |
| Enterprise Data Dictionary Standard | Canonical business terminology |
| Base Entity Standard | Common enterprise entity structure |

These standards collectively establish the enterprise foundation for logical modeling, physical database design, and database engineering.

---

# 17. Implementation Guidance

This document defines the logical structure of the Enterprise Base Entity.

It intentionally does not prescribe implementation technologies.

Approved implementation mechanisms may include:

- database inheritance;
- shared table definitions;
- ORM base classes;
- database templates;
- code generation;
- metadata-driven modeling.

Regardless of implementation technology, the logical semantics defined by this standard shall remain unchanged.

---

# 18. Architectural Decisions

The Enterprise Base Entity is governed by the following architectural decisions.

## Canonical Entity Structure

The Phoenix Platform adopts a single canonical Base Entity applicable across all enterprise domains.

Alternative base structures shall not be introduced without formal architectural approval.

---

## Separation of Business and Infrastructure Metadata

The Base Entity contains only infrastructure-level metadata.

Business-specific information shall always remain within business entities.

---

## Stable Enterprise Foundation

The Base Entity is considered a stable enterprise contract.

Changes to the Base Entity may affect every persistent entity and therefore require enterprise-level architectural review.

---

## Independent Enterprise Concerns

The following enterprise concerns remain independent:

- Identity
- Business Metadata
- Audit Metadata
- Version Metadata
- Business State
- Historical Change Tracking
- Event Sourcing

These concerns shall evolve independently to preserve architectural clarity and reduce coupling.

---

# 19. Future Evolution

The Enterprise Base Entity has been intentionally designed to remain compact and stable.

Future standards may extend the enterprise data architecture through independent specifications such as:

- Soft Delete Standard
- Temporal Data Standard
- Historical Change Tracking Standard
- Data Retention Standard
- Archiving Standard
- Lifecycle Management Standard

These capabilities shall complement the Base Entity rather than expanding its canonical structure.

---

# 20. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Base Entity Standard. |
| 2026.2 | 2026-07-22 | Comprehensive revision aligned with the Enterprise Data capability. Updated governance metadata, repository integration, enterprise principles, canonical Base Entity model, implementation guidance, architectural decisions, and cross-standard consistency. |

---

# 21. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative enterprise Base Entity model governing all persistent entities within the platform.

All logical models, physical database models, database implementations, and future data services shall comply with this standard unless an approved architectural exception has been granted.

This standard shall remain the canonical reference for common enterprise entity structure until superseded by a formally approved revision.

---

# End of Document