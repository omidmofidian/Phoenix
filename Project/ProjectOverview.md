# Project Overview

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-001 |
| Document | ProjectOverview |
| Version | 2026.2 |
| Status | Approved |
| Classification | Architecture Governance |
| Owner | Architecture Team |
| Repository | Phoenix |
| Architecture Style | Domain-Driven Design (DDD) |
| Development Methodology | Architecture First |
| Database Platform | PostgreSQL 17 |
| Deployment Platform | Docker |
| Last Updated | 2026-07-04 |

---

# 1. Introduction

Phoenix Platform is an enterprise-grade quantitative analysis platform designed to support investment decision-making across multiple financial markets.

The platform combines market data, quantitative analysis, statistical methods, machine learning, and modular services to evaluate, rank, and manage investment opportunities.

Phoenix is designed as a long-term software platform rather than a single application. Its architecture emphasizes modularity, maintainability, scalability, and technology independence.

---

# 2. Mission

The mission of Phoenix is to establish a canonical enterprise platform capable of supporting:

- Quantitative market analysis
- Investment opportunity evaluation
- Risk management
- Portfolio management
- Machine learning workflows
- Financial data integration
- Multi-market support

The platform architecture is intended to remain stable while allowing services and technologies to evolve independently.

---

# 3. Architectural Vision

Phoenix follows an **Architecture First** approach.

Business architecture is defined before database implementation.

Logical design precedes physical design.

Implementation is derived from architectural artifacts rather than driving them.

All platform components shall trace back to a single canonical business model.

---

# 4. Architectural Principles

The platform is based on the following principles.

- Domain-Driven Design (DDD)
- Architecture First
- Documentation as Code
- Business Before Technology
- Canonical Domain Model
- Service-Oriented Architecture
- Independent Service Ownership
- Technology Independence
- Explicit Architectural Governance
- Long-Term Maintainability

Detailed principles are defined in:

- ArchitecturalPrinciples.md
- PlatformArchitectureVision.md
- QualityAttributes.md

---

# 5. Repository Organization

The repository is organized into architecture-driven sections.

```text
Docs/

Architecture/
    ADR/
    DomainModel/
    Services/
    Vision/
    Governance/

Design/

Standards/

RunBooks/

Deployment/
```

The repository structure is considered part of the platform architecture and shall remain stable.

---

# 6. Architecture Layers

The platform architecture is organized into the following layers.

### Vision

Defines long-term objectives and architectural direction.

### Governance

Defines project governance, roadmap, sprint reviews, and architectural decisions.

### Domain

Defines business concepts, entities, business rules, aggregates, and relationships.

### Services

Defines service boundaries, ownership, and interactions.

### Design

Transforms business architecture into logical and physical database models.

### Implementation

Contains SQL scripts, services, APIs, and application source code.

---

# 7. Current Project Status

| Sprint | Objective | Status |
|---------|-----------|--------|
| Sprint 1 | PostgreSQL Infrastructure | Completed |
| Sprint 2 | Enterprise Business Architecture | Completed |
| Sprint 3 | Logical Database Design | Planned |
| Sprint 4 | Physical Database Design | Planned |
| Sprint 5 | Database Implementation | Planned |
| Sprint 6 | Service Foundation | Planned |
| Sprint 7 | Analytics & AI Services | Planned |
| Sprint 8 | User Applications & Integration | Planned |

The official roadmap is maintained in **RoadmapRevision2026.2.md**.

---

# 8. Completed Architecture

The following architectural artifacts have been completed.

## Vision

- PlatformArchitectureVision
- ArchitecturalPrinciples
- QualityAttributes

---

## Domain Architecture

- BusinessCapabilityMap
- BoundedContextDefinition
- CanonicalDomainModel
- EntityCatalog
- CanonicalBusinessRules
- ConceptualRelationships
- AggregateDefinitions

---

## Service Architecture

- CanonicalServiceCatalog
- ServiceContextMap

---

## Governance

- ProjectOverview
- Sprint1Overview
- Sprint1ArchitectureReview
- Sprint2Overview
- Sprint2ArchitectureReview
- RoadmapRevision2026.2

---

# 9. Development Roadmap

The project progresses through the following phases.

1. Infrastructure Foundation
2. Enterprise Business Architecture
3. Logical Database Design
4. Physical Database Design
5. Database Implementation
6. Service Development
7. Analytics and Artificial Intelligence
8. User Applications and Platform Integration

Each phase depends on the successful completion and approval of the previous phase.

---

# 10. Governance

Architectural governance is maintained through:

- Architecture Decision Records (ADR)
- Sprint Reviews
- Architecture Reviews
- Repository Standards
- Documentation Standards
- Change Control

Major architectural artifacts are frozen upon approval and may only be modified through an approved architecture review.

---

# 11. Long-Term Vision

Phoenix aims to become a comprehensive enterprise platform for quantitative financial analysis.

The platform is designed to support multiple financial markets, reusable services, independent deployment, and future expansion without requiring architectural redesign.

Every implementation artifact—including databases, services, APIs, and applications—shall be derived from the canonical enterprise architecture maintained within this repository.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial project overview. |
| 2026.2 | 2026-07-04 | Updated after Sprint 2 completion and roadmap revision. |