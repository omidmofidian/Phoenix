# Industry Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-012 |
| Document | IndustryDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Domain | Reference Domain |
| Aggregate | Market Reference |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, EnterpriseIdentityStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

This document defines the canonical business meaning of the **Industry** entity within the Phoenix Platform.

The Industry Data Dictionary serves as the authoritative semantic reference for understanding the role, responsibilities, lifecycle, and business relationships of industries within the enterprise classification hierarchy.

It provides a technology-independent business definition that is shared consistently across all architectural layers.

---

# 2. Scope

This document applies to the **Industry** business entity within the **Reference Domain**.

It defines:

- business meaning;
- business responsibilities;
- enterprise identity;
- lifecycle;
- business relationships;
- governance rules.

This document does not define:

- database tables;
- SQL implementation;
- physical columns;
- indexes;
- constraints;
- PostgreSQL data types.

Those implementation concerns are defined in the Logical and Physical Database Models.

---

# 3. Business Context

An Industry represents the second level of the enterprise economic classification hierarchy.

It groups companies that perform similar economic activities within a broader Sector and provides a stable business taxonomy used throughout the Phoenix Platform.

Industry classifications support portfolio analysis, market analytics, reporting, regulatory classification, and enterprise-wide business consistency.

---

# 4. Business Definition

## Canonical Name

**Industry**

---

## Business Description

An Industry is an enterprise business classification representing a group of companies engaged in similar commercial or economic activities.

Industries provide the detailed level of business classification beneath Sectors and serve as reusable reference data across all supported financial markets.

An Industry is a business concept rather than a market participant or tradable asset.

---

## Business Purpose

The Industry exists to:

- classify companies according to their primary business activities;
- organize enterprise business information;
- support financial analysis;
- enable sector-based reporting;
- improve investment research;
- provide a stable enterprise taxonomy.

---

## Business Responsibilities

The Industry is responsible for:

- maintaining detailed business classifications;
- grouping related companies;
- supporting enterprise analytics;
- enabling business reporting;
- preserving classification consistency;
- providing reusable enterprise reference data.

---

## Aggregate Membership

| Property | Value |
|----------|-------|
| Domain | Reference Domain |
| Aggregate | Market Reference |
| Aggregate Root | Industry |
| Entity Type | Aggregate Root |
| Lifecycle Dependency | Independent |

Industry is an Aggregate Root within the Market Reference Aggregate and governs the lifecycle of its business classification while maintaining an association with its parent Sector.

---

# 5. Enterprise Identity

The Industry entity follows the Enterprise Identity Standard adopted by the Phoenix Platform.

Three independent identity layers are recognized.

| Identity Layer | Purpose |
|----------------|---------|
| Canonical Identity | Permanent enterprise identity |
| Business Identity | Business-recognizable identifier |
| External Identity | Provider-specific identifiers |

---

## Canonical Identity

Every Industry shall possess exactly one immutable canonical identifier.

Characteristics:

- globally unique;
- immutable;
- technology independent;
- enterprise-wide;
- never reused.

The canonical identifier represents the enterprise identity of the Industry regardless of implementation technology.

---

## Business Identity

Every Industry shall have one approved business identifier.

Typical examples include:

- Industry Code
- Enterprise Industry Identifier
- Official Classification Code

Business identifiers shall remain stable and meaningful within the enterprise business taxonomy.

---

## External Identity

Industry classifications may be mapped to external providers.

Examples include:

- TSETMC Industry Code
- GICS Industry
- ICB Industry
- NAICS Classification
- ISIC Classification

External identifiers:

- are optional;
- are provider-specific;
- may change over time;
- never replace the canonical identity.

---

# 6. Business Relationships

The Industry participates in the following enterprise business relationships.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Sector | belongs to | N : 1 |
| Company | classifies | 1 : N |
| Market | referenced by | N : N |
| Instrument | indirectly classifies | 1 : N |

All relationships described herein are business relationships and remain independent of physical foreign-key implementation.

---

## Parent Relationship

An Industry shall belong to exactly one Sector.

The parent Sector provides the highest-level business classification for the Industry.

---

## Child Relationship

An Industry may classify zero, one, or many Companies.

Each Company shall belong to exactly one Industry at any point in time.

---

## Cross-Domain Relationships

The Industry entity may be referenced by:

- Market Domain;
- Analytics Domain;
- Portfolio Domain;
- Reporting Domain;
- Machine Learning Domain.

Such references do not transfer ownership of the Industry business definition.

---

# 7. Lifecycle

The lifecycle of an Industry is governed by enterprise reference data management.

```text
Proposed

↓

Reviewed

↓

Approved

↓

Active

↓

Deprecated

↓

Retired
```

Industries are expected to remain stable over long periods.

Historical classifications shall remain available for reporting, auditing, and analytical purposes.

Retired Industries shall remain part of the enterprise knowledge base and shall not be physically removed if referenced by historical business data.

---

# 8. Business Rules

The following business rules govern the Industry entity throughout the Phoenix Platform.

## Classification Rules

- Every Industry shall belong to exactly one Sector.
- Every Company shall belong to exactly one Industry.
- An Industry may classify zero, one, or many Companies.
- Industry classifications shall be consistent across all enterprise domains.
- Industry definitions shall remain independent of implementation technologies.

---

## Identity Rules

- Every Industry shall possess exactly one canonical enterprise identifier.
- Every Industry shall have one approved business identifier.
- External provider identifiers are optional.
- Canonical identifiers shall never change.
- Business identifiers may only change through formal governance approval.

---

## Lifecycle Rules

- Industry classifications are expected to be stable over long periods.
- Historical Industry classifications shall remain available for reporting and auditing.
- Retired Industries shall never be physically removed when referenced by historical business records.
- Deprecation shall preserve backward compatibility.

---

## Integrity Rules

- Duplicate Industry definitions are prohibited.
- Industry names shall be unique within the enterprise taxonomy.
- Business meaning shall remain unambiguous.
- Every Industry shall belong to one and only one Sector at any point in time.

---

## Governance Rules

Creation of a new Industry requires:

- documented business justification;
- enterprise architecture review;
- governance approval;
- update of the Entity Dictionary;
- update of the Attribute Dictionary where applicable;
- update of the Relationship Dictionary if new relationships are introduced.

---

# 9. Ownership

| Responsibility | Owner |
|---------------|-------|
| Business Definition | Reference Domain |
| Business Governance | Architecture Team |
| Classification Governance | Reference Domain |
| Enterprise Identity | Enterprise Identity Standard |
| Relationship Governance | Relationship Dictionary |
| Attribute Governance | Attribute Dictionary |

The Reference Domain is the authoritative owner of the Industry business concept.

No other domain may redefine the business meaning of an Industry.

---

# 10. Traceability

The Industry entity is traceable to the following enterprise artifacts.

| Artifact | Purpose |
|----------|---------|
| Business Glossary | Defines business terminology. |
| Entity Dictionary | Defines the Industry business entity. |
| Attribute Catalog | Registers reusable enterprise attributes. |
| Attribute Dictionary | Defines attribute semantics. |
| Relationship Dictionary | Defines business relationships. |
| Aggregate Catalog | Defines aggregate ownership. |
| Enterprise Identity Standard | Governs enterprise identity. |
| Logical Database Model | Defines logical representation. |
| Physical Database Model | Defines physical implementation. |
| Canonical Business Rules | Defines governing business rules. |

---

# 11. Governance

The Industry entity is governed under the Enterprise Data Governance framework of the Phoenix Platform.

All modifications to the business definition of Industry shall follow the Architecture Governance process.

The following changes require formal approval:

- creation of a new Industry classification;
- retirement of an existing Industry;
- modification of business meaning;
- changes to lifecycle semantics;
- changes affecting aggregate boundaries;
- changes to enterprise identity;
- changes impacting the enterprise classification hierarchy.

All approved changes shall be reflected consistently across every dependent enterprise artifact.

---

# 12. Related Documents

The Industry Data Dictionary is supported by the following enterprise documents.

### Enterprise Standards

- EnterpriseNamingStandard
- EnterpriseIdentityStandard
- EnterpriseAttributeStandard
- EnterpriseDataTypeStandard
- IdentifierStrategy
- EnterpriseDataDictionaryStandard

### Enterprise Dictionaries

- BusinessGlossary
- EntityDictionary
- AttributeCatalog
- AttributeDictionary
- RelationshipDictionary
- AggregateCatalog

### Architecture

- CanonicalDomainModel
- ReferenceDomainArchitecture
- LogicalDatabaseModel
- PhysicalDatabaseModel
- CanonicalBusinessRules

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial table-oriented data dictionary. |
| 2026.2 | 2026-07-23 | Complete redesign based on the Enterprise Data Dictionary architecture. Converted from a physical table description to a technology-independent semantic business dictionary aligned with the Enterprise Identity Standard, Attribute Dictionary, Relationship Dictionary, and Single Source of Truth (SSOT) principles. |

---

# Architecture Alignment

The redesigned **Industry Data Dictionary** fully complies with the enterprise architecture adopted by the Phoenix Platform.

The document follows the principles of:

- Domain-Driven Design (DDD)
- Single Source of Truth (SSOT)
- Enterprise Data Governance
- Technology Independence
- Canonical Business Modeling
- Separation of Semantic, Logical, and Physical Architecture

Business semantics defined in this document shall be considered authoritative for every architectural layer.

Implementation artifacts shall conform to these definitions and shall not redefine business meaning.

---

# Compliance

This document complies with the following enterprise standards:

| Standard | Compliance |
|----------|------------|
| Enterprise Naming Standard | ✔ Fully Compliant |
| Enterprise Identity Standard | ✔ Fully Compliant |
| Enterprise Attribute Standard | ✔ Fully Compliant |
| Enterprise Data Type Standard | ✔ Fully Compliant |
| Enterprise Data Dictionary Standard | ✔ Fully Compliant |
| Identifier Strategy | ✔ Fully Compliant |
| Logical Model Documentation Standard | ✔ Fully Compliant |

No implementation-specific details are intentionally included in this document.

---

# Notes

The **Industry** entity is a stable enterprise reference entity whose primary responsibility is to provide the second level of economic classification within the Phoenix Platform.

It establishes the business taxonomy between **Sector** and **Company** and serves as a reusable enterprise classification shared across all financial markets supported by the platform.

Its semantic definition is independent of:

- database technology;
- programming language;
- service implementation;
- integration mechanisms;
- deployment architecture.

The Physical Database Model, Entity Specifications, and DDL scripts are responsible for translating this semantic definition into implementation artifacts.

---

# Migration Notes

This version supersedes the original table-oriented data dictionary.

The following implementation-specific sections have been intentionally removed:

- Table Information
- Physical Columns
- SQL Data Types
- Primary Keys
- Foreign Keys
- Constraints
- Indexes
- Default Values
- Sample Records

These implementation concerns are now maintained by their respective authoritative artifacts in accordance with the Single Source of Truth (SSOT) architecture.

The Industry Data Dictionary is now exclusively responsible for documenting the **business semantics** of the Industry entity.

---

# Architecture Alignment

The redesigned **Industry Data Dictionary** fully complies with the enterprise architecture adopted by the Phoenix Platform.

The document follows the principles of:

- Domain-Driven Design (DDD)
- Single Source of Truth (SSOT)
- Enterprise Data Governance
- Technology Independence
- Canonical Business Modeling
- Separation of Semantic, Logical, and Physical Architecture

Business semantics defined in this document shall be considered authoritative for every architectural layer.

Implementation artifacts shall conform to these definitions and shall not redefine business meaning.

---

# Compliance

This document complies with the following enterprise standards:

| Standard | Compliance |
|----------|------------|
| Enterprise Naming Standard | ✔ Fully Compliant |
| Enterprise Identity Standard | ✔ Fully Compliant |
| Enterprise Attribute Standard | ✔ Fully Compliant |
| Enterprise Data Type Standard | ✔ Fully Compliant |
| Enterprise Data Dictionary Standard | ✔ Fully Compliant |
| Identifier Strategy | ✔ Fully Compliant |
| Logical Model Documentation Standard | ✔ Fully Compliant |

No implementation-specific details are intentionally included in this document.

---

# Notes

The **Industry** entity is a stable enterprise reference entity whose primary responsibility is to define the second level of the enterprise economic classification hierarchy.

It provides the semantic bridge between **Sector** and **Company**, enabling consistent classification of business activities across all financial markets supported by the Phoenix Platform.

Its semantic definition is independent of:

- database technology;
- programming language;
- service implementation;
- integration mechanisms;
- deployment architecture.

This separation guarantees that the business meaning of an Industry remains stable while implementation technologies evolve.

The Logical Database Model, Physical Database Model, Entity Specifications, and DDL scripts are responsible for translating this semantic definition into implementation artifacts.

---

# Migration Notes

This version supersedes the original table-oriented Industry Data Dictionary.

The following implementation-specific sections have been intentionally removed:

- Table Information
- Physical Columns
- SQL Data Types
- Primary Keys
- Foreign Keys
- Constraints
- Indexes
- Default Values
- Sample Records

These implementation concerns are now governed by their respective authoritative enterprise artifacts in accordance with the **Single Source of Truth (SSOT)** architecture.

The Industry Data Dictionary is now exclusively responsible for documenting the **canonical business semantics** of the **Industry** entity.

This redesign also aligns the document with the Phoenix enterprise documentation architecture, ensuring consistency with:

- Entity Dictionary
- Attribute Catalog
- Attribute Dictionary
- Relationship Dictionary
- Aggregate Catalog
- Canonical Business Rules
- Enterprise Identity Standard
- Enterprise Data Dictionary Standard
- Logical Database Model
- Physical Database Model

Consequently, the Industry entity now has a single authoritative semantic definition that can be reused consistently by all present and future domains, services, APIs, databases, analytics engines, and integration components without duplication or semantic divergence.

---