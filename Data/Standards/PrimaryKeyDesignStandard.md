# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | PrimaryKeyDesignStandard |
| Document Title | Enterprise Primary Key Design Standard |
| Document Identifier | STD-DATA-002 |
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
selection, implementation, and lifecycle management of Primary Keys
within the Phoenix Platform.

## Audience

- Enterprise Architects
- Database Architects
- Database Developers
- Backend Developers
- Technical Reviewers

## Related Standards

- ColumnNamingStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- FactTableDesignStandard
- EventTableDesignStandard
- BridgeTableDesignStandard

# 1. Introduction

## 1.1 Purpose

This document defines the enterprise standards governing the design,
selection, implementation, and management of Primary Keys within the
Phoenix Platform.

Its purpose is to establish a consistent, scalable, and architecture-driven
approach for uniquely identifying every persistent business entity across
the enterprise database.

---

## 1.2 Scope

This standard applies to every relational table implemented within the
Phoenix Platform, including but not limited to:

- Master Entity Tables
- Reference Tables
- Fact Tables
- Event Tables
- Bridge Tables
- Configuration Tables
- Operational Tables

Every database table SHALL define exactly one Primary Key in accordance
with this standard.

---

## 1.3 Objectives

The objectives of this standard are to:

- Ensure unique identification of every database row.
- Promote repository-wide consistency.
- Improve maintainability.
- Support long-term scalability.
- Enable reliable relationships between database objects.
- Simplify application development.
- Support future database evolution.

---

## 1.4 Guiding Principles

Primary Keys SHALL be designed according to the following principles:

- Uniqueness
- Stability
- Immutability
- Simplicity
- Performance
- Scalability
- Technology independence

Primary Keys SHALL represent technical identifiers rather than business
information.

---

## 1.5 Relationship to Other Standards

This document defines only the standards that are specific to Primary Keys.

The following concerns are governed by separate enterprise standards:

- Column naming conventions
- Foreign Key design
- Audit columns
- Table design
- Constraint naming

These topics SHALL NOT be redefined within this document.

---

## 1.6 Repository Compliance

Every database object implemented within the Phoenix Platform SHALL comply
with this standard.

Exceptions SHALL require formal approval through the Enterprise
Architecture governance process.

---

# 2. Primary Key Principles

## 2.1 Definition

A Primary Key is the canonical technical identifier of a database row.

Each row SHALL have one and only one Primary Key.

The Primary Key SHALL uniquely identify a row throughout its entire
lifecycle.

---

## 2.2 Uniqueness

Every Primary Key value SHALL be unique within its table.

Duplicate Primary Key values are prohibited.

The uniqueness constraint SHALL be enforced by the database management
system.

---

## 2.3 Immutability

Primary Key values SHALL never change after creation.

Business events SHALL NOT modify an existing Primary Key value.

If a business identifier changes, the Primary Key SHALL remain unchanged.

---

## 2.4 Stability

Primary Keys SHALL remain stable throughout the lifetime of the record.

Primary Keys SHALL NOT depend on:

- Business codes
- Business names
- Business classifications
- Operational status
- External systems

---

## 2.5 Technical Identifier

A Primary Key SHALL be a technical identifier only.

Business meaning SHALL NOT be embedded within the Primary Key.

Primary Keys SHALL NOT expose business semantics.

---

## 2.6 Single Primary Key Rule

Each table SHALL define exactly one Primary Key.

Multiple Primary Keys within a single table are prohibited.

Composite Primary Keys SHALL only be permitted where explicitly allowed by
this standard.

---

## 2.7 Surrogate Key Principle

Phoenix adopts Surrogate Keys as the canonical Primary Key strategy.

Business identifiers SHALL be stored as business attributes and SHALL NOT
replace the Primary Key.

Examples include:

- exchange_code
- instrument_isin
- issuer_registration_code

These attributes MAY be constrained as UNIQUE where appropriate, but SHALL
NOT serve as the table's Primary Key.

---

## 2.8 Repository Consistency

All Primary Keys implemented within the Phoenix Platform SHALL follow a
single enterprise-wide design philosophy.

Primary Key implementation SHALL remain consistent across all schemas,
modules, and database objects.

---

# 3. Primary Key Naming Standard

## 3.1 Purpose

This section defines the naming requirements that are specific to Primary
Keys.

General database column naming rules are defined in the
**ColumnNamingStandard** and SHALL NOT be duplicated within this document.

---

## 3.2 Canonical Naming Rule

Every Primary Key SHALL comply with the canonical naming convention defined
by the ColumnNamingStandard.

The approved naming pattern is:

```text
<entity_name>_id
```

Examples:

- exchange_id
- market_id
- trading_board_id
- instrument_id
- issuer_id

---

## 3.3 Entity Consistency

The Primary Key name SHALL use the exact canonical entity name.

Examples:

Entity

Exchange

Primary Key

exchange_id

Entity

Trading Board

Primary Key

trading_board_id

Entity

Daily Market Data

Primary Key

daily_market_data_id

The entity name SHALL remain identical across all database objects.

---

## 3.4 Singular Form

Primary Key names SHALL use the singular form of the entity name.

Correct:

exchange_id

instrument_id

issuer_id

Incorrect:

exchanges_id

instruments_id

issuers_id

---

## 3.5 Repository Consistency

The same entity SHALL always use the same Primary Key name throughout the
repository.

Example:

Exchange

exchange_id

Master Table

exchange_id

Foreign Key

exchange_id

Views

exchange_id

Materialized Views

exchange_id

Consistency SHALL be maintained across every database object.

---

## 3.6 Reserved Names

The following names SHALL NOT be used as Primary Keys:

- id
- entity_id
- object_id
- record_id
- key
- identifier

Approved names SHALL follow the canonical entity-based naming convention.

---

## 3.7 Relationship with Foreign Keys

Every Foreign Key referencing a Primary Key SHALL use exactly the same
column name as the referenced Primary Key.

Example:

Primary Key

exchange_id

Foreign Key

exchange_id

This requirement is governed by the **ForeignKeyDesignStandard**.

---

## 3.8 Compliance

Every Primary Key SHALL:

- Comply with ColumnNamingStandard.
- Use the canonical entity name.
- Use the suffix `_id`.
- Be repository consistent.
- Use exactly one approved name.

---

# 4. Primary Key Data Type Standard

## 4.1 Purpose

This section defines the approved data types for Primary Keys within the
Phoenix Platform.

---

## 4.2 Approved Data Type

The canonical Primary Key data type is:

```sql
BIGINT GENERATED ALWAYS AS IDENTITY
```

This SHALL be the default implementation for all relational tables unless
an approved architectural exception exists.

---

## 4.3 Identity Generation

Primary Key values SHALL be generated exclusively by PostgreSQL.

Application code SHALL NOT generate Primary Key values.

Manual assignment of Primary Key values is prohibited.

---

## 4.4 Surrogate Key Strategy

Phoenix adopts Surrogate Keys implemented as PostgreSQL Identity Columns.

Business identifiers SHALL remain independent of the Primary Key.

---

## 4.5 UUID Usage

UUID SHALL NOT replace the Primary Key.

UUID MAY be implemented as an additional public identifier when required
for:

- External APIs
- System integration
- Data synchronization
- Public object identification

UUID usage SHALL NOT affect the Primary Key strategy.

Every business entity MAY define a public_id column of type UUID as an immutable public identifier. The public_id SHALL NOT replace the Primary Key and SHALL be constrained as UNIQUE.

---

## 4.6 Data Type Consistency

Every Primary Key within the repository SHALL use the same approved data
type.

Mixing BIGINT, INTEGER, UUID, or other data types for Primary Keys is
prohibited unless explicitly approved by Enterprise Architecture.

---

## 4.7 Future Scalability

The selected Primary Key data type SHALL support long-term growth of the
Phoenix Platform.

The Primary Key implementation SHALL remain scalable across multiple
schemas, services, and database modules.

---

## 4.8 Compliance

Every Primary Key SHALL:

- Use BIGINT.
- Use GENERATED ALWAYS AS IDENTITY.
- Be generated by PostgreSQL.
- Be immutable.
- Be repository consistent.

---

# 5. Primary Key Generation

## 5.1 Purpose

This section defines the approved mechanisms for generating Primary Key
values within the Phoenix Platform.

Primary Key generation SHALL be automatic, deterministic, and fully managed
by the database management system.

---

## 5.2 Generation Authority

PostgreSQL SHALL be the sole authority responsible for generating Primary
Key values.

Applications, services, users, and external systems SHALL NOT generate or
assign Primary Key values.

---

## 5.3 Identity Columns

Primary Keys SHALL be implemented using PostgreSQL Identity Columns.

Approved implementation:

```sql
exchange_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

`GENERATED ALWAYS AS IDENTITY` SHALL be used unless an approved
architectural exception exists.

---

## 5.4 Manual Assignment

Manual assignment of Primary Key values is prohibited.

The following operations SHALL NOT be performed:

- Explicit INSERT of Primary Key values
- Manual sequence manipulation
- Reuse of deleted identifiers
- Importing externally generated Primary Keys

---

## 5.5 Sequence Management

Identity sequences SHALL be managed exclusively by PostgreSQL.

Database applications SHALL NOT:

- Reset sequences
- Decrease sequence values
- Generate independent sequence values

Sequence administration SHALL only occur as part of controlled database
maintenance activities.

---

## 5.6 Import and Migration

During approved migration activities, explicit Primary Key values MAY be
inserted only when:

- The migration has been formally approved.
- Referential integrity is preserved.
- Identity sequences are synchronized after migration.

Migration procedures SHALL be documented and repeatable.

---

## 5.7 Public Identifiers

When a business entity requires a public identifier, it SHALL be stored
independently from the Primary Key.

Every entity requiring a public identifier SHALL define a column named public_id.

Example:

```sql
public_id UUID
    NOT NULL
    DEFAULT gen_random_uuid()
```

The public identifier SHALL NOT replace the Primary Key.

---

## 5.8 Compliance

Every Primary Key generation mechanism SHALL:

- Be database-generated.
- Be automatic.
- Be immutable.
- Be repeatable.
- Be repository consistent.

---

# 6. Business Keys

## 6.1 Purpose

This section defines the relationship between Primary Keys and Business
Keys.

Business Keys and Primary Keys represent different architectural concepts
and SHALL remain independent.

---

## 6.2 Business Key Definition

A Business Key uniquely identifies a business concept from the perspective
of business users.

Examples include:

- exchange_code
- instrument_isin
- issuer_registration_code

Business Keys SHALL NOT replace Primary Keys.

---

## 6.3 Surrogate Key Principle

Phoenix adopts Surrogate Keys as the canonical Primary Key strategy.

Business Keys SHALL exist independently of the technical identifier.

Both identifiers MAY coexist within the same table.

---

## 6.4 Alternate Keys

Business Keys MAY be constrained as Alternate Keys using UNIQUE
constraints.

Example:

```sql
CONSTRAINT uk_exchange_code
    UNIQUE (exchange_code)
```

Alternate Keys SHALL NOT become Primary Keys.

---

## 6.5 Natural Keys

Natural Keys SHALL NOT be used as Primary Keys.

Examples include:

- Exchange code
- ISIN
- National identifier
- Registration number

Natural Keys MAY change during the lifetime of a business entity.

---

## 6.6 Business Rule Independence

Changes to Business Keys SHALL NOT require modification of the Primary Key.

Primary Key stability SHALL always take precedence over business
convenience.

---

## 6.7 Repository Consistency

Every table within the Phoenix Platform SHALL distinguish clearly between:

- Technical Identifier (Primary Key)
- Public Identifier (when applicable)
- Business Identifier(s)

Each identifier SHALL have a clearly defined architectural purpose.

---

## 6.8 Compliance

Every implementation SHALL ensure that:

- Primary Keys are surrogate identifiers.
- Business Keys remain business attributes.
- Alternate Keys use UNIQUE constraints.
- Natural Keys never replace Primary Keys.
- Repository consistency is maintained.

---

# 7. Composite Primary Keys

## 7.1 Purpose

This section defines the enterprise policy governing the use of Composite
Primary Keys within the Phoenix Platform.

The use of Composite Primary Keys SHALL be minimized to preserve simplicity,
maintainability, and long-term scalability.

---

## 7.2 General Policy

Phoenix adopts a **Single Surrogate Primary Key** strategy.

Every table SHOULD define a single-column surrogate Primary Key.

Composite Primary Keys SHALL only be used where explicitly approved by
Enterprise Architecture.

---

## 7.3 Preferred Design

The preferred implementation is:

```sql
bridge_table_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Business relationships SHALL be enforced using UNIQUE constraints rather
than Composite Primary Keys whenever possible.

---

## 7.4 Approved Exceptions

Composite Primary Keys MAY be approved only when all of the following
conditions are satisfied:

- A surrogate key provides no architectural benefit.
- The relationship is inherently composite.
- The design improves data integrity.
- Enterprise Architecture formally approves the exception.

Such cases SHALL be rare.

---

## 7.5 Bridge Tables

Bridge Tables SHOULD use a surrogate Primary Key.

The uniqueness of the relationship SHALL be enforced through a UNIQUE
constraint.

Example:

```sql
PRIMARY KEY
(
    instrument_sector_id
)

UNIQUE
(
    instrument_id,
    sector_id
)
```

This approach improves extensibility and simplifies future enhancements.

---

## 7.6 Fact Tables

Fact Tables SHALL use a surrogate Primary Key.

Business uniqueness MAY additionally be enforced using UNIQUE constraints
covering the relevant business dimensions.

Composite Primary Keys SHALL NOT be used for Fact Tables.

---

## 7.7 Event Tables

Event Tables SHALL use a surrogate Primary Key.

Multiple business attributes MAY uniquely identify an event, but these
attributes SHALL NOT replace the surrogate Primary Key.

---

## 7.8 Compliance

Composite Primary Keys SHALL:

- Be exceptional.
- Require Architecture approval.
- Be fully documented.
- Include architectural justification.

The default enterprise strategy SHALL remain a single surrogate Primary
Key.

---

# 8. Relationship Rules

## 8.1 Purpose

This section defines the relationship between Primary Keys and Foreign Keys
within the Phoenix Platform.

Primary Keys SHALL serve as the canonical reference target for all
inter-table relationships.

---

## 8.2 Referential Integrity

Every Foreign Key SHALL reference the Primary Key of the parent table unless
an approved architectural exception exists.

Referential integrity SHALL be enforced by the database.

---

## 8.3 Primary Key Ownership

The Primary Key SHALL belong exclusively to its owning entity.

Child tables SHALL reference the parent entity through Foreign Keys.

Primary Keys SHALL NOT be shared between unrelated entities.

---

## 8.4 Foreign Key Naming

Foreign Key column names SHALL be identical to the referenced Primary Key
column names.

Example:

Parent Table

```text
exchange_id
```

Child Table

```text
exchange_id
```

Naming consistency is governed by the ForeignKeyDesignStandard.

---

## 8.5 Relationship Stability

Changes to business attributes SHALL NOT affect Primary Key relationships.

Primary Key values SHALL remain stable throughout the lifecycle of every
relationship.

---

## 8.6 Cascade Policy

Cascade operations SHALL be used only where explicitly justified.

The default enterprise policy is:

- ON UPDATE RESTRICT
- ON DELETE RESTRICT

Alternative cascade behaviors SHALL require architectural approval.

---

## 8.7 Cross-Schema Relationships

Primary Keys MAY be referenced across schemas.

Cross-schema references SHALL follow the same naming, integrity, and
governance rules as intra-schema relationships.

---

## 8.8 Compliance

Every relationship SHALL:

- Reference the parent Primary Key.
- Preserve referential integrity.
- Use consistent Foreign Key names.
- Maintain relationship stability.
- Comply with the ForeignKeyDesignStandard.

---

# 9. Primary Key Constraints

## 9.1 Purpose

This section defines the mandatory database constraints associated with
Primary Keys within the Phoenix Platform.

Every Primary Key SHALL be protected by database-enforced constraints to
ensure data integrity, consistency, and long-term maintainability.

---

## 9.2 Mandatory Constraints

Every Primary Key SHALL satisfy the following constraints:

- PRIMARY KEY
- NOT NULL
- UNIQUE (implicitly enforced by the PRIMARY KEY constraint)

No Primary Key SHALL permit NULL values.

---

## 9.3 PRIMARY KEY Constraint

Every table SHALL define exactly one PRIMARY KEY constraint.

Example:

```sql
CONSTRAINT pk_exchange
    PRIMARY KEY
    (
        exchange_id
    )
```

Constraint names SHALL comply with the Enterprise Constraint Naming
Standard.

The naming of PRIMARY KEY constraints is governed by the Enterprise Constraint Naming Standard and SHALL NOT be redefined in this document.

---

## 9.4 NOT NULL Requirement

Primary Key columns SHALL always be defined as NOT NULL.

When using PostgreSQL Identity Columns, this requirement is enforced
automatically by the database.

Application logic SHALL NOT rely on implicit behavior.

---

## 9.5 Uniqueness

Every Primary Key SHALL uniquely identify exactly one row.

Duplicate Primary Key values are prohibited.

Uniqueness SHALL be enforced exclusively by the database management
system.

---

## 9.6 Constraint Enforcement

Applications SHALL NOT bypass database-enforced Primary Key constraints.

Integrity SHALL always be guaranteed by the database engine rather than
application code.

---

## 9.7 Constraint Stability

Primary Key constraints SHALL remain stable throughout the lifecycle of
the database.

Changing or removing an approved Primary Key constraint SHALL require:

- Architecture review
- Repository impact analysis
- Migration plan
- Formal approval

---

## 9.8 Compliance

Every Primary Key SHALL:

- Be protected by a PRIMARY KEY constraint.
- Be NOT NULL.
- Be unique.
- Be enforced by PostgreSQL.
- Comply with Enterprise constraint standards.

---

# 10. Performance Considerations

## 10.1 Purpose

This section defines the enterprise performance principles for Primary Key
implementation.

Primary Key design SHALL support efficient storage, indexing, and query
execution throughout the Phoenix Platform.

---

## 10.2 Index Creation

Every PRIMARY KEY constraint automatically creates a unique B-tree index in
PostgreSQL.

Additional indexes SHALL NOT be created on the Primary Key column unless a
documented architectural justification exists.

---

## 10.3 Sequential Identity Values

Identity-generated BIGINT values provide sequential key generation.

Sequential identifiers reduce index fragmentation and improve insertion
performance.

This is the preferred strategy for all Phoenix database tables.

---

## 10.4 Join Performance

Primary Keys SHALL be optimized for join operations.

Foreign Keys referencing Primary Keys SHALL use identical data types to
avoid unnecessary type conversion during query execution.

---

## 10.5 Storage Efficiency

BIGINT Primary Keys provide an efficient balance between scalability,
storage requirements, and processing performance.

Primary Key columns SHALL remain compact and free of embedded business
information.

---

## 10.6 Index Fragmentation

Sequential Identity Columns minimize index fragmentation compared with
random identifiers.

UUID values SHALL NOT be used as clustered or Primary Keys due to their
potential impact on index maintenance and insert performance.

---

## 10.7 Query Optimization

Database queries SHALL use Primary Keys whenever direct entity retrieval is
required.

Business identifiers MAY be indexed independently when required by business
workloads.

---

## 10.8 Compliance

Primary Key implementations SHALL:

- Support efficient indexing.
- Minimize fragmentation.
- Optimize join performance.
- Use sequential identity values.
- Maintain long-term scalability.

---

# 11. Canonical Implementation Examples

## 11.1 Purpose

This section provides canonical implementation examples demonstrating the
approved Primary Key design for different table categories within the
Phoenix Platform.

These examples SHALL be used as implementation references for future
database development.

---

## 11.2 Master Entity Table

Example:

```sql
CREATE TABLE ref.exchange
(
    exchange_id BIGINT
        GENERATED ALWAYS AS IDENTITY,

    ...

    CONSTRAINT pk_exchange
        PRIMARY KEY
        (
            exchange_id
        )
);
```

Characteristics:

- Single surrogate Primary Key
- BIGINT Identity
- Immutable
- Technology-generated

---

## 11.3 Reference Table

Example:

```sql
CREATE TABLE ref.country
(
    country_id BIGINT
        GENERATED ALWAYS AS IDENTITY,

    ...

    CONSTRAINT pk_country
        PRIMARY KEY
        (
            country_id
        )
);
```

Characteristics:

- Single surrogate Primary Key
- Repository-wide consistency
- Referenced by multiple business entities

---

## 11.4 Fact Table

Example:

```sql
CREATE TABLE market.daily_market_data
(
    daily_market_data_id BIGINT
        GENERATED ALWAYS AS IDENTITY,

    instrument_id BIGINT
        NOT NULL,

    trading_date DATE
        NOT NULL,

    ...

    CONSTRAINT pk_daily_market_data
        PRIMARY KEY
        (
            daily_market_data_id
        )
);
```

Business uniqueness MAY additionally be enforced through a UNIQUE
constraint.

---

## 11.5 Event Table

Example:

```sql
CREATE TABLE market.trading_halt_event
(
    trading_halt_event_id BIGINT
        GENERATED ALWAYS AS IDENTITY,

    instrument_id BIGINT
        NOT NULL,

    ...

    CONSTRAINT pk_trading_halt_event
        PRIMARY KEY
        (
            trading_halt_event_id
        )
);
```

Event attributes SHALL NOT replace the surrogate Primary Key.

---

## 11.6 Bridge Table

Example:

```sql
CREATE TABLE market.instrument_sector
(
    instrument_sector_id BIGINT
        GENERATED ALWAYS AS IDENTITY,

    instrument_id BIGINT
        NOT NULL,

    sector_id BIGINT
        NOT NULL,

    ...

    CONSTRAINT pk_instrument_sector
        PRIMARY KEY
        (
            instrument_sector_id
        ),

    CONSTRAINT uk_instrument_sector
        UNIQUE
        (
            instrument_id,
            sector_id
        )
);
```

Bridge Tables SHALL use a surrogate Primary Key.

Relationship uniqueness SHALL be enforced through a UNIQUE constraint.

---

## 11.7 Public Identifier Example

When public identification is required, a UUID MAY be implemented in
addition to the Primary Key.

Example:

```sql
exchange_id BIGINT
    GENERATED ALWAYS AS IDENTITY,

public_id UUID
    NOT NULL
    DEFAULT gen_random_uuid(),

CONSTRAINT uk_exchange_public_id
    UNIQUE
    (
        public_id
    )
```

The `public_id` SHALL NOT replace the Primary Key.

---

## 11.8 Compliance

Every implementation example SHALL comply with:

- ColumnNamingStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- Enterprise Constraint Naming Standard

These examples SHALL be considered canonical implementation references.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies Primary Key design practices that are prohibited
within the Phoenix Platform.

The anti-patterns described below SHALL NOT be implemented.

---

## 12.2 Business Code as Primary Key

Business codes SHALL NOT be used as Primary Keys.

Incorrect:

```text
exchange_code
```

Correct:

```text
exchange_id
```

Business codes MAY be protected by UNIQUE constraints.

---

## 12.3 Business Name as Primary Key

Business names SHALL NOT be used as Primary Keys.

Incorrect examples:

- exchange_name
- issuer_name
- instrument_name

Business names are mutable and unsuitable as technical identifiers.

---

## 12.4 Smart Keys

Primary Keys SHALL NOT contain embedded business meaning.

Examples of prohibited Smart Keys:

- EX-000001
- IRX-100025
- NYSE-001

Primary Keys SHALL remain opaque technical identifiers.

---

## 12.5 Natural Keys

Natural Keys SHALL NOT replace surrogate Primary Keys.

Examples include:

- ISIN
- National identifiers
- Registration numbers
- Exchange codes

These values MAY change over time.

---

## 12.6 Composite Keys Without Justification

Composite Primary Keys SHALL NOT be implemented solely because multiple
columns appear to identify a record.

Surrogate Primary Keys SHALL remain the enterprise default.

---

## 12.7 Mutable Primary Keys

Primary Key values SHALL NEVER be modified after creation.

Changing a Primary Key introduces unnecessary complexity and risks
referential integrity.

---

## 12.8 Duplicate Identification Strategies

The same business entity SHALL NOT use different Primary Key strategies in
different tables.

Repository-wide consistency SHALL always take precedence over local design
preferences.

---

## 12.9 Compliance

Primary Key implementations SHALL avoid every anti-pattern defined in this
section.

Architectural reviews SHALL verify compliance before implementation.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the enterprise rules governing Primary Keys during
database migration, modernization, data import, and repository evolution.

Migration activities SHALL preserve the integrity, stability, and identity
of all database records.

---

## 13.2 Primary Key Preservation

Existing Primary Key values SHALL be preserved whenever practical during
migration.

Primary Key values SHALL NOT be regenerated unless explicitly approved by
Enterprise Architecture.

---

## 13.3 Referential Integrity

Migration procedures SHALL preserve all Primary Key and Foreign Key
relationships.

Referential integrity SHALL remain valid before, during, and after
migration.

Broken relationships are prohibited.

---

## 13.4 Identity Sequence Synchronization

When Primary Key values are imported explicitly, the corresponding Identity
sequence SHALL be synchronized before the database is returned to service.

Failure to synchronize Identity sequences is prohibited.

---

## 13.5 Legacy Database Migration

Legacy systems MAY use different Primary Key strategies.

During migration, legacy identifiers MAY be preserved as business
attributes or alternate identifiers.

The migrated table SHALL adopt the Phoenix Primary Key standard.

---

## 13.6 Public Identifier Migration

Where Public Identifiers are implemented, existing UUID values SHOULD be
preserved whenever possible.

New UUID values SHALL only be generated when no valid Public Identifier
exists.

Public Identifiers SHALL remain immutable after migration.

---

## 13.7 Data Validation

Every migration SHALL validate:

- Primary Key uniqueness
- Referential integrity
- Identity sequence synchronization
- Duplicate detection
- Orphan record detection

Migration SHALL NOT be considered complete until validation succeeds.

---

## 13.8 Compliance

Every migration SHALL:

- Preserve Primary Keys.
- Preserve relationships.
- Synchronize Identity sequences.
- Maintain repository consistency.
- Be documented and repeatable.

---

# 14. Validation Checklist

## 14.1 Purpose

This section defines the mandatory validation checklist for reviewing
Primary Key implementations before deployment.

Every Primary Key SHALL successfully pass this checklist.

No database table SHALL be approved for implementation unless every applicable validation rule defined in this section has been successfully satisfied.

---

## 14.2 Naming Validation

Verify that:

- The Primary Key name complies with the ColumnNamingStandard.
- The entity name is correct.
- The suffix `_id` is used.
- Repository naming consistency is maintained.

---

## 14.3 Structure Validation

Verify that:

- Exactly one Primary Key exists.
- The Primary Key is a single column.
- The Primary Key uses a surrogate identifier.
- Composite Primary Keys are formally approved.

---

## 14.4 Data Type Validation

Verify that:

- Data type is BIGINT.
- `GENERATED ALWAYS AS IDENTITY` is used.
- Manual value assignment is not permitted.

---

## 14.5 Integrity Validation

Verify that:

- PRIMARY KEY constraint exists.
- NOT NULL is enforced.
- Uniqueness is enforced.
- Referential integrity is preserved.

---

## 14.6 Performance Validation

Verify that:

- Sequential identity values are used.
- No unnecessary Primary Key indexes exist.
- Foreign Keys use identical data types.
- Join performance is preserved.

---

## 14.7 Architecture Validation

Verify that:

- Business Keys are not Primary Keys.
- Smart Keys are not used.
- Natural Keys are not used.
- Primary Keys are immutable.
- Repository standards are followed.

---

## 14.8 Compliance Checklist

Every Primary Key implementation SHALL satisfy all of the following:

✓ Canonical naming

✓ BIGINT Identity

✓ Surrogate Key

✓ Immutable

✓ Database-generated

✓ Single-column Primary Key

✓ PRIMARY KEY constraint

✓ Repository consistency

✓ Architecture compliance

---

# 15. Canonical Examples

## 15.1 Purpose

This section provides canonical Primary Key examples for the core business
entities of the Phoenix Platform.

These examples SHALL be used as the authoritative implementation reference
for future database development.

---

## 15.2 Exchange

Entity:

Exchange

Primary Key:

```text
exchange_id
```

Implementation:

```sql
exchange_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Constraint:

```sql
CONSTRAINT pk_exchange
    PRIMARY KEY
    (
        exchange_id
    )
```

---

## 15.3 Market

Entity:

Market

Primary Key:

```text
market_id
```

Implementation:

```sql
market_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Constraint:

```sql
CONSTRAINT pk_market
    PRIMARY KEY
    (
        market_id
    )
```

---

## 15.4 Trading Board

Entity:

Trading Board

Primary Key:

```text
trading_board_id
```

Implementation:

```sql
trading_board_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Constraint:

```sql
CONSTRAINT pk_trading_board
    PRIMARY KEY
    (
        trading_board_id
    )
```

---

## 15.5 Instrument

Entity:

Instrument

Primary Key:

```text
instrument_id
```

Implementation:

```sql
instrument_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Constraint:

```sql
CONSTRAINT pk_instrument
    PRIMARY KEY
    (
        instrument_id
    )
```

---

## 15.6 Issuer

Entity:

Issuer

Primary Key:

```text
issuer_id
```

Implementation:

```sql
issuer_id BIGINT
    GENERATED ALWAYS AS IDENTITY
```

Constraint:

```sql
CONSTRAINT pk_issuer
    PRIMARY KEY
    (
        issuer_id
    )
```

---

## 15.7 Repository Pattern

Every Primary Key within the Phoenix Platform SHALL follow the same
canonical implementation pattern.

```sql
<entity>_id BIGINT
    GENERATED ALWAYS AS IDENTITY,

CONSTRAINT pk_<entity>
    PRIMARY KEY
    (
        <entity>_id
    )
```

This pattern SHALL be applied consistently across all schemas and database
objects.

---

## 15.8 Compliance

All canonical examples SHALL comply with:

- ColumnNamingStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- Enterprise Constraint Naming Standard

These examples SHALL be considered the official implementation reference
for Primary Keys.

---

# 16. Architecture Rules

## 16.1 Purpose

This section defines the architectural governance rules applicable to
Primary Keys throughout the Phoenix Platform.

These rules ensure long-term consistency, maintainability, and repository
stability.

---

## 16.2 Enterprise Standard

Primary Keys SHALL be implemented uniformly across the entire repository.

Project-specific or module-specific Primary Key strategies are prohibited.

---

## 16.3 Single Source of Truth

The architectural rules governing Primary Keys SHALL be defined exclusively
within this document.

Related standards MAY reference this document but SHALL NOT redefine
Primary Key policies.

This document governs Primary Key architecture only. Column naming conventions SHALL remain exclusively governed by the ColumnNamingStandard.

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

All schemas, services, and database modules SHALL implement Primary Keys
using the same architectural principles.

Repository-wide consistency SHALL take precedence over local optimization.

---

## 16.6 Standard Evolution

Future database standards SHALL reference this document whenever Primary
Key behavior is discussed.

Duplicate Primary Key implementation rules across multiple standards are
prohibited.

---

## 16.7 Architecture Freeze

Once approved, the Primary Key strategy SHALL be considered architecturally
frozen.

Changes SHALL require:

- Business justification
- Repository impact assessment
- Migration strategy
- Enterprise Architecture approval

Architectural stability SHALL take precedence over stylistic preference.

---

## 16.8 Compliance

Every Primary Key implementation SHALL comply with:

- Enterprise Architecture principles
- Repository governance
- Approved ADRs
- Related database standards

Compliance with these rules is mandatory.

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative enterprise documents governing
Primary Key implementation within the Phoenix Platform.

Only the documents referenced herein SHALL be considered normative for
Primary Key design.

---

## 17.2 Normative References

The following documents SHALL be complied with when implementing Primary
Keys.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| Enterprise Naming Standard | Enterprise naming principles |
| ColumnNamingStandard | Primary Key column naming |
| ForeignKeyDesignStandard | Foreign Key implementation |
| AuditColumnDesignStandard | Enterprise audit columns |
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
| ConstraintNamingStandard | Constraint naming conventions |
| DatabaseConstraintStandard | Constraint implementation |
| DatabaseIndexStandard | Index implementation and optimization |
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
architecture, implementation, and lifecycle management of Primary Keys.

Other standards MAY reference this document but SHALL NOT redefine Primary
Key rules.

---

## 17.6 Repository Compliance

Every database object implemented within the Phoenix Platform SHALL comply
with this standard.

Compliance SHALL be verified during architecture review and repository
certification.

---

# 18. Revision History

## 18.1 Purpose

This section records the revision history and lifecycle of the Enterprise
Primary Key Design Standard.

All approved modifications SHALL be documented to ensure complete
traceability.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Primary Key Design Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this standard SHALL be managed under the Enterprise Governance
Framework.

Every modification SHALL include:

- Change justification
- Architecture impact assessment
- Repository impact assessment
- Version update
- Formal approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing Primary Key implementations SHALL include a
repository-wide impact analysis.

Migration activities SHALL preserve referential integrity and repository
consistency.

---

## 18.5 Architecture Freeze

Once approved, the Primary Key strategy SHALL be considered
architecturally frozen.

Changes SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Migration strategy
- Version increment

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

This document is the single authoritative source governing Primary Key
architecture within the Phoenix Platform.

All database tables, SQL scripts, database models, and implementation
artifacts SHALL comply with this standard.

Primary Key rules SHALL NOT be duplicated or redefined in other repository
documents.

---

## End of Document