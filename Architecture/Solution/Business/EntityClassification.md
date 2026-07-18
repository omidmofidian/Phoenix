# Entity Classification

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ENT-001 |
| Document | EntityClassification |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Architecture Layer | Enterprise Knowledge |
| Owner | Enterprise Architecture |
| Depends On | KnowledgeDrivenArchitecture, PlatformArchitectureVision, CanonicalDomainModel |
| Used By | ReferenceDomainArchitecture, ReferenceDataModel, LogicalDatabaseModel, PhysicalDatabaseModel, EnterpriseDataDictionary |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical classification of business entities within the Phoenix Platform.

Entity classification provides a common architectural language for identifying the role, responsibility, ownership, and lifecycle of every enterprise entity.

Rather than classifying entities according to implementation technologies or database structures, Phoenix classifies entities according to their business purpose and architectural responsibility.

This classification establishes a stable foundation for domain modeling, service boundaries, database design, governance, and future platform evolution.

---

# 2. Objectives

The objectives of this document are to:

- Establish a canonical taxonomy for enterprise entities.
- Standardize entity responsibilities across all business domains.
- Support Domain-Driven Design (DDD) through explicit business ownership.
- Improve consistency across architecture, design, and implementation artifacts.
- Provide traceability from business knowledge to physical database objects.
- Support long-term maintainability and architectural governance.

---

# 3. Architectural Principles

Entity classification within Phoenix follows the following principles.

## EC-001 — Business Before Technology

Entities are classified according to business meaning rather than implementation technology.

---

## EC-002 — Single Architectural Responsibility

Each entity belongs to exactly one primary architectural category.

Secondary responsibilities shall be represented through relationships rather than multiple classifications.

---

## EC-003 — Stable Classification

Entity classifications are expected to remain stable even when technologies, services, or database implementations evolve.

---

## EC-004 — Explicit Ownership

Every entity shall have a clearly defined business owner and belong to exactly one business domain.

---

## EC-005 — Canonical Representation

Every business concept shall have one canonical enterprise entity.

Duplicate representations are prohibited unless explicitly approved through an Architecture Decision Record (ADR).

---

## EC-006 — Traceability

Every entity shall be traceable to:

- Business Knowledge
- Business Capability
- Domain Model
- Service Architecture
- Data Model
- Physical Database

---

# 4. Entity Classification Framework

Phoenix classifies enterprise entities into eight architectural categories.

| Category | Purpose |
|----------|---------|
| Reference Entity | Shared enterprise reference information |
| Master Entity | Core business objects with long-term identity |
| Transaction Entity | Business events and operational records |
| Analytical Entity | Derived analytical information |
| Configuration Entity | Platform configuration and runtime behavior |
| Operational Entity | Platform operational activities |
| Integration Entity | External system interaction and identity mapping |
| Audit Entity | Traceability, history, and compliance information |

Each entity belongs to one—and only one—primary architectural category.

Subsequent sections define the characteristics, ownership rules, lifecycle, and dependency rules for each category.

---

# 5. Entity Categories

## 5.1 Reference Entities

### Purpose

Reference Entities define stable enterprise reference information shared across multiple business domains.

They provide standardized classifications, taxonomies, codes, calendars, and business vocabularies that support consistent interpretation of operational data.

### Characteristics

- Low rate of change
- Enterprise-wide usage
- Shared by multiple domains
- Technology independent
- Highly governed
- Long lifecycle

### Typical Examples

- Exchange
- Market
- Board
- Country
- Currency
- Language
- TimeZone
- Industry
- Sector
- InstrumentType
- TradingCalendar
- TradingSession

---

## 5.2 Master Entities

### Purpose

Master Entities represent the primary business objects managed by the enterprise.

They maintain long-term business identity and form the foundation of operational processing.

### Characteristics

- Long-lived identity
- Business ownership
- Frequently referenced
- Version controlled where appropriate
- Canonical representation

### Typical Examples

- Company
- FinancialInstrument
- InstrumentListing
- Investor
- Organization
- Portfolio

---

## 5.3 Transaction Entities

### Purpose

Transaction Entities record business events that occur over time.

They capture immutable operational facts produced during normal business activities.

### Characteristics

- Event-oriented
- Time dependent
- Append-only whenever practical
- Historically preserved
- Business auditable

### Typical Examples

- DailyMarketData
- CorporateAction
- Order
- Trade
- PositionMovement
- PortfolioTransaction
- CashTransaction

---

## 5.4 Analytical Entities

### Purpose

Analytical Entities represent information derived from business data through calculation, statistical analysis, quantitative models, or artificial intelligence.

They never replace or modify operational business data.

### Characteristics

- Derived information
- Reproducible
- Disposable
- Version dependent
- Model dependent

### Typical Examples

- IndicatorDefinition
- IndicatorValue
- FeatureDefinition
- FeatureValue
- Prediction
- Signal
- StrategyResult
- RiskMetric
- PortfolioScore

---

## 5.5 Configuration Entities

### Purpose

Configuration Entities define how the platform behaves at runtime without modifying application code.

### Characteristics

- Environment independent
- Runtime configurable
- Centrally governed
- Business neutral

### Typical Examples

- ConfigurationGroup
- ConfigurationItem
- FeatureFlag
- SystemParameter
- EnvironmentProfile

---

## 5.6 Operational Entities

### Purpose

Operational Entities support execution, monitoring, scheduling, and administration of the platform.

They are required for platform operation but do not represent financial business concepts.

### Characteristics

- Infrastructure oriented
- Operational lifecycle
- System managed
- Independent from business knowledge

### Typical Examples

- Job
- JobExecution
- SchedulerTask
- FileImport
- ProcessingQueue
- Notification
- CacheEntry

---

## 5.7 Integration Entities

### Purpose

Integration Entities isolate Phoenix from external systems by managing external identities, providers, interfaces, and data exchange processes.

### Characteristics

- External system mapping
- Provider specific
- Replaceable
- Loosely coupled
- Boundary focused

### Typical Examples

- DataProvider
- ExternalIdentifier
- ProviderConnection
- ImportSession
- ExportSession
- APIEndpoint
- IntegrationMapping

---

## 5.8 Audit Entities

### Purpose

Audit Entities preserve enterprise traceability, historical accountability, and regulatory compliance.

They provide complete visibility into business and technical activities without owning business processes.

### Characteristics

- Append-only
- Immutable
- Time-stamped
- Compliance driven
- Independent from operational logic

### Typical Examples

- AuditEvent
- AuditSession
- ChangeHistory
- LoginHistory
- SecurityEvent
- DataAccessLog

---

# 6. Entity Classification Matrix

| Category | Business Owner | Primary Purpose | Shared Across Domains | Historical | Derived | Typical Lifecycle |
|----------|----------------|-----------------|----------------------|------------|---------|-------------------|
| Reference | Reference Domain | Enterprise reference knowledge | Yes | Yes | No | Very Long |
| Master | Master Domain | Core business identity | Yes | Yes | No | Long |
| Transaction | Business Domains | Business events | No | Yes | No | Permanent |
| Analytical | Analytics Domain | Derived business intelligence | Yes | Optional | Yes | Regenerable |
| Configuration | Configuration Domain | Runtime behavior | Yes | Optional | No | Long |
| Operational | Platform Operations | Platform execution | Limited | Optional | No | Operational |
| Integration | Integration Domain | External system interaction | Limited | Optional | No | Operational |
| Audit | Audit Domain | Traceability and compliance | Yes | Yes | No | Permanent |

---

# 7. Dependency Rules

Entity dependencies shall follow the architectural hierarchy below.

```text
Reference
      │
      ▼
Master
      │
      ▼
Transaction
      │
      ▼
Analytical
```

The following dependency rules govern all entity relationships.

- Reference Entities shall not depend on any other entity category.
- Master Entities may reference only Reference Entities.
- Transaction Entities may reference Reference and Master Entities.
- Analytical Entities may reference Reference, Master, and Transaction Entities.
- Configuration Entities should remain independent from business entities whenever practical.
- Operational Entities shall not own business knowledge.
- Integration Entities shall isolate external systems from enterprise business entities.
- Audit Entities may observe all categories but shall never modify business data.

Circular dependencies between entity categories are prohibited.

---

# 8. Ownership Principles

Every enterprise entity shall have exactly one authoritative owner.

Ownership defines responsibility for:

- Business semantics
- Data stewardship
- Validation rules
- Lifecycle management
- Governance

Shared ownership is prohibited.

Cross-domain collaboration shall occur through published interfaces rather than shared ownership.

---

# 9. Lifecycle Principles

Each entity category follows its own lifecycle.

| Category | Lifecycle |
|----------|-----------|
| Reference | Stable and slowly evolving |
| Master | Long-lived with controlled updates |
| Transaction | Immutable after business completion whenever practical |
| Analytical | Fully reproducible and regenerable |
| Configuration | Version-controlled |
| Operational | Managed operationally |
| Integration | Managed according to external integration lifecycle |
| Audit | Append-only and permanently retained |

---

# 10. Naming Principles

Entity names shall comply with the Phoenix Enterprise Naming Standard.

The following rules apply.

- Entity names shall represent business concepts.
- Singular nouns shall always be used.
- Business terminology shall take precedence over technical terminology.
- Database implementation details shall never influence entity names.
- Entity names shall remain stable across all architectural layers.

Examples

- Exchange
- Market
- Board
- Company
- FinancialInstrument
- DailyMarketData
- CorporateAction

---

# 11. Related Documents

## Vision

- PlatformArchitectureVision.md
- KnowledgeDrivenArchitecture.md
- ArchitecturalPrinciples.md
- QualityAttributes.md

## Domain Architecture

- BusinessCapabilityMap.md
- CanonicalDomainModel.md
- DomainResponsibilities.md
- AggregateDefinitions.md

## Design

- ReferenceDomainArchitecture.md
- ReferenceDataModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- EnterpriseDataDictionary.md

## Governance

- Architecture Decision Records (ADR)

---

# 12. Success Criteria

The entity classification is considered successful when:

- Every enterprise entity belongs to exactly one architectural category.
- Entity ownership is explicit and unambiguous.
- Business concepts remain independent of implementation technologies.
- Entity dependencies comply with the approved architectural hierarchy.
- All architecture and design artifacts consistently apply this classification.
- New entity types can be introduced without redesigning the classification framework.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-18 | Complete redesign aligned with the Phoenix Enterprise Architecture and Knowledge-Driven Architecture. |