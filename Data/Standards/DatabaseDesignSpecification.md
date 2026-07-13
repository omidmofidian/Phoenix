# Phoenix Platform

# Database Design Standard

---

| Item | Value |
|------|-------|
| Standard | DDS-2026.1 |
| Title | Database Design Standard |
| Project | Phoenix |
| Status | Approved |
| Version | 2026.1 |
| Owner | Phoenix Architecture Team |
| Approval | Architecture Board |
| Last Updated | 2026-06-29 |

---

# Document Status

| Item | Value |
|------|-------|
| Status | Approved |
| Classification | Internal |
| Owner | Phoenix Architecture Team |
| Approval Authority | Architecture Board |
| Effective Date | 2026-06-29 |
| Review Cycle | Annual |
| Next Review | 2027-06-29 |
| Supersedes | None |
| Superseded By | N/A |

---

# Table of Contents

1. Purpose

2. Scope

3. Objectives

4. General Design Principles

5. Database Architecture

6. Schema Standards

7. Entity Standards

8. Naming Standards

9. Primary Key Standard

10. Public Identifier Standard

11. Business Identifier Standard

12. Foreign Key Standard

13. PostgreSQL Data Type Standard

14. Nullability Rules

15. Audit Strategy

16. Index Strategy

17. Constraint Strategy

18. Partition Strategy

19. Integration Strategy

20. Performance Guidelines

21. Migration Standards

22. Documentation Standards

23. Compliance Checklist

24. References

25. Revision History

---

# 1. Purpose

This document defines the official database design standards for the Phoenix platform.

The purpose of this standard is to establish a single authoritative reference governing:

- Database architecture
- Logical database design
- Physical database design
- Naming conventions
- PostgreSQL implementation
- Performance standards
- Documentation standards

Every database artifact within the Phoenix platform shall comply with this standard.

---

# 2. Scope

This standard applies to:

- Database schemas
- Tables
- Views
- Materialized Views
- Columns
- Constraints
- Primary Keys
- Foreign Keys
- Indexes
- Partitions
- Database Functions
- Stored Procedures
- SQL Scripts
- Database Migrations
- Entity Framework Models

This standard applies to every environment:

- Development
- Test
- Staging
- Production

---

# 3. Objectives

The objectives of this standard are:

- Consistency
- Maintainability
- Scalability
- Performance
- Simplicity
- Predictability
- Security
- Long-term evolution

Every database design decision shall support these objectives.

---

# 4. General Design Principles

The Phoenix database follows the principles below.

---

## Principle 1

Business Domain Independence

Business entities shall never contain infrastructure concerns.

Examples include:

- Provider identifiers
- Integration metadata
- Import metadata

These concerns belong exclusively to the Integration schema.

---

## Principle 2

Single Source of Truth

Each business concept shall be represented exactly once.

Duplicated business data is prohibited unless explicitly documented as a physical optimization.

---

## Principle 3

Immutable Identity

Every persistent entity shall possess an immutable identity.

Primary Keys

Public Identifiers

Business Identifiers

must never change after creation.

---

## Principle 4

Provider Independence

No business entity shall depend upon an external provider.

External systems are connected exclusively through Integration Infrastructure.

---

## Principle 5

Logical Before Physical

Logical design always precedes physical optimization.

Physical optimizations shall never change business semantics.

---

## Principle 6

Performance Through Design

Performance shall be achieved through:

- Correct modeling
- Proper indexing
- Appropriate partitioning

—not through denormalization unless explicitly approved.

---

## Principle 7

Documentation First

No table shall be implemented unless:

- Conceptual Model exists.
- Logical Model exists.
- Physical Model exists.
- Data Dictionary exists.

---

# 5. Database Architecture

The Phoenix platform follows a layered database architecture.

```text
Conceptual Model

↓

Logical Database Model

↓

Physical Database Model

↓

Database Design Standard

↓

DDL

↓

Database Implementation
```

Each layer refines the previous layer.

No lower layer may contradict a higher layer.

---

# 6. Schema Standards

The Phoenix database consists of four logical schemas.

---

## market

Contains master reference data.

Examples

```text
exchange

trading_board

sector

industry

company

instrument

instrument_listing
```

Characteristics

- Low update frequency
- High consistency
- Business-owned

---

## trading

Contains operational market data.

Examples

```text
trading_calendar

daily_market_data

corporate_action
```

Characteristics

- High volume

- Time-series

- Performance optimized

---

## integration

Contains infrastructure entities.

Examples

```text
external_identifier
```

Characteristics

- Provider mappings

- Synchronization metadata

- Integration services

No business entity may contain Integration data.

---

## system

Contains future infrastructure components.

Examples

```text
job_execution

audit_log

configuration

migration_history
```

This schema is reserved for platform infrastructure and operational services.

---
# 7. Entity Standards

Every persistent business entity shall follow the standards defined in this section.

---

## Entity Categories

Entities are classified into three categories.

### Master Data

Master data represents relatively stable business information.

Examples

```text
exchange
trading_board
sector
industry
company
instrument
instrument_listing
```

Characteristics

- Low update frequency
- Long lifecycle
- Business-owned

---

### Operational Data

Operational entities store transactional or time-series information.

Examples

```text
trading_calendar
daily_market_data
corporate_action
```

Characteristics

- High volume
- Frequently queried
- Performance optimized

---

### Infrastructure Data

Infrastructure entities support technical integration and platform services.

Examples

```text
external_identifier
```

Characteristics

- Technical ownership
- No business semantics
- Supports external integrations

---

# 8. Naming Standards

Consistency in naming is mandatory.

---

## General Rules

Names shall be:

- lowercase
- singular
- descriptive
- ASCII only
- separated by underscores

Example

```text
instrument_listing
```

Not

```text
InstrumentListing

InstrumentListings

InstrumentListingTbl
```

---

## Schema Names

Allowed schema names

```text
market

trading

integration

system
```

---

## Table Names

Table names shall represent a single business entity.

Examples

```text
company

instrument

corporate_action
```

---

## Column Names

Column names shall be lowercase snake_case.

Examples

```text
company_name

listing_date

public_id

created_at
```

---

## Boolean Columns

Boolean columns shall begin with:

```text
is_

has_

can_
```

Examples

```text
is_active

is_primary

has_permission
```

---

## Foreign Keys

Foreign keys shall follow:

```text
<entity>_id
```

Examples

```text
company_id

instrument_id

trading_board_id
```

---

## Timestamp Columns

Reserved names

```text
created_at

updated_at
```

No alternative names are allowed.

---

# 9. Primary Key Standard

Every persistent table shall contain:

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

Rules

- Surrogate key
- Immutable
- Never reused
- Never updated
- Never exposed to external systems

No business meaning shall be associated with the primary key.

---

# 10. Public Identifier Standard

Business entities exposed outside the database shall contain:

```sql
public_id UUID NOT NULL
```

Purpose

- Public APIs
- Event publishing
- External references
- Cross-service communication

Rules

- Globally unique
- Immutable
- Never recycled
- Protected by UNIQUE constraint

Operational high-volume tables may omit `public_id` when it provides no business value.

---

# 11. Business Identifier Standard

Business identifiers represent stable business concepts.

Examples

```text
exchange_code

sector_code

company_code

instrument_code
```

Rules

- Human-readable
- Stable
- Unique within business scope
- Protected by UNIQUE constraints

Business identifiers are not primary keys.

---

# 12. Foreign Key Standard

Every relationship shall be enforced through foreign keys.

Naming Rule

```text
<entity>_id
```

Examples

```text
industry_id

company_id

instrument_listing_id

trading_calendar_id
```

Foreign key behavior

```sql
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

Alternative actions must be explicitly documented and approved through an ADR.

---

## Relationship Principles

Foreign keys shall always reference the surrogate primary key (`id`).

Foreign keys shall never reference:

- public_id
- business_code
- external_identifier

This guarantees internal consistency and protects business identifiers from structural dependencies.

---
# 13. PostgreSQL Data Type Standard

Phoenix Platform is standardized on PostgreSQL 17.

Only approved PostgreSQL data types shall be used.

---

## Integer Types

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Primary Keys | BIGINT |
| Foreign Keys | BIGINT |
| Counters | INTEGER |
| Large Counters | BIGINT |

---

## Character Types

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Business Codes | VARCHAR(30) |
| External Codes | VARCHAR(100) |
| Names | VARCHAR(200) |
| Symbols | VARCHAR(30) |
| Descriptions | TEXT |

---

## Numeric Types

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Prices | NUMERIC(20,8) |
| Amounts | NUMERIC(24,8) |
| Ratios | NUMERIC(12,6) |
| Percentages | NUMERIC(8,4) |

Floating-point types (`REAL`, `DOUBLE PRECISION`) shall not be used for financial values.

---

## Date and Time Types

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Calendar Date | DATE |
| Timestamp | TIMESTAMPTZ |

`TIMESTAMPTZ` shall be used for all audit timestamps.

---

## Boolean Type

Boolean values shall use:

```sql
BOOLEAN
```

Allowed values:

```text
TRUE

FALSE
```

---

## UUID Type

Public identifiers shall use:

```sql
UUID
```

---

# 14. Nullability Rules

Nullability shall express business meaning.

---

## NOT NULL

Mandatory business attributes shall be defined as:

```sql
NOT NULL
```

Examples

```text
company_name

instrument_code

listing_symbol

trading_date
```

---

## NULL

Nullable columns are permitted only when:

- Information is optional
- Information may not yet exist
- Historical value is unknown

Examples

```text
isin

announcement_date

valid_to

description
```

---

## Prohibited

Columns shall never be nullable merely for implementation convenience.

---

# 15. Audit Strategy

Audit columns depend on the entity category.

---

## Master Data

Every master entity shall contain:

```text
created_at

updated_at

created_by

updated_by

is_active
```

Examples

```text
company

instrument

industry

instrument_listing
```

---

## Operational Data

High-volume immutable operational entities may contain:

```text
created_at

updated_at
```

Examples

```text
daily_market_data
```

The reduced audit model is an intentional optimization.

---

## Infrastructure Data

Infrastructure entities shall implement the full audit model.

---

# 16. Index Strategy

Indexes shall be created according to the following rules.

---

## Primary Index

Automatically created for:

```text
PRIMARY KEY
```

---

## Unique Index

Required for

```text
public_id

business_code

unique business keys
```

---

## Foreign Key Index

Every foreign key shall have an index.

Examples

```text
company_id

industry_id

instrument_listing_id
```

---

## Analytical Index

Analytical indexes shall be added based on query patterns.

Examples

```text
trading_date

effective_date

volume
```

---

## Composite Index

Composite indexes shall reflect the most common filtering order.

Example

```text
instrument_listing_id

trading_calendar_id
```

---

# 17. Constraint Strategy

The database shall enforce structural integrity.

---

## Primary Keys

Every table shall define exactly one primary key.

---

## Unique Constraints

Business uniqueness shall be enforced through UNIQUE constraints.

---

## Foreign Keys

All logical relationships shall be protected by foreign keys.

---

## Check Constraints

Check constraints shall be used only for simple invariant rules.

Examples

```text
price >= 0

volume >= 0
```

Complex business rules belong to the application layer.

---

# 18. Partition Strategy

Partitioning is reserved for high-volume operational tables.

---

## Current Candidate

```text
daily_market_data
```

---

## Partition Method

```sql
RANGE (trading_date)
```

---

## Partition Interval

Standard interval

```text
Monthly
```

---

## Physical Optimization

The physical model may duplicate immutable attributes to improve performance.

Current approved example

```text
trading_date

stored inside

daily_market_data
```

This optimization shall never change logical relationships.

---

## Partition Naming

Recommended format

```text
daily_market_data_2026_01

daily_market_data_2026_02

daily_market_data_2026_03
```

Partition names shall follow:

```text
<table>_<yyyy>_<mm>
```

---
# 19. Integration Strategy

The Phoenix platform shall isolate all external integration concerns from the business domain.

Integration shall be implemented exclusively through the Integration schema.

---

## Principles

Business entities shall never contain:

- Provider-specific identifiers
- External provider metadata
- Synchronization status
- Import timestamps
- Provider business codes

These concerns belong exclusively to the Integration Infrastructure.

---

## External Identifier

The approved integration mechanism is:

```text
Business Entity

↓

External Identifier

↓

External Provider
```

This strategy is defined in:

```text
ADR-017
```

---

## Future Extensions

Future infrastructure entities may include:

```text
data_provider

import_job

import_log

sync_status

api_token
```

These entities shall reside in the Integration schema.

---

# 20. Performance Guidelines

Database performance shall be achieved through architecture rather than application workarounds.

---

## General Principles

Priority order

1. Correct data model
2. Proper indexing
3. Appropriate partitioning
4. Query optimization
5. Hardware scaling

---

## Query Design

Queries shall

- avoid unnecessary joins
- use indexed predicates
- avoid SELECT *
- return only required columns

---

## Large Tables

High-volume tables shall support

- partition pruning
- index-only scans
- efficient filtering

---

## Historical Data

Historical datasets shall remain immutable whenever possible.

---

# 21. Migration Standards

All schema modifications shall be version controlled.

---

## Requirements

Every schema change shall be performed through migrations.

Direct modification of production databases is prohibited.

---

## Migration Rules

Each migration shall

- be atomic
- be reversible when practical
- contain descriptive names
- include documentation

Example

```text
20260701_AddInstrumentListing
```

---

## Compatibility

Breaking changes require

- Architecture approval
- ADR (if architectural)
- Migration documentation

---

# 22. Documentation Standards

Every persistent entity shall have:

- Conceptual representation
- Logical definition
- Physical definition
- Data Dictionary

No database object may exist without documentation.

---

## Mandatory References

Every major database change shall reference:

- Database Design Standard
- Relevant ADRs
- Data Dictionary
- Physical Database Model

---

# 23. Compliance Checklist

Before implementation, verify the following.

## Architecture

- Conceptual Model approved
- Logical Model approved
- Physical Model approved

## Documentation

- Data Dictionary exists
- ADR references are correct

## Database Design

- Primary Key follows DDS
- Public Identifier follows DDS
- Foreign Keys follow DDS
- Data types follow DDS
- Naming follows DDS
- Indexes follow DDS
- Constraints follow DDS
- Audit strategy follows DDS

## PostgreSQL

- PostgreSQL 17 compatible
- Partition strategy validated
- Performance reviewed

No implementation shall begin until this checklist is satisfied.

---

# 24. References

Architecture documents

```text
ConceptualModel.md

LogicalDatabaseModel.md

PhysicalDatabaseModel.md
```

Architecture Decisions

```text
ADR-015

ADR-016

ADR-017
```

Supporting Documents

```text
Data Dictionary

Architecture Freeze v1.1
```

---

# 25. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Database Design Standard for Phoenix Platform |

---

# Compliance

All database-related deliverables, including DDL scripts, migration scripts, ORM models, seed data, and future database modifications, shall comply with this standard unless an approved ADR explicitly defines an exception.

---

# Approval

This document is the authoritative database design standard for the Phoenix Platform.

All future database artifacts shall comply with this standard.

Any deviation from this standard requires formal approval through an Architecture Decision Record (ADR).

Status

```text
APPROVED

LOCKED

DDS-2026.1
```