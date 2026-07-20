# Reference Relationships

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-003 |
| Document | ReferenceRelationships |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Enterprise Repository |
| Depends On | ReferenceEntityDefinitions, ReferenceDomainLogicalModel, CanonicalDomainModel, EnterpriseRelationshipCatalog, CanonicalBusinessRules |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical logical relationships within the **Reference Domain** of the Phoenix Platform.

It specifies how aggregates and entities interact from a business perspective while remaining independent of database technologies and implementation details.

This document serves as the authoritative specification for relationship semantics, ownership, cardinality, aggregate boundaries and dependency rules within the Reference Domain.

---

# 2. Scope

## Included

- Intra-Aggregate relationships
- Cross-Aggregate relationships
- Aggregate ownership
- Relationship cardinalities
- Composition rules
- Reference rules
- Dependency rules
- Relationship governance

## Excluded

The following topics are documented elsewhere.

- Physical foreign keys
- Database constraints
- PostgreSQL implementation
- SQL DDL
- Index strategy
- Physical data model
- Enterprise-wide relationship catalog

---

# 3. Architectural Role

Relationships define how business concepts collaborate while preserving aggregate independence.

Within the Reference Domain, relationships exist to:

- express business semantics;
- define ownership;
- preserve aggregate boundaries;
- establish consistency rules;
- prevent circular dependencies;
- support enterprise-wide reuse.

All relationships described in this document are logical relationships only.

---

# 4. Relationship Principles

Every relationship defined in the Reference Domain shall comply with the following architectural principles.

## Business First

Relationships represent business meaning rather than implementation.

## Aggregate Integrity

Relationships shall never violate aggregate boundaries.

## Technology Independence

Relationships shall not imply physical database implementation.

## Explicit Ownership

Every relationship shall clearly identify ownership.

## Stable Semantics

Relationship meaning shall remain stable throughout the system lifecycle.

## Traceability

Every relationship shall be traceable to an approved business concept or business rule.

---

# 5. Intra-Aggregate Relationships

Relationships inside an aggregate represent composition and lifecycle dependency.

Child entities cannot exist independently of their Aggregate Root.

## 5.1 Geographic Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| Country | Region | 1 : N | Composition |
| Region | City | 1 : N | Composition |
| Country | TimeZone | 1 : N | Reference |

### Business Rules

- Every Region belongs to exactly one Country.
- Every City belongs to exactly one Region.
- Geographic hierarchy shall remain acyclic.
- Geographic ownership belongs to Country.

---

## 5.2 Localization Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| Language | Locale | 1 : N | Composition |

### Business Rules

- Every Locale belongs to exactly one Language.
- Locales cannot exist independently.
- Language owns the lifecycle of every Locale.

---

## 5.3 Financial Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| Currency | CurrencyPair | 1 : N | Composition |

### Business Rules

- Every CurrencyPair references exactly two currencies.
- Base Currency and Quote Currency shall be different.
- CurrencyPair lifecycle depends on Currency definitions.

---

## 5.4 Market Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| Market | Exchange | 1 : N | Composition |
| Exchange | TradingCalendar | 1 : N | Composition |
| TradingCalendar | TradingSession | 1 : N | Composition |

### Business Rules

- Every Exchange belongs to exactly one Market.
- Every Trading Calendar belongs to one Exchange.
- Every Trading Session belongs to one Trading Calendar.
- Aggregate ownership belongs to Market.

---

## 5.5 Classification Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| AssetClass | InstrumentType | 1 : N | Composition |
| Sector | Industry | 1 : N | Composition |

### Business Rules

- Every Instrument Type belongs to one Asset Class.
- Every Industry belongs to one Sector.
- Classification ownership remains hierarchical.

---

## 5.6 Calendar Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| HolidayCalendar | Holiday | 1 : N | Composition |

### Business Rules

- Every Holiday belongs to one Holiday Calendar.
- Holidays cannot exist independently.

---

## 5.7 Provider Aggregate

| Parent | Child | Cardinality | Relationship |
|----------|--------|-------------|--------------|
| DataProvider | DataSource | 1 : N | Composition |

### Business Rules

- Every Data Source belongs to one Data Provider.
- Provider owns the lifecycle of all Data Sources.

---

# 6. Cross-Aggregate Relationships

Cross-aggregate relationships are reference-only.

No aggregate may own entities belonging to another aggregate.

| Source Aggregate | Target Aggregate | Relationship Type | Cardinality |
|------------------|------------------|-------------------|-------------|
| Market | Geographic | Reference | N : 1 |
| Market | Calendar | Reference | N : 1 |
| Market | Financial | Reference | N : 1 |
| Localization | Geographic | Reference | N : 1 |
| Provider | Market | Reference | N : 1 |

## Cross-Aggregate Principles

- Aggregate ownership shall never cross aggregate boundaries.
- References shall target Aggregate Roots whenever possible.
- Cross-aggregate references are read-only from a business perspective.
- Cross-domain references shall preserve aggregate independence.

---

# 7. Aggregate Composition Rules

Composition relationships define strong ownership.

A composed entity cannot exist without its Aggregate Root.

## Composition Principles

- Composition exists only inside an aggregate.
- Aggregate Roots own all child entities.
- Child entities inherit aggregate lifecycle.
- Composition relationships imply ownership.
- Composition relationships are mandatory unless explicitly documented otherwise.

---

# 8. Relationship Cardinalities

Relationship cardinality defines the permitted number of business objects participating in a logical relationship.

Cardinality is a business rule and shall remain independent of any physical database implementation.

## Cardinality Principles

- Cardinality shall be explicitly defined for every relationship.
- Cardinality expresses business semantics rather than implementation.
- Mandatory participation shall be documented.
- Optional participation shall be explicitly identified.

## Supported Cardinalities

| Cardinality | Meaning |
|-------------|---------|
| 1 : 1 | Exactly one related entity |
| 1 : N | One parent may own many children |
| N : 1 | Many entities reference one parent |
| N : N | Many-to-many business relationship (implemented through an associative entity in logical and physical models) |

## Cardinality Rules

- Composition relationships normally use **1 : N**.
- Aggregate ownership shall never use **N : N**.
- Cross-aggregate references shall not imply ownership.
- Cardinality changes require Architecture Board approval.

---

# 9. Relationship Ownership

Ownership determines which aggregate is responsible for maintaining a relationship.

Ownership shall always remain within a single aggregate.

## Ownership Principles

- Every relationship has exactly one owner.
- Ownership belongs to the Aggregate Root.
- Child entities never own parent entities.
- Cross-aggregate references never transfer ownership.
- Ownership changes require enterprise governance approval.

## Ownership Matrix

| Relationship | Owner |
|--------------|-------|
| Country → Region | Country |
| Region → City | Country |
| Language → Locale | Language |
| Currency → CurrencyPair | Currency |
| Market → Exchange | Market |
| Exchange → TradingCalendar | Market |
| TradingCalendar → TradingSession | Market |
| AssetClass → InstrumentType | AssetClass |
| Sector → Industry | Sector |
| HolidayCalendar → Holiday | HolidayCalendar |
| DataProvider → DataSource | DataProvider |

---

# 10. Relationship Matrix

The following matrix summarizes the logical relationships defined within the Reference Domain.

| Source | Target | Relationship | Ownership | Cardinality |
|--------|--------|--------------|-----------|-------------|
| Country | Region | Composition | Country | 1 : N |
| Region | City | Composition | Country | 1 : N |
| Country | TimeZone | Reference | Geographic | 1 : N |
| Language | Locale | Composition | Language | 1 : N |
| Currency | CurrencyPair | Composition | Currency | 1 : N |
| Market | Exchange | Composition | Market | 1 : N |
| Exchange | TradingCalendar | Composition | Market | 1 : N |
| TradingCalendar | TradingSession | Composition | Market | 1 : N |
| AssetClass | InstrumentType | Composition | AssetClass | 1 : N |
| Sector | Industry | Composition | Sector | 1 : N |
| HolidayCalendar | Holiday | Composition | HolidayCalendar | 1 : N |
| DataProvider | DataSource | Composition | DataProvider | 1 : N |
| Market | Currency | Reference | Financial | N : 1 |
| Market | Geographic | Reference | Geographic | N : 1 |
| Localization | Geographic | Reference | Geographic | N : 1 |

---

# 11. Dependency Rules

Dependencies between aggregates shall remain minimal and unidirectional.

The objective is to maximize independence while preserving business consistency.

## Dependency Principles

- Dependencies shall always point toward stable reference concepts.
- Cyclic dependencies are prohibited.
- Aggregate Roots are the only externally visible dependency points.
- Internal entities shall never become dependency targets.
- Business dependencies shall remain technology independent.

## Allowed Dependencies

| Source Aggregate | Target Aggregate |
|------------------|------------------|
| Localization | Geographic |
| Market | Geographic |
| Market | Financial |
| Market | Calendar |
| Provider | Market |

## Prohibited Dependencies

- Geographic → Market
- Financial → Market
- Calendar → Provider
- Localization → Provider
- Circular dependencies of any kind

---

# 12. Consistency Rules

Relationship consistency ensures that the Reference Domain behaves as a coherent enterprise model.

## Consistency Principles

- Every relationship shall preserve aggregate integrity.
- Every reference shall target a valid Aggregate Root.
- Duplicate relationships are prohibited.
- Relationship semantics shall remain stable.
- Business meaning shall not change because of implementation choices.

## Consistency Requirements

- Relationship ownership shall always be identifiable.
- Cardinality shall remain valid throughout the lifecycle.
- Aggregate boundaries shall never overlap.
- Shared reference entities shall have a single authoritative owner.

---

# 13. Domain Constraints

The following constraints apply to all relationships defined within the Reference Domain.

## Structural Constraints

- Every aggregate shall have one Aggregate Root.
- Composition relationships shall remain within aggregate boundaries.
- Cross-aggregate relationships shall be reference-only.
- Aggregate ownership shall never cross domain boundaries.

## Business Constraints

- Business identifiers remain immutable.
- Relationship semantics remain stable.
- Reference entities shall never depend on transactional entities.
- Historical business meaning shall be preserved.

## Governance Constraints

- Relationship changes require architectural review.
- New cross-aggregate relationships require Architecture Board approval.
- Breaking relationship changes require an approved Architecture Decision Record (ADR).

---

# 14. Validation Rules

Every relationship defined within the Reference Domain shall satisfy the Phoenix Enterprise Architecture validation criteria before being approved.

Validation ensures architectural consistency, business correctness and long-term maintainability.

## Validation Principles

Every relationship shall satisfy the following requirements:

- Business meaning is explicitly defined.
- Source Aggregate is identified.
- Target Aggregate is identified.
- Relationship type is documented.
- Ownership is clearly assigned.
- Cardinality is explicitly specified.
- Aggregate boundaries are respected.
- Relationship direction is unambiguous.
- No duplicate relationship exists.
- Relationship complies with enterprise naming standards.
- Relationship complies with canonical business rules.
- Relationship is traceable to enterprise architecture artifacts.

Relationships failing validation shall not become part of the canonical repository.

---

# 15. Traceability

This document maintains complete traceability to the Phoenix Enterprise Architecture repository.

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Canonical business concepts |
| ReferenceDomainLogicalModel | Aggregate definitions and boundaries |
| ReferenceEntityDefinitions | Entity ownership and lifecycle |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Aggregate structure |
| EnterpriseRelationshipCatalog | Enterprise relationship definitions |
| EnterpriseRelationshipMatrix | Enterprise relationship validation |
| CanonicalBusinessRules | Business constraints |
| LogicalDatabaseModel | Enterprise logical relationships |
| PhysicalDatabaseModel | Physical implementation traceability |

Traceability ensures consistency between conceptual, logical and physical architecture.

---

# 16. Related Artifacts

## Domain Architecture

- CanonicalDomainModel
- ReferenceDomainLogicalModel
- ReferenceEntityDefinitions

## Enterprise Data Architecture

- AggregateCatalog
- AggregateAttributeMatrix
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- EnterpriseAttributeDictionary
- CanonicalBusinessRules

## Logical and Physical Models

- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix

---

# 17. Approval

The Phoenix Enterprise Architecture Board approves this document as the official logical relationship specification for the Reference Domain.

This document establishes the canonical business relationships, ownership rules and aggregate interaction principles governing the Reference Domain.

## Approval Status

**APPROVED**

---

# 18. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-07 | Initial logical relationship model. |
| 2026.2 | 2026-07-20 | Enterprise Repository Edition aligned with the canonical architecture baseline. |

---

# 19. Architecture Compliance

This document complies with the following Phoenix Enterprise Architecture standards:

- Domain-Driven Design (DDD)
- Enterprise Information Architecture
- Repository Architecture (ADR-022)
- Canonical Domain Modeling Standard
- Enterprise Relationship Modeling Standard
- Enterprise Data Governance Framework
- Enterprise Naming Standard

All relationships defined herein shall remain technology independent and shall preserve aggregate integrity throughout the lifecycle of the Phoenix Platform.

---

# 20. Document Summary

The **Reference Relationships** document defines the authoritative logical relationships within the Reference Domain.

It provides the enterprise foundation for:

- Aggregate composition
- Aggregate ownership
- Cross-aggregate references
- Relationship cardinalities
- Dependency management
- Business consistency
- Enterprise governance
- Logical database modeling
- Physical database implementation

This document, together with **ReferenceEntityDefinitions** and **ReferenceDomainLogicalModel**, forms the canonical logical specification of the Phoenix Platform Reference Domain.