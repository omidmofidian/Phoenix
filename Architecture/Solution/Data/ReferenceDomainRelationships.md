# Reference Relationships

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-003 |
| Document | ReferenceRelationships |
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

This document defines the logical relationships between entities within the Reference Domain.

The relationships described here represent business semantics only and are independent of any database technology or implementation.

---

# 2. Relationship Principles

All relationships shall comply with the following principles:

- Business-oriented
- Technology independent
- Aggregate boundaries respected
- Ownership clearly defined
- Cardinality explicitly specified
- Business meaning documented

---

# 3. Relationship Catalog

## 3.1 Geography Aggregate

### Country → Region

| Property | Value |
|----------|-------|
| Parent Entity | Country |
| Child Entity | Region |
| Cardinality | One-to-Many (1:N) |
| Ownership | Country |
| Mandatory | Yes |
| Aggregate | Geography |

**Business Rule**

Every Region belongs to exactly one Country.

---

### Region → City

| Property | Value |
|----------|-------|
| Parent Entity | Region |
| Child Entity | City |
| Cardinality | One-to-Many (1:N) |
| Ownership | Region |
| Mandatory | Yes |
| Aggregate | Geography |

**Business Rule**

Every City belongs to exactly one Region.

---

## 3.2 Localization Aggregate

### Language → Locale

| Property | Value |
|----------|-------|
| Parent Entity | Language |
| Child Entity | Locale |
| Cardinality | One-to-Many (1:N) |
| Ownership | Language |
| Mandatory | Yes |
| Aggregate | Localization |

**Business Rule**

Every Locale is defined for exactly one Language.

---

## 3.3 Currency Aggregate

### Currency → CurrencyPair (Base)

| Property | Value |
|----------|-------|
| Parent Entity | Currency |
| Child Entity | CurrencyPair |
| Role | Base Currency |
| Cardinality | One-to-Many (1:N) |
| Aggregate | Currency |

---

### Currency → CurrencyPair (Quote)

| Property | Value |
|----------|-------|
| Parent Entity | Currency |
| Child Entity | CurrencyPair |
| Role | Quote Currency |
| Cardinality | One-to-Many (1:N) |
| Aggregate | Currency |

**Business Rule**

A CurrencyPair consists of exactly two distinct currencies.

---

## 3.4 Market Aggregate

### Market → Exchange

| Property | Value |
|----------|-------|
| Parent Entity | Market |
| Child Entity | Exchange |
| Cardinality | One-to-Many (1:N) |
| Ownership | Market |
| Mandatory | Yes |

---

### Exchange → TradingCalendar

| Property | Value |
|----------|-------|
| Parent Entity | Exchange |
| Child Entity | TradingCalendar |
| Cardinality | One-to-Many (1:N) |
| Ownership | Exchange |

---

### TradingCalendar → TradingSession

| Property | Value |
|----------|-------|
| Parent Entity | TradingCalendar |
| Child Entity | TradingSession |
| Cardinality | One-to-Many (1:N) |
| Ownership | TradingCalendar |

---

## 3.5 Provider Aggregate

### DataProvider → DataSource

| Property | Value |
|----------|-------|
| Parent Entity | DataProvider |
| Child Entity | DataSource |
| Cardinality | One-to-Many (1:N) |
| Ownership | DataProvider |

---

# 4. Cross-Aggregate Relationships

Cross-Aggregate relationships shall be reference-only.

---

## Exchange → TimeZone

| Property | Value |
|----------|-------|
| Source Aggregate | Market |
| Target Aggregate | Time |
| Cardinality | Many-to-One (N:1) |
| Relationship Type | Reference |

**Business Meaning**

Each Exchange operates within one TimeZone.

---

## Exchange → HolidayCalendar

| Property | Value |
|----------|-------|
| Source Aggregate | Market |
| Target Aggregate | Holiday |
| Cardinality | Many-to-One (N:1) |
| Relationship Type | Reference |

---

## TradingCalendar → HolidayCalendar

| Property | Value |
|----------|-------|
| Source Aggregate | Market |
| Target Aggregate | Holiday |
| Cardinality | Many-to-One (N:1) |
| Relationship Type | Reference |

---

## Locale → Country

| Property | Value |
|----------|-------|
| Source Aggregate | Localization |
| Target Aggregate | Geography |
| Cardinality | Many-to-One (N:1) |
| Relationship Type | Reference |

---

## CurrencyPair → Currency

| Property | Value |
|----------|-------|
| Relationship | Base Currency |
| Cardinality | N:1 |

---

## CurrencyPair → Currency

| Property | Value |
|----------|-------|
| Relationship | Quote Currency |
| Cardinality | N:1 |

---

## Market → Currency

| Property | Value |
|----------|-------|
| Relationship | Settlement Currency |
| Cardinality | N:1 |

---

# 5. Relationship Matrix

| Source | Target | Type |
|---------|---------|------|
| Country | Region | Composition |
| Region | City | Composition |
| Language | Locale | Composition |
| Currency | CurrencyPair | Composition |
| Market | Exchange | Composition |
| Exchange | TradingCalendar | Composition |
| TradingCalendar | TradingSession | Composition |
| DataProvider | DataSource | Composition |
| Exchange | TimeZone | Reference |
| Exchange | HolidayCalendar | Reference |
| TradingCalendar | HolidayCalendar | Reference |
| Locale | Country | Reference |
| Market | Currency | Reference |

---

# 6. Relationship Constraints

The following constraints apply:

- Cross-Aggregate ownership is prohibited.
- Composition relationships exist only within the same Aggregate.
- Reference relationships shall not transfer ownership.
- Circular relationships are prohibited.
- Self-referencing entities require explicit architectural approval.

---

# 7. Aggregate Consistency Rules

- Aggregate Roots own all child entities.
- Child entities cannot exist without their Aggregate Root.
- Cross-Aggregate relationships are read-only from a business perspective.
- Aggregate boundaries shall never be violated.

---

# 8. Validation Rules

Every relationship shall satisfy:

- Defined business meaning
- Defined cardinality
- Defined ownership
- Aggregate boundary respected
- No duplicated relationships
- Traceability to Business Rules

---

# 9. Traceability

This document is derived from:

- ReferenceDomainArchitecture.md
- ReferenceDomainLogicalModel.md
- ReferenceEntityDefinitions.md
- CanonicalAggregateCatalog.md
- AggregateDesignGuidelines.md
- CanonicalBusinessRules.md

---

# 10. Related Documents

- ReferenceLogicalERD.md
- ReferenceValidation.md
- EntityDictionary.md
- RelationshipDictionary.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial logical relationship model for the Reference Domain. |