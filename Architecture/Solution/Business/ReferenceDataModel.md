# Reference Data Model

| Property | Value |
|----------|-------|
| Document ID | ReferenceDataModel |
| Version | 1.0 |
| Status | Approved |
| Classification | Enterprise Business Architecture |
| Owner | Enterprise Architecture |
| Repository | Phoenix Platform |
| Last Updated | 2026-07-11 |

---

# 1. Purpose

This document defines the Canonical Reference Data Model of the Phoenix Platform.

Reference Data represents stable enterprise-wide business concepts that are shared across multiple domains and services.

The purpose of this model is to ensure consistency, normalization, extensibility, and long-term maintainability throughout the platform.

---

# 2. Scope

This document applies to all reference entities used by the Phoenix Platform.

Reference Data shall be shared across:

- Business Domains
- Services
- Databases
- APIs
- Reporting
- Analytics
- Artificial Intelligence

Reference Data is considered canonical enterprise data.

---

# 3. Guiding Principles

The Reference Data Model follows these principles:

- Single Source of Truth
- Enterprise-wide Reuse
- Stable Business Semantics
- Normalized Relationships
- Technology Independence
- Extensibility
- Immutable Business Meaning

Reference entities shall be managed independently from business transactions.

---

# 4. Reference Domain

The Reference Domain contains business entities that describe classifications, taxonomies, and reusable business concepts.

Reference entities are shared across the entire platform.

---

# 5. Canonical Reference Entities

## Market

Represents a financial market.

Examples:

- Iran Capital Market
- Forex
- Cryptocurrency
- US Capital Market

---

## Exchange

Represents a trading exchange.

Examples:

- Tehran Stock Exchange
- Iran Fara Bourse
- NASDAQ
- NYSE
- CME

Relationship

Market
1 ────────∞ Exchange

---

## Trading Board

Represents an exchange trading board.

Examples:

- Main Market
- Secondary Market
- SME Market

Relationship

Exchange
1 ────────∞ Trading Board

---

## Asset Class

Represents the high-level financial asset category.

Examples:

- Equity
- ETF
- Commodity
- Fixed Income
- Currency
- Crypto
- Derivative

---

## Instrument Type

Represents the financial instrument type.

Examples:

- Common Stock
- Preferred Stock
- Bond
- Sukuk
- ETF
- Future
- Option
- Mutual Fund

Relationship

Asset Class
1 ────────∞ Instrument Type

---

## Sector

Represents the highest economic classification.

Examples:

- Financial
- Energy
- Technology

---

## Industry

Represents a business industry.

Examples:

- Banking
- Insurance
- Petrochemical

Relationship

Sector
1 ────────∞ Industry

---

## Sub Industry

Represents the lowest industry classification.

Relationship

Industry
1 ────────∞ Sub Industry

---

# 6. Business Entity Relationships

Business entities reference the Reference Domain.

Example:

Instrument

├── MarketId

├── ExchangeId

├── TradingBoardId

├── AssetClassId

├── InstrumentTypeId

├── IndustryId

└── SubIndustryId

Reference entities never reference business entities.

---

# 7. Business Rules

The following rules apply.

- Every Instrument belongs to exactly one Market.
- Every Instrument belongs to exactly one Exchange.
- Every Instrument belongs to exactly one Asset Class.
- Every Instrument belongs to exactly one Instrument Type.
- Every Instrument belongs to exactly one Industry.
- Sector contains multiple Industries.
- Industry contains multiple Sub Industries.
- Classification entities are enterprise reference data.
- Reference data shall never be duplicated inside business entities.
- Business transactions shall never modify reference definitions.

---

# 8. Lifecycle

Reference data changes infrequently.

Typical lifecycle events include:

- Creation of new markets
- Creation of new exchanges
- Industry taxonomy updates
- Regulatory changes

Reference data changes shall be governed through controlled administrative processes.

---

# 9. Integration

Reference data supports:

- Market Data Service
- Trading Service
- Analytics Service
- Reporting Service
- AI Service
- Integration Service

---

# 10. Related Artifacts

- ADR-015 — Market Classification Model
- CanonicalDomainModel.md
- EntityCatalog.md
- AggregateCatalog.md
- EnterpriseDataDictionary.md
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# 11. Future Extensions

The Reference Data Model is intentionally extensible.

Future versions may introduce additional reference entities, including:

- Currency
- Country
- Language
- Time Zone
- Trading Session
- Settlement Type
- Market Segment
- Regulatory Authority
- Holiday Calendar
- Corporate Action Type

Such additions shall not require changes to existing business entities.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial release |