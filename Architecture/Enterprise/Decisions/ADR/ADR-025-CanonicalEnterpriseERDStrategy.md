# ADR-025 — Canonical Diagram Strategy

| Field | Value |
|-------|-------|
| ADR ID | ADR-025 |
| Title | Canonical Diagram Strategy |
| Status | Accepted |
| Date | 2026-07-10 |
| Decision Makers | Phoenix Enterprise Architecture Team |
| Category | Enterprise Architecture |
| Impact | High |

---

# Context

During the evolution of the Phoenix Platform architecture, a complete set of canonical architectural artifacts has been established, including:

- Business Domain Model
- Aggregate Catalog
- Entity Catalog
- Enterprise Data Dictionary
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Relationship Definitions
- Business Constraint Matrix
- Enterprise Standards

Initially, Enterprise diagrams were considered as primary design artifacts.

However, practical experience during Sprint 3 demonstrated that this approach introduces unnecessary duplication, inconsistencies, and maintenance overhead.

The architecture itself is defined by canonical architectural artifacts.

Diagrams exist solely to visualize and communicate those artifacts.

Therefore, diagrams shall never become the authoritative source of architectural knowledge.

---

# Decision

The Phoenix Platform adopts the following architectural principles:

1. All architecture diagrams are **Derived Architectural Artifacts**.

2. Canonical architectural artifacts are the only authoritative source of architectural information.

3. Enterprise diagrams shall always be generated, validated, or maintained from approved canonical artifacts.

4. No architectural decision shall ever be made solely based on a diagram.

5. Every enterprise diagram shall remain synchronized with its canonical source.

---

# Canonical Sources

Architecture diagrams may derive information from one or more of the following artifacts:

- Canonical Domain Model
- Aggregate Catalog
- Entity Catalog
- Enterprise Data Dictionary
- Relationship Catalog
- Business Constraint Matrix
- Cardinality Matrix
- Enterprise Standards
- Approved ADRs

---

# Enterprise ERD Strategy

The Canonical Enterprise ERD is classified as a **Derived Enterprise Diagram**.

The ERD shall be produced only after the following artifacts reach the Approved state:

- Canonical Domain Model
- Aggregate Catalog
- Entity Catalog
- Relationship Definitions
- Enterprise Data Dictionary
- Business Constraints
- Logical Database Model

The ERD shall never replace these artifacts.

---

# Diagram Governance

Every enterprise diagram shall:

- reference its canonical sources;
- contain version information;
- be reviewable;
- remain technology-independent whenever possible;
- support long-term maintainability.

---

# Consequences

## Positive

- Single Source of Truth
- Elimination of duplicate modeling
- Improved consistency
- Easier maintenance
- Better traceability
- Higher documentation quality
- Possibility of automated diagram generation
- Reduced architectural drift

## Negative

- Diagram updates must follow changes in canonical artifacts.
- Diagram creation becomes the final step rather than the starting point.

---

# Related Artifacts

- PhoenixDiagramTemplate.vsdx
- CanonicalEnterpriseERD.md
- CanonicalDomainModel.md
- AggregateCatalog.md
- EntityCatalog.md
- EnterpriseDataDictionary.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- RelationshipCatalog.md
- BusinessConstraintMatrix.md

---

# Related ADRs

- ADR-021 — Canonical Domain Model and Schema Allocation
- ADR-022 — Repository Architecture
- ADR-024 — Enterprise Architecture Baseline Strategy

---

# Architecture Principle

> Canonical architectural artifacts define the architecture.

> Enterprise diagrams communicate the architecture.

Architecture shall never be defined by diagrams alone.

---

# Future Direction

This strategy applies not only to the Enterprise ERD, but also to all future Phoenix diagrams, including:

- Context Diagrams
- Service Dependency Diagrams
- Integration Diagrams
- Deployment Diagrams
- Security Diagrams
- Infrastructure Diagrams
- Capability Maps
- Data Flow Diagrams

All future architectural diagrams shall follow this ADR.