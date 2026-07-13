# ADR-015 — Market Classification Model

| Property | Value |
|----------|-------|
| ADR ID | ADR-015 |
| Title | Market Classification Model |
| Status | Accepted |
| Date | 2026-07-11 |
| Decision Makers | Phoenix Architecture Team |
| Category | Domain Architecture |

---

# Context

Phoenix Platform is designed to support multiple financial markets and asset classes.

The platform must not be limited to the Iranian stock market.

Future versions are expected to support:

- Equity Markets
- OTC Markets
- Fixed Income
- Commodities
- ETFs
- Mutual Funds
- Derivatives
- Foreign Exchange
- Cryptocurrency
- International Exchanges

A canonical classification model is therefore required.

Without a standard classification hierarchy, future expansion would require structural database modifications.

---

# Problem

Financial instruments are naturally classified through several independent dimensions.

Examples include:

- Market
- Exchange
- Asset Class
- Instrument Type
- Trading Board
- Industry
- Sector

These classifications are reference data and must remain stable.

---

# Decision

Phoenix adopts a hierarchical market classification model.

Business entities shall reference classification entities instead of storing classification values directly.

Classification entities belong to the Reference Domain.

---

# Classification Hierarchy

```
Market
    └── Exchange
            └── Trading Board
                    └── Instrument
```

Independent classification dimensions:

```
Asset Class
        └── Instrument Type
```

Industry classification:

```
Sector
    └── Industry
            └── Sub Industry
```

---

# Canonical Classification Entities

The following reference entities shall exist.

## Market

Represents a financial market.

Examples:

- Iran Capital Market
- Forex
- Crypto
- US Market

---

## Exchange

Represents a trading exchange.

Examples:

- Tehran Stock Exchange
- Iran Fara Bourse
- CME
- NASDAQ

---

## Trading Board

Represents an exchange trading board.

Examples:

- Main Market
- Secondary Market
- SME Board

---

## Asset Class

Examples:

- Equity
- Fixed Income
- ETF
- Commodity
- Currency
- Crypto
- Derivative

---

## Instrument Type

Examples:

- Common Stock
- Preferred Stock
- Bond
- Sukuk
- ETF
- Future
- Option
- Mutual Fund

---

## Sector

High-level economic classification.

Examples:

- Financial
- Energy
- Technology

---

## Industry

Business industry.

Examples:

- Banking
- Insurance
- Petrochemical

---

## Sub Industry

Lowest classification level.

---

# Business Rules

- Every Instrument belongs to exactly one Market.
- Every Instrument belongs to exactly one Exchange.
- Every Instrument belongs to exactly one Asset Class.
- Every Instrument belongs to exactly one Instrument Type.
- Every Instrument belongs to exactly one Industry.
- Sector contains multiple Industries.
- Industry contains multiple Sub Industries.
- Market classifications are reference data.
- Classification entities are immutable from business transactions.

---

# Consequences

Advantages

- Supports future markets.
- Eliminates duplicated classifications.
- Simplifies reporting.
- Enables consistent filtering.
- Supports multilingual names.
- Supports external provider mappings.

Trade-offs

- Additional reference tables.
- More joins in analytical queries.
- Initial modeling effort increases.

---

# Impact

Affected Documents

- CanonicalDomainModel.md
- EntityCatalog.md
- CanonicalBusinessRules.md
- CanonicalEntityRelationships.md
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

Affected Domains

- Reference
- Market
- Trading
- Reporting

---

# Alternatives Considered

## Alternative A

Store classification values directly in Instrument.

Rejected.

Reason:

Violates normalization and prevents extensibility.

---

## Alternative B

Use lookup tables without hierarchy.

Rejected.

Reason:

Cannot represent real-world market structures.

---

## Alternative C

Hierarchical reference model.

Accepted.

Reason:

Provides scalability, normalization and long-term maintainability.

---

# Related ADRs

- ADR-018 — Database Initialization Strategy
- ADR-020 — Database Bootstrap and Security Architecture
- ADR-021 — Canonical Domain Model and Schema Allocation

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-11 | Initial version |