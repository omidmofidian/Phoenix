# Enterprise Data Type Standard

---

# Document Information

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-002 |
| Document | EnterpriseDataTypeStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Standard |
| Capability | Data |
| Owner | Enterprise Data Architecture Team |
| Repository Path | Data/Standards/EnterpriseDataTypeStandard.md |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

This standard defines the enterprise-wide architecture for business data types within the Phoenix Platform.

Its purpose is to establish a consistent, technology-independent framework for representing business information across all enterprise domains while preserving semantic integrity, interoperability, and long-term maintainability.

Business data types describe the nature of enterprise information rather than its physical implementation.

Logical data types are defined independently of any database technology and are subsequently mapped to platform-specific implementations through approved engineering standards.

This standard governs enterprise data type architecture only.

Database-specific implementations, storage optimizations, and vendor-specific mappings are addressed during the physical database design and implementation phases.

---

# 2. Scope

This standard applies to every logical business data type defined within the Enterprise Data capability.

Its scope includes:

- Enterprise Information Models
- Conceptual Data Models
- Logical Data Models
- Enterprise Business Attributes
- Enterprise Data Dictionary
- Database Design
- Service Contracts
- Integration Models
- Reporting Models
- Analytics Models
- Machine Learning Metadata

This standard establishes the logical representation of business information regardless of implementation technology.

The following subjects are outside the scope of this document:

- Database storage optimization
- Vendor-specific SQL syntax
- Physical column definitions
- Database indexing
- Partitioning
- Storage engines
- Programming language data types
- ORM mappings

These implementation concerns are governed by the Enterprise Database Design Standard and subsequent implementation artifacts.

---

# 3. Objectives

The Enterprise Data Type Standard has the following objectives:

- establish a canonical enterprise data type architecture;
- ensure semantic consistency across all business domains;
- define technology-independent logical data types;
- support interoperability between enterprise services;
- minimize implementation-specific dependencies;
- provide a consistent mapping strategy toward physical implementations;
- improve maintainability of enterprise information models;
- preserve long-term portability across technology platforms.

---

# 4. Enterprise Data Type Philosophy

Within the Phoenix Platform, data types represent the semantic characteristics of business information rather than implementation mechanisms.

Business meaning shall always determine the logical data type.

Implementation technology shall never determine business semantics.

The information modeling sequence is therefore:

```text
Business Concept
        │
        ▼
Business Attribute
        │
        ▼
Logical Data Type
        │
        ▼
Physical Data Type
        │
        ▼
Database Implementation
```

Logical data types remain stable throughout the enterprise architecture, while physical mappings may evolve as implementation technologies change.

---

# 5. Position within Enterprise Data Architecture

The Enterprise Data Type Standard occupies the logical information layer of the Enterprise Data Architecture.

```text
Enterprise Architecture
            │
            ▼
Enterprise Business Attributes
            │
            ▼
Logical Data Types
            │
            ▼
Logical Data Model
            │
            ▼
Physical Database Model
            │
            ▼
Database Engineering
```

Logical data types provide the semantic bridge between business information and implementation-specific representations.

Every physical implementation shall preserve the business semantics defined by the logical data type architecture.

---

# 6. Enterprise Data Type Architecture

The Enterprise Data Type Architecture defines the canonical classification of business information within the Phoenix Platform.

Each logical data type represents a specific category of business information and shall maintain a single semantic meaning throughout the platform.

Logical data types provide the foundation for enterprise information modeling and shall remain independent of database vendors, programming languages, and implementation technologies.

---

# 7. Enterprise Data Type Principles

The following principles govern the definition and use of enterprise data types.

## Principle 1 — Business Semantics First

Business meaning shall always determine the logical data type.

Implementation technology shall never influence semantic classification.

---

## Principle 2 — Technology Independence

Logical data types shall remain independent of databases, programming languages, serialization formats, and infrastructure technologies.

---

## Principle 3 — Consistency

The same business information shall always use the same logical data type throughout the enterprise.

Different logical types shall never represent identical business semantics.

---

## Principle 4 — Reusability

Logical data types are enterprise assets.

Approved data types shall be reused across all business domains whenever applicable.

---

## Principle 5 — Traceability

Every logical data type shall remain traceable to the business attributes that use it and to the physical implementations that realize it.

---

## Principle 6 — Portability

Logical data types shall support future migration to different technologies without requiring changes to enterprise business semantics.

---

# 8. Enterprise Data Type Taxonomy

Every logical data type shall belong to one primary enterprise category.

| Category | Purpose |
|----------|---------|
| Identifier | Enterprise identity |
| Reference | References to enterprise business objects |
| Numeric | General numeric values |
| Monetary | Financial amounts |
| Percentage | Ratios and percentages |
| Quantity | Counts and measurable values |
| Boolean | Binary business states |
| Text | Human-readable business information |
| Enumeration | Controlled business vocabularies |
| Date | Calendar-based business dates |
| Time | Business time values |
| Timestamp | Business events in time |
| Duration | Time intervals |
| Binary | Binary business content |
| Structured | Structured business documents |

Each logical data type shall belong to exactly one category.

---

# 9. Logical Data Type Categories

## Identifier Types

Identifier types uniquely identify enterprise business objects.

Typical examples include:

- Entity Identifier
- Business Identifier
- External Identifier
- Public Identifier

Identity management is governed by the **Identifier Strategy (DST-005)**.

---

## Reference Types

Reference types express logical relationships between enterprise business objects.

References represent business associations rather than implementation-specific foreign keys.

---

## Numeric Types

Numeric types represent measurable business values.

Examples include:

- Counters
- Measurements
- Scores
- Statistical Values

Precision requirements shall be determined by business semantics.

---

## Monetary Types

Monetary types represent financial values.

Financial precision shall be preserved throughout the entire engineering lifecycle.

Loss of financial precision is prohibited.

---

## Percentage Types

Percentage types represent proportional business values.

Business semantics shall define acceptable precision.

---

## Quantity Types

Quantity types represent measurable business quantities.

Examples include:

- Trading Volume
- Inventory Quantity
- Share Count
- Transaction Quantity

---

## Boolean Types

Boolean types represent binary business conditions.

They shall express only two logical states.

Business processes requiring multiple states shall use controlled business classifications instead.

---

## Text Types

Text types represent human-readable business information.

Typical examples include:

- Business Names
- Descriptions
- Notes
- Comments
- External References

Length limitations shall be defined by business requirements rather than implementation constraints.

---

## Enumeration Types

Enumeration types represent controlled business vocabularies.

Enterprise enumerations shall remain centrally governed and documented within the Enterprise Data Dictionary.

Business-critical enumerations may evolve into enterprise reference data when appropriate.

---

## Temporal Types

Temporal types represent business time.

They include:

- Business Dates
- Event Timestamps
- Time Values
- Validity Periods
- Durations

Temporal semantics remain independent of physical timestamp implementation.

---

## Structured Types

Structured types represent flexible business information composed of multiple related elements.

These types are intended for metadata, extensible business content, and externally supplied structured information.

Core enterprise business concepts shall continue to be modeled explicitly within the logical data model rather than embedded within structured documents.

---

# 10. Mapping Strategy

Logical data types shall be transformed into implementation-specific physical types during physical database design.

The transformation process follows the approved engineering lifecycle.

```text
Logical Data Type
        │
        ▼
Physical Data Type
        │
        ▼
Database Vendor Mapping
        │
        ▼
Implementation Artifact
```

The logical data type shall remain the authoritative definition.

Physical implementations may evolve over time provided that business semantics remain unchanged.

---

# 11. Relationship with Enterprise Data Standards

The Enterprise Data Type Standard is an integral component of the Enterprise Data Standards framework.

It defines the logical representation of enterprise information while delegating specialized concerns to the corresponding Enterprise Data Standards.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Canonical naming conventions |
| DST-002 — Enterprise Data Type Standard | Enterprise logical data types |
| DST-003 — Base Entity Standard | Common enterprise entity structure |
| DST-004 — Audit Model Standard | Enterprise audit metadata |
| DST-005 — Identifier Strategy | Enterprise identity management |
| DST-006 — Enterprise Data Dictionary Standard | Enterprise business metadata governance |
| DST-007 — Enterprise Database Design Standard | Database engineering framework |
| DST-008 — Enterprise Business Attribute Standard | Business attribute architecture |

Together, these standards establish a unified and technology-independent Enterprise Data Architecture.

---

# 12. Physical Mapping Guidelines

Logical data types shall be mapped to physical implementations during database engineering.

The approved physical mappings are maintained separately to preserve the technology independence of this standard.

For the current implementation of the Phoenix Platform, the canonical PostgreSQL mappings are defined within the Enterprise Database Design Standard and the Physical Database Model.

Typical implementation mappings include:

| Logical Type | Typical PostgreSQL Mapping |
|--------------|----------------------------|
| Identifier | UUID |
| Monetary | NUMERIC |
| Percentage | NUMERIC |
| Quantity | NUMERIC |
| Text | VARCHAR / TEXT |
| Boolean | BOOLEAN |
| Date | DATE |
| Timestamp | TIMESTAMP WITH TIME ZONE |
| Structured | JSONB |

These mappings represent the current implementation baseline and may evolve as supported technologies change.

The logical meaning of enterprise data shall remain unaffected by implementation-specific changes.

---

# 13. Repository Integration

The Enterprise Data Type Standard is maintained within the Enterprise Data capability.

```text
Data/
└── Standards/
    └── EnterpriseDataTypeStandard.md
```

The standard governs logical data type usage across:

- Conceptual Data Models
- Logical Data Models
- Physical Database Models
- Enterprise Data Dictionary
- Database Engineering
- Service Contracts
- Integration Specifications

All engineering artifacts shall derive their physical data representations from the logical data types defined by this standard.

---

# 14. Governance

Enterprise data types are governed through the Phoenix Architecture Governance framework.

Compliance with this standard is mandatory.

Architecture reviews shall verify that:

- business semantics determine logical data types;
- logical data types remain technology independent;
- duplicate logical data types are avoided;
- physical mappings preserve business meaning;
- repository artifacts remain consistent with approved standards.

Any deviation from this standard requires:

- documented business justification;
- architectural impact assessment;
- formal approval by the Enterprise Architecture Team.

---

# 15. Future Evolution

The Enterprise Data Type Standard has been designed to support future growth of the Phoenix Platform.

Future enhancements may include:

- cross-platform type mappings;
- cloud-native database mappings;
- data exchange standards;
- semantic data type catalogs;
- analytical data type classifications;
- AI and machine learning data types;
- streaming data representations;
- domain-specific enterprise data type libraries.

Future enhancements shall extend the Enterprise Data Type Architecture without altering the canonical logical semantics established by this standard.

---

# 16. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Data Type Standard. |
| 2026.2 | 2026-07-22 | Complete redesign as the Enterprise Data Type Standard. Repositioned the document within the Enterprise Data capability, separated logical data type architecture from physical implementation, introduced enterprise data type taxonomy, mapping strategy, repository integration, governance framework, and alignment with the Enterprise Data Standards architecture. |

---

# 17. Approval

This document is an approved **Enterprise Data Standard** of the Phoenix Platform.

It defines the authoritative logical data type architecture governing business information throughout the platform.

All conceptual models, logical data models, enterprise business attributes, enterprise data dictionaries, physical database models, and database engineering activities shall comply with this standard unless an approved architectural exception has been granted.

This standard shall remain the authoritative reference for enterprise logical data types until superseded by a formally approved revision.

---

# End of Document