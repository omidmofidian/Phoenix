# Trading Board Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Table | market.trading_board |
| Document | Trading Board Data Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The `trading_board` table stores the trading boards operated by each securities exchange.

A trading board defines a market segment where financial instruments are listed and traded.

Each trading board belongs to exactly one exchange.

---

# Table Information

| Property | Value |
|----------|-------|
| Schema | market |
| Table | trading_board |
| Table Type | Master Data |
| Estimated Growth | Low |
| Primary Key | id |
| Public Identifier | public_id |

---

# Business Description

A trading board:

- Belongs to one exchange.
- Has a unique code within its exchange.
- Has an official name.
- May contain many listed instruments.
- May become inactive without being deleted.

---

# Columns

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | BIGINT | No | Internal database identifier |
| public_id | UUID | No | Public identifier |
| exchange_id | BIGINT | No | Parent exchange |
| board_code | VARCHAR(20) | No | Trading board code |
| external_board_code | VARCHAR(50) | Yes | External provider board identifier |
| board_name | VARCHAR(200) | No | Official English name |
| local_name | VARCHAR(200) | No | Official local language name |
| display_order | INTEGER | No | Display sequence |
| description | VARCHAR(500) | Yes | Optional description |
| is_active | BOOLEAN | No | Trading board status |
| created_at | TIMESTAMPTZ | No | Record creation timestamp |
| updated_at | TIMESTAMPTZ | No | Last update timestamp |

---

# Keys

## Primary Key

```text
id
```

## Public Identifier

```text
public_id
```

## Foreign Key

```text
exchange_id
```

## Business Key

```text
(exchange_id, board_code)
```

---

# Constraints

## Primary Key

```text
PK_trading_board
```

## Foreign Key

```text
FK_trading_board_exchange
```

References

```text
market.exchange(id)
```

## Unique Constraints

```text
UX_trading_board_public_id

UX_trading_board_exchange_board_code
```

---

# Relationships

Parent Table

```text
market.exchange
```

Child Table

```text
market.instrument_listing
```

Relationship

```text
Exchange (1)

↓

TradingBoard (N)

↓

InstrumentListing (N)
```

---

# Business Rules

- Every trading board belongs to exactly one exchange.
- Board codes must be unique within the same exchange.
- A trading board may contain many listed instruments.
- Historical trading boards shall never be physically deleted.
- Deactivation is preferred over deletion.

---

# Indexes

| Index | Type |
|--------|------|
| pk_trading_board | Primary Key |
| ux_trading_board_public_id | Unique |
| ux_trading_board_exchange_board_code | Unique |
| idx_trading_board_exchange | B-Tree |
| idx_trading_board_active | B-Tree |

---

# Default Values

| Column | Default |
|---------|---------|
| public_id | gen_random_uuid() |
| is_active | TRUE |
| created_at | CURRENT_TIMESTAMP |
| updated_at | CURRENT_TIMESTAMP |

---

# Sample Record

| Column | Example |
|---------|---------|
| board_code | FIRST |
| board_name | First Market |
| local_name | بازار اول |
| display_order | 1 |
| is_active | TRUE |

---

# Remarks

Trading boards classify market segments inside an exchange.

Instrument membership is managed through the `instrument_listing` table.

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- ADR-016
- STD-006 – Database Standards

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial version |