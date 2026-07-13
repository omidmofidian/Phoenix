# ADR-020
# Database Bootstrap and Security Architecture

| Item | Value |
|------|-------|
| ADR | 020 |
| Status | Accepted |
| Date | 2026-06-30 |
| Decision Makers | Phoenix Architecture Team |
| Standard | SDS-2026.1 |

---

# Context

Phoenix is designed as an enterprise-grade trading platform.

The database architecture must satisfy the following goals:

- Separation of concerns
- Repeatable deployments
- Docker compatibility
- Enterprise RBAC
- Least Privilege Principle
- Maintainability
- Scalability

During Sprint 1 several architectural decisions were finalized regarding database initialization, security and deployment.

This ADR records those decisions.

---

# Decision

The Phoenix database initialization process is divided into two distinct phases.

## Phase 1 — Bootstrap

Bootstrap is executed only once during the lifetime of a database.

Responsibilities:

- Create the database
- Assign the database owner

Bootstrap scripts are stored in:

```text
Database/
└── Bootstrap/
```

Current Bootstrap scripts:

```text
001-CreateDatabase.sql
```

Bootstrap scripts are intentionally **non-idempotent**, because PostgreSQL does not allow `CREATE DATABASE` inside procedural or transactional blocks.

---

## Phase 2 — Init

Initialization prepares an existing database for application usage.

Initialization scripts are stored in:

```text
Database/
└── Init/
```

Current initialization order:

```text
001-CreatePermissionRoles.sql

002-CreateLoginRoles.sql

003-GrantPermissions.sql

004-CreateExtensions.sql

005-CreateSchemas.sql

006-ConfigureSearchPath.sql
```

All scripts inside **Database/Init** shall be idempotent.

---

# Security Model

Phoenix adopts a Role-Based Access Control (RBAC) model.

Two different categories of roles exist.

## Permission Roles

Permission roles are created without LOGIN capability.

Examples:

```text
phoenix_owner

phoenix_admin

phoenix_rw

phoenix_ro
```

Permission roles own permissions only.

They never authenticate.

---

## Login Roles

Login roles authenticate to PostgreSQL.

Examples:

```text
phoenix_app

phoenix_test

phoenix_etl

phoenix_readonly

phoenix_deployer
```

Login roles do not receive permissions directly.

---

# Membership

Permissions are inherited through role membership.

Example:

```text
phoenix_app

↓

member of

↓

phoenix_rw
```

Direct permission assignment to login roles is prohibited.

---

# Ownership

All database objects shall be owned by:

```text
phoenix_owner
```

Including:

- Database
- Schemas
- Tables
- Views
- Materialized Views
- Functions
- Procedures
- Sequences
- Types

Deployment roles shall never own database objects.

---

# Script Responsibilities

Each SQL script shall have a single responsibility.

| Script | Responsibility |
|---------|----------------|
| CreatePermissionRoles | Create permission roles |
| CreateLoginRoles | Create login roles |
| GrantPermissions | Membership and grants |
| CreateExtensions | Extensions only |
| CreateSchemas | Schemas only |
| ConfigureSearchPath | Search path only |

---

# Docker Compatibility

Database scripts shall remain independent of Docker.

No script may contain:

- container names
- ports
- volumes
- Docker commands

Docker is considered an execution environment only.

---

# Secrets

Passwords shall never appear inside SQL scripts.

Authentication credentials shall be configured during deployment using secret management solutions.

Examples:

- Docker Secrets
- Kubernetes Secrets
- Azure Key Vault
- AWS Secrets Manager
- HashiCorp Vault

---

# Consequences

Advantages

- Clear separation of responsibilities
- Enterprise RBAC
- Repeatable initialization
- Docker portability
- Easier maintenance
- Better security
- Simplified future migrations

Trade-offs

- More initialization scripts
- Additional architectural documentation
- Slightly longer deployment sequence

The advantages significantly outweigh the additional complexity.

---

# Related Documents

- ADR-018 Database Initialization Strategy
- ADR-019 Validation Strategy
- SDS-2026.1
- SQLDevelopmentStandard.md

---

# Status

Accepted

This ADR establishes the official database bootstrap, initialization and security architecture for the Phoenix Platform.

Future changes to this architecture require a new ADR.