# Exchange Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-EX-001 |
| Document | ExchangeDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Reference Domain |
| Aggregate | Market Reference |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

This document defines the canonical business meaning of the **Exchange** entity within the Phoenix Platform.

The Exchange Dictionary serves as the authoritative business reference for understanding the responsibilities, lifecycle, business relationships, and attribute usage of an Exchange.

This document is technology-independent and does not define physical database implementation.

---

# 2. Business Definition

An **Exchange** is an organized financial marketplace that provides the regulatory, operational, and technical infrastructure for trading financial instruments.

Within the Phoenix Platform, an Exchange represents the highest-level trading venue under which one or more Markets and Trading Boards operate.

The Exchange entity is classified as enterprise reference data and provides foundational information used throughout multiple business domains.

---

# 3. Business Responsibilities

The Exchange entity is responsible for:

- Identifying regulated financial exchanges
- Providing exchange-level reference information
- Supporting market organization
- Providing the business context for Trading Boards
- Supporting instrument listing through subordinate entities
- Serving as an enterprise reference object across multiple services

The Exchange entity is **not responsible** for:

- Trading sessions
- Daily market prices
- Corporate actions
- Market analytics
- Technical indicators

These responsibilities belong to other business entities and domains.

---

# 4. Aggregate Information

| Property | Value |
|----------|-------|
| Domain | Reference Domain |
| Aggregate | Market Reference |
| Aggregate Root | Yes |
| Lifecycle | Stable |
| Business Owner | Reference Domain |
| Shared Across Domains | Yes |

The Exchange entity acts as an Aggregate Root for exchange-related reference information.

No external entity may modify Exchange state except through its Aggregate Root.

---

# 5. Business Lifecycle

The Exchange entity follows a long-lived and highly stable lifecycle.

Changes to an Exchange are rare and occur only when officially approved by the governing financial authority.

The typical lifecycle is illustrated below.

```text
Proposed
      ↓
Reviewed
      ↓
Approved
      ↓
Active
      ↓
Inactive
      ↓
Archived
```

## Lifecycle States

| State | Description |
|---------|-------------|
| Proposed | Exchange has been identified but not yet approved for enterprise use. |
| Reviewed | Business validation has been completed. |
| Approved | Exchange has been accepted as official enterprise reference data. |
| Active | Exchange is operational and may be referenced by other business entities. |
| Inactive | Exchange is no longer operational but remains historically valid. |
| Archived | Exchange is retained only for historical traceability. |

Exchange records shall never be physically deleted.

---

# 6. Enterprise Identity

The Exchange entity follows the enterprise identity model defined by the Enterprise Identity Standard.

## Canonical Identity

The Exchange possesses one immutable enterprise identifier.

Reference:

- EnterpriseIdentityStandard
- IdentifierStrategy

---

## Business Identity

The Exchange is additionally identified through approved business identifiers.

Typical business identifiers include:

- Exchange Code
- Official Exchange Name

Business identifiers are governed by the Reference Domain and shall remain stable.

---

## External Identity

An Exchange may possess one or more external identifiers assigned by external providers.

Examples include identifiers published by:

- TSETMC
- ISO organizations
- Market data vendors
- Commercial information providers

External identifiers are managed independently from enterprise identity.

---

# 7. Attribute Usage

The Exchange entity uses enterprise attributes defined in the Attribute Catalog.

The business semantics of each attribute are defined exclusively within the Attribute Dictionary.

The Exchange Dictionary assigns approved enterprise attributes to the Exchange entity without redefining their meaning.

| Attribute | Purpose | Mandatory |
|-----------|---------|-----------|
| id | Canonical enterprise identity | Yes |
| public_id | External enterprise identity | Yes |
| exchange_code | Business identifier | Yes |
| exchange_name | Official business name | Yes |
| local_name | Local-language business name | Yes |
| country_id | Associated country | Yes |
| currency_id | Trading currency | Yes |
| timezone_id | Business time zone | Yes |
| website | Official public website | No |
| external_identifier | External provider mapping | No |
| status | Business lifecycle status | Yes |
| is_active | Operational status | Yes |
| created_at | Audit information | Yes |
| updated_at | Audit information | Yes |

Attribute definitions shall not be duplicated within this document.

The authoritative source for attribute semantics is the **Attribute Dictionary**.

---

# 8. Business Responsibilities Matrix

| Responsibility | Exchange |
|----------------|----------|
| Enterprise Reference Data | ✓ |
| Business Identification | ✓ |
| Trading Infrastructure Definition | ✓ |
| Regulatory Information | ✓ |
| Market Organization | ✓ |
| Instrument Definition | ✗ |
| Trading Session Management | ✗ |
| Daily Market Data | ✗ |
| Corporate Actions | ✗ |
| Analytics | ✗ |

The Exchange entity represents only enterprise reference information and delegates operational trading responsibilities to subordinate business entities.

---

# 9. Business Constraints

The following business constraints apply regardless of implementation technology.

- Every Exchange shall possess exactly one canonical identity.
- Every Exchange shall possess one approved business identifier.
- Exchange Codes shall be unique within the enterprise.
- Official Exchange Names shall be unique.
- Every Exchange shall belong to exactly one Country.
- Every Exchange shall use one official Currency.
- Every Exchange shall reference one official Time Zone.
- Every Trading Board shall belong to exactly one Exchange.
- Exchange identity shall remain immutable throughout its lifecycle.
- Historical Exchange information shall remain traceable after deactivation.

Implementation-specific constraints are defined within the Physical Database Model.

---

# 10. Business Relationships

The Exchange entity participates in enterprise relationships defined by the Relationship Dictionary.

Business relationships documented here describe semantic associations rather than physical foreign-key implementations.

| Related Entity | Relationship | Cardinality | Business Meaning |
|----------------|--------------|-------------|------------------|
| Country | Association | N:1 | Every Exchange operates within one sovereign country. |
| Currency | Association | N:1 | Every Exchange uses one official trading currency. |
| TimeZone | Association | N:1 | Every Exchange follows one official business time zone. |
| Market | Composition | 1:N | An Exchange organizes one or more Markets. |
| Trading Board | Composition | 1:N | An Exchange governs one or more Trading Boards. |

The authoritative definitions of these relationships are maintained within the Relationship Dictionary.

---

# 11. Traceability

The Exchange entity is fully traceable across the enterprise architecture.

| Architectural Layer | Related Artifact |
|---------------------|------------------|
| Business Glossary | Exchange |
| Entity Dictionary | Exchange |
| Attribute Dictionary | Exchange Attributes |
| Attribute Catalog | Exchange Attribute Assignments |
| Relationship Dictionary | Exchange Relationships |
| Aggregate Catalog | Market Reference Aggregate |
| Canonical Domain Model | Reference Domain |
| Logical Database Model | Exchange Logical Entity |
| Physical Database Model | market.exchange |
| Enterprise Data Dictionary | Exchange |

This traceability ensures architectural consistency from business analysis through physical implementation.

---

# 12. Governance

The Exchange entity is governed by the Reference Domain.

Changes to its business definition require formal architectural governance.

The following modifications require approval:

- Business definition changes
- Lifecycle modifications
- Identity changes
- New business relationships
- Addition or removal of enterprise attributes
- Aggregate ownership changes

Implementation-specific modifications shall not alter the approved business semantics of the Exchange entity.

---

# 13. Related Enterprise Artifacts

The Exchange Dictionary shall be interpreted together with the following enterprise artifacts.

### Standards

- EnterpriseAttributeStandard
- EnterpriseNamingStandard
- EnterpriseIdentityStandard
- EnterpriseDataTypeStandard
- EnterpriseDataDictionaryStandard
- IdentifierStrategy

### Dictionaries

- BusinessGlossary
- EntityDictionary
- AttributeDictionary
- RelationshipDictionary
- AttributeCatalog

### Architecture

- CanonicalDomainModel
- ReferenceDomainArchitecture
- AggregateCatalog
- AggregateAttributeMatrix
- LogicalDatabaseModel
- PhysicalDatabaseModel

---

# 14. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial database-oriented Exchange Data Dictionary. |
| 2026.2 | 2026-07-23 | Completely redesigned as an Enterprise Exchange Dictionary aligned with the Enterprise Information Architecture, Single Source of Truth (SSOT), and the Enterprise Data Dictionary standards. |