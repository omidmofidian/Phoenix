# Core Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-002 |
| Document | CoreDomainLogicalModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Logical Data Architecture |
| Architecture Phase | Enterprise Data Modeling |
| Owner | Enterprise Architecture |
| Depends On | ConceptualDatabaseModel, CanonicalDomainModel, ReferenceDomainLogicalModel, AggregateCatalog, CanonicalEntityDefinitions, CanonicalBusinessRules |
| Consumed By | MarketDomainLogicalModel, IntegrationDomainLogicalModel, AuditDomainLogicalModel, CanonicalEnterpriseERD, LogicalDatabaseModel, PhysicalDatabaseModel |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical logical representation of the **Core Domain** within the Phoenix Platform Enterprise Architecture.

The Core Domain contains the enterprise master business entities that represent legal organizations and tradable financial instruments. These entities provide the business identity upon which operational, analytical, reporting and integration capabilities are built.

This document establishes the authoritative logical structure, aggregate boundaries, business responsibilities and cross-domain relationships of the Core Domain while remaining completely independent of implementation technologies.

The Core Domain Logical Model serves as the authoritative logical specification for all subsequent Enterprise Data Architecture artifacts, including the Canonical Enterprise ERD, Logical Database Model, Physical Database Model and Enterprise Data Dictionary.

---

# 2. Scope

## Included Aggregates

- Company
- Instrument

## Referenced Aggregates

### Reference Domain

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar

### Market Domain

- Instrument Listing
- Daily Market Data
- Corporate Action

### Integration Domain

- Data Provider
- External Identifier

---

## Excluded from this Model

The following artifacts are outside the scope of the Core Domain Logical Model:

- Physical database objects
- Database schemas
- Tables
- Columns
- Primary Keys
- Foreign Keys
- Indexes
- Database constraints
- Views
- Stored procedures
- Triggers
- Service implementations
- API specifications
- Infrastructure components
- Technology-specific implementation details

---

# 3. Architectural Role

The Core Domain represents the enterprise master business information that defines organizations and tradable financial instruments.

Unlike the Reference Domain, whose information changes infrequently, Core Domain entities evolve throughout their business lifecycle while preserving stable enterprise identity.

The Core Domain provides the authoritative business foundation for the Market, Integration, Audit, Reporting and Configuration Domains and serves as the primary source of enterprise business identity across the Phoenix Platform.

Business ownership, aggregate boundaries and logical relationships defined within this document are governed by the Enterprise Architecture baseline and remain independent of implementation technologies.

---

# 4. Aggregate Catalog

The Core Domain consists of the following canonical Aggregates.

| Aggregate | Description | Aggregate Root | Primary Responsibility |
|------------|-------------|----------------|-------------------------|
| Company | Represents a legal business organization participating in financial markets. | Company | Enterprise company identity management |
| Instrument | Represents a tradable financial instrument issued by a Company. | Instrument | Enterprise financial instrument management |

---

# 5. Aggregate Specifications

## 5.1 Company

### Business Purpose

Represents a legally recognized business organization that issues one or more tradable financial instruments within the enterprise.

### Business Responsibilities

- Maintain enterprise company identity.
- Maintain legal organization information.
- Maintain enterprise business classification.
- Support ownership of financial instruments.
- Provide a stable business identity across enterprise services.

### Business Identifier

**Company Code**

### Logical Characteristics

- Enterprise Business Aggregate
- Aggregate Root
- Shared Enterprise Resource
- Stable Business Identity
- Technology Independent

### Business Rules

- Every Company shall have a unique Company Code.
- Every Company shall belong to exactly one Industry.
- Sector classification shall be derived from the associated Industry.
- A Company may issue one or more Instruments.
- Company identity shall remain stable throughout its lifecycle.
- A Company shall not be removed while referenced by enterprise business information.

---

## 5.2 Instrument

### Business Purpose

Represents a tradable financial instrument issued by a Company and recognized throughout the enterprise.

### Business Responsibilities

- Maintain enterprise instrument identity.
- Represent the primary tradable asset.
- Support enterprise market operations.
- Support analytical and reporting activities.
- Preserve stable business identity throughout the instrument lifecycle.

### Business Identifier

**Instrument Code**

### Logical Characteristics

- Enterprise Business Aggregate
- Aggregate Root
- Shared Enterprise Resource
- Managed Lifecycle
- Technology Independent

### Business Rules

- Every Instrument shall have a unique Instrument Code.
- Every Instrument shall belong to exactly one Company.
- Instrument Listings shall reference the Instrument.
- Corporate Actions shall reference the Instrument.
- Instrument identity shall remain immutable throughout its lifecycle.
- An Instrument shall not exist independently of a Company.

---

# 6. Cross-Domain Relationships

The Core Domain collaborates with multiple enterprise domains while maintaining clear ownership boundaries.

| Referencing Domain | Purpose |
|--------------------|---------|
| Reference Domain | Business classification and reference information |
| Market Domain | Market listing and historical trading information |
| Integration Domain | External identifier mapping |
| Audit Domain | Business traceability |
| Reporting Domain | Enterprise reporting and analytics |
| Configuration Domain | Business configuration support |

The Core Domain owns enterprise business identity but never assumes ownership of entities belonging to other domains.

---

# 7. Domain Constraints

The following logical constraints govern the Core Domain.

- Every Company shall belong to exactly one Industry.
- Sector classification shall be derived through Industry.
- Every Instrument shall belong to exactly one Company.
- Enterprise business identifiers shall remain stable.
- Aggregate ownership shall remain unique.
- Cross-domain references shall target Aggregate Roots only.
- Business semantics shall remain technology independent.

---

# 8. Domain Invariants

The following invariants shall always hold throughout the Core Domain.

- Company identity remains stable throughout its lifecycle.
- Instrument identity remains stable throughout its lifecycle.
- Every Aggregate has exactly one Aggregate Root.
- Every Aggregate has exactly one Business Identifier.
- Aggregate ownership remains unique.
- Business ownership shall never cross Domain boundaries.
- Enterprise business semantics remain independent of implementation technologies.

---

# 9. Traceability

The Core Domain Logical Model maintains complete traceability to the authoritative Enterprise Architecture artifacts.

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| ConceptualDatabaseModel | Enterprise conceptual foundation |
| CanonicalDomainModel | Domain ownership |
| AggregateCatalog | Aggregate ownership and responsibilities |
| CanonicalEntityDefinitions | Canonical entity definitions |
| CanonicalBusinessRules | Enterprise business semantics |
| EnterpriseRelationshipCatalog | Business relationship definitions |
| EnterpriseRelationshipMatrix | Relationship validation |
| CardinalityMatrix | Relationship cardinalities |
| AggregateDependencyMatrix | Aggregate dependencies |
| BusinessConstraintMatrix | Enterprise business constraints |
| CanonicalEnterpriseERD | Enterprise logical relationships |

---

# 10. Transition to Physical Design

The Core Domain Logical Model establishes the logical foundation for the physical realization of enterprise business entities within the Phoenix Platform.

The logical definitions contained in this document are transformed into implementation artifacts during subsequent architecture and development phases while preserving business semantics and domain ownership.

This document provides the architectural basis for:

- Physical Database Model
- Company physical schema
- Instrument physical schema
- Enterprise key strategy
- Referential integrity rules
- Indexing strategy
- Data migration planning
- Service data ownership

Implementation technologies, database-specific features, storage optimization techniques and application-level concerns are intentionally excluded from this document.

---

# 11. Related Artifacts

This document shall be used together with the following Enterprise Architecture artifacts.

## Enterprise Architecture

- PlatformArchitectureVision
- ArchitecturalPrinciples
- BoundedContextDefinition

## Business Architecture

- BusinessGlossary
- CanonicalBusinessConcepts
- CanonicalBusinessRules

## Data Architecture

- ConceptualDatabaseModel
- CanonicalDomainModel
- CanonicalEntityDefinitions
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- AttributeDictionary
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CardinalityMatrix
- AggregateDependencyMatrix
- BusinessConstraintMatrix
- CanonicalEnterpriseERD
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseDataDictionary

## Domain Models

- ReferenceDomainLogicalModel
- MarketDomainLogicalModel
- IntegrationDomainLogicalModel
- ConfigurationDomainLogicalModel
- AuditDomainLogicalModel
- ReportingDomainLogicalModel

---

# 12. Architectural Governance

The Core Domain Logical Model is a controlled Enterprise Architecture artifact and forms part of the approved Enterprise Data Architecture baseline.

Any modification affecting:

- Company semantics
- Instrument semantics
- Aggregate ownership
- Domain boundaries
- Cross-domain relationships
- Business identifiers
- Enterprise business rules

shall require:

- Enterprise Architecture Review
- Business Impact Analysis
- Architecture Board Approval
- Repository Baseline Update

---

# 13. Approval

The Enterprise Architecture Board approves this Core Domain Logical Model as the official logical representation of the Core Domain for the Phoenix Platform.

**Approval Status**

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Core Domain Logical Model. |
| 2026.2 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline, including standardized metadata, governance, traceability, logical aggregate definitions, architectural constraints, and transition guidance. |