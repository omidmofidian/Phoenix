# Reference Entity Pattern

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | PAT-REF-001 |
| Document | ReferenceEntityPattern |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Architecture Pattern |
| Architecture Layer | Solution Architecture |
| Domain | Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | ReferenceArchitecture.md, ReferenceDomainArchitecture.md, ReferenceDataModel.md |
| Used By | LogicalDatabaseModel.md, PhysicalDatabaseModel.md, EnterpriseDataDictionary.md |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical architectural pattern for designing Reference Entities within the Phoenix Platform.

Reference Entities represent enterprise-wide business concepts whose primary responsibility is to provide stable classifications, taxonomies, controlled vocabularies, and reusable business definitions.

The purpose of this pattern is to ensure that all reference entities are designed consistently, governed uniformly, and reused throughout the platform without introducing redundancy or ambiguity.

This pattern establishes the logical characteristics of reference entities independently of any database technology or implementation framework.

---

# 2. Objectives

The objectives of this pattern are to:

- Define a canonical design pattern for all reference entities.
- Standardize the business semantics of reference data.
- Promote enterprise-wide reuse of reference entities.
- Prevent duplication of business classifications.
- Support normalized business relationships.
- Enable consistent logical and physical data modeling.
- Preserve long-term architectural stability.
- Support multi-market extensibility.
- Facilitate governance and traceability across all architecture layers.

---

# 3. Scope

This pattern applies to every enterprise entity whose primary responsibility is to represent reusable business reference information.

Typical reference entities include, but are not limited to:

### Market Structure

- Market
- Exchange
- TradingBoard
- MarketSegment

### Business Classification

- AssetClass
- InstrumentType
- Sector
- Industry
- SubIndustry

### Geographic Reference

- Country
- Region
- City
- TimeZone

### Localization

- Language
- Locale

### Financial Reference

- Currency
- SettlementType

### Calendar Reference

- TradingCalendar
- TradingSession
- HolidayCalendar

### Integration Reference

- DataProvider
- DataSource

The pattern does not apply to operational, transactional, analytical, or temporary business entities.

---

# 4. Pattern Overview

Reference Entities provide the shared business vocabulary upon which operational business domains are built.

Unlike transactional entities, reference entities describe business meaning rather than business activity.

Reference entities are intended to be:

- Canonical
- Stable
- Enterprise-wide
- Technology independent
- Reusable
- Centrally governed

They serve as the authoritative source of business classifications across all domains, services, databases, APIs, analytical models, and artificial intelligence components.

Reference entities shall never contain operational business behavior.

---

# 5. Architectural Characteristics

Every Reference Entity should exhibit the following architectural characteristics.

## Business Characteristics

- Represents a business concept.
- Has a well-defined business meaning.
- Exists independently of implementation technology.
- Can be understood by business stakeholders.

## Enterprise Characteristics

- Shared across multiple business domains.
- Governed centrally.
- Serves as a canonical enterprise definition.
- Supports organization-wide consistency.

## Data Characteristics

- Low frequency of change.
- Long operational lifetime.
- Frequently referenced by business entities.
- Rarely deleted.
- Suitable for long-term historical compatibility.

## Architectural Characteristics

- Technology independent.
- Normalized.
- Loosely coupled.
- Highly reusable.
- Fully traceable.
- Suitable for multi-market expansion.

---

# 6. Canonical Entity Structure

Every Reference Entity is composed of logical business components rather than implementation-specific database fields.

```text
Reference Entity
│
├── Business Identity
│
├── Business Definition
│
├── Business Classification
│
├── Business Relationships
│
├── Business Lifecycle
│
├── Governance Metadata
│
└── External Mappings
```

These logical components define the business structure of a reference entity.

The physical representation of these components is defined separately within the Logical Database Model, Physical Database Model, and Enterprise Data Dictionary.

---

# 7. Business Identity Pattern

Every Reference Entity shall possess a stable business identity that remains independent of implementation technology.

Business identity shall satisfy the following principles:

- Unique within the enterprise.
- Stable throughout the entity lifecycle.
- Independent of database implementation.
- Independent of external data providers.
- Suitable for long-term references.

Business identifiers represent business meaning rather than storage mechanisms.

---

# 8. Business Semantics Pattern

Reference Entities define business meaning rather than operational state.

Each entity shall provide an explicit definition for:

- Business purpose
- Business terminology
- Business classification
- Business ownership
- Business constraints
- Business usage

The business semantics of a Reference Entity shall remain stable over time.

Changes to business meaning require architectural governance and impact assessment.

---

# 9. Relationship Pattern

Reference Entities establish business relationships that support enterprise-wide consistency.

Relationships shall satisfy the following principles.

## Hierarchical Relationships

Reference entities may participate in hierarchical structures.

Examples include:

```text
Market
    └── Exchange
            └── Trading Board

Sector
    └── Industry
            └── Sub Industry
```

Hierarchical relationships shall represent business decomposition rather than implementation convenience.

---

## Classification Relationships

Reference entities may classify operational business entities.

Example:

```text
Financial Instrument
        │
        ├── Asset Class
        ├── Instrument Type
        ├── Exchange
        ├── Market
        └── Trading Board
```

Reference entities define classifications but do not own operational business processes.

---

## Cross-Reference Relationships

Reference entities may reference other reference entities where necessary.

Examples include:

- Exchange → Market
- Trading Board → Exchange
- Currency → Country
- Trading Session → Trading Calendar

Circular ownership relationships shall not be introduced.

---

# 10. Lifecycle Pattern

Reference Entities typically evolve slowly and follow a controlled lifecycle.

```text
Proposal
        │
        ▼
Review
        │
        ▼
Approval
        │
        ▼
Publication
        │
        ▼
Operational Usage
        │
        ▼
Revision
        │
        ▼
Retirement
```

Deletion of reference entities should be avoided whenever practical.

Where business history must be preserved, entities should transition to an inactive or retired state rather than being removed.

Business identity shall remain stable throughout the lifecycle.

---

# 11. Design Rules

Every Reference Entity shall comply with the following architectural rules.

## REF-001

A Reference Entity shall represent exactly one business concept.

---

## REF-002

Business meaning shall remain independent of implementation technology.

---

## REF-003

Reference Entities shall be reusable across multiple domains.

---

## REF-004

Reference Entities shall not contain operational or transactional behavior.

---

## REF-005

Reference Entities shall support normalized business relationships.

---

## REF-006

Business terminology shall conform to the Enterprise Business Glossary.

---

## REF-007

Reference Entities shall support enterprise-wide traceability.

---

## REF-008

Reference definitions shall be governed through controlled architectural processes.

---

## REF-009

Duplicate business definitions are prohibited.

---

## REF-010

Every Reference Entity shall belong to exactly one aggregate within the Reference Domain.

---

# 12. Governance

Reference Entities are governed as enterprise assets.

Changes to Reference Entities shall follow the Phoenix Architecture Governance process.

The governance process includes:

1. Business justification
2. Impact analysis
3. Architecture review
4. Data architecture review
5. Approval
6. Repository update
7. Version publication

Business definitions shall not be modified without formal governance approval.

Reference entities shall remain backward compatible whenever practical.

---

# 13. Traceability

Every Reference Entity shall be traceable across all architectural layers.

```text
Business Glossary
        │
        ▼
Canonical Business Rules
        │
        ▼
Reference Architecture
        │
        ▼
Reference Domain Architecture
        │
        ▼
Reference Data Model
        │
        ▼
Reference Entity Pattern
        │
        ▼
Logical Database Model
        │
        ▼
Physical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Database Implementation
```

This traceability ensures architectural consistency, governance, maintainability, and long-term evolution.

---

# 14. Compliance

All reference entities implemented within the Phoenix Platform shall comply with this architectural pattern.

Compliance shall be verified during:

- Architecture reviews
- Data model reviews
- Database design reviews
- Repository audits
- Architecture compliance assessments

Any intentional deviation from this pattern shall be documented and approved through an Architecture Decision Record (ADR).

---

# 15. Related Documents

## Vision

- PlatformArchitectureVision.md
- ReferenceArchitecture.md
- KnowledgeDrivenArchitecture.md

## Business Architecture

- BusinessCapabilityMap.md
- CanonicalDomainModel.md
- DomainResponsibilities.md

## Domain Architecture

- ReferenceDomainArchitecture.md

## Data Architecture

- ReferenceDataModel.md
- EntityClassification.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

## Governance

- BusinessGlossary.md
- CanonicalBusinessRules.md
- Architecture Decision Records (ADR)

---

# 16. Success Criteria

The Reference Entity Pattern is considered successfully applied when:

- Every reference entity follows a consistent architectural structure.
- Business semantics are defined explicitly and unambiguously.
- Reference entities are reused across business domains without duplication.
- Relationships remain fully normalized and technology independent.
- Logical and physical data models conform to the canonical pattern.
- Reference entities support future expansion to additional financial markets without structural redesign.
- All implementations remain traceable to the canonical business definitions.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-07 | Initial architectural pattern. |
| 2026.2 | 2026-07-18 | Complete redesign as the canonical Reference Entity Pattern aligned with the Phoenix Enterprise Architecture Framework. |