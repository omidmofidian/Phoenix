# Entity Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-002 |
| Document | EntityCatalog |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Model |
| Owner | Enterprise Architecture |
| Depends On | CanonicalDomainModel, BoundedContextDefinition, EntityClassification |
| Consumed By | AggregateCatalog, AggregateDefinitions, ConceptualDataModel, LogicalDataModel |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

The Entity Catalog defines the canonical business entities of the Phoenix Platform.

It serves as the authoritative inventory of all enterprise business entities and establishes their ownership within the Enterprise Domain Model.

Each business entity belongs to exactly one Domain and represents one business responsibility.

The Entity Catalog provides the foundation for aggregate design, conceptual modeling, logical data modeling, service boundaries, and business governance.

---

# 2. Scope

This document defines:

- Canonical business entities
- Domain ownership
- Entity classification
- Aggregate ownership
- Business responsibilities
- Lifecycle characteristics

This document does not define:

- Database tables
- Columns
- Data types
- Primary keys
- Foreign keys
- APIs
- Service implementations

These artifacts are defined in subsequent design documents.

---

# 3. Entity Classification Principles

Every entity defined in the Phoenix Platform shall comply with the following principles.

## EC-001 — Single Ownership

Each entity shall belong to exactly one Business Domain.

---

## EC-002 — Single Responsibility

Each entity represents one and only one business concept.

---

## EC-003 — Technology Independence

Entity definitions are independent of database technologies, programming languages, and service implementations.

---

## EC-004 — Stable Business Meaning

The business meaning of an entity shall remain stable across platform versions.

---

## EC-005 — Aggregate Membership

Every entity shall belong to exactly one Aggregate.

---

# 4. Canonical Entity Categories

Entities are classified according to their architectural responsibility.

| Category | Description |
|----------|-------------|
| Reference Entity | Enterprise reference and classification data |
| Master Entity | Enterprise business master data |
| Transaction Entity | Operational business transactions |
| Event Entity | Historical business events |
| Derived Entity | Analytical and calculated information |
| Configuration Entity | Platform configuration data |
| Integration Entity | External system integration metadata |

---

# 5. Foundation Business Domains

The current Enterprise Domain Model consists of the following primary domains:

- Reference Domain
- Core Domain
- Market Domain
- Integration Domain
- Configuration Domain
- Audit Domain
- Reporting Domain

Additional analytical domains may be introduced in future architectural iterations without affecting the ownership of existing entities.

---

# 6. Reference Domain

Reference entities describe stable business concepts that are shared across the enterprise.

| Entity | Category | Aggregate | Lifecycle | Business Purpose |
|---------|----------|-----------|-----------|------------------|
| Market | Reference | Market | Stable | Defines financial markets |
| Exchange | Reference | Exchange | Stable | Defines trading exchanges |
| TradingBoard | Reference | TradingBoard | Stable | Defines exchange trading boards |
| AssetClass | Reference | AssetClass | Stable | Classifies financial assets |
| InstrumentType | Reference | InstrumentType | Stable | Classifies tradable instruments |
| Sector | Reference | Sector | Stable | Defines economic sectors |
| Industry | Reference | Industry | Stable | Defines industries |
| SubIndustry | Reference | SubIndustry | Stable | Defines detailed industry classifications |
| TradingCalendar | Reference | TradingCalendar | Stable | Defines trading calendars |
| TradingSession | Reference | TradingSession | Stable | Defines market trading sessions |
| Currency | Reference | Currency | Stable | Defines supported currencies |
| Country | Reference | Country | Stable | Defines countries |
| Language | Reference | Language | Stable | Defines supported languages |
| TimeZone | Reference | TimeZone | Stable | Defines business time zones |

---

# 7. Core Domain

Core entities represent the fundamental business objects managed by the platform.

| Entity | Category | Aggregate | Lifecycle | Business Purpose |
|---------|----------|-----------|-----------|------------------|
| Company | Master | Company | Long-lived | Represents legal business entities |
| Instrument | Master | Instrument | Long-lived | Represents tradable financial instruments |
| InstrumentListing | Master | InstrumentListing | Long-lived | Represents the listing of an instrument on a trading board |

---

# 8. Market Domain

Market entities capture historical market observations and events.

| Entity | Category | Aggregate | Lifecycle | Business Purpose |
|---------|----------|-----------|-----------|------------------|
| DailyMarketData | Transaction | DailyMarketData | Historical | Stores daily trading information |
| CorporateAction | Event | CorporateAction | Historical | Records corporate events affecting instruments |

---

# 5. Canonical Entity Catalog

The Canonical Entity Catalog defines the enterprise business entities owned by each Domain.

Each entity:

- belongs to exactly one Domain;
- belongs to exactly one Aggregate;
- has exactly one business owner;
- has one defined lifecycle;
- follows the Enterprise Identity Standard;
- shall never be duplicated across Domains.

This catalog is independent of physical databases, services, APIs, and implementation technologies.

---

## 5.1 Reference Domain

### Market Aggregate

- Market
- Exchange
- TradingBoard

### Trading Calendar Aggregate

- TradingCalendar
- TradingSession

### Classification Aggregate

- AssetClass
- InstrumentType
- Sector
- Industry
- SubIndustry

### Geographic Aggregate

- Country
- TimeZone

### Localization Aggregate

- Language

### Financial Aggregate

- Currency

---

## 5.2 Core Business Domain

### Company Aggregate

- Company

### Instrument Aggregate

- Instrument

### Instrument Listing Aggregate

- InstrumentListing

---

## 5.3 Market Domain

### Daily Market Data Aggregate

- DailyMarketData

### Corporate Action Aggregate

- CorporateAction

---

## 5.4 Integration Domain

### Data Provider Aggregate

- DataProvider
- DataSource

### External Identifier Aggregate

- ExternalIdentifier

### Import Aggregate

- ImportSession
- ImportBatch

---

## 5.5 Configuration Domain

### Configuration Aggregate

- ConfigurationGroup
- ConfigurationItem

---

## 5.6 Audit Domain

### Audit Aggregate

- AuditSession
- AuditEvent

---

## 5.7 Reporting Domain

### Reporting Aggregate

- ReportDefinition
- ReportSnapshot

---

## 5.8 Planned Future Domains

The following domains are part of the long-term Phoenix roadmap and will be introduced incrementally.

### Feature Engineering Domain

- FeatureDefinition
- FeatureValue

### Analytics Domain

- Analysis
- Backtest
- Experiment

### Artificial Intelligence Domain

- ModelVersion
- Prediction

### Strategy Domain

- Strategy
- StrategyVersion
- StrategyParameter

### Ranking Domain

- Opportunity
- OpportunityScore

### Portfolio Domain

- Portfolio
- Position
- Trade

### Risk Management Domain

- RiskModel
- RiskAssessment

---

# 6. Entity Ownership Rules

The following rules govern ownership of all business entities.

## EC-006 — Single Domain Ownership

Every entity shall belong to exactly one Business Domain.

Shared ownership is prohibited.

---

## EC-007 — Aggregate Membership

Every entity shall belong to exactly one Aggregate.

Aggregate membership defines the entity's lifecycle and consistency boundary.

---

## EC-008 — Business Identity

Every entity shall have one canonical business identity.

External identifiers shall be managed exclusively by the Integration Domain.

---

## EC-009 — Lifecycle Ownership

The owning Aggregate is responsible for:

- creation;
- validation;
- modification;
- archival;
- retirement.

---

## EC-010 — Reference Integrity

Reference entities may be shared across domains.

Operational entities shall reference reference entities but shall never own them.

---

# 7. Entity Dependency Principles

Entity relationships shall follow the enterprise dependency model.

The following dependency rules apply.

```text
Reference Domain
        │
        ▼
Core Domain
        │
        ▼
Market Domain
        │
        ▼
Reporting Domain
```

Supporting domains interact as follows.

- Integration Domain communicates with external systems.
- Configuration Domain provides platform configuration.
- Audit Domain observes business activities.
- Reporting Domain consumes operational information without modifying it.

---

# 8. Traceability

This document shall remain consistent with the following architectural artifacts.

| Artifact | Purpose |
|----------|---------|
| CanonicalDomainModel | Enterprise domain structure |
| BoundedContextDefinition | Domain ownership boundaries |
| EntityClassification | Enterprise entity taxonomy |
| AggregateCatalog | Aggregate ownership |
| AggregateDefinitions | Aggregate composition |
| AggregateAttributeMatrix | Aggregate attributes |
| ReferenceDataModel | Enterprise reference entities |
| ConceptualDataModel | Business information model |
| LogicalDataModel | Logical entity relationships |
| EnterpriseDataDictionary | Canonical business definitions |

---

# 9. Architectural Constraints

The following constraints are mandatory.

- Every entity belongs to exactly one Domain.
- Every entity belongs to exactly one Aggregate.
- Every Aggregate has one Aggregate Root.
- Business entities shall remain technology independent.
- Entity ownership shall not overlap.
- Reference entities shall not contain transactional data.
- Operational entities shall not duplicate reference data.
- Derived entities shall never modify operational entities.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version |
| 2026.2 | 2026-07-18 | Refactored to align with the Enterprise Domain Architecture, Canonical Domain Model, Aggregate Catalog, Entity Classification, and Reference Data Model. Removed obsolete domains and synchronized entity ownership with the current Phoenix architecture. |