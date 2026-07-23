# Trading Calendar Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-012 |
| Document | TradingCalendarDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Depends On | EntityDictionary, AttributeDictionary, RelationshipDictionary, CanonicalDomainModel, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The Trading Calendar entity defines the canonical business representation of official market trading sessions within the Phoenix Platform.

It establishes the enterprise definition of trading days and non-trading days and serves as the authoritative calendar governing market operations.

The Trading Calendar provides the temporal framework upon which all trading activities, market observations, analytical processes, historical reconstructions, and regulatory reporting are based.

It is the single authoritative source for determining whether market activity is permitted on a given business date.

This document follows the Single Source of Truth (SSOT) principle and is intentionally technology independent.

---

# 2. Scope

This document defines the canonical business semantics of the Trading Calendar entity.

It applies to all enterprise capabilities that depend upon official market calendars, including market data collection, trading operations, portfolio valuation, analytics, reporting, machine learning, backtesting, and future market engines.

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
- foreign keys;
- implementation details.

These responsibilities belong to the Physical Database Model and related implementation artifacts.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Data Dictionary Standard | Governs the structure of enterprise data dictionaries |
| Entity Dictionary | Defines Trading Calendar as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Trading Calendar attributes |
| Relationship Dictionary | Defines canonical relationships involving Trading Calendar |
| Canonical Domain Model | Places Trading Calendar within the Trading domain |
| Logical Database Model | Defines logical relationships and aggregate boundaries |
| Physical Database Model | Defines physical database implementation |
| Architecture Decision Records (ADRs) | Capture architectural decisions affecting Trading Calendar |

---

# 4. Business Definition

The Trading Calendar represents the canonical business definition of official market sessions recognized by the Phoenix Platform.

It defines the enterprise calendar that governs when financial markets are operational and establishes the temporal framework for all market-related business activities.

Each Trading Calendar entry represents a single recognized business date together with its operational trading status within a specific market context.

The Trading Calendar does not describe trading activity itself; rather, it defines the business conditions under which trading activities may occur.

It therefore acts as the authoritative enterprise reference for market time.

---

# 5. Enterprise Identity

Every Trading Calendar entry possesses one canonical enterprise identity.

The identity represents a unique business trading session for a specific market calendar.

The enterprise identity is:

- unique;
- immutable;
- technology independent;
- market-context aware;
- independent of implementation.

A Trading Calendar entry shall remain permanently identifiable even if:

- trading hours are revised;
- holidays are reclassified;
- trading sessions are suspended;
- additional market metadata is introduced.

Historical calendar entries shall remain available to preserve the integrity of historical market reconstruction and analytical reproducibility.

---

# 6. Business Responsibilities

The Trading Calendar entity is responsible for defining the official business calendar governing market operations.

Its responsibilities include:

- defining official trading dates;
- defining non-trading dates;
- establishing the temporal framework for market operations;
- providing the authoritative business calendar for market data;
- supporting historical market reconstruction;
- supporting portfolio valuation dates;
- supporting analytical and machine learning processes;
- supporting regulatory reporting and auditability.

The Trading Calendar entity is not responsible for:

- recording market prices;
- storing trading volumes;
- defining financial instruments;
- maintaining market listings;
- calculating analytical indicators;
- managing investment portfolios.

These responsibilities belong to their respective enterprise entities.

---

# 7. Business Relationships

The Trading Calendar participates in several canonical business relationships across the enterprise.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Daily Market Data | Governs the business date of | 1 : N |
| Instrument Listing | Provides trading context for | 1 : N (Indirect) |
| Trading Session | Defines operational schedule for | 1 : N |
| Exchange | May be associated with | N : M |
| Market | Operates according to | N : M |
| Portfolio Valuation | Provides valuation date | 1 : N |
| Analytics | Provides temporal reference | 1 : N |

The Trading Calendar serves as the enterprise temporal reference for all market-dependent business processes.

---

# 8. Business Lifecycle

The lifecycle of a Trading Calendar entry follows the progression below.

```text
Planned

↓

Published

↓

Effective

↓

Historical

↓

Archived
```

Once a Trading Calendar entry becomes effective, its business identity shall remain immutable.

Historical calendar entries shall never be physically removed from the enterprise information model.

Changes to published calendar information shall be managed through controlled governance procedures to preserve historical consistency and auditability.

---

# 9. Business Rules

The following enterprise business rules govern the Trading Calendar entity.

## Calendar Rules

- Every Trading Calendar entry shall represent exactly one official business date.
- A business date shall be unique within a specific Market Calendar.
- Every Trading Calendar entry shall belong to one and only one Market Calendar.
- A Trading Calendar may contain both trading and non-trading dates.

---

## Trading Session Rules

- A trading day may contain one or more official trading sessions.
- A non-trading day shall not permit market transactions.
- Every trading session shall be governed by the Trading Calendar.
- Trading sessions shall comply with the official operating schedule of the corresponding market.

---

## Market Operation Rules

- Market data shall only be recorded for officially recognized trading sessions.
- Historical market data shall remain associated with the Trading Calendar under which it was originally recorded.
- Changes to future trading schedules shall not invalidate historical Trading Calendar entries.
- Exceptional market closures shall be recorded without modifying historical business semantics.

---

## Enterprise Rules

- The Trading Calendar shall provide the authoritative business calendar for all market-related enterprise services.
- Every market-dependent business process shall reference an approved Trading Calendar.
- The Trading Calendar shall remain independent of implementation technologies.
- Business semantics shall not depend upon database structures or application logic.

---

## Governance Rules

- Historical Trading Calendar entries shall never be physically removed.
- Business definitions shall remain stable across all enterprise artifacts.
- Changes affecting the Trading Calendar shall require Enterprise Architecture review and approval.
- All enterprise services shall interpret Trading Calendar semantics consistently according to this dictionary.

---

# 10. Governance

The Trading Calendar entity is governed as a canonical enterprise business entity.

Its business meaning, lifecycle, responsibilities, and relationships are controlled through the Enterprise Architecture Governance framework.

The following modifications require formal governance approval:

- changes to the business definition;
- changes to enterprise identity;
- changes to lifecycle semantics;
- changes to business responsibilities;
- changes affecting canonical relationships;
- introduction of new market calendar concepts;
- modifications affecting enterprise-wide temporal semantics.

All approved changes shall maintain consistency with every dependent enterprise artifact.

---

# 11. Traceability

The Trading Calendar entity is traceable throughout the Phoenix Enterprise Architecture.

| Artifact | Relationship |
|----------|--------------|
| Business Glossary | Defines Trading Calendar terminology |
| Entity Dictionary | Defines Trading Calendar as a canonical business entity |
| Attribute Dictionary | Defines the business semantics of Trading Calendar attributes |
| Relationship Dictionary | Defines canonical relationships involving Trading Calendar |
| Canonical Domain Model | Places Trading Calendar within the Trading domain |
| Aggregate Catalog | Defines aggregate ownership |
| Logical Database Model | Defines logical relationships |
| Physical Database Model | Defines physical implementation |
| Enterprise Data Dictionary | Defines business semantics |
| Architecture Decision Records (ADRs) | Record architectural decisions affecting Trading Calendar |

Enterprise traceability guarantees semantic consistency across business architecture, information architecture, application architecture, and data architecture.

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

The Trading Calendar entity is governed by and traced to the following enterprise artifacts.

| Enterprise Artifact | Relationship |
|----------------------|--------------|
| Business Glossary | Defines business terminology related to Trading Calendar |
| Entity Dictionary | Defines Trading Calendar as a canonical business entity |
| Attribute Catalog | Registers approved Trading Calendar attributes |
| Attribute Dictionary | Defines the business semantics of Trading Calendar attributes |
| Relationship Dictionary | Defines canonical business relationships involving Trading Calendar |
| Aggregate Catalog | Identifies the owning Aggregate |
| Canonical Domain Model | Places Trading Calendar within the Trading Domain |
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

All enterprise solutions shall use the Trading Calendar entity exactly as defined in this dictionary.

The Trading Calendar entity shall:

- maintain a single canonical business definition;
- remain technology independent;
- remain implementation independent;
- preserve semantic consistency across all enterprise artifacts;
- comply with the Enterprise Data Dictionary Standard;
- comply with the Enterprise Attribute Standard;
- comply with approved Architecture Decision Records (ADRs).

No application, service, database, or external integration may redefine the business meaning of the Trading Calendar entity.

Any modification to this document shall require formal review and approval through the Enterprise Architecture Governance process.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Trading Calendar Data Dictionary |
| 2026.2 | 2026-07-23 | Redesigned as an Enterprise semantic dictionary aligned with the Enterprise Data Dictionary Standard, the Single Source of Truth (SSOT) principle, and the canonical enterprise architecture. |