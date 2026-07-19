# Logical Database Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-000 |
| Document | LogicalDatabaseModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | ConceptualDatabaseModel, CanonicalDomainModel, CanonicalEntityDefinitions, AggregateCatalog, EnterpriseRelationshipMatrix, EnterpriseDataDictionary |
| Consumed By | PhysicalDatabaseModel, PostgreSQL DDL, Database Migration Scripts |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

The Logical Database Model defines the canonical logical structure of the Phoenix Platform database.

It transforms the enterprise business concepts defined by the Conceptual Database Model into normalized logical data structures while preserving business semantics and remaining independent of any specific database technology.

This document serves as the authoritative logical specification for database design throughout the Phoenix Platform.

Specifically, this document:

- defines the logical organization of enterprise data;
- identifies the logical schemas of the platform;
- specifies logical business objects and their relationships;
- establishes logical identifiers and business identifiers;
- defines logical integrity rules;
- provides the foundation for the Physical Database Model.

The Logical Database Model is implementation independent and shall not include database engine-specific details.

---

# 2. Scope

This document defines the logical organization of enterprise data across all business domains of the Phoenix Platform.

## Included

- Enterprise logical schemas
- Logical business objects
- Logical relationships
- Primary identifiers
- Business identifiers
- Alternate identifiers
- Foreign key relationships
- Cross-schema dependencies
- Logical integrity rules
- Normalization principles

## Excluded

The following implementation-specific topics are intentionally excluded from this document.

- Physical database structures
- Database-specific data types
- Storage parameters
- Index definitions
- Partitioning strategies
- Performance optimization
- Database engine configuration
- SQL implementation details

These topics are defined within the Physical Database Model.

---

# 3. Objectives

The objectives of the Logical Database Model are:

- provide a technology-independent logical representation of enterprise data;
- establish a consistent logical structure across all business domains;
- standardize logical identifiers and business identifiers;
- eliminate ambiguity in logical entity definitions;
- support enterprise-wide data consistency;
- enable logical validation prior to physical implementation;
- provide traceability between conceptual and physical models;
- establish the authoritative logical baseline for database development.

---

# 4. Design Principles

The Logical Database Model is governed by the following Enterprise Architecture principles.

## Business-Oriented Design

Logical business objects represent enterprise business concepts rather than implementation artifacts.

---

## Technology Independence

The logical model shall remain independent of PostgreSQL or any other database management system.

---

## Enterprise Consistency

Logical definitions shall remain consistent across all Enterprise Architecture artifacts.

---

## Third Normal Form

Logical business objects shall satisfy Third Normal Form (3NF) unless an approved Architecture Decision Record explicitly states otherwise.

---

## Stable Enterprise Identity

Every business object shall possess an immutable enterprise identifier.

Business identifiers shall remain stable throughout the business object's lifecycle.

---

## Separation of Concerns

Business data, operational data, integration data and configuration data shall remain logically separated according to their enterprise responsibilities.

---

## Canonical Representation

Every logical business object shall have a single canonical definition within the Enterprise Architecture repository.

No duplicate logical representations are permitted.

---

# Logical Database Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-000 |
| Document | LogicalDatabaseModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | ConceptualDatabaseModel, CanonicalDomainModel, CanonicalEntityDefinitions, AggregateCatalog, EnterpriseRelationshipMatrix, EnterpriseDataDictionary |
| Consumed By | PhysicalDatabaseModel, PostgreSQL DDL, Database Migration Scripts |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

The Logical Database Model defines the canonical logical structure of the Phoenix Platform database.

It transforms the enterprise business concepts defined by the Conceptual Database Model into normalized logical data structures while preserving business semantics and remaining independent of any specific database technology.

This document serves as the authoritative logical specification for database design throughout the Phoenix Platform.

Specifically, this document:

- defines the logical organization of enterprise data;
- identifies the logical schemas of the platform;
- specifies logical business objects and their relationships;
- establishes logical identifiers and business identifiers;
- defines logical integrity rules;
- provides the foundation for the Physical Database Model.

The Logical Database Model is implementation independent and shall not include database engine-specific details.

---

# 2. Scope

This document defines the logical organization of enterprise data across all business domains of the Phoenix Platform.

## Included

- Enterprise logical schemas
- Logical business objects
- Logical relationships
- Primary identifiers
- Business identifiers
- Alternate identifiers
- Foreign key relationships
- Cross-schema dependencies
- Logical integrity rules
- Normalization principles

## Excluded

The following implementation-specific topics are intentionally excluded from this document.

- Physical database structures
- Database-specific data types
- Storage parameters
- Index definitions
- Partitioning strategies
- Performance optimization
- Database engine configuration
- SQL implementation details

These topics are defined within the Physical Database Model.

---

# 3. Objectives

The objectives of the Logical Database Model are:

- provide a technology-independent logical representation of enterprise data;
- establish a consistent logical structure across all business domains;
- standardize logical identifiers and business identifiers;
- eliminate ambiguity in logical entity definitions;
- support enterprise-wide data consistency;
- enable logical validation prior to physical implementation;
- provide traceability between conceptual and physical models;
- establish the authoritative logical baseline for database development.

---

# 4. Design Principles

The Logical Database Model is governed by the following Enterprise Architecture principles.

## Business-Oriented Design

Logical business objects represent enterprise business concepts rather than implementation artifacts.

---

## Technology Independence

The logical model shall remain independent of PostgreSQL or any other database management system.

---

## Enterprise Consistency

Logical definitions shall remain consistent across all Enterprise Architecture artifacts.

---

## Third Normal Form

Logical business objects shall satisfy Third Normal Form (3NF) unless an approved Architecture Decision Record explicitly states otherwise.

---

## Stable Enterprise Identity

Every business object shall possess an immutable enterprise identifier.

Business identifiers shall remain stable throughout the business object's lifecycle.

---

## Separation of Concerns

Business data, operational data, integration data and configuration data shall remain logically separated according to their enterprise responsibilities.

---

## Canonical Representation

Every logical business object shall have a single canonical definition within the Enterprise Architecture repository.

No duplicate logical representations are permitted.

---

# 9. Reference Schema

The **Reference Schema** contains the canonical master data of the Phoenix Platform.

Business objects within this schema represent relatively stable enterprise concepts that provide the foundation for all operational, analytical and integration data.

The Reference Schema is the highest-level logical schema in the enterprise data architecture.

---

## 9.1 Reference Business Objects

| Business Object | Primary Responsibility | Business Identifier |
|-----------------|------------------------|---------------------|
| Exchange | Defines securities exchanges | Exchange Code |
| Market | Defines logical trading markets | Market Code |
| Board | Defines trading boards | Board Code |
| Sector | Defines economic sectors | Sector Code |
| Industry | Defines industry classifications | Industry Code |
| Company | Defines legal business entities | Company Code |
| Instrument | Defines tradable financial instruments | Instrument Code |
| Symbol | Defines trading symbols | Symbol Code |

---

# 10. Exchange

## Business Purpose

Represents an organized securities exchange operating under a common regulatory framework.

## Business Identifier

**Exchange Code**

## Logical Relationships

- One Exchange contains one or more Markets.
- An Exchange is the root business object of the market classification hierarchy.

---

# 11. Market

## Business Purpose

Represents a logical trading market operating within an Exchange.

## Business Identifier

**Market Code**

## Logical Relationships

- Every Market belongs to one Exchange.
- One Market contains one or more Boards.

---

# 12. Board

## Business Purpose

Represents a trading board within a Market.

## Business Identifier

**Board Code**

## Logical Relationships

- Every Board belongs to one Market.
- One Board contains one or more Instrument Listings.

---

# 13. Sector

## Business Purpose

Represents the highest level of economic classification used to categorize companies.

## Business Identifier

**Sector Code**

## Logical Relationships

- One Sector contains one or more Industries.

---

# 14. Industry

## Business Purpose

Represents a detailed economic classification within a Sector.

Industries group companies that operate in similar business activities and provide a more granular level of business classification.

## Business Identifier

**Industry Code**

## Logical Relationships

- Every Industry belongs to exactly one Sector.
- One Industry contains one or more Companies.

---

# 15. Company

## Business Purpose

Represents a legally registered business entity participating in one or more financial markets.

A Company serves as the issuer of one or more tradable financial instruments.

## Business Identifier

**Company Code**

## Logical Relationships

- Every Company belongs to exactly one Industry.
- One Company may issue one or more Instruments.

---

# 16. Instrument

## Business Purpose

Represents a tradable financial asset issued by a Company.

Examples include common shares, preferred shares, bonds, exchange-traded funds and other financial securities.

## Business Identifier

**Instrument Code**

## Logical Relationships

- Every Instrument belongs to exactly one Company.
- One Instrument may have one or more Symbols.
- One Instrument may have one or more Instrument Listings.

---

# 17. Symbol

## Business Purpose

Represents the trading symbol used to identify an Instrument within a specific Market or Board.

The Symbol provides the market-facing identifier used during trading activities while remaining logically associated with its underlying Instrument.

## Business Identifier

**Symbol Code**

## Logical Relationships

- Every Symbol belongs to exactly one Instrument.
- A Symbol may participate in one or more Instrument Listings.

---

# 18. Reference Schema Rules

The following logical rules govern the Reference Schema.

- Every Exchange shall contain one or more Markets.
- Every Market shall belong to exactly one Exchange.
- Every Board shall belong to exactly one Market.
- Every Sector shall contain one or more Industries.
- Every Industry shall belong to exactly one Sector.
- Every Company shall belong to exactly one Industry.
- Every Instrument shall belong to exactly one Company.
- Every Symbol shall belong to exactly one Instrument.
- Business identifiers shall be unique within their corresponding business objects.
- Enterprise identifiers shall remain immutable throughout the lifecycle of each business object.
- Reference business objects shall be centrally managed and reused throughout the enterprise.
- Reference business objects shall not depend on operational business objects.

---

# 19. Market Schema

The **Market Schema** contains the operational business objects responsible for recording trading activities and market events.

Business objects within this schema are transactional in nature and continuously evolve as new market information becomes available.

The Market Schema depends on the Reference Schema for all business classifications and enterprise identities.

---

## 19.1 Market Business Objects

| Business Object | Primary Responsibility | Business Identifier |
|-----------------|------------------------|---------------------|
| Trading Calendar | Defines official trading sessions | Trading Date |
| Instrument Listing | Represents the listing of an Instrument on a Board | Listing Code |
| Daily Market Data | Stores end-of-day trading information | Listing + Trading Date |
| Corporate Action | Records business events affecting an Instrument | Corporate Action Number |

---

# 20. Trading Calendar

## Business Purpose

Defines the official trading sessions recognized by the Phoenix Platform.

The Trading Calendar determines whether a specific date is an official trading day and provides the temporal foundation for all market activities.

## Business Identifier

**Trading Date**

## Logical Relationships

- One Trading Calendar may contain many Daily Market Data records.
- Every Daily Market Data record shall reference exactly one Trading Calendar.

---

# 21. Instrument Listing

## Business Purpose

Represents the admission of an Instrument to trading on a specific Board.

The Instrument Listing establishes the logical relationship between an Instrument and the Board on which it is traded.

## Business Identifier

**Listing Code**

## Logical Relationships

- Every Instrument Listing belongs to exactly one Instrument.
- Every Instrument Listing belongs to exactly one Board.
- One Instrument Listing may contain many Daily Market Data records.

---

# 22. Daily Market Data

## Business Purpose

Represents the official end-of-day trading information for a listed Instrument during a specific trading session.

Typical business information includes opening price, closing price, highest price, lowest price, traded volume, traded value and related market statistics.

## Business Identifier

**Listing + Trading Date**

## Logical Relationships

- Every Daily Market Data record belongs to exactly one Instrument Listing.
- Every Daily Market Data record belongs to exactly one Trading Calendar.

---

# 23. Corporate Action

## Business Purpose

Represents a business event that affects an Instrument or its issuing Company.

Examples include:

- Cash Dividend
- Stock Dividend
- Capital Increase
- Stock Split
- Reverse Split
- Rights Offering
- Symbol Change

## Business Identifier

**Corporate Action Number**

## Logical Relationships

- Every Corporate Action belongs to exactly one Instrument.
- One Instrument may have zero or more Corporate Actions.

---

# 24. Market Schema Rules

The following logical rules govern the Market Schema.

- Every Instrument Listing shall reference exactly one Instrument.
- Every Instrument Listing shall reference exactly one Board.
- Every Daily Market Data record shall reference exactly one Instrument Listing.
- Every Daily Market Data record shall reference exactly one Trading Calendar.
- Every Corporate Action shall reference exactly one Instrument.
- Historical market information shall remain immutable after publication unless corrected through approved business processes.
- Market business objects shall reference enterprise identifiers defined within the Reference Schema.
- Business identifiers shall remain unique within their corresponding business objects.

---

# 25. Integration Schema

The **Integration Schema** provides the enterprise integration layer of the Phoenix Platform.

Its purpose is to isolate external information providers from the canonical enterprise business model while preserving stable enterprise identities.

Business objects within this schema never own business data. Instead, they maintain mappings between enterprise business objects and provider-specific identifiers.

---

## 25.1 Integration Business Objects

| Business Object | Primary Responsibility | Business Identifier |
|-----------------|------------------------|---------------------|
| Data Provider | Defines external information providers | Provider Code |
| External Identifier | Maps enterprise business objects to provider-specific identifiers | Provider Code + External Identifier |

---

# 26. Data Provider

## Business Purpose

Represents an external organization that supplies business, reference or market information to the Phoenix Platform.

Examples include stock exchanges, market data vendors, financial information providers and other authorized external data sources.

## Business Identifier

**Provider Code**

## Logical Relationships

- One Data Provider may define many External Identifiers.
- Every External Identifier belongs to exactly one Data Provider.

---

# 27. External Identifier

## Business Purpose

Represents the association between a canonical enterprise business object and an identifier assigned by an external information provider.

External Identifiers preserve interoperability while ensuring that enterprise business identities remain independent of external systems.

## Business Identifier

**Provider Code + External Identifier**

## Logical Relationships

- Every External Identifier belongs to exactly one Data Provider.
- Every External Identifier references exactly one Aggregate Root.
- One enterprise business object may have multiple External Identifiers supplied by different providers.

---

# 28. Integration Schema Rules

The following logical rules govern the Integration Schema.

- Every External Identifier shall reference exactly one Data Provider.
- Every External Identifier shall reference exactly one enterprise Aggregate Root.
- Enterprise identifiers shall remain the authoritative business identifiers.
- External identifiers shall never replace enterprise identifiers.
- Multiple providers may define different identifiers for the same business object.
- Historical provider mappings shall remain traceable.
- Provider-specific identifiers shall never be stored within Reference or Market business objects.
- The Integration Schema shall remain independent of provider-specific technologies and communication protocols.

---

# 29. Cross-Schema Relationships

Enterprise business objects interact through well-defined logical relationships that preserve business ownership, Aggregate boundaries and domain responsibilities.

The following cross-schema relationships are defined within the Phoenix Platform.

| Source Schema | Target Schema | Relationship Purpose |
|---------------|---------------|----------------------|
| Reference | Market | Provides enterprise master data for market operations |
| Reference | Integration | Provides enterprise business identities for external mapping |
| Market | Reference | References canonical master business objects |
| Integration | Reference | Maps provider-specific identifiers to enterprise business objects |
| Integration | Market | Supports external identification of operational market objects |
| Reporting | Reference | Consumes enterprise master data for reporting |
| Reporting | Market | Consumes operational market information |
| Audit | All Schemas | Records enterprise business activities |
| Configuration | All Schemas | Provides configurable business behavior |

Cross-schema relationships shall always preserve enterprise business ownership.

---

# 30. Cross-Schema Dependency Rules

The logical dependency hierarchy of the Phoenix Platform is illustrated below.

```text
Reference
    │
    ├────────────► Market
    │
    ├────────────► Integration
    │
    ├────────────► Reporting
    │
    └────────────► Audit

Market
    │
    ├────────────► Reporting
    │
    └────────────► Audit

Integration
    │
    ├────────────► Reporting
    │
    └────────────► Audit

Configuration
    │
    └────────────► All Schemas
```

The following dependency principles shall always apply.

- The Reference Schema is the enterprise foundation.
- Market business objects depend upon Reference business objects.
- Integration business objects depend upon enterprise Aggregate Roots.
- Reporting consumes information without owning business objects.
- Audit records business activity without modifying business ownership.
- Configuration influences business behavior without owning operational data.

---

# 31. Logical Integrity Rules

The following logical integrity rules govern the enterprise logical data model.

- Every business object shall possess a unique enterprise identifier.
- Every business identifier shall be unique within its business object.
- Every logical relationship shall have an approved business meaning.
- Aggregate boundaries shall always be respected.
- Cross-domain references shall terminate only at Aggregate Roots.
- Circular ownership relationships are prohibited.
- Referential integrity shall be preserved across all logical schemas.
- Business semantics shall remain independent of implementation technologies.

---

# 32. Normalization Principles

The Phoenix Platform Logical Database Model complies with the principles of Third Normal Form (3NF).

The objectives of normalization are:

- eliminate duplicate business information;
- eliminate update anomalies;
- eliminate insertion anomalies;
- eliminate deletion anomalies;
- establish clear business ownership;
- minimize data redundancy;
- maximize logical consistency.

No denormalization shall be introduced at the logical architecture level.

Performance optimization, indexing strategies, storage optimization and implementation-specific decisions are exclusively addressed by the **Physical Database Model**.

---

# 33. Mapping to the Physical Database Model

The Logical Database Model serves as the authoritative input for the Physical Database Model.

The Physical Database Model extends this logical specification by defining implementation-specific details while preserving all approved business semantics.

The Physical Database Model shall define:

- physical tables;
- database schemas;
- physical columns;
- database-specific data types;
- primary keys;
- foreign keys;
- unique constraints;
- check constraints;
- indexes;
- partitioning strategies;
- storage optimization;
- performance optimization.

No additional business concepts shall be introduced during the transition from the Logical Database Model to the Physical Database Model.

---

# 34. Enterprise Naming Standards

The following enterprise naming standards apply to every logical business object.

## Business Objects

Business object names shall:

- be singular;
- use business terminology;
- remain technology independent;
- remain stable over time.

---

## Enterprise Identifiers

Every business object shall possess:

- an immutable enterprise identifier;
- a stable business identifier;
- an optional external identifier where applicable.

---

## Relationships

Logical relationship names shall:

- describe business meaning;
- remain implementation independent;
- remain consistent across all Enterprise Architecture artifacts.

---

## Schemas

Logical schema names shall:

- represent business capabilities;
- remain stable;
- avoid technology-specific terminology.

---

# 35. Business Identifier Strategy

The Phoenix Platform distinguishes between three categories of identifiers.

| Identifier Type | Purpose |
|-----------------|---------|
| Enterprise Identifier | Internal immutable business identity |
| Business Identifier | Stable business identifier used within the enterprise |
| External Identifier | Provider-specific identifier managed by the Integration Schema |

The following principles apply.

- Enterprise identifiers shall never change.
- Business identifiers shall remain stable throughout the lifecycle of the business object.
- External identifiers shall remain isolated from enterprise business objects.
- External identifiers shall be managed exclusively by the Integration Schema.
- Business identifiers shall remain unique within their corresponding business objects.

---

# 36. Logical Model Summary

The Logical Database Model establishes the canonical logical structure of enterprise data for the Phoenix Platform.

The model provides:

- a technology-independent representation of enterprise business objects;
- standardized logical schemas;
- normalized logical structures;
- enterprise-wide business identifiers;
- logical relationships;
- logical integrity rules;
- cross-schema dependency rules;
- traceability to Enterprise Architecture artifacts.

This document serves as the authoritative logical baseline for all subsequent Physical Database Design activities.

---

# 37. Traceability

The Logical Database Model is fully traceable to the authoritative Enterprise Architecture artifacts of the Phoenix Platform.

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| PlatformArchitectureVision | Enterprise architectural vision |
| ArchitecturalPrinciples | Enterprise architecture principles |
| CanonicalDomainModel | Domain ownership and business boundaries |
| ConceptualDatabaseModel | Business concepts and conceptual relationships |
| CanonicalEntityDefinitions | Enterprise business object definitions |
| AggregateCatalog | Business object ownership |
| EnterpriseRelationshipCatalog | Relationship semantics |
| EnterpriseRelationshipMatrix | Logical relationship validation |
| CardinalityMatrix | Relationship cardinality validation |
| AggregateDependencyMatrix | Aggregate dependency validation |
| DomainDependencyMatrix | Domain dependency validation |
| BusinessConstraintMatrix | Business constraint validation |
| EnterpriseDataDictionary | Canonical business terminology |
| PhysicalDatabaseModel | Physical realization of the logical model |

This traceability ensures that every logical business object, relationship and business rule remains fully aligned with the approved Enterprise Architecture baseline.

---

# 38. Related Artifacts

This document shall be used together with the following Enterprise Architecture specifications:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- CanonicalDomainModel
- ConceptualDatabaseModel
- CanonicalBusinessRules
- CanonicalEntityDefinitions
- AggregateCatalog
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CardinalityMatrix
- AggregateDependencyMatrix
- DomainDependencyMatrix
- BusinessConstraintMatrix
- EnterpriseDataDictionary
- PhysicalDatabaseModel
- CanonicalEnterpriseERD

---

# 39. Architectural Governance

The Logical Database Model is a controlled Enterprise Architecture artifact.

Any modification affecting:

- logical schemas;
- business object definitions;
- logical relationships;
- identifier strategies;
- normalization rules;
- business constraints;
- cross-schema dependencies;
- enterprise consistency; or
- architectural traceability

shall require:

- Enterprise Architecture Review;
- Business Impact Analysis;
- Architecture Board Approval; and
- Repository Baseline Update (when applicable).

All approved logical definitions contained in this document shall be considered canonical throughout the Phoenix Platform.

---

# 40. Approval

The Enterprise Architecture Board hereby approves this Logical Database Model as the official logical database specification of the Phoenix Platform.

This document establishes the canonical logical representation of enterprise data and serves as the authoritative reference for:

- Physical Database Modeling;
- Database Schema Design;
- Enterprise Data Governance;
- Database Migration Planning;
- Enterprise Data Integration; and
- Repository-wide Logical Data Consistency.

All logical definitions contained in this document shall be regarded as canonical and shall remain governed under the approved Enterprise Architecture Baseline.

Any future modification to this document shall follow the Enterprise Architecture Governance process and, where applicable, require an Architecture Decision Record (ADR), Architecture Board Approval and a new repository baseline.

**Approval Status**

**APPROVED**

---

# 41. Revision History

| Version | Date | Description |
|----------|------------|-------------|
| 1.0 | 2026-06-12 | Initial Logical Database Model. |
| 1.1 | 2026-06-29 | Architecture Freeze v1.1. Introduced Daily Market Data, promoted Instrument Listing to a business object, introduced the Integration Schema and External Identifier strategy. |
| 2026.2 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline. Reorganized the document according to the Enterprise Data Architecture documentation framework. Added enterprise metadata, objectives, logical architecture principles, schema responsibilities, business object specifications, cross-schema dependency rules, logical integrity rules, business identifier strategy, traceability, governance, approval and standardized terminology across all logical schemas. |

---

# 42. Architecture Compliance

This Logical Database Model complies with the approved Enterprise Architecture baseline of the Phoenix Platform.

The document is aligned with:

- Enterprise Architecture Principles
- Enterprise Data Architecture Standards
- Canonical Domain Model
- Canonical Business Rules
- Enterprise Data Dictionary
- Canonical Entity Definitions
- Aggregate Catalog
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Canonical Enterprise ERD
- Physical Database Model
- Repository Governance Standards

The logical structure defined in this document shall be regarded as the authoritative enterprise representation of logical business data throughout the Phoenix Platform.

---

# 43. Document Summary

The Logical Database Model establishes the canonical logical foundation of the Phoenix Platform Enterprise Data Architecture.

It provides:

- a technology-independent logical representation of enterprise business data;
- standardized logical schemas and business objects;
- enterprise-wide identifier strategies;
- normalized logical structures;
- canonical business relationships;
- logical integrity and dependency rules;
- complete architectural traceability;
- governance requirements for future evolution.

Together with the Conceptual Database Model and the Physical Database Model, this document forms the complete Enterprise Data Modeling framework of the Phoenix Platform.

This Logical Database Model shall serve as the primary reference for all logical database design activities, physical schema implementation and long-term enterprise data governance.

---

**Document Status**

**APPROVED**

**Baseline**

**Phoenix Enterprise Architecture Baseline 2026.2**