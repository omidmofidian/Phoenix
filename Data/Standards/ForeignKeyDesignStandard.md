---
title: Foreign Key Design Standard
document_id: PHX-STD-DATA-006
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
  - BridgeTableDesignStandard
---

# 1. Introduction

## 1.1 Purpose

This standard defines the canonical design principles for Foreign Keys
within the Phoenix Platform.

Foreign Keys establish and enforce business relationships between database
tables while preserving referential integrity, repository consistency, and
long-term maintainability.

This document provides a single authoritative source for designing,
implementing, and governing Foreign Keys across the repository.

---

## 1.2 Scope

This standard applies to every Foreign Key implemented within the Phoenix
Platform.

It governs:

- Logical database design
- Physical database design
- Referential integrity
- Relationship modeling
- Naming conventions
- Referential actions
- Database consistency
- Repository governance

This standard applies to all database schemas within the Phoenix Platform.

---

## 1.3 Objectives

The objectives of this standard are to:

- Standardize Foreign Key design.
- Preserve referential integrity.
- Eliminate inconsistent relationship implementations.
- Improve repository maintainability.
- Support enterprise-scale database architecture.
- Establish a single source of truth for Foreign Key design.

---

## 1.4 Architectural Context

Foreign Keys are a horizontal database design standard.

They are applicable to every canonical table category within the Phoenix
Platform, including:

- Master Entity Tables
- Reference Tables
- Fact Tables
- Event Tables
- Bridge Tables

Table-specific standards MAY introduce additional rules but SHALL NOT
contradict this standard.

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

All Foreign Keys SHALL comply with this standard unless an approved
Architecture Decision Record (ADR) explicitly authorizes an exception.

---

# 2. Foreign Key Definition

## 2.1 Purpose

This section defines the canonical meaning of a Foreign Key within the
Phoenix Platform.

A consistent definition ensures uniform relationship modeling throughout
the repository.

---

## 2.2 Definition

A Foreign Key is a database constraint that establishes a relationship
between a referencing table and a referenced table.

The Foreign Key guarantees that every referenced record exists before the
relationship can be created.

---

## 2.3 Architectural Responsibility

A Foreign Key is responsible for:

- Preserving referential integrity.
- Enforcing valid business relationships.
- Preventing orphan records.
- Supporting consistent navigation between business entities.

A Foreign Key SHALL NOT implement business workflow or application logic.

---

## 2.4 Referencing Table

The referencing table contains the Foreign Key column.

The Foreign Key value SHALL reference the Primary Key of another table,
unless an approved Architecture Decision Record (ADR) explicitly specifies
otherwise.

---

## 2.5 Referenced Table

The referenced table owns the Primary Key being referenced.

Referenced tables MAY include:

- Master Entity Tables
- Reference Tables
- Bridge Tables (where explicitly justified)

The appropriateness of a referenced table SHALL be determined by the
applicable table design standard.

---

## 2.6 Referential Integrity

Every Foreign Key SHALL preserve referential integrity throughout the
lifecycle of the database.

Relationships SHALL remain valid after every INSERT, UPDATE, and DELETE
operation.

---

## 2.7 Business Meaning

Every Foreign Key SHALL represent a documented business relationship.

Technical relationships without business meaning are prohibited.

---

## 2.8 Repository Consistency

Equivalent business relationships SHALL be implemented consistently across
the repository.

Identical business concepts SHALL use identical Foreign Key design
principles.

---

# 3. Foreign Key Design Principles

## 3.1 Purpose

This section defines the fundamental design principles governing Foreign
Keys within the Phoenix Platform.

These principles establish a consistent, maintainable, and scalable
approach to relationship modeling across the repository.

---

## 3.2 Business First

Every Foreign Key SHALL represent a documented business relationship.

Foreign Keys SHALL NOT be introduced solely for technical convenience.

The existence of every Foreign Key SHALL be justified by a business rule.

---

## 3.3 Referential Integrity

Every Foreign Key SHALL preserve referential integrity throughout the
entire lifecycle of the database.

A referencing record SHALL NOT exist unless the referenced record exists.

Orphan records are prohibited.

---

## 3.4 Single Relationship Principle

Each Foreign Key SHALL represent exactly one business relationship.

A Foreign Key SHALL NOT represent multiple independent business meanings.

If multiple business relationships exist, separate Foreign Keys SHALL be
defined.

---

## 3.5 Stable Relationships

Foreign Keys SHALL reference stable identifiers.

Business attributes such as names, codes, descriptions, or dates SHALL NOT
be referenced.

The referenced column SHALL normally be the Primary Key.

---

## 3.6 Explicit Relationships

Every business relationship SHALL be explicitly modeled.

Implicit relationships inferred from application logic, naming
conventions, or matching business values are prohibited.

---

## 3.7 Self-Descriptive Naming

Every Foreign Key column SHALL comply with the
MasterEntityColumnNamingStandard.

Examples:

exchange_id

market_id

instrument_id

issuer_id

relationship_status_id

Generic names are prohibited.

---

## 3.8 Normalization

Foreign Keys SHALL support database normalization.

Business data SHALL NOT be duplicated to avoid defining Foreign Key
relationships.

---

## 3.9 Repository Consistency

Equivalent business relationships SHALL use identical Foreign Key design
principles throughout the repository.

Repository-wide consistency SHALL take precedence over local design
preferences.

---

## 3.10 Enterprise Compliance

Foreign Key design SHALL comply with:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- Repository governance policies

---

# 4. Relationship Classification

## 4.1 Purpose

This section classifies the business relationships that may be implemented
using Foreign Keys within the Phoenix Platform.

Relationship classification improves consistency and simplifies database
design.

---

## 4.2 General Principles

Every Foreign Key SHALL represent one clearly identifiable relationship
type.

Relationship semantics SHALL be documented.

---

## 4.3 Mandatory Relationships

Mandatory relationships require the existence of a referenced business
object.

Mandatory Foreign Keys SHALL be defined as:

- NOT NULL
- FOREIGN KEY

Example:

instrument belongs to one market.

---

## 4.4 Optional Relationships

Optional relationships MAY exist when permitted by documented business
rules.

Optional Foreign Keys SHALL allow NULL values.

Example:

issuer may optionally belong to a holding company.

---

## 4.5 Identifying Relationships

An identifying relationship exists when the child record cannot exist
without the parent record.

Typical examples include:

Reference records owned by a Master Entity.

Bridge relationships between participating Master Entities.

Identifying relationships SHALL preserve referential integrity.

---

## 4.6 Non-Identifying Relationships

A non-identifying relationship references another business object without
forming part of the child record's identity.

These relationships are the preferred model for most business entities.

---

## 4.7 Recursive Relationships

A table MAY reference itself when required by documented business rules.

Examples include:

parent_instrument_id

parent_portfolio_id

Recursive relationships SHALL NOT create circular dependency chains.

---

## 4.8 Cross-Schema Relationships

Foreign Keys MAY reference tables located in another schema.

Cross-schema relationships SHALL comply with repository governance and
naming standards.

---

## 4.9 Relationship Documentation

Every Foreign Key SHALL have documented business meaning describing:

- Referencing table
- Referenced table
- Relationship purpose
- Cardinality
- Business justification

---

## 4.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Relationship type identified

✓ Business meaning documented

✓ Mandatory or optional relationship defined

✓ Referential integrity preserved

✓ Repository consistency maintained

---

# 5. Foreign Key Naming Standard

## 5.1 Purpose

This section defines the canonical naming conventions for Foreign Key
columns and Foreign Key constraints within the Phoenix Platform.

Consistent naming improves readability, maintainability, and repository
consistency.

---

## 5.2 General Principles

Every Foreign Key SHALL have a self-descriptive name.

The column name SHALL clearly identify the referenced business entity.

Generic names are prohibited.

---

## 5.3 Foreign Key Column Naming

Foreign Key column names SHALL follow the format:

<referenced_entity_name>_id

Examples:

exchange_id

market_id

board_id

instrument_id

issuer_id

market_index_id

portfolio_id

---

## 5.4 Reference Table Columns

When referencing a Reference Table, the column SHALL also identify the
referenced business concept.

Examples:

currency_id

market_type_id

relationship_status_id

instrument_type_id

Generic names are prohibited.

---

## 5.5 Self-Referencing Columns

Recursive Foreign Keys SHALL clearly describe the relationship.

Examples:

parent_instrument_id

parent_portfolio_id

parent_category_id

Names such as:

parent_id

root_id

master_id

are prohibited.

---

## 5.6 Constraint Naming

Foreign Key constraint names SHALL comply with the Enterprise Naming
Standard.

Recommended format:

fk_<referencing_table_name>_<referenced_table_name>

Examples:

fk_instrument_market

fk_board_market

fk_portfolio_instrument_bridge_portfolio

fk_portfolio_instrument_bridge_instrument

Constraint names SHALL remain unique within the schema.

---

## 5.7 Multiple References

When multiple Foreign Keys reference the same table, each Foreign Key SHALL
have a unique business meaning.

Examples:

primary_exchange_id

secondary_exchange_id

listing_exchange_id

The business meaning SHALL be explicit.

---

## 5.8 Repository Consistency

Equivalent Foreign Keys SHALL use identical names throughout the
repository.

Alternative naming for the same business relationship is prohibited.

---

## 5.9 Prohibited Naming

The following names are prohibited:

id

entity_id

reference_id

parent_id

master_id

object_id

relationship_id

---

## 5.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Self-descriptive column name

✓ Enterprise Naming Standard compliance

✓ Generic names avoided

✓ Constraint follows naming convention

✓ Repository consistency maintained

---

# 6. Referential Integrity Standard

## 6.1 Purpose

This section defines the referential integrity requirements governing
Foreign Keys within the Phoenix Platform.

Referential integrity SHALL guarantee that all business relationships
remain valid throughout the database lifecycle.

---

## 6.2 General Principles

Every Foreign Key SHALL preserve referential integrity.

A referenced record SHALL exist before a relationship can be created.

Orphan records are prohibited.

---

## 6.3 Mandatory Relationships

Mandatory relationships SHALL enforce:

- NOT NULL
- FOREIGN KEY

The database SHALL reject invalid references.

---

## 6.4 Optional Relationships

Optional relationships MAY allow NULL values when explicitly permitted by
documented business rules.

NULL SHALL represent the absence of a valid relationship.

---

## 6.5 Referential Validation

Referential integrity SHALL be enforced by database constraints.

Application code SHALL NOT replace database-enforced referential integrity.

---

## 6.6 Relationship Changes

Changes to referenced Primary Keys are discouraged.

Primary Keys SHALL remain immutable.

Foreign Keys SHALL always reference stable identifiers.

---

## 6.7 Deletion Integrity

Deletion of referenced records SHALL preserve database consistency.

Referential actions SHALL comply with the repository referential action
policy.

---

## 6.8 Cross-Schema Integrity

Cross-schema Foreign Keys SHALL provide the same referential guarantees as
relationships within a single schema.

---

## 6.9 Repository Consistency

Equivalent relationships SHALL preserve identical referential integrity
rules throughout the repository.

---

## 6.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Referential integrity enforced

✓ No orphan records

✓ Mandatory relationships protected

✓ Optional relationships documented

✓ Repository-wide consistency maintained

---

# 7. Referential Action Standard

## 7.1 Purpose

This section defines the standard referential actions governing Foreign
Keys within the Phoenix Platform.

Referential actions SHALL preserve business integrity while preventing
unexpected data loss and maintaining repository consistency.

---

## 7.2 General Principles

Referential actions SHALL reflect documented business rules.

Database convenience SHALL NOT override business integrity.

The selected referential action SHALL be explicitly justified.

---

## 7.3 ON UPDATE Policy

The canonical policy for Foreign Keys is:

ON UPDATE RESTRICT

Primary Keys are immutable within the Phoenix Platform.

Consequently, UPDATE operations affecting Primary Keys SHOULD NOT occur.

---

## 7.4 ON DELETE Policy

The canonical policy for Foreign Keys is:

ON DELETE RESTRICT

Referenced records SHALL NOT be deleted while dependent business records
exist.

This policy preserves referential integrity and protects historical data.

---

## 7.5 Exceptional Referential Actions

Alternative referential actions MAY be used only when explicitly justified
by documented business requirements.

Permitted alternatives include:

- ON DELETE CASCADE
- ON DELETE SET NULL
- ON UPDATE CASCADE

Each exception SHALL be documented.

---

## 7.6 CASCADE Usage

ON DELETE CASCADE SHALL be used only when deletion of the parent business
object logically requires deletion of all dependent records.

CASCADE SHALL NOT be used merely for implementation convenience.

Business justification is mandatory.

---

## 7.7 SET NULL Usage

ON DELETE SET NULL MAY be used only when:

- The relationship is optional.
- NULL has documented business meaning.
- The relationship remains valid without the referenced object.

Mandatory relationships SHALL NOT use SET NULL.

---

## 7.8 Repository Consistency

Equivalent business relationships SHALL use identical referential actions
throughout the repository.

Inconsistent referential actions for equivalent relationships are
prohibited.

---

## 7.9 Documentation

Every Foreign Key SHALL document:

- Selected referential action.
- Business justification.
- Exceptional behavior (if applicable).

---

## 7.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Referential action documented

✓ Business justification provided

✓ Canonical policy followed unless approved exception exists

✓ Repository consistency maintained

---

# 8. Nullable Relationship Standard

## 8.1 Purpose

This section defines the rules governing nullable Foreign Keys within the
Phoenix Platform.

Nullable Foreign Keys SHALL accurately represent optional business
relationships.

---

## 8.2 General Principles

NULL SHALL indicate that no business relationship currently exists.

NULL SHALL NOT represent:

- Unknown data
- Invalid data
- Temporary data
- Incomplete processing

---

## 8.3 Mandatory Relationships

Mandatory relationships SHALL satisfy:

- NOT NULL
- FOREIGN KEY

Every referencing record SHALL reference an existing business object.

---

## 8.4 Optional Relationships

Optional relationships MAY allow NULL values.

The business meaning of the optional relationship SHALL be documented.

Typical examples include:

holding_company_id

secondary_exchange_id

replacement_instrument_id

---

## 8.5 Business Validation

Application logic MAY impose additional business validation.

Database nullability SHALL represent structural requirements only.

Workflow validation SHALL remain outside database constraints.

---

## 8.6 Nullable Lifecycle

A nullable Foreign Key MAY become populated or cleared during the business
lifecycle when permitted by documented business rules.

Such changes SHALL remain auditable.

---

## 8.7 Prohibited Usage

NULL SHALL NOT be used to bypass referential integrity.

Placeholder values such as:

0

-1

999999

UNKNOWN

N/A

are prohibited.

Missing relationships SHALL be represented by NULL only when the
relationship is optional.

---

## 8.8 Repository Consistency

Equivalent optional relationships SHALL use identical nullability rules
throughout the repository.

Different implementations for equivalent business relationships are
prohibited.

---

## 8.9 Documentation

Every nullable Foreign Key SHALL document:

- Business meaning
- Conditions under which NULL is permitted
- Lifecycle behavior

---

## 8.10 Compliance Checklist

Every nullable Foreign Key SHALL satisfy the following:

✓ Business meaning documented

✓ NULL represents absence of relationship

✓ Placeholder values prohibited

✓ Repository consistency maintained

✓ Lifecycle behavior documented

---

# 9. Composite Foreign Key Standard

## 9.1 Purpose

This section defines the principles governing Composite Foreign Keys within
the Phoenix Platform.

Composite Foreign Keys SHALL be used only when they are required to
represent a valid business relationship and cannot be replaced by a single
surrogate identifier.

---

## 9.2 General Principles

The preferred approach within the Phoenix Platform is to reference a single
Primary Key.

Composite Foreign Keys SHOULD be avoided whenever a surrogate identifier
exists.

---

## 9.3 Canonical Rule

Foreign Keys SHALL reference the surrogate Primary Key of the referenced
table.

Composite Foreign Keys SHALL NOT be introduced merely to reproduce a
business key.

---

## 9.4 Exceptional Usage

A Composite Foreign Key MAY be permitted only when all of the following
conditions are satisfied:

- The referenced object has no surrogate Primary Key.
- The referenced key is officially defined as composite.
- Business semantics require all participating columns.
- Architectural approval has been obtained.

---

## 9.5 Phoenix Repository Policy

Within the Phoenix Platform, all canonical table categories use surrogate
Primary Keys.

Consequently, Composite Foreign Keys are expected to be extremely rare.

New designs SHOULD assume that Composite Foreign Keys are prohibited unless
an approved Architecture Decision Record (ADR) explicitly authorizes their
use.

---

## 9.6 Naming Convention

Each column participating in a Composite Foreign Key SHALL follow the
Enterprise Naming Standard.

Constraint names SHALL comply with:

fk_<referencing_table>_<referenced_table>

---

## 9.7 Referential Integrity

Every participating column SHALL preserve referential integrity.

Partial references are prohibited.

All participating columns SHALL reference the same parent record.

---

## 9.8 Repository Consistency

Equivalent business relationships SHALL use identical Foreign Key
structures throughout the repository.

---

## 9.9 Documentation

Every approved Composite Foreign Key SHALL document:

- Business justification
- Architectural justification
- Referenced key definition
- ADR reference (if applicable)

---

## 9.10 Compliance Checklist

Every Composite Foreign Key SHALL satisfy the following:

✓ Business justification documented

✓ Architectural approval obtained

✓ Surrogate alternative evaluated

✓ Referential integrity preserved

✓ Enterprise Naming Standard compliance

---

# 10. Self-Referencing Foreign Key Standard

## 10.1 Purpose

This section defines the requirements governing self-referencing Foreign
Keys within the Phoenix Platform.

Self-referencing Foreign Keys model hierarchical business relationships
within a single table.

---

## 10.2 General Principles

Self-referencing relationships SHALL represent a valid business hierarchy.

Hierarchies SHALL be explicitly documented.

---

## 10.3 Typical Examples

Examples include:

parent_instrument_id

parent_portfolio_id

parent_category_id

parent_organization_id

Each relationship SHALL describe a well-defined parent-child hierarchy.

---

## 10.4 Root Records

Root records SHALL contain NULL in the self-referencing Foreign Key when no
parent exists.

Placeholder values are prohibited.

---

## 10.5 Hierarchy Integrity

A record SHALL NOT reference itself.

Circular hierarchy chains are prohibited.

Every hierarchy SHALL terminate at a valid root record.

---

## 10.6 Recursive Queries

Self-referencing structures SHALL support recursive database queries.

Hierarchies SHOULD be designed for efficient recursive traversal.

---

## 10.7 Deletion Policy

Deletion of parent records SHALL preserve hierarchy integrity.

The selected referential action SHALL comply with the Referential Action
Standard.

---

## 10.8 Documentation

Every self-referencing relationship SHALL document:

- Parent meaning
- Child meaning
- Root definition
- Hierarchy semantics

---

## 10.9 Repository Consistency

Equivalent hierarchies SHALL use identical design principles throughout the
repository.

---

## 10.10 Compliance Checklist

Every self-referencing Foreign Key SHALL satisfy the following:

✓ Business hierarchy documented

✓ Self-reference prohibited

✓ Circular hierarchies prevented

✓ Root definition documented

✓ Repository consistency maintained

---

# 11. Circular Dependency Standard

## 11.1 Purpose

This section defines the rules governing circular dependencies involving
Foreign Keys within the Phoenix Platform.

The objective is to preserve a clear, maintainable, and scalable database
architecture while preventing unnecessary coupling between business
entities.

---

## 11.2 General Principles

Circular dependencies SHALL be avoided.

Business relationships SHALL form a logical dependency structure that
supports repository maintainability.

Database implementation convenience SHALL NOT justify circular
dependencies.

---

## 11.3 Direct Circular Dependencies

Two tables SHALL NOT reference each other through mandatory Foreign Keys.

Example:

Table A → Table B

Table B → Table A

Such structures complicate data creation, deletion, migration, and schema
maintenance.

---

## 11.4 Indirect Circular Dependencies

Dependency chains forming closed loops are prohibited.

Example:

A → B → C → A

Repository dependency graphs SHALL remain acyclic whenever reasonably
possible.

---

## 11.5 Approved Exceptions

A circular dependency MAY be permitted only when:

- The business model requires it.
- No simpler design exists.
- Architectural review has been completed.
- The exception has been formally approved.

Every approved exception SHALL reference an Architecture Decision Record
(ADR).

---

## 11.6 Detection

Circular dependencies SHOULD be detected during:

- Logical database design
- Physical database design
- Architecture review
- Repository audit

Automated schema validation is recommended whenever practical.

---

## 11.7 Alternative Designs

Before approving a circular dependency, architects SHOULD evaluate
alternative designs, including:

- Bridge Tables
- Optional relationships
- Relationship decomposition
- Domain model refactoring

The simplest maintainable design SHALL be preferred.

---

## 11.8 Repository Consistency

Equivalent business models SHALL avoid circular dependencies using
consistent architectural principles.

---

## 11.9 Documentation

Every approved exception SHALL document:

- Business justification
- Technical justification
- Impact assessment
- ADR reference

---

## 11.10 Compliance Checklist

Every database design SHALL satisfy the following:

✓ No direct circular dependencies

✓ No indirect dependency loops

✓ Alternative designs evaluated

✓ Approved exceptions documented

✓ Repository consistency maintained

---

# 12. Foreign Key Performance Standard

## 12.1 Purpose

This section defines performance considerations for Foreign Keys within the
Phoenix Platform.

Foreign Key design SHALL support efficient query execution while preserving
referential integrity.

---

## 12.2 General Principles

Performance optimization SHALL never compromise data integrity.

Foreign Keys SHALL be designed for long-term scalability.

---

## 12.3 Index Evaluation

Every Foreign Key SHALL be evaluated to determine whether an index is
required.

Frequently accessed Foreign Keys SHOULD normally be indexed.

Index design SHALL follow the IndexDesignStandard.

---

## 12.4 Query Performance

Foreign Keys SHALL support efficient:

- JOIN operations
- Filtering
- Relationship traversal
- Aggregation

Database access patterns SHOULD influence indexing strategy.

---

## 12.5 Insert Performance

Foreign Key validation introduces additional validation overhead during
INSERT operations.

Database design SHOULD balance integrity and performance.

Premature optimization is prohibited.

---

## 12.6 Update Performance

Because referenced Primary Keys are immutable within the Phoenix Platform,
Foreign Key update activity is expected to be minimal.

---

## 12.7 Delete Performance

Deletion of referenced records SHALL comply with the Referential Action
Standard.

Deletion strategies SHALL minimize unnecessary locking and preserve
business integrity.

---

## 12.8 Large-Scale Relationships

Relationships involving very large tables SHOULD undergo performance
testing.

Query execution plans SHOULD be reviewed before production deployment.

---

## 12.9 Repository Consistency

Equivalent Foreign Keys SHALL receive consistent performance optimization
throughout the repository.

---

## 12.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Performance evaluated

✓ Index strategy documented

✓ Referential integrity preserved

✓ Scalability considered

✓ Repository consistency maintained

---

# 13. Foreign Key Documentation Standard

## 13.1 Purpose

This section defines the documentation requirements for Foreign Keys within
the Phoenix Platform.

Every Foreign Key SHALL have sufficient documentation to ensure that its
business meaning, architectural purpose, and implementation remain
understandable throughout the repository lifecycle.

---

## 13.2 General Principles

Foreign Key documentation SHALL describe the business relationship rather
than merely the database constraint.

Documentation SHALL be maintained together with the database schema.

---

## 13.3 Mandatory Documentation

Every Foreign Key SHALL document:

- Referencing table
- Referenced table
- Referencing column
- Referenced column
- Business relationship
- Cardinality
- Nullability
- Referential action
- Business justification

---

## 13.4 Business Description

Documentation SHALL clearly explain:

- Why the relationship exists.
- What business concept it represents.
- Why the referenced entity is required.
- Whether the relationship is mandatory or optional.

Technical descriptions alone are insufficient.

---

## 13.5 Architectural Documentation

Foreign Keys SHALL be traceable to:

- Logical Data Model
- Physical Data Model
- Entity Relationship Diagram (ERD)
- Data Dictionary

Repository documentation SHALL remain synchronized.

---

## 13.6 Exception Documentation

Whenever a Foreign Key deviates from the canonical design principles,
documentation SHALL include:

- Architectural justification
- Business justification
- Approved ADR reference

---

## 13.7 Repository Traceability

Every Foreign Key SHALL remain traceable throughout repository history.

Structural changes SHALL be documented through version control.

---

## 13.8 Repository Consistency

Equivalent business relationships SHALL use consistent documentation
throughout the repository.

Terminology SHALL remain consistent across all standards.

---

## 13.9 Documentation Quality

Documentation SHALL be:

- Accurate
- Complete
- Current
- Understandable
- Business-oriented

Outdated documentation is prohibited.

---

## 13.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Business relationship documented

✓ Referential action documented

✓ Nullability documented

✓ Repository traceability maintained

✓ Documentation synchronized with implementation

---

# 14. Foreign Key Governance Standard

## 14.1 Purpose

This section defines the governance principles for Foreign Keys within the
Phoenix Platform.

Foreign Keys represent enterprise business relationships and SHALL be
governed as shared architectural assets.

---

## 14.2 Governance Principles

Every Foreign Key SHALL be:

- Business justified
- Architecturally reviewed
- Repository controlled
- Fully documented
- Version controlled

Individual implementation preferences SHALL NOT override repository
standards.

---

## 14.3 Ownership

Every Foreign Key SHALL have an identifiable business owner.

The business owner SHALL approve:

- Relationship semantics
- Business rules
- Relationship lifecycle
- Relationship necessity

Technical implementation remains the responsibility of the development
team.

---

## 14.4 Change Management

Changes affecting Foreign Keys SHALL undergo impact analysis.

The analysis SHALL consider:

- Business impact
- Data integrity
- Dependent tables
- Dependent services
- Repository consistency

---

## 14.5 Version Control

All Foreign Key definitions SHALL be maintained under version control.

Historical changes SHALL remain traceable.

---

## 14.6 Architecture Review

Major Foreign Key modifications SHOULD be reviewed by the architecture
team.

Architectural review is recommended for:

- New business relationships
- Cross-schema relationships
- Recursive relationships
- Approved exceptions

---

## 14.7 Repository Compliance

Repository-wide consistency SHALL take precedence over local optimization.

Equivalent business relationships SHALL follow identical governance
principles.

---

## 14.8 Periodic Review

Foreign Keys SHOULD be periodically reviewed to verify:

- Continued business relevance
- Referential integrity
- Naming consistency
- Documentation quality
- Repository compliance

---

## 14.9 Exception Approval

Exceptions to this standard SHALL require formal approval through an
Architecture Decision Record (ADR).

Undocumented exceptions are prohibited.

---

## 14.10 Compliance Checklist

Every Foreign Key SHALL satisfy the following:

✓ Business ownership identified

✓ Architecture review completed where required

✓ Repository governance followed

✓ Version controlled

✓ ADR documented for approved exceptions

---

# 15. Foreign Key Anti-Patterns

## 15.1 Purpose

This section identifies common design mistakes that SHALL be avoided when
designing Foreign Keys within the Phoenix Platform.

Avoiding these anti-patterns improves repository consistency,
maintainability, data integrity, and architectural quality.

---

## 15.2 Missing Business Meaning

Every Foreign Key SHALL represent a documented business relationship.

Foreign Keys created solely for implementation convenience are prohibited.

---

## 15.3 Referencing Business Attributes

Foreign Keys SHALL reference stable identifiers.

The following are prohibited as referenced columns:

- Name
- Local name
- Code
- Description
- Symbol
- Abbreviation

Only approved identifier columns SHALL be referenced.

---

## 15.4 Generic Column Names

Generic Foreign Key column names are prohibited.

Incorrect examples:

id

entity_id

reference_id

object_id

parent_id

Correct examples:

exchange_id

market_id

board_id

instrument_id

issuer_id

relationship_status_id

---

## 15.5 Missing Referential Integrity

Application logic SHALL NOT replace database-enforced Foreign Keys.

Relationships without Foreign Key constraints are prohibited unless an
approved Architecture Decision Record (ADR) explicitly authorizes an
exception.

---

## 15.6 Inconsistent Referential Actions

Equivalent business relationships SHALL NOT use different referential
actions.

Repository consistency SHALL be preserved.

---

## 15.7 Duplicate Relationships

Multiple Foreign Keys representing the same business relationship are
prohibited.

Each business relationship SHALL have exactly one authoritative Foreign
Key.

---

## 15.8 Circular Dependencies

Circular dependency chains SHALL NOT be introduced merely to satisfy
technical implementation.

Alternative designs SHALL be evaluated first.

---

## 15.9 Composite Foreign Keys Without Justification

Composite Foreign Keys SHALL NOT be introduced unless explicitly justified
by documented business requirements and approved through repository
governance.

---

## 15.10 Hidden Relationships

Business relationships implemented only through application logic are
prohibited.

Relationships SHALL be explicitly represented by Foreign Key constraints.

---

## 15.11 Inconsistent Naming

Equivalent Foreign Keys SHALL use identical naming throughout the
repository.

Alternative naming for the same business relationship is prohibited.

---

## 15.12 Repository Inconsistency

Foreign Key implementation SHALL remain consistent across all schemas,
services, and database modules.

Local optimization SHALL NOT compromise enterprise consistency.

---

## 15.13 Summary

The following practices are prohibited:

✗ Foreign Keys without business meaning

✗ Referencing business attributes

✗ Generic column names

✗ Missing Foreign Key constraints

✗ Inconsistent referential actions

✗ Duplicate business relationships

✗ Circular dependencies

✗ Unjustified Composite Foreign Keys

✗ Hidden application-only relationships

✗ Repository inconsistency

---

# 16. Foreign Key Design Checklist

## 16.1 Purpose

This checklist defines the mandatory architectural verification criteria
for designing Foreign Keys within the Phoenix Platform.

Every new Foreign Key SHALL satisfy all applicable checklist items before
implementation.

---

## 16.2 Business Relationship

□ Represents one documented business relationship.

□ Business purpose documented.

□ Business owner identified.

□ Relationship justified.

---

## 16.3 Referenced Object

□ References the correct table.

□ References the Primary Key.

□ References a stable identifier.

□ Business attributes are not referenced.

---

## 16.4 Naming

□ Foreign Key column follows:

<referenced_entity_name>_id

□ Constraint name complies with EnterpriseNamingStandard.

□ Generic names avoided.

---

## 16.5 Referential Integrity

□ Referential integrity enforced.

□ Mandatory or optional relationship documented.

□ Orphan records prevented.

---

## 16.6 Referential Actions

□ ON UPDATE policy documented.

□ ON DELETE policy documented.

□ Approved exceptions documented.

---

## 16.7 Nullability

□ Nullability matches business rules.

□ NULL has documented business meaning.

□ Placeholder values prohibited.

---

## 16.8 Performance

□ Performance evaluated.

□ Index requirements evaluated.

□ Query patterns reviewed.

---

## 16.9 Documentation

□ Business relationship documented.

□ Data Dictionary updated.

□ ERD updated.

□ Logical Data Model updated.

□ Physical Data Model updated.

---

## 16.10 Governance

□ Repository standards followed.

□ Architecture review completed where required.

□ ADR documented for approved exceptions.

□ Repository consistency verified.

---

## 16.11 Final Verification

A Foreign Key SHALL NOT be approved until all mandatory checklist items
have been reviewed and satisfied.

Any deviation from this standard SHALL require formal architectural
approval through the repository governance process.

---

# 17. References

## 17.1 Purpose

This section identifies the repository standards and architectural
documents referenced by this standard.

ForeignKeyDesignStandard SHALL be interpreted together with these
documents to ensure a consistent enterprise database architecture.

---

## 17.2 Mandatory Standards

The following standards are mandatory references:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard

Compliance with these standards is mandatory unless an approved
Architecture Decision Record (ADR) explicitly authorizes an exception.

---

## 17.3 Related Database Standards

The following database standards complement this document:

- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- FactTableDesignStandard
- EventTableDesignStandard
- BridgeTableDesignStandard

Together these standards define the canonical database table architecture
of the Phoenix Platform.

---

## 17.4 Related Constraint Standards

The following standards are closely related to Foreign Key design:

- PrimaryKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard
- IndexDesignStandard

Foreign Keys SHALL be designed consistently with these standards.

---

## 17.5 Repository Standards

Foreign Keys SHALL comply with repository-wide standards governing:

- Repository organization
- Documentation
- Database architecture
- Naming conventions
- Governance

Repository standards take precedence over local implementation
preferences.

---

## 17.6 Architecture Decision Records

Whenever this standard conflicts with an approved Architecture Decision
Record (ADR), the ADR SHALL take precedence.

Approved exceptions SHALL be documented through an ADR.

---

## 17.7 Future Revisions

This standard SHALL evolve together with the Phoenix Platform.

Future revisions SHOULD preserve backward compatibility whenever
reasonably possible.

Breaking changes SHALL undergo architectural review before adoption.

---

## 17.8 Summary

ForeignKeyDesignStandard defines the canonical principles governing
referential integrity, relationship modeling, and Foreign Key governance
within the Phoenix Platform.

It provides a single enterprise-wide standard for implementing business
relationships consistently across all supported database schemas.

---

# 18. Appendix

## 18.1 Canonical Foreign Key Example

```sql
CREATE TABLE instrument (

    instrument_id BIGINT GENERATED ALWAYS AS IDENTITY,

    market_id BIGINT NOT NULL,

    issuer_id BIGINT NOT NULL,

    instrument_type_id INTEGER NOT NULL,

    created_at TIMESTAMP NOT NULL,

    PRIMARY KEY (instrument_id),

    CONSTRAINT fk_instrument_market
        FOREIGN KEY (market_id)
        REFERENCES market (market_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_issuer
        FOREIGN KEY (issuer_id)
        REFERENCES issuer (issuer_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_instrument_type
        FOREIGN KEY (instrument_type_id)
        REFERENCES instrument_type (instrument_type_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);
```

---

## 18.2 Self-Referencing Example

```sql
CREATE TABLE organization (

    organization_id BIGINT GENERATED ALWAYS AS IDENTITY,

    parent_organization_id BIGINT NULL,

    organization_name VARCHAR(200) NOT NULL,

    PRIMARY KEY (organization_id),

    CONSTRAINT fk_organization_parent
        FOREIGN KEY (parent_organization_id)
        REFERENCES organization (organization_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);
```

---

## 18.3 Optional Relationship Example

```sql
CREATE TABLE issuer (

    issuer_id BIGINT GENERATED ALWAYS AS IDENTITY,

    holding_company_id BIGINT NULL,

    PRIMARY KEY (issuer_id),

    CONSTRAINT fk_issuer_holding_company
        FOREIGN KEY (holding_company_id)
        REFERENCES issuer (issuer_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);
```

---

## 18.4 Cross-Schema Example

```sql
CONSTRAINT fk_market_country
    FOREIGN KEY (country_id)
    REFERENCES reference.country (country_id)
```

Cross-schema Foreign Keys SHALL follow the same naming, integrity, and
governance rules as Foreign Keys within a single schema.

---

## 18.5 Repository Principles

Every Foreign Key implemented within the Phoenix Platform SHALL comply
with the following principles:

- Business-driven relationships
- Referential integrity
- Stable identifiers
- Self-descriptive naming
- Repository-wide consistency
- Complete documentation
- Architecture governance

These principles constitute the canonical Foreign Key policy of the
Phoenix Platform.

---

## End of Document