# Canonical Entity Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ENT-001 |
| Document | CanonicalEntityDefinitions |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Information Architecture |
| Owner | Enterprise Architecture |
| Repository Path | Architecture/Data/LogicalModel/CanonicalEntityDefinitions.md |
| Depends On | CanonicalDomainModel, AggregateCatalog, AggregateDefinitions, BusinessGlossary, CanonicalBusinessRules |
| Consumed By | LogicalDatabaseModel, CanonicalEnterpriseERD, EnterpriseRelationshipCatalog, EntityDictionary |
| Approval Authority | Enterprise Architecture Board |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical set of enterprise entities within the Phoenix Platform.

It establishes the authoritative business identity, ownership, architectural classification, and lifecycle responsibility of every canonical entity participating in the Enterprise Information Model.

This specification serves as the single architectural reference for entity ownership across all business domains and provides the foundation for logical data modeling, relationship analysis, aggregate validation, and physical database design.

Detailed business semantics, attributes, and implementation details are intentionally maintained in their respective authoritative artifacts.

---

# 2. Scope

This specification defines:

- Canonical enterprise entities
- Domain ownership
- Aggregate ownership
- Aggregate Root identification
- Entity classifications
- Business responsibilities
- Architectural constraints
- Traceability to related architecture artifacts

This specification does not define:

- Business attributes
- Data types
- Database tables
- Keys and constraints
- Physical storage
- Service implementation
- APIs
- Persistence mechanisms

---

# 3. Architectural Principles

The Canonical Entity Definitions are governed by the following principles.

| Principle ID | Principle |
|--------------|-----------|
| ENT-001 | Every Entity belongs to exactly one Business Domain. |
| ENT-002 | Every Entity belongs to exactly one Aggregate. |
| ENT-003 | Every Aggregate has exactly one Aggregate Root. |
| ENT-004 | Every Entity has one authoritative business owner. |
| ENT-005 | Entity identity is independent of implementation technology. |
| ENT-006 | Entity definitions represent business concepts only. |
| ENT-007 | Entity ownership shall remain stable across architecture baselines. |
| ENT-008 | Every Entity shall be traceable to approved architecture artifacts. |

---

# 4. Enterprise Domain Overview

| Domain | Primary Responsibility | Entity Category |
|---------|------------------------|-----------------|
| Reference Domain | Enterprise reference information | Reference Entities |
| Core Domain | Enterprise master business information | Master Entities |
| Market Domain | Trading and market operational information | Transactional & Historical Entities |
| Integration Domain | External system integration | Integration Entities |
| Audit Domain | Enterprise traceability | Audit Entities |
| Configuration Domain | Enterprise configuration | Configuration Entities |
| Reporting Domain | Analytical presentation | Reporting Entities |

---

# 5. Canonical Entity Catalog

## 5.1 Reference Domain

The Reference Domain provides stable enterprise reference information shared across all business domains.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Exchange | Exchange | Yes | Reference Entity | Represents a regulated securities exchange. |
| Trading Board | Exchange | No | Reference Entity | Represents a trading board operated by an Exchange. |
| Market | Exchange | No | Reference Entity | Represents a securities market administered by an Exchange. |
| Trading Calendar | Trading Calendar | Yes | Reference Entity | Defines official trading days and trading sessions. |
| Trading Session | Trading Calendar | No | Reference Entity | Represents an individual trading session within a trading day. |
| Country | Country | Yes | Reference Entity | Represents sovereign countries. |
| Currency | Currency | Yes | Reference Entity | Represents supported monetary currencies. |
| Time Zone | Country | No | Reference Entity | Represents official time zones associated with countries. |
| Sector | Sector | Yes | Reference Entity | Represents the highest level of business sector classification. |
| Industry | Sector | No | Reference Entity | Represents industry classifications within a business sector. |
| Instrument Type | Instrument Type | Yes | Reference Entity | Represents supported financial instrument categories. |
| Data Provider Type | Data Provider Type | Yes | Reference Entity | Classifies external market data providers. |
| External Identifier Type | External Identifier Type | Yes | Reference Entity | Defines supported external identifier classifications. |

---

## 5.2 Core Domain

The Core Domain contains the principal business entities representing listed companies and tradable financial instruments.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Company | Company | Yes | Master Entity | Represents a legal issuer or listed company. |
| Instrument | Instrument | Yes | Master Entity | Represents a tradable financial instrument issued by a company. |

---

## 5.3 Market Domain

The Market Domain manages listing information, historical market activity, and corporate events.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Instrument Listing | Instrument Listing | Yes | Transactional Entity | Represents the listing of an Instrument on a Trading Board. |
| Daily Market Data | Instrument Listing | No | Historical Entity | Represents official daily trading statistics for an Instrument Listing. |
| Corporate Action | Corporate Action | Yes | Historical Event | Represents corporate events affecting listed securities. |

---

## 5.4 Integration Domain

The Integration Domain manages communication with external systems and maintains mappings between enterprise and external identifiers.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Data Provider | Data Provider | Yes | Integration Entity | Represents an external market data provider. |
| External Identifier | External Identifier | Yes | Integration Entity | Maps enterprise entities to provider-specific identifiers. |
| Import Session | Import Session | Yes | Operational Entity | Represents an enterprise data import execution. |
| Import Batch | Import Session | No | Operational Entity | Represents a logical batch processed during an import session. |

---

## 5.5 Audit Domain

The Audit Domain provides enterprise-wide traceability and preserves immutable historical records.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Audit Session | Audit Session | Yes | Audit Entity | Represents the execution context for audit activities. |
| Audit Event | Audit Session | No | Audit Entity | Represents an immutable audit record generated by the platform. |

---

## 5.6 Configuration Domain

The Configuration Domain manages enterprise configuration information.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Configuration Group | Configuration Group | Yes | Configuration Entity | Represents a logical grouping of configuration items. |
| Configuration Item | Configuration Group | No | Configuration Entity | Represents an individual configurable enterprise parameter. |

---

## 5.7 Reporting Domain

The Reporting Domain provides analytical and reporting capabilities derived from enterprise business information.

| Entity | Aggregate | Aggregate Root | Entity Type | Business Responsibility |
|---------|-----------|----------------|-------------|-------------------------|
| Report Definition | Report Definition | Yes | Reporting Entity | Represents a reusable enterprise report specification. |
| Report Snapshot | Report Definition | No | Reporting Entity | Represents a generated immutable report instance. |

---

# 6. Entity Classification Summary

The Phoenix Platform Enterprise Information Model currently defines the following canonical entity categories.

| Entity Category | Count | Description |
|-----------------|------:|-------------|
| Reference Entity | 13 | Stable enterprise reference information shared across business domains. |
| Master Entity | 2 | Core enterprise business entities. |
| Transactional Entity | 1 | Operational business entities participating in business processes. |
| Historical Entity | 1 | Immutable historical business records. |
| Historical Event | 1 | Business events affecting enterprise entities. |
| Integration Entity | 2 | External system integration and identity mapping entities. |
| Operational Entity | 2 | Operational entities supporting enterprise integration workflows. |
| Audit Entity | 2 | Enterprise audit and traceability entities. |
| Configuration Entity | 2 | Enterprise configuration entities. |
| Reporting Entity | 2 | Reporting and analytical entities. |

---

# 7. Architectural Constraints

The following architectural constraints apply to every canonical entity.

| Constraint ID | Constraint |
|---------------|------------|
| ENT-CST-001 | Every Entity shall belong to exactly one Business Domain. |
| ENT-CST-002 | Every Entity shall belong to exactly one Aggregate. |
| ENT-CST-003 | Every Aggregate shall define exactly one Aggregate Root. |
| ENT-CST-004 | Aggregate ownership shall never overlap. |
| ENT-CST-005 | Aggregate boundaries shall remain stable across architecture baselines. |
| ENT-CST-006 | Cross-Aggregate references shall occur only through Aggregate Root identifiers. |
| ENT-CST-007 | Business identity shall remain independent of implementation technology. |
| ENT-CST-008 | Entity definitions shall not depend on database implementation or programming languages. |
| ENT-CST-009 | Every Entity shall remain traceable to approved architecture artifacts. |

---

# 8. Traceability

The Canonical Entity Definitions are derived from and validated against the following authoritative architectural artifacts.

| Source Artifact | Purpose |
|-----------------|---------|
| BusinessGlossary | Canonical business terminology |
| CanonicalBusinessConcepts | Business concepts |
| CanonicalBusinessRules | Enterprise business rules |
| CanonicalDomainModel | Domain ownership |
| AggregateCatalog | Aggregate ownership |
| AggregateDefinitions | Aggregate responsibilities |
| EnterpriseRelationshipCatalog | Approved business relationships |
| EnterpriseRelationshipMatrix | Relationship validation |
| BusinessConstraintMatrix | Business constraints |
| CanonicalEnterpriseERD | Enterprise logical representation |
| EntityDictionary | Detailed business definitions |
| AttributeCatalog | Enterprise attribute catalog |

---

# 9. Governance

The Canonical Entity Definitions constitute an Enterprise Architecture Baseline artifact.

Any modification to this specification shall require:

- Architecture Review
- Domain Impact Analysis
- Aggregate Boundary Validation
- Enterprise Relationship Validation
- Architecture Board Approval
- Repository Baseline Update (if applicable)

---

# 10. Related Artifacts

This document should be used together with:

- CanonicalDomainModel
- AggregateCatalog
- AggregateDefinitions
- AggregateBoundaryValidation
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- BusinessConstraintMatrix
- CanonicalEnterpriseERD
- LogicalDomainModels
- EntityDictionary
- AttributeCatalog
- AttributeDictionary

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-19 | Repository-wide architecture refactoring. Standardized metadata, governance model, traceability, entity catalog structure, architectural constraints, and alignment with the canonical enterprise architecture baseline. |