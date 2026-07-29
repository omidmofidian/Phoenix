# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | DatabaseObjectNamingStandard |
| Document Title | Enterprise Database Object Naming Standard |
| Document Identifier | STD-DATA-012 |
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

This document defines the Enterprise Standard governing the naming of
all database objects implemented within the Phoenix Platform.

Its purpose is to establish a consistent, predictable, and
architecture-driven naming convention that improves readability,
maintainability, traceability, interoperability, and long-term
repository governance.

Every database object SHALL comply with this standard unless an approved
architectural exception exists.

---

## 1.2 Scope

This standard applies to every database object contained within the
Phoenix Platform, including but not limited to:

- Schemas
- Tables
- Columns
- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Indexes
- Views
- Materialized Views
- Sequences
- Functions
- Procedures
- Triggers
- Domains
- User-defined Types

Every future database object introduced into the repository SHALL also
comply with this standard.

---

## 1.3 Objectives

The objectives of this standard are to:

- Establish a single enterprise naming convention.
- Improve repository consistency.
- Simplify database maintenance.
- Improve architectural readability.
- Support automated tooling.
- Improve documentation quality.
- Preserve long-term architectural stability.

---

## 1.4 Naming Philosophy

Enterprise database object names SHALL be:

- Stable
- Predictable
- Meaningful
- Business-oriented where appropriate
- Technically precise
- Repository consistent

Names SHALL communicate architectural intent rather than implementation
details.

---

## 1.5 Relationship to Other Standards

This document serves as the **Enterprise Naming Authority** for all
database objects.

The following standards SHALL inherit their naming rules from this
document:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard
- IndexDesignStandard
- SequenceDesignStandard
- ViewDesignStandard
- MaterializedViewDesignStandard

Object-specific standards MAY define additional naming requirements but
SHALL NOT contradict this document.

---

## 1.6 Compliance

Compliance with this standard is mandatory.

Every database object created within the Phoenix Platform SHALL comply
with this document.

Exceptions SHALL require formal approval by the Enterprise Architecture
Team.

---

# 2. Naming Architecture

## 2.1 Purpose

This section defines the enterprise architecture governing database
object naming throughout the Phoenix Platform.

Naming SHALL be considered an architectural concern rather than an
implementation detail.

---

## 2.2 Enterprise Naming Strategy

A consistent naming strategy SHALL be applied across every repository
schema.

Equivalent architectural requirements SHALL produce equivalent naming
patterns.

---

## 2.3 Consistency

Naming consistency SHALL be preserved across:

- Schemas
- Tables
- Columns
- Constraints
- Indexes
- Views
- Sequences
- Stored Programs

Repository-wide consistency SHALL always take precedence over developer
preference.

---

## 2.4 Readability

Object names SHALL be immediately understandable by architects,
developers, database administrators, auditors, and future maintainers.

Names SHALL minimize ambiguity.

---

## 2.5 Maintainability

Stable naming reduces maintenance cost.

Approved names SHALL remain unchanged unless business or architectural
requirements justify modification.

---

## 2.6 Traceability

Every object name SHOULD support traceability throughout:

Business Requirement

↓

Architecture Decision Record (ADR)

↓

Logical Model

↓

Physical Model

↓

DDL

↓

Database Object

↓

Application

---

## 2.7 Repository Governance

Naming SHALL remain under Enterprise Architecture governance.

Unauthorized naming conventions are prohibited.

---

## 2.8 Compliance

Every database object SHALL:

- Follow Enterprise naming principles.
- Support repository consistency.
- Remain architecturally meaningful.
- Preserve long-term maintainability.

---

# 3. General Naming Rules

## 3.1 Purpose

This section defines the universal naming rules applicable to every
database object.

These rules SHALL apply unless a more specific rule exists within this
document.

---

## 3.2 Character Set

Object names SHALL use:

- Lowercase English letters (`a-z`)
- Numbers (`0-9`) where appropriate
- Underscore (`_`)

Only ASCII characters SHALL be used.

---

## 3.3 Letter Case

All database object names SHALL use lowercase.

Examples:

```
security

market_data

trade_order

vw_market_summary
```

Mixed-case identifiers are prohibited.

---

## 3.4 Word Separator

Multiple words SHALL be separated using underscores.

Example:

```
daily_market_data
```

The following are prohibited:

```
DailyMarketData

dailyMarketData

daily-market-data

daily market data
```

---

## 3.5 Reserved Words

Database object names SHALL NOT use SQL reserved keywords.

Examples of prohibited names include:

```
user

table

group

select

order

where
```

---

## 3.6 Abbreviations

Abbreviations SHOULD be avoided unless they are officially approved
Enterprise abbreviations.

Examples of acceptable abbreviations include:

```
id

api

etl

url

uuid
```

Undocumented abbreviations are prohibited.

---

## 3.7 Length

Names SHALL remain concise while preserving clarity.

Excessively long names SHOULD be avoided.

Names SHALL remain within PostgreSQL identifier limits.

---

## 3.8 Compliance

Every database object name SHALL:

- Use lowercase.
- Use snake_case.
- Avoid reserved words.
- Avoid undocumented abbreviations.
- Preserve readability.
- Follow Enterprise Architecture.

---

# 4. Enterprise Naming Principles

## 4.1 Purpose

This section defines the architectural principles governing the naming
of database objects throughout the Phoenix Platform.

---

## 4.2 Business First

Where appropriate, names SHALL reflect business concepts rather than
technical implementation.

Examples:

```
security

exchange

market

trade
```

Business terminology SHALL take precedence over implementation
terminology.

---

## 4.3 Stable Names

Approved names SHALL remain stable throughout the repository lifecycle.

Renaming SHALL require:

- Business justification
- Architecture review
- Repository impact assessment

---

## 4.4 Semantic Clarity

Every object name SHALL express one clear meaning.

Ambiguous terminology is prohibited.

---

## 4.5 Repository Consistency

Equivalent business concepts SHALL always use identical names.

Examples:

```
security
```

SHALL NOT also appear elsewhere as:

```
instrument

stock

share

equity
```

unless explicitly defined by Enterprise Architecture as distinct
concepts.

---

## 4.6 One Meaning Per Name

Each approved name SHALL represent exactly one architectural concept.

Multiple meanings for the same name are prohibited.

---

## 4.7 Naming Authority

This document SHALL serve as the single authoritative source governing
database object naming.

Object-specific standards SHALL inherit these principles.

---

## 4.8 Compliance

Every database object SHALL:

- Use stable terminology.
- Express one architectural concept.
- Preserve semantic clarity.
- Remain repository consistent.
- Follow Enterprise naming governance.

---

# 5. Database Object Naming Standards

## 5.1 Purpose

This section defines the canonical naming conventions for every database
object within the Phoenix Platform.

Each database object SHALL follow a standardized naming pattern that
clearly identifies its architectural role.

---

## 5.2 Naming Summary

| Database Object | Naming Pattern | Example |
|-----------------|----------------|---------|
| Schema | `<schema_name>` | `market` |
| Table | `<business_object>` | `security` |
| View | `vw_<business_object>` | `vw_security_summary` |
| Materialized View | `mv_<business_object>` | `mv_daily_market` |
| Sequence | `seq_<business_object>` | `seq_security` |
| Primary Key | `pk_<table>` | `pk_security` |
| Foreign Key | `fk_<table>_<parent>` | `fk_trade_security` |
| Unique Constraint | `uq_<table>_<column>` | `uq_security_symbol` |
| Check Constraint | `ck_<table>_<rule>` | `ck_trade_quantity_positive` |
| Index | `idx_<table>_<column>` | `idx_security_symbol` |
| Trigger | `trg_<table>_<event>` | `trg_trade_audit` |
| Function | `fn_<purpose>` | `fn_calculate_score` |
| Procedure | `sp_<purpose>` | `sp_refresh_market_data` |
| Domain | `dom_<purpose>` | `dom_currency_code` |
| User-defined Type | `typ_<purpose>` | `typ_market_status` |

The naming conventions defined above SHALL be applied consistently
throughout the repository.

---

## 5.3 Object Prefixes

Object prefixes SHALL identify the architectural role of an object
rather than its implementation.

Approved prefixes include:

```
vw_
mv_
seq_
pk_
fk_
uq_
ck_
idx_
trg_
fn_
sp_
dom_
typ_
```

Additional prefixes SHALL require Enterprise Architecture approval.

---

## 5.4 Tables

Business tables SHALL NOT use prefixes.

Correct examples:

```
security

exchange

market

trade

portfolio
```

Incorrect examples:

```
tbl_security

t_security

tb_market

security_tbl
```

Business entities SHALL remain simple and business-oriented.

---

## 5.5 Constraints

Constraint names SHALL clearly identify:

- Constraint type
- Owning table
- Business purpose

Examples:

```
pk_security

fk_trade_security

uq_security_symbol

ck_trade_price_positive
```

Constraint names SHALL remain deterministic.

---

## 5.6 Executable Objects

Functions, Procedures, and Triggers SHALL clearly identify their
purpose.

Examples:

```
fn_calculate_risk

fn_validate_symbol

sp_refresh_market_data

trg_trade_insert
```

Implementation details SHALL NOT appear in object names.

---

## 5.7 Repository Consistency

Equivalent architectural responsibilities SHALL always produce
equivalent naming patterns.

Naming SHALL remain consistent across every schema within the Phoenix
repository.

---

## 5.8 Compliance

Every database object SHALL:

- Follow the approved naming convention.
- Use the correct object prefix.
- Preserve repository consistency.
- Support Enterprise traceability.

---

# 6. Table Naming Rules

## 6.1 Purpose

This section defines the Enterprise naming rules governing database
tables.

Tables SHALL represent business entities using stable business
terminology.

---

## 6.2 Business-oriented Naming

Table names SHALL describe business concepts.

Examples:

```
exchange

market

security

company

trade

portfolio
```

Implementation-oriented names are prohibited.

---

## 6.3 Singular Form

Business tables SHALL use singular nouns.

Correct:

```
security

trade

exchange
```

Incorrect:

```
securities

trades

exchanges
```

---

## 6.4 No Prefixes

Business tables SHALL NOT use technical prefixes.

Incorrect examples:

```
tbl_trade

tb_security

t_market
```

---

## 6.5 Stable Terminology

Equivalent business concepts SHALL always use identical names.

Repository-wide terminology SHALL remain consistent.

---

## 6.6 Business Independence

Table names SHALL identify the business entity only.

Names SHALL NOT describe:

- Storage
- History
- Temporary implementation
- Developer preference

---

## 6.7 Repository Consistency

Business terminology SHALL remain uniform across the repository.

Architectural consistency SHALL always take precedence over local
preferences.

---

## 6.8 Compliance

Every table SHALL:

- Use a singular noun.
- Represent one business entity.
- Avoid prefixes.
- Preserve repository consistency.

---

# 7. Column Naming Rules

## 7.1 Purpose

This section defines the relationship between this document and the
Enterprise Column Naming Standard.

---

## 7.2 Authority

Column naming SHALL be governed by:

**ColumnNamingStandard**

This document establishes enterprise naming principles.

Detailed column naming rules SHALL remain within the dedicated Column
Naming Standard.

---

## 7.3 General Principles

Column names SHALL:

- Use snake_case.
- Use lowercase.
- Express one business meaning.
- Remain stable.
- Support repository consistency.

---

## 7.4 Identifier Columns

Typical identifier columns include:

```
security_id

market_id

exchange_id

company_id
```

Identifier naming SHALL remain consistent throughout the repository.

---

## 7.5 Audit Columns

Audit columns SHALL comply with
AuditColumnDesignStandard.

Examples include:

```
created_at

created_by

updated_at

updated_by

deleted_at
```

---

## 7.6 Foreign Key Columns

Foreign key columns SHALL comply with
ForeignKeyDesignStandard.

Examples:

```
security_id

market_id

exchange_id
```

---

## 7.7 Repository Consistency

Equivalent business attributes SHALL always use identical names.

Repository-wide consistency SHALL be maintained.

---

## 7.8 Compliance

Every column SHALL comply with:

- ColumnNamingStandard
- AuditColumnDesignStandard
- ForeignKeyDesignStandard
- Enterprise naming principles

---

# 8. Constraint Naming Rules

## 8.1 Purpose

This section summarizes Enterprise naming conventions for database
constraints.

Detailed implementation SHALL remain within their corresponding design
standards.

---

## 8.2 Primary Keys

Naming pattern:

```
pk_<table>
```

Example:

```
pk_security
```

---

## 8.3 Foreign Keys

Naming pattern:

```
fk_<table>_<parent>
```

Example:

```
fk_trade_security
```

---

## 8.4 Unique Constraints

Naming pattern:

```
uq_<table>_<column>
```

Example:

```
uq_security_symbol
```

---

## 8.5 Check Constraints

Naming pattern:

```
ck_<table>_<rule>
```

Examples:

```
ck_trade_quantity_positive

ck_price_nonnegative
```

Rule names SHALL remain concise and descriptive.

---

## 8.6 Constraint Stability

Constraint names SHALL remain stable once approved.

Renaming SHALL require Enterprise Architecture approval.

---

## 8.7 Repository Consistency

Constraint naming SHALL remain identical throughout every repository
schema.

---

## 8.8 Compliance

Every constraint SHALL:

- Use the approved prefix.
- Clearly identify its purpose.
- Preserve repository consistency.

---

# 9. View Naming Rules

## 9.1 Purpose

This section defines the Enterprise naming rules governing database
Views within the Phoenix Platform.

View names SHALL clearly distinguish logical read models from base
tables.

---

## 9.2 Naming Convention

Every View SHALL use the following naming pattern:

```
vw_<business_object>
```

Examples:

```
vw_security

vw_market_summary

vw_trade_statistics

vw_portfolio_positions
```

The prefix `vw_` SHALL be reserved exclusively for database Views.

---

## 9.3 Business-oriented Naming

View names SHALL describe the business information exposed rather than
the SQL implementation.

Correct examples:

```
vw_daily_market

vw_company_profile

vw_active_orders
```

Implementation-oriented names are prohibited.

---

## 9.4 Repository Consistency

Equivalent View responsibilities SHALL use identical naming patterns.

Repository-wide consistency SHALL always take precedence over developer
preferences.

---

## 9.5 Relationship with ViewDesignStandard

Detailed View implementation SHALL comply with:

- ViewDesignStandard

This document governs naming only.

---

## 9.6 Versioning

View names SHALL remain stable.

Version numbers SHALL NOT appear in object names.

Incorrect examples:

```
vw_security_v2

vw_market_new

vw_trade_test
```

---

## 9.7 Reserved Prefix

The prefix `vw_` SHALL NOT be used for any object other than database
Views.

---

## 9.8 Compliance

Every View SHALL:

- Use the `vw_` prefix.
- Follow Enterprise naming principles.
- Preserve repository consistency.

---

# 10. Materialized View Naming Rules

## 10.1 Purpose

This section defines the Enterprise naming rules governing
Materialized Views.

Materialized Views SHALL remain clearly distinguishable from ordinary
Views.

---

## 10.2 Naming Convention

Every Materialized View SHALL use:

```
mv_<business_object>
```

Examples:

```
mv_market_statistics

mv_security_scores

mv_portfolio_snapshot

mv_daily_trade_summary
```

---

## 10.3 Architectural Meaning

Materialized View names SHALL identify the business information being
materialized rather than implementation details.

---

## 10.4 Reserved Prefix

The prefix

```
mv_
```

SHALL be reserved exclusively for Materialized Views.

---

## 10.5 Stability

Approved Materialized View names SHALL remain stable throughout the
repository lifecycle.

---

## 10.6 Relationship with MaterializedViewDesignStandard

Detailed Materialized View implementation SHALL comply with:

- MaterializedViewDesignStandard

This document governs naming only.

---

## 10.7 Repository Consistency

Equivalent Materialized Views SHALL use equivalent naming patterns.

---

## 10.8 Compliance

Every Materialized View SHALL:

- Use the `mv_` prefix.
- Preserve architectural clarity.
- Follow Enterprise naming principles.

---

# 11. Stored Program Naming Rules

## 11.1 Purpose

This section defines the Enterprise naming rules governing executable
database objects.

These rules apply to:

- Functions
- Procedures
- Triggers

---

## 11.2 Functions

Functions SHALL use:

```
fn_<purpose>
```

Examples:

```
fn_calculate_score

fn_validate_symbol

fn_generate_checksum

fn_compute_risk
```

Function names SHALL describe behavior.

---

## 11.3 Procedures

Procedures SHALL use:

```
sp_<purpose>
```

Examples:

```
sp_refresh_market_data

sp_close_trading_day

sp_import_exchange_data
```

Procedure names SHALL describe the business or technical operation.

---

## 11.4 Triggers

Triggers SHALL use:

```
trg_<table>_<event>
```

Examples:

```
trg_trade_insert

trg_security_update

trg_company_delete
```

Trigger names SHALL identify:

- Target object
- Trigger purpose

---

## 11.5 Domains

Domains SHALL use:

```
dom_<purpose>
```

Examples:

```
dom_currency_code

dom_market_status

dom_percentage
```

---

## 11.6 User-defined Types

User-defined Types SHALL use:

```
typ_<purpose>
```

Examples:

```
typ_order_status

typ_trade_direction

typ_market_phase
```

---

## 11.7 Repository Consistency

Executable object naming SHALL remain identical throughout every
repository schema.

---

## 11.8 Compliance

Every executable database object SHALL:

- Use the approved prefix.
- Clearly identify its purpose.
- Preserve repository consistency.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies prohibited naming practices.

The anti-patterns defined herein SHALL NOT be used.

---

## 12.2 Hungarian-style Prefixes

The following naming styles are prohibited:

```
tbl_security

tb_trade

t_market

tbl_company
```

Business tables SHALL NOT include technical prefixes.

---

## 12.3 Mixed Case

Mixed-case identifiers are prohibited.

Incorrect examples:

```
SecurityTable

TradeOrder

DailyMarketData
```

Correct examples:

```
security

trade_order

daily_market_data
```

---

## 12.4 Spaces and Special Characters

Object names SHALL NOT contain:

- Spaces
- Hyphens
- Periods
- Special characters

Incorrect examples:

```
market-data

daily market

security.table
```

---

## 12.5 Cryptic Abbreviations

Undocumented abbreviations are prohibited.

Incorrect examples:

```
sec

mkt

cmp

trd
```

Unless formally approved, full business terminology SHALL be used.

---

## 12.6 Temporary Names

Temporary or development names SHALL NOT appear in production.

Examples:

```
test_table

new_security

security_temp

market_backup
```

---

## 12.7 Version Numbers

Version numbers SHALL NOT appear in database object names.

Examples:

```
security_v2

vw_trade_v3

seq_company_v4
```

Versioning belongs in source control, not object names.

---

## 12.8 Compliance

Every implementation SHALL avoid:

- Technical table prefixes.
- Mixed case.
- Reserved words.
- Temporary names.
- Version numbers.
- Undocumented abbreviations.

Repository consistency SHALL always take precedence over local
implementation preferences.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the Enterprise Standard governing the migration,
refactoring, normalization, and retirement of database object names
within the Phoenix Platform.

Migration SHALL preserve repository consistency, architectural
traceability, and consumer compatibility.

---

## 13.2 Migration Principles

Database object renaming SHALL preserve:

- Architectural meaning
- Business terminology
- Repository consistency
- Dependency integrity
- Consumer compatibility
- Documentation traceability

Migration SHALL NOT introduce semantic changes without explicit
Enterprise Architecture approval.

---

## 13.3 Legacy Migration

Legacy database objects MAY contain:

- Mixed-case names
- Technical prefixes
- Inconsistent abbreviations
- Reserved words
- Temporary names
- Non-standard naming conventions

Legacy implementations SHALL be migrated to conform to this standard.

---

## 13.4 Refactoring

Naming refactoring MAY include:

- Naming normalization
- Prefix correction
- Abbreviation removal
- Semantic clarification
- Documentation updates
- Repository alignment

Refactoring SHALL preserve architectural intent.

---

## 13.5 Dependency Validation

Before deployment, every renamed database object SHALL be validated to
ensure:

- Dependency integrity
- Object references remain valid
- SQL compatibility
- Application compatibility
- Repository consistency

Migration SHALL fail if dependency integrity cannot be guaranteed.

---

## 13.6 Repository Alignment

Following migration, every database object SHALL comply with:

- DatabaseObjectNamingStandard
- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- ViewDesignStandard
- MaterializedViewDesignStandard
- SequenceDesignStandard

Repository alignment SHALL be mandatory.

---

## 13.7 Controlled Change

Naming changes SHALL include:

- Version control
- Architecture review
- Dependency assessment
- Repository impact assessment
- Consumer impact assessment

Every change SHALL remain fully traceable.

---

## 13.8 Compliance

Every migration SHALL:

- Preserve semantic clarity.
- Preserve repository consistency.
- Preserve architectural intent.
- Comply with Enterprise governance.

---

# 14. Validation Checklist

## 14.1 Purpose

This checklist SHALL be used during architecture review,
implementation approval, repository audit, SQL validation, and
production certification.

---

## 14.2 General Validation

Verify that:

- Object name follows Enterprise standards.
- Naming is meaningful.
- Naming is stable.
- Naming is repository consistent.

---

## 14.3 Character Validation

Verify that:

- Lowercase characters are used.
- snake_case is used.
- ASCII characters are used.
- Invalid symbols are absent.
- Reserved SQL keywords are avoided.

---

## 14.4 Prefix Validation

Verify that approved prefixes are correctly applied.

| Object | Prefix |
|---------|--------|
| View | `vw_` |
| Materialized View | `mv_` |
| Sequence | `seq_` |
| Primary Key | `pk_` |
| Foreign Key | `fk_` |
| Unique Constraint | `uq_` |
| Check Constraint | `ck_` |
| Index | `idx_` |
| Trigger | `trg_` |
| Function | `fn_` |
| Procedure | `sp_` |
| Domain | `dom_` |
| User-defined Type | `typ_` |

Business tables SHALL NOT use prefixes.

---

## 14.5 Semantic Validation

Verify that:

- Name expresses one architectural concept.
- Business terminology is used.
- Technical implementation details are omitted.
- Ambiguity does not exist.

---

## 14.6 Repository Validation

Verify that:

- Duplicate names do not exist.
- Naming standards are consistently applied.
- Documentation reflects approved names.
- Repository terminology remains consistent.

---

## 14.7 Documentation Validation

Verify that:

- Database object names match documentation.
- ADR references remain valid.
- Logical and Physical Models use identical names.
- Enterprise Data Dictionary remains synchronized.

---

## 14.8 Compliance Checklist

Every database object SHALL satisfy all of the following:

✓ Approved naming convention

✓ Correct prefix

✓ Lowercase

✓ snake_case

✓ Semantic clarity

✓ Repository consistency

✓ Documentation synchronization

✓ Enterprise Architecture approval

No database object SHALL be approved unless every applicable validation
requirement has been successfully satisfied.

---

# 15. Repository Rules

## 15.1 Repository-wide Consistency

Every database object SHALL follow identical naming principles
throughout every Phoenix repository schema.

Equivalent architectural concepts SHALL always use identical names.

---

## 15.2 Naming Authority

This document SHALL serve as the authoritative naming standard for all
database objects.

Object-specific standards SHALL inherit these naming principles.

Conflicting naming conventions are prohibited.

---

## 15.3 Relationship with Other Standards

This document SHALL be used together with:

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard
- IndexDesignStandard
- SequenceDesignStandard
- ViewDesignStandard
- MaterializedViewDesignStandard

This document governs naming only.

Implementation SHALL remain governed by the corresponding object
standards.

---

## 15.4 Mandatory Documentation

Every database object SHALL be traceable to:

- Business Requirement
- Architecture Decision Record (ADR)
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- DDL Script

Undocumented database objects are prohibited.

---

## 15.5 Repository Governance

Database object naming SHALL remain under Enterprise Architecture
governance.

Repository-wide consistency SHALL always take precedence over local
implementation preferences.

---

## 15.6 DDL Compliance

All DDL scripts SHALL use approved object names.

Naming SHALL remain identical across:

- DDL
- Documentation
- Database implementation
- Source code
- Repository artifacts

---

## 15.7 Repository Certification

Repository certification SHALL verify:

- Naming consistency
- Semantic consistency
- Architectural consistency
- Documentation consistency
- Repository integrity

---

## 15.8 Compliance

Repository compliance with this standard is mandatory.

---

# 16. Architecture Rules

## 16.1 Enterprise Principle

Naming SHALL be considered part of Enterprise Architecture.

Database object names SHALL communicate architectural intent rather than
implementation detail.

---

## 16.2 Single Meaning Principle

Each approved database object name SHALL represent exactly one
architectural concept.

A single name SHALL NEVER represent multiple meanings.

Likewise, multiple names SHALL NOT represent the same architectural
concept unless explicitly approved.

---

## 16.3 Business-driven Terminology

Business terminology SHALL take precedence over technical terminology
whenever appropriate.

Database names SHALL reflect the enterprise domain language defined by
the Domain Model and Enterprise Data Dictionary.

---

## 16.4 Naming Stability

Approved names SHALL remain stable throughout the repository lifecycle.

Renaming SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Documentation update

---

## 16.5 Architectural Consistency

Equivalent architectural responsibilities SHALL always produce
equivalent naming conventions.

Consistency SHALL extend across:

- Schemas
- SQL scripts
- Documentation
- Source code
- Automation

---

## 16.6 Architecture Freeze

Once approved, Enterprise database naming SHALL be considered
architecturally frozen.

Changes SHALL require formal governance approval.

---

## 16.7 Repository Integrity

Repository-wide naming consistency SHALL always take precedence over
individual implementation preferences.

Enterprise Architecture SHALL remain the governing authority.

---

## 16.8 Compliance

Every database object SHALL comply with:

- Enterprise Architecture
- Approved ADRs
- Repository Governance
- This standard

Compliance is mandatory.

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative documents governing the
naming of database objects within the Phoenix Platform.

Only the documents referenced herein SHALL be considered normative.

---

## 17.2 Normative References

The following standards SHALL be complied with when naming database
objects.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| ColumnNamingStandard | Column naming conventions |
| PrimaryKeyDesignStandard | Primary key naming |
| ForeignKeyDesignStandard | Foreign key naming |
| UniqueConstraintDesignStandard | Unique constraint naming |
| CheckConstraintDesignStandard | Check constraint naming |
| IndexDesignStandard | Index naming |
| ViewDesignStandard | View naming |
| MaterializedViewDesignStandard | Materialized View naming |
| SequenceDesignStandard | Sequence naming |
| DDLTemplateSpecification | Canonical SQL implementation |
| PostgreSQL Design Decisions | PostgreSQL implementation guidance |
| PhysicalDatabaseModel | Physical database architecture |

---

## 17.3 Related Standards

The following standards complement this document.

| Document | Relationship |
|----------|--------------|
| ReferenceTableDesignStandard | Reference table implementation |
| MasterEntityDesignStandard | Master entity implementation |
| BridgeTableDesignStandard | Bridge table implementation |
| TransactionTableDesignStandard | Transaction table implementation |
| EventTableDesignStandard | Event table implementation |
| FactTableDesignStandard | Fact table implementation |
| LogicalDatabaseModel | Logical architecture |
| EnterpriseDataDictionary | Business terminology |
| ADR Repository | Architectural decisions |

---

## 17.4 Related Architecture Artifacts

Every approved database object name SHOULD be traceable to one or more
of the following architecture artifacts:

- Business Requirements
- Business Process Models
- Architecture Decision Records (ADRs)
- Domain Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- DDL Scripts
- Source Code Repository

Naming SHALL always originate from approved architectural artifacts.

---

## 17.5 Governance

Where conflicts exist between this document and another naming
convention, the Enterprise Governance Framework SHALL determine
precedence.

Approved Architecture Decision Records SHALL override implementation
guidance whenever an explicit architectural decision exists.

---

## 17.6 Single Source of Truth

This document SHALL remain the single authoritative standard governing
database object naming throughout the Phoenix Platform.

All object-specific naming standards SHALL inherit their naming rules
from this document.

No document SHALL redefine enterprise naming principles.

---

## 17.7 Repository Compliance

Every database object implemented within the Phoenix Platform SHALL
comply with this standard.

Compliance SHALL be verified during:

- Enterprise Architecture Review
- Repository Audit
- Database Review
- Production Release Approval

---

## 17.8 Traceability

Every approved database object name SHOULD remain traceable throughout
the following chain:

Business Requirement

↓

Business Process

↓

Architecture Decision Record (ADR)

↓

Domain Model

↓

Logical Database Model

↓

Physical Database Model

↓

DDL Script

↓

Database Object

↓

Application

↓

Repository Documentation

Complete traceability SHALL be maintained throughout the repository
lifecycle.

---

# 18. Revision History

## 18.1 Purpose

This section records the lifecycle and revision history of the
Enterprise Database Object Naming Standard.

Every approved modification SHALL be documented to preserve
architectural traceability and repository governance.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Database Object Naming Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this document SHALL be managed under the Enterprise
Governance Framework.

Every proposed change SHALL include:

- Business justification
- Architecture impact assessment
- Repository impact assessment
- Dependency assessment
- Documentation assessment
- Version increment
- Formal approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing database object names SHALL include a
repository-wide compatibility assessment.

Migration activities SHALL preserve:

- Architectural meaning
- Business terminology
- Repository consistency
- Dependency integrity
- Documentation consistency

Backward compatibility SHALL be evaluated before implementation.

---

## 18.5 Architecture Freeze

Once approved, the Enterprise Database Naming Architecture SHALL be
considered architecturally frozen.

Changes SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Documentation synchronization
- Version update

Architectural stability SHALL take precedence over implementation
convenience.

---

## 18.6 Repository Compliance

All database object names, SQL scripts, deployment artifacts,
documentation, models, and future implementations SHALL comply with the
latest approved version of this standard.

Legacy implementations SHALL be aligned through controlled migration
activities where required.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Requests for clarification, modification, exception, or extension SHALL
be submitted through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative standard governing the naming
of database objects within the Phoenix Platform.

Every database object SHALL remain:

- Architecture-driven
- Business-oriented
- Technically precise
- Semantically unambiguous
- Repository-consistent
- Fully traceable
- Governed by Enterprise Architecture

Database object names SHALL communicate architectural intent rather than
implementation details.

Consistent naming SHALL improve readability, maintainability,
automation, interoperability, repository governance, and long-term
evolution of the Phoenix Platform.

All object-specific naming standards—including those governing columns,
constraints, indexes, sequences, views, materialized views, and future
database objects—SHALL inherit their naming principles from this
Enterprise Database Object Naming Standard.

Repository-wide naming consistency SHALL remain a fundamental
architectural principle of the Phoenix Platform and SHALL be preserved
throughout the entire system lifecycle.

---

## End of Document