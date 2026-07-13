# Market Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-003 |
| Document | MarketDomainLogicalModel |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Architecture Team |
| Depends On | ReferenceDomainLogicalModel, CoreDomainLogicalModel, CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical logical representation of the Market Domain within the Phoenix Platform.

The Market Domain represents market activities associated with tradable financial instruments, including listing information, historical market data and corporate actions.

The model is technology independent and serves as the authoritative logical foundation for physical database design.

---

# 2. Scope

## Included Aggregates

- Instrument Listing
- Daily Market Data
- Corporate Action

## Excluded Aggregates

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar
- Company
- Instrument
- Data Provider
- External Identifier

---

# 3. Architectural Role

The Market Domain captures business events and historical market information.

Unlike the Reference and Core Domains, Market entities are highly dynamic and continuously grow as new market events occur.

Historical information within this domain is immutable once published unless corrected through an approved governance process.

---

# 4. Aggregate Summary

| Aggregate | Responsibility | Business Identifier |
|------------|---------------|---------------------|
| Instrument Listing | Defines where and how an Instrument is listed | Listing Code |
| Daily Market Data | Records official daily trading information | Instrument + Trading Date |
| Corporate Action | Records official corporate events affecting Instruments | Corporate Action Reference |

---

# 5. Aggregate Specifications

## 5.1 Instrument Listing

### Business Purpose

Represents the official listing of a financial instrument on a Trading Board.

### Business Responsibilities

- Associate an Instrument with a Trading Board.
- Maintain listing lifecycle.
- Support listing history.
- Provide trading eligibility information.

### Business Identifier

Listing Code

### Logical Characteristics

- Aggregate Root
- Lifecycle managed
- Historical entity
- Shared across operational and analytical services

### Business Rules

- Every Listing belongs to exactly one Instrument.
- Every Listing belongs to exactly one Trading Board.
- An Instrument may have multiple Listings during its lifecycle.
- Only active Listings are eligible for trading.

---

## 5.2 Daily Market Data

### Business Purpose

Represents the official daily trading results for an Instrument Listing.

### Business Responsibilities

- Record daily market activity.
- Preserve historical trading information.
- Support technical analysis.
- Support quantitative research.
- Support backtesting.

### Business Identifier

Instrument Listing + Trading Date

### Logical Characteristics

- Aggregate Root
- Immutable historical entity
- Time-series data

### Business Rules

- One record shall exist for each Instrument Listing and Trading Date.
- Historical market data shall be immutable after publication.
- Every record shall reference a valid Trading Calendar entry.
- Every record shall reference an active Instrument Listing.

---

## 5.3 Corporate Action

### Business Purpose

Represents official corporate events affecting an Instrument or its issuing Company.

### Business Responsibilities

- Record dividends.
- Record capital increases.
- Record stock splits.
- Record symbol changes.
- Preserve historical adjustments.

### Business Identifier

Corporate Action Reference

### Logical Characteristics

- Aggregate Root
- Historical event
- Business event entity

### Business Rules

- Every Corporate Action belongs to one Instrument.
- Every Corporate Action has one effective Trading Date.
- Historical Corporate Actions shall never be deleted.
- Market adjustments shall remain fully traceable.

---

# 6. Cross-Aggregate Relationships

| Parent Aggregate | Child Aggregate | Cardinality |
|------------------|-----------------|-------------|
| Instrument | Instrument Listing | 1 : N |
| Trading Board | Instrument Listing | 1 : N |
| Instrument Listing | Daily Market Data | 1 : N |
| Trading Calendar | Daily Market Data | 1 : N |
| Instrument | Corporate Action | 1 : N |

---

# 7. Domain Constraints

The following logical constraints govern the Market Domain:

- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall reference exactly one Trading Board.
- Every Daily Market Data record shall reference one Instrument Listing.
- Every Daily Market Data record shall reference one Trading Day.
- Every Corporate Action shall reference one Instrument.
- Historical market information shall remain immutable after publication.

---

# 8. Domain Invariants

The following invariants shall always hold:

- Every Aggregate has exactly one Aggregate Root.
- Historical records are immutable.
- Business identifiers remain stable.
- Aggregate references target Aggregate Roots only.
- Market events preserve chronological integrity.
- Business semantics remain technology independent.

---

# 9. Traceability

| Source Artifact | Traceability |
|-----------------|--------------|
| CoreDomainLogicalModel | Instrument references |
| ReferenceDomainLogicalModel | Trading Board and Trading Calendar references |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Logical attribute assignment |
| AttributeCatalog | Approved enterprise attributes |
| CanonicalBusinessRules | Business constraints |
| EnterpriseAttributeStandard | Attribute compliance |

---

# 10. Transition to Physical Design

This document provides the logical foundation for:

- Market Schema Design
- Listing Tables
- Daily Market Data Tables
- Corporate Action Tables
- Foreign Keys
- Constraints
- Historical Data Strategy
- Partitioning Strategy

Implementation-specific decisions are intentionally excluded.

---

# 11. Related Artifacts

- ReferenceDomainLogicalModel
- CoreDomainLogicalModel
- IntegrationDomainLogicalModel
- ConceptualModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- AttributeDictionary
- CanonicalBusinessRules

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial canonical Market Domain Logical Model |