# Corporate Action Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-014 |
| Document | CorporateActionDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, CanonicalDomainModel, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The Corporate Action entity defines the canonical business representation of official events initiated by an issuing company or recognized market authority that affect one or more financial instruments within the Phoenix Platform.

It serves as the authoritative enterprise record of events that alter the economic or legal characteristics of financial instruments while preserving the historical integrity of market observations.

Corporate Action provides the business foundation for historical price adjustments, portfolio valuation, corporate event processing, and regulatory reporting.

This document defines the business semantics of Corporate Action independently of any database technology or implementation.

The document follows the Single Source of Truth (SSOT) principle and is intentionally technology independent.

---

# 2. Scope

This document defines the canonical business semantics of the Corporate Action entity.

It applies to every enterprise capability that records, interprets, or consumes official corporate events, including market data processing, historical price adjustment, portfolio management, risk analysis, reporting, compliance, and future analytical services.

This dictionary defines:

- business meaning;
- enterprise identity;
- business responsibilities;
- lifecycle;
- business relationships;
- governance;
- traceability.

This dictionary does not define:

- database tables;
- SQL implementation;
- physical columns;
- indexes;
- constraints;
- implementation details.

These responsibilities belong to the Physical Database Model and related implementation artifacts.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Data Dictionary Standard | Governs the structure of enterprise data dictionaries |
| Entity Dictionary | Defines Corporate Action as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Corporate Action attributes |
| Relationship Dictionary | Defines canonical relationships involving Corporate Action |
| Canonical Domain Model | Places Corporate Action within the Trading domain |
| Logical Database Model | Defines logical relationships and aggregate boundaries |
| Physical Database Model | Defines physical database implementation |
| Architecture Decision Records (ADRs) | Capture architectural decisions affecting Corporate Action |

---

# 4. Business Definition

The Corporate Action entity represents the canonical business record of an official event initiated by an issuing company or recognized market authority that changes the economic, legal, or structural characteristics of one or more financial instruments.

It captures enterprise-recognized corporate events independently of how they are stored, processed, or distributed by information systems.

Each Corporate Action represents a distinct business event that becomes part of the permanent historical record of the affected financial instrument.

Corporate Actions preserve the historical continuity of market information and provide the business foundation for interpreting changes in financial instruments over time.

---

# 5. Enterprise Identity

Every Corporate Action possesses one canonical enterprise identity.

The enterprise identity uniquely represents one official corporate event affecting one financial instrument.

The enterprise identity is:

- unique;
- immutable;
- technology independent;
- event-oriented;
- business driven.

Once a Corporate Action has been officially published and recognized by the enterprise, its identity shall never change.

Business corrections shall be managed through controlled governance procedures while preserving historical traceability and auditability.

---

# 6. Business Responsibilities

The Corporate Action entity is responsible for representing official corporate events affecting financial instruments.

Its responsibilities include:

- recording official corporate events;
- preserving historical business continuity;
- supporting historical price adjustment processes;
- supporting portfolio valuation;
- supporting investment analysis;
- supporting regulatory reporting;
- supporting market event interpretation;
- supporting enterprise auditability;
- providing historical context for analytical services.

The Corporate Action entity is not responsible for:

- recording market prices;
- defining financial instruments;
- managing trading sessions;
- calculating adjusted prices;
- generating trading signals;
- executing trading strategies;
- maintaining investment portfolios.

These responsibilities belong to their respective enterprise entities and services.

---

# 7. Business Relationships

The Corporate Action entity participates in the following canonical enterprise relationships.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Instrument | Affects | N : 1 |
| Company | Originates from | N : 1 |
| Daily Market Data | Provides historical adjustment context for | 1 : N |
| Portfolio Valuation | Influences | 1 : N |
| Risk Analysis | Supports | 1 : N |
| Reporting | Provides business event information for | 1 : N |
| Price Adjustment Service | Serves as input to | 1 : N |

Corporate Action provides the authoritative enterprise representation of official corporate events and serves as the business foundation for interpreting structural changes affecting financial instruments.

---

# 8. Business Lifecycle

The lifecycle of a Corporate Action follows the progression below.

```text
Announced

↓

Verified

↓

Approved

↓

Published

↓

Effective

↓

Historical

↓

Archived
```

After publication, a Corporate Action becomes an immutable enterprise business event.

Subsequent modifications shall occur only through formally governed correction procedures while preserving historical integrity and enterprise auditability.

Corporate Actions shall remain permanently available as part of the enterprise historical knowledge base, ensuring consistent interpretation of market history across all business capabilities.

---

# 9. Business Rules

The following enterprise business rules govern the Corporate Action entity.

## Business Event Rules

- Every Corporate Action shall represent one officially recognized corporate event.
- Every Corporate Action shall be associated with exactly one financial Instrument.
- A Corporate Action shall originate from an authorized issuer or recognized market authority.
- Every Corporate Action shall possess a unique enterprise identity throughout its lifecycle.

---

## Historical Integrity Rules

- Corporate Actions represent immutable historical business events.
- Published Corporate Actions shall not be modified through normal business operations.
- Official corrections shall follow controlled governance procedures while preserving historical traceability.
- Historical Corporate Actions shall remain permanently identifiable.

---

## Market Integrity Rules

- Corporate Actions shall not directly modify historical Daily Market Data.
- Historical market observations shall remain unchanged after publication.
- Corporate Actions shall provide the business context required for historical interpretation and analytical adjustment.
- Price adjustment services shall consume Corporate Actions without altering their business meaning.

---

## Enterprise Analytics Rules

- Corporate Actions shall serve as the canonical enterprise source of official corporate event information.
- Portfolio valuation, historical analysis, quantitative research, forecasting, and analytical services shall interpret Corporate Actions using the approved business semantics.
- Derived analytical entities shall not redefine the business meaning of Corporate Actions.

---

## Governance Rules

- Corporate Actions shall remain technology independent.
- Business semantics shall remain independent of implementation technologies.
- Enterprise services shall interpret Corporate Actions consistently across all business domains.
- Changes affecting business semantics shall require formal Enterprise Architecture approval.

---

# 10. Governance

The Corporate Action entity is governed as a canonical enterprise business entity representing official market events.

Its business definition, enterprise identity, lifecycle, responsibilities, and relationships are managed through the Enterprise Architecture Governance framework.

The following modifications require formal governance approval:

- changes to the business definition;
- changes to enterprise identity;
- changes to lifecycle semantics;
- changes to business responsibilities;
- changes to canonical business relationships;
- changes affecting enterprise historical interpretation;
- changes impacting analytical or regulatory semantics.

All approved modifications shall preserve semantic consistency across every dependent enterprise artifact.

---

# 11. Traceability

The Corporate Action entity is traceable throughout the Phoenix Enterprise Architecture.

| Artifact | Relationship |
|----------|--------------|
| Business Glossary | Defines Corporate Action terminology |
| Entity Dictionary | Defines Corporate Action as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Corporate Action attributes |
| Relationship Dictionary | Defines canonical relationships involving Corporate Action |
| Canonical Domain Model | Places Corporate Action within the Trading domain |
| Aggregate Catalog | Defines aggregate ownership |
| Logical Database Model | Defines logical relationships |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary | Defines business semantics |
| Architecture Decision Records (ADRs) | Record architectural decisions affecting Corporate Action |

Enterprise traceability guarantees semantic consistency across Business Architecture, Information Architecture, Application Architecture, and Data Architecture.

---

# 12. Related Documents

- EnterpriseDataDictionaryStandard
- BusinessGlossary
- EntityDictionary
- AttributeDictionary
- RelationshipDictionary
- CanonicalDomainModel
- AggregateCatalog
- LogicalDatabaseModel
- PhysicalDatabaseModel
- ADR-015 — Market Classification Model
- ADR-016 — Public Identifier Strategy
- ADR-017 — Canonical Data Modeling Principles

---

# 13. Cross-Reference Matrix

The Corporate Action entity is governed by and traced to the following enterprise artifacts.

| Enterprise Artifact | Relationship |
|----------------------|--------------|
| Business Glossary | Defines business terminology related to Corporate Action |
| Entity Dictionary | Defines Corporate Action as a canonical business entity |
| Attribute Catalog | Registers approved Corporate Action attributes |
| Attribute Dictionary | Defines the business semantics of Corporate Action attributes |
| Relationship Dictionary | Defines canonical business relationships involving Corporate Action |
| Aggregate Catalog | Identifies the owning Aggregate |
| Canonical Domain Model | Places Corporate Action within the Trading Domain |
| Logical Database Model | Defines logical structure and aggregate boundaries |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary Standard | Governs the structure of this document |
| Enterprise Attribute Standard | Governs enterprise attribute definitions |
| Enterprise Naming Standard | Governs naming conventions |
| Enterprise Data Type Standard | Governs logical data types |
| ADR-015 — Market Classification Model | Defines enterprise market classification principles |
| ADR-016 — Public Identifier Strategy | Defines enterprise identity strategy |
| ADR-017 — Canonical Data Modeling Principles | Defines enterprise data modeling principles |

---

# 14. Compliance

All enterprise solutions shall use the Corporate Action entity exactly as defined in this dictionary.

The Corporate Action entity shall:

- maintain a single canonical business definition;
- represent the authoritative enterprise record of official corporate events;
- remain technology independent;
- remain implementation independent;
- preserve semantic consistency across all enterprise artifacts;
- comply with the Enterprise Data Dictionary Standard;
- comply with the Enterprise Attribute Standard;
- comply with approved Architecture Decision Records (ADRs).

No application, service, database, analytical engine, or external integration may redefine the business meaning of the Corporate Action entity.

Any modification to this document shall require formal review and approval through the Enterprise Architecture Governance process.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Corporate Action Data Dictionary |
| 2026.2 | 2026-07-23 | Redesigned as an Enterprise semantic dictionary aligned with the Enterprise Data Dictionary Standard, the Single Source of Truth (SSOT) principle, and the canonical enterprise architecture. |

---

# 15. Architecture Notes

## Architectural Role

Corporate Action is the canonical enterprise representation of official business events that modify the economic interpretation of financial instruments without changing their historical trading observations.

It bridges issuer-driven business events and analytical processing while preserving the immutability of historical market data.

---

## Architectural Characteristics

Corporate Action is characterized by:

- Event-driven business semantics
- Immutable historical records
- Enterprise-wide consumption
- Strong auditability
- Regulatory significance
- Historical traceability
- Cross-domain integration

Unlike transactional entities, Corporate Action represents officially recognized business events rather than operational transactions.

---

## Enterprise Significance

Corporate Action provides the authoritative business context for:

- Historical Price Adjustment
- Adjusted Time-Series Generation
- Portfolio Valuation
- Risk Analytics
- Performance Measurement
- Dividend Analysis
- Capital Structure Analysis
- Financial Reporting
- Regulatory Compliance
- Machine Learning Feature Engineering

Without Corporate Action, historical market observations cannot be interpreted consistently across time.

---

## Architectural Constraints

Corporate Action shall not:

- modify Daily Market Data;
- overwrite historical market observations;
- redefine Instrument identity;
- contain provider-specific implementation logic;
- embed calculation algorithms.

Its responsibility is limited to representing official enterprise business events.

---

## Integration Principles

Corporate Action integrates with multiple enterprise capabilities while remaining the single source of truth for corporate event information.

Enterprise services shall consume Corporate Action through its approved business semantics.

Analytical services may derive adjusted datasets from Corporate Actions, but they shall never modify the canonical Corporate Action records.

---

## Physical Implementation Guidance

Implementation-specific concerns—including event versioning, indexing strategies, storage optimization, partitioning, compression, replication, and database-specific tuning—shall be documented exclusively within the Physical Database Model and related implementation standards.

These implementation decisions shall not alter the canonical business semantics defined by this dictionary

---