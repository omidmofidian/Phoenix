# Service Context Map

| Property | Value |
|----------|-------|
| Artifact ID | ART-021 |
| Project | Phoenix Platform |
| Document | ServiceContextMap |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Architecture Layer | Service Architecture |
| Owner | Architecture Team |
| Sprint | Sprint 2 |
| Depends On | CanonicalDomainModel, CanonicalServiceCatalog |
| Consumed By | API Design, Database Design, Service Specifications |
| Last Updated | 2026-07-04 |

---

# 1. Purpose

This document defines the ownership boundaries between business services, bounded contexts, aggregates, and business entities within the Phoenix Platform.

The Service Context Map establishes the canonical ownership model of the platform and serves as the authoritative reference for service responsibilities and inter-service dependencies.

No service implementation shall violate the ownership boundaries defined in this document.

---

# 2. Objectives

The objectives of this document are to:

- Define service ownership boundaries.
- Map services to bounded contexts.
- Define aggregate ownership.
- Define entity ownership.
- Prevent overlapping responsibilities.
- Support independent service evolution.
- Enable future microservice implementation.
- Preserve architectural consistency.

---

# 3. Mapping Principles

The following principles govern service ownership throughout the platform.

## SCM-001 — Single Ownership

Every business capability shall be owned by exactly one service.

---

## SCM-002 — Aggregate Ownership

Every aggregate shall belong to one owning service.

---

## SCM-003 — Entity Ownership

Every business entity shall have exactly one owning service.

---

## SCM-004 — Interface-Based Collaboration

Services shall collaborate exclusively through explicit service contracts.

---

## SCM-005 — Database Isolation

Services shall never directly access another service's persistent storage.

---

## SCM-006 — Stable Boundaries

Service boundaries shall evolve only through approved architectural decisions.

---

# 4. Service Context Matrix

| Service | Bounded Context | Primary Aggregates | Primary Entities |
|----------|-----------------|-------------------|------------------|
| Reference Service | Reference | Reference Catalog | Exchange, Market, Currency, Country, Calendar |
| Market Service | Market | Market Data | MarketData, PriceHistory, CorporateAction |
| Instrument Service | Instrument | Instrument | Instrument, Symbol, Asset |
| Feature Service | Feature Engineering | Feature Set | Feature, Indicator, Factor |
| Analytics Service | Analytics | Analysis | AnalysisResult, BacktestResult, StatisticalModel |
| AI Service | Artificial Intelligence | AI Model | MLModel, Prediction, TrainingDataset |
| Strategy Service | Strategy | Strategy | Strategy, TradingSignal |
| Ranking Service | Ranking | Opportunity Ranking | Opportunity, OpportunityScore |
| Risk Service | Risk | Risk Profile | RiskModel, RiskAssessment |
| Portfolio Service | Portfolio | Portfolio | Portfolio, Position, Transaction |
| Integration Service | Integration | Provider | DataProvider, BrokerConnection |
| Reporting Service | Reporting | Report | Report, Dashboard |
| Notification Service | Notification | Notification | Notification, Alert |
| Configuration Service | Configuration | Configuration | ConfigurationItem |
| Audit Service | Audit | Audit Log | AuditEntry |
| Execution Service | Execution | Order | Order, Execution |

---

# 5. Service Dependency Matrix

| Service | Depends On |
|----------|------------|
| Reference Service | — |
| Market Service | Reference Service |
| Instrument Service | Reference Service |
| Feature Service | Market Service, Instrument Service |
| Analytics Service | Feature Service |
| AI Service | Analytics Service |
| Strategy Service | Analytics Service |
| Ranking Service | Strategy Service, Risk Service |
| Risk Service | Portfolio Service, Market Service |
| Portfolio Service | Instrument Service, Market Service |
| Integration Service | Reference Service |
| Reporting Service | Read Contracts of All Services |
| Notification Service | Published Events |
| Configuration Service | — |
| Audit Service | Published Events |
| Execution Service | Strategy Service, Portfolio Service, Risk Service |

---

# 6. Entity Ownership

The following table defines the canonical owner of each business entity.

| Entity | Owner Service |
|---------|---------------|
| Exchange | Reference Service |
| Market | Reference Service |
| Currency | Reference Service |
| Country | Reference Service |
| Calendar | Reference Service |
| Instrument | Instrument Service |
| Symbol | Instrument Service |
| Asset | Instrument Service |
| MarketData | Market Service |
| PriceHistory | Market Service |
| CorporateAction | Market Service |
| Feature | Feature Service |
| Indicator | Feature Service |
| Factor | Feature Service |
| AnalysisResult | Analytics Service |
| BacktestResult | Analytics Service |
| StatisticalModel | Analytics Service |
| MLModel | AI Service |
| Prediction | AI Service |
| TrainingDataset | AI Service |
| Strategy | Strategy Service |
| TradingSignal | Strategy Service |
| Opportunity | Ranking Service |
| OpportunityScore | Ranking Service |
| Portfolio | Portfolio Service |
| Position | Portfolio Service |
| Transaction | Portfolio Service |
| RiskModel | Risk Service |
| RiskAssessment | Risk Service |
| DataProvider | Integration Service |
| BrokerConnection | Integration Service |
| Report | Reporting Service |
| Dashboard | Reporting Service |
| Notification | Notification Service |
| Alert | Notification Service |
| ConfigurationItem | Configuration Service |
| AuditEntry | Audit Service |
| Order | Execution Service |
| Execution | Execution Service |

---

# 7. Communication Model

Services shall communicate through well-defined service contracts.

Supported communication mechanisms include:

- REST APIs
- gRPC
- Event Messaging
- Scheduled Synchronization

Direct database sharing between services is prohibited.

---

# 8. Ownership Rules

Ownership implies responsibility for:

- Business rules
- Data integrity
- Validation
- Persistence
- Lifecycle management
- Version compatibility

Other services may consume business information only through published interfaces.

---

# 9. Evolution Rules

The Service Context Map is expected to evolve as new business capabilities are introduced.

However:

- Existing ownership boundaries shall remain stable.
- Business capability duplication is prohibited.
- Service responsibilities shall not overlap.
- Major ownership changes require an approved Architecture Decision Record (ADR).

---

# 10. Traceability

Every service defined in this document shall be traceable to:

- Business Capability Map
- Bounded Context Definition
- Canonical Domain Model
- Entity Catalog
- Canonical Business Rules
- Architecture Decision Records (ADR)

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |