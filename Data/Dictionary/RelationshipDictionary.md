# Relationship Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-005 |
| Document | RelationshipDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Enterprise Architecture Team |
| Depends On | EnterpriseDataDictionaryStandard, EntityDictionary, AttributeDictionary, CanonicalDomainModel, AggregateCatalog, EnterpriseRelationshipStandard |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The Relationship Dictionary defines the canonical business semantics of relationships between enterprise entities within the Phoenix Platform.

It serves as the authoritative semantic reference describing how business entities are related independently of implementation technology, database structures, or service implementations.

Every approved relationship shall possess one and only one enterprise definition.

The Relationship Dictionary is therefore the Single Source of Truth for business relationships across the Phoenix Platform.

---

# 2. Scope

This dictionary applies to every business relationship appearing within the enterprise information architecture, including:

- Business Concepts
- Aggregate Roots
- Member Entities
- Value Objects
- Logical Entities
- Enterprise Information Model
- Logical Data Models
- Physical Data Models
- Enterprise Data Dictionary

This document defines only business semantics.

It intentionally excludes:

- SQL foreign keys
- Database constraints
- Physical joins
- ORM mappings
- API implementation
- Service implementation
- Query optimization

Implementation details are governed by the Physical Database Model and related implementation standards.

---

# 3. Enterprise Position

Within the Phoenix Enterprise Information Architecture, relationships occupy a dedicated semantic layer.

The enterprise modeling sequence is therefore:

Business Capability

↓

Business Concept

↓

Domain

↓

Aggregate

↓

Entity

↓

Relationship

↓

Logical Information Model

↓

Physical Database Model

Business relationships shall always be modeled before database relationships.

Business meaning shall always precede technical implementation.

---

# 4. Relationship Objectives

The Relationship Dictionary establishes:

- canonical relationship semantics;
- relationship ownership;
- business cardinality;
- aggregate boundaries;
- lifecycle dependencies;
- enterprise consistency;
- architectural traceability.

Every logical and physical implementation shall conform to these definitions.

---

# 5. Relationship Principles

The Phoenix Platform adopts the following enterprise principles.

## Principle 1

Relationships are enterprise information assets.

---

## Principle 2

Each relationship shall have exactly one canonical business meaning.

---

## Principle 3

Relationships shall describe business semantics rather than implementation mechanisms.

---

## Principle 4

Business relationships shall remain technology independent.

---

## Principle 5

Physical implementation shall never redefine business semantics.

---

## Principle 6

Relationships shall preserve bounded context boundaries.

---

## Principle 7

Relationship ownership shall always be explicit.

---

## Principle 8

Every relationship shall be traceable throughout the enterprise architecture.

---

# 6. Relationship Lifecycle

Every enterprise relationship progresses through the following lifecycle.

Proposed

↓

Reviewed

↓

Approved

↓

Implemented

↓

Operational

↓

Deprecated

↓

Retired

Only Approved relationships may appear in enterprise logical models.

---

# 7. Single Source of Truth

Every business relationship shall be documented only once.

Other architectural artifacts shall reference this dictionary instead of redefining relationship semantics.

This guarantees:

- semantic consistency;
- architectural integrity;
- enterprise governance;
- reusable business knowledge.

---

# 8. Enterprise Relationship Taxonomy

Every relationship shall belong to exactly one canonical relationship category.

| Category | Purpose |
|----------|---------|
| Association | Independent business entities with a semantic relationship |
| Aggregation | Whole-part relationship with independent lifecycle |
| Composition | Strong ownership relationship with dependent lifecycle |
| Reference | Cross-aggregate business reference |
| Dependency | Operational or behavioral dependency |
| Hierarchical | Parent-child organizational relationship |
| Temporal | Relationship valid only within a business time period |
| Derived | Relationship inferred from approved business rules |

Relationship categories are mutually exclusive.

---

# 9. Relationship Definition Template

Every relationship documented within the enterprise shall contain the following metadata.

| Property | Description |
|----------|-------------|
| Canonical Name | Enterprise relationship name |
| Source Entity | Originating business entity |
| Target Entity | Related business entity |
| Relationship Category | Canonical relationship classification |
| Business Meaning | Semantic interpretation |
| Cardinality | Approved business cardinality |
| Ownership | Owning Aggregate |
| Aggregate Boundary | Internal or External |
| Lifecycle Dependency | Independent or Dependent |
| Navigability | Business navigation direction |
| Status | Proposed / Approved / Deprecated |
| Related Business Rules | Applicable enterprise rules |

---

# 10. Relationship Ownership

Every relationship shall have exactly one owning Aggregate.

Relationship ownership determines:

- lifecycle responsibility;
- business consistency;
- modification authority;
- governance responsibility.

Ownership shall never be shared across Aggregates.

---

# 11. Aggregate Boundary Model

Relationships are classified according to aggregate boundaries.

## Internal Relationship

An Internal Relationship exists entirely within a single Aggregate.

Characteristics include:

- transactional consistency;
- shared lifecycle;
- same Aggregate ownership;
- synchronous modification.

---

## External Relationship

An External Relationship connects two different Aggregates.

Characteristics include:

- independent lifecycles;
- separate ownership;
- aggregate isolation;
- interaction through Aggregate Roots or domain services.

External relationships shall never violate aggregate boundaries.

---

# 12. Business Cardinality

Business relationships shall express business reality rather than implementation convenience.

Approved cardinalities are:

| Cardinality | Meaning |
|-------------|---------|
| 1 : 1 | One-to-one |
| 1 : N | One-to-many |
| N : 1 | Many-to-one |
| N : M | Many-to-many (conceptual only) |

Conceptual many-to-many relationships shall always be resolved into associative entities during logical data modeling.

The conceptual business meaning, however, shall remain unchanged.

---

# 13. Navigability

Business navigability defines the natural direction of understanding a relationship.

Navigability is independent of database joins.

Relationship navigation may be:

- Unidirectional
- Bidirectional

Navigation shall always represent business understanding rather than technical access paths.

---

# 14. Lifecycle Dependency

Relationships shall explicitly define lifecycle dependency.

Possible values include:

| Dependency | Description |
|------------|-------------|
| Independent | Both entities maintain independent lifecycles |
| Dependent | Target lifecycle depends on source |
| Shared | Entities evolve together within one Aggregate |

Lifecycle dependency shall be determined exclusively by business rules.

---

# 15. Referential Semantics

Reference relationships identify another Aggregate Root.

Reference relationships:

- preserve aggregate independence;
- establish business association;
- do not imply ownership;
- do not imply lifecycle dependency.

Reference relationships are semantic concepts and shall not be confused with physical foreign keys.

---

# 16. Relationship Validation Principles

Every approved relationship shall satisfy the following validation criteria:

- unique canonical definition;
- approved relationship category;
- valid ownership;
- approved cardinality;
- aggregate boundary compliance;
- lifecycle consistency;
- business semantic clarity;
- traceability to enterprise artifacts.

Relationships failing any validation criterion shall not be approved.

---

# 17. Canonical Relationship Catalog

The following catalog defines the enterprise-approved business relationships currently recognized within the Phoenix Platform.

| Source Entity | Target Entity | Category | Cardinality | Ownership | Aggregate Boundary |
|---------------|---------------|----------|-------------|-----------|--------------------|
| Exchange | Market | Association | 1 : N | Reference | External |
| Exchange | Trading Board | Composition | 1 : N | Exchange | Internal |
| Trading Board | Instrument Listing | Composition | 1 : N | Trading Board | Internal |
| Sector | Industry | Composition | 1 : N | Sector | Internal |
| Industry | Company | Association | 1 : N | Industry | External |
| Company | Instrument | Composition | 1 : N | Company | Internal |
| Instrument | Instrument Listing | Composition | 1 : N | Instrument | Internal |
| Instrument Listing | Daily Market Data | Composition | 1 : N | Instrument Listing | Internal |
| Trading Calendar | Daily Market Data | Association | 1 : N | Trading Calendar | External |
| Instrument | Corporate Action | Association | 1 : N | Instrument | External |
| Portfolio | Position | Composition | 1 : N | Portfolio | Internal |
| Strategy | Indicator | Aggregation | 1 : N | Strategy | Internal |
| Strategy | Feature | Aggregation | 1 : N | Strategy | Internal |
| Strategy | Signal | Composition | 1 : N | Strategy | Internal |
| Model | Prediction | Composition | 1 : N | Model | Internal |

The catalog shall evolve only through Architecture Governance.

---

# 18. Relationship Traceability

Every approved relationship shall be traceable throughout the enterprise architecture.

Relationship traceability shall include references to:

- Business Glossary
- Enterprise Data Dictionary
- Entity Dictionary
- Attribute Dictionary
- Aggregate Catalog
- Aggregate Definitions
- Canonical Domain Model
- Logical Database Model
- Physical Database Model
- Canonical Business Rules
- Service Context Map

Relationship definitions shall remain synchronized with all dependent architectural artifacts.

---

# 19. Relationship Governance

The introduction of a new business relationship requires:

- business justification;
- semantic review;
- ownership verification;
- aggregate boundary validation;
- lifecycle analysis;
- architectural approval.

Modifications to approved relationships shall follow the Architecture Governance process.

Relationships shall never be introduced solely to simplify implementation.

---

# 20. Relationship Evolution

Business relationships evolve independently from implementation technologies.

Relationship evolution shall preserve:

- business semantics;
- canonical naming;
- ownership;
- traceability;
- backward architectural compatibility.

Breaking changes require a formal Architecture Decision Record (ADR).

---

# 21. Compliance

Every logical relationship within the Phoenix Platform shall comply with:

- Enterprise Naming Standard
- Enterprise Attribute Standard
- Enterprise Data Dictionary Standard
- Canonical Domain Model
- Aggregate Modeling Standard
- Service Context Map
- Architecture Governance Model

No physical implementation may contradict the approved enterprise relationship definitions.

---

# 22. Related Documents

- EnterpriseAttributeStandard
- EnterpriseDataDictionaryStandard
- EntityDictionary
- AttributeDictionary
- AggregateCatalog
- AggregateDefinitions
- CanonicalDomainModel
- LogicalDatabaseModel
- PhysicalDatabaseModel
- CanonicalBusinessRules
- ServiceContextMap
- ArchitectureGovernanceModel

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Relationship Dictionary |
| 2026.2 | 2026-07-23 | Completely redesigned as the Enterprise Relationship Dictionary aligned with the Enterprise Information Architecture and Single Source of Truth principles |

