# Domain Dependency Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-004 |
| Document | DomainDependencyMatrix |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Phase | Stage 9 — Enterprise Data Architecture Baseline |
| Depends On | ConceptualDatabaseModel, CanonicalDomainModel, AggregateCatalog, AggregateDependencyMatrix, EnterpriseRelationshipMatrix, CanonicalBusinessRules |
| Consumed By | DomainLogicalModels, BusinessConstraintMatrix, CanonicalEnterpriseERD, LogicalDatabaseModel, PhysicalDatabaseModel, AggregateBoundaryValidation |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

The Domain Dependency Matrix defines the canonical dependency relationships between the business domains of the Phoenix Platform.

It establishes the approved dependency direction, architectural responsibilities and interaction boundaries among enterprise domains while preserving domain autonomy and preventing unintended coupling.

This document provides the authoritative architectural reference for validating domain interactions throughout the Enterprise Data Architecture baseline.

The Domain Dependency Matrix is independent of implementation technologies, database platforms, programming languages, messaging mechanisms and deployment architectures.

---

# 2. Scope

This specification governs dependency relationships between all enterprise business domains defined within the Phoenix Platform.

The scope includes:

- Domain dependency direction
- Dependency validation
- Cross-domain interaction
- Domain independence
- Domain layering
- Architectural governance
- Dependency constraints
- Enterprise consistency

The scope excludes:

- Physical database dependencies
- Service implementation dependencies
- API specifications
- Event implementation
- Infrastructure communication
- Deployment topology
- Runtime orchestration
- Technology-specific integrations

---

# 3. Objectives

The objectives of this document are to:

- define the canonical dependency model for all enterprise domains;
- ensure that dependencies remain intentional and architecturally governed;
- prevent circular dependencies between business domains;
- preserve domain ownership and bounded context autonomy;
- establish the dependency baseline for logical and physical data architecture;
- support enterprise architecture validation and governance.

---

# 4. Architectural Principles

The following architectural principles govern all domain dependencies.

| Principle ID | Principle | Description |
|--------------|-----------|-------------|
| DDP-001 | Unidirectional Dependencies | Domain dependencies shall always be unidirectional. |
| DDP-002 | Domain Independence | Every Domain shall preserve its business autonomy. |
| DDP-003 | No Circular Dependencies | Circular dependencies between Domains are prohibited. |
| DDP-004 | Explicit Dependencies | Every dependency shall be intentional and explicitly documented. |
| DDP-005 | Business-Driven Relationships | Dependencies shall reflect business semantics rather than implementation details. |
| DDP-006 | Published Interfaces | Cross-domain interaction shall occur only through approved enterprise interfaces. |
| DDP-007 | Read-Only Reporting | Reporting shall consume enterprise information without introducing business ownership. |
| DDP-008 | Observational Auditing | Audit shall observe enterprise behavior without influencing business logic. |
| DDP-009 | Stable Architecture | Dependency relationships shall remain stable across architecture baselines whenever possible. |
| DDP-010 | Technology Independence | Domain dependencies shall remain independent of implementation technologies. |

---

# 5. Domain Dependency Matrix

| Source Domain | Reference | Core | Market | Integration | Audit | Configuration | Reporting |
|---------------|:---------:|:----:|:------:|:-----------:|:-----:|:-------------:|:---------:|
| **Reference** | — | ✕ | ✕ | ✕ | ✕ | ✕ | ✕ |
| **Core** | ✓ | — | ✕ | ✕ | ✕ | ✕ | ✕ |
| **Market** | ✓ | ✓ | — | ✕ | ✕ | ✓ | ✕ |
| **Integration** | ✓ | ✓ | ✓ | — | ✕ | ✓ | ✕ |
| **Audit** | ✓ | ✓ | ✓ | ✓ | — | ✓ | ✕ |
| **Configuration** | ✕ | ✕ | ✕ | ✕ | ✕ | — | ✕ |
| **Reporting** | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | — |

**Legend**

- ✓ Allowed Dependency
- ✕ Dependency Not Permitted
- — Same Domain

---

# 6. Dependency Summary

| Domain | Permitted Dependencies | Primary Responsibility |
|----------|------------------------|----------------------|
| Reference | None | Enterprise reference information |
| Core | Reference | Enterprise master business entities |
| Market | Reference, Core, Configuration | Market operations and historical information |
| Integration | Reference, Core, Market, Configuration | External system integration |
| Audit | Reference, Core, Market, Integration, Configuration | Enterprise traceability |
| Configuration | None | Shared enterprise configuration |
| Reporting | All Domains | Read-only analytical consumption |

---

# 7. Dependency Layers

The enterprise dependency hierarchy is organized to preserve architectural stability, business ownership and clear separation of responsibilities.

Higher layers may consume services or information from lower layers, while lower layers shall never depend on higher architectural layers.

```text
                     Reporting Domain
                            ▲
                            │
                      Audit Domain
                            ▲
                            │
                  Integration Domain
                            ▲
                            │
                     Market Domain
                            ▲
                            │
                      Core Domain
                            ▲
                            │
                   Reference Domain


               Configuration Domain
                       │
                       └────────────► Shared Enterprise Services
                                     (Consumed by authorized Domains)
```

The dependency hierarchy establishes the following architectural characteristics:

- Reference Domain forms the architectural foundation of the enterprise.
- Core Domain extends enterprise reference information with master business entities.
- Market Domain builds upon Core and Reference domains to represent market operations and historical market information.
- Integration Domain connects external information sources with enterprise business entities while preserving enterprise identity.
- Audit Domain observes enterprise activities without participating in business ownership.
- Reporting Domain consumes enterprise information in a read-only manner.
- Configuration Domain remains independent and provides shared enterprise configuration across authorized domains.

---

# 8. Dependency Rules

The following architectural rules govern dependencies between enterprise domains.

## 8.1 Reference Domain

The Reference Domain is the foundational business domain of the enterprise architecture.

Rules:

- Shall not depend on any other Domain.
- Owns enterprise reference information.
- Provides reference information to authorized consumer Domains.
- Shall remain stable across architecture baselines.

---

## 8.2 Core Domain

The Core Domain defines enterprise master business entities.

Rules:

- Depends only on the Reference Domain.
- Owns enterprise master business information.
- Shall never depend on operational Domains.
- Provides master entities to downstream Domains.

---

## 8.3 Market Domain

The Market Domain represents operational market information.

Rules:

- Depends on the Reference Domain.
- Depends on the Core Domain.
- May consume shared Configuration information.
- Shall not own enterprise reference information.
- Shall preserve historical business integrity.

---

## 8.4 Integration Domain

The Integration Domain manages enterprise interaction with external information providers.

Rules:

- Depends on Reference, Core and Market Domains.
- May consume Configuration information.
- Shall never become the owner of enterprise business entities.
- Shall isolate provider-specific identities from enterprise identities.

---

## 8.5 Audit Domain

The Audit Domain provides enterprise traceability.

Rules:

- May observe operational Domains.
- Shall never modify business entities.
- Shall remain append-only.
- Shall preserve complete historical traceability.

---

## 8.6 Configuration Domain

The Configuration Domain provides enterprise-wide configuration capabilities.

Rules:

- Shall remain independent.
- Shall not depend on business Domains.
- May be consumed by authorized enterprise Domains.
- Shall not contain business ownership.

---

## 8.7 Reporting Domain

The Reporting Domain provides analytical and reporting capabilities.

Rules:

- May consume information from all enterprise Domains.
- Shall remain read-only.
- Shall never modify business information.
- Shall never become the authoritative owner of enterprise data.

---

# 9. Validation Rules

The following validation rules shall always be satisfied.

| Rule ID | Validation Rule |
|----------|-----------------|
| DDR-001 | Circular Domain dependencies shall not exist. |
| DDR-002 | Every dependency shall follow the approved enterprise dependency hierarchy. |
| DDR-003 | Every dependency shall be explicitly documented. |
| DDR-004 | Reference Domain shall remain independent. |
| DDR-005 | Core Domain shall depend only on the Reference Domain. |
| DDR-006 | Configuration Domain shall remain independent of business Domains. |
| DDR-007 | Reporting Domain shall remain read-only. |
| DDR-008 | Audit Domain shall remain observational and append-only. |
| DDR-009 | Cross-domain interactions shall preserve business ownership. |
| DDR-010 | Domain dependencies shall remain technology independent. |

---

# 10. Traceability

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| ConceptualDatabaseModel | Enterprise conceptual dependency model |
| CanonicalDomainModel | Domain ownership and responsibilities |
| CanonicalBusinessRules | Business semantics and governance |
| AggregateCatalog | Aggregate ownership |
| AggregateDependencyMatrix | Aggregate-level dependency validation |
| EnterpriseRelationshipMatrix | Cross-domain relationships |
| BusinessConstraintMatrix | Enterprise business constraints |
| DomainLogicalModels | Domain realization |
| CanonicalEnterpriseERD | Enterprise logical relationships |

---

# 11. Transition to Physical Design

The Domain Dependency Matrix provides the architectural foundation for the following implementation artifacts:

- Logical Database Model
- Physical Database Model
- Schema Dependency Design
- Foreign Key Strategy
- Service Boundary Definition
- Data Integration Architecture
- Enterprise Data Governance

Implementation-specific dependency mechanisms, database technologies and runtime communication patterns are intentionally excluded from this specification.

---


# 12. Related Artifacts

This specification shall be used together with the following Enterprise Architecture artifacts.

## Foundational Architecture

- PlatformArchitectureVision
- ArchitecturalPrinciples
- QualityAttributes
- CanonicalBusinessRules

## Business Architecture

- CanonicalDomainModel
- BoundedContextDefinition
- ServiceContextMap
- CanonicalServiceCatalog

## Data Architecture

- ConceptualDatabaseModel
- CanonicalEntityDefinitions
- AggregateCatalog
- AggregateDependencyMatrix
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CardinalityMatrix
- BusinessConstraintMatrix
- CanonicalEnterpriseERD
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseDataDictionary

---

# 13. Architectural Governance

The Domain Dependency Matrix is a controlled Enterprise Architecture artifact and forms part of the approved Phoenix Enterprise Architecture Baseline.

Any modification affecting:

- Domain responsibilities
- Dependency direction
- Domain ownership
- Cross-domain interactions
- Architectural layering
- Enterprise governance

shall require:

- Enterprise Architecture Review
- Dependency Impact Analysis
- Architecture Board Approval
- Repository Baseline Update

No implementation-specific dependency shall violate the dependency rules defined in this document.

---

# 14. Approval

The Enterprise Architecture Board approves this Domain Dependency Matrix as the authoritative specification governing dependencies between enterprise domains within the Phoenix Platform.

**Approval Status**

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Domain Dependency Matrix. |
| 2026.2 | 2026-07-19 | Repository-standard rewrite aligned with the Enterprise Architecture baseline, including standardized metadata, governance, dependency rules, validation, traceability and architectural consistency. |