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
| Depends On | ReferenceDomainLogicalModel, ReferenceEntityDefinitions, CanonicalDomainModel, AggregateCatalog, CanonicalBusinessRules |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical logical relationships between entities belonging to the **Reference Domain** of the Phoenix Platform.

It establishes the enterprise business semantics governing entity interactions while remaining completely independent of physical database implementation.

The document serves as the authoritative source for logical relationships used by conceptual modeling, logical data modeling and physical database design.

---

# 2. Scope

## Included

- Intra-aggregate relationships
- Cross-aggregate reference relationships
- Ownership semantics
- Cardinality
- Composition rules
- Reference rules
- Relationship governance

## Excluded

The following subjects are defined elsewhere:

- Physical foreign keys
- SQL constraints
- PostgreSQL implementation
- Table relationships
- Index definitions
- Database optimization

---

# 3. Relationship Principles

All enterprise relationships shall comply with the following architectural principles.

## Business Principles

- Business driven
- Technology independent
- Explicit ownership
- Stable semantics
- Enterprise consistency
- Traceable to business rules

## Architectural Principles

- Aggregate boundaries shall be respected.
- Every relationship shall have explicit business meaning.
- Ownership shall never cross aggregate boundaries.
- Composition exists only inside an aggregate.
- Cross-aggregate communication shall occur through references only.

---

# 4. Relationship Types

Phoenix recognizes two logical relationship categories.

## Composition Relationship

Composition indicates ownership.

Characteristics:

- Parent owns child.
- Child lifecycle depends on parent.
- Child cannot exist independently.
- Aggregate Root controls consistency.

Typical examples:

- Country → Region
- Region → City
- Language → Locale
- Currency → CurrencyPair

---

## Reference Relationship

Reference relationships indicate business dependency without ownership.

Characteristics:

- Independent lifecycle
- No ownership transfer
- Read-only business dependency
- Aggregate boundaries preserved

Typical examples:

- Exchange → TimeZone
- Exchange → HolidayCalendar
- Market → Currency

---

# 5. Geographic Relationships

The Geographic Aggregate defines enterprise geographical hierarchy.

## Country → Region

| Property | Value |
|----------|-------|
| Parent Entity | Country |
| Child Entity | Region |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Country |
| Mandatory | Yes |
| Aggregate | Geographic |

### Business Rule

Every Region shall belong to exactly one Country.

---

## Region → City

| Property | Value |
|----------|-------|
| Parent Entity | Region |
| Child Entity | City |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Region |
| Mandatory | Yes |
| Aggregate | Geographic |

### Business Rule

Every City shall belong to exactly one Region.

---

## Country → TimeZone

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | One-to-Many (1:N) |
| Business Meaning | A country may observe one or more time zones. |

---

# 6. Localization Relationships

Localization entities define enterprise language and regional formatting.

## Language → Locale

| Property | Value |
|----------|-------|
| Parent Entity | Language |
| Child Entity | Locale |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Language |
| Mandatory | Yes |

### Business Rule

Every Locale shall belong to exactly one Language.

---

## Locale → Country

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | Many-to-One (N:1) |
| Business Meaning | A locale references the country where it is applicable. |

---

# 7. Financial Relationships

Financial entities provide standardized monetary definitions.

## Currency → CurrencyPair

| Property | Value |
|----------|-------|
| Parent Entity | Currency |
| Child Entity | CurrencyPair |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Currency |
| Role | Base Currency / Quote Currency |

### Business Rules

- Every CurrencyPair consists of exactly two currencies.
- Base Currency and Quote Currency shall be different.
- CurrencyPair cannot exist without valid Currency definitions.

---

## Currency → Market

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | One-to-Many (1:N) |
| Business Meaning | Markets reference settlement currencies defined by the Financial Aggregate. |

---

# 8. Market Relationships

The Market Aggregate organizes enterprise financial markets.

## Market → Exchange

| Property | Value |
|----------|-------|
| Parent Entity | Market |
| Child Entity | Exchange |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Market |
| Mandatory | Yes |

### Business Rule

Every Exchange shall belong to exactly one Market.

---

## Exchange → TradingCalendar

| Property | Value |
|----------|-------|
| Parent Entity | Exchange |
| Child Entity | TradingCalendar |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Exchange |

### Business Rule

Each Exchange maintains one or more Trading Calendars.

---

## TradingCalendar → TradingSession

| Property | Value |
|----------|-------|
| Parent Entity | TradingCalendar |
| Child Entity | TradingSession |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | TradingCalendar |

### Business Rule

Trading Sessions are defined within a single Trading Calendar.

---

# 9. Classification Relationships

The Classification Aggregate provides standardized business classifications used throughout the Phoenix Platform.

## AssetClass → InstrumentType

| Property | Value |
|----------|-------|
| Parent Entity | AssetClass |
| Child Entity | InstrumentType |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | AssetClass |
| Mandatory | Yes |

### Business Rule

Every Instrument Type shall belong to exactly one Asset Class.

---

## Sector → Industry

| Property | Value |
|----------|-------|
| Parent Entity | Sector |
| Child Entity | Industry |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | Sector |
| Mandatory | Yes |

### Business Rule

Every Industry shall belong to exactly one Sector.

---

## Industry → Instrument

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | One-to-Many (1:N) |
| Business Meaning | Financial instruments may reference an Industry for analytical classification. |

---

# 10. Calendar Relationships

The Calendar Aggregate defines enterprise business calendars.

## HolidayCalendar → Holiday

| Property | Value |
|----------|-------|
| Parent Entity | HolidayCalendar |
| Child Entity | Holiday |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | HolidayCalendar |
| Mandatory | Yes |

### Business Rule

Every Holiday belongs to exactly one Holiday Calendar.

---

## TradingCalendar → HolidayCalendar

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | Many-to-One (N:1) |
| Business Meaning | Trading Calendars reference Holiday Calendars when determining market closures. |

---

# 11. Provider Relationships

The Provider Aggregate governs external data providers.

## DataProvider → DataSource

| Property | Value |
|----------|-------|
| Parent Entity | DataProvider |
| Child Entity | DataSource |
| Relationship Type | Composition |
| Cardinality | One-to-Many (1:N) |
| Ownership | DataProvider |
| Mandatory | Yes |

### Business Rule

Every Data Source shall belong to exactly one Data Provider.

---

## DataSource → Market

| Property | Value |
|----------|-------|
| Relationship Type | Reference |
| Cardinality | Many-to-One (N:1) |
| Business Meaning | A Data Source may provide information for one or more financial markets. |

---

# 12. Cross-Domain Relationships

Reference entities are shared across multiple business domains.

Cross-domain relationships shall never transfer ownership.

## Examples

| Source Domain | Target Entity | Relationship |
|---------------|---------------|--------------|
| Instrument Domain | Exchange | Reference |
| Instrument Domain | Trading Board | Reference |
| Instrument Domain | Industry | Reference |
| Instrument Domain | Currency | Reference |
| Company Domain | Industry | Reference |
| Company Domain | Exchange | Reference |
| Market Data Domain | Trading Calendar | Reference |
| Portfolio Domain | Currency | Reference |
| Portfolio Domain | Market | Reference |

---

# 13. Aggregate Ownership Rules

Ownership is confined to Aggregate boundaries.

## Rules

- Every Aggregate has exactly one Aggregate Root.
- Aggregate Roots own every child entity.
- Ownership shall never cross Aggregate boundaries.
- Child entities cannot own other Aggregates.
- External domains reference Aggregate Roots only.

---

# 14. Cardinality Rules

Every logical relationship shall explicitly define its cardinality.

Supported cardinalities include:

| Cardinality | Meaning |
|-------------|---------|
| 1:1 | One-to-One |
| 1:N | One-to-Many |
| N:1 | Many-to-One |
| N:M | Many-to-Many (logical only where explicitly approved) |

## Rules

- Cardinality shall always be documented.
- Mandatory participation shall be identified.
- Optional relationships shall be explicitly defined.
- Ambiguous cardinalities are prohibited.

---

# 15. Composition Rules

Composition relationships represent ownership.

## Characteristics

- Parent controls lifecycle.
- Child cannot exist independently.
- Aggregate Root enforces consistency.
- Cascading business rules originate from the parent.
- Composition is restricted to entities within the same Aggregate.

## Composition Examples

- Country → Region
- Region → City
- Language → Locale
- Currency → CurrencyPair
- Market → Exchange
- Exchange → TradingCalendar
- TradingCalendar → TradingSession
- HolidayCalendar → Holiday
- DataProvider → DataSource
- Sector → Industry
- AssetClass → InstrumentType

---

# 16. Reference Rules

Reference relationships preserve Aggregate independence.

## Characteristics

- No ownership transfer.
- Independent lifecycle.
- Read-only business dependency.
- Aggregate boundaries remain intact.
- Referential semantics are defined logically, not physically.

## Reference Examples

- Exchange → TimeZone
- Exchange → HolidayCalendar
- TradingCalendar → HolidayCalendar
- Locale → Country
- Market → Currency
- Instrument → Industry
- Portfolio → Currency

## Architectural Rule

Cross-Aggregate communication shall always occur through reference relationships rather than composition.

---

# 17. Relationship Constraints

The following enterprise constraints apply to all logical relationships defined within the Reference Domain.

## General Constraints

- Cross-Aggregate ownership is prohibited.
- Composition relationships shall exist only within the same Aggregate.
- Reference relationships shall never transfer ownership.
- Circular dependencies are prohibited.
- Self-referencing relationships require Architecture Board approval.
- Every relationship shall have a clearly defined business purpose.
- Every relationship shall preserve Aggregate consistency.

---

# 18. Validation Rules

Every logical relationship shall satisfy the following validation requirements before becoming part of the canonical repository.

## Mandatory Validation

- Business meaning defined
- Source entity identified
- Target entity identified
- Relationship type specified
- Cardinality documented
- Ownership defined
- Aggregate boundary validated
- Business rule documented

## Architectural Validation

Every relationship shall comply with:

- Domain-Driven Design (DDD)
- Aggregate Design Principles
- Enterprise Information Architecture
- Canonical Naming Standard
- Enterprise Governance Framework
- Canonical Business Rules

Relationships failing validation shall not become part of the enterprise architecture.

---

# 19. Traceability

This document maintains full traceability to the enterprise architecture repository.

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Enterprise business concepts |
| ReferenceDomainLogicalModel | Aggregate structure |
| ReferenceEntityDefinitions | Entity ownership |
| AggregateCatalog | Aggregate responsibilities |
| AggregateAttributeMatrix | Aggregate organization |
| EnterpriseRelationshipCatalog | Enterprise relationship inventory |
| EnterpriseRelationshipMatrix | Cross-domain relationship mapping |
| CanonicalBusinessRules | Business constraints |
| LogicalDatabaseModel | Logical implementation |
| PhysicalDatabaseModel | Physical implementation |

---

# 20. Related Artifacts

## Enterprise Architecture

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

## Data Models

- LogicalDatabaseModel
- PhysicalDatabaseModel
- ReferenceLogicalERD

---

# 21. Approval

The Phoenix Enterprise Architecture Board approves this document as the authoritative definition of logical relationships within the Reference Domain.

This document establishes the canonical relationship semantics used by all downstream logical and physical models.

## Approval Status

**APPROVED**

---

# 22. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-07 | Initial logical relationship model. |
| 2026.2 | 2026-07-20 | Enterprise Repository Edition aligned with the canonical repository architecture and DDD aggregate model. |

---

# 23. Architecture Compliance

This document complies with the following Phoenix Enterprise Architecture standards:

- Domain-Driven Design (DDD)
- Enterprise Information Architecture
- Repository Architecture (ADR-022)
- Aggregate Modeling Principles
- Canonical Domain Modeling Standard
- Enterprise Relationship Standard
- Enterprise Data Governance Framework
- Enterprise Naming Standard

All logical relationships shall remain technology independent and shall preserve Aggregate integrity throughout the lifecycle of the Phoenix Platform.

---

# 24. Document Summary

The **Reference Relationships** document defines the authoritative business relationships between entities belonging to the Reference Domain.

It provides the enterprise foundation for:

- Aggregate ownership
- Composition relationships
- Reference relationships
- Cardinality rules
- Cross-domain interaction
- Relationship governance
- Logical database modeling
- Physical database implementation

Together with **ReferenceDomainLogicalModel** and **ReferenceEntityDefinitions**, this document forms the canonical logical specification of the Phoenix Platform Reference Domain.

---

# 25. Future Evolution

Future enhancements to this document may include:

- Relationship lifecycle metadata
- Relationship versioning
- Business event dependencies
- Domain interaction patterns
- Enterprise dependency matrix
- Automated architecture validation rules
- Model-driven relationship generation

Any future enhancement shall remain fully backward compatible with the Phoenix Enterprise Architecture and follow the established governance process.