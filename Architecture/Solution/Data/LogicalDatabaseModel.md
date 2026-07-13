# Logical Database Model

---

# Document Information

| Item | Value |
|------|-------|
| Document | Logical Database Model |
| Project | Phoenix |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Logical Database Model defines the logical structure of the Phoenix database.

It transforms the business concepts described in the Conceptual Database Model into normalized relational entities.

The logical model is independent of any specific database engine and serves as the foundation for the Physical Database Model.

---

# Scope

This document defines:

- Database schemas
- Logical entities
- Entity relationships
- Primary keys
- Foreign keys
- Candidate keys
- Business identifiers
- Normalization rules

This document intentionally excludes:

- Physical data types
- Storage parameters
- Index definitions
- Partitioning
- Performance optimization

These topics are addressed in the Physical Database Model.

---

# Design Principles

The Phoenix logical model follows these principles.

## Business-Oriented Design

Logical entities represent business concepts.

---

## Technology Independent

The model is independent of PostgreSQL or any other DBMS.

---

## Third Normal Form (3NF)

All entities shall satisfy Third Normal Form unless otherwise justified.

---

## Stable Primary Keys

Every entity shall use a surrogate primary key.

```text
id
```

Primary keys never contain business meaning.

---

## Public Identifiers

Every externally accessible master entity shall expose a globally unique public identifier.

```text
public_id
```

Public identifiers are immutable.

---

## Business Identifiers

Every master entity shall own a stable business identifier.

Examples:

- exchange_code
- board_code
- sector_code
- industry_code
- company_code
- instrument_code

Business identifiers remain stable throughout the entity lifecycle.

---

## Separation of Concerns

Business entities remain independent of integration concerns.

External provider identifiers are managed separately within the Integration schema.

---

# Database Schemas

Phoenix is organized into the following logical schemas.

| Schema | Responsibility |
|----------|----------------|
| market | Master market reference data |
| trading | Trading and market activity |
| integration | External system mappings |
| system | Shared infrastructure and system metadata |

---

# Schema Overview

```text
market
│
├── exchange
├── trading_board
├── sector
├── industry
├── company
├── instrument
└── instrument_listing

trading
│
├── trading_calendar
├── daily_market_data
└── corporate_action

integration
│
└── external_identifier

system
└── (Future)
```

---

# Naming Conventions

The following conventions apply.

## Tables

Singular nouns.

Examples

```text
exchange
company
instrument
daily_market_data
```

---

## Primary Keys

Every table contains:

```text
id
```

---

## Public Identifiers

Master tables expose:

```text
public_id
```

---

## Business Codes

Business identifiers use the following convention.

```text
exchange_code

board_code

sector_code

industry_code

company_code

instrument_code
```

---

## Foreign Keys

Foreign keys use the referenced table name followed by `_id`.

Examples

```text
exchange_id

industry_id

company_id

instrument_id
```

---

## Audit Columns

Every persistent entity shall contain the standard audit attributes defined by the project standards.

These attributes are documented in the Physical Database Model.

---
# Market Schema

The **market** schema contains master reference data describing the structure of financial markets.

Entities in this schema are relatively stable and change infrequently.

---

# Entity Overview

```text
Exchange
    │
    │ 1
    ▼
Trading Board
    │
    │ 1
    ▼
Instrument Listing
    ▲
    │
    │ N
Instrument
    ▲
    │
    │ N
Company
    ▲
    │
    │ N
Industry
    ▲
    │
    │ N
Sector
```

---

# market.exchange

## Description

Represents a securities exchange.

## Primary Key

id

## Business Identifier

exchange_code

## Public Identifier

public_id

## Relationships

One Exchange

↓

Many Trading Boards

```text
exchange

1

↓

N

trading_board
```

---

# market.trading_board

## Description

Represents a trading board operated by an exchange.

## Primary Key

id

## Foreign Keys

exchange_id

## Business Identifier

board_code

## Public Identifier

public_id

## Relationships

Belongs to one Exchange.

Contains many Instrument Listings.

```text
Exchange

1

↓

N

Trading Board
```

---

# market.sector

## Description

Represents the highest level of economic classification.

## Primary Key

id

## Business Identifier

sector_code

## Public Identifier

public_id

## Relationships

One Sector

↓

Many Industries

---

# market.industry

## Description

Represents an industry classification.

## Primary Key

id

## Foreign Keys

sector_id

## Business Identifier

industry_code

## Public Identifier

public_id

## Relationships

Belongs to one Sector.

Contains many Companies.

---

# market.company

## Description

Represents a legal company.

## Primary Key

id

## Foreign Keys

industry_id

## Business Identifier

company_code

## Public Identifier

public_id

## Relationships

Belongs to one Industry.

Owns many Instruments.

---

# market.instrument

## Description

Represents a tradable financial instrument.

## Primary Key

id

## Foreign Keys

company_id

## Business Identifier

instrument_code

## Public Identifier

public_id

## Relationships

Belongs to one Company.

May have many Listings.

May have many Daily Market Data records.

May have many Corporate Actions.

---

# market.instrument_listing

## Description

Represents the listing of an instrument on a trading board.

## Primary Key

id

## Foreign Keys

instrument_id

trading_board_id

## Public Identifier

public_id

## Relationships

Belongs to one Instrument.

Belongs to one Trading Board.

Represents the logical bridge between Instrument and Trading Board.

---

# Market Schema Integrity Rules

The following logical rules apply.

- Every Trading Board shall belong to one Exchange.
- Every Industry shall belong to one Sector.
- Every Company shall belong to one Industry.
- Every Instrument shall belong to one Company.
- Every Instrument Listing shall reference one Instrument.
- Every Instrument Listing shall reference one Trading Board.
- Business identifiers shall be unique within their corresponding entities.
- Public identifiers shall be globally unique.

---
# Trading Schema

The **trading** schema contains operational market data.

This schema grows continuously and stores time-series information.

---

# trading.trading_calendar

## Description

Defines official market trading sessions.

## Primary Key

id

## Public Identifier

public_id

## Relationships

Referenced by Daily Market Data.

---

# trading.daily_market_data

## Description

Represents end-of-day market information for one listed instrument.

## Primary Key

id

## Foreign Keys

instrument_listing_id

trading_calendar_id

## Relationships

Belongs to one Instrument Listing.

Belongs to one Trading Calendar.

One Instrument Listing

↓

Many Daily Market Data records.

---

# trading.corporate_action

## Description

Represents corporate events affecting a listed company or its instruments.

Examples

- Cash Dividend
- Stock Dividend
- Capital Increase
- Stock Split
- Reverse Split
- Rights Offering

## Primary Key

id

## Foreign Keys

instrument_id

## Relationships

Belongs to one Instrument.

One Instrument

↓

Many Corporate Actions.

---

# Integration Schema

The **integration** schema isolates Phoenix from external systems.

No business entity stores provider-specific identifiers.

---

# integration.external_identifier

## Description

Stores mappings between Phoenix entities and external provider identifiers.

## Primary Key

id

## Relationships

Each External Identifier references exactly one business entity.

Supported entity types include:

- Exchange
- Trading Board
- Sector
- Industry
- Company
- Instrument

One Business Entity

↓

Many External Identifiers

Examples

```text
Company

↓

Bloomberg Identifier

↓

Refinitiv Identifier

↓

TSE Identifier

↓

Yahoo Finance Identifier
```

---

# Cross-Schema Relationships

```text
market.instrument_listing

        │

        ▼

trading.daily_market_data



market.instrument

        │

        ▼

trading.corporate_action



market.*

        │

        ▼

integration.external_identifier
```

---

# Logical Integrity Rules

The following rules apply across schemas.

## Market

- Every Instrument Listing references exactly one Instrument.
- Every Instrument Listing references exactly one Trading Board.

---

## Trading

- Daily Market Data shall reference one Instrument Listing.
- Daily Market Data shall reference one Trading Calendar.
- Corporate Action shall reference one Instrument.

---

## Integration

- External Identifier references exactly one business entity.
- One business entity may have multiple external identifiers.
- Provider identifiers are never stored in Market entities.

---
# Normalization

The Phoenix logical data model follows Third Normal Form (3NF).

Normalization objectives include:

- Elimination of duplicate data
- Elimination of update anomalies
- Elimination of insertion anomalies
- Elimination of deletion anomalies
- Clear separation of business entities

No denormalization is introduced at the logical level.

Performance optimizations are addressed exclusively in the Physical Database Model.

---

# Cross-Schema Dependencies

```text
market
    │
    ├──────────────► trading
    │
    └──────────────► integration

trading
    │
    └──────────────► market

integration
    │
    └──────────────► market
```

Dependency Rules

- The Market schema is the foundation of the data model.
- The Trading schema depends on Market entities.
- The Integration schema depends on Market entities.
- Market entities never depend on Trading.
- Market entities never depend on Integration.

---

# Mapping to Physical Database Model

The Physical Database Model extends this logical model by defining:

- PostgreSQL data types
- Indexes
- Constraints
- Partitioning
- Storage optimization
- Performance tuning

No business concepts shall be introduced in the Physical Database Model.

---

# Logical Model Summary

## Market Schema

- exchange
- trading_board
- sector
- industry
- company
- instrument
- instrument_listing

## Trading Schema

- trading_calendar
- daily_market_data
- corporate_action

## Integration Schema

- external_identifier

## System Schema

Reserved for future infrastructure components.

---

# Architecture Decisions Applied

This Logical Database Model incorporates the following architecture decisions:

- ADR-015 — Public Identifier Strategy
- ADR-016 — Primary Key Strategy
- ADR-017 — External Identifier Mapping Strategy

---

# References

- ConceptualModel.md
- PhysicalDatabaseModel.md
- Data Dictionary
- ArchitectureFreeze-v1.1.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-12 | Initial Logical Model |
| 1.1 | 2026-06-29 | Architecture Freeze v1.1, DailyMarketData introduced, Instrument Listing promoted to business entity, Integration schema introduced, External Identifier Mapping adopted |