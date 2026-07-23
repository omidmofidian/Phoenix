# Market Schema Reference

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-003 |
| Document | MarketSchemaReference |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Schema Reference |
| Owner | Architecture Team |
| Depends On | CanonicalDomainModel, EntityDictionary, RelationshipDictionary, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The **Market Schema Reference** defines the architectural organization, business responsibilities, and structural boundaries of the **Market Schema** within the Phoenix Platform.

Rather than documenting individual entities or database implementation details, this document describes the business role of the schema as a whole and its relationship to the broader Enterprise Information Architecture.

The Market Schema serves as the authoritative repository for master data describing financial markets, listed organizations, tradable instruments, and their structural classifications.

It establishes a stable business foundation upon which operational, analytical, and machine learning capabilities are built.

---

# 2. Scope

This document applies to the complete **Market Schema** and its constituent business entities.

The schema encompasses enterprise master data related to:

- Financial Exchanges
- Trading Boards
- Market Classifications
- Economic Sectors
- Industries
- Listed Companies
- Financial Instruments
- Instrument Listings

This document does **not** define:

- Physical database implementation;
- SQL objects or storage structures;
- Entity semantics;
- Attribute semantics;
- Relationship semantics.

Those concerns are governed by their respective enterprise artifacts.

---

# 3. Position within the Enterprise Information Architecture

The Market Schema occupies the **Master Data Layer** of the Phoenix Enterprise Information Architecture.

Its primary responsibility is to maintain stable business information that changes infrequently compared with transactional market data.

Within the overall architecture, the Market Schema provides authoritative reference information consumed by multiple business domains and services.

```text
Enterprise Business Architecture
                │
                ▼
Enterprise Information Architecture
                │
                ▼
Reference Information
                │
                ▼
Market Schema
                │
        ┌───────┴────────┐
        ▼                ▼
Trading Schema    Analytics Services
        │                │
        └────────┬───────┘
                 ▼
       Machine Learning Services
```

The Market Schema therefore acts as the structural backbone for every operational and analytical capability implemented within the Phoenix Platform.

---

# 4. Architectural Responsibilities

The Market Schema is responsible for maintaining the enterprise master data required to describe financial markets and the tradable objects that exist within them.

Its responsibilities include establishing canonical business definitions, preserving structural consistency, and providing stable reference information for all dependent domains.

Specifically, the Market Schema is responsible for:

- maintaining the enterprise catalog of financial exchanges;
- defining trading boards operated by each exchange;
- maintaining hierarchical market classifications;
- organizing sectors and industries;
- maintaining listed company master data;
- defining tradable financial instruments;
- recording instrument listing information;
- preserving historical continuity of master data;
- providing authoritative reference information to downstream services.

The Market Schema shall not contain operational trading data or analytical results.

---

# 5. Business Ownership

Business ownership of the Market Schema is distributed across several bounded contexts while preserving clear architectural responsibilities.

| Business Capability | Owning Domain |
|---------------------|---------------|
| Exchange Management | Reference Domain |
| Market Classification | Reference Domain |
| Company Reference Data | Market Domain |
| Instrument Reference Data | Market Domain |
| Instrument Listings | Market Domain |

Each Aggregate within the schema shall have exactly one owning business domain.

Ownership shall never be shared between domains.

Cross-domain access shall occur through well-defined business relationships rather than duplicate data ownership.

---

# 6. Schema Overview

The Market Schema contains the enterprise master data describing market structures and tradable business objects.

The schema currently consists of the following core entities.

| Entity | Primary Business Responsibility |
|----------|--------------------------------|
| Exchange | Defines securities exchanges |
| TradingBoard | Defines trading boards operated by exchanges |
| Sector | Defines high-level economic sectors |
| Industry | Defines industries within sectors |
| Company | Represents listed organizations |
| Instrument | Represents tradable financial instruments |
| InstrumentListing | Associates instruments with trading boards |

These entities collectively form the structural foundation upon which trading, analytics, reporting, and machine learning capabilities depend.

The schema intentionally excludes transactional, historical, and derived information, which belongs to other enterprise schemas.

---

# 7. Entity Landscape

The Market Schema organizes enterprise master data into a hierarchical structure that reflects real-world financial market organization.

Each entity fulfills a distinct business responsibility while remaining part of an integrated reference model.

```text
Exchange
    │
    ├── TradingBoard
    │       │
    │       └── InstrumentListing
    │               │
    │               └── Instrument
    │                       │
    │                       └── Company
    │                               │
    │                               └── Industry
    │                                       │
    │                                       └── Sector
```

This hierarchy represents business dependencies rather than physical database implementation.

Each entity is documented independently within the Entity Dictionary, while relationships between entities are governed by the Relationship Dictionary.

---

# 8. Cross-Domain Relationships

Although the Market Schema owns the enterprise master data for market structures and tradable instruments, it collaborates with several other enterprise domains.

| Related Domain | Relationship |
|----------------|--------------|
| Reference Domain | Provides shared enterprise reference data such as countries, currencies, and classifications. |
| Trading Domain | Consumes market master data to record trading sessions, prices, corporate actions, and market events. |
| Analytics Domain | Uses market entities as inputs for indicators, factors, signals, and analytical models. |
| Machine Learning Domain | References market entities when generating features, training datasets, and prediction models. |
| Integration Domain | Maps enterprise entities to identifiers used by external exchanges, brokers, and data providers. |

The Market Schema owns only its canonical business entities.

Transactional records, analytical outputs, predictions, and external integration metadata remain the responsibility of their respective domains.

---

# 9. Enterprise Design Principles

The Market Schema shall comply with the architectural principles governing the Phoenix Platform.

These principles include:

- **Business First** — Business concepts drive schema organization rather than implementation concerns.
- **Canonical Information** — Each business concept is represented once within the enterprise.
- **Technology Independence** — Business structure remains independent of database technologies and application frameworks.
- **Single Source of Truth** — Master data originates from one authoritative enterprise location.
- **Domain Ownership** — Every entity belongs to exactly one owning business domain.
- **Normalization** — Duplicate business information shall be eliminated through appropriate entity relationships.
- **Referential Integrity** — Business relationships shall remain consistent throughout the enterprise information model.
- **Extensibility** — The schema shall accommodate future financial markets, instruments, and classifications without structural redesign.

These principles ensure that the Market Schema remains a stable, reusable, and enterprise-wide foundation for all current and future Phoenix Platform capabilities.

---

# 10. Enterprise Business Rules

The following business rules govern every entity contained within the Market Schema.

## 10.1 Structural Rules

- Every Company shall belong to exactly one Industry.
- Every Industry shall belong to exactly one Sector.
- Every Instrument shall belong to exactly one Company.
- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall belong to exactly one Trading Board.
- Every Trading Board shall belong to exactly one Exchange.

These structural relationships define the canonical organization of market master data and shall remain consistent across all logical and physical implementations.

---

## 10.2 Identity Rules

Every entity within the Market Schema shall comply with the Enterprise Identity Standard.

Accordingly:

- each entity shall possess exactly one canonical enterprise identifier (`id`);
- business identifiers shall remain independent from technical identifiers;
- external provider identifiers shall never replace enterprise identities;
- canonical identifiers shall remain immutable throughout the entity lifecycle.

---

## 10.3 Lifecycle Rules

Market master data is intended to preserve historical continuity.

Therefore:

- approved master data shall not be physically deleted;
- business deactivation shall be preferred over deletion;
- historical relationships shall remain traceable;
- changes to business classifications shall preserve historical integrity whenever applicable.

---

## 10.4 Governance Rules

Changes affecting Market Schema entities shall comply with the Phoenix Architecture Governance process.

Examples include:

- introducing new entity types;
- modifying Aggregate boundaries;
- changing ownership responsibilities;
- introducing new business identifiers;
- altering canonical business relationships.

Such changes require architectural review and formal approval before implementation.

---

# 11. Standards Compliance

The Market Schema shall comply with all enterprise information standards defined by the Phoenix Platform.

This includes, but is not limited to, the following documents:

- Enterprise Naming Standard
- Enterprise Data Type Standard
- Enterprise Attribute Standard
- Enterprise Identity Standard
- Base Entity Standard
- Enterprise Data Dictionary Standard
- Identifier Strategy
- Logical Model Document Template

Compliance with these standards ensures semantic consistency, architectural traceability, and interoperability across every business domain.

---

# 12. Related Enterprise Artifacts

The Market Schema is supported by several architectural artifacts that collectively define its business semantics and implementation boundaries.

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Defines enterprise business concepts and domain boundaries. |
| Logical Database Model | Defines logical entities and business relationships. |
| Physical Database Model | Defines physical database implementation. |
| Entity Dictionary | Defines the business meaning of Market entities. |
| Relationship Dictionary | Defines canonical business relationships. |
| Attribute Dictionary | Defines the semantics of reusable enterprise attributes. |
| Enterprise Data Dictionary | Provides enterprise-wide metadata governance. |
| Architecture Decision Records (ADRs) | Capture architectural decisions affecting the schema. |

These artifacts together provide complete traceability from business concepts through logical modeling to physical implementation.

---

# 13. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial Market Schema Dictionary. |
| 2.0 | 2026-07-22 | Reorganized as an enterprise schema specification aligned with Sprint 3 Information Architecture and Enterprise Data Governance standards. |

# Appendix A — Entity Responsibility Matrix

The following matrix summarizes the primary business responsibilities of each entity contained within the Market Schema.

| Entity | Primary Responsibility | Aggregate | Business Lifecycle |
|----------|------------------------|-----------|--------------------|
| Exchange | Defines regulated securities exchanges | Market Reference | Stable |
| TradingBoard | Defines trading environments operated by an exchange | Market Reference | Stable |
| Sector | Classifies companies into high-level economic sectors | Market Classification | Stable |
| Industry | Provides detailed economic classification beneath sectors | Market Classification | Stable |
| Company | Represents legal organizations issuing financial instruments | Company | Active |
| Instrument | Represents tradable financial assets | Instrument | Active |
| InstrumentListing | Represents the admission of an instrument to a trading board | Instrument Listing | Historical |

Each entity owns a distinct business responsibility and shall not duplicate responsibilities assigned to another entity.

---

# Appendix B — Information Flow

The Market Schema supplies master data to multiple enterprise domains.

```text
                     Market Schema
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
 Trading Domain     Analytics Domain   Integration Domain
        │                  │                  │
        ▼                  ▼                  ▼
 Trading Data      Indicators & Models  External Providers
        │                  │                  │
        └──────────────────┼──────────────────┘
                           ▼
                 Machine Learning Domain
```

The Market Schema functions exclusively as the provider of authoritative reference information.

Downstream domains consume—but never own or redefine—the master data maintained within this schema.

---

# Appendix C — Architectural Characteristics

The Market Schema exhibits the following architectural characteristics.

| Characteristic | Description |
|----------------|-------------|
| Business Orientation | Models business concepts rather than technical structures. |
| Canonical Information | Maintains a single enterprise representation for each master data concept. |
| Technology Independence | Remains independent of database vendors, programming languages, and implementation frameworks. |
| Referential Integrity | Preserves consistent business relationships between entities. |
| Historical Preservation | Protects historical master data through controlled lifecycle management. |
| Reusability | Provides reusable reference information for all enterprise domains. |
| Extensibility | Supports future financial markets, asset classes, and business capabilities without structural redesign. |
| Governance | Operates under centralized enterprise architecture governance and information standards. |

These characteristics ensure that the Market Schema remains a durable and scalable foundation for the Phoenix Platform's enterprise information architecture.

---

# Appendix D — Business Terminology

The following terminology is used consistently throughout the Market Schema and related enterprise artifacts.

| Term | Definition |
|------|------------|
| Exchange | A regulated organization that facilitates the trading of financial instruments. |
| Trading Board | A market segment or trading venue operated by an exchange under specific trading rules. |
| Sector | A high-level economic classification grouping organizations with similar business activities. |
| Industry | A detailed business classification within a sector. |
| Company | A legal business entity that issues one or more financial instruments. |
| Instrument | A tradable financial asset recognized by the Phoenix Platform. |
| Instrument Listing | The formal admission of an instrument to a trading board, including its listing lifecycle. |
| Market Reference Data | Stable business information describing financial market structures. |
| Master Data | Canonical enterprise information shared across multiple business domains. |

These definitions shall remain consistent with the Business Glossary and the Entity Dictionary.

---

# Appendix E — Architectural Traceability

The Market Schema participates in the enterprise architecture through complete traceability across all modeling layers.

```text
Enterprise Vision
        │
        ▼
Business Architecture
        │
        ▼
Reference Domain Architecture
        │
        ▼
Canonical Domain Model
        │
        ▼
Logical Database Model
        │
        ▼
Market Schema Dictionary
        │
        ▼
Entity Dictionary
        │
        ▼
Relationship Dictionary
        │
        ▼
Attribute Dictionary
        │
        ▼
Physical Database Model
        │
        ▼
Database Implementation
```

Each layer refines the previous one while preserving business meaning.

No implementation artifact shall contradict the business semantics defined at higher architectural layers.

---

# Appendix F — Future Evolution

The Market Schema has been designed to support the long-term evolution of the Phoenix Platform.

Future enhancements may include:

- support for multiple securities exchanges across different countries;
- additional asset classes, including bonds, ETFs, mutual funds, derivatives, commodities, cryptocurrencies, and foreign exchange instruments;
- expanded market classification frameworks;
- richer issuer and corporate metadata;
- enhanced listing lifecycle management;
- integration with multiple external market-data providers;
- internationalization through standardized reference data.

Future enhancements shall extend the existing information model rather than replacing established business concepts.

Backward compatibility shall be preserved whenever practical.

All structural changes shall be governed through the Phoenix Architecture Governance process and, where appropriate, documented by Architecture Decision Records (ADRs).

---

# Appendix G — Enterprise Information Governance

The Market Schema is governed as part of the Phoenix Enterprise Information Architecture.

Its information assets shall comply with the following governance principles.

## G.1 Single Source of Truth

Each business concept shall have exactly one authoritative representation within the Market Schema.

Duplicate representations of the same business concept are prohibited.

---

## G.2 Canonical Ownership

Every entity shall have a clearly defined owning business domain.

Ownership includes responsibility for:

- business semantics;
- lifecycle management;
- quality assurance;
- business validation;
- structural evolution.

---

## G.3 Semantic Consistency

Business terminology shall remain consistent across:

- Business Glossary;
- Entity Dictionary;
- Attribute Dictionary;
- Relationship Dictionary;
- Enterprise Data Dictionary;
- Logical Database Model;
- Physical Database Model.

Semantic changes shall be propagated to all dependent artifacts through the architecture governance process.

---

## G.4 Information Quality

Market reference data shall satisfy the following quality dimensions:

| Dimension | Objective |
|-----------|-----------|
| Accuracy | Business information correctly represents real-world entities. |
| Completeness | Required business information is available. |
| Consistency | Equivalent business concepts are represented uniformly. |
| Uniqueness | Duplicate master data is prevented. |
| Timeliness | Information is maintained according to business requirements. |
| Traceability | Every change can be traced to its business origin. |

---

## G.5 Change Governance

Changes affecting Market Schema information shall undergo:

1. Business impact analysis.
2. Architectural review.
3. Information model validation.
4. Standards compliance verification.
5. Approval through Architecture Governance.

Implementation shall only begin after approval of the conceptual and logical changes.

---

# Appendix H — Implementation Independence

The Market Schema Dictionary intentionally excludes implementation-specific concerns.

Accordingly, this document shall **not** define:

- SQL syntax;
- PostgreSQL-specific features;
- indexes;
- partitions;
- storage optimization;
- query optimization;
- caching mechanisms;
- application frameworks;
- service implementation details.

Such concerns belong to the Physical Database Model, implementation standards, or operational documentation.

This separation preserves the long-term stability of the enterprise information architecture.

---

# Document Status

This document is designated as the **authoritative architectural specification** for the **Market Schema** within the Phoenix Platform.

It defines:

- the business responsibilities of the Market Schema;
- its bounded context;
- canonical entities and relationships;
- governance principles;
- architectural constraints;
- enterprise traceability.

It intentionally delegates detailed attribute definitions, relationship semantics, logical modeling, and physical implementation to the corresponding enterprise artifacts.

Future revisions shall preserve backward compatibility unless superseded through an approved Architecture Decision Record (ADR).

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial Market Schema Dictionary. |
| 2.0 | 2026-07-22 | Rewritten as an enterprise architectural specification aligned with Sprint 3 Information Architecture, Enterprise Data Governance, and the canonical documentation framework. |