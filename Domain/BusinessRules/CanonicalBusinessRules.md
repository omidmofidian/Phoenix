# Canonical Business Rules

| Property | Value |
|----------|-------|
| Document | Canonical Business Rules |
| Project | Phoenix Platform |
| Version | 2026.1 |
| Status | Draft |
| Classification | Canonical Architecture Document |
| Owner | Business Architecture |
| Sprint | Sprint 2 |
| Depends On | Business Capability Map, Bounded Context Definition, Canonical Domain Model, Entity Catalog |
| Next Artifact | Conceptual Domain Relationships |
| Last Updated | 2026-07-04 |

---

# 1. Purpose

The purpose of this document is to define the canonical business rules governing the Phoenix Platform.

Business Rules represent stable business knowledge that exists independently of software implementation, database technologies, programming languages, or deployment architecture.

This document establishes the authoritative business constraints, policies, invariants, and operational principles that shall govern every future implementation artifact throughout the platform.

These rules form the foundation from which logical models, physical database structures, services, APIs, analytical models, and software components will be derived.

---

# 2. Scope

This document applies to every business domain defined within the Phoenix Platform.

Its scope includes:

- Business Constraints
- Domain Policies
- Business Invariants
- Entity Relationships
- Aggregate Consistency Rules
- Lifecycle Constraints
- Data Governance Rules
- Temporal Rules
- Cross-Domain Rules
- Investment Selection Principles
- Risk Governance Principles

This document intentionally excludes:

- Database implementation details
- SQL constraints
- API behavior
- Application logic
- User interface behavior
- Infrastructure implementation

Those artifacts shall implement these rules but shall never redefine them.

---

# 3. Objectives

The objectives of this document are:

- Establish a single source of business truth.
- Preserve business consistency across all implementation layers.
- Eliminate ambiguity in business interpretation.
- Ensure long-term architectural stability.
- Support traceability from business requirements to implementation.
- Minimize architectural drift throughout the project lifecycle.
- Enable reproducible system behavior.
- Provide a stable foundation for future expansion into additional financial markets.

---

# 4. Architectural Position

Within the Phoenix Platform architecture hierarchy, this document occupies the Business Architecture layer.

```
Business Vision
        │
        ▼
Business Capability Map
        │
        ▼
Bounded Contexts
        │
        ▼
Canonical Domain Model
        │
        ▼
Entity Catalog
        │
        ▼
Canonical Business Rules
        │
        ▼
Conceptual Relationships
        │
        ▼
Logical Database Design
        │
        ▼
Physical Database Design
        │
        ▼
Implementation
```

All lower architectural layers shall conform to the rules defined in this document.

---

# 5. Guiding Principles

The following principles govern every business rule defined herein.

## BP-001 Business First

Business requirements take precedence over implementation concerns.

Business Rules shall never be altered solely to simplify software implementation.

---

## BP-002 Technology Independence

Business Rules shall remain independent of:

- Database technology
- Programming language
- Framework
- Infrastructure
- Deployment model

---

## BP-003 Canonical Definition

Every business concept shall have one authoritative definition.

Duplicate or conflicting business interpretations are prohibited.

---

## BP-004 Stability

Business Rules are expected to remain significantly more stable than implementation artifacts.

Implementation evolves.

Business Rules remain stable.

---

## BP-005 Traceability

Every Business Rule shall be traceable to one or more of the following:

- Business Capability
- Bounded Context
- Domain Entity
- Aggregate
- Architecture Decision Record (ADR)
- Logical Data Model
- Physical Database Object
- Service
- API
- Test Case

---

## BP-006 Business Language

Business Rules shall use the Ubiquitous Language defined by the Canonical Domain Model.

Technical terminology shall not replace business terminology.

---

## BP-007 Single Source of Truth

A business rule shall be defined only once.

Other documents may reference a rule but shall not redefine it.

---

## BP-008 Explicitness

Implicit business assumptions are prohibited.

Every important business constraint shall be documented explicitly.

---

## BP-009 Consistency

Business Rules shall not contradict one another.

Any conflicting interpretation requires an Architecture Decision Record (ADR).

---

## BP-010 Evolution

Business Rules may evolve only through controlled architectural governance.

Historical versions shall remain traceable.

---

# 6. Rule Classification

Business Rules are classified according to their purpose.

| Code | Category | Description |
|------|----------|-------------|
| FND | Foundational | Fundamental architectural business principles |
| STR | Structural | Structural constraints between business entities |
| VAL | Validation | Business validation rules |
| LIF | Lifecycle | Entity lifecycle constraints |
| TMP | Temporal | Time-related business rules |
| DER | Derivation | Rules governing derived analytical data |
| CAL | Calculation | Business calculation principles |
| SEL | Selection | Investment opportunity selection rules |
| RSK | Risk | Risk management principles |
| GOV | Governance | Business governance and ownership |
| SEC | Security | Business security requirements |
| CRS | Cross-Domain | Rules involving multiple domains |

Each Business Rule shall belong to exactly one primary category.

---

# 7. Rule Specification Standard

Every Business Rule defined within this document shall follow a common specification.

| Field | Description |
|------|-------------|
| Rule ID | Unique immutable identifier |
| Name | Official rule name |
| Category | Rule classification |
| Domain | Related Bounded Context |
| Applies To | Entity or Aggregate |
| Description | Business explanation |
| Rule Statement | Canonical business statement |
| Rationale | Business justification |
| Exceptions | Approved business exceptions |
| Related ADR | Associated Architecture Decision Record(s) |
| Future Implementation | Expected implementation layer(s) |

The specification format ensures consistency, traceability, and maintainability throughout the project lifecycle.

---

# 8. Rule Identification Convention

Business Rules shall follow the identifier format:

```
BR-<Category>-<Number>
```

Examples:

```
BR-FND-001
BR-STR-014
BR-VAL-007
BR-LIF-003
BR-TMP-002
BR-SEL-001
```

Rule identifiers are permanent.

Identifiers shall never be reused, even if a rule is retired.

---

# 9. Interpretation Rules

Unless explicitly stated otherwise:

- All Business Rules are mandatory.
- Business Rules apply platform-wide.
- Rules remain valid across all supported financial markets.
- Future implementations shall comply with these rules.
- Violations require explicit architectural approval.
- Business intent always overrides implementation convenience.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial canonical structure established. |

# 10. Foundational Business Rules

Foundational Business Rules establish the universal principles governing the entire Phoenix Platform.

These rules apply to every Business Domain, every Bounded Context, every Entity, every Aggregate, and every future implementation artifact.

Unless explicitly overridden by an approved Architecture Decision Record (ADR), Foundational Rules are mandatory.

---

## BR-FND-001

### Name

Business First

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business requirements shall always take precedence over implementation concerns.

### Rationale

Business architecture defines the system.
Technology implements the business architecture.

### Related ADR

ADR-000 Architecture Principles

---

## BR-FND-002

### Name

Single Source of Business Truth

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Every business concept shall have exactly one canonical definition.

Duplicate or conflicting business definitions are prohibited.

### Rationale

Multiple definitions inevitably lead to inconsistent implementations.

---

## BR-FND-003

### Name

Canonical Domain Language

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business terminology shall conform to the Canonical Domain Model.

Alternative terminology shall not be introduced without architectural approval.

### Rationale

A shared ubiquitous language reduces ambiguity throughout the platform.

---

## BR-FND-004

### Name

Business Rule Independence

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules shall remain independent of implementation technologies.

Business Rules shall not reference:

- SQL
- Database vendors
- Programming languages
- Frameworks
- Infrastructure
- Deployment models

### Rationale

Business knowledge must survive technology changes.

---

## BR-FND-005

### Name

Stable Business Rules

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules are expected to remain significantly more stable than implementation artifacts.

### Rationale

Software evolves continuously.

Business knowledge evolves slowly.

---

## BR-FND-006

### Name

Architecture Compliance

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

All implementation artifacts shall comply with the approved Business Architecture.

Implementation shall never redefine business behavior.

### Future Implementation

- Database
- Services
- APIs
- Applications

---

## BR-FND-007

### Name

No Implicit Business Knowledge

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business assumptions shall always be documented explicitly.

Undocumented assumptions are considered invalid.

### Rationale

Hidden business knowledge creates inconsistent implementations.

---

## BR-FND-008

### Name

Consistency of Business Rules

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules shall never contradict one another.

Conflicts shall be resolved through the Architecture Decision Record (ADR) process.

### Related ADR

ADR Governance

---

## BR-FND-009

### Name

Traceability

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Every Business Rule shall be traceable to one or more Business Capabilities and one or more implementation artifacts.

### Traceability Chain

Business Capability

↓

Bounded Context

↓

Domain Model

↓

Business Rule

↓

Entity

↓

Logical Model

↓

Physical Model

↓

Service

↓

API

↓

Test Case

### Rationale

Complete traceability ensures architectural integrity throughout the system lifecycle.

---

## BR-FND-010

### Name

Business Rule Versioning

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules are immutable once approved.

Changes shall be introduced by creating a new document revision.

Historical revisions shall remain preserved.

---

## BR-FND-011

### Name

Business Rule Authority

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Canonical Business Rules constitute the authoritative source of business behavior.

Other project documents may reference these rules but shall not redefine or duplicate them.

---

## BR-FND-012

### Name

Architecture Before Implementation

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules shall be fully defined and approved before logical or physical implementation begins.

### Rationale

Architecture precedes implementation.

Implementation follows architecture.

---

## BR-FND-013

### Name

Platform Independence

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules shall remain valid regardless of supported financial market, asset class, or data provider.

### Rationale

Phoenix is designed as a multi-market analytical platform.

---

## BR-FND-014

### Name

Business Entity Integrity

### Category

Foundational

### Applies To

All Business Entities

### Rule Statement

Every Business Entity shall represent a meaningful business concept with a clearly defined responsibility.

Entities shall not exist solely for technical convenience.

---

## BR-FND-015

### Name

Aggregate Consistency

### Category

Foundational

### Applies To

All Aggregates

### Rule Statement

Every Aggregate shall have exactly one Aggregate Root.

All modifications to Aggregate members shall occur through the Aggregate Root.

### Related ADR

Aggregate Design

---

## BR-FND-016

### Name

Immutable Business Identity

### Category

Foundational

### Applies To

All Business Entities

### Rule Statement

Business identifiers are immutable.

Business identity shall never change throughout the lifecycle of an entity.

---

## BR-FND-017

### Name

Separation of Business and Analytical Data

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Original business data and derived analytical data shall remain logically separated.

Analytical data shall never replace original business information.

### Related ADR

ADR-008 Separation of Core Business Entities and Derived Analytical Entities

---

## BR-FND-018

### Name

Historical Data Preservation

### Category

Foundational

### Applies To

Historical Data

### Rule Statement

Historical business data shall be preserved.

Approved historical records shall not be physically deleted.

Logical retirement mechanisms may be used where applicable.

### Related ADR

ADR-004 Immutable Historical Data

---

## BR-FND-019

### Name

Business Time Awareness

### Category

Foundational

### Applies To

Historical Business Data

### Rule Statement

Business events shall be evaluated according to Business Time rather than System Time unless explicitly stated otherwise.

### Related ADR

ADR-006 Business Time and System Time Separation

---

## BR-FND-020

### Name

Extensibility

### Category

Foundational

### Applies To

Entire Platform

### Rule Statement

Business Rules shall support future expansion without requiring architectural redesign.

New financial markets, asset classes, analytical models, and services shall integrate through extension rather than modification of existing business principles.

---

# End of Foundational Business Rules

# 11. Identity Domain Business Rules

The Identity Domain defines the canonical rules governing the identification of business entities within the Phoenix Platform.

The purpose of this domain is to ensure that every business entity possesses a stable, unique and immutable identity throughout its lifecycle.

Identity is a business concept rather than a technical implementation.

Business identities remain valid regardless of storage technology, database implementation or software architecture.

---

## BR-IDN-001

### Name

Unique Business Identity

### Category

Structural

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Every Business Entity shall possess exactly one unique Business Identifier.

No two active business entities may share the same Business Identifier.

### Rationale

Unique identification is essential for maintaining business consistency and traceability.

---

## BR-IDN-002

### Name

Immutable Business Identifier

### Category

Lifecycle

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

A Business Identifier shall never change after the entity has been created.

Corrections shall be handled through business governance rather than identifier replacement.

### Related Rules

BR-FND-016

---

## BR-IDN-003

### Name

Identity Before Relationships

### Category

Structural

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

An entity shall establish its Business Identity before participating in any business relationship.

### Rationale

Relationships cannot exist without identifiable participants.

---

## BR-IDN-004

### Name

Identity Independence

### Category

Governance

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Business Identity shall remain independent of implementation technologies.

Business identifiers shall never encode:

- Database Keys
- Physical Storage Locations
- Infrastructure Information
- Software Components

### Rationale

Business identity must survive technological evolution.

---

## BR-IDN-005

### Name

Business Identity Persistence

### Category

Lifecycle

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Business Identity shall remain valid throughout the entire lifecycle of an entity, including inactive, suspended, archived and historical states.

---

## BR-IDN-006

### Name

Identity Reuse Prohibition

### Category

Governance

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Retired Business Identifiers shall never be reassigned to another Business Entity.

### Rationale

Identifier reuse compromises historical traceability.

---

## BR-IDN-007

### Name

Identity Traceability

### Category

Governance

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Every Business Identifier shall remain traceable throughout the complete lifecycle of the entity.

Business history shall remain reconstructable at any point in time.

---

## BR-IDN-008

### Name

Canonical Identity Ownership

### Category

Governance

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Each Business Identifier shall have exactly one authoritative owner within the Canonical Domain Model.

Duplicate ownership is prohibited.

---

## BR-IDN-009

### Name

Business Identity Validation

### Category

Validation

### Domain

Identity

### Applies To

All Business Entities

### Rule Statement

Business Identifiers shall conform to the validation rules defined by their corresponding Business Entity.

Invalid identities shall not be accepted into the Canonical Domain Model.

---

## BR-IDN-010

### Name

Identity Transparency

### Category

Governance

### Domain

Identity

### Applies To

Entire Platform

### Rule Statement

Business Identity shall represent business meaning only.

Implementation-specific information shall never be inferred from Business Identifiers.

---

## BR-IDN-011

### Name

Historical Identity Preservation

### Category

Temporal

### Domain

Identity

### Applies To

Historical Business Entities

### Rule Statement

Historical records shall preserve the original Business Identifier assigned at entity creation.

Historical identity shall never be rewritten.

### Related ADR

ADR-004 Immutable Historical Data

ADR-006 Business Time and System Time Separation

---

## BR-IDN-012

### Name

Cross-Domain Identity Consistency

### Category

Cross-Domain

### Domain

Identity

### Applies To

Entire Platform

### Rule Statement

A Business Identifier referenced across multiple Bounded Contexts shall always represent the same business concept.

Different meanings for the same identifier are prohibited.

---

# End of Identity Domain Business Rules

# 12. Reference Domain Business Rules

The Reference Domain defines the canonical reference data used throughout the Phoenix Platform.

Reference data provides stable business definitions shared across multiple business domains.

Reference Entities are authoritative, relatively static, and intended for reuse throughout the platform.

Operational domains shall reference Reference Entities but shall never redefine them.

---

## BR-REF-001

### Name

Canonical Reference Data

### Category

Foundational

### Domain

Reference

### Applies To

All Reference Entities

### Rule Statement

Every reference entity shall represent a single canonical business concept.

Duplicate reference definitions are prohibited.

### Rationale

Reference data establishes a common business vocabulary across the platform.

---

## BR-REF-002

### Name

Reference Data Ownership

### Category

Governance

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Each reference entity shall have exactly one authoritative source within the platform.

Alternative definitions are not permitted.

---

## BR-REF-003

### Name

Reference Before Usage

### Category

Structural

### Domain

Reference

### Applies To

Entire Platform

### Rule Statement

Reference entities shall exist before they are referenced by operational entities.

Operational entities shall not create implicit reference values.

### Rationale

Business consistency requires explicit reference definitions.

---

## BR-REF-004

### Name

Reference Data Reusability

### Category

Structural

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Reference entities shall be reusable across multiple bounded contexts.

Duplicate copies of the same business concept are prohibited.

---

## BR-REF-005

### Name

Reference Data Stability

### Category

Lifecycle

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Reference data is expected to remain relatively stable.

Business changes shall occur through controlled governance procedures.

---

## BR-REF-006

### Name

Immutable Business Meaning

### Category

Governance

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

The business meaning of a reference entity shall remain stable throughout its lifecycle.

Changes to descriptions or metadata shall not alter its business identity.

---

## BR-REF-007

### Name

Reference Entity Independence

### Category

Structural

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Reference entities shall not depend upon operational entities.

Operational entities may reference reference entities.

The reverse dependency is prohibited.

### Rationale

Reference data forms the foundation of the business model.

---

## BR-REF-008

### Name

Reference Identifier

### Category

Validation

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Every reference entity shall possess a unique immutable business identifier.

Identifiers shall remain valid across all supported financial markets.

---

## BR-REF-009

### Name

Shared Business Vocabulary

### Category

Cross-Domain

### Domain

Reference

### Applies To

Entire Platform

### Rule Statement

All bounded contexts shall use the canonical reference entities defined by the Reference Domain.

Alternative business vocabularies are prohibited.

---

## BR-REF-010

### Name

Reference Data Validation

### Category

Validation

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

Operational data shall reference only valid and approved reference entities.

References to undefined values shall be rejected.

---

## BR-REF-011

### Name

Historical Consistency

### Category

Temporal

### Domain

Reference

### Applies To

Historical Data

### Rule Statement

Historical business records shall preserve the original reference values that were valid at the corresponding Business Time.

Reference updates shall not invalidate historical business interpretation.

---

## BR-REF-012

### Name

Reference Data Extensibility

### Category

Governance

### Domain

Reference

### Applies To

Reference Entities

### Rule Statement

New reference entities may be introduced without modifying existing reference definitions.

Platform growth shall occur through extension rather than modification.

---

# End of Reference Domain Business Rules