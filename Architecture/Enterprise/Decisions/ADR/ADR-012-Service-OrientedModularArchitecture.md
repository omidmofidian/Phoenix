# ADR-012 : Service-Oriented Modular Architecture

---

## Status

Accepted

---

## Date

2026-06-28

---

## Context

Phoenix is designed as a long-term quantitative trading platform.

The platform consists of multiple independent business capabilities, including:

- Market Data Management
- Technical Indicators
- Feature Engineering
- Machine Learning
- Trading Strategies
- Signal Generation
- Portfolio Management
- Backtesting
- Reporting
- Screening

These capabilities evolve independently and should remain reusable across future projects.

A tightly coupled monolithic architecture would reduce maintainability and software reusability.

Conversely, adopting a full Microservice architecture from the beginning would introduce unnecessary operational complexity for a single-developer project.

An architectural balance is therefore required.

---

## Decision

Phoenix shall adopt a Service-Oriented Modular Architecture.

Each business capability shall be implemented as an autonomous Service.

Each Service shall:

- own a single business responsibility;
- expose a well-defined public contract;
- hide its internal implementation;
- communicate through contracts rather than implementation details.

During Version 1.x, all Services shall execute within a single deployable application (Modular Monolith).

The architecture shall preserve clear service boundaries so that Services may be migrated to independent Microservices in future versions without changes to business logic.

---

## Architectural Principles

1. Every Service has one business responsibility.

2. Services communicate through Contracts.

3. Services never depend on another Service implementation.

4. Core Domain remains independent.

5. Infrastructure contains no business rules.

6. Every Service is independently testable.

7. Future Microservice migration shall require minimal architectural changes.

---

## Initial Service Catalog

- MarketDataService
- IndicatorService
- FeatureService
- ModelService
- StrategyService
- SignalService
- PortfolioService
- BacktestService
- ReportService
- ScreeningService

---

## Rationale

This architecture combines the simplicity of a Modular Monolith with the discipline of Service-Oriented Design.

It supports maintainability, scalability, software reusability, and future architectural evolution while avoiding the operational overhead of Microservices during the early stages of the project.

---

## Consequences

### Advantages

- High modularity
- Strong separation of concerns
- Excellent software reusability
- Easier testing
- Clear service boundaries
- Simplified migration to Microservices
- Lower operational complexity

### Disadvantages

- Requires disciplined interface design
- Additional upfront architectural effort

---

## Related Decisions

ADR-000 Architecture Principles

ADR-001 Core Independence

ADR-009 Canonical Data Dictionary

ADR-010 Containerized Development Environment

ADR-011 Infrastructure as Code

---

## Impact Analysis

Affected Documents

- ReferenceArchitecture.md
- LayerArchitecture.md
- DependencyRules.md
- DeploymentArchitecture.md
- SDD

Future Implementation

- Service Contracts
- Dependency Injection
- Docker Compose
- API Layer

---

End of ADR-012