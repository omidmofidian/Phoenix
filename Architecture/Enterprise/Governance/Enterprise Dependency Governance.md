# Enterprise Dependency Governance

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-007 |
| Document | DependencyRules |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Architecture Governance |
| Architecture Layer | Governance |
| Owner | Phoenix Architecture Board |
| Depends On | PlatformArchitectureVision.md, GovernanceFramework.md, RepositoryStructure.md, ArchitecturalPrinciples.md |
| Used By | All Architecture, Design, Software, Platform and Operations Artifacts |
| Last Updated | 2026-07-21 |

---

# 1. Purpose

This document defines the enterprise dependency policy governing the Phoenix Platform.

Dependency rules establish how architectural layers, repository capabilities, business domains, services, data assets, and implementation components may depend upon one another.

The objective is to preserve architectural integrity, eliminate unintended coupling, and ensure that the enterprise architecture remains modular, maintainable, and evolvable throughout its lifecycle.

This document serves as the authoritative dependency governance policy for the Phoenix Enterprise Architecture.

---

# 2. Objectives

The objectives of this document are to:

- establish enterprise-wide dependency principles;
- define permitted dependency directions;
- prohibit architectural cycles;
- preserve clear separation of responsibilities;
- protect business knowledge from implementation concerns;
- support repository governance;
- enable dependency validation;
- facilitate architecture reviews;
- improve long-term maintainability.

---

# 3. Scope

These dependency rules apply to every governed artifact within the Phoenix Platform.

The rules govern dependencies between:

- Enterprise Architecture layers
- Repository capabilities
- Governance artifacts
- Knowledge artifacts
- Business domains
- Services
- Data models
- Software components
- Platform infrastructure
- Operational artifacts

Unless explicitly approved through an Architecture Decision Record (ADR), no governed artifact may violate these dependency rules.

---

# 4. Enterprise Dependency Model

Enterprise dependencies follow the architectural flow of business knowledge toward operational realization.

```text
Enterprise Vision
        │
        ▼
Enterprise Knowledge
        │
        ▼
Business Architecture
        │
        ▼
Domain Architecture
        │
        ▼
Data Architecture
        │
        ▼
Service Architecture
        │
        ▼
Software Architecture
        │
        ▼
Platform
        │
        ▼
Operations
```

Dependencies shall always move downward through this architectural progression.

Higher architectural layers define intent.

Lower architectural layers realize that intent.

Reverse architectural dependencies are prohibited unless explicitly authorized through enterprise governance.

---

# 5. Enterprise Dependency Principles

All dependency decisions shall comply with the following enterprise principles.

## DP-001 — One Direction

Dependencies shall flow in a single architectural direction.

Reverse dependencies are prohibited.

---

## DP-002 — Separation of Responsibilities

Each architectural layer shall depend only upon information that belongs to lower-level implementation responsibilities when explicitly permitted by this standard.

Responsibilities shall never overlap through dependency shortcuts.

---

## DP-003 — Knowledge First

Enterprise knowledge governs architecture.

Architecture governs implementation.

Implementation shall never redefine enterprise knowledge.

---

## DP-004 — Stable Dependencies

Architectural dependencies should target stable enterprise concepts rather than implementation details.

Stable abstractions shall be preferred over volatile implementations.

---

## DP-005 — Explicit Dependencies

Significant architectural dependencies shall be explicitly documented.

Hidden or implicit dependencies should be avoided.

---

## DP-006 — Minimal Coupling

Dependencies shall be minimized whenever practical.

Reducing dependency complexity improves maintainability, scalability, and architectural evolution.

---

## DP-007 — No Circular Dependencies

Circular dependencies are prohibited across every architectural layer, repository capability, service boundary, domain boundary, and software component.

Repository validation shall detect and report dependency cycles.

---

## DP-008 — No Hidden Dependencies

Every architectural dependency shall be explicitly visible, documented, and traceable.

Hidden dependencies introduced through undocumented assumptions, implicit knowledge, shared databases, or implementation shortcuts are prohibited.

---

# 6. Enterprise Layer Dependencies

Enterprise architecture is organized as a hierarchy of architectural layers.

Each layer has a distinct responsibility and may depend only upon explicitly permitted layers.

Dependency rules preserve architectural integrity by preventing implementation concerns from influencing business knowledge.

---

## 6.1 Enterprise Layer Hierarchy

The Phoenix Platform adopts the following enterprise dependency hierarchy.

```text
Enterprise Vision
        │
        ▼
Enterprise Knowledge
        │
        ▼
Business Architecture
        │
        ▼
Domain Architecture
        │
        ▼
Data Architecture
        │
        ▼
Service Architecture
        │
        ▼
Software Architecture
        │
        ▼
Platform
        │
        ▼
Operations
```

Every dependency shall respect this hierarchy.

---

## 6.2 Layer Responsibilities

| Layer | Primary Responsibility |
|--------|------------------------|
| Enterprise Vision | Strategic direction and enterprise objectives |
| Enterprise Knowledge | Business knowledge, terminology, and reference information |
| Business Architecture | Business capabilities, rules, and organizational concepts |
| Domain Architecture | Domain boundaries, aggregates, and business models |
| Data Architecture | Enterprise information structures and ownership |
| Service Architecture | Business service realization |
| Software Architecture | Software implementation and component organization |
| Platform | Runtime environment and technical infrastructure |
| Operations | Deployment, monitoring, maintenance, and operational governance |

Each layer shall remain focused on its own responsibility and shall not absorb concerns belonging to other architectural layers.

---

## 6.3 Dependency Direction Rules

The dependency direction is strictly top-down.

Higher architectural layers govern lower architectural layers.

Lower layers implement decisions originating from higher layers.

Accordingly:

- Enterprise Vision governs all subsequent layers.
- Enterprise Knowledge informs Business Architecture.
- Business Architecture governs Domain Architecture.
- Domain Architecture governs Data and Service Architecture.
- Service Architecture governs Software Architecture.
- Software Architecture depends upon Platform capabilities.
- Platform supports Operations.

Reverse dependencies are prohibited.

---

# 7. Allowed Dependency Rules

Dependencies are permitted only when explicitly allowed by this standard.

The following rules define the canonical dependency policy.

---

## DR-001 — Vision Dependencies

Enterprise Vision shall not depend upon any lower architectural layer.

Vision defines enterprise direction.

It is the origin of architectural intent.

---

## DR-002 — Knowledge Dependencies

Enterprise Knowledge may depend upon Enterprise Vision.

It shall not depend upon:

- Business Architecture
- Domain Architecture
- Data Architecture
- Service Architecture
- Software
- Platform
- Operations

---

## DR-003 — Business Architecture Dependencies

Business Architecture may depend upon:

- Enterprise Vision
- Enterprise Knowledge

Business Architecture shall not depend upon implementation-oriented layers.

---

## DR-004 — Domain Architecture Dependencies

Domain Architecture may depend upon:

- Enterprise Knowledge
- Business Architecture

Domain models shall remain independent of software implementation.

---

## DR-005 — Data Architecture Dependencies

Data Architecture may depend upon:

- Business Architecture
- Domain Architecture

Enterprise data structures shall not depend upon software implementation technologies.

---

## DR-006 — Service Architecture Dependencies

Service Architecture may depend upon:

- Business Architecture
- Domain Architecture
- Data Architecture

Service definitions shall remain independent of deployment technologies.

---

## DR-007 — Software Architecture Dependencies

Software Architecture may depend upon:

- Service Architecture
- Data Architecture
- Platform interfaces

Software shall not redefine business concepts or enterprise knowledge.

---

## DR-008 — Platform Dependencies

Platform components may depend upon Software Architecture and approved infrastructure technologies.

Platform concerns shall remain independent of business semantics.

---

## DR-009 — Operations Dependencies

Operational artifacts may depend upon every implementation-oriented layer required for deployment, monitoring, maintenance, and runtime governance.

Operations shall not redefine architectural intent.

---

# 8. Repository Capability Dependencies

Repository capabilities follow the same dependency principles as enterprise architecture.

Each capability represents a distinct area of enterprise responsibility.

---

## 8.1 Capability Dependency Model

```text
Knowledge
      │
      ▼
Architecture
      │
      ▼
Data
      │
      ▼
Software
      │
      ▼
Platform
      │
      ▼
Operations
```

Project and Resources capabilities support the repository but do not alter this dependency hierarchy.

---

## 8.2 Repository Rules

### RC-001 — Knowledge Independence

Knowledge shall not depend upon implementation artifacts.

---

### RC-002 — Architecture Independence

Architecture shall not depend upon Software or Platform implementation.

---

### RC-003 — Data Independence

Enterprise data definitions shall remain independent of implementation technologies.

---

### RC-004 — Software Compliance

Software shall implement approved architectural decisions without redefining them.

---

### RC-005 — Platform Isolation

Platform artifacts shall provide technical capabilities without embedding enterprise business logic.

---

### RC-006 — Operational Separation

Operational documentation shall describe deployment and runtime behavior rather than architectural design.

---

# 9. Architectural Dependency Rules

Architectural dependencies shall preserve the integrity of the Phoenix Enterprise Architecture by maintaining clear responsibility boundaries between architectural elements.

Every architectural dependency shall be intentional, explicit, and justifiable.

---

## 9.1 Architectural Dependency Principles

Architecture components shall collaborate through stable abstractions rather than implementation details.

Dependencies shall:

- preserve architectural cohesion;
- minimize coupling;
- respect bounded contexts;
- avoid architectural leakage;
- support long-term evolution.

---

## 9.2 Domain Dependencies

Domain Architecture represents the enterprise business model.

Domain components shall remain independent of implementation technologies.

### AD-001 — Domain Independence

A domain shall not depend upon another domain unless an explicit business relationship exists.

---

### AD-002 — Aggregate Independence

Aggregates shall remain autonomous consistency boundaries.

Aggregates shall communicate through identifiers, published events, or application services rather than direct object references.

---

### AD-003 — Aggregate Ownership

Entities shall belong to exactly one Aggregate.

Cross-aggregate ownership is prohibited.

---

### AD-004 — Shared Kernel

Shared Kernel dependencies shall remain minimal and explicitly governed.

Only concepts intentionally shared between bounded contexts may reside within the Shared Kernel.

---

### AD-005 — Context Isolation

Bounded Contexts shall remain isolated.

Integration between contexts shall occur through published contracts rather than internal implementation details.

---

# 10. Service Dependency Rules

Service Architecture realizes enterprise business capabilities.

Service dependencies shall preserve loose coupling and independent evolution.

---

## 10.1 Service Principles

Services shall communicate through well-defined contracts.

Direct implementation dependencies between services shall be minimized.

---

## 10.2 Service Rules

### SD-001 — Business Alignment

Every service shall realize one or more approved business capabilities.

---

### SD-002 — Contract First

Services shall depend upon published service contracts rather than implementation classes or internal components.

---

### SD-003 — Service Autonomy

Services shall remain independently deployable and independently evolvable whenever practical.

---

### SD-004 — Data Ownership

Each service owns its authoritative business data.

Direct modification of another service's data store is prohibited.

---

### SD-005 — Service Communication

Service interaction shall occur through approved integration mechanisms, including:

- service interfaces;
- APIs;
- domain events;
- messaging;
- asynchronous integration.

Database-to-database integration between services shall be avoided.

---

### SD-006 — Circular Service Dependencies

Mutual service dependencies are prohibited.

Dependency graphs between services shall remain acyclic.

---

# 11. Data Dependency Rules

Enterprise Data Architecture defines authoritative business information.

Data dependencies shall preserve information ownership, consistency, and integrity.

---

## 11.1 Data Principles

Enterprise information shall remain independent of implementation technologies.

Business semantics govern data—not application logic.

---

## 11.2 Data Rules

### DD-001 — Single Source of Truth

Each business fact shall have one authoritative owner.

Duplicate ownership is prohibited.

---

### DD-002 — Reference Integrity

Relationships between enterprise entities shall be explicitly defined and validated.

---

### DD-003 — Canonical Definitions

Business entities shall originate from the Canonical Domain Model.

Physical implementations shall not redefine enterprise semantics.

---

### DD-004 — Reference Data

Reference data shall be centrally governed and shared across authorized services.

---

### DD-005 — Historical Preservation

Historical business facts shall remain immutable whenever business regulations permit.

---

### DD-006 — Technology Independence

Logical data models shall not depend upon database vendor features unless explicitly approved through governance.

---

# 12. Knowledge Dependency Rules

Enterprise Knowledge forms the intellectual foundation of the Phoenix Platform.

All architectural, engineering, and operational artifacts ultimately derive their meaning from enterprise knowledge.

Knowledge dependencies therefore flow outward from the Knowledge capability and shall never be created in the opposite direction.

---

## 12.1 Knowledge Principles

Enterprise Knowledge shall remain:

- authoritative;
- technology-independent;
- implementation-neutral;
- reusable;
- centrally governed.

Knowledge artifacts describe **what the enterprise knows**, not **how software is implemented**.

---

## 12.2 Knowledge Rules

### KD-001 — Knowledge Primacy

Enterprise Knowledge shall precede architectural and implementation decisions.

Architecture shall interpret enterprise knowledge rather than redefine it.

---

### KD-002 — Technology Neutrality

Knowledge artifacts shall not depend upon:

- programming languages;
- databases;
- frameworks;
- infrastructure technologies;
- deployment environments.

---

### KD-003 — Stable Terminology

Business terminology shall originate from approved enterprise knowledge artifacts.

Alternative terminology shall not be introduced within architecture, design, or implementation artifacts without governance approval.

---

### KD-004 — Canonical Definitions

Business concepts shall be defined exactly once.

Architectural and implementation artifacts shall reference canonical definitions rather than creating alternative interpretations.

---

### KD-005 — Knowledge Reuse

Knowledge artifacts shall be reused through references whenever possible.

Duplicate knowledge documentation shall be avoided.

---

# 13. Forbidden Dependencies

Certain dependency relationships are fundamentally incompatible with the Phoenix Enterprise Architecture.

These prohibited dependencies protect architectural integrity and preserve long-term maintainability.

---

## 13.1 Architectural Violations

The following dependency patterns are prohibited.

### FD-001 — Reverse Layer Dependencies

Lower architectural layers shall not govern higher architectural layers.

Examples include:

- Software → Business Architecture
- Platform → Domain Architecture
- Operations → Enterprise Vision

---

### FD-002 — Circular Dependencies

Circular dependencies are prohibited between:

- repository capabilities;
- architectural layers;
- bounded contexts;
- services;
- software modules;
- governance artifacts.

---

### FD-003 — Business Logic in Infrastructure

Infrastructure and platform components shall not contain enterprise business rules.

Business decisions belong exclusively to the Business and Domain Architecture layers.

---

### FD-004 — Technology-Driven Business Models

Business models shall not be influenced by implementation technologies.

Architecture shall adapt technology to business—not business to technology.

---

### FD-005 — Cross-Service Database Ownership

A service shall not directly modify another service's authoritative data store.

Inter-service collaboration shall occur through approved integration mechanisms.

---

### FD-006 — Duplicate Business Ownership

Multiple architectural components shall not claim ownership of the same business responsibility.

Ownership shall remain explicit and unambiguous.

---

### FD-007 — Repository Layer Violations

Repository capabilities shall not bypass approved dependency directions.

Artifacts shall remain within their architectural responsibility boundaries.

---

# 14. Dependency Validation

Compliance with this standard shall be continuously verified throughout the enterprise architecture lifecycle.

Dependency validation ensures that architectural integrity is preserved as the repository evolves.

---

## 14.1 Validation Objectives

Validation activities verify:

- dependency direction;
- architectural layering;
- repository consistency;
- domain isolation;
- service autonomy;
- data ownership;
- knowledge independence;
- governance compliance.

---

## 14.2 Validation Rules

### DV-001 — Dependency Direction Validation

Every dependency shall follow the approved enterprise dependency hierarchy.

---

### DV-002 — Circular Dependency Validation

Repository validation shall identify and report dependency cycles.

---

### DV-003 — Layer Isolation Validation

Artifacts shall not introduce dependencies that violate architectural layer boundaries.

---

### DV-004 — Service Dependency Validation

Service relationships shall comply with the approved Service Architecture.

---

### DV-005 — Repository Dependency Validation

Repository capability dependencies shall comply with the approved Repository Structure and Governance Framework.

---

## 14.3 Validation Activities

Dependency validation may be performed through:

- Architecture Reviews;
- Repository Audits;
- Dependency Analysis;
- Architecture Validation Reports;
- Repository Validation Reports;
- Continuous Governance Reviews.

Validation findings shall be documented and resolved before architectural approval is granted.

---

# 15. Compliance

Compliance with this standard is mandatory for every governed artifact, repository capability, architectural layer, service, data asset, software component, and operational artifact within the Phoenix Platform.

Conformance ensures that enterprise dependencies remain explicit, consistent, verifiable, and aligned with the approved architectural governance model.

Compliance shall be continuously evaluated throughout the architecture lifecycle.

---

## 15.1 Mandatory Requirements

Every governed artifact shall:

- comply with the approved enterprise dependency hierarchy;
- avoid prohibited dependency relationships;
- preserve separation of responsibilities;
- maintain explicit ownership boundaries;
- participate in enterprise traceability;
- comply with repository governance;
- satisfy dependency validation requirements.

---

## 15.2 Non-Compliance

The following situations constitute architectural non-compliance.

### NC-001 — Reverse Dependency

A lower architectural layer governs or influences a higher architectural layer.

---

### NC-002 — Circular Dependency

Two or more architectural components form a dependency cycle.

---

### NC-003 — Layer Boundary Violation

An artifact bypasses one or more approved architectural layers.

---

### NC-004 — Unauthorized Cross-Domain Dependency

A domain depends upon another domain without an approved architectural relationship.

---

### NC-005 — Service Ownership Violation

A service directly manipulates another service's authoritative business data.

---

### NC-006 — Repository Dependency Violation

Repository capabilities violate the approved dependency model.

---

### NC-007 — Knowledge Dependency Violation

Implementation artifacts redefine enterprise knowledge or introduce conflicting business semantics.

---

Repository validation activities shall identify and report all dependency violations before architectural approval or repository certification.

---

# 16. Related Artifacts

## Vision

- PlatformArchitectureVision.md
- ReferenceArchitecture.md
- KnowledgeDrivenArchitecture.md
- LayerArchitecture.md

---

## Governance

- GovernanceFramework.md
- RepositoryStructure.md
- ArtifactCatalog.md
- ArtifactIdentifierStandard.md

---

## Principles

- ArchitecturalPrinciples.md
- EngineeringPrinciples.md
- QualityAttributes.md

---

## Standards

- DocumentationStandard.md
- RepositoryStructureStandard.md
- NamingConventionStandard.md

---

## Validation

- ArchitectureValidationReport.md
- EnterpriseConsistencyValidationReport.md
- TraceabilityValidationReport.md
- RepositoryValidationReport.md
- ArchitectureValidationDashboard.md

---

## Architecture Decision Records

- ADR-001 — Enterprise Architectural Principles
- ADR-012 — Service-Oriented Modular Architecture
- ADR-020 — Enterprise Modeling Strategy
- ADR-021 — Canonical Domain Model & Schema Allocation
- ADR-022 — Repository Documentation Structure
- ADR-023 — Enterprise Audit and Validation Strategy

---

# 17. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-08 | Initial dependency rules. |
| 2026.2 | 2026-07-21 | Complete enterprise redesign aligned with the Platform Architecture Vision, Knowledge-Driven Architecture, Repository Structure, Governance Framework, Architectural Principles, Quality Attributes, Enterprise Traceability Model, Validation Framework, and Capability-Centric Repository Architecture. |

---

# End of Document