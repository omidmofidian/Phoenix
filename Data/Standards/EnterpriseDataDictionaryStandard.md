# Enterprise Data Dictionary Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-006 |
| Document | EnterpriseDataDictionaryStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Epic | Enterprise Data Dictionary |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical standard for creating and maintaining the Enterprise Data Dictionary of the Phoenix Platform.

Its objective is to establish a uniform structure for documenting business entities, attributes, relationships, and metadata across all domains.

The Enterprise Data Dictionary serves as the authoritative source of business information for logical and physical database design.

---

# 2. Scope

This standard applies to:

- Business Glossary
- Entity Definitions
- Attribute Definitions
- Logical Data Model
- Physical Data Model
- Database Documentation
- API Documentation
- Reporting Metadata
- Machine Learning Metadata

All future Data Dictionary documents shall comply with this standard.

---

# 3. Principles

The Enterprise Data Dictionary shall be:

- Business-oriented
- Technology-independent
- Canonical
- Consistent
- Traceable
- Extensible
- Maintainable

Business meaning shall always take precedence over implementation details.

---

# 4. Data Dictionary Structure

The Enterprise Data Dictionary is organized into the following sections.

```
Business Glossary
        ↓
Entity Catalog
        ↓
Entity Definitions
        ↓
Attribute Definitions
        ↓
Relationship Definitions
        ↓
Domain Mapping
        ↓
Validation Rules
```

Each section builds upon the previous one and shall remain internally consistent.

---

# 5. Entity Definition Standard

Each business entity shall include the following information.

| Property | Description |
|----------|-------------|
| Entity Name | Canonical business name |
| Domain | Owning business domain |
| Description | Business purpose |
| Business Owner | Responsible domain |
| Aggregate | Aggregate Root (if applicable) |
| Primary Identifier | Canonical identifier |
| Lifecycle | Entity lifecycle |
| Related Entities | Direct relationships |

---

# 6. Attribute Definition Standard

Each attribute shall contain the following metadata.

| Property | Description |
|----------|-------------|
| Attribute Name | Canonical attribute name |
| Description | Business meaning |
| Data Type | Canonical data type |
| Nullable | Yes / No |
| Default Value | Business default |
| Business Rule | Associated rule(s) |
| Example | Sample value |
| Source | Origin of the information |

Attributes shall describe business semantics rather than storage implementation.

---

# 7. Relationship Definition Standard

Every relationship shall document:

- Source Entity
- Target Entity
- Relationship Type
- Cardinality
- Optionality
- Business Meaning
- Ownership

Relationships shall be documented independently of physical foreign keys.

---

# 8. Business Glossary Standard

Business terms shall include:

| Property | Description |
|----------|-------------|
| Term | Canonical business term |
| Definition | Business definition |
| Synonyms | Approved alternative terms |
| Domain | Responsible domain |
| Related Terms | Associated concepts |

A business term shall have exactly one canonical definition.

---

# 9. Domain Organization

The Enterprise Data Dictionary shall be organized according to the approved bounded contexts.

Current domains include:

- Reference
- Core
- Market
- Integration
- Configuration
- Audit
- Reporting

Future domains shall follow the same documentation structure.

---

# 10. Traceability

Every documented entity and attribute shall be traceable to:

- Business Capability
- Bounded Context
- Domain Model
- Business Rules
- Logical Model
- Physical Model

This ensures complete architectural traceability throughout the platform.

---

# 11. Naming Compliance

All entities and attributes shall comply with:

- EnterpriseNamingStandard.md
- EnterpriseDataTypeStandard.md
- BaseEntityStandard.md
- AuditModelStandard.md
- IdentifierStrategy.md

No Data Dictionary entry shall violate approved enterprise standards.

---

# 12. Versioning

The Enterprise Data Dictionary shall evolve incrementally.

Each revision shall:

- Preserve backward traceability.
- Record all structural changes.
- Maintain revision history.
- Avoid breaking approved business definitions.

---

# 13. Compliance

Compliance with this standard is mandatory.

All Entity Dictionary, Attribute Dictionary, Business Glossary, and Relationship documents shall follow the structure defined herein.

Any deviation shall require approval through the Architecture Governance process.

---

# 14. Related Documents

- EnterpriseNamingStandard.md
- EnterpriseDataTypeStandard.md
- BaseEntityStandard.md
- AuditModelStandard.md
- IdentifierStrategy.md
- CanonicalDomainModel.md
- EntityCatalog.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Data Dictionary Standard. |