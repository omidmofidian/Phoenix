# Phoenix Platform

# Index Specifications

| Item | Value |
|------|-------|
| Document ID | PHX-DB-SPEC-INDEX-001 |
| Version | 2026.1 |
| Status | Approved |
| Owner | Phoenix Architecture Team |
| Approver | Phoenix Architecture Team |
| Classification | Canonical |
| Last Updated | 2026-07-25 |

---

# 1. Purpose

This document defines the technical specifications governing the implementation of database indexes within the Phoenix Platform.

Its purpose is to establish a consistent and maintainable implementation approach for all database indexes by standardizing index naming, supported index types, implementation options, storage considerations, and database-specific capabilities.

Unlike **IndexDevelopmentStandard**, which defines **when** and **why** indexes shall be created, this document specifies **how** indexes shall be implemented.

---

# 2. Scope

This specification applies to all indexes created for database objects maintained within the Phoenix Platform, including:

- Tables
- Materialized Views
- Partitioned Tables
- Historical Tables
- Analytical Tables

This specification covers:

- Index naming conventions
- Supported index types
- Index implementation options
- SQL implementation guidelines
- Database-specific capabilities
- Performance-related implementation recommendations

This specification does **not** define:

- Business justification for index creation
- Index creation policies
- Index lifecycle management
- Architecture decisions

These topics are governed by **IndexDevelopmentStandard**.

---

# 3. Objectives

The objectives of this specification are to:

- Standardize index implementation across the Phoenix Platform.
- Promote consistent use of PostgreSQL indexing capabilities.
- Improve maintainability and readability of database objects.
- Encourage efficient and predictable index implementation.
- Reduce implementation inconsistencies.
- Provide a common technical reference for database developers.
- Support long-term evolution of database indexing strategies.

---

# 4. Relationship to IndexDevelopmentStandard

The relationship between the two documents is defined as follows.

| Document | Responsibility |
|----------|----------------|
| IndexDevelopmentStandard | Defines why and when indexes shall be created. |
| IndexSpecifications | Defines how approved indexes shall be implemented. |

This specification shall never redefine architectural policies established by **IndexDevelopmentStandard**.

Implementation shall always comply with the policies defined by that standard.

---

# 5. Index Naming Convention

All indexes shall follow a consistent naming convention to ensure readability, maintainability, and administrative efficiency.

Index names shall uniquely identify:

- The indexed object
- The indexed columns
- The index purpose

Names shall be deterministic and easily understandable without requiring inspection of the underlying definition.

---

## 5.1 General Naming Rules

All index names shall:

- Use lowercase characters.
- Use snake_case formatting.
- Be descriptive and concise.
- Avoid abbreviations unless officially standardized.
- Avoid database reserved keywords.
- Be unique within the schema.

---

## 5.2 Naming Pattern

The canonical naming pattern is:

```text
IX_<table_name>_<column_name>
```

For composite indexes:

```text
IX_<table_name>_<column1>_<column2>
```

Examples:

```text
IX_symbol_symbol_code

IX_market_exchange_id

IX_daily_market_data_symbol_id_trade_date
```

---

## 5.3 Unique Indexes

Indexes supporting UNIQUE constraints shall follow the same naming convention.

Examples:

```text
IX_exchange_exchange_code

IX_symbol_isin
```

Constraint names remain governed by **ConstraintDevelopmentStandard**.

---

## 5.4 Composite Indexes

Composite index names shall preserve the column order defined by the index.

Example:

```text
IX_daily_market_data_symbol_id_trade_date
```

Column ordering shall not be rearranged for naming convenience.

---

## 5.5 Expression Indexes

Expression indexes should indicate the indexed expression whenever practical.

Example:

```text
IX_symbol_lower_symbol_code
```

Names should remain concise while clearly identifying the indexed expression.

---

## 5.6 Partial Indexes

Partial indexes shall follow the standard naming convention.

Conditions shall not normally be included in the index name.

Documentation shall describe the associated filtering condition.

---

## 5.7 Partitioned Tables

Indexes created for partitioned tables shall follow the same naming convention as regular tables.

Partition implementation details are governed by **PartitionStrategy**.

---

## 5.8 Deprecated Indexes

Deprecated indexes shall retain their original names until formally removed.

Renaming existing indexes solely to comply with newer naming conventions should be avoided unless justified by broader refactoring activities.

---

# 6. Supported PostgreSQL Index Types

Phoenix Platform adopts the indexing capabilities provided by PostgreSQL.

Index selection shall be based on the workload characteristics and the intended access pattern.

The appropriate index type shall be selected according to the requirements of each database object.

---

## 6.1 B-Tree Index

B-tree is the default and preferred index type for general-purpose workloads.

It shall be used for:

- Equality comparisons (`=`)
- Range searches (`<`, `<=`, `>`, `>=`)
- BETWEEN predicates
- ORDER BY operations
- DISTINCT operations
- Most JOIN operations

Unless another index type provides a clear advantage, B-tree shall be considered the default implementation.

---

## 6.2 Hash Index

Hash indexes are optimized for equality comparisons.

They should only be considered when:

- Queries exclusively perform equality lookups.
- Range searches are not required.
- Performance analysis demonstrates measurable benefits over B-tree.

Hash indexes shall not be used as the default index type.

---

## 6.3 GiST Index

GiST (Generalized Search Tree) indexes support extensible search operations.

Typical use cases include:

- Geometric data
- Spatial searches
- Range types
- Network address types
- Full-text search extensions

GiST indexes shall only be implemented when supported by the application data model.

---

## 6.4 SP-GiST Index

SP-GiST indexes are suitable for partitioned search spaces and specialized data structures.

Typical use cases include:

- Hierarchical structures
- Non-balanced data distributions
- Specialized search algorithms

SP-GiST shall only be used when justified by workload analysis.

---

## 6.5 GIN Index

GIN (Generalized Inverted Index) is optimized for multi-valued data structures.

Typical use cases include:

- JSONB documents
- Arrays
- Full-text search
- Composite values

GIN indexes should be preferred whenever searching within document-oriented data.

---

## 6.6 BRIN Index

BRIN (Block Range Index) is intended for very large tables where data exhibits natural physical ordering.

Typical use cases include:

- Historical data
- Time-series data
- Append-only tables
- Large analytical datasets

BRIN indexes provide minimal storage overhead and should be considered for very large datasets.

---

## 6.7 Bloom Index

Bloom indexes may be used when supported by the target PostgreSQL deployment.

They are intended for workloads involving multiple equality predicates across numerous columns.

Bloom indexes shall only be introduced following performance validation.

---

## 6.8 Index Type Selection

The following table provides general guidance for index selection.

| Requirement | Recommended Index |
|-------------|-------------------|
| Equality search | B-tree |
| Range search | B-tree |
| Sorting | B-tree |
| Join operations | B-tree |
| JSONB search | GIN |
| Array search | GIN |
| Full-text search | GIN / GiST |
| Spatial search | GiST |
| Time-series analytics | BRIN |
| Extremely large historical tables | BRIN |
| Specialized hierarchical search | SP-GiST |

---

## 6.9 Future Compatibility

Future PostgreSQL index types may be adopted following architectural review and performance validation.

This specification shall evolve as PostgreSQL introduces new indexing capabilities.

---

# 7. PostgreSQL Index Implementation Options

This section defines the PostgreSQL-specific implementation options that may be used when creating indexes within the Phoenix Platform.

These options shall be selected according to workload characteristics and implementation requirements.

---

## 7.1 Unique Indexes

Unique indexes enforce value uniqueness while providing efficient lookup performance.

They shall be used when uniqueness is required independently of a PRIMARY KEY constraint.

Example:

```sql
CREATE UNIQUE INDEX IX_symbol_isin
ON symbol (isin);
```

---

## 7.2 Partial Indexes

Partial indexes index only rows satisfying a specified condition.

They are recommended when:

- Only a subset of rows is frequently queried.
- The filtering condition is stable.
- Storage optimization is desirable.

Example:

```sql
CREATE INDEX IX_symbol_active
ON symbol (symbol_code)
WHERE is_active = TRUE;
```

---

## 7.3 Expression Indexes

Expression indexes index the result of an expression rather than the underlying column.

Typical use cases include:

- Case-insensitive searches
- Calculated values
- Derived expressions

Example:

```sql
CREATE INDEX IX_symbol_lower_symbol_code
ON symbol (LOWER(symbol_code));
```

---

## 7.4 INCLUDE Columns

PostgreSQL supports covering indexes through the INCLUDE clause.

Included columns participate in index-only scans without affecting index ordering.

Example:

```sql
CREATE INDEX IX_daily_market_data_symbol_date
ON daily_market_data
(
    symbol_id,
    trade_date
)
INCLUDE
(
    close_price,
    volume
);
```

---

## 7.5 Concurrent Index Creation

Indexes on production systems should normally be created using the CONCURRENTLY option whenever operational requirements prohibit extended table locking.

Example:

```sql
CREATE INDEX CONCURRENTLY IX_symbol_symbol_code
ON symbol (symbol_code);
```

Implementation teams shall evaluate operational trade-offs before selecting concurrent index creation.

---

## 7.6 Fillfactor

Fillfactor specifies the percentage of each index page to be initially filled.

Default PostgreSQL values should normally be used unless workload analysis demonstrates measurable benefit from customization.

Changes to Fillfactor shall be documented.

---

## 7.7 Tablespace

Indexes may be assigned to dedicated tablespaces when required for operational or storage optimization.

Tablespace selection shall comply with the organization's storage strategy.

---

## 7.8 Storage Parameters

PostgreSQL storage parameters shall only be customized when supported by documented performance analysis.

Default storage settings should remain the preferred configuration.

---

## 7.9 Reindex Operations

Indexes requiring rebuild due to fragmentation or corruption shall be recreated using PostgreSQL REINDEX capabilities.

Maintenance operations shall be performed according to operational procedures.

---

## 7.10 Implementation Guidelines

When implementing indexes:

- Prefer the simplest implementation.
- Use PostgreSQL defaults whenever appropriate.
- Avoid unnecessary implementation complexity.
- Document non-default implementation choices.
- Validate implementation using execution plans and performance testing.

Database-specific implementation shall remain consistent across the Phoenix Platform.

---

# 8. Performance Recommendations

The following recommendations support efficient and maintainable index implementations within the Phoenix Platform.

These recommendations complement, but do not replace, the architectural policies defined in **IndexDevelopmentStandard**.

---

## 8.1 Use the Simplest Suitable Index

The simplest index implementation capable of satisfying the workload shall be preferred.

Complex index structures should only be introduced when supported by measurable performance improvements.

---

## 8.2 Minimize Index Maintenance Overhead

Each additional index increases the cost of data modification operations.

Index implementations should therefore minimize unnecessary maintenance while preserving query performance.

---

## 8.3 Prefer Default PostgreSQL Settings

Default PostgreSQL index configuration should be used unless documented performance analysis demonstrates a clear advantage from customization.

Custom configuration shall be justified and documented.

---

## 8.4 Validate Using Execution Plans

Index effectiveness shall be validated using PostgreSQL execution plans.

Validation should confirm that indexes are utilized as intended and provide measurable performance improvements.

---

## 8.5 Monitor Index Utilization

Index usage should be periodically monitored to identify:

- Unused indexes
- Duplicate indexes
- Inefficient indexes
- Opportunities for optimization

Indexes that no longer provide measurable value should be reviewed.

---

## 8.6 Periodically Reassess Index Design

Database workloads evolve over time.

Index implementations should be periodically reviewed to ensure continued alignment with application requirements and performance objectives.

---

# 9. Compliance

Compliance with this specification is mandatory for all database index implementations within the Phoenix Platform.

Database developers and reviewers shall ensure that all implemented indexes conform to this specification.

Implementation deviations shall require documented technical justification and architectural approval.

---

# 10. Related Standards

This specification should be used together with the following documents:

- IndexDevelopmentStandard
- EnterpriseTableConvention
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- QueryExecutionStrategy
- PartitionStrategy
- DatabaseStandardsGovernance

---

# 11. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-25 | Complete rewrite. Refactored as the canonical technical specification for PostgreSQL index implementation. |

