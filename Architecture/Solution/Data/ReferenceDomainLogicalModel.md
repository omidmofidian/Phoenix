# Reference Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-001 |
| Document | ReferenceDomainLogicalModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Architecture Team |
| Depends On | CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical logical representation of the Reference Domain within the Phoenix Platform.

The Reference Domain provides stable enterprise reference data shared across all business domains.

It establishes the logical structure, aggregate responsibilities, business identifiers, relationships and business constraints independently of any database technology or implementation.

---

# 2. Scope

## Included Aggregates

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar

## Excluded Aggregates

- Company
- Instrument
- Instrument Listing
- Daily Market Data
- Corporate Action
- External Identifier
- Data Provider

---

# 3. Architectural Role

The Reference Domain acts as the enterprise foundation for classification and reference information.

Reference Aggregates provide reusable master data for all downstream business domains.

Reference data is expected to change infrequently and shall be governed through controlled business processes.

---

# 4. Aggregate Summary

| Aggregate | Responsibility | Business Identifier |
|------------|---------------|---------------------|
| Exchange | Securities exchange | Exchange Code |
| Trading Board | Trading board within an Exchange | Board Code |
| Sector | Business sector classification | Sector Code |
| Industry | Business industry classification | Industry Code |
| Trading Calendar | Official trading calendar | Trading Date |

---

# 5. Aggregate Specifications

## 5.1 Exchange

### Business Purpose

Represents a regulated securities exchange responsible for operating one or more trading boards.

### Business Responsibilities

- Maintain exchange identity.
- Maintain exchange business information.
- Own Trading Boards.
- Provide enterprise reference information.

### Business Identifier

Exchange Code

### Logical Characteristics

- Stable reference entity
- Aggregate Root
- Enterprise owned
- Shared across domains

### Business Rules

- Exchange Code shall be unique.
- Exchange shall remain uniquely identifiable during its lifecycle.
- Exchange may own one or more Trading Boards.
- Exchange cannot be removed while referenced by other Aggregates.

---

## 5.2 Trading Board

### Business Purpose

Represents an operational trading board belonging to a single Exchange.

### Business Responsibilities

- Classify listed instruments.
- Define trading environment.
- Support market segmentation.

### Business Identifier

Board Code

### Logical Characteristics

- Aggregate Root
- Child of Exchange
- Shared reference entity

### Business Rules

- Every Trading Board belongs to exactly one Exchange.
- Board Code shall be unique within an Exchange.
- Trading Board cannot exist without its parent Exchange.

---

## 5.3 Sector

### Business Purpose

Represents the highest level of enterprise business classification.

### Business Responsibilities

- Organize industries.
- Support enterprise reporting.
- Support market classification.

### Business Identifier

Sector Code

### Logical Characteristics

- Aggregate Root
- Enterprise classification entity

### Business Rules

- Sector Code shall be unique.
- Sector may contain multiple Industries.
- Sector cannot depend on transactional entities.

---

## 5.4 Industry

### Business Purpose

Represents a detailed business classification within a Sector.

### Business Responsibilities

- Organize companies.
- Support financial classification.
- Enable analytical grouping.

### Business Identifier

Industry Code

### Logical Characteristics

- Aggregate Root
- Child of Sector

### Business Rules

- Every Industry belongs to exactly one Sector.
- Industry Code shall be unique within a Sector.
- Industry cannot exist without a parent Sector.

---

## 5.5 Trading Calendar

### Business Purpose

Defines the official trading schedule used throughout the platform.

### Business Responsibilities

- Identify trading days.
- Identify holidays.
- Support historical market processing.
- Support business time management.

### Business Identifier

Trading Date

### Logical Characteristics

- Enterprise calendar
- Shared reference entity

### Business Rules

- One calendar entry shall exist for each trading day.
- A calendar day cannot simultaneously be a trading day and a market holiday.
- Historical calendar entries shall not be modified without governance approval.

---

# 6. Cross-Aggregate Relationships

| Parent Aggregate | Child Aggregate | Cardinality |
|------------------|-----------------|-------------|
| Exchange | Trading Board | 1 : N |
| Sector | Industry | 1 : N |

The remaining business domains reference these Aggregates but do not own them.

---

# 7. Domain Constraints

The following logical constraints govern the Reference Domain:

- Every Trading Board shall reference one Exchange.
- Every Industry shall reference one Sector.
- Business identifiers shall remain stable.
- Reference entities shall not depend on transactional entities.
- Aggregate boundaries shall remain independent.

---

# 8. Domain Invariants

The following invariants shall always hold:

- Every Aggregate has exactly one Aggregate Root.
- Every Aggregate has exactly one Business Identifier.
- Aggregate ownership shall never be ambiguous.
- Aggregate references shall target Aggregate Roots only.
- Reference data shall remain enterprise consistent.
- Business semantics shall remain technology independent.

---

# 9. Traceability

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Aggregate definitions |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Logical attribute assignment |
| AttributeCatalog | Approved enterprise attributes |
| CanonicalBusinessRules | Business constraints |
| EnterpriseAttributeStandard | Attribute compliance |

---

# 10. Transition to Physical Design

This document provides the authoritative logical foundation for:

- Physical Database Model
- PostgreSQL Schema Design
- Table Design
- Foreign Key Design
- Constraint Design
- Migration Planning

No implementation-specific decisions are defined in this document.

---

# 11. Related Artifacts

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
| 2026.1 | 2026-07-09 | Initial logical model |
| 2026.2 | 2026-07-09 | Canonical redesign aligned with Sprint 3 Information Architecture |