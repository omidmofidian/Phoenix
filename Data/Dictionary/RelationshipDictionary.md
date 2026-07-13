# Relationship Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-004 |
| Document | RelationshipDictionary |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Enterprise Data Dictionary |
| Task | T3-009 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical business relationships between entities within the Phoenix Platform.

The Relationship Dictionary provides the authoritative reference for logical associations, ownership, cardinality, and aggregate boundaries.

Relationships documented herein represent business semantics and shall remain independent of physical database implementation.

---

# 2. Scope

This standard applies to:

- Logical Data Models
- Entity Relationships
- Aggregate Design
- Service Boundaries
- Physical Database Design
- API Contracts

---

# 3. Relationship Definition Template

Each relationship shall include the following metadata.

| Property | Description |
|----------|-------------|
| Source Entity | Originating entity |
| Target Entity | Related entity |
| Relationship Type | Association, Aggregation, Composition, Dependency |
| Cardinality | 1:1, 1:N, N:M |
| Ownership | Owning entity |
| Aggregate Boundary | Internal / External |
| Business Meaning | Business interpretation |
| Status | Draft / Approved / Deprecated |

---

# 4. Canonical Relationships

| Source Entity | Target Entity | Type | Cardinality | Ownership | Aggregate Boundary |
|---------------|---------------|------|-------------|-----------|--------------------|
| Market | Exchange | Association | 1:N | Market | External |
| Exchange | Listing | Association | 1:N | Exchange | External |
| Instrument | Listing | Composition | 1:N | Instrument | Internal |
| Instrument | Symbol | Composition | 1:N | Instrument | Internal |
| Listing | Daily Market Data | Association | 1:N | Listing | External |
| Portfolio | Position | Composition | 1:N | Portfolio | Internal |
| Strategy | Indicator | Aggregation | 1:N | Strategy | Internal |
| Strategy | Feature | Aggregation | 1:N | Strategy | Internal |
| Strategy | Signal | Composition | 1:N | Strategy | Internal |
| Model | Prediction | Composition | 1:N | Model | Internal |
| Provider | Market Data | Dependency | 1:N | Provider | External |

---

# 5. Relationship Types

## Association

A semantic relationship where two entities are related but maintain independent lifecycles.

---

## Aggregation

A whole-part relationship where child entities may exist independently.

---

## Composition

A strong ownership relationship.

The child entity cannot exist independently of its owner.

---

## Dependency

A usage relationship where one entity depends upon another without ownership.

---

# 6. Cardinality Rules

Approved cardinalities:

- 1:1
- 1:N
- N:M

All many-to-many relationships shall be resolved through explicit associative entities during logical database modeling.

---

# 7. Aggregate Boundaries

Relationships are classified as:

## Internal

Relationship exists within a single aggregate.

Transactional consistency is guaranteed.

---

## External

Relationship crosses aggregate boundaries.

Interaction shall occur through aggregate roots or services.

---

# 8. Ownership Rules

Ownership determines lifecycle responsibility.

The owner entity is responsible for:

- Creation
- Update
- Deactivation
- Removal (where applicable)

Owned entities shall not be modified independently.

---

# 9. Traceability

Every relationship shall be traceable to:

- Business Glossary
- Entity Dictionary
- Canonical Business Rules
- Aggregate Catalog
- Service Context Map

---

# 10. Compliance

All logical relationships shall be documented before physical foreign keys are introduced.

Physical implementation shall not alter the approved business relationships.

---

# 11. Related Documents

- BusinessGlossary.md
- EntityDictionary.md
- AttributeDictionary.md
- CanonicalAggregateCatalog.md
- AggregateDefinitions.md
- ConceptualRelationships.md
- ServiceContextMap.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Relationship Dictionary. |