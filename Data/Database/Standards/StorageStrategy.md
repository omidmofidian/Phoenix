# Storage Strategy

| Property | Value |
|----------|-------|
| Document ID | STD-015 |
| Document Name | Storage Strategy |
| Project | Phoenix Platform |
| Version | 1.0 |
| Status | Approved |
| Owner | Phoenix Architecture Team |
| Type | Enterprise Database Standard |

---

# 1. Purpose

This document defines the enterprise storage strategy for the Phoenix
Platform.

The objective of this standard is to establish a consistent approach for
physical data storage, storage optimization, lifecycle management, and
long-term scalability across all PostgreSQL databases used by the platform.

This specification provides guidance for:

- Physical storage organization.
- Tablespace utilization.
- Storage parameter selection.
- Large object management.
- Compression strategy.
- TOAST utilization.
- Storage optimization.
- Capacity planning.
- Long-term maintainability.

The strategy defined in this document aligns with PostgreSQL 17 best
practices and the architectural principles of the Phoenix Platform.

---

# 2. Scope

This standard applies to all persistent database objects created within the
Phoenix Platform.

The specification governs storage strategies for:

- Tables
- Partitioned Tables
- Indexes
- Materialized Views
- TOAST Tables
- Large Objects
- Future storage extensions

This standard applies to every database schema including:

- reference
- market
- analytics
- operational
- configuration
- security
- audit

---

# 3. Objectives

The primary objectives of this standard are:

1. Optimize physical storage utilization.

2. Improve I/O performance.

3. Support scalable database growth.

4. Minimize storage fragmentation.

5. Simplify operational maintenance.

6. Support efficient backup and recovery.

7. Provide consistent enterprise storage architecture.

8. Align storage decisions with PostgreSQL 17 best practices.

---

# 4. Storage Principles

The Phoenix Platform adopts a layered storage architecture that separates
logical data modeling from physical storage implementation.

Storage decisions shall be based on:

- Business requirements.
- Data access patterns.
- Data growth characteristics.
- Operational requirements.
- PostgreSQL best practices.

Physical storage optimization shall never compromise data integrity,
maintainability, or architectural consistency.

---

# 5. Storage Classification

The Phoenix Platform classifies database storage into the following
categories.

---

## 5.1 Reference Storage

Reference Storage contains relatively static business entities that exhibit
low write frequency and small data volume.

Typical examples include:

- Exchange
- Market
- Board
- Industry
- Sector
- Company
- Instrument
- TradingCalendar
- HolidayCalendar

Characteristics:

- Small tables
- Low fragmentation
- Minimal maintenance
- No partitioning
- Standard heap storage

---

## 5.2 Operational Storage

Operational Storage contains continuously changing business data.

Typical examples include:

- DailyMarketData
- IntradayMarketData
- TickData
- OrderBook
- TradeHistory

Characteristics:

- High write activity
- Large data volume
- Continuous growth
- Candidate for partitioning

---

## 5.3 Analytical Storage

Analytical Storage supports reporting, feature engineering, machine learning,
and historical analysis.

Typical examples include:

- Indicator Results
- Feature Store
- Analytics Cache
- Backtest Results

Characteristics:

- Large read workload
- Periodic batch updates
- Long retention periods
- Optimized for analytical queries

---

## 5.4 Audit Storage

Audit Storage contains operational history and security records.

Typical examples include:

- Audit Logs
- User Activity
- System Events
- Data Change History

Characteristics:

- Append-only
- Long-term retention
- Time-based partitioning
- Read-intensive

---

# 6. Storage Architecture

The physical storage architecture follows a layered approach.

```text
Application Layer
        │
        ▼
Logical Database Model
        │
        ▼
Tables
        │
        ▼
Indexes
        │
        ▼
Partitions
        │
        ▼
Physical Storage
```

Each layer has an independent responsibility.

Changes to physical storage shall not require changes to the logical data
model.

---

# 7. Tablespace Strategy

Tablespaces provide logical separation of physical storage.

The Phoenix Platform recognizes the following tablespace categories.

| Tablespace | Purpose |
|------------|---------|
| ts_reference | Reference Data |
| ts_operational | Operational Data |
| ts_analytics | Analytical Data |
| ts_audit | Audit Data |
| ts_index | Large Indexes (optional) |

The use of multiple tablespaces shall be justified by operational or
performance requirements.

Single-server deployments may use the default tablespace.

Enterprise deployments may distribute tablespaces across different storage
devices.

---

# 8. Storage Parameters

Storage parameters shall be configured only when justified by measurable
operational or performance requirements.

Default PostgreSQL settings shall be preferred unless workload analysis
demonstrates a clear benefit from customization.

Storage parameter changes shall be documented and approved through the
database review process.

---

## 8.1 Fillfactor

Fillfactor determines the percentage of each data page initially occupied
during INSERT operations.

General recommendations:

| Workload | Recommended Fillfactor |
|----------|------------------------|
| Reference Tables | 100 |
| Read-Mostly Tables | 100 |
| Frequently Updated Tables | 90–95 |
| Heavy Update Tables | 80–90 |

Lower Fillfactor values reduce page splits but increase storage consumption.

---

## 8.2 Autovacuum

Autovacuum shall remain enabled for all Phoenix databases.

Configuration changes shall be made only after workload analysis.

Autovacuum is responsible for:

- Dead tuple removal
- Statistics updates
- Transaction ID protection
- Storage optimization

Disabling Autovacuum is prohibited.

---

## 8.3 Analyze

Database statistics shall remain current.

Automatic ANALYZE should normally be sufficient.

Manual ANALYZE may be executed after:

- Large data imports
- Bulk updates
- Major maintenance activities

---

# 9. TOAST Strategy

TOAST (The Oversized-Attribute Storage Technique) shall be used according to
PostgreSQL default behavior.

Application developers shall not manually optimize TOAST storage unless
performance analysis demonstrates a measurable benefit.

Typical TOAST candidates include:

- Large text documents
- JSON documents
- XML documents
- Binary objects

Reference tables should avoid unnecessary large variable-length columns.

---

# 10. Compression Strategy

The Phoenix Platform relies primarily on PostgreSQL native compression
capabilities.

Compression shall remain transparent to application code.

Compression is recommended for:

- Historical datasets
- Large textual documents
- Archived analytical data

Compression shall not be introduced solely to reduce disk usage without
evaluating CPU overhead.

---

# 11. Large Object Strategy

Large Objects (LOBs) should be avoided unless required by business
requirements.

Whenever practical:

- Documents should be stored outside the database.
- The database should store metadata and secure references.

Typical external objects include:

- PDF reports
- Images
- Financial statements
- Attachments

Exceptions shall be documented through architectural approval.

---

# 12. Storage Maintenance

Routine storage maintenance is required to preserve long-term database
performance.

Maintenance activities include:

- VACUUM
- VACUUM FULL (only when justified)
- ANALYZE
- REINDEX
- Storage monitoring
- Capacity monitoring
- Bloat monitoring

Maintenance procedures shall be automated whenever practical.

---

# 13. Best Practices

The following best practices shall be followed for all storage-related
decisions within the Phoenix Platform.

---

## 13.1 Prefer Simplicity

Storage architecture shall remain as simple as possible.

Complex storage configurations shall be introduced only when supported by
measurable operational requirements.

---

## 13.2 Separate Logical and Physical Design

Logical database design shall remain independent of physical storage
implementation.

Changes to tablespaces, storage parameters, compression, or physical layout
shall not require modifications to the logical data model.

---

## 13.3 Optimize for Workload

Storage optimization shall be driven by actual workload characteristics.

Typical workload dimensions include:

- Read-intensive
- Write-intensive
- Mixed workload
- Analytical processing
- Historical storage

---

## 13.4 Plan for Growth

Storage architecture shall anticipate long-term database growth.

Capacity planning shall consider:

- Expected data growth
- Storage expansion
- Backup requirements
- Disaster recovery
- Future market engines

---

## 13.5 Monitor Continuously

Storage health shall be monitored continuously.

Recommended monitoring includes:

- Database size
- Tablespace utilization
- Index growth
- TOAST growth
- Table bloat
- Autovacuum activity
- Storage latency

---

# 14. Anti-Patterns

The following practices are prohibited unless explicitly approved through
architectural governance.

- Disabling Autovacuum.
- Creating unnecessary tablespaces.
- Excessive customization of storage parameters.
- Storing large binary files inside the database without business
  justification.
- Mixing operational and analytical workloads within the same storage
  strategy.
- Ignoring storage growth projections.
- Using physical storage optimization to compensate for poor logical design.

---

# 15. Storage Review Checklist

Every storage-related design decision shall be reviewed before
implementation.

| Question | Required |
|----------|----------|
| Is the storage strategy documented? | Yes |
| Does the design match workload characteristics? | Yes |
| Is the selected tablespace appropriate? | Yes |
| Are storage parameters justified? | Yes |
| Is Autovacuum enabled? | Yes |
| Is long-term growth considered? | Yes |
| Are backup and recovery requirements addressed? | Yes |
| Has the design been approved through architecture review? | Yes |

---

# 16. Compliance

All database storage implementations within the Phoenix Platform shall
comply with this standard.

Any deviation from this specification shall be documented and approved
through the Architecture Decision Record (ADR) process.

Architecture reviews, database reviews, and operational readiness reviews
shall verify compliance with this standard before deployment.

---

# 17. References

The following Phoenix standards and architecture documents are related to
this specification.

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- IndexSpecifications
- PartitionStrategy
- PostgreSQLDevelopmentGuidelines
- ADR-015 — Market Classification Model
- ADR-026 — Reference Data Normalization Model

---

# 18. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 1.0 | 2026-07-24 | Initial enterprise version. |

---

# 19. Approval

This document is approved as the official enterprise standard governing
physical database storage throughout the Phoenix Platform.

All future database storage decisions shall comply with the principles,
requirements, and governance defined in this specification.

Changes to this standard shall be reviewed and approved through the Phoenix
Architecture Governance process.

---

# 20. Summary

This specification establishes the enterprise storage strategy for the
Phoenix Platform.

It defines a consistent approach for physical storage architecture,
tablespace utilization, storage parameters, TOAST usage, compression,
maintenance, and long-term capacity planning.

The strategy promotes:

- Predictable storage behavior.
- Improved operational efficiency.
- Scalable physical architecture.
- Reduced maintenance complexity.
- Consistent PostgreSQL implementation.
- Long-term repository maintainability.

Storage decisions shall always be guided by business requirements,
workload characteristics, PostgreSQL best practices, and architectural
governance rather than premature optimization.

---

