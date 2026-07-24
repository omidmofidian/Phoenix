# PostgreSQL Physical Database Design

---

# 1. Document Information

| Item | Value |
|------|-------|
| Document | PostgreSQL Physical Database Design |
| Directory | Architecture/Solution/Data/PhysicalDesign |
| Layer | Solution Architecture |
| Domain | Data Architecture |
| Database Platform | PostgreSQL 17 |
| Version | 2026.2 |
| Status | Architecture Freeze |
| Owner | Database Architecture |
| Repository | Phoenix Platform |
| Last Updated | 2026-07-23 |

---

# 2. Purpose

This document defines the canonical PostgreSQL Physical Database Design for the Phoenix Platform.

Its purpose is to transform the approved **Physical Database Model** into a complete PostgreSQL implementation architecture while preserving all approved business semantics, architectural principles, and enterprise database standards.

Unlike the Physical Database Model, which specifies the physical structure of the enterprise database, this document defines **how PostgreSQL shall implement that structure**.

It establishes the PostgreSQL-specific architectural decisions that govern the implementation of:

- schemas;
- tables;
- columns;
- identities;
- constraints;
- indexes;
- storage;
- partitioning;
- auditing;
- performance optimization.

This document serves as the architectural foundation for all PostgreSQL implementation artifacts maintained within the Phoenix repository.

---

# 3. Scope

The PostgreSQL Physical Database Design covers every architectural aspect required before executable SQL scripts are generated.

The scope includes:

- PostgreSQL architecture
- schema organization
- physical storage architecture
- identity management
- audit implementation
- physical optimization strategy
- PostgreSQL implementation principles
- implementation standards
- implementation governance
- DDL generation architecture

The following topics are intentionally excluded because they are maintained by dedicated architectural documents:

- table physical specifications;
- constraint definitions;
- index specifications;
- partition specifications;
- storage specifications;
- implementation execution plans.

---

# 4. Architecture Position

Within the Phoenix Enterprise Architecture, the PostgreSQL Physical Database Design occupies the architectural layer immediately preceding implementation specifications.

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
Physical Database Model
        │
        ▼
PostgreSQL Physical Database Design
        │
        ▼
Physical Design Specifications
        │
        ├── Table Physical Specifications
        ├── Constraint Specifications
        ├── Index Specifications
        ├── Partition Strategy
        └── Storage Strategy
        │
        ▼
PostgreSQL DDL Scripts
        │
        ▼
Database Deployment
```

The responsibility of this document is to define the PostgreSQL implementation architecture.

It does **not** redefine:

- business entities;
- logical relationships;
- business rules;
- logical data structures.

Those responsibilities belong respectively to:

- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary

This document acts as the architectural bridge between the enterprise data models and the PostgreSQL implementation specifications that ultimately generate executable database objects.

---

# 5. PostgreSQL Architecture Overview

The Phoenix Platform adopts PostgreSQL as its canonical relational database management system.

All physical database implementations shall conform to PostgreSQL 17 capabilities, standards, and recommended enterprise practices.

The PostgreSQL architecture has been selected to support:

- long-term maintainability;
- enterprise scalability;
- transactional consistency;
- analytical performance;
- extensibility;
- data integrity;
- future multi-market expansion.

The database architecture is implementation-driven while remaining fully aligned with the approved enterprise data models.

---

## Architectural Objectives

The PostgreSQL implementation shall achieve the following objectives.

### Enterprise Consistency

Every database object shall be implemented consistently across all schemas.

---

### Predictable Implementation

Every approved architectural artifact shall produce one deterministic PostgreSQL implementation.

No implementation ambiguity shall exist.

---

### Performance

The physical implementation shall support:

- OLTP workloads;
- analytical workloads;
- historical reporting;
- large-scale time-series processing.

---

### Extensibility

The architecture shall support future implementation of additional market engines without requiring redesign of the existing database.

---

### Maintainability

Physical implementation shall remain modular, readable, and independently maintainable.

---

### Traceability

Every PostgreSQL object shall remain traceable to:

- Enterprise Data Dictionary;
- Physical Database Model;
- Physical Design specifications;
- Architecture Decision Records (ADRs).

---

# 6. Architectural Principles

The PostgreSQL Physical Database Design follows the architectural principles defined by the Phoenix Enterprise Architecture.

---

## 6.1 Canonical Database Platform

PostgreSQL is the canonical database platform for the Phoenix Platform.

All implementation artifacts shall target PostgreSQL unless a future Architecture Decision Record explicitly approves an additional database platform.

---

## 6.2 Architecture First

Physical implementation shall always follow architectural design.

Database objects shall never be created before their governing architectural specifications have been approved.

---

## 6.3 Separation of Concerns

Architectural responsibilities are intentionally separated.

| Layer | Responsibility |
|--------|----------------|
| Conceptual Data Model | Business concepts |
| Logical Database Model | Logical structure |
| Physical Database Model | Physical architecture |
| PostgreSQL Physical Database Design | PostgreSQL implementation architecture |
| Physical Design Specifications | Object-level implementation specifications |
| DDL | Executable SQL |

Each layer shall remain independent.

---

## 6.4 Single Source of Truth

Every implementation decision shall originate from exactly one authoritative architectural artifact.

Duplicate architectural definitions are prohibited.

---

## 6.5 PostgreSQL Native Features

The implementation shall utilize PostgreSQL native capabilities whenever they improve:

- maintainability;
- integrity;
- performance;
- scalability.

Examples include:

- Identity Columns
- Native Partitioning
- Generated Columns
- UUID
- JSONB (where explicitly approved)
- Partial Indexes
- Expression Indexes

The adoption of PostgreSQL-specific features shall never invalidate the logical architecture.

---

## 6.6 Deterministic Design

Equivalent business requirements shall always produce equivalent PostgreSQL implementations.

Implementation decisions shall be standardized throughout the repository.

---

## 6.7 Implementation Independence

Business semantics shall remain independent from implementation details.

Changes to PostgreSQL implementation shall never require modification of:

- business rules;
- business entities;
- conceptual models;
- logical models.

---

## 6.8 Long-Term Stability

The PostgreSQL architecture shall prioritize long-term repository stability over short-term implementation convenience.

Architectural consistency always takes precedence over implementation shortcuts.

---

## 6.9 Repository Alignment

All PostgreSQL architectural documents shall remain fully synchronized with the canonical Phoenix repository structure.

Architectural documents shall reside under:

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
```

Executable SQL artifacts shall reside under:

```text
Data/
└── Database/
    ├── DDL/
    ├── DML/
    └── Validation/
```

This separation ensures a clear distinction between architecture and implementation while maintaining complete traceability across the repository.

---

# 7. Schema Organization

The PostgreSQL implementation shall organize database objects into dedicated schemas according to their architectural responsibilities.

Schema boundaries shall reflect logical ownership, security requirements, lifecycle characteristics, and long-term maintainability.

Schemas shall not be created solely for technical convenience.

Each schema shall represent a coherent architectural domain.

---

## 7.1 Design Principles

Schema organization shall satisfy the following principles.

- clear ownership;
- logical cohesion;
- low coupling;
- high maintainability;
- future scalability;
- security isolation.

Objects belonging to different architectural domains shall not share the same schema.

---

## 7.2 Schema Categories

The Phoenix Platform distinguishes multiple schema categories.

Typical categories include:

- Reference Data
- Market Data
- Trading Data
- Integration Data
- System Data
- Audit Data

Additional schemas may be introduced through an approved Architecture Decision Record (ADR).

---

## 7.3 Naming Standards

Schema names shall:

- use lowercase characters;
- use singular business terminology where appropriate;
- avoid abbreviations;
- remain stable across repository versions.

Examples

```text
market

trading

integration

audit

system
```

---

## 7.4 Cross-Schema References

Foreign keys between schemas are permitted when required by the approved Physical Database Model.

Cross-schema dependencies shall remain explicit.

Example

```text
trading.daily_market_data

        │

        ▼

market.instrument_listing
```

Cross-schema references shall never introduce circular architectural dependencies.

---

# 8. Database Object Organization

Database objects shall be organized according to standardized implementation rules.

Each object type has a single architectural responsibility.

---

## 8.1 Tables

Tables represent persistent business or infrastructure entities.

Their physical implementation shall be governed exclusively by:

```text
TablePhysicalSpecifications.md
```

---

## 8.2 Constraints

Constraint implementation shall be governed by:

```text
ConstraintSpecifications.md
```

Constraint definitions shall remain centralized.

---

## 8.3 Indexes

Index implementation shall be governed by:

```text
IndexSpecifications.md
```

Indexes shall never be duplicated across multiple architectural documents.

---

## 8.4 Partitions

Partition implementation shall follow:

```text
PartitionStrategy.md
```

Only approved partitioned tables shall implement native PostgreSQL partitioning.

---

## 8.5 Storage Configuration

Physical storage characteristics shall follow:

```text
StorageStrategy.md
```

Storage decisions shall remain independent from business modeling.

---

# 9. Physical Storage Architecture

The PostgreSQL Physical Database Design separates logical business architecture from physical storage implementation.

Storage architecture exists to optimize operational efficiency without altering approved business semantics.

---

## 9.1 Storage Objectives

The storage architecture shall optimize:

- transactional performance;
- analytical performance;
- storage efficiency;
- scalability;
- maintenance;
- backup and recovery.

---

## 9.2 Storage Independence

Business entities shall remain independent of storage decisions.

Changing:

- storage parameters;
- tablespaces;
- compression settings;
- partition placement;

shall not affect the logical or physical database models.

---

## 9.3 Storage Hierarchy

The storage architecture follows the hierarchy below.

```text
Database

    │

    ▼

Schema

    │

    ▼

Table

    │

    ▼

Partition (optional)

    │

    ▼

Index

    │

    ▼

Storage Parameters
```

Each level inherits the architectural decisions defined by higher levels while allowing controlled PostgreSQL-specific optimization.

---

## 9.4 Physical Optimization

Physical optimization may include:

- native partitioning;
- fillfactor tuning;
- TOAST optimization;
- index optimization;
- storage parameter tuning.

Such optimizations shall never change:

- business behavior;
- data integrity;
- application-visible semantics.

---

## 9.5 Implementation Responsibility

Detailed storage implementation rules are maintained separately within:

```text
StorageStrategy.md
```

This document defines only the architectural principles governing physical storage.

Implementation details shall remain isolated to preserve separation of concerns across the Physical Design layer.

---

# 10. Identity Strategy

The Phoenix Platform adopts a standardized identity strategy to ensure consistency, scalability, interoperability, and long-term maintainability across the PostgreSQL implementation.

Identity management distinguishes between internal database identifiers, public identifiers, and business identifiers.

Each identity type serves a distinct architectural purpose and shall never be substituted for another.

---

## 10.1 Internal Identifier

Every persistent entity shall contain an internal surrogate identifier.

Standard implementation

```text
id BIGINT GENERATED ALWAYS AS IDENTITY
```

Characteristics

- immutable;
- meaningless to business users;
- optimized for relational integrity;
- used as the primary key;
- never exposed as a business identifier.

---

## 10.2 Public Identifier

Entities intended to be referenced outside the database shall expose a globally unique public identifier.

Standard implementation

```text
public_id UUID
```

Characteristics

- globally unique;
- immutable;
- safe for external exposure;
- independent of database implementation;
- suitable for APIs and distributed systems.

Whenever implemented, the public identifier shall be protected by a UNIQUE constraint.

---

## 10.3 Business Identifier

Business identifiers represent meaningful identifiers defined by business rules.

Examples include:

- exchange code;
- market code;
- company registration number;
- trading symbol;
- composite business keys.

Business identifiers shall:

- remain stable whenever possible;
- be validated according to business rules;
- never replace the surrogate primary key.

---

## 10.4 Composite Business Keys

Where required by business semantics, composite business keys shall be implemented using UNIQUE constraints.

Example

```text
(trading_board_id, listing_symbol)
```

Composite business keys shall remain consistent with the Enterprise Data Dictionary.

---

## 10.5 Identity Governance

Identity strategies are defined by the architecture.

Implementation teams shall not introduce alternative identity mechanisms without formal architectural approval.

---

# 11. Audit Strategy

The Phoenix Platform distinguishes between **master data** and **operational data** when implementing auditing.

Audit implementation shall remain consistent across the entire repository.

---

## 11.1 Master Data

Master data entities shall contain the standard enterprise audit columns.

Canonical audit columns

```text
created_at

updated_at

created_by

updated_by

is_active
```

These columns support:

- traceability;
- lifecycle management;
- operational auditing;
- administrative reporting.

---

## 11.2 Operational Data

Operational datasets are typically generated automatically by system processes.

Examples include:

- Daily Market Data;
- future historical datasets;
- imported analytical datasets.

These datasets generally require only:

```text
created_at

updated_at
```

Additional audit columns may be introduced only where justified by operational requirements.

---

## 11.3 Audit Consistency

Audit implementation shall be standardized across all physical tables.

Equivalent entity categories shall always implement equivalent audit structures.

---

## 11.4 Soft Delete Policy

Where applicable, logical deletion shall be implemented using:

```text
is_active
```

Physical deletion shall be avoided unless explicitly authorized by business rules or operational policies.

---

## 11.5 Audit Responsibility

Detailed audit implementation rules are maintained within the relevant Physical Design specifications.

This document establishes only the governing architectural principles.

---

# 12. Naming Strategy

Consistent naming is essential for maintainability, readability, and automated DDL generation.

All PostgreSQL objects shall comply with the Phoenix Enterprise Naming Standards.

---

## 12.1 General Rules

Database object names shall:

- use lowercase characters;
- use snake_case;
- avoid abbreviations;
- remain descriptive;
- remain stable across repository versions.

---

## 12.2 Table Names

Table names shall represent singular business entities.

Examples

```text
exchange

market

company

instrument

instrument_listing

daily_market_data
```

---

## 12.3 Column Names

Column names shall:

- describe business meaning;
- remain implementation independent;
- avoid vendor-specific terminology.

Examples

```text
company_name

listing_symbol

effective_date

trade_value
```

---

## 12.4 Constraint Names

Constraint names shall follow standardized prefixes.

Typical examples

```text
pk_<table>

fk_<table>_<parent>

uq_<table>_<columns>

ck_<table>_<rule>
```

---

## 12.5 Index Names

Indexes shall follow standardized prefixes.

Typical examples

```text
idx_<table>_<column>

uidx_<table>_<column>
```

Composite indexes shall include sufficient descriptive information while remaining concise.

---

## 12.6 Sequence Objects

Identity columns shall rely on PostgreSQL native identity generation.

Explicit sequence objects shall not be created unless an approved architectural decision requires them.

---

## 12.7 Naming Governance

Detailed naming conventions are governed by the Enterprise Naming Standards.

This document defines only the architectural principles that every PostgreSQL implementation shall follow.

---

# 13. PostgreSQL Data Type Strategy

The Phoenix Platform adopts a standardized PostgreSQL data type strategy to ensure consistency, portability, storage efficiency, and predictable implementation.

Data types shall accurately represent business semantics while remaining optimized for PostgreSQL.

Implementation teams shall not select data types independently of these architectural rules.

---

## 13.1 General Principles

Data types shall satisfy the following objectives.

- represent business meaning;
- preserve precision;
- optimize storage;
- maximize performance;
- remain consistent across equivalent entities.

Equivalent business attributes shall always use identical PostgreSQL data types.

---

## 13.2 Numeric Data

Numeric values shall be selected according to business precision.

Typical standards include:

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Identity | BIGINT |
| Counter | INTEGER |
| Quantity | BIGINT |
| Price | NUMERIC(20,8) |
| Monetary Value | NUMERIC(24,8) |
| Percentage | NUMERIC(10,6) |

Floating-point data types (`REAL`, `DOUBLE PRECISION`) shall not be used for financial values.

---

## 13.3 Character Data

Character data shall use variable-length types unless fixed-length storage is explicitly required.

Typical standards include:

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Name | VARCHAR |
| Business Code | VARCHAR |
| Symbol | VARCHAR |
| Description | TEXT |
| External Identifier | VARCHAR |

Column lengths shall be defined according to approved business requirements.

---

## 13.4 Date and Time

Temporal attributes shall use PostgreSQL native temporal types.

Typical standards include:

| Business Meaning | PostgreSQL Type |
|------------------|-----------------|
| Calendar Date | DATE |
| Timestamp | TIMESTAMP WITH TIME ZONE |
| Audit Timestamp | TIMESTAMP WITH TIME ZONE |

The use of textual date representations is prohibited.

---

## 13.5 Boolean Data

Binary business states shall use:

```text
BOOLEAN
```

Typical examples include:

```text
is_active

is_trading_day

is_primary
```

---

## 13.6 UUID

Public identifiers shall use:

```text
UUID
```

UUID values shall never replace surrogate primary keys.

---

## 13.7 Future Extensions

Advanced PostgreSQL data types such as:

- JSONB
- ARRAY
- ENUM
- RANGE

may only be introduced through an approved Architecture Decision Record (ADR).

---

# 14. Constraint Strategy

Constraints are the primary mechanism for enforcing structural integrity within the PostgreSQL implementation.

Constraint definitions shall be centralized, standardized, and fully traceable to the approved Physical Database Model.

---

## 14.1 Constraint Categories

The PostgreSQL implementation recognizes the following constraint categories.

- Primary Key
- Foreign Key
- Unique Constraint
- Check Constraint
- Default Constraint
- Generated Column Constraint

Each category has a distinct architectural responsibility.

---

## 14.2 Primary Keys

Every persistent table shall define exactly one primary key.

Standard implementation

```text
PRIMARY KEY (id)
```

Composite primary keys are prohibited unless explicitly approved by architecture.

---

## 14.3 Foreign Keys

Foreign keys shall preserve referential integrity.

Foreign key definitions shall:

- reference surrogate keys;
- use explicit schema qualification;
- follow standardized naming conventions.

---

## 14.4 Unique Constraints

Business identifiers shall be enforced through UNIQUE constraints.

Examples include:

```text
public_id
```

and

```text
(trading_board_id, listing_symbol)
```

---

## 14.5 Check Constraints

CHECK constraints shall enforce implementation-level validation.

Examples include:

- positive numeric values;
- valid date ranges;
- mandatory business states.

Business workflows shall remain outside database constraints.

---

## 14.6 Constraint Governance

Detailed constraint definitions are maintained exclusively within:

```text
ConstraintSpecifications.md
```

This document defines only the governing architectural strategy.

---

# 15. Index Strategy

Indexes exist to optimize database access while preserving implementation consistency.

Indexing decisions shall balance read performance, write performance, maintenance overhead, and storage efficiency.

---

## 15.1 Architectural Principles

Indexes shall:

- support approved query patterns;
- preserve data integrity;
- minimize unnecessary duplication;
- remain fully documented.

Indexes shall never be created solely as ad hoc performance fixes.

---

## 15.2 Standard Index Categories

The PostgreSQL implementation supports the following categories.

### Primary Indexes

Automatically created by primary keys.

---

### Unique Indexes

Support business identifiers.

---

### Foreign Key Indexes

Support join performance and referential integrity.

---

### Lookup Indexes

Optimize common search operations.

---

### Composite Indexes

Support multi-column filtering and ordering.

---

### Analytical Indexes

Support reporting and historical analysis.

Typical examples include:

```text
trading_date

close_price

volume
```

---

## 15.3 PostgreSQL Features

The following PostgreSQL capabilities may be used where appropriate.

- Partial Indexes
- Expression Indexes
- Covering Indexes
- BRIN Indexes
- GIN Indexes

Their adoption shall require architectural justification.

---

## 15.4 Performance Validation

Every index shall demonstrate measurable benefit.

Indexes that introduce maintenance cost without operational value shall not be implemented.

---

## 15.5 Index Governance

Complete index definitions are maintained within:

```text
IndexSpecifications.md
```

This document establishes only the architectural principles governing PostgreSQL indexing.

---

# 16. Partition Strategy

The Phoenix Platform adopts PostgreSQL native partitioning for large operational datasets in order to improve scalability, maintenance, and query performance.

Partitioning is an implementation optimization and shall never modify business semantics or logical relationships.

Only tables that demonstrate clear operational or analytical benefits shall be partitioned.

---

## 16.1 Objectives

Partitioning supports the following architectural objectives.

- efficient management of historical data;
- improved analytical query performance;
- partition pruning;
- simplified archival;
- simplified backup and recovery;
- predictable long-term scalability.

---

## 16.2 Partition Eligibility

Partitioning shall be applied only to tables that satisfy one or more of the following conditions.

- continuous data growth;
- large historical datasets;
- time-series data;
- analytical workloads;
- lifecycle-based archival requirements.

Typical examples include:

```text
daily_market_data
```

Future operational tables may also become eligible following architectural review.

---

## 16.3 Preferred Strategy

The preferred PostgreSQL partitioning strategy is:

```text
RANGE Partitioning
```

using:

```text
trading_date
```

as the partition key.

This strategy aligns with the operational characteristics of financial market data.

---

## 16.4 Partition Granularity

Unless otherwise approved, the recommended partition interval is:

```text
Monthly
```

Example

```text
daily_market_data_2026_01

daily_market_data_2026_02

daily_market_data_2026_03
```

Alternative intervals (weekly, quarterly, yearly) may be introduced when justified by workload analysis.

---

## 16.5 Governance

Detailed partition definitions, maintenance procedures, and lifecycle policies are maintained in:

```text
PartitionStrategy.md
```

This document defines only the governing architectural principles.

---

# 17. Storage Strategy

The PostgreSQL storage strategy aims to provide an efficient, maintainable, and scalable physical implementation while preserving architectural consistency.

Storage optimization shall always remain transparent to business functionality.

---

## 17.1 Design Objectives

Storage decisions shall optimize:

- performance;
- storage utilization;
- maintenance;
- recoverability;
- scalability.

---

## 17.2 Storage Independence

Business entities shall remain independent of physical storage implementation.

Changing:

- tablespaces;
- fillfactor;
- compression;
- TOAST configuration;

shall never alter business behavior.

---

## 17.3 Storage Optimization

PostgreSQL storage optimization may include:

- fillfactor tuning;
- TOAST optimization;
- compression where supported;
- optimized tablespace placement.

These optimizations shall be documented before implementation.

---

## 17.4 Lifecycle Management

Storage architecture shall support:

- online maintenance;
- backup;
- restoration;
- archival;
- future storage migration.

---

## 17.5 Governance

Detailed storage implementation rules are maintained within:

```text
StorageStrategy.md
```

---

# 18. Performance Strategy

Performance optimization shall be achieved through architectural design rather than isolated implementation changes.

Optimization decisions shall remain measurable, repeatable, and traceable.

---

## 18.1 Architectural Performance Principles

Performance shall primarily be achieved through:

- normalized logical design;
- efficient physical design;
- appropriate indexing;
- native PostgreSQL partitioning;
- optimized storage;
- deterministic query patterns.

---

## 18.2 Query Optimization

Database structures shall support efficient execution of:

- point lookups;
- range queries;
- historical analysis;
- reporting;
- aggregation;
- time-series processing.

---

## 18.3 Scalability

The PostgreSQL implementation shall support long-term growth without requiring structural redesign.

Performance improvements shall prioritize architectural consistency over short-term optimization.

---

## 18.4 Performance Validation

Optimization decisions shall be supported by:

- execution plans;
- workload analysis;
- benchmark testing;
- production monitoring.

Implementation assumptions shall not replace measurable evidence.

---

# 19. Security Strategy

Database security is implemented using a layered architecture.

Security controls shall protect both business data and infrastructure assets while remaining independent of application logic.

---

## 19.1 Security Principles

The PostgreSQL implementation shall support:

- confidentiality;
- integrity;
- availability;
- accountability;
- least privilege.

---

## 19.2 Access Control

Database access shall be granted according to clearly defined roles.

Privileges shall be assigned following the principle of minimum required access.

Application services shall not operate using administrative accounts.

---

## 19.3 Data Integrity

Data integrity shall be preserved through:

- primary keys;
- foreign keys;
- unique constraints;
- check constraints;
- transactional consistency.

---

## 19.4 Auditability

Database operations shall support appropriate auditing in accordance with the enterprise audit strategy.

Audit implementation shall remain consistent with the architectural standards defined for the Phoenix Platform.

---

## 19.5 Security Governance

Security implementation details, including authentication, authorization, encryption, and operational hardening, are governed by the relevant enterprise security standards and shall remain outside the scope of this document.

---

# 20. Relationship to Physical Design Documents

The PostgreSQL Physical Database Design defines the overall implementation architecture for the PostgreSQL database.

It intentionally delegates detailed implementation specifications to dedicated documents within the **PhysicalDesign** directory.

Each document has a single architectural responsibility.

Collectively, these documents form the complete implementation specification for the Phoenix Platform database.

---

## 20.1 Architectural Responsibility Matrix

| Document | Primary Responsibility |
|-----------|------------------------|
| PostgreSQLPhysicalDatabaseDesign.md | PostgreSQL implementation architecture |
| PostgreSQLDesignDecisions.md | Implementation decisions and architectural trade-offs |
| TablePhysicalSpecifications.md | Physical implementation of every table |
| ConstraintSpecifications.md | Constraint implementation standards |
| IndexSpecifications.md | Index implementation standards |
| PartitionStrategy.md | Native partitioning strategy |
| StorageStrategy.md | Physical storage standards |
| ExecutionPlan.md | Database implementation sequence |

No document shall duplicate the responsibility of another.

---

## 20.2 Dependency Hierarchy

The Physical Design documents are intended to be consumed in the following order.

```text
Physical Database Model
        │
        ▼
PostgreSQL Physical Database Design
        │
        ▼
PostgreSQL Design Decisions
        │
        ▼
Table Physical Specifications
        │
        ├── Constraint Specifications
        ├── Index Specifications
        ├── Partition Strategy
        └── Storage Strategy
        │
        ▼
Execution Plan
        │
        ▼
DDL Scripts
```

Each layer refines the architectural decisions established by the preceding layer.

---

## 20.3 Traceability

Every PostgreSQL database object shall be traceable through the complete architectural chain.

Example

```text
Business Requirement
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Physical Database Model
        │
        ▼
PostgreSQL Physical Database Design
        │
        ▼
Table Physical Specifications
        │
        ▼
DDL Script
```

This traceability ensures that every implementation decision can be justified by an approved architectural artifact.

---

# 21. DDL Generation Flow

The Phoenix Platform follows an **Architecture-First** implementation methodology.

Executable SQL scripts are generated only after the corresponding architectural specifications have reached the **Architecture Freeze** state.

---

## 21.1 Generation Workflow

The standard workflow is shown below.

```text
Enterprise Architecture
        │
        ▼
Conceptual Data Model
        │
        ▼
Logical Database Model
        │
        ▼
Physical Database Model
        │
        ▼
Physical Design
        │
        ▼
DDL Generation
        │
        ▼
Database Validation
        │
        ▼
Deployment
```

No implementation activity shall bypass any architectural layer.

---

## 21.2 Source of DDL

The primary architectural source for generating table scripts is:

```text
TablePhysicalSpecifications.md
```

Additional implementation documents provide complementary specifications.

| Specification | Used For |
|--------------|----------|
| ConstraintSpecifications.md | Constraints |
| IndexSpecifications.md | Indexes |
| PartitionStrategy.md | Partitioned tables |
| StorageStrategy.md | Storage options |
| PostgreSQLDesignDecisions.md | PostgreSQL implementation decisions |

---

## 21.3 Generated Artifacts

The Physical Design layer produces implementation artifacts located under:

```text
Data/
└── Database/
    ├── DDL/
    │   ├── Schemas/
    │   ├── Tables/
    │   ├── Constraints/
    │   ├── Indexes/
    │   ├── Views/
    │   └── Functions/
    │
    ├── DML/
    └── Validation/
```

The Physical Design layer itself shall never contain executable SQL.

---

# 22. Governance

The PostgreSQL Physical Database Design is governed under the Phoenix Architecture Governance Framework.

All implementation decisions documented herein are considered **canonical architectural decisions**.

---

## 22.1 Ownership

| Responsibility | Owner |
|----------------|-------|
| Enterprise Architecture | Enterprise Architect |
| PostgreSQL Architecture | Database Architect |
| Physical Database Design | Database Architecture Team |
| DDL Generation | Development Team |
| Database Validation | Database Engineering |

---

## 22.2 Change Control

Changes to this document shall occur only when one or more of the following artifacts change.

- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL implementation strategy
- Enterprise Database Standards
- Architecture Decision Records (ADRs)

Direct modification of implementation rules without architectural approval is prohibited.

---

## 22.3 Review Policy

This document shall be reviewed whenever:

- a new PostgreSQL capability is adopted;
- a database architecture decision changes;
- a new schema is introduced;
- the implementation architecture is redesigned.

---

# 23. Repository Structure

The PostgreSQL Physical Database Design is maintained entirely within the **Architecture** capability of the Phoenix repository.

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
```

Its outputs are implemented within the **Data** capability.

```text
Data/
└── Database/
    ├── DDL/
    ├── DML/
    └── Validation/
```

This separation preserves a clear distinction between **architecture** and **implementation**.

Architecture defines **what shall be implemented**.

Implementation defines **how it is executed**.

This architectural boundary is mandatory throughout the Phoenix Platform repository.

---

# 24. Related Documents

The PostgreSQL Physical Database Design is part of the Phoenix Data Architecture documentation set.

It shall be interpreted together with the documents listed below.

---

## 24.1 Enterprise Data Architecture

```text
Architecture/
└── Solution/
    └── Data/
        ├── ConceptualDataModel.md
        ├── LogicalDatabaseModel.md
        ├── PhysicalDatabaseModel.md
        └── PhysicalDesign/
```

These documents collectively define the complete database architecture of the Phoenix Platform.

---

## 24.2 Physical Design Documents

The following documents complement this specification.

```text
README.md

PostgreSQLDesignDecisions.md

TablePhysicalSpecifications.md

ConstraintSpecifications.md

IndexSpecifications.md

PartitionStrategy.md

StorageStrategy.md

ExecutionPlan.md
```

Together they provide the complete implementation blueprint for PostgreSQL.

---

## 24.3 Enterprise Data Dictionary

The Enterprise Data Dictionary remains the authoritative source for:

- business entities;
- business attributes;
- business identifiers;
- business relationships;
- business rules.

Physical implementation shall never redefine information maintained within the Data Dictionary.

---

## 24.4 Architecture Decision Records

All PostgreSQL implementation decisions shall remain consistent with the approved Architecture Decision Records (ADRs).

Where conflicts arise, the ADRs take precedence.

---

## 24.5 Enterprise Standards

Implementation shall comply with the approved enterprise standards, including:

- Enterprise Database Design Standard
- Enterprise Database Standards
- Enterprise Naming Standards
- Repository Standards
- Architecture Governance Standards

---

# 25. Revision History

| Version | Date | Status | Description |
|----------|------------|----------------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-23 | Approved | Initial PostgreSQL Physical Database Design document. |
| 2026.2 | 2026-07-23 | Architecture Freeze | Complete architectural redesign. Document responsibilities separated, repository alignment updated, PostgreSQL implementation architecture formalized, governance strengthened, and traceability model established. |

---

# 26. Final Statement

The PostgreSQL Physical Database Design defines the canonical implementation architecture for PostgreSQL within the Phoenix Platform.

Its purpose is not to describe individual database objects, but to establish the architectural principles, implementation strategies, governance rules, and design standards that govern every PostgreSQL implementation.

This document serves as the architectural foundation for all Physical Design specifications and provides the implementation context from which executable PostgreSQL artifacts are derived.

The implementation lifecycle is therefore defined as:

```text
Conceptual Data Model
        │
        ▼
Logical Database Model
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
Physical Design Specifications
        │
        ▼
PostgreSQL DDL
        │
        ▼
Database Validation
        │
        ▼
Database Deployment
```

Every executable PostgreSQL artifact within the Phoenix repository shall be fully traceable to this architectural chain.

No database object shall be introduced without conformity to the approved:

- Conceptual Data Model;
- Logical Database Model;
- Physical Database Model;
- Enterprise Data Dictionary;
- PostgreSQL Physical Database Design;
- Physical Design Specifications; and
- Architecture Decision Records (ADRs).

This document, together with the remaining artifacts in the **PhysicalDesign** directory, constitutes the canonical architectural reference for PostgreSQL database implementation within the Phoenix Platform.

---

**End of Document**