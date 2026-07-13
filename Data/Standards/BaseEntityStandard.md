# Base Entity Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-003 |
| Document | BaseEntityStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Task | T3-003 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical base entity structure for all logical entities within the Phoenix Platform.

The objective is to establish a common set of mandatory attributes shared by business entities to ensure consistency, traceability, maintainability, and enterprise-wide governance.

This standard applies to logical entities and serves as the foundation for subsequent physical database implementation.

---

# 2. Scope

This standard applies to:

- Logical Entities
- Physical Tables
- Reference Data
- Core Domain
- Market Domain
- Integration Domain
- Configuration Domain
- Reporting Domain

Exceptions shall require formal architectural approval.

---

# 3. Design Principles

The Base Entity shall:

- Be technology independent.
- Represent common business characteristics.
- Support distributed systems.
- Support auditability.
- Support optimistic concurrency.
- Minimize duplication.
- Remain stable across all domains.

---

# 4. Canonical Base Entity

Every business entity shall inherit the following logical attributes.

| Attribute | Category | Mandatory |
|-----------|----------|-----------|
| id | Identity | Yes |
| external_code | Business Metadata | No |
| effective_from | Business Metadata | No |
| effective_to | Business Metadata | No |
| is_active | Business Metadata | Yes |
| created_at | Audit | Yes |
| created_by | Audit | Yes |
| updated_at | Audit | No |
| updated_by | Audit | No |
| version | Concurrency | Yes |

---

# 5. Identity

Each entity shall have a single immutable identifier.

Characteristics:

- Globally unique
- Stable
- Never reused
- Business independent

The identifier strategy is defined in `IdentifierStrategy.md`.

---

# 6. Business Metadata

## external_code

Represents an identifier supplied by an external system or data provider.

Examples include:

- Exchange symbol codes
- Broker identifiers
- External market identifiers

This attribute is optional and may be omitted where no external identifier exists.

---

## effective_from

The date and time from which the entity becomes valid.

---

## effective_to

The date and time until which the entity remains valid.

---

## is_active

Indicates whether the entity is currently active from a business perspective.

This attribute shall not be used to represent deletion.

---

# 7. Audit Metadata

Audit attributes capture the lifecycle of each entity.

Mandatory attributes:

- created_at
- created_by

Optional update attributes:

- updated_at
- updated_by

Detailed audit policies are defined in `AuditModelStandard.md`.

---

# 8. Optimistic Concurrency

Every mutable entity shall contain a version attribute.

The version shall be incremented after every successful update.

This attribute supports optimistic locking and prevents lost updates in concurrent environments.

---

# 9. Soft Delete Policy

Soft delete is **not** part of the canonical Base Entity.

Attributes such as:

- deleted_at
- deleted_by
- is_deleted

shall only be introduced where explicitly required by business rules.

The absence of these attributes from the Base Entity avoids unnecessary complexity and storage overhead.

---

# 10. Entity Lifecycle

The standard lifecycle of an entity is:

```text
Created
    ↓
Active
    ↓
Updated
    ↓
Inactive (optional)
    ↓
Archived (optional)
```

Deletion is not considered part of the standard lifecycle.

---

# 11. Inheritance Rules

All logical entities shall inherit the Base Entity unless a documented architectural exception has been approved.

Reference entities that are immutable may omit update-related attributes if justified and documented.

---

# 12. Compliance

Compliance with this standard is mandatory.

Architecture reviews, logical data model reviews, and physical database reviews shall verify conformance.

Exceptions require approval through the architecture governance process.

---

# 13. Related Documents

- EnterpriseNamingStandard.md
- EnterpriseDataTypeStandard.md
- AuditModelStandard.md
- IdentifierStrategy.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Base Entity Standard. |