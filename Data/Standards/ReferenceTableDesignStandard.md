---
title: Reference Table Design Standard
document_code: STD-DATA-003
version: 1.0
status: Approved
owner: Phoenix Architecture Team
reviewers:
  - Enterprise Architecture Board
approvers:
  - Chief Architect
created: 2026-07-27
last_updated: 2026-07-27
effective_date: 2026-07-27
category: Data Standard
domain: Data Architecture
layer: Database
applies_to:
  - PostgreSQL
  - Reference Tables
related_documents:
  - EnterpriseDatabaseDesignStandard.md
  - EnterpriseNamingStandard.md
  - EnterpriseDataTypeStandard.md
  - MasterEntityDesignStandard.md
  - FactTableDesignStandard.md
  - AuditModelStandard.md
  - IdentifierStrategy.md
supersedes: null
superseded_by: null
---

# 1. Purpose

## 1.1 Objective

This standard defines the architectural principles, design rules, and
implementation requirements for Reference Tables within the Phoenix Platform.

Its purpose is to establish a consistent, maintainable, and enterprise-grade
approach for designing and managing reference data across the repository.

Reference Tables SHALL provide the canonical source for controlled business
classifications, enumerations, and predefined business values.

---

## 1.2 Scope

This standard applies to all Reference Tables within the Phoenix Repository.

It governs the logical and physical design of Reference Tables used by
Master Entities, Fact Tables, and other database components.

This standard applies regardless of the business domain, financial market,
or implementation technology.

---

## 1.3 Objectives

The objectives of this standard are to:

- Standardize the design of Reference Tables.
- Eliminate duplicated classification values.
- Promote repository-wide consistency.
- Support referential integrity.
- Improve maintainability and extensibility.
- Enable controlled business classifications.
- Provide a single source of truth for reference data.

---

## 1.4 Architectural Role

Reference Tables provide standardized business classifications and controlled
vocabularies shared across the Phoenix Platform.

Unlike Master Entities, they do not represent independent business objects.

Unlike Fact Tables, they do not record business events or historical
transactions.

Their primary responsibility is to define and maintain reusable reference
values that support consistent business processing.

---

## 1.5 Repository Integration

Reference Tables are an integral part of the Phoenix Enterprise Data Model.

They SHALL be designed in accordance with the repository architecture and
remain consistent with all applicable enterprise standards.

Reference Tables SHALL serve as reusable shared components across multiple
business domains and services.

---

## 1.6 Relationship to Other Standards

This document complements, but does not replace, the following enterprise
standards:

- EnterpriseDatabaseDesignStandard
- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityDesignStandard
- FactTableDesignStandard
- AuditModelStandard
- IdentifierStrategy

Where overlapping guidance exists, the more specialized standard SHALL take
precedence within its defined scope.

---

## 1.7 Intended Audience

This standard is intended for:

- Enterprise Architects
- Solution Architects
- Database Architects
- Database Developers
- Backend Developers
- Data Engineers
- Repository Maintainers
- Architecture Reviewers

All stakeholders responsible for designing or reviewing Reference Tables
SHALL comply with this standard.

---

## 1.8 Guiding Principle

Reference Tables SHALL define reusable business classifications rather than
business entities or business events.

Every reference value SHALL have a clear business meaning, a well-defined
ownership, and a controlled lifecycle.

Reference data SHALL be maintained centrally to ensure consistency,
reusability, and long-term governance across the Phoenix Platform.

---

# 2. Reference Table Definition

## 2.1 Definition

A Reference Table is a database object that stores controlled business
classifications, predefined values, enumerations, or lookup data used
throughout the Phoenix Platform.

Reference Tables provide the canonical source for standardized business
values and ensure consistent interpretation across all services,
applications, and database objects.

Reference Tables do not represent independent business entities and do not
record business events or historical transactions.

---

## 2.2 Characteristics

Every Reference Table SHALL exhibit the following characteristics:

- Business-controlled
- Repository-wide reusable
- Low volatility
- Shared across multiple domains
- Referentially stable
- Canonical
- Self-descriptive

Reference Tables SHALL contain only approved business values.

---

## 2.3 Business Responsibilities

Reference Tables are responsible for:

- Defining controlled business classifications.
- Providing reusable lookup values.
- Standardizing business terminology.
- Supporting referential integrity.
- Eliminating duplicated classification values.
- Improving data consistency.
- Supporting enterprise governance.

---

## 2.4 Reference Data

Reference data includes, but is not limited to:

- Market types
- Exchange types
- Instrument types
- Currency definitions
- Trading session types
- Order book sides
- Snapshot types
- Data quality statuses
- Price adjustment statuses
- Timeframes

Reference data SHALL be centrally governed.

---

## 2.5 Business Independence

Reference Tables SHALL remain independent from transactional processing.

They define reusable business values rather than business activity.

Changes to Reference Tables SHALL represent changes to controlled business
classifications rather than operational events.

---

## 2.6 Referential Model

Reference Tables SHALL be referenced through canonical foreign keys.

Business classifications SHALL NOT be duplicated as free-text values.

Correct:

price_adjustment_status_id

Incorrect:

price_adjustment_status_name

status

type

---

## 2.7 Lifecycle

Reference data is expected to change infrequently.

Business values SHOULD be added, modified, or retired through controlled
governance processes.

Historical business records SHALL continue to reference previously valid
reference values.

Reference values SHOULD be deactivated rather than physically deleted unless
their removal has been formally approved.

---

## 2.8 Canonical Source of Truth

Each business classification SHALL have exactly one canonical Reference
Table.

Duplicate Reference Tables representing the same business concept are
prohibited.

Examples:

One canonical Currency table.

One canonical MarketSnapshotType table.

One canonical OrderBookSide table.

---

## 2.9 Relationship with Master Entities

Reference Tables SHALL NOT replace Master Entities.

Master Entities represent independent business objects.

Reference Tables define classifications applied to those business objects.

Examples:

Instrument (Master Entity)

↓

InstrumentType (Reference Table)

Exchange (Master Entity)

↓

ExchangeType (Reference Table)

---

## 2.10 Relationship with Fact Tables

Fact Tables SHALL reference Reference Tables through foreign keys.

Reference Tables SHALL NOT contain transactional measurements,
business events, or historical observations.

Examples:

DailyMarketData

↓

price_adjustment_status_id

↓

PriceAdjustmentStatus

OrderBookSnapshot

↓

market_snapshot_type_id

↓

MarketSnapshotType

---

## 2.11 Design Principle

The following principle governs every Reference Table in Phoenix:

"A Reference Table defines what values are allowed, never what happened."

Business entities belong to Master Entities.

Business events belong to Fact Tables.

Business classifications belong to Reference Tables.

---

# 3. Design Principles

## 3.1 General Principles

Every Reference Table within the Phoenix Platform SHALL be designed according
to a common set of enterprise architectural principles.

These principles ensure consistency, maintainability, reusability, and
long-term governance across all business domains and financial markets.

---

## 3.2 Single Responsibility

A Reference Table SHALL represent exactly one business classification.

A Reference Table SHALL NOT combine multiple unrelated classifications.

Correct:

Currency

Incorrect:

CurrencyAndExchange

---

## 3.3 Single Source of Truth

Every business classification SHALL have one and only one canonical
Reference Table.

The same classification SHALL NOT be duplicated in multiple Reference Tables.

If multiple business domains require the same classification, they SHALL
reference the same Reference Table.

---

## 3.4 Separation of Concerns

Reference Tables define business classifications.

Master Entities define business objects.

Fact Tables record business facts.

Configuration Tables define application settings.

Each object type SHALL have a single architectural responsibility.

---

## 3.5 Canonical References

Reference Tables SHALL be referenced through canonical foreign keys.

Applications and database objects SHALL reference identifiers rather than
codes or descriptive values.

Correct:

currency_id

Incorrect:

currency_code

currency_name

---

## 3.6 Business Stability

Reference data SHOULD remain stable.

Changes SHALL occur only when business classifications change.

Operational or transactional events SHALL NOT modify reference data.

---

## 3.7 Controlled Vocabulary

Reference Tables SHALL provide a controlled business vocabulary.

Free-text business classifications are prohibited where a canonical
Reference Table exists.

---

## 3.8 Normalization

Business classifications SHALL be normalized.

Duplicate classification values SHALL NOT exist.

Reference Tables SHALL NOT duplicate Master Entity attributes or Fact Table
measurements.

---

## 3.9 Self-Descriptive Columns

Every column SHALL comply with the Enterprise Naming Standard.

Column names SHALL clearly express their business meaning.

Examples:

currency_id

currency_code

currency_name

display_order

is_active

Generic column names are prohibited.

Examples of prohibited names:

id

code

name

type

status

---

## 3.10 Extensibility

Reference Tables SHALL support future business growth.

The design SHALL accommodate:

- Additional financial markets
- Additional asset classes
- New business classifications
- Future enterprise services

without requiring architectural redesign.

---

## 3.11 Business Independence

Reference Tables SHALL remain independent of operational processing.

They SHALL define reusable business values rather than business activities.

Reference Tables SHALL NOT contain transactional data.

---

## 3.12 Governance

Reference data SHALL be centrally governed.

Creation, modification, retirement, and deletion of reference values SHALL
follow an approved governance process.

---

## 3.13 Architecture Before Implementation

Reference Tables SHALL be designed from the enterprise architecture.

Implementation SHALL follow architecture.

Architecture SHALL NOT be altered to satisfy implementation shortcuts.

---

## 3.14 Repository Consistency

Equivalent business classifications SHALL be represented consistently
throughout the Phoenix Repository.

Consistency across the repository has higher priority than local
optimization.

---

## 3.15 Design Principle Summary

Every Reference Table SHALL satisfy the following principles:

✓ Single Responsibility

✓ Single Source of Truth

✓ Separation of Concerns

✓ Canonical References

✓ Business Stability

✓ Controlled Vocabulary

✓ Normalization

✓ Self-Descriptive Columns

✓ Extensibility

✓ Central Governance

✓ Architecture First

✓ Repository Consistency

---

# 4. Canonical Reference Table Architecture

## 4.1 Purpose

This section defines the canonical architecture of Reference Tables within
the Phoenix Platform.

Every Reference Table SHALL follow a consistent structural model to ensure
repository-wide consistency, readability, maintainability, and governance.

---

## 4.2 Canonical Structure

A Reference Table SHOULD be organized using the following logical column
groups:

1. Primary Identifier
2. Business Identifier
3. Business Description
4. Business Attributes
5. Display Attributes
6. Status Attributes
7. Audit Attributes

---

## 4.3 Primary Identifier

Every Reference Table SHALL contain one surrogate primary key.

Examples:

currency_id

market_snapshot_type_id

order_book_side_id

The primary identifier SHALL be immutable.

---

## 4.4 Business Identifier

Every Reference Table SHALL define a business identifier.

Typical examples include:

currency_code

market_snapshot_type_code

order_book_side_code

Business identifiers SHALL be unique within the Reference Table.

---

## 4.5 Business Description

Business descriptions SHALL clearly identify the reference value.

Typical columns include:

currency_name

market_snapshot_type_name

order_book_side_name

An additional local language representation MAY be provided when required.

Examples:

currency_local_name

market_snapshot_type_local_name

order_book_side_local_name

The suffix `_local_name` SHALL be used only for an additional localized
representation.

It SHALL NOT replace the canonical `<entity>_name` column.

Descriptive columns SHALL comply with the Enterprise Naming Standard.

---

## 4.6 Business Attributes

Reference Tables MAY contain additional business attributes that describe
the reference value.

Examples include:

sort_order

display_color

display_symbol

abbreviation

icon_name

Business attributes SHALL describe the reference value itself and SHALL NOT
contain transactional information.

---

## 4.7 Display Attributes

Display-related attributes MAY be included when required.

Examples:

display_group

display_sequence

Presentation-specific formatting SHALL remain outside the database whenever
possible.

---

## 4.8 Status Attributes

Reference Tables SHOULD support controlled lifecycle management.

Typical attributes include:

is_active

effective_from_date

effective_to_date

Status attributes SHALL represent business validity rather than technical
state.

---

## 4.9 Audit Attributes

Audit columns SHALL comply with the AuditModelStandard.

Reference Tables SHALL NOT define custom audit structures.

---

## 4.10 Recommended Column Order

The recommended column order is:

1. Primary Identifier
2. Business Identifier
3. Business Description
4. Business Attributes
5. Display Attributes
6. Status Attributes
7. Audit Attributes

Equivalent Reference Tables SHALL follow the same column order throughout
the repository.

---

## 4.11 Design Principle

The structure of every Reference Table SHALL prioritize:

- Clarity
- Consistency
- Reusability
- Governance

Architectural consistency SHALL take precedence over local implementation
preferences.

---

# 5. Reference Table Classification

## 5.1 Purpose

This section defines the canonical classification of Reference Tables within
the Phoenix Platform.

Classification provides a consistent architectural model for organizing,
designing, and governing reference data across all business domains.

Each Reference Table SHALL belong to exactly one primary classification.

---

## 5.2 Classification Principles

Reference Tables SHALL be classified according to their primary business
responsibility.

The selected classification SHALL remain stable throughout the lifecycle of
the Reference Table.

If a Reference Table appears to satisfy multiple classifications, the
dominant business purpose SHALL determine its classification.

---

## 5.3 Business Classification Reference

Business Classification References define business categories and
classifications used throughout the platform.

Typical examples include:

- InstrumentType
- ExchangeType
- MarketType
- BoardType
- TradingSessionType
- PriceAdjustmentStatus
- DataQualityStatus

---

## 5.4 Geographic Reference

Geographic References define geographical or jurisdictional information.

Typical examples include:

- Country
- Region
- Province
- City
- TimeZone

---

## 5.5 Financial Reference

Financial References define reusable financial concepts shared across
multiple business domains.

Typical examples include:

- Currency
- SettlementCycle
- Timeframe
- MarketSnapshotType
- OrderBookSide

---

## 5.6 Technical Reference

Technical References define values required by the platform architecture
rather than by the business domain.

Typical examples include:

- ImportStatus
- ProcessingStatus
- SynchronizationStatus
- ValidationSeverity

Technical References SHALL remain independent from business classifications.

---

## 5.7 Repository Rules

Equivalent business concepts SHALL use the same Reference Table.

Duplicate Reference Tables representing the same classification are
prohibited.

Reference Tables SHALL be shared across services whenever possible.

---

## 5.8 Future Extensions

Additional classifications MAY be introduced as the Phoenix Platform evolves.

New classifications SHALL require approval through the repository governance
process or an Architecture Decision Record (ADR).

---

## 5.9 Classification Summary

| Classification | Purpose | Example |
|----------------|---------|---------|
| Business Classification Reference | Defines business categories | InstrumentType |
| Geographic Reference | Defines geographical values | Country |
| Financial Reference | Defines reusable financial concepts | Currency |
| Technical Reference | Defines platform-level classifications | ProcessingStatus |

---

# 6. Mandatory Column Groups

## 6.1 Purpose

This section defines the mandatory column groups for Reference Tables within
the Phoenix Platform.

A consistent column organization improves readability, maintainability,
governance, and repository-wide consistency.

Unless explicitly approved through an Architecture Decision Record (ADR),
every Reference Table SHALL follow the column group structure defined in this
standard.

---

## 6.2 Mandatory Group Order

Reference Tables SHALL organize their columns in the following order:

1. Primary Identifier

2. Business Identifier

3. Business Description

4. Business Attributes

5. Lifecycle Attributes

6. Audit Attributes

---

## 6.3 Primary Identifier

Purpose

Provide the immutable surrogate identifier of the reference value.

Requirements

- Exactly one column.
- BIGINT.
- GENERATED ALWAYS AS IDENTITY.
- Primary Key.
- Immutable.

Examples

currency_id

market_snapshot_type_id

order_book_side_id

---

## 6.4 Business Identifier

Purpose

Provide the stable business identifier of the reference value.

Requirements

- Unique within the Reference Table.
- Human-readable where appropriate.
- Used for business interoperability.
- SHALL NOT be the Primary Key.

Examples

currency_code

market_snapshot_type_code

order_book_side_code

---

## 6.5 Business Description

Purpose

Provide the business-readable description of the reference value.

Mandatory column

<entity>_name

Optional columns

<entity>_local_name

<entity>_description

Requirements

- `<entity>_name` SHALL be present.
- `<entity>_local_name` MAY be provided when a localized business name is
  required.
- `_local_name` SHALL NOT replace the canonical `_name` column.

Examples

currency_name

currency_local_name

market_snapshot_type_name

market_snapshot_type_local_name

---

## 6.6 Business Attributes

Purpose

Store additional attributes that describe the reference value.

Examples

sort_order

display_symbol

abbreviation

icon_name

Business attributes SHALL describe the reference value itself.

They SHALL NOT contain transactional or operational data.

---

## 6.7 Lifecycle Attributes

Purpose

Control the business lifecycle of the reference value.

Typical columns

is_active

effective_from_date

effective_to_date

Lifecycle attributes SHALL represent business validity.

They SHALL NOT represent application state.

---

## 6.8 Audit Attributes

Purpose

Provide traceability for creation and modification of reference data.

Audit columns SHALL comply with the AuditModelStandard.

Reference Tables SHALL NOT define custom audit structures.

---

## 6.9 Optional Column Groups

Additional column groups MAY be introduced only when justified by business
requirements.

Examples include:

- Localization
- External Standard Mapping
- Regulatory Classification

Optional groups SHALL appear before the Audit Attributes unless otherwise
approved.

---

## 6.10 Prohibited Column Groups

The following column groups SHALL NOT appear in Reference Tables:

- Business Measurements
- Transaction Data
- Historical Events
- User Preferences
- Presentation Data
- Processing Metadata

Such information belongs to other architectural components.

---

## 6.11 Summary

Every Reference Table SHALL organize its columns according to the following
canonical sequence:

Primary Identifier

↓

Business Identifier

↓

Business Description

↓

Business Attributes

↓

Lifecycle Attributes

↓

Audit Attributes

---

# 7. Primary Key Standard

## 7.1 Purpose

This section defines the mandatory requirements for primary keys used by
Reference Tables within the Phoenix Platform.

Every Reference Table SHALL use a consistent surrogate primary key strategy
to ensure repository-wide consistency and long-term maintainability.

---

## 7.2 Primary Key Requirement

Every Reference Table SHALL define exactly one Primary Key.

The Primary Key SHALL uniquely identify each reference value within the
Reference Table.

Primary Keys SHALL NOT contain business meaning.

---

## 7.3 Primary Key Type

The Primary Key SHALL satisfy the following requirements:

- Data type: BIGINT
- NOT NULL
- GENERATED ALWAYS AS IDENTITY
- Immutable
- Unique

Primary Keys SHALL NOT be updated after creation.

---

## 7.4 Naming Convention

Primary Key column names SHALL comply with the Enterprise Naming Standard.

The column name SHALL use the following format:

<reference_table_name>_id

Examples:

currency_id

market_snapshot_type_id

order_book_side_id

price_adjustment_status_id

Primary Key columns SHALL NOT use generic names such as:

id

reference_id

record_id

---

## 7.5 Surrogate Identifier

Reference Tables SHALL use surrogate identifiers as Primary Keys.

Business identifiers SHALL remain separate from the Primary Key.

Surrogate identifiers SHALL NOT be exposed as business codes.

---

## 7.6 Business Independence

Changes to business identifiers SHALL NOT require modification of the
Primary Key.

The Primary Key SHALL remain stable throughout the lifecycle of the
reference value.

---

## 7.7 Foreign Key References

Other database objects SHALL reference Reference Tables through their
Primary Keys.

Applications SHALL NOT establish relationships using business codes or
descriptive names.

Correct:

currency_id

Incorrect:

currency_code

currency_name

---

## 7.8 Prohibited Practices

The following practices are prohibited:

- Using business codes as Primary Keys.
- Using descriptive names as Primary Keys.
- Updating Primary Key values.
- Defining composite Primary Keys.
- Using generic column names such as `id`.

---

## 7.9 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Exactly one Primary Key

✓ BIGINT data type

✓ GENERATED ALWAYS AS IDENTITY

✓ Immutable after creation

✓ Self-descriptive column name

✓ Surrogate identifier

✓ No business meaning

---

# 8. Business Key Standard

## 8.1 Purpose

This section defines the requirements for Business Keys used by Reference
Tables within the Phoenix Platform.

A Business Key uniquely identifies a reference value according to business
rules.

Business Keys SHALL remain independent of the surrogate Primary Key.

---

## 8.2 Business Identity

Every Reference Table SHALL define a Business Key.

The Business Key represents the business identity of a reference value.

Business Keys SHALL be stable, unique, and meaningful within their business
context.

---

## 8.3 Business Key Composition

A Business Key MAY consist of one or more business attributes.

Single-column Business Keys are preferred whenever sufficient.

Composite Business Keys SHALL be used only when required by business rules.

Examples

Currency

currency_code

MarketSnapshotType

market_snapshot_type_code

OrderBookSide

order_book_side_code

---

## 8.4 Stability

Business Keys SHOULD remain stable throughout the lifecycle of the reference
value.

Changes to a Business Key SHALL occur only when explicitly required by
business rules.

Changing a Business Key SHALL NOT require modification of the Primary Key.

---

## 8.5 Uniqueness

Every Business Key SHALL be unique.

Business uniqueness SHALL be enforced using a UNIQUE constraint.

Business Keys SHALL NOT permit duplicate values.

---

## 8.6 Nullability

Business Key columns SHALL be defined as NOT NULL.

Reference values without a Business Key are prohibited.

---

## 8.7 Naming Convention

Business Key columns SHALL comply with the Enterprise Naming Standard.

Typical examples include:

currency_code

market_snapshot_type_code

order_book_side_code

price_adjustment_status_code

Generic names such as:

code

business_code

reference_code

are prohibited.

---

## 8.8 Relationship to Primary Key

The Primary Key provides technical identity.

The Business Key provides business identity.

These two identities SHALL remain independent.

Applications MAY use the Business Key for business interoperability.

Database relationships SHALL use the Primary Key.

---

## 8.9 Prohibited Practices

The following practices are prohibited:

- Using the Business Key as the Primary Key.
- Allowing duplicate Business Keys.
- Allowing NULL Business Keys.
- Using generic column names.
- Changing Business Keys without business justification.

---

## 8.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Business Key defined

✓ Business Key unique

✓ NOT NULL

✓ Independent of Primary Key

✓ Enterprise Naming Standard compliance

✓ Business meaning documented

---

# 9. Foreign Key Standard

## 9.1 Purpose

This section defines the architectural principles governing foreign key
relationships for Reference Tables within the Phoenix Platform.

Reference Tables SHALL remain as independent as possible while preserving
referential integrity where business relationships exist.

---

## 9.2 General Principle

Reference Tables SHOULD NOT reference other Reference Tables unless a genuine
business dependency exists.

The preferred architecture is a flat and reusable reference model.

Unnecessary dependencies between Reference Tables are prohibited.

---

## 9.3 Permitted Relationships

A Reference Table MAY reference another Reference Table when the referenced
value represents a permanent business classification.

Typical examples include:

Currency
    ↓
CurrencyType

Exchange
    ↓
Country

AdministrativeRegion
    ↓
Country

Such relationships SHALL represent stable business structures.

---

## 9.4 Prohibited Relationships

Reference Tables SHALL NOT reference:

- Fact Tables
- Transaction Tables
- Operational Tables
- Temporary Tables

Reference Tables SHALL remain independent from transactional processing.

---

## 9.5 Circular Dependencies

Circular foreign key relationships are prohibited.

The dependency graph between Reference Tables SHALL remain acyclic.

---

## 9.6 Foreign Key Naming

Foreign key columns SHALL comply with the Enterprise Naming Standard.

Format:

<referenced_table_name>_id

Examples:

country_id

currency_type_id

market_type_id

Generic names such as:

type_id

reference_id

parent_id

are prohibited unless they explicitly identify the referenced business
concept.

---

## 9.7 Referential Integrity

All foreign key relationships SHALL enforce referential integrity.

The following referential actions are recommended:

ON UPDATE RESTRICT

ON DELETE RESTRICT

Alternative actions SHALL require explicit business justification.

---

## 9.8 Nullable Foreign Keys

Foreign key columns SHOULD be defined as NOT NULL.

Nullable foreign keys MAY be used only when the business relationship is
optional.

---

## 9.9 Repository Consistency

Equivalent Reference Tables SHALL use identical foreign key relationships
throughout the repository.

The same business relationship SHALL NOT be modeled differently in different
Reference Tables.

---

## 9.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Foreign Keys only where business dependency exists

✓ No references to Fact Tables

✓ No circular dependencies

✓ Self-descriptive foreign key names

✓ Referential integrity enforced

✓ Repository-wide consistency maintained

---

# 10. Data Type Standard

## 10.1 Purpose

This section defines the standard data types for columns used in Reference
Tables within the Phoenix Platform.

Reference Tables SHALL use canonical enterprise data types to ensure
consistency, maintainability, and interoperability across the repository.

Detailed data type definitions are governed by the
EnterpriseDataTypeStandard.

---

## 10.2 General Principles

Reference Tables SHALL use the most appropriate data type for each business
attribute.

Data types SHALL accurately represent the business meaning of the stored
value.

Overly large or unnecessarily restrictive data types SHOULD be avoided.

---

## 10.3 Identifier Columns

Primary Key columns SHALL use:

BIGINT

Foreign Key columns SHALL use the same data type as the referenced Primary
Key.

Business Key columns SHALL use an appropriate character type as defined by
the EnterpriseDataTypeStandard.

---

## 10.4 Business Description Columns

Business description columns SHALL use character data types.

Typical examples include:

<entity>_name

<entity>_local_name

<entity>_description

The maximum length SHALL comply with the EnterpriseDataTypeStandard.

---

## 10.5 Business Attribute Columns

Business attributes SHALL use data types appropriate to their business
meaning.

Examples:

sort_order

INTEGER

display_symbol

VARCHAR

abbreviation

VARCHAR

icon_name

VARCHAR

---

## 10.6 Status Columns

Status attributes SHALL use:

BOOLEAN

Examples:

is_active

Additional lifecycle attributes SHALL comply with the
EnterpriseDataTypeStandard.

---

## 10.7 Date Columns

Business lifecycle dates SHALL use:

DATE

Examples:

effective_from_date

effective_to_date

Timestamp data types SHALL be used only when business requirements require
time precision.

---

## 10.8 Numeric Columns

Numeric columns SHALL be used only when required by the business.

Typical examples include:

sort_order

INTEGER

decimal_places

SMALLINT

Numeric precision SHALL comply with the EnterpriseDataTypeStandard.

---

## 10.9 Nullability

Columns SHALL be defined as NOT NULL whenever the business value is
mandatory.

Nullable columns SHALL be used only when the business meaning of an unknown
or inapplicable value is valid.

---

## 10.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Canonical data types

✓ Consistent identifier types

✓ Appropriate character types

✓ Appropriate numeric types

✓ Mandatory values defined as NOT NULL

✓ Compliance with EnterpriseDataTypeStandard

---

# 11. Unique Constraint Standard

## 11.1 Purpose

This section defines the standard for UNIQUE constraints used by Reference
Tables within the Phoenix Platform.

UNIQUE constraints ensure that each business reference value is represented
only once and prevent duplication of controlled business classifications.

---

## 11.2 General Principles

Every Reference Table SHALL enforce business uniqueness through one or more
UNIQUE constraints.

UNIQUE constraints SHALL be based on business rules rather than technical
implementation details.

---

## 11.3 Business Key Uniqueness

Every Business Key SHALL be protected by a UNIQUE constraint.

Examples:

currency_code

market_snapshot_type_code

order_book_side_code

price_adjustment_status_code

Business Key values SHALL NOT be duplicated.

---

## 11.4 Business Name Uniqueness

Business names SHOULD be unique whenever required by business rules.

Examples:

currency_name

market_snapshot_type_name

order_book_side_name

Business names MAY remain non-unique only when explicitly permitted by the
business domain.

---

## 11.5 Composite Uniqueness

A composite UNIQUE constraint MAY be used when business uniqueness depends
upon multiple attributes.

Composite UNIQUE constraints SHALL represent a documented business rule.

---

## 11.6 Localized Names

Localized names SHALL NOT be used as the sole business identifier.

The presence of a `<entity>_local_name` column SHALL NOT eliminate the need
for a unique Business Key.

Uniqueness requirements for localized names SHALL be defined according to
business rules.

---

## 11.7 Technical Requirements

UNIQUE constraints SHALL:

- Be explicitly named.
- Be documented.
- Represent business uniqueness.
- Remain stable over time.

Constraint names SHALL comply with the Enterprise Naming Standard.

---

## 11.8 Prohibited Practices

The following practices are prohibited:

- Relying on the Primary Key instead of a Business Key.
- Allowing duplicate Business Keys.
- Creating duplicate UNIQUE constraints.
- Defining UNIQUE constraints without documented business meaning.

---

## 11.9 Repository Consistency

Equivalent Reference Tables SHALL implement equivalent uniqueness rules.

Business uniqueness SHALL be modeled consistently throughout the repository.

---

## 11.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Business Key protected by a UNIQUE constraint

✓ Business uniqueness enforced

✓ Explicitly named UNIQUE constraints

✓ No duplicate business identifiers

✓ Consistent implementation across the repository

---

# 12. Check Constraint Standard

## 12.1 Purpose

This section defines the standard for CHECK constraints used by Reference
Tables within the Phoenix Platform.

CHECK constraints SHALL enforce simple business validation rules at the
database level and improve data integrity across the repository.

---

## 12.2 General Principles

CHECK constraints SHALL validate business values that can be enforced
directly by the database.

Validation rules SHALL be deterministic, stable, and independent of
application logic.

Complex business workflows SHALL NOT be implemented using CHECK
constraints.

---

## 12.3 Appropriate Usage

CHECK constraints SHOULD be used for validating:

- Numeric ranges
- Boolean consistency
- Date ranges
- Positive sequence values
- Fixed business limits

Examples include:

sort_order >= 0

effective_to_date >= effective_from_date

---

## 12.4 Prohibited Usage

CHECK constraints SHALL NOT:

- Reference other tables.
- Contain business workflows.
- Depend on external data.
- Duplicate application logic.
- Implement authorization rules.

Such rules belong to the application or business layer.

---

## 12.5 Constraint Naming

CHECK constraint names SHALL comply with the Enterprise Naming Standard.

Recommended format:

ck_<table_name>_<business_rule>

Examples:

ck_currency_sort_order

ck_market_snapshot_type_date_range

ck_order_book_side_code

---

## 12.6 Nullability

CHECK constraints SHALL correctly handle NULL values.

Validation rules SHALL distinguish between:

- Mandatory values
- Optional values

Mandatory values SHALL additionally be protected by NOT NULL constraints.

---

## 12.7 Repository Consistency

Equivalent business rules SHALL use equivalent CHECK constraints throughout
the repository.

Validation logic SHALL remain consistent across all Reference Tables.

---

## 12.8 Documentation

Every CHECK constraint SHALL represent a documented business rule.

The purpose of each CHECK constraint SHALL be understandable without
requiring application code.

---

## 12.9 Prohibited Practices

The following practices are prohibited:

- Redundant CHECK constraints.
- Conflicting validation rules.
- Constraints with undocumented business meaning.
- Overly complex expressions.
- Using CHECK constraints to replace proper database design.

---

## 12.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ CHECK constraints enforce simple business rules

✓ Constraint names follow the Enterprise Naming Standard

✓ Validation rules are deterministic

✓ Mandatory values use NOT NULL where applicable

✓ Business rules are documented

✓ Repository-wide consistency is maintained

---

# 13. Index Standard

## 13.1 Purpose

This section defines the standard for indexing Reference Tables within the
Phoenix Platform.

Indexes SHALL improve lookup performance while preserving simplicity,
maintainability, and repository-wide consistency.

Because Reference Tables typically contain a relatively small number of
records, indexes SHALL be created only when justified by business or
technical requirements.

---

## 13.2 General Principles

Every Reference Table SHALL use the minimum number of indexes necessary to
support its intended usage.

Unnecessary indexes SHALL NOT be created.

Index design SHALL prioritize simplicity over optimization.

---

## 13.3 Primary Key Index

The Primary Key SHALL be indexed automatically by the database.

No additional index SHALL be created on the Primary Key.

---

## 13.4 Business Key Index

Every Business Key protected by a UNIQUE constraint SHALL also provide an
efficient lookup path.

Separate non-unique indexes SHALL NOT be created for the same Business Key
unless justified by documented performance requirements.

---

## 13.5 Foreign Key Index

Indexes on Foreign Key columns MAY be created when justified by query
patterns or join performance.

Reference Tables without Foreign Keys SHALL NOT define unnecessary indexes.

---

## 13.6 Composite Indexes

Composite indexes SHOULD be created only when supported by documented query
requirements.

Columns included in a composite index SHALL reflect common filtering,
joining, or sorting patterns.

---

## 13.7 Duplicate Indexes

Duplicate or overlapping indexes are prohibited.

Equivalent indexes SHALL NOT be created on the same column set.

---

## 13.8 Index Naming

Index names SHALL comply with the Enterprise Naming Standard.

Recommended format:

idx_<table_name>_<column_list>

Examples:

idx_currency_name

idx_market_snapshot_type_name

idx_order_book_side_sort_order

---

## 13.9 Performance Considerations

Indexes SHALL be reviewed periodically.

Indexes that no longer provide measurable value SHOULD be removed.

Performance optimization SHALL remain subordinate to architectural
consistency.

---

## 13.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Primary Key indexed

✓ Business Key efficiently searchable

✓ No unnecessary indexes

✓ No duplicate indexes

✓ Enterprise Naming Standard compliance

✓ Repository-wide consistency maintained

---

# 14. Reference Data Lifecycle Standard

## 14.1 Purpose

This section defines the lifecycle management principles for Reference
Tables within the Phoenix Platform.

Reference data SHALL be managed in a controlled, predictable, and auditable
manner throughout its lifecycle.

---

## 14.2 Lifecycle Principles

Reference values SHALL progress through a controlled business lifecycle.

The lifecycle SHALL preserve historical integrity while supporting future
business requirements.

Reference data SHALL remain stable unless a documented business reason
requires change.

---

## 14.3 Creation

New reference values SHALL be created only when approved by the responsible
business owner.

Every new reference value SHALL:

- Have a unique Business Key.
- Have a valid business name.
- Satisfy all mandatory constraints.
- Comply with this standard.

---

## 14.4 Modification

Reference values MAY be modified only when required by legitimate business
changes.

The following attributes SHOULD remain unchanged whenever possible:

- Primary Key
- Business Key

Business descriptions MAY be updated when necessary.

---

## 14.5 Activation

Reference values SHOULD become available only after successful validation.

When lifecycle management is implemented, newly created values SHOULD be
activated by setting:

is_active = TRUE

---

## 14.6 Deactivation

Reference values SHOULD be deactivated rather than physically deleted.

Deactivation preserves historical consistency and referential integrity.

Typical implementation:

is_active = FALSE

---

## 14.7 Deletion

Physical deletion SHOULD be avoided.

Deletion MAY occur only when ALL of the following conditions are satisfied:

- The reference value has never been used.
- No foreign key references exist.
- Business approval has been obtained.

---

## 14.8 Historical Integrity

Historical records SHALL continue to reference the original reference value.

Changing or removing a reference value SHALL NOT invalidate historical
business data.

---

## 14.9 Governance

Lifecycle operations SHALL follow the repository governance process.

Changes affecting shared Reference Tables SHALL be reviewed before
implementation.

Major changes MAY require approval through an Architecture Decision Record
(ADR).

---

## 14.10 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Controlled creation

✓ Controlled modification

✓ Controlled activation

✓ Controlled deactivation

✓ Restricted deletion

✓ Historical integrity preserved

✓ Repository governance followed

---

# 15. Reference Data Governance

## 15.1 Purpose

This section defines the governance principles for Reference Tables within
the Phoenix Platform.

Reference data SHALL be governed as a shared enterprise asset to ensure
consistency, integrity, and long-term maintainability across all business
domains and services.

---

## 15.2 Governance Principles

Reference data SHALL be:

- Centrally governed
- Business-approved
- Repository-wide reusable
- Consistently maintained
- Properly documented

Reference Tables SHALL NOT be independently managed by individual services
or applications.

---

## 15.3 Ownership

Every Reference Table SHALL have a clearly identified business owner.

The business owner SHALL be responsible for:

- Defining reference values.
- Approving new values.
- Approving modifications.
- Approving retirements.
- Maintaining business definitions.

Technical implementation SHALL remain the responsibility of the development
team.

---

## 15.4 Change Management

Changes to Reference Tables SHALL follow an approved change management
process.

Changes SHALL be evaluated for their impact on:

- Existing business processes
- Dependent database objects
- Applications
- Services
- Historical data

---

## 15.5 Version Control

Reference Table definitions SHALL be maintained under version control within
the Phoenix Repository.

All structural modifications SHALL be traceable through repository history.

Business value changes SHOULD also be documented when appropriate.

---

## 15.6 Documentation

Every Reference Table SHALL be documented.

Documentation SHOULD include:

- Business purpose
- Business definition
- Business owner
- Business Key
- Relationships
- Usage notes

Documentation SHALL remain synchronized with the implemented database
structure.

---

## 15.7 Repository Consistency

Equivalent business concepts SHALL reuse the same Reference Table.

Creating duplicate Reference Tables for identical business concepts is
prohibited.

Repository consistency SHALL take precedence over local optimization.

---

## 15.8 Governance Review

Reference Tables SHOULD be reviewed periodically to verify:

- Continued business relevance
- Data quality
- Naming consistency
- Compliance with enterprise standards

Obsolete reference values SHOULD be retired through the approved lifecycle
process.

---

## 15.9 Compliance Checklist

Every Reference Table SHALL satisfy the following:

✓ Business owner identified

✓ Changes governed through an approved process

✓ Repository version controlled

✓ Business documentation maintained

✓ Repository-wide consistency preserved

✓ Periodic governance review performed

---

# 16. Reference Table Anti-Patterns

## 16.1 Purpose

This section identifies common design mistakes that SHALL be avoided when
designing Reference Tables within the Phoenix Platform.

Avoiding these anti-patterns improves consistency, maintainability,
reusability, and long-term architectural integrity.

---

## 16.2 Duplicate Reference Tables

The same business classification SHALL NOT be implemented in multiple
Reference Tables.

Each business classification SHALL have exactly one canonical Reference
Table.

Incorrect:

Country

CountryLookup

CountryReference

CountryMaster

Correct:

Country

---

## 16.3 Mixing Business Concepts

A Reference Table SHALL represent exactly one business classification.

Multiple unrelated business concepts SHALL NOT be combined into a single
Reference Table.

Incorrect:

MarketCurrencyType

Correct:

Market

Currency

---

## 16.4 Using Reference Tables as Master Entities

Reference Tables SHALL NOT contain business objects.

Business entities belong in Master Entity tables.

Incorrect:

Customer

Broker

Instrument

Correct:

CustomerType

BrokerType

InstrumentType

---

## 16.5 Using Reference Tables as Fact Tables

Reference Tables SHALL NOT store:

- Transactions
- Events
- Measurements
- Historical observations
- Time-series data

Such information belongs in Fact Tables.

---

## 16.6 Free-Text Classification

Applications SHALL NOT store free-text classification values when an
approved Reference Table exists.

Incorrect:

market_type = 'Stock'

Correct:

market_type_id

---

## 16.7 Generic Column Names

Reference Tables SHALL NOT use generic column names.

Incorrect:

id

code

name

type

status

Correct:

currency_id

currency_code

currency_name

market_snapshot_type_code

---

## 16.8 Duplicate Business Values

Duplicate business values are prohibited.

Business uniqueness SHALL be enforced through appropriate UNIQUE
constraints.

---

## 16.9 Circular Dependencies

Reference Tables SHALL NOT reference each other in a circular manner.

Dependency graphs SHALL remain acyclic.

---

## 16.10 Business Logic in Reference Tables

Reference Tables SHALL NOT implement business workflows.

Reference Tables define business classifications only.

Business processing belongs to the application or domain layer.

---

## 16.11 Repository Inconsistency

Equivalent business concepts SHALL NOT be represented differently across the
repository.

Naming conventions, identifiers, and business rules SHALL remain
consistent.

---

## 16.12 Premature Generalization

Reference Tables SHALL NOT be designed for hypothetical future
requirements.

Only approved business requirements SHALL influence the current design.

Future extensibility SHALL be achieved through architectural flexibility,
not speculative implementation.

---

## 16.13 Summary

The following practices are prohibited within the Phoenix Platform:

✗ Duplicate Reference Tables

✗ Mixed Business Concepts

✗ Business Entities in Reference Tables

✗ Transactional Data in Reference Tables

✗ Free-Text Classifications

✗ Generic Column Names

✗ Duplicate Business Values

✗ Circular Dependencies

✗ Business Logic in Reference Tables

✗ Repository Inconsistency

✗ Premature Generalization

---

# 17. Reference Table Design Checklist

## 17.1 Purpose

This checklist defines the mandatory architectural verification criteria
for designing Reference Tables within the Phoenix Platform.

Every new Reference Table SHALL satisfy all applicable checklist items
before implementation.

---

## 17.2 Business Purpose

□ Represents exactly one business classification.

□ Does not represent a Master Entity.

□ Does not represent a Fact Table.

□ Has a clearly documented business purpose.

□ Has an identified business owner.

---

## 17.3 Naming Compliance

□ Table name complies with the Enterprise Naming Standard.

□ All column names are self-descriptive.

□ No generic column names are used.

□ Naming is consistent with equivalent Reference Tables.

---

## 17.4 Primary Key

□ Uses a surrogate Primary Key.

□ BIGINT.

□ GENERATED ALWAYS AS IDENTITY.

□ Primary Key is immutable.

□ Primary Key name follows:

<reference_table_name>_id

---

## 17.5 Business Key

□ Business Key is defined.

□ Business Key is unique.

□ Business Key is NOT NULL.

□ Business Key remains independent from the Primary Key.

---

## 17.6 Business Description

□ Canonical business name is provided.

□ Localized business name is provided only when required.

□ Business descriptions are meaningful.

□ Business descriptions comply with the Enterprise Naming Standard.

---

## 17.7 Relationships

□ Foreign Keys exist only where genuine business dependencies exist.

□ No circular dependencies.

□ No references to Fact Tables.

□ Referential integrity is enforced.

---

## 17.8 Constraints

□ UNIQUE constraints protect business uniqueness.

□ CHECK constraints enforce simple business rules.

□ NOT NULL is applied where required.

□ Constraint names comply with the Enterprise Naming Standard.

---

## 17.9 Data Types

□ Enterprise data types are used.

□ Identifier data types are consistent.

□ Character columns use approved types.

□ Numeric columns use appropriate precision.

---

## 17.10 Indexes

□ No unnecessary indexes.

□ No duplicate indexes.

□ Business lookup performance is supported.

□ Index names follow the Enterprise Naming Standard.

---

## 17.11 Lifecycle

□ Supports controlled activation.

□ Supports controlled deactivation.

□ Avoids physical deletion.

□ Preserves historical integrity.

---

## 17.12 Governance

□ Fully documented.

□ Repository version controlled.

□ Business changes follow the governance process.

□ Repository consistency verified.

---

## 17.13 Final Verification

A Reference Table SHALL NOT be approved unless all mandatory checklist
items have been reviewed and satisfied.

Any exception SHALL require formal architectural approval through the
repository governance process.

---

# 18. References

## 18.1 Purpose

This section identifies the repository standards and architectural
documents referenced by this standard.

ReferenceTableDesignStandard SHALL be interpreted together with these
documents to ensure consistent database design throughout the Phoenix
Platform.

---

## 18.2 Mandatory Standards

The following standards are mandatory references for every Reference Table:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard

Compliance with these standards is required unless an Architecture Decision
Record (ADR) explicitly approves an exception.

---

## 18.3 Related Database Standards

The following database standards complement this document:

- MasterEntityDesignStandard
- FactTableDesignStandard

These standards define the canonical design rules for the other database
table categories used within the Phoenix Platform.

---

## 18.4 Repository Standards

Reference Tables SHALL comply with all repository-wide standards governing:

- Repository organization
- Documentation
- Naming
- Governance
- Database architecture

Repository standards take precedence over local implementation
preferences.

---

## 18.5 Architecture Decision Records

Whenever this standard conflicts with an approved Architecture Decision
Record (ADR), the ADR SHALL take precedence.

All approved deviations SHALL be documented through an ADR.

---

## 18.6 Future Revisions

This standard SHALL evolve together with the Phoenix Platform.

Revisions SHALL preserve backward compatibility whenever reasonably
possible.

Breaking changes SHALL be documented and approved before adoption.

---

## 18.7 Summary

ReferenceTableDesignStandard is part of the Phoenix Enterprise Database
Standards.

It SHALL be used together with the Enterprise Naming, Data Type, Audit,
Master Entity, and Fact Table standards to ensure a consistent,
maintainable, and extensible database architecture.

---

## End of Document