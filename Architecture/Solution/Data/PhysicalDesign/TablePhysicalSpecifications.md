# Table Physical Specifications

---

# 1. Document Information

| Item | Value |
|------|-------|
| Document | Table Physical Specifications |
| Directory | Architecture/Solution/Data/PhysicalDesign |
| Layer | Solution Architecture |
| Domain | Data Architecture |
| Database Platform | PostgreSQL 17 |
| Version | 2026.2 |
| Status | Architecture Freeze |
| Canonical Status | Canonical Physical Specification |
| Owner | Database Architecture |
| Repository | Phoenix Platform |
| Last Updated | 2026-07-23 |

---

# 2. Purpose

This document defines the canonical physical specification for every PostgreSQL table implemented within the Phoenix Platform.

This document is the canonical physical implementation specification of the Phoenix Platform.

It is derived from the approved Enterprise Data Dictionary and the Logical Database Model.

In case of any inconsistency, the following precedence shall apply:

1. Architecture Decision Records (ADRs)
2. Domain Model
3. Enterprise Data Dictionary
4. Logical Database Model
5. Table Physical Specifications
6. PostgreSQL DDL

Executable DDL scripts shall be generated from this document.
No architectural decision shall originate from DDL scripts.

Unlike the Physical Database Model, which defines the physical structure of the enterprise database, and the PostgreSQL Physical Database Design, which defines implementation architecture and design principles, this document specifies the complete physical implementation of each table.

Every table specification contained herein is intended to be sufficiently complete for deterministic DDL generation.

No architectural interpretation shall be required during SQL implementation.

---

# 3. Scope

This document specifies the physical implementation of every approved PostgreSQL table.

Each table specification includes, where applicable:

- physical table metadata;
- implementation purpose;
- schema location;
- physical column definitions;
- PostgreSQL data types;
- nullability;
- default values;
- generated columns;
- identity definition;
- primary keys;
- alternate keys;
- foreign keys;
- check constraints;
- indexes;
- partition configuration;
- storage characteristics;
- audit implementation;
- implementation notes;
- validation requirements;
- DDL generation guidance.

Business semantics are intentionally excluded because they are maintained within the Enterprise Data Dictionary.

Likewise, architectural rationale is intentionally excluded because it is documented within **PostgreSQLDesignDecisions.md**.

---

# 4. Document Authority

This document defines the canonical physical implementation of approved database tables.

It shall remain synchronized with the Enterprise Data Dictionary.

This document is subordinate to:

- ADRs
- Domain Model
- Enterprise Data Dictionary
- Logical Database Model

All PostgreSQL DDL scripts shall conform to this specification.

DDL scripts are implementation artifacts and shall never become the source of architectural truth.

---

# 5. Synchronization Policy

The following artifacts shall remain synchronized:

- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model
- Table Physical Specifications
- PostgreSQL DDL

Whenever a change is introduced, synchronization shall proceed in the following order:

Enterprise Data Dictionary
    ↓
Logical Database Model
    ↓
Physical Database Model
    ↓
Table Physical Specifications
    ↓
DDL

---

# 6. Relationship to Physical Design

Within the Physical Design layer, this document represents the final architectural specification before executable SQL generation.

```text
Conceptual Data Model
        │
        ▼
Logical Database Model
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
DDL/Tables
        │
        ▼
Database Validation
```

Accordingly, this document answers the following implementation question:

> **Exactly how shall each PostgreSQL table be implemented?**

It does **not** redefine:

- business entities;
- business attributes;
- business rules;
- implementation philosophy;
- architectural decisions.

Those responsibilities belong to the higher architectural layers.

---

# 7. Specification Methodology

Every table within the Phoenix Platform shall be documented using a single standardized specification template.

The objective is to ensure that:

- all tables are documented consistently;
- every PostgreSQL object is fully specified;
- DDL generation is deterministic;
- implementation ambiguity is eliminated;
- repository maintainability is maximized.

Each table specification shall contain only implementation information.

Business definitions shall remain within the Enterprise Data Dictionary.

Architectural reasoning shall remain within **PostgreSQLDesignDecisions.md**.

Implementation standards shall remain within **PostgreSQLPhysicalDatabaseDesign.md**.

This document therefore serves as the implementation bridge between architectural design and executable PostgreSQL DDL.

---

# 8. Standard Table Specification Template

Every PostgreSQL table implemented within the Phoenix Platform shall follow a single standardized physical specification.

The template defined in this section is mandatory for all current and future business entities.

The objective is to ensure:

- implementation consistency;
- deterministic DDL generation;
- architectural traceability;
- simplified maintenance;
- predictable repository organization.

The template intentionally separates implementation details from business semantics.

Business definitions remain within the Enterprise Data Dictionary.

---

## 8.1 Standard Specification Structure

Every table specification shall contain the following sections.

```text
1. Table Information

2. Purpose

3. Physical Location

4. Table Definition

5. Column Specifications

6. Identity Strategy

7. Default Values

8. Generated Columns

9. Primary Key

10. Alternate Keys

11. Foreign Keys

12. Check Constraints

13. Indexes

14. Partition Strategy

15. Storage Parameters

16. Audit Implementation

17. DDL Generation Notes

18. Validation Requirements

19. Dependencies

20. Future Extensions
```

Individual sections may be omitted only when they are not applicable to a particular table.

---

## 8.2 Table Information

Each specification shall begin with implementation metadata.

Typical information includes:

```text
Table Name

Schema

Entity

Version

Status

Owner
```

This information supports repository governance and version control.

---

## 8.3 Purpose

The purpose section shall describe the implementation responsibility of the table.

It shall not redefine business concepts already documented within the Enterprise Data Dictionary.

Purpose statements shall remain concise and implementation-oriented.

---

## 8.4 Physical Location

Each specification shall explicitly identify the physical PostgreSQL location.

Typical information includes:

```text
Schema

Table Name

Partitioned

Tablespace (if applicable)
```

---

## 8.5 Table Definition

Every specification shall include the canonical PostgreSQL table declaration.

Example

```sql
CREATE TABLE market.company
(
    ...
);
```

Only implementation structure shall be described.

Business explanations are intentionally excluded.

---

# 9. Physical Table Standards

The Phoenix Platform adopts standardized implementation rules for every PostgreSQL table.

Equivalent implementation problems shall always be solved using identical physical standards.

---

## 9.1 One Entity — One Table

Every persistent business entity shall be implemented as exactly one physical table.

Table splitting shall only occur when approved by architecture.

---

## 9.2 Stable Physical Names

Table names shall remain stable.

Renaming tables after implementation shall be avoided because it affects:

- foreign keys;
- views;
- functions;
- ETL processes;
- integrations.

---

## 9.3 Schema Qualification

Every physical table shall always be referenced using its fully qualified name.

Example

```text
market.company

market.instrument

trading.daily_market_data
```

Schema qualification improves readability and eliminates ambiguity.

---

## 9.4 Singular Naming

Table names shall represent a single business entity.

Examples

```text
company

instrument

exchange

market
```

Plural names shall not be used.

---

## 9.5 Implementation Independence

Physical table definitions shall remain independent from:

- application code;
- ORM frameworks;
- reporting tools;
- import utilities.

The database architecture shall remain the authoritative implementation source.

---

# 10. Column Definition Rules

Column definitions shall follow standardized implementation rules across every PostgreSQL table.

---

## 10.1 Column Ordering

Columns shall appear in the following logical order.

```text
Identity Columns

Business Identifier Columns

Relationship Columns

Business Attributes

Operational Attributes

Audit Columns
```

This ordering improves readability and implementation consistency.

---

## 10.2 Column Naming

Columns shall:

- use lowercase characters;
- use snake_case;
- remain descriptive;
- avoid abbreviations;
- follow Enterprise Naming Standards.

Examples

```text
company_name

listing_symbol

effective_date

trade_value

created_at
```

---

## 10.3 Nullable Columns

A column shall be nullable only when the absence of a value has valid business meaning.

Nullable columns shall not be introduced solely to simplify implementation.

---

## 10.4 Mandatory Columns

Mandatory columns shall always specify:

- PostgreSQL data type;
- nullability;
- default value (where applicable).

Mandatory columns shall not rely upon application behavior for correctness.

---

## 10.5 Column Documentation

Every column shall include:

- implementation purpose;
- PostgreSQL data type;
- nullability;
- default behavior;
- implementation notes (when required).

This documentation shall be sufficient for automated DDL generation.

---

## 10.6 Implementation Consistency

Equivalent business attributes shall always be implemented using identical:

- names;
- PostgreSQL data types;
- nullability rules;
- default values.

Consistency shall take precedence over localized implementation preferences.

---

# 11. Identity Columns

Identity columns establish the internal identity of every persistent table within the Phoenix Platform.

Their implementation shall follow a single enterprise-wide strategy to ensure consistency, interoperability, and long-term maintainability.

Identity implementation shall conform to the standards defined in:

- PostgreSQLPhysicalDatabaseDesign.md
- PostgreSQLDesignDecisions.md

This document specifies only the physical implementation.

---

## 11.1 Primary Identity

Every persistent table shall contain one internal surrogate identifier.

Standard implementation

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

Characteristics

- immutable;
- meaningless to business users;
- database generated;
- never updated;
- used exclusively as the primary key.

---

## 11.2 Public Identifier

Where external references are required, the table shall expose a public identifier.

Standard implementation

```sql
public_id UUID
```

The public identifier shall:

- remain immutable;
- be globally unique;
- never replace the primary key;
- be protected by a UNIQUE constraint.

---

## 11.3 Business Identifiers

Business identifiers shall be implemented as ordinary business attributes.

Examples include:

```text
exchange_code

market_code

listing_symbol

company_registration_number
```

Business identifiers shall never replace surrogate identifiers.

Uniqueness shall be enforced through UNIQUE constraints where required.

---

## 11.4 Identity Implementation Rules

Each table specification shall explicitly define:

- identity column;
- identity generation method;
- public identifier (if applicable);
- business identifiers;
- uniqueness requirements.

---

# 12. Audit Columns

Audit columns record lifecycle information for database records.

Their implementation depends upon the category of the entity being implemented.

---

## 12.1 Master Data Audit

Master data tables shall contain the complete enterprise audit set.

Standard implementation

```sql
created_at TIMESTAMP WITH TIME ZONE

updated_at TIMESTAMP WITH TIME ZONE

created_by BIGINT

updated_by BIGINT

is_active BOOLEAN
```

These columns support:

- operational auditing;
- lifecycle management;
- administrative reporting;
- logical deletion.

---

## 12.2 Operational Data Audit

Operational datasets generally require only timestamp auditing.

Typical implementation

```sql
created_at TIMESTAMP WITH TIME ZONE

updated_at TIMESTAMP WITH TIME ZONE
```

Additional audit columns shall only be introduced when justified by operational requirements.

---

## 12.3 Audit Consistency

Equivalent entity categories shall implement identical audit structures.

Audit implementation shall never vary between similar tables without architectural approval.

---

## 12.4 Audit Defaults

Where applicable, audit columns shall define standard default expressions.

Typical examples include

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP
```

The implementation of automatic update behavior shall be defined separately within the DDL layer.

---

# 13. Default Values

Default values improve implementation consistency while reducing unnecessary application logic.

Only business-neutral defaults shall be defined within the database.

Business-specific defaults remain the responsibility of application services.

---

## 13.1 Default Value Principles

Default values shall:

- be deterministic;
- remain architecture-approved;
- avoid business assumptions;
- simplify implementation.

---

## 13.2 Typical Defaults

Common defaults include:

```sql
CURRENT_TIMESTAMP

TRUE

FALSE

0
```

Each default shall be explicitly documented within the table specification.

---

## 13.3 Business Defaults

Business-dependent values shall never be implemented as database defaults.

Examples include:

- exchange selection;
- market selection;
- trading status;
- business workflow state.

These values shall be assigned by the application layer.

---

## 13.4 Default Value Documentation

Every default value shall specify:

- affected column;
- PostgreSQL expression;
- implementation purpose;
- architectural justification (where required).

---

# 14. Generated Columns

Generated columns provide deterministic values derived from other columns.

They improve implementation consistency while reducing redundant data maintenance.

---

## 14.1 Usage Principles

Generated columns shall only be used when:

- values are deterministic;
- no business logic is introduced;
- implementation complexity is reduced.

---

## 14.2 Supported Generation

Typical PostgreSQL generated columns include:

```sql
GENERATED ALWAYS AS (...)
STORED
```

Virtual generated columns shall not be used because PostgreSQL supports stored generated columns only.

---

## 14.3 Generated Value Restrictions

Generated columns shall not:

- reference external tables;
- contain business workflow logic;
- replace application processing;
- duplicate business semantics.

---

## 14.4 Documentation Requirements

Whenever a generated column exists, the table specification shall document:

- source columns;
- generation expression;
- storage behavior;
- implementation purpose;
- DDL generation notes.

This information shall be sufficient for deterministic generation of the corresponding PostgreSQL DDL.

---

# 15. Constraint Specification Standard

Constraints preserve structural integrity within the PostgreSQL database and ensure that every physical table complies with the approved enterprise data model.

Constraint implementation shall follow standardized architectural rules across the entire Phoenix Platform.

Detailed implementation decisions are governed by **PostgreSQLDesignDecisions.md**.

This document specifies only the physical implementation requirements.

---

## 15.1 Constraint Categories

Every table specification shall explicitly document the applicable constraint categories.

Typical constraint types include:

```text
Primary Key

Unique Constraint

Foreign Key

Check Constraint

Exclusion Constraint (when applicable)
```

Only applicable constraints shall be included for a given table.

---

## 15.2 Constraint Definition Principles

All constraints shall:

- be deterministic;
- be explicitly documented;
- be reproducible during DDL generation;
- avoid business workflow logic;
- preserve structural integrity.

Constraints shall never duplicate validation already enforced by another constraint.

---

## 15.3 Constraint Naming

Constraint names shall follow the Enterprise Naming Standards.

Typical examples include:

```text
pk_company

fk_company_exchange

uq_company_public_id

ck_daily_market_data_price
```

Constraint names shall remain stable throughout the repository lifecycle.

---

## 15.4 Constraint Documentation

Each documented constraint shall specify:

- constraint name;
- constraint type;
- participating columns;
- PostgreSQL implementation;
- implementation purpose.

---

## 15.5 DDL Generation

Every documented constraint shall be directly convertible into executable PostgreSQL DDL without architectural interpretation.

---

# 16. Foreign Key Specification

Foreign keys define relationships between physical tables.

Every relationship documented within the Physical Database Model shall be implemented using explicit PostgreSQL foreign keys unless an approved architectural exception exists.

---

## 16.1 Foreign Key Principles

Foreign keys shall:

- reference surrogate primary keys;
- preserve referential integrity;
- be explicitly named;
- use fully qualified schema references.

Example

```sql
REFERENCES market.company(id)
```

---

## 16.2 Referential Actions

Referential actions shall be selected according to approved business semantics.

Typical actions include:

```text
RESTRICT

CASCADE

SET NULL

NO ACTION
```

The selected action shall be documented within each table specification.

---

## 16.3 Required Documentation

Each foreign key definition shall specify:

```text
Constraint Name

Parent Schema

Parent Table

Referenced Column

Referential Action

Supporting Index
```

---

## 16.4 Cross-Schema References

Cross-schema foreign keys are permitted.

Example

```sql
trading.daily_market_data

↓

market.instrument
```

Cross-schema relationships shall remain fully documented.

---

## 16.5 Foreign Key Validation

Every foreign key shall satisfy:

- identical PostgreSQL data types;
- identical numeric precision;
- compatible nullability;
- matching business relationship.

---

# 17. Check Constraint Specification

CHECK constraints enforce implementation-level validation within the PostgreSQL database.

They shall preserve structural correctness without embedding business workflows.

---

## 17.1 Purpose

CHECK constraints may validate:

- numeric ranges;
- valid dates;
- non-negative values;
- logical consistency;
- allowable implementation states.

---

## 17.2 Examples

Typical PostgreSQL CHECK constraints include:

```sql
price >= 0
```

```sql
volume >= 0
```

```sql
valid_to >= valid_from
```

---

## 17.3 Business Rules

Business workflows shall never be implemented as CHECK constraints.

Examples that shall remain outside database constraints include:

- approval workflows;
- trading permissions;
- exchange operational rules;
- portfolio validation;
- investment policies.

---

## 17.4 Documentation

Each CHECK constraint shall document:

- constraint name;
- validated columns;
- validation expression;
- implementation purpose.

---

## 17.5 Implementation Consistency

Equivalent validation rules shall always use identical CHECK constraints throughout the Phoenix Platform.

---

## 17.6 DDL Readiness

Every documented CHECK constraint shall be immediately convertible into PostgreSQL DDL without requiring additional design decisions.

This document therefore serves as the authoritative implementation specification for CHECK constraint generation.

---

# 18. Index Specification Standard

Indexes are physical database objects created to optimize approved access patterns.

Every index documented within this specification shall have a clearly defined implementation purpose and shall remain traceable to an approved architectural requirement.

Indexes shall not be introduced solely as speculative performance optimizations.

---

## 18.1 Index Categories

Each table specification shall explicitly identify all required indexes.

Typical categories include:

```text
Primary Index

Unique Index

Foreign Key Index

Lookup Index

Composite Index

Analytical Index
```

Only indexes justified by implementation requirements shall be created.

---

## 18.2 Primary Index

The primary key automatically creates the primary index.

Example

```sql
PRIMARY KEY (id)
```

No additional index shall duplicate the primary key index.

---

## 18.3 Unique Indexes

Unique indexes shall enforce business uniqueness.

Typical examples include:

```sql
public_id
```

or

```sql
(exchange_id, market_code)
```

Every unique index shall correspond to an approved business identifier.

---

## 18.4 Foreign Key Indexes

Foreign key columns shall normally have supporting indexes.

Example

```sql
instrument_id
```

Supporting indexes improve:

- JOIN performance;
- UPDATE performance;
- DELETE performance;
- referential integrity validation.

---

## 18.5 Lookup Indexes

Lookup indexes support frequently executed search operations.

Typical examples include:

```sql
listing_symbol
```

```sql
company_name
```

```sql
external_identifier
```

Lookup indexes shall only be created when justified by expected query patterns.

---

## 18.6 Composite Indexes

Composite indexes shall support common multi-column filtering.

Example

```sql
(trading_date, instrument_id)
```

Column ordering shall reflect expected query selectivity.

---

## 18.7 Analytical Indexes

Analytical tables may contain indexes optimized for reporting workloads.

Typical columns include:

```sql
trading_date

close_price

volume
```

Analytical indexes shall be documented separately from transactional indexes.

---

## 18.8 Index Documentation

Each documented index shall specify:

- index name;
- index type;
- indexed columns;
- uniqueness;
- implementation purpose;
- expected workload.

---

## 18.9 DDL Generation

Every documented index shall be directly convertible into PostgreSQL CREATE INDEX statements.

No implementation decisions shall remain unresolved during DDL generation.

---

# 19. Storage Specification

Storage specifications describe the physical storage characteristics of each PostgreSQL table.

These specifications optimize implementation without affecting business semantics.

---

## 19.1 Storage Objectives

Storage specifications support:

- efficient disk utilization;
- predictable performance;
- long-term scalability;
- simplified maintenance.

---

## 19.2 Tablespace

Where applicable, each table specification shall identify its target tablespace.

Example

```text
Default Tablespace
```

Alternative tablespaces may be documented when required by future deployment architectures.

---

## 19.3 Fillfactor

Tables requiring optimized write performance may specify a custom fillfactor.

Example

```sql
FILLFACTOR = 90
```

If omitted, PostgreSQL default values shall apply.

---

## 19.4 TOAST

Large variable-length attributes shall rely upon PostgreSQL native TOAST storage.

Manual TOAST configuration shall only be documented where architectural justification exists.

---

## 19.5 Storage Documentation

Each table specification shall document:

- tablespace;
- fillfactor;
- storage parameters;
- TOAST considerations;
- implementation notes.

---

# 20. Partition Specification

Partition specifications define how large operational tables are physically partitioned.

Only approved tables shall contain partition definitions.

---

## 20.1 Partition Eligibility

Each table specification shall explicitly state whether the table is:

```text
Partitioned

or

Non-Partitioned
```

Tables not approved for partitioning shall omit partition definitions.

---

## 20.2 Partition Method

Where partitioning is required, the specification shall define:

```text
Partition Method

Partition Key

Partition Interval
```

Example

```text
Method

RANGE

Key

trading_date

Interval

Monthly
```

---

## 20.3 Partition Naming

Partition names shall follow enterprise naming standards.

Example

```text
daily_market_data_2026_01

daily_market_data_2026_02

daily_market_data_2026_03
```

Naming shall remain deterministic to support automated deployment.

---

## 20.4 Partition Maintenance

Each partitioned table shall document:

- creation policy;
- archival policy;
- retention policy;
- maintenance considerations.

Operational procedures remain outside the scope of this document.

---

## 20.5 Partition Documentation

Each partition specification shall include:

- partition method;
- partition key;
- partition interval;
- expected partition naming;
- implementation notes.

---

## 20.6 DDL Generation

Partition specifications shall provide sufficient information for deterministic generation of PostgreSQL partitioned table DDL.

No partition-related implementation decisions shall remain unresolved after completion of the table specification.

---

# 21. Table Specification — Exchange

This section defines the canonical physical implementation specification for the **Exchange** table.

The Exchange table represents the highest-level trading venue within the Phoenix Platform and serves as the root reference for multiple downstream market entities.

The following specification is the authoritative source for generating the PostgreSQL DDL for this table.

---

## 21.1 Table Information

| Item | Value |
|------|-------|
| Entity | Exchange |
| Schema | market |
| Table | exchange |
| Category | Reference Data |
| Physical Type | Master Table |
| Lifecycle | Static |
| Partitioned | No |

---

## 21.2 Purpose

The Exchange table stores the list of supported financial exchanges.

It provides the root reference for Markets, Trading Boards, Instruments, and future market engines.

The table contains only master reference data and therefore experiences very low update frequency.

---

## 21.3 PostgreSQL Definition

```sql
CREATE TABLE market.exchange
(
    ...
);
```

---

## 21.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| exchange_code | VARCHAR(20) | No | — | Business code |
| exchange_name | VARCHAR(200) | No | — | Official exchange name |
| short_name | VARCHAR(50) | Yes | NULL | Abbreviated name |
| country_code | CHAR(2) | Yes | NULL | ISO country code |
| currency_code | CHAR(3) | Yes | NULL | ISO currency |
| timezone_name | VARCHAR(100) | Yes | NULL | Time zone |
| website | VARCHAR(300) | Yes | NULL | Official website |
| description | TEXT | Yes | NULL | Additional notes |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 21.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```sql
exchange_code
```

---

## 21.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 21.7 Generated Columns

None.

---

## 21.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 21.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (exchange_code)
```

---

## 21.10 Foreign Keys

None.

Exchange is the root entity of the market hierarchy.

---

## 21.11 Check Constraints

Typical constraints include

```sql
exchange_code <> ''
```

```sql
char_length(exchange_code) <= 20
```

Additional validation rules may be introduced where appropriate.

---

## 21.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

exchange_code
```

Lookup

```sql
exchange_name
```

---

## 21.13 Partition Strategy

```text
Not Partitioned
```

Reference tables shall not be partitioned.

---

## 21.14 Storage Parameters

Default PostgreSQL storage parameters shall be used.

No custom fillfactor or tablespace is required.

---

## 21.15 Audit Implementation

The Exchange table implements the standard Master Data audit model.

Audit columns

```text
created_at

updated_at

created_by

updated_by

is_active
```

---

## 21.16 DDL Generation Notes

DDL generation shall include:

- identity column;
- UUID column;
- primary key;
- alternate keys;
- lookup indexes;
- audit columns;
- table comments (where applicable).

---

## 21.17 Validation Requirements

Validation shall verify:

- exchange_code uniqueness;
- public_id uniqueness;
- mandatory columns;
- audit defaults;
- constraint implementation.

---

## 21.18 Dependencies

Referenced By

```text
Market

Trading Board

Future Market Engines
```

Depends On

```text
None
```

---

## 21.19 Future Extensions

Future versions may introduce:

- MIC code;
- exchange category;
- trading calendar association;
- settlement information;
- regulatory authority reference.

---

# 22. Table Specification — Market

The Market table represents individual financial markets operating within an Exchange.

Markets are subordinate to Exchanges and provide the next level of organization within the Phoenix market hierarchy.

---

## 22.1 Table Information

| Item | Value |
|------|-------|
| Entity | Market |
| Schema | market |
| Table | market |
| Category | Reference Data |
| Physical Type | Master Table |
| Lifecycle | Static |
| Partitioned | No |

---

## 22.2 Purpose

The Market table stores the markets belonging to a specific Exchange.

Typical examples include equity, bond, derivative, and other organized markets.

---

## 22.3 PostgreSQL Definition

```sql
CREATE TABLE market.market
(
    ...
);
```

---

## 22.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| exchange_id | BIGINT | No | — | Parent exchange |
| market_code | VARCHAR(20) | No | — | Business code |
| market_name | VARCHAR(200) | No | — | Market name |
| short_name | VARCHAR(50) | Yes | NULL | Short name |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 22.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
exchange_id

+

market_code
```

---

## 22.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 22.7 Generated Columns

None.

---

## 22.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 22.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (exchange_id, market_code)
```

---

## 22.10 Foreign Keys

```sql
exchange_id

REFERENCES market.exchange(id)
```

Referential Action

```text
RESTRICT
```

---

## 22.11 Check Constraints

Typical validation includes

```sql
market_code <> ''
```

---

## 22.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

(exchange_id, market_code)
```

Foreign Key

```sql
exchange_id
```

Lookup

```sql
market_name
```

---

## 22.13 Partition Strategy

```text
Not Partitioned
```

---

## 22.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 22.15 Audit Implementation

Standard Master Data audit implementation.

---

## 22.16 DDL Generation Notes

DDL generation shall include:

- foreign key definition;
- supporting foreign key index;
- alternate key;
- audit implementation.

---

## 22.17 Validation Requirements

Validation shall verify:

- foreign key integrity;
- business key uniqueness;
- mandatory columns;
- audit defaults.

---

## 22.18 Dependencies

Depends On

```text
Exchange
```

Referenced By

```text
Trading Board

Future Reference Tables
```

---

## 22.19 Future Extensions

Future implementations may include:

- market classification;
- trading session profile;
- settlement model;
- regulatory framework;
- market operating status.

---

# 23. Table Specification — Trading Board

The **Trading Board** table represents the trading boards operating within a specific Market.

A Trading Board defines the operational environment in which financial instruments are listed and traded.

It is a reference (master) table with relatively static data and serves as a parent entity for listed instruments.

---

## 23.1 Table Information

| Item | Value |
|------|-------|
| Entity | Trading Board |
| Schema | market |
| Table | trading_board |
| Category | Reference Data |
| Physical Type | Master Table |
| Lifecycle | Static |
| Partitioned | No |

---

## 23.2 Purpose

The Trading Board table stores all approved trading boards belonging to individual markets.

It provides the organizational level between Markets and listed Instruments.

---

## 23.3 PostgreSQL Definition

```sql
CREATE TABLE market.trading_board
(
    ...
);
```

---

## 23.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| market_id | BIGINT | No | — | Parent market |
| board_code | VARCHAR(20) | No | — | Business code |
| board_name | VARCHAR(200) | No | — | Official board name |
| short_name | VARCHAR(50) | Yes | NULL | Short name |
| trading_currency | CHAR(3) | Yes | NULL | ISO currency |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 23.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
market_id

+

board_code
```

---

## 23.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 23.7 Generated Columns

None.

---

## 23.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 23.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (market_id, board_code)
```

---

## 23.10 Foreign Keys

```sql
market_id

REFERENCES market.market(id)
```

Referential Action

```text
RESTRICT
```

---

## 23.11 Check Constraints

Typical validation includes

```sql
board_code <> ''
```

---

## 23.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

(market_id, board_code)
```

Foreign Key

```sql
market_id
```

Lookup

```sql
board_name
```

---

## 23.13 Partition Strategy

```text
Not Partitioned
```

---

## 23.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 23.15 Audit Implementation

Standard Master Data audit implementation.

---

## 23.16 DDL Generation Notes

DDL generation shall include:

- foreign key definition;
- supporting foreign key index;
- alternate key;
- audit implementation.

---

## 23.17 Validation Requirements

Validation shall verify:

- parent market existence;
- business key uniqueness;
- mandatory attributes;
- audit defaults.

---

## 23.18 Dependencies

Depends On

```text
Market
```

Referenced By

```text
Instrument

Instrument Listing

Future Trading Rules
```

---

## 23.19 Future Extensions

Future implementations may include:

- trading sessions;
- auction configuration;
- settlement profile;
- quotation rules;
- board operational status.

---

# 24. Table Specification — Sector

The **Sector** table represents the first level of business classification applied to listed companies and financial instruments.

Sector definitions are relatively stable and are shared across multiple services within the Phoenix Platform.

---

## 24.1 Table Information

| Item | Value |
|------|-------|
| Entity | Sector |
| Schema | market |
| Table | sector |
| Category | Reference Data |
| Physical Type | Master Table |
| Lifecycle | Static |
| Partitioned | No |

---

## 24.2 Purpose

The Sector table stores the highest level of business activity classification used throughout the platform.

It provides the parent classification for Industries.

---

## 24.3 PostgreSQL Definition

```sql
CREATE TABLE market.sector
(
    ...
);
```

---

## 24.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| sector_code | VARCHAR(20) | No | — | Business code |
| sector_name | VARCHAR(200) | No | — | Official sector name |
| short_name | VARCHAR(50) | Yes | NULL | Short name |
| display_order | INTEGER | Yes | NULL | Display sequence |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 24.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
sector_code
```

---

## 24.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 24.7 Generated Columns

None.

---

## 24.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 24.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (sector_code)
```

---

## 24.10 Foreign Keys

None.

Sector represents the root of the classification hierarchy.

---

## 24.11 Check Constraints

Typical validation includes

```sql
sector_code <> ''
```

---

## 24.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

sector_code
```

Lookup

```sql
sector_name
```

---

## 24.13 Partition Strategy

```text
Not Partitioned
```

---

## 24.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 24.15 Audit Implementation

Standard Master Data audit implementation.

---

## 24.16 DDL Generation Notes

DDL generation shall include:

- business unique constraints;
- lookup indexes;
- audit columns;
- standard comments.

---

## 24.17 Validation Requirements

Validation shall verify:

- sector uniqueness;
- mandatory attributes;
- audit implementation.

---

## 24.18 Dependencies

Referenced By

```text
Industry
```

Depends On

```text
None
```

---

## 24.19 Future Extensions

Future implementations may include:

- international classification mapping;
- GICS integration;
- ICB integration;
- custom reporting hierarchy;
- external classification identifiers.

---

# 25. Table Specification — Industry

The **Industry** table represents the second level of the enterprise market classification hierarchy.

Each Industry belongs to exactly one Sector and serves as the parent classification for Companies.

The Industry table contains relatively static reference data shared across multiple services of the Phoenix Platform.

---

## 25.1 Table Information

| Item | Value |
|------|-------|
| Entity | Industry |
| Schema | market |
| Table | industry |
| Category | Reference Data |
| Physical Type | Master Table |
| Lifecycle | Static |
| Partitioned | No |

---

## 25.2 Purpose

The Industry table stores approved industry classifications used throughout the Phoenix Platform.

It provides a standardized classification model for listed companies, market analysis, screening, reporting, and future analytics engines.

---

## 25.3 PostgreSQL Definition

```sql
CREATE TABLE market.industry
(
    ...
);
```

---

## 25.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| sector_id | BIGINT | No | — | Parent sector |
| industry_code | VARCHAR(20) | No | — | Business code |
| industry_name | VARCHAR(200) | No | — | Official industry name |
| short_name | VARCHAR(50) | Yes | NULL | Short name |
| display_order | INTEGER | Yes | NULL | Display sequence |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 25.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
sector_id

+

industry_code
```

---

## 25.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 25.7 Generated Columns

None.

---

## 25.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 25.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (sector_id, industry_code)
```

---

## 25.10 Foreign Keys

```sql
sector_id

REFERENCES market.sector(id)
```

Referential Action

```text
RESTRICT
```

---

## 25.11 Check Constraints

Typical validation includes

```sql
industry_code <> ''
```

---

## 25.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

(sector_id, industry_code)
```

Foreign Key

```sql
sector_id
```

Lookup

```sql
industry_name
```

---

## 25.13 Partition Strategy

```text
Not Partitioned
```

---

## 25.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 25.15 Audit Implementation

Standard Master Data audit implementation.

---

## 25.16 DDL Generation Notes

DDL generation shall include:

- foreign key definition;
- supporting foreign key index;
- alternate keys;
- audit implementation.

---

## 25.17 Validation Requirements

Validation shall verify:

- sector integrity;
- business key uniqueness;
- mandatory attributes;
- audit defaults.

---

## 25.18 Dependencies

Depends On

```text
Sector
```

Referenced By

```text
Company
```

---

## 25.19 Future Extensions

Future implementations may include:

- international industry mappings;
- ISIC classifications;
- GICS relationships;
- ICB mappings;
- analytical grouping metadata.

---

# 26. Table Specification — Company

The **Company** table represents legal business entities whose financial instruments are listed within supported exchanges.

It is one of the core master tables of the Phoenix Platform and serves as the parent entity for instruments, corporate actions, financial statements, disclosures, and analytical datasets.

---

## 26.1 Table Information

| Item | Value |
|------|-------|
| Entity | Company |
| Schema | market |
| Table | company |
| Category | Master Data |
| Physical Type | Core Business Entity |
| Lifecycle | Long-lived |
| Partitioned | No |

---

## 26.2 Purpose

The Company table stores canonical information describing listed companies.

The table acts as the authoritative company reference across all services and future market engines.

---

## 26.3 PostgreSQL Definition

```sql
CREATE TABLE market.company
(
    ...
);
```

---

## 26.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| industry_id | BIGINT | No | — | Parent industry |
| company_code | VARCHAR(30) | No | — | Internal company code |
| company_name | VARCHAR(250) | No | — | Official company name |
| short_name | VARCHAR(100) | Yes | NULL | Short company name |
| legal_name | VARCHAR(300) | Yes | NULL | Registered legal name |
| registration_number | VARCHAR(50) | Yes | NULL | Company registration |
| national_identifier | VARCHAR(50) | Yes | NULL | National identifier |
| tax_identifier | VARCHAR(50) | Yes | NULL | Tax identifier |
| incorporation_date | DATE | Yes | NULL | Establishment date |
| website | VARCHAR(300) | Yes | NULL | Official website |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 26.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
company_code
```

---

## 26.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 26.7 Generated Columns

None.

---

## 26.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 26.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (company_code)
```

Additional unique constraints may be defined for:

```text
registration_number

national_identifier
```

when business rules require uniqueness.

---

## 26.10 Foreign Keys

```sql
industry_id

REFERENCES market.industry(id)
```

Referential Action

```text
RESTRICT
```

---

## 26.11 Check Constraints

Typical validation includes

```sql
company_code <> ''
```

```sql
company_name <> ''
```

---

## 26.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

company_code
```

Foreign Key

```sql
industry_id
```

Lookup

```sql
company_name

short_name
```

---

## 26.13 Partition Strategy

```text
Not Partitioned
```

---

## 26.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 26.15 Audit Implementation

The Company table implements the standard Master Data audit model.

---

## 26.16 DDL Generation Notes

DDL generation shall include:

- surrogate identity;
- UUID identifier;
- foreign key implementation;
- business unique constraints;
- lookup indexes;
- audit columns;
- table comments.

---

## 26.17 Validation Requirements

Validation shall verify:

- industry existence;
- company uniqueness;
- mandatory attributes;
- audit implementation;
- constraint integrity.

---

## 26.18 Dependencies

Depends On

```text
Industry
```

Referenced By

```text
Instrument

Corporate Action

Financial Statement

Disclosure

Future Fundamental Analysis Services
```

---

## 26.19 Future Extensions

Future implementations may include:

- international company identifiers;
- LEI (Legal Entity Identifier);
- ESG classifications;
- ownership profile;
- issuer classifications;
- regulatory information;
- listing lifecycle attributes.

---

# 27. Table Specification — Instrument

The **Instrument** table represents financial instruments that are listed and traded within supported markets.

It is one of the central master tables of the Phoenix Platform and acts as the primary reference for market data, trading history, corporate actions, analytics, portfolio management, and future trading engines.

---

## 27.1 Table Information

| Item | Value |
|------|-------|
| Entity | Instrument |
| Schema | market |
| Table | instrument |
| Category | Master Data |
| Physical Type | Core Business Entity |
| Lifecycle | Long-lived |
| Partitioned | No |

---

## 27.2 Purpose

The Instrument table stores the canonical definition of every tradable financial instrument supported by the Phoenix Platform.

Each instrument belongs to exactly one company and one trading board.

The table is referenced extensively throughout operational and analytical datasets.

---

## 27.3 PostgreSQL Definition

```sql
CREATE TABLE market.instrument
(
    ...
);
```

---

## 27.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| public_id | UUID | No | — | Public identifier |
| company_id | BIGINT | No | — | Parent company |
| trading_board_id | BIGINT | No | — | Trading board |
| instrument_code | VARCHAR(30) | No | — | Internal instrument code |
| symbol | VARCHAR(50) | No | — | Trading symbol |
| instrument_name | VARCHAR(250) | No | — | Official instrument name |
| short_name | VARCHAR(100) | Yes | NULL | Short display name |
| isin | VARCHAR(20) | Yes | NULL | International ISIN |
| instrument_type | VARCHAR(50) | No | — | Instrument type |
| listing_date | DATE | Yes | NULL | Listing date |
| delisting_date | DATE | Yes | NULL | Delisting date |
| description | TEXT | Yes | NULL | Description |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |
| is_active | BOOLEAN | No | TRUE | Active status |

---

## 27.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Public Identity

```sql
public_id UUID
```

Business Identity

```text
instrument_code
```

---

## 27.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_active DEFAULT TRUE
```

---

## 27.7 Generated Columns

None.

---

## 27.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 27.9 Alternate Keys

```sql
UNIQUE (public_id)

UNIQUE (instrument_code)
```

Optional unique constraints

```text
ISIN

Symbol within Trading Board
```

---

## 27.10 Foreign Keys

```sql
company_id

REFERENCES market.company(id)
```

```sql
trading_board_id

REFERENCES market.trading_board(id)
```

Referential Action

```text
RESTRICT
```

---

## 27.11 Check Constraints

Typical validation includes

```sql
symbol <> ''
```

```sql
instrument_name <> ''
```

```sql
delisting_date IS NULL
OR
delisting_date >= listing_date
```

---

## 27.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
public_id

instrument_code
```

Foreign Key

```sql
company_id

trading_board_id
```

Lookup

```sql
symbol

instrument_name

isin
```

---

## 27.13 Partition Strategy

```text
Not Partitioned
```

---

## 27.14 Storage Parameters

Default PostgreSQL storage parameters.

---

## 27.15 Audit Implementation

Standard Master Data audit implementation.

---

## 27.16 DDL Generation Notes

DDL generation shall include:

- identity implementation;
- UUID identifier;
- foreign keys;
- business unique constraints;
- lookup indexes;
- audit columns.

---

## 27.17 Validation Requirements

Validation shall verify:

- referenced Company exists;
- referenced Trading Board exists;
- business identifiers remain unique;
- audit implementation is complete.

---

## 27.18 Dependencies

Depends On

```text
Company

Trading Board
```

Referenced By

```text
Daily Market Data

Corporate Action

Orders

Portfolio

Analytics

Indicators

Future Trading Engines
```

---

## 27.19 Future Extensions

Future versions may include:

- Bloomberg identifier;
- Reuters identifier;
- external vendor mappings;
- derivative relationships;
- issuer classifications;
- lifecycle status.

---

# 28. Table Specification — Instrument Listing

The **Instrument Listing** table maintains the listing history of financial instruments.

It records where, when, and under which trading conditions an instrument is listed.

Unlike the Instrument table, this entity supports historical tracking of listing changes.

---

## 28.1 Table Information

| Item | Value |
|------|-------|
| Entity | Instrument Listing |
| Schema | market |
| Table | instrument_listing |
| Category | Operational Reference |
| Physical Type | Historical Entity |
| Lifecycle | Historical |
| Partitioned | No |

---

## 28.2 Purpose

The Instrument Listing table stores the listing lifecycle of every financial instrument.

It enables the Phoenix Platform to maintain historical listing information while preserving complete traceability.

---

## 28.3 PostgreSQL Definition

```sql
CREATE TABLE market.instrument_listing
(
    ...
);
```

---

## 28.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| instrument_id | BIGINT | No | — | Parent instrument |
| trading_board_id | BIGINT | No | — | Trading board |
| listing_symbol | VARCHAR(50) | No | — | Trading symbol |
| listing_status | VARCHAR(30) | No | — | Listing status |
| effective_from | DATE | No | — | Start date |
| effective_to | DATE | Yes | NULL | End date |
| remarks | TEXT | Yes | NULL | Notes |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| created_by | BIGINT | Yes | NULL | Audit |
| updated_by | BIGINT | Yes | NULL | Audit |

---

## 28.5 Identity Strategy

Internal surrogate identifier

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Business uniqueness

```text
Instrument

+

Effective From
```

---

## 28.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP
```

---

## 28.7 Generated Columns

None.

---

## 28.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 28.9 Alternate Keys

```sql
UNIQUE (instrument_id, effective_from)
```

---

## 28.10 Foreign Keys

```sql
instrument_id

REFERENCES market.instrument(id)
```

```sql
trading_board_id

REFERENCES market.trading_board(id)
```

---

## 28.11 Check Constraints

Typical validation

```sql
effective_to IS NULL
OR
effective_to >= effective_from
```

---

## 28.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Foreign Keys

```sql
instrument_id

trading_board_id
```

Lookup

```sql
listing_symbol

listing_status
```

---

## 28.13 Partition Strategy

```text
Not Partitioned
```

Historical volume is expected to remain manageable.

---

## 28.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 28.15 Audit Implementation

Standard operational audit implementation.

---

## 28.16 DDL Generation Notes

DDL generation shall include:

- foreign keys;
- alternate key;
- lookup indexes;
- audit columns.

---

## 28.17 Validation Requirements

Validation shall verify:

- instrument existence;
- board existence;
- effective date consistency;
- uniqueness of historical records.

---

## 28.18 Dependencies

Depends On

```text
Instrument

Trading Board
```

Referenced By

```text
Historical Reports

Listing History

Future Regulatory Services
```

---

## 28.19 Future Extensions

Future implementations may include:

- listing reason;
- suspension history;
- transfer history;
- regulatory approvals;
- listing events.

---

# 29. Table Specification — Trading Calendar

The **Trading Calendar** table defines the official trading calendar used by the Phoenix Platform.

It records trading days, holidays, half-day sessions, and other market calendar events for each supported Exchange and Market.

The Trading Calendar serves as the authoritative source for all time-based processing including market data import, backtesting, analytics, scheduling, and trading engines.

---

## 29.1 Table Information

| Item | Value |
|------|-------|
| Entity | Trading Calendar |
| Schema | market |
| Table | trading_calendar |
| Category | Reference Data |
| Physical Type | Calendar Master |
| Lifecycle | Long-lived |
| Partitioned | No |

---

## 29.2 Purpose

The Trading Calendar provides the official calendar defining whether a specific date is tradable for a given market.

It is referenced throughout the platform to ensure that every time-series process operates only on valid trading sessions.

---

## 29.3 PostgreSQL Definition

```sql
CREATE TABLE market.trading_calendar
(
    ...
);
```

---

## 29.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| exchange_id | BIGINT | No | — | Exchange |
| market_id | BIGINT | Yes | NULL | Market |
| trading_date | DATE | No | — | Trading date |
| day_of_week | SMALLINT | No | — | ISO weekday |
| is_trading_day | BOOLEAN | No | TRUE | Trading day flag |
| is_holiday | BOOLEAN | No | FALSE | Holiday flag |
| holiday_name | VARCHAR(200) | Yes | NULL | Holiday name |
| session_type | VARCHAR(30) | Yes | NULL | Session classification |
| remarks | TEXT | Yes | NULL | Notes |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |

---

## 29.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Business Identity

```text
exchange_id

+

market_id

+

trading_date
```

---

## 29.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

is_trading_day DEFAULT TRUE

is_holiday DEFAULT FALSE
```

---

## 29.7 Generated Columns

None.

---

## 29.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 29.9 Alternate Keys

```sql
UNIQUE
(
    exchange_id,
    market_id,
    trading_date
)
```

---

## 29.10 Foreign Keys

```sql
exchange_id

REFERENCES market.exchange(id)
```

```sql
market_id

REFERENCES market.market(id)
```

---

## 29.11 Check Constraints

Typical validation includes

```sql
day_of_week BETWEEN 1 AND 7
```

---

## 29.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
(exchange_id, market_id, trading_date)
```

Lookup

```sql
trading_date
```

Foreign Keys

```sql
exchange_id

market_id
```

---

## 29.13 Partition Strategy

```text
Not Partitioned
```

Calendar data volume is expected to remain relatively small.

---

## 29.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 29.15 Audit Implementation

Standard operational audit implementation.

---

## 29.16 DDL Generation Notes

DDL generation shall include:

- foreign keys;
- alternate key;
- lookup indexes;
- audit columns.

---

## 29.17 Validation Requirements

Validation shall verify:

- exchange existence;
- market existence;
- calendar uniqueness;
- valid weekday values.

---

## 29.18 Dependencies

Depends On

```text
Exchange

Market
```

Referenced By

```text
Daily Market Data

Trading Engines

Backtesting

Scheduling

Analytics
```

---

## 29.19 Future Extensions

Future implementations may include:

- multiple trading sessions;
- daylight-saving adjustments;
- settlement calendars;
- clearing calendars;
- exchange announcements.

---

# 30. Table Specification — Daily Market Data

The **Daily Market Data** table stores the official end-of-day (EOD) market data for every listed financial instrument.

This table is expected to become one of the largest operational tables within the Phoenix Platform and serves as the primary source for technical analysis, indicators, backtesting, screening, and future machine learning models.

---

## 30.1 Table Information

| Item | Value |
|------|-------|
| Entity | Daily Market Data |
| Schema | trading |
| Table | daily_market_data |
| Category | Operational Data |
| Physical Type | Time-Series |
| Lifecycle | Historical |
| Partitioned | Yes |

---

## 30.2 Purpose

The Daily Market Data table stores historical daily trading information for every financial instrument supported by the platform.

Each record represents exactly one trading day for one instrument.

---

## 30.3 PostgreSQL Definition

```sql
CREATE TABLE trading.daily_market_data
(
    ...
);
```

---

## 30.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| instrument_id | BIGINT | No | — | Instrument |
| trading_date | DATE | No | — | Trading date |
| open_price | NUMERIC(18,4) | No | — | Opening price |
| high_price | NUMERIC(18,4) | No | — | Highest price |
| low_price | NUMERIC(18,4) | No | — | Lowest price |
| close_price | NUMERIC(18,4) | No | — | Closing price |
| adjusted_close_price | NUMERIC(18,4) | Yes | NULL | Adjusted close |
| volume | BIGINT | No | 0 | Trading volume |
| trade_count | INTEGER | Yes | NULL | Number of trades |
| trade_value | NUMERIC(20,2) | Yes | NULL | Trading value |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |

---

## 30.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Business Identity

```text
instrument_id

+

trading_date
```

---

## 30.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP

volume DEFAULT 0
```

---

## 30.7 Generated Columns

None.

---

## 30.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 30.9 Alternate Keys

```sql
UNIQUE
(
    instrument_id,
    trading_date
)
```

---

## 30.10 Foreign Keys

```sql
instrument_id

REFERENCES market.instrument(id)
```

---

## 30.11 Check Constraints

Typical validation includes

```sql
open_price >= 0

high_price >= 0

low_price >= 0

close_price >= 0

volume >= 0
```

---

## 30.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Unique

```sql
(instrument_id, trading_date)
```

Lookup

```sql
trading_date
```

Composite

```sql
(trading_date, instrument_id)
```

---

## 30.13 Partition Strategy

```text
Partition Method

RANGE

Partition Key

trading_date

Interval

Monthly
```

---

## 30.14 Storage Parameters

Large historical dataset.

Default storage parameters may later be optimized based on production workload.

---

## 30.15 Audit Implementation

Standard operational audit implementation.

---

## 30.16 DDL Generation Notes

DDL generation shall include:

- RANGE partitioning;
- partition key definition;
- business unique constraint;
- lookup indexes;
- supporting foreign key index.

---

## 30.17 Validation Requirements

Validation shall verify:

- instrument existence;
- trading day uniqueness;
- numeric consistency;
- partition correctness;
- constraint integrity.

---

## 30.18 Dependencies

Depends On

```text
Instrument

Trading Calendar
```

Referenced By

```text
Indicators

Oscillators

Backtesting

Portfolio Analysis

Screening Engine

Machine Learning

Forecasting

Reporting
```

---

## 30.19 Future Extensions

Future implementations may include:

- vendor identifiers;
- adjusted OHLC values;
- VWAP;
- turnover ratio;
- free-float statistics;
- market capitalization snapshots;
- data quality indicators.

---

# 31. Table Specification — Corporate Action

The **Corporate Action** table stores events that affect listed financial instruments throughout their lifecycle.

Corporate actions modify the economic characteristics of an instrument without altering its fundamental identity. These events are essential for price adjustment, total return calculations, portfolio valuation, and historical data normalization.

The table serves as the authoritative source for all corporate event processing within the Phoenix Platform.

---

## 31.1 Table Information

| Item | Value |
|------|-------|
| Entity | Corporate Action |
| Schema | trading |
| Table | corporate_action |
| Category | Operational Reference |
| Physical Type | Event Table |
| Lifecycle | Historical |
| Partitioned | Yes |

---

## 31.2 Purpose

The Corporate Action table records all approved corporate events affecting listed financial instruments.

Typical corporate actions include:

- Cash Dividend
- Stock Dividend
- Bonus Shares
- Rights Offering
- Stock Split
- Reverse Split
- Capital Increase
- Symbol Change
- Delisting
- Merger
- Acquisition

The table provides the basis for historical price adjustments and corporate event analysis.

---

## 31.3 PostgreSQL Definition

```sql
CREATE TABLE trading.corporate_action
(
    ...
);
```

---

## 31.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| instrument_id | BIGINT | No | — | Instrument |
| action_type | VARCHAR(40) | No | — | Corporate action type |
| announcement_date | DATE | Yes | NULL | Announcement date |
| ex_date | DATE | Yes | NULL | Ex-date |
| record_date | DATE | Yes | NULL | Record date |
| effective_date | DATE | No | — | Effective date |
| ratio | NUMERIC(18,8) | Yes | NULL | Adjustment ratio |
| amount | NUMERIC(20,4) | Yes | NULL | Monetary amount |
| currency_code | CHAR(3) | Yes | NULL | Currency |
| remarks | TEXT | Yes | NULL | Notes |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |

---

## 31.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Business Identity

```text
instrument_id

+

effective_date

+

action_type
```

---

## 31.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP
```

---

## 31.7 Generated Columns

None.

---

## 31.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 31.9 Alternate Keys

```sql
UNIQUE
(
    instrument_id,
    effective_date,
    action_type
)
```

---

## 31.10 Foreign Keys

```sql
instrument_id

REFERENCES market.instrument(id)
```

Referential Action

```text
RESTRICT
```

---

## 31.11 Check Constraints

Typical validation includes

```sql
ratio > 0
```

```sql
amount >= 0
```

---

## 31.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Foreign Key

```sql
instrument_id
```

Composite

```sql
(instrument_id, effective_date)
```

Lookup

```sql
action_type
```

---

## 31.13 Partition Strategy

```text
Partition Method

RANGE

Partition Key

effective_date

Interval

Yearly
```

---

## 31.14 Storage Parameters

Default PostgreSQL storage configuration.

Yearly partitioning is recommended to simplify historical maintenance.

---

## 31.15 Audit Implementation

Standard operational audit implementation.

---

## 31.16 DDL Generation Notes

DDL generation shall include:

- RANGE partitioning;
- foreign key definition;
- alternate key;
- lookup indexes;
- audit columns.

---

## 31.17 Validation Requirements

Validation shall verify:

- instrument existence;
- business key uniqueness;
- valid ratios;
- chronological consistency.

---

## 31.18 Dependencies

Depends On

```text
Instrument
```

Referenced By

```text
Adjusted Price Calculation

Portfolio Valuation

Backtesting

Corporate Event Engine

Reporting
```

---

## 31.19 Future Extensions

Future implementations may include:

- approval workflow;
- source provider tracking;
- document references;
- exchange announcements;
- adjustment calculation metadata.

---

# 32. Table Specification — External Identifier

The **External Identifier** table maintains mappings between Phoenix internal entities and identifiers assigned by external data providers, exchanges, regulators, brokers, and third-party information vendors.

This table enables the platform to integrate multiple heterogeneous data sources while preserving a single canonical internal identifier.

---

## 32.1 Table Information

| Item | Value |
|------|-------|
| Entity | External Identifier |
| Schema | market |
| Table | external_identifier |
| Category | Integration Reference |
| Physical Type | Mapping Table |
| Lifecycle | Long-lived |
| Partitioned | No |

---

## 32.2 Purpose

The External Identifier table stores mappings between Phoenix entities and external systems.

Supported mappings may include:

- Exchange Codes
- Broker Codes
- ISIN
- Bloomberg
- Reuters
- TradingView
- Yahoo Finance
- Custom Vendor Codes

The table supports future multi-provider data integration.

---

## 32.3 PostgreSQL Definition

```sql
CREATE TABLE market.external_identifier
(
    ...
);
```

---

## 32.4 Column Specifications

| Column | PostgreSQL Type | Nullable | Default | Description |
|---------|-----------------|----------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Identity | Primary key |
| entity_type | VARCHAR(50) | No | — | Entity category |
| entity_id | BIGINT | No | — | Internal entity identifier |
| provider_name | VARCHAR(100) | No | — | External provider |
| external_code | VARCHAR(100) | No | — | External identifier |
| external_name | VARCHAR(250) | Yes | NULL | External name |
| effective_from | DATE | Yes | NULL | Effective date |
| effective_to | DATE | Yes | NULL | Expiration date |
| remarks | TEXT | Yes | NULL | Notes |
| created_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |
| updated_at | TIMESTAMP WITH TIME ZONE | No | CURRENT_TIMESTAMP | Audit |

---

## 32.5 Identity Strategy

Internal Identity

```sql
id
BIGINT GENERATED ALWAYS AS IDENTITY
```

Business Identity

```text
provider_name

+

entity_type

+

external_code
```

---

## 32.6 Default Values

```sql
created_at DEFAULT CURRENT_TIMESTAMP

updated_at DEFAULT CURRENT_TIMESTAMP
```

---

## 32.7 Generated Columns

None.

---

## 32.8 Primary Key

```sql
PRIMARY KEY (id)
```

---

## 32.9 Alternate Keys

```sql
UNIQUE
(
    provider_name,
    entity_type,
    external_code
)
```

---

## 32.10 Foreign Keys

No direct foreign keys are defined.

The combination of:

```text
entity_type

+

entity_id
```

supports polymorphic references to multiple business entities.

Referential integrity is enforced by application services.

---

## 32.11 Check Constraints

Typical validation includes

```sql
external_code <> ''
```

```sql
effective_to IS NULL

OR

effective_to >= effective_from
```

---

## 32.12 Indexes

Primary

```sql
PRIMARY KEY (id)
```

Composite

```sql
(entity_type, entity_id)
```

Unique

```sql
(provider_name, entity_type, external_code)
```

Lookup

```sql
external_code
```

---

## 32.13 Partition Strategy

```text
Not Partitioned
```

---

## 32.14 Storage Parameters

Default PostgreSQL storage configuration.

---

## 32.15 Audit Implementation

Standard Master Data audit implementation.

---

## 32.16 DDL Generation Notes

DDL generation shall include:

- business unique constraint;
- composite lookup indexes;
- audit columns;
- table comments.

---

## 32.17 Validation Requirements

Validation shall verify:

- uniqueness of external mappings;
- chronological consistency;
- mandatory provider information.

---

## 32.18 Dependencies

Referenced By

```text
Import Engine

Data Synchronization

External Connectors

Vendor Adapters

Future Integration Services
```

Depends On

```text
Multiple Business Entities
```

---

## 32.19 Future Extensions

Future implementations may include:

- provider priority;
- confidence score;
- synchronization status;
- source provenance;
- automatic reconciliation metadata.

---

# 33. DDL Generation Rules

This document serves as the authoritative specification for generating PostgreSQL DDL scripts within the Phoenix Platform.

All SQL objects created under:

```text
Data/
└── Database/
    └── DDL/
```

shall be derived exclusively from the specifications contained in this document.

Manual interpretation during DDL development is not permitted.

---

## 33.1 Generation Principles

DDL generation shall satisfy the following principles:

- deterministic;
- repeatable;
- architecture compliant;
- traceable;
- repository consistent;
- PostgreSQL optimized.

Generated SQL shall never contradict:

- Enterprise Data Dictionary;
- Logical Database Model;
- Physical Database Model;
- PostgreSQL Physical Database Design;
- PostgreSQL Design Decisions.

---

## 33.2 Generation Sequence

The recommended implementation order is:

```text
Reference Tables

↓

Core Master Tables

↓

Relationship Tables

↓

Operational Tables

↓

Historical Tables

↓

Supporting Objects
```

This sequence minimizes dependency-related deployment issues.

---

## 33.3 Naming Compliance

Generated SQL objects shall comply with Enterprise Naming Standards.

The following objects shall be explicitly named:

```text
Tables

Primary Keys

Foreign Keys

Unique Constraints

Check Constraints

Indexes

Sequences (if applicable)

Comments
```

Automatically generated PostgreSQL names shall not be used.

---

## 33.4 SQL Formatting

Generated SQL scripts shall follow a consistent formatting standard.

Requirements include:

- uppercase SQL keywords;
- lowercase object names;
- one column per line;
- aligned indentation;
- explicit constraint names;
- descriptive comments where required.

---

## 33.5 Object Ordering

Within each CREATE TABLE statement the following order shall be maintained:

```text
Columns

↓

Generated Columns

↓

Primary Key

↓

Alternate Keys

↓

Check Constraints

↓

Foreign Keys

↓

Table Options
```

Indexes shall be created after table creation.

---

## 33.6 Repository Location

Generated table scripts shall be stored under:

```text
Data/
└── Database/
    └── DDL/
        └── Tables/
```

Each table shall have exactly one SQL file.

Example

```text
exchange.sql

market.sql

company.sql

instrument.sql

daily_market_data.sql
```

---

# 34. Validation Rules

Every generated PostgreSQL object shall pass architectural validation before being accepted into the repository.

Validation confirms that implementation remains consistent with the approved architecture.

---

## 34.1 Structural Validation

Each table shall verify:

- table name;
- schema;
- columns;
- data types;
- nullability;
- default values;
- generated columns.

---

## 34.2 Constraint Validation

Validation shall verify:

- primary keys;
- alternate keys;
- foreign keys;
- check constraints;
- constraint names.

---

## 34.3 Index Validation

Validation shall confirm:

- required indexes exist;
- duplicate indexes are absent;
- foreign key indexes exist;
- composite indexes follow specification.

---

## 34.4 Naming Validation

Every generated object shall comply with:

- Enterprise Naming Standard;
- PostgreSQL naming conventions;
- repository standards.

---

## 34.5 Traceability Validation

Each physical object shall remain traceable back to:

```text
Enterprise Data Dictionary

↓

Logical Database Model

↓

Physical Database Model

↓

Physical Design Specification

↓

DDL
```

No object may exist without an approved architectural source.

---

## 34.6 Deployment Validation

Before deployment every generated script shall successfully execute on the supported PostgreSQL version.

Validation shall confirm:

- successful execution;
- dependency correctness;
- referential integrity;
- object creation order.

---

# 35. Traceability Matrix

Every physical database object shall maintain complete architectural traceability.

The purpose of traceability is to ensure that implementation never diverges from approved enterprise architecture.

---

## 35.1 Traceability Flow

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
DDL Scripts
        │
        ▼
Database Deployment
```

---

## 35.2 Object Traceability

Each physical table shall be traceable to:

- originating business entity;
- logical entity;
- approved physical model;
- implementation specification;
- generated SQL script.

---

## 35.3 Repository Traceability

Repository relationships shall remain as follows:

```text
Architecture/
    Solution/
        Data/
            PhysicalDesign/
                TablePhysicalSpecifications.md
                        │
                        ▼
Data/
    Database/
        DDL/
            Tables/
                *.sql
```

The Physical Design directory defines the implementation specification.

The DDL directory contains the executable implementation.

Neither directory shall duplicate the responsibilities of the other.

---

# 36. Related Documents

The following architectural documents define or support this specification:

- Architecture/Solution/Data/ConceptualDataModel.md
- Architecture/Solution/Data/LogicalDatabaseModel.md
- Architecture/Solution/Data/PhysicalDatabaseModel.md
- Architecture/Solution/Data/PhysicalDesign/PostgreSQLPhysicalDatabaseDesign.md
- Architecture/Solution/Data/PhysicalDesign/PostgreSQLDesignDecisions.md
- Data/Dictionary/
- Data/Database/DDL/
- Data/Standards/EnterpriseDatabaseDesignStandard.md

---

# 37. Repository Integration

This document occupies the final architectural position before SQL implementation.

Its primary responsibilities are:

- define complete physical table specifications;
- eliminate implementation ambiguity;
- standardize PostgreSQL table design;
- provide deterministic input for DDL generation.

It shall not duplicate:

- business semantics;
- logical modeling;
- architectural rationale;
- SQL implementation scripts.

---

# 38. Governance

Changes to this document require approval from the Database Architect.

Changes affecting enterprise data architecture additionally require approval from the Enterprise Architect.

Modifications shall preserve:

- architectural consistency;
- implementation traceability;
- repository integrity;
- PostgreSQL compatibility.

---

# 39. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.2 | 2026-07-24 | Complete rewrite of the Table Physical Specifications document to establish the canonical implementation specification for PostgreSQL table generation. |

---

# 40. Final Statement

This document is the canonical implementation specification for PostgreSQL table definitions within the Phoenix Platform.

All table-level DDL scripts located under:

```text
Data/
└── Database/
    └── DDL/
        └── Tables/
```

shall be generated directly from this specification.

No physical table shall be implemented without a corresponding specification in this document.

Likewise, every specification defined herein shall ultimately be realized as executable PostgreSQL DDL, ensuring complete traceability from enterprise architecture to database implementation.

---

