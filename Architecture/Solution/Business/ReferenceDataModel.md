# Reference Data Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DAT-001 |
| Document | ReferenceDataModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Architecture |
| Architecture Layer | Data Architecture |
| Owner | Enterprise Architecture Team |
| Depends On | PlatformArchitectureVision, ReferenceArchitecture, ReferenceDomainArchitecture, CanonicalDomainModel |
| Used By | LogicalDatabaseModel, PhysicalDatabaseModel, EnterpriseDataDictionary |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the Canonical Reference Data Model of the Phoenix Platform.

It specifies the architectural structure of enterprise reference data, the categories of reference entities, their canonical relationships, governance principles, and lifecycle characteristics.

The model provides a stable, technology-independent representation of enterprise reference information that supports all business domains, services, analytical components, and future market expansions.

The Reference Data Model serves as the authoritative foundation for logical and physical data modeling throughout the platform.

---

# 2. Objectives

The objectives of the Reference Data Model are to:

- Establish a canonical representation of enterprise reference data.
- Eliminate duplication of reference information.
- Standardize enterprise classifications.
- Support consistent business semantics.
- Enable enterprise-wide reuse.
- Provide a stable foundation for logical database design.
- Support multi-market expansion.
- Preserve long-term architectural consistency.

---

# 3. Scope

This model applies to all enterprise reference data shared across multiple business domains.

Reference data shall be reusable by:

- Business Domains
- Business Services
- Data Services
- Analytical Services
- Artificial Intelligence Services
- Reporting Services
- Integration Services

Reference data represents business knowledge rather than operational business activity.

---

# 4. Architectural Principles

The Reference Data Model follows the architectural principles defined by the Phoenix Enterprise Architecture.

Key principles include:

- Single Source of Truth
- Canonical Data Representation
- Technology Independence
- Stable Business Semantics
- Enterprise Reuse
- Controlled Evolution
- Separation of Reference and Transaction Data
- Extensibility Without Redesign

Reference data shall remain independent of implementation technologies and operational workflows.

---

# 5. Reference Data Architecture

Reference Data occupies the foundational layer of enterprise data architecture.

```text
Business Knowledge
        │
        ▼
Reference Domain Architecture
        │
        ▼
Reference Data Model
        │
        ▼
Logical Data Model
        │
        ▼
Physical Database Model
```

The Reference Data Model translates business reference knowledge into a canonical data architecture while remaining independent of database implementation.

---

# 6. Reference Entity Categories

Reference entities are organized into enterprise categories according to their business purpose.

### Geographic Reference

Defines geographical concepts shared across the enterprise.

Examples include countries, regions, cities, and geopolitical areas.

---

### Financial Reference

Defines financial concepts that are common across markets.

Examples include currencies, settlement methods, and financial classifications.

---

### Market Reference

Defines financial market structures and trading environments.

Examples include markets, exchanges, trading boards, and market segments.

---

### Classification Reference

Defines business taxonomies used for organizing financial information.

Examples include asset classes, instrument types, sectors, industries, and sub-industries.

---

### Calendar Reference

Defines enterprise calendars and business schedules.

Examples include trading calendars, holidays, settlement calendars, and trading sessions.

---

### Localization Reference

Defines language and regional settings used throughout the platform.

Examples include languages, locales, time zones, and regional conventions.

---

### Integration Reference

Defines shared reference information required for external system integration.

Examples include data providers, external code systems, and identifier registries.

---

# 7. Canonical Reference Entity Catalog

The Reference Data Model defines the canonical categories of enterprise reference entities.

Each reference entity belongs to exactly one reference category and shall have a single authoritative business owner.

Reference entities are intentionally stable and reusable across the platform.

---

## 7.1 Geographic Reference

Purpose

Provides standardized geographical information used throughout the platform.

Typical reference entities include:

- Country
- Region
- City
- Time Zone

These entities support localization, regulatory compliance, and international market expansion.

---

## 7.2 Financial Reference

Purpose

Provides standardized financial classifications and monetary concepts.

Typical reference entities include:

- Currency
- Currency Pair
- Settlement Type

Financial reference entities are shared across multiple financial markets.

---

## 7.3 Market Reference

Purpose

Defines the organizational structure of financial markets.

Typical reference entities include:

- Market
- Exchange
- Trading Board
- Market Segment

These entities establish the structural hierarchy of trading environments.

---

## 7.4 Classification Reference

Purpose

Provides reusable business classifications for financial instruments and business entities.

Typical reference entities include:

- Asset Class
- Instrument Type
- Sector
- Industry
- Sub-Industry

Classification entities provide a canonical taxonomy that supports analytics, reporting, and portfolio management.

---

## 7.5 Calendar Reference

Purpose

Defines enterprise calendars and business schedules.

Typical reference entities include:

- Trading Calendar
- Trading Session
- Holiday Calendar
- Settlement Calendar

Calendar entities provide consistent temporal definitions across the platform.

---

## 7.6 Localization Reference

Purpose

Supports multilingual and multinational platform capabilities.

Typical reference entities include:

- Language
- Locale
- Regional Format

Localization entities ensure consistent presentation of business information across regions.

---

## 7.7 Integration Reference

Purpose

Supports standardized interaction with external systems.

Typical reference entities include:

- Data Provider
- External Identifier Type
- External Code System

Integration reference entities isolate external systems from the canonical enterprise model.

---

# 8. Canonical Relationships

Reference entities are organized through normalized parent-child relationships.

The following relationships define the canonical reference hierarchy.

```text
Market
    └── Exchange
            └── Trading Board

Asset Class
    └── Instrument Type

Sector
    └── Industry
            └── Sub-Industry

Trading Calendar
    ├── Trading Session
    └── Holiday Calendar
```

Only direct parent-child relationships shall be stored.

Derived relationships shall be resolved through navigation rather than duplication.

---

# 9. Reference Data Governance

Reference data is governed as an enterprise asset.

Governance responsibilities include:

- Definition of canonical business meaning.
- Approval of new reference entities.
- Lifecycle management.
- Classification governance.
- Identifier governance.
- Version management.
- Deprecation management.
- Change control.

Every reference entity shall have a designated business owner responsible for maintaining its semantic integrity.

---

# 10. Reference Data Lifecycle

Reference data evolves through controlled governance rather than operational business processes.

Typical lifecycle stages include:

1. Proposal
2. Review
3. Approval
4. Publication
5. Operational Use
6. Revision
7. Deprecation
8. Retirement

Reference data changes shall preserve backward compatibility whenever practical.

Deprecated reference entities shall remain traceable until all dependent artifacts have been migrated.

---

# 11. Business Rules

The following enterprise business rules govern the Reference Data Model.

**RDM-001**

Every reference entity shall have exactly one canonical definition.

**RDM-002**

Every reference entity shall belong to exactly one reference category.

**RDM-003**

Reference entities shall remain independent of operational business transactions.

**RDM-004**

Reference data shall be reusable across multiple business domains.

**RDM-005**

Reference classifications shall not be duplicated within business entities.

**RDM-006**

Only direct hierarchical relationships shall be persisted.

Derived relationships shall be resolved through the canonical hierarchy.

**RDM-007**

Reference data shall support multiple financial markets without requiring structural redesign.

**RDM-008**

Every reference entity shall have a stable business identifier.

**RDM-009**

External provider identifiers shall never replace canonical enterprise identifiers.

External identifiers shall be maintained through explicit mapping.

**RDM-010**

Business meaning shall always take precedence over physical implementation.

---

# 12. Design Principles

Logical and physical database models derived from this document shall comply with the following principles.

- Fully normalized reference structures.
- Canonical ownership of reference entities.
- Stable business semantics.
- Explicit parent-child relationships.
- Extensible classification hierarchies.
- Technology-independent business definitions.
- Separation of reference data from transactional data.
- Preservation of historical compatibility.

---

# 13. Traceability

The Reference Data Model provides the foundation for downstream design artifacts.

```text
PlatformArchitectureVision
            │
            ▼
ReferenceArchitecture
            │
            ▼
ReferenceDomainArchitecture
            │
            ▼
ReferenceDataModel
            │
            ├── LogicalDatabaseModel
            ├── PhysicalDatabaseModel
            ├── EnterpriseDataDictionary
            ├── CanonicalERD
            └── Database Standards
```

All derived artifacts shall preserve the canonical structure defined by this model.

---

# 14. Related Documents

## Vision

- PlatformArchitectureVision.md
- ReferenceArchitecture.md
- KnowledgeDrivenArchitecture.md
- ArchitecturalPrinciples.md

## Business Architecture

- BusinessCapabilityMap.md
- CanonicalDomainModel.md
- DomainResponsibilities.md

## Domain Architecture

- ReferenceDomainArchitecture.md

## Data Architecture

- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md
- CanonicalERD.md

## Governance

- BusinessGlossary.md
- CanonicalBusinessRules.md
- Architecture Decision Records (ADR)

---

# 15. Success Criteria

The Reference Data Model is considered successful when:

- Enterprise reference data has a single canonical representation.
- Reference entities are consistently reused across all business domains.
- Canonical relationships remain normalized and unambiguous.
- Reference classifications support multi-market expansion.
- External identifiers are isolated from canonical business identifiers.
- Downstream logical and physical data models are fully traceable to this model.
- The model remains stable as new markets, instruments, and services are introduced.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version. |
| 2026.2 | 2026-07-18 | Complete redesign as an Enterprise Data Architecture artifact aligned with the Phoenix Architecture Framework. |