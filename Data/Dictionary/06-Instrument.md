# Instrument Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | Instrument |
| Schema | market |
| Table | instrument |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The Instrument entity represents a tradable financial instrument issued by a company.

An Instrument is the business object that becomes available for trading after being listed on one or more Trading Boards through Instrument Listings.

---

# Description

The Instrument entity stores static master data describing financial instruments.

It is independent of:

- Trading Boards
- Market Data
- External Providers

Operational trading information is maintained through:

- Instrument Listing
- Daily Market Data
- Corporate Action

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

Globally unique immutable public identifier.

Purpose

- Public APIs
- External integrations
- Object references

Constraint

```text
UNIQUE
```

---

# Business Identifier

| Name | Type |
|------|------|
| instrument_code | VARCHAR(30) |

Description

Stable internal business identifier.

Example

```text
INS-000123
```

Constraint

```text
UNIQUE
```

---

# Attributes

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| company_id | BIGINT | No | Issuing company |
| instrument_type | VARCHAR(30) | No | Instrument classification |
| isin | VARCHAR(20) | Yes | International Securities Identification Number |
| description | TEXT | Yes | Optional description |

---

# Relationships

## Parent Entity

Company

```text
Company

1

↓

N

Instrument
```

Foreign Key

```text
company_id
```

---

## Child Entity

Instrument Listing

```text
Instrument

1

↓

N

Instrument Listing
```

---

## Child Entity

Corporate Action

```text
Instrument

1

↓

N

Corporate Action
```

---

# Business Rules

An Instrument:

- belongs to exactly one Company.
- may have zero or more Instrument Listings.
- may have zero or more Corporate Actions.
- shall not contain provider-specific identifiers.
- shall not contain market trading information.

---

# Instrument Types

Typical values include:

```text
Common Stock

Preferred Stock

ETF

Bond

Option

Future

Right

Warrant
```

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

## Business Identifier

```text
UNIQUE (instrument_code)
```

---

## Foreign Key

```text
company_id

REFERENCES market.company(id)
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

instrument_code
```

Foreign Key Index

```text
company_id
```

---

# Audit Columns

Every Instrument record contains:

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

- Company

Referenced By

- Instrument Listing
- Corporate Action
- External Identifier

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- 05-company.md
- 07-instrument_listing.md
- ADR-015
- ADR-016
- ADR-017

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |