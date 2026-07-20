# Reference Entity Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-002 |
| Document | ReferenceEntityDefinitions |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Enterprise Repository |
| Depends On | CanonicalDomainModel, ReferenceDomainLogicalModel, AggregateCatalog, AggregateAttributeMatrix, EnterpriseAttributeDictionary, CanonicalBusinessRules |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical logical entities that belong to the **Reference Domain** of the Phoenix Platform.

Reference entities represent stable enterprise business concepts that are shared across multiple domains and services. They provide standardized definitions for geographical, financial, market, classification, calendar and provider information.

This document establishes the authoritative business identity, ownership, lifecycle and governance rules for every reference entity.

The document is intentionally technology-independent and serves as the logical foundation for conceptual modeling, logical database modeling and physical database implementation.

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

- Canonical entity definitions
- Aggregate ownership
- Aggregate roots
- Business identifiers
- Entity lifecycle
- Entity mutability
- Cross-domain sharing
- Governance rules

## Excluded Topics

The following subjects are documented elsewhere:

- Physical database implementation
- PostgreSQL data types
- Foreign key implementation
- Table definitions
- SQL scripts
- Enterprise Attribute Dictionary
- Enterprise Relationship Catalog

---

# 3. Architectural Role

The Reference Domain provides the stable business vocabulary used throughout the Phoenix Platform.

Unlike operational domains, reference entities change infrequently and serve as shared master data across multiple bounded contexts.

Reference entities provide:

- Enterprise business terminology
- Canonical classifications
- Shared organizational structures
- Stable business identifiers
- Consistent cross-domain references

Reference entities shall remain independent of implementation technology and shall not contain operational business behavior.

---

# 4. Entity Definition Standard

Every reference entity shall comply with the Phoenix Enterprise Entity Standard.

Each entity definition shall include the following metadata.

| Property | Description |
|----------|-------------|
| Entity Name | Canonical business entity name |
| Aggregate | Owning aggregate |
| Aggregate Root | Indicates aggregate ownership |
| Business Identifier | Canonical business identifier |
| Lifecycle | Business lifecycle |
| Ownership | Owning business domain |
| Shared Across Domains | Enterprise sharing status |
| Mutable | Business mutability |
| Description | Business purpose |

Additional implementation-specific attributes are defined within the Enterprise Attribute Dictionary.

---

# 5. Geographic Aggregate

## Business Purpose

The Geographic Aggregate provides standardized geographical information used across the Phoenix Platform.

It defines countries, administrative regions, cities and time zones that support market operations, localization, reporting and integration.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Geographic |
| Aggregate Root | Country |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Limited |
| Lifecycle | Long-lived |

---

## 5.1 Country

### Business Purpose

Represents a sovereign country recognized by the Phoenix Platform.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Country |
| Aggregate | Geographic |
| Aggregate Root | Yes |
| Business Identifier | ISO 3166-1 Alpha-2 |
| Lifecycle | Active / Inactive |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Metadata only |
| Description | Canonical country definition used throughout the enterprise. |

---

## 5.2 Region

### Business Purpose

Represents an administrative subdivision of a country.

### Entity Metadata

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
| Description | Administrative or geographical subdivision belonging to a country. |

---

## 5.3 City

### Business Purpose

Represents a city or municipality.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | City |
| Aggregate | Geographic |
| Aggregate Root | No |
| Business Identifier | City Code |
| Lifecycle | Active / Inactive |
| Ownership | Geographic Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical city definition supporting enterprise localization and reporting. |

---

## 5.4 TimeZone

### Business Purpose

Represents an internationally recognized time zone.

### Entity Metadata

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
| Description | Standardized time zone used for scheduling, trading calendars and localization. |

---

# 6. Localization Aggregate

## Business Purpose

The Localization Aggregate defines the enterprise language and locale standards used throughout the Phoenix Platform.

It supports multilingual presentation, formatting, regional conventions and internationalization.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Localization |
| Aggregate Root | Language |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Rarely |
| Lifecycle | Long-lived |

---

## 6.1 Language

### Business Purpose

Represents a supported language within the Phoenix Platform.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Language |
| Aggregate | Localization |
| Aggregate Root | Yes |
| Business Identifier | ISO 639-1 |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Canonical language definition supporting multilingual capabilities. |

---

## 6.2 Locale

### Business Purpose

Represents a regional language configuration used for formatting and localization.

### Entity Metadata

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
| Description | Regional localization settings including language, formatting and cultural conventions. |

---

# 7. Financial Aggregate

## Business Purpose

The Financial Aggregate defines standardized monetary reference information used across financial markets and services.

It provides enterprise-wide definitions for currencies and related financial reference entities.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Financial |
| Aggregate Root | Currency |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Rarely |
| Lifecycle | Long-lived |

---

## 7.1 Currency

### Business Purpose

Represents an official monetary currency recognized by international standards.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Currency |
| Aggregate | Financial |
| Aggregate Root | Yes |
| Business Identifier | ISO 4217 |
| Lifecycle | Active / Inactive |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | No |
| Description | Canonical monetary currency used throughout the enterprise. |

---

## 7.2 CurrencyPair

### Business Purpose

Represents a tradable foreign exchange currency pair.

### Entity Metadata

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
| Description | Canonical foreign exchange currency pair supporting FX markets and analytical services. |

---

# 8. Market Aggregate

## Business Purpose

The Market Aggregate defines the enterprise structure of financial markets.

It provides standardized definitions for markets, exchanges and trading calendars that are shared across all market engines supported by the Phoenix Platform.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Market |
| Aggregate Root | Market |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Limited |
| Lifecycle | Long-lived |

---

## 8.1 Market

### Business Purpose

Represents a financial market supported by the Phoenix Platform.

A Market defines the highest-level business boundary for a collection of exchanges operating under common regulatory and business rules.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Market |
| Aggregate | Market |
| Aggregate Root | Yes |
| Business Identifier | Market Code |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical financial market definition (e.g., Iran Stock Market, Forex, Cryptocurrency Market). |

---

## 8.2 Exchange

### Business Purpose

Represents a securities or financial exchange operating within a Market.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Exchange |
| Aggregate | Market |
| Aggregate Root | No |
| Business Identifier | Exchange Code (MIC where applicable) |
| Lifecycle | Active |
| Ownership | Market Aggregate |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical exchange definition responsible for executing trades within a financial market. |

---

## 8.3 TradingCalendar

### Business Purpose

Defines official trading days, holidays and market-specific calendar exceptions.

### Entity Metadata

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
| Description | Enterprise trading calendar defining valid trading days and market holidays. |

---

## 8.4 TradingSession

### Business Purpose

Represents a trading session within a Trading Calendar.

### Entity Metadata

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
| Description | Defines official trading sessions such as Pre-Market, Regular Session and After-Hours trading. |

---

# 9. Classification Aggregate

## Business Purpose

The Classification Aggregate provides standardized business classifications used to organize financial instruments and issuers.

These classifications support reporting, analytics, portfolio construction and regulatory compliance.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Classification |
| Aggregate Root | AssetClass |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Limited |
| Lifecycle | Long-lived |

---

## 9.1 AssetClass

### Business Purpose

Represents the highest-level classification of financial assets.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | AssetClass |
| Aggregate | Classification |
| Aggregate Root | Yes |
| Business Identifier | Asset Class Code |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Canonical classification of financial asset categories such as Equity, Fixed Income, ETF, Commodity and Cryptocurrency. |

---

## 9.2 InstrumentType

### Business Purpose

Represents the classification of tradable financial instruments.

### Entity Metadata

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
| Description | Canonical classification of tradable instrument types. |

---

## 9.3 Sector

### Business Purpose

Represents a business sector used for enterprise-wide classification.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Sector |
| Aggregate | Classification |
| Aggregate Root | No |
| Business Identifier | Sector Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Standardized business sector classification. |

---

## 9.4 Industry

### Business Purpose

Represents an industry belonging to a business sector.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | Industry |
| Aggregate | Classification |
| Aggregate Root | No |
| Business Identifier | Industry Code |
| Lifecycle | Active |
| Ownership | Classification Aggregate |
| Shared Across Domains | Yes |
| Mutable | Rarely |
| Description | Canonical industry classification supporting reporting and analytics. |

---

# 10. Calendar Aggregate

## Business Purpose

The Calendar Aggregate defines enterprise calendars that govern business operations, market activities and scheduling.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Calendar |
| Aggregate Root | HolidayCalendar |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Yes |
| Lifecycle | Long-lived |

---

## 10.1 HolidayCalendar

### Business Purpose

Represents a calendar defining public holidays and market holidays.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | HolidayCalendar |
| Aggregate | Calendar |
| Aggregate Root | Yes |
| Business Identifier | Calendar Code |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Yes |
| Description | Enterprise holiday calendar used by scheduling, trading and operational services. |

---

# 11. Provider Aggregate

## Business Purpose

The Provider Aggregate defines external organizations that supply market data, reference information or integration services.

Provider entities establish a standardized abstraction over external systems.

### Aggregate Characteristics

| Property | Value |
|----------|-------|
| Aggregate | Provider |
| Aggregate Root | DataProvider |
| Domain | Reference Domain |
| Shared | Enterprise-wide |
| Mutable | Limited |
| Lifecycle | Long-lived |

---

## 11.1 DataProvider

### Business Purpose

Represents an external organization supplying information to the Phoenix Platform.

### Entity Metadata

| Property | Value |
|----------|-------|
| Entity Name | DataProvider |
| Aggregate | Provider |
| Aggregate Root | Yes |
| Business Identifier | Provider Code |
| Lifecycle | Active |
| Ownership | Reference Domain |
| Shared Across Domains | Yes |
| Mutable | Limited |
| Description | Canonical definition of an external market data or information provider. |

---

## 11.2 DataSource

### Business Purpose

Represents a specific source of information supplied by a Data Provider.

### Entity Metadata

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
| Description | Logical source of information provided by a Data Provider. |

---

# 12. Entity Ownership

Entity ownership defines the authoritative business domain responsible for maintaining each reference entity.

Ownership establishes accountability for lifecycle management, governance and business correctness.

## Ownership Principles

The following principles apply:

- Every entity shall belong to exactly one aggregate.
- Every aggregate shall belong to exactly one business domain.
- Ownership shall remain stable throughout the entity lifecycle.
- Cross-domain access shall not transfer ownership.
- Ownership changes require Architecture Board approval.

---

# 13. Entity Lifecycle

Reference entities follow controlled business lifecycles.

Unlike operational entities, reference entities are expected to remain stable for extended periods.

## Lifecycle States

Typical lifecycle states include:

- Proposed
- Approved
- Active
- Suspended
- Deprecated
- Retired

Lifecycle transitions shall be governed by enterprise data governance policies.

---

# 14. Business Identifier Strategy

Every reference entity shall expose a canonical business identifier.

Business identifiers provide stable, human-readable references independent of implementation technology.

## Business Identifier Principles

- Business identifiers shall be unique within their scope.
- Business identifiers shall remain stable whenever possible.
- Business identifiers shall not be used as technical primary keys.
- Business identifiers shall support enterprise interoperability.
- Changes shall be governed by approved business processes.

---

# 15. Aggregate Root Policy

Aggregate Roots define the consistency boundaries of the Reference Domain.

Only Aggregate Roots may be referenced directly from outside their aggregate.

## Policy Rules

- Every aggregate shall have exactly one Aggregate Root.
- Child entities shall not be referenced independently across aggregates.
- Aggregate invariants shall be enforced through the Aggregate Root.
- Aggregate boundaries shall remain stable unless superseded by an approved Architecture Decision Record (ADR).

---

# 16. Entity Mutability Rules

Reference entities are expected to be stable.

Business semantics should change infrequently and only through controlled governance processes.

## Mutability Principles

- Business identity shall remain immutable.
- Business identifiers shall remain stable.
- Metadata may be updated when required.
- Historical integrity shall be preserved.
- Breaking changes require architectural approval.

---

# 17. Cross-Domain Sharing

Reference entities are shared assets used throughout the Phoenix Platform.

They provide a common enterprise vocabulary that supports interoperability across bounded contexts.

## Sharing Principles

- Reference entities shall be reusable.
- Duplicate definitions are prohibited.
- Shared entities shall preserve semantic consistency.
- Consumer domains shall reference—not redefine—reference entities.
- Enterprise governance shall ensure consistency across all domains.

---

# 18. Naming Standards

Reference entities shall comply with the Phoenix Enterprise Naming Standards.

Naming conventions ensure consistency across business documentation, logical models, physical implementations and application services.

## Naming Principles

The following principles shall apply to every reference entity.

- Entity names shall represent business concepts.
- Entity names shall be singular.
- Entity names shall be written in PascalCase.
- Names shall avoid implementation terminology.
- Names shall remain stable over time.
- Abbreviations shall be avoided unless internationally recognized.
- Names shall be technology independent.

### Examples

| Correct | Incorrect |
|----------|-----------|
| Country | Countries |
| Exchange | ExchangeTable |
| TradingCalendar | TblTradingCalendar |
| Currency | CurrencyEntity |

---

# 19. Entity Relationships

Reference entities establish the canonical relationships used throughout the Phoenix Platform.

These relationships define logical dependencies between entities while remaining independent of database implementation.

## Relationship Principles

- Relationships are business relationships.
- Relationships shall reference Aggregate Roots whenever possible.
- Cardinalities are defined within the Logical Database Model.
- Physical foreign keys are defined within the Physical Database Model.
- Circular dependencies between aggregates are prohibited.

### Relationship Overview

| Source Entity | Target Entity | Relationship |
|---------------|---------------|--------------|
| Country | Region | One-to-Many |
| Region | City | One-to-Many |
| Language | Locale | One-to-Many |
| Market | Exchange | One-to-Many |
| Exchange | TradingCalendar | One-to-Many |
| AssetClass | InstrumentType | One-to-Many |
| Sector | Industry | One-to-Many |
| DataProvider | DataSource | One-to-Many |

Detailed relationship definitions are maintained within the Enterprise Relationship Catalog and the Logical Database Model.

---

# 20. Governance Rules

Reference entities are governed by enterprise-wide data governance policies.

Governance ensures consistency, quality and long-term maintainability.

## Governance Principles

The following rules shall always apply.

- Every entity shall belong to exactly one aggregate.
- Every aggregate shall belong to the Reference Domain.
- Business identifiers shall remain unique.
- Duplicate entities are prohibited.
- Entity ownership shall be clearly defined.
- Shared entities shall not be duplicated.
- Changes require architectural review.
- Historical business semantics shall be preserved.

---

# 21. Validation Rules

Logical entity definitions shall be validated before approval.

Validation ensures compliance with enterprise architecture standards.

## Validation Checklist

Every entity definition shall satisfy the following criteria.

- Business purpose is clearly documented.
- Aggregate ownership is defined.
- Aggregate Root designation is correct.
- Business identifier is specified.
- Lifecycle is defined.
- Ownership is assigned.
- Mutability is documented.
- Cross-domain sharing is identified.
- Naming complies with enterprise standards.
- Description accurately reflects business semantics.

Entity definitions that fail validation shall not be incorporated into the canonical model.

---

# 22. Traceability

Every entity definition shall be traceable to approved enterprise architecture artifacts.

Traceability ensures consistency across conceptual, logical and physical models.

## Traceability Matrix

| Source Artifact | Traceability |
|-----------------|--------------|
| CanonicalDomainModel | Business concepts |
| ReferenceDomainLogicalModel | Aggregate definitions |
| AggregateCatalog | Aggregate ownership |
| AggregateAttributeMatrix | Attribute allocation |
| EnterpriseAttributeDictionary | Canonical attributes |
| EnterpriseRelationshipCatalog | Business relationships |
| EnterpriseRelationshipMatrix | Relationship matrix |
| CanonicalBusinessRules | Business constraints |
| LogicalDatabaseModel | Logical implementation |
| PhysicalDatabaseModel | Physical implementation |

---

# 23. Related Artifacts

The following documents complement this specification.

## Enterprise Architecture

- CanonicalDomainModel
- ReferenceDomainLogicalModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix

## Data Architecture

- AggregateCatalog
- AggregateAttributeMatrix
- EnterpriseAttributeDictionary
- CanonicalBusinessRules

## Repository Standards

- Repository Architecture (ADR-022)
- Enterprise Naming Standard
- Enterprise Data Governance Standard

---

# 24. Approval

The Phoenix Architecture Board approves this document as the official logical definition of the Reference Domain entities.

This document establishes the canonical enterprise definitions for all Reference Domain entities and serves as the authoritative source for subsequent conceptual, logical and physical data modeling activities.

## Approval Status

**APPROVED**

---

# 25. Revision History

| Version | Date | Description |
|----------|------------|-------------------------------------------------------------|
| 2026.1 | 2026-07-20 | Initial Enterprise Repository Edition of the Reference Entity Definitions. |