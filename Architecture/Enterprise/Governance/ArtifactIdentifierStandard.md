# Artifact Identifier Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-001 |
| Document | ArtifactIdentifierStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Standard |
| Architecture Layer | Standards |
| Owner | Phoenix Architecture Board |
| Depends On | PlatformArchitectureVision.md, GovernanceFramework.md, RepositoryStructure.md, ArtifactCatalog.md |
| Used By | All Enterprise Repository Artifacts |
| Last Updated | 2026-07-21 |

---

# 1. Purpose

This standard defines the enterprise-wide identification policy governing every artifact within the Phoenix Platform repository.

Artifact identifiers provide a stable, technology-independent mechanism for uniquely identifying architectural, engineering, design, implementation, operational, and knowledge assets throughout their entire lifecycle.

The identifier serves as the permanent identity of an artifact regardless of changes to its name, repository location, version, ownership, or lifecycle status.

This standard establishes the authoritative enterprise policy for artifact identification, namespace governance, repository traceability, and architectural consistency.

---

# 2. Objectives

The objectives of this standard are to:

- establish a single enterprise artifact identification policy;
- guarantee globally unique artifact identities;
- preserve identifier stability throughout the artifact lifecycle;
- support enterprise repository governance;
- enable complete architectural traceability;
- facilitate impact analysis and dependency management;
- simplify repository navigation;
- eliminate identifier ambiguity;
- support long-term repository evolution.

---

# 3. Scope

This standard applies to every governed artifact maintained within the Phoenix Platform repository.

The policy is independent of repository capability, technology, implementation language, storage format, or organizational ownership.

Governed artifacts include, but are not limited to:

- Architecture documents
- Governance documents
- Architecture Decision Records (ADR)
- Standards
- Business models
- Domain models
- Service models
- Data models
- Dictionaries
- Catalogs
- Matrices
- Validation reports
- Knowledge artifacts
- Research documents
- Technical specifications
- Database specifications
- SQL artifacts
- Diagrams
- Templates
- Checklists
- Runbooks
- Operational procedures
- Configuration specifications
- Repository governance artifacts

Future artifact families shall comply with this standard unless explicitly exempted through an approved Architecture Decision Record.

---

# 4. Enterprise Identifier Model

Artifact identification is founded upon five enterprise principles.

## EI-001 — Uniqueness

Every governed artifact shall possess one globally unique enterprise identifier.

No duplicate identifiers shall exist within the repository.

---

## EI-002 — Permanence

Artifact identifiers are permanent.

Identifiers shall never change once assigned.

---

## EI-003 — Technology Independence

Identifiers represent enterprise architectural identity rather than implementation details.

They shall remain independent of:

- programming language;
- repository technology;
- storage platform;
- deployment environment;
- file format.

---

## EI-004 — Repository Independence

Artifact identity is independent of repository organization.

Moving an artifact between repository capabilities shall not affect its identifier.

---

## EI-005 — Traceability

Every identifier shall participate in the enterprise traceability model.

Artifact identifiers constitute the primary mechanism for architectural cross-referencing, governance, validation, dependency analysis, and repository auditing.

---

# 5. Identifier Architecture

Enterprise artifact identification is based on a hierarchical identification architecture.

Each identifier consists of two logical components:

1. Artifact Namespace
2. Sequential Identifier

Together, these components uniquely identify every governed artifact within the Phoenix Platform.

The identifier architecture is intentionally simple, stable, and technology-independent to maximize readability, longevity, and interoperability.

---

## 5.1 Logical Structure

Every identifier follows the canonical format:

```text
<Namespace>-<Sequence>
```

where:

```text
Namespace
        │
        ▼
Artifact Family
        │
        ▼
Sequential Identifier
```

Example:

```text
ADR-003
STD-006
ARC-014
VAL-005
KNW-018
```

---

## 5.2 Architectural Principles

The identifier architecture follows the following principles.

### IA-001 — Simplicity

Identifiers shall be concise, human-readable, and easily recognizable.

---

### IA-002 — Stability

Identifier syntax shall remain stable across repository evolution.

---

### IA-003 — Extensibility

New artifact namespaces may be introduced without affecting existing identifiers.

---

### IA-004 — Independence

Identifier syntax shall remain independent from:

- repository folders;
- implementation technology;
- organizational structure;
- deployment environment.

---

### IA-005 — Scalability

The architecture shall support long-term repository growth without structural redesign.

---

# 6. Identifier Components

An enterprise artifact identifier consists of two mandatory components.

| Component | Description |
|-----------|-------------|
| Namespace | Identifies the governed artifact family |
| Sequence | Uniquely identifies the artifact within its namespace |

Both components are mandatory.

---

## 6.1 Namespace

The namespace identifies the architectural classification of an artifact.

Examples include:

```text
ADR
STD
ARC
GOV
VAL
KNW
MAT
```

Namespaces are architectural concepts rather than repository locations.

They shall remain stable even if repository organization changes.

---

## 6.2 Sequence Number

The sequence uniquely identifies an artifact within its namespace.

General format:

```text
001
002
003
...
999
```

Characteristics:

- numeric;
- zero-padded;
- sequential;
- immutable;
- unique within the namespace.

Sequence numbers carry no semantic meaning beyond uniqueness.

---

## 6.3 Identifier Examples

| Identifier | Meaning |
|------------|---------|
| ADR-003 | Third Architecture Decision Record |
| STD-001 | First Enterprise Standard |
| GOV-006 | Sixth Governance Artifact |
| ARC-012 | Twelfth Architecture Document |
| VAL-004 | Fourth Validation Report |

Identifiers describe identity only.

They shall never encode version numbers, repository paths, project phases, ownership, or implementation details.

---

# 7. Enterprise Artifact Namespace Taxonomy

Namespaces classify enterprise artifacts into well-defined architectural families.

The namespace taxonomy serves as the authoritative enterprise registry for artifact identification.

---

## 7.1 Governance

| Namespace | Artifact Family |
|-----------|-----------------|
| GOV | Governance |
| ADR | Architecture Decision Records |
| STD | Enterprise Standards |
| VAL | Validation Reports |

---

## 7.2 Enterprise Architecture

| Namespace | Artifact Family |
|-----------|-----------------|
| ARC | Architecture |
| VIS | Vision |
| DOM | Domain Architecture |
| SRV | Service Architecture |

---

## 7.3 Enterprise Design

| Namespace | Artifact Family |
|-----------|-----------------|
| CMD | Conceptual Models |
| LDM | Logical Models |
| PDM | Physical Models |
| DBD | Database Design |

---

## 7.4 Enterprise Knowledge

| Namespace | Artifact Family |
|-----------|-----------------|
| KNW | Knowledge Documents |
| REF | Reference Material |
| RSH | Research |
| REG | Regulations |

---

## 7.5 Enterprise Data Assets

| Namespace | Artifact Family |
|-----------|-----------------|
| DIC | Dictionaries |
| CAT | Catalogs |
| MAT | Matrices |

---

## 7.6 Enterprise Operations

| Namespace | Artifact Family |
|-----------|-----------------|
| OPS | Operational Documentation |
| RUN | Runbooks |
| CHK | Checklists |
| TMP | Templates |

The namespace registry may be expanded as new enterprise artifact families are introduced through approved governance processes.

---

# 8. Namespace Governance

Namespaces are enterprise-governed architectural assets.

They shall not be created, modified, renamed, or removed without formal architectural approval.

---

## 8.1 Governance Objectives

Namespace governance ensures:

- global uniqueness;
- architectural consistency;
- repository stability;
- long-term maintainability;
- enterprise-wide interoperability.

---

## 8.2 Governance Rules

### NG-001 — Namespace Uniqueness

Each namespace shall represent exactly one enterprise artifact family.

---

### NG-002 — Namespace Stability

Existing namespaces shall remain stable throughout repository evolution.

---

### NG-003 — Controlled Introduction

New namespaces shall only be introduced through approved repository governance and, where applicable, an Architecture Decision Record (ADR).

---

### NG-004 — No Semantic Overlap

Namespaces shall have clearly defined responsibilities.

Two namespaces shall not represent the same architectural concept.

---

### NG-005 — Central Registry

The Artifact Catalog shall maintain the authoritative registry of all approved namespaces and their associated artifact families.

---

# 9. Identifier Allocation Policy

Artifact identifiers shall be allocated through a controlled enterprise process to preserve uniqueness, consistency, and long-term repository integrity.

Identifier allocation establishes the permanent identity of an artifact before it becomes part of the governed repository.

Once assigned, an identifier shall never be reassigned, recycled, or modified.

---

## 9.1 Allocation Principles

Identifier allocation follows the following enterprise principles.

### AP-001 — One Artifact, One Identifier

Each governed artifact shall receive exactly one enterprise identifier.

---

### AP-002 — One-Time Allocation

Identifiers shall be assigned only once during the lifetime of an artifact.

---

### AP-003 — Immutable Identity

Allocated identifiers shall remain unchanged regardless of changes to:

- document title;
- repository location;
- ownership;
- implementation;
- lifecycle status;
- version.

---

### AP-004 — Namespace Isolation

Sequential numbers shall be unique only within their namespace.

Example:

```text
STD-001
ADR-001
ARC-001
```

are all valid identifiers.

---

### AP-005 — Central Registration

Allocated identifiers shall be recorded in the Enterprise Artifact Catalog before publication.

---

## 9.2 Allocation Rules

### AR-001 — Sequential Allocation

Identifiers shall be assigned sequentially within each namespace.

---

### AR-002 — No Reuse

Previously assigned identifiers shall never be reused, even after artifact retirement or archival.

---

### AR-003 — Reserved Numbers

Repository governance may reserve identifier ranges for future enterprise use.

Reserved identifiers shall remain unavailable until officially allocated.

---

### AR-004 — Gap Preservation

Unused or retired identifier numbers shall not be reassigned.

Maintaining numbering gaps is preferable to compromising historical traceability.

---

### AR-005 — Allocation Authority

Identifier allocation shall be performed only by the authorized repository governance process.

---

# 10. Identifier Lifecycle

Artifact identifiers remain valid throughout every phase of the artifact lifecycle.

Identifiers are independent of lifecycle state.

---

## 10.1 Lifecycle Model

```text
Allocated
      │
      ▼
Draft
      │
      ▼
Review
      │
      ▼
Approved
      │
      ▼
Published
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

Throughout every stage, the identifier remains unchanged.

---

## 10.2 Lifecycle Rules

### IL-001 — Permanent Identity

Lifecycle transitions shall never modify an artifact identifier.

---

### IL-002 — Version Independence

New artifact versions shall retain the same identifier.

Example:

| Artifact ID | Version |
|-------------|---------|
| GOV-005 | 1.0 |
| GOV-005 | 2.0 |
| GOV-005 | 2026.2 |

Only the version changes.

---

### IL-003 — Repository Independence

Repository relocation shall not require identifier modification.

---

### IL-004 — Ownership Independence

Changing the responsible owner shall not affect the identifier.

---

### IL-005 — Historical Preservation

Archived artifacts shall preserve their original identifiers indefinitely.

---

# 11. Identifier Governance

Artifact identifiers are governed enterprise assets.

Their creation, allocation, registration, and maintenance are controlled through the Phoenix Architecture Governance Framework.

---

## 11.1 Governance Objectives

Identifier governance aims to:

- preserve repository integrity;
- maintain identifier uniqueness;
- support enterprise traceability;
- prevent identifier conflicts;
- ensure long-term architectural consistency.

---

## 11.2 Governance Responsibilities

Identifier governance includes:

- namespace administration;
- identifier allocation;
- registry maintenance;
- duplicate prevention;
- repository auditing;
- standards compliance verification;
- lifecycle monitoring.

---

## 11.3 Governance Rules

### IG-001 — Unique Registration

Every allocated identifier shall appear exactly once within the Enterprise Artifact Catalog.

---

### IG-002 — Duplicate Prevention

Duplicate artifact identifiers are prohibited.

Repository validation shall detect identifier conflicts.

---

### IG-003 — Immutable Registry

Allocated identifiers shall not be edited or renumbered.

Corrections shall be made through governance records rather than identifier modification.

---

### IG-004 — Standards Compliance

Identifiers shall conform to this standard before artifacts are approved.

---

### IG-005 — Auditability

Identifier allocation and registration shall be auditable throughout the repository lifecycle.

---

## 11.4 Governance Authority

Responsibility for enterprise identifier governance is distributed across the approved governance structure.

Typical responsibilities include:

| Authority | Responsibility |
|-----------|----------------|
| Phoenix Architecture Board | Enterprise identifier policy |
| Repository Governance | Identifier allocation |
| Architecture Team | Standards compliance |
| Repository Validation | Identifier verification |
| Project Governance | Repository oversight |

Governance authority shall always be explicitly defined and documented.

---

# 12. Repository Integration

The Artifact Identifier Standard is an integral component of the Phoenix Enterprise Governance Framework.

It provides the common identification mechanism that enables every governed artifact to participate consistently in repository organization, architectural governance, traceability, validation, and lifecycle management.

Artifact identifiers are therefore considered foundational enterprise metadata rather than implementation-specific attributes.

---

## 12.1 Integration Objectives

Repository integration ensures that artifact identifiers:

- remain unique across the enterprise repository;
- support repository discoverability;
- enable architectural cross-referencing;
- facilitate governance automation;
- simplify dependency analysis;
- preserve long-term repository consistency.

---

## 12.2 Integrated Repository Components

Artifact identifiers are consumed by multiple enterprise governance capabilities.

| Repository Capability | Integration Purpose |
|-----------------------|---------------------|
| Artifact Catalog | Primary artifact registration |
| Repository Structure | Repository organization |
| Documentation Standards | Metadata consistency |
| Naming Convention Standard | Naming compliance |
| Repository Validation | Identifier verification |
| Architecture Governance | Enterprise oversight |
| Configuration Management | Artifact lifecycle management |
| Enterprise Traceability | Cross-artifact relationships |

Each integration point relies upon stable artifact identifiers rather than filenames or repository locations.

---

## 12.3 Repository Independence

Artifact identifiers remain independent of:

- repository folder hierarchy;
- repository restructuring;
- storage technology;
- document filenames;
- implementation language;
- deployment environment.

Consequently, repository evolution shall never require identifier modification.

---

# 13. Enterprise Traceability

Artifact identifiers constitute the primary reference mechanism for enterprise traceability.

Every governed artifact shall be traceable throughout the enterprise architecture lifecycle using its permanent identifier.

---

## 13.1 Traceability Objectives

Artifact identifiers enable:

- business traceability;
- architectural traceability;
- design traceability;
- implementation traceability;
- operational traceability;
- governance traceability;
- validation traceability.

---

## 13.2 Enterprise Traceability Chain

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
Design
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

Artifact identifiers provide the stable references connecting every stage of this architectural lineage.

---

## 13.3 Traceability Rules

### TR-001 — Identifier-Based References

Governed artifacts shall reference one another using artifact identifiers wherever practical.

---

### TR-002 — Stable References

Artifact references shall remain valid throughout repository evolution.

---

### TR-003 — Bidirectional Traceability

Where appropriate, upstream and downstream artifact relationships shall be identifiable through artifact identifiers.

---

### TR-004 — Decision Traceability

Architecture Decision Records shall reference governed artifacts using their official identifiers.

---

### TR-005 — Validation Traceability

Validation reports shall reference the identifiers of the artifacts they evaluate.

---

# 14. Validation

Compliance with this standard shall be verified through continuous repository validation activities.

Validation ensures that enterprise artifact identifiers remain unique, consistent, correctly registered, and fully traceable.

---

## 14.1 Validation Objectives

Validation activities verify:

- identifier uniqueness;
- namespace correctness;
- metadata consistency;
- registry completeness;
- traceability integrity;
- governance compliance.

---

## 14.2 Validation Rules

### IV-001 — Uniqueness Validation

No duplicate artifact identifiers shall exist within the repository.

---

### IV-002 — Registry Validation

Every governed artifact shall be registered in the Enterprise Artifact Catalog.

---

### IV-003 — Namespace Validation

Identifiers shall use approved namespaces only.

---

### IV-004 — Metadata Validation

Artifact metadata shall include the assigned artifact identifier.

---

### IV-005 — Traceability Validation

Identifier references shall resolve to existing governed artifacts.

---

## 14.3 Validation Activities

Compliance may be assessed through:

- Architecture Reviews;
- Repository Audits;
- Enterprise Validation Reports;
- Traceability Validation;
- Repository Certification;
- Governance Reviews.

Validation results provide objective evidence supporting repository integrity and enterprise governance.

---

# 15. Compliance

Compliance with this standard is mandatory for every governed artifact maintained within the Phoenix Platform repository.

Conformance ensures that artifact identification remains consistent, stable, auditable, and interoperable across all architectural, engineering, and operational capabilities.

Compliance with this standard shall be verified as part of the enterprise governance process.

---

## 15.1 Mandatory Requirements

Every governed artifact shall:

- possess exactly one enterprise artifact identifier;
- use an approved namespace;
- maintain a permanent identifier throughout its lifecycle;
- include the identifier within its metadata;
- be registered in the Enterprise Artifact Catalog;
- comply with the Repository Structure Standard;
- comply with the Documentation Standard;
- participate in the enterprise traceability model.

---

## 15.2 Non-Compliance

The following situations are considered repository non-compliance.

### NC-001 — Missing Identifier

A governed artifact exists without an assigned artifact identifier.

---

### NC-002 — Duplicate Identifier

Two or more artifacts share the same identifier.

---

### NC-003 — Invalid Namespace

An identifier uses an unapproved namespace.

---

### NC-004 — Identifier Modification

A previously assigned identifier has been altered, renumbered, or reused.

---

### NC-005 — Unregistered Artifact

A governed artifact has not been recorded in the Enterprise Artifact Catalog.

---

### NC-006 — Broken Traceability

Artifact references cannot be resolved through valid artifact identifiers.

---

Repository validation activities shall identify and report every non-compliant artifact before approval or publication.

---

# 16. Related Artifacts

## Vision

- PlatformArchitectureVision.md
- KnowledgeDrivenArchitecture.md
- ReferenceArchitecture.md

---

## Governance

- GovernanceFramework.md
- RepositoryStructure.md
- ArtifactCatalog.md

---

## Standards

- DocumentationStandard.md
- NamingConventionStandard.md
- RepositoryStructureStandard.md
- MetadataStandard.md

---

## Validation

- ArchitectureValidationReport.md
- EnterpriseConsistencyValidationReport.md
- TraceabilityValidationReport.md
- RepositoryValidationReport.md
- ArchitectureValidationDashboard.md

---

## Architecture Decision Records

- ADR-003 — Documentation Standards
- ADR-022 — Repository Documentation Structure
- ADR-023 — Enterprise Audit and Validation Strategy

---

# 17. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-08 | Initial artifact identifier standard. |
| 2026.2 | 2026-07-21 | Complete enterprise redesign aligned with the Platform Architecture Vision, Governance Framework, Repository Structure, Artifact Catalog, Documentation Standards, Enterprise Traceability Model, Validation Framework, and Capability-Centric Repository Architecture. |

---

# End of Document