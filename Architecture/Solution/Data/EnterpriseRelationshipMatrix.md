# Enterprise Relationship Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-001 |
| Document | EnterpriseRelationshipMatrix |
| Version | 2026.3 |
| Status | Approved |
| Classification | Enterprise Data Architecture |
| Architecture Layer | Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalEntityDefinitions, EnterpriseRelationshipCatalog, AggregateCatalog, CanonicalDomainModel, CardinalityMatrix |
| Consumed By | CanonicalEnterpriseERD, LogicalDatabaseModel, PhysicalDatabaseModel |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

This document defines the canonical logical relationships between enterprise entities within the Phoenix Platform.

The Enterprise Relationship Matrix establishes the authoritative specification for relationship ownership, navigation, cardinality, aggregate boundaries and cross-domain interactions throughout the Enterprise Data Architecture.

Its primary objective is to provide a consistent, implementation-independent representation of enterprise relationships that supports conceptual modeling, logical database design and Enterprise ERD development.

The matrix complements the Enterprise Relationship Catalog by providing the formal structural characteristics of each approved business relationship.

This specification serves as the authoritative source for:

- relationship ownership;
- relationship direction;
- relationship cardinality;
- navigation semantics;
- aggregate boundaries;
- cross-domain interactions;
- enterprise relationship validation.

The Enterprise Relationship Matrix is technology independent and intentionally excludes implementation-specific concepts such as foreign keys, database constraints, indexes and persistence mechanisms.

---

# 2. Scope

This specification governs every approved logical relationship within the Enterprise Data Architecture of the Phoenix Platform.

It applies to relationships defined across the following enterprise domains:

- Reference Domain
- Core Domain
- Market Domain
- Integration Domain
- Configuration Domain
- Audit Domain
- Reporting Domain

The scope of this document includes:

- Relationship ownership
- Relationship navigation
- Relationship cardinality
- Aggregate boundaries
- Cross-domain relationships
- Mandatory participation
- Logical dependency validation

The following implementation concerns are explicitly outside the scope of this specification:

- Physical database relationships
- Foreign key implementation
- SQL constraints
- Database indexes
- ORM mappings
- API contracts
- Event choreography
- Infrastructure dependencies

---

# 3. Enterprise Relationship Matrix

The following matrix defines the canonical logical relationships between enterprise entities.

| ID | Parent Entity | Child Entity | Relationship Type | Cardinality | Navigation | Ownership | Aggregate Boundary | Cross Domain | Mandatory |
|----|---------------|--------------|-------------------|-------------|------------|-----------|--------------------|--------------|-----------|
| REL-001 | Exchange | Trading Board | Composition | 1:N | Parent → Child | Exchange | Internal | No | Yes |
| REL-002 | Sector | Industry | Aggregation | 1:N | Parent → Child | Sector | Internal | No | Yes |
| REL-003 | Company | Instrument | Aggregation | 1:N | Parent → Child | Company | Cross Aggregate | No | Yes |
| REL-004 | Instrument | Instrument Listing | Association | 1:N | Bidirectional | Instrument Listing | Cross Domain | Yes | Yes |
| REL-005 | Trading Board | Instrument Listing | Association | 1:N | Bidirectional | Instrument Listing | Cross Domain | Yes | Yes |
| REL-006 | Instrument Listing | Daily Market Data | Composition | 1:N | Parent → Child | Instrument Listing | Internal | No | Yes |
| REL-007 | Trading Calendar | Daily Market Data | Association | 1:N | Parent → Child | Daily Market Data | Cross Domain | Yes | Yes |
| REL-008 | Instrument | Corporate Action | Association | 1:N | Parent → Child | Corporate Action | Cross Domain | Yes | No |
| REL-009 | Data Provider | External Identifier | Composition | 1:N | Parent → Child | Data Provider | Internal | No | Yes |
| REL-010 | External Identifier | Enterprise Entity | Association | N:1 | Bidirectional | External Identifier | Cross Domain | Yes | Yes |
| REL-011 | Audit Session | Audit Event | Composition | 1:N | Parent → Child | Audit Session | Internal | No | Yes |
| REL-012 | Audit Event | Aggregate Root | Association | N:1 | Child → Parent | Audit Event | Cross Domain | Yes | Yes |
| REL-013 | Configuration Group | Configuration Item | Composition | 1:N | Parent → Child | Configuration Group | Internal | No | Yes |
| REL-014 | Report Definition | Report Snapshot | Composition | 1:N | Parent → Child | Report Definition | Internal | No | Yes |
| REL-015 | Report Snapshot | Enterprise Domains | Dependency | N:N | Child → Parent | None | Cross Domain | Yes | Yes |

The Enterprise Relationship Matrix defines logical architecture only and shall remain consistent with the Enterprise Relationship Catalog and the Cardinality Matrix.

---

# 4. Relationship Type Definitions

Enterprise relationships are classified according to their business semantics and ownership characteristics.

| Relationship Type | Description |
|-------------------|-------------|
| Composition | Strong ownership relationship where the child entity depends entirely on the lifecycle of the parent entity. |
| Aggregation | Weak ownership relationship where the child entity has an independent lifecycle while maintaining a business association with the parent. |
| Association | Logical business reference between independent entities without ownership transfer. |
| Dependency | Read-only relationship used for information consumption without ownership or lifecycle dependency. |

Relationship classifications are defined at the Enterprise Architecture level and remain independent of implementation technologies.

---

# 5. Navigation Rules

Navigation defines the permitted logical traversal between related enterprise entities.

| Navigation | Meaning |
|------------|---------|
| Parent → Child | Navigation is permitted from the parent entity to its child entity. |
| Child → Parent | Navigation is permitted from the child entity to its parent entity. |
| Bidirectional | Navigation is permitted in both directions. |

The following navigation principles apply:

- Navigation represents logical business access only.
- Navigation does not imply physical implementation.
- Navigation does not imply foreign key direction.
- Navigation shall remain consistent across all Enterprise Architecture artifacts.

---

# 6. Ownership Rules

Enterprise relationship ownership is governed by the following architectural principles.

- Aggregate Roots own their Aggregates.
- Composition establishes lifecycle ownership.
- Aggregation establishes business ownership without lifecycle dependency.
- Association never transfers ownership.
- Dependencies are always read-only.
- Business ownership shall always remain unique.
- Ownership shall never cross Aggregate boundaries through Composition.
- Ownership shall remain consistent with the Aggregate Catalog.

---

# 7. Aggregate Boundary Rules

Aggregate boundaries define the architectural scope of enterprise relationships.

| Boundary Type | Description |
|---------------|-------------|
| Internal | Relationship remains entirely within a single Aggregate. |
| Cross Aggregate | Relationship spans multiple Aggregates within the same Domain. |
| Cross Domain | Relationship spans Aggregates belonging to different Domains. |

The following architectural rules apply:

- Aggregate boundaries shall preserve business ownership.
- Aggregate boundaries shall remain stable across architectural revisions.
- Cross-Aggregate relationships shall reference Aggregate Roots only.
- Cross-Domain relationships shall preserve Domain ownership.

---

# 8. Cross-Domain Interaction Summary

The following matrix summarizes approved interactions between enterprise domains.

| Source Domain | Target Domain | Business Purpose |
|---------------|---------------|------------------|
| Core | Reference | Business classification |
| Market | Reference | Trading structure |
| Market | Core | Tradable business assets |
| Integration | Reference | External reference mapping |
| Integration | Core | External business identity mapping |
| Integration | Market | External market data integration |
| Configuration | Operational Domains | Enterprise runtime configuration |
| Audit | Operational Domains | Business traceability and compliance |
| Reporting | All Domains | Enterprise reporting and analytical presentation |

Cross-domain interactions shall preserve Domain ownership and shall never transfer business responsibility between Domains.

---

# 9. Validation Rules

The following validation rules shall always hold throughout the Enterprise Relationship Matrix.

- Every relationship shall define a valid business meaning.
- Every relationship shall specify its relationship type.
- Every relationship shall define cardinality.
- Every relationship shall define navigation semantics.
- Every relationship shall define ownership.
- Every relationship shall specify its Aggregate Boundary.
- Cross-Domain relationships shall terminate at Aggregate Roots.
- Circular ownership relationships are prohibited.
- Relationship ownership shall remain unique.
- Relationship definitions shall remain consistent with the Enterprise Relationship Catalog.
- Cardinality definitions shall remain consistent with the Cardinality Matrix.
- Relationship semantics shall remain implementation independent.

---

# 10. Traceability

The Enterprise Relationship Matrix is fully traceable to the authoritative Enterprise Architecture artifacts of the Phoenix Platform.

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| CanonicalDomainModel | Domain ownership and business boundaries |
| CanonicalEntityDefinitions | Enterprise entity definitions |
| AggregateCatalog | Aggregate ownership and responsibilities |
| EnterpriseRelationshipCatalog | Business relationship semantics |
| CardinalityMatrix | Relationship multiplicity and participation |
| AggregateDependencyMatrix | Aggregate dependency validation |
| DomainDependencyMatrix | Domain dependency validation |
| BusinessConstraintMatrix | Business constraint verification |
| ConceptualDatabaseModel | Conceptual relationship validation |
| CanonicalEnterpriseERD | Graphical representation of enterprise relationships |
| LogicalDatabaseModel | Logical realization of enterprise relationships |
| PhysicalDatabaseModel | Physical realization of enterprise relationships |

This traceability ensures that every relationship defined in this matrix remains consistent across all Enterprise Data Architecture artifacts.

---

# 11. Related Artifacts

This document shall be used together with the following Enterprise Architecture specifications:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- CanonicalDomainModel
- CanonicalBusinessRules
- CanonicalEntityDefinitions
- AggregateCatalog
- EnterpriseRelationshipCatalog
- CardinalityMatrix
- AggregateDependencyMatrix
- DomainDependencyMatrix
- BusinessConstraintMatrix
- ConceptualDatabaseModel
- CanonicalEnterpriseERD
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseDataDictionary

---

# 12. Architectural Governance

The Enterprise Relationship Matrix is a controlled Enterprise Architecture artifact.

Any modification affecting:

- relationship ownership;
- relationship navigation;
- relationship cardinality;
- Aggregate boundaries;
- Cross-Domain relationships;
- business semantics;
- relationship classifications;
- enterprise consistency;

shall require:

- Enterprise Architecture Review;
- Business Impact Analysis;
- Architecture Board Approval;
- Repository Baseline Update (when applicable).

All approved relationship definitions contained in this document shall be considered canonical throughout the Phoenix Platform.

---

# 13. Approval

The Enterprise Architecture Board approves this Enterprise Relationship Matrix as the official specification for the logical relationships between enterprise entities within the Phoenix Platform.

This document establishes the canonical representation of enterprise relationship ownership, navigation, cardinality and aggregate boundaries and serves as the authoritative reference for Enterprise ERD development, Logical Database Modeling and Physical Database realization.

**Approval Status**

**APPROVED**

---

# 14. Revision History

| Version | Date | Description |
|----------|------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| 2026.1 | 2026-07-09 | Initial Enterprise Relationship Matrix. |
| 2026.2 | 2026-07-09 | Added navigation model and refined enterprise relationship semantics. |
| 2026.3 | 2026-07-19 | Complete repository-standard rewrite aligned with the Enterprise Architecture baseline. Added Scope, Related Artifacts, Architectural Governance and Approval sections. Standardized traceability, governance, validation rules and repository-wide architectural consistency. |