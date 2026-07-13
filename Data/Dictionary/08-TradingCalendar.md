# Trading Calendar Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | Trading Calendar |
| Schema | trading |
| Table | trading_calendar |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Trading Calendar entity defines all official trading sessions recognized by the Phoenix platform.

It serves as the authoritative reference for trading dates and market sessions.

---

# Description

Trading Calendar stores the official calendar of market activity.

Each record represents one trading date.

Trading Calendar is referenced by Daily Market Data and ensures that market data can only exist for valid trading sessions.

---

# Primary Key

| Name | Type |
|------|------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY |

Description

Internal immutable surrogate identifier.

---

# Public Identifier

| Name | Type |
|------|------|
| public_id | UUID |

Description

Globally unique immutable identifier.

Constraint

```text
UNIQUE
```

---

# Business Identifier

The business identity is the trading date.

Constraint

```text
UNIQUE (trading_date)
```

---

# Attributes

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| trading_date | DATE | No | Official trading date |
| session_name | VARCHAR(50) | No | Trading session |
| is_trading_day | BOOLEAN | No | Indicates whether trading is allowed |

---

# Session Types

Typical values include

```text
REGULAR

PRE_OPEN

POST_CLOSE

HOLIDAY
```

Additional session types may be introduced in future versions.

---

# Relationships

## Child Entity

Daily Market Data

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

A Trading Calendar record

- represents exactly one calendar date.
- may represent either a trading day or a non-trading day.
- shall be unique by trading date.
- may be referenced by many Daily Market Data records.
- cannot be deleted while referenced by trading data.

---

# Constraints

## Primary Key

```text
PRIMARY KEY (id)
```

---

## Public Identifier

```text
UNIQUE (public_id)
```

---

## Business Key

```text
UNIQUE (trading_date)
```

---

# Index Recommendation

Primary Index

```text
id
```

Unique Indexes

```text
public_id

trading_date
```

---

# Audit Columns

Every Trading Calendar record contains

```text
created_at

updated_at

created_by

updated_by

is_active
```

---

# Dependencies

Depends On

None

Referenced By

- Daily Market Data

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- 07-instrument_listing.md
- 09-daily_market_data.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |