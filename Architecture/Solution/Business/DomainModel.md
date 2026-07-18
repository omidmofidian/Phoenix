# Domain Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-001 |
| Document | DomainModel |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Business Architecture |
| Architecture Layer | Business Architecture |
| Owner | Architecture Team |
| Depends On | BusinessCapabilityMap.md, PlatformArchitectureVision.md |
| Consumed By | ConceptualModel.md, LogicalDatabaseModel.md, PhysicalDatabaseModel.md, CanonicalServiceCatalog.md |
| Last Updated | 2026-07-17 |

---

# 1. Purpose

This document defines the Canonical Enterprise Domain Model of the Phoenix Platform.

The Domain Model establishes the authoritative business decomposition of the platform and identifies the business domains, domain boundaries, aggregates, business ownership, and high-level relationships that collectively represent the enterprise business architecture.

This document is implementation independent and serves as the primary business architecture artifact from which conceptual models, logical database models, physical database models, service boundaries, APIs, and implementation artifacts are derived.

No implementation technology, database platform, programming language, deployment model, or infrastructure decision shall influence the structure of the Domain Model.

---

# 2. Architectural Position

Within the Phoenix Enterprise Architecture, the Domain Model occupies the central position between Business Capability Architecture and Enterprise Data Architecture.

```text
Business Vision
        │
        ▼
Business Capability Map
        │
        ▼
Canonical Domain Model
        │
        ├──────────────┐
        ▼              ▼
Service Architecture   Enterprise Data Architecture
        │              │
        └──────┬───────┘
               ▼
        Solution Design
               │
               ▼
        Implementation
```

The Domain Model is therefore considered the canonical business representation of the Phoenix Platform.

---

# 3. Architectural Principles

The Domain Model is governed by the architectural principles defined in the Vision layer.

In particular, this document adopts the following principles:

- Business Before Technology
- Knowledge Before Architecture
- Architecture Before Design
- Domain Before Database
- Canonical Business Model
- Single Source of Truth
- Separation of Concerns
- Explicit Ownership
- Service-Oriented Architecture
- Technology Independence
- Long-Term Maintainability

Any deviation from these principles requires an approved Architecture Decision Record (ADR).

---

# 4. Enterprise Domain Landscape

The Phoenix Platform is organized into seven enterprise business domains.

```text
Reference Domain

Market Domain

Core Business Domain

Configuration Domain

Reporting Domain

Integration Domain

Audit Domain
```

Each domain owns a well-defined business responsibility.

Business concepts shall belong to exactly one domain.

Business ownership shall never overlap between domains.

---

# 5. Domain Responsibilities

| Domain | Primary Responsibility |
|---------|------------------------|
| Reference Domain | Enterprise reference data, classifications, master data and taxonomies |
| Market Domain | Market structure, instruments and historical market information |
| Core Business Domain | Business capabilities supporting analysis and investment decision making |
| Configuration Domain | Platform configuration, parameters and runtime behavior |
| Reporting Domain | Reporting, analytical presentation and published information |
| Integration Domain | Communication with external providers, systems and services |
| Audit Domain | Audit trails, traceability, governance history and compliance |

---

# 6. Domain Collaboration

The enterprise domains collaborate while preserving explicit ownership.

```text
Reference Domain
        │
        ▼
Market Domain
        │
        ▼
Core Business Domain
      ┌─┼──────────────┐
      ▼ ▼              ▼
Reporting Domain   Integration Domain
          │
          ▼
      Audit Domain
```

Reference data may be consumed by multiple domains but shall remain owned exclusively by the Reference Domain.

The Core Business Domain consumes business information from supporting domains while preserving clear business boundaries.

Audit and Reporting consume information from operational domains but do not own operational business entities.

---

# 7. Enterprise Domain Definitions

## 7.1 Reference Domain

### Purpose

The Reference Domain provides the canonical business vocabulary shared throughout the enterprise.

It owns all stable reference information required by other domains and establishes the common language used across the Phoenix Platform.

### Responsibilities

- Markets
- Exchanges
- Boards
- Industry Classifications
- Sector Classifications
- Instrument Types
- Currency Definitions
- Geographic Definitions
- Trading Calendars
- Reference Taxonomies

### Aggregate Roots

- Exchange
- Market
- Board
- Industry
- Sector
- InstrumentType
- Currency
- TradingCalendar

The Reference Domain is the authoritative owner of enterprise reference data.

---

## 7.2 Market Domain

### Purpose

The Market Domain manages financial market structure and historical market information.

It owns business entities describing tradable instruments and their historical behavior.

### Responsibilities

- Companies
- Financial Instruments
- Daily Market Data
- Corporate Actions
- Financial Statements
- Market Events

### Aggregate Roots

- Company
- FinancialInstrument
- DailyMarketData
- CorporateAction
- FinancialStatement

Historical market information shall remain immutable whenever practical.

---

## 7.3 Core Business Domain

### Purpose

The Core Business Domain implements the primary business capabilities of the Phoenix Platform.

This domain transforms validated business information into analytical knowledge supporting investment decision-making.

### Responsibilities

- Technical Indicators
- Feature Engineering
- Quantitative Analysis
- Opportunity Evaluation
- Risk Assessment
- Portfolio Evaluation
- Strategy Definition
- Decision Support

### Aggregate Roots

- IndicatorDefinition
- FeatureDefinition
- Strategy
- Portfolio
- RiskModel
- OpportunityScore

The Core Business Domain consumes business information but shall not redefine enterprise reference data.

---

## 7.4 Configuration Domain

### Purpose

The Configuration Domain manages enterprise configuration and runtime behavior.

### Responsibilities

- System Parameters
- Feature Flags
- Runtime Configuration
- Environment Settings
- Business Parameters
- Configuration Versioning

### Aggregate Roots

- ConfigurationProfile
- ConfigurationParameter
- FeatureFlag

Configuration modifies system behavior without changing business rules.

---

## 7.5 Reporting Domain

### Purpose

The Reporting Domain transforms enterprise information into business reports, dashboards, and analytical views.

### Responsibilities

- Operational Reports
- Executive Reports
- Analytical Views
- Dashboard Models
- Published Metrics

### Aggregate Roots

- ReportDefinition
- Dashboard
- ReportingDataset

The Reporting Domain consumes business information without owning operational entities.

---

## 7.6 Integration Domain

### Purpose

The Integration Domain manages all interactions between the Phoenix Platform and external systems.

It provides controlled interfaces for importing, exporting, synchronizing, and exchanging business information while preserving enterprise ownership boundaries.

### Responsibilities

- External Market Data Providers
- Broker Connectivity
- Data Import
- Data Export
- External APIs
- Integration Adapters
- Messaging Interfaces
- Synchronization Services

### Aggregate Roots

- ExternalProvider
- IntegrationEndpoint
- ImportJob
- ExportJob

The Integration Domain facilitates information exchange but does not own enterprise business entities.

---

## 7.7 Audit Domain

### Purpose

The Audit Domain preserves enterprise traceability, accountability, and compliance.

It records business and operational events without modifying business ownership.

### Responsibilities

- Audit Events
- Change History
- Security Events
- Business Events
- Operational Events
- Data Lineage
- Compliance Records

### Aggregate Roots

- AuditEvent
- ChangeHistory
- SecurityEvent

The Audit Domain observes enterprise activities but never owns operational business processes.

---

# 8. Domain Ownership Principles

Enterprise domain ownership shall comply with the following principles.

## DOP-001 — Single Ownership

Every business entity shall belong to one—and only one—enterprise domain.

---

## DOP-002 — Explicit Boundaries

Business boundaries shall be explicit and documented.

Cross-domain ownership is prohibited.

---

## DOP-003 — Controlled Collaboration

Domains collaborate through defined business relationships.

Shared ownership is not permitted.

---

## DOP-004 — Stable Responsibilities

Domain responsibilities shall remain stable over time.

Implementation technologies shall never redefine domain boundaries.

---

# 9. Domain Dependency Principles

Dependencies between enterprise domains shall follow the hierarchy below.

```text
Reference Domain
        │
        ▼
Market Domain
        │
        ▼
Core Business Domain
      ┌─┼──────────────┐
      ▼ ▼              ▼
Reporting Domain   Integration Domain
          │
          ▼
      Audit Domain
```

Rules:

- Reference Domain has no business dependencies.
- Market Domain depends only on Reference Domain.
- Core Business Domain depends on Reference and Market Domains.
- Reporting Domain consumes information but does not own business entities.
- Integration Domain exchanges information without changing business ownership.
- Audit Domain records enterprise events generated by all operational domains.

---

# 10. Related Artifacts

## Vision

- PlatformArchitectureVision.md
- ArchitectureVisionMap.md
- KnowledgeDrivenArchitecture.md
- ReferenceArchitecture.md

## Business Architecture

- BusinessCapabilityMap.md
- DomainResponsibilities.md
- ServiceContextMap.md

## Data Architecture

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

## Domain Model

- CanonicalDomainModel.md
- AggregateCatalog.md
- AggregateDefinitions.md
- EntityCatalog.md
- BoundedContextDefinition.md

---

# 11. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2.0 | 2026-07-12 | Initial enterprise domain model. |
| 2026.3 | 2026-07-17 | Complete enterprise rewrite aligned with the Business Capability Map, Platform Architecture Vision, Knowledge-Driven Architecture, Reference Architecture, Enterprise Data Architecture, and Capability-Centric Repository Architecture. |

---

**End of Document**