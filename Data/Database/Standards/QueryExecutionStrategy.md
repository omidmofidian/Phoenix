# Query Execution Strategy

| Property | Value |
|----------|-------|
| Document ID | STD-016 |
| Document Name | Query Execution Strategy |
| Project | Phoenix Platform |
| Version | 1.0 |
| Status | Approved |
| Owner | Phoenix Architecture Team |
| Type | Enterprise Database Standard |

---

# 1. Purpose

This document defines the enterprise standards governing query execution,
query optimization, and execution plan analysis within the Phoenix Platform.

The objective of this standard is to establish a consistent methodology for
evaluating, optimizing, and maintaining SQL query performance throughout the
entire platform.

This specification provides guidance for:

- Query execution planning.
- Execution plan interpretation.
- PostgreSQL optimizer behavior.
- Performance analysis.
- Query tuning.
- Statistics management.
- Performance review procedures.
- Long-term optimization practices.

The strategy defined in this document aligns with PostgreSQL 17 best
practices and the architectural principles of the Phoenix Platform.

---

# 2. Scope

This standard applies to every SQL statement executed within the Phoenix
Platform, including:

- SELECT statements
- INSERT statements
- UPDATE statements
- DELETE statements
- MERGE statements
- Materialized View refresh operations
- Reporting queries
- Analytical queries
- Batch processing
- Administrative SQL

This standard applies to every database schema including:

- reference
- market
- analytics
- operational
- configuration
- security
- audit

The principles defined in this specification shall be considered during
database design, software development, code review, database review, and
performance tuning activities.

---

# 3. Relationship to Other Database Standards

QueryExecutionStrategy defines how PostgreSQL executes SQL statements, evaluates execution plans, and selects execution strategies during runtime.

This standard does not define the implementation of database objects.

Implementation details for database objects are governed by dedicated standards, including:

| Standard | Responsibility |
|----------|----------------|
| IndexSpecifications | Index implementation |
| TableDevelopmentStandard | Table implementation |
| ConstraintDevelopmentStandard | Constraint implementation |
| PartitionStrategy | Partition architecture |
| StorageStrategy | Physical storage architecture |

QueryExecutionStrategy focuses on runtime execution behavior rather than physical database implementation.

---

# 4. Objectives

The primary objectives of this standard are:

1. Establish a consistent enterprise approach to query optimization.

2. Improve SQL execution performance.

3. Minimize unnecessary resource consumption.

4. Reduce execution latency.

5. Promote efficient use of PostgreSQL query planner capabilities.

6. Support predictable database performance.

7. Standardize execution plan analysis across the Phoenix Platform.

8. Improve long-term maintainability of SQL code.

9. Enable objective performance reviews during architecture and code review.

10. Align query optimization practices with PostgreSQL 17 best practices.

---

# 5. Query Optimization Principles

Query optimization is an integral part of enterprise database architecture.

Every SQL statement shall be designed to achieve the required business
functionality while minimizing resource consumption.

Optimization efforts shall focus on measurable improvements rather than
assumptions.

Query optimization shall be performed throughout the software lifecycle,
including:

- Database design
- Application development
- Code review
- Performance testing
- Production monitoring

Optimization decisions shall always preserve correctness and maintainability.

---

# 6. PostgreSQL Query Planner

The PostgreSQL Query Planner is responsible for determining the most efficient
execution strategy for every SQL statement.

The planner evaluates multiple execution alternatives before selecting the
lowest estimated cost plan.

Planner decisions are based on:

- Table statistics
- Index availability
- Data distribution
- Join selectivity
- Estimated row counts
- Storage characteristics
- Available system resources

The Query Planner evaluates available database structures but does not define their implementation.

Implementation details for indexes, partitions, and storage structures are governed by their respective standards.

Application developers shall understand planner behavior before attempting
manual query optimization.

---

## 6.1 Planner Cost Model

The PostgreSQL planner estimates execution cost using an internal cost model.

Estimated cost represents a relative measurement rather than elapsed time.

Planner cost is influenced by:

- Sequential page reads
- Random page reads
- CPU processing
- Join complexity
- Sort operations
- Aggregate operations
- Parallel execution

Lower estimated cost generally indicates a more efficient execution strategy.

---

## 6.2 Statistics

Accurate statistics are essential for effective query planning.

The planner relies on statistics to estimate:

- Row counts
- Data distribution
- Value selectivity
- Null fraction
- Distinct values

Outdated statistics may result in poor execution plans.

Automatic ANALYZE shall remain enabled.

Manual ANALYZE may be executed following:

- Bulk data loads
- Large updates
- Major maintenance operations

---

# 7. Execution Plan Analysis

Execution plans shall be reviewed whenever:

- Query performance becomes unacceptable.
- New indexes are introduced.
- Database schema changes.
- Large datasets are imported.
- Major PostgreSQL upgrades occur.
- Performance regression is suspected.

Execution plan analysis shall focus on identifying the actual execution
strategy selected by the planner rather than validating developer
expectations.

---

## 7.1 EXPLAIN

The EXPLAIN command displays the estimated execution plan selected by the
planner.

Typical review items include:

- Estimated cost
- Estimated rows
- Join order
- Scan methods
- Sort operations
- Aggregate operations

EXPLAIN should be the first step of every performance investigation.

---

## 7.2 EXPLAIN ANALYZE

EXPLAIN ANALYZE executes the SQL statement and reports actual execution
statistics.

Reported information includes:

- Actual execution time
- Actual row counts
- Loop counts
- Buffer usage (when enabled)
- Planning time
- Execution time

EXPLAIN ANALYZE provides the most reliable method for validating planner
estimates.

Its execution should be performed carefully on production systems because
the statement is actually executed.

---

# 8. Scan Strategies

The following scan strategies describe execution behaviors selected by the PostgreSQL Query Planner.

These sections explain execution plan interpretation and shall not be interpreted as implementation guidance for database indexes.

The PostgreSQL Query Planner selects an appropriate scan strategy based on
table statistics, index availability, data distribution, and estimated cost.

Understanding scan strategies is essential for interpreting execution plans.

---

## 8.1 Sequential Scan

Sequential Scan reads every row of a table.

This strategy is appropriate when:

- The table is small.
- A large percentage of rows must be returned.
- No suitable index exists.
- Sequential access is less expensive than index traversal.

A Sequential Scan is not inherently inefficient and shall not be considered a
performance issue without workload analysis.

---

## 8.2 Index Scan

Index Scan retrieves qualifying rows through an index.

Typical characteristics include:

- Efficient point lookups.
- Efficient selective filtering.
- Ordered data retrieval.
- Reduced disk I/O for highly selective queries.

Index Scan should be expected for highly selective predicates.

---

## 8.3 Index Only Scan

Index Only Scan retrieves all required information directly from an index
without accessing the underlying table.

This strategy provides excellent performance when:

- Required columns exist within the index.
- Visibility Map information is current.
- Heap access can be avoided.

Index Only Scan should be considered during index design for frequently
executed read-only queries.

---

## 8.4 Bitmap Index Scan

Bitmap Index Scan combines index lookups with bitmap processing before
accessing table pages.

This strategy is typically selected when:

- Multiple rows satisfy the search condition.
- Multiple indexes are combined.
- Direct Index Scan becomes inefficient.

Bitmap scans often represent an effective compromise between Sequential Scan
and Index Scan.

---

## 8.5 Scan Selection

Developers shall not force scan methods unless justified by measurable
performance improvements.

The PostgreSQL planner shall normally determine the most appropriate scan
strategy.

---

# 9. Join Strategies

The planner automatically selects an appropriate join algorithm.

Selection depends upon:

- Estimated row counts
- Join selectivity
- Available indexes
- Memory availability
- Estimated execution cost

---

## 9.1 Nested Loop Join

Nested Loop Join is appropriate when:

- One input is relatively small.
- Indexes exist on the joined columns.
- Highly selective filtering is present.

---

## 9.2 Merge Join

Merge Join requires sorted input.

Typical characteristics:

- Efficient for large sorted datasets.
- Performs well with ordered indexes.
- Reduces repeated comparisons.

---

## 9.3 Hash Join

Hash Join builds an in-memory hash table for one relation before processing
the second relation.

Typical characteristics:

- Efficient for large joins.
- Does not require sorted input.
- Frequently selected for analytical workloads.

Adequate working memory is essential for efficient Hash Join execution.

---

# 10. Parallel Execution

PostgreSQL supports parallel query execution for suitable workloads.

Parallel execution may improve performance for:

- Large table scans.
- Aggregation.
- Analytical queries.
- Parallel index operations.

Parallel execution is not beneficial for every workload.

The planner shall determine whether parallel execution provides measurable
benefit.

---

## 10.1 Parallel Workers

The planner estimates the optimal number of parallel workers based on:

- Estimated execution cost.
- Available CPU resources.
- Table size.
- Configuration parameters.

Application code shall not assume that parallel execution will always occur.

---

## 10.2 Parallel Safety

Database functions used within SQL statements should be classified correctly
regarding parallel execution.

Functions marked as unsafe may prevent the planner from selecting a parallel
execution plan.

Parallel safety should be considered during function design and database code
review.

---

# 11. Query Optimization Best Practices

The following best practices shall be followed for all SQL statements
developed within the Phoenix Platform.

---

## 11.1 Optimize for Readability First

SQL statements shall remain clear, maintainable, and self-explanatory.

Performance optimization shall never compromise readability unless measurable
performance improvements justify the additional complexity.

---

## 11.2 Optimize Only After Measurement

Performance optimization shall always be based on measurable evidence.

Execution plans, execution statistics, and workload analysis shall guide all
optimization activities.

Assumptions shall not be used as justification for SQL optimization.

---

## 11.3 Avoid Premature Optimization

Queries shall not be optimized before a demonstrated performance requirement
exists.

Database design, indexing strategy, and statistics should be reviewed before
modifying SQL statements.

Index implementation decisions remain governed by IndexSpecifications.

---

## 11.4 Keep Statistics Current

Accurate planner statistics are essential for reliable execution plans.

Routine maintenance shall ensure that database statistics remain current.

---

## 11.5 Review Performance After Schema Changes

Execution plans should be reviewed following significant database changes,
including:

- New indexes
- Schema modifications
- Partition changes
- PostgreSQL upgrades
- Large data imports

---

# 12. Anti-Patterns

The following practices are prohibited unless supported by documented
performance analysis.

- Optimizing SQL without execution plan analysis.
- Assuming Index Scan is always preferable to Sequential Scan.
- Ignoring planner statistics.
- Forcing implementation choices based solely on estimated cost.
- Excessive query complexity without measurable benefit.
- Using optimizer workarounds instead of correcting database design.
- Ignoring execution plan regressions.

---

# 13. Query Review Checklist

Every performance-sensitive SQL statement shall be reviewed before
deployment.

| Question | Required |
|----------|----------|
| Has EXPLAIN been reviewed? | Yes |
| Has EXPLAIN ANALYZE been reviewed where appropriate? | Yes |
| Are planner estimates reasonable? | Yes |
| Are scan methods appropriate? | Yes |
| Are join strategies appropriate? | Yes |
| Are statistics current? | Yes |
| Does the query follow PostgreSQL best practices? | Yes |
| Has measurable performance been demonstrated? | Yes |

---

# 14. Compliance

All SQL statements developed within the Phoenix Platform shall comply with
this standard.

Any deviation from this specification shall be documented and approved
through the Architecture Decision Record (ADR) process.

Architecture reviews, database reviews, code reviews, and performance reviews
shall verify compliance before deployment.

---

# 15. References

The following Phoenix standards and architecture documents are related to
this specification.

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- IndexSpecifications
- PartitionStrategy
- StorageStrategy
- PostgreSQLDevelopmentGuidelines
- ADR-015 — Market Classification Model
- ADR-026 — Reference Data Normalization Model

---

# 15. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 1.0 | 2026-07-24 | Initial enterprise version. |

---

# 16. Approval

This document is approved as the official enterprise standard governing query
execution analysis and SQL performance optimization throughout the Phoenix
Platform.

All future SQL development and performance reviews shall comply with the
principles and requirements defined in this specification.

Changes to this standard shall be reviewed and approved through the Phoenix
Architecture Governance process.

---

# 17. Summary

This specification establishes the enterprise query execution strategy for
the Phoenix Platform.

It defines a consistent methodology for understanding PostgreSQL planner
behavior, interpreting execution plans, evaluating query performance, and
applying optimization techniques based on measurable evidence.

The strategy promotes:

- Consistent SQL performance evaluation.
- Reliable execution plan analysis.
- Efficient use of PostgreSQL planner capabilities.
- Improved maintainability.
- Reduced performance regressions.
- Evidence-based optimization decisions.

Query optimization shall always be driven by execution plans, workload
characteristics, and PostgreSQL best practices rather than assumptions or
premature optimization.

---

# 18. Architecture Assessment

The Query Execution Strategy defined in this document establishes the
enterprise framework for SQL performance analysis and execution plan
evaluation within the Phoenix Platform.

The strategy promotes evidence-based optimization by relying on PostgreSQL
planner decisions, execution statistics, and workload characteristics rather
than subjective assumptions.

The architecture defined by this specification ensures that:

- Query optimization remains measurable.
- SQL development remains maintainable.
- Database performance remains predictable.
- Performance regressions can be identified systematically.
- PostgreSQL optimizer capabilities are fully utilized.
- Enterprise governance is consistently enforced.

Execution plan analysis is recognized as a continuous architectural activity
throughout the software lifecycle rather than a one-time optimization task.

---

# 19. Final Summary

The Phoenix Platform adopts a layered enterprise database architecture in
which logical design, physical implementation, and performance optimization
are governed through independent but complementary standards.

The Query Execution Strategy completes the database performance layer by
providing:

- Standardized execution plan analysis.
- Consistent optimization methodology.
- PostgreSQL planner guidance.
- Performance review procedures.
- Best practices for SQL tuning.
- Enterprise governance requirements.

Together with the other database standards, this specification contributes
to a scalable, maintainable, and performance-oriented PostgreSQL
implementation suitable for long-term enterprise evolution.

Compliance with this standard is mandatory for all SQL performance analysis,
database optimization activities, and architecture reviews conducted within
the Phoenix Platform.

---

