# Domain Responsibilities

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-002 |
| Document | DomainResponsibilities |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Business Architecture |
| Architecture Layer | Business Architecture |
| Owner | Architecture Team |
| Depends On | BusinessCapabilityMap.md, DomainModel.md |
| Consumed By | ServiceContextMap.md, CanonicalServiceCatalog.md, AggregateCatalog.md, AggregateDefinitions.md |
| Last Updated | 2026-07-17 |

---

# 1. Purpose

This document defines the canonical business responsibilities of every enterprise domain within the Phoenix Platform.

Its primary objective is to establish explicit business ownership boundaries, eliminate responsibility overlap, and provide the authoritative source for assigning business capabilities, aggregates, entities, and services to enterprise domains.

The responsibility model defined in this document is independent of software implementation, database technologies, deployment architecture, and organizational structure.

---

# 2. Architectural Position

Domain Responsibilities translate the Enterprise Domain Model into explicit business ownership.

```text
Business Capability Map
        │
        ▼
Domain Model
        │
        ▼
Domain Responsibilities
        │
        ├──────────────┐
        ▼              ▼
Aggregate Ownership    Service Ownership
        │              │
        └──────┬───────┘
               ▼
Enterprise Data Architecture
```

Every aggregate, business entity, service, and database object shall ultimately inherit its ownership from the responsibilities defined in this document.

---

# 3. Responsibility Principles

The responsibility model follows the principles below.

## DRP-001 — Explicit Ownership

Every business responsibility shall belong to exactly one enterprise domain.

---

## DRP-002 — No Responsibility Overlap

Business domains shall never share ownership of the same business capability.

---

## DRP-003 — Stable Responsibilities

Business responsibilities shall evolve significantly more slowly than implementation technologies.

---

## DRP-004 — Capability Alignment

Every business responsibility shall support one or more approved business capabilities.

---

## DRP-005 — Service Alignment

Enterprise services shall implement responsibilities owned by their corresponding business domain.

---

# 4. Enterprise Responsibility Matrix

| Domain | Primary Responsibility | Business Ownership | Publishes Information | Consumes Information |
|---------|------------------------|-------------------|----------------------|----------------------|
| Reference Domain | Enterprise reference information | Yes | Yes | No |
| Market Domain | Market structure and historical market information | Yes | Yes | Yes |
| Core Business Domain | Investment intelligence and business analysis | Yes | Yes | Yes |
| Configuration Domain | Runtime behavior and configuration | Yes | Yes | No |
| Reporting Domain | Analytical presentation and reporting | Derived Only | Yes | Yes |
| Integration Domain | External communication and synchronization | No | Yes | Yes |
| Audit Domain | Enterprise auditability and traceability | Yes | Yes | Yes |

---

# 5. Enterprise Domain Responsibilities

## 5.1 Reference Domain

### Mission

The Reference Domain establishes and maintains the canonical enterprise reference information shared across the entire Phoenix Platform.

It defines the business vocabulary, classification systems, and master reference structures upon which every operational domain depends.

### Primary Responsibilities

- Exchange Management
- Market Management
- Trading Board Management
- Industry Classification
- Sector Classification
- Instrument Type Classification
- Trading Calendar Management
- Currency Management
- Country Management
- Enterprise Taxonomies

### Owns

- Exchange
- Market
- Board
- Industry
- Sector
- InstrumentType
- TradingCalendar
- Currency
- Country

### Business Rules

- Owns all enterprise reference data.
- Provides shared business definitions.
- Shall not depend on operational domains.
- Business identifiers remain stable and immutable whenever practical.

---

## 5.2 Market Domain

### Mission

The Market Domain manages the structure of financial markets and preserves historical market information.

It owns the enterprise representation of companies, tradable instruments, historical observations, and corporate events.

### Primary Responsibilities

- Company Management
- Financial Instrument Management
- Historical Market Data
- Corporate Actions
- Financial Statements
- Market Events

### Owns

- Company
- FinancialInstrument
- DailyMarketData
- CorporateAction
- FinancialStatement

### Business Rules

- Depends only on the Reference Domain.
- Historical market observations are immutable.
- Does not redefine enterprise reference information.
- Preserves historical business facts.

---

## 5.3 Core Business Domain

### Mission

The Core Business Domain transforms validated market information into investment knowledge and decision-support information.

This domain represents the primary analytical capabilities of the Phoenix Platform.

### Primary Responsibilities

- Technical Indicators
- Feature Engineering
- Quantitative Analysis
- Investment Scoring
- Strategy Definition
- Portfolio Evaluation
- Risk Assessment
- Decision Support

### Owns

- IndicatorDefinition
- IndicatorResult
- FeatureDefinition
- FeatureValue
- Strategy
- OpportunityScore
- Portfolio
- RiskModel

### Business Rules

- Consumes information from the Market Domain.
- Shall not modify historical market information.
- Produces derived analytical information.
- Maintains complete analytical traceability.

---

## 5.4 Configuration Domain

### Mission

The Configuration Domain controls configurable platform behavior while remaining independent of business ownership.

### Primary Responsibilities

- Runtime Configuration
- Business Parameters
- System Parameters
- Environment Configuration
- Feature Flags
- Configuration Versioning

### Owns

- ConfigurationProfile
- ConfigurationGroup
- ConfigurationParameter
- FeatureFlag

### Business Rules

- Independent of operational domains.
- Controls platform behavior only.
- Does not own business processes.
- Does not contain analytical data.

---

## 5.5 Reporting Domain

### Mission

The Reporting Domain delivers enterprise reporting, dashboards, and analytical presentations.

### Primary Responsibilities

- Operational Reports
- Executive Reports
- Analytical Dashboards
- Business Intelligence Views
- Published Metrics
- Reporting Snapshots

### Owns

- ReportDefinition
- Dashboard
- ReportingDataset
- ReportingSnapshot

### Business Rules

- Consumes information from operational domains.
- Owns only reporting artifacts.
- Shall never modify operational business information.
- All reporting information is derived.

---

## 5.6 Integration Domain

### Mission

The Integration Domain provides controlled communication between the Phoenix Platform and external systems while protecting the integrity of the enterprise business model.

### Primary Responsibilities

- External Market Data Providers
- Broker Connectivity
- Data Import
- Data Export
- External API Integration
- Messaging Interfaces
- Synchronization Services
- External Identifier Mapping

### Owns

- ExternalProvider
- IntegrationEndpoint
- ImportSession
- ExportSession
- ExternalIdentifier

### Business Rules

- Does not own enterprise business entities.
- Shall isolate external systems from internal business domains.
- Performs translation and mapping between external and canonical models.
- All imported information shall be validated before entering operational domains.

---

## 5.7 Audit Domain

### Mission

The Audit Domain preserves enterprise accountability, traceability, and regulatory compliance across the entire platform.

### Primary Responsibilities

- Audit Logging
- Business Event Recording
- Security Event Recording
- Change History
- Data Lineage
- Compliance Monitoring
- Operational Traceability

### Owns

- AuditSession
- AuditEvent
- ChangeHistory
- SecurityEvent

### Business Rules

- Operates independently of business workflows.
- Records enterprise events without changing business state.
- Audit information is append-only.
- Complete traceability shall be maintained throughout the lifecycle of every business object.

---

# 6. Cross-Domain Collaboration Principles

Enterprise domains collaborate through explicit business responsibilities while preserving ownership boundaries.

## DRC-001 — Single Business Ownership

Every business capability, aggregate, and business entity shall belong to one—and only one—enterprise domain.

---

## DRC-002 — Explicit Information Publishing

Domains publish business information without transferring business ownership.

---

## DRC-003 — Controlled Information Consumption

Domains consume published information but shall not redefine or duplicate business ownership.

---

## DRC-004 — Derived Information

Reporting and analytical domains may derive new information but shall never alter the original business facts.

---

## DRC-005 — Independent Support Domains

Configuration, Integration, and Audit support operational domains without assuming ownership of their business processes.

---

# 7. Responsibility Traceability

Every enterprise responsibility shall be traceable throughout the architecture.

```text
Business Capability
        │
        ▼
Enterprise Domain
        │
        ▼
Aggregate
        │
        ▼
Business Entity
        │
        ▼
Service
        │
        ▼
Database Object
        │
        ▼
Implementation
```

This traceability ensures consistency across the Business Architecture, Data Architecture, Service Architecture, and implementation layers.

---

# 8. Related Artifacts

## Vision

- PlatformArchitectureVision.md
- ArchitectureVisionMap.md
- KnowledgeDrivenArchitecture.md
- ReferenceArchitecture.md

## Business Architecture

- BusinessCapabilityMap.md
- DomainModel.md
- ServiceContextMap.md

## Domain Architecture

- CanonicalDomainModel.md
- AggregateCatalog.md
- AggregateDefinitions.md
- EntityCatalog.md
- BoundedContextDefinition.md

## Data Architecture

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

---

# 9. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-18 | Complete enterprise rewrite aligned with the Business Capability Map, Domain Model, Platform Architecture Vision, Service-Oriented Architecture, and Enterprise Domain Ownership principles. |

---

**End of Document**