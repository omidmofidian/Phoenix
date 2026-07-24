# Database Definition Language (DDL)

---

# Document Information

| Item | Value |
|------|-------|
| Document | Database Definition Language (DDL) Repository |
| Directory | Data/Database/DDL |
| Version | 2026.1 |
| Status | Approved |
| Owner | Database Architecture |
| Audience | Database Architects, Database Developers, Backend Developers, DevOps Engineers |
| Database Platform | PostgreSQL 17 |
| Classification | Database Implementation Repository |
| Last Updated | 2026-07-24 |

---

# Purpose

This directory contains the canonical PostgreSQL Database Definition Language (DDL) scripts used to create, modify, and maintain the Phoenix Platform database.

The DDL repository represents the executable implementation layer of the approved Physical Database Design.

Unlike the documents contained within the **Architecture** repository, the artifacts stored in this directory are executable SQL scripts intended for deployment.

All implementation artifacts contained herein shall be generated from the approved Physical Design specifications.

---

# Scope

The DDL repository includes SQL scripts for creating and maintaining all database structures required by the Phoenix Platform.

The scope includes:

- Database schemas
- Domains
- Tables
- Constraints
- Indexes
- Views
- Materialized Views
- Sequences
- Functions
- Procedures
- Triggers
- Extensions
- Future PostgreSQL database objects

Only executable SQL implementation artifacts belong in this directory.

---

# Architecture Position

The DDL repository is the implementation layer of the Phoenix Enterprise Database Architecture.

Its position within the overall architecture is illustrated below.

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
Physical Database Design
        │
        ▼
Database Definition Language (DDL)
        │
        ▼
Database Deployment
```

The Physical Design layer defines **what** shall be implemented.

The DDL layer implements **how** it is created within PostgreSQL.

---

# Relationship to Physical Design

The DDL repository shall remain synchronized with the canonical Physical Design specifications located under:

```text
Architecture/
└── Solution/
    └── Data/
        └── PhysicalDesign/
```

The following documents collectively govern every SQL artifact contained in this repository.

| Physical Design Document | Responsibility |
|--------------------------|----------------|
| PostgreSQLPhysicalDatabaseDesign.md | PostgreSQL implementation architecture |
| PostgreSQLDesignDecisions.md | PostgreSQL implementation decisions |
| TablePhysicalSpecifications.md | Physical table definitions |
| ConstraintSpecifications.md | Constraint implementation |
| DDLTemplateSpecification.md | SQL template and formatting rules |

The DDL repository shall never redefine architectural decisions contained within these documents.

---

# DDL Repository Philosophy

The Phoenix Platform adopts an **Architecture-Driven Database Development** approach.

Under this methodology, executable SQL scripts are implementation artifacts generated from approved architectural specifications.

The DDL repository is **not** a design repository.

Its sole responsibility is to provide executable PostgreSQL scripts that faithfully implement the approved Physical Database Design.

All database implementation shall originate from architecture.

No architectural decision shall originate within this repository.

---

# Implementation Principles

Every SQL artifact contained in this repository shall comply with the following principles.

## Architecture First

Implementation shall always follow approved architecture.

Database developers shall not redefine business semantics.

---

## Single Source of Truth

The authoritative source for implementation remains the Physical Design documentation.

DDL scripts are implementation artifacts only.

---

## Deterministic Implementation

Identical Physical Design specifications shall always produce identical SQL scripts.

Manual interpretation during implementation shall be minimized.

---

## Repository Consistency

Equivalent database objects shall always be implemented using identical structural patterns.

Repository-wide consistency has priority over developer preference.

---

## PostgreSQL Optimization

Implementation shall leverage PostgreSQL capabilities while preserving architectural independence.

Technology-specific optimizations shall never alter approved business semantics.

---

# Repository Structure

The DDL repository is organized by database object type.

```text
DDL/
│
├── README.md
│
├── Schemas/
├── Extensions/
├── Domains/
├── Tables/
├── Constraints/
├── Indexes/
├── Views/
├── MaterializedViews/
├── Sequences/
├── Functions/
├── Procedures/
├── Triggers/
└── Deployment/
```

Each directory has a single, clearly defined responsibility.

Database objects shall never be placed outside their designated directory.

---

# Directory Responsibilities

| Directory | Responsibility |
|-----------|----------------|
| Schemas | Schema creation scripts |
| Extensions | PostgreSQL extension installation |
| Domains | Domain definitions |
| Tables | Table creation scripts |
| Constraints | Foreign keys and additional constraints |
| Indexes | Performance indexes |
| Views | Logical database views |
| MaterializedViews | Materialized views |
| Sequences | Database sequences |
| Functions | SQL and PL/pgSQL functions |
| Procedures | Stored procedures |
| Triggers | Trigger definitions |
| Deployment | Deployment orchestration scripts |

This separation simplifies dependency management and deployment planning.

---

# Script Categories

Each SQL script belongs to exactly one implementation category.

Typical categories include:

- Schema Definition
- Extension Installation
- Domain Definition
- Table Definition
- Constraint Definition
- Index Definition
- View Definition
- Function Definition
- Trigger Definition
- Deployment Script

Each script shall implement only one database object.

Large multi-object implementation scripts are prohibited.

---

# Naming Conventions

Every SQL file shall follow the Enterprise Naming Standard.

Rules include:

- lowercase filenames;
- snake_case naming;
- descriptive object names;
- one object per file;
- `.sql` extension.

Examples:

```text
exchange.sql

market.sql

trading_board.sql

sector.sql

industry.sql

company.sql

instrument.sql

instrument_listing.sql

daily_market_data.sql
```

Sequential numbering of implementation scripts is discouraged except where deployment sequencing explicitly requires it.

---

# Execution Order

Database objects shall be deployed in dependency order.

The recommended execution sequence is:

```text
Schemas
        │
        ▼
Extensions
        │
        ▼
Domains
        │
        ▼
Sequences
        │
        ▼
Tables
        │
        ▼
Primary Keys
        │
        ▼
Alternate Keys
        │
        ▼
CHECK Constraints
        │
        ▼
Foreign Keys
        │
        ▼
Indexes
        │
        ▼
Views
        │
        ▼
Materialized Views
        │
        ▼
Functions
        │
        ▼
Procedures
        │
        ▼
Triggers
        │
        ▼
Deployment Validation
```

The deployment process shall always preserve dependency integrity.

No object shall be created before its dependencies exist.

---

# Dependencies

Every SQL script shall explicitly identify its dependencies.

Dependencies include:

- schemas;
- domains;
- referenced tables;
- referenced views;
- referenced functions;
- PostgreSQL extensions.

Implementation scripts shall assume only previously deployed dependencies.

Circular dependencies shall be avoided whenever possible.

Where unavoidable, deferred constraint creation shall be used.

---

# Generation Process

All SQL scripts within this repository shall be generated from the approved Physical Database Design.

The implementation workflow is:

```text
Business Requirements
        │
        ▼
Enterprise Architecture
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
Physical Database Design
        │
        ▼
DDL Template Specification
        │
        ▼
Generated SQL
        │
        ▼
Repository Validation
        │
        ▼
Deployment
```

No executable SQL shall be authored independently of the approved architectural specifications.

---

# Validation

Before a DDL artifact is accepted into the repository, it shall successfully complete all required validation stages.

Validation includes:

## Architecture Validation

Verification that the implementation conforms to the approved Physical Database Design.

---

## SQL Validation

Verification that the script is syntactically correct and compatible with PostgreSQL 17.

---

## Repository Validation

Verification that:

- the file resides in the correct directory;
- naming conventions are respected;
- documentation headers are complete;
- formatting complies with the DDL Template Specification.

---

## Functional Validation

Verification that the implemented database object behaves as defined by the approved architecture.

Only validated SQL artifacts shall become part of the canonical repository.

---

# Deployment

Deployment scripts shall orchestrate the execution of DDL artifacts while preserving dependency order.

Deployment shall be deterministic and repeatable.

Typical deployment activities include:

- database creation;
- schema creation;
- extension installation;
- object creation;
- constraint creation;
- index creation;
- validation.

Deployment logic shall remain separate from object definition scripts.

---

# Repository Governance

The DDL repository is governed under the Phoenix Enterprise Architecture Governance Framework.

All implementation artifacts shall comply with:

- Enterprise Naming Standard;
- Enterprise Database Design Standard;
- PostgreSQL Physical Database Design;
- PostgreSQL Design Decisions;
- Table Physical Specifications;
- Constraint Specifications;
- DDL Template Specification.

Architectural specifications shall always take precedence over implementation artifacts.

Repository reviews shall verify architectural compliance before any SQL artifact is approved.

---

# Related Documents

The DDL repository is governed by and derived from the canonical architectural documentation maintained within the Phoenix Platform repository.

The following documents provide the authoritative specifications for all database implementation artifacts.

| Document | Responsibility |
|----------|----------------|
| Architecture/Solution/Data/ConceptualDataModel.md | Enterprise conceptual data architecture |
| Architecture/Solution/Data/LogicalDatabaseModel.md | Logical data model |
| Architecture/Solution/Data/PhysicalDatabaseModel.md | Physical database model |
| Architecture/Solution/Data/PhysicalDesign/PostgreSQLPhysicalDatabaseDesign.md | PostgreSQL implementation architecture |
| Architecture/Solution/Data/PhysicalDesign/PostgreSQLDesignDecisions.md | PostgreSQL implementation decisions |
| Architecture/Solution/Data/PhysicalDesign/TablePhysicalSpecifications.md | Physical table definitions |
| Architecture/Solution/Data/PhysicalDesign/ConstraintSpecifications.md | Constraint implementation rules |
| Architecture/Solution/Data/PhysicalDesign/DDLTemplateSpecification.md | Canonical DDL template specification |

These documents collectively define the architectural foundation from which every DDL artifact shall be generated.

The DDL repository shall never supersede or contradict the approved Physical Design documentation.

---

# Revision History

This document records the controlled evolution of the DDL repository architecture.

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-24 | Initial DDL repository documentation created. |

Future revisions shall:

- preserve repository consistency;
- maintain synchronization with the Physical Design layer;
- document architectural rationale for repository changes;
- preserve backward traceability whenever possible.

Revision history shall remain complete throughout the lifecycle of the repository.

---

# Final Statement

The **Data/Database/DDL** repository constitutes the canonical implementation layer of the Phoenix Platform database architecture.

Its purpose is to transform the approved Physical Database Design into executable PostgreSQL SQL scripts while preserving complete architectural traceability.

Every SQL artifact contained within this repository shall:

- implement exactly one database object;
- conform to the Enterprise Naming Standard;
- follow the approved DDL Template Specification;
- remain synchronized with the Physical Design documentation;
- support deterministic deployment;
- support automated validation;
- preserve repository consistency;
- maintain long-term maintainability.

The DDL repository is an implementation repository—not a design repository.

All architectural decisions originate within the **Architecture/Solution/Data/PhysicalDesign** layer.

The DDL repository exists solely to implement those approved architectural specifications accurately, consistently, and reproducibly.

By maintaining a strict separation between architecture and implementation, the Phoenix Platform ensures:

- complete architectural traceability;
- deterministic SQL generation;
- enterprise-wide implementation consistency;
- simplified repository governance;
- high-quality PostgreSQL implementations;
- sustainable long-term evolution of the database platform.

This repository serves as the authoritative source of executable database objects and represents the final implementation stage before database deployment.

---