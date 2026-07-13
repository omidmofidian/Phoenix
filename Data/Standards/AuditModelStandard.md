# Audit Model Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-004 |
| Document | AuditModelStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Task | T3-004 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical audit model for the Phoenix Platform.

The objective is to establish a consistent and technology-independent approach for recording the lifecycle of business entities while ensuring traceability, accountability, and governance across the platform.

This standard governs audit metadata only and does not define application logging, monitoring, or event sourcing.

---

# 2. Scope

This standard applies to:

- Logical Data Model
- Physical Database Design
- Business Entities
- Reference Entities
- Configuration Data
- Service Metadata

It does not apply to:

- Application logs
- System logs
- Security logs
- Event streams
- Message queues

These concerns are addressed by separate standards.

---

# 3. Audit Principles

The audit model is based on the following principles.

- Every entity has a traceable lifecycle.
- Audit information is immutable once recorded.
- Audit metadata is business-independent.
- Audit shall not contain implementation details.
- Audit information shall be captured automatically whenever possible.
- Business logic shall not duplicate audit responsibilities.

---

# 4. Canonical Audit Attributes

The canonical audit attributes are:

| Attribute | Mandatory | Description |
|-----------|-----------|-------------|
| created_at | Yes | Timestamp of entity creation |
| created_by | Yes | Creator identifier |
| updated_at | No | Timestamp of last modification |
| updated_by | No | Last modifier identifier |

These attributes form the minimum audit metadata required for mutable entities.

---

# 5. Attribute Definitions

## created_at

Represents the date and time when the entity was first created.

Characteristics:

- Immutable
- Automatically assigned
- Never updated

---

## created_by

Identifies the actor responsible for creating the entity.

Possible actors include:

- User
- Service
- Integration
- Scheduled Job
- System Process

The value shall reference the canonical identity of the actor.

---

## updated_at

Represents the date and time of the most recent successful modification.

The value shall remain unchanged if the entity has never been modified after creation.

---

## updated_by

Identifies the actor responsible for the latest successful update.

The value shall always correspond to the update represented by `updated_at`.

---

# 6. Mutable vs Immutable Entities

Entities are classified into two categories.

## Mutable Entities

Examples:

- User
- Portfolio
- Configuration
- Organization

These entities shall include all canonical audit attributes.

---

## Immutable Entities

Examples:

- Historical Market Data
- Imported Daily Candles
- Historical Financial Statements

Immutable entities shall contain:

- created_at
- created_by

Update-related attributes may be omitted when business rules guarantee immutability.

---

# 7. Audit Lifecycle

The standard audit lifecycle is:

```text
Create
    ↓
Read
    ↓
Update (optional)
    ↓
Deactivate (optional)
    ↓
Archive (optional)
```

Deletion is not part of the standard audit lifecycle.

---

# 8. Soft Delete Policy

Soft delete is not included in the canonical audit model.

Attributes such as:

- deleted_at
- deleted_by
- is_deleted

shall only be introduced where explicitly required by business rules.

If implemented, these attributes belong to the specific entity and not to the common audit model.

---

# 9. Time Standard

All audit timestamps shall use the enterprise time standard.

Approved logical representation:

- Event Timestamp

Approved physical implementation:

- `timestamp with time zone`

All timestamps shall be stored in UTC.

Presentation in local time zones shall be handled by the application layer.

---

# 10. Actor Identification

Audit actors shall represent the logical source of the operation rather than implementation-specific identifiers.

Examples:

- User
- Internal Service
- External Integration
- Scheduler
- System

The mapping to physical identities shall be defined during implementation.

---

# 11. Relationship with Versioning

Audit metadata records **who** performed an operation and **when** it occurred.

Concurrency metadata records **which version** of the entity is current.

These concerns are complementary and shall remain separate.

---

# 12. Compliance

Compliance with this standard is mandatory.

All mutable entities shall implement the canonical audit model unless an approved architectural exception exists.

Any deviation shall be documented and reviewed through the architecture governance process.

---

# 13. Related Documents

- EnterpriseNamingStandard.md
- EnterpriseDataTypeStandard.md
- BaseEntityStandard.md
- IdentifierStrategy.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Audit Model Standard. |