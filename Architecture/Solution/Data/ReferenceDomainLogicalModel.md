# Reference Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-001 |
| Document | ReferenceDomainLogicalModel |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Enterprise Repository |
| Depends On | CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, ReferenceEntityDefinitions, CanonicalBusinessRules |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical logical representation of the **Reference Domain** within the Phoenix Platform.

The Reference Domain contains the enterprise master data shared by all bounded contexts and business services. It establishes the logical structure of the domain by defining aggregates, aggregate boundaries, ownership, responsibilities and business constraints independently of any implementation technology.

This document serves as the authoritative logical specification for conceptual modeling, logical database modeling and subsequent physical database implementation.

---

# 2. Scope

## Included Aggregates

- Geographic
- Localization
- Financial
- Market
- Classification
- Calendar
- Provider

## Included Topics

- Aggregate definitions
- Aggregate responsibilities
- Aggregate boundaries
- Aggregate ownership
- Business identifiers
- Cross-aggregate relationships
- Domain constraints
- Domain invariants

## Excluded Topics

The following subjects are defined in separate enterprise artifacts.

- Individual entity definitions
- Attribute definitions
- Physical tables
- Database schemas
- PostgreSQL implementation
- SQL scripts
- Foreign key implementation

---

# 3. Architectural Role

The Reference Domain provides the enterprise foundation upon which all other business domains depend.

Unlike operational domains, the Reference Domain contains stable business concepts that evolve slowly and are reused across multiple services and bounded contexts.

Its primary responsibilities include:

- Establishing canonical business terminology.
- Providing reusable enterprise master data.
- Supporting cross-domain consistency.
- Eliminating duplicated reference information.
- Defining authoritative aggregate ownership.

The Reference Domain shall never depend upon operational or transactional domains.

---

# 4. Domain Overview

The Reference Domain is composed of multiple aggregates, each representing a cohesive business capability.

Each aggregate owns its internal entities and business rules while exposing a single Aggregate Root to external consumers.

The domain follows the principles of Domain-Driven Design (DDD):

- Clear aggregate boundaries.
- Single Aggregate Root.
- Strong consistency inside an aggregate.
- Loose coupling between aggregates.
- Technology independence.

---

# 5. Aggregate Summary

| Aggregate | Aggregate Root | Business Identifier | Primary Responsibility |
|------------|----------------|---------------------|------------------------|
| Geographic | Country | ISO Country Code | Geographic reference information |
| Localization | Language | ISO Language Code | Languages and localization |
| Financial | Currency | ISO Currency Code | Financial reference data |
| Market | Market | Market Code | Financial market structure |
| Classification | AssetClass | Asset Class Code | Enterprise classifications |
| Calendar | HolidayCalendar | Calendar Code | Business calendars |
| Provider | DataProvider | Provider Code | External information providers |

---

# 6. Geographic Aggregate

## Business Purpose

The Geographic Aggregate provides standardized geographical reference information used throughout the enterprise.

It supports localization, reporting, scheduling and market operations by maintaining canonical geographical structures.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | Country |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Limited |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain country definitions.
- Maintain regional hierarchy.
- Maintain city hierarchy.
- Maintain enterprise time zones.
- Provide reusable geographical reference data.

### Business Identifier

**ISO 3166-1 Alpha-2**

### Aggregate Rules

- Every Region belongs to exactly one Country.
- Every City belongs to one Region.
- Time Zones shall comply with IANA standards.
- Geographic identifiers shall remain stable.
- Geographic entities shall never depend on operational domains.

---

# 7. Localization Aggregate

## Business Purpose

The Localization Aggregate defines the enterprise language and regional formatting standards.

It enables multilingual support and internationalization across all Phoenix services.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | Language |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Rarely |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain supported languages.
- Maintain enterprise locales.
- Support internationalization.
- Support regional formatting.
- Standardize language identifiers.

### Business Identifier

**ISO 639-1**

### Aggregate Rules

- Every Locale belongs to one Language.
- Language definitions are enterprise-wide.
- Locale identifiers shall remain stable.
- Localization entities shall remain technology independent.

---

# 8. Financial Aggregate

## Business Purpose

The Financial Aggregate defines standardized financial reference information shared throughout the platform.

It provides canonical definitions for currencies and related financial classifications.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | Currency |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Rarely |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain currency definitions.
- Maintain currency pair definitions.
- Support financial reporting.
- Support analytical services.
- Support multi-market architecture.

### Business Identifier

**ISO 4217**

### Aggregate Rules

- Currency identifiers shall comply with ISO standards.
- Currency Pairs reference two valid currencies.
- Currency definitions are immutable except for metadata.
- Financial reference entities are shared enterprise assets.

---

# 9. Market Aggregate

## Business Purpose

The Market Aggregate defines the enterprise structure of financial markets supported by the Phoenix Platform.

It establishes the canonical representation of markets, exchanges, trading calendars and trading sessions that are shared across all market engines.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | Market |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Limited |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain supported financial markets.
- Maintain exchange definitions.
- Maintain trading calendars.
- Maintain trading sessions.
- Support market governance.
- Support multi-market architecture.

### Business Identifier

**Market Code**

### Aggregate Rules

- Every Exchange belongs to exactly one Market.
- Every Trading Calendar belongs to one Exchange.
- Every Trading Session belongs to one Trading Calendar.
- Market identifiers shall remain stable.
- Market definitions shall be independent of trading activity.

---

# 10. Classification Aggregate

## Business Purpose

The Classification Aggregate provides standardized business classifications used throughout the Phoenix Platform.

These classifications support reporting, analytics, portfolio management and enterprise-wide categorization.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | AssetClass |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Rarely |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain Asset Classes.
- Maintain Instrument Types.
- Maintain Sector hierarchy.
- Maintain Industry hierarchy.
- Support enterprise reporting.
- Support analytical grouping.

### Business Identifier

**Asset Class Code**

### Aggregate Rules

- Instrument Types belong to an Asset Class.
- Industries belong to a Sector.
- Classification entities shall not depend upon operational entities.
- Classification structures shall remain consistent across all business domains.

---

# 11. Calendar Aggregate

## Business Purpose

The Calendar Aggregate defines enterprise calendars governing business operations, trading activities and scheduling.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | HolidayCalendar |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Yes |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain public holidays.
- Maintain market holidays.
- Support scheduling.
- Support trading operations.
- Provide enterprise calendar services.

### Business Identifier

**Calendar Code**

### Aggregate Rules

- Holiday calendars shall be unique.
- Calendar definitions shall remain historically traceable.
- Calendar changes shall follow enterprise governance procedures.

---

# 12. Provider Aggregate

## Business Purpose

The Provider Aggregate defines external organizations supplying market data, reference information or integration services.

It provides a standardized abstraction over external systems.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate Root | DataProvider |
| Shared Across Domains | Yes |
| Lifecycle | Long-lived |
| Mutable | Limited |
| Domain | Reference |

### Aggregate Responsibilities

- Maintain provider definitions.
- Maintain data source definitions.
- Support external integrations.
- Provide canonical provider identities.

### Business Identifier

**Provider Code**

### Aggregate Rules

- Every Data Source belongs to one Data Provider.
- Provider identifiers shall remain stable.
- Provider definitions shall be reusable across services.
- External provider changes shall not affect business identifiers.

---

# 13. Cross-Aggregate Relationships

Reference Aggregates collaborate through well-defined business relationships while preserving aggregate independence.

| Parent Aggregate | Child Aggregate | Cardinality |
|------------------|-----------------|-------------|
| Geographic | Localization | 1 : N |
| Market | Exchange | 1 : N |
| Exchange | TradingCalendar | 1 : N |
| TradingCalendar | TradingSession | 1 : N |
| Classification | InstrumentType | 1 : N |
| Classification | Sector | 1 : N |
| Sector | Industry | 1 : N |
| Provider | DataSource | 1 : N |

Reference aggregates expose only their Aggregate Root to external domains.

---

# 14. Aggregate Dependencies

Reference aggregates may depend only on other reference aggregates when required by business semantics.

Dependency rules are intentionally restrictive to preserve loose coupling.

## Dependency Principles

- Dependencies shall remain unidirectional.
- Circular aggregate dependencies are prohibited.
- Aggregate Roots are the only externally visible entry points.
- Internal entities shall never be referenced directly.
- Dependencies shall remain technology independent.

---

# 15. Aggregate Ownership

Each aggregate has a single authoritative owner responsible for its lifecycle, governance and business correctness.

## Ownership Rules

- Every aggregate belongs to exactly one domain.
- Ownership shall never be ambiguous.
- Aggregate ownership cannot be delegated.
- Cross-domain usage does not transfer ownership.
- Ownership changes require Architecture Board approval.

---

# 16. Aggregate Lifecycle

Reference aggregates are long-lived enterprise assets.

Lifecycle changes occur infrequently and follow controlled governance processes.

## Lifecycle States

- Proposed
- Approved
- Active
- Suspended
- Deprecated
- Retired

Aggregate lifecycle transitions shall preserve historical integrity and business continuity.

---

# 17. Aggregate Boundaries

Aggregate boundaries define transactional consistency and ownership within the Reference Domain.

These boundaries ensure that each aggregate remains cohesive and independently maintainable.

## Boundary Principles

- Each aggregate has exactly one Aggregate Root.
- Business invariants are enforced within aggregate boundaries.
- Cross-aggregate communication occurs through Aggregate Roots.
- Aggregate boundaries shall not overlap.
- Aggregate boundaries shall remain stable unless superseded by an approved ADR.

---

# 18. Domain Constraints

The following logical constraints govern the Reference Domain and apply to every aggregate.

## General Constraints

- Every aggregate shall have exactly one Aggregate Root.
- Every aggregate shall expose a stable business identifier.
- Every aggregate shall belong exclusively to the Reference Domain.
- Aggregate ownership shall be unique and unambiguous.
- Aggregate boundaries shall remain independent.
- Reference aggregates shall not depend on operational or transactional domains.
- Cross-domain references shall target Aggregate Roots only.
- Business semantics shall remain technology independent.

## Consistency Constraints

- Business identifiers shall remain unique within their defined scope.
- Aggregate relationships shall preserve referential consistency.
- Reference data shall remain authoritative across the enterprise.
- Duplicate business concepts are prohibited.
- Changes affecting business semantics require enterprise governance approval.

---

# 19. Domain Invariants

The following invariants shall always hold throughout the lifecycle of the Reference Domain.

## Aggregate Invariants

- Every aggregate has one and only one Aggregate Root.
- Aggregate ownership is immutable unless superseded by an approved Architecture Decision Record (ADR).
- Aggregate boundaries remain stable.
- Internal entities shall not be referenced directly by external domains.

## Business Invariants

- Business identifiers remain stable.
- Canonical business definitions remain consistent.
- Shared reference data shall have a single authoritative source.
- Historical business meaning shall never be lost through implementation changes.

## Architectural Invariants

- The Reference Domain remains independent of implementation technology.
- Logical models shall not contain physical database details.
- Domain models shall remain independent of application services.
- Reference aggregates shall continue to provide reusable enterprise master data.

---

# 20. Traceability

This document maintains complete traceability to the Phoenix Enterprise Architecture repository.

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Domain concepts and aggregate boundaries |
| ReferenceEntityDefinitions | Canonical entity definitions |
| AggregateCatalog | Aggregate ownership and responsibilities |
| AggregateAttributeMatrix | Aggregate-to-attribute allocation |
| EnterpriseAttributeDictionary | Canonical enterprise attributes |
| EnterpriseRelationshipCatalog | Cross-aggregate relationships |
| EnterpriseRelationshipMatrix | Relationship validation |
| CanonicalBusinessRules | Enterprise business constraints |
| LogicalDatabaseModel | Enterprise logical data model alignment |
| PhysicalDatabaseModel | Physical implementation traceability |

Traceability ensures consistency between business architecture, logical modeling and physical implementation.

---

# 21. Transition to Physical Design

The Reference Domain Logical Model provides the authoritative logical foundation for physical database implementation.

The following implementation activities derive directly from this document:

- Physical Database Modeling
- Schema Design
- Table Design
- Primary Key Strategy
- Foreign Key Design
- Constraint Definition
- Index Strategy
- Data Governance Implementation

Implementation-specific decisions are intentionally excluded from this document and are defined within the **PhysicalDatabaseModel**.

---

# 22. Related Artifacts

## Domain Architecture

- CanonicalDomainModel
- ReferenceEntityDefinitions
- LogicalDatabaseModel
- PhysicalDatabaseModel

## Enterprise Data Architecture

- AggregateCatalog
- AggregateAttributeMatrix
- EnterpriseAttributeDictionary
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CanonicalBusinessRules

## Enterprise Standards

- Repository Architecture (ADR-022)
- Enterprise Naming Standard
- Enterprise Data Governance Standard

---

# 23. Approval

The Phoenix Enterprise Architecture Board approves this Reference Domain Logical Model as the official logical specification of the Reference Domain.

This document establishes the canonical aggregate structure, business responsibilities and logical boundaries for the Reference Domain and serves as the authoritative foundation for conceptual modeling, logical database modeling and physical database implementation.

## Approval Status

**APPROVED**

---

# 24. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.3 | 2026-07-20 | Enterprise Repository Edition aligned with the canonical architecture baseline. |

---

# 25. Architecture Compliance

This document complies with the Phoenix Enterprise Architecture standards and is aligned with:

- Domain-Driven Design (DDD)
- Enterprise Information Architecture
- Repository Architecture (ADR-022)
- Canonical Domain Modeling Standards
- Enterprise Data Governance Framework
- Enterprise Naming Standards
- Aggregate Modeling Principles

The Reference Domain Logical Model shall be regarded as the authoritative logical specification for all Reference Domain aggregates. All future modifications shall preserve architectural consistency unless explicitly superseded by an approved Architecture Decision Record (ADR).