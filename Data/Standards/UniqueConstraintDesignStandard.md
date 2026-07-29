# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | UniqueConstraintDesignStandard |
| Document Title | Enterprise Unique Constraint Design Standard |
| Document Identifier | STD-DATA-004 |
| Domain | Data Architecture |
| Category | Database Design Standard |
| Status | Draft |
| Version | 2026.1 |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Platform |
| Language | English |
| Classification | Internal |
| Created | 2026-07-28 |
| Last Updated | 2026-07-28 |
| Next Review | TBD |

---

# 1. Introduction

## 1.1 Purpose

This document defines the Enterprise Standard governing the design,
implementation, naming, validation, and governance of **UNIQUE
Constraints** throughout the Phoenix Platform.

It establishes a single, repository-wide approach for enforcing business
uniqueness while ensuring architectural consistency, data integrity, and
long-term maintainability.

---

## 1.2 Scope

This standard applies to:

- Reference Tables
- Master Entity Tables
- Transaction Tables
- Fact Tables
- Bridge Tables
- Configuration Tables
- All PostgreSQL schemas within the Phoenix repository

Every applicable database object SHALL comply with this standard.

---

## 1.3 Objectives

The objectives of this standard are to:

- Protect business uniqueness.
- Prevent duplicate business data.
- Standardize UNIQUE Constraint implementation.
- Standardize constraint naming.
- Improve repository consistency.
- Support enterprise data quality.
- Reduce implementation ambiguity.

---

## 1.4 Guiding Principles

This standard is based on the following principles:

- Business rules SHALL be enforced by the database whenever possible.
- Every uniqueness rule SHALL be explicit.
- Constraint names SHALL be deterministic.
- Repository consistency SHALL take precedence over local preferences.
- All implementations SHALL remain architecture-driven.

---

## 1.5 Relationship to Other Standards

This document SHALL be used together with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard
- DDLTemplateSpecification

This document defines only UNIQUE Constraint rules.

Rules governing Primary Keys and Foreign Keys SHALL NOT be duplicated
herein.

---

## 1.6 Compliance

Compliance with this standard is mandatory.

Any exception SHALL require formal approval by the Enterprise
Architecture Team.

---

# 2. Unique Constraint Principles

## 2.1 Purpose

A UNIQUE Constraint protects business identity by preventing duplicate
values within one or more business columns.

It SHALL enforce business uniqueness independently of the Primary Key.

---

## 2.2 Business Identity

A UNIQUE Constraint SHALL represent a business rule rather than a
technical implementation detail.

Typical examples include:

- Exchange Code
- Market Code
- ISIN
- Currency Code
- Country Code

Business identifiers SHALL remain stable throughout the lifecycle of the
entity.

---

## 2.3 Relationship with Primary Key

A UNIQUE Constraint SHALL NOT replace the Primary Key.

Primary Keys identify database rows.

UNIQUE Constraints identify business uniqueness.

Both mechanisms SHALL coexist when appropriate.

---

## 2.4 Candidate Keys

A UNIQUE Constraint MAY be defined on a Candidate Key.

When multiple Candidate Keys exist, each approved business identifier MAY
be protected by its own UNIQUE Constraint.

---

## 2.5 Natural Keys

Natural business identifiers SHOULD be protected using UNIQUE
Constraints.

Examples include:

- exchange_code
- market_code
- isin
- currency_code

Natural Keys SHALL NOT replace surrogate Primary Keys.

---

## 2.6 Composite Business Keys

Where business uniqueness depends on multiple attributes, a Composite
UNIQUE Constraint SHALL be used.

Example:

```sql
(exchange_id, market_code)
```

The combination SHALL be unique even if each individual column is not.

---

## 2.7 Repository Consistency

Equivalent business rules SHALL be implemented identically throughout the
repository.

Similar entities SHALL use similar UNIQUE Constraint strategies.

Local variations are prohibited unless approved by Enterprise
Architecture.

---

## 2.8 Compliance

Every UNIQUE Constraint SHALL:

- Represent a business uniqueness rule.
- Be deterministic.
- Be architecture-driven.
- Remain repository consistent.
- Comply with this standard.

---

# 3. Unique Constraint Definition

## 3.1 Definition

A UNIQUE Constraint guarantees that no two rows contain the same value,
or the same combination of values, within the constrained columns.

It enforces business uniqueness at the database level.

---

## 3.2 Purpose

UNIQUE Constraints SHALL:

- Prevent duplicate business identifiers.
- Preserve data quality.
- Protect business integrity.
- Support reliable data integration.
- Reduce application-level validation complexity.

---

## 3.3 Characteristics

A UNIQUE Constraint:

- MAY reference one column.
- MAY reference multiple columns.
- SHALL be deterministic.
- SHALL be enforced by PostgreSQL.
- SHALL be named explicitly.

---

## 3.4 Appropriate Usage

UNIQUE Constraints SHOULD be used for:

- Business Codes
- External Codes
- Registration Numbers
- ISIN
- ISO Codes
- Composite Business Identifiers

They SHALL NOT be used merely to improve query performance.

---

## 3.5 Inappropriate Usage

UNIQUE Constraints SHALL NOT be used:

- Instead of Primary Keys.
- Instead of CHECK Constraints.
- Instead of Foreign Keys.
- For temporary validation.
- For application-only rules.

Each database constraint SHALL have a single architectural purpose.

---

## 3.6 Enforcement

Every UNIQUE Constraint SHALL be enforced by PostgreSQL.

Application-level validation MAY supplement database validation but SHALL
NOT replace it.

---

# 4. Naming Standard

## 4.1 Purpose

Every UNIQUE Constraint SHALL have a deterministic, meaningful, and
repository-wide consistent name.

Unnamed constraints are prohibited.

---

## 4.2 Canonical Naming Pattern

The approved naming convention is:

```text
uk_<table_name>_<business_identifier>
```

---

## 4.3 Examples

Correct examples:

```text
uk_exchange_exchange_code
uk_market_market_code
uk_currency_currency_code
uk_country_country_code
uk_security_isin
```

Composite examples:

```text
uk_market_exchange_market_code
uk_board_market_board_code
```

---

## 4.4 Naming Rules

Constraint names SHALL:

- Begin with `uk_`.
- Contain the table name.
- Contain the protected business identifier.
- Use lowercase letters.
- Use underscores as separators.
- Avoid abbreviations unless officially approved.

---

## 4.5 Prohibited Names

The following names SHALL NOT be used:

```text
unique1
uk1
unique_code
constraint1
sys_unique
```

Automatically generated PostgreSQL names are prohibited.

---

## 4.6 Repository Consistency

Equivalent business rules SHALL always produce equivalent constraint
names.

Repository consistency SHALL take precedence over developer preference.

---

## 4.7 Relationship with Column Naming

Constraint names SHALL reference the canonical business column names
defined by the ColumnNamingStandard.

Constraint names SHALL NOT introduce alternative terminology.

---

## 4.8 Compliance

Every UNIQUE Constraint SHALL:

- Use the `uk_` prefix.
- Include the table name.
- Include the protected business identifier.
- Follow the approved naming convention.
- Remain repository consistent.

---

# 5. Single-Column Unique Constraints

## 5.1 Purpose

This section defines the Enterprise Standard governing UNIQUE Constraints
implemented on a single database column.

Single-column UNIQUE Constraints SHALL protect business identifiers that
are individually unique across the corresponding table.

---

## 5.2 Appropriate Usage

A single-column UNIQUE Constraint SHOULD be used when one business
attribute uniquely identifies an entity.

Typical examples include:

- exchange_code
- market_code
- currency_code
- timezone_code
- country_code
- isin

---

## 5.3 Canonical Implementation

Approved implementation:

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    )
```

Every single-column UNIQUE Constraint SHALL use the canonical naming
convention defined in this standard.

---

## 5.4 Business Semantics

Single-column UNIQUE Constraints SHALL protect business identity rather
than technical implementation details.

They SHALL remain stable throughout the lifecycle of the corresponding
business entity.

---

## 5.5 Candidate Key Protection

Where a Candidate Key consists of a single business column, that column
SHOULD be protected by a UNIQUE Constraint.

The existence of a surrogate Primary Key SHALL NOT eliminate the need for
business uniqueness.

---

## 5.6 Performance Considerations

PostgreSQL automatically creates a unique index supporting every UNIQUE
Constraint.

Additional duplicate indexes SHALL NOT be created.

---

## 5.7 Repository Consistency

Equivalent business identifiers SHALL always be implemented using the
same UNIQUE Constraint strategy.

Repository-wide consistency SHALL take precedence over local
implementation preferences.

---

## 5.8 Compliance

Every single-column UNIQUE Constraint SHALL:

- Protect one business identifier.
- Be explicitly named.
- Follow the canonical naming convention.
- Prevent duplicate business values.
- Remain repository consistent.

---

# 6. Composite Unique Constraints

## 6.1 Purpose

This section defines the Enterprise Standard governing Composite UNIQUE
Constraints.

Composite UNIQUE Constraints SHALL protect business identities that are
defined by the combination of multiple attributes.

---

## 6.2 Appropriate Usage

A Composite UNIQUE Constraint SHALL be used whenever no single column is
sufficient to guarantee business uniqueness.

Typical examples include:

- Exchange + Market Code
- Market + Board Code
- Country + Currency
- Security + Effective Date

---

## 6.3 Canonical Implementation

Approved implementation:

```sql
CONSTRAINT uk_market_exchange_market_code
    UNIQUE
    (
        exchange_id,
        market_code
    )
```

The uniqueness SHALL apply to the entire column combination.

---

## 6.4 Column Order

The order of columns within a Composite UNIQUE Constraint SHALL be
deterministic.

Columns SHALL be ordered according to business meaning rather than
alphabetical order.

The selected order SHALL remain stable throughout the repository.

---

## 6.5 Business Semantics

Every Composite UNIQUE Constraint SHALL represent exactly one business
rule.

Multiple unrelated business rules SHALL NOT be combined into a single
constraint.

---

## 6.6 Redundant Constraints

A Composite UNIQUE Constraint SHALL NOT duplicate the behavior of another
existing UNIQUE Constraint.

Redundant uniqueness definitions are prohibited.

---

## 6.7 Candidate Key Representation

Composite Candidate Keys SHOULD be protected using Composite UNIQUE
Constraints.

Surrogate Primary Keys SHALL remain independent from business uniqueness.

---

## 6.8 Compliance

Every Composite UNIQUE Constraint SHALL:

- Represent one business rule.
- Use deterministic column ordering.
- Be explicitly named.
- Avoid redundancy.
- Remain repository consistent.

---

# 7. NULL Handling

## 7.1 Purpose

This section defines the Enterprise Standard governing NULL values within
UNIQUE Constraints.

---

## 7.2 PostgreSQL Behavior

PostgreSQL considers NULL values to be distinct.

Therefore, multiple rows MAY contain NULL in a UNIQUE-constrained column,
provided all non-NULL values remain unique.

---

## 7.3 Repository Policy

Columns representing mandatory business identifiers SHALL be declared:

```sql
NOT NULL
```

before applying a UNIQUE Constraint.

Business identifiers SHALL NOT rely on PostgreSQL NULL semantics.

---

## 7.4 Optional Business Attributes

Where business rules permit missing values, NULL MAY be allowed.

Such cases SHALL be explicitly documented within the Enterprise Data
Dictionary.

---

## 7.5 Consistency

Equivalent business identifiers SHALL use identical NULL policies across
the repository.

---

## 7.6 Compliance

Every UNIQUE implementation SHALL:

- Explicitly define NULL behavior.
- Prefer NOT NULL for business identifiers.
- Avoid ambiguous business semantics.
- Remain repository consistent.

---

# 8. Business Rules

## 8.1 Purpose

This section defines the business principles governing the use of UNIQUE
Constraints.

---

## 8.2 Business Rule Enforcement

Every UNIQUE Constraint SHALL enforce a genuine business rule.

Technical convenience SHALL NOT justify a UNIQUE Constraint.

---

## 8.3 Stable Business Identifiers

Business identifiers protected by UNIQUE Constraints SHOULD be stable.

Frequently changing business values SHOULD NOT be selected as unique
identifiers.

---

## 8.4 Multiple Business Identifiers

An entity MAY define multiple approved business identifiers.

Each independent business rule SHALL have its own UNIQUE Constraint.

Each Business Identifier must have exactly one UNIQUE Constraint.

Each UNIQUE Constraint must implement only one Business Rule.

---

## 8.5 Temporary Values

Temporary identifiers SHALL NOT be protected using UNIQUE Constraints.

Only persistent business identifiers qualify.

---

## 8.6 Documentation

Every UNIQUE Constraint SHALL be traceable to:

- Domain Model
- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model

---

## 8.7 Governance

Every new UNIQUE Constraint SHALL be supported by documented business
justification.

Undocumented uniqueness rules are prohibited.

---

## 8.8 Compliance

Every UNIQUE Constraint SHALL:

- Protect a documented business rule.
- Preserve business integrity.
- Be architecture-driven.
- Remain repository consistent.

---

# 9. Constraint Ordering

## 9.1 Purpose

This section defines the canonical ordering of UNIQUE Constraints within
database table definitions.

Consistent constraint ordering improves readability, maintainability, code
reviews, and repository-wide consistency.

---

## 9.2 Canonical Constraint Sequence

All table-level constraints SHALL be declared in the following order:

1. Primary Key
2. Unique Constraints
3. Foreign Keys
4. Check Constraints

No alternative ordering SHALL be used unless formally approved.

---

## 9.3 Multiple UNIQUE Constraints

Where multiple UNIQUE Constraints exist, they SHALL be ordered according
to business importance.

The Primary Business Identifier SHALL appear first.

Example:

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    ),

CONSTRAINT uk_exchange_exchange_name
    UNIQUE
    (
        exchange_name
    )
```

---

## 9.4 Composite Constraints

Composite UNIQUE Constraints SHALL be placed after single-column UNIQUE
Constraints unless business requirements dictate otherwise.

Ordering SHALL remain deterministic.

---

## 9.5 Readability

Constraint definitions SHOULD be visually grouped.

Blank lines MAY separate different constraint categories.

Formatting SHALL follow the approved DDL template.

---

## 9.6 Repository Consistency

Equivalent entities SHALL use identical constraint ordering throughout the
repository.

Repository consistency SHALL take precedence over developer preference.

---

## 9.7 DDL Template Alignment

The canonical ordering defined herein SHALL be reflected in the
DDLTemplateSpecification.

Every DDL script SHALL follow the same constraint sequence.

---

## 9.8 Compliance

Every table SHALL:

- Follow the canonical ordering.
- Group constraints consistently.
- Preserve repository uniformity.
- Comply with the DDL template.

---

# 10. Canonical SQL Patterns

## 10.1 Purpose

This section defines the canonical SQL implementation patterns for UNIQUE
Constraints.

These patterns SHALL be used consistently throughout the Phoenix
repository.

---

## 10.2 Single-Column Pattern

Canonical implementation:

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    )
```

---

## 10.3 Composite Pattern

Canonical implementation:

```sql
CONSTRAINT uk_market_exchange_market_code
    UNIQUE
    (
        exchange_id,
        market_code
    )
```

---

## 10.4 Multiple UNIQUE Constraints

The public_id (UUID) column should always have an independent UNIQUE Constraint and this Constraint should be defined in all tables with the name uk_<table_name>_public_id.

Example:

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    ),

CONSTRAINT uk_exchange_public_id
    UNIQUE
    (
        public_id
    )
```

Each UNIQUE Constraint SHALL enforce one independent business rule.

---

## 10.5 Naming Pattern

Approved format:

```text
uk_<table_name>_<business_identifier>
```

Examples:

```text
uk_currency_currency_code
uk_timezone_timezone_code
uk_country_country_code
```

---

## 10.6 Formatting Rules

Constraint definitions SHALL:

- Use uppercase SQL keywords.
- Use one column per line when practical.
- Follow repository indentation rules.
- End with commas where appropriate.

Formatting SHALL remain identical across the repository.

---

## 10.7 DDL Consistency

All SQL scripts SHALL implement UNIQUE Constraints using the canonical
patterns defined in this section.

Custom formatting is prohibited.

---

## 10.8 Compliance

Every implementation SHALL:

- Follow canonical SQL patterns.
- Follow canonical naming.
- Follow canonical formatting.
- Remain repository consistent.

---

# 11. Canonical Examples

## 11.1 Purpose

This section provides authoritative examples illustrating correct
implementation of UNIQUE Constraints.

These examples SHALL serve as the repository reference implementation.

---

## 11.2 Reference Table Example

```sql
CONSTRAINT uk_currency_currency_code
    UNIQUE
    (
        currency_code
    )
```

---

## 11.3 Master Entity Example

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    )
```

---

## 11.4 Composite Example

```sql
CONSTRAINT uk_market_exchange_market_code
    UNIQUE
    (
        exchange_id,
        market_code
    )
```

---

## 11.5 Multiple Constraint Example

```sql
CONSTRAINT uk_security_isin
    UNIQUE
    (
        isin
    ),

CONSTRAINT uk_security_symbol_exchange
    UNIQUE
    (
        exchange_id,
        symbol
    )
```

---

## 11.6 Repository Pattern

Every example SHALL:

- Use explicit names.
- Follow canonical ordering.
- Follow canonical formatting.
- Represent one documented business rule.

---

## 11.7 Business Traceability

Every UNIQUE Constraint SHOULD be traceable to:

- Domain Model
- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model

---

## 11.8 Compliance

Canonical examples SHALL be treated as the approved implementation
patterns for the Phoenix Platform.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies prohibited UNIQUE Constraint implementations.

The anti-patterns defined herein SHALL NOT be used.

---

## 12.2 Unnamed Constraints

Incorrect:

```sql
UNIQUE (exchange_code)
```

Correct:

```sql
CONSTRAINT uk_exchange_exchange_code
    UNIQUE
    (
        exchange_code
    )
```

---

## 12.3 Using UNIQUE Instead of Primary Key

UNIQUE Constraints SHALL NOT replace Primary Keys.

Business identity and row identity are separate concepts.

---

## 12.4 Duplicate UNIQUE Constraints

Multiple UNIQUE Constraints protecting the same business rule are
prohibited.

Redundant uniqueness definitions SHALL NOT exist.

---

## 12.5 Incorrect Naming

The following names are prohibited:

```text
uk1
unique1
constraint1
unique_code
```

Automatically generated constraint names SHALL NOT be retained.

---

## 12.6 Technical-Only Constraints

UNIQUE Constraints SHALL NOT be created solely for perceived query
performance improvements.

Their purpose is enforcing documented business uniqueness.

---

## 12.7 Undocumented Business Rules

Every UNIQUE Constraint SHALL correspond to a documented business rule.

Undocumented uniqueness constraints are prohibited.

---

## 12.8 Compliance

Every implementation SHALL avoid:

- Unnamed constraints.
- Redundant constraints.
- Incorrect naming.
- Misuse of UNIQUE Constraints.
- Undocumented business rules.

Repository consistency SHALL always take precedence over implementation
preferences.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the Enterprise Standard governing the migration of
UNIQUE Constraints during schema evolution, repository modernization, and
database migration activities.

Migration SHALL preserve business integrity and repository consistency.

---

## 13.2 Business Rule Preservation

Existing UNIQUE Constraints SHALL be preserved whenever the underlying
business rule remains valid.

UNIQUE Constraints SHALL NOT be removed solely because of schema
refactoring.

---

## 13.3 Legacy Migration

Legacy databases MAY use:

- unnamed constraints;
- inconsistent naming;
- duplicate uniqueness definitions;
- application-only uniqueness validation.

During migration, all such implementations SHALL be aligned with this
standard.

---

## 13.4 Constraint Renaming

Existing UNIQUE Constraints SHALL be renamed to comply with the canonical
naming convention.

Approved pattern:

```text
uk_<table_name>_<business_identifier>
```

Constraint renaming SHALL NOT modify business semantics.

---

## 13.5 Data Validation

Before enabling a UNIQUE Constraint, duplicate business values SHALL be
identified and resolved.

Migration SHALL fail if duplicate data violates the intended uniqueness
rule.

---

## 13.6 Repository Alignment

Following migration, every UNIQUE Constraint SHALL comply with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard

---

## 13.7 Backward Compatibility

Where legacy interfaces depend upon existing business identifiers,
migration SHALL preserve functional compatibility whenever possible.

Breaking changes SHALL require architectural approval.

---

## 13.8 Compliance

Every migration SHALL:

- Preserve business uniqueness.
- Preserve repository consistency.
- Preserve business semantics.
- Comply with this standard.

---

# 14. Validation Checklist

## 14.1 Purpose

This checklist SHALL be used during architecture review, repository
certification, and implementation approval.

---

## 14.2 Naming Validation

Verify that:

- Every UNIQUE Constraint has an explicit name.
- The name begins with `uk_`.
- The table name is included.
- The business identifier is included.
- The name complies with the approved naming convention.

---

## 14.3 Business Validation

Verify that:

- The constraint protects a documented business rule.
- The protected business identifier is stable.
- The uniqueness rule exists in the Enterprise Data Dictionary.

---

## 14.4 Structural Validation

Verify that:

- Duplicate UNIQUE Constraints do not exist.
- Composite constraints contain the correct columns.
- Column ordering is deterministic.

---

## 14.5 SQL Validation

Verify that:

- Canonical SQL formatting is used.
- Constraint ordering is correct.
- Constraint names are explicit.
- PostgreSQL syntax is valid.

---

## 14.6 Repository Validation

Verify that:

- Equivalent entities use equivalent constraint strategies.
- Repository conventions are consistently applied.
- Local deviations have not been introduced.

---

## 14.7 Architecture Validation

Verify that:

- Business uniqueness has architectural justification.
- No UNIQUE Constraint replaces a Primary Key.
- The implementation complies with all related standards.

---

## 14.8 Compliance Checklist

Every UNIQUE Constraint SHALL satisfy all of the following:

✓ Explicitly named

✓ Correct naming convention

✓ One documented business rule

✓ Correct SQL implementation

✓ Repository consistency

✓ Architecture compliance

No UNIQUE Constraint SHALL be approved unless every applicable validation
rule has been successfully satisfied.

---

# 15. Repository Rules

## 15.1 Repository-wide Consistency

All UNIQUE Constraints SHALL follow identical implementation principles
throughout every Phoenix repository schema.

---

## 15.2 Single Source of Truth

This document SHALL be the single authoritative source governing UNIQUE
Constraint implementation.

Other standards MAY reference this document but SHALL NOT redefine UNIQUE
Constraint behavior.

---

## 15.3 Relationship with Other Standards

This document SHALL be used together with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard

---

## 15.4 Mandatory Documentation

Every UNIQUE Constraint SHALL be traceable to at least one documented
business requirement.

Undocumented UNIQUE Constraints are prohibited.

Each UNIQUE Constraint must be traceable to a specific entity in the Enterprise Data Dictionary and, if possible, to a Business Rule or ADR.

---

## 15.5 Repository Naming

All UNIQUE Constraint names SHALL remain globally consistent.

Equivalent business identifiers SHALL use equivalent naming patterns.

---

## 15.6 DDL Template Compliance

Every DDL script SHALL implement UNIQUE Constraints according to the
approved DDLTemplateSpecification.

---

## 15.7 Architecture Review

Every newly introduced UNIQUE Constraint SHALL be reviewed during
Enterprise Architecture review.

---

## 15.8 Compliance

Repository compliance with this standard is mandatory.

---

# 16. Architecture Rules

## 16.1 Enterprise Principle

Business uniqueness SHALL be enforced by the database whenever practical.

Application-only uniqueness validation is insufficient.

---

## 16.2 Architectural Responsibility

UNIQUE Constraints SHALL enforce business identity.

Primary Keys SHALL enforce row identity.

These responsibilities SHALL remain distinct.

---

## 16.3 Repository Stability

Business uniqueness definitions SHALL remain stable throughout the
repository lifecycle.

Frequent redesign of UNIQUE Constraints is discouraged.

---

## 16.4 Architectural Governance

Any exception to this standard SHALL:

- Include documented justification.
- Include repository impact assessment.
- Receive Enterprise Architecture approval.

---

## 16.5 Architecture Freeze

Once approved, UNIQUE Constraint architecture SHALL be considered
architecturally frozen.

Changes SHALL require:

- Business justification.
- Architecture review.
- Migration strategy.
- Version update.

---

## 16.6 Future Standards

Future database standards SHALL reference this document whenever UNIQUE
Constraints are discussed.

Duplicate definitions are prohibited.

---

## 16.7 Repository Integrity

Repository-wide consistency SHALL always take precedence over individual
implementation preferences.

---

## 16.8 Compliance

Every implementation SHALL comply with:

- Enterprise Architecture
- Approved ADRs
- Repository Governance
- This standard

Compliance is mandatory.

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative documents governing the design,
implementation, validation, and lifecycle management of UNIQUE Constraints
within the Phoenix Platform.

Only the documents referenced herein SHALL be considered normative.

---

## 17.2 Normative References

The following standards SHALL be complied with when implementing UNIQUE
Constraints.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| ColumnNamingStandard | Canonical database column naming |
| PrimaryKeyDesignStandard | Primary Key implementation |
| ForeignKeyDesignStandard | Foreign Key implementation |
| AuditColumnDesignStandard | Enterprise audit columns |
| DDLTemplateSpecification | Canonical SQL script template |
| PostgreSQL Design Decisions | PostgreSQL implementation guidance |

---

## 17.3 Related Standards

The following documents complement this standard.

| Document | Relationship |
|----------|--------------|
| DatabaseConstraintStandard | Enterprise constraint governance |
| DatabaseIndexStandard | Index implementation strategy |
| MasterEntityDesignStandard | Master entity table design |
| ReferenceTableDesignStandard | Reference table design |
| FactTableDesignStandard | Fact table design |
| EventTableDesignStandard | Event table design |
| BridgeTableDesignStandard | Bridge table design |

---

## 17.4 Related Architecture Artifacts

Business uniqueness SHALL be traceable to one or more of the following
architecture artifacts:

- Architecture Decision Records (ADRs)
- Domain Model
- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model
- Table Physical Specifications

Business rules SHALL NOT exist solely within SQL scripts.

---

## 17.5 Governance

Where conflicts exist between this document and another implementation
standard, the Enterprise Governance Framework SHALL determine precedence.

Approved ADRs SHALL override implementation guidance whenever an explicit
architectural decision exists.

---

## 17.6 Single Source of Truth

This document SHALL remain the authoritative source governing UNIQUE
Constraint implementation.

Other standards MAY reference this document but SHALL NOT redefine UNIQUE
Constraint behavior.

---

## 17.7 Repository Compliance

Every UNIQUE Constraint implemented within the Phoenix Platform SHALL
comply with this standard.

Compliance SHALL be verified during architecture review, repository audit,
and repository certification.

---

## 17.8 Traceability

Every UNIQUE Constraint SHOULD be traceable from:

Business Requirement

→ Domain Model

→ Enterprise Data Dictionary

→ Physical Database Model

→ SQL Implementation

Complete traceability SHALL be maintained throughout the repository
lifecycle.

---

# 18. Revision History

## 18.1 Purpose

This section records the lifecycle and revision history of the Enterprise
Unique Constraint Design Standard.

Every approved modification SHALL be documented to preserve architectural
traceability.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Unique Constraint Design Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this document SHALL be managed under the Enterprise Governance
Framework.

Every change SHALL include:

- Business justification
- Architecture impact assessment
- Repository impact assessment
- Version increment
- Formal approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing UNIQUE Constraints SHALL include a repository-
wide compatibility assessment.

Migration activities SHALL preserve business integrity, data quality, and
repository consistency.

---

## 18.5 Architecture Freeze

Once approved, the Enterprise UNIQUE Constraint architecture SHALL be
considered architecturally frozen.

Changes SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Migration strategy
- Version update

Architectural stability SHALL take precedence over implementation
convenience.

---

## 18.6 Repository Compliance

All SQL scripts, database models, and future implementations SHALL comply
with the latest approved version of this standard.

Legacy implementations SHALL be aligned through controlled migration
activities where required.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Requests for modification, clarification, or exception SHALL be submitted
through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative source governing the design,
implementation, validation, and governance of UNIQUE Constraints within
the Phoenix Platform.

All database objects, SQL scripts, data models, and implementation
artifacts SHALL comply with this standard.

UNIQUE Constraint rules SHALL NOT be duplicated or redefined elsewhere in
the repository.

---

## End of Document