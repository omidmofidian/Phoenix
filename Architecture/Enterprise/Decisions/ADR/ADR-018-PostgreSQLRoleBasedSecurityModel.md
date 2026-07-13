# ADR-018

# PostgreSQL Role-Based Security Model

---

| Item | Value |
|------|-------|
| ADR | 018 |
| Title | PostgreSQL Role-Based Security Model |
| Status | Accepted |
| Date | 2026-06-30 |
| Decision Makers | Phoenix Architecture Team |

---

# Context

The Phoenix Platform requires a secure, maintainable and scalable database security model.

The database shall support:

- production applications,
- automated deployment,
- testing,
- reporting,
- ETL processes,

while enforcing the Principle of Least Privilege.

Database ownership shall remain isolated from operational database access.

---

# Decision

The database shall adopt a Role-Based Access Control (RBAC) model based on dedicated PostgreSQL roles.

The following role hierarchy is approved.

```text
                               postgres
                                   │
                                   ▼
                            phoenix_owner
                                   │
      ┌────────────┬────────────┬────────────┬────────────┬────────────┐
      ▼            ▼            ▼            ▼            ▼
 phoenix_app  phoenix_test  phoenix_etl  phoenix_readonly  phoenix_deployer
```

---

# Role Definitions

## postgres

Purpose

Database administration.

Responsibilities

- installation
- backup
- recovery
- maintenance
- upgrades

This role shall never be used by applications.

---

## phoenix_owner

Purpose

Database object ownership.

Responsibilities

Owns

- schemas
- tables
- sequences
- views
- functions
- procedures

Properties

```text
NOLOGIN
```

No interactive login is permitted.

---

## phoenix_app

Purpose

Production application runtime.

Responsibilities

- SELECT
- INSERT
- UPDATE
- DELETE
- EXECUTE (where required)

This role shall never own database objects.

---

## phoenix_test

Purpose

Testing.

Responsibilities

- Integration Testing
- Regression Testing
- Smoke Testing
- User Acceptance Testing

No schema modification privileges.

---

## phoenix_etl

Purpose

Data import and export.

Responsibilities

- ETL
- Batch Processing
- External Data Providers
- Scheduled Jobs

No ownership privileges.

---

## phoenix_readonly

Purpose

Read-only reporting.

Responsibilities

- BI
- Dashboards
- Reporting
- Analytics

Read-only access only.

---

## phoenix_deployer

Purpose

Automated deployment.

Responsibilities

- CI/CD
- Database Release
- Migration Execution

No ownership privileges.

---

# Ownership Model

All database objects shall be owned exclusively by

```text
phoenix_owner
```

Applications shall never own database objects.

---

# Authentication Model

Only operational roles may login.

```text
LOGIN

phoenix_app

phoenix_test

phoenix_etl

phoenix_readonly

phoenix_deployer
```

The following role shall never login.

```text
phoenix_owner
```

---

# Authorization Model

Privileges shall be granted explicitly.

Role inheritance shall not be used as a substitute for explicit permissions.

Object ownership shall remain isolated.

---

# Security Principles

The implementation shall follow:

## Principle of Least Privilege

Each role receives only the permissions required to perform its responsibilities.

---

## Separation of Duties

Ownership

Deployment

Application Runtime

Testing

Reporting

ETL

shall remain independent.

---

## Explicit Permissions

Privileges shall always be granted explicitly.

Implicit permissions are prohibited.

---

## No Shared Accounts

Each operational process shall use its dedicated database role.

Shared application accounts are prohibited.

---

# Consequences

Advantages

- Improved security
- Better auditing
- Clear ownership
- Easier maintenance
- CI/CD compatibility
- Enterprise scalability

Trade-offs

- Additional role management
- Slightly more administration

These trade-offs are accepted.

---

# Related Documents

DDS-2026.1

SDS-2026.1

DatabaseImplementationPlan.md

PhysicalDatabaseModel.md

---

# Status

```text
ACCEPTED

IMPLEMENTATION READY
```