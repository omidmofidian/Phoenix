# Company Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-009 |
| Document | CompanyDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Reference Domain |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, EnterpriseIdentityStandard, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The Company Data Dictionary defines the canonical business semantics of the **Company** entity within the Phoenix Platform.

A Company represents a legally recognized organization that issues one or more financial instruments and participates in one or more financial markets supported by the platform.

This document establishes the authoritative business meaning of the Company entity and serves as the single semantic reference for every architectural layer.

The document intentionally remains independent of database implementation, programming languages, APIs, messaging technologies, and deployment architecture.

---

# 2. Scope

This document defines the enterprise business semantics of the Company entity, including:

- business meaning;
- business responsibilities;
- enterprise identity;
- lifecycle;
- business relationships;
- governance;
- traceability;
- ownership.

This document does **not** define:

- database tables;
- SQL columns;
- PostgreSQL data types;
- primary keys;
- foreign keys;
- indexes;
- constraints;
- implementation details.

Those implementation concerns are defined by the Logical Database Model, Physical Database Model, Entity Specifications, and database migration scripts.

---

# 3. Business Definition

A **Company** is a legally established business organization that exists independently of any financial market and may issue one or more financial instruments for trading.

Within the Phoenix Platform, the Company represents the canonical business entity describing an issuer rather than a tradable asset.

A Company exists regardless of whether its securities are currently listed on an exchange.

The Company serves as the authoritative source for legal organization information used throughout the enterprise.

Typical business information associated with a Company includes:

- legal identity;
- official business name;
- registration information;
- economic classification;
- country of incorporation;
- issuer information;
- corporate lifecycle.

The Company entity provides a stable business foundation shared across multiple domains including:

- Market Domain;
- Portfolio Domain;
- Analytics Domain;
- Machine Learning Domain;
- Reporting Domain;
- Integration Domain.

---

# 4. Enterprise Identity

The Company entity follows the Enterprise Identity Standard adopted by the Phoenix Platform.

Three independent identity layers are recognized.

| Identity Layer | Purpose |
|----------------|---------|
| Canonical Identity | Permanent enterprise identity |
| Business Identity | Enterprise business identifier |
| External Identity | External provider identifiers |

---

## Canonical Identity

Every Company shall possess exactly one immutable enterprise identifier.

The canonical identifier:

- is globally unique;
- is immutable;
- has no business meaning;
- is never reused;
- uniquely identifies the Company throughout its entire lifecycle.

---

## Business Identity

Every Company shall possess one approved enterprise business identifier.

Typical examples include:

- Company Code
- Registration Number
- Legal Registration Identifier
- Enterprise Company Identifier

Business identifiers are intended for enterprise communication and governance.

---

## External Identity

A Company may be identified differently by external organizations.

Examples include:

- TSETMC Company Code
- Exchange-specific Company Identifier
- Regulatory Identifier
- Commercial Data Provider Identifier

External identifiers:

- are optional;
- are provider-specific;
- may change over time;
- never replace the canonical enterprise identity.

---

    # 5. Business Relationships

The Company entity participates in multiple enterprise relationships across the Phoenix Platform.

These relationships describe business dependencies and organizational responsibilities rather than implementation-specific foreign keys.

---

## Upstream Relationships

A Company is classified by the enterprise reference taxonomy.

| Related Entity | Business Meaning |
|----------------|------------------|
| Industry | Defines the Company's primary economic activity. |
| Sector | Defines the broader economic sector through the assigned Industry. |

Every Company shall belong to exactly one Industry.

The assigned Industry determines the Company's position within the enterprise classification hierarchy.

---

## Downstream Relationships

A Company may issue one or more financial instruments.

| Related Entity | Business Meaning |
|----------------|------------------|
| Instrument | Financial instrument issued by the Company. |
| Instrument Listing | Exchange listing of issued instruments. |
| Corporate Action | Business events initiated by the Company. |

The existence of a Company does not depend upon the existence of any specific financial instrument.

---

## Cross-Domain Relationships

The Company entity is reused across multiple business domains.

| Domain | Business Usage |
|---------|----------------|
| Market | Issuer of financial instruments. |
| Portfolio | Investment ownership reference. |
| Analytics | Fundamental analysis and financial metrics. |
| Machine Learning | Feature generation and predictive models. |
| Reporting | Enterprise reporting and regulatory disclosure. |
| Integration | Mapping to external providers and regulatory authorities. |

---

## Aggregate Relationships

Within Domain-Driven Design (DDD), the Company is treated as an Aggregate Root.

The Company Aggregate owns its internal business state while interacting with other aggregates through well-defined references.

Direct modification of related aggregates is prohibited.

---

# 6. Lifecycle

The Company lifecycle represents the evolution of a legal business entity within the Phoenix Platform.

A Company normally progresses through the following states.

```text
Proposed
    ↓
Registered
    ↓
Approved
    ↓
Active
    ↓
Suspended
    ↓
Inactive
    ↓
Archived
```

---

## Proposed

The Company has been identified but has not yet completed enterprise validation.

---

## Registered

The Company has been formally recorded with the required business and regulatory information.

---

## Approved

The Company has successfully passed enterprise governance and is available for operational use.

---

## Active

The Company is actively recognized within the enterprise and may issue or maintain financial instruments.

---

## Suspended

Business activities are temporarily restricted while the Company remains part of the enterprise model.

---

## Inactive

The Company is no longer operational but continues to exist for historical and regulatory purposes.

---

## Archived

The Company is retained exclusively for historical traceability.

Archived Companies remain accessible for reporting, auditing, historical analytics, and regulatory compliance.

They shall not be physically deleted while referenced by enterprise data.

---

# 7. Business Rules

The following enterprise business rules govern the Company entity throughout its lifecycle.

These rules are independent of implementation technology and shall remain valid across all architectural layers.

---

## Company Existence

A Company represents a legally recognized business organization.

The Company exists independently of:

- financial instruments;
- exchange listings;
- market participation;
- trading activity.

The existence of a Company shall not depend on any downstream business entity.

---

## Enterprise Identity

Every Company shall possess exactly one canonical enterprise identity.

The enterprise identifier:

- is globally unique;
- is immutable;
- has no business meaning;
- shall never be reassigned;
- remains valid throughout the Company's lifecycle.

---

## Business Classification

Every Company shall belong to exactly one approved Industry.

Business classification is maintained through the enterprise reference hierarchy.

A Company inherits its Sector classification through the assigned Industry.

A Company shall never be directly assigned to multiple Industries simultaneously.

---

## Instrument Issuance

A Company may issue:

- one financial instrument;
- multiple financial instruments;
- different classes of financial instruments;
- additional instruments over time.

Each issued Instrument shall reference exactly one Company as its issuer.

---

## Market Independence

A Company may exist without:

- an active exchange listing;
- active trading;
- market data;
- portfolio ownership.

Business existence and market participation are separate concepts.

---

## Historical Preservation

Historical Company information constitutes enterprise reference data.

Business history shall be preserved to support:

- regulatory compliance;
- historical reporting;
- financial analysis;
- audit activities;
- reproducible analytical models.

Business history shall never be lost through physical deletion.

---

## Deactivation

When a Company becomes inactive:

- enterprise identity shall remain unchanged;
- historical relationships shall remain valid;
- analytical references shall remain intact;
- archived data shall continue to be available for authorized use.

Inactive status shall not invalidate historical business information.

---

# 8. Ownership

The Company entity is owned by the **Market Domain** as part of the enterprise master data.

Business stewardship is responsible for maintaining the semantic integrity, governance, and lifecycle of Company information.

Changes to Company definitions shall be managed through the Architecture Governance process.

Ownership responsibilities include:

- maintaining canonical business definitions;
- ensuring consistency with the Entity Dictionary;
- preserving enterprise identity;
- coordinating changes across dependent domains;
- approving structural modifications affecting downstream consumers.

No service or application may redefine the business meaning of the Company entity outside this governance process.

---

# 9. Traceability

The Company entity shall remain fully traceable across all enterprise architectural artifacts.

Every definition, relationship, business rule, and lifecycle state shall be consistent throughout the Phoenix Platform.

The Company Data Dictionary serves as the authoritative semantic reference for all downstream models and specifications.

---

## Upstream Traceability

The business definition of Company originates from the enterprise business architecture.

The entity is derived from and constrained by the following artifacts:

- Business Glossary
- Canonical Domain Model
- Canonical Business Rules
- Entity Dictionary
- Attribute Dictionary
- Relationship Dictionary

---

## Downstream Traceability

The Company definition is realized through multiple implementation artifacts.

These include:

- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- Service Contracts
- API Specifications
- Integration Models
- Reporting Models
- Machine Learning Feature Models

Every implementation artifact shall preserve the approved business semantics defined in this document.

---

## Cross-Domain Traceability

The Company entity is referenced by multiple enterprise domains.

Typical consumers include:

- Market Domain
- Portfolio Domain
- Analytics Domain
- Machine Learning Domain
- Reporting Domain
- Integration Domain

These domains may extend the usage of Company information but shall not redefine its business meaning.

---

# 10. Governance

The Company entity is governed under the Phoenix Architecture Governance Framework.

Any modification affecting its business definition requires formal architectural review and approval.

Governance applies to, but is not limited to:

- business meaning;
- lifecycle;
- enterprise identity;
- ownership;
- business relationships;
- classification hierarchy;
- canonical naming.

Changes shall be evaluated for their impact on:

- enterprise consistency;
- downstream domains;
- service contracts;
- integration interfaces;
- analytical models;
- historical data compatibility.

Backward compatibility shall be preserved whenever reasonably possible.

---

# 11. Related Documents

The Company Data Dictionary is closely aligned with the following enterprise artifacts:

- BusinessGlossary.md
- CanonicalDomainModel.md
- CanonicalBusinessRules.md
- EntityDictionary.md
- AttributeDictionary.md
- RelationshipDictionary.md
- AggregateCatalog.md
- AggregateAttributeMatrix.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionaryStandard.md
- EnterpriseIdentityStandard.md

---

# 12. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial table-oriented Company Data Dictionary. |
| 2026.2 | 2026-07-23 | Redesigned as an enterprise semantic Company Data Dictionary aligned with the Enterprise Data Dictionary architecture and Single Source of Truth principles. |

---

# 13. Architecture Alignment

This document conforms to the Phoenix enterprise documentation architecture.

It is aligned with:

- Single Source of Truth (SSOT)
- Domain-Driven Design (DDD)
- Enterprise Data Dictionary
- Canonical Business Model
- Technology Independence
- Architecture Governance

No implementation-specific information shall be introduced into this document.

---

# 14. Compliance

Compliance with this dictionary is mandatory.

All architectural artifacts, logical models, physical models, services, APIs, reports, integrations, and analytical components that reference the Company entity shall conform to the business semantics defined herein.

Any exception requires formal approval through the Architecture Governance process.

---

# 15. Notes

The Company entity represents a legal business organization and shall never be confused with a financial instrument, trading symbol, exchange listing, or issuer-specific market representation.

A single Company may issue multiple Instruments, each of which may participate in one or more market listings over time.

Accordingly, Company serves as a foundational enterprise master data entity supporting consistent business identity across the entire Phoenix Platform.

---

# 16. Migration Notes

Version **2026.2** supersedes the previous table-oriented Company Data Dictionary.

Implementation-specific content—including SQL columns, data types, keys, indexes, constraints, default values, and sample records—has been relocated to the Physical Database Model and related implementation artifacts.

This document is now the canonical semantic definition of the **Company** entity within the Phoenix Enterprise Data Dictionary.

---

# 17. Business Examples

The following examples illustrate how the Company entity is interpreted throughout the Phoenix Platform.

These examples are provided solely to clarify business semantics and shall not be interpreted as implementation specifications.

---

## Example 1 — Publicly Listed Company

A manufacturing corporation is registered as a legal entity and has issued ordinary shares that are listed on a securities exchange.

Business interpretation:

- One Company exists.
- The Company belongs to one Industry.
- The Company belongs indirectly to one Sector.
- The Company issues one or more Instruments.
- Each Instrument may have one or more Listings.
- Daily market data is collected for the Listings rather than for the Company itself.

---

## Example 2 — Multiple Financial Instruments

A company issues several classes of securities, including ordinary shares, preferred shares, and corporate bonds.

Business interpretation:

- One Company
- Multiple Instruments
- Each Instrument maintains its own business lifecycle.
- Each Instrument may be traded independently.

The Company remains the common issuer for all issued instruments.

---

## Example 3 — Multiple Exchange Listings

A Company issues an Instrument that is admitted for trading on more than one trading venue.

Business interpretation:

- One Company
- One Instrument
- Multiple Instrument Listings
- Multiple Trading Boards
- Potentially multiple Exchanges

The Company identity remains unchanged regardless of where its instruments are traded.

---

## Example 4 — Delisted Company

A Company whose securities are no longer traded continues to exist as a legal business entity.

Business interpretation:

- Historical Company information is preserved.
- Historical Instruments remain traceable.
- Historical Listings remain available.
- Historical Market Data remains available.

The Company is retained for historical reporting, regulatory compliance, auditability, and long-term analytical reproducibility.

---

## Example 5 — External Data Integration

Several external market-data providers maintain different identifiers for the same Company.

Business interpretation:

- One canonical Company
- Multiple external identifiers
- Multiple provider mappings

The canonical enterprise identity remains the authoritative reference, while external identifiers are treated as provider-specific aliases.

---

# 18. Future Extensions

The Company entity has been designed to support future business capabilities without requiring changes to its core semantic definition.

Potential extensions include:

- ownership structure;
- shareholder registry;
- board of directors;
- executive management;
- financial statements;
- ESG information;
- corporate governance indicators;
- regulatory disclosures;
- credit ratings;
- issuer risk profiles;
- sustainability metrics;
- international cross-listings.

These capabilities shall extend the Company entity through related aggregates and services rather than altering its canonical business meaning.

---

# 19. Architecture Decision Alignment

The Company Data Dictionary complies with the architectural decisions adopted by the Phoenix Platform.

This document is aligned with:

- ADR-015 — Market Classification Model
- ADR-016 — Public Identifier Strategy
- ADR-022 — Repository Architecture
- Enterprise Data Dictionary Standard
- Enterprise Attribute Standard
- Enterprise Naming Standard
- Canonical Business Rules

Future architectural decisions affecting the Company entity shall maintain semantic consistency with this dictionary or formally supersede it through the Architecture Governance process.

---

