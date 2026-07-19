# Cardinality Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-002 |
| Document | CardinalityMatrix |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Architecture Layer | Enterprise Information Architecture |
| Owner | Enterprise Architecture |
| Repository Path | Architecture/Data/Relationships/CardinalityMatrix.md |
| Depends On | EnterpriseRelationshipMatrix, EnterpriseRelationshipCatalog, CanonicalEntityDefinitions |
| Consumed By | AggregateDependencyMatrix, BusinessConstraintMatrix, CanonicalEnterpriseERD, LogicalDatabaseModel |
| Approval Authority | Enterprise Architecture Board |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical cardinality and participation rules governing logical relationships between enterprise entities within the Phoenix Platform.

The Cardinality Matrix establishes the authoritative multiplicity model for all approved business relationships and provides the architectural foundation for enterprise logical data modeling, validation, canonical ERD generation, aggregate consistency analysis, and subsequent physical database design.

This specification is intentionally technology independent and represents business semantics rather than implementation constraints.

---

# 2. Scope

This specification defines:

- Relationship cardinalities
- Participation constraints
- Lifecycle dependency rules
- Identifying relationship rules
- Cardinality validation requirements
- Relationship governance
- Enterprise traceability

This specification does not define:

- Database tables
- Foreign Keys
- Primary Keys
- Physical constraints
- Database indexes
- SQL implementation
- ORM mappings
- Service implementations

---

# 3. Cardinality Principles

Canonical relationship cardinalities are governed by the following architectural principles.

| Principle ID | Principle |
|--------------|-----------|
| CAR-P001 | Every business relationship shall define explicit minimum and maximum participation. |
| CAR-P002 | Cardinality shall be derived from business semantics rather than implementation technology. |
| CAR-P003 | Mandatory participation shall be explicitly identified. |
| CAR-P004 | Lifecycle dependency shall be evaluated independently from relationship cardinality. |
| CAR-P005 | Identifying relationships shall be explicitly documented. |
| CAR-P006 | Cardinalities shall remain consistent with approved Aggregate boundaries. |
| CAR-P007 | Cardinalities shall comply with Domain dependency rules. |
| CAR-P008 | Every relationship shall remain traceable to its authoritative business definition. |

---

# 4. Cardinality Matrix

The following matrix defines the approved cardinality and participation rules for all canonical business relationships within the Phoenix Platform.

| ID | Parent Entity | Child Entity | Parent Participation | Child Participation | Cardinality | Lifecycle Dependency | Identifying Relationship | Notes |
|----|---------------|--------------|----------------------|---------------------|-------------|----------------------|--------------------------|-------|
| CAR-001 | Exchange | Trading Board | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | No | A Trading Board cannot exist without an Exchange. |
| CAR-002 | Sector | Industry | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Every Industry belongs to one Sector. |
| CAR-003 | Company | Instrument | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Every Instrument is issued by one Company. |
| CAR-004 | Instrument | Instrument Listing | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | An Instrument may have multiple Listings. |
| CAR-005 | Trading Board | Instrument Listing | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Every Listing belongs to one Trading Board. |
| CAR-006 | Instrument Listing | Daily Market Data | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Daily Market Data exists only for an Instrument Listing. |
| CAR-007 | Trading Calendar | Daily Market Data | Mandatory (1..1) | Mandatory (1..N) | 1:N | No | No | Market Data belongs to one Trading Day. |
| CAR-008 | Instrument | Corporate Action | Mandatory (1..1) | Optional (0..N) | 1:N | No | No | Corporate Actions exist only when applicable. |
| CAR-009 | Data Provider | External Identifier | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | No | External Identifiers belong to one Data Provider. |
| CAR-010 | Enterprise Entity | External Identifier | Mandatory (1..1) | Optional (0..N) | 1:N | No | No | An Enterprise Entity may have multiple External Identifiers. |
| CAR-011 | Audit Session | Audit Event | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Audit Events belong to one Audit Session. |
| CAR-012 | Aggregate Root | Audit Event | Mandatory (1..1) | Optional (0..N) | 1:N | No | No | Aggregate Roots may be referenced by Audit Events. |
| CAR-013 | Configuration Group | Configuration Item | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Configuration Items belong to one Configuration Group. |
| CAR-014 | Report Definition | Report Snapshot | Mandatory (1..1) | Mandatory (1..N) | 1:N | Yes | Yes | Report Snapshots are generated from one Report Definition. |
| CAR-015 | Enterprise Aggregate | Report Snapshot | Mandatory (1..1) | Optional (0..N) | 1:N (Logical Reference) | No | No | Report Snapshots may reference multiple enterprise Aggregates for analytical purposes. |

---

# 5. Participation Rules

Participation specifies whether an entity is required to participate in a business relationship.

| Participation Type | Description |
|--------------------|-------------|
| Mandatory | Participation is required to satisfy business rules. |
| Optional | Participation is permitted but not required. |

### Participation Principles

| Rule ID | Rule |
|----------|------|
| PAR-001 | Parent participation shall always be explicitly defined. |
| PAR-002 | Child participation shall always be explicitly defined. |
| PAR-003 | Mandatory participation shall be justified by business semantics. |
| PAR-004 | Optional participation shall not violate business invariants. |

---

# 6. Lifecycle Dependency Rules

Lifecycle dependency specifies whether the child entity can exist independently of its parent.

| Dependency | Description |
|------------|-------------|
| Yes | The child entity cannot exist without its parent entity. |
| No | The child entity maintains an independent lifecycle after creation. |

### Lifecycle Principles

| Rule ID | Rule |
|----------|------|
| LIF-001 | Lifecycle dependency shall be evaluated independently from cardinality. |
| LIF-002 | Lifecycle dependency shall follow Aggregate ownership rules. |
| LIF-003 | Child entities shall not outlive their owning Aggregate when dependency exists. |
| LIF-004 | Lifecycle rules shall remain consistent with the Aggregate Catalog. |

---

# 7. Identifying Relationship Rules

An identifying relationship exists when the business identity of a child entity depends wholly or partially upon its parent entity.

Typical identifying relationships within the Phoenix Platform include:

| Parent Entity | Child Entity | Reason |
|---------------|--------------|--------|
| Instrument Listing | Daily Market Data | Daily Market Data cannot exist independently of its Listing. |
| Audit Session | Audit Event | Audit Events derive their execution context from an Audit Session. |
| Configuration Group | Configuration Item | Configuration Items exist within a Configuration Group. |
| Report Definition | Report Snapshot | Report Snapshots are generated from a Report Definition. |

Identifying relationships shall always preserve Aggregate integrity and shall never violate approved Aggregate boundaries.

---

# 8. Validation Rules

The following validation rules shall be applied during logical model verification and Enterprise ERD generation.

| Rule ID | Validation Rule |
|----------|-----------------|
| VAL-001 | Every business relationship shall define an approved cardinality. |
| VAL-002 | Parent participation shall be explicitly specified. |
| VAL-003 | Child participation shall be explicitly specified. |
| VAL-004 | Lifecycle dependency shall be documented for every parent-child relationship. |
| VAL-005 | Identifying relationships shall be explicitly identified. |
| VAL-006 | Cardinality definitions shall remain consistent with the Enterprise Relationship Matrix. |
| VAL-007 | Cardinalities shall not violate Aggregate boundaries. |
| VAL-008 | Cross-domain relationships shall comply with the Domain Dependency Matrix. |
| VAL-009 | Business constraints shall remain consistent with the Business Constraint Matrix. |
| VAL-010 | Circular ownership relationships shall not exist. |

---

# 9. Traceability

Every cardinality definition shall remain traceable to its authoritative architectural source.

| Target Artifact | Traceability Purpose |
|-----------------|----------------------|
| Enterprise Relationship Catalog | Business relationship semantics |
| Enterprise Relationship Matrix | Relationship ownership and navigation |
| Canonical Entity Definitions | Entity ownership and classification |
| Aggregate Catalog | Aggregate boundaries |
| Aggregate Dependency Matrix | Aggregate dependency validation |
| Domain Dependency Matrix | Cross-domain validation |
| Business Constraint Matrix | Business rule validation |
| Canonical Enterprise ERD | Logical graphical representation |

---

# 10. Deliverables

Successful completion of the Cardinality Matrix authorizes the production of the following Enterprise Architecture artifacts:

- Aggregate Dependency Matrix
- Business Constraint Matrix
- Aggregate Boundary Validation
- Canonical Enterprise ERD
- Logical Data Model
- Physical Database Design Baseline

---

# 11. Architectural Governance

The Cardinality Matrix is a governed Enterprise Architecture artifact.

Any modification affecting:

- Relationship cardinality
- Mandatory participation
- Optional participation
- Lifecycle dependency
- Identifying relationships
- Aggregate ownership
- Domain ownership

shall require:

- Enterprise Architecture Review
- Impact Analysis
- Architecture Board Approval
- Repository Baseline Update (where applicable)

---

# 12. Approval

The Enterprise Architecture Board confirms that the relationship cardinalities defined in this specification accurately represent the approved business semantics of the Phoenix Platform.

**Approval Status**

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Cardinality Matrix specification. |
| 2026.2 | 2026-07-19 | Repository-standard revision aligned with the Enterprise Data Architecture framework, including standardized metadata, governance, traceability, validation rules, and architectural approval workflow. |