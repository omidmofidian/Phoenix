# STD-006: Database Standards

---

# Document Information

| Item | Value |
|------|-------|
| Standard | Database Standards |
| Code | STD-006 |
| Project | Phoenix |
| Version | 1.0 |
| Status | Approved |
| Date | 2026-06-29 |

---

# Purpose

This standard defines the common database rules that apply to all database objects in the Phoenix platform.

The objective is to ensure:

- Consistency
- Maintainability
- Performance
- Scalability
- Readability

---

# Applies To

This standard applies to:

- All Schemas
- All Tables
- All Views
- All Materialized Views
- All Future Modules

---

# Naming Convention

## Schemas

- lowercase
- singular

Example

```text
market
trading
analytics
system
```

---

## Tables

- lowercase
- snake_case
- singular

Example

```text
exchange

instrument

instrument_listing

daily_market_data
```

---

## Columns

- lowercase
- snake_case

Example

```text
company_id

instrument_id

public_id

created_at
```

---

# Identifier Strategy

Every table shall contain two identifiers.

## Internal Identifier

Column

```text
id
```

Type

```text
BIGINT GENERATED ALWAYS AS IDENTITY
```

Purpose

- Primary Key
- Foreign Keys
- Internal joins

---

## Public Identifier

Column

```text
public_id
```

Type

```text
UUID
```

Default

```sql
gen_random_uuid()
```

Purpose

- REST APIs
- External Integrations
- Event Messages
- Future SOA
- Future Microservices

---

# Standard Audit Columns

Every table shall contain

```text
created_at

updated_at
```

Type

```text
TIMESTAMPTZ
```

Defaults

```sql
CURRENT_TIMESTAMP
```

---

# Active Status

Master tables shall contain

```text
is_active BOOLEAN
```

Default

```sql
TRUE
```

Records should be deactivated rather than physically deleted.

---

# Primary Keys

Every table shall contain

```text
id
```

Primary Key naming convention

```text
pk_<table_name>
```

---

# Foreign Keys

Naming convention

```text
<parent_table>_id
```

Example

```text
company_id

industry_id

exchange_id
```

---

# Unique Constraints

Naming convention

```text
ux_<table>_<column>
```

Example

```text
ux_company_public_id

ux_company_company_code
```

---

# Index Naming

Primary Key

```text
pk_<table>
```

Unique

```text
ux_<table>_<column>
```

Foreign Key

```text
idx_<table>_<foreign_key>
```

Composite

```text
idx_<table>_<column1>_<column2>
```

---

# Timestamp Policy

All timestamps shall use

```text
TIMESTAMPTZ
```

Timezone

```text
Asia/Tehran
```

Application layer should always store UTC where applicable.

---

# Deletion Policy

Reference data shall never be physically deleted.

Preferred approach

```text
Soft Delete

or

Deactivate
```

---

# UUID Policy

UUID values shall never change after creation.

UUID values shall never be reused.

UUID values shall be exposed through APIs instead of internal numeric identifiers.

---

# References

- ADR-016
- PhysicalDatabaseModel.md
- ArchitectureFreeze-v1.0.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial version |