# Enterprise Attribute Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-003 |
| Document | EnterpriseAttributeCatalog |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Metadata Catalog |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Dictionary/AttributeCatalog.md |
| Depends On | DST-009 Enterprise Attribute Standard, DST-006 Enterprise Data Dictionary Standard |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The Enterprise Attribute Catalog is the authoritative registry of all reusable business attributes defined within the Phoenix Platform.

Its primary purpose is to provide a centralized inventory of enterprise attributes before they are assigned to individual business entities.

The catalog establishes attribute ownership, classification, and reuse policies while ensuring that every attribute has a single canonical registration within the enterprise information architecture.

Detailed semantic definitions are maintained separately within the Enterprise Attribute Dictionary.

---

# 2. Scope

The Enterprise Attribute Catalog includes:

- Canonical enterprise attributes
- Attribute classification
- Attribute ownership
- Enterprise reuse status
- Canonical attribute names
- Attribute governance metadata
- Cross-reference information

The catalog intentionally excludes detailed business definitions, validation rules, implementation details, and physical database specifications.

Those concerns are documented within the Enterprise Attribute Dictionary.

---

# 3. Objectives

The Enterprise Attribute Catalog has the following objectives:

- establish a single enterprise registry for reusable attributes;
- eliminate duplicate attribute definitions;
- promote enterprise-wide attribute reuse;
- simplify logical modeling activities;
- improve consistency across business domains;
- support metadata governance;
- provide traceability to enterprise standards.

---

# 4. Architectural Position

The Enterprise Attribute Catalog forms part of the Enterprise Metadata Architecture.

```text
Enterprise Architecture
        │
        ▼
Enterprise Data Dictionary
        │
        ├── Entity Dictionary
        ├── Attribute Catalog
        ├── Attribute Dictionary
        └── Relationship Dictionary
        │
        ▼
Logical Data Model
        │
        ▼
Physical Database Model
```

The catalog provides the registration layer for enterprise attributes, while the Attribute Dictionary provides their complete business definitions.

---

# 5. Enterprise Attribute Lifecycle

Every enterprise attribute shall progress through a governed lifecycle.

```text
Proposed
      │
      ▼
Reviewed
      │
      ▼
Approved
      │
      ▼
Registered
      │
      ▼
Reusable
      │
      ▼
Deprecated (optional)
      │
      ▼
Retired
```

Only attributes in the **Registered** or **Reusable** states may be referenced by Logical Data Models.

---

# 6. Catalog Entry Structure

Each catalog entry represents a registered enterprise attribute.

Every entry shall include the following metadata.

| Property | Description |
|----------|-------------|
| Canonical Name | Official enterprise attribute name |
| Category | Enterprise attribute classification |
| Owner Domain | Responsible business domain |
| Owning Aggregate | Aggregate responsible for governance |
| Reusable | Enterprise reuse status |
| Mandatory | Default usage recommendation |
| Standard Reference | Governing enterprise standard |
| Dictionary Reference | Link to detailed Attribute Dictionary entry |

The catalog intentionally contains only summary metadata.

Complete attribute specifications are maintained within the Enterprise Attribute Dictionary.

---

# 7. Enterprise Attribute Categories

All registered attributes shall belong to exactly one enterprise category.

| Category | Purpose |
|----------|---------|
| Identity | Canonical enterprise identifiers |
| Naming | Business names and codes |
| Business | Business-specific information |
| Classification | Business categorization |
| Reference | Aggregate references |
| Lifecycle | Business state management |
| Temporal | Business validity and time |
| Audit | Audit metadata |
| Derived | Calculated information |
| External | External system mappings |

This classification shall remain consistent across all business domains.

---

# 8. Catalog Organization

The Enterprise Attribute Catalog is organized by attribute category rather than by business entity.

The recommended organization is:

- Identity Attributes
- Naming Attributes
- Business Attributes
- Classification Attributes
- Reference Attributes
- Lifecycle Attributes
- Temporal Attributes
- Audit Attributes
- Derived Attributes
- External Attributes

This organization maximizes discoverability and enterprise-wide reuse.

---

# 9. Registration Rules

An attribute shall be registered only when:

- its business meaning is unique;
- no equivalent canonical attribute already exists;
- ownership has been assigned;
- classification has been approved;
- naming complies with the Enterprise Naming Standard;
- architectural review has been completed.

Existing registered attributes shall always be reused before introducing new attributes.

---

# 10. Relationship with the Attribute Dictionary

The Enterprise Attribute Catalog and the Enterprise Attribute Dictionary serve complementary purposes.

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Attribute Catalog | Enterprise registry of attributes |
| Enterprise Attribute Dictionary | Complete business definition of each attribute |

The catalog answers:

> *"Which enterprise attributes exist?"*

The Attribute Dictionary answers:

> *"What does each attribute mean and how shall it be used?"*

The two artifacts shall remain fully synchronized throughout the lifecycle of the platform.

---

# 11. Governance

The Enterprise Attribute Catalog is governed under the Phoenix Architecture Governance Framework.

The following governance principles apply:

- every registered attribute shall have a single owner;
- duplicate registrations are prohibited;
- enterprise attributes shall be reviewed before approval;
- retired attributes shall remain documented for historical traceability;
- changes shall preserve backward compatibility whenever practical;
- deprecated attributes shall reference their approved replacements.

The catalog represents the official enterprise registry of reusable business attributes.

---

# 12. Repository Integration

The Enterprise Attribute Catalog is maintained within the Enterprise Data capability.

```text
Data/
└── Dictionary/
    ├── AttributeCatalog.md
    ├── AttributeDictionary.md
    ├── EntityDictionary.md
    └── RelationshipDictionary.md
```

Its primary consumers include:

- Enterprise Architecture
- Information Architecture
- Logical Data Models
- Physical Database Models
- Database Design
- API Design
- Service Contracts
- Analytics
- Reporting
- Future Artificial Intelligence capabilities

The catalog provides a stable metadata foundation for all information-related artifacts.

---

# 13. Relationship with Enterprise Standards

The Enterprise Attribute Catalog shall comply with the Enterprise Data Standards framework.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Canonical attribute naming |
| DST-002 — Enterprise Data Type Standard | Logical data type governance |
| DST-003 — Base Entity Standard | Common enterprise attributes |
| DST-004 — Audit Model Standard | Audit metadata |
| DST-005 — Identifier Strategy | Identity governance |
| DST-006 — Enterprise Data Dictionary Standard | Enterprise metadata governance |
| DST-008 — Enterprise Identity Standard | Identity architecture |
| DST-009 — Enterprise Attribute Standard | Enterprise attribute architecture |

The catalog is the implementation of the registration process defined by these standards.

---

# 14. Compliance

Compliance with this document is mandatory.

Every reusable enterprise attribute shall:

- be registered within this catalog;
- comply with the Enterprise Attribute Standard;
- have an approved business owner;
- belong to exactly one attribute category;
- reference its corresponding Attribute Dictionary definition.

Attributes that are not registered shall not be reused across multiple business domains without formal architectural approval.

---

# 15. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Enterprise Attribute Catalog. |
| 2026.2 | 2026-07-22 | Complete redesign as an Enterprise Attribute Registry. Clarified responsibilities, separated registry concerns from detailed attribute definitions, introduced governance model, repository integration, enterprise lifecycle, traceability, and alignment with the Enterprise Data Standards framework. |

---

# 16. Approval

This document is an approved **Enterprise Metadata Catalog** of the Phoenix Platform.

It serves as the authoritative registry of reusable enterprise attributes and provides the registration layer of the Enterprise Data Dictionary.

Detailed attribute semantics, business rules, validation requirements, and implementation guidance are maintained exclusively within the **Enterprise Attribute Dictionary**.

This catalog remains the authoritative reference for enterprise attribute registration until superseded by a formally approved revision.

---

# End of Document