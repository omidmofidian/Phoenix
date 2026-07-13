# Industry Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Table | market.industry |
| Document | Industry Data Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The `industry` table stores industries that belong to economic sectors.

Industries provide the second level of the business classification hierarchy.

Each industry belongs to exactly one sector.

---

# Table Information

| Property | Value |
|----------|-------|
| Schema | market |
| Table | industry |
| Table Type | Master Data |
| Estimated Growth | Very Low |
| Primary Key | id |
| Public Identifier | public_id |

---

# Business Description

An industry:

- Belongs to exactly one sector.
- Has a unique industry code.
- Has a unique official name.
- May contain multiple companies.
- Is shared across all exchanges.

---

# Columns

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | BIGINT | No | Internal database identifier |
| public_id | UUID | No | Public identifier |
| sector_id | BIGINT | No | Parent sector |
| industry_code | VARCHAR(20) | No | Industry code |
| external_industry_code | VARCHAR(50) | Yes | External provider industry identifier |
| industry_name | VARCHAR(200) | No | Official English name |
| local_name | VARCHAR(200) | No | Official local language name |
| is_active | BOOLEAN | No | Active status |
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
sector_id
```

## Business Keys

```text
industry_code

industry_name
```

---

# Constraints

## Primary Key

```text
PK_industry
```

## Foreign Key

```text
FK_industry_sector
```

References

```text
market.sector(id)
```

## Unique Constraints

```text
UX_industry_public_id

UX_industry_industry_code

UX_industry_industry_name
```

---

# Relationships

Parent Table

```text
market.sector
```

Child Table

```text
market.company
```

Relationship

```text
Sector (1)

↓

Industry (N)

↓

Company (N)
```

---

# Business Rules

- Every industry belongs to exactly one sector.
- Industry codes shall be unique.
- Industry names shall be unique.
- Historical industries shall never be physically deleted.
- Deactivation is preferred over deletion.

---

# Indexes

| Index | Type |
|--------|------|
| pk_industry | Primary Key |
| ux_industry_public_id | Unique |
| ux_industry_industry_code | Unique |
| ux_industry_industry_name | Unique |
| idx_industry_sector | B-Tree |
| idx_industry_active | B-Tree |

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
| industry_code | BANK |
| industry_name | Banking |
| local_name | بانک‌ها |
| is_active | TRUE |

---

# Remarks

Industries provide the intermediate classification level between sectors and companies.

---

# Related Documents

- STD-006 – Database Standards
- ADR-016 – Public Identifier Strategy
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial version |