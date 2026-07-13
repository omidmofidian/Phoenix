# Canonical Service Catalog

| Property | Value |
|----------|-------|
| Artifact ID | ART-020 |
| Project | Phoenix Platform |
| Document | CanonicalServiceCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Architecture Layer | Service Architecture |
| Owner | Architecture Team |
| Sprint | Sprint 2 |
| Depends On | PlatformArchitectureVision, ArchitecturalPrinciples, CanonicalDomainModel |
| Consumed By | Service Specifications, API Design, Database Design, Implementation |
| Last Updated | 2026-07-04 |

---

# 1. Purpose

This document defines the canonical service architecture of the Phoenix Platform.

It establishes the complete catalog of business services, their responsibilities, ownership boundaries, dependencies, and interactions.

The Service Catalog serves as the authoritative reference for all future service implementations and architectural decisions.

---

# 2. Objectives

The objectives of this document are:

- Define the canonical business services.
- Establish clear service boundaries.
- Prevent overlapping responsibilities.
- Promote service reusability.
- Support independent deployment.
- Enable future microservice architecture.
- Provide traceability between business capabilities and implementation.

---

# 3. Service Design Principles

Every service shall:

- Own a single business capability.
- Have a clearly defined responsibility.
- Be loosely coupled.
- Be highly cohesive.
- Be independently deployable.
- Be independently testable.
- Expose explicit service contracts.
- Own its business data.
- Avoid direct database access to other services.
- Communicate through defined interfaces.

---

# 4. Service Classification

Phoenix services are classified into four categories.

## Core Services

Core business capabilities of the platform.

## Supporting Services

Business support capabilities shared by multiple domains.

## Shared Services

Cross-cutting enterprise services.

## Future Services

Services reserved for future platform evolution.

---

# 5. Canonical Service Catalog

| ID | Service | Category | Primary Capability | Status |
|----|----------|----------|--------------------|--------|
| SVC-001 | Reference Service | Core | Reference Data Management | Planned |
| SVC-002 | Market Service | Core | Market Data Management | Planned |
| SVC-003 | Instrument Service | Core | Financial Instrument Management | Planned |
| SVC-004 | Feature Service | Core | Feature Extraction | Planned |
| SVC-005 | Analytics Service | Core | Quantitative Analytics | Planned |
| SVC-006 | AI Service | Core | Machine Learning & AI | Planned |
| SVC-007 | Strategy Service | Core | Trading Strategy Management | Planned |
| SVC-008 | Ranking Service | Core | Opportunity Ranking | Planned |
| SVC-009 | Risk Service | Core | Risk Management | Planned |
| SVC-010 | Portfolio Service | Core | Portfolio Management | Planned |
| SVC-011 | Integration Service | Supporting | External Systems Integration | Planned |
| SVC-012 | Reporting Service | Supporting | Reporting & Visualization | Planned |
| SVC-013 | Notification Service | Supporting | Alerts & Notifications | Planned |
| SVC-014 | Configuration Service | Shared | Configuration Management | Planned |
| SVC-015 | Audit Service | Shared | Audit & Traceability | Planned |
| SVC-016 | Execution Service | Future | Trade Execution | Future |

---

# 6. Service Responsibilities

## Reference Service

Responsible for maintaining canonical reference data shared across the platform.

Examples include:

- Exchanges
- Markets
- Countries
- Currencies
- Trading Calendars
- Reference Classifications

---

## Market Service

Responsible for acquiring, validating, normalizing and maintaining market data.

Responsibilities include:

- Historical Prices
- Market Sessions
- Corporate Actions
- Data Validation
- Data Normalization

---

## Instrument Service

Responsible for managing tradable financial instruments.

Examples include:

- Stocks
- ETFs
- Indices
- Forex Pairs
- Cryptocurrencies
- Commodities

---

## Feature Service

Responsible for transforming raw market data into analytical features.

Examples include:

- Technical Indicators
- Statistical Features
- Derived Factors
- Feature Sets

---

## Analytics Service

Responsible for quantitative analysis.

Examples include:

- Statistical Analysis
- Factor Analysis
- Correlation
- Performance Evaluation
- Backtesting

---

## AI Service

Responsible for machine learning and intelligent prediction.

Examples include:

- Model Training
- Inference
- Classification
- Prediction
- Optimization

---

## Strategy Service

Responsible for trading strategies.

Examples include:

- Strategy Definitions
- Entry Rules
- Exit Rules
- Signal Generation

---

## Ranking Service

Responsible for evaluating investment opportunities.

Examples include:

- Opportunity Scoring
- Ranking
- Filtering
- Prioritization

---

## Risk Service

Responsible for investment risk assessment.

Examples include:

- Position Risk
- Portfolio Risk
- Exposure
- Risk Limits

---

## Portfolio Service

Responsible for portfolio management.

Examples include:

- Holdings
- Allocation
- Performance
- Rebalancing

---

## Integration Service

Responsible for communication with external providers.

Examples include:

- Market APIs
- Broker APIs
- Codal
- News Providers
- External Services

---

## Reporting Service

Responsible for reports and dashboards.

---

## Notification Service

Responsible for alerts and messaging.

---

## Configuration Service

Responsible for centralized platform configuration.

---

## Audit Service

Responsible for audit logging and business traceability.

---

## Execution Service

Reserved for future trade execution capabilities.

---

# 7. Service Ownership

Each business capability shall be owned by exactly one service.

Business capability ownership shall never overlap.

Duplicate implementations are prohibited.

---

# 8. Service Communication Principles

Services communicate through explicit contracts.

Direct database sharing is prohibited.

Communication mechanisms may include:

- REST APIs
- gRPC
- Event Messaging
- Scheduled Synchronization

The communication mechanism shall not affect service ownership.

---

# 9. Service Dependency Rules

Dependencies shall always point toward stable business capabilities.

Circular dependencies are prohibited.

Shared services shall not depend on core business services.

Future services shall not influence current architecture.

---

# 10. Data Ownership

Every business entity shall have exactly one owning service.

Other services may consume business information through published interfaces only.

Database-level coupling between services is prohibited.

---

# 11. Service Evolution

The platform shall evolve by introducing new services rather than modifying existing responsibilities.

New business capabilities shall be implemented as new services whenever practical.

---

# 12. Traceability

Every service shall be traceable to:

- Business Capability
- Bounded Context
- Domain Model
- Business Rules
- Architecture Decision Records (ADR)

---

# 13. Future Evolution

The Service Catalog is expected to evolve as the platform expands to support:

- Additional financial markets
- New analytical capabilities
- Advanced AI services
- Portfolio optimization
- Automated execution
- Regulatory compliance
- Distributed deployment

The architectural principles defined in this document shall remain stable throughout the evolution of the platform.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |