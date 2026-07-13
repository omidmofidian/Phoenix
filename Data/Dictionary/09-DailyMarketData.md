# Daily Market Data Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | Daily Market Data |
| Schema | trading |
| Table | daily_market_data |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Daily Market Data entity stores end-of-day trading information for each Instrument Listing.

It is the primary operational dataset of the Phoenix platform and serves as the foundation for reporting, analytics, quantitative research and machine learning.

---

# Description

Each record represents the complete trading summary for one Instrument Listing during one official trading session.

Daily Market Data is immutable after market close except for officially published corrections.

The entity is optimized for:

- Historical analysis
- Financial reporting
- Quantitative models
- Time-series processing
- AI datasets

---

# Primary Key

| Name | Type |
|------|------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY |

Description

Internal immutable surrogate identifier.

---

# Business Key

The logical business identity is defined by:

```text
Instrument Listing

+

Trading Date
```

Constraint

```text
UNIQUE
(
    instrument_listing_id,
    trading_calendar_id
)
```

---

# Attributes

## Identity

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| instrument_listing_id | BIGINT | No | Listed instrument |
| trading_calendar_id | BIGINT | No | Trading session |
| trading_date | DATE | No | Physical partition key |

---

## Price Information

| Column | Type | Nullable |
|---------|------|----------|
| open_price | NUMERIC(20,8) | No |
| high_price | NUMERIC(20,8) | No |
| low_price | NUMERIC(20,8) | No |
| close_price | NUMERIC(20,8) | No |
| last_price | NUMERIC(20,8) | Yes |

---

## Trading Statistics

| Column | Type | Nullable |
|---------|------|----------|
| volume | BIGINT | No |
| trade_count | INTEGER | Yes |
| trade_value | NUMERIC(24,8) | Yes |

---

# Relationships

## Parent Entity

Instrument Listing

```text
Instrument Listing

1

↓

N

Daily Market Data
```

Foreign Key

```text
instrument_listing_id
```

---

## Parent Entity

Trading Calendar

```text
Trading Calendar

1

↓

N

Daily Market Data
```

Foreign Key

```text
trading_calendar_id
```

---

# Business Rules

A Daily Market Data record

- belongs to exactly one Instrument Listing.
- belongs to exactly one Trading Calendar.
- represents one completed trading day.
- cannot exist without a valid trading session.
- cannot exist without a valid Instrument Listing.
- is immutable after publication except for official corrections.

---
# Price Validation Rules

The following validation rules apply.

| Rule | Description |
|------|-------------|
| High Price | Greater than or equal to Open, Close, Last and Low |
| Low Price | Less than or equal to Open, Close, Last and High |
| Volume | Greater than or equal to zero |
| Trade Count | Greater than or equal to zero |
| Trade Value | Greater than or equal to zero |

These rules shall be enforced by the application layer.

---

# Constraints

## Primary Key

```text
PRIMARY KEY (id)
```

---

## Business Key

```text
UNIQUE
(
    instrument_listing_id,
    trading_calendar_id
)
```

---

## Foreign Keys

```text
instrument_listing_id

REFERENCES market.instrument_listing(id)
```

```text
trading_calendar_id

REFERENCES trading.trading_calendar(id)
```

---

# Physical Design Note

Although the logical model references Trading Calendar through:

```text
trading_calendar_id
```

the physical model intentionally stores:

```text
trading_date
```

inside the Daily Market Data table.

This is an intentional physical optimization that enables:

- Native PostgreSQL RANGE partitioning
- Efficient partition pruning
- Faster analytical queries
- Reduced JOIN overhead
- Improved historical reporting performance

This denormalization exists only in the Physical Database Model and does not alter the Logical Database Model.

---

# Partition Strategy

Partition Method

```text
RANGE (trading_date)
```

Suggested Partition Interval

```text
Monthly
```

Example

```text
daily_market_data_2026_01

daily_market_data_2026_02

daily_market_data_2026_03
```

---

# Index Recommendation

Primary Index

```text
id
```

Unique Index

```text
(
    instrument_listing_id,
    trading_calendar_id
)
```

Foreign Key Indexes

```text
instrument_listing_id

trading_calendar_id
```

Analytical Indexes

```text
trading_date

close_price

volume
```

Additional indexes may be introduced according to workload analysis.

---

# Audit Columns

Every Daily Market Data record contains

```text
created_at

updated_at
```

Unlike master data entities, `created_by`, `updated_by`, and `is_active` are not required because Daily Market Data is an immutable operational dataset loaded automatically by system processes.

---

# Dependencies

Depends On

- Instrument Listing
- Trading Calendar

Referenced By

Future modules may include:

- Technical Indicators
- Portfolio Valuation
- Risk Analytics
- Backtesting
- AI Feature Store
- Forecasting Models

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- 07-instrument_listing.md
- 08-trading_calendar.md
- 10-corporate_action.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |