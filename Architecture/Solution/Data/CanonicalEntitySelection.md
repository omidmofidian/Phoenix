# Canonical Entity Selection

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ERD-002 |
| Document | CanonicalEntitySelection |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Phase | Stage 9 — Canonical Enterprise ERD |
| Depends On | ERD-001 ERDReadinessReport, CanonicalEntityDefinitions, AggregateCatalog |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document identifies the canonical business entities that shall participate in the Canonical Enterprise ERD.

The objective is to ensure that only business entities forming the enterprise logical data model are included.

---

# 2. Selection Principles

An entity shall be included in the Canonical Enterprise ERD only if it satisfies all of the following conditions:

- Represents a business concept.
- Has a unique business identity.
- Belongs to exactly one Aggregate.
- Belongs to exactly one Domain.
- Has documented business attributes.
- Participates in at least one business relationship.
- Has no unresolved architectural conflicts.

---

# 3. Included Entity Categories

The following categories shall be represented in the Canonical Enterprise ERD.

| Category | Included |
|----------|----------|
| Reference Entity | Yes |
| Core Entity | Yes |
| Market Entity | Yes |
| Integration Entity | Yes |
| Configuration Entity | Yes |
| Reporting Entity | Yes |
| Audit Entity | Yes (Logical Only) |

---

# 4. Excluded Elements

The following elements shall not appear in the Canonical Enterprise ERD.

| Element | Reason |
|----------|--------|
| Value Objects | Not independently identifiable |
| Domain Events | Behavioral artifact |
| Services | Not data entities |
| Repositories | Technical component |
| Application Services | Technical component |
| Infrastructure Components | Outside logical data model |
| Audit Columns | Defined by Enterprise Standards |
| Calculated Fields | Derived at runtime |
| Temporary Objects | Implementation detail |
| Database Indexes | Physical design concern |
| Foreign Key Columns | Represented by relationships |
| Database Constraints | Physical implementation concern |
| Enumeration Types | Defined by attribute standards |
| Lookup Values | Represented by Reference Entities where applicable |

---

# 5. Entity Ownership Rules

Every canonical entity shall satisfy the following ownership rules.

- One Domain Owner.
- One Aggregate Owner.
- One Aggregate Root.
- One Canonical Definition.
- One Business Identifier.

---

# 6. Entity Readiness Checklist

| Validation Item | Result |
|-----------------|--------|
| Canonical Definition Exists | PASS |
| Aggregate Assigned | PASS |
| Domain Assigned | PASS |
| Business Identifier Defined | PASS |
| Attributes Documented | PASS |
| Relationships Defined | PASS |
| Naming Standard Applied | PASS |

---

# 7. Selection Process

```text
Business Glossary
        │
        ▼
Canonical Business Concepts
        │
        ▼
Canonical Entity Definitions
        │
        ▼
Aggregate Assignment
        │
        ▼
Domain Assignment
        │
        ▼
Canonical Entity Selection
        │
        ▼
Canonical Enterprise ERD
```

---

# 8. Acceptance Criteria

A canonical entity is accepted into the Enterprise ERD when:

- All mandatory metadata is available.
- Ownership has been validated.
- Attributes are documented.
- Relationships are approved.
- Naming complies with enterprise standards.
- Validation reports have passed.

---

# 9. Deliverable

Output Artifact

- RelationshipConsolidation
- AggregateBoundaryValidation
- CanonicalEnterpriseERD

This document serves as the authoritative source for determining which entities are represented in the Canonical Enterprise ERD.

---

# 10. Approval

The selected entities are approved for inclusion in the Canonical Enterprise ERD.

Result

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Canonical Entity Selection. |