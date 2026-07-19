# Enterprise Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-001 |
| Document | EnterpriseDataDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Logical Data Architecture |
| Owner | Enterprise Architecture |
| Phase | Stage 10 — Enterprise Data Dictionary |
| Depends On | CanonicalEntityDefinitions, AttributeCatalog, AttributeDictionary, LogicalDatabaseModel, PhysicalDatabaseModel |
| Consumed By | DatabaseDDL, PostgreSQLImplementation, DataMigration, EnterpriseServices |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

The Enterprise Data Dictionary defines the canonical business and technical metadata for all enterprise entities, attributes and relationships within the Phoenix Platform.

It serves as the authoritative metadata repository for the Enterprise Logical Data Architecture and establishes a consistent vocabulary across all architectural and implementation artifacts.

This document standardizes business definitions, attribute semantics, naming conventions and metadata classifications to ensure consistency throughout the enterprise data lifecycle.

The Enterprise Data Dictionary provides the primary reference for logical data modeling, physical database design, service implementation, data integration and enterprise governance while remaining independent of any specific database management system, programming language or implementation technology.

As a canonical architecture artifact, this document acts as the Single Source of Truth (SSOT) for enterprise metadata and ensures that all derived artifacts remain semantically consistent across the Phoenix Platform.

---

# 2. Scope

The Enterprise Data Dictionary applies to every canonical data asset defined within the Phoenix Platform Enterprise Architecture.

It establishes the enterprise metadata standards governing business entities, attributes, identifiers and relationships throughout the entire data architecture lifecycle.

This document applies to the following architectural artifacts:

- Canonical Domain Model
- Conceptual Database Model
- Domain Logical Models
- Canonical Entity Definitions
- Aggregate Catalog
- Attribute Catalog
- Attribute Dictionary
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Cardinality Matrix
- Aggregate Dependency Matrix
- Domain Dependency Matrix
- Business Constraint Matrix
- Canonical Enterprise ERD
- Logical Database Model
- Physical Database Model
- Database Definition Language (DDL)
- Enterprise Reference Data
- Integration Mapping Specifications

The Enterprise Data Dictionary governs the definition and usage of:

- Business Entities
- Business Attributes
- Business Identifiers
- Enterprise Metadata
- Reference Data
- Business Relationships
- Naming Standards
- Data Classification
- Attribute Semantics
- Business Constraints

Implementation-specific concerns, including database engine optimization, indexing strategies, storage allocation, programming language constructs and application-specific behavior, are intentionally excluded from this document.

---

# 3. Objectives

The Enterprise Data Dictionary is established to achieve the following architectural objectives:

- Establish a single, authoritative repository for enterprise metadata.
- Standardize business terminology across the Phoenix Platform.
- Provide consistent business definitions for all canonical entities and attributes.
- Eliminate ambiguity and duplication in enterprise data definitions.
- Ensure semantic consistency across all architectural artifacts.
- Define standardized metadata for enterprise entities, attributes and identifiers.
- Support Conceptual, Logical and Physical Data Modeling activities.
- Establish a common reference for database design and implementation.
- Promote consistency across enterprise services and data integration.
- Support enterprise data governance and metadata management.
- Improve traceability between business concepts and implementation artifacts.
- Enable consistent validation of business rules and architectural constraints.
- Facilitate maintainability and long-term evolution of the enterprise data architecture.
- Support enterprise reporting, analytics and integration through standardized metadata.
- Serve as the authoritative reference for all enterprise data definitions throughout the architecture lifecycle.

The Enterprise Data Dictionary is a canonical architecture artifact and shall remain the Single Source of Truth (SSOT) for enterprise metadata within the Phoenix Platform.

---

# 4. Governance

The Enterprise Data Dictionary is governed by the Phoenix Platform Enterprise Architecture governance framework and is maintained as a controlled architectural artifact.

It defines the authoritative business and technical metadata for enterprise information assets and serves as the canonical reference for all data architecture activities throughout the platform lifecycle.

All entity definitions, attribute definitions, business identifiers, naming conventions and metadata classifications contained within this document are considered canonical unless superseded by an approved Enterprise Architecture decision.

The Enterprise Data Dictionary shall remain synchronized with all architecture artifacts that define or consume enterprise metadata.

## Governance Principles

The following principles govern this document.

### GOV-001 — Single Source of Truth

The Enterprise Data Dictionary shall serve as the authoritative source for all enterprise data definitions.

Duplicate or conflicting metadata definitions are prohibited.

---

### GOV-002 — Architecture Ownership

Ownership of this document resides exclusively with the Enterprise Architecture function.

Business units, development teams and implementation projects may consume this document but shall not redefine canonical metadata.

---

### GOV-003 — Technology Independence

Business definitions shall remain independent of database platforms, programming languages, frameworks and implementation technologies.

Technology-specific implementation details belong to lower architectural layers.

---

### GOV-004 — Repository Consistency

Every entity, attribute, identifier and relationship defined in this document shall remain consistent with the approved Enterprise Architecture repository.

Any inconsistency shall be resolved through the Architecture Governance process.

---

### GOV-005 — Metadata Traceability

Every metadata definition shall be traceable to one or more approved architectural artifacts, including business concepts, domain models, logical models and physical models.

Traceability shall be maintained throughout the architecture lifecycle.

---

### GOV-006 — Controlled Evolution

Changes to enterprise metadata shall occur only through approved architecture governance procedures.

All modifications shall preserve backward semantic compatibility whenever possible.

---

### GOV-007 — Standardized Metadata

All enterprise entities shall follow a common metadata structure, including:

- Business Definition
- Technical Definition
- Business Identifier
- Enterprise Identifier
- Attributes
- Relationships
- Business Rules
- Ownership
- Traceability

---

### GOV-008 — Cross-Artifact Consistency

Definitions contained in this document shall remain consistent with:

- Canonical Domain Model
- Canonical Entity Definitions
- Aggregate Catalog
- Attribute Catalog
- Attribute Dictionary
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Cardinality Matrix
- Logical Database Model
- Physical Database Model

Conflicting definitions shall not exist across architectural artifacts.

---

### GOV-009 — Enterprise Governance

The Enterprise Data Dictionary forms part of the Phoenix Enterprise Architecture Baseline.

Any modification affecting enterprise metadata shall require:

- Architecture Review
- Metadata Validation
- Business Impact Analysis
- Architecture Board Approval
- Repository Baseline Update (when applicable)

---

### GOV-010 — Canonical Authority

When inconsistencies arise between implementation artifacts and this document, the Enterprise Data Dictionary shall be regarded as the authoritative reference until an approved architectural change is adopted.

---

# 5. Dictionary Rules

The Enterprise Data Dictionary is governed by the following canonical rules. These rules define the minimum requirements for documenting, maintaining and governing enterprise metadata throughout the Phoenix Platform.

---

## DDR-001 — Canonical Definition

Every business entity shall have exactly one canonical definition within the Enterprise Data Dictionary.

Duplicate entity definitions are prohibited.

---

## DDR-002 — Unique Business Concept

Each business concept shall be represented only once.

Multiple entities shall not represent the same business meaning.

---

## DDR-003 — Standardized Entity Documentation

Every enterprise entity shall be documented using the approved metadata structure defined by the Enterprise Architecture.

Mandatory metadata shall include, where applicable:

- Business Definition
- Technical Definition
- Business Identifier
- Enterprise Identifier
- Ownership
- Attributes
- Relationships
- Business Rules
- Traceability
- Related Architectural Artifacts

---

## DDR-004 — Standardized Attribute Documentation

Every attribute shall have a single authoritative definition.

Each attribute definition shall include its business meaning, technical characteristics and governance information.

Duplicate attribute definitions are prohibited.

---

## DDR-005 — Technology Independence

Business definitions shall remain independent of implementation technologies.

The Enterprise Data Dictionary shall not include:

- Database-specific syntax
- SQL statements
- ORM mappings
- Programming language constructs
- Implementation-specific logic

---

## DDR-006 — Consistent Naming

Entity names, attribute names and identifiers shall comply with the Enterprise Naming Standards.

Naming conventions shall remain consistent across all Enterprise Architecture artifacts.

---

## DDR-007 — Stable Business Identity

Every enterprise entity shall possess a stable business identity that remains unchanged throughout its business lifecycle.

Changes in operational state shall never alter business identity.

---

## DDR-008 — Metadata Consistency

Metadata definitions shall remain synchronized with all approved architectural artifacts, including:

- Conceptual Database Model
- Logical Database Model
- Physical Database Model
- Canonical Entity Definitions
- Aggregate Catalog
- Attribute Catalog
- Attribute Dictionary

---

## DDR-009 — Cross-Reference Integrity

Every documented relationship shall reference approved enterprise entities only.

Undefined or deprecated entities shall not appear within the Enterprise Data Dictionary.

---

## DDR-010 — Traceability

Every entity, attribute and business rule shall be traceable to one or more authoritative architectural artifacts.

Traceability shall be maintained throughout the complete architecture lifecycle.

---

## DDR-011 — Controlled Evolution

Modifications to canonical metadata shall follow the Enterprise Architecture governance process.

All changes shall be reviewed, validated and approved before becoming part of the official repository baseline.

---

## DDR-012 — Business Rule Consistency

Business definitions contained in this document shall never contradict approved Canonical Business Rules.

Where conflicts exist, the Canonical Business Rules shall take precedence until an approved architectural revision is completed.

---

## DDR-013 — Repository Alignment

The Enterprise Data Dictionary shall remain fully aligned with the approved Phoenix repository structure and its canonical architectural artifacts.

No entity or attribute shall be documented unless it exists within the approved Enterprise Architecture baseline.

---

## DDR-014 — Single Source of Truth

The Enterprise Data Dictionary is the authoritative source for enterprise metadata.

Implementation artifacts, database schemas and application code shall conform to the definitions contained within this document and shall not redefine enterprise metadata independently.

---

# 6. Common Metadata Standard

Every enterprise entity documented within the Enterprise Data Dictionary shall follow a standardized metadata structure to ensure consistency, traceability and architectural governance across the Phoenix Platform.

The metadata defined in this section establishes the minimum documentation requirements for all canonical business entities, regardless of their business domain or implementation technology.

The metadata model is governed by the Enterprise Architecture and shall be applied consistently throughout all conceptual, logical and physical data architecture artifacts.

---

## 6.1 Mandatory Metadata

Every enterprise entity shall include the following metadata sections.

| Metadata | Purpose |
|----------|---------|
| Business Definition | Describes the business meaning of the entity. |
| Technical Definition | Describes the architectural role of the entity. |
| Business Identifier | Defines the primary business identity of the entity. |
| Enterprise Identifier | Defines the internal enterprise identifier. |
| Primary Key | Defines the logical primary identifier. |
| Alternate Keys | Defines approved alternate business identifiers. |
| Foreign Keys | Identifies logical references to other entities where applicable. |
| Attributes | Defines all approved entity attributes. |
| Relationships | Describes relationships with other enterprise entities. |
| Business Rules | Defines business constraints governing the entity. |
| Ownership | Identifies the responsible business domain and aggregate. |
| Traceability | Links the entity to related architectural artifacts. |
| Source ADR | References governing Architecture Decision Records. |
| Related Documents | References associated Enterprise Architecture documents. |

---

## 6.2 Metadata Standardization Principles

The following principles govern enterprise metadata.

### MDS-001 — Completeness

Every canonical entity shall include all mandatory metadata sections.

Incomplete entity definitions shall not be considered architecturally complete.

---

### MDS-002 — Consistency

Metadata shall remain consistent across all Enterprise Architecture artifacts.

Definitions appearing in multiple documents shall convey identical business meaning.

---

### MDS-003 — Technology Independence

Metadata shall describe business concepts rather than implementation details.

Database-specific definitions, programming constructs and infrastructure concerns are intentionally excluded.

---

### MDS-004 — Canonical Ownership

Every metadata element shall have exactly one authoritative definition.

Duplicate ownership of metadata is prohibited.

---

### MDS-005 — Traceability

Every metadata element shall be traceable to approved Enterprise Architecture artifacts.

Business definitions, attributes and relationships shall maintain complete architectural traceability.

---

## 6.3 Metadata Lifecycle

Enterprise metadata progresses through the following lifecycle.

```text
Business Concept
        │
        ▼
Canonical Definition
        │
        ▼
Enterprise Data Dictionary
        │
        ▼
Logical Database Model
        │
        ▼
Physical Database Model
        │
        ▼
Database Implementation
```

Each stage refines the previous one without altering the original business meaning.

---

## 6.4 Metadata Governance

Enterprise metadata shall be governed according to the following rules.

- Metadata shall remain centrally managed.
- Canonical definitions shall not be duplicated.
- Business terminology shall remain standardized.
- Metadata shall evolve through approved architecture governance.
- Repository consistency shall be preserved.
- Backward semantic compatibility shall be maintained whenever practical.

---

## 6.5 Metadata Usage

The metadata defined within this document shall be used by:

- Conceptual Database Model
- Logical Database Model
- Physical Database Model
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Aggregate Catalog
- Attribute Catalog
- Attribute Dictionary
- Database Definition Language (DDL)
- Data Integration Services
- Reporting Services
- Enterprise APIs
- Architecture Governance Processes

These artifacts shall consume enterprise metadata from this document and shall not redefine canonical business information independently.

---

# 7. Common Enterprise Attributes

The Phoenix Platform adopts a standardized set of enterprise attributes that are shared across business entities whenever applicable.

These attributes provide a consistent foundation for identity, governance, lifecycle management, auditing and integration while preserving business semantics and technology independence.

The standardization of enterprise attributes improves consistency across conceptual, logical and physical data models and simplifies enterprise-wide governance.

---

## 7.1 Attribute Categories

Enterprise attributes are organized into the following categories.

| Category | Purpose |
|----------|---------|
| Identity Attributes | Identify business entities uniquely. |
| Business Attributes | Describe the business characteristics of an entity. |
| Reference Attributes | Establish logical relationships between entities. |
| Lifecycle Attributes | Describe the lifecycle state of an entity. |
| Audit Attributes | Record creation and modification metadata. |
| Governance Attributes | Support enterprise governance and version management. |
| Integration Attributes | Support interoperability with external systems. |

---

## 7.2 Identity Attributes

Identity attributes uniquely identify enterprise business entities.

| Attribute | Purpose |
|----------|---------|
| id | Internal enterprise identifier. |
| code | Stable business identifier. |
| external_code | Optional identifier provided by an external system. |

Identity attributes shall remain stable throughout the lifetime of the entity.

---

## 7.3 Lifecycle Attributes

Lifecycle attributes describe the operational state of an entity.

| Attribute | Purpose |
|----------|---------|
| is_active | Indicates whether the entity is currently active. |
| effective_from | Start of business validity period, where applicable. |
| effective_to | End of business validity period, where applicable. |

Lifecycle attributes describe business validity and shall not modify business identity.

---

## 7.4 Audit Attributes

Audit attributes support enterprise traceability.

| Attribute | Purpose |
|----------|---------|
| created_at | Date and time the entity was created. |
| created_by | User or process that created the entity. |
| updated_at | Date and time of the most recent modification. |
| updated_by | User or process responsible for the latest modification. |

These attributes provide operational traceability and are common across enterprise entities where updates are permitted.

---

## 7.5 Governance Attributes

Governance attributes support enterprise data management.

| Attribute | Purpose |
|----------|---------|
| row_version | Supports optimistic concurrency and controlled updates. |
| description | Optional descriptive information. |
| display_order | Preferred presentation order where applicable. |

Governance attributes improve consistency without affecting business meaning.

---

## 7.6 Integration Attributes

Integration attributes support interoperability with external information providers.

| Attribute | Purpose |
|----------|---------|
| external_code | Identifier assigned by an external provider. |
| provider_reference | Reference to the originating external system, where applicable. |

Integration attributes shall never replace enterprise business identifiers.

---

## 7.7 Attribute Standardization Rules

The following rules apply to all common enterprise attributes.

| Rule ID | Rule |
|----------|------|
| EA-001 | Enterprise attributes shall have one canonical definition. |
| EA-002 | Attribute names shall follow the Enterprise Naming Standard. |
| EA-003 | Business identifiers shall remain immutable. |
| EA-004 | External identifiers shall never replace enterprise identifiers. |
| EA-005 | Audit attributes shall support enterprise traceability. |
| EA-006 | Governance attributes shall support enterprise consistency. |
| EA-007 | Common attributes shall be reused wherever applicable rather than redefined. |

---

## 7.8 Architectural Notes

The Common Enterprise Attributes defined in this section establish conceptual standards only.

Detailed attribute specifications, data types, constraints, nullability and implementation details are defined in the following authoritative artifacts:

- Enterprise Attribute Standard
- Attribute Catalog
- Attribute Dictionary
- Aggregate Attribute Matrix
- Logical Database Model
- Physical Database Model

This document intentionally defines the enterprise-level attribute taxonomy rather than implementation-specific metadata.

---

# 8. Identifier Strategy

The Phoenix Platform adopts a standardized enterprise identifier strategy to ensure consistency, traceability, interoperability and long-term data integrity across all architecture layers.

The identifier strategy is defined independently of any database technology and shall be applied consistently throughout the Conceptual Model, Logical Database Model, Physical Database Model and implementation artifacts.

## 8.1 Identifier Principles

The following principles govern enterprise identifiers.

- Every entity shall have exactly one Primary Identifier.
- Business identifiers shall remain stable throughout the entity lifecycle.
- Internal identifiers shall never be exposed as business identifiers.
- Business identifiers shall be implementation independent.
- External identifiers shall be managed separately from enterprise identifiers.
- Identifier uniqueness shall be enforced according to business semantics.
- Identifier definitions shall be governed centrally.

---

## 8.2 Enterprise Identifier Types

The Phoenix Platform recognizes the following identifier categories.

| Identifier Type | Purpose |
|-----------------|---------|
| Primary Identifier | Internal enterprise identity |
| Business Identifier | Stable business identity |
| External Identifier | Identifier supplied by external providers |
| Alternate Identifier | Optional additional business identifier |

---

## 8.3 Primary Identifier

Every enterprise entity shall define one Primary Identifier.

The Primary Identifier represents the internal identity of the entity and is independent of business meaning.

Characteristics include:

- Globally unique within the entity.
- Never reused.
- Never modified after creation.
- Technology independent at the conceptual level.

---

## 8.4 Business Identifier

Business Identifiers represent stable business concepts recognized by users and business processes.

Examples include:

- Exchange Code
- Market Code
- Board Code
- Sector Code
- Industry Code
- Company Code
- Instrument Code

Business identifiers shall:

- remain stable;
- be unique within their defined business scope;
- never be reassigned to different business entities.

---

## 8.5 External Identifier

External Identifiers represent identifiers assigned by external organizations or data providers.

Examples include:

- Exchange-specific codes
- Vendor security identifiers
- External market identifiers

External identifiers:

- do not define enterprise identity;
- are managed independently by the Integration Domain;
- may vary between providers;
- may change without affecting enterprise identity.

---

## 8.6 Alternate Identifier

Some entities may define additional identifiers for business interoperability.

Alternate identifiers:

- supplement the primary business identifier;
- shall not replace the canonical business identifier;
- remain optional unless required by business rules.

---

## 8.7 Identifier Governance

Enterprise identifiers shall comply with the following governance principles.

- Identifier ownership shall be unique.
- Identifier definitions shall remain centrally governed.
- Duplicate identifiers are prohibited.
- Identifier lifecycle shall be fully traceable.
- Identifier semantics shall remain implementation independent.

---

## 8.8 Architectural Traceability

The enterprise identifier strategy is realized throughout the architecture by the following artifacts.

| Artifact | Purpose |
|----------|---------|
| Canonical Business Rules | Identifier governance |
| Canonical Entity Definitions | Business identity |
| Logical Database Model | Logical identifier realization |
| Physical Database Model | Physical identifier implementation |
| Enterprise Relationship Matrix | Identifier relationships |
| Enterprise Data Dictionary | Identifier metadata |
| Integration Domain Logical Model | External identifier management |

---

# 9. Reference Entities

Reference Entities define the canonical business classification framework of the Phoenix Platform.

These entities provide stable enterprise reference information that is shared across multiple business domains and supports consistent classification, validation and business interpretation.

Reference entities are centrally governed and evolve independently from transactional and historical business data.

They establish the common business vocabulary used throughout the platform and serve as the foundation for logical and physical data architecture.

---

## 9.1 Architectural Characteristics

Reference Entities exhibit the following architectural characteristics.

- Represent stable business concepts.
- Maintain enterprise-wide consistency.
- Are shared across multiple business domains.
- Have well-defined business ownership.
- Change infrequently compared to operational data.
- Remain technology independent.
- Serve as authoritative classification sources.

---

## 9.2 Reference Entity Hierarchy

The Phoenix Platform organizes its reference entities according to the following conceptual hierarchy.

```text
Exchange
    │
    ▼
Market
    │
    ▼
Trading Board
    │
    ▼
Sector
    │
    ▼
Industry
    │
    ▼
Company
    │
    ▼
Instrument
```

The hierarchy represents conceptual business classification and shall not be interpreted as a physical database structure.

---

## 9.3 Canonical Reference Entities

The following entities constitute the canonical enterprise reference model.

| Entity | Business Purpose |
|---------|------------------|
| Exchange | Defines regulated trading organizations. |
| Market | Defines logical markets operated by an Exchange. |
| Trading Board | Defines trading environments within a Market. |
| Sector | Defines high-level business classifications. |
| Industry | Defines detailed business classifications within a Sector. |
| Company | Defines legal business organizations participating in financial markets. |
| Instrument | Defines tradable financial instruments issued by companies. |

---

## 9.4 Governance Principles

Reference entities are governed according to the following principles.

- Each entity shall have one authoritative business definition.
- Each entity shall belong to exactly one business domain.
- Business identifiers shall remain stable.
- Duplicate business concepts are prohibited.
- Enterprise-wide reuse is mandatory.
- Changes shall be controlled through architecture governance.

---

## 9.5 Relationship with Other Domains

Reference entities provide foundational business information for multiple enterprise domains.

| Consumer Domain | Usage |
|-----------------|-------|
| Core Domain | Business ownership and classification |
| Market Domain | Trading structure and market organization |
| Integration Domain | External identifier mapping |
| Configuration Domain | Business parameter classification |
| Reporting Domain | Enterprise reporting and analytics |
| Audit Domain | Business event traceability |

Reference entities remain independent of the consuming domains.

---

## 9.6 Transition to Entity Definitions

The detailed metadata, business attributes, relationships and business rules for each reference entity are defined in the following sections of this document.

Each entity specification follows a standardized enterprise metadata template to ensure consistency across all architecture artifacts.

---

# 10. Reference Entity Specifications

The following sections define the canonical metadata for each Reference Entity.

Each specification follows a standardized enterprise template to ensure consistency across all architectural artifacts, including the Conceptual Database Model, Logical Database Model, Physical Database Model and Enterprise Relationship Model.

Each entity specification includes:

- Business Definition
- Technical Definition
- Business Ownership
- Business Identifier
- Primary Key
- Alternate Keys
- Foreign Keys
- Attributes
- Relationships
- Business Rules
- Related Artifacts

The entities are presented according to the enterprise reference hierarchy.

| Order | Entity | Domain | Aggregate |
|------:|--------|--------|-----------|
| 10.1 | Exchange | Reference Domain | Exchange |
| 10.2 | Market | Reference Domain | Market |
| 10.3 | Trading Board | Reference Domain | Trading Board |
| 10.4 | Sector | Reference Domain | Sector |
| 10.5 | Industry | Reference Domain | Industry |
| 10.6 | Company | Core Domain | Company |
| 10.7 | Instrument | Core Domain | Instrument |

---

## Standard Entity Metadata Template

Every entity specification shall use the following standardized structure.

1. Business Definition
2. Technical Definition
3. Business Ownership
4. Business Identifier
5. Primary Key
6. Alternate Keys
7. Foreign Keys
8. Attributes
9. Relationships
10. Business Rules
11. Related Artifacts

This standardized template guarantees architectural consistency across the Enterprise Data Dictionary and all derived data architecture artifacts.

---

## Relationship to Other Architecture Artifacts

The detailed entity specifications defined in this chapter are traceable to the following enterprise artifacts.

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical business entities |
| Aggregate Catalog | Aggregate ownership |
| Aggregate Attribute Matrix | Attribute allocation |
| Enterprise Relationship Catalog | Relationship definitions |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |

---

The detailed specifications begin with **Section 10.1 — Exchange**.

---

# 11. Exchange

## 11.1 Business Definition

An Exchange represents a regulated financial organization responsible for operating one or more securities markets under a defined legal and regulatory framework.

The Exchange serves as the highest-level business classification within the Phoenix Platform market hierarchy and provides the organizational context for all subordinate market structures.

---

## 11.2 Technical Definition

The Exchange entity is the root reference entity within the Reference Domain.

It establishes the organizational boundary for Markets and represents the highest level of the enterprise market classification model.

An Exchange is managed independently and may support multiple Markets.

---

## 11.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Reference Domain |
| Aggregate | Exchange |
| Business Owner | Enterprise Reference Data Management |
| Entity Type | Reference Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 11.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Exchange Code | Stable enterprise business identifier |

The business identifier shall remain stable throughout the lifecycle of the Exchange.

---

## 11.5 Primary Key

| Attribute | Description |
|----------|-------------|
| exchange_id | Surrogate primary identifier |

The primary key is an implementation identifier and carries no business meaning.

---

## 11.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| exchange_code | Enterprise business code |

---

## 11.7 Foreign Keys

The Exchange entity is the root of the enterprise market classification hierarchy.

Therefore, it has no mandatory foreign key dependencies.

---

## 11.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| exchange_code | Enterprise business code |
| exchange_name | Official business name |
| short_name | Abbreviated business name |
| english_name | International business name |
| country_code | Country of operation |
| timezone | Official trading time zone |
| currency_code | Primary trading currency |
| description | Business description |
| display_order | Presentation ordering |
| is_active | Operational status |

Common enterprise audit attributes are defined by the Enterprise Data Standard and are not repeated here.

---

## 11.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Market | Operates | One-to-Many |

Relationship details are formally defined in the Enterprise Relationship Matrix and Cardinality Matrix.

---

## 11.10 Business Rules

- Every Exchange shall possess a unique Exchange Code.
- Exchange names should remain unique within the enterprise.
- An Exchange may operate one or more Markets.
- Every Market shall belong to exactly one Exchange.
- Business identifiers shall remain immutable.
- Exchange information shall be centrally governed.

---

## 11.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

    # 12. Market

## 12.1 Business Definition

A Market represents a logical trading environment operating under the authority of an Exchange.

It defines a regulated trading environment that groups one or more Trading Boards sharing common operational characteristics, trading rules and business policies.

The Market serves as the primary organizational layer between the Exchange and Trading Board within the enterprise market classification hierarchy.

---

## 12.2 Technical Definition

The Market entity is a canonical reference entity within the Reference Domain.

It represents the logical organization of trading activities and provides the business context for Trading Boards operating under the same market structure.

Each Market belongs to exactly one Exchange and may contain multiple Trading Boards.

---

## 12.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Reference Domain |
| Aggregate | Market |
| Business Owner | Enterprise Reference Data Management |
| Entity Type | Reference Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 12.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Market Code | Stable enterprise business identifier |

The Market Code uniquely identifies a Market within the enterprise and shall remain stable throughout its lifecycle.

---

## 12.5 Primary Key

| Attribute | Description |
|----------|-------------|
| market_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and has no business meaning.

---

## 12.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| market_code | Enterprise business code |

---

## 12.7 Foreign Keys

| Attribute | References |
|----------|------------|
| exchange_id | Exchange |

Every Market shall belong to exactly one Exchange.

---

## 12.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| market_code | Enterprise business code |
| market_name | Official market name |
| short_name | Abbreviated market name |
| english_name | International market name |
| description | Business description |
| display_order | Default presentation order |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 12.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Exchange | Belongs to | Many-to-One |
| Trading Board | Contains | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 12.10 Business Rules

- Every Market shall belong to exactly one Exchange.
- Every Market shall possess a unique Market Code.
- A Market may contain one or more Trading Boards.
- Market identity shall remain independent of Trading Board definitions.
- Market business identifiers shall remain immutable.
- Market definitions shall be governed centrally by the Reference Domain.

---

## 12.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 13. Trading Board

## 13.1 Business Definition

A Trading Board represents a regulated trading environment within a Market where financial instruments are admitted for trading under a defined set of business and operational rules.

Trading Boards provide the organizational structure through which listed financial instruments are categorized according to trading characteristics, market regulations and listing requirements.

---

## 13.2 Technical Definition

The Trading Board entity is a canonical reference entity within the Reference Domain.

It represents a business classification layer subordinate to a Market and provides the business context for Instrument Listings.

Each Trading Board belongs to exactly one Market and may contain multiple Instrument Listings.

---

## 13.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Reference Domain |
| Aggregate | Trading Board |
| Business Owner | Enterprise Reference Data Management |
| Entity Type | Reference Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 13.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Trading Board Code | Stable enterprise business identifier |

The Trading Board Code uniquely identifies a Trading Board within the enterprise and shall remain stable throughout its lifecycle.

---

## 13.5 Primary Key

| Attribute | Description |
|----------|-------------|
| trading_board_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and carries no business meaning.

---

## 13.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| trading_board_code | Enterprise business code |

---

## 13.7 Foreign Keys

| Attribute | References |
|----------|------------|
| market_id | Market |

Every Trading Board shall belong to exactly one Market.

---

## 13.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| trading_board_code | Enterprise business code |
| trading_board_name | Official trading board name |
| short_name | Abbreviated name |
| english_name | International name |
| description | Business description |
| display_order | Default presentation order |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 13.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Market | Belongs to | Many-to-One |
| Instrument Listing | Contains | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 13.10 Business Rules

- Every Trading Board shall belong to exactly one Market.
- Every Trading Board shall possess a unique Trading Board Code.
- A Trading Board may contain multiple Instrument Listings.
- Trading Board identity shall remain independent of listed instruments.
- Trading Board business identifiers shall remain immutable.
- Trading Board definitions shall be centrally governed by the Reference Domain.

---

## 13.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 14. Sector

## 14.1 Business Definition

A Sector represents the highest level of business classification used to organize companies according to their primary economic activities.

Sectors provide a stable enterprise taxonomy that supports market analysis, reporting, portfolio management and regulatory classification.

Each Sector groups one or more related Industries sharing common economic characteristics.

---

## 14.2 Technical Definition

The Sector entity is a canonical reference entity within the Reference Domain.

It defines the upper level of the enterprise business classification hierarchy and provides the organizational context for Industry classification.

Each Sector may contain one or more Industries.

---

## 14.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Reference Domain |
| Aggregate | Sector |
| Business Owner | Enterprise Reference Data Management |
| Entity Type | Reference Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 14.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Sector Code | Stable enterprise business identifier |

The Sector Code uniquely identifies a Sector within the enterprise and shall remain stable throughout its lifecycle.

---

## 14.5 Primary Key

| Attribute | Description |
|----------|-------------|
| sector_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and carries no business meaning.

---

## 14.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| sector_code | Enterprise business code |

---

## 14.7 Foreign Keys

The Sector entity is a top-level business classification entity.

Therefore, it has no mandatory foreign key dependencies.

---

## 14.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| sector_code | Enterprise business code |
| sector_name | Official sector name |
| short_name | Abbreviated sector name |
| english_name | International sector name |
| description | Business description |
| display_order | Default presentation order |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 14.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Industry | Contains | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 14.10 Business Rules

- Every Sector shall possess a unique Sector Code.
- A Sector may contain one or more Industries.
- Every Industry shall belong to exactly one Sector.
- Sector identity shall remain stable throughout its lifecycle.
- Business identifiers shall remain immutable.
- Sector definitions shall be centrally governed by the Reference Domain.

---

## 14.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 15. Industry

## 15.1 Business Definition

An Industry represents a detailed business classification within a Sector and groups companies engaged in similar economic activities.

Industries provide a finer level of enterprise classification than Sectors and support business analysis, market segmentation, portfolio construction, regulatory reporting and comparative financial analysis.

Each Industry belongs to exactly one Sector and may contain one or more Companies.

---

## 15.2 Technical Definition

The Industry entity is a canonical reference entity within the Reference Domain.

It defines the second level of the enterprise business classification hierarchy and provides the classification context for Companies.

Industry classifications are centrally managed and reused throughout the Phoenix Platform.

---

## 15.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Reference Domain |
| Aggregate | Industry |
| Business Owner | Enterprise Reference Data Management |
| Entity Type | Reference Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 15.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Industry Code | Stable enterprise business identifier |

The Industry Code uniquely identifies an Industry within the enterprise and shall remain stable throughout its lifecycle.

---

## 15.5 Primary Key

| Attribute | Description |
|----------|-------------|
| industry_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and carries no business meaning.

---

## 15.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| industry_code | Enterprise business code |

---

## 15.7 Foreign Keys

| Attribute | References |
|----------|------------|
| sector_id | Sector |

Every Industry shall belong to exactly one Sector.

---

## 15.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| industry_code | Enterprise business code |
| industry_name | Official industry name |
| short_name | Abbreviated industry name |
| english_name | International industry name |
| description | Business description |
| display_order | Default presentation order |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 15.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Sector | Belongs to | Many-to-One |
| Company | Classifies | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 15.10 Business Rules

- Every Industry shall belong to exactly one Sector.
- Every Industry shall possess a unique Industry Code.
- A Sector may contain one or more Industries.
- An Industry may classify one or more Companies.
- Every Company shall belong to exactly one Industry.
- Industry business identifiers shall remain immutable.
- Industry definitions shall be centrally governed by the Reference Domain.

---

## 15.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 16. Company

## 16.1 Business Definition

A Company represents a legally recognized business organization that issues one or more tradable financial instruments.

Within the Phoenix Platform, the Company serves as the canonical representation of a business entity participating in one or more financial markets. It provides the enterprise identity upon which market activities, corporate actions, financial analysis and investment decisions are based.

A Company maintains a stable business identity throughout its lifecycle regardless of changes to its listings, instruments or organizational structure.

---

## 16.2 Technical Definition

The Company entity is a canonical master entity within the Core Domain.

It represents the enterprise business identity of an organization independently of market-specific information.

Each Company belongs to exactly one Industry and may issue one or more Instruments.

---

## 16.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Core Domain |
| Aggregate | Company |
| Business Owner | Enterprise Master Data Management |
| Entity Type | Master Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 16.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Company Code | Stable enterprise business identifier |

The Company Code uniquely identifies a Company within the enterprise and shall remain stable throughout its lifecycle.

---

## 16.5 Primary Key

| Attribute | Description |
|----------|-------------|
| company_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and carries no business meaning.

---

## 16.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| company_code | Enterprise business code |

Additional alternate identifiers may be maintained when required by regulatory authorities or external data providers.

---

## 16.7 Foreign Keys

| Attribute | References |
|----------|------------|
| industry_id | Industry |

Every Company shall belong to exactly one Industry.

Sector classification is derived through the associated Industry.

---

## 16.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| company_code | Enterprise business code |
| company_name | Official company name |
| short_name | Abbreviated company name |
| english_name | International company name |
| national_identifier | Official legal identifier |
| incorporation_country | Country of incorporation |
| description | Business description |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 16.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Industry | Belongs to | Many-to-One |
| Instrument | Issues | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 16.10 Business Rules

- Every Company shall possess a unique Company Code.
- Every Company shall belong to exactly one Industry.
- Sector classification shall be derived from the associated Industry.
- A Company may issue one or more Instruments.
- A Company shall maintain a stable business identity throughout its lifecycle.
- Business identifiers shall remain immutable.
- Company master data shall be centrally governed.

---

## 16.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Core Domain Logical Model | Logical domain model |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 17. Instrument

## 17.1 Business Definition

An Instrument represents a tradable financial asset issued by a Company and admitted for trading within one or more regulated market environments.

Within the Phoenix Platform, the Instrument is the primary business entity used to capture market activity, corporate actions, historical market data, analytical features and investment decisions.

An Instrument maintains a stable business identity throughout its lifecycle regardless of listing changes, market activity or historical trading information.

---

## 17.2 Technical Definition

The Instrument entity is a canonical master entity within the Core Domain.

It represents the enterprise definition of a tradable financial instrument independently of its market listings or historical trading records.

Each Instrument is issued by exactly one Company and may be listed on one or more Trading Boards through Instrument Listings.

---

## 17.3 Business Ownership

| Property | Value |
|----------|-------|
| Business Domain | Core Domain |
| Aggregate | Instrument |
| Business Owner | Enterprise Master Data Management |
| Entity Type | Master Entity |
| Lifecycle | Managed |
| Sharing | Enterprise-wide |

---

## 17.4 Business Identifier

| Identifier | Description |
|------------|-------------|
| Instrument Code | Stable enterprise business identifier |

The Instrument Code uniquely identifies an Instrument within the enterprise and shall remain stable throughout its lifecycle.

---

## 17.5 Primary Key

| Attribute | Description |
|----------|-------------|
| instrument_id | Surrogate primary identifier |

The primary key provides the internal enterprise identity and carries no business meaning.

---

## 17.6 Alternate Keys

| Attribute | Description |
|----------|-------------|
| instrument_code | Enterprise business code |

Additional alternate identifiers may be maintained for integration with external market data providers.

---

## 17.7 Foreign Keys

| Attribute | References |
|----------|------------|
| company_id | Company |

Every Instrument shall belong to exactly one Company.

Market participation is established through Instrument Listings and is not a direct property of the Instrument.

---

## 17.8 Attributes

| Attribute | Business Purpose |
|-----------|------------------|
| instrument_code | Enterprise business code |
| instrument_name | Official instrument name |
| short_name | Abbreviated instrument name |
| english_name | International instrument name |
| instrument_type | Classification of the financial instrument |
| trading_symbol | Official trading symbol |
| isin | International Securities Identification Number (when applicable) |
| description | Business description |
| is_active | Operational status |

Common enterprise attributes, audit attributes and governance attributes are defined centrally within the Enterprise Data Dictionary and are not repeated here.

---

## 17.9 Relationships

| Related Entity | Relationship | Cardinality |
|----------------|--------------|-------------|
| Company | Issued by | Many-to-One |
| Instrument Listing | Listed through | One-to-Many |
| Daily Market Data | Has | One-to-Many |
| Corporate Action | Subject of | One-to-Many |
| External Identifier | Referenced by | One-to-Many |

Detailed relationship semantics are defined in the Enterprise Relationship Catalog, Enterprise Relationship Matrix and Cardinality Matrix.

---

## 17.10 Business Rules

- Every Instrument shall possess a unique Instrument Code.
- Every Instrument shall belong to exactly one Company.
- An Instrument may have one or more Instrument Listings.
- Historical market information shall reference an Instrument through its Instrument Listing.
- Corporate Actions shall reference exactly one Instrument.
- Business identity shall remain stable throughout the Instrument lifecycle.
- Business identifiers shall remain immutable.
- Instrument master data shall be centrally governed.

---

## 17.11 Related Artifacts

| Artifact | Purpose |
|----------|---------|
| Canonical Domain Model | Domain ownership |
| Canonical Entity Definitions | Canonical entity definition |
| Aggregate Catalog | Aggregate ownership |
| Enterprise Relationship Catalog | Business relationships |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Cardinality rules |
| Business Constraint Matrix | Business constraints |
| Core Domain Logical Model | Logical domain model |
| Market Domain Logical Model | Market relationships |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |
| ADR-015 | Market Classification Model |
| ADR-026 | Normalize Reference Data Model |

---

# 18. Traceability

The Enterprise Data Dictionary is fully traceable to the canonical Enterprise Architecture baseline of the Phoenix Platform.

Each entity, attribute, business identifier and business rule defined within this document originates from an approved architectural artifact. This traceability ensures consistency across the conceptual, logical and physical architecture while maintaining a single authoritative source for enterprise metadata.

The Enterprise Data Dictionary shall remain synchronized with all approved architecture artifacts throughout the lifecycle of the platform.

---

## 18.1 Traceability Principles

The following principles govern traceability within this document.

- Every business entity shall have one authoritative architectural source.
- Every attribute shall originate from an approved enterprise standard.
- Every business relationship shall be traceable to the Enterprise Relationship Model.
- Every business rule shall originate from the Canonical Business Rules.
- Every identifier shall conform to the Enterprise Identifier Strategy.
- No metadata shall be duplicated across architecture artifacts.

---

## 18.2 Architecture Traceability Matrix

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| Platform Architecture Vision | Enterprise architecture vision |
| Architectural Principles | Architecture governance |
| Canonical Domain Model | Domain ownership |
| Conceptual Database Model | Business concepts |
| Canonical Entity Definitions | Canonical business entities |
| Aggregate Catalog | Aggregate ownership |
| Aggregate Attribute Matrix | Attribute allocation |
| Attribute Catalog | Approved enterprise attributes |
| Attribute Dictionary | Enterprise attribute definitions |
| Enterprise Relationship Catalog | Business relationship definitions |
| Enterprise Relationship Matrix | Relationship validation |
| Cardinality Matrix | Relationship cardinality |
| Business Constraint Matrix | Business constraints |
| Logical Database Model | Logical data realization |
| Physical Database Model | Physical data realization |
| Canonical Business Rules | Business semantics |
| Enterprise Naming Standard | Naming compliance |
| Enterprise Identifier Strategy | Identifier governance |

---

## 18.3 Downstream Architecture Artifacts

The Enterprise Data Dictionary serves as a primary reference for the following architecture and implementation artifacts.

| Consumer Artifact | Usage |
|-------------------|-------|
| Logical Database Model | Entity metadata |
| Physical Database Model | Physical column definitions |
| Database DDL | Table and column implementation |
| Enterprise ERD | Entity validation |
| API Specifications | Business data definitions |
| Integration Specifications | Canonical data mapping |
| Data Migration Specifications | Data transformation rules |
| Data Validation Rules | Business validation |
| Test Specifications | Metadata verification |

---

## 18.4 Governance

Changes to the Enterprise Data Dictionary shall be governed through the Enterprise Architecture governance process.

Any modification affecting:

- business definitions;
- entity ownership;
- attribute definitions;
- business identifiers;
- business relationships;
- business rules; or
- enterprise metadata

shall require review for consistency with the approved Enterprise Architecture baseline before implementation.

---

# 19. Related Artifacts

The Enterprise Data Dictionary is an integral component of the Phoenix Platform Enterprise Architecture repository.

It shall be used together with the following approved architecture artifacts to ensure consistency across business architecture, data architecture and implementation.

---

## 19.1 Enterprise Architecture

| Artifact | Purpose |
|----------|---------|
| Platform Architecture Vision | Defines the overall enterprise architecture vision. |
| Architectural Principles | Defines enterprise architecture principles. |
| Quality Attributes | Defines architectural quality requirements. |
| Canonical Business Rules | Defines enterprise business semantics. |
| Canonical Domain Model | Defines enterprise domain boundaries. |
| Canonical Entity Definitions | Defines canonical enterprise entities. |

---

## 19.2 Data Architecture

| Artifact | Purpose |
|----------|---------|
| Conceptual Database Model | Defines enterprise business concepts. |
| Logical Database Model | Defines logical entity structures. |
| Physical Database Model | Defines physical database implementation. |
| Canonical Enterprise ERD | Defines the canonical enterprise relationship model. |
| Aggregate Catalog | Defines aggregate ownership. |
| Aggregate Attribute Matrix | Defines attribute allocation. |
| Attribute Catalog | Defines approved enterprise attributes. |
| Attribute Dictionary | Defines enterprise attribute metadata. |
| Enterprise Relationship Catalog | Defines business relationships. |
| Enterprise Relationship Matrix | Defines relationship mappings. |
| Cardinality Matrix | Defines relationship cardinalities. |
| Aggregate Dependency Matrix | Defines aggregate dependencies. |
| Domain Dependency Matrix | Defines domain dependencies. |
| Business Constraint Matrix | Defines enterprise business constraints. |

---

## 19.3 Enterprise Standards

| Artifact | Purpose |
|----------|---------|
| Enterprise Naming Standard | Naming conventions for entities and attributes. |
| Enterprise Identifier Strategy | Defines identifier governance. |
| Enterprise Metadata Standard | Defines metadata standards. |
| Enterprise Audit Standard | Defines enterprise audit requirements. |

---

## 19.4 Architecture Decision Records

The Enterprise Data Dictionary shall conform to all approved Architecture Decision Records (ADRs).

Particular alignment is required with ADRs governing:

- Enterprise Architecture
- Domain-Driven Design
- Reference Data Management
- Market Classification
- Identifier Strategy
- Database Architecture
- Naming Standards

---

## 19.5 Repository Position

Within the Phoenix Enterprise Repository, the Enterprise Data Dictionary acts as the authoritative metadata catalog for all enterprise business entities.

It bridges conceptual architecture, logical architecture and physical implementation while maintaining a single source of truth for enterprise data definitions.

---

## 19.6 Usage Guidance

The Enterprise Data Dictionary shall be consulted before creating or modifying:

- Business entities
- Business attributes
- Database tables
- Database columns
- API contracts
- Integration mappings
- Validation rules
- Reporting structures
- Data migration specifications

No implementation artifact shall introduce business metadata that is inconsistent with this document.

---

# 20. Architectural Governance

The Enterprise Data Dictionary is a controlled Enterprise Architecture artifact and forms part of the official Phoenix Platform Enterprise Architecture Baseline.

It establishes the authoritative business metadata for enterprise entities and shall remain consistent with all approved architecture artifacts throughout the lifecycle of the platform.

---

## 20.1 Governance Principles

The Enterprise Data Dictionary shall be governed according to the following principles.

- Business definitions shall have a single authoritative source.
- Enterprise metadata shall remain implementation independent.
- All modifications shall preserve architectural consistency.
- Metadata duplication across architectural artifacts is prohibited.
- Business terminology shall remain standardized throughout the repository.
- Every change shall be fully traceable.
- Governance shall be applied before implementation.

---

## 20.2 Change Management

Changes to this document shall be initiated only when one or more of the following conditions occur:

- Introduction of a new business entity.
- Introduction of a new business attribute.
- Modification of an approved business definition.
- Changes to enterprise business terminology.
- Changes to identifier policies.
- Approved changes to enterprise relationships.
- Approved Architecture Decision Records (ADRs).
- Enterprise Architecture Baseline updates.

All proposed changes shall undergo formal architectural review before approval.

---

## 20.3 Compliance Requirements

The Enterprise Data Dictionary shall remain consistent with:

- Platform Architecture Vision
- Architectural Principles
- Canonical Domain Model
- Conceptual Database Model
- Logical Database Model
- Physical Database Model
- Canonical Business Rules
- Canonical Entity Definitions
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Cardinality Matrix
- Business Constraint Matrix
- Enterprise Naming Standard
- Enterprise Identifier Strategy

Any inconsistency identified between this document and an approved architecture artifact shall be resolved through the Enterprise Architecture governance process.

---

## 20.4 Architecture Review

The Enterprise Architecture Board shall review this document whenever changes affect:

- Enterprise business concepts
- Business entity definitions
- Attribute definitions
- Business identifiers
- Domain ownership
- Aggregate ownership
- Business relationships
- Enterprise standards
- Architecture governance

Architectural review shall verify consistency, completeness, traceability and compliance with the approved enterprise architecture baseline.

---

## 20.5 Approval Authority

Approval authority for this document resides with the Enterprise Architecture Board.

Approval confirms that:

- Business metadata is complete.
- Business definitions are canonical.
- Entity ownership is validated.
- Traceability has been verified.
- Enterprise standards have been satisfied.
- Repository consistency has been preserved.

---

## 20.6 Baseline Management

The Enterprise Data Dictionary is maintained as part of the official Enterprise Architecture Baseline.

Any approved modification shall result in:

- Document version update.
- Revision history update.
- Traceability validation.
- Repository synchronization.
- Baseline review when required.

The approved baseline shall remain the authoritative source for all enterprise business metadata.

---

# 21. Approval

The Enterprise Data Dictionary is approved as the authoritative enterprise metadata specification for the Phoenix Platform.

This document establishes the canonical definitions of enterprise business entities, identifiers, metadata standards and business terminology that shall be used consistently throughout all architecture, design, implementation and operational artifacts.

All subsequent logical and physical data models shall conform to the definitions contained within this document.

---

## 21.1 Approval Scope

Approval of this document confirms that:

- Enterprise business entities have been formally identified.
- Canonical business definitions have been validated.
- Enterprise metadata standards have been applied.
- Business identifiers conform to the Enterprise Identifier Strategy.
- Entity relationships are consistent with the approved Enterprise Architecture.
- Traceability to authoritative architecture artifacts has been verified.
- Repository-wide consistency has been achieved.

---

## 21.2 Architectural Status

| Property | Value |
|----------|-------|
| Approval Status | **APPROVED** |
| Architecture Baseline | EA-BL-2026-01 |
| Governance Authority | Enterprise Architecture Board |
| Repository Status | Canonical |
| Implementation Status | Approved for Logical and Physical Database Design |

---

## 21.3 Approval Statement

The Enterprise Architecture Board approves this Enterprise Data Dictionary as the official enterprise metadata specification for the Phoenix Platform.

This document shall serve as the single authoritative source for enterprise business metadata and shall govern the definition of all business entities, attributes, identifiers and relationships across the Phoenix Platform.

Future modifications shall follow the approved Enterprise Architecture governance process and maintain full consistency with the established Enterprise Architecture Baseline.

---

# 22. Revision History

The revision history records all approved modifications to the Enterprise Data Dictionary throughout its lifecycle.

Each revision represents an approved Enterprise Architecture baseline and provides complete traceability for future maintenance, governance and auditing activities.

Only approved revisions shall be recorded in this section.

---

| Version | Date | Description | Approved By |
|----------|------------|--------------------------------------------------------------|------------------------------|
| 1.0 | 2026-07-12 | Initial Enterprise Data Dictionary. | Enterprise Architecture |
| 2026.1 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline. Standardized document metadata, governance model, entity catalog structure, traceability framework, reference entity specifications and enterprise architectural compliance. | Enterprise Architecture Board |

---

## Revision Management Principles

The following principles govern document revisions.

- Every revision shall be uniquely versioned.
- Every revision shall include the approval date.
- Every revision shall describe the architectural changes introduced.
- Every revision shall be approved through the Enterprise Architecture governance process.
- Historical revisions shall remain immutable.
- Repository baselines shall reference approved document versions only.

---

## Versioning Policy

The Enterprise Data Dictionary follows the Phoenix Platform documentation versioning standard.

| Version Type | Purpose |
|--------------|---------|
| Major | Significant architectural or structural changes affecting the Enterprise Architecture Baseline. |
| Minor | Approved extensions, additional entities, attributes or architectural refinements that preserve backward compatibility. |
| Patch | Editorial corrections, clarifications or formatting improvements with no architectural impact. |

---

## Change Control

Any future modification to this document shall require:

- Enterprise Architecture Review
- Business Impact Assessment
- Repository Consistency Validation
- Traceability Verification
- Enterprise Architecture Board Approval
- Baseline Update (when applicable)

Only after successful completion of the above governance activities may a new revision be added to this history.

---