# ADR-024 — Enterprise Architecture Baseline Strategy

| Property | Value |
|----------|-------|
| ADR ID | ADR-024 |
| Title | Enterprise Architecture Baseline Strategy |
| Status | Accepted |
| Category | Architecture Governance |
| Decision Date | 2026-07-09 |
| Owner | Enterprise Architecture |
| Applies To | Phoenix Platform |
| Supersedes | None |
| Superseded By | None |

---

# 1. Context

Sprint 3 establishes the first complete Enterprise Architecture of the Phoenix Platform.

The architecture now includes:

- Business Architecture
- Knowledge Architecture
- Domain Architecture
- Logical Data Architecture
- Relationship Architecture
- Validation Framework
- Repository Governance
- Architecture Governance

At the completion of Sprint 3, these artifacts collectively represent the official architectural foundation of the platform.

Without a formal baseline strategy, architectural artifacts could evolve independently, resulting in inconsistency, loss of traceability and governance violations.

A baseline strategy is therefore required to preserve architectural integrity throughout the lifecycle of the project.

---

# 2. Decision

Phoenix adopts an Enterprise Architecture Baseline Strategy.

At the end of approved architecture milestones, the complete architecture shall be frozen as an official Enterprise Architecture Baseline.

Each baseline represents the authoritative architectural state of the project at a specific point in time.

Subsequent architectural evolution shall occur only through approved governance processes.

---

# 3. Baseline Principles

The following principles govern all Enterprise Architecture Baselines.

- Every baseline shall have a unique identifier.
- Every baseline shall be immutable after approval.
- Architectural changes shall not modify a published baseline directly.
- New baselines supersede previous baselines but shall preserve historical traceability.
- Every baseline shall pass all required validation activities before publication.

---

# 4. Baseline Identifier

Baseline identifiers shall follow the standard format.

```text
EA-BL-YYYY-NN
```

Example:

```text
EA-BL-2026-01
```

Where:

- EA = Enterprise Architecture
- BL = Baseline
- YYYY = Calendar Year
- NN = Sequential Baseline Number

---

# 5. Baseline Scope

A baseline includes all approved architectural artifacts, including but not limited to:

- Architecture Vision
- Architecture Principles
- Quality Attributes
- Architecture Decision Records (ADRs)
- Business Glossary
- Canonical Business Concepts
- Canonical Business Rules
- Domain Responsibilities
- Aggregate Catalog
- Canonical Entity Definitions
- Attribute Catalog
- Attribute Dictionary
- Relationship Catalog
- Logical Domain Models
- Validation Reports
- Repository Structure
- Architecture Governance Standards

---

# 6. Baseline Lifecycle

Every baseline progresses through the following lifecycle.

```text
Draft
    ↓
Architecture Review
    ↓
Validation
    ↓
Approval
    ↓
Baseline
    ↓
Superseded
    ↓
Archived
```

A baseline shall only transition to **Baseline** after successful completion of all review and validation activities.

---

# 7. Change Management

Changes to a published baseline shall not be performed directly.

All architectural modifications shall be introduced through one of the following mechanisms:

- New Architecture Decision Record (ADR)
- Approved Architecture Change Request
- New Enterprise Architecture Baseline

All approved changes shall maintain backward traceability to the affected baseline.

---

# 8. Governance Requirements

Every baseline shall satisfy the following governance requirements:

- Architecture Review completed.
- Validation reports approved.
- Traceability verified.
- Repository validated.
- Documentation standards satisfied.
- Applicable ADRs approved.

---

# 9. Compliance

Compliance with this strategy is mandatory for all architectural artifacts.

Artifacts that do not belong to an approved baseline shall not be considered part of the official Enterprise Architecture.

---

# 10. Consequences

## Positive

- Stable architectural reference.
- Controlled architectural evolution.
- Improved governance.
- Full historical traceability.
- Higher repository consistency.
- Predictable change management.

## Trade-offs

- Additional governance activities before publishing new baselines.
- Architectural changes require formal review and approval.

---

# 11. Relationship to Other ADRs

This ADR complements and reinforces:

- ADR-000 — Architecture Governance
- ADR-003 — Documentation Standards
- ADR-017 — Enterprise Attribute Strategy
- ADR-021 — Canonical Domain Model & Schema Allocation
- ADR-022 — Repository Documentation Structure
- ADR-023 — Enterprise Audit and Domain Event Strategy

Future ADRs shall reference the active Enterprise Architecture Baseline where applicable.

---

# 12. Initial Baseline

The first official Enterprise Architecture Baseline established under this strategy is:

```text
Baseline ID : EA-BL-2026-01
Baseline Name : Enterprise Architecture Baseline v1.0
Established : 2026-07-09
Established By : Sprint 3 Architecture Freeze
Status : Active
```

---

# 13. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-09 | Initial Enterprise Architecture Baseline Strategy. |