# Market Schema Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Schema | market |
| Document | Market Schema Dictionary |
| Version | 1.0 |
| Status | Approved |
| Last Updated | 2026-06-29 |

---

# Purpose

The **market** schema contains all master and reference data describing financial markets, listed companies, tradable instruments, and their classification.

It represents the structural foundation of the Phoenix database.

The schema is intentionally independent of trading history and analytical data.

---

# Scope

The schema contains the following entities.

| Entity | Description |
|---------|-------------|
| exchange | Securities exchanges |
| trading_board | Trading boards operated by exchanges |
| sector | Economic sectors |
| industry | Industries belonging to sectors |
| company | Listed companies |
| instrument | Tradable financial instruments |
| instrument_listing | Instrument listing history |

---

# Responsibilities

The market schema is responsible for:

- Exchange definition
- Trading board definition
- Company master data
- Instrument master data
- Industry classification
- Sector classification
- Listing information

The schema is NOT responsible for:

- Daily prices
- Trading history
- Market statistics
- Corporate events processing

Those belong to the **trading** schema.

---

# Entity Hierarchy

```text
Exchange
    │
    ├──────────────┐
    │              │
Trading Board      │
    │              │
    ▼              │
Instrument Listing │
    ▲              │
    │              │
Instrument─────────┘
    ▲
    │
Company
    ▲
    │
Industry
    ▲
    │
Sector
```

---

# Entity Relationships

## Exchange

One Exchange

↓

Many Trading Boards

---

## Trading Board

One Trading Board

↓

Many Instrument Listings

---

## Sector

One Sector

↓

Many Industries

---

## Industry

One Industry

↓

Many Companies

---

## Company

One Company

↓

Many Instruments

---

## Instrument

One Instrument

↓

Many Listings

---

# Business Rules

The following rules apply to the entire schema.

- Every company belongs to exactly one industry.
- Every industry belongs to exactly one sector.
- Every instrument belongs to exactly one company.
- Every listing belongs to exactly one trading board.
- Every trading board belongs to exactly one exchange.
- Historical master data shall never be physically deleted.
- Master data shall use soft deactivation.

---

# Standard Columns

Every entity contains:

```text
id

public_id

created_at

updated_at
```

Reference entities additionally contain

```text
is_active
```

---

# Identifier Strategy

This schema follows ADR-016.

Internal Identifier

```text
id
```

Public Identifier

```text
public_id
```

---

# Related Schemas

## trading

Stores

- Daily Market Data
- Trading Calendar
- Corporate Actions

---

## analytics (Future)

Stores

- Indicators
- Factors
- Machine Learning Features

---

## system (Future)

Stores

- Users
- Permissions
- Audit Logs
- Configuration

---

# Design Principles

The market schema follows the following principles.

- Fully normalized
- Immutable identifiers
- Master data isolation
- No duplicated business entities
- Referential integrity
- API-ready identifiers
- Future SOA compatibility

---

# References

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- STD-006 – Database Standards
- ADR-016 – Public Identifier Strategy

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial version |