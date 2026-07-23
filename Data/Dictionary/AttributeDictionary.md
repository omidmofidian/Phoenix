# Enterprise Attribute Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-004 |
| Document | EnterpriseAttributeDictionary |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Semantic Dictionary |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Dictionary/AttributeDictionary.md |
| Depends On | DICT-003 EnterpriseAttributeCatalog, DST-009 Enterprise Attribute Standard, DST-006 Enterprise Data Dictionary Standard |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The Enterprise Attribute Dictionary is the authoritative semantic reference for every enterprise attribute defined within the Phoenix Platform.

Its purpose is to establish a single, canonical business meaning for each registered attribute and to ensure that identical business concepts are never interpreted differently across domains, services, databases, APIs, analytics, or future artificial intelligence capabilities.

Unlike the Enterprise Attribute Catalog, which registers reusable attributes, this dictionary explains the complete business semantics of every approved enterprise attribute.

The Enterprise Attribute Dictionary represents the semantic foundation of the Phoenix Enterprise Information Architecture.

---

# 2. Scope

This dictionary documents the semantic characteristics of enterprise attributes, including:

- canonical business definitions;
- business meaning;
- business purpose;
- business context;
- approved usage guidance;
- semantic relationships;
- business examples;
- enterprise terminology;
- cross-domain consistency.

This dictionary intentionally excludes:

- physical database implementation;
- SQL data types;
- storage optimization;
- aggregate ownership;
- mandatory or optional usage;
- implementation-specific validation.

These concerns are governed by their respective enterprise standards and supporting artifacts.

---

# 3. Objectives

The Enterprise Attribute Dictionary has the following objectives:

- establish a single semantic definition for every enterprise attribute;
- eliminate inconsistent interpretations of business terminology;
- provide a common language for business and technical stakeholders;
- support logical and physical data modeling;
- improve enterprise-wide information consistency;
- enable metadata governance;
- provide semantic knowledge for analytics and artificial intelligence;
- preserve long-term architectural stability.

---

# 4. Architectural Position

The Enterprise Attribute Dictionary occupies the semantic layer of the Phoenix Information Architecture.

```text
Enterprise Architecture
        │
        ▼
Enterprise Information Architecture
        │
        ▼
Enterprise Data Dictionary
        │
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
Applications and Services
```

The Attribute Dictionary defines what an enterprise attribute means.

It does not determine where the attribute is used or how it is implemented.

---

# 5. Relationship with Enterprise Artifacts

The Enterprise Attribute Dictionary operates together with other enterprise metadata artifacts.

| Artifact | Responsibility |
|----------|----------------|
| Enterprise Attribute Standard | Defines attribute architecture |
| Enterprise Attribute Catalog | Registers reusable enterprise attributes |
| Enterprise Attribute Dictionary | Defines business semantics |
| Entity Dictionary | Defines enterprise entities |
| Relationship Dictionary | Defines enterprise relationships |
| Logical Data Model | Uses approved enterprise attributes |
| Physical Database Model | Implements approved enterprise attributes |

Each artifact has a single responsibility while remaining fully traceable to the enterprise information architecture.

---

# 6. Enterprise Semantic Principles

Every enterprise attribute documented in this dictionary shall comply with the following principles.

## Principle 1 — Single Meaning

Every attribute shall have exactly one canonical business meaning throughout the enterprise.

---

## Principle 2 — Business First

Attribute definitions shall describe business concepts rather than implementation details.

---

## Principle 3 — Technology Independence

Semantic definitions shall remain independent of programming languages, database products, messaging technologies, and implementation frameworks.

---

## Principle 4 — Consistency

An attribute shall preserve the same meaning regardless of the domain, aggregate, service, or database in which it appears.

---

## Principle 5 — Reusability

Enterprise attributes are reusable business assets.

New attributes shall not be introduced when an approved semantic equivalent already exists.

---

## Principle 6 — Traceability

Every attribute shall be traceable to its governing standards, business domains, and related architectural artifacts.

---

# 7. Dictionary Organization

The Enterprise Attribute Dictionary is organized by enterprise attribute categories.

The recommended organization is:

- Identity Attributes
- Naming Attributes
- Business Attributes
- Classification Attributes
- Reference Attributes
- Lifecycle Attributes
- Temporal Attributes
- Audit Attributes
- Derived Attributes
- External Attributes

Each category groups attributes with similar business responsibilities while preserving semantic consistency.

---

# 8. Standard Attribute Definition Structure

Every attribute documented within this dictionary shall follow the same structure.

| Section | Description |
|----------|-------------|
| Canonical Name | Official enterprise attribute name |
| Business Definition | Canonical semantic definition |
| Business Purpose | Business objective |
| Business Meaning | Enterprise interpretation |
| Business Context | Typical business usage |
| Usage Guidelines | Recommended usage |
| Business Examples | Representative examples |
| Related Attributes | Semantically associated attributes |
| Related Entities | Common entity usage |
| Governing Standards | Applicable enterprise standards |
| Remarks | Additional semantic notes |

This standardized structure ensures that every enterprise attribute is documented consistently and remains understandable throughout the lifecycle of the platform.

---

# 9. Identity Attributes

## id

### Canonical Name

`id`

### Business Definition

The immutable canonical identifier assigned to a business entity within the Phoenix Platform.

### Business Purpose

Provides a permanent enterprise identity that uniquely distinguishes one business object from every other business object.

### Business Meaning

The identifier represents enterprise identity only.

It carries no business semantics and shall never be interpreted as business information.

### Business Context

Used internally throughout all business domains, services, databases, integrations, and architectural layers.

### Usage Guidelines

- Assigned exactly once.
- Never modified.
- Never reused.
- Used as the canonical reference between business entities.

### Business Examples

Every Exchange, Company, Instrument, Trading Board, Sector, Industry, and Market Data record possesses its own immutable enterprise identifier.

### Related Attributes

- public_id
- external_code

### Governing Standards

- Enterprise Identity Standard
- Identifier Strategy
- Enterprise Attribute Standard

---

## public_id

### Canonical Name

`public_id`

### Business Definition

A stable identifier intended for communication with external consumers while protecting the internal enterprise identity.

### Business Purpose

Provides a publicly exposed reference that remains stable without revealing the platform's canonical identifier.

### Business Meaning

Represents the public identity of a business object rather than its internal enterprise identity.

### Business Context

Typically used by:

- REST APIs
- External integrations
- Public documentation
- Future distributed services

### Usage Guidelines

- Shall remain stable throughout the business lifecycle.
- Shall never replace the canonical `id`.
- May be exposed outside the enterprise boundary.

### Related Attributes

- id
- external_code

### Governing Standards

- Enterprise Identity Standard
- Identifier Strategy

---

# 10. Naming Attributes

## code

### Canonical Name

`code`

### Business Definition

A concise business identifier used to distinguish business objects within a specific business context.

### Business Purpose

Supports business communication, reporting, operational activities, and human recognition.

### Business Meaning

Represents a meaningful business code governed by enterprise business rules.

### Business Context

Typical examples include:

- Exchange Code
- Market Code
- Company Code
- Instrument Code

### Usage Guidelines

Business codes shall:

- remain meaningful;
- follow approved naming conventions;
- remain stable whenever practical;
- never replace enterprise identifiers.

### Related Attributes

- short_name
- name
- display_name

### Governing Standards

- Enterprise Naming Standard
- Enterprise Attribute Standard

---

## name

### Canonical Name

`name`

### Business Definition

The official human-readable name assigned to a business object.

### Business Purpose

Provides the primary textual representation used throughout the enterprise.

### Business Meaning

Represents the canonical business designation recognized by users and business processes.

### Business Context

Applicable to virtually every enterprise entity, including:

- Exchanges
- Companies
- Markets
- Trading Boards
- Industries
- Sectors

### Usage Guidelines

Names shall:

- use approved business terminology;
- remain unambiguous;
- comply with the Enterprise Naming Standard.

### Related Attributes

- short_name
- display_name
- full_name
- code

### Governing Standards

- Enterprise Naming Standard
- Enterprise Attribute Standard

---

# 11. Business Attributes

## registration_number

### Canonical Name

`registration_number`

### Business Definition

The official identifier assigned to a business entity by a legally recognized registration authority.

### Business Purpose

Supports legal, regulatory, and organizational identification.

### Business Meaning

Represents an externally recognized business registration rather than an enterprise-generated identifier.

### Business Context

Typically applicable to legal entities such as companies, organizations, exchanges, and regulatory bodies.

### Usage Guidelines

Registration numbers shall preserve the original value assigned by the issuing authority.

### Related Attributes

- code
- external_code

### Governing Standards

- Enterprise Attribute Standard
- Enterprise Identity Standard

---

## listing_date

### Canonical Name

`listing_date`

### Business Definition

The official business date on which a financial instrument becomes eligible for trading within a regulated market.

### Business Purpose

Marks the beginning of the instrument's active trading lifecycle.

### Business Meaning

Represents the formal admission of an instrument to an exchange or trading venue.

### Business Context

Applicable to listed securities such as:

- Equities
- Exchange-Traded Funds (ETFs)
- Bonds
- Other exchange-listed financial instruments

### Usage Guidelines

The listing date shall correspond to the officially approved market listing date and shall remain unchanged unless corrected by the authoritative market source.

### Related Attributes

- trading_date
- effective_from
- status

### Governing Standards

- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard

---

# 12. Reference Attributes

## exchange_id

### Canonical Name

`exchange_id`

### Business Definition

A reference identifying the Exchange responsible for governing or hosting a business object.

### Business Purpose

Establishes the relationship between business entities and their governing exchange.

### Business Meaning

Represents an enterprise relationship rather than an identifier with independent business meaning.

### Business Context

Commonly referenced by:

- Markets
- Trading Boards
- Instruments
- Listings
- Trading Calendars

### Usage Guidelines

Reference attributes shall always point to the canonical enterprise identifier of the referenced Aggregate Root.

Business codes and external identifiers shall not be used as substitute references.

### Related Attributes

- market_id
- company_id
- trading_board_id

### Governing Standards

- Enterprise Attribute Standard
- Enterprise Identity Standard
- Identifier Strategy

---

## company_id

### Canonical Name

`company_id`

### Business Definition

A reference identifying the Company associated with another enterprise object.

### Business Purpose

Represents ownership or business association between enterprise entities.

### Business Meaning

Provides the canonical enterprise relationship to the owning company.

### Business Context

Used by entities such as:

- Instruments
- Listings
- Corporate Actions
- Financial Statements

### Usage Guidelines

Relationships shall reference the Company's canonical enterprise identifier.

### Related Attributes

- exchange_id
- instrument_id

### Governing Standards

- Enterprise Attribute Standard
- Identifier Strategy

---

# 13. Lifecycle Attributes

## status

### Canonical Name

`status`

### Business Definition

Represents the current business state of an enterprise object.

### Business Purpose

Supports lifecycle management and business decision-making.

### Business Meaning

Indicates where a business object resides within its approved lifecycle.

### Business Context

Examples include:

- Active
- Suspended
- Archived
- Retired

The allowed values shall be governed by the business domain responsible for the entity.

### Related Attributes

- is_active
- effective_from
- effective_to

### Governing Standards

- Enterprise Attribute Standard
- Base Entity Standard

---

## is_active

### Canonical Name

`is_active`

### Business Definition

Indicates whether a business object is currently operational and available for normal business processes.

### Business Purpose

Provides a simple operational indicator without describing the complete lifecycle state.

### Business Meaning

Represents operational availability rather than deletion or archival status.

### Usage Guidelines

This attribute shall not be used as a replacement for lifecycle management or soft-delete mechanisms.

### Related Attributes

- status
- effective_from
- effective_to

### Governing Standards

- Base Entity Standard
- Enterprise Attribute Standard

---

# 14. Governance

Every attribute documented within this dictionary shall:

- have exactly one canonical business definition;
- remain technology independent;
- comply with Enterprise Data Standards;
- be registered within the Enterprise Attribute Catalog;
- preserve semantic consistency across all business domains;
- remain traceable to its governing standards and architectural artifacts.

Semantic modifications shall be reviewed through the Phoenix Architecture Governance process before approval.

---

# 15. Repository Integration

The Enterprise Attribute Dictionary is maintained within the Enterprise Data capability.

```text
Data/
└── Dictionary/
    ├── AttributeCatalog.md
    ├── AttributeDictionary.md
    ├── EntityDictionary.md
    └── RelationshipDictionary.md
```

The dictionary serves as the authoritative semantic reference for:

- Enterprise Architecture
- Business Analysis
- Information Architecture
- Logical Data Modeling
- Physical Database Design
- API Design
- Service Contracts
- Reporting
- Analytics
- Artificial Intelligence

---

# 16. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-09 | Redesigned with Single Source of Truth alignment. |
| 2026.3 | 2026-07-22 | Complete redesign as the Enterprise Semantic Dictionary. Introduced semantic architecture, standardized attribute definition structure, governance model, repository integration, traceability framework, and alignment with the Enterprise Data Standards framework. |

---

# 17. Approval

This document is an approved **Enterprise Semantic Dictionary** of the Phoenix Platform.

It defines the canonical business meaning of every registered enterprise attribute and serves as the semantic foundation of the Enterprise Data Dictionary.

The Enterprise Attribute Catalog governs attribute registration, while this dictionary governs attribute semantics.

Both artifacts shall remain synchronized throughout the lifecycle of the Phoenix Platform.

---

# End of Document