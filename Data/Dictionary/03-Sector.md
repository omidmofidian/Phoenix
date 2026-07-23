# Sector Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-011 |
| Document | SectorDataDictionary |
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

This document defines the canonical business meaning of the **Sector** entity within the Phoenix Platform.

The Sector Data Dictionary serves as the authoritative semantic reference for understanding the role, responsibilities, lifecycle, and business relationships of economic sectors.

It provides a technology-independent business definition that is shared across all architectural layers.

---

# 2. Scope

This document applies to the **Sector** business entity within the **Reference Domain**.

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

These implementation concerns are documented in the Logical and Physical Database Models.

---

# 3. Business Context

A Sector represents the highest level of the enterprise economic classification hierarchy.

It groups related industries that participate in similar areas of economic activity and provides a stable framework for organizing companies, financial instruments, market analytics, reporting, and regulatory classification.

The Sector classification establishes the foundation upon which the enterprise business taxonomy is constructed.

---

# 4. Business Definition

## Canonical Name

**Sector**

---

## Business Description

A Sector is a high-level economic classification that groups industries sharing common business activities and economic characteristics.

Within the Phoenix Platform, a Sector acts as a stable reference entity used to organize enterprise business information consistently across multiple markets and services.

A Sector represents a business concept rather than a market participant or financial instrument.

---

## Business Purpose

The Sector exists to:

- organize industries into broad economic categories;
- provide a consistent enterprise classification hierarchy;
- support business reporting;
- enable analytical grouping;
- facilitate regulatory classification;
- improve cross-market comparability.

---

## Business Responsibilities

The Sector is responsible for:

- defining top-level business classifications;
- grouping related industries;
- supporting enterprise reporting;
- enabling portfolio categorization;
- providing analytical dimensions;
- preserving historical classification consistency.

---

## Aggregate Membership

| Property | Value |
|----------|-------|
| Domain | Reference Domain |
| Aggregate | Market Reference |
| Aggregate Root | Sector |
| Entity Type | Aggregate Root |
| Lifecycle Dependency | Independent |

Sector is an Aggregate Root within the Market Reference Aggregate and owns the lifecycle of its associated Industry entities.

---

# 5. Business Identity

The Sector follows the enterprise identity model defined by the **Enterprise Identity Standard**.

## Canonical Identity

Every Sector possesses one immutable enterprise identifier.

Characteristics:

- globally unique;
- immutable;
- technology independent;
- enterprise managed;
- never carries business meaning.

The canonical identifier remains unchanged throughout the entire lifecycle of the Sector.

---

## Business Identity

A Sector possesses a business identity representing its recognized economic classification.

Typical business identifiers may include:

- enterprise sector code;
- official classification code;
- internationally recognized classification code (where applicable).

Business identifiers are governed by enterprise data governance and remain stable over time.

---

## External Identity

External providers may classify sectors differently.

Therefore, a Sector may maintain one or more external identifiers originating from:

- stock exchanges;
- market data providers;
- regulatory organizations;
- financial information vendors.

External identifiers do not replace the canonical enterprise identity.

---

# 6. Lifecycle

The Sector lifecycle is intentionally stable because economic classifications rarely change.

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

## Lifecycle Principles

- Every Sector begins as a proposed business classification.
- Approval is governed by enterprise architecture and business governance.
- Active Sectors may be referenced by many Industries.
- Deprecation shall preserve historical traceability.
- Retired Sectors shall remain available for historical reporting.

Physical deletion of business information is prohibited.

---

# 7. Business Relationships

| Related Entity | Relationship | Business Meaning |
|----------------|-------------|------------------|
| Industry | Owns | A Sector groups one or more Industries. |
| Company | Indirect Classification | Companies inherit Sector classification through their Industry. |
| Instrument | Indirect Classification | Financial Instruments inherit Sector classification through their Company. |
| Market Analytics | Classification Dimension | Sector provides an analytical grouping for reporting and analysis. |

The complete relationship semantics are defined in the **Relationship Dictionary**.

---

# 8. Business Rules

The following business rules govern the Sector entity throughout the Phoenix Platform.

## Classification Rules

- Every Industry shall belong to exactly one Sector.
- A Sector may classify zero, one, or many Industries.
- Sector classifications shall remain consistent across all enterprise domains.
- Sector definitions shall be business-oriented and independent of implementation technologies.

---

## Identity Rules

- Every Sector shall possess exactly one canonical enterprise identifier.
- Every Sector shall have one approved business identifier.
- External provider identifiers are optional.
- Canonical identifiers shall never change.
- Business identifiers may only change through formal governance approval.

---

## Lifecycle Rules

- Sector classifications are expected to be long-lived.
- Historical classifications shall remain available for audit and reporting purposes.
- Retired Sectors shall never be physically removed when referenced by historical business records.
- Deprecation shall preserve backward compatibility.

---

## Integrity Rules

- Duplicate Sector definitions are prohibited.
- Business meaning shall be unique across all enterprise classifications.
- Sector names shall remain unambiguous.
- Every Sector shall be uniquely identifiable within the enterprise taxonomy.

---

## Governance Rules

Creation of a new Sector requires:

- business justification;
- architecture review;
- enterprise governance approval;
- update of the Entity Dictionary;
- update of the Attribute Dictionary where applicable;
- update of the Relationship Dictionary if new relationships are introduced.

---

# 9. Ownership

| Responsibility | Owner |
|---------------|-------|
| Business Definition | Reference Domain |
| Business Governance | Architecture Team |
| Enterprise Classification | Reference Domain |
| Identity Management | Enterprise Identity Standard |
| Relationship Governance | Relationship Dictionary |
| Attribute Definitions | Attribute Dictionary |

The Reference Domain is the authoritative owner of the Sector business concept.

No other domain may redefine its business meaning.

---

# 10. Traceability

The Sector entity is traceable to the following enterprise artifacts.

| Artifact | Purpose |
|----------|---------|
| Business Glossary | Defines the business terminology. |
| Entity Dictionary | Defines the enterprise business entity. |
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

The Sector entity is governed under the Enterprise Data Governance framework of the Phoenix Platform.

All modifications to the business definition of Sector shall follow the Architecture Governance process.

The following changes require formal approval:

- introduction of a new business classification;
- modification of business meaning;
- changes to lifecycle semantics;
- changes affecting aggregate boundaries;
- changes to enterprise identity;
- changes impacting enterprise taxonomy.

All approved changes shall be reflected consistently in every dependent enterprise artifact.

---

# 12. Related Documents

The Sector Data Dictionary is supported by the following enterprise documents:

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
| 2026.2 | 2026-07-23 | Complete redesign based on Enterprise Data Dictionary architecture. Converted from a physical table description to a technology-independent semantic business dictionary aligned with the Enterprise Identity Standard, Attribute Dictionary, Relationship Dictionary, and Single Source of Truth (SSOT) principles. |

---

# Architecture Alignment

The redesigned **Sector Data Dictionary** fully complies with the enterprise architecture adopted by the Phoenix Platform.

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

The **Sector** entity is a stable enterprise reference entity whose primary responsibility is to establish the highest level of economic classification within the Phoenix Platform.

Its semantic definition is independent of:

- database technology;
- programming language;
- service implementation;
- integration mechanisms;
- deployment architecture.

This separation ensures that the Sector business concept remains stable while implementation technologies evolve.

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

These concerns are now maintained by their respective authoritative artifacts in accordance with the Single Source of Truth (SSOT) architecture.

The Sector Data Dictionary is now exclusively responsible for documenting the **business semantics** of the Sector entity.

---