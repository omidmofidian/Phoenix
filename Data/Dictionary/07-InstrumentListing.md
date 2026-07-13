# Instrument Listing Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | Instrument Listing |
| Schema | market |
| Table | instrument_listing |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Instrument Listing entity represents the admission of a financial instrument to a specific Trading Board.

It defines where and under which trading symbol an Instrument is traded.

This entity separates the concept of an Instrument from its market listing.

---

# Description

An Instrument may be listed on one or more Trading Boards.

Each listing represents an independent business object with its own lifecycle.

Trading data is always associated with an Instrument Listing rather than directly with an Instrument.

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

Instrument Listing has no independent business code.

The business identity is defined by the combination of:

```text
Trading Board

+

Listing Symbol
```

Constraint

```text
UNIQUE (trading_board_id, listing_symbol)
```

---

# Attributes

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| instrument_id | BIGINT | No | Referenced Instrument |
| trading_board_id | BIGINT | No | Trading Board |
| listing_symbol | VARCHAR(30) | No | Trading Symbol |
| listing_date | DATE | No | Listing Date |
| delisting_date | DATE | Yes | Delisting Date |
| listing_status | VARCHAR(20) | No | Listing Status |

---

# Listing Status

Typical values include

```text
ACTIVE

SUSPENDED

DELISTED

PENDING
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

Instrument Listing
```

Foreign Key

```text
instrument_id
```

---

## Parent Entity

Trading Board

```text
Trading Board

1

↓

N

Instrument Listing
```

Foreign Key

```text
trading_board_id
```

---

## Child Entity

Daily Market Data

```text
Instrument Listing

1

↓

N

Daily Market Data
```

---

# Business Rules

An Instrument Listing

- belongs to exactly one Instrument.
- belongs to exactly one Trading Board.
- owns exactly one trading symbol within a Trading Board.
- may become inactive through delisting.
- is the only entity referenced by Daily Market Data.

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
UNIQUE
(
    trading_board_id,
    listing_symbol
)
```

---

## Foreign Keys

```text
instrument_id

REFERENCES market.instrument(id)
```

```text
trading_board_id

REFERENCES market.trading_board(id)
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

(trading_board_id, listing_symbol)
```

Foreign Key Indexes

```text
instrument_id

trading_board_id
```

---

# Audit Columns

Every Instrument Listing contains

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
- Trading Board

Referenced By

- Daily Market Data

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- 06-instrument.md
- 08-trading_calendar.md
- 09-daily_market_data.md
- ADR-017

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |