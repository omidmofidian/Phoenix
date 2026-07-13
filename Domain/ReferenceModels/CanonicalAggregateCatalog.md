# Canonical Aggregate Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-006 |
| Document | CanonicalAggregateCatalog |
| Version | 2.0 |
| Status | Approved |
| Classification | Domain Architecture |
| Owner | Architecture Team |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical Aggregate structure of the Phoenix Platform based on Domain-Driven Design (DDD).

It establishes aggregate boundaries, ownership, lifecycle, business invariants, and relationships between aggregates.

This document is the authoritative reference for all logical and physical data models.

---

# 2. Aggregate Design Principles

Every aggregate shall satisfy the following principles:

- Single Aggregate Root
- Explicit ownership
- High cohesion
- Low coupling
- Transaction consistency within the aggregate
- References across aggregates by identifier only
- Technology-independent design

---

# 3. Domain Organization

The platform is organized into business domains.

Each domain contains one or more subdomains.

Each subdomain contains one or more aggregates.

```text
Domain
    └── Subdomain
            └── Aggregate
                    └── Entity
```

---

# 4. Reference Domain

## 4.1 Master Reference Subdomain

### Geography Aggregate

**Purpose**

Represents geographical hierarchy used throughout the platform.

**Aggregate Root**

Country

**Child Entities**

- Region
- City

**Business Invariants**

- A Region belongs to exactly one Country.
- A City belongs to exactly one Region.
- Country Code is unique.
- Geographic hierarchy cannot contain cycles.

**Lifecycle**

Stable

---

### Time Aggregate

**Aggregate Root**

TimeZone

**Business Invariants**

- TimeZone identifiers follow the IANA standard.
- TimeZone definitions are immutable except for metadata.

---

### Localization Aggregate

**Aggregate Root**

Language

**Child Entities**

- Locale

**Business Invariants**

- Locale references exactly one Language.
- Language codes follow ISO 639-1.

---

### Currency Aggregate

**Aggregate Root**

Currency

**Child Entities**

- CurrencyPair

**Business Invariants**

- Currency codes follow ISO 4217.
- CurrencyPair references two valid currencies.
- Duplicate currency pairs are prohibited.

---

### Market Aggregate

**Aggregate Root**

Market

**Child Entities**

- Exchange
- TradingCalendar
- TradingSession

**Business Invariants**

- Exchange belongs to one Market.
- TradingCalendar belongs to one Exchange.
- TradingSession belongs to one TradingCalendar.
- Sessions within a calendar shall not overlap.

---

### Provider Aggregate

**Aggregate Root**

DataProvider

**Child Entities**

- DataSource

**Business Invariants**

- DataSource belongs to exactly one DataProvider.
- Provider names are unique.

---

### Holiday Aggregate

**Aggregate Root**

HolidayCalendar

**Business Invariants**

- Holidays shall not overlap for the same calendar.
- Holiday dates are unique within a calendar.

---

## 4.2 Classification Subdomain

### AssetClass Aggregate

**Aggregate Root**

AssetClass

**Purpose**

Defines high-level financial asset categories.

---

### InstrumentType Aggregate

**Aggregate Root**

InstrumentType

**Purpose**

Defines tradable instrument classifications.

---

### Sector Aggregate

**Aggregate Root**

Sector

**Purpose**

Defines business sectors.

---

### Industry Aggregate

**Aggregate Root**

Industry

**Purpose**

Defines industries within sectors.

---

# 5. Aggregate Ownership

| Aggregate | Owner |
|-----------|-------|
| Geography | Reference Domain |
| Time | Reference Domain |
| Localization | Reference Domain |
| Currency | Reference Domain |
| Market | Reference Domain |
| Provider | Integration Domain (business ownership delegated by Reference Domain) |
| Holiday | Reference Domain |
| AssetClass | Reference Domain |
| InstrumentType | Reference Domain |
| Sector | Reference Domain |
| Industry | Reference Domain |

---

# 6. Aggregate Dependency Rules

The following rules apply:

- Aggregates communicate through identifiers.
- Aggregates shall not directly modify each other's state.
- Cross-aggregate transactions are prohibited.
- Aggregate Roots enforce all business invariants.
- Child entities cannot exist independently of their Aggregate Root.

---

# 7. Cross-Aggregate References

| From | To | Relationship |
|------|----|--------------|
| Market | Currency | Uses settlement currency |
| Exchange | TimeZone | Uses local time |
| Exchange | HolidayCalendar | Uses holiday schedule |
| TradingCalendar | HolidayCalendar | References holidays |
| Locale | Country | Default regional settings |
| CurrencyPair | Currency | Base and quote currencies |

---

# 8. Aggregate Dependency Matrix

| Aggregate | Depends On |
|-----------|------------|
| Geography | None |
| Time | None |
| Localization | Geography |
| Currency | None |
| Market | Time, Currency, Holiday |
| Provider | None |
| Holiday | Geography |
| AssetClass | None |
| InstrumentType | AssetClass |
| Sector | None |
| Industry | Sector |

---

# 9. General Business Invariants

The following rules apply platform-wide:

- Every aggregate has exactly one Aggregate Root.
- Aggregate Roots own the lifecycle of child entities.
- Cross-domain ownership is prohibited.
- Business identifiers are immutable.
- Canonical identifiers are immutable.
- External identifiers are managed by the Integration Domain.
- Aggregate boundaries shall not overlap.

---

# 10. Traceability

This document is referenced by:

- CanonicalDomainModel.md
- CanonicalBusinessRules.md
- ReferenceDomainArchitecture.md
- ReferenceDomainLogicalModel.md
- EnterpriseIdentityStandard.md
- ServiceContextMap.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-04 | Initial aggregate catalog. |
| 2.0 | 2026-07-07 | Refactored according to DDD aggregate boundaries and subdomain architecture. |