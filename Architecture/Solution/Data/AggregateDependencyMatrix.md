# Aggregate Dependency Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-003 |
| Document | AggregateDependencyMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | AggregateCatalog, EnterpriseRelationshipMatrix, CanonicalDomainModel |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical dependency relationships among Aggregates within the Phoenix Platform.

It identifies dependency direction, dependency strength and architectural constraints while remaining independent of implementation technology.

This document is the authoritative reference for Aggregate interaction and provides the architectural basis for service boundaries, migration sequencing and enterprise validation.

---

# 2. Dependency Principles

The following principles govern Aggregate dependencies.

- Every Aggregate shall have a single Aggregate Root.
- Aggregate dependencies shall be unidirectional.
- Circular Aggregate dependencies are prohibited.
- Dependencies shall cross Aggregate boundaries only through Aggregate Roots.
- Aggregate dependencies shall reflect business semantics rather than implementation details.

---

# 3. Aggregate Dependency Matrix

| ID | Source Aggregate | Target Aggregate | Dependency Type | Strength | Mandatory | Cross Domain | Reason |
|----|------------------|------------------|-----------------|----------|-----------|--------------|--------|
| AGG-001 | Trading Board | Exchange | Structural | Strong | Yes | No | Every Trading Board belongs to one Exchange. |
| AGG-002 | Industry | Sector | Structural | Strong | Yes | No | Every Industry belongs to one Sector. |
| AGG-003 | Instrument | Company | Business | Strong | Yes | No | Every Instrument is issued by one Company. |
| AGG-004 | Instrument Listing | Instrument | Business | Strong | Yes | Yes | Listing requires an Instrument. |
| AGG-005 | Instrument Listing | Trading Board | Business | Strong | Yes | Yes | Listing requires a Trading Board. |
| AGG-006 | Daily Market Data | Instrument Listing | Lifecycle | Strong | Yes | No | Market Data exists only for a Listing. |
| AGG-007 | Daily Market Data | Trading Calendar | Reference | Strong | Yes | Yes | Market Data belongs to a Trading Day. |
| AGG-008 | Corporate Action | Instrument | Business | Medium | No | Yes | Corporate Actions affect Instruments. |
| AGG-009 | External Identifier | Data Provider | Lifecycle | Strong | Yes | No | Identifier belongs to one Provider. |
| AGG-010 | External Identifier | Enterprise Entity | Reference | Strong | Yes | Yes | Maps external identity to enterprise identity. |
| AGG-011 | Audit Event | Audit Session | Lifecycle | Strong | Yes | No | Events belong to one Session. |
| AGG-012 | Audit Event | Aggregate Root | Reference | Medium | Yes | Yes | Audit references business Aggregates. |
| AGG-013 | Configuration Item | Configuration Group | Lifecycle | Strong | Yes | No | Items belong to a Configuration Group. |
| AGG-014 | Report Snapshot | Report Definition | Lifecycle | Strong | Yes | No | Snapshot derives from Report Definition. |
| AGG-015 | Report Snapshot | Enterprise Aggregates | Analytical | Weak | Yes | Yes | Reports consume enterprise information. |

---

# 4. Dependency Types

| Type | Description |
|------|-------------|
| Structural | Defines structural ownership. |
| Business | Represents core business dependency. |
| Lifecycle | Child lifecycle depends on parent Aggregate. |
| Reference | Read-only business reference. |
| Analytical | Read-only dependency used for reporting and analytics. |

---

# 5. Dependency Strength

| Strength | Description |
|----------|-------------|
| Strong | Aggregate cannot fulfill its business responsibility without the dependency. |
| Medium | Aggregate depends on another Aggregate for selected business capabilities. |
| Weak | Dependency exists only for derived or analytical purposes. |

---

# 6. Architectural Rules

The following architectural rules shall always hold.

- Aggregate Roots are the only externally accessible entry points.
- Dependencies shall never bypass Aggregate Roots.
- Circular dependencies are prohibited.
- Cross-domain dependencies shall remain explicit.
- Business ownership shall never transfer through dependencies.

---

# 7. Validation Rules

The following validation rules apply.

- Every Aggregate dependency shall identify its target Aggregate.
- Every dependency shall specify its type.
- Every dependency shall specify its strength.
- Mandatory dependencies shall be explicitly identified.
- Circular dependencies shall not exist.

---

# 8. Traceability

| Artifact | Purpose |
|----------|---------|
| AggregateCatalog | Aggregate definitions |
| CanonicalEntityDefinitions | Entity ownership |
| EnterpriseRelationshipCatalog | Semantic relationships |
| EnterpriseRelationshipMatrix | Relationship structure |
| CardinalityMatrix | Multiplicity validation |
| DomainDependencyMatrix | Domain dependency validation |
| CanonicalBusinessRules | Business semantics |

---

# 9. Dependency Overview

## Reference Domain

- Trading Board → Exchange
- Industry → Sector

## Core Domain

- Instrument → Company

## Market Domain

- Instrument Listing → Instrument
- Instrument Listing → Trading Board
- Daily Market Data → Instrument Listing
- Daily Market Data → Trading Calendar
- Corporate Action → Instrument

## Integration Domain

- External Identifier → Data Provider
- External Identifier → Enterprise Entity

## Audit Domain

- Audit Event → Audit Session
- Audit Event → Aggregate Root

## Configuration Domain

- Configuration Item → Configuration Group

## Reporting Domain

- Report Snapshot → Report Definition
- Report Snapshot → Enterprise Aggregates

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Aggregate Dependency Matrix |