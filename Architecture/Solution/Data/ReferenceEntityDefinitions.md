# Reference Entity Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-002 |
| Document | ReferenceEntityDefinitions |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Enterprise Repository |
| Depends On | CanonicalDomainModel, ReferenceDomainLogicalModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical logical entities belonging to the **Reference Domain** of the Phoenix Platform.

It establishes the enterprise business identity, ownership, lifecycle, mutability and architectural characteristics of each logical entity.

The document is technology independent and serves as the authoritative source for logical entity definitions used by conceptual modeling, logical database modeling and physical database implementation.

---

# 2. Scope

## Included

- Canonical logical entities
- Aggregate membership
- Aggregate Root identification
- Business identifiers
- Entity ownership
- Entity lifecycle
- Entity mutability
- Enterprise characteristics

## Excluded

The following subjects are documented separately:

- Logical relationships
- Physical tables
- Database schemas
- SQL implementation
- Attribute definitions
- Physical constraints
- Foreign keys
- Enterprise relationship catalog

---

# 3. Entity Definition Standard

Every logical entity defined within the Reference Domain shall include the following metadata.

| Property | Description |
|----------|-------------|
| Entity Name | Canonical business name |
| Aggregate | Aggregate ownership |
| Aggregate Root | Indicates whether the entity is the Aggregate Root |
| Business Identifier | Stable business identifier |
| Lifecycle | Business lifecycle |
| Ownership | Responsible aggregate |
| Shared Across Domains | Enterprise reuse indicator |
| Mutable | Expected business mutability |
| Description | Business definition |

## Standard Principles

Every entity shall:

- represent a business concept;
- belong to exactly one aggregate;
- have one authoritative owner;
- remain technology independent;
- expose a stable business identity;
- comply with enterprise naming standards.

---

# 4. Geographic Entities

The Geographic Aggregate provides standardized geographical reference information shared throughout the enterprise.

## Country

| Property | Value |
|----------|-------|
| Entity Name | Country |
| Aggregate | Geographic |
| Aggregate Root | Yes |
| Business Identifier | ISO 3166-1 Alpha-2 |
| Lifecycle | Active / Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | No (except metadata) |
| Description | Canonical definition of a sovereign country used throughout the platform. |

---

## Region

| Property | Value |
|----------|-------|
| Entity Name | Region |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | Region Code |
| Lifecycle | Active / Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Administrative or geographical subdivision belonging to a Country. |

---

## City

| Property | Value |
|----------|-------|
| Entity Name | City |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | City Code |
| Lifecycle | Active /Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical municipality or city belonging to a Region. |

---

## TimeZone

| Property | Value |
|----------|-------|
| Entity Name | TimeZone |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | IANA Time Zone Identifier |
| Lifecycle | Active |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Enterprise definition of an IANA time zone used for scheduling and trading operations. |

---

# 5. Localization Entities

The Localization Aggregate standardizes language and regional formatting across the enterprise.

## Language

| Property | Value |
|----------|-------|
| Entity Name | Language |
| Aggregate | Localization |
| Aggregate Root | Yes |
| Business Identifier | ISO 639-1 |
| Lifecycle | Active |
| Ownership | Localization Aggregate |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Canonical enterprise language definition. |

---

## Locale

| Property | Value |
|----------|-------|
| Entity Name | Locale |
| Aggregate | Localization |
| Aggregate Root | No |
| Business Identifier | Language-Country Code |
| Lifecycle | Active |
| Ownership | Localization Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Regional localization settings used for formatting dates, numbers and currencies. |

---

# 6. Financial Entities

The Financial Aggregate provides enterprise-wide financial reference information.

## Currency

| Property | Value |
|----------|-------|
| Entity Name | Currency |
| Aggregate | Financial |
| Aggregate Root | Yes |
| Business Identifier | ISO 4217 |
| Lifecycle | Active / Inactive |
| Ownership | Financial Aggregate |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Canonical monetary currency recognized by the platform. |

---

## CurrencyPair

| Property | Value |
|----------|-------|
| Entity Name | CurrencyPair |
| Aggregate | Financial |
| Aggregate Root | No |
| Business Identifier | Base Currency + Quote Currency |
| Lifecycle | Active |
| Ownership | Financial Aggregate |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Tradable foreign-exchange currency pair composed of two valid currencies. |

---

# 7. Market Entities

The Market Aggregate defines the enterprise structure of supported financial markets.

## Market

| Property | Value |
|----------|-------|
| Entity Name | Market |
| Aggregate | Market |
| Aggregate Root | Yes |
| Business Identifier | Market Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical financial market such as Iran Equities, Forex or Cryptocurrency. |

---

## Exchange

| Property | Value |
|----------|-------|
| Entity Name | Exchange |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Exchange Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Securities exchange operating within a Market. |

---

## TradingCalendar

| Property | Value |
|----------|-------|
| Entity Name | TradingCalendar |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Calendar Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Defines official trading days, holidays and market schedules. |

---

## TradingSession

| Property | Value |
|----------|-------|
| Entity Name | TradingSession |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Session Code |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Defines trading sessions within a Trading Calendar. |

---

# 8. Classification Entities

The Classification Aggregate provides standardized business classifications used throughout the Phoenix Platform for reporting, analytics, screening and portfolio management.

## AssetClass

| Property | Value |
|----------|-------|
| Entity Name | AssetClass |
| Aggregate | Classification |
| Aggregate Root | Yes |
| Business Identifier | Asset Class Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Canonical classification of financial assets such as Equity, ETF, Bond, Commodity, Forex and Cryptocurrency. |

---

## InstrumentType

| Property | Value |
|----------|-------|
| Entity Name | InstrumentType |
| Aggregate | Classification |
| Aggregate Root | No |
| Business Identifier | Instrument Type Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Canonical classification of tradable financial instruments. |

---

## Sector

| Property | Value |
|----------|-------|
| Entity Name | Sector |
| Aggregate | Classification |
| Aggregate Root | No |
| Business Identifier | Sector Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Enterprise business sector classification used for market organization and reporting. |

---

## Industry

| Property | Value |
|----------|-------|
| Entity Name | Industry |
| Aggregate | Classification |
| Aggregate Root | No |
| Business Identifier | Industry Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Enterprise industry classification belonging to a business sector. |

---

# 9. Calendar Entities

The Calendar Aggregate provides enterprise calendar definitions shared by business and market services.

## HolidayCalendar

| Property | Value |
|----------|-------|
| Entity Name | HolidayCalendar |
| Aggregate | Calendar |
| Aggregate Root | Yes |
| Business Identifier | Calendar Code |
| Lifecycle | Active |
| Ownership | Calendar Aggregate |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Enterprise calendar defining public holidays and market holidays. |

---

## Holiday

| Property | Value |
|----------|-------|
| Entity Name | Holiday |
| Aggregate | Calendar |
| Aggregate Root | No |
| Business Identifier | Holiday Code |
| Lifecycle | Active |
| Ownership | Calendar Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Individual holiday belonging to a Holiday Calendar. |

---

# 10. Provider Entities

The Provider Aggregate standardizes external organizations supplying market, financial or reference information.

## DataProvider

| Property | Value |
|----------|-------|
| Entity Name | DataProvider |
| Aggregate | Provider |
| Aggregate Root | Yes |
| Business Identifier | Provider Code |
| Lifecycle | Active |
| Ownership | Provider Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical definition of an external information provider. |

---

## DataSource

| Property | Value |
|----------|-------|
| Entity Name | DataSource |
| Aggregate | Provider |
| Aggregate Root | No |
| Business Identifier | Data Source Code |
| Lifecycle | Active |
| Ownership | Provider Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Specific information source supplied by a Data Provider. |

---

# 11. Entity Characteristics

Every entity defined within the Reference Domain shares a common set of architectural characteristics.

## Architectural Characteristics

- Technology independent
- Business oriented
- Enterprise governed
- Canonically defined
- Reusable across domains
- Stable over time
- Independently identifiable

## Design Principles

- Every entity belongs to exactly one aggregate.
- Every aggregate has exactly one Aggregate Root.
- Child entities cannot exist independently of their Aggregate Root.
- Business semantics take precedence over implementation concerns.
- Entity definitions remain independent of physical database design.

---

# 12. Business Identifiers

Every entity shall expose a stable business identifier that uniquely identifies the business concept.

## Identifier Principles

Business identifiers shall be:

- Stable
- Human meaningful where appropriate
- Technology independent
- Immutable during the entity lifecycle
- Unique within their business scope

## Examples

| Entity | Business Identifier |
|---------|---------------------|
| Country | ISO 3166-1 Alpha-2 |
| Language | ISO 639-1 |
| Currency | ISO 4217 |
| Market | Market Code |
| Exchange | Exchange Code |
| TradingCalendar | Calendar Code |
| AssetClass | Asset Class Code |
| Sector | Sector Code |
| Industry | Industry Code |
| HolidayCalendar | Calendar Code |
| DataProvider | Provider Code |

---

# 13. Lifecycle Definitions

Reference entities generally have long business lifecycles and evolve under controlled governance.

## Standard Lifecycle States

- Proposed
- Approved
- Active
- Suspended
- Deprecated
- Retired

## Lifecycle Rules

- Business identifiers remain unchanged throughout the lifecycle.
- Lifecycle transitions require governance approval where applicable.
- Retired entities remain historically traceable.
- Historical business meaning shall never be lost.

---

# 14. Ownership Rules

Ownership defines the aggregate responsible for maintaining the lifecycle and business correctness of an entity.

## Ownership Principles

- Every entity has exactly one owner.
- Ownership belongs to the Aggregate Root.
- Ownership cannot cross aggregate boundaries.
- Shared usage does not imply shared ownership.
- Ownership changes require Architecture Board approval.

---

# 15. Mutability Rules

Reference entities are designed to be relatively stable.

## Mutability Categories

| Category | Description |
|----------|-------------|
| Immutable | Business definition rarely changes. |
| Limited | Changes occur only through controlled governance. |
| Rarely | Occasional administrative updates are permitted. |
| Mutable | Business updates are expected but remain governed. |

## General Rules

- Business identifiers are immutable.
- Metadata may be updated under governance.
- Historical meaning shall be preserved.
- Changes affecting business semantics require formal architectural approval.

---

# 16. Naming Standards

All entities defined within the Reference Domain shall comply with the Phoenix Enterprise Naming Standard.

## Naming Principles

- Business-oriented
- Technology independent
- Singular nouns
- Clear and unambiguous
- Consistent across all domains
- Internationally understandable

## Entity Naming Rules

- Entity names shall use **PascalCase**.
- Aggregate names shall represent business capabilities.
- Entity names shall not contain implementation details.
- Abbreviations shall be avoided unless they are internationally recognized standards (e.g., ISO, MIC, IANA).

## Business Identifier Naming

Business identifiers shall follow recognized international or enterprise standards whenever possible.

Examples include:

| Entity | Identifier Standard |
|----------|---------------------|
| Country | ISO 3166-1 Alpha-2 |
| Language | ISO 639-1 |
| Currency | ISO 4217 |
| TimeZone | IANA Time Zone ID |
| Exchange | Enterprise Exchange Code |
| Market | Enterprise Market Code |

---

# 17. Entity Relationships

Entity relationships are defined separately in the **ReferenceRelationships** document.

This document identifies entity ownership and aggregate membership only.

## Relationship Principles

- Relationships shall respect aggregate boundaries.
- Aggregate Roots own all child entities.
- Child entities shall not be referenced independently by external domains.
- Cross-aggregate relationships are reference-only.
- Relationship semantics are independent of database implementation.

---

# 18. Governance Rules

Reference entities are governed through the Phoenix Enterprise Architecture Governance Framework.

## Governance Principles

- Every entity shall have one authoritative definition.
- Duplicate enterprise entities are prohibited.
- Business semantics shall remain stable.
- Entity ownership shall be explicitly defined.
- Aggregate boundaries shall remain consistent.

## Change Management

The following changes require formal architectural approval:

- Creation of new entities
- Removal of existing entities
- Aggregate ownership changes
- Business identifier changes
- Lifecycle model changes
- Aggregate boundary changes

Architecture-impacting changes shall be documented through an approved **Architecture Decision Record (ADR)**.

---

# 19. Validation Rules

Every entity shall satisfy the following validation requirements before becoming part of the canonical repository.

## Mandatory Validation

- Entity name defined
- Aggregate assigned
- Aggregate Root identified
- Business Identifier specified
- Lifecycle defined
- Ownership identified
- Mutability defined
- Business description provided

## Architectural Validation

- Aggregate boundaries respected
- Naming standard compliance
- Business identifier uniqueness
- Technology independence
- Traceability established
- Compliance with enterprise business rules

Entities failing validation shall not be incorporated into the enterprise architecture.

---

# 20. Traceability

This document maintains complete traceability to the Phoenix Enterprise Architecture repository.

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Enterprise business concepts |
| ReferenceDomainLogicalModel | Aggregate definitions |
| ReferenceRelationships | Entity interaction rules |
| AggregateCatalog | Aggregate ownership |
| AggregateAttributeMatrix | Aggregate structure |
| EnterpriseAttributeDictionary | Canonical attributes |
| CanonicalBusinessRules | Business constraints |
| LogicalDatabaseModel | Logical entity mapping |
| PhysicalDatabaseModel | Physical implementation |

Traceability ensures consistency between conceptual, logical and physical architecture.

---

# 21. Related Artifacts

## Domain Architecture

- CanonicalDomainModel
- ReferenceDomainLogicalModel
- ReferenceRelationships

## Enterprise Data Architecture

- AggregateCatalog
- AggregateAttributeMatrix
- EnterpriseAttributeDictionary
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CanonicalBusinessRules

## Logical and Physical Models

- LogicalDatabaseModel
- PhysicalDatabaseModel

---

# 22. Approval

The Phoenix Enterprise Architecture Board approves this document as the authoritative definition of the logical entities belonging to the Reference Domain.

This document establishes the canonical business identity, ownership, lifecycle and architectural characteristics of all Reference Domain entities.

## Approval Status

**APPROVED**

---

# 23. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-07 | Initial logical entity definitions. |
| 2026.2 | 2026-07-20 | Enterprise Repository Edition aligned with the canonical architecture baseline. |

---

# 24. Architecture Compliance

This document complies with the following Phoenix Enterprise Architecture standards:

- Domain-Driven Design (DDD)
- Enterprise Information Architecture
- Repository Architecture (ADR-022)
- Canonical Domain Modeling Standard
- Enterprise Data Governance Framework
- Enterprise Naming Standard
- Aggregate Modeling Principles

All logical entity definitions shall remain technology independent and shall preserve aggregate integrity throughout the lifecycle of the Phoenix Platform.

---

# 25. Document Summary

The **Reference Entity Definitions** document defines the authoritative logical entities of the Phoenix Platform Reference Domain.

It provides the enterprise foundation for:

- Canonical entity definitions
- Aggregate ownership
- Business identifiers
- Entity lifecycle management
- Mutability rules
- Enterprise governance
- Logical database modeling
- Physical database implementation

Together with **ReferenceDomainLogicalModel** and **ReferenceRelationships**, this document forms the canonical logical specification of the Phoenix Platform Reference Domain.