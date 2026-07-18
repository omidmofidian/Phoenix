# SDS-2026.2

# Canonical Domain Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Document | CanonicalDomainModel |
| Document ID | SDS-CDM-001 |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Architecture |
| Owner | Enterprise Architecture |
| Depends On | PlatformArchitectureVision, ArchitecturalPrinciples, BoundedContextDefinition |
| Consumed By | AggregateCatalog, AggregateDefinitions, ServiceContextMap, ConceptualDataModel, LogicalDataModel, PhysicalDatabaseModel |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

The Canonical Domain Model defines the stable business architecture of the Phoenix Platform.

It identifies the enterprise business domains, their responsibilities, ownership boundaries, and business relationships independently of implementation technology.

This document represents the highest level of the enterprise business architecture and serves as the authoritative source for all subsequent domain-driven design and data modeling activities.

All lower-level architectural artifacts—including aggregates, entities, conceptual models, logical models, physical database models, services, and APIs—shall be derived from this document.

---

# 2. Architectural Principles

The Canonical Domain Model is governed by the following principles.

- Domain-Driven Design (DDD)
- Enterprise Business Architecture
- Single Source of Truth
- Separation of Concerns
- Explicit Domain Ownership
- High Cohesion
- Low Coupling
- Technology Independence
- Business-Driven Design
- Long-Term Architectural Stability

---

# 3. Canonical Domain Landscape

The Phoenix Platform is organized into a set of independent business domains.

```text
Phoenix Platform

├── Reference Domain

├── Instrument Domain

├── Market Data Domain

├── Corporate Actions Domain

├── Trading Calendar Domain

├── Analytics Domain

├── Feature Engineering Domain

├── Strategy Domain

├── Backtesting Domain

├── Portfolio Domain

├── Risk Management Domain

├── Reporting Domain

└── Integration Domain
```

Each domain owns a distinct set of business capabilities, aggregates, business entities, and business rules.

No business capability shall belong to more than one domain.

---

# 4. Domain Definitions

## 4.1 Reference Domain

### Mission

Provide enterprise-wide reference data shared across the entire Phoenix Platform.

### Primary Responsibilities

- Financial market structure
- Business classifications
- Geographic reference data
- Calendar definitions
- Localization metadata
- Provider classifications
- Enterprise reference standards

### Typical Aggregates

- Exchange
- Market
- Board
- Industry
- Sector
- Country
- Currency
- Trading Calendar

---

## 4.2 Instrument Domain

### Mission

Manage all tradable financial instruments and their business identities.

### Primary Responsibilities

- Company management
- Financial instrument lifecycle
- Instrument identity
- Instrument metadata
- Instrument classifications
- Listing-independent instrument information

### Typical Aggregates

- Company
- Financial Instrument
- Instrument Identifier

---

## 4.3 Market Data Domain

### Mission

Capture, validate and maintain historical market observations.

### Primary Responsibilities

- Daily market data
- Price history
- Trading statistics
- Market quotations
- Trading volumes
- Historical market records

### Typical Aggregates

- Instrument Listing
- Daily Market Data
- Market Statistics

---

# 5. Domain Responsibilities

The responsibilities of each domain define its ownership boundary within the enterprise architecture.

## Reference Domain

**Business Purpose**

Provide enterprise reference information that is shared across all business domains.

**Owns**

- Enterprise classifications
- Exchange hierarchy
- Market hierarchy
- Board hierarchy
- Geographic reference data
- Calendar reference data
- Currency reference data

**Consumed By**

All other business domains.

---

## Instrument Domain

**Business Purpose**

Manage the identity and lifecycle of tradable financial instruments.

**Owns**

- Company
- Financial Instrument
- Instrument identifiers
- Instrument metadata

**Consumed By**

- Market Data Domain
- Analytics Domain
- Strategy Domain
- Portfolio Domain

---

## Market Data Domain

**Business Purpose**

Manage historical and operational market observations.

**Owns**

- Daily Market Data
- Instrument Listing
- Trading statistics
- Historical prices

**Consumed By**

- Analytics Domain
- Feature Engineering Domain
- Strategy Domain
- Backtesting Domain
- Portfolio Domain

---

## Corporate Actions Domain

**Business Purpose**

Manage business events affecting financial instruments.

**Owns**

- Corporate Actions
- Adjustment events
- Distribution events
- Capital change events

**Consumed By**

- Market Data Domain
- Analytics Domain
- Portfolio Domain

---

## Trading Calendar Domain

**Business Purpose**

Manage official trading schedules and trading sessions.

**Owns**

- Trading Calendar
- Trading Days
- Holidays
- Trading Sessions

**Consumed By**

All domains that process time-dependent market information.

---

## Analytics Domain

**Business Purpose**

Produce analytical results from normalized market information.

**Owns**

- Indicator calculations
- Statistical analysis
- Analytical models
- Derived market metrics

---

## Feature Engineering Domain

**Business Purpose**

Generate reusable analytical features for quantitative models.

**Owns**

- Feature definitions
- Feature values
- Feature generation rules
- Feature metadata

---

## Strategy Domain

**Business Purpose**

Define and execute investment decision logic.

**Owns**

- Trading strategies
- Strategy parameters
- Trading signals
- Strategy versions

---

## Backtesting Domain

**Business Purpose**

Evaluate trading strategies using historical market data.

**Owns**

- Backtest executions
- Simulation results
- Performance metrics

---

## Portfolio Domain

**Business Purpose**

Manage investment portfolios and positions.

**Owns**

- Portfolio
- Position
- Transactions
- Holdings

---

## Risk Management Domain

**Business Purpose**

Measure and monitor portfolio risk.

**Owns**

- Risk models
- Risk measurements
- Exposure calculations
- Risk assessments

---

## Reporting Domain

**Business Purpose**

Provide business reporting and analytical projections.

**Owns**

- Report definitions
- Report snapshots
- Analytical views
- Dashboard models

Reporting data is derived and shall never become the system of record.

---

## Integration Domain

**Business Purpose**

Integrate external systems and market data providers.

**Owns**

- Data providers
- External identifiers
- Import sessions
- Provider mappings
- Integration metadata

The Integration Domain never owns core business entities.

---

# 6. Domain Classification

The enterprise domains are classified according to their architectural role.

| Domain | Classification |
|---------|----------------|
| Reference | Foundation Domain |
| Instrument | Core Business Domain |
| Market Data | Core Business Domain |
| Corporate Actions | Core Business Domain |
| Trading Calendar | Supporting Domain |
| Analytics | Analytical Domain |
| Feature Engineering | Analytical Domain |
| Strategy | Decision Domain |
| Backtesting | Research Domain |
| Portfolio | Core Business Domain |
| Risk Management | Decision Domain |
| Reporting | Supporting Domain |
| Integration | Infrastructure Domain |

---

# 7. Domain Dependency Principles

The following dependency rules govern the enterprise architecture.

- Reference Domain shall not depend on any business domain.
- Instrument Domain may depend only on the Reference Domain.
- Market Data Domain may depend on the Reference and Instrument Domains.
- Corporate Actions Domain may depend on the Instrument Domain.
- Trading Calendar Domain shall remain independent.
- Analytical domains shall consume operational domains but shall never own operational data.
- Reporting shall consume information without modifying operational data.
- Integration shall communicate with external systems without owning business concepts.
- Dependencies shall always flow from foundational domains toward higher-level business capabilities.

---

# 8. Domain Interaction Rules

The interaction between enterprise domains shall comply with the following rules.

## DM-001 — Single Ownership

Every business capability shall belong to exactly one domain.

Ownership shall never overlap.

---

## DM-002 — Business Autonomy

Each domain owns:

- Business terminology
- Business rules
- Business entities
- Aggregate boundaries
- Lifecycle management

---

## DM-003 — Explicit Collaboration

Cross-domain collaboration shall occur only through published contracts.

Domains shall not expose their internal implementation.

---

## DM-004 — Data Ownership

Each business entity shall have exactly one owning domain.

Read access does not imply ownership.

---

## DM-005 — Stable Boundaries

Domain boundaries shall remain stable over time.

Changes to domain ownership require an approved Architecture Decision Record (ADR).

---

## DM-006 — Technology Independence

Domains are independent of:

- Database schemas
- Programming languages
- Frameworks
- APIs
- Messaging technologies
- Deployment models

---

# 9. Derived Architectural Artifacts

The Canonical Domain Model is the foundation for the following architectural artifacts.

### Domain Architecture

- BoundedContextDefinition
- DomainResponsibilities
- DomainDependencyMatrix
- ServiceContextMap

### Domain Modeling

- AggregateCatalog
- AggregateDefinitions
- AggregateDesignGuidelines
- AggregateAttributeMatrix
- EntityClassification

### Data Architecture

- ConceptualDataModel
- LogicalDataModel
- PhysicalDatabaseModel
- ReferenceDataModel
- EnterpriseDataDictionary

### Service Architecture

- CanonicalServiceCatalog
- ServiceContracts
- IntegrationArchitecture

Every downstream artifact shall remain consistent with the ownership boundaries defined in this document.

---

# 10. Architectural Constraints

The following enterprise constraints are mandatory.

- Every business entity belongs to exactly one domain.
- Every aggregate belongs to exactly one domain.
- Every service implements responsibilities of a single domain or a well-defined supporting capability.
- Reference data shall never be duplicated across domains.
- Analytical data shall never modify operational data.
- Business terminology shall remain consistent across all architectural artifacts.
- Cross-domain persistence is prohibited.
- Domain ownership shall take precedence over implementation convenience.

---

# 11. Traceability

This document is governed by and shall remain consistent with the following architectural artifacts.

| Artifact | Purpose |
|----------|---------|
| PlatformArchitectureVision | Enterprise architecture vision |
| ArchitecturalPrinciples | Enterprise design principles |
| BoundedContextDefinition | Business ownership boundaries |
| DomainResponsibilities | Business responsibility allocation |
| ServiceContextMap | Service ownership model |
| AggregateCatalog | Aggregate ownership |
| AggregateDefinitions | Aggregate specifications |
| ConceptualDataModel | Business information model |
| EnterpriseDataDictionary | Canonical business definitions |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version |
| 2026.2 | 2026-07-18 | Refactored to align with the Enterprise Domain Architecture, clarified domain responsibilities, introduced explicit ownership and dependency rules, and synchronized with the canonical architecture documentation. |