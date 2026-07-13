# Documentation Structure

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | GOV-012 |
| Document | DocumentationStructure |
| Version | 2026.1 |
| Status | Approved |
| Classification | Architecture Governance |
| Owner | Architecture Team |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the official documentation structure of the Phoenix Platform.

It establishes the canonical organization of all project documentation and ensures consistency, discoverability, maintainability, and architectural governance.

No document shall be created outside this approved structure without formal architectural approval.

---

# 2. Documentation Principles

The documentation repository follows these principles:

- Architecture First
- Documentation as Code
- Domain-Driven Design (DDD)
- Single Source of Truth
- Separation of Concerns
- Version Controlled Documentation
- Stable Documentation Structure

---

# 3. Documentation Repository

```text
Phoenix/
└── Docs/
    ├── Architecture/
    ├── Design/
    ├── RunBooks/
    ├── Deployment/
    └── Project/
```

Each top-level folder has a distinct responsibility.

---

# 4. Architecture

Architecture documents describe **why** the platform is designed as it is.

```text
Architecture/
├── ADR/
├── DomainModel/
├── Governance/
├── Services/
└── Vision/
```

## ADR

Architecture Decision Records.

Examples:

- ADR-001
- ADR-020
- ADR-021

---

## DomainModel

Canonical business architecture.

Examples:

- CanonicalDomainModel
- CanonicalBusinessRules
- AggregateDefinitions
- CanonicalAggregateCatalog
- ConceptualRelationships

---

## Governance

Architecture governance and project baselines.

Examples:

- Sprint1Overview
- Sprint2Overview
- Sprint3Plan
- Sprint3Backlog
- Sprint1ArchitectureReview
- Sprint2ArchitectureReview
- Epic1DataStandardsFreeze
- Epic2EnterpriseDataDictionaryFreeze
- DocumentationStructure

---

## Services

Service-oriented architecture.

Examples:

- CanonicalServiceCatalog
- ServiceContextMap

---

## Vision

Long-term architectural direction.

Examples:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- QualityAttributes

---

# 5. Design

Design documents describe **how** the architecture is implemented.

```text
Design/
├── DataDictionary/
├── Standards/
├── Database/
├── LogicalModel/
├── PhysicalModel/
├── ERD/
└── SQL/
```

---

## DataDictionary

Enterprise business metadata.

Examples:

- BusinessGlossary
- EntityDictionary
- AttributeDictionary
- RelationshipDictionary

---

## Standards

Enterprise design standards.

Examples:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- BaseEntityStandard
- AuditModelStandard
- IdentifierStrategy
- EnterpriseDataDictionaryStandard
- LogicalModelDocumentTemplate

---

## Database

Database design artifacts.

Examples:

- ConceptualModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- DataDictionary

---

## LogicalModel

Domain-specific logical models.

```text
LogicalModel/
├── Reference/
├── Market/
├── Portfolio/
├── Analytics/
├── MachineLearning/
├── Configuration/
└── Integration/
```

Each domain may contain:

- DomainLogicalModel
- EntityDefinitions
- Relationships
- Validation
- ERD

---

## PhysicalModel

Physical database implementation documents.

Examples:

- Table Specifications
- Constraints
- Storage Design

---

## ERD

Entity Relationship Diagrams.

Examples:

- ReferenceERD
- MarketERD
- PortfolioERD
- CanonicalLogicalERD

---

## SQL

SQL implementation.

Examples:

- DDL
- Views
- Functions
- Migration Scripts

---

# 6. RunBooks

Operational procedures.

Examples:

- Environment Setup
- Backup
- Restore
- Deployment Verification

---

# 7. Deployment

Deployment documentation.

Examples:

- Docker
- PostgreSQL Bootstrap
- Infrastructure Configuration

---

# 8. Project

Project management documentation.

Examples:

- ProjectOverview
- Roadmap
- Release Notes
- Milestones

---

# 9. Documentation Rules

The following rules apply to all documentation.

- Every document shall have a unique purpose.
- Every document shall belong to exactly one folder.
- Duplicate documents are prohibited.
- Cross-references shall be used instead of duplicated content.
- Documents shall remain technology-independent whenever possible.
- All documents shall include revision history.

---

# 10. Governance

The documentation structure defined herein is frozen.

Changes require:

- Architecture review
- Impact analysis
- Approval by the Architecture Team

No ad hoc folders or parallel documentation structures may be introduced.

---

# 11. Related Documents

- ProjectOverview.md
- PlatformArchitectureVision.md
- Sprint3Plan.md
- Sprint3Backlog.md
- LogicalModelDocumentTemplate.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial documentation structure baseline. |