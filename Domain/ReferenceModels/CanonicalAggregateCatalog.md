# Canonical Aggregate Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-008 |
| Document | CanonicalAggregateCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Domain Architecture |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical aggregates and aggregate roots of the Phoenix Platform.

Aggregates establish transactional consistency boundaries and define ownership of business entities within the domain model.

This catalog serves as the authoritative reference for logical data modeling, service boundaries, and future microservice decomposition.

---

# 2. Design Principles

The aggregate model follows the principles of Domain-Driven Design (DDD):

- Every aggregate has exactly one Aggregate Root.
- External references shall target only Aggregate Roots.
- Internal entities are accessed through their Aggregate Root.
- Business invariants shall be enforced within aggregate boundaries.
- Aggregates should remain cohesive and transactionally consistent.

---

# 3. Aggregate Catalog

| Aggregate | Aggregate Root | Domain |
|------------|----------------|--------|
| Reference Data | Market | Reference |
| Instrument Catalog | Instrument | Market |
| Market Data | Market Data | Market |
| Portfolio | Portfolio | Portfolio |
| Analytics | Strategy | Analytics |
| Machine Learning | Model | Machine Learning |
| Configuration | Configuration | Configuration |

---

# 4. Reference Data Aggregate

## Aggregate Root

Market

### Member Entities

- Exchange
- Country
- Currency
- Time Zone
- Language

Business Responsibility

Provides stable reference information shared across the platform.

---

# 5. Instrument Catalog Aggregate

## Aggregate Root

Instrument

### Member Entities

- Symbol
- Listing

Business Responsibility

Represents tradable financial assets and their listings on one or more exchanges.

---

# 6. Market Data Aggregate

## Aggregate Root

Market Data

### Member Entities

- Daily Market Data
- Intraday Market Data (Future)
- Tick Data (Future)
- Order Book Snapshot (Future)

Business Responsibility

Represents historical and real-time market observations associated with financial instruments.

---

# 7. Portfolio Aggregate

## Aggregate Root

Portfolio

### Member Entities

- Position
- Transaction (Future)
- Cash Balance (Future)

Business Responsibility

Represents investment holdings and portfolio composition.

---

# 8. Analytics Aggregate

## Aggregate Root

Strategy

### Member Entities

- Indicator
- Feature
- Signal
- Ranking

Business Responsibility

Transforms market data into investment opportunities using quantitative analysis.

---

# 9. Machine Learning Aggregate

## Aggregate Root

Model

### Member Entities

- Training Dataset
- Validation Dataset
- Prediction
- Model Version (Future)

Business Responsibility

Manages predictive models and generated forecasts.

---

# 10. Configuration Aggregate

## Aggregate Root

Configuration

### Member Entities

- Parameter
- Environment Setting
- Feature Flag

Business Responsibility

Stores configurable platform behavior independent of business data.

---

# 11. Aggregate Ownership Rules

The following rules apply to all aggregates.

- Every entity belongs to exactly one aggregate.
- Aggregate Roots own the lifecycle of their member entities.
- Cross-aggregate updates should be coordinated through services.
- Aggregate boundaries define transactional consistency.

---

# 12. Relationship to Services

Each aggregate is primarily managed by one business service.

| Aggregate | Primary Service |
|------------|-----------------|
| Reference Data | Reference Service |
| Instrument Catalog | Market Service |
| Market Data | Market Data Service |
| Portfolio | Portfolio Service |
| Analytics | Analytics Service |
| Machine Learning | Machine Learning Service |
| Configuration | Configuration Service |

---

# 13. Future Extensions

The aggregate model is designed to support future capabilities including:

- Multi-market support
- Multi-provider integration
- Event-driven architecture
- CQRS
- Distributed services
- Independent service deployment

---

# 14. Related Documents

- CanonicalDomainModel.md
- EntityDictionary.md
- RelationshipDictionary.md
- AggregateDefinitions.md
- ServiceContextMap.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Canonical Aggregate Catalog. |