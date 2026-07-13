# Financial Market Taxonomy

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | FMK-001 |
| Version | 1.0 |
| Status | Approved |
| Classification | Financial Market Knowledge |
| Owner | Domain Architecture Team |
| Last Updated | 2026-07-08 |

---

# 1. Purpose

This document defines the canonical taxonomy of financial markets supported by the Phoenix Platform.

It establishes a common business vocabulary and hierarchical classification for markets, asset classes, financial instruments, exchanges, trading sessions, and related concepts.

This taxonomy serves as the foundation for:

- Knowledge Layer
- Domain Model
- Service Model
- Database Design
- AI Models
- Analytics
- Risk Management

---

# 2. Scope

This taxonomy applies to every market supported by Phoenix.

It is independent of:

- Country
- Exchange
- Broker
- Technology
- Database
- Programming Language

---

# 3. Design Principles

The taxonomy shall be:

- Business-oriented
- Technology independent
- Extensible
- Hierarchical
- Vendor neutral
- Globally applicable

---

# 4. Financial Market Hierarchy

```text
Financial Market
│
├── Capital Market
│   ├── Equity Market
│   ├── Bond Market
│   ├── ETF Market
│   ├── REIT Market
│   └── Preferred Shares
│
├── Money Market
│
├── Derivatives Market
│   ├── Futures
│   ├── Options
│   ├── Swaps
│   └── Forwards
│
├── Foreign Exchange Market (Forex)
│
├── Cryptocurrency Market
│
├── Commodity Market
│   ├── Energy
│   ├── Metals
│   ├── Agriculture
│   └── Livestock
│
├── Fixed Income Market
│
└── Alternative Investments
```

---

# 5. Asset Classification

Financial assets are classified into:

## Equity

Examples

- Common Stock
- Preferred Stock

---

## Fixed Income

Examples

- Government Bond
- Corporate Bond
- Treasury Bill

---

## Derivatives

Examples

- Future
- Option
- Swap
- Forward

---

## Currency

Examples

- Fiat Currency
- Forex Pair

---

## Digital Assets

Examples

- Cryptocurrency
- Stablecoin
- Token

---

## Commodities

Examples

- Gold
- Oil
- Wheat
- Copper

---

## Funds

Examples

- ETF
- Mutual Fund
- Index Fund

---

# 6. Trading Venues

Trading venues include:

- Stock Exchange
- Commodity Exchange
- Futures Exchange
- Forex ECN
- Cryptocurrency Exchange
- OTC Market
- Dark Pool

---

# 7. Market Participants

Typical participants include:

- Retail Investor
- Institutional Investor
- Broker
- Dealer
- Market Maker
- Custodian
- Clearing House
- Exchange
- Regulator
- Data Vendor

---

# 8. Financial Instruments

Examples include:

- Stock
- Bond
- ETF
- Future
- Option
- Currency Pair
- Cryptocurrency
- Commodity Contract
- Index
- CFD

---

# 9. Market Data

Typical market data includes:

- Trade
- Quote
- Bid
- Ask
- OHLC Candle
- Volume
- Open Interest
- Corporate Actions
- Market Depth
- Order Book

---

# 10. Trading Calendar

Every market shall define:

- Time Zone
- Trading Days
- Holidays
- Trading Sessions
- Early Close
- Emergency Closure

Trading calendars are market-specific.

---

# 11. Market Sessions

Typical sessions:

- Pre-Market
- Opening Auction
- Continuous Trading
- Closing Auction
- After Hours

A market may implement one or more sessions.

---

# 12. Data Providers

Examples:

- Official Exchange
- Broker
- Market Data Vendor
- Public API
- Commercial API

A provider may supply one or multiple markets.

---

# 13. Geographic Scope

Phoenix shall support:

- National Markets
- Regional Markets
- International Markets

No assumptions shall be made regarding country-specific rules.

---

# 14. Specialization

Country-specific regulations, calendars, settlement rules and trading restrictions shall be documented separately.

Examples:

- Iran Capital Market
- New York Stock Exchange
- London Stock Exchange
- Tokyo Stock Exchange

These are specializations of the canonical taxonomy.

---

# 15. Relationship with Other Knowledge

This taxonomy is the parent document for:

- AssetClassification.md
- InstrumentClassification.md
- TradingCalendarStandard.md
- MarketSessionStandard.md
- DataProviderTaxonomy.md
- CorporateActionTaxonomy.md
- FinancialGlossary.md

---

# 16. Related Architecture

This document supports:

- Reference Domain
- Market Domain
- Analytics Services
- AI Services
- Portfolio Services
- Risk Services

---

# 17. Governance

The taxonomy shall remain technology independent.

Changes require Architecture Review.

New market types shall preserve backward compatibility whenever possible.

---

# 18. Repository Compliance

This document is the authoritative classification of financial markets for the Phoenix Platform.

All architecture, design and implementation artifacts shall conform to this taxonomy.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-08 | Initial Financial Market Taxonomy. |