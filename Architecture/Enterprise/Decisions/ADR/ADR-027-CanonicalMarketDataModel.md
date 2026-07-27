# ADR-027 — Canonical Market Data Model

## Status

Accepted

---

## Context

Phoenix Platform is designed as a multi-market, service-oriented financial platform capable of supporting equities, exchange-traded funds, fixed-income securities, derivatives, foreign exchange, cryptocurrencies, commodities, and additional financial markets.

Market data is the primary source of information for almost every business capability within the platform, including:

- Market Data Engine
- Indicator Engine
- Strategy Engine
- Backtesting Engine
- Machine Learning Engine
- Reporting Engine
- Portfolio Engine
- Alert Engine
- Analytics Engine

A canonical market data model is therefore required to ensure that all services operate on a consistent, normalized, and extensible data structure.

---

## Problem Statement

Without a canonical market data model:

- Different services may store identical information differently.
- Historical reconstruction becomes difficult.
- Corporate actions become inconsistent.
- Multi-market support becomes expensive.
- Event processing becomes fragmented.
- Analytics and machine learning require excessive preprocessing.

---

# Decision

Phoenix adopts a Canonical Market Data Model.

Market information shall be organized into four architectural categories.

---

# 1. Reference Data

Reference data represents slowly changing business classifications.

Examples:

```text
Exchange
Country
Currency
Market
Board
InstrumentType
TradingSession
MarketStatus
CalendarType
TimeZone
CorporateActionType
CorporateActionStatus
TradingHaltCategory
InstrumentSuspensionReason
MarketEventType
Language
```

Characteristics

- Small tables
- Rarely updated
- Shared across all services
- Referenced through foreign keys

---

# 2. Master Data

Master data represents long-lived business entities.

Examples

```text
Instrument
InstrumentListing
MarketIndex
```

Characteristics

- Business identity
- Slowly changing
- Historical tracking supported
- Shared across the platform

---

# 3. Fact Data

Fact tables represent measurable market observations.

Examples

```text
DailyMarketData
IntradayBar
TickData
OrderBookSnapshot
MarketSnapshot
```

Characteristics

- High volume
- Append-only
- Partitioned
- Time-series optimized

---

# 4. Event Data

Event tables represent business events affecting market behavior.

Examples

```text
CorporateAction
CorporateActionItem
TradingHalt
InstrumentSuspension
InstrumentStatusHistory
InstrumentPriceAdjustment
CorporateAnnouncementReference
SymbolAlias
```

Characteristics

- Immutable whenever possible
- Historical
- Event-driven
- Auditable

---

# Canonical Relationships

```text
Reference
      │
      ▼
Master
      │
      ▼
Fact
      ▲
      │
Event
```

Reference data provides classifications.

Master data provides identities.

Fact data stores measurements.

Event data records lifecycle changes.

---

# Market Data Flow

```text
Exchange
    │
    ▼
Instrument
    │
    ▼
InstrumentListing
    │
    ├─────────────────────────────┐
    │                             │
    ▼                             ▼
DailyMarketData        InstrumentStatusHistory
    │                             │
    ▼                             ▼
Indicators                 TradingHalt
    │                             │
    ▼                             ▼
Strategies          InstrumentSuspension
    │
    ▼
Backtesting
    │
    ▼
Machine Learning
```

---

# DailyMarketData Responsibilities

DailyMarketData shall store only observable market facts.

Examples

- Trading date
- Open price
- High price
- Low price
- Close price
- Last price
- Previous close price
- Trade volume
- Trade value
- Trade count
- Market capitalization
- Base volume

DailyMarketData shall **not** contain:

- Corporate actions
- Suspension history
- Listing history
- Symbol history
- Instrument metadata

These belong to specialized Event or Master tables.

---

# Historical Principle

Phoenix never overwrites historical market data.

Business events are represented by dedicated Event tables.

Adjusted prices are calculated through adjustment services rather than modifying original observations.

---

# Partitioning Strategy

The following tables shall be partitioned by Trading Date or Timestamp.

```text
DailyMarketData
IntradayBar
TickData
OrderBookSnapshot
MarketSnapshot
```

Monthly partitions are recommended.

---

# Index Strategy

Indexes shall be defined only after all table definitions have been completed.

The initial DDL scripts shall include only:

- Primary Keys
- Unique Constraints
- Foreign Keys
- Check Constraints

Secondary indexes shall be implemented in dedicated Index scripts.

---

# Event Sourcing Principle

Every significant market event shall be stored as an immutable business event.

Examples

```text
Trading Halt
Corporate Action
Listing
Delisting
Suspension
Status Change
Price Adjustment
```

---

# Naming Convention

Reference Tables

```text
ReferenceName
```

Master Tables

```text
BusinessEntity
```

Fact Tables

```text
BusinessFact
```

Event Tables

```text
BusinessEvent
```

---

# Consequences

## Advantages

- Canonical enterprise data model
- Separation of business responsibilities
- High scalability
- Efficient analytics
- Simplified machine learning pipelines
- Multi-market readiness
- Event-driven architecture support
- PostgreSQL partitioning compatibility
- Clear ownership of business entities

## Trade-offs

- Larger number of tables
- More foreign key relationships
- Additional ETL complexity
- More sophisticated event orchestration

---

# Decision Summary

The Phoenix Platform shall organize all market-related data into four canonical categories:

- Reference Data
- Master Data
- Fact Data
- Event Data

This decision establishes the mandatory architectural foundation for every current and future object within the Market schema.

Every new Market table shall belong to exactly one of these four architectural categories.