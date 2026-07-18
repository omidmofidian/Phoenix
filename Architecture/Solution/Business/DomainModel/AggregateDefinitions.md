# Aggregate Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-008 |
| Document | AggregateDefinitions |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Architecture |
| Architecture Layer | Domain Model |
| Owner | Enterprise Architecture |
| Depends On | AggregateCatalog, CanonicalDomainModel, DomainResponsibilities |
| Consumed By | AggregateAttributeMatrix, ConceptualDataModel, LogicalDatabaseModel |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical business specifications of the Aggregates identified in the Enterprise Aggregate Catalog.

Where the Aggregate Catalog identifies **which Aggregates exist**, this document defines **how each Aggregate behaves as a business consistency boundary**.

Each Aggregate specification describes its business purpose, ownership, lifecycle, invariants, collaboration rules, and extension points.

This document is technology-independent and contains no implementation, persistence, or service implementation details.

---

# 2. Objectives

The objectives of this document are to:

- Define the business semantics of every Aggregate.
- Describe Aggregate responsibilities.
- Specify Aggregate boundaries.
- Identify Aggregate invariants.
- Define lifecycle ownership.
- Describe Aggregate collaboration.
- Support conceptual and logical data modeling.
- Maintain consistency across the enterprise architecture.

---

# 3. Aggregate Specification Template

Every Aggregate defined within the Phoenix Platform shall follow a common specification template.

Each specification contains the following sections.

| Section | Description |
|---------|-------------|
| Business Purpose | Why the Aggregate exists. |
| Aggregate Root | The single business entry point. |
| Business Responsibility | Responsibilities owned by the Aggregate. |
| Business Invariants | Rules that shall always remain true. |
| Lifecycle | Creation, modification and retirement rules. |
| Collaboration | Relationships with other Aggregates. |
| Published Information | Business information exposed to other Domains. |
| Extension Points | Future business evolution opportunities. |

---

# 4. Aggregate Specifications

## 4.1 Exchange Aggregate

### Business Purpose

Represents a securities exchange operating within a financial market.

The Exchange Aggregate provides the authoritative business definition of an exchange and serves as the parent business context for one or more Markets.

### Aggregate Root

Exchange

### Business Responsibility

- Maintain exchange identity.
- Maintain exchange business attributes.
- Govern exchange lifecycle.
- Publish exchange reference information.

### Business Invariants

- Every Exchange has a unique business identity.
- Exchange business identifiers remain stable.
- Exchange meaning is immutable once established.

### Lifecycle

- Create
- Maintain
- Deactivate
- Preserve historical identity

### Collaborates With

- Market Aggregate

### Published Information

- Exchange identifier
- Exchange code
- Exchange name
- Operational status

### Extension Points

Future versions may support:

- Regulatory authority
- Trading regulations
- Settlement characteristics

---

## 4.2 Market Aggregate

### Business Purpose

Represents a distinct financial market operating within an Exchange.

The Market Aggregate defines the business environment in which financial instruments are listed and traded. It provides the organizational structure for Trading Boards and establishes the business context for trading activities.

### Aggregate Root

Market

### Business Responsibility

- Maintain market identity.
- Define market characteristics.
- Govern market lifecycle.
- Organize trading boards.
- Publish market reference information.

### Business Invariants

- Every Market belongs to exactly one Exchange.
- A Market cannot exist without an Exchange.
- Market business identifiers are immutable.
- Market ownership shall never change after creation.

### Lifecycle

- Create
- Maintain
- Suspend
- Deactivate
- Preserve historical identity

### Collaborates With

- Exchange Aggregate
- Trading Board Aggregate

### Published Information

- Market identifier
- Market code
- Market name
- Parent Exchange
- Operational status

### Extension Points

Future versions may introduce:

- Market segments
- Trading models
- Settlement models
- Regulatory classifications

---

## 4.3 Trading Board Aggregate

### Business Purpose

Represents a trading board within a Market.

The Trading Board Aggregate defines the business rules governing the listing and trading of financial instruments within a specific market segment.

### Aggregate Root

TradingBoard

### Business Responsibility

- Maintain board identity.
- Organize listed companies and instruments.
- Define board characteristics.
- Publish board reference information.

### Business Invariants

- Every Trading Board belongs to exactly one Market.
- A Trading Board cannot exist independently.
- Board business identifiers are immutable.
- Board classification shall remain stable.

### Lifecycle

- Create
- Maintain
- Suspend
- Deactivate

### Collaborates With

- Market Aggregate
- Company Aggregate

### Published Information

- Board identifier
- Board code
- Board name
- Parent Market
- Operational status

### Extension Points

Future versions may support:

- Listing requirements
- Trading restrictions
- Market-specific regulations

---

## 4.4 Industry Aggregate

### Business Purpose

Represents the highest level of business industry classification used throughout the Phoenix Platform.

The Industry Aggregate provides a stable classification framework for organizing economic activities across multiple markets.

### Aggregate Root

Industry

### Business Responsibility

- Maintain industry taxonomy.
- Govern industry lifecycle.
- Publish classification information.
- Support enterprise-wide business classification.

### Business Invariants

- Every Industry has a unique business identity.
- Industry definitions are centrally governed.
- Industry meaning remains stable over time.

### Lifecycle

- Create
- Maintain
- Retire (only when officially superseded)

### Collaborates With

- Sector Aggregate

### Published Information

- Industry identifier
- Industry code
- Industry name

### Extension Points

Future versions may support:

- International classification standards
- Multi-level industry hierarchies
- Cross-market mappings

---

## 4.5 Company Aggregate

### Business Purpose

Represents a legally recognized business entity participating in one or more financial markets.

The Company Aggregate serves as the enterprise business identity for issuers of financial instruments and acts as the authoritative source of corporate information throughout the platform.

### Aggregate Root

Company

### Business Responsibility

- Maintain company identity.
- Manage corporate business information.
- Support company lifecycle.
- Publish enterprise company information.

### Business Invariants

- Every Company belongs to exactly one Trading Board.
- Every Company belongs to exactly one Sector.
- Company identity shall remain immutable.
- Business ownership belongs exclusively to the Company Aggregate.

### Lifecycle

- Register
- Maintain
- Suspend
- Delist
- Preserve historical identity

### Collaborates With

- Trading Board Aggregate
- Sector Aggregate
- Financial Instrument Aggregate

### Published Information

- Company identifier
- Company code
- Company name
- Listing information
- Business classification

### Extension Points

Future versions may support:

- Corporate governance information
- Ownership structure
- Regulatory filings
- Corporate profile

---

## 4.6 Financial Instrument Aggregate

### Business Purpose

Represents a tradable financial asset issued by a Company.

The Financial Instrument Aggregate defines the commercial characteristics of securities and other financial products traded within supported markets.

### Aggregate Root

FinancialInstrument

### Business Responsibility

- Maintain instrument identity.
- Define instrument characteristics.
- Govern instrument lifecycle.
- Publish instrument reference information.

### Business Invariants

- Every Financial Instrument belongs to exactly one Company.
- Instrument identity is immutable.
- Instrument classification shall remain stable.
- Business ownership belongs exclusively to this Aggregate.

### Lifecycle

- Create
- Activate
- Maintain
- Suspend
- Delist
- Preserve historical identity

### Collaborates With

- Company Aggregate
- Daily Market Data Aggregate
- Corporate Action Aggregate

### Published Information

- Instrument identifier
- Trading symbol
- Instrument type
- Listing status
- Parent Company

### Extension Points

Future versions may support:

- Multi-exchange listings
- International identifiers
- Derivative relationships
- Trading restrictions

---

# 5. Aggregate Collaboration Principles

All Aggregates shall collaborate according to the following principles.

- Each Aggregate owns its own business consistency boundary.
- Business ownership shall never overlap.
- Cross-Aggregate relationships shall be established through Aggregate Root identities.
- Business rules shall be enforced only by the owning Aggregate.
- Aggregates shall communicate through published interfaces or application services.
- Aggregate boundaries shall remain stable unless modified through an approved Architecture Decision Record (ADR).

---

# 6. Relationship with Other Artifacts

This document is supported by the following architectural artifacts.

- Business Capability Map
- Canonical Domain Model
- Aggregate Catalog
- Aggregate Attribute Matrix
- Domain Responsibilities
- Conceptual Data Model
- Logical Database Model
- Enterprise Data Dictionary

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-04 | Initial version. |
| 2026.2 | 2026-07-18 | Rewritten as the canonical Aggregate specification document aligned with the Enterprise Domain Model. |