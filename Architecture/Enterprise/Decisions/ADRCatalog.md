# Architecture Decision Record Catalog (ADRCatalog)

| Property | Value |
|----------|-------|
| Document ID | ADRCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Governance |
| Repository | Phoenix Platform |
| Owner | Enterprise Architecture |
| Baseline | 2026.1 |
| Last Updated | 2026-07-11 |

---

# 1. Purpose

This document is the official catalog of all Architecture Decision Records (ADRs) within the Phoenix Platform Enterprise Architecture Repository.

It provides a single authoritative reference for:

- Architecture decision identification
- Decision governance
- Architectural traceability
- ADR lifecycle management
- Repository consistency
- Baseline management

This document is a governance artifact and shall not itself be treated as an Architecture Decision Record.

---

# 2. Scope

This catalog applies to every Architecture Decision Record maintained within the Phoenix Platform Repository.

It governs:

- ADR creation
- ADR numbering
- ADR lifecycle
- ADR maintenance
- ADR traceability
- ADR classification

---

# 3. ADR Governance Principles

The following principles govern all Architecture Decision Records.

- Every significant architectural decision shall be documented as an ADR.
- ADRs define architecture rather than implementation.
- ADR identifiers are permanent.
- ADR numbers shall never be reused.
- Accepted ADRs become part of the Architecture Baseline.
- ADRs remain available for historical traceability even if superseded.

---

# 4. ADR Lifecycle

| Status | Description |
|----------|-------------|
| Proposed | Under architectural evaluation |
| Accepted | Official architectural decision |
| Superseded | Replaced by another ADR |
| Deprecated | Retained for historical reference |

---

# 5. ADR Numbering Policy

Architecture Decision Records use sequential numbering.

Format

ADR-XXX

Example

ADR-001

ADR-015

ADR-025

Number allocation rules

- Numbers are sequential.
- Numbers are immutable.
- Existing ADRs shall never be renumbered.
- New ADRs always receive the next available number.

---

# 6. ADR Classification

Architecture Decisions are grouped according to their architectural responsibility.

| Category | Description |
|----------|-------------|
| Enterprise | Enterprise-wide architecture |
| Governance | Repository governance |
| Business Architecture | Business domains and business rules |
| Data Architecture | Enterprise data architecture |
| Solution Architecture | Services and platform architecture |
| Integration | External integrations |
| Infrastructure | Platform infrastructure |
| Quality | Quality attributes |
| Standards | Enterprise standards |

---

# 7. ADR Index

| ADR | Title | Category | Status |
|------|-------|----------|--------|
| ADR-000 | Architecture Principles | Enterprise | Accepted |
| ADR-001 | Core Independence | Architecture | Accepted |
| ADR-002 | Data Source Abstraction | Integration | Accepted |
| ADR-003 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-004 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-005 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-006 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-007 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-008 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-009 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-010 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-011 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-012 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-013 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-014 | Test-Driven Quality Assurance | Quality | Accepted |
| ADR-015 | Market Classification Model | Business Architecture | Accepted |
| ADR-016 | Public Identifier Strategy | Data Architecture | Accepted |
| ADR-017 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-018 | Database Initialization Strategy | Data Architecture | Accepted |
| ADR-019 | *(See ADR Repository)* | Accepted | Accepted |
| ADR-020 | Database Bootstrap and Security Architecture | Infrastructure | Accepted |
| ADR-021 | Canonical Domain Model and Schema Allocation | Data Architecture | Accepted |
| ADR-022 | Repository Architecture | Governance | Accepted |
| ADR-023 | Enterprise Audit and Domain Event Strategy | Governance | Accepted |
| ADR-024 | Enterprise Architecture Baseline Strategy | Enterprise | Accepted |
| ADR-025 | Canonical Enterprise ERD Strategy | Data Architecture | Accepted |

> Titles shown as **"(See ADR Repository)"** shall be replaced with the exact title from the corresponding ADR file. The catalog must always match the repository contents exactly.

---

# 8. Repository Metrics

| Metric | Value |
|---------|------:|
| Total ADRs | 26 |
| Accepted ADRs | 26 |
| Proposed ADRs | 0 |
| Deprecated ADRs | 0 |
| Superseded ADRs | 0 |

---

# 9. Traceability

Architecture Decision Records provide traceability between:

- Enterprise Vision
- Business Architecture
- Data Architecture
- Solution Architecture
- Enterprise Standards
- Governance
- Repository Baseline

Every canonical architectural artifact may reference one or more ADRs.

---

# 10. Relationship with Other Governance Artifacts

This catalog complements:

- RepositoryAuditReport.md
- RepositoryBaseline.md
- RepositoryFreezeReport.md
- GovernanceFramework.md
- ArtifactCatalog.md
- TraceabilityMatrix.md

---

# 11. Maintenance Policy

The Enterprise Architecture Team is responsible for maintaining this catalog.

The catalog shall be updated whenever:

- a new ADR is accepted;
- an ADR is superseded;
- an ADR is deprecated;
- repository governance changes.

The catalog shall always remain synchronized with the ADR repository.

---

# 12. References

Repository

Architecture/Enterprise/Decisions/ADR/

Governance

Architecture/Enterprise/Governance/

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-11 | Repository Baseline release |