# Market Domain Logical Model

| Property | Value |
|----------|-------|
| **Project** | Phoenix Platform |
| **Artifact ID** | LDM-003 |
| **Document** | MarketDomainLogicalModel |
| **Version** | 2026.2 |
| **Status** | Approved |
| **Classification** | Enterprise Logical Data Model |
| **Owner** | Enterprise Architecture |
| **Architecture Layer** | Business Data Architecture |
| **Domain** | Market Domain |
| **Depends On** | PlatformArchitectureVision, ArchitecturalPrinciples, CanonicalDomainModel, ReferenceDomainLogicalModel, CoreDomainLogicalModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| **Referenced By** | LogicalDatabaseModel, PhysicalDatabaseModel, CanonicalEnterpriseERD |
| **Last Updated** | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical logical representation of the **Market Domain** within the Phoenix Platform Enterprise Architecture.

The Market Domain models the operational activities associated with tradable financial instruments after they have been defined by the Reference and Core Domains. It provides the enterprise representation of market listings, historical trading information and corporate actions while preserving business ownership, Aggregate boundaries and domain independence.

This document serves as the authoritative logical specification for the Market Domain and provides the foundation for Logical Database Modeling, Physical Database Design, Enterprise Reporting and future analytical services.

The model is intentionally technology independent and focuses exclusively on business semantics.

---

# 2. Scope

This document defines the logical structure of all Aggregates that belong to the Market Domain.

## Included Business Objects

- Instrument Listing
- Daily Market Data
- Corporate Action

## Referenced Business Objects

The following business objects are referenced but are owned by other enterprise domains.

- Exchange
- Trading Board
- Trading Calendar
- Company
- Instrument

## Excluded Business Objects

The following Aggregates are outside the scope of this document.

- Exchange
- Trading Board
- Sector
- Industry
- Company
- Instrument
- Data Provider
- External Identifier
- Audit Session
- Audit Event
- Configuration Group
- Configuration Item
- Report Definition
- Report Snapshot

---

# 3. Objectives

The Market Domain Logical Model has the following objectives:

- establish the canonical logical representation of operational market data;
- define the ownership and responsibilities of Market Domain Aggregates;
- preserve the separation between reference data and operational market data;
- support historical market information without compromising data integrity;
- provide a stable foundation for analytical processing and backtesting;
- ensure complete traceability to the Enterprise Architecture baseline;
- remain independent of implementation technologies and database platforms.

---

# 4. Architectural Role

The Market Domain represents the operational layer of the Phoenix Platform Enterprise Data Architecture.

Its primary responsibility is to capture, organize and preserve market activities associated with tradable financial instruments.

Unlike the Reference Domain, whose business objects are relatively stable, the Market Domain manages continuously growing historical information that records the evolution of market activity over time.

The Market Domain does not define enterprise identities. Instead, it consumes canonical business objects from the Reference and Core Domains while maintaining its own operational business objects and historical events.

Historical market information shall remain immutable after publication except through formally governed correction procedures.

---

# 5. Architectural Principles

The Market Domain is governed by the following architectural principles.

- Operational market data shall remain independent of reference data.
- Every Aggregate shall have exactly one Aggregate Root.
- Historical market information shall be preserved throughout its lifecycle.
- Business ownership shall remain explicit and unambiguous.
- Aggregate boundaries shall always be respected.
- Cross-domain references shall terminate only at Aggregate Roots.
- Business semantics shall remain independent of implementation technologies.
- Enterprise identifiers shall remain stable throughout the lifecycle of every business object.

---

# 6. Domain Overview

The Market Domain consists of three enterprise Aggregates that collectively describe market operations.

```text
                 Market Domain

        ┌──────────────────────────────┐
        │      Instrument Listing      │
        └──────────────┬───────────────┘
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
 ┌───────────────────┐    ┌───────────────────┐
 │ Daily Market Data │    │ Corporate Action  │
 └───────────────────┘    └───────────────────┘
```

These Aggregates provide the logical representation of trading availability, historical trading activity and business events affecting tradable financial instruments.

---

# 7. Business Objects

| Business Object | Primary Responsibility | Business Identifier |
|-----------------|------------------------|---------------------|
| Instrument Listing | Represents the official listing of a financial instrument on a Trading Board | Listing Code |
| Daily Market Data | Records official historical trading activity for an Instrument Listing | Instrument Listing + Trading Date |
| Corporate Action | Records official business events affecting an Instrument | Corporate Action Reference |

---

# 8. Instrument Listing

## Business Purpose

The **Instrument Listing** Aggregate represents the official admission of a financial instrument to trading on a specific Trading Board.

It defines where an instrument may be traded and establishes the logical relationship between enterprise business objects defined in the Reference and Core Domains.

---

## Business Responsibilities

The Instrument Listing Aggregate shall:

- associate an Instrument with a Trading Board;
- maintain listing lifecycle information;
- preserve historical listing records;
- determine trading eligibility;
- provide the parent Aggregate for historical market information.

---

## Business Identifier

**Listing Code**

---

## Logical Characteristics

| Characteristic | Value |
|---------------|-------|
| Aggregate Type | Aggregate Root |
| Business Category | Operational Reference |
| Lifecycle | Managed |
| Historical | Yes |
| Shared Across Services | Yes |
| Mutable | Limited |

---

## Business Rules

- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall reference exactly one Trading Board.
- An Instrument may have multiple Listings during its lifecycle.
- Only active Listings may participate in market trading.
- Listing history shall remain fully traceable.
- Enterprise identifiers shall never change during the Listing lifecycle.

---

# 9. Daily Market Data

## Business Purpose

The **Daily Market Data** Aggregate represents the official daily trading activity associated with an Instrument Listing.

It forms the canonical historical record used throughout the Phoenix Platform for technical analysis, quantitative research, reporting, forecasting and backtesting.

---

## Business Responsibilities

The Daily Market Data Aggregate shall:

- record official daily trading information;
- preserve historical market activity;
- support analytical processing;
- provide trusted historical market records;
- maintain chronological consistency.

---

## Business Identifier

**Instrument Listing + Trading Date**

---

## Logical Characteristics

| Characteristic | Value |
|---------------|-------|
| Aggregate Type | Aggregate Root |
| Business Category | Historical Time-Series |
| Lifecycle | Immutable After Publication |
| Historical | Yes |
| Shared Across Services | Yes |
| Mutable | No (Except Approved Corrections) |

---

## Business Rules

- One Daily Market Data record shall exist for each Instrument Listing and Trading Day.
- Every record shall reference exactly one Instrument Listing.
- Every record shall reference exactly one Trading Calendar entry.
- Historical records shall remain immutable after publication.
- Any correction shall follow the approved Enterprise Data Governance process.
- Historical data shall remain permanently traceable.

---

# 10. Corporate Action

## Business Purpose

The **Corporate Action** Aggregate represents official business events that affect an Instrument or its issuing Company throughout its lifecycle.

These events influence historical market information and are essential for accurate analytical processing and price adjustment.

---

## Business Responsibilities

The Corporate Action Aggregate shall:

- record dividends;
- record capital increases;
- record stock splits and reverse splits;
- record rights offerings;
- record symbol or listing changes where applicable;
- preserve complete historical adjustment information.

---

## Business Identifier

**Corporate Action Reference**

---

## Logical Characteristics

| Characteristic | Value |
|---------------|-------|
| Aggregate Type | Aggregate Root |
| Business Category | Historical Business Event |
| Lifecycle | Historical |
| Historical | Yes |
| Shared Across Services | Yes |
| Mutable | No (Except Approved Corrections) |

---

## Business Rules

- Every Corporate Action shall reference exactly one Instrument.
- Every Corporate Action shall have one effective Trading Date.
- Historical Corporate Actions shall never be deleted.
- Corporate Action history shall remain fully traceable.
- Market adjustments shall preserve chronological consistency.

---

# 11. Cross-Aggregate Relationships

| Parent Aggregate | Child Aggregate | Cardinality | Relationship Type |
|------------------|-----------------|-------------|-------------------|
| Instrument | Instrument Listing | 1 : N | Association |
| Trading Board | Instrument Listing | 1 : N | Association |
| Instrument Listing | Daily Market Data | 1 : N | Composition |
| Trading Calendar | Daily Market Data | 1 : N | Association |
| Instrument | Corporate Action | 1 : N | Association |

All cross-aggregate relationships shall comply with the Aggregate boundaries defined by the Enterprise Architecture.

---

# 12. Domain Constraints

The following logical constraints govern the Market Domain.

- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall reference exactly one Trading Board.
- Every Daily Market Data record shall reference exactly one Instrument Listing.
- Every Daily Market Data record shall reference exactly one Trading Calendar entry.
- Every Corporate Action shall reference exactly one Instrument.
- Historical market information shall remain immutable after publication.
- Cross-domain references shall target Aggregate Roots only.
- Business identifiers shall remain stable throughout the lifecycle of each Aggregate.

---

# 13. Domain Invariants

The following invariants shall always hold throughout the Market Domain.

- Every Aggregate has exactly one Aggregate Root.
- Historical records are immutable.
- Business identifiers remain stable.
- Aggregate ownership remains explicit.
- Aggregate references terminate only at Aggregate Roots.
- Market events preserve chronological integrity.
- Enterprise identity remains independent of implementation technologies.
- Business semantics remain technology independent.

---

# 14. Traceability

The Market Domain Logical Model is fully traceable to the authoritative Enterprise Architecture artifacts of the Phoenix Platform.

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| PlatformArchitectureVision | Enterprise architectural direction |
| ArchitecturalPrinciples | Enterprise design principles |
| CanonicalDomainModel | Domain ownership and boundaries |
| ReferenceDomainLogicalModel | Exchange, Trading Board and Trading Calendar references |
| CoreDomainLogicalModel | Company and Instrument references |
| AggregateCatalog | Aggregate ownership and responsibilities |
| AggregateAttributeMatrix | Logical attribute allocation |
| AttributeCatalog | Enterprise attribute definitions |
| AttributeDictionary | Attribute semantics |
| CanonicalBusinessRules | Business rules and domain constraints |
| EnterpriseRelationshipCatalog | Business relationship semantics |
| EnterpriseRelationshipMatrix | Relationship ownership and navigation |
| CanonicalEnterpriseERD | Enterprise logical representation |

This traceability guarantees architectural consistency across the entire Enterprise Data Architecture.

---

# 15. Transition to Physical Design

This logical model provides the architectural foundation for the Physical Database Model.

The Physical Database Model shall derive from this document by defining:

- PostgreSQL schemas;
- database tables;
- columns and data types;
- primary and foreign keys;
- unique constraints;
- check constraints;
- indexes;
- partitioning strategy;
- storage optimization;
- performance optimization.

No implementation-specific business semantics shall be introduced during physical database design.

---

# 16. Related Artifacts

This document shall be used together with the following Enterprise Architecture specifications:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- CanonicalDomainModel
- ReferenceDomainLogicalModel
- CoreDomainLogicalModel
- IntegrationDomainLogicalModel
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- AttributeDictionary
- CanonicalBusinessRules
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CanonicalEnterpriseERD
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseDataDictionary

---

# 17. Architectural Governance

The Market Domain Logical Model is a controlled Enterprise Architecture artifact.

Any modification affecting:

- Aggregate ownership;
- Aggregate boundaries;
- business identifiers;
- business rules;
- domain responsibilities;
- cross-domain relationships;
- enterprise semantics;
- logical data structures;

shall require:

- Enterprise Architecture Review;
- Business Impact Analysis;
- Architecture Board Approval;
- Repository Baseline Update (when applicable).

All approved definitions contained in this document shall be regarded as canonical throughout the Phoenix Platform.

---

# 18. Approval

The Enterprise Architecture Board approves this Market Domain Logical Model as the official logical specification for the Market Domain of the Phoenix Platform.

This document establishes the canonical logical representation of enterprise market data and serves as the authoritative foundation for Logical Database Modeling, Physical Database Design, Enterprise Data Governance and Canonical Enterprise ERD development.

**Approval Status**

**APPROVED**

---

# 19. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------------------------------------------------------------------------|
| 2026.1 | 2026-07-09 | Initial canonical Market Domain Logical Model. |
| 2026.2 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline. Added Objectives, Architectural Principles, Domain Overview, Business Objects, Architectural Governance, Approval, enhanced Traceability and standardized document structure. |

---

# 20. Architecture Compliance

This document complies with the Phoenix Enterprise Architecture baseline and conforms to the following standards:

- Enterprise Architecture Governance Standard
- Canonical Domain Modeling Standard
- Enterprise Data Modeling Standard
- Aggregate Design Standard
- Enterprise Naming Convention Standard
- Enterprise Traceability Standard
- Repository Documentation Standard

The Market Domain Logical Model shall remain consistent with all approved Enterprise Architecture artifacts throughout the lifecycle of the Phoenix Platform.

---

# 21. Document Summary

The Market Domain Logical Model defines the canonical logical representation of operational market information within the Phoenix Platform Enterprise Architecture.

It establishes the ownership, responsibilities and business semantics of the Instrument Listing, Daily Market Data and Corporate Action Aggregates while preserving domain boundaries, Aggregate integrity and enterprise-wide architectural consistency.

This document serves as the authoritative logical foundation for the Canonical Enterprise ERD, Logical Database Model, Physical Database Model and all future implementations related to market data management.