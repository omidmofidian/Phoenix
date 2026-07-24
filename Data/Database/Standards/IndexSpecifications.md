# Index Specifications

| Property | Value |
|----------|-------|
| Document ID | STD-013 |
| Document Name | Index Specifications |
| Project | Phoenix Platform |
| Version | 1.0 |
| Status | Approved |
| Owner | Phoenix Architecture Team |
| Type | Enterprise Database Standard |

---

# 1. Purpose

This document defines the enterprise standards for designing, naming,
implementing, and maintaining database indexes throughout the Phoenix Platform.

The objective of this standard is to provide a consistent indexing strategy that:

- Improves query performance.
- Supports efficient transaction processing.
- Optimizes analytical workloads.
- Prevents redundant or unnecessary indexes.
- Reduces maintenance overhead.
- Ensures consistency across all database objects.
- Aligns with PostgreSQL 17 best practices.
- Supports long-term scalability of the Phoenix Platform.

This specification applies to all database schemas developed within the
Phoenix Platform, including reference, market, analytics, operational,
configuration, security, audit, and future extension schemas.

---

# 2. Scope

This standard applies to every database object that may require indexing,
including but not limited to:

- Tables
- Materialized Views
- Partitioned Tables
- Large Operational Tables
- Historical Tables
- Analytical Tables

This document defines:

- Index naming conventions.
- Index classifications.
- Design principles.
- Implementation rules.
- PostgreSQL index types.
- Performance recommendations.
- Maintenance guidelines.
- Architecture compliance requirements.

---

# 3. Objectives

The primary objectives of this standard are:

1. Provide predictable query performance.

2. Standardize index implementation across the repository.

3. Support high-volume analytical processing.

4. Minimize unnecessary storage consumption.

5. Reduce write overhead caused by excessive indexing.

6. Ensure every index has a clearly defined business or technical purpose.

7. Maintain long-term consistency throughout the Phoenix Platform.

---

# 4. Index Classification

Indexes within the Phoenix Platform are classified into six categories.

Each category serves a specific architectural purpose and follows dedicated
implementation rules.

---

## 4.1 Primary Key Indexes

Primary Key indexes uniquely identify each record within a table.

Characteristics:

- Automatically created by PostgreSQL.
- Clustered by logical identifier.
- One per table.
- Mandatory.

Example

```sql
CONSTRAINT PK_Company
PRIMARY KEY (company_id);
```

---

## 4.2 Unique Indexes

Unique indexes enforce business uniqueness while improving lookup performance.

Characteristics

- Automatically created by UNIQUE constraints.
- Mandatory for all business keys.
- Should be implemented using constraints rather than CREATE UNIQUE INDEX whenever possible.

Examples

```sql
public_id

code

ticker

isin
```

Example

```sql
CONSTRAINT UQ_Instrument_PublicId
UNIQUE (public_id);
```

---

## 4.3 Foreign Key Indexes

Foreign Key indexes improve JOIN performance and reduce locking during UPDATE
and DELETE operations.

PostgreSQL does not automatically create indexes for foreign keys.

Therefore,

Every Foreign Key in the Phoenix Platform SHALL have a corresponding index,
unless a documented architectural exception has been approved.

Example

```sql
exchange_id

market_id

board_id

industry_id

sector_id

company_id
```

Example

```sql
CREATE INDEX IX_Instrument_Company
ON reference.Instrument (company_id);
```

---

## 4.4 Business Search Indexes

Business Search indexes support the most common application queries.

Typical examples include searches by:

- Business Code
- Name
- Short Name
- External Identifier
- Trading Symbol
- ISIN

Business Search indexes shall be created only when justified by application
workloads.

---

## 4.5 Composite Indexes

Composite indexes optimize queries that filter or sort using multiple columns.

Column order shall always follow expected query selectivity.

Example

```text
(exchange_id, calendar_date)
```

is preferred over

```text
(calendar_date, exchange_id)
```

when Exchange is always specified in application queries.

Composite indexes shall not duplicate existing indexes.

---

## 4.6 Specialized Indexes

Specialized indexes are intended for advanced workloads.

Supported PostgreSQL index families include:

- B-tree
- Hash
- GIN
- GiST
- SP-GiST
- BRIN

Specialized indexes shall be introduced only when justified by workload
analysis and documented design decisions.

---

# 5. Index Naming Convention

All indexes within the Phoenix Platform shall follow a consistent naming
convention to improve repository readability, maintainability, and operational
support.

Index names shall be unique within the owning schema.

The following naming standards are mandatory.

---

## 5.1 Primary Key

Format

```text
PK_<TableName>
```

Example

```text
PK_Exchange
PK_Market
PK_Company
PK_Instrument
```

---

## 5.2 Unique Constraint

Format

```text
UQ_<TableName>_<BusinessKey>
```

Examples

```text
UQ_Exchange_PublicId

UQ_Exchange_Code

UQ_Instrument_ISIN

UQ_TradingCalendar_Exchange_Date
```

---

## 5.3 Foreign Key

Format

```text
FK_<ChildTable>_<ParentTable>
```

Examples

```text
FK_Market_Exchange

FK_Board_Market

FK_Company_Industry

FK_Instrument_Company

FK_TradingCalendar_Exchange

FK_HolidayCalendar_Exchange
```

---

## 5.4 Standard Index

Format

```text
IX_<TableName>_<ColumnName>
```

Examples

```text
IX_Company_Name

IX_Company_EnglishName

IX_Instrument_Ticker

IX_TradingCalendar_CalendarDate
```

---

## 5.5 Composite Index

Format

```text
IX_<TableName>_<Column1>_<Column2>
```

Examples

```text
IX_TradingCalendar_Exchange_CalendarDate

IX_Company_Exchange_Code

IX_Instrument_Company_Ticker
```

---

## 5.6 Partial Index

Format

```text
PIX_<TableName>_<ColumnName>
```

Examples

```text
PIX_Company_IsActive

PIX_Instrument_IsActive
```

---

## 5.7 Specialized Index

Specialized indexes shall use the following prefixes.

| Prefix | Index Type |
|---------|------------|
| GIN | Generalized Inverted Index |
| GIST | Generalized Search Tree |
| SPGIST | Space-partitioned GiST |
| BRIN | Block Range Index |
| HASH | Hash Index |

Examples

```text
GIN_Announcement_Content

GIN_News_Content

BRIN_DailyMarketData_TradeDate
```

---

# 6. General Design Rules

The following architectural rules apply to every index created within the
Phoenix Platform.

---

## Rule IX-001

Every index shall have a clearly documented business or technical purpose.

Indexes shall never be created "just in case."

---

## Rule IX-002

Duplicate indexes are prohibited.

Before creating a new index, existing indexes shall be reviewed.

---

## Rule IX-003

Indexes shall support actual application queries.

Indexes shall be derived from workload analysis rather than assumptions.

---

## Rule IX-004

Column order within composite indexes shall follow query selectivity.

The most selective columns should normally appear first unless application
access patterns require a different order.

---

## Rule IX-005

Indexes shall be as narrow as practical.

Avoid indexing unnecessary columns.

---

## Rule IX-006

Business constraints shall be implemented using PRIMARY KEY or UNIQUE
constraints rather than manually created unique indexes whenever possible.

---

## Rule IX-007

Every Foreign Key should have a supporting index unless an approved
architectural exception has been documented.

---

## Rule IX-008

Index names shall remain stable throughout the lifetime of the database.

Renaming indexes without architectural justification is discouraged.

---

# 7. PostgreSQL Best Practices

The following best practices shall be followed for all indexes created within
the Phoenix Platform.

---

## 7.1 Prefer B-Tree Indexes

B-tree indexes shall be used as the default index type unless another index
type provides a measurable benefit.

Typical use cases include:

- Equality searches
- Range searches
- ORDER BY
- JOIN operations

---

## 7.2 Use BRIN for Very Large Historical Tables

BRIN indexes are recommended for append-only historical tables containing
millions of rows where physical ordering follows insertion order.

Typical examples include:

- DailyMarketData
- IntradayMarketData
- TickData

---

## 7.3 Use GIN for Search Operations

GIN indexes should be used for:

- Full-text search
- JSONB
- Arrays

Examples include:

- News
- Announcements
- Financial Reports

---

## 7.4 Avoid Indexing Low Cardinality Columns

Indexes should generally not be created for columns having very few distinct
values.

Examples include:

- is_active
- is_deleted
- is_weekend
- gender

Partial indexes may be considered when justified.

---

## 7.5 Avoid Over-Indexing

Each additional index increases:

- INSERT cost
- UPDATE cost
- DELETE cost
- Storage consumption
- VACUUM overhead

Indexes shall therefore be created only when justified.

---

# 8. Index Maintenance

Indexes require periodic monitoring and maintenance.

Recommended activities include:

- Detect unused indexes.
- Remove duplicate indexes.
- Monitor index bloat.
- Rebuild fragmented indexes when necessary.
- Review execution plans.
- Update database statistics.

Maintenance activities should be scheduled as part of regular database
administration procedures.

---

# 9. Index Review Checklist

Every new index shall be reviewed using the following checklist.

| Question | Required |
|----------|----------|
| Does the index support a documented query? | Yes |
| Is an equivalent index already present? | No |
| Is the naming convention correct? | Yes |
| Is the index type appropriate? | Yes |
| Does the index improve performance? | Yes |
| Is storage overhead acceptable? | Yes |
| Has PostgreSQL best practice been followed? | Yes |
| Has the index been documented? | Yes |

---

# 10. Compliance

All database objects created within the Phoenix Platform shall comply with this
standard.

Any deviation from this specification shall be documented and approved through
the Architecture Decision Record (ADR) process.

Database reviews, architecture audits, and code reviews shall verify compliance
with this standard before implementation.

---

# 11. References

The following Phoenix standards and architecture documents are related to this
specification.

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- EnterpriseTableConvention
- PostgreSQLDevelopmentGuidelines
- ADR-015 — Market Classification Model
- ADR-026 — Reference Data Normalization Model

---

# 12. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 1.0 | 2026-07-24 | Initial enterprise version. |

---

# 13. Approval

This document is approved as the official enterprise standard governing
database index design throughout the Phoenix Platform.

All future database development activities shall comply with the principles,
rules, and requirements defined in this specification.

Changes to this standard shall be reviewed and approved through the Phoenix
Architecture Governance process.

---

# 14. Summary

This specification establishes a consistent enterprise-wide indexing strategy
for the Phoenix Platform.

By standardizing index naming, classification, implementation rules, PostgreSQL
best practices, and review procedures, the platform achieves:

- Consistent repository structure.
- Predictable query performance.
- Reduced maintenance complexity.
- Improved scalability.
- Better architectural governance.
- Long-term maintainability.

Compliance with this specification is mandatory for all current and future
database objects developed within the Phoenix Platform.

---

