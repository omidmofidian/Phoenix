# Standard STD-006

# Enterprise Database Object Standard

---

## Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-006 |
| Document | Enterprise Database Object Standard |
| Version | 2.0 |
| Status | Approved |
| Classification | Enterprise Database Standard |
| Layer | Enterprise Governance |
| Owner | Enterprise Architecture |
| Repository Location | Architecture/Enterprise/Governance |
| Governed By | STA-001 – Standards Architecture |
| Related Artifacts | STD-003, STD-005, ADR-008, ADR-016, ADR-022, PhysicalDatabaseModel.md, EnterpriseDataDictionary.md |
| Last Updated | 2026-07-21 |

---

# 1. Purpose

This standard defines the enterprise-wide rules governing all PostgreSQL database objects used within the Phoenix Platform.

The objective is to ensure that every database object is designed, named, implemented, and maintained consistently across the platform.

Unlike **STD-005 – Enterprise Database Design Standard**, which defines architectural and design principles, this standard specifies the implementation rules and quality requirements for individual database objects.

The goals of this standard are to:

- establish uniform database object definitions;
- improve consistency across schemas;
- preserve data integrity;
- simplify maintenance;
- support long-term scalability;
- enable automation;
- facilitate future service-oriented evolution.

---

# 2. Scope

This standard applies to every database object created within the Phoenix Platform.

The scope includes:

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
- Triggers
- Extensions
- Domains (where applicable)
- Enumerated Types (where applicable)
- Audit Columns
- Identifier Columns
- UUID Columns
- Timestamp Columns

This standard applies to both manually written SQL scripts and migration-generated objects.

---

# 3. Out of Scope

The following topics are intentionally outside the scope of this standard:

- conceptual data modeling;
- logical data modeling;
- physical entity relationships;
- business rules;
- domain modeling;
- database normalization strategy;
- technology selection.

These subjects are governed by:

- Enterprise Architecture;
- Physical Database Model;
- Enterprise Data Dictionary;
- STD-005 – Enterprise Database Design Standard.

---

# 4. Relationship with Other Standards

This standard is part of the Enterprise Standards family governed by **STA-001 – Standards Architecture**.

Its relationships with other standards are defined as follows.

| Standard | Responsibility |
|----------|----------------|
| STD-003 | Enterprise naming conventions |
| STD-005 | Database design principles and architectural rules |
| STD-006 | Database object implementation standards |

STD-006 complements STD-005 and shall not duplicate architectural design principles defined there.

---

# 5. Standard Objectives

The Enterprise Database Object Standard establishes consistent implementation rules for database objects across all Phoenix Platform services and engines.

Its primary objectives are:

- consistency;
- maintainability;
- readability;
- interoperability;
- portability;
- extensibility;
- scalability;
- traceability.

All database objects shall comply with this standard unless an approved Architecture Decision Record explicitly defines an exception.

---

# 6. Database Platform

The official relational database management system (RDBMS) for the Phoenix Platform is:

```text
PostgreSQL 17
```

All SQL examples, naming conventions, and implementation rules defined in this document assume PostgreSQL 17 unless explicitly stated otherwise.

---

# 7. Database Object Taxonomy

For governance purposes, database objects are classified into the following categories.

## 7.1 Structural Objects

Structural objects define the physical organization of the database.

Included objects:

- Schemas
- Tables
- Columns
- Domains
- Enumerated Types

---

## 7.2 Integrity Objects

Integrity objects preserve data correctness and consistency.

Included objects:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Exclusion Constraints (where applicable)

---

## 7.3 Performance Objects

Performance objects optimize query execution.

Included objects:

- Indexes
- Materialized Views
- Query Optimization Structures

---

## 7.4 Logical Objects

Logical objects provide reusable database abstractions.

Included objects:

- Views
- Materialized Views

---

## 7.5 Executable Objects

Executable objects encapsulate reusable database logic.

Included objects:

- Functions
- Triggers
- Stored Procedures (if introduced in future versions)

---

## 7.6 Administrative Objects

Administrative objects support database operation and maintenance.

Included objects:

- Extensions
- Sequences
- Roles
- Permissions
- Ownership Definitions

---

# 8. Database Object Governance

Every database object shall satisfy the following governance requirements.

## 8.1 Unique Identification

Every object shall have a unique name within its namespace.

Object names shall never be reused for different semantic purposes.

---

## 8.2 Single Responsibility

Each database object shall serve a single clearly defined purpose.

Objects shall not combine unrelated responsibilities.

For example:

- a view shall expose data;
- a trigger shall enforce automation;
- a function shall encapsulate reusable logic.

---

## 8.3 Traceability

Every database object shall be traceable to at least one approved architectural artifact where applicable.

Typical upstream references include:

- Physical Database Model
- Enterprise Data Dictionary
- Architecture Decision Records
- Enterprise Standards

---

## 8.4 Version Control

Database object definitions shall be maintained under version control.

Direct modification of production database objects without an approved migration process is prohibited.

---

## 8.5 Documentation

All non-trivial database objects should include sufficient documentation describing:

- purpose;
- ownership;
- dependencies;
- assumptions;
- implementation notes.

Documentation may be maintained within SQL comments or the corresponding architectural artifacts.

---

# 9. Schema Standards

Schemas provide logical separation between enterprise domains.

Schemas shall be used to organize database objects according to business capability rather than technical implementation.

---

## 9.1 Schema Naming

Schema names shall:

- use lowercase letters;
- use singular nouns where appropriate;
- follow `snake_case`;
- remain stable over time.

Examples:

```text
market
analytics
reference
system
integration
```

---

## 9.2 Schema Responsibilities

Each schema shall have a clearly defined responsibility.

A schema shall not contain unrelated business domains.

Examples:

| Schema | Responsibility |
|----------|----------------|
| reference | Enterprise reference data |
| market | Market master and transactional data |
| analytics | Analytical data structures |
| system | Internal platform metadata |
| integration | External system interfaces |

---

## 9.3 Schema Ownership

Every schema shall have an identified owner responsible for:

- maintenance;
- security;
- version evolution;
- object consistency.

---

## 10. Table Standards

Tables represent persistent business entities.

Each table shall model exactly one business concept.

---

## 10.1 Table Naming

Table names shall:

- be singular;
- use lowercase letters;
- use `snake_case`;
- describe business meaning rather than implementation.

Examples:

```text
exchange

market

company

instrument

daily_market_data

trade_calendar
```

---

## 10.2 Table Responsibilities

Each table shall contain data belonging to a single business entity.

Business responsibilities shall not overlap between tables.

---

## 10.3 Table Classification

Enterprise tables are classified into the following categories.

### Reference Tables

Contain relatively static enterprise reference data.

Examples:

- exchange
- market
- board
- industry

---

### Master Tables

Contain long-lived business entities.

Examples:

- company
- instrument
- shareholder

---

### Transaction Tables

Contain operational events.

Examples:

- daily_market_data
- trade
- order

---

### Association Tables

Resolve many-to-many relationships.

Examples:

- company_index
- instrument_sector

---

### System Tables

Support platform infrastructure.

Examples:

- migration_history
- audit_log

---

# 11. Column Standards

Columns define the attributes of business entities.

Every column shall have a clearly defined semantic meaning.

---

## 11.1 Column Naming

Column names shall:

- use lowercase letters;
- use `snake_case`;
- describe business meaning;
- avoid abbreviations unless universally accepted.

Examples:

```text
company_name

trade_date

closing_price

market_status
```

---

## 11.2 Data Types

Data types shall accurately represent business semantics.

Examples:

| Business Concept | Preferred Type |
|------------------|----------------|
| Identifier | BIGINT |
| Public Identifier | UUID |
| Date | DATE |
| Timestamp | TIMESTAMPTZ |
| Price | NUMERIC |
| Percentage | NUMERIC |
| Quantity | BIGINT or NUMERIC |
| Status | BOOLEAN or ENUM (where appropriate) |
| Description | TEXT |

Floating-point data types shall never be used for financial values.

---

## 11.3 Nullability

Columns shall be declared `NOT NULL` whenever business rules require mandatory values.

Nullable columns shall represent genuinely optional information.

---

## 11.4 Default Values

Default values shall represent valid business defaults.

Defaults shall never hide missing business information.

Examples:

```sql
CURRENT_TIMESTAMP

TRUE

FALSE

gen_random_uuid()
```

---

## 11.5 Business Semantics

Column names shall express business meaning rather than technical implementation.

Preferred:

```text
listing_date
```

Avoid:

```text
date1
```

---

# 12. Identifier Standards

Enterprise identifiers provide stable identification of business entities.

Every persistent business table shall implement the enterprise identifier strategy.

---

## 12.1 Internal Identifier

Every persistent table shall contain:

```text
id
```

Type:

```sql
BIGINT GENERATED ALWAYS AS IDENTITY
```

Purpose:

- primary key;
- internal joins;
- foreign key relationships.

The internal identifier shall never be exposed through public APIs.

---

## 12.2 Public Identifier

Business entities intended for external integration shall contain:

```text
public_id
```

Type:

```sql
UUID
```

Default:

```sql
gen_random_uuid()
```

Purpose:

- REST APIs;
- service communication;
- event publishing;
- external references.

UUID values are immutable.

---

## 12.3 Business Identifiers

Where applicable, business identifiers shall be maintained separately from technical identifiers.

Examples:

```text
ticker

isin

exchange_code

instrument_code

external_company_code
```

Business identifiers shall never replace the internal primary key.

---

## 12.4 External Identifiers

Objects synchronized with external systems should include dedicated external identifier columns.

Recommended naming convention:

```text
external_<source>_code
```

Examples:

```text
external_tsetmc_code

external_codal_code

external_broker_code
```

External identifiers shall remain independent from enterprise identifiers to preserve decoupling between the Phoenix Platform and external data providers.

---

# 13. Key Standards

Keys establish the structural integrity of the enterprise database.

Every key definition shall support consistency, maintainability, and long-term scalability.

---

## 13.1 Primary Keys

Every persistent table shall define exactly one primary key.

Primary keys shall:

- use the `id` column;
- use `BIGINT GENERATED ALWAYS AS IDENTITY`;
- be immutable;
- never contain business meaning;
- never be updated after creation.

Primary key constraint naming:

```text
pk_<table_name>
```

Example:

```text
pk_company

pk_daily_market_data
```

---

## 13.2 Foreign Keys

Foreign keys establish relationships between business entities.

Foreign key columns shall:

- reference the parent table primary key;
- use identical data types;
- be indexed unless unnecessary;
- follow enterprise naming conventions.

Column naming:

```text
<parent_table>_id
```

Examples:

```text
exchange_id

market_id

company_id

instrument_id
```

Constraint naming:

```text
fk_<child_table>_<parent_table>
```

Example:

```text
fk_company_exchange

fk_instrument_market
```

---

## 13.3 Composite Keys

Composite primary keys should be avoided.

They may only be used when:

- no surrogate identifier is appropriate;
- the relationship itself is the business identity;
- architectural approval has been obtained.

Association tables should normally use a surrogate primary key together with an appropriate unique constraint.

---

## 13.4 Natural Keys

Natural keys may be enforced through unique constraints.

They shall not replace enterprise surrogate identifiers.

Examples include:

- ISIN
- exchange_code
- ticker (where uniqueness is guaranteed)

---

# 14. Constraint Standards

Constraints preserve business correctness and data integrity.

Constraints shall be declarative whenever practical.

Business logic shall not rely solely on application code.

---

## 14.1 Primary Key Constraints

Every persistent table shall define one primary key constraint.

---

## 14.2 Foreign Key Constraints

All logical relationships shall be enforced through foreign keys unless a documented architectural exception exists.

Referential integrity shall never be enforced solely by application logic.

---

## 14.3 Unique Constraints

Unique constraints shall protect business uniqueness.

Constraint naming:

```text
ux_<table_name>_<column_name>
```

Examples:

```text
ux_company_public_id

ux_exchange_exchange_code

ux_market_market_code
```

Composite unique constraints shall include all participating columns in the constraint definition.

---

## 14.4 Check Constraints

Check constraints shall enforce domain validity whenever possible.

Typical examples include:

- positive quantities;
- non-negative prices;
- valid percentages;
- valid status ranges.

Constraint naming:

```text
ck_<table_name>_<rule>
```

Examples:

```text
ck_daily_market_data_price_positive

ck_company_listing_date
```

---

## 14.5 Default Constraints

Default values shall represent valid business defaults.

Defaults shall never compensate for missing mandatory business information.

---

# 15. Index Standards

Indexes improve query performance.

Indexes shall be created based upon workload analysis rather than convenience.

Excessive indexing shall be avoided.

---

## 15.1 Primary Key Indexes

Primary keys automatically create indexes.

No duplicate primary key indexes shall be created.

---

## 15.2 Foreign Key Indexes

Foreign key columns should normally be indexed.

Exceptions require documented performance justification.

---

## 15.3 Business Indexes

Indexes shall be created for frequently searched business columns.

Typical candidates include:

- ticker;
- trade_date;
- public_id;
- external identifiers;
- listing_date.

---

## 15.4 Composite Indexes

Composite indexes shall reflect actual query patterns.

Column ordering shall follow query selectivity and access frequency.

---

## 15.5 Index Naming

Naming convention:

```text
idx_<table_name>_<column_name>
```

Examples:

```text
idx_company_ticker

idx_daily_market_data_trade_date

idx_daily_market_data_company_id
```

Composite indexes:

```text
idx_<table_name>_<column1>_<column2>
```

Example:

```text
idx_daily_market_data_company_id_trade_date
```

---

## 15.6 Index Review

Indexes shall be reviewed periodically to identify:

- unused indexes;
- duplicate indexes;
- redundant indexes;
- missing indexes.

Performance optimization shall be evidence-based.

---

# 16. View Standards

Views provide logical abstraction over persistent data.

Views shall simplify data consumption without duplicating business logic.

---

## 16.1 Naming

Views shall use:

```text
vw_<view_name>
```

Examples:

```text
vw_latest_market_data

vw_active_company

vw_market_summary
```

---

## 16.2 Responsibilities

Views should:

- simplify reporting;
- encapsulate reusable queries;
- hide implementation complexity;
- expose business-friendly structures.

Views shall not become substitutes for application services.

---

## 16.3 Update Policy

Views should normally be read-only.

Updateable views may be used only when explicitly justified.

---

# 17. Materialized View Standards

Materialized views shall be used only when query performance requires persisted query results.

---

## 17.1 Naming

Materialized views shall use:

```text
mv_<view_name>
```

Examples:

```text
mv_market_statistics

mv_company_rankings
```

---

## 17.2 Refresh Strategy

Refresh strategy shall be explicitly documented.

Possible strategies include:

- scheduled refresh;
- incremental refresh;
- manual refresh;
- event-driven refresh.

---

## 17.3 Data Freshness

Consumers of materialized views shall understand the expected data latency.

Materialized views shall not be used where real-time data is mandatory.

---

# 18. Sequence Standards

Identity columns should be preferred over standalone sequences.

Standalone sequences shall be created only when required by a specific architectural or technical requirement.

Sequence naming:

```text
seq_<object_name>
```

Examples:

```text
seq_batch_number

seq_import_execution
```

Sequences shall not be shared across unrelated business domains without explicit architectural approval.

---

# 19. Function Standards

Functions encapsulate reusable database logic.

Functions shall implement deterministic and reusable business or technical operations whenever practical.

Functions shall not replace application services or domain logic.

---

## 19.1 Naming

Function names shall follow:

```text
fn_<function_name>
```

Examples:

```text
fn_generate_public_id

fn_calculate_market_value

fn_import_market_data
```

---

## 19.2 Responsibilities

Functions should:

- perform one well-defined task;
- produce predictable results;
- be reusable;
- minimize side effects.

---

## 19.3 Parameters

Parameter names shall be meaningful and follow `snake_case`.

Parameters shall use explicit PostgreSQL data types.

---

## 19.4 Return Types

Return types shall accurately represent the function result.

Preferred return types include:

- scalar values;
- records;
- table results;
- JSON (where appropriate).

---

## 19.5 Documentation

Complex functions shall include SQL comments describing:

- purpose;
- parameters;
- return value;
- assumptions;
- dependencies.

---

# 20. Trigger Standards

Triggers automate database behavior.

Triggers shall be used sparingly.

Business rules should normally reside within the application layer unless enforcing data integrity or audit requirements.

---

## 20.1 Naming

Trigger names shall follow:

```text
trg_<trigger_name>
```

Examples:

```text
trg_update_timestamp

trg_audit_insert

trg_validate_reference
```

---

## 20.2 Responsibilities

Typical trigger responsibilities include:

- audit management;
- timestamp maintenance;
- integrity enforcement;
- controlled synchronization.

Triggers shall not contain complex business workflows.

---

## 20.3 Trigger Timing

Trigger timing shall be explicitly selected:

- BEFORE
- AFTER
- INSTEAD OF

The selected timing shall reflect the intended business behavior.

---

# 21. Audit Standards

Enterprise audit information provides traceability for persistent business data.

Every operational table shall support a consistent audit model.

---

## 21.1 Mandatory Audit Columns

Operational tables shall include:

```text
created_at

updated_at
```

Data type:

```sql
TIMESTAMP WITH TIME ZONE
```

Default:

```sql
CURRENT_TIMESTAMP
```

---

## 21.2 Optional Audit Columns

Where required, tables may also include:

```text
created_by

updated_by

deleted_at

deleted_by
```

These columns support future identity management and security integration.

---

## 21.3 Audit Automation

Automatic maintenance of audit columns should be implemented through reusable triggers or standardized infrastructure mechanisms.

Audit logic shall be implemented consistently across all schemas.

---

# 22. UUID Standards

UUIDs provide globally unique identifiers suitable for distributed architectures.

---

## 22.1 UUID Generation

UUID values shall be generated using PostgreSQL-supported secure functions.

Recommended implementation:

```sql
gen_random_uuid()
```

---

## 22.2 Immutability

UUID values shall never change after creation.

Existing UUIDs shall never be reused.

---

## 22.3 External Exposure

External APIs, integration services, and future service-oriented components should expose UUID values instead of internal numeric identifiers.

---

## 22.4 Internal Usage

Database joins shall continue to use internal numeric primary keys unless an approved architectural exception exists.

---

# 23. Temporal Standards

Enterprise databases shall represent time consistently.

---

## 23.1 Timestamp Type

All timestamps shall use:

```sql
TIMESTAMP WITH TIME ZONE
```

(`TIMESTAMPTZ`)

---

## 23.2 Time Zone

Application components should store timestamps in UTC.

Presentation layers may convert timestamps to local time zones.

Enterprise reference timezone:

```text
Asia/Tehran
```

---

## 23.3 Date Columns

Business dates shall use:

```sql
DATE
```

Examples:

```text
trade_date

listing_date

settlement_date
```

---

## 23.4 Time Columns

Time-only values shall use:

```sql
TIME
```

Only when business requirements explicitly require isolated time values.

---

# 24. Reference Data Standards

Reference data represents stable enterprise business definitions.

Examples include:

- exchanges;
- markets;
- boards;
- industries;
- sectors;
- currencies.

---

## 24.1 Stability

Reference data changes infrequently.

Updates shall follow controlled governance procedures.

---

## 24.2 Deletion Policy

Reference records shall not be physically deleted.

Preferred approaches include:

- deactivation;
- logical retirement;
- validity periods.

---

## 24.3 Active Status

Reference entities should include:

```text
is_active BOOLEAN
```

Default:

```sql
TRUE
```

---

## 24.4 Business Codes

Reference tables should expose stable business codes independent of internal identifiers.

Examples:

```text
exchange_code

market_code

board_code
```

---

# 25. Financial Data Standards

Financial data requires higher precision than ordinary numeric information.

---

## 25.1 Numeric Precision

Financial values shall use:

```sql
NUMERIC
```

Appropriate precision and scale shall be selected according to business requirements.

---

## 25.2 Floating Point Types

The following types shall not be used for financial calculations:

```text
REAL

FLOAT

DOUBLE PRECISION
```

except where explicitly approved for analytical or statistical processing.

---

## 25.3 Currency Values

Currency values shall always preserve full business precision.

Implicit rounding shall never occur during storage.

---

## 25.4 Percentages

Percentages shall use:

```sql
NUMERIC
```

Business rules shall define the required precision.

---

## 25.5 Quantities

Share quantities and trading volumes shall use integer or precise numeric types depending on business semantics.

Implicit conversion between numeric types should be avoided.

---

# 26. Security Standards

Database objects shall be designed according to the principle of least privilege.

Security shall be considered an integral part of database object design rather than an operational afterthought.

---

## 26.1 Object Ownership

Every database object shall have a clearly defined owner.

Ownership shall be assigned to managed database roles rather than individual user accounts.

---

## 26.2 Access Control

Privileges shall be granted using database roles.

Direct privilege assignment to individual users should be avoided.

Privileges shall be limited to the minimum required for the intended business function.

---

## 26.3 Data Protection

Sensitive business data shall be protected using appropriate database and application security mechanisms.

Where applicable, this includes:

- encryption at rest;
- encryption in transit;
- role-based access control;
- audit logging;
- secure credential management.

---

## 26.4 Separation of Duties

Administrative, application, reporting, and integration accounts shall be separated.

Database objects shall not assume elevated privileges beyond their intended operational scope.

---

# 27. Compliance Rules

Every database object created within the Phoenix Platform shall comply with this standard.

Compliance shall be verified during architecture review, implementation review, and database migration review.

---

## 27.1 Mandatory Requirements

The following requirements are mandatory unless an approved Architecture Decision Record (ADR) explicitly defines an exception:

- object naming conventions;
- identifier strategy;
- audit columns;
- data type standards;
- constraint naming;
- index naming;
- UUID policy;
- timestamp policy.

---

## 27.2 Exceptions

Any deviation from this standard shall:

- be documented;
- include technical and business justification;
- identify the affected database objects;
- receive formal architectural approval.

Temporary exceptions shall include a target resolution date.

---

## 27.3 Validation

Compliance should be verified through automated and manual review processes.

Typical validation activities include:

- schema validation;
- migration review;
- naming convention validation;
- object consistency validation;
- referential integrity validation;
- architectural compliance review.

---

# 28. Implementation Guidance

STD-006 defines **what** enterprise database objects shall look like.

It does **not** prescribe migration tooling or implementation technology.

Implementation artifacts shall conform to this standard, including:

- SQL DDL scripts;
- migration scripts;
- initialization scripts;
- seed data scripts;
- database deployment pipelines.

---

# 29. Relationship with Enterprise Architecture

STD-006 is part of the Enterprise Governance layer.

Its purpose is to standardize the implementation characteristics of database objects across the Phoenix Platform.

The relationship with other architectural artifacts is illustrated below.

```text
ADR-022 Repository Architecture
               │
               ▼
STA-001 Standards Architecture
               │
               ▼
STD-003 Naming Convention Standard
               │
               ├──────────────┐
               ▼              ▼
STD-005 Enterprise      STD-006 Enterprise
Database Design         Database Object
Standard                Standard
               │
               ▼
Physical Database Model
               │
               ▼
Enterprise Data Dictionary
               │
               ▼
Database Implementation
```

STD-005 defines **how the database shall be designed**.

STD-006 defines **how database objects shall be implemented**.

The Physical Database Model defines **which objects exist**.

The Enterprise Data Dictionary defines **the meaning of those objects**.

---

# 30. References

## Architecture Decision Records

- ADR-008 — Database Architecture
- ADR-016 — Enterprise Identifier Strategy
- ADR-022 — Repository Architecture

---

## Enterprise Standards

- STA-001 — Standards Architecture
- STD-001 — Documentation Standard
- STD-003 — Naming Convention Standard
- STD-005 — Enterprise Database Design Standard

---

## Architecture Documentation

- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md
- CanonicalEnterpriseERD.vsdx (when applicable)

---

# 31. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial database standards document. |
| 2.0 | 2026-07-21 | Refactored into the Enterprise Database Object Standard. Added comprehensive standards for schemas, tables, columns, identifiers, constraints, indexes, views, materialized views, sequences, functions, triggers, audit model, UUID policy, temporal data, reference data, financial data, security, compliance, governance, and alignment with STA-001, STD-005, and ADR-022. |

---

# 32. Approval

This standard is approved as the authoritative enterprise standard governing PostgreSQL database objects within the Phoenix Platform.

All future database schemas, migration scripts, and physical database implementations shall conform to this standard.

Changes affecting the scope, governance model, or mandatory implementation rules defined herein shall require Enterprise Architecture approval and, where applicable, a corresponding Architecture Decision Record (ADR).

---