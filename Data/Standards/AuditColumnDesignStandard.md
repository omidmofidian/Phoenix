# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | AuditColumnDesignStandard |
| Document Title | Enterprise Audit Column Design Standard |
| Document Identifier | STD-DATA-003 |
| Domain | Data Architecture |
| Category | Database Standard |
| Status | Draft |
| Version | 2026.1 |
| Owner | Enterprise Architecture |
| Approver | Enterprise Architecture Board |
| Repository | Phoenix |
| Language | English |
| Classification | Internal |
| Created | 2026-07-28 |
| Last Updated | 2026-07-28 |
| Next Review | TBD |

---

# Document Information

## Purpose

This document defines the enterprise standard governing the design,
implementation, lifecycle, and management of audit columns within the
Phoenix Platform.

It establishes a consistent audit model for all database tables to ensure
data traceability, operational accountability, optimistic concurrency
control, and repository-wide consistency.

---

## Audience

This document is intended for:

- Enterprise Architects
- Database Architects
- Database Developers
- Backend Developers
- Technical Reviewers

---

## Related Standards

- ColumnNamingStandard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- FactTableDesignStandard
- EventTableDesignStandard
- BridgeTableDesignStandard

---

# 1. Introduction

## 1.1 Purpose

This document defines the enterprise standards governing audit columns
within the Phoenix Platform.

Its purpose is to establish a consistent, reusable, and architecture-driven
audit model for every persistent database entity.

---

## 1.2 Scope

This standard applies to every persistent relational table implemented
within the Phoenix Platform, including but not limited to:

- Master Entity Tables
- Reference Tables
- Fact Tables
- Event Tables
- Bridge Tables
- Configuration Tables
- Operational Tables

Temporary objects, staging tables, and transient processing tables MAY be
exempt where explicitly approved.

---

## 1.3 Objectives

The objectives of this standard are to:

- Provide complete record lifecycle traceability.
- Support operational auditing.
- Enable optimistic concurrency control.
- Improve repository consistency.
- Support future governance and compliance requirements.
- Standardize audit implementation across all schemas.

---

## 1.4 Guiding Principles

Audit columns SHALL:

- Be enterprise-wide.
- Be technology-independent.
- Be reusable.
- Be infrastructure-oriented.
- Be consistently implemented.
- Remain independent of business attributes.

---

## 1.5 Relationship to Other Standards

This document defines only the standards specific to audit columns.

The following concerns are governed by separate enterprise standards and
SHALL NOT be redefined herein:

- Column naming conventions
- Primary Key design
- Foreign Key design
- Table design
- Constraint naming

---

## 1.6 Repository Compliance

Every applicable database table within the Phoenix Platform SHALL comply
with this standard.

Exceptions SHALL require formal approval through the Enterprise
Architecture governance process.

---

# 2. Audit Column Principles

## 2.1 Enterprise Audit Philosophy

Audit columns provide technical metadata describing the lifecycle of a
database record.

They SHALL support governance, traceability, diagnostics, synchronization,
and operational accountability.

Audit columns SHALL NOT represent business data.

---

## 2.2 Enterprise Infrastructure Columns

Audit columns are Enterprise Infrastructure Columns.

They are shared by all applicable database tables and SHALL follow a
single enterprise-wide implementation strategy.

They SHALL NOT be customized for individual business entities.

---

## 2.3 Canonical Audit Columns

The canonical audit columns are:

- created_at
- created_by
- updated_at
- updated_by
- deleted_at
- deleted_by
- row_version

These column names are reserved for enterprise audit purposes.

---

## 2.4 Naming Exception

Audit columns are the only approved exception to the canonical business
column naming pattern defined in the ColumnNamingStandard.

Business columns SHALL follow:

```text
<entity_name>_<attribute_name>
```

Audit columns SHALL use their canonical enterprise names without entity
prefixes.

Examples:

Correct

- created_at
- updated_by
- row_version

Incorrect

- exchange_created_at
- market_updated_by
- instrument_row_version

---

## 2.5 Business Independence

Audit columns SHALL remain independent of business logic.

Changes to business attributes SHALL NOT alter the semantics or behavior
of audit columns.

---

## 2.6 Lifecycle Coverage

The canonical audit model SHALL support the complete lifecycle of a record,
including:

- Creation
- Modification
- Logical deletion
- Concurrency control

---

## 2.7 Repository Consistency

Every applicable table SHALL implement the same audit column model.

Alternative audit implementations are prohibited unless formally approved
by Enterprise Architecture.

---

## 2.8 Compliance

Every audit implementation SHALL:

- Use the canonical audit columns.
- Use canonical audit names.
- Remain business independent.
- Be repository consistent.
- Comply with this standard.

---

# 3. Audit Column Definitions

## 3.1 Purpose

This section defines the canonical audit columns approved for use within
the Phoenix Platform.

These definitions SHALL be applied consistently across all applicable
database tables.

---

## 3.2 created_at

### Purpose

Records the timestamp when the database row was initially created.

### Data Type

```sql
TIMESTAMPTZ
```

### Rules

- SHALL be mandatory.
- SHALL be assigned only once.
- SHALL NOT be modified after record creation.
- SHALL represent the database server timestamp.

Example:

```sql
created_at TIMESTAMPTZ
    NOT NULL
    DEFAULT CURRENT_TIMESTAMP
```

---

## 3.3 created_by

### Purpose

Identifies the authenticated user, service, or process that created the
database row.

### Data Type

```sql
BIGINT
```

### Rules

- SHALL be mandatory.
- SHALL reference the creating principal.
- SHALL NOT be modified after creation.
- SHALL NOT contain business information.

Example:

```sql
created_by BIGINT
    NOT NULL
```

---

## 3.4 updated_at

### Purpose

Records the timestamp of the most recent successful modification.

### Data Type

```sql
TIMESTAMPTZ
```

### Rules

- SHALL be NULL until the first update.
- SHALL be updated after every successful modification.
- SHALL NOT change unless the row is modified.

Example:

```sql
updated_at TIMESTAMPTZ
```

---

## 3.5 updated_by

### Purpose

Identifies the authenticated user, service, or process responsible for the
most recent update.

### Data Type

```sql
BIGINT
```

### Rules

- SHALL be NULL until the first update.
- SHALL be updated together with `updated_at`.
- SHALL identify the modifying principal.

Example:

```sql
updated_by BIGINT
```

---

## 3.6 deleted_at

### Purpose

Records the timestamp at which the row was logically deleted.

### Data Type

```sql
TIMESTAMPTZ
```

### Rules

- SHALL remain NULL for active rows.
- SHALL be populated only during a logical deletion.
- SHALL NOT be cleared unless an approved recovery operation occurs.

Example:

```sql
deleted_at TIMESTAMPTZ
```

---

## 3.7 deleted_by

### Purpose

Identifies the authenticated user, service, or process responsible for the
logical deletion.

### Data Type

```sql
BIGINT
```

### Rules

- SHALL remain NULL for active rows.
- SHALL be populated together with `deleted_at`.
- SHALL identify the deleting principal.

Example:

```sql
deleted_by BIGINT
```

---

## 3.8 row_version

### Purpose

Supports optimistic concurrency control by recording the current version
of the database row.

### Data Type

```sql
INTEGER
```

### Rules

- SHALL be mandatory.
- SHALL be initialized to `1`.
- SHALL be incremented after every successful update.
- SHALL NOT be modified directly by application code.

Example:

```sql
row_version INTEGER
    NOT NULL
    DEFAULT 1
```

---

# 4. Naming Standard

## 4.1 Purpose

This section defines the naming requirements applicable to Enterprise Audit
Columns.

General database column naming rules are governed by the
**ColumnNamingStandard** and SHALL NOT be duplicated within this document.

---

## 4.2 Canonical Names

The following audit column names are reserved and SHALL be used exactly as
defined.

| Audit Purpose | Canonical Column Name |
|---------------|-----------------------|
| Creation Timestamp | created_at |
| Creator Identifier | created_by |
| Last Update Timestamp | updated_at |
| Last Updater Identifier | updated_by |
| Deletion Timestamp | deleted_at |
| Deletion Identifier | deleted_by |
| Optimistic Concurrency | row_version |

---

## 4.3 Naming Exception

Audit columns are Enterprise Infrastructure Columns.

They SHALL NOT use entity prefixes.

Correct:

```text
created_at
updated_by
row_version
```

Incorrect:

```text
exchange_created_at
market_updated_by
issuer_row_version
```

---

## 4.4 Reserved Names

The following names are reserved exclusively for enterprise audit
purposes:

- created_at
- created_by
- updated_at
- updated_by
- deleted_at
- deleted_by
- row_version

No business attribute SHALL use these names.

---

## 4.5 Deprecated Names

The following names SHALL NOT be used:

- version
- timestamp
- create_date
- modify_date
- modified_at
- creator
- updater
- last_modified
- last_updated
- rowversion

These names are prohibited to ensure repository-wide consistency.

---

## 4.6 Repository Consistency

Every applicable database table SHALL use the same audit column names.

Alternative naming conventions are prohibited.

---

## 4.7 Relationship with ColumnNamingStandard

The ColumnNamingStandard governs all business column names.

This document defines the only approved exception for Enterprise Audit
Columns.

No additional naming exceptions SHALL be introduced.

---

## 4.8 Compliance

Every audit implementation SHALL:

- Use canonical audit names.
- Avoid entity prefixes.
- Avoid deprecated names.
- Follow the approved audit model.
- Remain repository consistent.

---

# 5. Data Type Standard

## 5.1 Purpose

This section defines the approved data types for Enterprise Audit Columns.

Audit Columns SHALL use standardized data types throughout the Phoenix
Platform to ensure consistency, interoperability, and long-term
maintainability.

---

## 5.2 Timestamp Columns

The following audit columns SHALL use the PostgreSQL `TIMESTAMPTZ` data
type:

- created_at
- updated_at
- deleted_at

Approved implementation:

```sql
TIMESTAMPTZ
```

Time zone awareness SHALL be preserved for every timestamp.

---

## 5.3 Principal Identifier Columns

The following audit columns SHALL use the PostgreSQL `BIGINT` data type:

- created_by
- updated_by
- deleted_by

These columns SHALL reference the canonical identifier of the authenticated
user, service, or process responsible for the corresponding operation.

The referenced identifier SHALL comply with the
**ForeignKeyDesignStandard**.

---

## 5.4 Row Version

The `row_version` column SHALL use:

```sql
INTEGER
```

Approved implementation:

```sql
row_version INTEGER
    NOT NULL
    DEFAULT 1
```

`row_version` SHALL be used exclusively for optimistic concurrency control.

---

## 5.5 Nullable Columns

The following audit columns SHALL allow NULL values:

- updated_at
- updated_by
- deleted_at
- deleted_by

These columns SHALL remain NULL until the corresponding lifecycle event
occurs.

---

## 5.6 Mandatory Columns

The following audit columns SHALL be mandatory:

- created_at
- created_by
- row_version

These columns SHALL always contain valid values.

---

## 5.7 Data Type Consistency

The approved audit data types SHALL remain identical across every schema,
module, and database object.

Alternative implementations are prohibited unless explicitly approved by
Enterprise Architecture.

---

## 5.8 Compliance

Every audit implementation SHALL:

- Use TIMESTAMPTZ for audit timestamps.
- Use BIGINT for audit principals.
- Use INTEGER for row_version.
- Preserve repository-wide consistency.
- Comply with this standard.

---

# 6. Default Values

## 6.1 Purpose

This section defines the approved default values for Enterprise Audit
Columns.

Default values SHALL be deterministic, consistent, and database-driven.

---

## 6.2 created_at

The `created_at` column SHALL be initialized automatically.

Approved implementation:

```sql
created_at TIMESTAMPTZ
    NOT NULL
    DEFAULT CURRENT_TIMESTAMP
```

The application SHALL NOT assign this value explicitly.

---

## 6.3 created_by

`created_by` SHALL NOT define a database default value.

The authenticated application layer SHALL provide the creating principal.

Example:

```sql
created_by BIGINT
    NOT NULL
```

---

## 6.4 updated_at and updated_by

`updated_at` and `updated_by` SHALL NOT define database default values.

Both columns SHALL remain NULL until the first successful update.

They SHALL always be updated together.

---

## 6.5 deleted_at and deleted_by

`deleted_at` and `deleted_by` SHALL NOT define database default values.

Both columns SHALL remain NULL until a logical deletion occurs.

They SHALL always be populated together.

---

## 6.6 row_version

`row_version` SHALL be initialized automatically.

Approved implementation:

```sql
row_version INTEGER
    NOT NULL
    DEFAULT 1
```

The initial version SHALL always be `1`.

---

## 6.7 Application Responsibilities

The application layer SHALL:

- Supply `created_by`.
- Supply `updated_by`.
- Supply `deleted_by`.
- Increment `row_version` during every successful update.
- Never modify `created_at`.

The database SHALL remain responsible only for database-generated default
values.

---

## 6.8 Compliance

Every audit implementation SHALL:

- Use CURRENT_TIMESTAMP for `created_at`.
- Initialize `row_version` to `1`.
- Avoid unnecessary database defaults.
- Keep application and database responsibilities clearly separated.
- Remain repository consistent.

---

# 7. Update Rules

## 7.1 Purpose

This section defines the mandatory rules governing audit column behavior
during record updates.

Audit columns SHALL accurately represent the lifecycle of a database row
throughout its existence.

---

## 7.2 Record Creation

When a new row is inserted:

| Column | Value |
|---------|-------|
| created_at | CURRENT_TIMESTAMP |
| created_by | Creating principal |
| updated_at | NULL |
| updated_by | NULL |
| deleted_at | NULL |
| deleted_by | NULL |
| row_version | 1 |

These values SHALL represent the initial state of the row.

---

## 7.3 Record Update

When a row is successfully updated:

| Column | Action |
|---------|--------|
| created_at | SHALL NOT change |
| created_by | SHALL NOT change |
| updated_at | Set to CURRENT_TIMESTAMP |
| updated_by | Set to updating principal |
| deleted_at | SHALL NOT change |
| deleted_by | SHALL NOT change |
| row_version | Increment by one |

Every successful update SHALL modify all applicable audit columns
simultaneously.

---

## 7.4 Immutable Columns

The following audit columns are immutable after row creation:

- created_at
- created_by

Applications, services, and database utilities SHALL NOT modify these
values after insertion.

---

## 7.5 Update Atomicity

Audit column updates SHALL occur within the same database transaction as
the corresponding business update.

Partial audit updates are prohibited.

---

## 7.6 Failed Transactions

If a transaction is rolled back:

- Audit columns SHALL remain unchanged.
- `row_version` SHALL NOT increase.
- No partial audit information SHALL be persisted.

Audit information SHALL always reflect committed database state.

---

## 7.7 Multiple Updates

Each successful update SHALL:

- Refresh `updated_at`.
- Refresh `updated_by`.
- Increment `row_version`.

There SHALL be exactly one version increment per successful update
transaction.

---

## 7.8 Compliance

Every update operation SHALL:

- Preserve immutable audit values.
- Update modification metadata.
- Increment `row_version`.
- Execute atomically.
- Maintain transactional consistency.

---

# 8. Soft Delete Rules

## 8.1 Purpose

This section defines the enterprise standard for logical (soft) deletion
within the Phoenix Platform.

Logical deletion preserves historical information while preventing records
from participating in normal business operations.

---

## 8.2 Soft Delete Principle

Business entities SHOULD be logically deleted rather than physically
removed.

Logical deletion SHALL preserve:

- Business history
- Referential integrity
- Auditability
- Operational traceability

Physical deletion SHALL be exceptional.

---

## 8.3 Logical Delete Operation

A logical deletion SHALL perform the following actions:

| Column | Action |
|---------|--------|
| deleted_at | Set to CURRENT_TIMESTAMP |
| deleted_by | Set to deleting principal |
| updated_at | Set to CURRENT_TIMESTAMP |
| updated_by | Set to deleting principal |
| row_version | Increment by one |

The business data SHALL remain unchanged.

---

## 8.4 Active Records

An active record SHALL satisfy:

```sql
deleted_at IS NULL
```

Business queries SHOULD retrieve only active records unless historical
records are explicitly requested.

---

## 8.5 Deleted Records

Deleted records SHALL:

- Remain stored.
- Preserve business history.
- Preserve audit history.
- Preserve Primary Key values.
- Preserve Foreign Key relationships.

Logical deletion SHALL NOT invalidate referential integrity.

---

## 8.6 Record Restoration

If business policy permits restoration:

- `deleted_at` SHALL be reset to NULL.
- `deleted_by` SHALL be reset to NULL.
- `updated_at` SHALL be refreshed.
- `updated_by` SHALL identify the restoring principal.
- `row_version` SHALL be incremented.

Every restoration SHALL be auditable.

---

## 8.7 Physical Deletion

Physical deletion SHALL only be permitted when:

- Explicitly approved by Enterprise Architecture.
- Required by legal or regulatory obligations.
- Executed through controlled maintenance procedures.

Routine business operations SHALL NOT physically delete persistent
business entities.

---

## 8.8 Compliance

Every implementation supporting logical deletion SHALL:

- Preserve deleted records.
- Maintain audit history.
- Preserve referential integrity.
- Increment `row_version`.
- Comply with enterprise governance.

---

# 9. Optimistic Concurrency Control

## 9.1 Purpose

This section defines the enterprise standard for optimistic concurrency
control within the Phoenix Platform.

Optimistic concurrency prevents lost updates when multiple users,
services, or processes modify the same database row concurrently.

---

## 9.2 Concurrency Strategy

The Phoenix Platform SHALL implement optimistic concurrency using the
canonical audit column:

```text
row_version
```

No alternative concurrency mechanism SHALL be implemented without
Enterprise Architecture approval.

---

## 9.3 Initial Value

Every newly created row SHALL initialize:

```sql
row_version INTEGER
    NOT NULL
    DEFAULT 1
```

The initial version SHALL always be **1**.

---

## 9.4 Version Increment

Every successful UPDATE operation SHALL increment the row version by one.

Example:

| Operation | row_version |
|-----------|-------------|
| INSERT | 1 |
| First UPDATE | 2 |
| Second UPDATE | 3 |
| Third UPDATE | 4 |

Exactly one increment SHALL occur for each committed update transaction.

---

## 9.5 Update Validation

Before updating a row, the application SHALL verify that the stored
`row_version` matches the version originally read.

Example:

```sql
UPDATE ref.exchange
SET
    exchange_name = :exchange_name,
    updated_at    = CURRENT_TIMESTAMP,
    updated_by    = :user_id,
    row_version   = row_version + 1
WHERE
    exchange_id = :exchange_id
AND row_version = :row_version;
```

If no row is updated, a concurrency conflict SHALL be reported.

The canonical SQL implementation patterns for optimistic concurrency SHALL be maintained in the DDL Template Specification and SQL Coding Standard.

---

## 9.6 Concurrency Conflict

When a concurrency conflict occurs:

- The transaction SHALL fail.
- Existing data SHALL remain unchanged.
- No partial update SHALL be committed.
- The application SHALL reload the latest row before retrying.

Automatic overwriting of concurrent changes is prohibited.

---

## 9.7 Repository Consistency

All database tables implementing optimistic concurrency SHALL use the same
`row_version` strategy.

Alternative versioning mechanisms are prohibited.

---

## 9.8 Compliance

Every implementation SHALL:

- Use `row_version`.
- Start at version `1`.
- Increment by one per successful update.
- Detect concurrent modifications.
- Prevent lost updates.

---

# 10. Audit Lifecycle

## 10.1 Purpose

This section defines the lifecycle of Enterprise Audit Columns from record
creation through logical deletion.

Audit information SHALL accurately reflect the complete lifecycle of every
persistent database row.

---

## 10.2 Record Creation

When a row is inserted:

| Audit Column | Value |
|--------------|-------|
| created_at | CURRENT_TIMESTAMP |
| created_by | Creating principal |
| updated_at | NULL |
| updated_by | NULL |
| deleted_at | NULL |
| deleted_by | NULL |
| row_version | 1 |

---

## 10.3 Record Modification

Each successful update SHALL:

- Preserve `created_at`.
- Preserve `created_by`.
- Update `updated_at`.
- Update `updated_by`.
- Increment `row_version`.

Business changes and audit changes SHALL occur within the same database
transaction.

---

## 10.4 Logical Deletion

A logical deletion SHALL:

- Preserve the business record.
- Preserve the Primary Key.
- Populate `deleted_at`.
- Populate `deleted_by`.
- Refresh `updated_at`.
- Refresh `updated_by`.
- Increment `row_version`.

Logical deletion SHALL remain fully auditable.

---

## 10.5 Record Restoration

When restoration is permitted:

- `deleted_at` SHALL become NULL.
- `deleted_by` SHALL become NULL.
- `updated_at` SHALL be refreshed.
- `updated_by` SHALL identify the restoring principal.
- `row_version` SHALL be incremented.

The restoration event SHALL remain traceable.

---

## 10.6 Physical Deletion

Where physical deletion is explicitly approved:

- Audit history SHOULD be archived beforehand.
- Referential integrity SHALL be preserved.
- Repository governance procedures SHALL be followed.

Routine business operations SHALL NOT physically delete persistent
business entities.

---

## 10.7 Lifecycle Summary

The canonical lifecycle is:

```text
Insert
   │
   ▼
Created
   │
   ▼
Zero or More Updates
   │
   ▼
Logical Delete
   │
   ▼
(Optional Restoration)
   │
   ▼
(Approved Physical Deletion)
```

Every lifecycle transition SHALL be reflected by the corresponding audit
columns.

---

## 10.8 Compliance

Every persistent table SHALL implement the complete audit lifecycle defined
in this section.

Exceptions SHALL require formal Enterprise Architecture approval.

---

# 11. Canonical Implementation Examples

## 11.1 Purpose

This section provides canonical implementation examples for Enterprise
Audit Columns.

These examples SHALL be used as the authoritative implementation reference
throughout the Phoenix Platform.

---

## 11.2 Canonical Audit Block

Every applicable database table SHALL implement the following audit block.

```sql
------------------------------------------------------------------------------
-- Audit Columns
------------------------------------------------------------------------------

created_at                 TIMESTAMPTZ
                               NOT NULL
                               DEFAULT CURRENT_TIMESTAMP,

updated_at                 TIMESTAMPTZ,

deleted_at                 TIMESTAMPTZ,

created_by                 BIGINT
                               NOT NULL,

updated_by                 BIGINT,

deleted_by                 BIGINT,

row_version                INTEGER
                               NOT NULL
                               DEFAULT 1
```

This audit block SHALL remain identical across all applicable database
tables.

---

## 11.3 Master Entity Example

Example:

```sql
CREATE TABLE ref.exchange
(
    ...

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                 TIMESTAMPTZ
                                   NOT NULL
                                   DEFAULT CURRENT_TIMESTAMP,

    updated_at                 TIMESTAMPTZ,

    deleted_at                 TIMESTAMPTZ,

    created_by                 BIGINT
                                   NOT NULL,

    updated_by                 BIGINT,

    deleted_by                 BIGINT,

    row_version                INTEGER
                                   NOT NULL
                                   DEFAULT 1
);
```

---

## 11.4 Reference Table Example

Reference tables SHALL implement the identical audit block.

No audit column customization is permitted.

---

## 11.5 Fact Table Example

Fact tables SHALL implement the identical audit block unless formally
exempted by Enterprise Architecture.

Operational behavior SHALL remain unchanged.

---

## 11.6 Event Table Example

Event tables SHALL implement the identical audit block.

Event-specific business attributes SHALL NOT replace enterprise audit
columns.

---

## 11.7 Repository Pattern

Every applicable table SHALL implement audit columns using the following
canonical sequence:

```text
created_at
updated_at
deleted_at
created_by
updated_by
deleted_by
row_version
```

This ordering SHALL be preserved throughout the repository.

---

## 11.8 Compliance

Every implementation example SHALL:

- Use canonical audit columns.
- Preserve canonical ordering.
- Preserve canonical data types.
- Preserve canonical defaults.
- Remain repository consistent.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies prohibited audit column implementations.

The anti-patterns defined herein SHALL NOT be used within the Phoenix
Platform.

---

## 12.2 Entity-Prefixed Audit Columns

Audit columns SHALL NOT include entity prefixes.

Incorrect:

```text
exchange_created_at
market_updated_by
issuer_deleted_at
instrument_row_version
```

Correct:

```text
created_at
updated_by
deleted_at
row_version
```

---

## 12.3 Duplicate Audit Columns

Duplicate audit information is prohibited.

Incorrect:

```text
created_at
creation_date
```

Incorrect:

```text
updated_at
last_modified
```

Each audit concept SHALL be represented by exactly one canonical column.

---

## 12.4 Deprecated Names

The following names are prohibited:

- version
- timestamp
- modified_at
- modified_by
- creator
- updater
- create_date
- update_date
- delete_date
- rowversion

Only canonical audit names SHALL be used.

---

## 12.5 Business Information

Audit columns SHALL NOT store business information.

Incorrect examples:

- Department
- Business Unit
- Exchange Name
- Customer Code

Audit columns SHALL contain only technical audit metadata.

---

## 12.6 Business Logic

Business rules SHALL NOT depend on audit column values except where
explicitly defined by enterprise architecture.

Audit columns SHALL remain infrastructure metadata.

---

## 12.7 Missing Audit Columns

Applicable database tables SHALL NOT omit required audit columns.

Incomplete audit implementations are prohibited unless formally approved.

---

## 12.8 Compliance

Every audit implementation SHALL avoid:

- Entity-prefixed audit columns.
- Duplicate audit metadata.
- Deprecated names.
- Business information.
- Missing mandatory audit columns.

Repository consistency SHALL always take precedence over local
implementation preferences.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the enterprise rules governing the migration of audit
columns during database modernization, data migration, schema evolution,
and repository maintenance.

Migration activities SHALL preserve audit integrity, traceability, and
repository consistency.

---

## 13.2 Audit Preservation

Existing audit information SHALL be preserved whenever technically
possible.

The following audit columns SHALL NOT be regenerated during migration:

- created_at
- created_by
- updated_at
- updated_by
- deleted_at
- deleted_by
- row_version

---

## 13.3 Legacy System Migration

Legacy systems MAY use alternative audit implementations.

During migration:

- Existing audit values SHOULD be preserved.
- Missing audit values MAY remain NULL where appropriate.
- Legacy column names SHALL be mapped to the canonical audit model.

The resulting implementation SHALL comply with this standard.

---

## 13.4 Default Value Synchronization

After migration, all audit columns SHALL comply with the approved default
value definitions.

In particular:

- `created_at` SHALL use `CURRENT_TIMESTAMP`.
- `row_version` SHALL default to `1`.
- Other audit columns SHALL NOT define database defaults unless explicitly
  approved.

---

## 13.5 Audit Validation

Every migration SHALL validate:

- Audit column existence.
- Audit data types.
- Default values.
- NULL / NOT NULL rules.
- Canonical column names.
- Repository consistency.

Migration SHALL NOT be considered complete until all validations succeed.

---

## 13.6 Data Integrity

Migration activities SHALL preserve:

- Audit history.
- Business history.
- Referential integrity.
- Optimistic concurrency information.

Migration SHALL NOT corrupt or invalidate audit metadata.

---

## 13.7 Repository Alignment

Following migration, all affected database tables SHALL comply with the
current version of the AuditColumnDesignStandard.

Legacy audit implementations SHALL be retired through controlled migration
activities.

---

## 13.8 Compliance

Every migration SHALL:

- Preserve audit information.
- Preserve audit history.
- Preserve repository consistency.
- Preserve concurrency information.
- Comply with this standard.

---

# 14. Validation Checklist

## 14.1 Purpose

This section defines the mandatory review checklist for Enterprise Audit
Columns.

Every applicable database table SHALL satisfy all validation rules before
implementation approval.

---

## 14.2 Naming Validation

Verify that:

- Canonical audit names are used.
- No entity prefixes exist.
- Deprecated names are absent.
- Column names comply with this standard.

---

## 14.3 Structural Validation

Verify that:

- All mandatory audit columns exist.
- Optional audit columns are correctly implemented.
- Column ordering follows the canonical sequence.
- No duplicate audit columns exist.

---

## 14.4 Data Type Validation

Verify that:

- TIMESTAMPTZ is used for timestamps.
- BIGINT is used for principal identifiers.
- INTEGER is used for `row_version`.

No alternative data types are permitted.

---

## 14.5 Default Value Validation

Verify that:

- `created_at` uses `CURRENT_TIMESTAMP`.
- `row_version` defaults to `1`.
- Other audit columns do not define unauthorized defaults.

---

## 14.6 Lifecycle Validation

Verify that:

- Creation audit metadata is immutable.
- Update metadata is refreshed correctly.
- Logical deletion updates the correct audit columns.
- Restoration rules are correctly implemented.
- Physical deletion follows governance policies.

---

## 14.7 Concurrency Validation

Verify that:

- `row_version` exists.
- Versioning starts at `1`.
- Each successful update increments the version.
- Concurrent updates are correctly detected.

---

## 14.8 Compliance Checklist

Every applicable table SHALL satisfy all of the following:

✓ Canonical audit columns

✓ Canonical column ordering

✓ Canonical data types

✓ Canonical default values

✓ Immutable creation metadata

✓ Correct update behavior

✓ Logical deletion support

✓ Optimistic concurrency support

✓ Repository-wide consistency

No database table SHALL be approved for implementation unless every
applicable validation rule defined in this section has been successfully
satisfied.

---

# 15. Canonical Examples

## 15.1 Purpose

This section provides canonical examples illustrating the correct
implementation of Enterprise Audit Columns.

These examples SHALL be considered the authoritative implementation
reference throughout the Phoenix Platform.

---

## 15.2 Canonical Audit Column Block

Every applicable database table SHALL implement the following audit block.

```sql
------------------------------------------------------------------------------
-- Audit Columns
------------------------------------------------------------------------------

created_at                 TIMESTAMPTZ
                               NOT NULL
                               DEFAULT CURRENT_TIMESTAMP,

updated_at                 TIMESTAMPTZ,

deleted_at                 TIMESTAMPTZ,

created_by                 BIGINT
                               NOT NULL,

updated_by                 BIGINT,

deleted_by                 BIGINT,

row_version                INTEGER
                               NOT NULL
                               DEFAULT 1
```

This implementation SHALL remain identical throughout the repository.

---

## 15.3 Example — Reference Table

```sql
------------------------------------------------------------------------------
-- Audit Columns
------------------------------------------------------------------------------

created_at                 TIMESTAMPTZ
                               NOT NULL
                               DEFAULT CURRENT_TIMESTAMP,

updated_at                 TIMESTAMPTZ,

deleted_at                 TIMESTAMPTZ,

created_by                 BIGINT
                               NOT NULL,

updated_by                 BIGINT,

deleted_by                 BIGINT,

row_version                INTEGER
                               NOT NULL
                               DEFAULT 1
```

---

## 15.4 Example — Master Entity Table

Master Entity tables SHALL implement the identical audit column block.

No additional audit columns are permitted.

No audit columns may be omitted.

---

## 15.5 Example — Fact Table

Fact tables SHALL implement the identical audit column block unless an
Enterprise Architecture exception has been formally approved.

---

## 15.6 Example — Event Table

Event tables SHALL implement the identical audit model.

Business event attributes SHALL NOT replace Enterprise Audit Columns.

---

## 15.7 Canonical Repository Pattern

Every applicable table SHALL implement Audit Columns using the following
canonical sequence:

```text
created_at
updated_at
deleted_at
created_by
updated_by
deleted_by
row_version
```

This sequence SHALL remain identical across every schema and every
database object.

---

## 15.8 Compliance

Every implementation example SHALL:

- Use canonical audit columns.
- Preserve canonical ordering.
- Preserve canonical data types.
- Preserve canonical default values.
- Remain repository consistent.

---

# 16. Architecture Rules

## 16.1 Purpose

This section defines the architectural governance rules applicable to
Enterprise Audit Columns throughout the Phoenix Platform.

These rules ensure long-term consistency, maintainability, and repository
stability.

---

## 16.2 Enterprise Standard

Enterprise Audit Columns SHALL be implemented uniformly across the entire
repository.

Project-specific or module-specific audit models are prohibited.

---

## 16.3 Single Source of Truth

This document SHALL be the single authoritative source governing the
architecture, lifecycle, and implementation of Enterprise Audit Columns.

Related standards MAY reference this document but SHALL NOT redefine audit
column behavior.

---

## 16.4 Architecture Review

Any proposed deviation from this standard SHALL:

- Be documented.
- Include architectural justification.
- Be reviewed by Enterprise Architecture.
- Receive formal approval before implementation.

Unapproved deviations are prohibited.

---

## 16.5 Repository Consistency

Every schema, service, and database module SHALL implement the same audit
column architecture.

Repository-wide consistency SHALL take precedence over local
implementation preferences.

---

## 16.6 Standard Evolution

Future database standards SHALL reference this document whenever audit
columns are discussed.

Duplicate audit rules across multiple standards are prohibited.

---

## 16.7 Architecture Freeze

Once approved, the Enterprise Audit Column architecture SHALL be
considered architecturally frozen.

Changes SHALL require:

- Business justification.
- Repository impact assessment.
- Migration strategy.
- Enterprise Architecture approval.

Architectural stability SHALL take precedence over implementation
convenience.

---

## 16.8 Compliance

Every implementation SHALL comply with:

- Enterprise Architecture principles.
- Approved ADRs.
- Repository governance.
- Related database standards.

Compliance with this standard is mandatory.

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative enterprise documents governing
the implementation and management of Enterprise Audit Columns within the
Phoenix Platform.

Only the documents referenced herein SHALL be considered normative for
audit column design.

---

## 17.2 Normative References

The following standards SHALL be complied with when implementing
Enterprise Audit Columns.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| Enterprise Naming Standard | Enterprise naming principles |
| ColumnNamingStandard | Business and audit column naming conventions |
| PrimaryKeyDesignStandard | Primary Key implementation |
| ForeignKeyDesignStandard | Foreign Key implementation |
| MasterEntityDesignStandard | Master Entity table design |
| ReferenceTableDesignStandard | Reference table design |
| FactTableDesignStandard | Fact table design |
| EventTableDesignStandard | Event table design |
| BridgeTableDesignStandard | Bridge table design |

---

## 17.3 Related Standards

The following standards complement this document.

| Document | Relationship |
|----------|--------------|
| DatabaseConstraintStandard | Constraint implementation |
| DatabaseIndexStandard | Index implementation |
| DDLTemplateSpecification | Canonical DDL implementation template |
| PostgreSQL Design Decisions | PostgreSQL-specific implementation guidance |

---

## 17.4 Governance

If a conflict exists between this document and another implementation
standard, the conflict SHALL be resolved according to the Enterprise
Governance Framework.

Approved Architecture Decision Records (ADRs) SHALL take precedence over
implementation guidance whenever an ADR explicitly defines a different
architectural rule.

---

## 17.5 Single Source of Truth

This document SHALL remain the single authoritative source governing the
architecture, lifecycle, and implementation of Enterprise Audit Columns.

Other standards MAY reference this document but SHALL NOT redefine audit
column behavior.

---

## 17.6 Repository Compliance

Every applicable database table within the Phoenix Platform SHALL comply
with this standard.

Compliance SHALL be verified during architecture review and repository
certification.

---

# 18. Revision History

## 18.1 Purpose

This section records the revision history and lifecycle of the Enterprise
Audit Column Design Standard.

All approved modifications SHALL be documented to ensure complete
traceability.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Audit Column Design Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this standard SHALL be managed under the Enterprise Governance
Framework.

Every modification SHALL include:

- Change justification.
- Architecture impact assessment.
- Repository impact assessment.
- Version update.
- Formal approval.

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing audit implementations SHALL include a
repository-wide impact assessment.

Migration activities SHALL preserve audit history, lifecycle integrity,
and repository consistency.

---

## 18.5 Architecture Freeze

Once approved, the Enterprise Audit Column model SHALL be considered
architecturally frozen.

Changes SHALL require:

- Business justification.
- Enterprise Architecture approval.
- Repository impact assessment.
- Migration strategy.
- Version increment.

Architectural stability SHALL take precedence over implementation
convenience.

---

## 18.6 Repository Compliance

All database objects created after the approval of this standard SHALL
comply with the latest approved version.

Legacy implementations SHALL be aligned through controlled migration
activities when required.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Questions, proposed improvements, and requests for exceptions SHALL be
submitted through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative source governing Enterprise
Audit Columns within the Phoenix Platform.

All database tables, SQL scripts, database models, and implementation
artifacts SHALL comply with this standard.

Audit column rules SHALL NOT be duplicated or redefined in other
repository documents.

---

## End of Document