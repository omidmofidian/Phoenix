# Table Physical Specifications

---

# Document Information

| Item | Value |
|------|-------|
| Document | Table Physical Specifications |
| Directory | Data/Database/PhysicalDesign |
| Version | 2026.1 |
| Status | Architecture Baseline |
| Database Platform | PostgreSQL 17 |
| Owner | Database Architecture |
| Last Updated | 2026-07-23 |

---

# Purpose

This document defines the physical implementation specifications for every PostgreSQL table in the Phoenix Platform.

It translates the approved Logical Database Model into implementation-ready physical table definitions while preserving all approved business semantics.

This document serves as the primary reference for generating PostgreSQL DDL scripts.

---

# Scope

This specification applies to every physical table implemented within the Phoenix Platform.

For each table, this document defines:

- physical table name;
- schema;
- table classification;
- storage characteristics;
- column ordering;
- identity strategy;
- partition eligibility;
- indexing requirements;
- implementation notes.

Detailed constraint definitions are maintained in **ConstraintSpecifications.md**.

Detailed index definitions are maintained in **IndexSpecifications.md**.

---

# Table Classification

Phoenix tables are classified into the following categories:

| Category | Description |
|----------|-------------|
| Reference | Stable reference data |
| Master | Core business entities |
| Transaction | Operational business data |
| Historical | Immutable historical records |
| Integration | External mapping and synchronization |
| System | Internal platform metadata |

---

# Physical Table Inventory

| Schema | Table | Category | Partitioned | Status |
|---------|-------|----------|-------------|--------|
| market | exchange | Reference | No | Planned |
| market | trading_board | Reference | No | Planned |
| market | sector | Reference | No | Planned |
| market | industry | Reference | No | Planned |
| market | company | Master | No | Planned |
| market | instrument | Master | No | Planned |
| market | instrument_listing | Master | No | Planned |
| trading | trading_calendar | Reference | No | Planned |
| trading | daily_market_data | Historical | Yes | Planned |
| trading | corporate_action | Transaction | No | Planned |
| integration | external_identifier | Integration | No | Planned |

---

# Standard Physical Table Layout

Unless explicitly documented otherwise, every table shall follow the canonical column order.

```text
Primary Key

Public Identifier

Business Key

Foreign Keys

Business Attributes

Operational Attributes

Audit Columns
```

---

# Identity Strategy

Every business table shall contain:

- BIGINT identity primary key
- UUID public identifier
- Business key (where applicable)

Identity generation follows the standards defined in:

- PostgreSQLDesignDecisions.md

---

# Audit Strategy

Master and reference tables shall include:

```text
created_at

updated_at

created_by

updated_by

is_active
```

Historical immutable tables may use a reduced audit model where approved.

---

# Storage Strategy

Each table shall define:

- schema
- tablespace (future)
- storage parameters (future)
- TOAST behavior (where applicable)

---

# Partition Eligibility

Only large historical datasets shall be partitioned.

Current candidates include:

| Table | Strategy |
|--------|----------|
| trading.daily_market_data | RANGE(trading_date) |

Additional partitioned tables require architectural approval.

---

# Physical Specification Template

Each table specification shall include:

1. General Information

2. Physical Columns

3. Identity Strategy

4. Default Values

5. Storage Characteristics

6. Constraints Reference

7. Index Reference

8. Partition Information

9. Performance Notes

10. Implementation Notes

---

# Traceability

Every table specification shall remain traceable to:

- Conceptual Data Model
- Logical Database Model
- Enterprise Data Dictionary
- PostgreSQL Design Decisions

---

# Deliverables

This specification becomes the authoritative source for generating:

- CREATE TABLE
- ALTER TABLE
- COMMENT
- Identity definitions

within the PostgreSQL DDL scripts.

---

# Related Documents

- PostgreSQLPhysicalDatabaseDesign.md
- PostgreSQLDesignDecisions.md
- ConstraintSpecifications.md
- IndexSpecifications.md
- PartitionStrategy.md
- StorageStrategy.md
- Enterprise Data Dictionary

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-23 | Initial physical table specification baseline. |