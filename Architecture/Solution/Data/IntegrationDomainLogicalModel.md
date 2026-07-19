# Integration Domain Logical Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | LDM-004 |
| Document | IntegrationDomainLogicalModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Model |
| Architecture Layer | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Domain | Integration |
| Depends On | ReferenceDomainLogicalModel, CoreDomainLogicalModel, CanonicalDomainModel, AggregateCatalog, AggregateAttributeMatrix, CanonicalBusinessRules |
| Consumed By | ConceptualDatabaseModel, LogicalDatabaseModel, PhysicalDatabaseModel |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical logical representation of the **Integration Domain** within the Phoenix Platform.

The Integration Domain provides the enterprise model for managing external data providers and the mapping between enterprise business objects and identifiers supplied by external information sources.

Its primary objective is to ensure that externally assigned identifiers remain isolated from the enterprise business model while maintaining complete traceability between internal and external representations.

Specifically, this document:

- defines the logical structure of the Integration Domain;
- identifies the business objects belonging to the domain;
- establishes relationships with other enterprise domains;
- specifies domain-level business rules and constraints;
- provides the logical foundation for subsequent physical database design.

The Integration Domain is implementation independent and serves as the authoritative logical specification for all provider integration activities.

---

# 2. Scope

This document applies exclusively to the Integration Domain.

## Included Business Objects

- Data Provider
- External Identifier

## Referenced Business Objects

- Exchange
- Market
- Board
- Sector
- Industry
- Company
- Instrument
- Instrument Listing

## Excluded Business Objects

The following business objects are defined in other domain models and are therefore outside the scope of this document.

- Trading Calendar
- Daily Market Data
- Corporate Action
- Audit objects
- Configuration objects
- Reporting objects

---

# 3. Domain Overview

The Integration Domain manages information required to connect the Phoenix Platform with external information providers.

Its responsibilities include:

- registering external data providers;
- maintaining provider metadata;
- preserving provider-specific identifiers;
- maintaining mappings between enterprise objects and external identifiers;
- supporting interoperability between multiple external data sources.

The Integration Domain does not define enterprise business concepts.

Instead, it references business objects defined by the Reference, Core and Market Domains while preserving the independence of the enterprise data model from external systems.

The logical model defined in this document remains independent of database technologies, integration mechanisms and implementation frameworks.

---

# 4. Business Objects

The Integration Domain consists of the following canonical business objects.

These business objects collectively provide the enterprise capability required to manage external information providers and maintain mappings between enterprise business objects and provider-specific identifiers.

| Business Object | Primary Responsibility | Business Identifier |
|-----------------|------------------------|---------------------|
| Data Provider | Defines and manages external information providers | Provider Code |
| External Identifier | Maps enterprise business objects to provider-specific identifiers | Provider Code + External Identifier |

The responsibilities of each business object are described in the following sections.

---

# 5. Data Provider

## Business Purpose

A **Data Provider** represents an external organization or system that supplies business, reference or market information to the Phoenix Platform.

Examples include stock exchanges, market data vendors, brokerage systems and financial information providers.

---

## Responsibilities

The Data Provider business object is responsible for:

- identifying external information providers;
- maintaining provider metadata;
- defining provider lifecycle information;
- supporting multiple provider registrations;
- serving as the source of external identifiers.

---

## Business Identifier

**Provider Code**

The Provider Code uniquely identifies a Data Provider within the Phoenix Platform.

---

## Business Rules

- Every Data Provider shall have a unique Provider Code.
- Provider Codes shall remain stable throughout their lifecycle.
- A Data Provider may define multiple External Identifiers.
- Historical provider information shall remain available after deactivation.
- Inactive providers shall not be physically deleted.

---

# 6. External Identifier

## Business Purpose

An **External Identifier** associates an enterprise business object with the identifier assigned by a specific external Data Provider.

It enables interoperability with external systems while preserving the enterprise's own business identifiers.

---

## Responsibilities

The External Identifier business object is responsible for:

- storing provider-specific identifiers;
- maintaining mappings to enterprise business objects;
- supporting multiple external providers;
- preserving historical identifier mappings;
- enabling future provider replacement without affecting enterprise identities.

---

## Business Identifier

**Provider Code + External Identifier**

The combination of the Provider Code and the External Identifier uniquely identifies an external mapping.

---

## Business Rules

- Every External Identifier shall belong to exactly one Data Provider.
- Every External Identifier shall reference exactly one enterprise business object.
- A business object may have multiple External Identifiers from different providers.
- Enterprise identifiers shall remain the authoritative identifiers.
- External identifiers shall never replace enterprise business identifiers.
- Historical mappings shall remain available for audit and traceability.

---

# 7. Domain Relationships

The Integration Domain references business objects defined in other enterprise domains.

| Business Object | Related Business Object | Relationship |
|-----------------|-------------------------|--------------|
| Data Provider | External Identifier | One-to-Many |
| Exchange | External Identifier | One-to-Many |
| Market | External Identifier | One-to-Many |
| Board | External Identifier | One-to-Many |
| Sector | External Identifier | One-to-Many |
| Industry | External Identifier | One-to-Many |
| Company | External Identifier | One-to-Many |
| Instrument | External Identifier | One-to-Many |
| Instrument Listing | External Identifier | One-to-Many |

These relationships enable provider-specific mappings while preserving the independence of the enterprise business model.

---

# 8. Domain Rules

The Integration Domain operates according to the following business rules.

- Every External Identifier shall reference one Data Provider.
- Every External Identifier shall reference one enterprise business object.
- Enterprise business objects may be associated with multiple external providers.
- Provider-specific identifiers shall remain independent of enterprise identifiers.
- Business identity shall always be determined by enterprise identifiers.
- Provider mappings shall remain historically traceable.
- External providers shall not define or modify enterprise business objects.

---

# 9. Domain Constraints

The following logical constraints govern the Integration Domain.

- Data Provider codes shall be unique.
- External Identifier mappings shall be unique within a Data Provider.
- Every External Identifier shall reference an existing enterprise business object.
- Duplicate mappings for the same provider and identifier shall not exist.
- Enterprise business identifiers shall remain immutable.
- The Integration Domain shall not own business objects defined in other domains.
- All logical definitions shall remain implementation independent.

---

# 10. Traceability

The Integration Domain Logical Model is fully traceable to the authoritative Enterprise Architecture artifacts of the Phoenix Platform.

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| CanonicalDomainModel | Domain ownership and business boundaries |
| ReferenceDomainLogicalModel | Reference business objects |
| CoreDomainLogicalModel | Core business objects |
| MarketDomainLogicalModel | Market business objects |
| AggregateCatalog | Business object ownership |
| AggregateAttributeMatrix | Logical attribute allocation |
| AttributeCatalog | Enterprise attribute definitions |
| EnterpriseDataDictionary | Canonical business terminology |
| CanonicalBusinessRules | Business rules and constraints |
| ADR-002 | External Data Source Abstraction |
| ADR-017 | External Business Identifier Strategy |
| ADR-021 | Integration Architecture Principles |

This traceability ensures that the Integration Domain remains fully aligned with the approved Enterprise Architecture baseline.

---

# 11. Transition to Physical Design

This logical model provides the foundation for the implementation of the Integration Domain within the physical database architecture.

The model serves as the basis for:

- Integration Schema Design;
- Data Provider tables;
- External Identifier tables;
- Foreign Key definitions;
- Referential Integrity rules;
- Unique Constraints;
- External identifier mapping strategies;
- Enterprise integration services.

Implementation-specific decisions, database technologies and performance optimizations are intentionally excluded from this document.

---

# 12. Related Artifacts

This document shall be used together with the following Enterprise Architecture specifications:

- ReferenceDomainLogicalModel
- CoreDomainLogicalModel
- MarketDomainLogicalModel
- CanonicalDomainModel
- AggregateCatalog
- AggregateAttributeMatrix
- AttributeCatalog
- EnterpriseDataDictionary
- LogicalDatabaseModel
- PhysicalDatabaseModel
- CanonicalBusinessRules
- ADR-002 — Data Source Abstraction
- ADR-017 — External Business Identifier Strategy
- ADR-021 — Integration Architecture Principles

---

# 13. Architectural Governance

The Integration Domain Logical Model is a controlled Enterprise Architecture artifact.

Any modification affecting:

- domain responsibilities;
- business object definitions;
- domain relationships;
- external identifier strategy;
- provider integration rules;
- business constraints;
- enterprise traceability; or
- architectural consistency

shall require:

- Enterprise Architecture Review;
- Business Impact Analysis;
- Architecture Board Approval; and
- Repository Baseline Update (when applicable).

All approved definitions contained in this document shall be considered canonical throughout the Phoenix Platform.

---

# 14. Approval

The Enterprise Architecture Board approves this Integration Domain Logical Model as the official logical specification for the Integration Domain of the Phoenix Platform.

This document establishes the canonical logical representation of external data providers and enterprise identifier mappings and serves as the authoritative foundation for Logical Database Modeling and Physical Database Design.

**Approval Status**

**APPROVED**

---

# 15. Revision History

| Version | Date | Description |
|----------|------------|-------------|
| 2026.1 | 2026-07-09 | Initial canonical Integration Domain Logical Model. |
| 2026.2 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline. Reorganized document structure, replaced Aggregate-centric terminology with Business Object terminology where appropriate, expanded traceability, governance, related artifacts and physical design guidance, and standardized the document with the Enterprise Data Architecture documentation framework. |
