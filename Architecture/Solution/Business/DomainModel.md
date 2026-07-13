# Domain Model

| Item | Value |
|------|------|
| Document | Domain Model |
| Project | Phoenix Platform |
| Version | 2.0 |
| Status | Approved |
| Owner | Enterprise Architecture |
| Last Updated | 2026-07-12 |

---

# 1. Purpose

This document defines the canonical business domain model of the Phoenix Platform.

It identifies the core business domains, aggregates, entities, and relationships that constitute the enterprise financial platform.

The Domain Model is implementation-independent and serves as the foundation for the Conceptual Data Model, Logical Data Model, Physical Database Model, and application services.

---

# 2. Architectural Principles

The Domain Model follows these principles:

- Domain-Driven Design (DDD)
- Canonical Business Model
- Separation of Concerns
- Single Source of Truth
- Third Normal Form (3NF)
- Enterprise Scalability
- Business-Driven Architecture
- Technology Independence

---

# 3. Domain Landscape

```text
Phoenix Platform

├── Reference Domain

├── Market Data Domain

├── Instrument Domain

├── Corporate Actions Domain

├── Trading Calendar Domain

├── Analytics Domain

├── Feature Engineering Domain

├── Strategy Domain

├── Backtesting Domain

├── Portfolio Domain

├── Risk Management Domain

├── Reporting Domain

└── Integration Domain
```

---

# 4. Reference Domain

The Reference Domain contains the master data required throughout the platform.

## Aggregate Structure

```text
Exchange
    │
    └── Market
            │
            └── Board
                    │
                    └── Company
                            │
                            └── FinancialInstrument
```

Business Classification

```text
Industry
      │
      └── Sector
              │
              └── Company
```

---

# 5. Aggregate Definitions

## Exchange

Represents a securities exchange.

Examples:

- Tehran Stock Exchange
- Iran Fara Bourse

---

## Market

Represents a market operating inside an exchange.

A Market belongs to exactly one Exchange.

---

## Board

Represents a trading board within a market.

A Board belongs to exactly one Market.

---

## Industry

Represents an industry classification.

---

## Sector

Represents a business sector.

A Sector belongs to exactly one Industry.

---

## Company

Represents a legal business entity.

A Company belongs to:

- one Board
- one Sector

A Company does not directly reference:

- Exchange
- Market
- Industry

These relationships are derived through the normalized hierarchy.

---

## Financial Instrument

Represents a tradable financial instrument.

Examples include:

- Common Stock
- ETF
- Bond
- Option
- Future
- Right Issue
- Index
- Commodity
- Currency

Each Financial Instrument belongs to exactly one Company.

---

## Trading Calendar

Represents official trading days.

---

## Holiday Calendar

Represents exchange holidays and non-trading days.

---

# 6. Aggregate Relationships

```text
Exchange (1)
    │
    └──────────────< Market (N)

Market (1)
    │
    └──────────────< Board (N)

Board (1)
    │
    └──────────────< Company (N)

Industry (1)
    │
    └──────────────< Sector (N)

Sector (1)
    │
    └──────────────< Company (N)

Company (1)
    │
    └──────────────< FinancialInstrument (N)

TradingCalendar (1)
    │
    └──────────────< HolidayCalendar (N)
```

---

# 7. Aggregate Roots

The following entities are Aggregate Roots.

| Aggregate | Root Entity |
|------------|-------------|
| Exchange | Exchange |
| Industry | Industry |
| Company | Company |
| Trading Calendar | TradingCalendar |

---

# 8. Business Rules

## BR-001

Every Market belongs to one Exchange.

---

## BR-002

Every Board belongs to one Market.

---

## BR-003

Every Sector belongs to one Industry.

---

## BR-004

Every Company belongs to one Board.

---

## BR-005

Every Company belongs to one Sector.

---

## BR-006

Every Financial Instrument belongs to one Company.

---

## BR-007

Only direct parent relationships may be stored.

Derived relationships shall never be stored.

---

## BR-008

The canonical operational model shall remain fully normalized.

---

# 9. Domain Boundaries

| Domain | Responsibility |
|---------|----------------|
| Reference | Master Data |
| Market Data | Historical Prices |
| Instrument | Tradable Assets |
| Trading Calendar | Trading Sessions |
| Analytics | Indicators |
| Feature Engineering | ML Features |
| Strategy | Trading Logic |
| Portfolio | Holdings |
| Risk | Risk Models |
| Reporting | Reports |
| Integration | External Providers |

---

# 10. Related Documents

- ADR-026 — Normalize Reference Data Model
- ADR-027 — Introduce Financial Instrument Aggregate
- ConceptualDataModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

---

# 11. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------|
| 1.0 | 2026-07-08 | Initial domain model. |
| 2.0 | 2026-07-12 | Normalized reference hierarchy and introduced the Financial Instrument aggregate. |