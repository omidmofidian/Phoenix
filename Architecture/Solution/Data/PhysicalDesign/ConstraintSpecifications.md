# Constraint Specifications

---

# 1. Document Information

| Item | Value |
|------|-------|
| Document | Constraint Specifications |
| Layer | Physical Database Design |
| Directory | Architecture/Solution/Data/PhysicalDesign |
| Version | 2026.2 |
| Status | Approved |
| Owner | Database Architecture |
| Audience | Database Architects, Solution Architects, Database Developers, Backend Developers |
| Database Platform | PostgreSQL 17 |
| Classification | Canonical Physical Database Design Artifact |
| Last Updated | 2026-07-24 |

---

# 2. Purpose

This document defines the canonical physical specification for every database constraint implemented within the Phoenix Platform.

Its primary objective is to establish a single enterprise-wide standard for designing, documenting, validating, and generating PostgreSQL database constraints.

The specification ensures that all constraints are implemented consistently across every database schema while preserving architectural integrity, business consistency, and long-term maintainability.

This document is the authoritative source for constraint implementation and serves as the direct architectural input for PostgreSQL DDL generation.

---

# 3. Scope

This document governs every constraint implemented throughout the Phoenix Platform database.

The scope includes, but is not limited to:

- Primary Keys
- Alternate Keys
- Unique Constraints
- Foreign Keys
- CHECK Constraints
- Exclusion Constraints
- Deferrable Constraints
- Composite Constraints
- Referential Integrity Rules
- Constraint Naming Standards
- Constraint Validation Rules
- Constraint Traceability
- Constraint Governance

This specification applies to every schema, every table, and every future database module introduced into the Phoenix Platform.

---

# 4. Objectives

The objectives of this specification are to:

- establish a unified enterprise constraint architecture;
- preserve business integrity through physical implementation;
- ensure deterministic PostgreSQL DDL generation;
- eliminate ambiguity during database implementation;
- standardize constraint naming;
- standardize referential integrity implementation;
- improve repository consistency;
- simplify database maintenance;
- support long-term scalability;
- support future multi-market expansion.

---

# 5. Architecture Position

Constraint Specifications occupy the physical implementation layer of the enterprise data architecture.

They define **how database integrity is physically enforced** after business semantics have already been approved.

The architectural flow is:

```text
Business Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
PostgreSQL Physical Database Design
        │
        ▼
PostgreSQL Design Decisions
        │
        ▼
Constraint Specifications
        │
        ▼
DDL Scripts
        │
        ▼
Database Deployment
```

Constraint Specifications shall never redefine business rules.

Instead, they translate approved architectural relationships into executable PostgreSQL constraint definitions.

---

# 6. Relationship to Other Physical Design Documents

This document complements the remaining Physical Design artifacts.

Its responsibilities are intentionally separated from the other documents.

| Document | Responsibility |
|----------|----------------|
| PostgreSQLPhysicalDatabaseDesign.md | Overall PostgreSQL implementation architecture |
| PostgreSQLDesignDecisions.md | Physical implementation decisions and standards |
| TablePhysicalSpecifications.md | Complete physical definition of every table |
| ConstraintSpecifications.md | Canonical specification of all database constraints |
| IndexSpecifications.md *(future)* | Physical index implementation |
| PartitionStrategy.md *(future)* | Physical partition implementation |

Each document owns a distinct architectural responsibility.

No document shall duplicate the responsibilities assigned to another Physical Design artifact.

---

# 7. Repository Position

This document is maintained under the canonical Physical Design directory.

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
            ├── README.md
            ├── PostgreSQLPhysicalDatabaseDesign.md
            ├── PostgreSQLDesignDecisions.md
            ├── TablePhysicalSpecifications.md
            ├── ConstraintSpecifications.md
            ├── IndexSpecifications.md
            ├── PartitionStrategy.md
            └── StorageStrategy.md
```

ConstraintSpecifications.md is the authoritative specification for every constraint that will ultimately be implemented under:

```text
Data/
└── Database/
    └── DDL/
        ├── Tables/
        └── Constraints/
```

No database constraint shall be implemented without a corresponding specification in this document.

---

# 8. Intended Audience

This specification is intended for:

- Enterprise Architects
- Solution Architects
- Database Architects
- PostgreSQL Developers
- Backend Developers
- Database Administrators
- Quality Assurance Engineers
- Repository Maintainers

All contributors responsible for database implementation shall comply with the standards defined herein.

---

# 9. Design Philosophy

Constraint implementation shall follow several fundamental principles.

Every constraint shall be:

- architecture-driven;
- deterministic;
- implementation-ready;
- reproducible;
- fully documented;
- traceable;
- technology-specific only where appropriate;
- independent of application workflows.

Business semantics originate in higher architectural layers.

Constraint Specifications define only the physical enforcement mechanism within PostgreSQL.

---

# 10. Guiding Principles

Every database constraint implemented within the Phoenix Platform shall comply with the following principles:

1. Preserve approved business semantics.
2. Enforce structural integrity.
3. Avoid implementation ambiguity.
4. Follow Enterprise Naming Standards.
5. Support deterministic DDL generation.
6. Maintain repository consistency.
7. Support long-term maintainability.
8. Remain fully traceable to enterprise architecture.
9. Minimize implementation complexity.
10. Remain compatible with PostgreSQL 17 and future supported PostgreSQL versions.

---

# 11. Constraint Architecture

Database constraints represent the physical enforcement layer of enterprise data integrity.

They define the structural rules that guarantee consistency between database objects while preserving the business semantics established by higher architectural layers.

Constraints shall never introduce new business logic.

Instead, they enforce approved relationships through PostgreSQL-native mechanisms.

---

# 12. Constraint Lifecycle

Every constraint follows a defined lifecycle throughout the Phoenix Platform.

```text
Business Requirement
        │
        ▼
Conceptual Relationship
        │
        ▼
Logical Constraint
        │
        ▼
Physical Constraint Specification
        │
        ▼
PostgreSQL Constraint
        │
        ▼
DDL Script
        │
        ▼
Database Deployment
```

At no stage shall manual interpretation alter the approved architectural intent.

---

# 13. Constraint Design Principles

Every database constraint shall comply with the following design principles.

### 13.1 Deterministic

The same architectural specification shall always produce the same PostgreSQL implementation.

---

### 13.2 Explicit

Every constraint shall be explicitly documented.

Implicit or automatically generated constraints shall not be relied upon unless required by PostgreSQL.

---

### 13.3 Traceable

Every constraint shall remain traceable back to:

- Business Architecture
- Logical Database Model
- Enterprise Data Dictionary
- Physical Database Model

---

### 13.4 Maintainable

Constraint definitions shall be understandable without requiring implementation-specific knowledge.

---

### 13.5 Portable

Where practical, constraint specifications should remain compatible with future supported PostgreSQL versions.

---

### 13.6 Repository Consistency

Equivalent business rules shall always be enforced using equivalent physical constraints.

Different implementations for identical business rules are prohibited.

---

# 14. Constraint Categories

The Phoenix Platform classifies database constraints into several categories.

Each category serves a distinct architectural purpose.

```text
Primary Key

Alternate Key

Unique Constraint

Foreign Key

CHECK Constraint

Exclusion Constraint

Deferrable Constraint
```

Each constraint belongs to exactly one primary category.

---

# 15. Constraint Responsibilities

Constraint Specifications define:

- physical integrity;
- referential integrity;
- uniqueness;
- structural validation;
- implementation consistency.

Constraint Specifications do not define:

- business workflows;
- authorization rules;
- application logic;
- calculation rules;
- reporting rules;
- trading rules.

Those responsibilities belong to higher architectural layers.

---

# 16. Constraint Documentation Standard

Every documented constraint shall contain sufficient information for deterministic PostgreSQL implementation.

At minimum, each specification shall document:

- Constraint Name
- Constraint Type
- Owning Table
- Participating Columns
- Referenced Table (if applicable)
- Validation Expression (if applicable)
- Referential Action
- Purpose
- Dependencies
- PostgreSQL Implementation Notes

No undocumented constraint shall be implemented.

---

# 17. Constraint Classification Matrix

Each table specification shall classify its constraints according to the following matrix.

| Constraint Type | Required | Optional |
|-----------------|----------|----------|
| Primary Key | Yes | No |
| Alternate Key | Usually | Yes |
| Foreign Key | When applicable | No |
| CHECK Constraint | When applicable | Yes |
| Exclusion Constraint | Rare | Yes |
| Deferrable Constraint | Rare | Yes |

This classification ensures consistent implementation throughout the repository.

---

# 18. Architectural Rules

The following architectural rules apply to every database constraint.

### Rule 1

Every table shall have exactly one Primary Key.

---

### Rule 2

Every business identifier shall be protected by an Alternate Key or Unique Constraint.

---

### Rule 3

Every logical relationship shall be implemented using a Foreign Key unless an approved architectural exception exists.

---

### Rule 4

Every validation that can be enforced safely within PostgreSQL should be implemented as a CHECK Constraint.

---

### Rule 5

Application logic shall never replace structural database integrity.

---

### Rule 6

Constraint implementations shall remain consistent across all schemas.

---

### Rule 7

Constraint names shall comply with Enterprise Naming Standards.

---

### Rule 8

Every implemented constraint shall be traceable to an approved architectural artifact.

---

# 19. Constraint Metadata

Every constraint definition shall maintain the following metadata.

| Metadata | Description |
|----------|-------------|
| Name | Canonical constraint name |
| Type | Constraint category |
| Table | Owning table |
| Schema | Owning schema |
| Version | Specification version |
| Status | Approved / Deprecated |
| Created By | Architecture |
| Last Updated | Revision date |

This metadata supports repository governance, automated validation, and future documentation generation.

---

# 20. Relationship to DDL Generation

Constraint Specifications serve as the authoritative input for generating PostgreSQL DDL.

The implementation flow is:

```text
Constraint Specification

↓

PostgreSQL Constraint

↓

DDL Script

↓

Database Deployment
```

DDL developers shall not introduce additional constraints beyond those defined in this document unless they have first been approved through the architecture governance process.

---

# 21. Primary Key Specifications

Primary Keys uniquely identify every row stored within a database table.

Every table implemented in the Phoenix Platform shall contain exactly one Primary Key.

Primary Keys establish the foundation for referential integrity, indexing, and object identity throughout the platform.

---

## 21.1 Objectives

Primary Keys shall:

- uniquely identify every record;
- remain immutable;
- support efficient indexing;
- enable foreign key relationships;
- simplify data synchronization;
- preserve long-term data integrity.

---

## 21.2 General Rules

The following rules apply to every Primary Key.

### Rule 1

Every table shall have one and only one Primary Key.

---

### Rule 2

Primary Keys shall use surrogate identifiers.

Business identifiers shall never serve as Primary Keys.

---

### Rule 3

Primary Keys shall never contain business meaning.

---

### Rule 4

Primary Keys shall never be updated after creation.

---

### Rule 5

Primary Keys shall always be indexed.

---

## 21.3 PostgreSQL Implementation

Unless explicitly approved otherwise, Primary Keys shall be implemented as:

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

Example

```sql
CONSTRAINT pk_company
PRIMARY KEY (id)
```

---

## 21.4 Naming Standard

Primary Key names shall follow the Enterprise Naming Standard.

Format

```text
pk_<table_name>
```

Examples

```text
pk_exchange

pk_market

pk_company

pk_instrument

pk_daily_market_data
```

Automatically generated PostgreSQL names shall not be used.

---

## 21.5 Composite Primary Keys

Composite Primary Keys are prohibited unless explicitly approved by the Enterprise Architect.

Historical uniqueness shall instead be implemented through Alternate Keys.

---

# 22. Alternate Key Specifications

Alternate Keys preserve business uniqueness independently of the internal surrogate identifier.

They provide stable business identifiers while allowing Primary Keys to remain implementation-specific.

---

## 22.1 Purpose

Alternate Keys ensure:

- business uniqueness;
- duplicate prevention;
- external integration;
- business traceability.

---

## 22.2 General Rules

Business identifiers shall always be protected using Alternate Keys.

Examples include:

```text
exchange_code

market_code

company_code

instrument_code

public_id
```

---

## 22.3 Composite Alternate Keys

Composite business identifiers shall use composite unique constraints.

Example

```text
(exchange_id, market_code)
```

---

## 22.4 PostgreSQL Implementation

Example

```sql
CONSTRAINT uk_market_exchange_code
UNIQUE
(
    exchange_id,
    market_code
)
```

---

## 22.5 Naming Standard

Alternate Keys shall follow:

```text
uk_<table>_<business_identifier>
```

Examples

```text
uk_exchange_code

uk_market_exchange_code

uk_company_code

uk_instrument_code
```

---

## 22.6 UUID Constraints

Every public UUID identifier shall be protected using an Alternate Key.

Example

```sql
CONSTRAINT uk_company_public_id
UNIQUE (public_id)
```

---

# 23. Foreign Key Specifications

Foreign Keys enforce approved relationships between business entities.

They represent one of the most important structural integrity mechanisms within the Phoenix Platform.

---

## 23.1 Purpose

Foreign Keys ensure:

- referential integrity;
- relationship consistency;
- dependency enforcement;
- architectural correctness.

---

## 23.2 General Rules

Every logical relationship documented within the Logical Database Model shall be implemented as a Foreign Key unless an approved architectural exception exists.

---

## 23.3 Parent Table Requirements

Referenced tables shall:

- possess a Primary Key;
- exist prior to deployment;
- remain stable.

---

## 23.4 Child Table Requirements

Referencing tables shall:

- contain matching data types;
- contain compatible nullability;
- support efficient lookup through indexes.

---

## 23.5 PostgreSQL Implementation

Example

```sql
CONSTRAINT fk_market_exchange
FOREIGN KEY (exchange_id)
REFERENCES market.exchange(id)
```

---

## 23.6 Naming Standard

Foreign Keys shall follow:

```text
fk_<child_table>_<parent_table>
```

Examples

```text
fk_market_exchange

fk_company_industry

fk_instrument_company

fk_daily_market_data_instrument
```

---

## 23.7 Referential Actions

Unless explicitly documented otherwise, the following referential actions shall apply.

```text
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

Other actions require architectural approval.

---

## 23.8 Required Indexes

Every Foreign Key shall have a supporting index.

Example

```sql
CREATE INDEX ix_market_exchange
ON market.market(exchange_id);
```

---

# 24. Referential Integrity Rules

Referential integrity shall preserve structural consistency throughout the database.

---

## Rule 1

Child records shall never reference non-existent parent records.

---

## Rule 2

Parent deletion shall not invalidate existing business history.

---

## Rule 3

Historical operational data shall remain protected against accidental cascading deletes.

---

## Rule 4

Application code shall never replace database referential integrity.

---

## Rule 5

Every approved entity relationship shall remain physically enforceable throughout the database lifecycle.

---

# 25. CHECK Constraint Specifications

CHECK Constraints enforce column-level and row-level validation rules that can be evaluated entirely within PostgreSQL.

They provide the first line of defense against invalid data entering the database.

Unlike application validation, CHECK Constraints guarantee that every data modification complies with approved architectural rules regardless of the source application.

---

## 25.1 Purpose

CHECK Constraints ensure:

- domain validation;
- numeric validation;
- logical consistency;
- mandatory business rules that are independent of application workflows;
- protection against invalid values.

---

## 25.2 General Rules

CHECK Constraints shall only enforce rules that:

- depend solely on values within the current row;
- are deterministic;
- can be evaluated by PostgreSQL;
- do not require querying other tables.

---

## 25.3 Typical Usage

Typical CHECK Constraints include:

- positive numeric values;
- valid percentages;
- valid date ranges;
- allowed status values;
- valid string lengths;
- non-empty business identifiers.

---

## 25.4 PostgreSQL Implementation

Example

```sql
CONSTRAINT ck_company_name
CHECK
(
    company_name <> ''
)
```

Example

```sql
CONSTRAINT ck_price_positive
CHECK
(
    close_price >= 0
)
```

Example

```sql
CONSTRAINT ck_listing_dates
CHECK
(
    delisting_date IS NULL
    OR
    delisting_date >= listing_date
)
```

---

## 25.5 Naming Standard

CHECK Constraints shall follow:

```text
ck_<table>_<business_rule>
```

Examples

```text
ck_company_name

ck_market_code

ck_instrument_symbol

ck_daily_market_data_price
```

---

## 25.6 Design Guidelines

CHECK Constraints should:

- remain simple;
- be easy to understand;
- avoid unnecessary complexity;
- document obvious business assumptions.

---

## 25.7 Prohibited Usage

CHECK Constraints shall not:

- reference other tables;
- contain subqueries;
- perform calculations requiring external data;
- duplicate application workflow logic.

---

# 26. Exclusion Constraint Specifications

Exclusion Constraints prevent conflicting records that cannot be enforced using ordinary UNIQUE Constraints.

Although rarely required within the Phoenix Platform, PostgreSQL provides powerful exclusion capabilities for specialized business requirements.

---

## 26.1 Purpose

Exclusion Constraints prevent overlapping or mutually exclusive values.

Typical use cases include:

- overlapping effective date ranges;
- overlapping validity periods;
- duplicate temporal assignments;
- spatial conflicts.

---

## 26.2 General Rules

Exclusion Constraints shall only be implemented when:

- UNIQUE Constraints are insufficient;
- CHECK Constraints cannot express the required rule;
- PostgreSQL GiST or SP-GiST indexes are appropriate.

---

## 26.3 PostgreSQL Example

```sql
EXCLUDE USING gist
(
    instrument_id WITH =,
    daterange(effective_from, effective_to) WITH &&
)
```

---

## 26.4 Naming Standard

```text
ex_<table>_<rule>
```

Example

```text
ex_instrument_listing_period
```

---

## 26.5 Approval Requirement

Every Exclusion Constraint requires explicit approval from the Database Architect.

---

# 27. Deferrable Constraint Specifications

Deferrable Constraints postpone validation until transaction completion.

They are intended only for advanced implementation scenarios.

---

## 27.1 Purpose

Deferrable Constraints support:

- complex batch loading;
- circular dependency resolution;
- controlled migration procedures.

---

## 27.2 General Rules

Default behavior shall be:

```text
NOT DEFERRABLE
```

Only documented exceptions may use:

```text
DEFERRABLE

INITIALLY DEFERRED
```

---

## 27.3 PostgreSQL Example

```sql
CONSTRAINT fk_example
FOREIGN KEY (...)
REFERENCES (...)
DEFERRABLE INITIALLY DEFERRED
```

---

## 27.4 Usage Restrictions

Deferrable Constraints shall not be used during normal OLTP processing unless justified by documented architectural requirements.

---

# 28. Constraint Naming Standards

Every database constraint shall follow the Enterprise Naming Standard.

Constraint names shall be:

- deterministic;
- readable;
- unique within a schema;
- descriptive.

---

## 28.1 Prefix Standards

| Constraint Type | Prefix |
|-----------------|--------|
| Primary Key | pk |
| Alternate Key | uk |
| Foreign Key | fk |
| CHECK | ck |
| Exclusion | ex |

---

## 28.2 Naming Format

```text
<prefix>_<table_name>_<business_name>
```

Examples

```text
pk_company

uk_company_code

fk_company_industry

ck_company_name

ex_listing_period
```

---

## 28.3 Naming Rules

Constraint names shall:

- use lowercase;
- use underscores;
- avoid abbreviations unless standardized;
- remain stable over time.

---

## 28.4 Maximum Length

Constraint names should remain comfortably within PostgreSQL identifier limits.

Names should be concise while remaining descriptive.

---

# 29. Referential Action Standards

Referential actions determine how parent-child relationships behave during UPDATE and DELETE operations.

The Phoenix Platform adopts conservative referential actions to preserve historical integrity.

---

## 29.1 Default Behavior

Unless explicitly approved otherwise:

```sql
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

shall be used.

---

## 29.2 CASCADE

CASCADE may be used only when deleting the parent is guaranteed not to destroy valuable historical data.

Approval from the Database Architect is required.

---

## 29.3 SET NULL

SET NULL may be used only when:

- nullable relationships are valid;
- business semantics remain correct.

---

## 29.4 SET DEFAULT

SET DEFAULT shall only be used when documented default reference records exist.

---

## 29.5 NO ACTION

NO ACTION shall only be used when its behavior is intentionally different from RESTRICT and the difference has been documented.

---

## 29.6 Summary Matrix

| Action | Default | Requires Approval |
|---------|---------|-------------------|
| RESTRICT | Yes | No |
| CASCADE | No | Yes |
| SET NULL | No | Yes |
| SET DEFAULT | No | Yes |
| NO ACTION | Rare | Yes |

Historical business data shall always be preserved.

Referential actions shall never compromise auditability or enterprise traceability.

---

# 30. Business Integrity Rules

Database constraints are responsible for enforcing structural integrity, while business integrity originates from the enterprise architecture.

Only business rules that can be expressed deterministically at the database level shall be implemented as database constraints.

Application workflows, calculations, authorization policies, and process orchestration remain outside the responsibility of database constraints.

---

## 30.1 Structural Integrity

Structural integrity guarantees that every record stored in the database satisfies the minimum architectural requirements.

Structural integrity includes:

- valid primary keys;
- valid foreign keys;
- mandatory attributes;
- uniqueness;
- domain validation;
- valid relationships.

---

## 30.2 Business Integrity

Business integrity ensures that database contents remain consistent with approved enterprise business semantics.

Examples include:

- every Instrument belongs to one Company;
- every Company belongs to one Industry;
- every Industry belongs to one Sector;
- every Market belongs to one Exchange.

These relationships shall always be enforced through Foreign Keys.

---

## 30.3 Data Integrity

Data integrity shall be maintained at every layer.

```text
Business Rules
        │
        ▼
Logical Constraints
        │
        ▼
Physical Constraints
        │
        ▼
Database Integrity
```

Violation of any physical constraint represents a violation of enterprise data integrity.

---

## 30.4 Integrity Responsibilities

| Layer | Responsibility |
|--------|----------------|
| Business Architecture | Business semantics |
| Logical Model | Business relationships |
| Physical Design | Constraint specification |
| PostgreSQL | Constraint enforcement |
| Application | Workflow execution |

These responsibilities shall never overlap.

---

# 31. Constraint Implementation Matrix

Every supported constraint type shall follow a standardized implementation strategy.

| Constraint Type | PostgreSQL Object | Mandatory | Naming Prefix |
|-----------------|------------------|------------|---------------|
| Primary Key | PRIMARY KEY | Yes | pk |
| Alternate Key | UNIQUE | Usually | uk |
| Foreign Key | FOREIGN KEY | When required | fk |
| CHECK | CHECK | When required | ck |
| Exclusion | EXCLUDE | Rare | ex |
| Deferrable | DEFERRABLE | Rare | Existing Prefix |

---

## 31.1 Table-Level Matrix

The following matrix summarizes the expected constraints for the primary Phoenix entities.

| Table | PK | UK | FK | CHECK |
|--------|----|----|----|--------|
| Exchange | ✓ | ✓ | — | ✓ |
| Market | ✓ | ✓ | ✓ | ✓ |
| Trading Board | ✓ | ✓ | ✓ | ✓ |
| Sector | ✓ | ✓ | — | ✓ |
| Industry | ✓ | ✓ | ✓ | ✓ |
| Company | ✓ | ✓ | ✓ | ✓ |
| Instrument | ✓ | ✓ | ✓ | ✓ |
| Instrument Listing | ✓ | ✓ | ✓ | ✓ |
| Trading Calendar | ✓ | ✓ | ✓ | ✓ |
| Daily Market Data | ✓ | ✓ | ✓ | ✓ |
| Corporate Action | ✓ | ✓ | ✓ | ✓ |
| External Identifier | ✓ | ✓ | — | ✓ |

---

## 31.2 Implementation Policy

Constraint implementation shall follow the approved architectural specification exactly.

Implementation teams shall not:

- remove constraints;
- rename constraints;
- introduce undocumented constraints;
- weaken referential integrity;
- replace database integrity with application logic.

---

# 32. Constraint Validation Rules

Every implemented constraint shall be validated before repository acceptance.

Validation shall be performed during:

- DDL review;
- automated testing;
- database deployment;
- architecture compliance review.

---

## 32.1 Primary Key Validation

Validation shall verify:

- existence;
- uniqueness;
- naming compliance;
- identity implementation.

---

## 32.2 Alternate Key Validation

Validation shall verify:

- uniqueness;
- business identifier protection;
- naming compliance.

---

## 32.3 Foreign Key Validation

Validation shall verify:

- referenced table;
- referenced column;
- matching data types;
- supporting indexes;
- referential actions.

---

## 32.4 CHECK Constraint Validation

Validation shall verify:

- expression correctness;
- deterministic behavior;
- naming compliance.

---

## 32.5 Repository Validation

Repository validation confirms that:

- every documented constraint exists;
- every implemented constraint is documented;
- no undocumented constraint exists.

---

# 33. Traceability

Every constraint implemented within the Phoenix Platform shall remain fully traceable to enterprise architecture.

---

## 33.1 Architectural Traceability

```text
Business Requirement
        │
        ▼
Business Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
Constraint Specifications
        │
        ▼
DDL
        │
        ▼
Database Deployment
```

---

## 33.2 Repository Traceability

Constraint specifications reside in:

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
            └── ConstraintSpecifications.md
```

Executable SQL shall reside in:

```text
Data/
└── Database/
    └── DDL/
        └── Constraints/
```

Constraint specifications define the implementation.

DDL implements the specification.

The two shall always remain synchronized.

---

## 33.3 Change Traceability

Every modification to an existing constraint shall be traceable through:

- Architecture Decision Records (ADRs), where applicable;
- Git commit history;
- Repository review process;
- version history recorded within this document.

---

# 34. Governance

Constraint Specifications are governed under the Phoenix Enterprise Architecture Governance Framework.

This document is a controlled architectural artifact and serves as the authoritative source for implementing database constraints across the Phoenix Platform.

No deviation from this specification is permitted without formal architectural approval.

---

## 34.1 Governance Objectives

Governance ensures that:

- structural integrity is preserved;
- business semantics remain consistent;
- PostgreSQL implementations remain standardized;
- repository quality remains uniform;
- future database evolution remains manageable.

---

## 34.2 Ownership

| Responsibility | Owner |
|---------------|-------|
| Business Semantics | Enterprise Architect |
| Logical Relationships | Solution Architect |
| Physical Constraint Design | Database Architect |
| PostgreSQL Implementation | Database Developer |
| Repository Compliance | Repository Maintainer |

---

## 34.3 Approval Authority

The following changes require approval from the Database Architect:

- adding constraints;
- removing constraints;
- modifying constraint definitions;
- changing naming conventions;
- modifying referential actions;
- introducing exclusion constraints;
- introducing deferrable constraints.

Changes affecting business semantics additionally require Enterprise Architect approval.

---

## 34.4 Change Control

Every modification shall satisfy the following process.

```text
Architecture Proposal
        │
        ▼
Architecture Review
        │
        ▼
Approval
        │
        ▼
Physical Design Update
        │
        ▼
DDL Update
        │
        ▼
Validation
        │
        ▼
Repository Commit
```

No implementation change shall bypass this workflow.

---

## 34.5 Compliance Requirements

Every PostgreSQL database implementation shall comply with:

- Enterprise Naming Standard;
- Enterprise Database Design Standard;
- PostgreSQL Physical Database Design;
- PostgreSQL Design Decisions;
- Table Physical Specifications;
- Constraint Specifications.

Compliance shall be verified during repository review.

---

## 34.6 Architectural Consistency

Constraint implementations shall remain consistent across all schemas.

Equivalent business relationships shall always be enforced using equivalent constraint definitions.

Architectural consistency has priority over implementation convenience.

---

## 34.7 Repository Consistency

The following directories shall always remain synchronized.

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
            ├── PostgreSQLPhysicalDatabaseDesign.md
            ├── PostgreSQLDesignDecisions.md
            ├── TablePhysicalSpecifications.md
            └── ConstraintSpecifications.md
```

```text
Data/
└── Database/
    └── DDL/
        ├── Tables/
        └── Constraints/
```

The Physical Design layer specifies the implementation.

The DDL layer implements the specification.

---

## 34.8 Periodic Review

Constraint Specifications shall be reviewed:

- before each major release;
- after approval of new ADRs affecting the data architecture;
- when introducing new database schemas;
- when introducing new market engines;
- when upgrading PostgreSQL.

Review results shall be documented in the repository.

---

# 35. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-24 | Initial enterprise constraint specification created. |
| 2026.2 | 2026-07-24 | Complete rewrite following establishment of the canonical Physical Design architecture and repository structure. |

---

# 36. Final Statement

This document is the canonical specification for every database constraint implemented within the Phoenix Platform.

It defines the physical implementation standards for:

- Primary Keys;
- Alternate Keys;
- Foreign Keys;
- CHECK Constraints;
- Exclusion Constraints;
- Deferrable Constraints;
- Referential Integrity;
- Constraint Naming;
- Constraint Validation.

All PostgreSQL constraint definitions shall be generated from this specification.

No database constraint shall be implemented without a corresponding architectural definition contained herein.

Likewise, every approved constraint defined in this document shall ultimately be implemented within the PostgreSQL DDL repository.

This approach guarantees:

- complete architectural traceability;
- deterministic DDL generation;
- enterprise-wide consistency;
- long-term maintainability;
- PostgreSQL implementation quality;
- repository integrity.

Constraint Specifications constitute one of the core architectural artifacts of the Phoenix Physical Database Design layer and provide the authoritative bridge between enterprise data architecture and executable PostgreSQL constraint implementation.

---

