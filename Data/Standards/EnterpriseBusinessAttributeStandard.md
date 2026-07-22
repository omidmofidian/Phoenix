# Enterprise Business Attribute Standard

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-008 |
| Document | EnterpriseBusinessAttributeStandard |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/EnterpriseBusinessAttributeStandard.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the canonical architecture for business attributes within the Phoenix Platform.

Its purpose is to establish a consistent, reusable, and technology-independent framework for defining, classifying, governing, and reusing business attributes across the enterprise.

Business attributes are considered enterprise information assets.

Their definitions shall originate from business semantics rather than implementation requirements, ensuring that every attribute maintains a single meaning throughout the platform.

This standard governs business attribute architecture only.

Naming conventions, data types, identity management, audit metadata, and physical implementation are governed by dedicated enterprise standards.

---

# 2. Scope

This standard applies to all business attributes defined within the Enterprise Data capability.

Its scope includes:

- Business Concepts
- Domain Models
- Aggregate Roots
- Member Entities
- Value Objects
- Logical Data Models
- Enterprise Data Dictionary
- Business Metadata
- Attribute Catalogs
- Information Architecture

This standard applies equally to reusable enterprise attributes and domain-specific business attributes.

The following topics are explicitly outside the scope of this document:

- Physical database implementation
- SQL data types
- Table structures
- Database constraints
- Index design
- Storage optimization
- ORM implementation
- Programming language constructs

These concerns are governed by other Enterprise Data Standards.

---

# 3. Objectives

The Enterprise Business Attribute Standard has the following objectives:

- establish a canonical business attribute architecture;
- ensure semantic consistency across all business domains;
- define a single authoritative meaning for every business attribute;
- promote enterprise-wide attribute reuse;
- reduce duplication across logical models;
- improve consistency within the Enterprise Data Dictionary;
- support long-term maintainability and governance;
- preserve complete traceability between business architecture and enterprise data models.

---

# 4. Business Attribute Philosophy

Within the Phoenix Platform, business attributes are treated as enterprise information assets rather than implementation artifacts.

Business attributes shall always be derived from approved business architecture.

The modeling sequence is therefore:

```text
Business Capability
        │
        ▼
Business Domain
        │
        ▼
Aggregate
        │
        ▼
Entity
        │
        ▼
Business Attribute
        │
        ▼
Logical Data Model
        │
        ▼
Physical Database Model
```

Business attributes shall never drive business architecture.

Instead, they describe business concepts that have already been identified and approved.

This principle ensures that enterprise architecture remains the authoritative source of business semantics.

---

# 5. Position within Enterprise Data Architecture

The Enterprise Business Attribute Standard occupies a central position within the Enterprise Data Architecture.

```text
Enterprise Architecture
            │
            ▼
Enterprise Data Dictionary
            │
            ▼
Enterprise Business Attributes
            │
            ▼
Logical Data Model
            │
            ▼
Physical Database Model
            │
            ▼
Database Implementation
```

Business attributes provide the semantic bridge between business concepts and implementation-ready data models.

Every attribute shall therefore remain traceable to its originating business concept and shall preserve its meaning throughout the entire engineering lifecycle.

---

# 6. Enterprise Attribute Architecture

Business attributes are organized according to a canonical enterprise architecture that separates business semantics from implementation concerns.

Every attribute shall belong to one business context, have one authoritative definition, and fulfill one clearly defined business responsibility.

This architecture provides a stable foundation for logical modeling, enterprise data governance, and long-term reuse.

---

# 7. Enterprise Attribute Principles

The following principles govern all business attributes within the Phoenix Platform.

## Principle 1 — Business First

Business attributes shall originate from approved business concepts rather than database implementation.

---

## Principle 2 — Single Meaning

Each business attribute shall have exactly one canonical business definition.

Multiple meanings for the same attribute are prohibited.

---

## Principle 3 — Single Ownership

Each attribute shall have one authoritative owner within the enterprise.

Ownership belongs to the Aggregate responsible for the business concept represented by the attribute.

---

## Principle 4 — Enterprise Reuse

Reusable attributes shall be defined once and reused consistently throughout the platform.

Redefinition of existing business attributes is prohibited.

---

## Principle 5 — Technology Independence

Business attributes shall describe business semantics only.

Implementation technologies, programming languages, databases, and storage mechanisms shall not influence attribute definitions.

---

## Principle 6 — Long-Term Stability

Attribute definitions shall remain stable over time.

Changes affecting attribute meaning require architectural review and impact analysis.

---

# 8. Attribute Ownership

Every business attribute shall belong to exactly one Aggregate.

The owning Aggregate is responsible for:

- business meaning;
- lifecycle definition;
- validation rules;
- documentation;
- future evolution.

Other Aggregates may reference the attribute where appropriate, but ownership shall never be duplicated.

---

# 9. Attribute Classification Framework

Each business attribute shall belong to one primary classification category.

The classification framework standardizes attribute semantics across all enterprise domains.

| Category | Purpose |
|----------|---------|
| Identity | Enterprise identification |
| Naming | Human-readable identification |
| Business | Core business information |
| Classification | Business categorization |
| Reference | Relationships between Aggregates |
| Lifecycle | Business state management |
| Temporal | Business validity and time |
| Derived | Calculated business information |
| External | External business identifiers |

Each attribute shall have one primary classification even if it participates in multiple business processes.

---

# 10. Business Attribute Categories

## Identity Attributes

Identity attributes uniquely identify business objects from a business perspective.

Examples include:

- Business Identifier
- Registration Number
- Symbol Code
- Listing Identifier

Enterprise identity implementation is governed by the **Identifier Strategy (DST-005)**.

---

## Naming Attributes

Naming attributes provide meaningful business names for enterprise concepts.

Typical examples include:

- Name
- Short Name
- Display Name
- Full Name
- Official Name

Naming conventions are governed by the **Enterprise Naming Standard (DST-001)**.

---

## Business Attributes

Business attributes represent the fundamental information required to describe enterprise business concepts.

Examples include:

- Listing Date
- Registration Number
- Trading Status
- Market Capitalization Category
- Company Type

These attributes form the core business semantics of the Enterprise Data Model.

---

## Classification Attributes

Classification attributes assign business concepts to enterprise taxonomies.

Examples include:

- Exchange
- Market
- Board
- Industry
- Sector
- Instrument Type

These attributes support enterprise reporting, analytics, and business navigation.

---

## Reference Attributes

Reference attributes establish semantic relationships between Aggregate Roots.

They express business relationships rather than physical foreign keys.

Logical reference definitions precede database implementation.

---

## Lifecycle Attributes

Lifecycle attributes represent the operational state of business entities.

Examples include:

- Active Status
- Effective Period
- Business State
- Approval Status

These attributes describe business behavior rather than system behavior.

---

## Temporal Attributes

Temporal attributes describe business time.

Typical examples include:

- Business Date
- Trading Date
- Effective From
- Effective To
- Valid Until

Temporal semantics remain independent of physical timestamp implementation.

---

## Derived Attributes

Derived attributes are calculated from existing enterprise information.

They shall:

- have documented derivation rules;
- remain reproducible;
- never replace canonical business attributes.

---

## External Attributes

External attributes identify business concepts within external organizations or information providers.

Typical examples include:

- Exchange Code
- Provider Identifier
- Vendor Symbol
- External Classification Code

External attributes supplement enterprise business information but shall never replace canonical enterprise definitions.

---

# 11. Attribute Reuse

Enterprise business attributes are reusable information assets.

Reusable attributes shall be defined once within the Enterprise Data Dictionary and referenced consistently throughout all logical models.

Attribute reuse promotes:

- semantic consistency;
- reduced duplication;
- simplified maintenance;
- improved interoperability between business domains;
- enterprise-wide information standardization.

Business attributes with identical meaning shall never be defined multiple times under different names.

---

# 12. Attribute Lifecycle

Business attributes evolve throughout a controlled lifecycle.

```text
Identification
        │
        ▼
Business Definition
        │
        ▼
Classification
        │
        ▼
Approval
        │
        ▼
Enterprise Registration
        │
        ▼
Reuse
        │
        ▼
Revision (if required)
        │
        ▼
Retirement (optional)
```

Each lifecycle transition shall be governed by the Enterprise Architecture Governance process.

Attribute retirement shall preserve historical traceability.

---

# 13. Relationship with Enterprise Standards

This standard defines the business architecture of enterprise attributes.

It complements, but does not replace, other Enterprise Data Standards.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Attribute naming conventions |
| DST-002 — Enterprise Data Type Standard | Logical and physical data types |
| DST-003 — Base Entity Standard | Common infrastructure attributes |
| DST-004 — Audit Model Standard | Audit metadata |
| DST-005 — Identifier Strategy | Enterprise identity management |
| DST-006 — Enterprise Data Dictionary Standard | Canonical business definitions |
| DST-007 — Enterprise Database Design Standard | Database engineering framework |
| DST-008 — Enterprise Business Attribute Standard | Business attribute architecture |

Together, these standards establish the complete Enterprise Data Standards framework of the Phoenix Platform.

---

# 14. Repository Integration

This standard is maintained within the Enterprise Data capability.

```text
Data/
└── Standards/
    └── EnterpriseBusinessAttributeStandard.md
```

Its primary consumers include:

- Data/Dictionary
- Data/Models
- Data/Database
- Architecture
- Database Engineering

Business attribute definitions shall remain synchronized with the Enterprise Data Dictionary and all logical data models.

---

# 15. Compliance

Compliance with this standard is mandatory.

Enterprise Architecture Reviews shall verify that:

- every business attribute has one canonical definition;
- ownership is clearly identified;
- classification is correctly assigned;
- attribute reuse is maximized;
- semantic duplication does not exist;
- logical models remain aligned with enterprise business architecture.

Any exception shall:

- include documented justification;
- undergo architectural impact assessment;
- receive formal approval through the Enterprise Architecture Governance process.

---

# 16. Architectural Decisions

The Enterprise Business Attribute Architecture is governed by the following decisions.

## Canonical Semantics

Every business attribute shall represent one and only one business meaning.

---

## Enterprise Ownership

Every attribute shall have one authoritative owner.

Ownership shall not be shared between Aggregates.

---

## Business Independence

Business attributes describe enterprise information rather than implementation mechanisms.

Implementation technologies shall never influence attribute semantics.

---

## Long-Term Stability

Business attributes constitute enterprise knowledge assets.

Changes affecting business meaning require enterprise-level architectural review.

---

# 17. Future Evolution

The Enterprise Business Attribute Standard has been designed to support future expansion of the Phoenix Platform.

Future standards may extend this architecture with guidance for:

- calculated business metrics;
- financial indicator attributes;
- machine learning feature metadata;
- semantic data lineage;
- metadata quality assessment;
- enterprise reference data governance;
- cross-market attribute harmonization.

Future enhancements shall extend the attribute architecture while preserving the canonical business semantics established by this standard.

---

# 18. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Enterprise Attribute Standard. |
| 2026.2 | 2026-07-09 | Expanded information architecture. |
| 2026.3 | 2026-07-22 | Complete redesign as the Enterprise Business Attribute Standard. Aligned with the Enterprise Data capability, eliminated overlap with other Enterprise Data Standards, introduced enterprise attribute architecture, repository integration, governance framework, and business-oriented attribute lifecycle. |

---

# 19. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative enterprise architecture governing business attributes across all business domains.

All conceptual models, logical data models, enterprise data dictionaries, and future information models shall comply with this standard unless an approved architectural exception has been granted.

This standard shall remain the canonical reference for enterprise business attribute architecture until superseded by a formally approved revision.

---

# End of Document