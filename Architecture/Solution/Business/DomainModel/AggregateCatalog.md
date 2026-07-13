# Aggregate Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-006 |
| Document | AggregateCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Domain Model |
| Owner | Architecture Team |
| Depends On | CanonicalDomainModel, AggregateDefinitions, DomainBoundaryAnalysis |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical Aggregate Catalog for the Phoenix Platform.

An Aggregate represents a business consistency boundary that groups one Aggregate Root with its associated Member Entities and Value Objects.

This catalog establishes the official Aggregate boundaries used throughout the enterprise domain model.

---

# 2. Scope

This document defines:

- Aggregate boundaries
- Aggregate ownership
- Aggregate Roots
- Member Entities
- Business consistency boundaries
- Lifecycle ownership

This document does not define:

- Physical database tables
- SQL implementation
- APIs
- Services
- Persistence strategy

---

# 3. Aggregate Modeling Principles

The following principles apply to every Aggregate.

## Principle 1

Each Aggregate shall have exactly one Aggregate Root.

---

## Principle 2

Aggregate boundaries are determined by business consistency requirements rather than database relationships.

---

## Principle 3

Member Entities shall not be referenced directly from outside the Aggregate.

---

## Principle 4

Cross-Aggregate communication shall occur only through Aggregate Root identity.

---

## Principle 5

Each Aggregate belongs to exactly one Business Domain.

---

# 4. Aggregate Classification

| Category | Description |
|----------|-------------|
| Reference Aggregate | Stable enterprise reference data |
| Core Aggregate | Core business entities |
| Market Aggregate | Market operational data |
| Integration Aggregate | External system integration |
| Supporting Aggregate | Configuration, Audit and Reporting |

---

# 5. Enterprise Aggregate Catalog

## Reference Domain

---

### Exchange Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Exchange |
| Member Entities | Market, Trading Board |
| Value Objects | None |
| Business Purpose | Defines the official market structure |
| Lifecycle Owner | Reference Domain |
| Referenced By | Core, Market, Integration |

---

### Trading Calendar Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Trading Calendar |
| Member Entities | Holiday, Trading Session |
| Value Objects | None |
| Business Purpose | Defines official trading schedule |
| Lifecycle Owner | Reference Domain |
| Referenced By | Market |

---

### Sector Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Sector |
| Member Entities | Industry |
| Value Objects | None |
| Business Purpose | Defines business classification hierarchy |
| Lifecycle Owner | Reference Domain |
| Referenced By | Core |

---

### Instrument Type Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Instrument Type |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Defines supported financial instrument types |
| Lifecycle Owner | Reference Domain |
| Referenced By | Core |

---

### Country Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Country |
| Member Entities | None |
| Value Objects | Time Zone |
| Business Purpose | Defines geographical reference information |
| Lifecycle Owner | Reference Domain |
| Referenced By | Integration |

---

### Currency Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Currency |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Defines supported currencies |
| Lifecycle Owner | Reference Domain |
| Referenced By | Market, Integration |

---

### External Identifier Type Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | External Identifier Type |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Defines supported external identifier types |
| Lifecycle Owner | Reference Domain |
| Referenced By | Integration |

---

### Data Provider Type Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Data Provider Type |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Defines categories of external providers |
| Lifecycle Owner | Reference Domain |
| Referenced By | Integration |

---

## Core Domain

---

### Company Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Company |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Represents listed companies |
| Lifecycle Owner | Core Domain |
| Referenced By | Market, Integration |

---

### Instrument Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Instrument |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Represents tradable financial instruments |
| Lifecycle Owner | Core Domain |
| Referenced By | Market, Integration |

---

## Market Domain

---

### Instrument Listing Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Instrument Listing |
| Member Entities | Daily Market Data |
| Value Objects | None |
| Business Purpose | Represents market listing and historical trading data |
| Lifecycle Owner | Market Domain |
| Referenced By | Analytics, Backtest |

---

### Corporate Action Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Corporate Action |
| Member Entities | None |
| Value Objects | None |
| Business Purpose | Represents corporate events affecting securities |
| Lifecycle Owner | Market Domain |
| Referenced By | Analytics |

---

## Integration Domain

---

### Data Provider Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Data Provider |
| Member Entities | Provider Mapping, External Identifier |
| Value Objects | None |
| Business Purpose | Represents external market data providers |
| Lifecycle Owner | Integration Domain |
| Referenced By | Market |

---

### Import Session Aggregate

| Property | Value |
|----------|-------|
| Aggregate Root | Import Session |
| Member Entities | Import Batch |
| Value Objects | None |
| Business Purpose | Represents data import execution lifecycle |
| Lifecycle Owner | Integration Domain |
| Referenced By | Operations |

---

## Supporting Domains

### Configuration Aggregate

Aggregate Root:
- Configuration Item

---

### Audit Aggregate

Aggregate Root:
- Audit Event

---

### Reporting Aggregate

Aggregate Root:
- Report Definition

---

# 6. Future Evolution

This catalog shall evolve together with the Enterprise Domain Model.

Any modification to Aggregate boundaries requires an approved Architecture Decision Record (ADR).

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Enterprise Aggregate Catalog |