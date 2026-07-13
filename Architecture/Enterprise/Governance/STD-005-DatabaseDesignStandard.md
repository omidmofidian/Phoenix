# Standard STD-005

# Database Design Standard

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | STD-005 |
| Title | Database Design Standard |
| Version | 1.0 |
| Status | Approved |
| Author | Phoenix Project |
| Date | 2026-06-28 |

---

# Purpose

This standard defines the database design principles for the Phoenix Project.

The goals are:

- Consistency
- Data Integrity
- Performance
- Scalability
- Maintainability

---

# Scope

Applies to every PostgreSQL database object.

---

# Database Platform

Official DBMS

```
PostgreSQL 17
```

---

# Character Set

```
UTF-8
```

---

# Time Zone

```
Asia/Tehran
```

---

# Schemas

The following schemas shall be used.

```
market

analytics

trading

system
```

---

# Naming Convention

All names

```
snake_case
```

Examples

```
daily_price

trade_date

company
```

---

# Primary Keys

Use

```
BIGINT GENERATED ALWAYS AS IDENTITY
```

Column name

```
id
```

---

# Foreign Keys

Format

```
<table>_id
```

Example

```
exchange_id

company_id
```

---

# Date Columns

Operational tables should include

```
created_at

updated_at
```

Timestamp type

```
TIMESTAMP WITH TIME ZONE
```

---

# Financial Data

Prices

```
NUMERIC
```

Never use

```
FLOAT
```

for financial values.

---

# Constraints

Mandatory

- Primary Key
- Foreign Key
- NOT NULL
- CHECK
- UNIQUE (where applicable)

---

# Indexes

Create indexes for

- Foreign Keys
- Frequently searched columns
- Composite search keys

Index naming

```
idx_table_column
```

---

# Views

Naming

```
vw_latest_prices
```

---

# Functions

Naming

```
fn_import_prices
```

---

# Triggers

Naming

```
trg_update_timestamp
```

---

# Migrations

Every structural database change shall be implemented through versioned migration scripts.

Direct modification of database structures is prohibited.

---

# Seed Data

Reference data shall be maintained through version-controlled SQL scripts.

---

# Backup

Database backups shall be stored outside the running container.

---

# References

- ADR-008
- ADR-009
- ADR-010
- STD-003

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Release |