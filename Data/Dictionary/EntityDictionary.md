# Entity Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-002 |
| Document | EntityDictionary |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Enterprise Data Dictionary |
| Task | T3-007 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical business entities of the Phoenix Platform.

Each entity represents a distinct business concept and serves as the authoritative reference for logical data modeling, service design, and database implementation.

The Entity Dictionary provides a technology-independent description of business entities and their responsibilities.

---

# 2. Scope

This document applies to all business entities across the approved domains of the Phoenix Platform.

Every logical entity shall be documented before physical database implementation.

---

# 3. Entity Definition Template

Each entity shall include the following information.

| Property | Description |
|----------|-------------|
| Entity Name | Canonical business name |
| Domain | Owning business domain |
| Aggregate | Aggregate Root |
| Description | Business purpose |
| Lifecycle | Business lifecycle |
| Related Business Rules | References to Canonical Business Rules |
| Related Services | Responsible services |
| Status | Draft / Approved / Deprecated |

---

# 4. Reference Domain

## Country

| Property | Value |
|----------|-------|
| Domain | Reference |
| Aggregate | Reference Data |
| Description | Represents a sovereign country used by the platform. |
| Lifecycle | Stable |
| Related Services | Reference Service |
| Status | Approved |

---

## Currency

| Property | Value |
|----------|-------|
| Domain | Reference |
| Aggregate | Reference Data |
| Description | Represents a monetary unit used in trading and reporting. |
| Lifecycle | Stable |
| Related Services | Reference Service |
| Status | Approved |

---

## Exchange

| Property | Value |
|----------|-------|
| Domain | Reference |
| Aggregate | Market Reference |
| Description | Represents a financial exchange. |
| Lifecycle | Stable |
| Related Services | Market Service |
| Status | Approved |

---

## Market

| Property | Value |
|----------|-------|
| Domain | Reference |
| Aggregate | Market Reference |
| Description | Represents a financial market. |
| Lifecycle | Stable |
| Related Services | Market Service |
| Status | Approved |

---

# 5. Market Domain

## Instrument

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | Tradable financial asset. |
| Lifecycle | Active |
| Related Services | Market Data Service |
| Status | Approved |

---

## Symbol

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | Exchange-specific identifier of an instrument. |
| Lifecycle | Active |
| Related Services | Market Data Service |
| Status | Approved |

---

## Listing

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | Associates an instrument with an exchange. |
| Lifecycle | Active |
| Related Services | Market Data Service |
| Status | Approved |

---

## Trading Session

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | Defines market trading hours. |
| Lifecycle | Active |
| Related Services | Market Data Service |
| Status | Approved |

---

## Market Data

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | Root entity representing all collected market data. |
| Lifecycle | Continuous |
| Related Services | Market Data Service |
| Status | Approved |

---

## Daily Market Data

| Property | Value |
|----------|-------|
| Domain | Market |
| Aggregate | Market Data |
| Description | End-of-day OHLCV data for a listed instrument. |
| Lifecycle | Immutable |
| Related Services | Market Data Service |
| Status | Approved |

---

# 6. Portfolio Domain

## Portfolio

| Property | Value |
|----------|-------|
| Domain | Portfolio |
| Aggregate | Portfolio |
| Description | Collection of investment positions. |
| Lifecycle | Active |
| Related Services | Portfolio Service |
| Status | Approved |

---

## Position

| Property | Value |
|----------|-------|
| Domain | Portfolio |
| Aggregate | Portfolio |
| Description | Holding of a financial instrument. |
| Lifecycle | Active |
| Related Services | Portfolio Service |
| Status | Approved |

---

# 7. Analytics Domain

## Feature

| Property | Value |
|----------|-------|
| Domain | Analytics |
| Aggregate | Analytics |
| Description | Derived variable used for quantitative analysis. |
| Lifecycle | Versioned |
| Related Services | Feature Engineering Service |
| Status | Approved |

---

## Indicator

| Property | Value |
|----------|-------|
| Domain | Analytics |
| Aggregate | Analytics |
| Description | Technical indicator calculated from market data. |
| Lifecycle | Versioned |
| Related Services | Indicator Service |
| Status | Approved |

---

## Strategy

| Property | Value |
|----------|-------|
| Domain | Analytics |
| Aggregate | Analytics |
| Description | Collection of business rules used to generate trading signals. |
| Lifecycle | Versioned |
| Related Services | Strategy Service |
| Status | Approved |

---

## Signal

| Property | Value |
|----------|-------|
| Domain | Analytics |
| Aggregate | Analytics |
| Description | Recommendation generated from one or more strategies. |
| Lifecycle | Ephemeral |
| Related Services | Signal Service |
| Status | Approved |

---

# 8. Machine Learning Domain

## Model

| Property | Value |
|----------|-------|
| Domain | Machine Learning |
| Aggregate | ML |
| Description | Trained predictive model. |
| Lifecycle | Versioned |
| Related Services | Machine Learning Service |
| Status | Approved |

---

## Prediction

| Property | Value |
|----------|-------|
| Domain | Machine Learning |
| Aggregate | ML |
| Description | Prediction generated by a trained model. |
| Lifecycle | Immutable |
| Related Services | Machine Learning Service |
| Status | Approved |

---

# 9. Governance

All entities documented herein are canonical business entities.

Any modification requires:

- Architecture review
- Impact analysis
- Approval through the Architecture Governance process

---

# 10. Related Documents

- BusinessGlossary.md
- AttributeDictionary.md
- RelationshipDictionary.md
- CanonicalDomainModel.md
- AggregateDefinitions.md
- CanonicalBusinessRules.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Entity Dictionary. |