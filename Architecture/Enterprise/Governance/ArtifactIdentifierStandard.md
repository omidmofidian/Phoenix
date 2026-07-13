# Artifact Identifier Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-001 |
| Version | 1.0 |
| Status | Approved |
| Classification | Enterprise Standard |
| Owner | Architecture Team |
| Last Updated | 2026-07-08 |

---

# 1. Purpose

This standard defines the enterprise-wide identification scheme for all artifacts within the Phoenix Platform.

Every artifact shall have a unique identifier that remains stable throughout its lifecycle.

Artifact identifiers provide:

- Unambiguous identification
- Repository traceability
- Governance support
- Version tracking
- Cross-referencing
- Impact analysis

Artifact IDs are immutable.

---

# 2. Scope

This standard applies to every artifact stored within the Phoenix repository, including:

- Documents
- Architecture Models
- Design Models
- Standards
- ADRs
- Database Specifications
- Data Dictionaries
- Knowledge Documents
- SQL Specifications
- Diagrams
- Runbooks
- Checklists
- Templates

---

# 3. Artifact ID Structure

Artifact IDs follow the format:

```text
<PREFIX>-<NUMBER>
```

Example:

```text
ARC-001
STD-015
ADR-003
FMK-007
```

Rules:

- Prefix shall be uppercase.
- Number shall contain three digits.
- IDs are immutable.
- IDs shall never be reused.

---

# 4. Artifact Prefix Registry

## Governance

| Prefix | Description |
|---------|-------------|
| GOV | Governance Documents |

---

## Vision

| Prefix | Description |
|---------|-------------|
| VIS | Vision Documents |

---

## Architecture

| Prefix | Description |
|---------|-------------|
| ARC | General Architecture |
| ADR | Architecture Decision Record |
| DOM | Domain Model |
| AGG | Aggregate Design |
| SRV | Service Architecture |

---

## Design

| Prefix | Description |
|---------|-------------|
| DSN | General Design |
| CMD | Conceptual Model |
| LDM | Logical Data Model |
| PDM | Physical Data Model |
| DBD | Database Design |
| ERD | Entity Relationship Diagram |
| SQL | SQL Design Specification |
| DIC | Data Dictionary |

---

## Standards

| Prefix | Description |
|---------|-------------|
| STD | Enterprise Standard |

---

## Knowledge

| Prefix | Description |
|---------|-------------|
| FMK | Financial Market Knowledge |
| TRD | Trading Knowledge |
| ANL | Analytics Knowledge |
| AIK | Artificial Intelligence |
| REG | Regulations |
| RSH | Research |
| REF | Reference Material |

---

## Project Management

| Prefix | Description |
|---------|-------------|
| PRJ | Project Documentation |
| SPR | Sprint Documentation |
| TSK | Task Definition |

---

## Operations

| Prefix | Description |
|---------|-------------|
| OPS | Operational Documentation |
| RUN | Runbook |
| MON | Monitoring |

---

# 5. Numbering Rules

Numbering begins with:

```text
001
```

Example:

```text
ARC-001
ARC-002
ARC-003
```

Numbers are sequential.

Deleted artifacts never free their identifiers.

Reserved identifiers shall remain unused until assigned.

---

# 6. Identifier Lifecycle

An Artifact ID is assigned when the artifact is first created.

The identifier never changes.

Changes to:

- File Name
- Repository Location
- Version
- Status

shall NOT modify the Artifact ID.

---

# 7. File Naming

Artifact ID is metadata.

It shall NOT appear in the filename.

Correct:

```text
RepositoryStructure.md
```

Not recommended:

```text
GOV-005_RepositoryStructure.md
```

File names shall remain business-oriented and readable.

---

# 8. Version Independence

Artifact Version and Artifact ID are independent.

Example:

| Artifact ID | Version |
|-------------|---------|
| GOV-005 | 1.0 |
| GOV-005 | 2.0 |
| GOV-005 | 3.0 |

The identifier remains constant.

---

# 9. Artifact Status

Each artifact shall have one lifecycle status.

Allowed values:

- Draft
- Review
- Approved
- Frozen
- Deprecated
- Archived

Status changes do not affect the identifier.

---

# 10. Cross References

Artifacts shall reference other artifacts using:

- Artifact ID
- Artifact Name

Example:

```text
Related Artifacts

GOV-005 RepositoryStructure

STD-001 ArtifactIdentifierStandard

ARC-003 CanonicalDomainModel
```

---

# 11. Governance Rules

Artifact IDs:

- shall be unique;
- shall never be reused;
- shall never be renumbered;
- shall remain immutable;
- shall be registered in ArtifactCatalog.md before publication.

---

# 12. Compliance

Every repository artifact shall comply with this standard.

Artifacts without identifiers are non-compliant.

Duplicate identifiers are prohibited.

---

# 13. Related Documents

- RepositoryStructure.md
- ArtifactCatalog.md
- DocumentationStandard.md
- NamingConventionStandard.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-08 | Initial enterprise artifact identifier standard. |