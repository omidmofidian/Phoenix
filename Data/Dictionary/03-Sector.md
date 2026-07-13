# Sector Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Table | market.sector |
| Document | Sector Data Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The `sector` table stores the economic sectors used to classify companies within the Phoenix platform.

Each sector represents the highest level of the business classification hierarchy.

---

# Table Information

| Property | Value |
|----------|-------|
| Schema | market |
| Table | sector |
| Table Type | Master Data |
| Estimated Growth | Very Low |
| Primary Key | id |
| Public Identifier | public_id |

---

# Business Description

A sector is the highest level of company classification.

Each sector:

- Has a unique code.
- Has a unique official name.
- May contain multiple industries.
- Is shared across all exchanges.

---

# Columns

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | BIGINT | No | Internal database identifier |
| public_id | UUID | No | Public identifier |
| sector_code | VARCHAR(20) | No | Unique sector code |
| external_sector_code | VARCHAR(50) | Yes | External provider sector identifier |
| sector_name | VARCHAR(200) | No | Official English name |
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

## Business Keys

```text
sector_code

sector_name
```

---

# Constraints

## Primary Key

```text
PK_sector
```

## Unique Constraints

```text
UX_sector_public_id

UX_sector_sector_code

UX_sector_sector_name
```

---

# Relationships

Parent Tables

None

Child Tables

```text
market.industry
```

Relationship

```text
Sector (1)

↓

Industry (N)
```

---

# Business Rules

- Every sector shall have a unique code.
- Every sector shall have a unique official name.
- A sector may contain multiple industries.
- Historical sectors shall not be physically deleted.
- Deactivation is preferred over deletion.

---

# Indexes

| Index | Type |
|--------|------|
| pk_sector | Primary Key |
| ux_sector_public_id | Unique |
| ux_sector_sector_code | Unique |
| ux_sector_sector_name | Unique |
| idx_sector_active | B-Tree |

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
| sector_code | FIN |
| sector_name | Financial Services |
| local_name | خدمات مالی |
| is_active | TRUE |

---

# Remarks

The sector table is the root of the business classification hierarchy.

Sector classifications are stable and expected to change infrequently.

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