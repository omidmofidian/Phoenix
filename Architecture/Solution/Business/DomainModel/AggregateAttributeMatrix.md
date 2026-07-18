# Aggregate Attribute Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-007 |
| Document | AggregateAttributeMatrix |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Domain Architecture |
| Owner | Enterprise Architecture |
| Architecture Layer | Domain Model |
| Depends On | CanonicalDomainModel, AggregateCatalog, EntityClassification, EnterpriseAttributeCatalog |
| Consumed By | ConceptualDataModel, LogicalDatabaseModel, PhysicalDatabaseModel |
| Last Updated | 2026-07-18 |

---

# 1. Purpose

This document defines the canonical attribute profiles assigned to Aggregate Roots within the Phoenix Platform.

Rather than defining physical database columns, this document specifies the categories of business attributes that each Aggregate shall possess according to its business responsibilities.

The Aggregate Attribute Matrix establishes the architectural relationship between Aggregate definitions and the Enterprise Attribute Catalog.

---

# 2. Objectives

The objectives of this document are to:

- Standardize Aggregate attribute composition.
- Promote enterprise-wide attribute reuse.
- Eliminate duplicate attribute definitions.
- Ensure consistency across all business domains.
- Support technology-independent domain modeling.
- Provide traceability between Aggregates and Enterprise Attributes.
- Serve as the foundation for subsequent conceptual and logical data modeling.

---

# 3. Architectural Principles

The Aggregate Attribute Matrix follows the following architectural principles.

## AAM-001 — Enterprise Attribute Reuse

Business attributes shall be defined once within the Enterprise Attribute Catalog and reused throughout the platform.

---

## AAM-002 — Technology Independence

This document defines business attribute profiles only.

Physical database columns, SQL data types, indexes, and implementation details are outside its scope.

---

## AAM-003 — Aggregate Consistency

All instances of the same Aggregate shall share the same attribute profile.

---

## AAM-004 — Single Source of Truth

Business attribute definitions shall originate exclusively from the Enterprise Attribute Catalog.

This document assigns attributes but never defines them.

---

## AAM-005 — Separation of Concerns

Business attributes, audit attributes, derived attributes, and infrastructure attributes shall remain architecturally separated.

---

# 4. Attribute Categories

The Phoenix Platform classifies enterprise attributes into the following categories.

| Category | Purpose |
|----------|---------|
| Identity | Enterprise identity and business identifiers |
| Naming | Human-readable names and business codes |
| Business | Core business properties |
| Reference | References to other Aggregate Roots |
| Classification | Business classifications and taxonomies |
| Lifecycle | Business status and lifecycle management |
| Temporal | Business validity and effective periods |
| External | External provider identifiers |
| Derived | Computed business information |
| Audit | Enterprise audit information inherited from the Base Entity Pattern |

Audit attributes are inherited by all Aggregates and therefore are not explicitly repeated within Aggregate profiles.

---

# 5. Aggregate Attribute Profiles

This section defines the canonical attribute profile for each Aggregate.

The profiles specify the categories of attributes required by each Aggregate rather than individual attribute definitions.

Detailed attribute semantics are maintained within the Enterprise Attribute Catalog.

---

# 5.1 Reference Domain

Reference Aggregates provide enterprise-wide reference information shared across multiple business domains.

## Exchange

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Business | Yes |
| Lifecycle | Yes |
| External | Optional |
| Audit | Inherited |

---

## Market

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Reference | Yes |
| Business | Yes |
| Lifecycle | Yes |
| Audit | Inherited |

---

## Board

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Reference | Yes |
| Lifecycle | Yes |
| Audit | Inherited |

---

## Industry

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Lifecycle | Yes |
| Audit | Inherited |

---

## Sector

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Reference | Yes |
| Lifecycle | Yes |
| Audit | Inherited |

---

## Trading Calendar

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Business | Yes |
| Temporal | Yes |
| Lifecycle | Yes |
| Audit | Inherited |

---

# 5.2 Core Domain

## Company

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Reference | Yes |
| Business | Yes |
| Lifecycle | Yes |
| External | Optional |
| Audit | Inherited |

---

## Financial Instrument

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Naming | Yes |
| Reference | Yes |
| Classification | Yes |
| Business | Yes |
| Lifecycle | Yes |
| External | Optional |
| Audit | Inherited |

---

# 5.3 Market Domain

## Daily Market Data

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Reference | Yes |
| Business | Yes |
| Temporal | Yes |
| Audit | Inherited |

---

## Corporate Action

| Attribute Category | Required |
|--------------------|----------|
| Identity | Yes |
| Reference | Yes |
| Classification | Yes |
| Business | Yes |
| Temporal | Yes |
| Audit | Inherited |

---

# 6. Attribute Inheritance

All Aggregate Roots shall inherit common enterprise attributes through the Base Entity Pattern.

Inherited attributes include, but are not limited to:

- Audit attributes
- Versioning attributes
- Concurrency control attributes
- Common lifecycle metadata

Inheritance ensures architectural consistency while eliminating duplicated attribute definitions.

Aggregate-specific business attributes shall extend the inherited profile without modifying the Base Entity Pattern.

---

# 7. Validation Rules

Every Aggregate Attribute Profile shall satisfy the following validation rules.

## AAM-VR-001

Every Aggregate shall define exactly one business identity.

---

## AAM-VR-002

Every Reference attribute shall reference another Aggregate Root.

---

## AAM-VR-003

Attribute categories shall align with the Aggregate's business responsibility.

---

## AAM-VR-004

Business attributes shall originate from the Enterprise Attribute Catalog.

---

## AAM-VR-005

Audit attributes shall not be redefined within Aggregate profiles.

---

## AAM-VR-006

Derived attributes shall never be persisted as canonical business attributes unless explicitly approved by an Architecture Decision Record (ADR).

---

# 8. Traceability

The Aggregate Attribute Matrix maintains traceability with the following architectural artifacts.

| Artifact | Relationship |
|----------|--------------|
| BusinessCapabilityMap | Defines business capabilities supported by each Aggregate |
| CanonicalDomainModel | Defines Aggregate boundaries |
| AggregateCatalog | Defines Aggregate ownership and responsibilities |
| EntityClassification | Classifies Aggregate entities |
| EnterpriseAttributeCatalog | Defines enterprise attribute semantics |
| ConceptualDataModel | Maps Aggregate profiles to conceptual entities |
| LogicalDatabaseModel | Refines conceptual attributes into logical structures |
| PhysicalDatabaseModel | Implements logical attributes as physical database objects |

---

# 9. Success Criteria

The Aggregate Attribute Matrix is considered complete when:

- Every Aggregate Root has an approved attribute profile.
- All attribute categories conform to enterprise standards.
- No Aggregate defines implementation-specific attributes.
- All business attributes are traceable to the Enterprise Attribute Catalog.
- Attribute inheritance is consistently applied across all Aggregates.
- Validation rules have been verified through architectural review.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version. |
| 2026.2 | 2026-07-18 | Complete architectural redesign. Converted from implementation-oriented attribute lists to technology-independent enterprise attribute profiles aligned with the Canonical Domain Model and Enterprise Attribute Catalog. |