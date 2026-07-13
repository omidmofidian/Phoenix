# Cardinality Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-002 |
| Document | CardinalityMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | EnterpriseRelationshipMatrix, EnterpriseRelationshipCatalog, CanonicalEntityDefinitions |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical cardinality and participation rules governing relationships between enterprise entities within the Phoenix Platform.

It establishes the authoritative multiplicity model for all logical relationships and serves as the primary reference for logical data modeling, validation, Canonical ERD generation and physical database design.

This document is technology independent.

---

# 2. Cardinality Principles

The following principles apply to all enterprise relationships.

- Every relationship shall define its minimum and maximum participation.
- Cardinality is determined by business semantics rather than implementation constraints.
- Mandatory participation shall be explicitly documented.
- Lifecycle dependency is independent of cardinality.
- Identifying relationships shall be explicitly identified.

---

# 3. Cardinality Matrix

| ID | Parent Entity | Child Entity | Parent Participation | Child Participation | Cardinality | Lifecycle Dependency | Identifying Relationship | Notes |
|----|---------------|--------------|----------------------|---------------------|-------------|----------------------|--------------------------|-------|
| CAR-001 | Exchange | Trading Board | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | No | Trading Boards cannot exist without an Exchange. |
| CAR-002 | Sector | Industry | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Industries belong to one Sector. |
| CAR-003 | Company | Instrument | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Every Instrument is issued by one Company. |
| CAR-004 | Instrument | Instrument Listing | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | One Instrument may have multiple listings. |
| CAR-005 | Trading Board | Instrument Listing | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Listings exist on one Trading Board. |
| CAR-006 | Instrument Listing | Daily Market Data | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Market data cannot exist without its listing. |
| CAR-007 | Trading Calendar | Daily Market Data | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Every market record belongs to one trading day. |
| CAR-008 | Instrument | Corporate Action | Mandatory (1..1) | Optional (0..N) | 1:N | No | No | Corporate Actions occur only when applicable. |
| CAR-009 | Data Provider | External Identifier | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | No | External identifiers belong to one provider. |
| CAR-010 | External Identifier | Enterprise Entity | Mandatory (1..N) | Mandatory (1..1) | N:1 | No | No | Multiple external identifiers may reference one enterprise entity. |
| CAR-011 | Audit Session | Audit Event | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Audit Events belong to one Audit Session. |
| CAR-012 | Audit Event | Aggregate Root | Mandatory (1..N) | Mandatory (1..1) | N:1 | No | No | Audit Events reference one Aggregate Root. |
| CAR-013 | Configuration Group | Configuration Item | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Configuration Items belong to one Configuration Group. |
| CAR-014 | Report Definition | Report Snapshot | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Snapshots originate from one Report Definition. |
| CAR-015 | Report Snapshot | Enterprise Domains | Mandatory (1..N) | Mandatory (1..N) | N:N | No | No | Reports consume information from multiple domains. |

---

# 4. Participation Rules

Participation defines whether an entity is required to exist within a relationship.

| Participation | Meaning |
|---------------|---------|
| Mandatory | Participation is required. |
| Optional | Participation is not required. |

---

# 5. Lifecycle Dependency Rules

Lifecycle dependency specifies whether the lifecycle of the child entity depends on its parent.

| Value | Description |
|-------|-------------|
| Yes | Child cannot exist independently. |
| No | Child may continue to exist independently. |

---

# 6. Identifying Relationship Rules

An identifying relationship indicates that the child entity derives part of its identity from the parent.

Typical identifying relationships include:

- Instrument Listing → Daily Market Data
- Audit Session → Audit Event
- Configuration Group → Configuration Item
- Report Definition → Report Snapshot

---

# 7. Validation Rules

The following validation rules shall always hold.

- Every relationship shall define a valid cardinality.
- Parent participation shall always be defined.
- Child participation shall always be defined.
- Lifecycle dependency shall be explicitly specified.
- Identifying relationships shall be documented.
- Cardinality shall remain consistent with the Enterprise Relationship Matrix.

---

# 8. Traceability

| Artifact | Purpose |
|----------|---------|
| EnterpriseRelationshipMatrix | Relationship ownership and navigation |
| EnterpriseRelationshipCatalog | Semantic relationship definitions |
| CanonicalEntityDefinitions | Entity classification |
| AggregateCatalog | Aggregate ownership |
| BusinessConstraintMatrix | Constraint validation |
| AggregateDependencyMatrix | Aggregate dependency analysis |
| DomainDependencyMatrix | Domain dependency validation |
| Canonical ERD | Graphical enterprise relationship model |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Cardinality Matrix |