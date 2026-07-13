# SQL Script Development Standard

| Item | Value |
|------|------|
| Document ID | STD-SQL-001 |
| Version | 1.0 |
| Status | Draft |
| Category | Database Standard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This standard defines the common architecture, conventions, formatting rules, documentation requirements, and quality requirements for every SQL script developed within the Phoenix Platform.

This document serves as the parent standard for all SQL script types.

---

# 2. Scope

This standard applies to all SQL scripts, including:

- Bootstrap Scripts
- Initialization Scripts
- DDL Scripts
- DML Scripts
- Migration Scripts
- Validation Scripts
- Seed Scripts
- View Scripts
- Function Scripts
- Procedure Scripts
- Trigger Scripts
- Sequence Scripts
- Domain Scripts
- Type Scripts

---

# 3. Objectives

The objectives of this standard are:

- Ensure consistency
- Improve maintainability
- Improve readability
- Standardize documentation
- Standardize execution
- Support automated deployment
- Reduce implementation errors
- Improve traceability

---

# 4. Architectural Principles

Every SQL script shall follow the following principles.

- Architecture First
- Documentation First
- Single Responsibility
- Explicit Dependencies
- Deterministic Execution
- Repeatable Deployment
- Least Privilege
- Explicit Naming
- Version Controlled
- Readability over Cleverness

---

# 5. Script Categories

The Phoenix Platform classifies SQL scripts into the following categories.

| Category | Description |
|-----------|-------------|
| Bootstrap | Database creation |
| Init | Database initialization |
| DDL | Database objects |
| DML | Data manipulation |
| Migration | Schema evolution |
| Seed | Reference and initial data |
| Validation | Database verification |
| View | Logical data presentation |
| Function | Reusable database logic |
| Procedure | Administrative or business operations |
| Trigger | Event-driven logic |

---

# 6. File Naming Convention

Every SQL file shall follow the standard naming convention.

```
NNN-ActionObject.sql
```

Examples

```
001-CreateDatabase.sql
005-CreateSchemas.sql
010-CreateExchange.sql
040-CreateCompany.sql
090-SeedReferenceData.sql
```

Numbering should increment by ten whenever possible.

---

# 7. Standard Header

Every SQL script shall begin with the standard Phoenix SQL header.

The header shall contain at least:

- Script Name
- Version
- Description
- Category
- Dependencies
- Related ADRs
- Related Standards
- Author
- Created Date
- Revision History

---

# 8. Script Responsibility

Each SQL script shall implement one clearly defined responsibility.

Scripts shall not combine unrelated operations.

---

# 9. Dependency Declaration

Dependencies shall always be explicitly declared.

Execution order shall never rely on filename ordering alone.

---

# 10. Formatting Rules

SQL keywords shall be written in uppercase.

Examples

```
CREATE TABLE

ALTER TABLE

PRIMARY KEY

FOREIGN KEY
```

Object names shall follow Phoenix naming standards.

Indentation shall be consistent throughout the project.

Trailing whitespace shall not exist.

---

# 11. Comments

Every SQL script shall contain explanatory comments where required.

Database objects shall include COMMENT statements whenever applicable.

---

# 12. Transactions

Scripts shall clearly define transactional behavior.

If a script cannot safely execute inside a transaction, the reason shall be documented.

---

# 13. Error Handling

Scripts shall not suppress errors unless explicitly justified.

Unexpected errors should terminate execution.

---

# 14. Security

SQL scripts shall follow the principle of least privilege.

Ownership changes, permission grants, and security configuration shall be implemented only within their designated script categories.

---

# 15. Idempotency

Idempotency requirements depend on script category.

| Category | Idempotent |
|----------|------------|
| Bootstrap | No |
| Init | Preferred |
| DDL | Migration Controlled |
| DML | Depends |
| Seed | Yes |
| Validation | Yes |

---

# 16. Version Control

All SQL scripts shall be maintained under version control.

Changes shall be traceable.

Breaking changes require an approved ADR.

---

# 17. Quality Requirements

Every SQL script shall satisfy the following requirements before approval.

- Standard Header
- Correct File Name
- Correct Category
- Dependency Declaration
- Proper Formatting
- Explicit Object Names
- Documentation
- No Dead Code
- No Debug Statements
- No Temporary Objects

---

# 18. Review Checklist

Every SQL script shall be reviewed for:

- Architecture Compliance
- Naming Compliance
- Dependency Validation
- Security Review
- Documentation Review
- Formatting Review
- Standards Compliance

---

# 19. Related Standards

This document is the parent standard for:

- DatabaseDDLDevelopmentStandard
- DatabaseDMLDevelopmentStandard
- TableDevelopmentStandard
- ViewDevelopmentStandard
- MaterializedViewDevelopmentStandard
- FunctionDevelopmentStandard
- ProcedureDevelopmentStandard
- TriggerDevelopmentStandard
- ConstraintDevelopmentStandard
- IndexDevelopmentStandard
- SequenceDevelopmentStandard
- DomainDevelopmentStandard
- TypeDevelopmentStandard
- SeedDevelopmentStandard
- ValidationScriptDevelopmentStandard
- MigrationDevelopmentStandard

---

# 20. Compliance

All SQL scripts within the Phoenix Platform shall comply with this standard.

Project-specific exceptions require an approved Architecture Decision Record (ADR).

---

# 21. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |