# Physical Database Model

---

# Document Information

| Item | Value |
|------|-------|
| Document | Physical Database Model |
| Project | Phoenix |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Physical Database Model defines the PostgreSQL implementation of the Phoenix logical database model.

This document specifies:

- PostgreSQL data types
- Primary key implementation
- Foreign key implementation
- Constraints
- Index strategy
- Naming conventions
- Performance considerations

---

# Scope

This document includes:

- Physical tables
- Physical columns
- Data types
- Primary keys
- Foreign keys
- Unique constraints
- Check constraints
- Indexes
- Partitioning strategy
- Audit columns

This document excludes:

- SQL scripts
- Migration scripts
- Seed data

These topics are documented separately.

---

# Target Database Platform

Database Engine

```text
PostgreSQL 17
```

Character Encoding

```text
UTF-8
```

Time Zone

```text
UTC
```

Collation

```text
Default PostgreSQL Collation
```

---

# Physical Design Principles

The Phoenix physical database follows these principles.

## Standards First

All tables follow one physical standard.

---

## Stable Primary Keys

Every table uses an immutable surrogate primary key.

Implementation

```sql
BIGINT GENERATED ALWAYS AS IDENTITY
```

No table shall use BIGSERIAL.

---

## Public Identifiers

Every master entity exposes a public identifier.

Implementation

```sql
UUID NOT NULL
```

Public identifiers are immutable.

---

## Business Identifiers

Business identifiers remain human-readable.

Examples

```text
exchange_code

board_code

sector_code

industry_code

company_code

instrument_code
```

Business identifiers shall be protected by UNIQUE constraints.

---

## Provider Independence

Business entities shall never contain provider-specific identifiers.

External provider mappings are implemented exclusively inside:

```text
integration.external_identifier
```

---

## Auditability

Audit columns are standardized according to the entity category.

### Master Data Entities

Master data entities shall contain the complete audit column set.

```text
created_at

updated_at

created_by

updated_by

is_active
```

Examples

- exchange
- trading_board
- sector
- industry
- company
- instrument
- instrument_listing

---

### Operational Time-Series Entities

High-volume immutable operational tables may use a reduced audit column set.

```text
created_at

updated_at
```

Examples

- daily_market_data

The omission of user and active-state columns is intentional to reduce storage overhead and improve write performance.
---

# Database Schemas

The physical database contains the following schemas.

```text
market

trading

integration

system
```

---

# Physical Naming Convention

## Schemas

Lowercase

Singular

Examples

```text
market

trading

integration

system
```

---

## Tables

Lowercase

Snake case

Singular

Examples

```text
exchange

company

instrument

daily_market_data
```

---

## Primary Keys

Every table contains

```text
id
```

Implementation

```sql
BIGINT GENERATED ALWAYS AS IDENTITY
```

---

## Public Identifiers

Every master table contains

```text
public_id
```

Implementation

```sql
UUID NOT NULL
```

---

## Foreign Keys

Foreign keys follow the convention

```text
<referenced_table>_id
```

Examples

```text
exchange_id

industry_id

company_id

instrument_id

instrument_listing_id
```

---

## Standard Audit Columns

Audit columns depend on the entity category.

### Master Data

```text
created_at

updated_at

created_by

updated_by

is_active
```

---

### Operational Time-Series

```text
created_at

updated_at
```

Daily Market Data follows the operational audit standard.

---

# PostgreSQL Data Type Standards

| Logical Type | PostgreSQL Type |
|--------------|-----------------|
| Identifier | BIGINT |
| Public Identifier | UUID |
| Code | VARCHAR(30) |
| Name | VARCHAR(200) |
| Description | TEXT |
| Boolean | BOOLEAN |
| Date | DATE |
| Timestamp | TIMESTAMPTZ |
| Integer | INTEGER |
| Decimal | NUMERIC(20,8) |

---
# Market Schema

The **market** schema contains master reference data.

All tables in this schema follow the Phoenix Physical Design Standard.

---

# market.exchange

## Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Public Identifier |
| exchange_code | VARCHAR(30) | No | Business Identifier |
| exchange_name | VARCHAR(200) | No | Official Name |
| exchange_name_en | VARCHAR(200) | Yes | English Name |
| description | TEXT | Yes | Description |
| created_at | TIMESTAMPTZ | No | Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Update Timestamp |
| created_by | UUID | Yes | Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Flag |

## Constraints

Primary Key

```sql
PRIMARY KEY (id)
```

Unique Constraints

```sql
UNIQUE (public_id)

UNIQUE (exchange_code)
```

---

# market.trading_board

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| exchange_id | BIGINT | No |
| board_code | VARCHAR(30) | No |
| board_name | VARCHAR(200) | No |
| board_name_en | VARCHAR(200) | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (exchange_id, board_code)

FOREIGN KEY (exchange_id)
REFERENCES market.exchange(id)
```

---

# market.sector

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| sector_code | VARCHAR(30) | No |
| sector_name | VARCHAR(200) | No |
| sector_name_en | VARCHAR(200) | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (sector_code)
```

---

# market.industry

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| sector_id | BIGINT | No |
| industry_code | VARCHAR(30) | No |
| industry_name | VARCHAR(200) | No |
| industry_name_en | VARCHAR(200) | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (sector_id, industry_code)

FOREIGN KEY (sector_id)
REFERENCES market.sector(id)
```

---

# market.company

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| industry_id | BIGINT | No |
| company_code | VARCHAR(30) | No |
| company_name | VARCHAR(250) | No |
| company_name_en | VARCHAR(250) | Yes |
| national_id | VARCHAR(30) | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (company_code)

FOREIGN KEY (industry_id)
REFERENCES market.industry(id)
```

---

# market.instrument

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| company_id | BIGINT | No |
| instrument_code | VARCHAR(30) | No |
| instrument_type | VARCHAR(30) | No |
| isin | VARCHAR(20) | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (instrument_code)

FOREIGN KEY (company_id)
REFERENCES market.company(id)
```

---

# market.instrument_listing

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| instrument_id | BIGINT | No |
| trading_board_id | BIGINT | No |
| listing_symbol | VARCHAR(30) | No |
| listing_date | DATE | No |
| delisting_date | DATE | Yes |
| listing_status | VARCHAR(20) | No |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (trading_board_id, listing_symbol)

FOREIGN KEY (instrument_id)
REFERENCES market.instrument(id)

FOREIGN KEY (trading_board_id)
REFERENCES market.trading_board(id)
```

---
# Trading Schema

The **trading** schema stores operational and time-series market data.

Tables in this schema are expected to grow continuously.

---

# trading.trading_calendar

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| trading_date | DATE | No |
| is_trading_day | BOOLEAN | No |
| session_name | VARCHAR(50) | No |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (trading_date)
```

---

# trading.daily_market_data

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| instrument_listing_id | BIGINT | No |
| trading_calendar_id | BIGINT | No |
| open_price | NUMERIC(20,8) | No |
| high_price | NUMERIC(20,8) | No |
| low_price | NUMERIC(20,8) | No |
| close_price | NUMERIC(20,8) | No |
| last_price | NUMERIC(20,8) | Yes |
| volume | BIGINT | No |
| trade_count | INTEGER | Yes |
| trade_value | NUMERIC(24,8) | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (
    instrument_listing_id,
    trading_calendar_id
)

FOREIGN KEY (instrument_listing_id)
REFERENCES market.instrument_listing(id)

FOREIGN KEY (trading_calendar_id)
REFERENCES trading.trading_calendar(id)
```

---

# trading.corporate_action

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| public_id | UUID | No |
| instrument_id | BIGINT | No |
| action_type | VARCHAR(50) | No |
| effective_date | DATE | No |
| announcement_date | DATE | Yes |
| description | TEXT | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |
| created_by | UUID | Yes |
| updated_by | UUID | Yes |
| is_active | BOOLEAN | No |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

FOREIGN KEY (instrument_id)
REFERENCES market.instrument(id)
```

---

# Integration Schema

The **integration** schema contains infrastructure tables.

Business tables shall never contain provider-specific identifiers.

---

# integration.external_identifier

## Columns

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No |
| provider_name | VARCHAR(50) | No |
| entity_type | VARCHAR(50) | No |
| entity_id | BIGINT | No |
| external_identifier | VARCHAR(100) | No |
| is_primary | BOOLEAN | No |
| valid_from | DATE | Yes |
| valid_to | DATE | Yes |
| created_at | TIMESTAMPTZ | No |
| updated_at | TIMESTAMPTZ | Yes |

## Constraints

```sql
PRIMARY KEY (id)

UNIQUE (
    provider_name,
    entity_type,
    external_identifier
)
```

---

# Foreign Key Strategy

All foreign keys shall use:

```sql
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

unless explicitly documented otherwise.

---

# Index Strategy

Indexes shall be created for:

- Every Primary Key
- Every Foreign Key
- Every UNIQUE constraint
- Frequently searched Business Codes
- Public Identifiers

Additional indexes shall be defined according to query performance requirements.

---

# Partition Strategy

Only high-volume tables shall be partitioned.

Current candidate:

```text
trading.daily_market_data
```

Partition Method

```text
RANGE (trading_date)
```

Implementation details are documented separately in the DDL specification.

---
# Audit Column Standard

All persistent tables shall implement the following audit columns.

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| created_at | TIMESTAMPTZ | No | Record creation timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last modification timestamp |
| created_by | UUID | Yes | User who created the record |
| updated_by | UUID | Yes | User who last modified the record |
| is_active | BOOLEAN | No | Logical active flag |

---

# Physical Integrity Rules

The following rules apply to every table.

## Primary Key

Every table shall contain:

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

---

## Public Identifier

Every master table shall contain:

```sql
public_id UUID NOT NULL
```

Public identifiers shall be globally unique.

---

## Business Identifier

Business codes shall be protected by UNIQUE constraints.

Examples

```text
exchange_code

board_code

sector_code

industry_code

company_code

instrument_code
```

---

## Foreign Keys

Foreign keys shall use:

```sql
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

unless explicitly documented otherwise.

---

## Nullability Rules

Mandatory business attributes shall be defined as

```sql
NOT NULL
```

Optional business attributes may be nullable.

---

# Time-Series Strategy

The following table is classified as a high-volume time-series table.

```text
trading.daily_market_data
```

To support efficient partitioning, the table shall contain the following columns:

| Column | PostgreSQL Type | Nullable |
|---------|-----------------|----------|
| trading_calendar_id | BIGINT | No |
| trading_date | DATE | No |

## Rationale

Although `trading_date` is logically derived from `trading_calendar`, it is intentionally duplicated in `daily_market_data` to support:

- Native PostgreSQL RANGE partitioning
- Efficient partition pruning
- Simpler analytical queries
- Reduced JOIN overhead for historical datasets

This is an intentional physical denormalization and does not affect the logical model.

---

# Performance Strategy

The physical database shall optimize for:

- Read-heavy workloads
- Historical time-series analysis
- Fast lookup by business code
- Fast lookup by public identifier
- Efficient joins through indexed foreign keys

---

# Index Categories

Indexes are classified into the following categories.

## Primary Indexes

Automatically created for:

- Primary Keys

---

## Unique Indexes

Created for:

- public_id
- Business Codes

---

## Foreign Key Indexes

Created for every foreign key.

Examples

```text
exchange_id

sector_id

industry_id

company_id

instrument_id

instrument_listing_id

trading_calendar_id
```

---

## Analytical Indexes

Created where required for:

- trading_date
- listing_symbol
- action_type
- effective_date

---

# Physical Model Summary

## market

- exchange
- trading_board
- sector
- industry
- company
- instrument
- instrument_listing

## trading

- trading_calendar
- daily_market_data
- corporate_action

## integration

- external_identifier

## system

Reserved for future infrastructure components.

---

# Architecture Decisions Applied

This Physical Database Model implements the following architecture decisions.

- ADR-015 — Public Identifier Strategy
- ADR-016 — Primary Key Strategy
- ADR-017 — External Identifier Mapping Strategy

---

# References

- ConceptualModel.md
- LogicalDatabaseModel.md
- Data Dictionary
- ArchitectureFreeze-v1.1.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-12 | Initial Physical Model |
| 1.1 | 2026-06-29 | Architecture Freeze v1.1, PostgreSQL 17 standard adopted, GENERATED ALWAYS AS IDENTITY adopted, Instrument Listing promoted to business entity, DailyMarketData linked to Instrument Listing, Integration schema introduced, External Identifier Mapping implemented |