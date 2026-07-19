# Business Constraint Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-005 |
| Document | BusinessConstraintMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Logical Data Architecture |
| Owner | Enterprise Architecture Team |
| Repository Path | Architecture/Data/LogicalArchitecture/Matrices/BusinessConstraintMatrix.md |
| Depends On | CanonicalBusinessRules, AggregateDependencyMatrix, DomainDependencyMatrix, EnterpriseRelationshipMatrix, CardinalityMatrix |
| Consumed By | LogicalDatabaseModel, PhysicalDatabaseModel, CheckConstraintCatalog, ForeignKeyCatalog, ValidationRules, Service Specifications |
| ADR References | ADR-002, ADR-003, ADR-004, ADR-015, ADR-026 |
| Last Updated | 2026-07-19 |
| Review Status | Canonical |

---

# 1. Purpose

The **Business Constraint Matrix** defines the canonical set of business constraints governing the logical enterprise data model of the Phoenix Platform.

Business constraints capture the semantic rules that preserve enterprise integrity independently of any implementation technology. They describe **what must always be true** from a business perspective, rather than **how those rules are implemented** in a database, application, or service.

This document serves as the authoritative source for validating entity behavior, aggregate consistency, relationship integrity, lifecycle rules, and domain interactions across the platform.

It provides the logical foundation from which implementation-specific validation mechanisms—including relational constraints, application validation, domain services, and business rule engines—are derived.

---

# 2. Objectives

The objectives of this document are to:

- Define the canonical business constraints governing enterprise data.
- Preserve semantic consistency across all business domains.
- Establish implementation-independent validation rules.
- Identify mandatory business invariants.
- Define ownership-related constraints across Aggregates and Domains.
- Support logical validation prior to physical database design.
- Provide traceability between business rules and implementation artifacts.
- Enable consistent constraint enforcement across services.
- Prevent contradictory interpretations of enterprise business rules.
- Support future evolution while preserving architectural integrity.

---

# 3. Scope

This document defines:

- Entity-level business constraints.
- Aggregate-level consistency constraints.
- Domain interaction constraints.
- Relationship integrity rules.
- Identity and uniqueness rules.
- Lifecycle constraints.
- Business ownership restrictions.
- Constraint severity classifications.
- Traceability to architectural artifacts.

This document does **not** define:

- Primary Keys
- Foreign Keys
- SQL CHECK constraints
- Database triggers
- Stored procedures
- Service implementation
- Programming language validation
- Physical database optimization

Those implementation artifacts are defined within the Physical Data Architecture and Implementation layers.

---

# 4. Architectural Principles

The Business Constraint Matrix follows the following architectural principles.

## BCM-001 — Business First

Business constraints originate from business semantics rather than technical implementation.

---

## BCM-002 — Technology Independence

Logical business constraints shall remain independent of databases, programming languages, frameworks, and infrastructure technologies.

---

## BCM-003 — Single Source of Truth

Every business constraint shall have a single authoritative definition.

---

## BCM-004 — Traceability

Each business constraint shall be traceable to one or more architectural artifacts including Business Rules, Aggregate Definitions, Relationship Models, and Domain Models.

---

## BCM-005 — Consistency Preservation

Business constraints shall preserve consistency within Aggregate boundaries and across Domain interactions.

---

## BCM-006 — Evolution Control

Business constraints may evolve only through approved architectural governance and shall remain backward compatible whenever possible.

---

# 5. Constraint Categories

Business constraints are classified according to their architectural scope and business responsibility.

| Category | Description |
|----------|-------------|
| Entity Constraint | Governs the integrity and behavior of an individual business entity. |
| Relationship Constraint | Governs semantic relationships between business entities. |
| Aggregate Constraint | Preserves consistency within Aggregate boundaries. |
| Domain Constraint | Governs interactions between Business Domains. |
| Identity Constraint | Defines uniqueness and identity semantics. |
| Lifecycle Constraint | Controls business lifecycle transitions. |
| Ownership Constraint | Defines ownership boundaries across Domains and Aggregates. |
| Governance Constraint | Defines enterprise-wide architectural policies. |

---

# 6. Business Constraint Matrix

| ID | Category | Scope | Business Constraint | Severity | Source Artifact |
|----|----------|-------|---------------------|----------|-----------------|
| BCM-001 | Entity | Exchange | Exchange Code shall be unique within the enterprise. | Critical | CanonicalBusinessRules |
| BCM-002 | Entity | Trading Board | Every Trading Board shall belong to exactly one Exchange. | Critical | CardinalityMatrix |
| BCM-003 | Entity | Sector | Sector Code shall be unique. | Critical | CanonicalBusinessRules |
| BCM-004 | Entity | Industry | Every Industry shall belong to exactly one Sector. | Critical | EnterpriseRelationshipMatrix |
| BCM-005 | Entity | Company | Company Business Identifier shall remain unique throughout its lifecycle. | Critical | CanonicalBusinessRules |
| BCM-006 | Entity | Instrument | Every Instrument shall belong to exactly one Company. | Critical | AggregateDependencyMatrix |
| BCM-007 | Entity | Instrument Listing | Every Listing shall reference one Instrument and one Trading Board. | Critical | AggregateDependencyMatrix |
| BCM-008 | Entity | Daily Market Data | Market Data shall not exist without a valid Instrument Listing. | Critical | AggregateDependencyMatrix |
| BCM-009 | Entity | Trading Calendar | Trading Date shall be unique within a Market. | High | CanonicalBusinessRules |
| BCM-010 | Entity | Corporate Action | Every Corporate Action shall reference one Instrument. | High | AggregateDependencyMatrix |
| BCM-011 | Identity | External Identifier | External Identifier shall be unique for each Provider and Entity. | Critical | EnterpriseIdentityStandard |
| BCM-012 | Identity | Enterprise Entity | Public Identifier shall remain immutable throughout the entity lifecycle. | Critical | EnterpriseIdentityStandard |
| BCM-013 | Aggregate | Aggregate Root | External references shall target Aggregate Roots only. | Critical | AggregateCatalog |
| BCM-014 | Aggregate | Aggregate Boundary | Internal Aggregate entities shall never be referenced directly. | Critical | AggregateBoundaryValidation |
| BCM-015 | Domain | Reference Domain | Reference Domain shall remain independent of operational Domains. | Critical | DomainDependencyMatrix |
| BCM-016 | Domain | Reporting Domain | Reporting Domain shall remain read-only. | Critical | DomainDependencyMatrix |
| BCM-017 | Domain | Audit Domain | Audit Domain shall never modify business entities. | Critical | CanonicalBusinessRules |
| BCM-018 | Lifecycle | Configuration Item | Configuration Items shall belong to exactly one Configuration Group. | High | AggregateDependencyMatrix |
| BCM-019 | Lifecycle | Audit Event | Every Audit Event shall belong to one Audit Session. | Critical | AggregateDependencyMatrix |
| BCM-020 | Lifecycle | Report Snapshot | Every Report Snapshot shall belong to one Report Definition. | High | AggregateDependencyMatrix |
| BCM-021 | Relationship | Enterprise | Circular ownership relationships are prohibited. | Critical | EnterpriseRelationshipMatrix |
| BCM-022 | Relationship | Cross Domain | Cross-Domain relationships shall comply with the Domain Dependency Matrix. | Critical | DomainDependencyMatrix |
| BCM-023 | Governance | Enterprise | Aggregate ownership shall remain unchanged unless approved through Architecture Governance. | Critical | AggregateCatalog |
| BCM-024 | Governance | Enterprise | Every business constraint shall be traceable to an approved architectural artifact. | High | Architecture Governance |

---

# 7. Severity Levels

| Severity | Description |
|----------|-------------|
| Critical | Violation compromises enterprise integrity, ownership, or business consistency. |
| High | Violation significantly impacts business correctness or data quality. |
| Medium | Violation affects business behavior but does not compromise structural integrity. |
| Low | Recommendation intended to improve governance and maintainability. |

---

# 8. Validation Principles

The following principles govern business constraint validation.

- Every business constraint shall be traceable.
- Every business constraint shall originate from business semantics.
- Business constraints shall remain implementation independent.
- Constraints shall preserve Aggregate consistency boundaries.
- Constraints shall preserve Domain ownership.
- Constraints shall be validated before physical implementation.
- No business constraint shall contradict the Canonical Business Rules.
- Every constraint shall have a clearly identified architectural owner.

---

# 9. Traceability

The Business Constraint Matrix shall remain synchronized with the following enterprise architecture artifacts.

| Artifact | Purpose |
|----------|---------|
| PlatformArchitectureVision | Enterprise architecture vision |
| ArchitecturalPrinciples | Enterprise design principles |
| CanonicalBusinessRules | Source of enterprise business semantics |
| CanonicalDomainModel | Domain ownership and business boundaries |
| BoundedContextDefinition | Context ownership and responsibilities |
| AggregateCatalog | Aggregate ownership and consistency boundaries |
| AggregateDefinitions | Aggregate composition and lifecycle |
| AggregateDependencyMatrix | Aggregate dependency validation |
| AggregateBoundaryValidation | Aggregate boundary verification |
| DomainDependencyMatrix | Cross-domain dependency validation |
| EnterpriseRelationshipMatrix | Enterprise relationship semantics |
| CardinalityMatrix | Participation and multiplicity validation |
| EntityCatalog | Business entity ownership |
| LogicalDataModel | Logical data structure |
| CanonicalEnterpriseERD | Enterprise logical data architecture |

---

# 10. Transition to Physical Design

The logical business constraints defined in this document provide the authoritative foundation for implementation-specific validation mechanisms.

During the Physical Data Architecture and Application Design phases, these logical constraints may be realized through:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Domain Constraints
- Exclusion Constraints
- Database Views
- Application Validation
- Domain Services
- Business Rule Engines
- API Validation
- Event Validation

The logical definition contained in this document shall always remain the authoritative source of business integrity.

---

# 11. Architectural Constraints

The following architectural constraints shall always be enforced.

- Business constraints shall remain technology independent.
- Business semantics shall never be derived from implementation details.
- Aggregate consistency shall always be preserved.
- Domain ownership shall remain unchanged.
- Cross-Domain interactions shall comply with the approved Domain Dependency Matrix.
- Circular ownership relationships are prohibited.
- Identity constraints shall remain stable throughout the entity lifecycle.
- Business constraints shall not contradict approved Canonical Business Rules.
- All logical constraints shall be validated before physical implementation.
- Every enterprise business constraint shall have an identified architectural owner.

---

# 12. Governance

The Business Constraint Matrix is governed by the Phoenix Enterprise Architecture Governance process.

Changes affecting:

- business semantics;
- entity constraints;
- aggregate constraints;
- relationship constraints;
- domain constraints;
- identity rules;
- lifecycle rules;
- ownership rules; or
- enterprise validation policies

shall undergo formal architectural review and, where applicable, be approved through an Architecture Decision Record (ADR) before implementation.

---

# 13. Related Artifacts

This document shall be maintained together with the following enterprise architecture artifacts.

- PlatformArchitectureVision
- ArchitecturalPrinciples
- CanonicalBusinessRules
- CanonicalDomainModel
- BoundedContextDefinition
- AggregateCatalog
- AggregateDefinitions
- AggregateDependencyMatrix
- AggregateBoundaryValidation
- DomainDependencyMatrix
- EnterpriseRelationshipMatrix
- CardinalityMatrix
- EntityCatalog
- LogicalDataModel
- CanonicalEnterpriseERD
- PhysicalDataModel
- ConstraintCatalog

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Business Constraint Matrix. |
| 2026.2 | 2026-07-19 | Refactored to align with the Canonical Domain Model, Aggregate Catalog, Aggregate Definitions, Aggregate Dependency Matrix, Aggregate Boundary Validation, Domain Dependency Matrix, Entity Catalog, Logical Data Model, and Canonical Enterprise ERD. Added Governance, Architectural Constraints, enhanced Traceability, standardized constraint categories, and aligned the document with the Phoenix Enterprise Architecture baseline. |