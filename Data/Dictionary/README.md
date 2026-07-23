# Enterprise Data Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact | Enterprise Data Dictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Metadata |
| Owner | Architecture Team |
| Maintainers | Data Architecture Team, Database Team |
| Repository | Data/Dictionary |
| Last Updated | 2026-07-22 |

---

# 1. Purpose

The Enterprise Data Dictionary is the authoritative repository of business metadata for the Phoenix Platform.

Its purpose is to establish a common business vocabulary shared by architects, database designers, software developers, data engineers, integration services, analytics components, and future artificial intelligence capabilities.

Rather than describing implementation details, the Enterprise Data Dictionary defines the meaning of enterprise information assets and provides a single source of truth for business entities, business attributes, business relationships, and canonical terminology.

The Enterprise Data Dictionary bridges Enterprise Architecture, Information Architecture, Logical Data Modeling, Physical Database Design, and Software Implementation.

---

# 2. Scope

The Enterprise Data Dictionary documents the business metadata associated with the Phoenix information architecture.

Its scope includes:

- Business Entities
- Enterprise Attributes
- Business Relationships
- Canonical Definitions
- Business Terminology
- Business Classifications
- Enterprise Metadata
- Reference Data Definitions
- Business Constraints
- Cross-Domain Relationships

The dictionary is technology-independent and intentionally avoids implementation-specific database details except where necessary for traceability.

---

# 3. Architectural Position

Within the Phoenix Architecture, the Enterprise Data Dictionary occupies the metadata layer between enterprise design and implementation.

```text
Knowledge
      │
      ▼
Architecture
      │
      ▼
Design
      │
      ├── Conceptual Models
      ├── Logical Models
      ├── Physical Models
      └── Enterprise Data Dictionary
      │
      ▼
Database Implementation
      │
      ▼
Applications
```

Every business concept implemented within the platform shall be traceable through the Enterprise Data Dictionary.

---

# 4. Objectives

The Enterprise Data Dictionary has the following objectives:

- establish a common enterprise vocabulary;
- eliminate inconsistent business definitions;
- standardize entity documentation;
- standardize attribute definitions;
- standardize relationship documentation;
- improve communication across teams;
- support architectural traceability;
- improve implementation consistency;
- support enterprise governance;
- provide metadata for future automation and AI-assisted development.

---

# 5. Dictionary Organization

The Enterprise Data Dictionary is organized into complementary metadata collections.

| Dictionary | Responsibility |
|------------|----------------|
| Entity Dictionary | Canonical business entities |
| Attribute Dictionary | Enterprise attributes |
| Relationship Dictionary | Business relationships |
| Business Definitions | Canonical terminology |
| Domain Metadata | Domain ownership |
| Supporting Documents | Cross-reference metadata |

Each collection has a single responsibility while remaining fully traceable to the enterprise architecture.

---

# 6. Repository Structure

```text
Data/
└── Dictionary/
    │
    ├── README.md
    ├── EntityDictionary.md
    ├── AttributeDictionary.md
    ├── RelationshipDictionary.md
    ├── AttributeCatalog.md
    │
    ├── 01-Exchange.md
    ├── 02-TradingBoard.md
    ├── 03-Sector.md
    ├── 04-Industry.md
    ├── 05-Company.md
    ├── 06-Instrument.md
    ├── 07-InstrumentListing.md
    ├── 08-TradingCalendar.md
    ├── 09-DailyMarketData.md
    └── 10-CorporateAction.md
```

The repository structure may evolve as additional enterprise domains are introduced while preserving backward compatibility and traceability.

---

# 7. Relationship with Enterprise Architecture

The Enterprise Data Dictionary is derived from approved architectural and design artifacts.

It shall remain fully synchronized with the enterprise information architecture throughout the lifecycle of the platform.

The Enterprise Data Dictionary is primarily derived from:

- Conceptual Data Models
- Logical Data Models
- Physical Database Models
- Enterprise Data Standards
- Canonical Domain Models
- Canonical Business Rules
- Architecture Decision Records (ADRs)

The dictionary shall never redefine business concepts independently of the approved architecture.

---

# 8. Enterprise Metadata Principles

The Enterprise Data Dictionary is governed by the following principles.

## Principle 1 — Single Source of Truth

Every business concept shall have exactly one canonical definition.

---

## Principle 2 — Business First

Business meaning shall always precede implementation details.

---

## Principle 3 — Technology Independence

Metadata shall remain independent of database products, programming languages, and implementation frameworks whenever practical.

---

## Principle 4 — Reuse

Enterprise definitions shall be reused rather than duplicated.

---

## Principle 5 — Traceability

Every documented element shall be traceable to its originating architectural artifact.

---

## Principle 6 — Consistency

Terminology, entity definitions, attribute definitions, and relationships shall remain consistent across every enterprise domain.

---

# 9. Standard Dictionary Structure

Every dictionary document shall follow a consistent documentation structure.

The recommended structure includes:

| Section | Purpose |
|----------|---------|
| Document Information | Governance metadata |
| Purpose | Business objective |
| Business Description | Business meaning |
| Entity Definition | Canonical definition |
| Attribute Definitions | Business attributes |
| Relationships | Business relationships |
| Business Rules | Governing rules |
| Cross References | Related artifacts |
| Related Documents | Supporting references |
| Revision History | Document evolution |

Additional sections may be introduced where justified by business requirements.

---

# 10. Metadata Categories

Enterprise metadata maintained within the dictionary is classified into the following categories.

| Category | Description |
|----------|-------------|
| Entity Metadata | Business entities |
| Attribute Metadata | Business attributes |
| Relationship Metadata | Business relationships |
| Reference Metadata | Controlled reference data |
| Classification Metadata | Business classifications |
| Lifecycle Metadata | Business lifecycle information |
| Audit Metadata | Audit-related definitions |
| Identity Metadata | Enterprise identity definitions |
| Integration Metadata | External system mappings |

Each metadata category has clearly defined ownership and responsibilities.

---

# 11. Traceability

Every documented metadata element shall be traceable throughout the enterprise architecture.

Typical traceability includes:

```text
Business Capability
        │
        ▼
Business Domain
        │
        ▼
Business Entity
        │
        ▼
Enterprise Attribute
        │
        ▼
Logical Model
        │
        ▼
Physical Model
        │
        ▼
Database Implementation
```

This traceability enables architectural governance, impact analysis, change management, and long-term maintainability.

---

# 12. Relationship with Enterprise Data Standards

The Enterprise Data Dictionary operates as part of the Enterprise Data Standards framework.

The dictionary shall comply with the following enterprise standards.

| Standard | Responsibility |
|----------|----------------|
| DST-001 — Enterprise Naming Standard | Canonical naming |
| DST-002 — Enterprise Data Type Standard | Enterprise data types |
| DST-003 — Base Entity Standard | Common entity architecture |
| DST-004 — Audit Model Standard | Audit metadata |
| DST-005 — Identifier Strategy | Identifier governance |
| DST-006 — Enterprise Data Dictionary Standard | Dictionary governance |
| DST-007 — Enterprise Database Design Standard | Database engineering |
| DST-008 — Enterprise Identity Standard | Enterprise identity architecture |
| DST-009 — Enterprise Attribute Standard | Enterprise attribute architecture |
| DST-010 — Logical Model Document Standard | Logical model documentation |

These standards collectively establish the governance framework for all enterprise metadata.

---

# 13. Governance

The Enterprise Data Dictionary is a governed architectural asset.

Every modification shall follow the Phoenix Architecture Governance process.

Architecture reviews shall verify:

- compliance with Enterprise Data Standards;
- consistency with approved architectural artifacts;
- uniqueness of business definitions;
- correctness of business terminology;
- completeness of metadata;
- consistency across all business domains.

Business definitions shall not be modified without evaluating their architectural impact.

---

# 14. Repository Integration

The Enterprise Data Dictionary is maintained within the Enterprise Data capability.

```text
Data/
└── Dictionary/
```

It provides business metadata for:

- Enterprise Architecture
- Conceptual Data Models
- Logical Data Models
- Physical Database Models
- Database Design
- SQL Development
- API Design
- Service Contracts
- Reporting
- Analytics
- Future Artificial Intelligence services

The Enterprise Data Dictionary serves as the authoritative metadata source for every information-related artifact within the Phoenix Platform.

---

# 15. Compliance

Compliance with this document is mandatory.

Every dictionary document shall:

- follow the approved documentation structure;
- comply with Enterprise Data Standards;
- use canonical enterprise terminology;
- remain synchronized with architectural artifacts;
- preserve semantic consistency;
- support full architectural traceability.

Any exception requires formal approval through the Phoenix Architecture Governance process.

---

# 16. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial Data Dictionary. |
| 2026.2 | 2026-07-22 | Complete redesign as the Enterprise Data Dictionary. Introduced enterprise metadata architecture, governance model, repository integration, metadata categories, traceability framework, and alignment with the Enterprise Data Standards framework. |

---

# 17. Approval

This document is an approved **Enterprise Metadata Guide** of the Phoenix Platform.

It defines the governance, organization, and architectural responsibilities of the Enterprise Data Dictionary.

All dictionary documents, entity definitions, attribute definitions, relationship definitions, and business metadata maintained within the repository shall comply with this guide unless an approved architectural exception has been granted.

This document remains the authoritative reference for the Enterprise Data Dictionary until superseded by a formally approved revision.

---

# End of Document