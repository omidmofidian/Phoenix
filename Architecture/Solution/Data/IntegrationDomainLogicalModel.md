# Integration Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-004 |
| Document | IntegrationDomainLogicalModel |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Architecture Team |
| Depends On | ReferenceDomainLogicalModel, CoreDomainLogicalModel, CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical logical representation of the Integration Domain within the Phoenix Platform.

The Integration Domain isolates external information providers from the enterprise business model by maintaining provider definitions and external business identifiers.

It ensures that the internal business model remains independent of external systems, vendor-specific identifiers and integration technologies.

---

# 2. Scope

## Included Aggregates

- Data Provider
- External Identifier

## Excluded Aggregates

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar
- Company
- Instrument
- Instrument Listing
- Daily Market Data
- Corporate Action

---

# 3. Architectural Role

The Integration Domain acts as the enterprise Anti-Corruption Layer (ACL).

Its responsibilities include:

- Registering external data providers.
- Managing mappings between enterprise entities and provider-specific identifiers.
- Preserving internal business identity.
- Preventing external systems from influencing the canonical business model.

The Integration Domain never owns business entities.

It only references Aggregate Roots defined in other domains.

---

# 4. Aggregate Summary

| Aggregate | Responsibility | Business Identifier |
|------------|---------------|---------------------|
| Data Provider | Defines an external source of business information | Provider Code |
| External Identifier | Maps enterprise entities to provider identifiers | Provider + External Code |

---

# 5. Aggregate Specifications

## 5.1 Data Provider

### Business Purpose

Represents an external organization supplying market or reference information.

### Business Responsibilities

- Register external providers.
- Maintain provider identity.
- Maintain provider lifecycle.
- Define provider capabilities.

### Business Identifier

Provider Code

### Logical Characteristics

- Aggregate Root
- Reference entity
- Enterprise managed

### Business Rules

- Provider Code shall be unique.
- Provider identity shall remain stable.
- A Provider may define multiple External Identifiers.
- A Provider may become inactive without deleting historical mappings.

---

## 5.2 External Identifier

### Business Purpose

Represents the association between an enterprise Aggregate and an identifier assigned by an external provider.

### Business Responsibilities

- Preserve external identifiers.
- Support provider interoperability.
- Maintain identifier history.
- Support future provider migration.

### Business Identifier

Provider + External Code

### Logical Characteristics

- Aggregate Root
- Integration entity
- Shared across all business domains

### Business Rules

- Every External Identifier belongs to exactly one Provider.
- Every External Identifier references exactly one Aggregate Root.
- External identifiers shall never replace enterprise identifiers.
- Multiple providers may define different identifiers for the same business entity.
- Historical mappings shall remain traceable.

---

# 6. Cross-Domain Relationships

| Parent Aggregate | Child Aggregate | Cardinality |
|------------------|-----------------|-------------|
| Data Provider | External Identifier | 1 : N |
| Exchange | External Identifier | 1 : N |
| Trading Board | External Identifier | 1 : N |
| Sector | External Identifier | 1 : N |
| Industry | External Identifier | 1 : N |
| Company | External Identifier | 1 : N |
| Instrument | External Identifier | 1 : N |
| Instrument Listing | External Identifier | 1 : N |

---

# 7. Domain Constraints

The following logical constraints govern the Integration Domain:

- Every External Identifier shall reference exactly one Data Provider.
- Every External Identifier shall reference exactly one Aggregate Root.
- Enterprise identifiers remain the authoritative identifiers.
- External identifiers are provider-specific.
- External identifiers shall never be used as business keys inside the enterprise.

---

# 8. Domain Invariants

The following invariants shall always hold:

- Every Aggregate has exactly one Aggregate Root.
- Enterprise identity is independent of provider identity.
- Provider mappings shall be historically traceable.
- Aggregate references target Aggregate Roots only.
- Business semantics remain technology independent.

---

# 9. Traceability

| Source Artifact | Traceability |
|-----------------|--------------|
| ADR-002 | Data Source Abstraction |
| ADR-017 | External Business Identifier Strategy |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Logical attribute assignment |
| AttributeCatalog | Approved enterprise attributes |
| CanonicalBusinessRules | Business constraints |
| EnterpriseAttributeStandard | Attribute compliance |

---

# 10. Transition to Physical Design

This document provides the logical foundation for:

- Integration Schema Design
- Provider Tables
- External Identifier Tables
- Referential Integrity
- Provider Mapping Strategy

Implementation-specific decisions are intentionally excluded.

---

# 11. Related Artifacts

- ReferenceDomainLogicalModel
- CoreDomainLogicalModel
- MarketDomainLogicalModel
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- AttributeDictionary
- CanonicalBusinessRules
- ADR-002
- ADR-017
- ADR-021

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial canonical Integration Domain Logical Model |