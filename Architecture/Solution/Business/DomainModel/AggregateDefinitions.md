# Aggregate Definitions

| Property | Value |
|----------|-------|
| Artifact ID | ART-011 |
| Project | Phoenix Platform |
| Document | AggregateDefinitions |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Architecture Layer | Domain Model |
| Owner | Architecture Team |
| Sprint | Sprint 2 |
| Depends On | CanonicalDomainModel, EntityCatalog, CanonicalBusinessRules, ServiceContextMap, ConceptualRelationships |
| Consumed By | LogicalDatabaseModel, CanonicalERD, Service Design |
| Last Updated | 2026-07-04 |

---

# 1. Purpose

This document defines the canonical aggregates of the Phoenix Platform.

Aggregates establish consistency boundaries within the domain model and identify the aggregate root responsible for enforcing business invariants.

Aggregate definitions are independent of persistence technologies and implementation details.

---

# 2. Objectives

The objectives of this document are to:

- Define aggregate boundaries.
- Identify aggregate roots.
- Assign aggregate ownership.
- Preserve business consistency.
- Support transactional integrity.
- Provide input for logical database design.

---

# 3. Aggregate Design Principles

## AGG-001 — Single Aggregate Root

Every aggregate shall have exactly one Aggregate Root.

---

## AGG-002 — Consistency Boundary

Business consistency shall be guaranteed within an aggregate.

---

## AGG-003 — Reference by Identity

Aggregates shall reference other aggregates by identity rather than by direct object ownership.

---

## AGG-004 — Service Ownership

Each aggregate shall belong to exactly one owning service.

---

## AGG-005 — Technology Independence

Aggregate definitions shall not depend on persistence mechanisms.

---

# 4. Canonical Aggregate Catalog

| Aggregate | Aggregate Root | Owner Service |
|------------|----------------|---------------|
| Reference Catalog | ReferenceCatalog | Reference Service |
| Instrument | Instrument | Instrument Service |
| Market Data | MarketData | Market Service |
| Feature Set | FeatureSet | Feature Service |
| Analysis | Analysis | Analytics Service |
| AI Model | MLModel | AI Service |
| Strategy | Strategy | Strategy Service |
| Opportunity | Opportunity | Ranking Service |
| Portfolio | Portfolio | Portfolio Service |
| Risk Profile | RiskAssessment | Risk Service |
| Report | Report | Reporting Service |
| Notification | Notification | Notification Service |
| Configuration | ConfigurationItem | Configuration Service |
| Audit Log | AuditEntry | Audit Service |
| Order | Order | Execution Service |

---

# 5. Aggregate Specifications

## 5.1 Reference Catalog

### Aggregate Root

ReferenceCatalog

### Purpose

Maintains canonical reference data used throughout the platform.

### Owned Entities

- Exchange
- Market
- Currency
- Country
- TradingCalendar

### Referenced Aggregates

None

### Owner Service

Reference Service

---

## 5.2 Instrument

### Aggregate Root

Instrument

### Purpose

Represents a tradable financial instrument.

### Owned Entities

- Symbol
- Asset

### Referenced Aggregates

- Reference Catalog

### Owner Service

Instrument Service

---

## 5.3 Market Data

### Aggregate Root

MarketData

### Purpose

Represents validated market information collected from external providers.

### Owned Entities

- PriceHistory
- CorporateAction

### Referenced Aggregates

- Instrument

### Owner Service

Market Service

---

## 5.4 Feature Set

### Aggregate Root

FeatureSet

### Purpose

Represents analytical features derived from market data.

### Owned Entities

- Feature
- Indicator
- Factor

### Referenced Aggregates

- Market Data
- Instrument

### Owner Service

Feature Service

---

## 5.5 Analysis

### Aggregate Root

Analysis

### Purpose

Represents quantitative analysis and backtesting results.

### Owned Entities

- AnalysisResult
- BacktestResult
- StatisticalModel

### Referenced Aggregates

- Feature Set

### Owner Service

Analytics Service

---

## 5.6 AI Model

### Aggregate Root

MLModel

### Purpose

Represents machine learning models and prediction results.

### Owned Entities

- Prediction
- TrainingDataset

### Referenced Aggregates

- Analysis

### Owner Service

AI Service

---

## 5.7 Strategy

### Aggregate Root

Strategy

### Purpose

Defines trading strategies and signal generation.

### Owned Entities

- TradingSignal

### Referenced Aggregates

- AI Model
- Analysis

### Owner Service

Strategy Service

---

## 5.8 Opportunity

### Aggregate Root

Opportunity

### Purpose

Represents evaluated investment opportunities.

### Owned Entities

- OpportunityScore

### Referenced Aggregates

- Strategy
- Risk Profile

### Owner Service

Ranking Service

---

## 5.9 Portfolio

### Aggregate Root

Portfolio

### Purpose

Represents an investment portfolio and its holdings.

### Owned Entities

- Position
- Transaction

### Referenced Aggregates

- Instrument
- Opportunity

### Owner Service

Portfolio Service

---

## 5.10 Risk Profile

### Aggregate Root

RiskAssessment

### Purpose

Represents portfolio and position risk evaluations.

### Owned Entities

- RiskModel

### Referenced Aggregates

- Portfolio
- Market Data

### Owner Service

Risk Service

---

## 5.11 Report

### Aggregate Root

Report

### Purpose

Represents analytical reports and dashboards.

### Owned Entities

- Dashboard

### Referenced Aggregates

All business aggregates (read-only)

### Owner Service

Reporting Service

---

## 5.12 Notification

### Aggregate Root

Notification

### Purpose

Represents user notifications generated from business events.

### Owned Entities

- Alert

### Referenced Aggregates

Business Events

### Owner Service

Notification Service

---

## 5.13 Configuration

### Aggregate Root

ConfigurationItem

### Purpose

Represents platform configuration managed centrally.

### Owned Entities

None

### Referenced Aggregates

None

### Owner Service

Configuration Service

---

## 5.14 Audit Log

### Aggregate Root

AuditEntry

### Purpose

Represents immutable audit records.

### Owned Entities

None

### Referenced Aggregates

Business Events

### Owner Service

Audit Service

---

## 5.15 Order

### Aggregate Root

Order

### Purpose

Represents trade execution requests and execution lifecycle.

### Owned Entities

- Execution

### Referenced Aggregates

- Portfolio
- Strategy
- Risk Profile

### Owner Service

Execution Service

---

# 6. Aggregate Interaction Rules

- Aggregates shall communicate through references or service contracts.
- Aggregate boundaries shall preserve transactional consistency.
- Cross-aggregate updates shall be coordinated through application services or domain events.
- Aggregate roots are the only entry points for modifying aggregate state.

---

# 7. Traceability

Every aggregate shall be traceable to:

- Business Capability Map
- Bounded Context Definition
- Canonical Domain Model
- Entity Catalog
- Canonical Business Rules
- Service Context Map
- Conceptual Relationships

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |