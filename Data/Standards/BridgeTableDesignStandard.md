---
title: Bridge Table Design Standard
document_id: PHX-STD-DATA-005
version: 1.0
status: Draft
owner: Phoenix Architecture Team
reviewers:
  - Enterprise Architecture
  - Data Architecture
approvers:
  - Chief Architect
created: 2026-07-27
last_updated: 2026-07-27
category: Database Standard
domain: Data
layer: Database
applies_to:
  - PostgreSQL
  - Phoenix Platform
related_documents:
  - EnterpriseNamingStandard
  - EnterpriseDataTypeStandard
  - MasterEntityColumnNamingStandard
  - AuditModelStandard
  - MasterEntityDesignStandard
  - ReferenceTableDesignStandard
  - FactTableDesignStandard
  - EventTableDesignStandard
---

# 1. Introduction

## 1.1 Purpose

This standard defines the canonical design principles for Bridge Tables
within the Phoenix Platform.

Bridge Tables model business relationships between two or more business
entities while preserving referential integrity, architectural consistency,
and long-term maintainability.

This document establishes a consistent approach for designing,
implementing, and governing Bridge Tables across the repository.

---

## 1.2 Scope

This standard applies to every Bridge Table implemented within the Phoenix
Platform.

It governs:

- Logical database design
- Physical database design
- Relationship modeling
- Naming conventions
- Keys and constraints
- Referential integrity
- Lifecycle management
- Repository governance

This standard applies to all current and future financial markets supported
by the Phoenix Platform.

---

## 1.3 Objectives

The objectives of this standard are to:

- Standardize Bridge Table design.
- Model business relationships consistently.
- Preserve relationship integrity.
- Improve repository consistency.
- Support future platform evolution.
- Minimize architectural ambiguity.

---

## 1.4 Architectural Context

Within the Phoenix Platform, Bridge Tables are one of the canonical
database table categories.

Master Entity

↓

Reference

↓

Fact

↓

Event

↓

Bridge

Each category has a distinct architectural responsibility.

---

## 1.5 Intended Audience

This standard is intended for:

- Enterprise Architects
- Solution Architects
- Database Architects
- Database Developers
- Backend Developers
- Data Engineers
- Repository Maintainers

---

## 1.6 Repository Compliance

All Bridge Tables SHALL comply with this standard unless an approved
Architecture Decision Record (ADR) explicitly authorizes an exception.

---

# 2. Bridge Table Definition

## 2.1 Purpose

This section defines the canonical meaning of a Bridge Table within the
Phoenix Platform.

A precise definition ensures consistent architectural classification and
prevents overlap with Master Entity, Reference, Fact, and Event Tables.

---

## 2.2 Definition

A Bridge Table represents a business relationship between two or more
business entities.

The Bridge Table models the relationship itself rather than the individual
entities participating in that relationship.

A Bridge Table MAY also contain business attributes that describe the
relationship.

---

## 2.3 Characteristics

A Bridge Table typically possesses the following characteristics:

- Connects two or more Master Entities.
- Represents one business relationship.
- Preserves referential integrity.
- May contain relationship-specific attributes.
- May contain relationship lifecycle information.
- May preserve historical relationship changes.

---

## 2.4 Architectural Responsibility

The responsibility of a Bridge Table is to answer questions such as:

"Which business entities are related?"

"When did the relationship become effective?"

"What attributes describe this relationship?"

A Bridge Table SHALL NOT answer:

"What business object exists?" (Master Entity)

"What category does it belong to?" (Reference)

"What happened?" (Event)

"What was measured?" (Fact)

---

## 2.5 Typical Examples

Typical Bridge Tables include:

- instrument_market_index_bridge
- portfolio_instrument_bridge
- strategy_indicator_bridge
- strategy_feature_bridge
- user_role_bridge

Each table represents a business relationship rather than an independent
business entity.

---

## 2.6 Non-Examples

The following are NOT Bridge Tables:

Master Entity

- Instrument
- Exchange
- Market

Reference

- Currency
- TradingHaltReason

Fact

- DailyMarketData
- MarketIndexValue

Event

- CashDividend
- TradingHalt

---

## 2.7 Design Principles

Every Bridge Table SHALL satisfy the following principles:

- Represent exactly one business relationship.
- Preserve relationship integrity.
- Reference participating entities through Foreign Keys.
- Avoid redundant business information.
- Remain independent of presentation concerns.

---

## 2.8 Relationship Identity

A Bridge Table represents the identity of a business relationship.

The relationship itself MAY possess business attributes, validity periods,
priorities, weights, statuses, or other characteristics independent of the
participating entities.

---

# 3. Bridge Table Classification

## 3.1 Purpose

This section defines the canonical classification of Bridge Tables within
the Phoenix Platform.

Consistent classification ensures that every Bridge Table models a single
business relationship while preventing architectural overlap with Master
Entity, Reference, Fact, and Event Tables.

---

## 3.2 Classification Principles

Every Bridge Table SHALL belong to exactly one business relationship
category.

A Bridge Table SHALL represent one logical relationship.

Multiple unrelated relationships SHALL NOT be combined within the same
Bridge Table.

---

## 3.3 Relationship Categories

Bridge Tables MAY be classified into one of the following categories:

- Entity-to-Entity Relationships
- Membership Relationships
- Assignment Relationships
- Composition Relationships
- Hierarchical Relationships
- Permission Relationships

Additional categories MAY be introduced when justified by approved business
requirements.

---

## 3.4 Entity-to-Entity Relationships

Entity-to-Entity Bridge Tables associate two independent Master Entities.

Typical examples include:

- instrument_market_index_bridge
- instrument_sector_bridge

These relationships define business associations without implying ownership.

---

## 3.5 Membership Relationships

Membership Bridge Tables define participation within a business collection.

Typical examples include:

- portfolio_instrument_bridge
- watchlist_instrument_bridge

Membership relationships MAY include:

- membership_start_date
- membership_end_date
- membership_weight

---

## 3.6 Assignment Relationships

Assignment Bridge Tables assign one business object to another.

Typical examples include:

- user_role_bridge
- strategy_indicator_bridge
- strategy_feature_bridge

Assignment relationships MAY include:

- assignment_date
- assignment_priority
- assignment_status_id

---

## 3.7 Hierarchical Relationships

Bridge Tables MAY model recursive business relationships.

Typical examples include:

- parent_portfolio_bridge
- instrument_successor_bridge

Recursive relationships SHALL remain acyclic unless an approved business
rule explicitly permits otherwise.

---

## 3.8 Classification Rules

Every Bridge Table SHALL represent only one relationship category.

Relationship categories SHALL NOT be mixed within a single Bridge Table.

Business meaning SHALL remain explicit.

---

## 3.9 Repository Consistency

Equivalent business relationships SHALL use identical classification
principles throughout the repository.

The same relationship SHALL NOT be modeled differently by different
services.

---

# 4. Bridge Table Characteristics

## 4.1 Purpose

This section defines the mandatory characteristics of Bridge Tables within
the Phoenix Platform.

These characteristics distinguish Bridge Tables from the other canonical
database table categories.

---

## 4.2 Core Characteristics

Every Bridge Table SHALL:

- Represent one business relationship.
- Connect two or more Master Entities.
- Preserve referential integrity.
- Support relationship lifecycle management.
- Support auditability.

---

## 4.3 Relationship Integrity

Every Bridge Table SHALL preserve the integrity of the represented business
relationship.

A relationship SHALL exist only while all mandatory participating entities
exist.

Bridge Tables SHALL NOT contain orphaned relationships.

---

## 4.4 Relationship Attributes

Bridge Tables MAY contain attributes describing the relationship itself.

Typical examples include:

- relationship_start_date
- relationship_end_date
- relationship_weight
- relationship_priority
- relationship_status_id

These attributes SHALL describe the relationship rather than either
participating entity.

---

## 4.5 Referential Integrity

Every participating Master Entity SHALL be referenced through a Foreign Key.

Bridge Tables SHALL NOT duplicate business attributes belonging to the
participating entities.

---

## 4.6 Relationship Independence

The business relationship SHALL be treated as an independent architectural
concept.

Relationship attributes SHALL belong exclusively to the relationship and
SHALL NOT duplicate Master Entity attributes.

---

## 4.7 Historical Preservation

Where business history is required, Bridge Tables SHALL preserve historical
relationship changes.

Historical relationships SHOULD remain available for audit and analytical
purposes.

---

## 4.8 Repository Consistency

All Bridge Tables SHALL follow identical architectural principles across
all supported financial markets.

Repository consistency SHALL take precedence over implementation
convenience.

---

## 4.9 Design Objectives

Bridge Tables are designed to provide:

- Consistent relationship modeling
- Referential integrity
- Historical traceability
- Business flexibility
- Repository-wide consistency

---

# 5. Bridge Table Design Principles

## 5.1 Purpose

This section defines the mandatory design principles for Bridge Tables
within the Phoenix Platform.

These principles ensure that business relationships are modeled
consistently, remain maintainable, and preserve long-term architectural
integrity.

---

## 5.2 Single Relationship Principle

Every Bridge Table SHALL represent exactly one business relationship.

A Bridge Table SHALL NOT represent multiple unrelated relationships.

Examples

Correct

instrument_market_index_bridge

portfolio_instrument_bridge

Incorrect

instrument_market_portfolio_bridge

---

## 5.3 Relationship Ownership

A Bridge Table SHALL own only the attributes that belong to the
relationship.

Business attributes belonging to participating Master Entities SHALL remain
within their respective Master Entity tables.

---

## 5.4 Relationship Independence

The business relationship SHALL be treated as an independent architectural
concept.

Changes to one participating Master Entity SHALL NOT require redesign of
the Bridge Table unless the relationship itself changes.

---

## 5.5 Minimal Redundancy

Bridge Tables SHALL avoid storing duplicated business information.

Only relationship-specific attributes MAY be stored.

Duplicating attributes from Master Entity tables is prohibited.

---

## 5.6 Referential Integrity

Every participating Master Entity SHALL be referenced through Foreign Keys.

Relationships SHALL always remain valid according to documented business
rules.

---

## 5.7 Relationship Cardinality

Bridge Tables SHALL explicitly model the intended business cardinality.

Typical examples include:

- Many-to-Many
- Many-to-One
- Recursive relationships

The intended cardinality SHALL be documented.

---

## 5.8 Historical Relationships

When business requirements demand historical tracking, the Bridge Table
SHALL preserve relationship history.

Typical attributes include:

relationship_start_date

relationship_end_date

Historical relationships SHOULD NOT be physically deleted.

---

## 5.9 Repository Consistency

Equivalent business relationships SHALL use identical Bridge Table design
principles throughout the repository.

Repository consistency SHALL take precedence over implementation
preferences.

---

## 5.10 Repository Compliance

Every Bridge Table SHALL comply with:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard
- Repository governance policies

---

# 6. Mandatory Column Groups

## 6.1 Purpose

This section defines the mandatory column groups for Bridge Tables within
the Phoenix Platform.

A consistent column organization improves readability, maintainability,
relationship traceability, and repository-wide consistency.

---

## 6.2 Mandatory Group Order

Bridge Tables SHALL organize their columns in the following order:

1. Primary Identifier

2. Participating Master Entity References

3. Relationship Attributes

4. Relationship Lifecycle

5. Audit Attributes

---

## 6.3 Primary Identifier

Purpose

Provide the immutable surrogate identifier of the relationship.

Requirements

- Exactly one column.
- BIGINT.
- GENERATED ALWAYS AS IDENTITY.
- Primary Key.
- Immutable.

Example

portfolio_instrument_bridge_id

---

## 6.4 Participating Master Entity References

Purpose

Identify every Master Entity participating in the relationship.

Typical examples

portfolio_id

instrument_id

market_index_id

strategy_id

Every participating Master Entity SHALL be referenced through a Foreign Key.

---

## 6.5 Relationship Attributes

Purpose

Store business attributes describing the relationship itself.

Typical examples

relationship_weight

relationship_priority

allocation_percentage

membership_order

These attributes SHALL describe the relationship rather than the
participating entities.

---

## 6.6 Relationship Lifecycle

Purpose

Describe the business lifecycle of the relationship.

Typical examples

relationship_start_date

relationship_end_date

relationship_status_id

is_primary_relationship

Lifecycle attributes SHALL belong to the relationship itself.

---

## 6.7 Audit Attributes

Purpose

Provide complete traceability for database operations.

Audit columns SHALL comply with the AuditModelStandard.

Custom audit implementations are prohibited.

---

## 6.8 Optional Business Identifier

Where a documented business identifier exists, it MAY be included after the
Primary Identifier.

Such identifiers SHALL remain independent of the Primary Key.

---

## 6.9 Summary

Every Bridge Table SHALL organize its columns according to the following
canonical sequence:

Primary Identifier

↓

Participating Master Entity References

↓

Relationship Attributes

↓

Relationship Lifecycle

↓

Audit Attributes

---

# 7. Primary Key Standard

## 7.1 Purpose

This section defines the mandatory requirements for Primary Keys used by
Bridge Tables within the Phoenix Platform.

Every Bridge Table SHALL use a surrogate Primary Key to ensure repository-
wide consistency, stable relationships, and long-term maintainability.

---

## 7.2 Primary Key Requirement

Every Bridge Table SHALL define exactly one Primary Key.

The Primary Key SHALL uniquely identify one business relationship record.

The Primary Key SHALL have no business meaning.

---

## 7.3 Primary Key Type

The Primary Key SHALL satisfy the following requirements:

- BIGINT
- NOT NULL
- GENERATED ALWAYS AS IDENTITY
- Immutable
- Unique

Primary Key values SHALL never be modified.

---

## 7.4 Naming Convention

Primary Key column names SHALL comply with the Enterprise Naming Standard.

The naming format SHALL be:

<bridge_table_name>_id

Examples:

portfolio_instrument_bridge_id

instrument_market_index_bridge_id

strategy_indicator_bridge_id

Generic names are prohibited, including:

id

bridge_id

relationship_id

record_id

---

## 7.5 Surrogate Identifier

Bridge Tables SHALL use surrogate identifiers as their Primary Keys.

Business identifiers SHALL remain separate from the Primary Key.

The Primary Key SHALL NOT be exposed as a business identifier.

---

## 7.6 Business Independence

Business relationships MAY change over time.

Such changes SHALL NOT require modification of the Primary Key.

The Primary Key SHALL remain stable throughout the lifetime of the
relationship record.

---

## 7.7 Foreign Key References

Other database objects SHALL reference Bridge Tables through their Primary
Keys.

Relationships SHALL NOT be established using business attributes.

Correct:

portfolio_instrument_bridge_id

Incorrect:

portfolio_id + instrument_id

---

## 7.8 Prohibited Practices

The following practices are prohibited:

- Using participating Foreign Keys as the Primary Key.
- Composite Primary Keys.
- Updating Primary Key values.
- Business-dependent identifiers.
- Generic column names.

---

## 7.9 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Exactly one Primary Key

✓ BIGINT

✓ GENERATED ALWAYS AS IDENTITY

✓ Immutable

✓ Self-descriptive column name

✓ No business meaning

---

# 8. Business Key Standard

## 8.1 Purpose

This section defines the requirements for Business Keys used by Bridge
Tables within the Phoenix Platform.

A Business Key uniquely identifies a business relationship according to
documented business rules while remaining independent from the technical
Primary Key.

---

## 8.2 General Principles

A Bridge Table MAY define a Business Key when a stable business identifier
exists.

Many Bridge Tables naturally derive their business identity from the
combination of participating Master Entities.

Artificial Business Keys SHALL NOT be introduced without documented
business justification.

---

## 8.3 Natural Business Keys

The Business Key of a Bridge Table will often be a composite of the
participating Master Entity references.

Typical examples include:

portfolio_id +
instrument_id

strategy_id +
indicator_id

user_id +
role_id

The Business Key SHALL represent the uniqueness of the business
relationship.

---

## 8.4 Relationship History

When historical relationships are maintained, additional attributes MAY be
required as part of the Business Key.

Typical examples include:

instrument_id +
market_index_id +
relationship_start_date

portfolio_id +
instrument_id +
effective_date

Business rules SHALL determine the appropriate uniqueness.

---

## 8.5 Stability

Business Keys SHOULD remain stable throughout the lifetime of the business
relationship.

When business rules require changes, those changes SHALL remain fully
auditable.

---

## 8.6 Uniqueness

Business Keys SHALL be protected by a UNIQUE constraint.

Duplicate active business relationships are prohibited unless explicitly
permitted by documented business rules.

---

## 8.7 Naming Convention

Business Key columns SHALL comply with the Enterprise Naming Standard.

Generic names such as:

identifier

reference

number

code

are prohibited.

---

## 8.8 Relationship to Primary Key

The Primary Key provides technical identity.

The Business Key provides business identity.

Database relationships SHALL use the Primary Key.

Business validation MAY use the Business Key.

---

## 8.9 Prohibited Practices

The following practices are prohibited:

- Using the Business Key as the Primary Key.
- Creating undocumented Business Keys.
- Allowing duplicate active relationships.
- Using generic column names.

---

## 8.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Business Key documented

✓ Business Key independent from Primary Key

✓ UNIQUE constraint implemented

✓ Enterprise Naming Standard compliance

✓ Business uniqueness preserved

---

# 9. Foreign Key Standard

## 9.1 Purpose

This section defines the mandatory requirements for Foreign Keys used by
Bridge Tables within the Phoenix Platform.

Foreign Keys establish and preserve the business relationship represented
by the Bridge Table while ensuring referential integrity throughout the
repository.

---

## 9.2 General Principles

Every Bridge Table SHALL contain the Foreign Keys required to identify all
participating Master Entities.

Each Foreign Key SHALL represent a documented business relationship.

Undocumented relationships are prohibited.

---

## 9.3 Participating Master Entities

Every participating Master Entity SHALL be referenced through its Primary
Key.

Typical examples include:

portfolio_id

instrument_id

market_index_id

strategy_id

user_id

role_id

Foreign Keys SHALL reference the corresponding Master Entity Primary Key.

---

## 9.4 Reference Table Relationships

Bridge Tables MAY reference Reference Tables when required to classify the
relationship.

Typical examples include:

relationship_status_id

relationship_type_id

membership_type_id

Reference Tables SHALL NOT replace participating Master Entities.

---

## 9.5 Mandatory Relationships

Every mandatory participating entity SHALL be enforced through:

- NOT NULL
- FOREIGN KEY
- Referential integrity

A Bridge Table SHALL NOT contain incomplete business relationships.

---

## 9.6 Referential Actions

Recommended referential actions are:

ON UPDATE RESTRICT

ON DELETE RESTRICT

Alternative actions SHALL require documented business justification.

Cascade deletion SHOULD be avoided because Bridge Tables may preserve
historical business relationships.

---

## 9.7 Naming Convention

Foreign Key column names SHALL comply with the Enterprise Naming Standard.

Examples:

portfolio_id

instrument_id

market_index_id

relationship_status_id

Generic names are prohibited, including:

entity_id

parent_id

reference_id

object_id

---

## 9.8 Prohibited Relationships

Bridge Tables SHALL NOT:

- Reference Fact Tables.
- Reference Event Tables.
- Reference business attributes instead of Primary Keys.
- Introduce circular dependencies.

---

## 9.9 Relationship Integrity

Every Bridge Table SHALL preserve complete relationship integrity.

Orphaned relationship records are prohibited.

All Foreign Keys SHALL remain valid throughout the relationship lifecycle.

---

## 9.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Foreign Keys reference Master Entity Primary Keys

✓ Mandatory relationships enforced

✓ Referential integrity maintained

✓ Self-descriptive Foreign Key names

✓ No circular dependencies

✓ No references to Fact Tables

✓ No references to Event Tables

---

# 10. Data Type Standard

## 10.1 Purpose

This section defines the canonical data type requirements for Bridge Tables
within the Phoenix Platform.

Bridge Tables SHALL use enterprise-approved data types to ensure repository
consistency, interoperability, and long-term maintainability.

Detailed data type definitions are governed by the
EnterpriseDataTypeStandard.

---

## 10.2 General Principles

Every column SHALL use the enterprise-approved data type corresponding to
its business meaning.

Equivalent relationship attributes SHALL use identical data types
throughout the repository.

---

## 10.3 Identifier Columns

Primary Key columns SHALL use:

BIGINT

Foreign Key columns SHALL use exactly the same data type as the referenced
Primary Key.

Business identifier columns SHALL comply with the
EnterpriseDataTypeStandard.

---

## 10.4 Relationship Attributes

Relationship attributes SHALL use enterprise-approved data types.

Typical examples include:

relationship_weight

NUMERIC

allocation_percentage

NUMERIC

membership_order

INTEGER

priority_sequence

INTEGER

---

## 10.5 Lifecycle Attributes

Lifecycle attributes SHALL use enterprise-approved data types.

Typical examples include:

relationship_start_date

DATE

relationship_end_date

DATE

relationship_status_id

BIGINT

---

## 10.6 Boolean Attributes

Boolean relationship attributes SHALL use:

BOOLEAN

Typical examples include:

is_primary_relationship

is_default_relationship

is_active_relationship

---

## 10.7 Nullability

Mandatory relationship attributes SHALL be defined as NOT NULL.

Nullable columns SHALL be used only where business rules explicitly permit
missing values.

---

## 10.8 Repository Consistency

Equivalent relationship attributes SHALL use identical data types
throughout the repository.

The same business concept SHALL NOT be implemented using different data
types.

---

## 10.9 Enterprise Compliance

All data types SHALL comply with the EnterpriseDataTypeStandard.

Local deviations are prohibited unless approved through an Architecture
Decision Record (ADR).

---

## 10.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Canonical enterprise data types

✓ Consistent identifier types

✓ Consistent lifecycle attribute types

✓ Appropriate numeric precision

✓ Mandatory values protected by NOT NULL

✓ Compliance with EnterpriseDataTypeStandard

---

# 11. Unique Constraint Standard

## 11.1 Purpose

This section defines the mandatory requirements for UNIQUE constraints used
by Bridge Tables within the Phoenix Platform.

UNIQUE constraints preserve the uniqueness of business relationships and
prevent duplicate relationship records.

---

## 11.2 General Principles

Every Bridge Table SHALL define at least one UNIQUE constraint representing
the business uniqueness of the relationship.

The UNIQUE constraint SHALL be independent of the surrogate Primary Key.

---

## 11.3 Business Relationship Uniqueness

The UNIQUE constraint SHALL include all columns required to uniquely
identify an active business relationship.

Typical examples include:

portfolio_id +
instrument_id

strategy_id +
indicator_id

user_id +
role_id

---

## 11.4 Historical Relationships

When relationship history is preserved, additional lifecycle attributes MAY
be included in the UNIQUE constraint.

Typical examples include:

instrument_id +
market_index_id +
relationship_start_date

portfolio_id +
instrument_id +
effective_date

Business requirements SHALL determine the appropriate uniqueness rule.

---

## 11.5 Active Relationship Rule

Where historical relationships are maintained, business rules SHALL prevent
duplicate active relationships.

Only one active relationship representing the same business association
SHALL exist unless explicitly permitted by documented business rules.

---

## 11.6 Constraint Naming

UNIQUE constraint names SHALL comply with the Enterprise Naming Standard.

Recommended format:

uq_<bridge_table_name>_<business_key>

Examples:

uq_portfolio_instrument_bridge

uq_strategy_indicator_bridge

uq_user_role_bridge

---

## 11.7 Duplicate Constraints

Duplicate UNIQUE constraints are prohibited.

Equivalent business rules SHALL be enforced only once.

---

## 11.8 Repository Consistency

Equivalent Bridge Tables SHALL implement equivalent business uniqueness
rules throughout the repository.

The same relationship SHALL NOT be modeled with inconsistent uniqueness
rules.

---

## 11.9 Documentation

Every UNIQUE constraint SHALL have documented business justification.

Technical uniqueness without business meaning is prohibited.

---

## 11.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Business uniqueness documented

✓ UNIQUE constraint implemented

✓ Duplicate relationships prevented

✓ Enterprise Naming Standard compliance

✓ Repository consistency maintained

---

# 12. Check Constraint Standard

## 12.1 Purpose

This section defines the standard for CHECK constraints used by Bridge
Tables within the Phoenix Platform.

CHECK constraints SHALL enforce deterministic validation rules related to
business relationships.

---

## 12.2 General Principles

CHECK constraints SHALL validate only deterministic business rules that can
be evaluated by the database.

Workflow logic SHALL NOT be implemented using CHECK constraints.

---

## 12.3 Appropriate Usage

CHECK constraints SHOULD validate:

- Percentage ranges
- Weight ranges
- Priority ranges
- Valid date intervals
- Positive numeric values

Typical examples include:

allocation_percentage BETWEEN 0 AND 100

relationship_weight >= 0

relationship_end_date >= relationship_start_date

membership_order > 0

---

## 12.4 Prohibited Usage

CHECK constraints SHALL NOT:

- Reference other tables.
- Implement business workflows.
- Enforce authorization rules.
- Replace application logic.
- Call external business services.

---

## 12.5 Constraint Naming

CHECK constraint names SHALL comply with the Enterprise Naming Standard.

Recommended format:

ck_<bridge_table_name>_<business_rule>

Examples:

ck_portfolio_instrument_valid_dates

ck_strategy_indicator_positive_weight

ck_user_role_priority

---

## 12.6 Nullability

Mandatory relationship attributes SHALL additionally be protected using
NOT NULL constraints.

Nullable attributes SHALL represent optional business information only.

---

## 12.7 Repository Consistency

Equivalent relationship validation rules SHALL be implemented consistently
throughout the repository.

Validation logic SHALL remain identical for equivalent Bridge Tables.

---

## 12.8 Documentation

Every CHECK constraint SHALL represent a documented business rule.

Its purpose SHALL be understandable without reading application code.

---

## 12.9 Prohibited Practices

The following practices are prohibited:

- Redundant CHECK constraints.
- Conflicting validation rules.
- Undocumented validation rules.
- Overly complex expressions.
- Workflow implementation inside CHECK constraints.

---

## 12.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Deterministic validation rules

✓ Enterprise Naming Standard compliance

✓ Business rules documented

✓ Mandatory values protected

✓ Repository-wide consistency maintained

---

# 13. Index Standard

## 13.1 Purpose

This section defines the indexing principles for Bridge Tables within the
Phoenix Platform.

Indexes SHALL support efficient relationship traversal while maintaining
repository consistency and acceptable write performance.

---

## 13.2 General Principles

Indexes SHALL be created according to documented business access patterns.

Every index SHALL have measurable business or technical value.

Redundant indexes are prohibited.

---

## 13.3 Primary Key Index

The Primary Key SHALL be indexed automatically by the database.

Additional indexes SHALL NOT duplicate the Primary Key index.

---

## 13.4 Foreign Key Indexes

Every Foreign Key SHOULD be indexed.

Bridge Tables are primarily traversed through their participating Master
Entity references.

Typical examples include:

portfolio_id

instrument_id

market_index_id

strategy_id

user_id

role_id

---

## 13.5 Composite Relationship Indexes

Composite indexes SHOULD support the most common relationship traversal
patterns.

Typical examples include:

portfolio_id +
instrument_id

instrument_id +
market_index_id

strategy_id +
indicator_id

Column order SHALL reflect expected filtering selectivity.

---

## 13.6 Lifecycle Indexes

Lifecycle attributes MAY be indexed when historical relationship queries
are common.

Typical examples include:

relationship_start_date

relationship_end_date

relationship_status_id

Composite lifecycle indexes MAY be created where justified.

---

## 13.7 Unique Indexes

Business uniqueness SHALL normally be enforced through a UNIQUE index.

Additional indexes SHALL NOT duplicate the UNIQUE index.

---

## 13.8 Index Naming

Index names SHALL comply with the Enterprise Naming Standard.

Recommended format:

idx_<bridge_table_name>_<column_list>

Examples:

idx_portfolio_instrument_bridge_portfolio_id

idx_portfolio_instrument_bridge_instrument_id

idx_strategy_indicator_bridge_strategy_id_indicator_id

---

## 13.9 Performance Review

Indexes SHOULD be periodically reviewed.

Unused or redundant indexes SHOULD be removed.

Performance optimization SHALL balance read efficiency against write
overhead.

---

## 13.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Primary Key indexed

✓ Foreign Keys indexed where appropriate

✓ Composite indexes evaluated

✓ UNIQUE indexes not duplicated

✓ Enterprise Naming Standard compliance

✓ Periodic performance review completed

---

# 14. Bridge Relationship Lifecycle Standard

## 14.1 Purpose

This section defines the lifecycle management principles for Bridge Tables
within the Phoenix Platform.

Bridge Tables SHALL preserve the integrity and business meaning of
relationships throughout their lifecycle.

---

## 14.2 Lifecycle Principles

Every business relationship SHALL have a clearly defined lifecycle.

Relationship creation, modification, expiration, and termination SHALL
follow documented business rules.

---

## 14.3 Relationship Creation

A relationship record SHALL be created only after all participating Master
Entities exist.

Every new relationship SHALL:

- Have a valid Primary Key.
- Satisfy all mandatory constraints.
- Reference all mandatory Master Entities.
- Record the relationship start date when applicable.

---

## 14.4 Relationship Modification

Relationship attributes MAY change during the lifetime of the relationship.

Such changes SHALL remain fully auditable.

Business modifications SHALL NOT require replacement of the Primary Key.

---

## 14.5 Relationship Termination

When a relationship ends, the preferred approach is to record its end rather
than physically delete the relationship.

Typical examples include:

relationship_end_date

relationship_status_id

Physical deletion SHOULD be avoided unless explicitly required by approved
data retention policies.

---

## 14.6 Historical Relationships

Historical relationships SHOULD remain available for:

- Business auditing
- Historical analysis
- Regulatory compliance
- Relationship traceability

Repository history SHALL be preserved whenever reasonably possible.

---

## 14.7 Archiving

Historical Bridge records MAY be archived.

Archiving SHALL preserve:

- Referential integrity
- Business meaning
- Audit information

Archived relationships SHALL remain recoverable.

---

## 14.8 Governance

Relationship lifecycle rules SHALL comply with repository governance.

Major lifecycle changes MAY require approval through an Architecture
Decision Record (ADR).

---

## 14.9 Repository Consistency

Equivalent business relationships SHALL follow identical lifecycle
principles throughout the repository.

---

## 14.10 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Controlled relationship creation

✓ Auditable relationship modifications

✓ Relationship termination documented

✓ Historical relationships preserved

✓ Archive policy defined

✓ Repository governance followed

---

# 15. Bridge Table Governance Standard

## 15.1 Purpose

This section defines the governance principles for Bridge Tables within the
Phoenix Platform.

Bridge Tables represent enterprise business relationships and SHALL be
governed as shared repository assets to ensure consistency, traceability,
and long-term maintainability.

---

## 15.2 Governance Principles

Bridge Tables SHALL be:

- Business governed
- Repository controlled
- Fully documented
- Fully auditable
- Architecturally consistent

Bridge Tables SHALL NOT be independently designed by individual services.

---

## 15.3 Ownership

Every Bridge Table SHALL have an identified business owner.

The business owner SHALL be responsible for:

- Defining the business relationship.
- Approving business rules.
- Approving lifecycle rules.
- Approving relationship semantics.
- Maintaining business documentation.

Technical implementation SHALL remain the responsibility of the
development team.

---

## 15.4 Change Management

Changes affecting Bridge Tables SHALL follow the repository change
management process.

Every structural modification SHALL be evaluated for its impact on:

- Participating Master Entities
- Business relationships
- Related services
- Repository consistency
- Historical integrity

---

## 15.5 Version Control

All Bridge Table definitions SHALL be maintained under version control.

Every structural modification SHALL be traceable through repository
history.

Business rule modifications SHOULD also be documented.

---

## 15.6 Documentation

Every Bridge Table SHALL include documented information describing:

- Business purpose
- Participating entities
- Relationship definition
- Business owner
- Lifecycle
- Business rules
- Historical behavior

Documentation SHALL remain synchronized with the implemented schema.

---

## 15.7 Repository Consistency

Equivalent business relationships SHALL be modeled consistently throughout
the repository.

Duplicate Bridge Tables representing the same relationship are prohibited.

Repository consistency SHALL take precedence over implementation
preferences.

---

## 15.8 Governance Review

Bridge Tables SHOULD be reviewed periodically to verify:

- Continued business relevance
- Naming consistency
- Relationship integrity
- Lifecycle compliance
- Repository compliance

---

## 15.9 Compliance Checklist

Every Bridge Table SHALL satisfy the following:

✓ Business owner identified

✓ Repository governance followed

✓ Fully documented

✓ Version controlled

✓ Lifecycle documented

✓ Repository consistency maintained

---

# 16. Bridge Table Anti-Patterns

## 16.1 Purpose

This section identifies common design mistakes that SHALL be avoided when
designing Bridge Tables within the Phoenix Platform.

Avoiding these anti-patterns improves repository consistency,
maintainability, and architectural quality.

---

## 16.2 Using Bridge Tables as Join Tables Only

A Bridge Table SHALL represent a business relationship.

It SHALL NOT exist solely to satisfy relational database normalization.

Business meaning SHALL always be documented.

---

## 16.3 Duplicating Master Entity Attributes

Bridge Tables SHALL NOT duplicate attributes belonging to participating
Master Entities.

Incorrect:

instrument_name

portfolio_name

market_index_name

Correct:

instrument_id

portfolio_id

market_index_id

---

## 16.4 Modeling Multiple Relationships

A Bridge Table SHALL represent exactly one business relationship.

Incorrect:

portfolio_strategy_indicator_bridge

Correct:

portfolio_strategy_bridge

strategy_indicator_bridge

---

## 16.5 Missing Business Rules

Relationships SHALL have documented business rules.

Undocumented associations are prohibited.

---

## 16.6 Missing Lifecycle Information

Where business relationships change over time, lifecycle attributes SHALL
be defined.

Typical examples include:

relationship_start_date

relationship_end_date

relationship_status_id

---

## 16.7 Generic Column Names

Generic column names are prohibited.

Incorrect:

id

status

type

priority

Correct:

portfolio_instrument_bridge_id

relationship_status_id

relationship_priority

---

## 16.8 Composite Primary Keys

Composite Primary Keys are prohibited.

Business uniqueness SHALL be enforced through UNIQUE constraints.

The Bridge Table SHALL use a surrogate Primary Key.

---

## 16.9 Circular Relationships

Bridge Tables SHALL NOT introduce circular relationship dependencies.

Relationship graphs SHALL remain understandable and maintainable.

---

## 16.10 Duplicate Active Relationships

Duplicate active business relationships are prohibited unless explicitly
required by documented business rules.

Business uniqueness SHALL be enforced consistently.

---

## 16.11 Repository Inconsistency

Equivalent business relationships SHALL be modeled consistently throughout
the repository.

Naming, constraints, lifecycle, and relationship semantics SHALL remain
consistent.

---

## 16.12 Premature Generalization

Bridge Tables SHALL NOT be designed for hypothetical future relationships.

Only approved business requirements SHALL influence the current design.

Architectural extensibility SHALL replace speculative implementation.

---

## 16.13 Summary

The following practices are prohibited:

✗ Join tables without business meaning

✗ Duplicating Master Entity attributes

✗ Modeling multiple relationships

✗ Missing business rules

✗ Missing lifecycle information

✗ Generic column names

✗ Composite Primary Keys

✗ Circular relationships

✗ Duplicate active relationships

✗ Repository inconsistency

✗ Premature generalization

---

# 17. Bridge Table Design Checklist

## 17.1 Purpose

This checklist defines the mandatory architectural verification criteria
for designing Bridge Tables within the Phoenix Platform.

Every new Bridge Table SHALL satisfy all applicable checklist items before
implementation.

---

## 17.2 Business Purpose

□ Represents exactly one business relationship.

□ Has a clearly documented business purpose.

□ Has an identified business owner.

□ Does not represent a Master Entity.

□ Does not represent a Reference Table.

□ Does not represent a Fact Table.

□ Does not represent an Event Table.

---

## 17.3 Naming Compliance

□ Table name complies with the Enterprise Naming Standard.

□ All column names are self-descriptive.

□ No generic column names are used.

□ Naming is consistent throughout the repository.

---

## 17.4 Primary Key

□ Uses a surrogate Primary Key.

□ BIGINT.

□ GENERATED ALWAYS AS IDENTITY.

□ Primary Key is immutable.

□ Primary Key name follows:

<bridge_table_name>_id

---

## 17.5 Business Key

□ Business Key documented.

□ Business Key independent from Primary Key.

□ UNIQUE constraint implemented.

□ Business uniqueness documented.

---

## 17.6 Relationships

□ All participating Master Entities referenced.

□ Foreign Keys reference Master Entity Primary Keys.

□ Reference Tables used only where justified.

□ No references to Fact Tables.

□ No references to Event Tables.

□ Referential integrity enforced.

□ No circular dependencies.

---

## 17.7 Relationship Attributes

□ Relationship attributes belong to the relationship itself.

□ No duplicated Master Entity attributes.

□ Lifecycle attributes documented.

□ Historical behavior documented where applicable.

---

## 17.8 Constraints

□ UNIQUE constraints implemented.

□ CHECK constraints validate deterministic business rules.

□ NOT NULL applied where appropriate.

□ Constraint names comply with the Enterprise Naming Standard.

---

## 17.9 Data Types

□ Enterprise data types are used.

□ Identifier data types are consistent.

□ Relationship attribute types are consistent.

□ Lifecycle attribute types comply with the EnterpriseDataTypeStandard.

---

## 17.10 Indexes

□ Primary Key indexed.

□ Foreign Key indexes evaluated.

□ Composite indexes evaluated.

□ No duplicate indexes.

---

## 17.11 Governance

□ Business owner identified.

□ Fully documented.

□ Version controlled.

□ Repository governance followed.

□ Repository consistency verified.

---

## 17.12 Final Verification

A Bridge Table SHALL NOT be approved unless all mandatory checklist items
have been reviewed and satisfied.

Any deviation from this standard SHALL require formal architectural
approval through the repository governance process.

---

# 18. References

## 18.1 Purpose

This section identifies the repository standards and architectural
documents referenced by this standard.

BridgeTableDesignStandard SHALL be interpreted together with these
documents to ensure a consistent enterprise database architecture.

---

## 18.2 Mandatory Standards

The following standards are mandatory references:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard

Compliance with these standards is mandatory unless an approved
Architecture Decision Record (ADR) explicitly authorizes an exception.

---

## 18.3 Related Database Standards

The following database standards complement this document:

- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- FactTableDesignStandard
- EventTableDesignStandard

Together these standards define the canonical database table architecture
of the Phoenix Platform.

---

## 18.4 Repository Standards

Bridge Tables SHALL comply with repository-wide standards governing:

- Repository organization
- Documentation
- Database architecture
- Naming conventions
- Governance

Repository standards take precedence over local implementation
preferences.

---

## 18.5 Architecture Decision Records

Whenever this standard conflicts with an approved Architecture Decision
Record (ADR), the ADR SHALL take precedence.

Approved exceptions SHALL be documented through an ADR.

---

## 18.6 Future Revisions

This standard SHALL evolve together with the Phoenix Platform.

Future revisions SHOULD preserve backward compatibility whenever
reasonably possible.

Breaking changes SHALL undergo architectural review before adoption.

---

## 18.7 Summary

BridgeTableDesignStandard defines the canonical design principles for
Bridge Tables within the Phoenix Platform.

Together with the Master Entity, Reference Table, Fact Table, and Event
Table standards, it establishes a complete and consistent enterprise
database design framework for modeling business entities, reference data,
measurements, business events, and business relationships across all
supported financial markets.

---

## End of Document