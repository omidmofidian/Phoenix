# =====================================================================
# External Identifier Data Dictionary
# =====================================================================

# Document Metadata

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DIC-015 |
| Document | External Identifier Data Dictionary |
| Entity | External Identifier |
| Schema | integration |
| Table | external_identifier |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Integration Data Dictionary |
| Owner | Enterprise Architecture Team |
| Domain | Integration |
| Bounded Context | Integration Management |
| Architecture Layer | Integration |
| Source of Truth | Phoenix Platform |
| Sprint | Sprint 4 |
| Epic | Physical Database Design |
| Last Updated | 2026-07-23 |

---

# 1. Purpose

The External Identifier entity provides the canonical mapping between Phoenix enterprise entities and identifiers assigned by external information providers.

Its purpose is to isolate external identification schemes from the enterprise business model, allowing Phoenix to integrate with multiple data providers while preserving a provider-independent canonical domain model.

External Identifier serves as the authoritative registry for external mappings used by import services, synchronization processes, API integrations, and data exchange mechanisms.

The entity ensures that provider-specific identifiers remain outside the business domain and never become part of the canonical identity of enterprise entities.

---

# 2. Scope

This dictionary defines the enterprise semantics of the External Identifier integration entity.

It applies to every service, connector, synchronization process, import pipeline, export pipeline, and external integration that exchanges identifiers between Phoenix and external systems.

This document governs:

- external identifier mappings;
- provider-specific identifiers;
- identifier lifecycle;
- identifier governance;
- integration semantics;
- mapping consistency;
- enterprise traceability.

This document does not define:

- business entities;
- market master data;
- trading data;
- provider communication protocols;
- API implementations;
- synchronization algorithms.

Those concerns are governed by their respective enterprise architecture artifacts.

---

# 3. Integration Definition

External Identifier is a canonical integration entity that associates one enterprise entity with one identifier assigned by one external information provider.

It exists solely to support interoperability between Phoenix and external systems.

External Identifier is not part of the enterprise business model and does not represent a business concept.

Instead, it represents an integration concern whose responsibility is maintaining stable, traceable, and governed mappings between enterprise identities and provider-specific identifiers.

The existence, modification, or removal of an External Identifier shall never alter the business meaning or enterprise identity of the associated entity.

External identifiers are implementation-facing artifacts and shall remain completely independent from enterprise business semantics.

---

# 4. Enterprise Identity

External Identifier is an integration artifact whose identity is derived from the relationship between an enterprise entity and an external information provider.

The canonical enterprise identity of an External Identifier is established by the combination of:

- External Provider
- Entity Type
- External Identifier

This identity uniquely identifies one mapping within the Phoenix Platform while remaining independent of the internal identity of the referenced enterprise entity.

The business identity of the referenced entity remains unchanged regardless of the existence or modification of external mappings.

---

# 5. Integration Responsibilities

The External Identifier entity is responsible for:

- maintaining mappings between enterprise entities and external identifiers;
- supporting interoperability with multiple external providers;
- preserving provider-independent enterprise identities;
- enabling synchronization between Phoenix and external systems;
- maintaining historical identifier mappings;
- supporting import and export processes;
- providing traceable identifier resolution across integration services.

The External Identifier entity shall not:

- represent business concepts;
- contain business attributes;
- replace enterprise primary keys;
- replace enterprise public identifiers;
- participate in business decision making;
- modify the lifecycle of business entities.

---

# 6. Integration Relationships

The External Identifier entity maintains logical associations with enterprise entities while remaining outside their aggregate boundaries.

| Related Entity | Relationship | Cardinality |
|---------------|--------------|-------------|
| Exchange | Association | 1:N |
| Trading Board | Association | 1:N |
| Sector | Association | 1:N |
| Industry | Association | 1:N |
| Company | Association | 1:N |
| Instrument | Association | 1:N |

Each enterprise entity may have multiple External Identifiers originating from different providers.

Each External Identifier shall reference exactly one enterprise entity.

External Identifier shall never own, aggregate, or compose any business entity.

---

# 7. Integration Lifecycle

The lifecycle of an External Identifier is independent of the lifecycle of the referenced enterprise entity.

An External Identifier may be:

- created when a provider mapping becomes available;
- superseded by a new identifier;
- deactivated when no longer valid;
- retained for historical traceability.

Historical mappings shall remain available for audit, synchronization, reconciliation, and historical integration purposes.

Physical deletion of External Identifier records shall be avoided except under formally approved governance procedures.

The lifecycle of an External Identifier shall never alter the lifecycle or business identity of the referenced enterprise entity.

---

# 8. Enterprise Attributes

The business semantics of every attribute are defined in the Enterprise Attribute Dictionary.

| Attribute | Business Meaning |
|----------|------------------|
| provider_name | External information provider responsible for the identifier |
| entity_type | Enterprise entity classification |
| entity_id | Internal identifier of the referenced enterprise entity |
| external_identifier | Provider-assigned identifier |
| is_primary | Preferred mapping for the provider |
| valid_from | Mapping validity start date |
| valid_to | Mapping validity end date |

Implementation details, physical data types, indexing strategies, storage mechanisms, and optimization rules are governed by the Physical Database Model and the Enterprise Attribute Standard.

---

# 9. Governance Rules

The External Identifier entity shall be governed according to the following enterprise principles.

## Identity Governance

The canonical identity of every enterprise entity shall remain independent of all external provider identifiers.

External identifiers shall serve exclusively as integration mappings and shall never become enterprise business identifiers.

---

## Mapping Governance

Each mapping shall reference exactly one enterprise entity.

An external identifier shall not simultaneously identify multiple enterprise entities for the same provider and entity type.

Mappings shall remain deterministic, traceable, and auditable throughout their lifecycle.

---

## Provider Independence

Enterprise services shall operate exclusively on canonical Phoenix identifiers.

Provider-specific identifiers shall be translated through the External Identifier entity before entering or leaving the business domain.

Business services shall never contain provider-specific identification logic.

---

## Lifecycle Governance

Historical mappings shall be preserved whenever required for reconciliation, synchronization, regulatory compliance, or audit purposes.

Expired mappings shall be marked through their validity period rather than being physically removed.

---

## Data Quality

Every mapping shall satisfy the following quality requirements:

- uniqueness;
- completeness;
- consistency;
- traceability;
- historical integrity;
- provider accountability.

---

# 10. Traceability

The External Identifier entity shall remain traceable across the enterprise architecture.

Its business semantics shall align with:

- Enterprise Business Glossary;
- Enterprise Entity Dictionary;
- Enterprise Attribute Dictionary;
- Canonical Integration Model;
- Logical Database Model;
- Physical Database Model;
- Service Context Map;
- Integration Architecture;
- Synchronization Architecture;
- Canonical Business Rules.

Every modification to identifier mappings shall remain fully auditable.

---

# 11. Compliance

Implementations of the External Identifier entity shall comply with:

- Enterprise Naming Standards;
- Enterprise Database Standards;
- Enterprise Integration Standards;
- Enterprise Security Standards;
- Enterprise Audit Standards;
- Enterprise Data Governance Principles.

No implementation may bypass the canonical mapping mechanism defined by this entity.

Provider-specific identifiers shall never be embedded directly within enterprise business entities.

---

# 12. Related Documents

- BusinessGlossary.md
- EntityDictionary.md
- AttributeDictionary.md
- RelationshipDictionary.md
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- IntegrationArchitecture.md
- SynchronizationArchitecture.md
- ServiceContextMap.md
- CanonicalBusinessRules.md
- ADR-016 — Public Identifier Strategy
- ADR-017 — External Identifier Strategy

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-06-29 | Initial Architecture Freeze version |
| 2026.2 | 2026-07-23 | Refactored as Enterprise Integration Data Dictionary following Enterprise Data Dictionary standards. |

---
# 13. Physical Database Design Readiness

The External Identifier entity has successfully completed the Enterprise Data Dictionary phase and is approved for transition into the Physical Database Design phase.

The physical implementation shall preserve the enterprise semantics defined in this document while applying database-specific optimization techniques appropriate for PostgreSQL.

The following design activities shall be addressed during the Physical Database Design phase:

## Physical Table Definition

- PostgreSQL data types
- Column ordering
- Default values
- Generated values
- NULL constraints

## Primary and Alternate Keys

- Primary Key definition
- Business Key implementation
- Public Identifier implementation
- Unique constraint strategy

## Referential Integrity

- Foreign key implementation where applicable
- Referential actions
- Constraint naming standards

## Physical Constraints

- CHECK constraints
- NOT NULL constraints
- Domain validation
- Temporal validation for validity periods

## Performance Optimization

- Index strategy
- Composite indexes
- Lookup indexes
- Provider-based search optimization

## Operational Characteristics

- Audit columns
- Soft delete policy
- Historical record preservation
- Storage considerations

## Security Considerations

- Access control
- Data ownership
- Integration service permissions
- Auditability

The resulting physical implementation shall remain fully consistent with:

- Conceptual Data Model
- Logical Database Model
- Enterprise Data Dictionary
- Enterprise Database Standards
- Enterprise Naming Standards

No physical optimization shall alter the approved business or integration semantics defined by this document.

---
# 14. Approval

| Role | Responsibility | Status |
|------|----------------|--------|
| Enterprise Architect | Business and Integration Semantics | Approved |
| Data Architect | Logical Data Model | Approved |
| Database Architect | Physical Database Design | Pending |
| Solution Architect | Architecture Compliance | Approved |

The External Identifier entity is approved for implementation during the Physical Database Design phase of the Phoenix Platform.