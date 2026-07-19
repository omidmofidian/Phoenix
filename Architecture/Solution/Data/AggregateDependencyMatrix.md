# Aggregate Dependency Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-003 |
| Document | AggregateDependencyMatrix |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Architecture Layer | Logical Data Architecture |
| Depends On | CanonicalDomainModel, AggregateCatalog, AggregateDefinitions, EntityCatalog, DomainDependencyMatrix |
| Consumed By | AggregateBoundaryValidation, LogicalDataModel, CanonicalEnterpriseERD |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical dependency relationships among Aggregates within the Phoenix Platform.

It establishes the approved dependency direction, dependency strength, and architectural constraints between Aggregates while preserving business ownership and consistency boundaries.

The Aggregate Dependency Matrix serves as the authoritative reference for validating Aggregate interactions during Logical Data Modeling and before generating the Canonical Enterprise ERD.

This document is independent of implementation technology, database design, and service implementation.

---

# 2. Scope

This document defines:

- Aggregate-to-Aggregate dependencies
- Dependency direction
- Dependency classification
- Dependency strength
- Cross-Domain dependencies
- Architectural dependency constraints
- Aggregate interaction rules

This document does not define:

- Database foreign keys
- Physical relationships
- Service communication mechanisms
- API contracts
- Implementation details

---

# 3. Dependency Principles

Aggregate dependencies within the Phoenix Platform shall comply with the following architectural principles.

## ADP-001 — Aggregate Independence

Every Aggregate shall preserve its own business consistency boundary.

---

## ADP-002 — Single Aggregate Root

Every Aggregate shall expose exactly one Aggregate Root.

External Aggregates shall communicate only through the Aggregate Root.

---

## ADP-003 — Unidirectional Dependencies

Aggregate dependencies shall be unidirectional.

Circular dependencies are prohibited.

---

## ADP-004 — Business-Driven Relationships

Dependencies shall represent business semantics rather than implementation convenience.

---

## ADP-005 — Domain Ownership

Aggregate dependencies shall never violate Domain ownership defined by the Canonical Domain Model.

---

## ADP-006 — Technology Independence

Aggregate dependencies shall remain independent of database technology, programming language, persistence strategy, and service implementation.

---

# 4. Aggregate Dependency Matrix

| ID | Source Aggregate | Target Aggregate | Dependency Type | Strength | Cross Domain | Business Purpose |
|----|------------------|------------------|-----------------|----------|--------------|------------------|
| AGG-001 | Exchange | Market | Structural | Strong | No | Every Exchange belongs to one Market. |
| AGG-002 | Trading Board | Exchange | Structural | Strong | No | Every Trading Board belongs to one Exchange. |
| AGG-003 | Industry | Sector | Classification | Strong | No | Every Industry belongs to one Sector. |
| AGG-004 | Instrument | Company | Business | Strong | No | Every Instrument is issued by one Company. |
| AGG-005 | Instrument Listing | Instrument | Business | Strong | Yes | A Listing cannot exist without an Instrument. |
| AGG-006 | Instrument Listing | Trading Board | Business | Strong | Yes | Every Listing belongs to one Trading Board. |
| AGG-007 | Daily Market Data | Instrument Listing | Lifecycle | Strong | No | Market Data exists only for a valid Listing. |
| AGG-008 | Daily Market Data | Trading Calendar | Reference | Strong | Yes | Trading data shall reference an official Trading Calendar. |
| AGG-009 | Corporate Action | Instrument | Business | Medium | Yes | Corporate Actions affect listed Instruments. |
| AGG-010 | External Identifier | Data Provider | Lifecycle | Strong | No | External identifiers belong to one Data Provider. |
| AGG-011 | External Identifier | Enterprise Entity | Reference | Strong | Yes | External identifiers map enterprise business entities. |
| AGG-012 | Audit Event | Aggregate Root | Reference | Medium | Yes | Audit records reference business Aggregates without modifying them. |
| AGG-013 | Report Snapshot | Enterprise Aggregate | Analytical | Weak | Yes | Reporting consumes enterprise information in read-only mode. |

---

# 5. Dependency Types

Aggregate dependencies are classified according to their business semantics rather than their technical implementation.

| Dependency Type | Description |
|-----------------|-------------|
| Structural | Defines permanent structural relationships required by the business model. |
| Business | Represents core business dependencies between Aggregates. |
| Lifecycle | Indicates that the lifecycle of one Aggregate depends upon another Aggregate. |
| Reference | Represents read-only business references without ownership transfer. |
| Classification | Represents dependencies on enterprise classification Aggregates. |
| Analytical | Represents read-only dependencies used for analytics, reporting, and decision support. |

---

# 6. Dependency Strength

Dependency strength indicates the business significance of the dependency.

| Strength | Description |
|----------|-------------|
| Strong | The source Aggregate cannot fulfill its business responsibility without the target Aggregate. |
| Medium | The dependency supports important business capabilities but does not determine the Aggregate lifecycle. |
| Weak | The dependency exists only for analytical, reporting, or informational purposes. |

---

# 7. Architectural Rules

The following architectural rules govern Aggregate dependencies throughout the Phoenix Platform.

- Aggregate dependencies shall always be explicit.
- Aggregate Roots are the only externally accessible entry points.
- Internal Aggregate entities shall never be referenced directly.
- Aggregate ownership shall never change through dependencies.
- Cross-Domain dependencies shall comply with the approved Domain Dependency Matrix.
- Circular Aggregate dependencies are prohibited.
- Dependencies shall preserve business consistency boundaries.
- Dependency direction shall follow business ownership rather than implementation convenience.
- Aggregate dependencies shall remain stable throughout the Enterprise Architecture baseline.

---

# 8. Validation Rules

The Aggregate Dependency Matrix shall satisfy the following validation rules.

| Rule ID | Validation Rule |
|---------|-----------------|
| ADM-001 | Every dependency shall identify a Source Aggregate. |
| ADM-002 | Every dependency shall identify a Target Aggregate. |
| ADM-003 | Every dependency shall specify its Dependency Type. |
| ADM-004 | Every dependency shall specify its Dependency Strength. |
| ADM-005 | Every Cross-Domain dependency shall be explicitly documented. |
| ADM-006 | Circular dependencies shall not exist. |
| ADM-007 | Aggregate ownership shall remain unchanged. |
| ADM-008 | Dependencies shall comply with the Canonical Domain Model. |
| ADM-009 | Dependencies shall preserve Aggregate consistency boundaries. |

---

# 9. Dependency Overview

## Reference Domain

- Exchange → Market
- Trading Board → Exchange
- Industry → Sector

---

## Core Domain

- Instrument → Company

---

## Market Domain

- Instrument Listing → Instrument
- Instrument Listing → Trading Board
- Daily Market Data → Instrument Listing
- Daily Market Data → Trading Calendar
- Corporate Action → Instrument

---

## Integration Domain

- External Identifier → Data Provider
- External Identifier → Enterprise Entity

---

## Audit Domain

- Audit Event → Aggregate Root

---

## Reporting Domain

- Report Snapshot → Enterprise Aggregates

---

# 10. Architectural Constraints

The following architectural constraints shall be enforced throughout the enterprise architecture.

- Every Aggregate shall belong to exactly one Business Domain.
- Every Aggregate shall expose exactly one Aggregate Root.
- Aggregate dependencies shall always be unidirectional.
- Circular Aggregate dependencies are prohibited.
- Internal Aggregate entities shall never be referenced directly by other Aggregates.
- Cross-Aggregate interactions shall occur exclusively through Aggregate Roots.
- Aggregate ownership shall never be transferred through dependencies.
- Dependency direction shall preserve Domain ownership.
- Aggregate dependencies shall remain independent of database implementation.
- Aggregate dependencies shall remain independent of service implementation.
- Business invariants shall remain enforceable within Aggregate boundaries.
- Aggregate dependency validation shall be completed before approval of the Canonical Enterprise ERD.

---

# 11. Traceability

This document shall remain synchronized with the following enterprise architecture artifacts.

| Artifact | Purpose |
|----------|---------|
| PlatformArchitectureVision | Enterprise architecture vision |
| CanonicalDomainModel | Domain ownership |
| AggregateCatalog | Aggregate ownership |
| AggregateDefinitions | Aggregate composition |
| EntityCatalog | Business entity ownership |
| AggregateAttributeMatrix | Aggregate attribute ownership |
| DomainDependencyMatrix | Domain dependency validation |
| ConceptualDataModel | Business information model |
| LogicalDataModel | Logical entity relationships |
| AggregateBoundaryValidation | Aggregate boundary verification |
| CanonicalEnterpriseERD | Enterprise logical data architecture |

---

# 12. Governance

The Aggregate Dependency Matrix is governed by the Enterprise Architecture Governance process.

Any modification affecting:

- Aggregate ownership;
- Aggregate boundaries;
- dependency direction;
- dependency type;
- dependency strength;
- Cross-Domain dependencies; or
- business consistency boundaries

shall undergo formal architectural review and, where applicable, be approved through an Architecture Decision Record (ADR) before implementation.

---

# 13. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Aggregate Dependency Matrix. |
| 2026.2 | 2026-07-19 | Refactored to align with the Canonical Domain Model, Aggregate Catalog, Aggregate Definitions, Entity Catalog, Domain Dependency Matrix, Aggregate Boundary Validation, and Canonical Enterprise ERD. Added architectural constraints, governance, traceability, updated dependency principles, validation rules, and enterprise dependency workflow. |