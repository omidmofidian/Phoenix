# Reference Domain Architecture

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-001 |
| Document | ReferenceDomainArchitecture |
<<<<<<< HEAD
| Version | 2026.1 |
| Status | Approved |
| Classification | Domain Architecture |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Epic 3 — Logical Data Modeling |
| Task | T3-010 |
| Last Updated | 2026-07-07 |
=======
| Version | 2026.2 |
| Status | Approved |
| Classification | Business Domain Architecture |
| Architecture Layer | Domain Architecture |
| Owner | Enterprise Architecture Team |
| Depends On | PlatformArchitectureVision, ReferenceArchitecture, BusinessCapabilityMap, CanonicalDomainModel |
| Used By | ReferenceDataModel, LogicalDatabaseModel, PhysicalDatabaseModel, EnterpriseDataDictionary |
| Last Updated | 2026-07-18 |
>>>>>>> 8ed4328 (refactor(architecture): establish the canonical enterprise architecture baseline)

---

# 1. Purpose

<<<<<<< HEAD
This document defines the architectural boundaries, responsibilities, capabilities, and canonical business concepts of the Reference Domain.

The Reference Domain provides enterprise-wide master reference data shared across all services within the Phoenix Platform.

It serves as the authoritative source for static or slowly changing business reference information.

---

# 2. Scope

The Reference Domain includes enterprise reference data that is:

- Shared across multiple domains
- Technology independent
- Business-oriented
- Stable over time
- Centrally governed

The Reference Domain does not contain transactional or analytical data.

---

# 3. Mission

The mission of the Reference Domain is to provide a single source of truth for all common business reference entities required by the Phoenix Platform.

This ensures consistency, interoperability, and reuse across all services.

---

# 4. Responsibilities

The Reference Domain is responsible for:

- Managing enterprise reference entities
- Maintaining canonical business classifications
- Providing standardized identifiers
- Supporting localization
- Supporting international markets
- Supporting multiple data providers
- Providing reference information to all business domains

---

# 5. Out of Scope

The Reference Domain shall not manage:

- Trading data
- Portfolio data
- Market prices
- Candlestick history
- Technical indicators
- Trading signals
- Machine learning models
- User-specific configurations

These belong to their respective business domains.

---

# 6. Core Business Capabilities

The Reference Domain provides the following capabilities:

- Geographic Reference Management
- Financial Reference Management
- Market Reference Management
- Classification Management
- Localization Management
- Calendar Management
- Provider Registry

---

# 7. Canonical Reference Entities

## Geographic

- Country
- Region
- City
- TimeZone

---

## Localization

- Language
- Locale

---

## Financial

- Currency
- CurrencyPair

---

## Market

- Market
- Exchange
- TradingCalendar
- TradingSession

---

## Classification

- AssetClass
- InstrumentType
- Sector
- Industry

---

## Integration

- DataProvider
- DataSource

---

## Calendar

- HolidayCalendar

---

# 8. Domain Consumers

The Reference Domain is consumed by:

- Market Service
- Portfolio Service
- Analytics Service
- Machine Learning Service
- Configuration Service
- Integration Service
- Reporting Service

The Reference Domain has no dependency on these domains.

---

# 9. Domain Dependencies

The Reference Domain depends only on:

- Enterprise Standards
- Enterprise Data Dictionary

It shall not depend on any business domain.

---

# 10. Architectural Principles

The Reference Domain follows these principles:

- Single Source of Truth
- Canonical Data Model
- Immutable Business Meaning
- Technology Independence
- Reusable Services
- Low Coupling
- High Cohesion

---

# 11. Service Boundary

The Reference Domain shall be implemented as an independent service.

Other services shall access reference information through published interfaces rather than maintaining duplicate reference data.

---

# 12. Aggregate Overview

The initial aggregates within the Reference Domain are:

- Geographic Aggregate
- Financial Aggregate
- Market Aggregate
- Classification Aggregate
- Localization Aggregate
- Provider Aggregate
- Calendar Aggregate

Aggregate definitions are refined during logical modeling.

---

# 13. Architectural Constraints

The following constraints apply:

- Reference entities shall have globally unique identifiers.
- Business meaning shall remain stable across versions.
- Duplicate reference entities are prohibited.
- Every entity shall belong to exactly one aggregate.
- Cross-domain ownership is prohibited.
=======
This document defines the business architecture of the Reference Domain within the Phoenix Platform.

It establishes the mission, responsibilities, business capabilities, ownership boundaries, and governance principles of the Reference Domain independently of implementation technologies, database structures, or software components.

The Reference Domain serves as the authoritative business source for enterprise reference information shared across all domains of the platform.

---

# 2. Domain Vision

The Reference Domain provides a stable and canonical foundation for enterprise-wide business knowledge.

Rather than managing operational business events, this domain defines the common business vocabulary, classifications, identifiers, calendars, and reference concepts that enable consistent interpretation of financial information throughout the Phoenix Platform.

The Reference Domain minimizes duplication, promotes interoperability, and preserves semantic consistency across all business domains.

---

# 3. Domain Mission

The mission of the Reference Domain is to establish and govern the enterprise reference knowledge required by all business capabilities.

The domain ensures that common business concepts are defined once, governed centrally, and reused consistently across the entire platform.

---

# 4. Business Scope

The Reference Domain includes business concepts that are:

- Enterprise-wide
- Canonical
- Stable over time
- Shared across multiple domains
- Technology independent
- Business oriented
- Centrally governed

Reference information represents business knowledge rather than operational activity.

---

# 5. Domain Responsibilities

The Reference Domain is responsible for:

- Defining enterprise reference concepts.
- Managing canonical business classifications.
- Governing enterprise identifiers.
- Maintaining reference taxonomies.
- Managing business calendars.
- Supporting localization.
- Supporting internationalization.
- Standardizing business vocabularies.
- Publishing enterprise reference information.
- Preserving semantic consistency across domains.

The Reference Domain does not perform operational business processing.

---

# 6. Business Capabilities

The Reference Domain owns the following business capabilities.

### BC-RD-001 Enterprise Classification Management

Provides standardized enterprise classifications used throughout the platform.

---

### BC-RD-002 Financial Reference Management

Maintains financial reference concepts shared across business domains.

---

### BC-RD-003 Market Reference Management

Defines reference information describing financial markets and exchanges.

---

### BC-RD-004 Calendar Management

Maintains enterprise business calendars and trading calendars.

---

### BC-RD-005 Localization Management

Provides language, locale, regional and international reference information.

---

### BC-RD-006 Enterprise Identifier Management

Maintains canonical business identifiers used across the platform.

---

# 7. Domain Boundaries

The Reference Domain defines enterprise business knowledge but does not execute business operations.

Its responsibility ends at defining and governing canonical reference information.

Operational domains consume this knowledge but do not own it.

The following principles define the domain boundary.

### Inside the Domain

The Reference Domain owns:

- Enterprise reference concepts
- Business classifications
- Business taxonomies
- Enterprise code systems
- Market reference definitions
- Trading calendars
- Localization standards
- Enterprise naming standards
- Canonical business vocabularies
- Reference data governance

### Outside the Domain

The Reference Domain does not own:

- Market observations
- Historical market data
- Trading activities
- Portfolio management
- Investment strategies
- Technical indicators
- Machine learning models
- Business transactions
- User preferences
- Runtime configuration

These responsibilities belong to their respective business domains.

---

# 8. Domain Ownership

The Reference Domain is the sole authoritative owner of enterprise reference knowledge.

Every reference concept shall have exactly one business owner.

Business ownership includes:

- Business definition
- Semantic consistency
- Lifecycle governance
- Identifier governance
- Classification governance
- Change approval

Ownership shall never be shared across domains.

---

# 9. Domain Context

The Reference Domain collaborates with other business domains through published business knowledge.

```text
                    Reference Domain
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
     Core Domain      Market Domain     Integration Domain
        │                  │                  │
        ├──────────────────┼──────────────────┤
        ▼                  ▼                  ▼
 Analytics Domain    Portfolio Domain   Reporting Domain
```

The Reference Domain publishes reference information.

It does not consume operational business information from other domains.

---

# 10. Domain Interaction Principles

Interactions with other domains shall follow these principles.

- Reference knowledge is published once and reused everywhere.
- Business domains shall reference canonical concepts rather than redefine them.
- Duplicate reference definitions are prohibited.
- Communication shall occur through published services and governed interfaces.
- Reference knowledge shall remain independent of operational workflows.

---

# 11. Business Rules

The following high-level business rules govern the Reference Domain.

**BR-RD-001**

Every enterprise reference concept shall have exactly one canonical definition.

**BR-RD-002**

Reference concepts shall remain technology independent.

**BR-RD-003**

Business meaning shall take precedence over implementation details.

**BR-RD-004**

Reference information shall be reusable across multiple business domains.

**BR-RD-005**

Changes to enterprise reference knowledge shall follow formal governance procedures.

**BR-RD-006**

Reference concepts shall evolve through controlled extension rather than redefinition.

---

# 12. Domain Constraints

The following architectural constraints apply.

- Reference knowledge shall remain implementation independent.
- Reference knowledge shall not contain operational business events.
- Business semantics shall remain stable across platform evolution.
- Enterprise classifications shall be centrally governed.
- Canonical business terminology shall be preserved.
- Reference concepts shall support multi-market expansion.

---

# 13. Governance

The Reference Domain is governed by the enterprise architecture governance model.

Changes affecting reference knowledge require:

- Architecture Review
- Business Impact Assessment
- Domain Owner Approval
- Repository Update
- Version Control

Reference concepts shall evolve through controlled governance to preserve long-term consistency across the platform.
>>>>>>> 8ed4328 (refactor(architecture): establish the canonical enterprise architecture baseline)

---

# 14. Traceability

<<<<<<< HEAD
This document is governed by:

- PlatformArchitectureVision.md
- ArchitecturalPrinciples.md
- CanonicalDomainModel.md
- CanonicalBusinessRules.md
- CanonicalAggregateCatalog.md
- ServiceContextMap.md
- EnterpriseDataDictionaryStandard.md
- BusinessGlossary.md

---

# 15. Related Design Documents

The following design documents derive from this architecture:

- ReferenceDomainLogicalModel.md
- ReferenceEntityDefinitions.md
- ReferenceRelationships.md
- ReferenceLogicalERD.md
- ReferenceValidation.md

---

# 16. Exit Criteria

The Reference Domain Architecture is considered complete when:

- Domain boundaries are approved.
- Business capabilities are defined.
- Canonical entities are identified.
- Aggregate candidates are identified.
- Architectural dependencies are validated.
- Governance approval is granted.
=======
The Reference Domain Architecture is derived from the enterprise architectural vision and provides architectural guidance for downstream design artifacts.

```text
PlatformArchitectureVision
            │
            ▼
KnowledgeDrivenArchitecture
            │
            ▼
BusinessCapabilityMap
            │
            ▼
CanonicalDomainModel
            │
            ▼
ReferenceDomainArchitecture
            │
            ▼
ReferenceDataModel
            │
            ▼
LogicalDatabaseModel
            │
            ▼
PhysicalDatabaseModel
            │
            ▼
EnterpriseDataDictionary
```

Every design artifact derived from the Reference Domain shall preserve semantic consistency with this architecture.

---

# 15. Related Documents

## Vision

- PlatformArchitectureVision.md
- ReferenceArchitecture.md
- KnowledgeDrivenArchitecture.md
- ArchitecturalPrinciples.md
- QualityAttributes.md

## Business Architecture

- BusinessCapabilityMap.md
- CanonicalDomainModel.md
- DomainResponsibilities.md
- EntityClassification.md

## Design

- ReferenceDataModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

## Governance

- Architecture Decision Records (ADR)
- BusinessGlossary.md
- CanonicalBusinessRules.md

---

# 16. Success Criteria

The Reference Domain Architecture is considered successful when:

- The business boundary of the Reference Domain is clearly defined.
- Ownership of enterprise reference knowledge is explicit and unambiguous.
- Business capabilities are independent of implementation technologies.
- All business domains consistently reuse canonical reference knowledge.
- Semantic consistency is maintained across the platform.
- The architecture supports future market expansion without structural redesign.
- Downstream design artifacts are fully traceable to this domain architecture.
>>>>>>> 8ed4328 (refactor(architecture): establish the canonical enterprise architecture baseline)

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
<<<<<<< HEAD
| 2026.1 | 2026-07-07 | Initial Reference Domain Architecture. |
=======
| 2026.1 | 2026-07-07 | Initial version. |
| 2026.2 | 2026-07-18 | Complete redesign as a Business Domain Architecture aligned with the Phoenix Enterprise Architecture and Knowledge-Driven Architecture. |
>>>>>>> 8ed4328 (refactor(architecture): establish the canonical enterprise architecture baseline)
