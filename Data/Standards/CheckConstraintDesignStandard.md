# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | CheckConstraintDesignStandard |
| Document Title | Enterprise Check Constraint Design Standard |
| Document Identifier | STD-DATA-005 |
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
implementation, naming, validation, and governance of **CHECK
Constraints** throughout the Phoenix Platform.

It establishes a single, repository-wide approach for enforcing business
validation rules at the database level while ensuring architectural
consistency, data integrity, and long-term maintainability.

---

## 1.2 Scope

This standard applies to:

- Reference Tables
- Master Entity Tables
- Transaction Tables
- Fact Tables
- Event Tables
- Bridge Tables
- Configuration Tables
- All PostgreSQL schemas within the Phoenix repository

Every applicable database object SHALL comply with this standard.

---

## 1.3 Objectives

The objectives of this standard are to:

- Protect business integrity.
- Enforce business validation rules.
- Prevent invalid data.
- Standardize CHECK Constraint implementation.
- Standardize constraint naming.
- Improve repository consistency.
- Reduce application-level validation.

---

## 1.4 Guiding Principles

This standard is based on the following principles:

- Business validation SHALL be enforced by the database whenever practical.
- Every CHECK Constraint SHALL represent one documented business rule.
- Constraint names SHALL be deterministic.
- Repository consistency SHALL take precedence over local implementation preferences.
- All implementations SHALL remain architecture-driven.

---

## 1.5 Relationship to Other Standards

This document SHALL be used together with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard
- DDLTemplateSpecification

This document defines only CHECK Constraint rules.

Rules governing Primary Keys, Foreign Keys, and UNIQUE Constraints SHALL
NOT be duplicated herein.

---

## 1.6 Compliance

Compliance with this standard is mandatory.

Any exception SHALL require formal approval by the Enterprise
Architecture Team.

---

# 2. Check Constraint Principles

## 2.1 Purpose

A CHECK Constraint enforces a documented business validation rule by
restricting the values that may be stored within one or more columns.

Its purpose is to prevent invalid data from entering the database.

---

## 2.2 Business Validation

Every CHECK Constraint SHALL represent a documented business rule.

The database SHALL enforce business validation independently of the
application layer.

---

## 2.3 Declarative Validation

Validation rules SHOULD be implemented declaratively using SQL CHECK
Constraints whenever supported by PostgreSQL.

Declarative validation is preferred over procedural validation.

---

## 2.4 Relationship with Application Validation

Application-level validation MAY improve user experience.

However, application validation SHALL NOT replace database-level CHECK
Constraints.

Both mechanisms MAY coexist.

---

## 2.5 One Constraint – One Rule

Each CHECK Constraint SHALL enforce exactly one business rule.

Multiple unrelated validation rules SHALL NOT be combined into a single
constraint.

---

## 2.6 Deterministic Evaluation

CHECK expressions SHALL be deterministic.

Expressions depending upon non-deterministic functions are prohibited.

Examples include:

- random()
- clock_timestamp()
- transaction_timestamp()

unless explicitly approved by Enterprise Architecture.

---

## 2.7 Repository Consistency

Equivalent business rules SHALL use equivalent CHECK Constraint
implementations throughout the repository.

Repository consistency SHALL take precedence over developer preference.

---

## 2.8 Compliance

Every CHECK Constraint SHALL:

- Enforce one documented business rule.
- Be deterministic.
- Be explicitly named.
- Be architecture-driven.
- Remain repository consistent.

---

# 3. Check Constraint Definition

## 3.1 Definition

A CHECK Constraint evaluates a Boolean expression whenever a row is
inserted or updated.

The operation SHALL succeed only when the expression evaluates to TRUE.

---

## 3.2 Purpose

CHECK Constraints SHALL:

- Prevent invalid business values.
- Protect business integrity.
- Improve data quality.
- Reduce application complexity.
- Support enterprise governance.

---

## 3.3 Characteristics

A CHECK Constraint:

- MAY reference one or more columns of the same row.
- SHALL evaluate a deterministic Boolean expression.
- SHALL be enforced by PostgreSQL.
- SHALL be explicitly named.

---

## 3.4 Appropriate Usage

CHECK Constraints SHOULD be used for:

- Numeric ranges.
- Mandatory business limits.
- String validation.
- Date validation.
- Enumeration validation.
- Boolean consistency.

---

## 3.5 Inappropriate Usage

CHECK Constraints SHALL NOT be used:

- Instead of Foreign Keys.
- Instead of UNIQUE Constraints.
- Instead of Primary Keys.
- To validate data in another table.
- To implement procedural business logic.

Each constraint SHALL have one architectural responsibility.

---

## 3.6 Enforcement

Every CHECK Constraint SHALL be enforced by PostgreSQL.

Applications MAY perform additional validation but SHALL NOT replace the
database implementation.

---

# 4. Naming Standard

## 4.1 Purpose

Every CHECK Constraint SHALL have a deterministic, meaningful, and
repository-wide consistent name.

Unnamed constraints are prohibited.

---

## 4.2 Canonical Naming Pattern

The approved naming convention is:

```text
ck_<table_name>_<business_rule>
```

---

## 4.3 Examples

Correct examples:

```text
ck_exchange_exchange_code_not_empty
ck_exchange_exchange_name_not_empty
ck_exchange_display_order
ck_currency_decimal_places
ck_timezone_utc_offset
ck_market_market_name_not_empty
```

---

## 4.4 Naming Rules

Constraint names SHALL:

- Begin with `ck_`.
- Include the table name.
- Include the validated business rule.
- Use lowercase letters.
- Use underscores as separators.
- Avoid undocumented abbreviations.

---

## 4.5 Prohibited Names

The following names SHALL NOT be used:

```text
check1
ck1
validation
constraint1
business_rule
general_check
```

Automatically generated PostgreSQL names are prohibited.

---

## 4.6 Repository Consistency

Equivalent validation rules SHALL always produce equivalent CHECK
Constraint names.

Repository consistency SHALL take precedence over developer preference.

---

## 4.7 Relationship with Column Naming

Constraint names SHALL reference canonical column names defined by the
ColumnNamingStandard.

Alternative terminology SHALL NOT be introduced.

---

## 4.8 Compliance

Every CHECK Constraint SHALL:

- Use the `ck_` prefix.
- Include the table name.
- Describe the validated business rule.
- Follow the approved naming convention.
- Remain repository consistent.

---

# 5. String Validation

## 5.1 Purpose

This section defines the Enterprise Standard governing CHECK Constraints
used for validating character-based data.

String validation SHALL prevent invalid textual values from being stored
within the database.

---

## 5.2 Empty String Validation

Mandatory business attributes SHALL NOT contain empty strings.

Approved implementation:

```sql
CONSTRAINT ck_exchange_exchange_code_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_code)) > 0
    )
```

---

## 5.3 Whitespace Validation

Business identifiers SHALL NOT consist solely of whitespace characters.

Validation SHALL use the `TRIM()` function before evaluating length.

Example:

```sql
CHECK
(
    LENGTH(TRIM(exchange_name)) > 0
)
```

---

## 5.4 String Length Validation

Where business rules specify minimum or maximum lengths, CHECK
Constraints SHOULD enforce those limits.

Example:

```sql
CHECK
(
    LENGTH(exchange_code) <= 20
)
```

Length limits SHALL remain consistent with the Enterprise Data
Dictionary.

---

## 5.5 Character Validation

Where applicable, CHECK Constraints MAY restrict character content.

Examples include:

- Uppercase codes
- Numeric-only identifiers
- Alphabetic values
- Approved symbols

Complex pattern validation SHOULD be implemented only when supported by
clear business requirements.

---

## 5.6 Business Meaning

String validation SHALL enforce business quality rather than formatting
preferences.

Formatting rules intended solely for user interfaces SHOULD remain within
the application layer.

---

## 5.7 Repository Consistency

Equivalent business attributes SHALL use equivalent string validation
rules throughout the repository.

Repository consistency SHALL take precedence over local implementation
preferences.

---

## 5.8 Compliance

Every string validation CHECK Constraint SHALL:

- Represent one documented business rule.
- Be deterministic.
- Prevent invalid textual values.
- Remain repository consistent.

---

# 6. Numeric Validation

## 6.1 Purpose

This section defines the Enterprise Standard governing CHECK Constraints
used for validating numeric business values.

Numeric validation SHALL protect business integrity and prevent invalid
numeric data.

---

## 6.2 Positive Values

Business attributes representing ordered sequences, identifiers,
quantities, or rankings SHALL enforce positive values where applicable.

Example:

```sql
CONSTRAINT ck_exchange_display_order
    CHECK
    (
        display_order > 0
    )
```

---

## 6.3 Value Ranges

Where business rules define acceptable numeric ranges, CHECK Constraints
SHALL enforce those limits.

Example:

```sql
CHECK
(
    decimal_places BETWEEN 0 AND 8
)
```

---

## 6.4 Minimum and Maximum Limits

Business rules MAY define explicit lower and upper bounds.

Example:

```sql
CHECK
(
    trading_days_per_week BETWEEN 1 AND 7
)
```

---

## 6.5 Decimal Precision

Where decimal precision is configurable, permitted values SHALL be
restricted by CHECK Constraints.

Example:

```sql
CHECK
(
    price_precision BETWEEN 0 AND 12
)
```

---

## 6.6 Business Semantics

Numeric validation SHALL represent documented business rules rather than
technical implementation preferences.

---

## 6.7 Repository Consistency

Equivalent numeric attributes SHALL use identical validation strategies
throughout the repository.

---

## 6.8 Compliance

Every numeric CHECK Constraint SHALL:

- Protect one documented business rule.
- Be deterministic.
- Prevent invalid numeric values.
- Remain repository consistent.

---

# 7. Date and Time Validation

## 7.1 Purpose

This section defines the Enterprise Standard governing CHECK Constraints
used for validating temporal business values.

---

## 7.2 Chronological Validation

CHECK Constraints SHOULD enforce valid chronological relationships.

Example:

```sql
CHECK
(
    effective_to >= effective_from
)
```

---

## 7.3 Valid Time Periods

Business periods SHALL have a valid beginning and ending.

Example:

```sql
CHECK
(
    expiration_date >= issue_date
)
```

---

## 7.4 Future and Historical Dates

Business rules MAY restrict dates to historical or future values only.

Such restrictions SHALL be deterministic.

---

## 7.5 Non-Deterministic Functions

CHECK Constraints SHALL NOT depend upon:

- CURRENT_TIMESTAMP
- NOW()
- CLOCK_TIMESTAMP()
- RANDOM()

because these expressions are not deterministic over time.

---

## 7.6 Business Semantics

Temporal validation SHALL represent documented business requirements.

---

## 7.7 Repository Consistency

Equivalent temporal attributes SHALL use equivalent validation rules.

---

## 7.8 Compliance

Every temporal CHECK Constraint SHALL:

- Represent one documented business rule.
- Be deterministic.
- Preserve chronological integrity.
- Remain repository consistent.

---

# 8. Boolean and Enumeration Validation

## 8.1 Purpose

This section defines the Enterprise Standard governing CHECK Constraints
used for validating Boolean values and controlled business domains.

---

## 8.2 Enumeration Validation

CHECK Constraints SHOULD enforce controlled value sets.

Example:

```sql
CHECK
(
    market_status IN
    (
        'ACTIVE',
        'INACTIVE',
        'SUSPENDED'
    )
)
```

---

## 8.3 Business Domains

Enumerated values SHALL originate from documented business definitions.

Hard-coded values SHALL NOT exist without architectural justification.

---

## 8.4 Boolean Consistency

Boolean columns SHOULD NOT require CHECK Constraints unless additional
business rules must be enforced.

---

## 8.5 Multi-Column Validation

CHECK Constraints MAY validate relationships between multiple columns of
the same row.

Example:

```sql
CHECK
(
    is_active = FALSE
    OR deactivated_at IS NULL
)
```

---

## 8.6 Reference Data

Where the valid values are maintained in a reference table, a Foreign Key
SHALL be used instead of a CHECK Constraint.

---

## 8.7 Repository Consistency

Equivalent business domains SHALL use identical validation rules across
the repository.

---

## 8.8 Compliance

Every Boolean or enumeration CHECK Constraint SHALL:

- Enforce one documented business rule.
- Use deterministic expressions.
- Avoid duplication with Foreign Keys.
- Remain repository consistent.

---

# 9. Constraint Ordering

## 9.1 Purpose

This section defines the canonical ordering of CHECK Constraints within
database table definitions.

Consistent constraint ordering improves readability, maintainability,
repository consistency, and architecture reviews.

---

## 9.2 Canonical Constraint Sequence

All table-level constraints SHALL be declared in the following order:

1. Primary Key
2. Unique Constraints
3. Foreign Keys
4. Check Constraints

CHECK Constraints SHALL always appear after all key constraints.

---

## 9.3 Multiple CHECK Constraints

Where multiple CHECK Constraints exist, they SHALL be ordered according
to business importance.

General validation rules SHOULD precede specialized validation rules.

Example:

```sql
CONSTRAINT ck_exchange_exchange_code_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_code)) > 0
    ),

CONSTRAINT ck_exchange_display_order
    CHECK
    (
        display_order > 0
    )
```

---

## 9.4 One Rule per Constraint

Each CHECK Constraint SHALL validate exactly one business rule.

Complex expressions combining unrelated validations are prohibited.

Incorrect:

```sql
CHECK
(
    display_order > 0
    AND LENGTH(TRIM(exchange_code)) > 0
)
```

Correct:

```sql
CONSTRAINT ck_exchange_display_order
CHECK
(
    display_order > 0
),

CONSTRAINT ck_exchange_exchange_code_not_empty
CHECK
(
    LENGTH(TRIM(exchange_code)) > 0
)
```

---

## 9.5 Readability

CHECK Constraints SHOULD be visually grouped.

Blank lines MAY separate logically different validation rules.

Formatting SHALL comply with the approved DDL Template.

---

## 9.6 Repository Consistency

Equivalent business rules SHALL always appear in the same relative order
throughout the repository.

Consistency SHALL take precedence over developer preference.

---

## 9.7 DDL Template Alignment

The canonical ordering defined herein SHALL be reflected in the
DDLTemplateSpecification.

Every DDL script SHALL follow the same constraint sequence.

---

## 9.8 Compliance

Every table SHALL:

- Follow canonical constraint ordering.
- Keep CHECK Constraints grouped.
- Preserve readability.
- Comply with the DDL template.

---

# 10. Canonical SQL Patterns

## 10.1 Purpose

This section defines the canonical SQL implementation patterns for CHECK
Constraints.

These patterns SHALL be used consistently throughout the Phoenix
repository.

---

## 10.2 Single-Column Validation

Canonical implementation:

```sql
CONSTRAINT ck_exchange_display_order
    CHECK
    (
        display_order > 0
    )
```

---

## 10.3 String Validation

Canonical implementation:

```sql
CONSTRAINT ck_exchange_exchange_name_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_name)) > 0
    )
```

---

## 10.4 Range Validation

Canonical implementation:

```sql
CONSTRAINT ck_currency_decimal_places
    CHECK
    (
        decimal_places BETWEEN 0 AND 8
    )
```

---

## 10.5 Multi-Column Validation

Canonical implementation:

```sql
CONSTRAINT ck_contract_effective_period
    CHECK
    (
        effective_to >= effective_from
    )
```

The validation SHALL reference only columns belonging to the same row.

---

## 10.6 Formatting Rules

CHECK Constraints SHALL:

- Use uppercase SQL keywords.
- Place the Boolean expression on separate lines.
- Follow repository indentation rules.
- Be explicitly named.
- Follow the approved DDL template.

---

## 10.7 Deterministic Expressions

CHECK expressions SHALL use only deterministic operators and functions.

Expressions depending upon changing runtime values are prohibited.

---

## 10.8 Compliance

Every CHECK Constraint SHALL:

- Follow canonical SQL patterns.
- Use explicit names.
- Use deterministic expressions.
- Remain repository consistent.

---

# 11. Canonical Examples

## 11.1 Purpose

This section provides authoritative examples illustrating the approved
implementation of CHECK Constraints.

These examples SHALL serve as the repository reference implementation.

---

## 11.2 Reference Table Example

```sql
CONSTRAINT ck_exchange_exchange_code_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_code)) > 0
    )
```

---

## 11.3 Numeric Validation Example

```sql
CONSTRAINT ck_exchange_display_order
    CHECK
    (
        display_order > 0
    )
```

---

## 11.4 Date Validation Example

```sql
CONSTRAINT ck_contract_effective_period
    CHECK
    (
        effective_to >= effective_from
    )
```

---

## 11.5 Enumeration Example

```sql
CONSTRAINT ck_market_market_status
    CHECK
    (
        market_status IN
        (
            'ACTIVE',
            'INACTIVE',
            'SUSPENDED'
        )
    )
```

---

## 11.6 Multi-Column Example

```sql
CONSTRAINT ck_security_price_range
    CHECK
    (
        maximum_price >= minimum_price
    )
```

---

## 11.7 Repository Pattern

Every example SHALL:

- Use explicit naming.
- Validate one business rule.
- Follow canonical formatting.
- Be deterministic.

---

## 11.8 Compliance

The examples presented herein SHALL be regarded as the approved CHECK
Constraint implementation patterns for the Phoenix Platform.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies prohibited CHECK Constraint implementations.

The anti-patterns defined herein SHALL NOT be used.

---

## 12.2 Multiple Rules in One Constraint

Incorrect:

```sql
CHECK
(
    display_order > 0
    AND is_active = TRUE
    AND LENGTH(TRIM(exchange_code)) > 0
)
```

Each business rule SHALL have its own CHECK Constraint.

---

## 12.3 Non-Deterministic Expressions

The following are prohibited:

```sql
CHECK (created_at <= CURRENT_TIMESTAMP)

CHECK (random() > 0.5)

CHECK (clock_timestamp() > created_at)
```

---

## 12.4 Cross-Table Validation

CHECK Constraints SHALL NOT reference other database tables.

Cross-table integrity SHALL be enforced using Foreign Keys or application
logic where appropriate.

---

## 12.5 Trigger Replacement

Business rules that can be implemented using CHECK Constraints SHALL NOT
be implemented solely by database triggers.

Declarative validation is preferred.

---

## 12.6 Incorrect Naming

The following names are prohibited:

```text
check1
ck1
validation
constraint1
general_check
```

Automatically generated PostgreSQL names SHALL NOT be retained.

---

## 12.7 Duplicate Validation

The same validation rule SHALL NOT be implemented multiple times for the
same table.

Duplicate CHECK Constraints are prohibited.

---

## 12.8 Compliance

Every implementation SHALL avoid:

- Multiple rules per constraint.
- Non-deterministic expressions.
- Cross-table validation.
- Duplicate validation.
- Incorrect naming.

Repository consistency SHALL always take precedence over implementation
preferences.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the Enterprise Standard governing the migration,
refactoring, and evolution of CHECK Constraints throughout the Phoenix
Platform.

Migration activities SHALL preserve business validation, repository
consistency, and architectural integrity.

---

## 13.2 Business Rule Preservation

Existing CHECK Constraints SHALL be preserved whenever the underlying
business rule remains valid.

Schema refactoring SHALL NOT alter business semantics.

---

## 13.3 Legacy Migration

Legacy databases MAY contain:

- unnamed CHECK Constraints;
- inconsistent naming conventions;
- multiple business rules within a single CHECK Constraint;
- duplicated validation logic;
- application-only validation.

During migration, these implementations SHALL be aligned with this
standard.

---

## 13.4 Constraint Renaming

Existing CHECK Constraints SHALL be renamed to comply with the canonical
naming convention.

Approved pattern:

```text
ck_<table_name>_<business_rule>
```

Renaming SHALL NOT modify business behavior.

---

## 13.5 Constraint Decomposition

Where one CHECK Constraint validates multiple unrelated business rules,
it SHALL be decomposed into multiple independent CHECK Constraints.

Example:

Incorrect:

```sql
CHECK
(
    display_order > 0
    AND LENGTH(TRIM(exchange_code)) > 0
)
```

Correct:

```sql
CONSTRAINT ck_exchange_display_order
CHECK
(
    display_order > 0
),

CONSTRAINT ck_exchange_exchange_code_not_empty
CHECK
(
    LENGTH(TRIM(exchange_code)) > 0
)
```

---

## 13.6 Data Validation

Before enabling a new CHECK Constraint, existing data SHALL be validated.

Migration SHALL fail if data violates the intended business rule.

Invalid data SHALL be corrected before deployment.

---

## 13.7 Repository Alignment

Following migration, every CHECK Constraint SHALL comply with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard

---

## 13.8 Compliance

Every migration SHALL:

- Preserve business validation.
- Preserve repository consistency.
- Preserve business semantics.
- Comply with this standard.

---

# 14. Validation Checklist

## 14.1 Purpose

This checklist SHALL be used during architecture review, repository
audit, and implementation approval.

---

## 14.2 Naming Validation

Verify that:

- Every CHECK Constraint has an explicit name.
- The name begins with `ck_`.
- The table name is included.
- The validated business rule is included.
- The name follows the approved naming convention.

---

## 14.3 Business Validation

Verify that:

- The CHECK Constraint protects one documented business rule.
- The business rule exists within the Enterprise Data Dictionary.
- The validation is deterministic.

---

## 14.4 Structural Validation

Verify that:

- One CHECK Constraint validates one business rule.
- No duplicate validation exists.
- Expressions are clear and maintainable.

---

## 14.5 SQL Validation

Verify that:

- Canonical SQL formatting is used.
- Constraint ordering is correct.
- Expressions reference only columns within the same row.
- PostgreSQL syntax is valid.

---

## 14.6 Repository Validation

Verify that:

- Equivalent business rules use equivalent CHECK Constraints.
- Repository naming conventions are followed.
- Local implementation variations have not been introduced.

---

## 14.7 Architecture Validation

Verify that:

- Validation belongs at the database layer.
- CHECK Constraints do not replace Foreign Keys.
- CHECK Constraints do not replace UNIQUE Constraints.
- CHECK Constraints comply with Enterprise Architecture.

---

## 14.8 Compliance Checklist

Every CHECK Constraint SHALL satisfy all of the following:

✓ Explicitly named

✓ One business rule

✓ Deterministic expression

✓ Correct SQL implementation

✓ Repository consistency

✓ Architecture compliance

No CHECK Constraint SHALL be approved unless every applicable validation
requirement has been successfully satisfied.

---

# 15. Repository Rules

## 15.1 Repository-wide Consistency

All CHECK Constraints SHALL follow identical implementation principles
throughout every Phoenix repository schema.

---

## 15.2 Single Source of Truth

This document SHALL be the single authoritative source governing CHECK
Constraint implementation.

Other standards MAY reference this document but SHALL NOT redefine CHECK
Constraint behavior.

---

## 15.3 Relationship with Other Standards

This document SHALL be used together with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- AuditColumnDesignStandard
- DatabaseConstraintStandard

---

## 15.4 Mandatory Documentation

Every CHECK Constraint SHALL be traceable to at least one documented
business requirement.

Undocumented CHECK Constraints are prohibited.

---

## 15.5 Repository Naming

All CHECK Constraint names SHALL remain globally consistent.

Equivalent business rules SHALL use equivalent naming patterns.

---

## 15.6 DDL Template Compliance

Every DDL script SHALL implement CHECK Constraints according to the
approved DDLTemplateSpecification.

---

## 15.7 Architecture Review

Every newly introduced CHECK Constraint SHALL be reviewed during
Enterprise Architecture review.

---

## 15.8 Compliance

Repository compliance with this standard is mandatory.

---

# 16. Architecture Rules

## 16.1 Enterprise Principle

Business validation SHALL be enforced by the database whenever practical.

Application-only validation is insufficient.

---

## 16.2 Architectural Responsibility

CHECK Constraints SHALL enforce business validation.

Primary Keys SHALL enforce row identity.

Foreign Keys SHALL enforce referential integrity.

UNIQUE Constraints SHALL enforce business uniqueness.

Each constraint type SHALL have exactly one architectural responsibility.

---

## 16.3 Repository Stability

Business validation rules SHALL remain stable throughout the repository
lifecycle.

Frequent redesign of CHECK Constraints is discouraged.

---

## 16.4 Architectural Governance

Any exception to this standard SHALL:

- Include documented business justification.
- Include repository impact assessment.
- Receive Enterprise Architecture approval.

---

## 16.5 Architecture Freeze

Once approved, the CHECK Constraint architecture SHALL be considered
architecturally frozen.

Changes SHALL require:

- Business justification.
- Architecture review.
- Migration strategy.
- Version update.

---

## 16.6 Future Standards

Future database standards SHALL reference this document whenever CHECK
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
implementation, validation, and lifecycle management of CHECK Constraints
within the Phoenix Platform.

Only the documents referenced herein SHALL be considered normative.

---

## 17.2 Normative References

The following standards SHALL be complied with when implementing CHECK
Constraints.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| ColumnNamingStandard | Canonical database column naming |
| PrimaryKeyDesignStandard | Primary Key implementation |
| ForeignKeyDesignStandard | Foreign Key implementation |
| UniqueConstraintDesignStandard | Business uniqueness implementation |
| AuditColumnDesignStandard | Enterprise audit column implementation |
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

Every CHECK Constraint SHOULD be traceable to one or more of the
following architectural artifacts:

- Architecture Decision Records (ADRs)
- Domain Model
- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model
- Table Physical Specifications
- Business Rule Catalog (if applicable)

Business validation rules SHALL NOT exist solely within SQL scripts.

---

## 17.5 Governance

Where conflicts exist between this document and another implementation
standard, the Enterprise Governance Framework SHALL determine precedence.

Approved Architecture Decision Records SHALL override implementation
guidance whenever an explicit architectural decision exists.

---

## 17.6 Single Source of Truth

This document SHALL remain the single authoritative source governing
CHECK Constraint implementation throughout the Phoenix Platform.

Other standards MAY reference this document but SHALL NOT redefine CHECK
Constraint behavior.

---

## 17.7 Repository Compliance

Every CHECK Constraint implemented within the Phoenix Platform SHALL
comply with this standard.

Compliance SHALL be verified during:

- Architecture Review
- Repository Audit
- Repository Certification
- Database Release Approval

---

## 17.8 Traceability

Every CHECK Constraint SHOULD be traceable through the following chain:

Business Requirement

→ Business Rule

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
Check Constraint Design Standard.

Every approved modification SHALL be documented to preserve architectural
traceability and governance.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Check Constraint Design Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this document SHALL be managed under the Enterprise Governance
Framework.

Every proposed change SHALL include:

- Business justification
- Architecture impact assessment
- Repository impact assessment
- Migration assessment
- Version increment
- Formal approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing CHECK Constraints SHALL include a repository-
wide compatibility assessment.

Migration activities SHALL preserve:

- Business integrity
- Data quality
- Repository consistency
- Architectural stability

---

## 18.5 Architecture Freeze

Once approved, the Enterprise CHECK Constraint architecture SHALL be
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

All SQL scripts, database models, documentation, and future
implementations SHALL comply with the latest approved version of this
standard.

Legacy implementations SHALL be aligned through controlled migration
activities where required.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Requests for modification, clarification, exception, or extension SHALL
be submitted through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative source governing the design,
implementation, validation, and governance of CHECK Constraints within
the Phoenix Platform.

All database objects, SQL scripts, data models, and implementation
artifacts SHALL comply with this standard.

CHECK Constraint definitions SHALL remain:

- Deterministic
- Explicit
- Architecture-driven
- Repository-consistent
- Fully traceable

Business validation rules SHALL NOT be duplicated, fragmented, or
redefined elsewhere within the repository.

---

## End of Document