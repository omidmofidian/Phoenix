# Reference Entity Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-002 |
| Document | ReferenceEntityDefinitions |
| Version | 2026.1 |
| Status | Draft |
| Classification | Logical Data Model |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Epic 3 — Logical Data Modeling |
| Task | T3-010 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical logical entities belonging to the Reference Domain.

It establishes the business identity, ownership, lifecycle, and architectural characteristics of each entity.

This document is technology-independent.

---

# 2. Entity Definition Standard

Every logical entity shall include the following metadata:

- Entity Name
- Aggregate
- Aggregate Root
- Business Identifier
- Lifecycle
- Ownership
- Shared Across Domains
- Mutable
- Description

---

# 3. Geographic Aggregate

## Country

| Property | Value |
|----------|-------|
| Entity Name | Country |
| Aggregate | Geographic |
| Aggregate Root | Yes |
| Business Identifier | ISO 3166-1 Alpha-2 |
| Lifecycle | Active / Inactive |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | No (except metadata) |
| Description | Canonical definition of a country. |

---

## Region

| Property | Value |
|----------|-------|
| Entity Name | Region |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | Region Code |
| Lifecycle | Active / Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Administrative or geographical subdivision of a country. |

---

## City

| Property | Value |
|----------|-------|
| Entity Name | City |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | City Code |
| Lifecycle | Active / Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | City or municipality belonging to a region or country. |

---

## TimeZone

| Property | Value |
|----------|-------|
| Entity Name | TimeZone |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | IANA Time Zone ID |
| Lifecycle | Active |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Canonical time zone definition. |

---

# 4. Localization Aggregate

## Language

| Property | Value |
|----------|-------|
| Entity Name | Language |
| Aggregate | Localization |
| Aggregate Root | Yes |
| Business Identifier | ISO 639-1 |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Supported language definition. |

---

## Locale

| Property | Value |
|----------|-------|
| Entity Name | Locale |
| Aggregate | Localization |
| Aggregate Root | No |
| Business Identifier | Language-Country Code |
| Lifecycle | Active |
| Ownership | Localization Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Locale used for formatting and localization. |

---

# 5. Financial Aggregate

## Currency

| Property | Value |
|----------|-------|
| Entity Name | Currency |
| Aggregate | Financial |
| Aggregate Root | Yes |
| Business Identifier | ISO 4217 |
| Lifecycle | Active / Inactive |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Official monetary currency. |

---

## CurrencyPair

| Property | Value |
|----------|-------|
| Entity Name | CurrencyPair |
| Aggregate | Financial |
| Aggregate Root | No |
| Business Identifier | Base-Quote Pair |
| Lifecycle | Active |
| Ownership | Financial Aggregate |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Tradable currency pair used in FX markets. |

---

# 6. Market Aggregate

## Market

| Property | Value |
|----------|-------|
| Entity Name | Market |
| Aggregate | Market |
| Aggregate Root | Yes |
| Business Identifier | Market Code |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Financial market definition (e.g., Tehran Stock Exchange, Forex, Crypto). |

---

## Exchange

| Property | Value |
|----------|-------|
| Entity Name | Exchange |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Exchange Code (MIC where applicable) |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Trading exchange within a market. |

---

## TradingCalendar

| Property | Value |
|----------|-------|
| Entity Name | TradingCalendar |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Calendar Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Defines trading days and exceptions. |

---

## TradingSession

| Property | Value |
|----------|-------|
| Entity Name | TradingSession |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Session Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Defines trading sessions within a calendar. |

---

# 7. Classification Aggregate

## AssetClass

Canonical classification of financial assets.

## InstrumentType

Canonical classification of tradable instruments.

## Sector

Business sector classification.

## Industry

Industry classification.

> These entities follow the same metadata structure defined above.

---

# 8. Provider Aggregate

## DataProvider

Canonical external provider.

---

## DataSource

Specific source supplied by a provider.

---

# 9. Calendar Aggregate

## HolidayCalendar

Business calendar defining public and market holidays.

---

# 10. Entity Governance Rules

The following rules apply to every entity:

- Each entity belongs to exactly one aggregate.
- Every aggregate has one Aggregate Root.
- Business identifiers are immutable.
- Technical identifiers are defined separately.
- Entities are independent of database implementation.
- Entity definitions are the authoritative source for logical modeling.

---

# 11. Related Documents

- ReferenceDomainArchitecture.md
- ReferenceDomainLogicalModel.md
- ReferenceRelationships.md
- ReferenceLogicalERD.md
- BusinessGlossary.md
- EntityDictionary.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Reference Entity Definitions. |