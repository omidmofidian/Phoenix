# Reference Domain Architecture

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-001 |
| Document | ReferenceDomainArchitecture |
| Version | 2026.1 |
| Status | Approved |
| Classification | Domain Architecture |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Epic 3 — Logical Data Modeling |
| Task | T3-010 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

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

---

# 14. Traceability

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

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Reference Domain Architecture. |