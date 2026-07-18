# Service Context Map

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ART-021 |
| Document | ServiceContextMap |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Solution Architecture |
| Architecture Layer | Service Architecture |
| Owner | Enterprise Architecture |
| Depends On | BusinessCapabilityMap.md, CanonicalDomainModel.md, DomainResponsibilities.md |
| Used By | Service Specifications, API Design, Integration Architecture, Database Design |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical service ownership model of the Phoenix Platform.

It establishes how Business Capabilities, Business Domains, Aggregates, and Services relate to one another, ensuring that every business responsibility is implemented by exactly one service while preserving clear architectural boundaries.

The Service Context Map provides the authoritative definition of service ownership, collaboration patterns, and dependency rules across the platform.

---

# 2. Objectives

The objectives of this document are to:

- Define service boundaries based on business domains.
- Map Business Capabilities to Services.
- Define aggregate ownership.
- Establish service collaboration principles.
- Prevent overlapping responsibilities.
- Support independent service evolution.
- Enable future distributed deployment.
- Preserve long-term architectural consistency.

---

# 3. Architectural Position

Within the Phoenix Enterprise Architecture, service design is derived from business architecture rather than implementation technology.

The architectural derivation is:

```text
Knowledge
        │
        ▼
Business Capability
        │
        ▼
Business Domain
        │
        ▼
Aggregate
        │
        ▼
Business Service
        │
        ▼
Service Interface
        │
        ▼
Implementation
```

A service is therefore an implementation of one or more business capabilities owned by a specific business domain.

---

# 4. Context Mapping Principles

The following principles govern service ownership.

## SCM-001 — Capability Ownership

Every Business Capability shall belong to exactly one Business Domain.

---

## SCM-002 — Domain Ownership

Every Business Domain shall own one or more Aggregates.

---

## SCM-003 — Aggregate Ownership

Every Aggregate shall belong to exactly one Business Service.

---

## SCM-004 — Single Service Ownership

Every Aggregate Root shall have exactly one owning service.

---

## SCM-005 — Explicit Collaboration

Services collaborate only through published contracts.

Business entities shall never be modified by non-owning services.

---

## SCM-006 — Autonomous Evolution

Services shall evolve independently whenever practical.

Changes to service boundaries require architectural governance.

---

# 5. Business Capability Mapping

The following table illustrates the relationship between Business Capabilities, Domains, and Services.

| Business Capability | Business Domain | Primary Service |
|---------------------|-----------------|-----------------|
| Reference Data Management | Reference Domain | Reference Service |
| Instrument Management | Core Domain | Instrument Service |
| Market Data Management | Market Domain | Market Service |
| Portfolio Management | Portfolio Domain | Portfolio Service |
| Analytics | Analytics Domain | Analytics Service |
| Strategy Management | Strategy Domain | Strategy Service |
| Risk Management | Risk Domain | Risk Service |
| Research & Backtesting | Research Domain | Research Service |
| Integration | Integration Domain | Integration Service |
| Configuration | Configuration Domain | Configuration Service |
| Audit & Governance | Audit Domain | Audit Service |
| Reporting | Reporting Domain | Reporting Service |

This mapping establishes the canonical ownership of enterprise business capabilities.

---

# 6. Domain Context Map

The Phoenix Platform is organized into a collection of autonomous business domains.

Each domain owns its business capabilities, aggregates, entities, and business rules.

```text
Reference Domain
        │
        ├──────────────┐
        │              │
        ▼              ▼
Core Domain      Integration Domain
        │              │
        ├──────┐       │
        ▼      ▼       ▼
Market   Portfolio   Configuration
Domain    Domain        Domain
        │
        ├──────────────┐
        ▼              ▼
Analytics        Research
Domain            Domain
        │
        ▼
Reporting
Domain
```

The Reference Domain provides shared business reference information for all other domains while remaining independent of operational business processes.

---

# 7. Aggregate Ownership

Every Aggregate belongs to exactly one Business Domain and is implemented by one owning service.

| Business Domain | Aggregate | Owning Service |
|-----------------|-----------|----------------|
| Reference Domain | Market Structure | Reference Service |
| Reference Domain | Business Classification | Reference Service |
| Reference Domain | Geographic Reference | Reference Service |
| Reference Domain | Financial Reference | Reference Service |
| Reference Domain | Calendar Reference | Reference Service |
| Core Domain | Financial Instrument | Instrument Service |
| Market Domain | Market Data | Market Service |
| Market Domain | Corporate Actions | Market Service |
| Portfolio Domain | Portfolio | Portfolio Service |
| Analytics Domain | Indicator Analysis | Analytics Service |
| Analytics Domain | Feature Engineering | Analytics Service |
| Strategy Domain | Trading Strategy | Strategy Service |
| Risk Domain | Risk Assessment | Risk Service |
| Research Domain | Backtesting | Research Service |
| Reporting Domain | Reporting | Reporting Service |
| Integration Domain | Provider Integration | Integration Service |
| Configuration Domain | Configuration | Configuration Service |
| Audit Domain | Audit Trail | Audit Service |

Aggregate ownership defines the authoritative source of business rules and lifecycle management.

---

# 8. Service Responsibilities

Each service is responsible for:

- Managing its aggregates.
- Enforcing business rules.
- Preserving data integrity.
- Managing aggregate lifecycles.
- Publishing business events.
- Providing explicit service interfaces.
- Protecting aggregate consistency.

Services shall not assume ownership of aggregates belonging to other domains.

---

# 9. Service Collaboration

Business services collaborate through published interfaces rather than shared persistence.

Supported collaboration patterns include:

## Synchronous Communication

- REST APIs
- gRPC

Used when an immediate response is required.

---

## Asynchronous Communication

- Domain Events
- Event Messaging
- Message Queues

Used for loosely coupled business collaboration.

---

## Batch Collaboration

- Scheduled Synchronization
- Bulk Import
- Bulk Export

Used for high-volume integration scenarios.

Direct database access between services is prohibited.

---

# 10. Dependency Rules

Service dependencies shall follow the business architecture.

The permitted dependency direction is:

```text
Reference Service
        │
        ▼
Instrument Service
        │
        ▼
Market Service
        │
        ▼
Portfolio Service
        │
        ▼
Analytics Service
        │
        ▼
Strategy Service
        │
        ▼
Research Service
        │
        ▼
Reporting Service
```

Cross-domain dependencies shall be minimized.

Circular service dependencies are prohibited.

Infrastructure services may support multiple business services without owning business capabilities.

---

# 11. Service Interface Principles

Every Business Service shall expose its capabilities through explicit, versioned, and well-defined interfaces.

Service interfaces shall satisfy the following principles:

- Business-oriented
- Technology independent
- Version controlled
- Backward compatible whenever practical
- Secure by default
- Fully documented
- Independently testable

Service interfaces represent business contracts rather than implementation details.

---

# 12. Ownership Rules

Ownership defines both responsibility and authority.

The owning service is exclusively responsible for:

- Business rules
- Aggregate lifecycle
- Data validation
- Consistency enforcement
- Persistence management
- Version compatibility
- Business event publication

Other services may consume business information only through published interfaces.

No service may modify another service's aggregates directly.

---

# 13. Governance

Changes to service boundaries shall be governed through the Phoenix Architecture Governance process.

Governance activities include:

1. Business capability analysis
2. Domain boundary validation
3. Aggregate ownership review
4. Dependency impact assessment
5. Architecture approval
6. Repository update
7. Version publication

Service boundaries are expected to remain stable over time.

Changes shall occur through architectural evolution rather than incremental implementation decisions.

Major ownership changes require an approved Architecture Decision Record (ADR).

---

# 14. Traceability

Every service defined within the Phoenix Platform shall be traceable to its business origin.

```text
Business Vision
        │
        ▼
Business Capability Map
        │
        ▼
Canonical Domain Model
        │
        ▼
Domain Responsibilities
        │
        ▼
Service Context Map
        │
        ▼
Service Specification
        │
        ▼
API Specification
        │
        ▼
Database Design
        │
        ▼
Implementation
```

This traceability ensures architectural consistency across all layers of the platform.

---

# 15. Related Documents

## Vision

- PlatformArchitectureVision.md
- ReferenceArchitecture.md
- KnowledgeDrivenArchitecture.md

## Business Architecture

- BusinessCapabilityMap.md
- CanonicalDomainModel.md
- DomainResponsibilities.md

## Domain Architecture

- ReferenceDomainArchitecture.md

## Data Architecture

- ReferenceDataModel.md
- EntityClassification.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

## Service Architecture

- CanonicalServiceCatalog.md

## Governance

- ArchitecturalPrinciples.md
- QualityAttributes.md
- CanonicalBusinessRules.md
- Architecture Decision Records (ADR)

---

# 16. Success Criteria

The Service Context Map is considered complete when:

- Every Business Capability is assigned to exactly one Business Domain.
- Every Business Domain has clearly defined service ownership.
- Every Aggregate has a single owning service.
- Service collaboration occurs exclusively through published interfaces.
- Cross-domain ownership is eliminated.
- Circular dependencies are absent.
- All service boundaries remain traceable to the Business Capability Map and Canonical Domain Model.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |
| 2026.2 | 2026-07-18 | Complete architectural redesign aligned with the Phoenix Enterprise Architecture Framework, Business Capability Model, Domain Architecture, and Knowledge-Driven Architecture. |