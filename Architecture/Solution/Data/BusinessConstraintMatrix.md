# Business Constraint Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-005 |
| Document | BusinessConstraintMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | EnterpriseRelationshipMatrix, CardinalityMatrix, AggregateDependencyMatrix, DomainDependencyMatrix, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical business constraints governing enterprise entities and relationships within the Phoenix Platform.

Business constraints express enterprise rules independently of any database management system, programming language or implementation technology.

This document serves as the authoritative source for logical validation and business integrity.

---

# 2. Constraint Categories

| Category | Description |
|----------|-------------|
| Entity Constraint | Rules governing a single entity. |
| Relationship Constraint | Rules governing relationships between entities. |
| Aggregate Constraint | Rules enforced within an Aggregate boundary. |
| Domain Constraint | Rules governing interactions between Domains. |
| Lifecycle Constraint | Rules controlling entity lifecycle. |
| Identity Constraint | Rules governing identifiers and uniqueness. |

---

# 3. Business Constraint Matrix

| ID | Category | Scope | Constraint | Severity | Related Artifact |
|----|----------|-------|------------|----------|------------------|
| BC-001 | Entity | Exchange | Exchange Code shall be unique. | Critical | EntityDictionary |
| BC-002 | Entity | Trading Board | Every Trading Board shall belong to exactly one Exchange. | Critical | CardinalityMatrix |
| BC-003 | Entity | Sector | Sector Code shall be unique. | Critical | EntityDictionary |
| BC-004 | Entity | Industry | Every Industry shall belong to one Sector. | Critical | EnterpriseRelationshipMatrix |
| BC-005 | Entity | Company | Company National Identifier shall be unique where applicable. | High | CanonicalEntityDefinitions |
| BC-006 | Entity | Instrument | Every Instrument shall belong to one Company. | Critical | CardinalityMatrix |
| BC-007 | Entity | Instrument Listing | Every Listing shall reference one Instrument and one Trading Board. | Critical | AggregateDependencyMatrix |
| BC-008 | Entity | Daily Market Data | Market Data shall not exist without an Instrument Listing. | Critical | AggregateDependencyMatrix |
| BC-009 | Entity | Trading Calendar | Trading Date shall be unique within a Market. | High | CanonicalBusinessRules |
| BC-010 | Entity | Corporate Action | Corporate Action shall reference one Instrument. | High | EnterpriseRelationshipMatrix |
| BC-011 | Identity | External Identifier | External Identifier shall be unique per Provider and Entity Type. | Critical | IdentifierStrategy |
| BC-012 | Identity | Enterprise Entity | Public Identifier shall never change during entity lifetime. | Critical | EnterpriseIdentityStandard |
| BC-013 | Aggregate | Aggregate Root | External references shall target Aggregate Roots only. | Critical | AggregateCatalog |
| BC-014 | Domain | Reference Domain | Reference Domain shall remain independent. | Critical | DomainDependencyMatrix |
| BC-015 | Domain | Reporting Domain | Reporting shall remain read-only. | Critical | DomainDependencyMatrix |
| BC-016 | Domain | Audit Domain | Audit shall never modify business entities. | Critical | ADR-023 |
| BC-017 | Lifecycle | Configuration Item | Configuration shall exist within a Configuration Group. | High | AggregateDependencyMatrix |
| BC-018 | Lifecycle | Report Snapshot | Snapshot shall belong to one Report Definition. | High | AggregateDependencyMatrix |
| BC-019 | Lifecycle | Audit Event | Audit Event shall belong to one Audit Session. | Critical | AggregateDependencyMatrix |
| BC-020 | Relationship | Enterprise | Circular ownership shall never exist. | Critical | EnterpriseRelationshipMatrix |

---

# 4. Severity Levels

| Level | Description |
|------|-------------|
| Critical | Violation compromises enterprise consistency. |
| High | Violation significantly impacts business correctness. |
| Medium | Violation affects data quality but not structural integrity. |
| Low | Recommendation or governance guidance. |

---

# 5. Validation Principles

The following principles apply.

- Every business constraint shall be traceable.
- Business constraints shall be implementation independent.
- Constraints shall originate from business semantics.
- Constraints shall be validated before physical implementation.
- No constraint shall contradict the Canonical Business Rules.

---

# 6. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalBusinessRules | Source of business semantics |
| EnterpriseRelationshipMatrix | Relationship validation |
| CardinalityMatrix | Participation validation |
| AggregateDependencyMatrix | Aggregate integrity |
| DomainDependencyMatrix | Domain governance |
| CanonicalEntityDefinitions | Entity semantics |
| IdentifierStrategy | Identity constraints |

---

# 7. Future Implementation Mapping

During Sprint 4 and subsequent implementation phases, these logical business constraints may be realized through:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints
- Domain Constraints
- Application Validation
- Service-Level Validation
- Business Rule Engines

The logical definition contained in this document shall always remain the authoritative source.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Business Constraint Matrix |