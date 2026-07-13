# ADR-009 : Canonical Data Dictionary

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

As the Phoenix platform evolves, multiple architectural artifacts define business entities, including:

- Software Design Document (SDD)
- Domain Model
- Conceptual Database Model
- Logical Database Model
- Physical Database Model
- Source Code
- API Specifications

Without a single authoritative reference for entity definitions and attributes, inconsistencies may arise between documentation, implementation, and database schema.

A canonical definition of all business entities is therefore required.

---

## Decision

Phoenix shall maintain a centralized Data Dictionary as the authoritative source for all business entities and their attributes.

Each business entity shall be documented in an individual Markdown document.

The Data Dictionary shall define:

- Business meaning
- Canonical entity name
- Attribute definitions
- Data types
- Business identifiers
- Relationships
- Validation rules
- Temporal semantics
- Related ADRs

Whenever inconsistencies arise between architectural documents, the Data Dictionary shall be considered the authoritative reference.

---

## Rationale

A centralized Data Dictionary improves consistency across architecture, database design, source code, and documentation.

It establishes a common vocabulary, supports maintainability, and simplifies future schema evolution.

---

## Consequences

### Advantages

- Single source of truth
- Improved documentation consistency
- Better communication
- Easier database evolution
- Simplified onboarding
- Reduced ambiguity

### Disadvantages

- Additional documentation effort
- Requires disciplined maintenance

---

## Documentation Structure

```
docs/
└── Database/
    └── DataDictionary/
        ├── README.md
        ├── Market.md
        ├── Exchange.md
        ├── Instrument.md
        ├── Symbol.md
        ├── DailyMarketData.md
        └── ...
```

---

## Related Decisions

ADR-000 Architecture Principles

ADR-005 Selection Domain

ADR-007 DailyMarketData Entity

ADR-008 Separation of Core Business Entities and Derived Analytical Entities

---

## Impact Analysis

Affected Documents

- DomainModel.md
- ConceptualModel.md
- LogicalModel.md
- PhysicalModel.md
- EntityClassification.md

Future Implementation

- PostgreSQL Schema
- SQLAlchemy Models
- Python Domain Classes

---

End of ADR-009