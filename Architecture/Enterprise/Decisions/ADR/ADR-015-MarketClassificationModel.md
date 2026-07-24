# ADR-015 — Canonical Reference Domain Model

---

## Document Information

| Attribute | Value |
|----------|-------|
| ADR Number | ADR-015 |
| Title | Canonical Reference Domain Model |
| Status | Accepted |
| Version | 2.0 |
| Date | 2026-07-24 |
| Decision Makers | Phoenix Architecture Board |
| Authors | Phoenix Architecture Team |
| Review Cycle | Major Architecture Changes |
| Supersedes | ADR-015 Version 1.0 (Market Classification Model) |

---

# 1. Status

**Accepted**

This Architecture Decision Record defines the canonical business reference model of the Phoenix Platform.

The decisions documented in this ADR are mandatory for every architectural layer, including:

- Domain Model
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- Database DDL
- Service Contracts
- APIs
- Application Services
- Integration Components

No implementation may introduce an alternative reference hierarchy without an approved superseding ADR.

---

# 2. Context

Phoenix Platform is designed as an enterprise-grade, service-oriented investment analysis platform intended to support multiple financial markets.

Although the initial implementation targets the Iranian capital market, the platform architecture must remain independent of any specific exchange, country, or asset class.

The platform is expected to support additional markets in future releases, including but not limited to:

- International Stock Exchanges
- Exchange Traded Funds (ETF)
- Bonds
- Mutual Funds
- Derivatives
- Commodities
- Foreign Exchange (Forex)
- Cryptocurrencies
- Other organized financial markets

As the platform evolved, multiple architectural documents introduced slightly different interpretations of the reference business hierarchy.

Examples included inconsistent usage of:

- Board vs. Trading Board
- Symbol vs. Instrument
- Exchange–Market hierarchy
- Industry classification hierarchy
- Parent-child ownership rules

These inconsistencies created ambiguity across architectural documentation and implementation artifacts.

A single canonical reference domain model is therefore required to establish a unified ubiquitous language across the entire Phoenix Platform.

---

# 3. Problem Statement

Prior architectural iterations introduced several naming inconsistencies and structural ambiguities across the repository.

Without a single authoritative reference model, different artifacts may evolve independently, resulting in:

- inconsistent business terminology;
- duplicated business concepts;
- conflicting database structures;
- incompatible service contracts;
- increased implementation complexity;
- reduced maintainability;
- higher integration costs.

To eliminate these risks, Phoenix requires one canonical reference domain model that serves as the single source of truth for every business reference entity used throughout the platform.

---

# 4. Decision

The Phoenix Platform shall adopt a single **Canonical Reference Domain Model** that defines the authoritative business reference hierarchy for the entire platform.

This model shall become the mandatory reference for every architectural, logical, physical, and implementation artifact.

No alternative business hierarchy may be introduced unless approved by a subsequent Architecture Decision Record.

---

# 5. Canonical Reference Domain Model

The canonical reference domain consists of seven core business entities.

```text
Exchange
    │
    └── Market
            │
            └── TradingBoard
                    │
                    └── Company
                            │
                            └── Instrument

Industry
    │
    └── Sector
            │
            └── Company
```

These entities represent the complete business taxonomy required to identify, classify, and organize tradable financial instruments within the Phoenix Platform.

---

# 6. Canonical Entities

The following entities are declared as canonical.

| Entity | Purpose |
|---------|---------|
| Exchange | Represents a regulated securities exchange. |
| Market | Represents a business market operated by an exchange. |
| TradingBoard | Represents a trading board within a market. |
| Industry | Represents a high-level business classification. |
| Sector | Represents a subdivision of an industry. |
| Company | Represents the legal entity issuing financial instruments. |
| Instrument | Represents a tradable financial instrument. |

These names shall be used consistently across:

- Architecture documents
- ADRs
- Data models
- Database objects
- Source code
- APIs
- Integration contracts
- Documentation

---

# 7. Deprecated Terminology

The following business terms are deprecated and shall not be introduced into future architectural artifacts.

| Deprecated | Canonical |
|------------|-----------|
| Board | TradingBoard |
| Trading Board | TradingBoard |
| Symbol | Instrument |
| Trading Symbol | Instrument |
| Company Symbol | Instrument |

Existing documents using deprecated terminology shall be updated during normal maintenance or repository consistency reviews.

---

# 8. Architectural Principles

The canonical reference model shall follow the principles below.

### Principle 1 — Single Source of Truth

Every business concept shall have exactly one canonical entity.

---

### Principle 2 — Ubiquitous Language

Business terminology shall remain identical across architecture, implementation, documentation, and services.

---

### Principle 3 — Market Independence

The model shall remain independent of any individual exchange, country, or financial market.

---

### Principle 4 — Extensibility

The model shall support future financial instruments and additional markets without structural redesign.

---

### Principle 5 — Enterprise Consistency

Business terminology shall remain stable across all architectural layers throughout the lifetime of the Phoenix Platform.

---
# 9. Trading Hierarchy

The trading hierarchy defines how tradable financial instruments are organized inside an exchange.

Each level has a distinct business responsibility and shall only maintain relationships with its immediate parent.

```text
Exchange
    │
    └── Market
            │
            └── TradingBoard
                    │
                    └── Company
                            │
                            └── Instrument
```

The responsibilities of each entity are defined below.

| Entity | Responsibility |
|---------|----------------|
| Exchange | Operates one or more regulated financial markets. |
| Market | Organizes securities into independent business markets. |
| TradingBoard | Represents the trading environment in which instruments are listed and traded. |
| Company | Represents the legal issuer of one or more financial instruments. |
| Instrument | Represents a tradable financial asset issued by a company. |

---

# 10. Business Classification Hierarchy

Business classification is independent from the trading hierarchy.

It classifies companies according to their business activities rather than their trading location.

```text
Industry
    │
    └── Sector
            │
            └── Company
```

Classification entities shall never be used to model trading relationships.

Likewise, trading entities shall never be used to model business classifications.

These two hierarchies remain independent and intersect only at the **Company** entity.

---

# 11. Parent–Child Relationship Rules

Each canonical entity shall maintain a relationship only with its immediate parent.

Direct references to higher-level ancestors shall not be stored unless explicitly approved by a separate Architecture Decision Record.

The canonical parent relationships are therefore defined as follows.

| Entity | Immediate Parent |
|---------|------------------|
| Market | Exchange |
| TradingBoard | Market |
| Company | TradingBoard, Sector |
| Instrument | Company |

This rule minimizes redundancy, improves normalization, and reduces the risk of inconsistent reference data.

---

# 12. Normalization Principles

The reference domain model shall comply with Third Normal Form (3NF).

Accordingly:

- Parent entities shall not duplicate information that can be derived through existing relationships.
- Child entities shall reference only their immediate parent entities.
- Redundant foreign keys shall be avoided.
- Derived relationships shall be resolved through joins rather than duplicated columns.

For example, an Instrument references its Company directly. Through the Company relationship, the platform can determine the associated TradingBoard, Market, and Exchange without storing those identifiers again.

Similarly, a Company references its Sector directly. The associated Industry can be determined through the Sector relationship without duplicating the Industry identifier.

These principles ensure a normalized, maintainable, and extensible reference model.

---

# 13. Naming Principles

To establish a consistent ubiquitous language across the Phoenix Platform, the following naming principles are mandatory.

## 13.1 Canonical Business Names

Each business concept shall have exactly one canonical name.

| Canonical Entity | Mandatory Name |
|------------------|----------------|
| Exchange | Exchange |
| Market | Market |
| TradingBoard | TradingBoard |
| Industry | Industry |
| Sector | Sector |
| Company | Company |
| Instrument | Instrument |

No synonyms shall be introduced into architecture, database objects, source code, APIs, or documentation.

---

## 13.2 Database Naming

Physical database objects shall comply with the Enterprise Database Naming Standard.

Examples:

| Object | Convention |
|---------|------------|
| Schema | `reference` |
| Table | `reference.instrument` |
| Primary Key | `id` |
| Foreign Key | `<parent>_id` |
| Public Identifier | `public_id` |
| Status Flag | `is_active` |
| Audit Columns | `created_at`, `created_by`, `updated_at`, `updated_by`, `version` |

---

## 13.3 Service Naming

Application services shall use canonical business terminology.

Examples:

- Instrument Service
- Company Service
- Exchange Service
- Market Service
- TradingBoard Service

Deprecated names such as **Symbol Service** shall not be introduced.

---

# 14. Architectural Consequences

Adoption of the canonical reference model has the following architectural consequences.

## Positive Consequences

- Establishes a single ubiquitous language across the Phoenix Platform.
- Eliminates ambiguity between architecture and implementation.
- Simplifies service contracts and API design.
- Improves database normalization.
- Reduces duplicated business concepts.
- Facilitates future support for multiple financial markets.
- Simplifies onboarding of developers and architects.
- Provides a stable foundation for enterprise governance.

## Negative Consequences

- Existing documentation using deprecated terminology must be updated.
- Existing DDL scripts may require refactoring to align with the canonical model.
- Legacy code, if any, may require migration.

These costs are considered acceptable in exchange for long-term architectural consistency.

---

# 15. Compliance Requirements

Every artifact produced within the Phoenix Platform shall comply with this Architecture Decision Record.

The following artifacts are subject to mandatory compliance:

- Architecture Decision Records (ADRs)
- Domain Model
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL DDL Scripts
- Service Contracts
- REST APIs
- Integration Specifications
- Source Code
- Test Data
- Technical Documentation

Repository consistency audits shall verify compliance with this ADR before major architectural milestones or release candidates.

---

# 16. Related ADRs

This ADR shall be interpreted together with the following Architecture Decision Records.

| ADR | Title |
|------|-------|
| ADR-001 | Domain-Driven Design |
| ADR-002 | Service-Oriented Architecture |
| ADR-015 | Canonical Reference Domain Model *(this document)* |
| ADR-026 | Normalize Reference Data Model |

Where conflicts exist, the most recent **Accepted** Architecture Decision Record shall take precedence.

---

# 17. References

The implementation of this Architecture Decision Record shall remain consistent with the following architectural artifacts.

- Domain Model
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL Physical Database Design
- PostgreSQL Design Decisions
- Table Physical Specifications
- Constraint Specifications
- DDL Template Specification

---

# End of Document