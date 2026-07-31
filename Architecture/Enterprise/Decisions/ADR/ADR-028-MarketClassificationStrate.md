# ADR-028 — Market Classification Strategy

* **Status:** Accepted
* **Version:** 2026.1
* **Date:** 2026-07-30
* **Category:** Data Architecture / Domain Modeling
* **Deciders:** Phoenix Architecture Team
* **Supersedes:** None
* **Superseded by:** None

## Context

Phoenix Platform is designed as a multi-market financial platform capable of supporting multiple stock exchanges, markets, trading boards, companies, and financial instruments across different countries and jurisdictions.

During the design of the canonical market data model, the following entities were identified as the core market classification hierarchy:

* Exchange
* Market
* Trading Board
* Company
* Instrument

The architecture must support:

* multiple exchanges
* multiple markets within an exchange
* multiple trading boards within a market
* companies listed on trading boards
* financial instruments issued by companies
* future support for multi-listing across multiple exchanges

A consistent market classification strategy is required to ensure data integrity, extensibility, and analytical performance.

---

## Decision

Phoenix adopts a **hierarchical market classification model**.

The canonical market hierarchy is:

**Exchange → Market → Trading Board → Company → Instrument**

Where:

* **Exchange** represents a stock exchange or trading venue.
* **Market** represents a business market operating within an exchange.
* **Trading Board** represents a listing or trading board within a market.
* **Company** represents a legal business entity.
* **Instrument** represents a tradable financial security issued by a company.

---

## Canonical Entity Placement

### Reference Layer (`ref`)

Contains global reference dictionaries.

Examples:

* country
* currency
* time_zone
* instrument_type
* industry
* sector

Reference entities are shared across all market domains and contain standardized master data.

### Market Domain Layer (`market`)

Contains market-specific business entities.

Examples:

* exchange
* market
* trading_board
* company
* instrument
* listing
* daily_market_data
* corporate_action
* trading_session

Market entities represent operational business concepts used by trading, analytics, and investment services.

---

## Classification References

### Company

The Company entity stores:

* exchange_id
* market_id
* trading_board_id
* industry_id
* sector_id

The storage of `exchange_id` and `market_id` is **intentional denormalization**.

These attributes can theoretically be derived from `trading_board_id`; however, they are retained to optimize analytical queries, filtering, reporting, and data warehouse operations.

Consistency between these references shall be enforced by:

* application services,
* validation procedures,
* ETL processes,
* or future database integrity mechanisms.

### Instrument

Instrument stores:

* company_id
* instrument_type_id

Instrument does **not** store exchange_id or market_id directly.

An instrument belongs to exactly one company.

---

## Listing Strategy

A separate **Listing** entity shall connect instruments to trading venues.

Future canonical relationship:

Exchange → Market → Trading Board → Listing → Instrument

Listing will contain exchange-specific trading attributes such as:

* ticker
* listing status
* listing date
* delisting date
* trading currency
* board-specific identifiers

This allows a single instrument to be listed on multiple exchanges or trading boards.

---

## Ticker Uniqueness

Ticker symbols are exchange-dependent.

During the current implementation phase (Iran Stock Exchange only), ticker values may remain globally unique.

The long-term canonical rule is:

**Ticker uniqueness shall be enforced within the scope of a Listing.**

Example:

UNIQUE (trading_board_id, ticker)

or

UNIQUE (exchange_id, ticker)

depending on the finalized Listing model.

---

## Normalization Policy

Phoenix adopts a **hybrid normalization strategy**.

* Reference entities are fully normalized.
* Core market entities may intentionally contain denormalized classification references when justified by analytical performance and reporting requirements.

Such denormalization must be:

* documented,
* deterministic,
* and maintainable through validation mechanisms.

---

## Consequences

### Advantages

* clear market hierarchy
* support for multiple exchanges and markets
* future multi-listing capability
* high analytical performance
* simplified reporting and filtering
* stable domain model for trading services

### Trade-offs

* duplicated classification references in Company
* additional validation requirements
* slightly increased write complexity

These trade-offs are accepted in favor of query efficiency and future scalability.

---

## Related Artifacts

### Architecture

* DomainModel.md
* LogicalDatabaseModel.md
* PhysicalDatabaseModel.md
* EnterpriseDataDictionary.md

### ADR

* ADR-018 Database Initialization Strategy
* ADR-020 Database Bootstrap and Security Architecture
* ADR-027 Canonical Market Data Model

### Database

* market.exchange
* market.market
* market.trading_board
* market.company
* market.instrument
* market.listing (planned)

---

## Decision Summary

Phoenix Platform adopts a hierarchical market classification strategy centered on the relationship:

**Exchange → Market → Trading Board → Company → Instrument**

Reference entities remain fully normalized within the `ref` schema, while selected market entities may intentionally store denormalized classification references to optimize analytical workloads.

The future Listing entity becomes the canonical bridge between financial instruments and trading venues and will be responsible for exchange-scoped ticker uniqueness and multi-listing support.
