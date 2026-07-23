# Instrument Listing Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-011 |
| Document | InstrumentListingDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, CanonicalDomainModel, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The Instrument Listing entity defines the canonical business representation of the admission of a financial instrument to a specific Trading Board within the Phoenix Platform.

An Instrument Listing establishes where, how, and under which trading identity an Instrument becomes available for trading.

It forms the business bridge between the Instrument, which represents the issued financial asset, and the Trading Board, which represents the market venue where trading occurs.

The Instrument Listing Data Dictionary serves as the authoritative semantic definition of this business entity across the enterprise.

This document follows the Single Source of Truth (SSOT) principle and is intentionally technology independent.

---

# 2. Scope

This document defines the canonical business semantics of the Instrument Listing entity.

It applies to every business capability responsible for market structure, trading, analytics, historical market reconstruction, portfolio management, reporting, and external integration.

This dictionary defines:

- business meaning;
- enterprise identity;
- business responsibilities;
- lifecycle;
- business relationships;
- governance;
- traceability.

This dictionary does not define:

- database tables;
- SQL implementation;
- physical columns;
- indexes;
- constraints;
- foreign keys;
- implementation details.

These responsibilities belong to the Physical Database Model and related implementation artifacts.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Data Dictionary Standard | Governs the structure of enterprise data dictionaries |
| Entity Dictionary | Defines Instrument Listing as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Instrument Listing attributes |
| Relationship Dictionary | Defines canonical relationships involving Instrument Listing |
| Canonical Domain Model | Places Instrument Listing within the Market domain |
| Logical Database Model | Defines logical relationships and aggregate boundaries |
| Physical Database Model | Defines physical database implementation |
| Architecture Decision Records (ADRs) | Capture architectural decisions affecting Instrument Listing |

---

# 4. Business Definition

An Instrument Listing represents the formal admission of a financial instrument to a specific Trading Board where it becomes eligible for public trading.

It establishes the business context in which an Instrument participates in a financial market by defining its trading identity within a particular market venue.

The Instrument Listing entity separates the intrinsic identity of a financial instrument from the operational context in which that instrument is traded.

Within the Phoenix Platform, trading activities, market observations, and historical market records are associated with the Instrument Listing rather than directly with the Instrument itself.

An Instrument may exist without any Instrument Listings, while an Instrument Listing cannot exist without both an Instrument and a Trading Board.

---

# 5. Enterprise Identity

Every Instrument Listing possesses a unique enterprise identity representing a specific admission of an Instrument to a particular Trading Board.

Unlike the Instrument entity, whose identity is globally stable, the identity of an Instrument Listing is context-dependent and represents a unique trading relationship between:

- one Instrument; and
- one Trading Board.

An Instrument may therefore have multiple independent Instrument Listings throughout its lifecycle.

The enterprise identity of an Instrument Listing remains stable regardless of:

- changes in trading activity;
- temporary trading suspensions;
- market data availability;
- analytical processing;
- external provider identifiers.

Historical Instrument Listings remain part of the enterprise knowledge base even after trading has permanently ceased.

---

# 6. Business Responsibilities

The Instrument Listing entity is responsible for representing the business admission of an Instrument to a trading venue.

Its responsibilities include:

- associating an Instrument with a Trading Board;
- establishing the trading identity of an Instrument within a market;
- defining the business context for trading activities;
- providing the reference point for market observations;
- supporting historical market reconstruction;
- enabling market analytics;
- supporting regulatory traceability;
- maintaining the historical continuity of market listings.

The Instrument Listing entity is not responsible for:

- defining the Instrument itself;
- defining the Trading Board;
- storing market prices;
- recording trading sessions;
- managing corporate actions;
- calculating analytical indicators;
- maintaining investment portfolios.

These responsibilities belong to their respective enterprise entities.

---

# 7. Business Relationships

The Instrument Listing entity participates in several canonical enterprise relationships.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Instrument | Represents the market admission of | N : 1 |
| Trading Board | Admitted to | N : 1 |
| Exchange | Indirectly associated through Trading Board | N : 1 |
| Daily Market Data | Produces | 1 : N |
| Corporate Action | May be affected by | N : M |
| Trading Calendar | Operates within | N : 1 |
| Market Statistics | Referenced by | 1 : N |

The Instrument Listing entity represents the operational bridge between master data and transactional market data.

All enterprise services dealing with trading information shall reference Instrument Listings rather than Instruments whenever market-specific context is required.

---

# 8. Business Lifecycle

The lifecycle of an Instrument Listing follows the progression below.

```text
Proposed

↓

Approved

↓

Listed

↓

Active

↓

Suspended (Optional)

↓

Delisted

↓

Archived
```

The lifecycle of an Instrument Listing is independent of the lifecycle of the associated Instrument.

An Instrument may continue to exist after one or more of its Instrument Listings have been delisted.

Likewise, historical Instrument Listings shall remain available for auditability, historical reporting, regulatory compliance, and analytical reproducibility.

---

# 9. Business Rules

The following enterprise business rules govern the Instrument Listing entity.

## Identity Rules

- Every Instrument Listing shall possess exactly one canonical enterprise identity.
- An Instrument Listing shall represent the admission of one Instrument to one Trading Board.
- An Instrument Listing shall not exist independently of both its associated Instrument and Trading Board.
- The enterprise identity of an Instrument Listing shall remain immutable throughout its lifecycle.

---

## Listing Rules

- An Instrument may have multiple Instrument Listings.
- A Trading Board may contain multiple Instrument Listings.
- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall reference exactly one Trading Board.
- Multiple listings of the same Instrument on different Trading Boards are permitted.
- Every Instrument Listing represents an independent business lifecycle.

---

## Trading Rules

- Trading activities shall always be associated with an Instrument Listing.
- Market observations shall reference an Instrument Listing rather than an Instrument.
- Historical trading information shall remain linked to the originating Instrument Listing.
- Suspension or delisting of an Instrument Listing shall not affect historical market records.

---

## Lifecycle Rules

- An Instrument Listing may exist before active trading begins.
- An Instrument Listing may be temporarily suspended without being removed.
- Delisted Instrument Listings shall remain available for historical reference.
- Historical Instrument Listings shall never be physically removed from the enterprise information model.

---

## Governance Rules

- Business semantics shall remain independent of implementation technology.
- External provider identifiers shall not define the business identity of an Instrument Listing.
- Changes affecting business semantics shall follow the Enterprise Architecture Governance process.
- All enterprise services shall interpret the Instrument Listing entity consistently according to this dictionary.

---

# 10. Governance

The Instrument Listing entity is governed as a canonical enterprise business entity.

Its business definition, lifecycle, responsibilities, and relationships are controlled through the Enterprise Architecture Governance framework.

The following changes require formal architectural review and approval:

- changes to the business definition;
- changes to enterprise identity;
- changes to lifecycle semantics;
- changes to canonical business relationships;
- changes affecting aggregate boundaries;
- introduction of new business concepts related to market listings.

All approved changes shall maintain consistency with every dependent enterprise artifact.

---

# 11. Traceability

The Instrument Listing entity is traceable throughout the Phoenix Enterprise Architecture.

| Artifact | Relationship |
|----------|--------------|
| Business Glossary | Defines Instrument Listing terminology |
| Entity Dictionary | Defines Instrument Listing as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Instrument Listing attributes |
| Relationship Dictionary | Defines canonical relationships involving Instrument Listing |
| Canonical Domain Model | Places Instrument Listing within the Market domain |
| Aggregate Catalog | Defines aggregate ownership |
| Logical Database Model | Defines logical relationships |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary | Defines business semantics |
| Architecture Decision Records (ADRs) | Record architectural decisions affecting Instrument Listing |

Enterprise traceability guarantees semantic consistency across business architecture, information architecture, application architecture, and data architecture.

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

# 13. Cross-Reference Matrix

The Instrument Listing entity is governed by and traced to the following enterprise artifacts.

| Enterprise Artifact | Relationship |
|---------------------|--------------|
| Business Glossary | Defines business terminology related to Instrument Listings |
| Entity Dictionary | Defines Instrument Listing as a canonical business entity |
| Attribute Catalog | Registers approved Instrument Listing attributes |
| Attribute Dictionary | Defines the business semantics of Instrument Listing attributes |
| Relationship Dictionary | Defines canonical business relationships involving Instrument Listing |
| Aggregate Catalog | Identifies the owning Aggregate |
| Canonical Domain Model | Places Instrument Listing within the Market Domain |
| Logical Database Model | Defines logical structure and aggregate boundaries |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary Standard | Governs the structure of this document |
| Enterprise Attribute Standard | Governs enterprise attribute definitions |
| Enterprise Naming Standard | Governs naming conventions |
| Enterprise Data Type Standard | Governs logical data types |
| ADR-015 — Market Classification Model | Defines enterprise market classification principles |
| ADR-016 — Public Identifier Strategy | Defines enterprise identity strategy |
| ADR-017 — Canonical Data Modeling Principles | Defines enterprise data modeling principles |

---

# 14. Compliance

All enterprise solutions shall use the Instrument Listing entity exactly as defined in this dictionary.

The Instrument Listing entity shall:

- maintain a single canonical business definition;
- remain technology independent;
- remain implementation independent;
- preserve semantic consistency across all enterprise artifacts;
- comply with the Enterprise Data Dictionary Standard;
- comply with the Enterprise Attribute Standard;
- comply with approved Architecture Decision Records (ADRs).

No application, service, database, or external integration may redefine the business meaning of an Instrument Listing.

Any modification to this document shall require formal review and approval through the Enterprise Architecture Governance process.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Instrument Listing Data Dictionary |
| 2026.2 | 2026-07-23 | Redesigned as an Enterprise semantic dictionary aligned with the Enterprise Data Dictionary Standard and the Single Source of Truth (SSOT) principles |