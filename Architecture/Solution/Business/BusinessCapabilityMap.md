# Business Capability Map

| Property | Value |
|----------|-------|
| Artifact ID | BUS-001 |
| Project | Phoenix Platform |
| Document | BusinessCapabilityMap |
| Version | 2026.2 |
| Status | Approved |
| Classification | Business Architecture |
| Architecture Layer | Business Architecture |
| Owner | Phoenix Architecture Board |
| Depends On | ProjectOverview.md, PlatformArchitectureVision.md, ArchitecturalPrinciples.md |
| Used By | Domain Architecture, Data Architecture, Service Architecture |
| Last Updated | 2026-07-17 |

---

# 1. Purpose

This document defines the canonical business capabilities of the Phoenix Platform.

Business capabilities describe **what the enterprise does**, independent of organizational structure, software implementation, databases, technologies, deployment models, or programming languages.

The Business Capability Model represents the highest level of the Business Architecture and serves as the foundation for every subsequent architectural artifact within the Phoenix repository.

All domains, aggregates, entities, services, databases, APIs, and implementation components shall ultimately trace back to one or more approved business capabilities.

---

# 2. Scope

This document defines:

- Enterprise business capabilities
- Capability hierarchy
- Capability ownership
- Capability boundaries
- Capability dependencies
- Enterprise business responsibilities

This document does **not** define:

- Domains
- Bounded Contexts
- Services
- Databases
- Tables
- APIs
- Software Components
- Technical Infrastructure

These artifacts are specified in lower architectural layers.

---

# 3. Architectural Position

The Business Capability Map occupies the highest level of the Business Architecture.

```text
Knowledge
        │
        ▼
Architecture Vision
        │
        ▼
Architectural Principles
        │
        ▼
Business Capability Map
        │
        ▼
Domain Architecture
        │
        ▼
Data Architecture
        │
        ▼
Service Architecture
        │
        ▼
Application Architecture
```

Business capabilities represent stable enterprise responsibilities from which every lower architectural layer is derived.

---

# 4. Business Capability Principles

Every business capability shall satisfy the following principles.

## BCP-001 — Business-Oriented

Capabilities represent business functions rather than technical solutions.

---

## BCP-002 — Technology Independent

Capabilities shall remain independent of programming languages, databases, frameworks, infrastructure, or deployment technologies.

---

## BCP-003 — Stable

Business capabilities shall evolve significantly more slowly than implementation technologies.

---

## BCP-004 — Independent

Each capability owns a distinct business responsibility.

Business capabilities shall not overlap.

---

## BCP-005 — Complete

The complete collection of capabilities shall describe the entire business scope of the Phoenix Platform.

---

## BCP-006 — Traceable

Every lower-layer architectural artifact shall be traceable to one or more business capabilities.

---

## BCP-007 — Evolvable

New capabilities shall be introduced through architectural extension without disrupting existing capabilities.

---

# 5. Enterprise Capability Categories

The Phoenix Platform organizes enterprise capabilities into the following categories.

| Category | Purpose |
|----------|---------|
| Enterprise Management | Enterprise administration and governance |
| Market Intelligence | Market information acquisition and management |
| Investment Intelligence | Analytical and decision-support capabilities |
| Portfolio & Trading | Investment execution and portfolio management |
| Platform Services | Cross-cutting enterprise capabilities |
| Enterprise Support | Operational and governance services |

These categories provide the organizational framework for all business capabilities defined within the platform.

---

# 6. Enterprise Business Capabilities

## ECM-001 — Enterprise Management

### Purpose

Provides enterprise governance, identity management, organizational structure, and platform administration.

### Responsibilities

- Identity Management
- Authentication
- Authorization
- Role Management
- User Management
- Organization Management
- Administrative Governance

---

## MKT-001 — Market Intelligence

### Purpose

Acquires, validates, standardizes, and manages financial market information from internal and external sources.

### Responsibilities

- Market Data Acquisition
- Market Data Validation
- Instrument Management
- Exchange Management
- Trading Calendar
- Corporate Actions
- Financial Statements
- Market Metadata

---

## REF-001 — Reference Data Management

### Purpose

Maintains enterprise reference information shared across all business capabilities.

### Responsibilities

- Countries
- Currencies
- Markets
- Exchanges
- Languages
- Time Zones
- Classification Systems
- Industry Classifications
- Sector Classifications
- Business Taxonomies

Reference Data represents the canonical shared vocabulary of the enterprise.

---

## ANA-001 — Investment Intelligence

### Purpose

Transforms validated business information into analytical knowledge supporting investment decisions.

### Responsibilities

- Technical Indicators
- Feature Engineering
- Statistical Analysis
- Quantitative Models
- Opportunity Ranking
- Risk Evaluation
- Decision Support

---

## AI-001 — Artificial Intelligence

### Purpose

Provides intelligent analytical capabilities based on enterprise knowledge and historical business information.

### Responsibilities

- Machine Learning
- Prediction Models
- Pattern Recognition
- Market Forecasting
- Portfolio Optimization
- Sentiment Analysis
- Natural Language Processing
- Explainable AI

AI capabilities assist business decision-making without replacing enterprise business rules.

---

## INV-001 — Portfolio & Investment Management

### Purpose

Supports investment lifecycle management and portfolio evaluation.

### Responsibilities

- Portfolio Management
- Position Management
- Holdings
- Investment Performance
- Portfolio Evaluation
- Asset Allocation

---

## TRD-001 — Trading Management

### Purpose

Manages the business lifecycle of trading activities.

### Responsibilities

- Order Management
- Trade Management
- Execution Tracking
- Order Lifecycle
- Transaction Recording

Trading capabilities remain independent from analytical capabilities.

---

## RES-001 — Research & Backtesting

### Purpose

Provides historical evaluation of analytical models and investment strategies.

### Responsibilities

- Backtesting
- Historical Simulation
- Strategy Evaluation
- Experimental Analysis
- Model Validation
- Research Results

Research capabilities consume enterprise data without modifying historical business facts.

---

# 7. Enterprise Support Capabilities

## INT-001 — Integration Management

### Purpose

Provides controlled communication between the Phoenix Platform and external systems.

### Responsibilities

- External Data Providers
- Broker Integration
- Import Services
- Export Services
- Data Exchange
- External APIs
- Integration Adapters
- Webhooks

Integration capabilities exchange information but never own enterprise business processes.

---

## CFG-001 — Configuration Management

### Purpose

Provides centralized management of configurable enterprise behavior.

### Responsibilities

- System Configuration
- Environment Configuration
- Feature Flags
- Parameter Management
- Business Configuration
- Configuration Versioning

Configuration supports enterprise flexibility without modifying business logic.

---

## REP-001 — Reporting & Business Intelligence

### Purpose

Transforms enterprise information into consumable business insights.

### Responsibilities

- Operational Reporting
- Analytical Reporting
- Dashboards
- Executive Reporting
- Business Intelligence
- Decision Support Views

Reporting consumes business information without owning operational entities.

---

## AUD-001 — Audit & Compliance

### Purpose

Ensures enterprise traceability, accountability, and regulatory compliance.

### Responsibilities

- Audit Logging
- Change History
- Business Events
- Security Events
- Compliance Monitoring
- Operational Audit
- Data Lineage

Audit capabilities observe enterprise activities without altering business ownership.

---

# 8. Capability Dependency Principles

Business capabilities collaborate while preserving clear ownership boundaries.

The following dependency principles are mandatory.

## CDP-001 — Shared Reference Data

Reference Data Management provides enterprise reference information consumed by all other capabilities.

---

## CDP-002 — Market Intelligence Foundation

Investment Intelligence, Artificial Intelligence, Research, Portfolio Management, and Trading consume validated Market Intelligence.

---

## CDP-003 — Analytics Independence

Analytical capabilities consume business information but shall not modify enterprise business facts.

---

## CDP-004 — Cross-Cutting Capabilities

Configuration, Audit, Reporting, and Integration provide enterprise-wide support capabilities without owning business domains.

---

## CDP-005 — Explicit Ownership

Every enterprise business object shall have one—and only one—owning business capability.

---

# 9. Capability Traceability

Every lower-layer architectural artifact shall be traceable to one or more enterprise business capabilities.

```text
Business Capability
        │
        ▼
Domain Architecture
        │
        ▼
Aggregate
        │
        ▼
Entity
        │
        ▼
Data Model
        │
        ▼
Service
        │
        ▼
Application
        │
        ▼
Infrastructure
```

This traceability preserves architectural consistency throughout the enterprise lifecycle.

---

# 10. Related Artifacts

## Vision

- ProjectOverview.md
- PlatformArchitectureVision.md
- ArchitectureVisionMap.md
- ReferenceArchitecture.md

## Principles

- ArchitecturalPrinciples.md
- EngineeringPrinciples.md
- LayerArchitecture.md
- QualityAttributes.md

## Business Architecture

- DomainResponsibilities.md
- ServiceContextMap.md

## Domain Architecture

- CanonicalDomainModel.md
- AggregateCatalog.md
- AggregateDefinitions.md
- EntityCatalog.md

---

# 11. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial business capability map. |
| 2026.2 | 2026-07-17 | Complete enterprise rewrite aligned with the Platform Architecture Vision, Knowledge-Driven Architecture, Reference Architecture, Architectural Principles, Layer Architecture, Quality Attributes, and Capability-Centric Enterprise Architecture. |

---

**End of Document**