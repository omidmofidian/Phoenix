# Aggregate Design Guidelines

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-007 |
| Document | AggregateDesignGuidelines |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Architecture Standard |
| Owner | Enterprise Architecture |
| Architecture Layer | Domain Architecture |
| Depends On | BusinessCapabilityMap, CanonicalDomainModel, AggregateCatalog, AggregateDefinitions, ArchitecturalPrinciples |
| Consumed By | ConceptualDataModel, LogicalDatabaseModel, ServiceDesign, Application Services |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document establishes the enterprise standards for designing Aggregates within the Phoenix Platform.

Aggregates define the fundamental consistency boundaries of the business domain and represent one of the primary architectural building blocks of the platform's Domain-Driven Design (DDD) approach.

The objective of this standard is to ensure that all Aggregates are designed consistently across business domains, preserve business integrity, and remain independent of implementation technologies, persistence mechanisms, and deployment architecture.

This document serves as the authoritative reference for Aggregate design and shall be applied to every current and future business domain within the Phoenix Platform.

---

# 2. Objectives

The objectives of this standard are to:

- Establish a consistent enterprise approach to Aggregate design.
- Define architectural rules for Aggregate boundaries.
- Preserve business consistency within transactional boundaries.
- Standardize Aggregate Root responsibilities.
- Promote high cohesion and low coupling across business domains.
- Support long-term maintainability and extensibility.
- Enable independent evolution of business domains.
- Ensure alignment between Domain Models, Services, and Data Models.
- Reduce architectural ambiguity during software implementation.

---

# 3. Scope

This standard applies to every Aggregate defined within the Phoenix Platform, including but not limited to:

- Reference Aggregates
- Core Business Aggregates
- Market Aggregates
- Portfolio Aggregates
- Analytics Aggregates
- Strategy Aggregates
- Research Aggregates
- Integration Aggregates
- Configuration Aggregates
- Audit Aggregates

This document governs conceptual and logical Aggregate design only.

It does not define:

- Database schemas
- Table structures
- Foreign keys
- Object-relational mappings (ORM)
- API contracts
- Service implementations
- Physical persistence strategies

These concerns are addressed by their corresponding architecture and implementation artifacts.

---

# 4. Architectural Context

Within the Phoenix Architecture Framework, Aggregate Design bridges the gap between business architecture and solution architecture.

```

Business Capability Map

↓

Canonical Domain Model

↓

Aggregate Catalog

↓

Aggregate Definitions

↓

Aggregate Design Guidelines

↓

Conceptual Data Model

↓

Logical Database Model

↓

Physical Database Model

↓

Application Services

```

Aggregate Design therefore serves as the primary mechanism for translating business concepts into consistent implementation boundaries while preserving enterprise architectural integrity.

---

# 5. Fundamental Definition

An Aggregate is a cohesive cluster of business entities that collectively represent a single business consistency boundary.

Each Aggregate:

- encapsulates a single business concept;
- contains exactly one Aggregate Root;
- owns the lifecycle of all contained entities;
- protects business invariants;
- defines the transactional consistency boundary;
- exposes business behavior through its Aggregate Root only.

An Aggregate is a business construct rather than a database construct and shall never be designed according to physical persistence considerations.

---

# 6. Relationship to Other Standards

This standard shall be used together with the following enterprise architecture artifacts:

- BusinessCapabilityMap
- CanonicalDomainModel
- AggregateCatalog
- AggregateDefinitions
- ServiceContextMap
- ArchitecturalPrinciples
- EnterpriseIdentityStandard
- EnterpriseAttributeStandard
- ConceptualDataModel
- LogicalDatabaseModel

Collectively, these artifacts establish the complete enterprise governance model for Aggregate design.

---

# 7. Aggregate Design Principles

Every Aggregate defined within the Phoenix Platform shall comply with the following architectural principles.

---

## AGG-001 — Single Business Responsibility

Each Aggregate shall represent exactly one business capability or one cohesive business concept.

An Aggregate shall never combine unrelated responsibilities merely for implementation convenience.

Business cohesion shall always take precedence over technical optimization.

---

## AGG-002 — Single Aggregate Root

Every Aggregate shall contain exactly one Aggregate Root.

The Aggregate Root is the only externally accessible entity and is responsible for:

- enforcing business rules;
- validating business operations;
- maintaining aggregate consistency;
- controlling lifecycle operations;
- protecting business invariants.

Direct access to internal entities from outside the Aggregate is prohibited.

---

## AGG-003 — Explicit Consistency Boundary

Every Aggregate defines a transactional consistency boundary.

All business invariants contained within an Aggregate shall always remain valid at the completion of every business transaction.

Whenever possible, a business transaction shall modify only one Aggregate.

---

## AGG-004 — High Cohesion

Entities belonging to the same Aggregate shall exhibit strong business cohesion.

Entities that rarely participate in the same business transaction or evolve independently should belong to different Aggregates.

---

## AGG-005 — Low Coupling

Aggregates shall remain independent from one another.

Dependencies between Aggregates shall be minimized and limited to stable business identifiers or published service interfaces.

Implementation details of one Aggregate shall never be visible to another.

---

## AGG-006 — Reference by Identity

Cross-Aggregate references shall always be established using immutable identifiers.

Aggregates shall never maintain direct object references to other Aggregate Roots or internal entities.

Navigation across Aggregate boundaries through object graphs is prohibited.

---

## AGG-007 — Lifecycle Ownership

Every entity contained within an Aggregate is owned exclusively by its Aggregate Root.

The Aggregate Root controls:

- creation;
- modification;
- activation;
- deactivation;
- archival;
- deletion (where permitted).

Child entities shall not exist independently of their owning Aggregate.

---

## AGG-008 — Business Invariant Protection

Business invariants shall be enforced exclusively by the Aggregate Root.

Validation logic shall never be delegated to child entities, repositories, database triggers, or infrastructure components.

---

## AGG-009 — Technology Independence

Aggregate design shall remain independent of:

- relational databases;
- object-relational mapping frameworks;
- messaging technologies;
- APIs;
- programming languages;
- deployment models.

Business modeling shall always precede implementation decisions.

---

## AGG-010 — Stable Public Interface

An Aggregate exposes only its public business behaviors.

Internal entities, implementation details, persistence structures, and lifecycle management mechanisms shall remain encapsulated.

---

# 8. Aggregate Root Responsibilities

Every Aggregate Root shall perform the following responsibilities:

- maintain business consistency;
- enforce business invariants;
- coordinate child entity lifecycle;
- validate business operations;
- expose domain behaviors;
- prevent invalid state transitions;
- protect Aggregate boundaries;
- publish domain events when appropriate.

Aggregate Roots shall not contain infrastructure concerns, persistence logic, or user interface behavior.

---

# 9. Child Entity Rules

Entities contained within an Aggregate shall comply with the following rules.

### Ownership

Each child entity shall belong to exactly one Aggregate.

Shared ownership is prohibited.

### Lifecycle

A child entity cannot exist independently from its Aggregate Root.

Its lifecycle shall always be governed by the Aggregate Root.

### Visibility

Child entities are internal implementation details.

External services shall never directly reference or manipulate them.

### Identity

Child entities may possess local identifiers, but enterprise identity belongs exclusively to the Aggregate Root.

### Persistence

Persistence of child entities shall always occur as part of Aggregate persistence.

Independent persistence of child entities is prohibited.

---

# 10. Aggregate Classification

Within the Phoenix Platform, Aggregates are classified into the following architectural categories:

| Category | Purpose |
|----------|---------|
| Reference Aggregate | Stable enterprise reference information |
| Core Aggregate | Core business concepts |
| Transactional Aggregate | Business transactions and operational workflows |
| Market Aggregate | Financial market observations and events |
| Analytical Aggregate | Derived analytical information |
| Strategy Aggregate | Investment and trading decision logic |
| Research Aggregate | Experimental and quantitative research |
| Integration Aggregate | External system interoperability |
| Configuration Aggregate | Runtime configuration management |
| Audit Aggregate | Enterprise traceability and auditability |

Each category follows the same Aggregate Design principles while addressing different business responsibilities.

---

# 11. Aggregate Communication

Aggregates shall collaborate only through well-defined architectural mechanisms.

The following communication principles shall be observed throughout the platform.

---

## AGC-001 — Identity-Based References

Aggregates shall reference other Aggregates only through their canonical identifiers.

Direct references to internal entities are prohibited.

---

## AGC-002 — Service-Oriented Collaboration

Business interactions between Aggregates shall be coordinated by Application Services or Domain Services.

Aggregates shall not orchestrate other Aggregates directly.

---

## AGC-003 — Domain Events

When business processes span multiple Aggregates, communication should be performed through published Domain Events whenever eventual consistency is acceptable.

---

## AGC-004 — Published Contracts

Cross-domain communication shall occur only through published service contracts.

Internal implementation details shall never be exposed outside the Aggregate boundary.

---

# 12. Aggregate Lifecycle

Every Aggregate follows a well-defined business lifecycle.

Although lifecycle stages vary by business domain, the following conceptual states are common across the platform.

```
Created
      │
      ▼
Active
      │
      ▼
Modified
      │
      ▼
Suspended (Optional)
      │
      ▼
Retired
      │
      ▼
Archived
```

Deletion of Aggregate Roots should be avoided whenever historical traceability is required.

Business deactivation is generally preferred over physical deletion.

---

# 13. Aggregate Evolution

Business models evolve continuously.

Aggregate evolution shall preserve:

- business meaning;
- Aggregate boundaries;
- public contracts;
- business identifiers;
- business invariants;
- backward compatibility whenever practical.

Changes that modify Aggregate ownership, boundaries, or responsibilities require approval through the Architecture Decision Record (ADR) process.

---

# 14. Aggregate Design Heuristics

Architects should consider creating a new Aggregate when one or more of the following conditions exist:

- a separate business consistency boundary is identified;
- lifecycle differs from existing Aggregates;
- business ownership differs;
- transactional boundaries differ;
- business invariants differ;
- security boundaries differ;
- independent evolution is expected.

Conversely, entities should remain within the same Aggregate when they:

- always change together;
- participate in the same business transaction;
- share identical lifecycle rules;
- collectively enforce the same business invariants.

---

# 15. Architectural Anti-Patterns

The following Aggregate design practices are prohibited within the Phoenix Platform.

- Multiple Aggregate Roots within a single Aggregate.
- Aggregates representing multiple unrelated business concepts.
- Shared child entities between Aggregates.
- Direct object references across Aggregate boundaries.
- Circular Aggregate dependencies.
- Persistence-driven Aggregate design.
- Infrastructure concerns embedded within Aggregate logic.
- Business rules distributed across multiple Aggregates.
- Excessively large ("God") Aggregates.
- Aggregate boundaries determined solely by database normalization.

---

# 16. Aggregate Validation Checklist

Every Aggregate shall satisfy the following architectural review criteria before approval.

| Validation Question | Required |
|---------------------|----------|
| Does the Aggregate represent a single business concept? | Yes |
| Does it contain exactly one Aggregate Root? | Yes |
| Are business invariants clearly identified? | Yes |
| Is the consistency boundary well defined? | Yes |
| Does the Aggregate fully own its child entities? | Yes |
| Are cross-Aggregate references identity-based? | Yes |
| Is business cohesion high? | Yes |
| Are dependencies minimized? | Yes |
| Can most business transactions remain inside the Aggregate? | Yes |
| Is the Aggregate independent of persistence technology? | Yes |
| Does it comply with the Canonical Domain Model? | Yes |
| Does it comply with the Service Context Map? | Yes |

All questions shall be answered positively before an Aggregate becomes part of the canonical architecture.

---

# 17. Compliance

Compliance with this standard is mandatory for all business domains within the Phoenix Platform.

Architecture reviews shall verify that every newly introduced Aggregate conforms to this document.

Non-compliant Aggregate designs shall be rejected until corrective actions have been completed.

---

# 18. Traceability

This standard is governed by and traceable to the following enterprise architecture artifacts:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- BusinessCapabilityMap
- CanonicalDomainModel
- AggregateCatalog
- AggregateDefinitions
- ServiceContextMap
- EnterpriseIdentityStandard
- EnterpriseAttributeStandard
- ConceptualDataModel
- LogicalDatabaseModel

---

# Revision History

| Version | Date | Description |
|----------|------------|-----------------------------------------------|
| 2026.1 | 2026-07-07 | Initial version. |
| 2026.2 | 2026-07-18 | Complete architectural rewrite aligned with the canonical Phoenix Domain Architecture, Business Capability Model, and Aggregate governance standards. |