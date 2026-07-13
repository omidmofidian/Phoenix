# Corporate Action Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | Corporate Action |
| Schema | trading |
| Table | corporate_action |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Corporate Action entity represents official events initiated by a company that affect its financial instruments.

Corporate Actions are used to preserve historical market consistency and support adjusted price calculations.

---

# Description

Each Corporate Action represents one official event announced by the issuer or market authority.

Corporate Actions affect one Instrument.

Examples include dividends, capital increases, stock splits and rights offerings.

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

Corporate Action has no business code.

Business identity is defined by:

```text
Instrument

+

Action Type

+

Effective Date
```

---

# Attributes

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| instrument_id | BIGINT | No | Related Instrument |
| action_type | VARCHAR(50) | No | Corporate Action Type |
| announcement_date | DATE | Yes | Official announcement date |
| effective_date | DATE | No | Effective date |
| description | TEXT | Yes | Additional notes |

---

# Corporate Action Types

Typical values include

```text
CASH_DIVIDEND

STOCK_DIVIDEND

CAPITAL_INCREASE

STOCK_SPLIT

REVERSE_SPLIT

RIGHTS_OFFERING

MERGER

DEMERGER
```

---

# Relationships

## Parent Entity

Instrument

```text
Instrument

1

↓

N

Corporate Action
```

Foreign Key

```text
instrument_id
```

---

# Business Rules

A Corporate Action

- belongs to exactly one Instrument.
- may affect historical prices.
- shall never modify historical Daily Market Data directly.
- may be used by adjustment algorithms.
- becomes immutable after publication.

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

## Foreign Key

```text
instrument_id

REFERENCES market.instrument(id)
```

---

# Index Recommendation

Primary Index

```text
id
```

Unique Index

```text
public_id
```

Foreign Key Index

```text
instrument_id
```

Analytical Indexes

```text
effective_date

action_type
```

---

# Audit Columns

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

- Instrument

Referenced By

Future modules

- Price Adjustment Engine
- Portfolio Valuation
- Risk Analytics
- Historical Data Processor

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- 06-instrument.md
- 09-daily_market_data.md
- 11-external_identifier.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |