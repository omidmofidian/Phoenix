# Enterprise Data Dictionary

| Item | Value |
|------|------|
| Document | Enterprise Data Dictionary |
| Project | Phoenix Platform |
| Version | 1.0 |
| Status | Draft |
| Classification | Canonical Architecture Artifact |
| Owner | Enterprise Architecture |
| Last Updated | 2026-07-12 |

---

# 1. Purpose

The Enterprise Data Dictionary defines the canonical business metadata of the Phoenix Platform.

It provides the authoritative business definition and technical metadata for all enterprise data entities.

This document serves as the single source of truth for business terminology and database metadata.

---

# 2. Scope

This document applies to:

- Domain Model
- Conceptual Model
- Logical Database Model
- Physical Database Model
- Database DDL
- Reference Data
- Enterprise Standards

---

# 3. Objectives

The objectives of this document are:

- Establish a common enterprise vocabulary.
- Eliminate ambiguity.
- Standardize entity definitions.
- Standardize attribute definitions.
- Improve consistency across models.
- Support database development.
- Improve traceability.
- Support long-term maintainability.

---

# 4. Governance

This document is governed by the Enterprise Architecture.

Any modification shall comply with approved Architecture Decision Records (ADR).

Entity definitions contained herein are considered canonical.

---

# 5. Dictionary Rules

## DD-001

Every business entity shall appear exactly once.

---

## DD-002

Every attribute shall have one business definition.

---

## DD-003

Attribute names shall follow the approved naming conventions.

---

## DD-004

Business definitions shall be implementation independent.

---

## DD-005

Technical metadata shall remain synchronized with the Logical and Physical Database Models.

---

## DD-006

No duplicate business concepts are permitted.

---

## DD-007

Reference entities shall be defined before transactional entities.

---

# 6. Common Metadata

Every entity described in this dictionary shall include:

- Business Definition
- Technical Definition
- Primary Key
- Alternate Keys
- Foreign Keys
- Attributes
- Relationships
- Business Rules
- Source ADR
- Related Documents

---

# 7. Common Audit Attributes

The following audit attributes are common to all enterprise entities.

| Attribute | Description |
|----------|-------------|
| created_at | Record creation timestamp |
| created_by | Record creator |
| updated_at | Last update timestamp |
| updated_by | Last updater |
| is_active | Active status |
| row_version | Optimistic concurrency version |

---

# 8. Identifier Strategy

Each enterprise entity shall use:

- Surrogate Primary Key
- Stable Business Code
- Optional External Code
- Immutable Identifier

Natural keys shall never be used as primary keys.

---

# 9. Reference Entity

Reference entities define the canonical classification structure of the Phoenix Platform.

These entities contain relatively static business information and provide the foundation for all transactional and analytical data.

Reference entities are centrally managed and referenced by other business entities throughout the platform.

The current reference entities are:

- Exchange
- Market
- Board
- Sector
- Company
- Symbol

The hierarchical relationship is illustrated below.

Exchange
    │
    ▼
Market
    │
    ▼
Board
    │
    ▼
Sector
    │
    ▼
Company
    │
    ▼
Symbol

Each reference entity is described in the following sections using a standardized enterprise metadata template.

---

# 10. Reference Entities

Reference entities provide the canonical classification framework of the Phoenix Platform.

These entities are relatively static and are managed centrally.

Reference entities may be referenced by transactional entities but shall not depend on them.

The current reference entities are:

- Exchange
- Market
- Board
- Sector
- Company
- Symbol

---

# 10.1 Exchange

## Business Definition

An Exchange represents an organized financial marketplace in which securities are listed and traded under a common regulatory authority.

Examples include national stock exchanges and other regulated trading venues.

---

## Technical Definition

The Exchange entity is the highest-level reference entity within the market classification hierarchy.

All Markets belong to one Exchange.

---

## Primary Key

| Attribute | Description |
|----------|-------------|
| exchange_id | Surrogate primary key |

---

## Alternate Keys

| Attribute | Description |
|----------|-------------|
| exchange_code | Enterprise business code |

---

## Foreign Keys

None.

Exchange is the root reference entity.

---

## Attributes

| Attribute | Data Type | Nullable | Business Definition |
|----------|-----------|----------|---------------------|
| exchange_id | BIGINT | No | Internal unique identifier |
| exchange_code | VARCHAR(50) | No | Enterprise exchange code |
| external_exchange_code | VARCHAR(50) | Yes | Code supplied by external data providers |
| exchange_name | VARCHAR(200) | No | Official exchange name |
| short_name | VARCHAR(100) | Yes | Short display name |
| english_name | VARCHAR(200) | Yes | English exchange name |
| country_code | CHAR(2) | No | ISO country code |
| timezone | VARCHAR(100) | No | Exchange time zone |
| currency_code | CHAR(3) | No | Trading currency |
| description | TEXT | Yes | Additional description |
| display_order | INTEGER | No | Default presentation order |
| created_at | TIMESTAMP | No | Creation timestamp |
| created_by | VARCHAR(100) | No | Record creator |
| updated_at | TIMESTAMP | Yes | Last modification timestamp |
| updated_by | VARCHAR(100) | Yes | Last modifier |
| is_active | BOOLEAN | No | Active status |
| row_version | INTEGER | No | Optimistic locking version |

---

## Relationships

| Parent | Child | Cardinality |
|---------|-------|-------------|
| Exchange | Market | One-to-Many |

---

## Business Rules

### BR-EX-001

Every Exchange shall have a unique business code.

---

### BR-EX-002

Exchange names shall be unique.

---

### BR-EX-003

An Exchange cannot belong to another Exchange.

---

### BR-EX-004

Markets shall reference exactly one Exchange.

---

### BR-EX-005

Inactive exchanges shall not be physically deleted.

---

## Related Entities

- Market

---

## Source ADR

- ADR-015 — Market Classification Model
- ADR-026 — Normalize Reference Data Model

---

## Related Documents

- DomainModel
- ConceptualModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- RepositoryStructure

---
# 10.2 Market

## Business Definition

A Market represents a logical trading environment operating within an Exchange.

A Market groups trading boards that share common trading regulations and operational characteristics.

---

## Technical Definition

Each Market belongs to exactly one Exchange.

A Market may contain one or more Boards.

---

## Primary Key

| Attribute | Description |
|----------|-------------|
| market_id | Surrogate primary key |

---

## Alternate Keys

| Attribute | Description |
|----------|-------------|
| market_code | Enterprise business code |

---

## Foreign Keys

| Attribute | References |
|----------|------------|
| exchange_id | Exchange |

---