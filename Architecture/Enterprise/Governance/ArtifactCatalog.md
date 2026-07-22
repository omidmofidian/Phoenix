# Artifact Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-006 |
| Document | ArtifactCatalog |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Architecture Governance |
| Architecture Layer | Governance |
| Owner | Phoenix Architecture Board |
| Governed By | ADR-003 — Documentation Standards, ADR-022 — Repository Documentation Structure |
| Depends On | RepositoryStructure.md, GovernanceFramework.md, ArchitecturalPrinciples.md, EngineeringPrinciples.md |
| Used By | All Enterprise Architecture, Knowledge, Data, Design, Software, Platform, Operations and Project Artifacts |
| Last Updated | 2026-07-21 |

---

# 1. Purpose

This document defines the Enterprise Artifact Management Framework for the Phoenix Platform.

It establishes the authoritative governance model for identifying, classifying, registering, managing, validating, and tracing every governed artifact maintained throughout the enterprise repository.

Rather than serving as a simple inventory of documents, this catalog defines the enterprise rules governing the complete lifecycle of repository artifacts.

Its primary objective is to ensure that every artifact can be uniquely identified, consistently governed, fully traceable, and properly integrated into the enterprise architecture.

---

# 2. Scope

This document applies to every governed artifact maintained within the Phoenix Platform repository.

Governed artifacts include, but are not limited to:

- Architecture documents
- Governance documents
- Architecture Decision Records (ADR)
- Enterprise standards
- Business knowledge
- Domain models
- Data models
- Enterprise dictionaries
- Catalogs
- Matrices
- Validation reports
- Engineering specifications
- Operational documentation
- Project governance artifacts

This document governs both manually maintained and automatically generated artifacts where applicable.

Repository artifacts that are temporary, experimental, or personal working materials are outside the scope of this document unless promoted into the governed repository.

---

# 3. Architecture Context

The Artifact Catalog forms one of the core governance components of the Phoenix Enterprise Architecture.

It complements the repository governance defined by GOV-005 (Repository Structure) by governing the artifacts contained within the repository rather than the repository organization itself.

Repository Structure defines **where** artifacts belong.

Artifact Catalog defines **what** artifacts are, **how** they are identified, and **how** they are governed.

Together these documents establish a complete enterprise repository governance model.

The Artifact Catalog implements governance established by:

- Platform Architecture Vision
- Governance Framework
- Architectural Principles
- Engineering Principles
- ADR-003 — Documentation Standards
- ADR-022 — Repository Documentation Structure

It also supports enterprise validation, repository auditing, architectural traceability, and long-term lifecycle management.

---

# 4. Enterprise Artifact Model

Within the Phoenix Platform, an artifact is defined as any governed repository asset that contributes to business knowledge, enterprise architecture, engineering, implementation, operations, or project governance.

An enterprise artifact is characterized by the following properties:

- Unique identity
- Clearly defined purpose
- Architectural ownership
- Explicit classification
- Controlled lifecycle
- Repository location
- Metadata compliance
- Traceability
- Governance
- Version history

Artifacts are considered first-class architectural assets.

They shall therefore be managed with the same level of governance applied to enterprise architecture, software, and data.

Artifacts shall never exist without governance, ownership, and architectural context.

---

# 5. Enterprise Artifact Taxonomy

The Phoenix Platform classifies repository artifacts according to their architectural responsibility rather than their implementation format.

Artifact taxonomy establishes a common enterprise language for governance, validation, traceability, lifecycle management, and repository organization.

Each governed artifact shall belong to one and only one primary artifact family.

The taxonomy defined by this document is authoritative throughout the enterprise repository.

---

## 5.1 Governance Artifacts

Governance artifacts define policies, governance models, lifecycle rules, repository organization, and architectural control mechanisms.

Examples include:

- Governance Framework
- Repository Structure
- Artifact Catalog
- Dependency Rules
- Repository Lifecycle
- Architecture Review Process

Primary identifier prefix:

**GOV**

---

## 5.2 Architecture Artifacts

Architecture artifacts define the strategic architecture of the enterprise.

Examples include:

- Architecture Vision
- Reference Architecture
- Canonical Domain Model
- Service Architecture
- Architecture Principles
- Engineering Principles

Primary identifier prefix:

**ART**

---

## 5.3 Architecture Decision Records

Architecture Decision Records document significant architectural decisions governing the enterprise.

Each ADR records:

- Context
- Decision
- Rationale
- Consequences
- Related artifacts

Primary identifier prefix:

**ADR**

---

## 5.4 Standards

Standards define mandatory engineering, architectural, documentation, and implementation practices.

Examples include:

- Documentation Standard
- Repository Standard
- Naming Convention Standard
- Database Standards
- Coding Standards

Primary identifier prefix:

**STD**

---

## 5.5 Knowledge Artifacts

Knowledge artifacts capture enterprise business knowledge independent of implementation technologies.

Examples include:

- Business Glossary
- Business Concepts
- Business Rules
- Domain Responsibilities
- Financial Knowledge
- Research
- Regulatory Knowledge

Primary identifier prefix:

**KNW**

---

## 5.6 Models

Models represent structured architectural views of enterprise information and business domains.

Examples include:

- Conceptual Models
- Logical Models
- Physical Models
- Domain Models
- Service Models

Primary identifier prefixes include:

- MOD
- ERD

---

## 5.7 Catalogs

Catalogs provide authoritative inventories of enterprise architectural assets.

Examples include:

- Aggregate Catalog
- Attribute Catalog
- Entity Catalog
- Relationship Catalog
- Service Catalog

Primary identifier prefix:

**CAT**

---

## 5.8 Dictionaries

Dictionaries provide authoritative semantic definitions.

Examples include:

- Entity Dictionary
- Attribute Dictionary
- Relationship Dictionary
- Enterprise Data Dictionary

Primary identifier prefix:

**DCT**

---

## 5.9 Matrices

Matrices describe enterprise relationships, responsibilities, dependencies, and mappings.

Examples include:

- Traceability Matrix
- Dependency Matrix
- Responsibility Matrix
- Relationship Matrix
- Constraint Matrix

Primary identifier prefix:

**MAT**

---

## 5.10 Validation Artifacts

Validation artifacts formally verify architectural integrity and governance compliance.

Examples include:

- Architecture Validation Report
- Repository Validation Report
- Knowledge Validation Report
- Domain Validation Report
- Traceability Validation Report

Primary identifier prefix:

**VAL**

---

## 5.11 Operational Artifacts

Operational artifacts support production operation and platform maintenance.

Examples include:

- Runbooks
- Deployment Guides
- Monitoring Procedures
- Recovery Procedures
- Operational Checklists

Primary identifier prefixes:

- OPS
- RB

---

# 6. Artifact Identification Strategy

Every governed artifact shall possess a unique and permanent enterprise identifier.

Artifact identifiers provide stable references throughout the repository lifecycle and shall remain unchanged even if an artifact is relocated within the repository.

Artifact identifiers support:

- Repository governance
- Architectural traceability
- Cross-referencing
- Repository validation
- Impact analysis
- Configuration management

---

## 6.1 Artifact Identifier Structure

Artifact identifiers follow the enterprise convention:

```text
<PREFIX>-<NUMBER>
```

Example identifiers include:

```text
ADR-022
STD-003
GOV-006
VAL-007
CAT-004
MAT-003
DCT-002
KNW-015
```

The identifier represents the architectural identity of the artifact and shall never encode repository location or implementation technology.

---

## 6.2 Identifier Requirements

Every artifact identifier shall satisfy the following requirements.

### AI-001 — Uniqueness

Each identifier shall be globally unique within the Phoenix repository.

Duplicate identifiers are prohibited.

---

### AI-002 — Permanence

Artifact identifiers shall remain stable throughout the artifact lifecycle.

Repository relocation shall not require identifier modification.

---

### AI-003 — Human Readability

Identifiers shall be concise, predictable, and easily referenced within documentation.

---

### AI-004 — Traceability

Artifact identifiers shall support end-to-end architectural traceability.

Every governed artifact shall be referenceable by its identifier.

---

### AI-005 — Version Independence

Artifact identifiers identify the artifact itself rather than a particular version.

Version information shall be managed independently through artifact metadata.

---

### AI-006 — Architectural Governance

Artifact identifiers shall be assigned according to the approved enterprise governance process.

Identifier reuse is permanently prohibited.

---

# 7. Artifact Metadata Standard

Every governed artifact shall include standardized metadata.

Metadata enables automated repository validation, architectural traceability, governance, lifecycle management, and impact analysis.

The metadata defined by this document is mandatory for all governed documentation artifacts.

Mandatory metadata includes:

- Project
- Artifact ID
- Document
- Version
- Status
- Classification
- Architecture Layer
- Owner
- Governed By
- Depends On
- Used By
- Last Updated

Additional metadata may be introduced through approved enterprise standards provided that mandatory fields remain unchanged.

---

# 8. Artifact Lifecycle

Every governed artifact shall progress through a controlled lifecycle governed by the Phoenix Enterprise Architecture Governance Framework.

The artifact lifecycle ensures that repository content evolves in a predictable, auditable, and traceable manner while preserving architectural integrity.

Lifecycle transitions shall occur only through approved governance activities.

---

## 8.1 Lifecycle States

The standard artifact lifecycle is illustrated below.

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

Each lifecycle state defines the governance responsibilities, permitted modifications, and architectural significance of the artifact.

---

## 8.2 Draft

Draft artifacts are under active development.

Characteristics include:

- Work in progress
- Subject to significant modification
- Not yet approved
- Not considered authoritative

Draft artifacts shall not be referenced as normative architectural sources.

---

## 8.3 Review

Review artifacts are undergoing formal evaluation.

Typical review activities include:

- Technical review
- Architecture review
- Consistency validation
- Traceability verification
- Standards compliance review

Only reviewers designated by the appropriate governance authority may approve transition beyond this stage.

---

## 8.4 Approved

Approved artifacts become authoritative references.

An approved artifact:

- Represents the accepted architectural position.
- May be referenced by other governed artifacts.
- Participates in enterprise traceability.
- Is eligible for inclusion in an architectural baseline.

---

## 8.5 Baseline

Baseline artifacts form part of an officially released enterprise architecture baseline.

Baselines provide stable architectural reference points for implementation, governance, validation, and future architectural evolution.

Each baseline shall possess a unique Baseline Identifier.

---

## 8.6 Frozen

Frozen artifacts shall remain immutable.

Any modification requires:

- Formal architecture review
- Version increment
- Updated validation
- Governance approval

Direct modification of frozen artifacts is prohibited.

---

## 8.7 Superseded

Superseded artifacts have been replaced by newer authoritative versions.

They remain available to preserve:

- Historical context
- Architectural lineage
- Traceability
- Auditability

Superseded artifacts shall clearly identify their successor.

---

## 8.8 Archived

Archived artifacts are retained solely for historical, regulatory, legal, or audit purposes.

Archived artifacts:

- Shall not participate in active development.
- Shall not be modified.
- Shall remain available for historical reference.

---

# 9. Artifact Relationships

Enterprise artifacts do not exist in isolation.

They participate in a governed network of semantic and architectural relationships that collectively form the Phoenix Enterprise Knowledge Graph.

Artifact relationships support:

- Architectural traceability
- Dependency analysis
- Impact assessment
- Repository validation
- Governance
- Change management

---

## 9.1 Relationship Types

The following relationship types are approved.

| Relationship | Description |
|--------------|-------------|
| Depends On | Requires another artifact as an upstream dependency |
| Governed By | Controlled by a governance artifact or ADR |
| References | Cites another artifact without dependency |
| Implements | Realizes architectural guidance |
| Validates | Verifies another artifact |
| Produces | Creates downstream artifacts |
| Consumes | Uses information from another artifact |
| Supersedes | Replaces an earlier artifact |
| Superseded By | Indicates the successor artifact |
| Related To | Defines a non-hierarchical association |

---

## 9.2 Relationship Rules

Artifact relationships shall comply with the following rules.

### AR-001 — Explicit Relationships

Significant relationships shall be explicitly documented.

Implicit architectural dependencies should be avoided.

---

### AR-002 — No Circular Governance

Governance artifacts shall not create circular governance dependencies.

Architectural authority shall always flow in a single direction.

---

### AR-003 — Traceable Relationships

Relationships shall support complete end-to-end enterprise traceability.

Every governed dependency shall be discoverable through repository analysis.

---

### AR-004 — Stable References

Artifact relationships shall reference Artifact IDs rather than repository paths whenever practical.

This preserves traceability even when repository organization evolves.

---

### AR-005 — Version Awareness

Relationship definitions shall always reference the current approved artifact unless historical traceability requires otherwise.

---

# 10. Artifact Ownership

Every governed artifact shall have clearly defined ownership.

Ownership establishes accountability for:

- Technical correctness
- Architectural consistency
- Lifecycle management
- Governance compliance
- Repository maintenance

Ownership remains associated with the artifact throughout its lifecycle unless formally reassigned.

---

## 10.1 Ownership Responsibilities

Artifact owners are responsible for:

- Maintaining artifact accuracy.
- Preserving architectural consistency.
- Ensuring metadata completeness.
- Managing lifecycle transitions.
- Participating in architecture reviews.
- Responding to governance findings.
- Maintaining downstream compatibility.

---

## 10.2 Ownership Principles

Artifact ownership shall follow these principles.

### AO-001 — Single Accountable Owner

Every governed artifact shall identify one primary owner.

Shared responsibility does not replace accountable ownership.

---

### AO-002 — Organizational Ownership

Ownership shall normally be assigned to an architectural role, governance body, or organizational function rather than an individual contributor.

---

### AO-003 — Lifecycle Accountability

Ownership continues throughout the complete artifact lifecycle, including maintenance, supersession, and archival.

---

### AO-004 — Governance Responsibility

Artifact owners are responsible for ensuring continued compliance with enterprise governance, standards, and repository policies.

---

# 11. Artifact Registration Rules

Every governed artifact shall be formally registered before becoming part of the approved enterprise repository.

Artifact registration establishes the artifact's identity, ownership, governance status, and participation within the enterprise traceability model.

Registration shall occur only once during the lifetime of an artifact.

Subsequent changes shall update the registered metadata without creating duplicate registrations.

---

## 11.1 Registration Objectives

Artifact registration ensures that:

- every artifact possesses a unique enterprise identity;
- ownership is explicitly established;
- architectural purpose is documented;
- repository placement complies with approved standards;
- lifecycle status is governed;
- traceability is preserved throughout the artifact lifecycle.

---

## 11.2 Registration Requirements

Every governed artifact shall include, at minimum:

- Unique Artifact Identifier
- Document Name
- Repository Capability
- Repository Location
- Artifact Classification
- Architecture Layer
- Version
- Lifecycle Status
- Responsible Owner
- Governing Standards
- Upstream Dependencies
- Downstream Consumers
- Last Updated

Additional metadata may be introduced by future enterprise standards without modifying the mandatory registration model.

---

## 11.3 Registration Rules

### RG-001 — Unique Registration

Each governed artifact shall have exactly one official registration.

Duplicate registrations are prohibited.

---

### RG-002 — Stable Identity

Artifact registration shall remain valid throughout the entire artifact lifecycle.

Repository relocation shall not require re-registration.

---

### RG-003 — Metadata Synchronization

Registered metadata shall accurately reflect the current approved state of the artifact.

Repository validation shall verify metadata consistency.

---

### RG-004 — Repository Compliance

Registration shall comply with the Repository Structure defined by GOV-005.

Artifacts located outside approved repository capabilities shall not be registered.

---

### RG-005 — Traceability

Registration shall establish participation in the enterprise traceability model.

Every registered artifact shall be reachable through repository traceability analysis.

---

# 12. Artifact Governance

Artifact governance defines the policies controlling the creation, modification, review, approval, publication, and retirement of enterprise artifacts.

Governance ensures that repository evolution remains consistent with the approved enterprise architecture.

---

## 12.1 Governance Objectives

Artifact governance aims to:

- preserve architectural integrity;
- maintain repository consistency;
- ensure standards compliance;
- support controlled architectural evolution;
- prevent unauthorized repository modifications;
- protect approved enterprise baselines.

---

## 12.2 Governance Responsibilities

Governance responsibilities include:

- Artifact creation approval
- Architecture review
- Standards compliance verification
- Lifecycle management
- Repository audit support
- Baseline protection
- Traceability maintenance

These responsibilities are exercised by the appropriate governance authorities defined within the Phoenix Governance Framework.

---

## 12.3 Governance Rules

### AG-001 — Architecture Review

Significant architectural artifacts shall undergo formal Architecture Review before approval.

---

### AG-002 — Standards Compliance

Governed artifacts shall comply with all approved enterprise standards.

---

### AG-003 — Baseline Protection

Artifacts included within an approved enterprise baseline shall not be modified without following the approved governance process.

---

### AG-004 — Repository Consistency

Artifact evolution shall preserve repository consistency and architectural integrity.

---

### AG-005 — Controlled Change

Changes affecting architectural semantics, governance, repository organization, or enterprise standards shall be governed through the Architecture Decision Record (ADR) process where applicable.

---

## 12.4 Governance Authorities

Artifact governance is distributed across the enterprise according to organizational responsibilities.

Typical governance authorities include:

| Authority | Responsibility |
|-----------|----------------|
| Phoenix Architecture Board | Enterprise architecture governance |
| Domain Owners | Business and domain artifacts |
| Engineering Leadership | Engineering standards |
| Data Architecture Team | Enterprise data artifacts |
| Platform Team | Platform architecture |
| Project Governance | Project management artifacts |

Governance authority shall always be explicitly identifiable.

---

# 13. Artifact Validation

Validation confirms that governed artifacts comply with enterprise architecture, governance policies, repository standards, and traceability requirements.

Validation forms an integral part of the enterprise governance lifecycle.

---

## 13.1 Validation Objectives

Artifact validation aims to verify:

- architectural correctness;
- repository compliance;
- metadata completeness;
- lifecycle consistency;
- traceability;
- standards compliance;
- governance integrity.

---

## 13.2 Validation Activities

Typical validation activities include:

- Metadata Validation
- Repository Validation
- Naming Validation
- Dependency Validation
- Cross-Reference Validation
- Standards Validation
- Traceability Validation
- Architectural Consistency Validation

Validation activities may be performed manually, automatically, or through a combination of both approaches.

---

## 13.3 Validation Rules

### AV-001 — Metadata Completeness

Mandatory metadata shall be complete before an artifact may be approved.

---

### AV-002 — Repository Compliance

Artifacts shall reside within approved repository capabilities.

---

### AV-003 — Standards Compliance

Artifacts shall comply with all governing enterprise standards.

---

### AV-004 — Traceability Verification

Every governed artifact shall participate in the enterprise traceability model.

---

### AV-005 — Architectural Consistency

Artifact content shall remain consistent with approved architectural principles, governance policies, and Architecture Decision Records.

---

## 13.4 Validation Outputs

Successful validation may produce one or more formal validation artifacts, including:

- Architecture Validation Reports
- Repository Validation Reports
- Traceability Validation Reports
- Enterprise Consistency Validation Reports
- Compliance Assessment Reports

Validation results provide objective evidence supporting architectural governance, repository certification, and enterprise baseline establishment.

---

# 14. Artifact Traceability

Every governed artifact shall participate in the Phoenix Enterprise Traceability Model.

Traceability ensures that enterprise knowledge, architectural decisions, engineering standards, implementation artifacts, and operational documentation remain logically connected throughout the repository lifecycle.

The objective of artifact traceability is to eliminate orphan artifacts, preserve architectural lineage, and support impact analysis during enterprise evolution.

---

## 14.1 Traceability Objectives

Artifact traceability shall ensure that:

- every governed artifact has an identifiable architectural purpose;
- upstream dependencies are explicitly documented;
- downstream consumers are identifiable;
- architectural decisions remain traceable;
- enterprise knowledge flows consistently across repository capabilities;
- repository evolution remains fully auditable.

---

## 14.2 Traceability Model

Artifact traceability follows the enterprise architecture lifecycle.

```text
Business Vision
        │
        ▼
Enterprise Knowledge
        │
        ▼
Architecture
        │
        ▼
Governance
        │
        ▼
Data Architecture
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

Every governed artifact participates within one or more segments of this traceability chain.

---

## 14.3 Traceability Requirements

### AT-001 — Upstream Traceability

Every governed artifact shall identify its upstream architectural dependencies where applicable.

---

### AT-002 — Downstream Traceability

Artifacts that govern other repository assets shall identify their downstream consumers whenever practical.

---

### AT-003 — Decision Traceability

Architectural artifacts shall identify the Architecture Decision Records (ADR) governing their existence.

---

### AT-004 — Standards Traceability

Artifacts shall reference the enterprise standards that define their required structure, content, or behavior.

---

### AT-005 — Validation Traceability

Validation reports shall reference the artifacts they verify.

---

### AT-006 — Repository Traceability

Repository capabilities shall maintain consistent traceability across architectural boundaries.

---

# 15. Artifact Quality Model

Enterprise artifacts are architectural assets and shall therefore satisfy measurable quality requirements.

Artifact quality supports maintainability, governance, discoverability, and long-term architectural sustainability.

---

## 15.1 Quality Objectives

Every governed artifact shall strive to achieve the following quality objectives:

- Completeness
- Correctness
- Consistency
- Traceability
- Maintainability
- Readability
- Reusability
- Discoverability
- Version Integrity
- Governance Compliance

---

## 15.2 Quality Assessment

Artifact quality shall be evaluated during architecture reviews, repository audits, and validation activities.

Typical evaluation criteria include:

| Quality Attribute | Objective |
|-------------------|-----------|
| Completeness | Required information is present |
| Correctness | Content is technically accurate |
| Consistency | Alignment with enterprise architecture |
| Traceability | Complete upstream and downstream references |
| Maintainability | Sustainable long-term evolution |
| Discoverability | Predictable repository location |
| Metadata Quality | Mandatory metadata is complete |
| Governance Compliance | Conforms to approved governance |
| Standards Compliance | Conforms to enterprise standards |
| Version Integrity | Proper lifecycle and version management |

Artifact quality assessments provide objective evidence supporting enterprise governance and repository certification.

---

# 16. Repository Integration

The Artifact Catalog integrates with every major governance component of the Phoenix Platform.

It provides the common management model through which repository artifacts are identified, governed, validated, and traced.

Repository integration includes:

- Repository Structure
- Governance Framework
- Architecture Principles
- Engineering Principles
- Documentation Standards
- Repository Standards
- Enterprise Validation
- Enterprise Traceability
- Architecture Decision Records

Collectively, these artifacts establish a unified governance ecosystem for the Phoenix Platform.

---

# 17. Related Artifacts

## Vision

- PlatformArchitectureVision.md
- ProjectOverview.md

## Principles

- ArchitecturalPrinciples.md
- EngineeringPrinciples.md

## Governance

- GovernanceFramework.md
- RepositoryStructure.md
- DependencyRules.md
- RepositoryLifecycle.md

## Architecture Decisions

- ADR-003 — Documentation Standards
- ADR-022 — Repository Documentation Structure

## Standards

- STD-001 — Documentation Standard
- STD-002 — Repository Structure Standard
- STD-003 — Naming Convention Standard

## Validation

- ArchitectureValidationReport.md
- RepositoryValidationReport.md
- EnterpriseConsistencyValidationReport.md
- TraceabilityValidationReport.md

---

# 18. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-08 | Initial Artifact Catalog. |
| 2026.2 | 2026-07-21 | Complete enterprise rewrite aligned with the Platform Architecture Vision, Governance Framework, Architectural Principles, Engineering Principles, ADR-003 (Documentation Standards), ADR-022 (Repository Documentation Structure), Enterprise Traceability Model, Enterprise Validation Framework, and Capability-Centric Repository Architecture. |