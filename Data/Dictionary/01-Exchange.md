# Exchange Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Table | market.exchange |
| Document | Exchange Data Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The `exchange` table stores the master information of securities exchanges supported by the Phoenix platform.

Each exchange represents an organized financial market where one or more trading boards operate.

This table is considered reference (master) data and changes infrequently.

---

# Table Information

| Property | Value |
|----------|-------|
| Schema | market |
| Table | exchange |
| Table Type | Master Data |
| Estimated Growth | Very Low |
| Primary Key | id |
| Public Identifier | public_id |

---

# Business Description

Each exchange:

- Has a unique exchange code.
- Has a unique official name.
- Belongs to one country.
- Uses one official currency.
- Operates in one official time zone.
- May contain multiple trading boards.

---

# Columns

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | BIGINT | No | Internal database identifier |
| public_id | UUID | No | Public identifier |
| exchange_code | VARCHAR(20) | No | Official exchange code |
| external_exchange_code | VARCHAR(50) | Yes | External provider exchange identifier |
| exchange_name | VARCHAR(200) | No | Official English name |
| local_name | VARCHAR(200) | No | Official local language name |
| country_code | CHAR(2) | No | ISO 3166-1 country code |
| website | VARCHAR(300) | Yes | Official website |
| timezone | VARCHAR(50) | No | IANA time zone |
| currency_code | CHAR(3) | No | ISO 4217 currency code |
| is_active | BOOLEAN | No | Exchange status |
| created_at | TIMESTAMPTZ | No | Record creation time |
| updated_at | TIMESTAMPTZ | No | Last update time |

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

## Business Keys

```text
exchange_code

exchange_name
```

---

# Constraints

## Primary Key

```text
PK_exchange
```

## Unique Constraints

```text
UX_exchange_public_id

UX_exchange_exchange_code

UX_exchange_exchange_name
```

## Check Constraints

```text
country_code must follow ISO 3166-1 Alpha-2

currency_code must follow ISO 4217
```

---

# Relationships

Parent Tables

None

Child Tables

```text
market.trading_board
```

Relationship

```text
Exchange (1)

↓

TradingBoard (N)
```

---

# Business Rules

- Every exchange must have a unique exchange code.
- Every exchange must have a unique official name.
- An exchange cannot be deleted while trading boards exist.
- Country codes shall comply with ISO 3166-1.
- Currency codes shall comply with ISO 4217.
- Time zones shall use IANA identifiers.
- Historical exchange records shall not be physically deleted.

---

# Indexes

| Index | Type |
|--------|------|
| pk_exchange | Primary Key |
| ux_exchange_public_id | Unique |
| ux_exchange_exchange_code | Unique |
| ux_exchange_exchange_name | Unique |
| idx_exchange_active | B-Tree |

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
| exchange_code | TSE |
| exchange_name | Tehran Stock Exchange |
| local_name | بورس اوراق بهادار تهران |
| country_code | IR |
| currency_code | IRR |
| timezone | Asia/Tehran |
| is_active | TRUE |

---

# Remarks

This table contains only master reference data.

Updates are expected to be infrequent and should occur only when official exchange information changes.

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