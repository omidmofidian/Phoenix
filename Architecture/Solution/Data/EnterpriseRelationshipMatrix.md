# Enterprise Relationship Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-001 |
| Document | EnterpriseRelationshipMatrix |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalEntityDefinitions, EnterpriseRelationshipCatalog, AggregateCatalog, CanonicalDomainModel |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical logical relationships among all enterprise entities within the Phoenix Platform.

It serves as the authoritative reference for relationship ownership, cardinality, navigation, aggregate boundaries and cross-domain interactions.

The matrix is technology independent and forms the primary input for the Canonical ERD and subsequent physical database design.

---

# 2. Enterprise Relationship Matrix

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

---

# 3. Relationship Type Definitions

| Type | Description |
|------|-------------|
| Composition | Strong ownership. Child lifecycle depends entirely on the Parent. |
| Aggregation | Weak ownership. Child may continue to exist independently. |
| Association | Logical business reference without ownership. |
| Dependency | Read-only consumption of information without structural ownership. |

---

# 4. Navigation Rules

Navigation defines the permitted logical traversal between related entities.

| Navigation | Meaning |
|------------|---------|
| Parent → Child | Parent may navigate to Child. |
| Child → Parent | Child references Parent only. |
| Bidirectional | Navigation is permitted in both directions. |

Navigation is a logical concept only and does not imply implementation details.

---

# 5. Ownership Rules

The following ownership principles govern enterprise relationships.

- Aggregate Roots own their Aggregate.
- Composition establishes lifecycle ownership.
- Aggregation establishes business ownership only.
- Association never transfers ownership.
- Dependencies are always read-only.
- Ownership is unique and unambiguous.

---

# 6. Aggregate Boundary Rules

| Boundary | Description |
|----------|-------------|
| Internal | Relationship remains inside a single Aggregate. |
| Cross Aggregate | Relationship crosses Aggregates within the same Domain. |
| Cross Domain | Relationship spans multiple Domains. |

---

# 7. Cross-Domain Interaction Summary

| Source Domain | Target Domain | Purpose |
|---------------|---------------|---------|
| Core | Reference | Business classification |
| Market | Reference | Trading structure |
| Market | Core | Tradable business assets |
| Integration | Reference | External mapping |
| Integration | Core | External mapping |
| Integration | Market | External mapping |
| Audit | All Domains | Traceability |
| Configuration | All Domains | Runtime configuration |
| Reporting | All Domains | Read-only analytical reporting |

---

# 8. Validation Rules

The following rules shall always hold.

- Every relationship shall have a defined business meaning.
- Every relationship shall specify its type.
- Every relationship shall define cardinality.
- Every relationship shall define navigation.
- Every relationship shall define ownership.
- Every relationship shall identify its Aggregate Boundary.
- Cross-domain references shall terminate only at Aggregate Roots.
- Circular ownership is prohibited.
- Relationships shall remain implementation independent.

---

# 9. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalEntityDefinitions | Entity ownership |
| EnterpriseRelationshipCatalog | Semantic relationships |
| AggregateCatalog | Aggregate ownership |
| CardinalityMatrix | Cardinality validation |
| BusinessConstraintMatrix | Constraint validation |
| DomainDependencyMatrix | Domain dependencies |
| AggregateDependencyMatrix | Aggregate dependencies |
| CanonicalBusinessRules | Business semantics |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version |
| 2026.2 | 2026-07-09 | Added navigation model and refined enterprise relationship semantics |