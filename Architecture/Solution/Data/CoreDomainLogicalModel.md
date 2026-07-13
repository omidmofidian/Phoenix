# Core Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-002 |
| Document | CoreDomainLogicalModel |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Architecture Team |
| Depends On | ReferenceDomainLogicalModel, CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical logical representation of the Core Domain within the Phoenix Platform.

The Core Domain contains the enterprise business entities that represent companies and tradable financial instruments. These entities form the foundation of all market, analytics, portfolio and strategy domains.

The model is technology independent and serves as the authoritative source for subsequent physical database design.

---

# 2. Scope

## Included Aggregates

- Company
- Instrument

## Excluded Aggregates

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar
- Instrument Listing
- Daily Market Data
- Corporate Action
- Data Provider
- External Identifier

---

# 3. Architectural Role

The Core Domain defines the enterprise representation of organizations and financial instruments.

Unlike the Reference Domain, Core entities evolve over time while preserving stable business identity.

Core entities are referenced by nearly every operational and analytical domain.

---

# 4. Aggregate Summary

| Aggregate | Responsibility | Business Identifier |
|------------|---------------|---------------------|
| Company | Legal business organization | Company Code |
| Instrument | Tradable financial instrument | Instrument Code |

---

# 5. Aggregate Specifications

## 5.1 Company

### Business Purpose

Represents a legal organization participating in one or more financial markets.

### Business Responsibilities

- Maintain enterprise company identity.
- Maintain legal and business information.
- Classify the company within the enterprise taxonomy.
- Own one or more financial instruments.

### Business Identifier

Company Code

### Logical Characteristics

- Aggregate Root
- Enterprise business entity
- Shared across domains
- Lifecycle managed

### Business Rules

- Company Code shall be unique.
- Every Company belongs to one Industry.
- Every Company belongs to one Sector through its Industry.
- A Company may own one or more Instruments.
- A Company cannot be removed while Instruments reference it.
- Company identity shall remain stable throughout its lifecycle.

---

## 5.2 Instrument

### Business Purpose

Represents a tradable financial instrument issued by a Company.

### Business Responsibilities

- Maintain instrument identity.
- Maintain trading characteristics.
- Represent the primary tradable asset.
- Support historical and analytical processing.

### Business Identifier

Instrument Code

### Logical Characteristics

- Aggregate Root
- Enterprise business entity
- Lifecycle managed
- Shared across operational and analytical services

### Business Rules

- Instrument Code shall be unique.
- Every Instrument belongs to exactly one Company.
- An Instrument may have multiple Listings during its lifecycle.
- Instrument identity shall never change.
- Historical business identity shall remain immutable.
- Instrument cannot exist without a Company.

---

# 6. Cross-Aggregate Relationships

| Parent Aggregate | Child Aggregate | Cardinality |
|------------------|-----------------|-------------|
| Company | Instrument | 1 : N |

Reference relationships inherited from the Reference Domain:

| Reference Aggregate | Core Aggregate |
|----------------------|----------------|
| Sector | Company |
| Industry | Company |

---

# 7. Domain Constraints

The following logical constraints govern the Core Domain:

- Every Company shall belong to exactly one Industry.
- Industry membership determines the associated Sector.
- Every Instrument shall belong to exactly one Company.
- Business identifiers shall remain stable.
- Core entities may reference Reference entities but shall never own them.

---

# 8. Domain Invariants

The following invariants shall always hold:

- Every Aggregate has exactly one Aggregate Root.
- Every Aggregate has exactly one Business Identifier.
- Company identity is independent of market listings.
- Instrument identity is independent of trading history.
- Aggregate references shall target Aggregate Roots only.
- Core business semantics shall remain technology independent.

---

# 9. Traceability

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Aggregate definitions |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Logical attribute assignment |
| AttributeCatalog | Approved enterprise attributes |
| CanonicalBusinessRules | Business constraints |
| ReferenceDomainLogicalModel | Cross-domain references |
| EnterpriseAttributeStandard | Attribute compliance |

---

# 10. Transition to Physical Design

This document provides the logical foundation for:

- Core Schema Design
- Company Tables
- Instrument Tables
- Foreign Key Design
- Constraint Design
- Migration Planning

Implementation-specific decisions are intentionally excluded.

---

# 11. Related Artifacts

- ReferenceDomainLogicalModel
- MarketDomainLogicalModel
- ConceptualModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- CanonicalDomainModel
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- AttributeDictionary
- CanonicalBusinessRules

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial canonical Core Domain Logical Model |