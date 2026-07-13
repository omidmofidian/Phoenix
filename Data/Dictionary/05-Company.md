# Company Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Table | market.company |
| Document | Company Data Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The `company` table stores the master information of legal entities whose financial instruments may be listed on one or more exchanges.

A company is a legal organization and represents the issuer of financial instruments.

This table is considered master data.

---

# Table Information

| Property | Value |
|----------|-------|
| Schema | market |
| Table | company |
| Table Type | Master Data |
| Estimated Growth | Low |
| Primary Key | id |
| Public Identifier | public_id |

---

# Business Description

A company:

- Belongs to exactly one industry.
- May issue one or more financial instruments.
- Has a unique company code.
- Has one official legal name.
- May have one short name.
- May have one national registration identifier.

---

# Columns

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | BIGINT | No | Internal database identifier |
| public_id | UUID | No | Public identifier |
| industry_id | BIGINT | No | Parent industry |
| company_code | VARCHAR(30) | No | Phoenix internal company code |
| external_company_code | VARCHAR(50) | Yes | External provider company identifier |
| legal_name | VARCHAR(300) | No | Official legal name |
| short_name | VARCHAR(150) | Yes | Short display name |
| national_id | VARCHAR(50) | Yes | National registration identifier |
| country_code | CHAR(2) | No | ISO 3166-1 Alpha-2 country code |
| incorporation_date | DATE | Yes | Company incorporation date |
| website | VARCHAR(300) | Yes | Official website |
| description | TEXT | Yes | Optional description |
| is_active | BOOLEAN | No | Company status |
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
industry_id
```

## Business Keys

```text
company_code

legal_name
```

---

# Constraints

## Primary Key

```text
PK_company
```

## Foreign Key

```text
FK_company_industry
```

References

```text
market.industry(id)
```

## Unique Constraints

```text
UX_company_public_id

UX_company_company_code

UX_company_legal_name
```

---

# Relationships

Parent Table

```text
market.industry
```

Child Table

```text
market.instrument
```

Relationship

```text
Industry (1)

↓

Company (N)

↓

Instrument (N)
```

---

# Business Rules

- Every company belongs to exactly one industry.
- Company codes shall be unique.
- Legal names shall be unique.
- A company may issue multiple financial instruments.
- A company cannot exist without an industry.
- Historical company records shall never be physically deleted.
- Company status changes shall be handled through `is_active`.
- External company identifiers are optional and may differ across data providers.
- Phoenix company_code remains immutable and is the canonical business identifier inside the platform.

---

# Indexes

| Index | Type |
|--------|------|
| pk_company | Primary Key |
| ux_company_public_id | Unique |
| ux_company_company_code | Unique |
| ux_company_legal_name | Unique |
| idx_company_industry | B-Tree |
| idx_company_country | B-Tree |
| idx_company_active | B-Tree |

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
| company_code | FULAD |
| legal_name | Foolad Mobarakeh Esfahan Co. |
| short_name | Foolad Mobarakeh |
| national_id | 10100340717 |
| country_code | IR |
| website | https://www.msc.ir |
| is_active | TRUE |

---

# Remarks

A company is a legal entity and should not be confused with a tradable instrument.

A company may issue multiple instruments over its lifetime.

Instrument information is maintained in the `market.instrument` table.

---

# Related Documents

- Market.md
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- STD-006 – Database Standards
- ADR-016 – Public Identifier Strategy

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial version |