# SDS-2026.1

# Bounded Context Definition

| Property | Value |
|----------|-------|
| Document ID | SDS-BCD-001 |
| Project | Phoenix Platform |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Business Architecture |
| Architecture Layer | Domain Architecture |
| Owner | Enterprise Architecture |
| Depends On | BusinessCapabilityMap, CanonicalDomainModel, DomainResponsibilities |
| Consumed By | ServiceContextMap, AggregateCatalog, AggregateDefinitions, ConceptualDataModel |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical **Bounded Contexts** of the Phoenix Platform.

A Bounded Context represents a clearly defined business boundary within which a consistent business language, business rules, domain model, and ownership model are maintained.

The objective of this document is to establish explicit ownership boundaries for business capabilities, eliminate ambiguity between business domains, and provide the foundation for service decomposition, aggregate ownership, and long-term architectural evolution.

This document is independent of implementation technologies, databases, deployment models, and programming languages.

---

# 2. Scope

This document defines:

- Canonical Bounded Contexts
- Business ownership boundaries
- Ubiquitous language boundaries
- Context responsibilities
- Context dependencies
- Upstream and downstream relationships
- Context communication principles
- Ownership rules

This document does not define:

- Services
- APIs
- Database schemas
- Tables
- Aggregates
- Entities
- Physical deployment
- Integration technologies

These artifacts are specified in subsequent architectural documents.

---

# 3. Bounded Context Principles

Every Bounded Context within the Phoenix Platform shall comply with the following architectural principles.

## BCP-001 — Single Business Responsibility

Each Bounded Context shall represent exactly one business domain.

Business responsibilities shall never overlap.

---

## BCP-002 — Ubiquitous Language

Each Bounded Context owns its own business terminology.

Business terms shall have exactly one meaning within the context.

---

## BCP-003 — Business Ownership

Every business entity, aggregate, business rule, and lifecycle belongs to exactly one Bounded Context.

Ownership shall never be shared.

---

## BCP-004 — Independent Evolution

Each Bounded Context shall evolve independently whenever possible.

Changes within one context should have minimal impact on other contexts.

---

## BCP-005 — Explicit Collaboration

Contexts shall collaborate only through published contracts.

Direct access to another context's internal implementation is prohibited.

---

## BCP-006 — Stable Boundaries

Bounded Context boundaries shall be driven by business semantics rather than organizational structures or technical implementation.

Boundary changes require architectural review and approval.

---

# 4. Canonical Bounded Context Catalog

The Phoenix Platform currently consists of the following canonical Bounded Contexts.

| Context | Primary Business Responsibility |
|----------|---------------------------------|
| Reference Context | Enterprise reference and classification data |
| Core Context | Enterprise master business entities |
| Market Context | Market structure and historical market observations |
| Analytics Context | Technical analysis and derived analytical information |
| Strategy Context | Trading strategies and decision logic |
| Portfolio Context | Investment portfolios and positions |
| Risk Context | Risk evaluation and portfolio risk management |
| Integration Context | External providers and data synchronization |
| Configuration Context | Platform configuration and runtime parameters |
| Audit Context | Enterprise auditability and traceability |
| Reporting Context | Analytical projections and reporting |
| Identity & Access Context | Authentication, authorization and security |

---

# 5. Context Responsibilities

The following sections define the primary responsibilities, owned business concepts, and architectural boundaries of each Bounded Context.

---

## 5.1 Reference Context

### Mission

Provide a single, authoritative source of enterprise reference data shared across the entire platform.

### Owns

- Market hierarchy
- Exchange hierarchy
- Trading boards
- Geographic reference data
- Currency definitions
- Calendar definitions
- Business classifications
- Instrument classifications
- Localization reference data

### Provides

- Canonical classifications
- Business identifiers
- Shared taxonomies
- Enterprise lookup data

### Consumed By

All other Bounded Contexts.

---

## 5.2 Core Context

### Mission

Manage the enterprise's primary business entities representing tradable organizations and financial instruments.

### Owns

- Company
- Financial Instrument
- Instrument Listing
- Instrument identity
- Listing lifecycle

### Depends On

Reference Context

---

## 5.3 Market Context

### Mission

Capture, validate and maintain historical market observations.

### Owns

- Daily Market Data
- Corporate Actions
- Trading Sessions
- Historical prices
- Market statistics

### Depends On

- Reference Context
- Core Context

---

## 5.4 Analytics Context

### Mission

Transform raw market observations into reusable analytical information.

### Owns

- Indicators
- Indicator Values
- Feature Definitions
- Feature Values
- Analytical Models
- Screening Results

### Depends On

- Market Context
- Core Context

---

## 5.5 Strategy Context

### Mission

Represent investment decision logic independently from analytical computations.

### Owns

- Strategies
- Strategy Versions
- Strategy Parameters
- Trading Signals
- Decision Rules

### Depends On

- Analytics Context

---

## 5.6 Portfolio Context

### Mission

Represent investment ownership, holdings and portfolio performance.

### Owns

- Portfolio
- Position
- Transaction
- Portfolio Performance

### Depends On

- Core Context
- Market Context
- Strategy Context

---

## 5.7 Risk Context

### Mission

Evaluate and monitor investment risk across portfolios and investment strategies.

### Owns

- Risk Models
- Risk Assessments
- Risk Metrics
- Exposure Calculations

### Depends On

- Portfolio Context
- Market Context

---

## 5.8 Integration Context

### Mission

Provide controlled integration with external systems, market data providers and third-party platforms.

### Owns

- Data Providers
- External Identifiers
- Import Sessions
- Import Jobs
- Synchronization Metadata

### Depends On

Reference Context

---

## 5.9 Configuration Context

### Mission

Manage configurable platform behavior independently of business logic.

### Owns

- Configuration Groups
- Configuration Items
- Runtime Parameters
- Feature Toggles

### Depends On

None

---

## 5.10 Audit Context

### Mission

Provide enterprise-wide traceability for business and operational activities.

### Owns

- Audit Sessions
- Audit Events
- Change History
- Security Events

### Depends On

Published events from all operational contexts.

---

## 5.11 Reporting Context

### Mission

Produce read-only business intelligence, dashboards and analytical projections.

### Owns

- Report Definitions
- Report Snapshots
- Analytical Views
- Dashboard Models

### Depends On

Read models published by operational contexts.

---

## 5.12 Identity & Access Context

### Mission

Provide authentication, authorization and enterprise security services.

### Owns

- Users
- Roles
- Permissions
- Authentication Policies
- Authorization Rules
- Security Sessions

### Depends On

Reference Context where localization or organizational reference information is required.

---

# 6. Context Relationships

The following relationships define the canonical dependencies between Bounded Contexts.

```text
                     +----------------------+
                     |  Reference Context   |
                     +----------------------+
                               │
               ┌───────────────┼────────────────┐
               │               │                │
               ▼               ▼                ▼
      +---------------+ +---------------+ +------------------+
      | Core Context  | | Integration   | | Identity & Access|
      +---------------+ | Context       | | Context          |
               │         +---------------+ +------------------+
               │
               ▼
      +----------------+
      | Market Context |
      +----------------+
               │
               ▼
      +------------------+
      | Analytics Context|
      +------------------+
               │
               ▼
      +------------------+
      | Strategy Context |
      +------------------+
               │
        ┌──────┴───────────┐
        ▼                  ▼
+----------------+   +----------------+
| Portfolio      |   | Risk Context   |
| Context        |   +----------------+
+----------------+            │
        └──────────────┬──────┘
                       ▼
              +------------------+
              | Reporting Context|
              +------------------+

All operational contexts publish business events.

               │
               ▼

        +------------------+
        | Audit Context    |
        +------------------+
```

---

# 7. Context Collaboration Rules

The following architectural rules govern collaboration between Bounded Contexts.

## BCR-001 — Exclusive Ownership

Each business entity, aggregate, value object and business rule shall belong to exactly one Bounded Context.

Ownership duplication is prohibited.

---

## BCR-002 — Contract-Based Communication

Contexts shall collaborate only through published interfaces, application services or domain events.

Internal implementation details shall never be exposed.

---

## BCR-003 — Independent Persistence

Each Bounded Context owns its persistence model.

Direct access to another context's database schema is prohibited.

---

## BCR-004 — Upstream / Downstream Dependency

Dependencies shall follow the business ownership hierarchy.

Lower-level contexts shall never become dependent on higher-level business processes.

---

## BCR-005 — Language Isolation

Business terminology is owned by the defining context.

Other contexts shall consume published concepts rather than redefining them.

---

## BCR-006 — Independent Evolution

Contexts may evolve independently provided that published contracts remain backward compatible.

Breaking interface changes require an approved Architecture Decision Record (ADR).

---

# 8. Traceability

This document is governed by and shall remain consistent with the following architectural artifacts.

| Artifact | Purpose |
|----------|---------|
| BusinessCapabilityMap | Enterprise business capabilities |
| DomainResponsibilities | Domain ownership and responsibilities |
| CanonicalDomainModel | Enterprise domain model |
| AggregateCatalog | Aggregate ownership |
| AggregateDefinitions | Aggregate boundaries |
| ServiceContextMap | Service ownership model |
| EntityClassification | Entity categorization |
| ReferenceDomainArchitecture | Reference domain architecture |
| ConceptualDataModel | Enterprise conceptual data model |
| ADR Repository | Architectural governance |

---

# 9. Related Documents

The following documents are derived from this Bounded Context Definition.

- CanonicalDomainModel.md
- DomainResponsibilities.md
- ServiceContextMap.md
- AggregateCatalog.md
- AggregateDefinitions.md
- AggregateAttributeMatrix.md
- EntityClassification.md
- ConceptualDataModel.md
- LogicalDataModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |
| 2026.2 | 2026-07-18 | Complete rewrite aligned with the canonical enterprise domain architecture, business ownership model, DDD bounded contexts, aggregate ownership and service architecture. |