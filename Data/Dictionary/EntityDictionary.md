# Enterprise Entity Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-002 |
| Document | EnterpriseEntityDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Semantic Dictionary |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Dictionary/EntityDictionary.md |
| Depends On | DST-006 Enterprise Data Dictionary Standard, DICT-001 BusinessGlossary, DICT-003 EnterpriseAttributeCatalog, DICT-004 EnterpriseAttributeDictionary |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The Enterprise Entity Dictionary is the authoritative semantic reference for every business entity defined within the Phoenix Platform.

Its purpose is to establish a single, canonical business definition for each enterprise entity before it is implemented within logical models, physical database designs, services, APIs, or integration components.

Each documented entity represents a distinct business concept with clearly defined responsibilities, boundaries, and business meaning.

The Entity Dictionary serves as the semantic foundation of the Enterprise Information Architecture and ensures that identical business concepts are never represented by multiple definitions.

---

# 2. Scope

The Enterprise Entity Dictionary documents the semantic characteristics of enterprise entities, including:

- canonical business definitions;
- business responsibilities;
- business purpose;
- business context;
- enterprise ownership;
- aggregate membership;
- lifecycle characteristics;
- semantic relationships;
- cross-domain traceability.

This dictionary intentionally excludes:

- database implementation;
- SQL tables;
- physical columns;
- indexes;
- constraints;
- implementation technologies;
- service implementation details.

These concerns are governed by the Logical Data Model, Physical Database Model, and related implementation artifacts.

---

# 3. Objectives

The Enterprise Entity Dictionary has the following objectives:

- establish a single semantic definition for every enterprise entity;
- provide a common business language across the platform;
- eliminate duplicate entity definitions;
- support Domain-Driven Design (DDD);
- improve consistency throughout enterprise information models;
- support architecture governance;
- provide traceability between business architecture and information architecture;
- enable long-term evolution of the enterprise data model.

---

# 4. Architectural Position

The Enterprise Entity Dictionary occupies the semantic layer of the Enterprise Information Architecture.

```text
Enterprise Architecture
        │
        ▼
Enterprise Information Architecture
        │
        ▼
Enterprise Data Dictionary
        │
        ├── Business Glossary
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
        │
        ▼
Enterprise Database
```

The Entity Dictionary defines what an enterprise entity **is**.

It does not define how the entity is physically implemented.

---

# 5. Relationship with Enterprise Artifacts

The Enterprise Entity Dictionary operates together with other enterprise metadata artifacts.

| Artifact | Responsibility |
|----------|----------------|
| Business Glossary | Defines enterprise business terminology |
| Enterprise Entity Dictionary | Defines enterprise business entities |
| Enterprise Attribute Catalog | Registers reusable attributes |
| Enterprise Attribute Dictionary | Defines attribute semantics |
| Relationship Dictionary | Defines business relationships |
| Logical Data Model | Organizes entities into logical structures |
| Physical Database Model | Implements approved entities |
| Canonical Domain Model | Defines business domains and aggregate boundaries |

Each artifact has a clearly defined responsibility while remaining fully traceable to the overall Enterprise Architecture.

---

# 6. Enterprise Entity Principles

Every enterprise entity documented within this dictionary shall comply with the following principles.

## Principle 1 — Single Business Identity

Every enterprise entity shall represent one and only one distinct business concept.

Different business concepts shall never share the same entity definition.

---

## Principle 2 — Business First

Entity definitions shall describe business meaning rather than implementation details.

Technology, programming languages, database structures, and service implementations shall not influence entity semantics.

---

## Principle 3 — Technology Independence

Business entities shall remain independent of:

- database platforms;
- programming languages;
- messaging technologies;
- deployment architectures;
- implementation frameworks.

The same entity definition shall remain valid regardless of future technological evolution.

---

## Principle 4 — Enterprise Consistency

The meaning of an entity shall remain identical wherever it appears throughout the Phoenix Platform.

A Company, Exchange, Market, or Instrument shall always preserve the same business definition regardless of the consuming service or bounded context.

---

## Principle 5 — Reusability

Enterprise entities are reusable business assets.

Existing entities shall always be reused before introducing new entity definitions.

---

## Principle 6 — Traceability

Every entity shall be traceable to:

- Business Glossary
- Domain Model
- Logical Data Model
- Physical Database Model
- Enterprise Data Dictionary
- Enterprise Business Rules

---

# 7. Entity Registration Lifecycle

Every enterprise entity progresses through a governed lifecycle before becoming part of the canonical enterprise model.

```text
Proposed
      │
      ▼
Business Review
      │
      ▼
Architecture Review
      │
      ▼
Approved
      │
      ▼
Implemented
      │
      ▼
Deprecated
      │
      ▼
Retired
```

Only approved entities may be incorporated into enterprise logical models and database designs.

---

# 8. Standard Entity Definition Structure

Every enterprise entity documented within this dictionary shall follow a standardized semantic structure.

| Section | Description |
|----------|-------------|
| Canonical Name | Official enterprise entity name |
| Business Definition | Canonical semantic definition |
| Business Purpose | Primary business objective |
| Business Responsibility | Core responsibility of the entity |
| Business Context | Typical business usage |
| Owning Domain | Responsible business domain |
| Aggregate | Aggregate Root membership |
| Lifecycle | Business lifecycle classification |
| Related Attributes | Associated enterprise attributes |
| Related Relationships | Primary business relationships |
| Governing Standards | Applicable enterprise standards |
| Remarks | Additional business notes |

This structure ensures semantic consistency across all enterprise entities.

---

# 9. Reference Domain

The Reference Domain contains stable business entities that provide controlled vocabularies and reusable reference information for the remainder of the platform.

Reference entities are characterized by:

- high stability;
- enterprise-wide reuse;
- controlled lifecycle management;
- low update frequency;
- centralized governance.

These entities provide the foundation upon which business and market domains are constructed.

---

## Exchange

### Canonical Name

**Exchange**

### Business Definition

An Exchange is a regulated financial organization that provides the legal, operational, and technological infrastructure required for listing, trading, clearing, and supervising financial instruments.

### Business Purpose

Provides the official marketplace in which financial instruments are admitted for trading under defined market regulations.

### Business Responsibility

The Exchange is responsible for:

- operating one or more markets;
- governing trading rules;
- admitting financial instruments for listing;
- supervising trading activities;
- publishing official market information.

### Business Context

Within the Phoenix Platform, an Exchange represents the highest business authority responsible for one or more financial markets.

Examples include national stock exchanges and commodity exchanges.

### Owning Domain

Reference Domain

### Aggregate

Market Reference

### Lifecycle

Stable

Reference entities change infrequently and are governed through enterprise reference data management.

### Related Attributes

- id
- code
- name
- short_name
- country_id
- timezone_id
- currency_id
- is_active

### Related Relationships

- Exchange contains Markets.
- Exchange governs Trading Boards.
- Exchange lists Financial Instruments through Listings.
- Exchange publishes Trading Calendars.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Identity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Market

### Canonical Name

**Market**

### Business Definition

A Market is a regulated trading environment operated by an Exchange in which financial instruments are traded according to a common set of business rules.

### Business Purpose

Provides the organizational structure under which specific categories of financial instruments are traded.

### Business Responsibility

A Market defines:

- trading regulations;
- listing scope;
- operational schedules;
- market classification;
- trading policies.

### Business Context

Markets exist within an Exchange.

A single Exchange may operate multiple independent markets.

Examples include:

- Equity Market
- Bond Market
- Derivatives Market
- ETF Market

### Owning Domain

Reference Domain

### Aggregate

Market Reference

### Lifecycle

Stable

### Related Attributes

- id
- code
- name
- exchange_id
- market_type
- is_active

### Related Relationships

- Market belongs to one Exchange.
- Market contains one or more Trading Boards.
- Market hosts Instrument Listings.
- Market follows one Trading Calendar.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Identity Standard

---

## Trading Board

### Canonical Name

**Trading Board**

### Business Definition

A Trading Board is an operational subdivision of a Market that groups financial instruments sharing common trading rules, operational characteristics, and market behavior.

### Business Purpose

Organizes listed instruments into business segments with consistent trading characteristics.

### Business Responsibility

A Trading Board defines:

- trading rules;
- quotation methods;
- settlement characteristics;
- operational constraints;
- board-specific classifications.

### Business Context

Trading Boards provide a finer level of market organization beneath a Market.

For example, multiple equity boards may exist within the same market, each serving different categories of listed companies.

### Owning Domain

Reference Domain

### Aggregate

Market Reference

### Lifecycle

Stable

### Related Attributes

- id
- code
- name
- market_id
- board_type
- is_active

### Related Relationships

- Trading Board belongs to one Market.
- Trading Board contains Instrument Listings.
- Trading Board applies board-specific trading policies.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Sector

### Canonical Name

**Sector**

### Business Definition

A Sector is a high-level business classification that groups companies operating within similar areas of economic activity.

### Business Purpose

Provides the primary level of business classification used for market organization, reporting, portfolio analysis, and industry comparison.

### Business Responsibility

A Sector defines the highest level of enterprise business categorization for listed companies and serves as the foundation for more detailed industry classifications.

### Business Context

Every listed company belongs to exactly one Sector.

A Sector may contain multiple Industries.

Examples include:

- Financial Services
- Energy
- Healthcare
- Materials
- Information Technology

### Owning Domain

Reference Domain

### Aggregate

Business Classification

### Lifecycle

Stable

Business classifications evolve infrequently and are governed through enterprise reference data management.

### Related Attributes

- id
- code
- name
- description
- display_order
- is_active

### Related Relationships

- Sector contains one or more Industries.
- Sector classifies Companies.
- Sector supports analytical reporting and market segmentation.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Industry

### Canonical Name

**Industry**

### Business Definition

An Industry is a detailed business classification representing organizations that perform similar commercial or production activities within a Sector.

### Business Purpose

Provides a finer level of business categorization to support financial analysis, benchmarking, market research, and investment decision-making.

### Business Responsibility

An Industry groups companies with closely related operational characteristics while maintaining alignment with the enterprise classification hierarchy.

### Business Context

Every Industry belongs to exactly one Sector.

Each Company is assigned to one Industry for business classification purposes.

### Owning Domain

Reference Domain

### Aggregate

Business Classification

### Lifecycle

Stable

### Related Attributes

- id
- code
- name
- sector_id
- description
- display_order
- is_active

### Related Relationships

- Industry belongs to one Sector.
- Industry classifies one or more Companies.
- Industry supports market analysis and reporting.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Company

### Canonical Name

**Company**

### Business Definition

A Company is a legally recognized business organization that issues or is associated with one or more financial instruments within the Phoenix Platform.

### Business Purpose

Represents the legal business entity responsible for corporate activities, regulatory disclosures, financial reporting, and issued securities.

### Business Responsibility

A Company is responsible for:

- issuing financial instruments;
- publishing corporate information;
- reporting financial statements;
- announcing corporate actions;
- maintaining regulatory compliance.

### Business Context

Within the Phoenix Platform, a Company represents the legal issuer rather than the tradable security itself.

One Company may issue multiple financial instruments.

### Owning Domain

Core Domain

### Aggregate

Company

### Lifecycle

Managed

The lifecycle of a Company is governed by regulatory registration, listing status, corporate restructuring, mergers, acquisitions, and delisting activities.

### Related Attributes

- id
- code
- name
- registration_number
- national_identifier
- industry_id
- sector_id
- incorporation_date
- is_active

### Related Relationships

- Company belongs to one Industry.
- Company belongs to one Sector.
- Company issues one or more Instruments.
- Company publishes Corporate Actions.
- Company publishes Financial Statements.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Identity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

# 10. Market Domain

The Market Domain contains the core business entities responsible for representing tradable financial instruments, their market presence, trading activities, and historical market information.

Unlike the Reference Domain, entities within the Market Domain are operational in nature and evolve continuously throughout the business lifecycle.

---

## Instrument

### Canonical Name

**Instrument**

### Business Definition

An Instrument is a tradable financial asset recognized by the Phoenix Platform and admitted for trading within one or more regulated financial markets.

### Business Purpose

Represents the financial asset that may be traded, analyzed, valued, and monitored throughout its lifecycle.

### Business Responsibility

An Instrument is responsible for representing:

- the tradable financial asset;
- its investment characteristics;
- its relationship with the issuing company;
- its market presence through one or more listings.

### Business Context

An Instrument represents the financial asset itself rather than its trading location.

The same Instrument may be listed on multiple Exchanges or Markets through independent Listings.

Examples include:

- Common Stock
- Preferred Stock
- ETF
- Bond
- Fund Unit
- Futures Contract

### Owning Domain

Market Domain

### Aggregate

Instrument

### Lifecycle

Managed

The lifecycle begins with creation and issuance, continues through listing and active trading, and ends with delisting, maturity, redemption, or retirement.

### Related Attributes

- id
- code
- name
- instrument_type
- company_id
- currency_id
- issue_date
- maturity_date
- is_active

### Related Relationships

- Instrument is issued by one Company.
- Instrument may have multiple Listings.
- Instrument generates Daily Market Data.
- Instrument may participate in Corporate Actions.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Identity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Instrument Listing

### Canonical Name

**Instrument Listing**

### Business Definition

An Instrument Listing represents the authorization for a specific Instrument to be traded on a particular Exchange, Market, and Trading Board.

### Business Purpose

Separates the business identity of an Instrument from the operational environment in which it is traded.

### Business Responsibility

An Instrument Listing defines:

- where an Instrument is traded;
- under which Market and Trading Board it operates;
- the trading symbol assigned by the Exchange;
- the listing validity period.

### Business Context

A single Instrument may have multiple Listings across different Exchanges or Markets.

Each Listing represents one trading venue.

### Owning Domain

Market Domain

### Aggregate

Instrument

### Lifecycle

Managed

Listings may be created, suspended, resumed, transferred, or terminated independently of the Instrument itself.

### Related Attributes

- id
- instrument_id
- exchange_id
- market_id
- trading_board_id
- trading_symbol
- listing_date
- delisting_date
- status

### Related Relationships

- Listing belongs to one Instrument.
- Listing belongs to one Exchange.
- Listing belongs to one Market.
- Listing belongs to one Trading Board.
- Listing owns Daily Market Data records.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Identity Standard

---

## Trading Calendar

### Canonical Name

**Trading Calendar**

### Business Definition

A Trading Calendar defines the official schedule governing trading sessions for an Exchange, Market, or Trading Board.

### Business Purpose

Provides the authoritative business calendar used to determine trading days, holidays, and operational sessions.

### Business Responsibility

A Trading Calendar specifies:

- trading dates;
- non-trading days;
- public holidays;
- exceptional trading sessions;
- early closing schedules.

### Business Context

Trading Calendars ensure consistent interpretation of market activity across all services, analytical processes, and historical datasets.

### Owning Domain

Market Domain

### Aggregate

Trading Calendar

### Lifecycle

Managed

Calendar entries are maintained periodically to reflect future trading schedules while preserving historical records.

### Related Attributes

- id
- exchange_id
- market_id
- trading_date
- session_status
- is_trading_day
- remarks

### Related Relationships

- Trading Calendar belongs to one Exchange.
- Trading Calendar may apply to one Market.
- Trading Calendar governs Daily Market Data generation.
- Trading Calendar supports market scheduling services.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

## Daily Market Data

### Canonical Name

**Daily Market Data**

### Business Definition

Daily Market Data represents the official end-of-day market information collected for an Instrument Listing during a single trading session.

### Business Purpose

Provides the authoritative historical market dataset used for technical analysis, quantitative research, portfolio valuation, backtesting, reporting, and machine learning.

### Business Responsibility

Daily Market Data records capture the official market outcome for a trading day, including:

- price movements;
- trading activity;
- market liquidity;
- trading statistics;
- settlement information.

These records constitute the historical market memory of the Phoenix Platform.

### Business Context

Each record corresponds to exactly one Instrument Listing and one Trading Day.

Daily Market Data is immutable after the official market close, except where corrections are issued by an authorized market authority.

### Owning Domain

Market Domain

### Aggregate

Market Data

### Lifecycle

Immutable

Once validated and published, historical records are preserved permanently to ensure analytical reproducibility and regulatory traceability.

### Related Attributes

- id
- instrument_listing_id
- trading_date
- open_price
- high_price
- low_price
- close_price
- adjusted_close_price
- traded_volume
- traded_value
- trade_count
- created_at

### Related Relationships

- Daily Market Data belongs to one Instrument Listing.
- Daily Market Data references one Trading Calendar entry.
- Daily Market Data serves as the primary input for Indicators.
- Daily Market Data supports Feature Engineering.
- Daily Market Data is consumed by Strategy and Machine Learning services.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard
- Enterprise Data Type Standard

---

## Corporate Action

### Canonical Name

**Corporate Action**

### Business Definition

A Corporate Action represents an official event initiated by a Company that affects its financial instruments or the rights of investors.

### Business Purpose

Captures business events that may influence instrument valuation, historical price adjustments, ownership rights, or investment decisions.

### Business Responsibility

Corporate Actions record events such as:

- cash dividends;
- stock dividends;
- bonus issues;
- stock splits;
- reverse stock splits;
- rights offerings;
- capital increases;
- mergers and acquisitions;
- symbol changes;
- delistings.

### Business Context

Corporate Actions are published by the issuing Company and may affect one or more Instrument Listings.

These events are essential for maintaining accurate historical market data and supporting adjusted-price calculations.

### Owning Domain

Market Domain

### Aggregate

Corporate Action

### Lifecycle

Immutable

Once officially announced and validated, Corporate Action records become permanent components of the enterprise historical record.

### Related Attributes

- id
- company_id
- instrument_listing_id
- action_type
- announcement_date
- effective_date
- record_date
- description
- status

### Related Relationships

- Corporate Action belongs to one Company.
- Corporate Action may affect one or more Instrument Listings.
- Corporate Action may trigger adjustments to Daily Market Data.
- Corporate Action supports historical price reconstruction and investment analytics.

### Governing Standards

- Enterprise Entity Standard
- Enterprise Attribute Standard
- Enterprise Identity Standard
- Enterprise Data Dictionary Standard

---

# 11. Governance

The Entity Dictionary is governed as the authoritative registry of enterprise business entities.

Every entity shall:

- represent a unique business concept;
- maintain a single canonical business definition;
- be approved through the Architecture Governance process;
- comply with all enterprise information standards;
- remain consistent with the Business Glossary, Domain Model, and Enterprise Data Dictionary.

Any modification to an approved entity definition shall undergo impact analysis and architectural review before adoption.

---

# 12. Related Documents

- BusinessGlossary
- EntityCatalog
- AttributeCatalog
- AttributeDictionary
- RelationshipDictionary
- AggregateCatalog
- AggregateAttributeMatrix
- CanonicalDomainModel
- EnterpriseAttributeStandard
- EnterpriseEntityStandard
- EnterpriseDataDictionaryStandard

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial version. |
| 2026.2 | 2026-07-22 | Rewritten as the canonical semantic dictionary for enterprise business entities, aligned with the Enterprise Information Architecture and Single Source of Truth principles. |

---

# 13. Architectural Principles

The Entity Dictionary is founded on the following enterprise architectural principles.

## Principle 1 — Business First

Entities represent business concepts rather than database tables, software classes, or implementation artifacts.

---

## Principle 2 — Canonical Definition

Every business entity shall have exactly one canonical definition throughout the Phoenix Platform.

---

## Principle 3 — Single Source of Truth

The Entity Dictionary serves as the authoritative semantic reference for all enterprise entities.

Logical models, physical database models, APIs, services, and documentation shall reference entity definitions from this document rather than redefining them.

---

## Principle 4 — Technology Independence

Entity definitions shall remain independent of:

- relational databases;
- programming languages;
- messaging technologies;
- service implementations;
- persistence mechanisms.

---

## Principle 5 — Enterprise Consistency

All entities shall remain consistent with:

- Business Glossary
- Enterprise Attribute Standard
- Attribute Dictionary
- Relationship Dictionary
- Canonical Domain Model
- Enterprise Data Dictionary Standard

---

## Principle 6 — Domain Ownership

Each entity belongs to exactly one business domain and is governed by a single owning Aggregate.

Cross-domain reuse shall occur through references rather than duplicate definitions.

---

# 14. Traceability

Each entity documented within this dictionary shall be traceable across the complete Enterprise Information Architecture.

| Enterprise Artifact | Traceability Purpose |
|---------------------|----------------------|
| Business Glossary | Canonical business terminology |
| Entity Catalog | Enterprise registration |
| Attribute Catalog | Reusable business attributes |
| Attribute Dictionary | Attribute semantics |
| Relationship Dictionary | Business relationships |
| Aggregate Catalog | Aggregate ownership |
| Aggregate Attribute Matrix | Attribute allocation |
| Canonical Domain Model | Business architecture |
| Logical Database Model | Logical representation |
| Physical Database Model | Physical implementation |

This traceability model ensures complete consistency from business architecture through physical implementation while preserving the Single Source of Truth principle.

---

# 15. Future Extensions

The Entity Dictionary is intentionally extensible and is expected to evolve as the Phoenix Platform expands.

Future editions may include additional domains such as:

- Portfolio Domain
- Risk Management Domain
- Strategy Domain
- Indicator Domain
- Reporting Domain
- Machine Learning Domain
- News & Sentiment Domain
- Economic Data Domain
- Cryptocurrency Domain
- Forex Domain

New entities shall follow the documentation structure and governance rules defined by this standard.

---

# 16. Compliance

Compliance with this dictionary is mandatory.

Architecture reviews shall verify that:

- every business entity is documented before implementation;
- no duplicate business definitions exist;
- entity semantics remain technology independent;
- ownership and aggregate boundaries are respected;
- all related enterprise artifacts remain synchronized.

Any deviation from this dictionary requires formal approval through the Architecture Governance process.

---

