# DDL Template Specification

---

# 1. Document Information

| Item | Value |
|------|-------|
| Document | DDL Template Specification |
| Layer | Physical Database Design |
| Directory | Architecture/Solution/Data/PhysicalDesign |
| Version | 2026.1 |
| Status | Approved |
| Owner | Database Architecture |
| Audience | Enterprise Architects, Solution Architects, Database Architects, Database Developers, Backend Developers |
| Database Platform | PostgreSQL 17 |
| Classification | Canonical Physical Database Design Artifact |
| Last Updated | 2026-07-24 |

---

# 2. Purpose

This document defines the canonical template used for generating every PostgreSQL Database Definition Language (DDL) script within the Phoenix Platform.

Its primary objective is to establish a single enterprise-wide specification for the structure, organization, formatting, documentation, and implementation of SQL scripts.

The template eliminates implementation ambiguity by ensuring that every DDL artifact follows an identical architecture-driven format regardless of the database object being created.

This document serves as the authoritative source for DDL script generation.

---

# 3. Scope

This specification applies to every SQL script created under the Phoenix database implementation repository.

The scope includes:

- Table creation scripts
- Constraint scripts
- Index scripts
- View scripts
- Materialized View scripts
- Sequence scripts
- Function scripts
- Trigger scripts
- Domain scripts
- Enumeration scripts
- Extension scripts
- Future PostgreSQL database objects

Every database implementation artifact shall conform to the template defined in this document.

---

# 4. Objectives

The objectives of this specification are to:

- standardize every DDL script;
- eliminate formatting inconsistencies;
- simplify repository maintenance;
- support deterministic DDL generation;
- preserve architectural traceability;
- improve readability;
- improve code review quality;
- simplify automated generation;
- simplify automated validation;
- support long-term maintainability.

---

# 5. Architecture Position

The DDL Template Specification occupies the final architectural layer before executable SQL generation.

Its responsibility is to translate approved Physical Database Design specifications into standardized implementation templates.

The architectural flow is:

```text
Business Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
PostgreSQL Physical Database Design
        │
        ▼
PostgreSQL Design Decisions
        │
        ▼
Table Physical Specifications
        │
        ▼
Constraint Specifications
        │
        ▼
DDL Template Specification
        │
        ▼
Generated DDL Scripts
        │
        ▼
Database Deployment
```

The DDL Template Specification defines **how SQL scripts are organized**.

It does not define business semantics or database design decisions.

---

# 6. Relationship to Physical Design Documents

The DDL Template Specification complements the remaining Physical Design artifacts.

| Document | Responsibility |
|----------|----------------|
| PostgreSQLPhysicalDatabaseDesign.md | Overall PostgreSQL architecture |
| PostgreSQLDesignDecisions.md | PostgreSQL implementation decisions |
| TablePhysicalSpecifications.md | Physical table definitions |
| ConstraintSpecifications.md | Constraint implementation |
| DDLTemplateSpecification.md | SQL script template and organization |

Each document owns a separate architectural responsibility.

No duplication of responsibilities shall exist between Physical Design artifacts.

---

# 7. Repository Position

The DDL Template Specification is maintained within the canonical Physical Design directory.

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
            ├── README.md
            ├── PostgreSQLPhysicalDatabaseDesign.md
            ├── PostgreSQLDesignDecisions.md
            ├── TablePhysicalSpecifications.md
            ├── ConstraintSpecifications.md
            └── DDLTemplateSpecification.md
```

The generated SQL scripts reside under:

```text
Data/
└── Database/
    └── DDL/
        ├── Tables/
        ├── Constraints/
        ├── Indexes/
        ├── Views/
        ├── Functions/
        ├── Triggers/
        └── Sequences/
```

The Physical Design layer specifies implementation.

The DDL layer implements the specification.

---

# 8. Intended Audience

This specification is intended for:

- Enterprise Architects
- Solution Architects
- Database Architects
- PostgreSQL Developers
- Backend Developers
- Database Administrators
- DevOps Engineers
- Repository Maintainers

All contributors responsible for creating or reviewing SQL implementation artifacts shall comply with this specification.

---

# 9. Design Philosophy

DDL scripts are implementation artifacts generated from architecture.

They are **not handwritten software components**.

Accordingly, every script shall be:

- architecture-driven;
- deterministic;
- repeatable;
- traceable;
- readable;
- standardized;
- implementation-oriented.

No implementation decision shall originate during SQL development.

All implementation decisions shall originate from approved Physical Design documents.

---

# 10. Guiding Principles

Every DDL script generated for the Phoenix Platform shall comply with the following principles.

1. Follow approved enterprise architecture.
2. Preserve business semantics.
3. Be deterministic.
4. Be fully traceable.
5. Follow Enterprise Naming Standards.
6. Follow Enterprise Database Standards.
7. Be PostgreSQL optimized.
8. Support automated generation.
9. Support automated validation.
10. Maintain repository-wide consistency.

---

# 11. DDL Generation Philosophy

The Phoenix Platform adopts an **Architecture-Driven Database Development** methodology.

Under this methodology, Database Definition Language (DDL) scripts are implementation artifacts generated from approved architectural specifications.

DDL scripts shall never become the source of architectural truth.

Instead, they represent the final executable realization of the Physical Database Design.

The architectural ownership remains within the Physical Design layer.

---

# 12. Architectural Principles

Every generated DDL script shall comply with the following architectural principles.

## 12.1 Architecture First

Architecture precedes implementation.

Database implementation shall always follow approved architecture.

---

## 12.2 Single Source of Truth

Every implementation decision shall originate from exactly one approved architectural artifact.

Multiple conflicting implementation sources are prohibited.

---

## 12.3 Deterministic Generation

Identical Physical Design specifications shall always produce identical DDL scripts.

Manual interpretation during script development is prohibited.

---

## 12.4 Repository Consistency

Equivalent database objects shall always be implemented using equivalent script structures.

Repository-wide consistency has priority over individual developer preference.

---

## 12.5 Technology Isolation

Business semantics shall remain independent of PostgreSQL implementation details.

Technology-specific implementation belongs exclusively to the Physical Design layer.

---

# 13. DDL Generation Workflow

The recommended implementation workflow is:

```text
Business Requirement
        │
        ▼
Business Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
Physical Design
        │
        ▼
DDL Template
        │
        ▼
Generated SQL
        │
        ▼
Deployment
```

Every DDL artifact shall be generated only after completion of the preceding architectural layers.

---

# 14. Repository Responsibilities

The repository separates architectural specifications from executable SQL.

| Repository Area | Responsibility |
|-----------------|----------------|
| Architecture/Solution/Data/PhysicalDesign | Physical implementation specifications |
| Data/Database/DDL | Executable SQL |
| Data/Database/DML | Data loading |
| Data/Database/Migrations | Schema evolution |
| Data/Database/Validation | Validation scripts |

Responsibilities shall never overlap.

---

# 15. Script Categories

The Phoenix Platform classifies DDL scripts into distinct implementation categories.

```text
Tables

Constraints

Indexes

Views

Materialized Views

Sequences

Functions

Procedures

Triggers

Domains

Enumerations

Extensions
```

Each category follows the template defined within this specification.

---

# 16. Template Objectives

The DDL template has several objectives.

It shall:

- standardize every SQL script;
- simplify repository navigation;
- support automated generation;
- support automated formatting;
- improve readability;
- improve review quality;
- reduce implementation errors;
- simplify future maintenance.

---

# 17. Standard Script Lifecycle

Every DDL script progresses through the following lifecycle.

```text
Architectural Specification

↓

Template Generation

↓

SQL Validation

↓

Repository Review

↓

Deployment

↓

Maintenance
```

Every revision shall preserve backward traceability.

---

# 18. DDL Artifact Classification

Every generated SQL artifact belongs to one of three implementation layers.

| Layer | Purpose |
|--------|---------|
| Core Objects | Tables, Domains, Sequences |
| Structural Objects | Constraints, Indexes |
| Behavioral Objects | Functions, Triggers, Procedures |

This classification simplifies deployment planning and dependency management.

---

# 19. Canonical Generation Rules

The following rules apply to every generated SQL artifact.

### Rule 1

Every script shall implement exactly one database object.

---

### Rule 2

Every script shall be independently understandable.

---

### Rule 3

Every script shall be traceable to one architectural specification.

---

### Rule 4

Every script shall use the approved DDL template.

---

### Rule 5

Every script shall remain idempotent whenever technically feasible.

---

### Rule 6

Every script shall follow Enterprise Naming Standards.

---

### Rule 7

Every script shall comply with PostgreSQL 17.

---

### Rule 8

Every script shall preserve implementation consistency across the repository.

---

# 20. Template Ownership

The DDL Template Specification is owned by the Database Architecture discipline.

Changes to this template require architectural approval before affecting generated SQL.

Individual SQL files shall never redefine template rules.

Template evolution shall occur only through controlled updates to this specification.

---

# 21. General File Structure

Every DDL script shall follow an identical physical structure.

The objective is to ensure consistency, readability, maintainability, and deterministic generation throughout the repository.

The canonical structure is:

```text
Documentation Header

↓

CREATE Object Statement

↓

Primary Keys

↓

Alternate Keys

↓

CHECK Constraints

↓

Foreign Keys

↓

Indexes

↓

Table Comment

↓

Column Comments

↓

Optional Future Sections
```

The order of these sections shall never be modified.

---

# 22. File Naming Standard

Every SQL file shall use lowercase names.

Words shall be separated using underscores.

The repository shall not use CamelCase, PascalCase, or mixed-case filenames.

Examples

```text
exchange.sql

market.sql

trading_board.sql

sector.sql

industry.sql

company.sql

instrument.sql

instrument_listing.sql

trading_calendar.sql

daily_market_data.sql

corporate_action.sql

external_identifier.sql
```

File names shall describe the implemented object rather than the implementation action.

For example:

Preferred

```text
exchange.sql
```

Not Recommended

```text
CreateExchange.sql

010_CreateExchange.sql
```

---

# 23. Header Specification

Every DDL script shall begin with a standardized documentation header.

The header provides architectural traceability, implementation metadata, and repository consistency.

The header shall be implemented as a SQL block comment.

Example structure:

```text
Project

Script

Category

Object Type

Object Name

Schema

Version

Status

Description

Dependencies

Standards

Author

Created

Revision History
```

Every header shall contain identical sections in the same order.

---

## 23.1 Project

```text
Phoenix Platform
```

---

## 23.2 Script

The script field identifies the file name.

Example

```text
exchange.sql
```

---

## 23.3 Category

Example

```text
Database Definition Language (DDL)
```

---

## 23.4 Object Type

Examples

```text
Table

Index

View

Function

Trigger

Sequence
```

---

## 23.5 Object Name

Example

```text
Exchange
```

This value represents the business object rather than the file name.

---

## 23.6 Schema

Example

```text
market
```

---

## 23.7 Version

Example

```text
2026.1
```

Version numbering shall follow repository release conventions.

---

## 23.8 Status

Typical values include:

```text
Draft

Review

Approved

Deprecated
```

---

## 23.9 Description

The description shall briefly explain:

- what the object is;
- why it exists;
- what architectural role it performs.

Descriptions shall remain concise.

---

## 23.10 Dependencies

Dependencies shall list prerequisite database objects.

Examples

```text
None

Exchange

Market

Company

Instrument
```

---

## 23.11 Standards

Every script shall identify the architectural standards that govern its implementation.

Typical references include:

```text
Enterprise Naming Standard

Enterprise Database Design Standard

PostgreSQL Physical Database Design

Table Physical Specifications

Constraint Specifications

DDL Template Specification
```

---

## 23.12 Author

Example

```text
Phoenix Architecture Team
```

Individual developer names shall not be used.

---

## 23.13 Created

Creation dates shall follow ISO 8601.

Example

```text
2026-07-24
```

---

## 23.14 Revision History

Every DDL script shall include a revision history table.

Example

```text
Version

Date

Description
```

Every structural modification shall update this section.

---

# 24. SQL Formatting Rules

The Phoenix Platform adopts a single SQL formatting standard.

Formatting consistency improves readability and enables deterministic script generation.

---

## 24.1 SQL Keywords

SQL keywords shall always be uppercase.

Example

```sql
CREATE TABLE

PRIMARY KEY

FOREIGN KEY

CHECK

REFERENCES

DEFAULT

COMMENT ON
```

---

## 24.2 Object Names

Database object names shall always be lowercase.

Examples

```sql
market.exchange

market.company

market.instrument
```

---

## 24.3 Indentation

Indentation shall use four spaces.

Tab characters shall never be used.

---

## 24.4 Column Alignment

Every column definition shall appear on a separate line.

Example

```sql
id                  BIGINT GENERATED ALWAYS AS IDENTITY,

public_id           UUID NOT NULL,

code                VARCHAR(20) NOT NULL
```

Column names shall be vertically aligned for readability.

---

## 24.5 Constraint Alignment

Constraint definitions shall appear after all column definitions.

Each constraint shall begin on a new line.

Example

```sql
CONSTRAINT pk_exchange
PRIMARY KEY (id)
```

---

## 24.6 Blank Lines

Blank lines shall separate logical sections only.

Excessive blank lines are prohibited.

---

## 24.7 Line Length

Lines should remain reasonably short to improve readability.

Where necessary, expressions shall wrap onto multiple lines.

---

## 24.8 Comments

SQL comments shall be meaningful and concise.

Section separators shall use a consistent format.

Example

```sql
------------------------------------------------------------------------------
-- Audit Columns
------------------------------------------------------------------------------
```

---

## 24.9 Statement Termination

Every SQL statement shall terminate with:

```sql
;
```

No exceptions are permitted.

---

## 24.10 Character Encoding

All SQL scripts shall be stored using:

```text
UTF-8
```

without a Byte Order Mark (BOM), ensuring consistent behavior across PostgreSQL tools and version control systems.

---

# 25. CREATE TABLE Template

Every table within the Phoenix Platform shall follow a single canonical CREATE TABLE template.

The purpose of this template is to guarantee that every table is implemented consistently regardless of its business purpose.

The template shall be used for all tables without exception.

---

## 25.1 Canonical Table Structure

Every CREATE TABLE statement shall follow the exact order shown below.

```text
CREATE TABLE

↓

Identity Column

↓

Public Identifier

↓

Business Columns

↓

Relationship Columns

↓

Business Status

↓

Audit Columns

↓

Version / Metadata Columns (if applicable)

↓

Constraints

↓

Table Options
```

The order shall never be changed.

---

## 25.2 General Syntax

Every table shall begin with:

```sql
CREATE TABLE <schema>.<table_name>
(
    ...
);
```

The schema shall always be explicitly specified.

---

## 25.3 Table Naming

Table names shall:

- use lowercase letters;
- use snake_case;
- describe business entities;
- remain singular.

Examples

```text
exchange

market

company

instrument

daily_market_data
```

Plural table names shall not be used.

---

## 25.4 Schema Naming

Schema names shall follow Enterprise Naming Standards.

Examples

```text
market

trading

reference

system
```

Every table shall belong to exactly one schema.

---

# 26. Column Ordering Rules

Column order shall be identical across the entire repository.

Consistent ordering improves readability and simplifies automated generation.

---

## 26.1 Standard Order

```text
Identity

↓

Public Identifier

↓

Business Attributes

↓

Reference Columns

↓

Status Columns

↓

Audit Columns

↓

Optional Metadata
```

---

## 26.2 Identity Column

The identity column shall always appear first.

Example

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

---

## 26.3 Public Identifier

The public identifier shall appear immediately after the internal identifier.

Example

```sql
public_id UUID NOT NULL
```

---

## 26.4 Business Attributes

Business attributes shall follow the public identifier.

Typical examples include:

```text
code

name

description

symbol

display_order
```

---

## 26.5 Reference Columns

Foreign Key columns shall appear after business attributes.

Examples

```text
exchange_id

market_id

company_id
```

---

## 26.6 Status Columns

Status information shall appear after reference columns.

Examples

```text
is_active

status

effective_from

effective_to
```

---

## 26.7 Audit Columns

Audit columns shall appear after business data.

Standard order:

```text
created_at

created_by

updated_at

updated_by
```

---

## 26.8 Optional Metadata

Implementation-specific metadata shall appear last.

Only architecturally approved metadata columns are permitted.

---

# 27. Identity Column Rules

The Phoenix Platform adopts surrogate keys for every business entity.

---

## 27.1 Standard Definition

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

This definition shall be used unless an approved architectural exception exists.

---

## 27.2 Identity Strategy

The platform uses PostgreSQL Identity Columns.

Legacy SERIAL and BIGSERIAL implementations shall not be used.

---

## 27.3 Naming

Every identity column shall be named:

```text
id
```

Entity-specific identifiers such as:

```text
exchange_id

company_id

instrument_id
```

shall not be used as Primary Keys.

They may only appear as Foreign Keys.

---

## 27.4 Primary Key Relationship

The identity column shall always become the Primary Key.

Example

```sql
CONSTRAINT pk_exchange
PRIMARY KEY (id)
```

---

# 28. Audit Column Rules

Audit columns provide standardized change tracking throughout the repository.

Every operational table shall implement the approved audit model.

---

## 28.1 Standard Audit Columns

The canonical audit columns are:

```text
created_at

created_by

updated_at

updated_by
```

---

## 28.2 Data Types

Recommended PostgreSQL data types:

```sql
created_at    TIMESTAMPTZ

created_by    BIGINT

updated_at    TIMESTAMPTZ

updated_by    BIGINT
```

---

## 28.3 Default Values

Example

```sql
created_at
DEFAULT CURRENT_TIMESTAMP
```

Additional defaults shall follow the Physical Design specifications.

---

## 28.4 Ordering

Audit columns shall always appear in the following order.

```text
created_at

created_by

updated_at

updated_by
```

---

# 29. Generated Column Rules

Generated columns shall be used only when:

- values are deterministic;
- expressions are immutable;
- calculation improves maintainability.

---

## 29.1 PostgreSQL Syntax

Example

```sql
display_name
TEXT GENERATED ALWAYS AS
(
    code || ' - ' || name
)
STORED
```

---

## 29.2 Restrictions

Generated columns shall not:

- reference other tables;
- use non-deterministic functions;
- replace business logic.

---

## 29.3 Placement

Generated columns shall appear immediately before the constraint section.

---

## 29.4 Documentation

Every generated column shall include:

- implementation rationale;
- generation expression;
- business purpose;
- associated comments.

Generated columns shall always be documented within the corresponding Physical Design specification before being implemented in DDL.

---

# 30. Constraint Template

Every table shall define constraints using a standardized template.

Constraint definitions shall appear immediately after all column definitions.

The order of constraint declaration is mandatory.

```text
Primary Key

↓

Alternate Keys

↓

CHECK Constraints

↓

Foreign Keys
```

No deviation from this ordering is permitted.

---

## 30.1 Primary Key Template

Every table shall define exactly one Primary Key.

Template

```sql
CONSTRAINT pk_<table_name>
PRIMARY KEY (id)
```

Example

```sql
CONSTRAINT pk_exchange
PRIMARY KEY (id)
```

---

## 30.2 Alternate Key Template

Business uniqueness shall be enforced through UNIQUE constraints.

Template

```sql
CONSTRAINT uk_<table>_<business_identifier>
UNIQUE (<column>)
```

Example

```sql
CONSTRAINT uk_exchange_code
UNIQUE (code)
```

Composite Alternate Keys shall follow the same naming convention.

---

## 30.3 CHECK Constraint Template

Template

```sql
CONSTRAINT ck_<table>_<rule>
CHECK
(
    ...
)
```

Example

```sql
CONSTRAINT ck_exchange_code
CHECK
(
    code <> ''
)
```

---

## 30.4 Foreign Key Template

Template

```sql
CONSTRAINT fk_<child_table>_<parent_table>

FOREIGN KEY (<column>)

REFERENCES <schema>.<parent_table>(id)

ON UPDATE RESTRICT

ON DELETE RESTRICT
```

Example

```sql
CONSTRAINT fk_market_exchange

FOREIGN KEY (exchange_id)

REFERENCES market.exchange(id)

ON UPDATE RESTRICT

ON DELETE RESTRICT
```

---

## 30.5 Constraint Section Layout

The constraint section shall remain visually separated from the column section.

Example

```sql
------------------------------------------------------------------------------
-- Constraints
------------------------------------------------------------------------------
```

This separator shall be used consistently throughout the repository.

---

# 31. Index Template

Indexes shall never be embedded inside CREATE TABLE statements.

Indexes shall always be created using independent CREATE INDEX statements.

---

## 31.1 Ordering

Indexes shall appear after table creation.

Recommended order:

```text
Primary Key Index

↓

Alternate Key Indexes

↓

Foreign Key Indexes

↓

Search Indexes

↓

Performance Indexes
```

---

## 31.2 Index Naming

Naming convention:

```text
ix_<table>_<column>

ix_<table>_<column1>_<column2>
```

Examples

```text
ix_company_name

ix_market_exchange

ix_instrument_symbol

ix_daily_market_data_trade_date
```

---

## 31.3 SQL Template

```sql
CREATE INDEX ix_market_exchange

ON market.market

(
    exchange_id
);
```

---

## 31.4 Composite Indexes

Composite indexes shall preserve column order defined within the Physical Design.

Example

```sql
CREATE INDEX ix_daily_market_data_instrument_date

ON market.daily_market_data
(
    instrument_id,
    trade_date
);
```

---

# 32. COMMENT Template

Documentation is considered part of the implementation.

Every database object shall be documented using PostgreSQL COMMENT statements.

---

## 32.1 Table Comment

Every table shall contain exactly one table comment.

Template

```sql
COMMENT ON TABLE market.exchange

IS '...';
```

---

## 32.2 Column Comments

Every business column shall contain a descriptive comment.

Template

```sql
COMMENT ON COLUMN market.exchange.code

IS 'Business identifier of the exchange.';
```

---

## 32.3 Comment Requirements

Comments shall:

- describe business meaning;
- avoid implementation details;
- remain concise;
- remain architecture consistent.

---

## 32.4 Comment Ordering

Comments shall appear in the following order.

```text
Table Comment

↓

Column Comments
```

---

## 32.5 Unsupported Comments

The following shall not be documented through COMMENT statements:

- implementation notes;
- TODO items;
- developer reminders;
- deployment instructions.

These belong in repository documentation rather than SQL scripts.

---

# 33. Storage Parameters

Storage parameters shall only be specified when explicitly required.

The default PostgreSQL configuration shall be preferred.

---

## 33.1 General Rule

Unless documented otherwise:

```text
No storage parameters shall be specified.
```

---

## 33.2 Fillfactor

FILLFACTOR may be configured only after performance analysis.

Example

```sql
WITH
(
    fillfactor = 90
)
```

---

## 33.3 TOAST

TOAST configuration shall remain at PostgreSQL defaults unless justified by measurable performance requirements.

---

## 33.4 Tablespaces

Tablespaces shall not be specified unless approved by the Database Architect.

Repository portability has priority over installation-specific optimization.

---

# 34. Partition Template

Partitioning shall only be implemented for architecturally approved tables.

---

## 34.1 Partition Strategy

The partition strategy shall be documented within:

```text
PartitionStrategy.md
```

The DDL template merely defines implementation syntax.

---

## 34.2 PostgreSQL Template

Example

```sql
CREATE TABLE market.daily_market_data
(
    ...
)
PARTITION BY RANGE
(
    trade_date
);
```

---

## 34.3 Child Partitions

Child partitions shall be created using separate SQL scripts.

Partition creation shall never be embedded within the parent table script.

---

## 34.4 Naming Convention

Parent

```text
daily_market_data
```

Children

```text
daily_market_data_2026

daily_market_data_2027
```

The partition naming convention shall remain deterministic across all repositories.

---

# 35. ALTER TABLE Rules

ALTER TABLE statements shall be used only when modification of an existing database object is required.

Initial object creation shall always be performed using CREATE statements.

ALTER TABLE shall never be used as a substitute for proper object definition.

---

## 35.1 Approved Usage

ALTER TABLE may be used for:

- adding constraints;
- dropping constraints;
- renaming objects;
- adding columns;
- modifying columns;
- changing ownership.

---

## 35.2 Prohibited Usage

ALTER TABLE shall not be used for:

- reorganizing column order;
- implementing business logic;
- bypassing Physical Design specifications;
- introducing undocumented objects.

---

## 35.3 Statement Organization

Each ALTER TABLE statement shall modify a single logical concern.

Preferred

```sql
ALTER TABLE market.company
ADD CONSTRAINT fk_company_industry
FOREIGN KEY (industry_id)
REFERENCES market.industry(id);
```

Avoid combining unrelated changes within a single statement.

---

## 35.4 Traceability

Every ALTER TABLE statement shall be traceable to:

- Physical Design;
- Architecture Decision Records (when applicable);
- repository revision history.

---

# 36. CREATE INDEX Rules

Indexes shall be created independently from table definitions.

This separation improves readability, deployment flexibility, and future maintenance.

---

## 36.1 General Rule

Every CREATE INDEX statement shall implement exactly one index.

---

## 36.2 Index Ordering

Indexes shall be generated after all required constraints have been created.

Recommended sequence:

```text
Primary Keys

↓

Unique Constraints

↓

Foreign Keys

↓

Indexes
```

---

## 36.3 SQL Template

```sql
CREATE INDEX ix_company_name

ON market.company
(
    name
);
```

---

## 36.4 Concurrent Index Creation

When required for production deployments:

```sql
CREATE INDEX CONCURRENTLY ...
```

may be used.

This decision shall be documented within deployment procedures rather than within Physical Design.

---

## 36.5 Partial Indexes

Partial indexes shall only be implemented after documented performance analysis.

Example

```sql
CREATE INDEX ix_company_active

ON market.company
(
    name
)

WHERE is_active = TRUE;
```

---

## 36.6 Expression Indexes

Expression indexes require explicit architectural approval.

Example

```sql
CREATE INDEX ix_company_lower_name

ON market.company
(
    LOWER(name)
);
```

---

# 37. Dependency Rules

DDL generation shall respect object dependencies.

Objects shall always be created in dependency order.

---

## 37.1 Recommended Deployment Order

```text
Schemas

↓

Domains

↓

Sequences

↓

Tables

↓

Primary Keys

↓

Alternate Keys

↓

CHECK Constraints

↓

Foreign Keys

↓

Indexes

↓

Views

↓

Materialized Views

↓

Functions

↓

Triggers
```

---

## 37.2 Circular Dependencies

Circular dependencies shall be avoided whenever possible.

When unavoidable, deferred constraint creation shall be used.

---

## 37.3 Object Independence

Every SQL script shall minimize unnecessary dependencies.

Scripts shall remain deployable within their dependency level.

---

# 38. Idempotency Rules

Whenever technically feasible, DDL scripts shall support repeatable execution.

---

## 38.1 General Principle

Scripts should avoid generating errors when executed multiple times.

---

## 38.2 Supported PostgreSQL Syntax

Examples

```sql
CREATE SCHEMA IF NOT EXISTS market;
```

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

---

## 38.3 Unsupported Cases

Where PostgreSQL does not support idempotent syntax, deployment tooling shall manage execution order.

Implementation shall remain deterministic.

---

# 39. Versioning Rules

Every SQL artifact shall participate in repository version control.

---

## 39.1 Document Version

Each script shall include:

```text
Version

Status

Revision History
```

within its documentation header.

---

## 39.2 Repository Version

SQL artifacts shall be versioned using Git.

Repository history constitutes the authoritative implementation history.

---

## 39.3 Script Evolution

Structural changes shall update:

- Revision History;
- associated Physical Design documents;
- related architectural specifications.

Synchronization between architecture and implementation is mandatory.

---

# 40. Validation Rules

Every generated DDL script shall undergo architectural and technical validation before acceptance.

---

## 40.1 Architecture Validation

Validation confirms:

- compliance with Physical Design;
- naming standards;
- repository structure;
- implementation rules.

---

## 40.2 SQL Validation

Validation confirms:

- syntax correctness;
- PostgreSQL compatibility;
- dependency correctness;
- object completeness.

---

## 40.3 Repository Validation

Repository validation confirms:

- correct directory placement;
- file naming compliance;
- documentation completeness;
- version consistency.

No SQL artifact shall be merged into the repository until all validation stages have successfully completed.

---

# 41. Traceability

Every DDL artifact shall remain fully traceable to the architectural specifications from which it was generated.

Traceability ensures that every executable SQL statement can be linked back to its originating business requirement and architectural decision.

No implementation artifact shall exist without architectural traceability.

---

## 41.1 Traceability Chain

Every generated DDL script shall participate in the following traceability chain.

```text
Business Requirement
        │
        ▼
Business Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
Physical Design Specifications
        │
        ▼
DDL Template Specification
        │
        ▼
Generated SQL Script
        │
        ▼
Database Deployment
```

Each layer provides the authoritative input for the next layer.

---

## 41.2 Physical Design Mapping

Every SQL artifact shall reference the Physical Design document from which it was generated.

Examples include:

| SQL Artifact | Source Specification |
|--------------|----------------------|
| exchange.sql | TablePhysicalSpecifications.md |
| market.sql | TablePhysicalSpecifications.md |
| company.sql | TablePhysicalSpecifications.md |
| Constraint Scripts | ConstraintSpecifications.md |
| Index Scripts | IndexSpecifications.md |
| Partition Scripts | PartitionStrategy.md |

The SQL implementation shall never become the architectural source.

---

## 41.3 Architecture Decision Records

Where implementation is influenced by an approved Architecture Decision Record (ADR), the corresponding ADR shall be referenced within the implementation documentation or repository metadata.

Examples include:

```text
ADR-015 — Market Classification Model

ADR-022 — Repository Architecture

ADR-026 — Normalize Reference Data Model
```

Architectural decisions shall always precede implementation.

---

# 42. Repository Mapping

The repository separates architectural specifications from executable database objects.

The mapping between the two layers shall remain stable.

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
                │
                ▼
Data/
└── Database/
    └── DDL/
```

The Physical Design layer defines implementation.

The DDL layer executes implementation.

---

## 42.1 Physical Design Artifacts

```text
README.md

PostgreSQLPhysicalDatabaseDesign.md

PostgreSQLDesignDecisions.md

TablePhysicalSpecifications.md

ConstraintSpecifications.md

DDLTemplateSpecification.md
```

These documents collectively define the canonical PostgreSQL implementation architecture.

---

## 42.2 Generated Repository Structure

The generated DDL repository shall follow the structure below.

```text
Data/
└── Database/
    └── DDL/
        ├── Schemas/
        ├── Domains/
        ├── Tables/
        ├── Constraints/
        ├── Indexes/
        ├── Views/
        ├── MaterializedViews/
        ├── Functions/
        ├── Procedures/
        ├── Triggers/
        ├── Sequences/
        └── Extensions/
```

Each directory owns one implementation responsibility.

---

## 42.3 Object Responsibility

Every SQL file shall create exactly one database object.

Examples

```text
exchange.sql

company.sql

instrument.sql

daily_market_data.sql
```

Large multi-object scripts are prohibited.

---

# 43. Generation Workflow

DDL generation shall follow a controlled architecture-driven workflow.

```text
Physical Design Approved
        │
        ▼
DDL Template Applied
        │
        ▼
SQL Generated
        │
        ▼
Architecture Validation
        │
        ▼
SQL Validation
        │
        ▼
Repository Review
        │
        ▼
Deployment Package
```

Manual deviations from this workflow are prohibited.

---

## 43.1 Automated Generation

Whenever practical, SQL scripts should be generated automatically from the approved Physical Design specifications.

Automation reduces implementation inconsistencies and improves repository quality.

---

## 43.2 Manual Adjustments

Manual modifications shall be limited to:

- formatting corrections;
- PostgreSQL syntax adjustments;
- deployment-specific options approved by the Database Architect.

Business semantics shall never be modified manually.

---

# 44. Governance

The DDL Template Specification is governed under the Phoenix Enterprise Architecture Governance Framework.

All SQL implementation artifacts shall comply with this specification.

---

## 44.1 Ownership

| Responsibility | Owner |
|---------------|-------|
| Architecture | Enterprise Architect |
| Physical Database Design | Database Architect |
| SQL Implementation | Database Developer |
| Repository Compliance | Repository Maintainer |

---

## 44.2 Approval Requirements

Changes affecting the DDL template require approval from the Database Architect.

Changes affecting architectural semantics additionally require approval from the Enterprise Architect.

---

## 44.3 Compliance

Compliance reviews shall verify:

- template usage;
- naming consistency;
- formatting consistency;
- repository consistency;
- traceability;
- architectural alignment.

Non-compliant SQL artifacts shall not be accepted into the repository.

---

# 45. Revision History

The revision history records the controlled evolution of this specification.

Every approved modification shall be documented to preserve architectural traceability and repository transparency.

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-24 | Initial enterprise DDL Template Specification created. |

Future revisions shall:

- preserve backward compatibility whenever possible;
- identify the architectural reason for change;
- reference related ADRs where applicable;
- remain synchronized with the corresponding Physical Design documents.

Revision history shall never be removed or rewritten.

---

# 46. Future Evolution

The DDL Template Specification is intended to evolve alongside the Phoenix Platform.

Future revisions may introduce standardized templates for:

- Row-Level Security (RLS)
- Policies
- Publications
- Subscriptions
- Logical Replication
- Full-Text Search
- PostgreSQL Extensions
- Vector Indexes
- AI-related database objects
- Multi-market database engines

Every extension shall remain compatible with the architectural principles established in this document.

---

# 47. Implementation Checklist

Before a DDL artifact is accepted into the repository, the following checklist shall be satisfied.

| Requirement | Status |
|-------------|--------|
| Uses canonical file template | □ |
| Uses approved naming conventions | □ |
| References correct schema | □ |
| Implements approved Physical Design | □ |
| Contains standardized documentation header | □ |
| Includes required constraints | □ |
| Includes required comments | □ |
| Passes PostgreSQL validation | □ |
| Passes architecture review | □ |
| Passes repository review | □ |

Completion of this checklist is mandatory for every new DDL script.

---

# 48. Appendix A — Canonical DDL File Layout

The following layout represents the canonical organization of every Phoenix DDL script.

```text
/***************************************************************************************************
 * Standard Documentation Header
 **************************************************************************************************/

CREATE TABLE ...

------------------------------------------------------------------------------
-- Primary Identifier
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Public Identifier
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Business Attributes
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Relationship Columns
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Business Status
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Audit Columns
------------------------------------------------------------------------------

...

------------------------------------------------------------------------------
-- Constraints
------------------------------------------------------------------------------

PRIMARY KEY

UNIQUE

CHECK

FOREIGN KEY

------------------------------------------------------------------------------
-- Comments
------------------------------------------------------------------------------

COMMENT ON TABLE ...

COMMENT ON COLUMN ...

------------------------------------------------------------------------------
-- Optional Future Sections
------------------------------------------------------------------------------

Indexes

Storage

Partitioning

Grants
```

This structure shall be used consistently throughout the repository.

---

# 49. Appendix B — Canonical Generation Principles

The following principles summarize the Phoenix DDL generation methodology.

1. Architecture precedes implementation.
2. Physical Design is the authoritative source.
3. DDL scripts are generated—not designed independently.
4. Every script implements exactly one database object.
5. Repository consistency has priority over developer preference.
6. Every implementation shall be deterministic.
7. Every implementation shall be fully traceable.
8. Every implementation shall comply with Enterprise Naming Standards.
9. Every implementation shall comply with PostgreSQL standards.
10. Every implementation shall remain maintainable throughout the platform lifecycle.

These principles govern every SQL artifact created for the Phoenix Platform.

---

# 50. Final Statement

The **DDL Template Specification** is the canonical standard governing the structure, organization, formatting, documentation, and implementation of every Database Definition Language (DDL) script within the Phoenix Platform.

Together with the following Physical Design documents:

- PostgreSQLPhysicalDatabaseDesign.md
- PostgreSQLDesignDecisions.md
- TablePhysicalSpecifications.md
- ConstraintSpecifications.md

it establishes the complete architectural foundation for PostgreSQL implementation.

No DDL artifact shall be created independently of these specifications.

Every executable SQL script shall be generated from the approved Physical Design architecture and shall preserve complete traceability from business requirements through database deployment.

By enforcing a single canonical template for all DDL artifacts, the Phoenix Platform achieves:

- enterprise-wide consistency;
- deterministic SQL generation;
- simplified repository maintenance;
- improved code quality;
- improved review efficiency;
- long-term maintainability;
- complete architectural traceability;
- standardized PostgreSQL implementation.

This document represents the final architectural specification before executable SQL generation and serves as the authoritative blueprint for all future DDL development within the Phoenix Platform.

---

