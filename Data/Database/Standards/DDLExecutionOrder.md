# DDL Execution Order

| Item | Value |
|------|------|
| Document ID | STD-DDL-002 |
| Version | 1.0 |
| Status | Draft |
| Category | Database Standard |
| Parent Standard | DatabaseDDLDevelopmentStandard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This document defines the official execution order of all Database Definition Language (DDL) scripts within the Phoenix Platform.

The objectives are:

- Ensure deterministic database deployment.
- Eliminate dependency conflicts.
- Support repeatable installations.
- Simplify database maintenance.
- Enable automated deployment pipelines.

---

# 2. Scope

This standard applies to every DDL script contained in the Phoenix repository.

It defines the logical execution sequence for creating database objects.

---

# 3. Execution Principles

The execution order shall always satisfy the following principles:

- Dependencies before dependents.
- Parent objects before child objects.
- Database structure before relationships.
- Constraints before optimization.
- Optimization before documentation.

---

# 4. High-Level Execution Order

DDL scripts shall be executed in the following phases.

| Phase | Description |
|--------|-------------|
| Phase 1 | Create Tables |
| Phase 2 | Add Foreign Keys |
| Phase 3 | Add Additional Constraints |
| Phase 4 | Create Indexes |
| Phase 5 | Create Views |
| Phase 6 | Create Materialized Views |
| Phase 7 | Create Functions |
| Phase 8 | Create Procedures |
| Phase 9 | Create Triggers |
| Phase 10 | Add Comments |
| Phase 11 | Validation |

---

# 5. Phase Details

## Phase 1 — Create Tables

This phase creates all database tables.

Only intrinsic table elements shall be created.

Allowed:

- Table definition
- Columns
- Data types
- NOT NULL
- DEFAULT
- PRIMARY KEY

Not Allowed:

- Foreign Keys
- Business Indexes
- Triggers
- Views

---

## Phase 2 — Add Foreign Keys

This phase establishes referential integrity.

Foreign keys shall only be created after every referenced table exists.

---

## Phase 3 — Add Additional Constraints

This phase creates constraints that are not part of the base table definition.

Examples:

- UNIQUE Constraints
- CHECK Constraints
- EXCLUDE Constraints

Where appropriate, simple constraints may remain inline with the table definition. Cross-object or deployment-dependent constraints should be applied in this phase.

---

## Phase 4 — Create Indexes

Indexes shall be created only after all required constraints exist.

Index creation shall comply with the Index Development Standard.

---

## Phase 5 — Create Views

Views shall only reference fully constructed tables.

---

## Phase 6 — Create Materialized Views

Materialized views shall be created after all dependent views and tables are available.

---

## Phase 7 — Create Functions

Functions shall be created after all dependent database objects exist.

---

## Phase 8 — Create Procedures

Stored procedures shall be created after functions.

---

## Phase 9 — Create Triggers

Triggers shall be created last among executable database objects.

Every referenced table, function, and procedure shall already exist.

---

## Phase 10 — Add Comments

COMMENT statements shall be executed after all database objects have been created.

This guarantees that every object exists before documentation is applied.

---

## Phase 11 — Validation

Validation scripts verify:

- Object existence
- Constraints
- Indexes
- Referential integrity
- Naming compliance
- Deployment completeness

---

# 6. Dependency Rules

Execution order shall never violate dependency rules.

Examples:

- Parent tables before child tables.
- Functions before triggers.
- Tables before views.
- Views before materialized views.

---

# 7. Parallel Execution

DDL scripts may be executed in parallel only when no dependency exists between the affected objects.

Dependency analysis shall take precedence over performance optimization.

---

# 8. Error Handling

Execution shall stop immediately when a critical dependency fails.

Subsequent phases shall not continue after a failed prerequisite phase.

---

# 9. Automation

Automated deployment tools shall follow this execution order without exception.

Execution order shall not be inferred solely from file names.

Dependencies declared in script headers shall remain authoritative.

---

# 10. Related Standards

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- IndexDevelopmentStandard

---

# 11. Compliance

All DDL deployments within the Phoenix Platform shall comply with this execution order.

Exceptions require an approved Architecture Decision Record (ADR).

---

# 12. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |