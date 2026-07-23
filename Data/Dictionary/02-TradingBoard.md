# Trading Board Enterprise Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-102 |
| Document | TradingBoardDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Domain | Reference |
| Aggregate | Market Reference |
| Depends On | EnterpriseDataDictionaryStandard, EntityDictionary, AttributeDictionary, RelationshipDictionary, AggregateCatalog |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

This document defines the canonical business semantics of the **Trading Board** entity within the Phoenix Platform.

A Trading Board represents an organized business segment operated by a financial Exchange where financial instruments are listed and traded according to a defined set of market rules.

This document serves as the authoritative business definition of the Trading Board entity and provides semantic guidance for logical modeling, service design, integration, and future platform evolution.

The document intentionally excludes physical database implementation details.

---

# 2. Scope

This dictionary defines the Trading Board as an enterprise business entity.

It documents:

- Business meaning
- Business responsibilities
- Aggregate membership
- Lifecycle
- Business identity
- Business relationships
- Enterprise traceability
- Governance

This document does not define:

- Database tables
- Database columns
- SQL data types
- Primary or foreign keys
- Constraints
- Indexes
- Storage implementation

These concerns are governed by the Logical Database Model, Physical Database Model, Enterprise Data Type Standard, and Identifier Strategy.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| Business Glossary | Defines the business meaning of Trading Board |
| Entity Dictionary | Registers Trading Board as a canonical enterprise entity |
| Attribute Catalog | Registers reusable Trading Board attributes |
| Attribute Dictionary | Defines the business semantics of Trading Board attributes |
| Relationship Dictionary | Defines business relationships involving Trading Board |
| Aggregate Catalog | Assigns Trading Board to the Market Reference Aggregate |
| Enterprise Data Dictionary Standard | Governs the documentation structure |
| Logical Database Model | Defines logical representation |
| Physical Database Model | Defines physical implementation |

---

# 4. Business Definition

## Canonical Name

**Trading Board**

---

## Business Description

A Trading Board is an organizational market segment established and managed by a financial Exchange.

It defines a specific trading environment under which financial instruments are admitted, listed, and traded according to a common set of operational, regulatory, and business rules.

A Trading Board represents a structural subdivision of an Exchange rather than an independent financial market.

---

## Business Purpose

The Trading Board exists to:

- organize listed financial instruments into business segments;
- provide a consistent trading environment;
- support market segmentation;
- simplify regulatory administration;
- facilitate reporting and market supervision;
- provide a stable reference for instrument listings.

---

## Business Responsibilities

The Trading Board is responsible for:

- defining a market segment within an Exchange;
- organizing listed instruments;
- supporting listing management;
- maintaining board identity;
- preserving historical market structure;
- enabling regulatory reporting.

---

## Aggregate Membership

| Property | Value |
|----------|-------|
| Domain | Reference Domain |
| Aggregate | Market Reference |
| Aggregate Root | Exchange |
| Entity Type | Child Entity |
| Lifecycle Dependency | Exchange |

Trading Board exists within the **Market Reference Aggregate** and is governed by the owning Exchange.

---

# 5. Business Identity

Trading Board possesses three independent identity layers.

## Canonical Identity

Assigned by Phoenix.

Characteristics:

- globally unique;
- immutable;
- technology independent;
- internally managed.

Governed by:

- Enterprise Identity Standard
- Identifier Strategy

---

## Business Identity

Represents the official business identity of the Trading Board.

Typical examples include:

- Board Code
- Official Board Name

Business identifiers are governed by Exchange policies.

---

## External Identity

External providers may assign their own identifiers.

Examples include identifiers used by:

- TSETMC
- Market data vendors
- Broker platforms
- Financial information providers

External identifiers are maintained independently of enterprise identity.

---

# 6. Lifecycle

The lifecycle of a Trading Board typically follows:

```text
Planned
    ↓
Established
    ↓
Operational
    ↓
Suspended
    ↓
Closed
```

Trading Board records are retained permanently for historical traceability.

Historical Trading Boards shall never be physically deleted.

---

# 7. Business Relationships

| Related Entity | Relationship | Business Meaning |
|----------------|-------------|------------------|
| Exchange | Belongs to | Every Trading Board is operated by exactly one Exchange. |
| Instrument Listing | Organizes | A Trading Board hosts multiple Instrument Listings. |
| Instrument | Indirect Association | Instruments become tradable through Listings assigned to a Trading Board. |
| Market | Part Of | Trading Boards collectively support the operation of a Market. |

The complete relationship semantics are defined in the **Relationship Dictionary**.

---

# 8. Business Rules

The following enterprise business rules govern the Trading Board entity.

- Every Trading Board shall belong to exactly one Exchange.
- A Trading Board cannot exist independently of an Exchange.
- Every Trading Board shall possess one canonical enterprise identity.
- Business identifiers shall be unique within the owning Exchange.
- A Trading Board may host many Instrument Listings.
- Historical Trading Boards shall remain available for historical reporting.
- Trading Board identity shall remain immutable throughout its lifecycle.
- Operational status changes shall not affect historical references.

---

# 9. Ownership

| Property | Value |
|----------|-------|
| Owning Domain | Reference Domain |
| Owning Aggregate | Market Reference |
| Business Owner | Market Reference Service |
| Governance Authority | Architecture Governance Board |

The owning aggregate is responsible for:

- creation;
- modification;
- activation;
- deactivation;
- lifecycle governance.

---

# 10. Traceability

The Trading Board entity is traceable to the following enterprise artifacts.

| Artifact | Purpose |
|----------|---------|
| Business Glossary | Business terminology |
| Entity Dictionary | Enterprise entity definition |
| Attribute Dictionary | Business meaning of attributes |
| Attribute Catalog | Reusable attributes |
| Relationship Dictionary | Business relationships |
| Aggregate Catalog | Aggregate assignment |
| Canonical Domain Model | Business model |
| Logical Database Model | Logical representation |
| Physical Database Model | Physical implementation |

---

# 11. Governance

Changes to the Trading Board business definition require:

- business impact assessment;
- architecture review;
- aggregate consistency validation;
- enterprise governance approval.

Business semantics shall remain technology independent.

---

# 12. Related Documents

- BusinessGlossary.md
- EntityDictionary.md
- AttributeCatalog.md
- AttributeDictionary.md
- RelationshipDictionary.md
- AggregateCatalog.md
- EnterpriseIdentityStandard.md
- IdentifierStrategy.md
- EnterpriseDataDictionaryStandard.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Trading Board Data Dictionary |
| 2026.2 | 2026-07-23 | Rewritten according to the Enterprise Data Dictionary architecture and Single Source of Truth principles |