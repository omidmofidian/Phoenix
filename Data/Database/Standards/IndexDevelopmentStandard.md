# Index Development Standard

| Item | Value |
|------|------|
| Document ID | STD-IDX-001 |
| Version | 1.0 |
| Status | Draft |
| Category | Database Standard |
| Parent Standard | SQLScriptDevelopmentStandard |
| Related Standard | DatabaseDDLDevelopmentStandard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This standard defines the design, implementation, naming, and governance rules for database indexes within the Phoenix Platform.

The objectives are:

- Improve query performance
- Support efficient data retrieval
- Maintain predictable execution plans
- Prevent unnecessary indexes
- Reduce maintenance overhead

---

# 2. Scope

This standard applies to all database indexes including:

- Primary Key Indexes
- Unique Indexes
- Non-Unique Indexes
- Composite Indexes
- Partial Indexes
- Expression Indexes
- Covering Indexes (when supported)

This standard does not apply to:

- Constraints
- Materialized Views
- Search Engine Indexes

---

# 3. Architectural Principles

Every index shall follow these principles.

- Performance First
- Business Driven
- Minimal Redundancy
- Explicit Naming
- Measurable Benefit
- Maintainability

---

# 4. General Rules

Indexes shall only be created when justified.

Indexes shall never be created by default.

Every index must support one or more of:

- Search
- Join
- Sorting
- Aggregation
- Uniqueness

---

# 5. Index Naming Convention

Every index shall have an explicit name.

Pattern

```
IX_<TableName>_<ColumnName>
```

Examples

```
IX_Company_Name

IX_Symbol_Code

IX_DailyMarketData_TradeDate
```

Composite indexes

```
IX_<Table>_<Column1>_<Column2>
```

Example

```
IX_DailyMarketData_Symbol_TradeDate
```

---

# 6. Composite Indexes

Composite indexes shall follow query access patterns.

The column order shall reflect:

1. Equality predicates
2. Range predicates
3. Sorting columns

Poorly ordered composite indexes shall not be approved.

---

# 7. Duplicate Indexes

Duplicate indexes are prohibited.

Before creating a new index the existing indexes shall be reviewed.

---

# 8. Unique Indexes

Unique indexes shall only enforce business uniqueness.

They shall not duplicate primary key indexes.

---

# 9. Partial Indexes

Partial indexes may be used when:

- Most rows are inactive
- Queries target a subset of data
- Performance benefits are measurable

Example

```
WHERE is_active = TRUE
```

---

# 10. Expression Indexes

Expression indexes may be used only when justified.

The indexed expression shall be deterministic.

Example

```
LOWER(symbol_code)
```

---

# 11. Foreign Key Indexes

Foreign key columns should normally have supporting indexes.

Exceptions shall be documented.

---

# 12. Performance Validation

Every index shall be validated using execution plans.

Index creation shall be supported by measurable performance improvements.

---

# 13. Maintenance Considerations

Index maintenance cost shall be considered.

Excessive indexing is prohibited.

Indexes that are no longer used shall be reviewed and removed through controlled migrations.

---

# 14. Storage Considerations

Large indexes should be monitored for storage growth.

Storage optimization shall follow PostgreSQL best practices.

---

# 15. Documentation

Business-critical indexes shall be documented.

The reason for creating each non-trivial index shall be recorded in the SQL script or supporting documentation.

---

# 16. Quality Checklist

Every index shall satisfy the following checklist.

- Explicit Name
- Correct Naming
- Performance Justified
- No Duplicate Index
- Correct Column Order
- Supports Business Queries
- Reviewed Using Execution Plan
- Documented

---

# 17. Related Standards

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- EnterpriseDataTypeStandard

---

# 18. Compliance

All indexes within the Phoenix Platform shall comply with this standard.

Any exception requires an approved ADR.

---

# 19. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |