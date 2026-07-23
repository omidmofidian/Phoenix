# Instrument Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-010 |
| Document | InstrumentDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, CanonicalDomainModel, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The Instrument entity represents the canonical business definition of a tradable financial instrument within the Phoenix Platform.

An Instrument is a financial asset issued by a Company that may become eligible for trading after being admitted to one or more Trading Boards through Instrument Listings.

The Instrument Data Dictionary establishes the enterprise-wide semantic definition of the Instrument entity and serves as the authoritative source for its business meaning across the platform.

This document follows the Single Source of Truth (SSOT) principle and is intentionally technology independent. It defines business semantics only and does not describe database implementation or physical storage.

---

# 2. Scope

This document defines the canonical business semantics of the Instrument entity throughout the Phoenix Platform.

It applies to all business capabilities, domains, services, and future extensions that create, manage, analyze, or exchange information related to financial instruments.

This dictionary defines:

- canonical business meaning;
- enterprise identity;
- business responsibilities;
- lifecycle;
- business relationships;
- governance;
- traceability.

This dictionary does not define:

- database tables;
- SQL data types;
- physical columns;
- indexes;
- constraints;
- foreign keys;
- implementation details.

These aspects are defined by the Physical Database Model and the corresponding implementation artifacts.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Data Dictionary Standard | Defines the documentation standard for all enterprise data dictionaries |
| Entity Dictionary | Defines the Instrument as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Instrument attributes |
| Relationship Dictionary | Defines the canonical business relationships involving Instrument |
| Canonical Domain Model | Places Instrument within the Market domain |
| Logical Database Model | Defines logical relationships and aggregate boundaries |
| Physical Database Model | Defines the physical implementation in PostgreSQL |
| Architecture Decision Records (ADRs) | Capture architectural decisions affecting the Instrument entity |

---

# 4. Business Definition

An Instrument is the canonical representation of a tradable financial asset within the Phoenix Platform.

It represents the financial security issued by a Company and serves as the primary business object upon which trading, valuation, portfolio management, market analysis, and investment decisions are based.

The Instrument entity exists independently of:

- exchanges;
- trading boards;
- market listings;
- external market data providers;
- analytical models;
- trading activity.

An Instrument may exist before being listed for trading and shall continue to exist after trading has ceased, provided that its historical business identity remains relevant.

The Instrument is therefore considered a long-lived enterprise business entity whose identity is immutable throughout its lifecycle.

---

# 5. Enterprise Identity

Every Instrument possesses one and only one canonical enterprise identity.

This identity uniquely distinguishes the Instrument from every other financial instrument managed by the Phoenix Platform.

The enterprise identity is:

- globally unique;
- immutable;
- technology independent;
- provider independent;
- exchange independent.

The identity of an Instrument shall never change because of:

- listing on additional exchanges;
- ticker symbol changes;
- trading board transfers;
- changes in external provider identifiers;
- company name changes;
- market restructuring.

The enterprise identity guarantees semantic consistency across all domains and services of the platform.

---

# 6. Business Responsibilities

The Instrument entity is responsible for representing the intrinsic business characteristics of a financial instrument.

Its primary responsibilities include:

- representing a tradable financial asset;
- maintaining the canonical enterprise identity of the asset;
- associating the asset with its issuing Company;
- supporting investment lifecycle management;
- providing the foundation for trading activities;
- enabling analytical and quantitative processing;
- supporting portfolio and risk management;
- supporting enterprise-wide integration.

The Instrument entity is not responsible for:

- market prices;
- trading sessions;
- exchange membership;
- listing history;
- corporate actions;
- technical indicators;
- investment portfolios;
- trading signals.

These responsibilities belong to their respective enterprise entities.

---

# 7. Business Relationships

The Instrument entity participates in several canonical business relationships across the enterprise.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Company | Issued by | N : 1 |
| Instrument Listing | Listed through | 1 : N |
| Trading Board | Traded on (through Instrument Listing) | N : M |
| Daily Market Data | Produces | 1 : N |
| Corporate Action | Subject of | 1 : N |
| Portfolio Position | Referenced by | 1 : N |
| Strategy | Evaluated by | N : M |
| Indicator | Calculated for | 1 : N |
| Prediction | Evaluated for | 1 : N |

All business relationships shall conform to the Relationship Dictionary and the approved Logical Database Model.

---

# 8. Business Lifecycle

The lifecycle of an Instrument follows the progression below.

```text
Proposed

↓

Issued

↓

Listed

↓

Tradable

↓

Suspended (Optional)

↓

Delisted

↓

Retired

↓

Archived
```

An Instrument shall preserve its enterprise identity throughout every lifecycle stage.

Historical Instruments shall remain available for reporting, auditing, analytics, and historical market reconstruction even after retirement.

---

# 9. Business Rules

The following enterprise business rules govern the Instrument entity.

## Identity Rules

- Every Instrument shall possess exactly one canonical enterprise identity.
- The enterprise identity shall remain immutable throughout the Instrument lifecycle.
- An Instrument shall never be duplicated within the enterprise.
- External provider identifiers shall never replace the canonical Instrument identity.

---

## Ownership Rules

- Every Instrument shall be issued by exactly one Company.
- An Instrument cannot exist without an issuing Company.
- Changes to Company information shall not affect the identity of the Instrument.

---

## Listing Rules

- An Instrument may exist without being listed on any Trading Board.
- An Instrument may be listed on one or more Trading Boards through Instrument Listings.
- Listing information is managed independently from the Instrument entity.

---

## Trading Rules

- Trading activities shall reference an existing Instrument.
- Market prices shall not be stored as attributes of the Instrument entity.
- Trading history shall be maintained independently from Instrument master data.

---

## Classification Rules

- Every Instrument shall belong to exactly one approved Instrument Type.
- Instrument classifications shall comply with the Enterprise Business Glossary and Canonical Domain Model.
- New Instrument Types require architectural approval before adoption.

---

## Governance Rules

- The Instrument entity shall remain technology independent.
- Business semantics shall not depend on database implementation.
- Historical Instruments shall never be physically removed from the enterprise information model.
- Business changes affecting the Instrument entity shall follow the Architecture Governance process.

---

# 10. Governance

The Instrument entity is governed as a canonical enterprise business entity.

All modifications to its business definition shall comply with the Enterprise Architecture Governance framework.

Changes requiring governance review include:

- changes to the business definition;
- changes to business responsibilities;
- changes to lifecycle semantics;
- changes to canonical relationships;
- changes affecting enterprise identity;
- introduction of new business concepts related to Instruments.

All proposed modifications shall undergo:

1. Business impact analysis.
2. Architecture review.
3. Cross-document consistency validation.
4. Formal architectural approval.

The Instrument entity shall remain synchronized with all dependent enterprise artifacts.

---

# 11. Traceability

The Instrument entity is traceable across the Phoenix Enterprise Architecture.

| Artifact | Relationship |
|----------|--------------|
| Business Glossary | Defines Instrument terminology |
| Entity Dictionary | Defines the Instrument business entity |
| Attribute Dictionary | Defines Instrument attribute semantics |
| Relationship Dictionary | Defines Instrument business relationships |
| Canonical Domain Model | Places Instrument within the Market domain |
| Aggregate Catalog | Defines aggregate ownership |
| Logical Database Model | Defines logical relationships |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary | Defines business semantics |
| Architecture Decision Records (ADRs) | Records architectural decisions affecting Instrument |

This traceability ensures consistency across business architecture, information architecture, application architecture, and data architecture.

---

# 12. Related Documents

- EnterpriseDataDictionaryStandard
- BusinessGlossary
- EntityDictionary
- AttributeDictionary
- RelationshipDictionary
- CanonicalDomainModel
- AggregateCatalog
- LogicalDatabaseModel
- PhysicalDatabaseModel
- ADR-015 — Market Classification Model
- ADR-016 — Public Identifier Strategy
- ADR-017 — Canonical Data Modeling Principles

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Instrument Data Dictionary |
| 2026.2 | 2026-07-23 | Redesigned as an Enterprise semantic dictionary aligned with the Enterprise Data Dictionary Standard and Single Source of Truth (SSOT) principles |

---

# 13. Cross-Reference Matrix

The Instrument entity is governed by and traced to the following enterprise artifacts.

| Enterprise Artifact | Relationship |
|---------------------|--------------|
| Business Glossary | Defines the business terminology related to Instruments |
| Entity Dictionary | Defines Instrument as a canonical business entity |
| Attribute Catalog | Registers approved Instrument attributes |
| Attribute Dictionary | Defines the business semantics of Instrument attributes |
| Relationship Dictionary | Defines canonical relationships involving Instrument |
| Aggregate Catalog | Identifies the owning Aggregate |
| Canonical Domain Model | Places Instrument within the Market Domain |
| Logical Database Model | Defines logical structure and relationships |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary Standard | Governs the structure of this document |
| Enterprise Attribute Standard | Governs Instrument attributes |
| Enterprise Naming Standard | Governs naming conventions |
| Enterprise Data Type Standard | Governs logical data types |
| ADR-015 — Market Classification Model | Defines market classification principles |
| ADR-016 — Public Identifier Strategy | Defines enterprise identity strategy |
| ADR-017 — Canonical Data Modeling Principles | Defines enterprise modeling principles |

---

# 14. Compliance

All enterprise solutions shall use the Instrument entity exactly as defined in this dictionary.

The Instrument entity shall:

- maintain a single canonical business definition;
- remain technology independent;
- remain implementation independent;
- preserve semantic consistency across all enterprise artifacts;
- comply with the Enterprise Data Dictionary Standard;
- comply with the Enterprise Attribute Standard;
- comply with approved Architecture Decision Records (ADRs).

No project, service, database, or application may redefine the business meaning of the Instrument entity.

Any modification to this document shall require formal architecture review and approval through the Enterprise Architecture Governance process.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Instrument Data Dictionary |
| 2026.2 | 2026-07-23 | Completely redesigned according to the Enterprise Data Dictionary Standard, aligned with the Single Source of Truth (SSOT) principle and the canonical enterprise architecture. |