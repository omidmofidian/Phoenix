# ADR-026 — Reference Data Normalization Model

---

## Document Information

| Attribute | Value |
|----------|-------|
| ADR Number | ADR-026 |
| Title | Reference Data Normalization Model |
| Status | Accepted |
| Version | 2.0 |
| Date | 2026-07-24 |
| Decision Makers | Phoenix Architecture Board |
| Authors | Phoenix Architecture Team |
| Review Cycle | Major Architecture Changes |
| Supersedes | ADR-026 Version 1.0 |

---

# 1. Status

**Accepted**

This Architecture Decision Record defines the normalization principles governing the Reference Data Model of the Phoenix Platform.

This ADR complements **ADR-015 — Canonical Reference Domain Model**.

While ADR-015 defines the canonical business entities and their relationships, this ADR specifies how those entities shall be implemented within the logical and physical database models.

The normalization rules defined herein are mandatory for:

- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL Database Design
- Database Definition Language (DDL)
- Object-Relational Mapping (ORM)
- Repository Layer
- Data Access Layer

Any deviation from these normalization rules requires an approved superseding Architecture Decision Record.

---

# 2. Context

The Phoenix Platform adopts an enterprise-grade, service-oriented architecture designed for long-term scalability, maintainability, and support for multiple financial markets.

The business reference hierarchy is formally defined in **ADR-015 — Canonical Reference Domain Model**.

That hierarchy establishes the canonical relationships between business entities such as Exchange, Market, TradingBoard, Company, Industry, Sector, and Instrument.

However, defining business relationships alone is insufficient for implementing a consistent enterprise data model.

Without explicit normalization rules, different developers may introduce:

- redundant foreign keys;
- duplicated business relationships;
- inconsistent entity ownership;
- update anomalies;
- insert anomalies;
- delete anomalies;
- unnecessary data redundancy.

Such inconsistencies increase maintenance costs and compromise data integrity.

To ensure that every implementation follows a single enterprise data model, Phoenix requires a formal normalization policy for all reference entities.

This ADR establishes those normalization rules and defines how canonical business relationships shall be represented within the database.

---

# 3. Problem Statement

The canonical business hierarchy defined in ADR-015 establishes the relationships between business entities.

However, without explicit normalization rules, those relationships may be implemented inconsistently across different database objects.

Typical implementation problems include:

- storing multiple foreign keys that represent the same business relationship;
- duplicating information that can be derived from existing relationships;
- introducing inconsistent parent-child ownership;
- violating Third Normal Form (3NF);
- increasing database maintenance complexity.

For example, if the **Company** entity stores:

- `exchange_id`
- `market_id`
- `trading_board_id`

the values of `exchange_id` and `market_id` are already derivable from `trading_board_id`.

Similarly, if **Instrument** stores:

- `exchange_id`
- `market_id`
- `trading_board_id`
- `company_id`

only `company_id` represents the immediate business parent.

All remaining relationships are derivable.

Persisting derivable relationships introduces unnecessary redundancy and creates opportunities for inconsistent data.

Therefore, a formal normalization policy is required to ensure consistent implementation across the Phoenix Platform.

---

# 4. Decision

The Phoenix Platform shall implement the Reference Data Model in accordance with the following principles.

## Principle 1 — Third Normal Form

Reference entities shall comply with Third Normal Form (3NF).

Every non-key attribute shall depend only upon:

- the key;
- the whole key;
- and nothing but the key.

---

## Principle 2 — Immediate Parent Rule

Each reference entity shall maintain foreign keys only to its immediate business parent.

Higher-level ancestor relationships shall be derived rather than persisted.

---

## Principle 3 — No Redundant Relationships

A foreign key shall not be stored when its value can be obtained through existing parent relationships.

Derived relationships belong to the logical model, not the physical storage model.

---

## Principle 4 — Canonical Ownership

Every reference entity shall have exactly one canonical ownership path.

Multiple ownership paths are prohibited unless explicitly approved by an Architecture Decision Record.

---

## Principle 5 — Business Integrity

Normalization shall never alter the canonical business hierarchy defined by ADR-015.

Logical optimization shall not compromise business semantics.

---

# 5. Normalization Rules

The following rules are mandatory for all reference entities.

### Rule 1

Store only immediate parent identifiers.

---

### Rule 2

Do not duplicate ancestor identifiers.

---

### Rule 3

Avoid transitive dependencies.

---

### Rule 4

Avoid duplicated business relationships.

---

### Rule 5

Reference entities shall remain independent from implementation-specific optimizations.

Performance optimizations, when required, shall be implemented using indexes, materialized views, caching strategies, or query optimization techniques rather than denormalizing the canonical reference model.

---

# 6. Immediate Parent Rule

The Immediate Parent Rule is the cornerstone of the Phoenix Reference Data Model.

Every reference entity shall store foreign keys only to its immediate business parent(s).

No entity shall store references to higher-level ancestors if those relationships can be derived through existing parent relationships.

---

## Canonical Parent Relationships

The following table defines the mandatory parent relationships.

| Entity | Immediate Parent(s) |
|----------|--------------------|
| Exchange | — |
| Market | Exchange |
| TradingBoard | Market |
| Industry | — |
| Sector | Industry |
| Company | TradingBoard, Sector |
| Instrument | Company |

No additional parent relationships shall be introduced without an approved Architecture Decision Record.

---

## Example — Trading Hierarchy

```text
Exchange
    │
    └── Market
            │
            └── TradingBoard
                    │
                    └── Company
                            │
                            └── Instrument
```

From this hierarchy:

- Market owns TradingBoard.
- TradingBoard owns Company.
- Company owns Instrument.

Therefore:

- Instrument **shall store only** `company_id`.
- Company **shall store only** `trading_board_id`.

The remaining relationships are derived.

---

## Example — Business Classification Hierarchy

```text
Industry
    │
    └── Sector
            │
            └── Company
```

Therefore:

Company stores only:

```text
sector_id
```

Industry is determined through the Sector relationship.

---

# 7. Allowed Relationships

The following foreign keys are approved as canonical.

| Entity | Allowed Foreign Keys |
|----------|----------------------|
| Market | exchange_id |
| TradingBoard | market_id |
| Sector | industry_id |
| Company | trading_board_id, sector_id |
| Instrument | company_id |

These relationships represent the minimum information required to preserve the complete business hierarchy.

---

# 8. Forbidden Relationships

The following foreign keys shall **not** be stored because they are derivable.

| Entity | Forbidden Foreign Keys | Reason |
|----------|------------------------|--------|
| Company | exchange_id | Derived through TradingBoard → Market → Exchange |
| Company | market_id | Derived through TradingBoard |
| Company | industry_id | Derived through Sector |
| Instrument | exchange_id | Derived through Company |
| Instrument | market_id | Derived through Company |
| Instrument | trading_board_id | Derived through Company |
| Instrument | sector_id | Derived through Company |
| Instrument | industry_id | Derived through Company |
| Instrument | company_exchange_id | Redundant |
| Instrument | company_market_id | Redundant |

These restrictions are mandatory to maintain Third Normal Form (3NF) and eliminate transitive dependencies.

---

# 9. Derived Relationships

Derived relationships are business relationships that can be determined by traversing the canonical hierarchy.

Such relationships shall **not** be physically stored within the reference model.

Instead, they shall be resolved through relational joins or equivalent application logic.

---

## Example 1 — Instrument to Exchange

```text
Instrument
      │
      ▼
Company
      │
      ▼
TradingBoard
      │
      ▼
Market
      │
      ▼
Exchange
```

Therefore:

```text
Instrument → Exchange
```

is a **derived relationship**.

The `exchange_id` shall **not** be stored in the Instrument table.

---

## Example 2 — Company to Industry

```text
Company
      │
      ▼
Sector
      │
      ▼
Industry
```

Therefore:

```text
Company → Industry
```

is also a derived relationship.

The `industry_id` shall **not** be stored in the Company table.

---

## Example 3 — Instrument to Sector

```text
Instrument
      │
      ▼
Company
      │
      ▼
Sector
```

Consequently:

```text
Instrument → Sector
```

is derived through Company.

No `sector_id` column shall exist in the Instrument entity.

---

# 10. Architectural Benefits

Adoption of this normalization model provides significant architectural advantages.

## Data Integrity

Eliminates inconsistent foreign key values and guarantees a single authoritative ownership path.

---

## Elimination of Redundancy

Prevents duplication of business relationships throughout the database.

---

## Improved Maintainability

Structural changes affect only immediate relationships rather than propagating through multiple entities.

---

## Scalability

Supports future financial markets, exchanges, instruments, and classifications without redesigning the reference model.

---

## Enterprise Consistency

Provides a uniform implementation strategy across:

- PostgreSQL DDL
- ORM mappings
- Repository layer
- Domain services
- Integration services

---

## Reduced Maintenance Cost

Schema evolution becomes significantly simpler because only canonical parent relationships are maintained.

---

# 11. Compliance Requirements

Compliance with this ADR is mandatory.

Every database object representing reference data shall satisfy the following requirements.

## Mandatory Requirements

- Store only immediate parent foreign keys.
- Eliminate redundant ancestor relationships.
- Avoid transitive dependencies.
- Preserve Third Normal Form (3NF).
- Follow the canonical hierarchy defined in ADR-015.
- Use canonical entity names.
- Apply standardized naming conventions.

---

## Repository Compliance

The following artifacts shall remain fully aligned with this ADR.

- Domain Model
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL DDL Scripts
- ORM Entity Definitions
- Repository Implementations
- Database Migration Scripts

Repository consistency audits shall verify compliance before every major release.

---

# 12. Related ADRs

This Architecture Decision Record complements the following ADRs.

| ADR | Title |
|------|-------|
| ADR-001 | Domain-Driven Design |
| ADR-002 | Service-Oriented Architecture |
| ADR-015 | Canonical Reference Domain Model |
| ADR-026 | Reference Data Normalization Model *(this document)* |

Where conflicts exist, **ADR-015** defines the canonical business hierarchy, while **ADR-026** governs its logical and physical implementation.

---

# 13. References

The implementation of this ADR shall remain consistent with the following architectural artifacts.

- Domain Model
- Conceptual Data Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- PostgreSQL Physical Database Design
- PostgreSQL Design Decisions
- Table Physical Specifications
- Constraint Specifications
- DDL Template Specification

---

# End of Document