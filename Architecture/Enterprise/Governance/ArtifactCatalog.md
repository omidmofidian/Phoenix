# Artifact Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-006 |
| Version | 1.0 |
| Status | Frozen |
| Classification | Architecture Governance |
| Owner | Architecture Team |
| Last Updated | 2026-07-08 |

---

# 1. Purpose

This document serves as the official registry of all artifacts within the Phoenix Platform repository.

It provides a single source of truth for artifact identification, ownership, classification, location, versioning, and lifecycle status.

Every artifact created within the project shall be registered in this catalog.

---

# 2. Objectives

The Artifact Catalog aims to:

- Maintain complete traceability.
- Prevent duplicate artifacts.
- Standardize artifact identification.
- Simplify repository navigation.
- Support governance and auditing.
- Enable impact analysis.
- Improve long-term maintainability.

---

# 3. Artifact Classification

Phoenix artifacts are classified into the following categories:

| Prefix | Category | Description |
|---------|----------|-------------|
| GOV | Governance | Governance and repository management documents |
| ARC | Architecture | Architecture documents |
| VIS | Vision | Vision and strategy documents |
| DOM | Domain Model | Domain-driven design artifacts |
| SRV | Services | Service architecture documents |
| STD | Standards | Enterprise and design standards |
| DSN | Design | General design documents |
| CMD | Conceptual Model | Conceptual models |
| LDM | Logical Model | Logical data models |
| PDM | Physical Model | Physical data models |
| DBD | Database Design | Database documentation |
| DDL | Database Scripts | SQL and DDL specifications |
| DIC | Data Dictionary | Business and technical dictionaries |
| FMK | Financial Market Knowledge | Financial market knowledge |
| TRD | Trading Knowledge | Trading concepts and workflows |
| ANL | Analytics Knowledge | Quantitative and analytical methods |
| AIK | Artificial Intelligence | AI and machine learning knowledge |
| REG | Regulations | Regulatory documentation |
| RSH | Research | Research documents |
| REF | Reference | External references and standards |
| ADR | Architectural Decision Record | Architecture decisions |

---

# 4. Artifact Lifecycle

Every artifact shall follow the lifecycle below.

```text
Draft
   │
   ▼
Review
   │
   ▼
Approved
   │
   ▼
Frozen
   │
   ▼
Deprecated
   │
   ▼
Archived
```

---

# 5. Artifact Registration Rules

Every artifact shall have:

- Unique Artifact ID
- Unique file name
- Repository location
- Version
- Status
- Owner
- Creation date
- Last modification date
- Related Sprint (if applicable)

---

# 6. Artifact Metadata

Every document should begin with a standard metadata table.

Example:

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | XXX-001 |
| Version | 1.0 |
| Status | Draft |
| Owner | Architecture Team |
| Last Updated | YYYY-MM-DD |

---

# 7. Artifact Registry

| Artifact ID | Artifact Name | Repository Path | Layer | Status | Version | Owner |
|-------------|---------------|-----------------|-------|--------|---------|-------|
| GOV-001 | ProjectOverview | Docs/Architecture/Governance | Architecture | Approved | 1.0 | Architecture Team |
| GOV-002 | Sprint1Overview | Docs/Architecture/Governance | Architecture | Approved | 1.0 | Architecture Team |
| GOV-003 | Sprint2Overview | Docs/Architecture/Governance | Architecture | Approved | 1.0 | Architecture Team |
| GOV-004 | Sprint3Plan | Docs/Architecture/Governance | Architecture | Approved | 1.0 | Architecture Team |
| GOV-005 | RepositoryStructure | Docs/Architecture/Governance | Architecture | Frozen | 2.0 | Architecture Team |
| GOV-006 | ArtifactCatalog | Docs/Architecture/Governance | Architecture | Frozen | 1.0 | Architecture Team |

> **Note:** This table shall be continuously expanded as new artifacts are introduced.

---

# 8. Artifact Dependency

Artifacts may reference one another.

Allowed relationships include:

- Depends On
- References
- Derived From
- Implements
- Supersedes
- Related To

Circular dependencies should be avoided.

---

# 9. Repository Compliance

No artifact shall exist without registration in this catalog.

Duplicate Artifact IDs are prohibited.

Repository paths shall conform to RepositoryStructure.md.

---

# 10. Governance

The Artifact Catalog shall be updated whenever:

- A new artifact is created.
- An artifact is renamed.
- An artifact changes status.
- An artifact changes repository location.
- An artifact is archived.

---

# 11. Related Documents

- RepositoryStructure.md
- DocumentationStructure.md
- GovernanceFramework.md
- GovernanceChecklist.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-08 | Initial Artifact Catalog. |