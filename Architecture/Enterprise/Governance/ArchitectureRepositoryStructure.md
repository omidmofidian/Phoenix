# Repository Structure

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-005 |
| Document | RepositoryStructure |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Architecture Governance |
| Architecture Layer | Governance |
| Owner | Phoenix Architecture Board |
| Governed By | ADR-022 — Repository Documentation Structure |
| Depends On | PlatformArchitectureVision.md, GovernanceFramework.md, ArchitecturalPrinciples.md, EngineeringPrinciples.md |
| Used By | All Enterprise Architecture, Design, Development, Operations and Knowledge Artifacts |
| Last Updated | 2026-07-21 |

---

# 1. Purpose

This document defines the canonical repository structure of the Phoenix Platform.

It establishes the enterprise governance model for organizing architectural knowledge, engineering assets, implementation artifacts, operational documentation, and project deliverables within a single, coherent repository.

The repository is considered an architectural asset rather than a source code container. Its organization reflects the enterprise capabilities of the platform and supports long-term maintainability, traceability, governance, and controlled architectural evolution.

This document serves as the authoritative reference for repository organization throughout the lifecycle of the Phoenix Platform.

---

# 2. Scope

This document governs the organization of every artifact maintained within the Phoenix repository, including but not limited to:

- Enterprise Architecture artifacts
- Architecture Decision Records (ADR)
- Governance documents
- Knowledge assets
- Business documentation
- Domain models
- Data architecture
- Design specifications
- Source code
- Database artifacts
- Infrastructure assets
- Operational documentation
- Project management artifacts
- Shared resources

Repository organization applies equally to documentation, executable assets, configuration files, engineering deliverables, and supporting materials.

No repository artifact shall exist outside the approved repository structure without formal architectural approval.

---

# 3. Architecture Context

The repository organization defined by this document implements the architectural governance established by:

- Platform Architecture Vision
- Architectural Principles
- Engineering Principles
- Governance Framework
- ADR-022 — Repository Documentation Structure

Rather than organizing artifacts according to implementation technologies, the Phoenix repository is organized around enterprise capabilities.

This capability-centric organization enables:

- Clear ownership
- Long-term scalability
- Technology independence
- Domain isolation
- Consistent governance
- Enterprise traceability

The repository therefore becomes an integral part of the enterprise architecture rather than a passive document store.

---

# 4. Repository Philosophy

The Phoenix repository follows four fundamental architectural principles.

## Capability-Centric Organization

Repository organization reflects enterprise business and engineering capabilities rather than technical implementation details.

Artifacts are grouped according to their architectural responsibility.

---

## Single Source of Truth

Every architectural concept, business definition, engineering standard, and implementation artifact shall have exactly one authoritative location.

Duplicate artifacts are prohibited.

Cross-references shall be used instead of duplication whenever possible.

---

## Lifecycle Alignment

Repository organization follows the complete enterprise lifecycle.

```text
Knowledge
        │
        ▼
Architecture
        │
        ▼
Design
        │
        ▼
Implementation
        │
        ▼
Operations
```

Each lifecycle stage produces artifacts that become authoritative inputs for subsequent stages.

---

## Governance by Architecture

Repository evolution is governed through architectural decisions rather than individual development preferences.

Structural modifications require formal architectural review and, where applicable, an approved Architecture Decision Record (ADR).

Repository governance is therefore treated as an enterprise architecture responsibility rather than an implementation activity.

---

# 5. Capability-Centric Repository Model

The Phoenix repository is organized according to enterprise capabilities.

Each top-level capability represents a stable architectural responsibility with clearly defined ownership and governance.

This organizational model replaces traditional technology-oriented repository structures and enables the platform to evolve without disrupting architectural consistency.

The canonical repository capabilities are summarized below.

| Capability | Primary Responsibility |
|------------|------------------------|
| Architecture | Enterprise architecture, governance and strategic design |
| Data | Enterprise data architecture, models and database assets |
| Knowledge | Business knowledge and domain expertise |
| Operations | Operational procedures, runbooks and maintenance |
| Platform | Platform infrastructure and shared technical capabilities |
| Project | Planning, roadmaps, milestones and project governance |
| Resources | Shared reusable resources and templates |
| Software | Source code, applications and implementation assets |
| Workspace | Active working material and temporary engineering artifacts |
| Archive | Historical and deprecated repository content |

These capabilities collectively define the canonical enterprise repository structure approved by the Phoenix Architecture Board.

---

# 6. Repository Design Principles

The Phoenix repository shall be governed by a consistent set of architectural principles that ensure long-term sustainability, maintainability, and enterprise-wide consistency.

These principles apply to every repository capability, regardless of technology, implementation language, or business domain.

---

## RP-001 — Capability-Based Organization

Repository organization shall reflect enterprise capabilities rather than implementation technologies.

Each top-level directory represents a stable architectural capability with clearly defined responsibilities and ownership.

---

## RP-002 — Single Source of Truth

Every architectural concept, engineering standard, business definition, implementation artifact, and operational document shall exist in one authoritative location only.

Duplicate artifacts are prohibited.

When multiple consumers require the same information, cross-references shall be used instead of duplication.

---

## RP-003 — Explicit Ownership

Every repository artifact shall have a clearly identifiable owner responsible for its accuracy, maintenance, lifecycle, and governance.

Ownership shall remain stable throughout the artifact lifecycle.

---

## RP-004 — Architectural Traceability

Every significant repository artifact shall participate in the enterprise traceability chain.

Artifacts shall be traceable to their governing architecture decisions, business objectives, engineering standards, or implementation deliverables.

---

## RP-005 — Technology Independence

Repository organization shall remain independent of implementation technologies whenever practical.

Technological evolution shall not require structural redesign of the repository.

---

## RP-006 — Controlled Evolution

Repository structure shall evolve only through approved governance processes.

Structural modifications require architectural review and, where appropriate, an approved Architecture Decision Record (ADR).

---

## RP-007 — Consistency

Naming conventions, artifact classifications, metadata, directory structures, and documentation standards shall remain consistent throughout the repository.

Consistency shall take precedence over local optimization.

---

## RP-008 — Long-Term Maintainability

Repository organization shall prioritize long-term maintainability over short-term convenience.

Structural simplicity, discoverability, and architectural clarity shall guide repository evolution.

---

# 7. Enterprise Repository Capabilities

The repository is organized into enterprise capabilities.

Each capability represents a distinct architectural responsibility with clearly defined governance boundaries.

## 7.1 Architecture

Purpose

Defines the enterprise architecture of the Phoenix Platform.

Typical contents include:

- Architecture Vision
- Architectural Principles
- Engineering Principles
- Domain Architecture
- Service Architecture
- Governance
- Architecture Decision Records
- Architecture Reviews

Primary responsibility

Establish and govern the long-term architectural direction of the platform.

---

## 7.2 Data

Purpose

Defines enterprise information architecture and database specifications.

Typical contents include:

- Conceptual Models
- Logical Models
- Physical Models
- Enterprise Data Dictionary
- Canonical ERD
- Database Standards
- Schema Specifications

Primary responsibility

Provide a technology-independent and implementation-ready enterprise data architecture.

---

## 7.3 Knowledge

Purpose

Captures enterprise business knowledge, financial expertise, terminology, and research.

Typical contents include:

- Business Glossary
- Business Concepts
- Business Rules
- Market Knowledge
- Research
- Regulatory References
- Financial Knowledge

Primary responsibility

Maintain the enterprise knowledge base supporting business and architectural decisions.

---

## 7.4 Operations

Purpose

Defines operational governance throughout the platform lifecycle.

Typical contents include:

- Runbooks
- Operational Procedures
- Monitoring Guides
- Maintenance Documentation
- Disaster Recovery
- Deployment Operations

Primary responsibility

Ensure reliable operation of the platform after deployment.

---

## 7.5 Platform

Purpose

Defines platform-wide infrastructure capabilities shared across all services.

Typical contents include:

- Infrastructure Architecture
- Container Platform
- Development Environment
- Synchronization
- Shared Platform Services

Primary responsibility

Provide common technical capabilities supporting the entire enterprise platform.

---

## 7.6 Project

Purpose

Manages planning, governance, scheduling, milestones, and project lifecycle.

Typical contents include:

- Project Overview
- Sprint Plans
- Roadmaps
- Milestones
- Reviews
- Planning Documents

Primary responsibility

Coordinate enterprise delivery while preserving architectural governance.

---

## 7.7 Resources

Purpose

Stores reusable assets shared across multiple capabilities.

Typical contents include:

- Templates
- Diagram Resources
- Icons
- Reference Material
- Shared Documents

Primary responsibility

Promote reuse and consistency throughout the repository.

---

## 7.8 Software

Purpose

Contains implementation assets and executable software components.

Typical contents include:

- Source Code
- Libraries
- Applications
- APIs
- Tests
- Build Configuration

Primary responsibility

Implement the enterprise architecture defined elsewhere in the repository.

---

## 7.9 Workspace

Purpose

Provides controlled working space for temporary engineering activities.

Typical contents include:

- Experimental Models
- Draft Documents
- Working Notes
- Temporary Analysis

Primary responsibility

Support ongoing engineering work without affecting approved architectural baselines.

---

## 7.10 Archive

Purpose

Preserves historical repository content.

Typical contents include:

- Deprecated Artifacts
- Historical Versions
- Superseded Specifications
- Legacy Documentation

Primary responsibility

Maintain historical traceability while preventing obsolete artifacts from affecting active development.

---

# 8. Enterprise Artifact Taxonomy

The Phoenix repository classifies artifacts according to their architectural purpose rather than their implementation format.

Artifact classification establishes a common governance model, improves discoverability, supports traceability, and enables consistent repository validation.

Every repository artifact shall belong to one and only one artifact family.

---

## 8.1 Architecture Artifacts

Architecture artifacts define the long-term structure, principles, decisions, and governance of the platform.

Examples include:

- Architecture Vision
- Architectural Principles
- Engineering Principles
- Reference Architectures
- Domain Models
- Service Models
- Governance Documents

Primary identifier prefixes include:

- ADR
- GOV
- ART

---

## 8.2 Knowledge Artifacts

Knowledge artifacts capture enterprise business knowledge independent of implementation technologies.

Examples include:

- Business Glossary
- Business Concepts
- Business Rules
- Entity Definitions
- Domain Responsibilities
- Financial Knowledge
- Regulatory References

Typical identifier prefixes include:

- KNW

---

## 8.3 Data Architecture Artifacts

Data artifacts define enterprise information structures and database architecture.

Examples include:

- Conceptual Data Models
- Logical Data Models
- Physical Data Models
- Enterprise Data Dictionary
- Canonical ERD
- Database Standards

Typical identifier prefixes include:

- MOD
- DCT
- ERD

---

## 8.4 Standards

Standards define mandatory engineering and documentation practices.

Examples include:

- Documentation Standards
- Naming Standards
- Database Standards
- Coding Standards
- Repository Standards

Typical identifier prefixes include:

- STD

---

## 8.5 Validation Artifacts

Validation artifacts document formal architectural verification and governance activities.

Examples include:

- Architecture Validation Reports
- Domain Validation Reports
- Repository Validation Reports
- Compliance Reports
- Review Reports

Typical identifier prefixes include:

- VAL

---

## 8.6 Catalogs

Catalogs provide authoritative inventories of enterprise assets.

Examples include:

- Aggregate Catalog
- Service Catalog
- Attribute Catalog
- Relationship Catalog
- Entity Catalog

Typical identifier prefixes include:

- CAT

---

## 8.7 Dictionaries

Dictionaries define authoritative business and technical terminology.

Examples include:

- Entity Dictionary
- Attribute Dictionary
- Relationship Dictionary
- Business Dictionary

Typical identifier prefixes include:

- DCT

---

## 8.8 Matrices

Matrices document relationships, dependencies, responsibilities, and mappings across architectural artifacts.

Examples include:

- Dependency Matrix
- Traceability Matrix
- Relationship Matrix
- Responsibility Matrix

Typical identifier prefixes include:

- MAT

---

## 8.9 Operational Artifacts

Operational artifacts support platform operation after implementation.

Examples include:

- Runbooks
- Deployment Guides
- Monitoring Procedures
- Disaster Recovery Procedures
- Operational Checklists

Typical identifier prefixes include:

- OPS
- RB

---

# 9. Artifact Placement Rules

Repository consistency depends upon predictable artifact placement.

The following repository rules are mandatory.

---

## RR-001 — Single Authoritative Location

Every artifact shall exist in exactly one approved repository location.

Duplicate artifacts are prohibited.

---

## RR-002 — Capability Ownership

Every artifact shall belong to one enterprise capability.

Artifacts shall never span multiple capability roots.

---

## RR-003 — Explicit Ownership

Every artifact shall identify its responsible owner.

Ownership shall be maintained throughout the artifact lifecycle.

---

## RR-004 — Metadata Compliance

Every governed artifact shall include the mandatory metadata defined by the Documentation Standard.

Repository validation shall verify metadata completeness.

---

## RR-005 — Naming Compliance

Artifact names shall comply with the Enterprise Naming Convention Standard (STD-003).

Technology-specific naming shall be avoided whenever practical.

---

## RR-006 — Cross-Reference Preference

When multiple documents require the same information, cross-references shall be used instead of duplication.

Repository consistency shall take precedence over local convenience.

---

## RR-007 — Baseline Protection

Approved baseline artifacts shall not be modified directly.

Changes shall follow the Architecture Governance process.

---

## RR-008 — Traceability

Repository artifacts shall maintain traceability to their governing architectural decisions, standards, or business objectives.

---

# 10. Repository Dependency Model

Repository dependencies shall follow the approved enterprise architecture lifecycle.

The dependency direction is strictly top-down.

```text
Knowledge
        │
        ▼
Architecture
        │
        ▼
Data & Design
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

Each capability consumes authoritative information produced by preceding capabilities.

Reverse dependencies are prohibited unless explicitly approved by an Architecture Decision Record.

---

## 10.1 Allowed Dependencies

The following dependency directions are permitted.

| Consumer | May Depend On |
|-----------|---------------|
| Knowledge | None |
| Architecture | Knowledge |
| Data | Knowledge, Architecture |
| Software | Knowledge, Architecture, Data |
| Platform | Knowledge, Architecture, Data, Software |
| Operations | All approved implementation capabilities |

---

## 10.2 Forbidden Dependencies

The following dependency patterns are prohibited.

- Knowledge depending on implementation artifacts.
- Architecture depending on software implementation.
- Data architecture being driven by database products.
- Software redefining architectural decisions.
- Operations modifying architecture baselines.
- Cross-capability circular dependencies.

Any exception requires formal approval through the Architecture Governance process and shall be documented by an approved Architecture Decision Record (ADR).

---

# 11. Repository Governance Model

Repository governance ensures that the Phoenix repository remains consistent, traceable, maintainable, and aligned with the approved enterprise architecture throughout its lifecycle.

Repository governance applies to every architectural, engineering, implementation, operational, and project artifact maintained within the repository.

---

## 11.1 Governance Objectives

Repository governance aims to:

- Preserve architectural consistency.
- Maintain repository integrity.
- Ensure compliance with enterprise standards.
- Prevent uncontrolled structural evolution.
- Support long-term maintainability.
- Protect approved architectural baselines.
- Enable complete enterprise traceability.

---

## 11.2 Governance Authority

The Phoenix Architecture Board is the governing authority responsible for repository evolution.

Its responsibilities include:

- Approving structural modifications.
- Reviewing architectural compliance.
- Governing repository standards.
- Maintaining architectural baselines.
- Approving Architecture Decision Records (ADR).
- Authorizing repository freeze activities.

No structural repository modification shall bypass this governance process.

---

## 11.3 Governance Activities

Repository governance includes the following recurring activities.

| Activity | Purpose |
|----------|---------|
| Architecture Review | Verify architectural consistency |
| Repository Audit | Verify repository compliance |
| Validation Review | Verify enterprise integrity |
| Baseline Review | Approve architectural baseline |
| ADR Review | Govern structural decisions |
| Repository Certification | Confirm repository readiness |

These governance activities collectively ensure continuous architectural quality.

---

## 11.4 Governance Rules

Repository governance shall enforce the following mandatory rules.

### RG-001 — Structural Stability

Approved repository capabilities shall remain stable.

Structural modifications require architectural approval.

---

### RG-002 — Architectural Compliance

Repository organization shall comply with all approved Architecture Decision Records.

---

### RG-003 — Standards Compliance

Repository artifacts shall comply with all approved enterprise standards.

---

### RG-004 — Validation Requirement

Major architectural changes shall complete the required validation process before becoming part of an approved baseline.

---

### RG-005 — Repository Traceability

Repository evolution shall remain fully traceable through Architecture Decision Records, governance documents, and validation reports.

---

# 12. Repository Lifecycle

Repository artifacts evolve through a controlled governance lifecycle.

Each lifecycle stage introduces additional governance controls while preserving architectural consistency.

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
Baseline
    │
    ▼
Frozen
    │
    ▼
Superseded
    │
    ▼
Archived
```

Repository lifecycle states apply to documentation, standards, architectural models, and implementation artifacts where appropriate.

---

## 12.1 Draft

Artifacts under active development.

Characteristics include:

- Working documents.
- Incomplete content.
- Subject to change.
- Not yet governed.

---

## 12.2 Review

Artifacts undergoing formal architectural review.

Activities include:

- Technical review.
- Consistency verification.
- Traceability review.
- Standards validation.

---

## 12.3 Approved

Approved artifacts become authoritative references.

Approved artifacts may be referenced by other repository components.

---

## 12.4 Baseline

Baseline artifacts represent officially released architectural states.

Baselines provide stable reference points for future architectural evolution.

---

## 12.5 Frozen

Frozen artifacts shall not be modified directly.

Subsequent changes require:

- Architecture Review.
- Approved ADR (when applicable).
- Version increment.
- Updated validation.

---

## 12.6 Superseded

Superseded artifacts remain historically valid but are replaced by newer authoritative versions.

They shall remain available for traceability purposes.

---

## 12.7 Archived

Archived artifacts are retained exclusively for historical, regulatory, or governance purposes.

Archived artifacts shall not participate in active architectural development.

---

# 13. Repository Compliance Model

Repository compliance is continuously evaluated through enterprise governance.

Compliance ensures that repository evolution remains consistent with the approved architecture.

---

## 13.1 Compliance Areas

Repository compliance includes verification of:

- Repository structure
- Artifact placement
- Naming conventions
- Metadata completeness
- Traceability
- Cross references
- Version consistency
- Architectural ownership
- Standards compliance
- Governance compliance

---

## 13.2 Compliance Validation

Repository compliance shall be verified through formal validation activities.

Typical validation artifacts include:

- Repository Validation Report
- Architecture Validation Report
- Enterprise Consistency Validation Report
- Traceability Validation Report

---

## 13.3 Non-Compliance

Repository artifacts shall be considered non-compliant when they:

- violate approved repository structure,
- duplicate authoritative information,
- omit mandatory metadata,
- violate enterprise standards,
- break traceability,
- bypass governance,
- introduce unauthorized structural changes.

Non-compliant artifacts shall be corrected or removed through the approved governance process.

---

# 14. Repository Quality Metrics

Repository quality shall be continuously monitored using measurable architectural indicators.

| Quality Metric | Objective |
|---------------|-----------|
| Structural Consistency | Single canonical organization |
| Artifact Discoverability | Predictable artifact location |
| Metadata Completeness | Mandatory metadata compliance |
| Naming Consistency | Enterprise naming compliance |
| Cross-Reference Integrity | No broken references |
| Traceability Coverage | Complete end-to-end lineage |
| Governance Compliance | Full governance adherence |
| Repository Maintainability | Sustainable long-term evolution |
| Baseline Integrity | Stable approved baselines |
| Architectural Consistency | Alignment with enterprise architecture |

These metrics support continuous architectural improvement and provide objective evidence during repository audits and architecture reviews.

---

# 15. Baseline Management

The Phoenix repository is governed through formally established architectural baselines.

A baseline represents a stable, reviewed, validated, and approved snapshot of the enterprise repository at a specific point in the architecture lifecycle.

Baselines provide controlled reference points for future architectural evolution while preserving historical consistency.

---

## 15.1 Baseline Objectives

Repository baselines shall:

- Preserve architectural integrity.
- Support controlled repository evolution.
- Enable repeatable architecture reviews.
- Provide stable references for implementation.
- Support governance audits.
- Protect enterprise traceability.

---

## 15.2 Baseline Establishment

A repository baseline may only be established after successful completion of:

- Architecture Review
- Repository Audit
- Enterprise Validation
- Traceability Validation
- Governance Approval

Upon approval, the baseline receives a unique enterprise identifier.

Example:

```text
EA-BL-2026-01
```

---

## 15.3 Baseline Modification

Approved baselines are immutable.

Changes to an established baseline shall occur through a new governed baseline rather than modification of an existing one.

Every new baseline shall:

- reference its predecessor,
- identify the architectural changes introduced,
- preserve complete traceability,
- receive formal governance approval.

---

# 16. Repository Certification

Repository certification confirms that the repository complies with the approved enterprise architecture.

Certification indicates that repository organization, governance, traceability, and architectural consistency satisfy all mandatory enterprise requirements.

Certification activities include verification of:

- Repository Structure
- Artifact Classification
- Metadata Compliance
- Naming Standards
- Repository Governance
- Architectural Traceability
- Cross-Reference Integrity
- Enterprise Validation
- Baseline Integrity

Repository certification shall be performed before establishing an official enterprise baseline.

---

# 17. Traceability

This document participates in the Phoenix Enterprise Traceability Model.

## Upstream Artifacts

- PlatformArchitectureVision.md
- ArchitecturalPrinciples.md
- EngineeringPrinciples.md
- GovernanceFramework.md
- ADR-022 — Repository Documentation Structure

## Downstream Artifacts

- Repository Validation Report
- Architecture Validation Report
- Enterprise Consistency Validation Report
- Traceability Validation Report
- Architecture Review Reports
- Repository Audit Reports
- All repository capabilities and governed artifacts

---

# 18. Related Artifacts

## Vision

- ProjectOverview.md
- PlatformArchitectureVision.md
- KnowledgeDrivenArchitecture.md

## Principles

- ArchitecturalPrinciples.md
- EngineeringPrinciples.md

## Governance

- GovernanceFramework.md
- DependencyRules.md
- RepositoryLifecycle.md
- ArchitectureReviewProcess.md

## Architecture Decisions

- ADR-000 — Architecture Governance
- ADR-003 — Documentation Standards
- ADR-022 — Repository Documentation Structure

## Standards

- STD-001 — Documentation Standard
- STD-002 — Repository Structure Standard
- STD-003 — Naming Convention Standard

## Validation

- RepositoryValidationReport.md
- ArchitectureValidationReport.md
- EnterpriseConsistencyValidationReport.md
- TraceabilityValidationReport.md

---

# 19. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-07 | Initial repository structure specification. |
| 2.0 | 2026-07-08 | Repository baseline declared frozen. |
| 2026.3 | 2026-07-21 | Complete enterprise rewrite aligned with the Platform Architecture Vision, Architectural Principles, Engineering Principles, Governance Framework, ADR-022 (Repository Documentation Structure), Capability-Centric Repository Architecture, Enterprise Validation Framework, and Enterprise Traceability Model. |