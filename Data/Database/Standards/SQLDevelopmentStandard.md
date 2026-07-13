# Phoenix Platform

# SQL Development Standard

---

| Item | Value |
|------|-------|
| Standard | SDS-2026.1 |
| Title | SQL Development Standard |
| Project | Phoenix |
| Status | Approved |
| Version | 2026.1 |
| Owner | Phoenix Architecture Team |
| Target Database | PostgreSQL 17 |

---

# Purpose

This document defines the official SQL development standard for the Phoenix Platform.

All SQL artifacts shall comply with this standard.

The standard applies to:

- Initialization Scripts
- DDL Scripts
- DML Scripts
- Seed Scripts
- Validation Scripts
- Views
- Functions
- Stored Procedures
- Migration Scripts

---

# Scope

This standard applies to every SQL artifact located under:

```text
Database/
```

---

# Rule 1

## PostgreSQL Version

All SQL shall target PostgreSQL 17.

Generic SQL intended for multiple database engines is prohibited.

---

# Rule 2

## Script Idempotency

Scripts shall be idempotent whenever PostgreSQL supports it.

Examples

```sql
CREATE SCHEMA IF NOT EXISTS

CREATE TABLE IF NOT EXISTS
```

Repeated execution shall never produce inconsistent results.

---

# Rule 3

## Script Header

Every SQL file shall begin with the approved Phoenix SQL Header.

The header shall contain:

- Project
- Script Name
- Version
- Target Database
- Category
- Description
- Dependencies
- Related ADR
- Revision History

---

# Rule 4

## Transaction Management

DDL scripts shall execute inside transactions whenever PostgreSQL permits.

Statements that cannot execute inside transactions shall be isolated into dedicated scripts.

---

# Rule 5

## Database Object Naming

All database objects shall follow DDS-2026.1.

Examples

Tables

```text
company
```

Primary Keys

```text
pk_company
```

Foreign Keys

```text
fk_company_industry
```

Indexes

```text
ix_company_public_id
```

Unique Constraints

```text
uq_company_public_id
```

Check Constraints

```text
ck_price_positive
```

---

# Rule 6

## File Naming Convention

Implementation files shall follow:

```text
NNN-DescriptiveName.ext
```

Where

- NNN = three-digit sequence
- "-" separates number from name
- DescriptiveName = PascalCase
- Spaces are prohibited
- Underscores are prohibited unless required by external tools

Examples

```text
001-CreateDatabase.sql

002-CreateRoles.sql

003-GrantPermissions.sql

001-CreateMarketTables.sql

ADR-018-PostgreSQLRoleBasedSecurityModel.md
```

### Folder-Based Numbering

Every directory maintains its own numbering sequence.

Each directory starts from

```text
001
```

Execution order is determined by:

```text
Database/ExecutionOrder.md
```

---

# Rule 7

## Documentation

Every database object shall be documented.

Required

```sql
COMMENT ON TABLE

COMMENT ON COLUMN
```

Documentation is mandatory.

---

# Rule 8

## Explicit Definitions

Implicit defaults are prohibited.

Every object definition shall explicitly specify:

- data type
- nullability
- default value (where applicable)

---

# Rule 9

## Explicit Constraint Naming

Automatically generated constraint names are prohibited.

All constraints shall be explicitly named.

---

# Rule 10

## Explicit Index Naming

Automatically generated index names are prohibited.

Every index shall have an explicit name.

---

# Rule 11

## Roll-Forward Strategy

Released scripts are immutable.

Corrections shall always be implemented through new scripts.

Released files shall never be modified.

---

# Rule 12

## Deterministic Execution

Execution shall never depend on:

- current date
- session state
- locale
- operating system
- user environment

Scripts shall always produce identical results.

---

# Rule 13

## Seed Data

Seed scripts shall be repeatable.

Duplicate business records shall never be created.

---

# Rule 14

## Role-Based Security

The database security model shall follow ADR-018.

Principles

- Least Privilege
- Separation of Duties
- Explicit Permissions
- Dedicated Roles

Applications shall never connect using the database owner account.

Database ownership and runtime execution shall always use separate roles.

---

# Rule 15

## Production Readiness

Every SQL artifact shall satisfy:

- deterministic execution
- repeatability
- explicit naming
- documentation
- PostgreSQL 17 compatibility

before being approved.

---

---

# Rule-016 — Runtime Validation Requirement

## Title

Every SQL initialization script shall successfully pass runtime validation before being approved for production use.

## Description

Static validation (syntax review, code inspection, architectural review, and idempotency verification) is necessary but not sufficient.

Every SQL initialization script shall be executed at least once in a clean runtime environment that matches the target deployment platform (Docker, Kubernetes, VM, or Cloud) before the script is considered complete.

Runtime validation confirms that the script:

Executes without errors.
Produces the expected database objects.
Produces the expected security configuration.
Produces the expected ownership configuration.
Produces the expected runtime behavior.
Can be executed repeatedly when designed to be idempotent.

## Requirements

Every initialization script shall have a corresponding runtime validation step.
Runtime validation results shall be documented.
Runtime validation shall be performed on the same PostgreSQL major version targeted by the project.
Runtime validation shall be completed before freezing the sprint or releasing the database baseline.
Validation queries shall themselves be verified against PostgreSQL system catalogs before being accepted as part of the validation process.

## Rationale

Static review detects design defects.

Runtime validation detects execution defects, deployment defects, environmental assumptions, and incorrect validation logic.

Both are mandatory for enterprise-grade database development.

---

# Rule-017 
## Idempotent Initialization Scripts

All SQL scripts located under:

Database/Init/

MUST be idempotent.

Running the same initialization script multiple times shall not produce an error and shall not modify an already initialized environment.

Typical implementation techniques include:

• IF NOT EXISTS
• CREATE ... IF NOT EXISTS
• DROP ... IF EXISTS (only when explicitly approved)
• Conditional DO $$ BEGIN ... END $$ blocks

This rule applies ONLY to Initialization scripts.

Future Migration scripts are intentionally non-idempotent and shall be executed exactly once through the migration framework.

## Rationale

Docker-based development environments may be recreated multiple times during the project lifecycle.

Initialization scripts must therefore be safely repeatable.

Permission Roles and Login Roles shall always be created in separate initialization scripts.

## Exception

002-CreateDatabase.sql is intentionally non-idempotent because PostgreSQL does not allow CREATE DATABASE inside transactional blocks or procedural code

---


# References

DDS-2026.1

ARD-020 Database Security Model

DatabaseImplementationPlan.md

PhysicalDatabaseModel.md

---

# Change Control

This document is a controlled architecture standard.

After approval, this version is considered immutable.

Changes to this document are prohibited unless all of the following conditions are satisfied:

- An Architecture Review has been completed.
- The proposed changes have been approved by the Architecture Team.
- A new SDS version has been assigned.
- The revision history has been updated.

Patch modifications to an approved version are not permitted.

New requirements shall be introduced only through a new version of the SQL Development Standard.

---

# Status

```text
APPROVED

SDS-2026.1

FINAL
```