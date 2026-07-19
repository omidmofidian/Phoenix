# Canonical Entity Selection

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ERD-002 |
| Document | CanonicalEntitySelection |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Information Architecture |
| Owner | Enterprise Architecture |
| Repository Path | Architecture/Data/ERD/CanonicalEntitySelection.md |
| Phase | Stage 9 — Canonical Enterprise ERD |
| Depends On | ERDReadinessReport, CanonicalEntityDefinitions, AggregateCatalog, CanonicalDomainModel |
| Consumed By | RelationshipConsolidation, AggregateBoundaryValidation, CanonicalEnterpriseERD |
| Approval Authority | Enterprise Architecture Board |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the enterprise selection criteria for identifying the canonical business entities that participate in the Canonical Enterprise Entity Relationship Diagram (ERD).

Its purpose is to ensure that only approved business entities forming the authoritative Enterprise Logical Data Model are represented within the enterprise architecture baseline.

The document establishes consistent selection rules, validation criteria, architectural ownership, and governance requirements while remaining independent of implementation technologies.

---

# 2. Scope

This specification defines:

- Canonical entity selection criteria
- Entity eligibility requirements
- Entity inclusion and exclusion rules
- Ownership validation
- Architectural readiness requirements
- Selection workflow
- Acceptance criteria
- Enterprise governance

This specification does not define:

- Business attributes
- Relationship definitions
- Cardinalities
- Database objects
- Physical implementation
- Service contracts
- APIs

---

# 3. Objectives

The Canonical Entity Selection process shall:

- identify entities eligible for the Enterprise ERD;
- ensure architectural consistency across all business domains;
- validate aggregate and domain ownership;
- eliminate duplicate or ambiguous business entities;
- provide a governed input for enterprise logical modeling;
- establish a stable baseline for subsequent physical database design.

---

# 4. Selection Principles

Canonical entity selection is governed by the following principles.

| Principle ID | Principle |
|--------------|-----------|
| SEL-001 | Every selected entity shall represent a business concept. |
| SEL-002 | Every selected entity shall have a unique business identity. |
| SEL-003 | Every selected entity shall belong to exactly one Business Domain. |
| SEL-004 | Every selected entity shall belong to exactly one Aggregate. |
| SEL-005 | Every selected entity shall have documented business ownership. |
| SEL-006 | Every selected entity shall participate in at least one approved business relationship. |
| SEL-007 | Every selected entity shall satisfy enterprise naming standards. |
| SEL-008 | Every selected entity shall pass architectural validation before inclusion. |

---

# 5. Included Entity Categories

Only canonical business entities satisfying the approved selection principles shall participate in the Canonical Enterprise ERD.

| Entity Category | Included | Rationale |
|-----------------|:--------:|-----------|
| Reference Entity | Yes | Represents stable enterprise reference information. |
| Master Entity | Yes | Represents core business objects owned by a business domain. |
| Transactional Entity | Yes | Represents operational business activities and lifecycle events. |
| Historical Entity | Yes | Represents immutable historical business information. |
| Integration Entity | Yes | Represents enterprise integration concepts and external mappings. |
| Configuration Entity | Yes | Represents enterprise configuration managed as business information. |
| Reporting Entity | Yes | Represents logical reporting and analytical information. |
| Audit Entity | Yes (Logical Only) | Represents enterprise traceability without affecting operational behavior. |

---

# 6. Excluded Elements

The following architectural elements shall not be represented in the Canonical Enterprise ERD because they belong to other architectural viewpoints or implementation layers.

| Element | Reason for Exclusion |
|----------|----------------------|
| Value Objects | Do not possess independent business identity. |
| Domain Events | Behavioral artifacts rather than persistent business entities. |
| Application Services | Service-layer implementation artifacts. |
| Domain Services | Behavioral components rather than information entities. |
| Repositories | Persistence abstraction. |
| Infrastructure Components | Outside the enterprise logical information model. |
| APIs | Integration contracts rather than business entities. |
| Database Schemas | Physical implementation concern. |
| Tables | Physical database representation. |
| Columns | Defined within physical data models. |
| Primary Keys | Physical implementation detail. |
| Foreign Keys | Represented logically through relationships. |
| Database Constraints | Physical database implementation. |
| Database Indexes | Performance optimization artifact. |
| Audit Columns | Governed by Enterprise Data Standards. |
| Calculated Attributes | Derived rather than stored business information. |
| Temporary Objects | Runtime implementation artifacts. |
| Enumeration Definitions | Governed by enterprise reference data. |
| Lookup Tables | Represented by canonical Reference Entities where applicable. |

---

# 7. Entity Ownership Rules

Every selected canonical entity shall satisfy the following ownership requirements.

| Rule ID | Ownership Rule |
|----------|----------------|
| OWN-001 | Every Entity shall belong to exactly one Business Domain. |
| OWN-002 | Every Entity shall belong to exactly one Aggregate. |
| OWN-003 | Every Aggregate shall define exactly one Aggregate Root. |
| OWN-004 | Every Entity shall have one authoritative Business Owner. |
| OWN-005 | Every Entity shall have one Canonical Definition. |
| OWN-006 | Every Entity shall define one Canonical Business Identifier. |
| OWN-007 | Ownership shall never be shared across Domains. |
| OWN-008 | Ownership shall remain stable throughout the architecture baseline. |

---

# 8. Entity Readiness Assessment

Before inclusion in the Canonical Enterprise ERD, every entity shall successfully complete the architectural readiness assessment.

| Validation Item | Required |
|-----------------|:--------:|
| Canonical Definition Approved | ✓ |
| Business Owner Assigned | ✓ |
| Domain Assigned | ✓ |
| Aggregate Assigned | ✓ |
| Aggregate Root Identified | ✓ |
| Business Identifier Defined | ✓ |
| Business Purpose Documented | ✓ |
| Enterprise Attributes Approved | ✓ |
| Relationships Defined | ✓ |
| Cardinalities Validated | ✓ |
| Naming Standards Applied | ✓ |
| Architectural Validation Passed | ✓ |
| Traceability Established | ✓ |
| Repository Standards Compliant | ✓ |

Only entities satisfying all mandatory validation criteria are eligible for inclusion in the Canonical Enterprise ERD.

---

# 9. Selection Workflow

The canonical entity selection process follows a controlled architectural workflow to ensure consistency, governance, and traceability throughout the Enterprise Architecture baseline.

```text
Business Glossary
        │
        ▼
Canonical Business Concepts
        │
        ▼
Canonical Domain Model
        │
        ▼
Canonical Entity Definitions
        │
        ▼
Aggregate Assignment
        │
        ▼
Domain Ownership Validation
        │
        ▼
Architectural Readiness Assessment
        │
        ▼
Canonical Entity Selection
        │
        ▼
Relationship Consolidation
        │
        ▼
Aggregate Boundary Validation
        │
        ▼
Canonical Enterprise ERD
```

---

# 10. Acceptance Criteria

A business entity is approved for inclusion in the Canonical Enterprise ERD only when all of the following conditions are satisfied.

| Acceptance Criterion | Required |
|----------------------|:--------:|
| Represents a canonical business concept | ✓ |
| Canonical definition approved | ✓ |
| Business owner assigned | ✓ |
| Domain ownership validated | ✓ |
| Aggregate ownership validated | ✓ |
| Aggregate Root identified | ✓ |
| Business identifier defined | ✓ |
| Enterprise attributes documented | ✓ |
| Business relationships approved | ✓ |
| Cardinalities validated | ✓ |
| Business constraints validated | ✓ |
| Naming standards satisfied | ✓ |
| Architectural review completed | ✓ |
| Traceability established | ✓ |

Entities failing any mandatory criterion shall not participate in the Enterprise ERD until the deficiency has been resolved.

---

# 11. Traceability

Every selected entity shall remain traceable to its authoritative architectural sources.

| Target Artifact | Traceability Purpose |
|-----------------|----------------------|
| Business Glossary | Business terminology |
| Canonical Business Concepts | Business semantics |
| Canonical Domain Model | Domain ownership |
| Aggregate Catalog | Aggregate ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Attribute Catalog | Enterprise attributes |
| Attribute Dictionary | Attribute metadata |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality validation |
| Business Constraint Matrix | Business constraints |
| Aggregate Boundary Validation | Aggregate integrity |
| Canonical Enterprise ERD | Enterprise logical representation |

---

# 12. Deliverables

Successful completion of the Canonical Entity Selection phase authorizes the production of the following enterprise architecture artifacts:

- Relationship Consolidation
- Aggregate Boundary Validation
- Canonical Enterprise ERD
- Enterprise Logical Data Model
- Physical Database Design Baseline

---

# 13. Architectural Governance

The Canonical Entity Selection forms part of the Enterprise Architecture governance process.

Any modification involving:

- Entity ownership
- Aggregate ownership
- Domain ownership
- Business identity
- Entity inclusion or exclusion
- Architectural classification

shall require:

- Enterprise Architecture Review
- Impact Analysis
- Architecture Board Approval
- Repository Baseline Update (where applicable)

---

# 14. Approval

The Enterprise Architecture Board confirms that the entities defined in this document satisfy the architectural selection criteria and are approved for inclusion in the Canonical Enterprise ERD.

**Approval Status**

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Canonical Entity Selection specification. |
| 2026.2 | 2026-07-19 | Repository-standard revision aligned with the Enterprise Architecture documentation framework, including standardized metadata, governance, traceability, readiness assessment, and architectural validation. |