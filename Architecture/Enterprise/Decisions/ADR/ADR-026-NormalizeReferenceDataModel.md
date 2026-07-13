# ADR-026 — Normalize Reference Data Model

| Item | Value |
|------|------|
| ADR ID | ADR-026 |
| Title | Normalize Reference Data Model |
| Status | Accepted |
| Date | 2026-07-12 |
| Decision Makers | Phoenix Architecture Team |

---

# 1. Context

During Sprint 4, the initial implementation of the Reference Data Model revealed that several entities contained redundant foreign keys.

The original Company entity contained references to:

- Exchange
- Market
- Board
- Industry
- Sector

However, the business hierarchy already defines these relationships.

```
Exchange
    └── Market
            └── Board
                    └── Company

Industry
    └── Sector
            └── Company
```

Consequently, the Company entity stored information that could be derived through existing relationships.

This introduced unnecessary redundancy into the canonical data model.

---

# 2. Problem Statement

The original design allowed the following situation.

```
Company
    exchange_id
    market_id
    board_id
    industry_id
    sector_id
```

This creates multiple problems.

- Data redundancy
- Update anomalies
- Insert anomalies
- Delete anomalies
- Inconsistent parent references
- Additional validation logic
- Increased maintenance cost

The model violates the principles of Third Normal Form (3NF).

---

# 3. Decision

The Reference Data Model shall be normalized.

Each entity shall maintain only direct parent relationships.

Derived parent relationships shall never be stored in the canonical database model.

---

# 4. New Reference Hierarchy

## Trading Structure

```text
Exchange
    │
    └── Market
            │
            └── Board
                    │
                    └── Company
                            │
                            └── Symbol
```

---

## Business Classification

```text
Industry
      │
      └── Sector
              │
              └── Company
```

---

# 5. Company Entity

The Company entity shall reference only its immediate parents.

## Removed Columns

```text
exchange_id

market_id

industry_id
```

## Retained Columns

```text
board_id

sector_id
```

Exchange, Market and Industry become derived relationships.

---

# 6. Foreign Key Model

The normalized foreign key hierarchy becomes:

| Child | Parent |
|--------|--------|
| Market | Exchange |
| Board | Market |
| Sector | Industry |
| Company | Board |
| Company | Sector |
| Symbol | Company |
| HolidayCalendar | TradingCalendar |

---

# 7. Architectural Principles

This decision reinforces the following principles.

- Third Normal Form (3NF)
- Canonical Data Model
- Single Source of Truth
- Elimination of Redundant Data
- Referential Integrity
- Enterprise Database Design
- Separation of Concerns

---

# 8. Benefits

## Data Integrity

- Elimination of redundant references
- Elimination of inconsistent parent relationships
- Simplified referential integrity

---

## Maintainability

- Fewer columns
- Simpler DDL
- Easier schema evolution

---

## Scalability

Future extensions require fewer structural changes.

Additional markets and exchanges can be introduced without modifying the Company entity.

---

## Reporting

Reporting requirements shall be satisfied through:

- Views
- Materialized Views
- Reporting Schemas
- Data Warehouse structures

The operational database remains fully normalized.

---

# 9. Consequences

The following artifacts shall be updated.

## Architecture

- DomainModel.md
- ConceptualDataModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

## Enterprise

- EnterpriseDataDictionary.md

---

## Database

- 060-CreateCompany.sql
- 070-CreateSymbol.sql (until superseded by ADR-027)
- 010-ReferenceForeignKeys.sql

---

## Documentation

- RepositoryValidationReport.md
- Sprint4ArchitectureReview.md
- Sprint4ArchitectureFreeze.md

---

# 10. Alternatives Considered

## Alternative 1

Store all parent foreign keys.

Decision:

Rejected.

Reason:

Introduces redundancy and violates normalization principles.

---

## Alternative 2

Store only direct parent relationships.

Decision:

Accepted.

Reason:

Provides a canonical, maintainable and scalable enterprise data model.

---

# 11. Risks

Potential increase in JOIN operations during reporting.

Mitigation:

- PostgreSQL query optimization
- Appropriate indexing
- Materialized Views
- Reporting Layer
- Data Warehouse

Operational correctness has priority over denormalization.

---

# 12. Implementation Plan

1. Update the reference data model.
2. Update architecture documents.
3. Update Enterprise Data Dictionary.
4. Rewrite Company DDL.
5. Rewrite Reference Foreign Keys.
6. Continue Sprint 4 implementation.

---

# 13. Compliance

All future reference entities shall follow the rule:

> Every entity stores only references to its immediate parent entities.

No redundant foreign keys shall be introduced into the canonical operational database.

---

# 14. Status

**Accepted**

This ADR becomes effective immediately and supersedes the previous Reference Data Model implemented during Sprint 4.