# Enterprise Relationship Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ARC-REL-001 |
| Document | EnterpriseRelationshipCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalEntityDefinitions, AggregateCatalog, CanonicalDomainModel, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical semantic relationships between enterprise entities within the Phoenix Platform.

It establishes the authoritative business relationships across all enterprise domains independently of database implementation.

This document describes business meaning rather than physical implementation.

Detailed cardinalities and implementation constraints are maintained in the EnterpriseRelationshipMatrix.

---

# 2. Principles

The following principles govern enterprise relationships.

- Every relationship has a business meaning.
- Relationships are technology independent.
- Relationships connect Aggregate Roots.
- Cross-domain references occur only through Aggregate Roots.
- Every relationship has a defined ownership.
- Circular ownership is prohibited.

---

# 3. Relationship Catalog

## 3.1 Reference Domain

### Exchange → Trading Board

**Relationship**

An Exchange operates one or more Trading Boards.

**Relationship Type**

Composition

**Business Meaning**

Trading Boards cannot exist without an Exchange.

---

### Sector → Industry

**Relationship**

A Sector contains one or more Industries.

**Relationship Type**

Aggregation

**Business Meaning**

Industries classify companies within a business sector.

---

## 3.2 Core Domain

### Company → Instrument

**Relationship**

A Company issues one or more Instruments.

**Relationship Type**

Aggregation

**Business Meaning**

Financial instruments are issued by legal entities.

---

## 3.3 Market Domain

### Instrument → Instrument Listing

**Relationship**

An Instrument may be listed on one or more Trading Boards.

**Relationship Type**

Association

**Business Meaning**

Listings define where an Instrument is traded.

---

### Trading Board → Instrument Listing

**Relationship**

A Trading Board hosts multiple Instrument Listings.

**Relationship Type**

Association

---

### Instrument Listing → Daily Market Data

**Relationship**

Daily Market Data records the trading activity of an Instrument Listing.

**Relationship Type**

Composition

---

### Trading Calendar → Daily Market Data

**Relationship**

Daily Market Data is recorded for an official Trading Day.

**Relationship Type**

Association

---

### Instrument → Corporate Action

**Relationship**

Corporate Actions affect a specific Instrument.

**Relationship Type**

Association

---

## 3.4 Integration Domain

### Data Provider → External Identifier

**Relationship**

A Data Provider assigns external identifiers.

**Relationship Type**

Composition

---

### External Identifier → Enterprise Entity

**Relationship**

External Identifiers map external business identities to enterprise entities.

**Relationship Type**

Association

---

## 3.5 Audit Domain

### Audit Session → Audit Event

**Relationship**

Audit Sessions contain Audit Events.

**Relationship Type**

Composition

---

### Audit Event → Aggregate Root

**Relationship**

Audit Events reference business Aggregate Roots.

**Relationship Type**

Association

---

## 3.6 Configuration Domain

### Configuration Group → Configuration Item

**Relationship**

Configuration Groups organize Configuration Items.

**Relationship Type**

Composition

---

## 3.7 Reporting Domain

### Report Definition → Report Snapshot

**Relationship**

Report Snapshots are generated from Report Definitions.

**Relationship Type**

Composition

---

### Report Snapshot → Enterprise Domains

**Relationship**

Report Snapshots derive information from enterprise domains.

**Relationship Type**

Dependency

---

# 4. Cross-Domain Relationships

| Source Domain | Target Domain | Business Purpose |
|---------------|---------------|------------------|
| Core | Reference | Classification |
| Market | Reference | Trading Structure |
| Market | Core | Tradable Assets |
| Integration | Reference | External Mapping |
| Integration | Core | External Mapping |
| Integration | Market | External Mapping |
| Audit | All Domains | Traceability |
| Configuration | All Services | Business Configuration |
| Reporting | All Domains | Analytical Presentation |

---

# 5. Relationship Classification

| Relationship Type | Description |
|-------------------|-------------|
| Composition | Strong ownership relationship |
| Aggregation | Weak ownership relationship |
| Association | Business reference |
| Dependency | Read-only dependency |

---

# 6. Architectural Constraints

- Aggregate Roots own business relationships.
- Child entities never own parent entities.
- Cross-domain references target Aggregate Roots only.
- Circular ownership is prohibited.
- Relationships remain technology independent.

---

# 7. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalEntityDefinitions | Entity ownership |
| AggregateCatalog | Aggregate ownership |
| EnterpriseRelationshipMatrix | Cardinality |
| BusinessConstraintMatrix | Business constraints |
| DomainDependencyMatrix | Domain dependencies |
| CanonicalBusinessRules | Business semantics |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial enterprise relationship catalog |