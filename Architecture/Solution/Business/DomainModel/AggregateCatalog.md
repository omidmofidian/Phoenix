# Aggregate Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-006 |
| Document | AggregateCatalog |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Architecture |
| Owner | Enterprise Architecture |
| Architecture Layer | Domain Model |
| Depends On | CanonicalDomainModel, DomainResponsibilities, EntityClassification |
| Consumed By | AggregateAttributeMatrix, ConceptualDataModel, LogicalDatabaseModel, ServiceContextMap |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical Aggregate Catalog of the Phoenix Platform.

An Aggregate is a business consistency boundary that encapsulates a single Aggregate Root together with the business rules governing its lifecycle and integrity.

The Aggregate Catalog establishes the official Aggregate boundaries of the enterprise domain model and serves as the authoritative reference for domain ownership, lifecycle management, and business consistency.

This document is independent of database implementation, persistence mechanisms, and service implementation.

---

# 2. Objectives

The objectives of this document are to:

- Define enterprise Aggregate boundaries.
- Identify Aggregate Roots.
- Assign Aggregate ownership to business domains.
- Establish business consistency boundaries.
- Support Domain-Driven Design (DDD).
- Prevent overlapping Aggregate responsibilities.
- Provide traceability between business domains and data models.
- Enable long-term architectural evolution.

---

# 3. Aggregate Design Principles

The Phoenix Platform adopts the following Aggregate design principles.

## AGG-001 — Single Aggregate Root

Every Aggregate shall contain exactly one Aggregate Root.

The Aggregate Root represents the only externally accessible entry point into the Aggregate.

---

## AGG-002 — Business Consistency Boundary

Aggregate boundaries shall be determined by business consistency requirements rather than by database relationships or implementation convenience.

---

## AGG-003 — Independent Lifecycle

Every Aggregate shall own its own lifecycle.

No Aggregate may directly control the lifecycle of another Aggregate.

---

## AGG-004 — Reference by Identity

Communication between Aggregates shall occur exclusively through Aggregate Root identities.

Aggregates shall never contain direct object references to other Aggregate internals.

---

## AGG-005 — Single Ownership

Every Aggregate shall belong to exactly one Business Domain.

Ownership responsibilities shall never overlap.

---

## AGG-006 — Technology Independence

Aggregate definitions shall describe business concepts only.

Implementation details, persistence strategies, database schemas, APIs, and service implementations are outside the scope of this document.

---

# 4. Aggregate Classification

Enterprise Aggregates are classified according to their business responsibilities.

| Category | Description |
|----------|-------------|
| Reference Aggregate | Enterprise reference and classification data |
| Core Business Aggregate | Core financial business entities |
| Market Aggregate | Market observations and historical events |
| Analytics Aggregate | Derived analytical knowledge |
| Portfolio Aggregate | Investment ownership and positions |
| Integration Aggregate | External provider interaction and identity mapping |
| Configuration Aggregate | Runtime configuration and platform settings |
| Audit Aggregate | Auditability and operational traceability |
| Reporting Aggregate | Read-only reporting and analytical projections |

---

# 5. Enterprise Aggregate Catalog

This section defines the canonical Aggregates of the Phoenix Platform.

Each Aggregate represents an independent business consistency boundary and belongs to exactly one Business Domain.

---

# 5.1 Reference Domain

The Reference Domain contains Aggregates that provide stable enterprise-wide reference information shared across multiple business domains.

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Exchange | Exchange | Represents securities exchanges. |
| Market | Market | Represents markets operating within an exchange. |
| Board | Board | Represents trading boards within a market. |
| Industry | Industry | Represents enterprise industry classifications. |
| Sector | Sector | Represents business sectors within an industry hierarchy. |
| Trading Calendar | TradingCalendar | Defines official trading days and calendars. |
| Trading Session | TradingSession | Defines trading sessions within a trading day. |
| Currency | Currency | Defines supported monetary units. |
| Country | Country | Defines geopolitical reference information. |
| Language | Language | Defines supported languages. |
| Time Zone | TimeZone | Defines supported time zones. |
| Data Provider Type | DataProviderType | Classifies external data provider categories. |
| External Identifier Type | ExternalIdentifierType | Classifies supported external identifier types. |

---

# 5.2 Core Domain

The Core Domain contains the principal business entities of the Phoenix Platform.

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Company | Company | Represents legal business entities. |
| Financial Instrument | FinancialInstrument | Represents tradable financial instruments. |

---

# 5.3 Market Domain

The Market Domain owns historical market observations and events.

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Instrument Listing | InstrumentListing | Represents the listing of a financial instrument within a trading board. |
| Daily Market Data | DailyMarketData | Represents historical daily market observations. |
| Corporate Action | CorporateAction | Represents corporate events affecting listed instruments. |

---

# 5.4 Analytics Domain

The Analytics Domain contains Aggregates derived from market observations.

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Indicator Definition | IndicatorDefinition | Defines analytical indicators. |
| Indicator Value | IndicatorValue | Stores calculated indicator values. |
| Feature Definition | FeatureDefinition | Defines analytical features. |
| Feature Value | FeatureValue | Stores calculated feature values. |
| Prediction | Prediction | Represents prediction results. |
| Signal | Signal | Represents trading signals generated by analytical models. |

---

# 5.5 Strategy Domain

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Strategy | Strategy | Defines investment decision logic. |
| Strategy Version | StrategyVersion | Maintains versioned strategy definitions. |

---

# 5.6 Portfolio Domain

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Portfolio | Portfolio | Represents an investment portfolio. |
| Position | Position | Represents holdings within a portfolio. |
| Trade | Trade | Represents executed investment transactions. |

---

# 5.7 Integration Domain

| Aggregate | Aggregate Root | Business Responsibility |
|-----------|----------------|--------------------------|
| Data Provider | DataProvider | Represents external market data providers. |
| Import Session | ImportSession | Represents data import execution. |
| External Identifier | ExternalIdentifier | Maintains mappings between internal and external identifiers. |

---

# 6. Aggregate Ownership Rules

The following rules govern Aggregate ownership throughout the Phoenix Platform.

## AGR-001 — Single Domain Ownership

Every Aggregate shall belong to exactly one Business Domain.

Shared ownership is prohibited.

---

## AGR-002 — Single Aggregate Root

Every Aggregate shall expose exactly one Aggregate Root.

External components shall interact only with the Aggregate Root.

---

## AGR-003 — Independent Lifecycle

Each Aggregate shall manage its own lifecycle independently.

The lifecycle of one Aggregate shall never be controlled by another Aggregate.

---

## AGR-004 — Business Integrity

All business invariants shall be enforced within the Aggregate boundary.

Business consistency shall never depend on external Aggregates.

---

## AGR-005 — Identity-Based References

Aggregates shall reference other Aggregates only through their identities.

Direct navigation to another Aggregate's internal objects is prohibited.

---

## AGR-006 — Stable Boundaries

Aggregate boundaries shall remain stable over time.

Changes to Aggregate boundaries require an approved Architecture Decision Record (ADR).

---

# 7. Aggregate Collaboration

Aggregates collaborate while preserving clear ownership boundaries.

The Phoenix Platform adopts the following collaboration model.

| Collaboration Principle | Description |
|--------------------------|-------------|
| Identity References | Aggregates communicate using Aggregate Root identifiers. |
| Published Interfaces | Business capabilities are exposed through published contracts. |
| Independent Validation | Every Aggregate validates its own business rules. |
| Independent Persistence | Persistence responsibilities remain within Aggregate ownership. |
| Independent Evolution | Aggregates may evolve independently provided published contracts remain compatible. |

---

# 8. Aggregate Lifecycle

Each Aggregate progresses through an independent business lifecycle.

Typical lifecycle phases include:

- Creation
- Validation
- Active Business Use
- Business Modification
- Deactivation
- Historical Preservation

Deletion of Aggregate Roots should be avoided.

Historical preservation is preferred whenever business regulations permit.

---

# 9. Traceability

The Aggregate Catalog maintains architectural traceability with the following artifacts.

| Artifact | Relationship |
|----------|--------------|
| BusinessCapabilityMap | Defines business capabilities supported by each Aggregate. |
| CanonicalDomainModel | Defines domain boundaries and Aggregate placement. |
| DomainResponsibilities | Defines business ownership of each Domain. |
| EntityClassification | Classifies entities contained within Aggregates. |
| AggregateAttributeMatrix | Defines the canonical attribute profile of each Aggregate. |
| ConceptualDataModel | Maps Aggregates to conceptual business entities. |
| LogicalDatabaseModel | Transforms Aggregate concepts into logical database structures. |
| ServiceContextMap | Maps Aggregates to service ownership and bounded contexts. |

---

# 10. Success Criteria

The Aggregate Catalog is considered complete when:

- Every Business Domain has clearly defined Aggregates.
- Every Aggregate has exactly one Aggregate Root.
- Aggregate ownership is unambiguous.
- Aggregate boundaries reflect business consistency requirements.
- Cross-Aggregate relationships use identity references only.
- All Aggregates are traceable to the Canonical Domain Model.
- Aggregate definitions remain independent of implementation technology.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-18 | Complete architectural redesign. Replaced implementation-oriented Aggregate descriptions with technology-independent business Aggregate definitions aligned with Domain-Driven Design, the Canonical Domain Model, and enterprise architectural governance. |