# Canonical Service Catalog

| Property | Value |
|----------|-------|
| Artifact ID | ART-020 |
| Project | Phoenix Platform |
| Document | CanonicalServiceCatalog |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Architecture Layer | Service Architecture |
| Owner | Enterprise Architecture Team |
| Repository Standard | Phoenix Repository Standard 2026.2 |
| Depends On | PlatformArchitectureVision, ArchitecturalPrinciples, QualityAttributes, CanonicalDomainModel, ServiceContextMap |
| Consumed By | Service Specifications, API Specifications, Physical Database Model, Software Design Document |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

The Canonical Service Catalog defines the enterprise service architecture of the Phoenix Platform.

It establishes the authoritative catalog of business services, supporting services and platform services together with their responsibilities, ownership boundaries and architectural relationships.

This document serves as the primary architectural reference for all future service implementations.

The Service Catalog is implementation independent.

---

# 2. Objectives

The objectives of this document are to:

- Define canonical enterprise services.
- Establish stable service boundaries.
- Prevent overlapping responsibilities.
- Promote service autonomy.
- Support modular development.
- Enable future distributed deployment.
- Maintain architectural consistency.
- Support Domain-Driven Design.
- Preserve business ownership.
- Provide traceability to business capabilities.

---

# 3. Scope

## Included

This document defines:

- Enterprise services
- Business responsibilities
- Service ownership
- Service categories
- Communication principles
- Dependency rules
- Data ownership principles
- Service evolution strategy

---

## Excluded

The following are outside the scope of this document:

- API definitions
- Database schemas
- Table structures
- Infrastructure deployment scripts
- Programming language implementation
- User interface architecture

---

# 4. Architectural Context

Within the Phoenix Architecture, services represent the primary implementation units of business capabilities.

Every service encapsulates a coherent set of business responsibilities and owns the lifecycle of its business data.

Services collaborate through explicit contracts while remaining internally autonomous.

The architecture is designed to evolve from a modular monolith toward a service-oriented distributed platform without changing business boundaries.

---

# 5. Service-Oriented Principles

Every service shall comply with the following principles.

---

## Single Responsibility

A service owns exactly one business capability.

Business responsibilities shall never overlap.

---

## High Cohesion

Business logic belonging to the same capability shall remain within the same service.

---

## Loose Coupling

Services communicate only through published interfaces.

Direct implementation dependencies are prohibited.

---

## Explicit Contracts

Every interaction shall occur through well-defined contracts.

Implementation details remain internal.

---

## Independent Evolution

A service shall evolve independently whenever possible.

Changes inside one service shall minimize impact on other services.

---

## Data Ownership

Every business entity belongs to exactly one service.

Ownership shall never be shared.

---

## Technology Independence

Business responsibilities remain independent of implementation technologies.

---

## Replaceability

Implementation details may change without affecting service contracts.

---

# 6. Service Classification

Phoenix services are grouped into five enterprise categories.

---

## 6.1 Core Business Services

Core services implement the primary business capabilities of the platform.

Characteristics:

- Own business entities
- Own business rules
- Own business data
- Represent bounded contexts

---

## 6.2 Supporting Services

Supporting services provide reusable business capabilities used by multiple core services.

Characteristics:

- Support business workflows
- Do not duplicate core ownership
- Remain reusable

---

## 6.3 Shared Platform Services

Shared platform services provide enterprise-wide technical capabilities.

Characteristics:

- Cross-cutting
- Infrastructure oriented
- Shared by all services

---

## 6.4 Analytical Services

Analytical services perform quantitative processing on business data.

Characteristics:

- Read business information
- Produce derived analytical information
- Do not own master business entities

---

## 6.5 Future Services

Reserved for future platform evolution.

Future services shall not influence the current architecture.

---

# 7. Enterprise Service Taxonomy

```text
Phoenix Platform

├── Core Business Services
│      ├── Reference Service
│      ├── Market Service
│      ├── Instrument Service
│      ├── Portfolio Service
│      └── Strategy Service
│
├── Supporting Services
│      ├── Integration Service
│      ├── Reporting Service
│      └── Notification Service
│
├── Shared Platform Services
│      ├── Configuration Service
│      ├── Audit Service
│      └── Identity Service (Future)
│
├── Analytical Services
│      ├── Indicator Engine
│      ├── Feature Engine
│      ├── Analytics Engine
│      ├── Prediction Engine
│      ├── Ranking Engine
│      ├── Risk Engine
│      └── Backtest Engine
│
└── Future Services
       ├── AI Service
       ├── Optimization Service
       ├── Execution Service
       └── Compliance Service
```

---

# 8. Canonical Enterprise Service Catalog

| ID | Service | Category | Primary Capability | Domain | Status |
|----|----------|----------|--------------------|--------|--------|
| SVC-001 | Reference Service | Core | Enterprise Reference Data | Reference | Planned |
| SVC-002 | Market Service | Core | Market Structure & Market Data | Market | Planned |
| SVC-003 | Instrument Service | Core | Tradable Instrument Management | Core | Planned |
| SVC-004 | Portfolio Service | Core | Portfolio Management | Core | Planned |
| SVC-005 | Strategy Service | Core | Trading Strategy Management | Core | Planned |
| SVC-006 | Integration Service | Supporting | External Integration | Integration | Planned |
| SVC-007 | Reporting Service | Supporting | Reporting & Analytics | Reporting | Planned |
| SVC-008 | Notification Service | Supporting | Alerts & Messaging | Supporting | Planned |
| SVC-009 | Configuration Service | Shared | Configuration Management | Configuration | Planned |
| SVC-010 | Audit Service | Shared | Audit & Traceability | Audit | Planned |
| SVC-011 | Indicator Engine | Analytical | Technical Indicators | Analytics | Planned |
| SVC-012 | Feature Engine | Analytical | Feature Engineering | Analytics | Planned |
| SVC-013 | Analytics Engine | Analytical | Quantitative Analysis | Analytics | Planned |
| SVC-014 | Prediction Engine | Analytical | Statistical & ML Prediction | Analytics | Planned |
| SVC-015 | Ranking Engine | Analytical | Opportunity Ranking | Analytics | Planned |
| SVC-016 | Risk Engine | Analytical | Risk Assessment | Analytics | Planned |
| SVC-017 | Backtest Engine | Analytical | Historical Strategy Evaluation | Analytics | Planned |
| SVC-018 | AI Service | Future | Artificial Intelligence | Future | Future |
| SVC-019 | Execution Service | Future | Trade Execution | Future | Future |
| SVC-020 | Compliance Service | Future | Regulatory Compliance | Future | Future |

---

# 9. Service Layer Relationships

```text
                    External Providers
                            │
                            ▼
                  Integration Service
                            │
                            ▼
        ┌─────────────────────────────────────┐
        │        Core Business Services        │
        └─────────────────────────────────────┘
                            │
                            ▼
                 Analytical Services
                            │
                            ▼
                  Reporting Service

Shared Platform Services
(Configuration / Audit)

provide capabilities to every layer.
```

---

# 10. Core Business Services

Core Business Services implement the primary business capabilities of the Phoenix Platform.

These services own business entities, business rules, business processes and data persistence for their respective domains.

Core Services represent the implementation of the platform's Bounded Contexts as defined by the Canonical Domain Model.

---

# 10.1 Reference Service

## Purpose

The Reference Service manages enterprise-wide reference and master data shared by all other services.

Reference data changes infrequently and provides the business foundation for every domain.

---

## Responsibilities

- Manage Markets
- Manage Exchanges
- Manage Trading Boards
- Manage Countries
- Manage Regions
- Manage Cities
- Manage Currencies
- Manage Time Zones
- Manage Trading Calendars
- Manage Holiday Calendars
- Manage Market Classification
- Manage Sector Classification
- Manage Industry Classification

---

## Owned Aggregates

- Market
- Exchange
- Trading Board
- Country
- Region
- City
- Currency
- Trading Calendar
- Holiday Calendar
- Sector
- Industry

---

## Business Rules

- Reference data is centrally governed.
- Business identifiers are immutable.
- Reference entities cannot depend on transactional entities.
- Reference entities are shared across all domains.

---

# 10.2 Market Service

## Purpose

The Market Service manages the operational structure of supported financial markets and their historical market data.

---

## Responsibilities

- Daily Market Data
- Market Sessions
- Trading Status
- Market Events
- Corporate Actions
- Historical Price Repository
- Trading Universe

---

## Owned Aggregates

- Daily Market Data
- Corporate Action
- Trading Session
- Trading Universe

---

## Business Rules

- Historical market data is immutable.
- Imported data is normalized before persistence.
- Every market record belongs to exactly one market.
- Raw and normalized data remain separated.

---

# 10.3 Instrument Service

## Purpose

The Instrument Service manages all tradable financial instruments supported by the platform.

---

## Responsibilities

- Instrument registration
- Symbol management
- Listing management
- External identifiers
- Instrument lifecycle
- Instrument metadata

---

## Owned Aggregates

- Instrument
- Symbol
- Instrument Listing
- External Identifier

---

## Business Rules

- Every Instrument owns one canonical identifier.
- Symbols may change over time.
- Listing history is preserved.
- Instrument identity never changes.

---

# 10.4 Portfolio Service

## Purpose

The Portfolio Service manages investment portfolios and their historical performance.

---

## Responsibilities

- Portfolio definition
- Holdings
- Allocation
- Position management
- Portfolio history
- Portfolio analytics

---

## Owned Aggregates

- Portfolio
- Position
- Holding

---

## Business Rules

- Portfolio ownership is exclusive.
- Historical positions are immutable.
- Portfolio history is preserved.
- Performance calculations are reproducible.

---

# 10.5 Strategy Service

## Purpose

The Strategy Service manages reusable investment strategies.

---

## Responsibilities

- Strategy definition
- Entry conditions
- Exit conditions
- Strategy parameters
- Strategy versions
- Strategy execution metadata

---

## Owned Aggregates

- Strategy
- Strategy Version
- Strategy Parameter

---

## Business Rules

- Strategies are version controlled.
- Historical strategies remain reproducible.
- Business rules remain independent of implementation.

---

# 11. Supporting Services

Supporting Services provide reusable business capabilities for multiple domains.

They do not own enterprise master data.

---

# 11.1 Integration Service

## Purpose

Provides controlled communication with external systems.

---

## Responsibilities

- Data import
- Provider adapters
- External APIs
- Data normalization
- Validation
- Import scheduling

---

## Supported Providers

- Tehran Stock Exchange
- TSETMC
- CODAL
- Forex providers
- Cryptocurrency exchanges
- Financial news providers

---

## Business Rules

- Provider-specific logic remains isolated.
- Canonical models are produced before business processing.
- External failures do not compromise internal consistency.

---

# 11.2 Reporting Service

## Purpose

Provides enterprise reporting, dashboards and analytical presentation.

---

## Responsibilities

- Report generation
- Dashboards
- Report snapshots
- Export services
- Analytical views
- Scheduled reports

---

## Business Rules

- Reporting is read-only.
- Reports never modify business entities.
- Historical reports remain reproducible.

---

# 11.3 Notification Service

## Purpose

Provides enterprise notification capabilities.

---

## Responsibilities

- Alerts
- Email notifications
- Scheduled reminders
- Signal notifications
- Event notifications

---

## Business Rules

- Notification delivery is asynchronous.
- Business processing never depends on notification success.
- Notification history is retained.

---

# 12. Shared Platform Services

Shared Platform Services provide enterprise-wide infrastructure capabilities.

These services are consumed by every business service.

---

# 12.1 Configuration Service

## Purpose

Provides centralized configuration management.

---

## Responsibilities

- Application configuration
- Feature flags
- Environment settings
- Service configuration
- Runtime parameters

---

## Business Rules

- Configuration is centrally managed.
- Environment-specific settings remain external.
- Configuration changes are auditable.

---

# 12.2 Audit Service

## Purpose

Provides enterprise audit and traceability.

---

## Responsibilities

- Audit logging
- Business event recording
- Technical event recording
- Security audit
- Compliance support

---

## Business Rules

- Audit records are immutable.
- Audit data is append-only.
- Audit information is never deleted.

---

# 13. Analytical Services

Analytical Services consume approved business information and generate derived analytical outputs.

They do not own business master data.

---

## Indicator Engine

Calculates technical indicators from historical market data.

Examples:

- Moving Average
- RSI
- MACD
- ATR
- Bollinger Bands
- Volume Indicators

---

## Feature Engine

Produces reusable analytical features.

Examples:

- Statistical factors
- Momentum features
- Volatility measures
- Pattern recognition features

---

## Analytics Engine

Performs quantitative analysis.

Examples:

- Correlation
- Factor analysis
- Statistical evaluation
- Performance metrics

---

## Prediction Engine

Produces predictive outputs using statistical and machine learning models.

Examples:

- Trend prediction
- Probability estimation
- Classification
- Forecasting

---

## Ranking Engine

Ranks investment opportunities.

Examples:

- Opportunity scoring
- Candidate ranking
- Portfolio prioritization

---

## Risk Engine

Calculates investment risk.

Examples:

- Position risk
- Portfolio exposure
- Drawdown
- Volatility analysis

---

## Backtest Engine

Evaluates historical strategy performance.

Examples:

- Strategy simulation
- Historical execution
- Performance comparison
- Risk-adjusted metrics

---

# 14. Infrastructure Services (Future)

The following infrastructure-oriented services are reserved for future platform evolution.

- Identity Service
- Authorization Service
- Scheduling Service
- Workflow Service
- Cache Service
- Search Service
- Document Service
- Messaging Service

These services provide technical capabilities and do not own business domains.

---

# 15. Service Communication

Enterprise services communicate exclusively through explicit contracts.

No service shall directly access another service's internal implementation or persistence layer.

The communication mechanism is considered an implementation detail and shall not influence business ownership.

---

## Communication Objectives

The communication architecture shall:

- Preserve service autonomy.
- Prevent tight coupling.
- Support independent deployment.
- Enable service replacement.
- Maintain architectural consistency.

---

## Supported Communication Mechanisms

| Mechanism | Typical Usage |
|-----------|---------------|
| REST API | Synchronous business operations |
| gRPC | High-performance internal communication |
| Event Messaging | Asynchronous business events |
| Scheduled Synchronization | Batch processing |
| File Exchange | Legacy integration |
| Message Queue | Background processing |

---

## Communication Principles

- Communication shall occur only through published contracts.
- Service interfaces shall remain versioned.
- Contracts shall be backward compatible whenever practical.
- Communication failures shall not corrupt business data.
- Retry mechanisms shall be implemented where appropriate.
- Long-running operations should be asynchronous.

---

# 16. Service Dependency Model

Dependencies between services shall follow the enterprise dependency rules.

Business ownership shall never be violated.

---

## Dependency Principles

- Dependencies always point toward stable business capabilities.
- Circular dependencies are prohibited.
- Supporting services shall not own business entities.
- Shared platform services remain independent of business domains.
- Analytical services consume business data but do not own it.

---

## Canonical Dependency Flow

```text
                    External Providers
                            │
                            ▼
                 Integration Service
                            │
                            ▼
                  Reference Service
                            │
                            ▼
        ┌────────────────────────────────┐
        │     Core Business Services      │
        │                                │
        │  Market                        │
        │  Instrument                    │
        │  Portfolio                     │
        │  Strategy                      │
        └────────────────────────────────┘
                            │
                            ▼
                 Analytical Services
                            │
                            ▼
                  Reporting Service

Configuration Service
Audit Service

provide cross-cutting capabilities
to all enterprise services.
```

---

## Dependency Matrix

| Consumer | Provider | Dependency Type |
|----------|----------|-----------------|
| Market Service | Reference Service | Business Reference |
| Instrument Service | Reference Service | Business Reference |
| Portfolio Service | Instrument Service | Business Reference |
| Strategy Service | Market Service | Business Reference |
| Analytical Services | Market Service | Read Only |
| Analytical Services | Instrument Service | Read Only |
| Reporting Service | All Business Services | Read Only |
| All Services | Configuration Service | Shared Platform |
| All Services | Audit Service | Shared Platform |

---

# 17. Data Ownership

Data ownership is one of the most important architectural principles of the Phoenix Platform.

Every business entity has exactly one owning service.

---

## Ownership Rules

- Ownership shall be unique.
- Ownership shall be permanent.
- Ownership shall be explicit.
- Ownership shall be traceable.
- Shared ownership is prohibited.

---

## Data Ownership Matrix

| Service | Owned Business Data |
|----------|---------------------|
| Reference Service | Markets, Exchanges, Boards, Calendars, Sectors, Industries |
| Market Service | Daily Market Data, Trading Sessions, Corporate Actions |
| Instrument Service | Instruments, Symbols, Listings, External Identifiers |
| Portfolio Service | Portfolios, Holdings, Positions |
| Strategy Service | Strategies, Parameters, Versions |
| Configuration Service | Platform Configuration |
| Audit Service | Audit Records |
| Reporting Service | Report Definitions, Report Snapshots |

---

## Ownership Constraints

- Only the owning service may modify its business entities.
- Other services consume information through published interfaces.
- Database-level coupling is prohibited.
- Ownership changes require architectural approval.

---

# 18. Service Lifecycle

Every enterprise service follows a consistent lifecycle.

---

## Lifecycle Stages

```text
Planning

↓

Architecture

↓

Design

↓

Implementation

↓

Testing

↓

Deployment

↓

Operation

↓

Monitoring

↓

Maintenance

↓

Retirement
```

---

## Lifecycle Principles

- Architecture precedes implementation.
- Every service shall be independently testable.
- Every deployment shall be reproducible.
- Operational monitoring shall be mandatory.
- Service retirement shall preserve historical information.

---

# 19. Deployment Considerations

The service architecture supports both the current modular deployment model and future distributed deployments.

---

## Current Architecture

- Modular Monolith
- Shared PostgreSQL Cluster
- Docker Containers
- Independent Modules

---

## Future Architecture

- Independent Services
- Dedicated Databases
- Event-Driven Integration
- Horizontal Scaling
- Cloud Deployment

---

## Deployment Principles

- Service boundaries remain unchanged.
- Deployment strategy does not affect business ownership.
- Infrastructure evolves independently of business architecture.

---

# 20. Governance

The Canonical Service Catalog is governed by the Enterprise Architecture process.

Any modification affecting service responsibilities, ownership or boundaries shall undergo formal architectural review.

---

## Governance Objectives

- Preserve service consistency.
- Prevent overlapping capabilities.
- Maintain domain integrity.
- Ensure compliance with approved ADRs.
- Control architectural evolution.

---

## Governance Rules

- New services require architectural justification.
- Existing responsibilities shall not be duplicated.
- Service boundaries shall remain stable.
- Major changes shall be documented through Architecture Decision Records (ADRs).

---

# 21. Traceability

Every service shall be traceable to enterprise architectural artifacts.

| Artifact | Purpose |
|----------|---------|
| PlatformArchitectureVision | Architectural direction |
| ArchitecturalPrinciples | Enterprise principles |
| QualityAttributes | Quality requirements |
| CanonicalDomainModel | Business ownership |
| ServiceContextMap | Domain interactions |
| SoftwareDesignDocument | Solution architecture |
| LogicalDatabaseModel | Logical persistence |
| PhysicalDatabaseModel | Physical implementation |
| Architecture Decision Records | Architectural governance |

---

# 22. Future Evolution

The Service Catalog is designed for long-term evolution.

Future platform capabilities are expected to include:

- Multi-market support
- Advanced machine learning
- Artificial intelligence services
- Fundamental analysis
- Financial statement analysis
- News and sentiment analysis
- Portfolio optimization
- Distributed analytical processing
- Regulatory compliance
- Automated execution
- Cloud-native deployment

Architectural principles defined in this document shall remain stable throughout future platform evolution.

---

# 23. Related Artifacts

### Enterprise Architecture

- PlatformArchitectureVision
- ArchitecturalPrinciples
- QualityAttributes
- RepositoryArchitecture
- ServiceContextMap
- CanonicalDomainModel

### Data Architecture

- ConceptualDataModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix

### Governance

- Architecture Decision Records (ADR)
- Repository Standards
- Documentation Standards
- Development Standards

---

# 24. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial Service Catalog |
| 2026.2 | 2026-07-20 | Complete enterprise redesign aligned with Repository Standard 2026.2, Domain-Driven Design, Service-Oriented Architecture and the canonical domain model |

---

# 25. Approval

## Document Status

**APPROVED FOR ENTERPRISE ARCHITECTURAL BASELINE**

The Canonical Service Catalog is the authoritative reference for defining business services within the Phoenix Platform.

All future service specifications, API contracts, database ownership, implementation decisions and architectural evolution shall conform to the principles and service boundaries defined in this document.

---

## Approval Authority

| Role | Responsibility |
|------|----------------|
| Enterprise Architecture | Owns service architecture |
| Solution Architecture | Defines service realization |
| Development Team | Implements approved services |
| Repository Governance | Maintains architectural consistency |

---

**End of Document**

**Project:** Phoenix Platform  
**Artifact:** ART-020 — CanonicalServiceCatalog  
**Version:** 2026.2  
**Status:** Approved