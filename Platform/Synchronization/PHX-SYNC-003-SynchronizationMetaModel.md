# PHX-SYNC-003 — Synchronization Meta Model

**Document ID:** PHX-SYNC-003

**Title:** Synchronization Meta Model

**Version:** 2.0

**Status:** Approved

**Classification:** Platform Architecture

---

# 1. Purpose

This document defines the canonical synchronization model of the Phoenix Platform.

Rather than synchronizing physical files, directories or database objects, Phoenix synchronizes logical synchronization domains organized within a canonical synchronization hierarchy.

This model serves as the foundation for all synchronization services, synchronization packages and synchronization policies.

---

# 2. Objectives

The Canonical Synchronization Model shall:

- Define a technology-independent synchronization model.
- Separate logical synchronization from physical storage.
- Support incremental synchronization.
- Support independent synchronization units.
- Support future platform evolution.
- Provide deterministic synchronization behavior.

---

# 3. Synchronization Meta Model

Phoenix defines four abstraction levels.

```
Synchronization Layer
        │
        ▼
Synchronization Domain
        │
        ▼
Synchronization Unit
        │
        ▼
Synchronization Object
```

---

# 4. Synchronization Layer

A Synchronization Layer represents the highest logical grouping.

Layers describe broad categories of synchronized assets.

Each layer contains one or more synchronization domains.

Examples:

- Platform Assets
- Database Assets
- Business Data
- Analytical Assets
- Operational Assets

---

# 5. Synchronization Domain

A Synchronization Domain represents a logical collection of related synchronization units.

Domains define synchronization boundaries.

Examples:

- Historical Market Data
- Reference Data
- Corporate Actions
- Financial Statements
- Feature Store

A domain owns:

- synchronization policy
- validation policy
- dependency rules
- version policy

---

# 6. Synchronization Unit

A Synchronization Unit is the smallest independently synchronized logical component.

Examples:

Historical Market Data

contains

- Daily Market Data
- Weekly Market Data
- Monthly Market Data

Reference Data

contains

- Exchanges
- Trading Boards
- Industries
- Sectors

Feature Store

contains

- Technical Features
- Fundamental Features
- AI Features

Each unit may be synchronized independently.

---

# 7. Synchronization Object

Synchronization Objects represent physical implementation artifacts.

Examples:

- database rows
- files
- documents
- datasets
- binary models
- configuration files

Objects are implementation details.

The synchronization engine operates primarily on Units rather than individual objects.

---

# 8. Canonical Synchronization Layers

## Layer 1 — Platform Assets

Purpose

Development infrastructure.

Examples

- Configuration
- Docker
- Runtime Configuration
- Environment Definition

---

## Layer 2 — Database Assets

Purpose

Database structure.

Examples

- Schema
- Views
- Functions
- Procedures
- Indexes

---

## Layer 3 — Business Data

Purpose

Business information.

Domains

- Reference Data
- Instrument Master Data
- Historical Market Data
- Corporate Actions
- Financial Statements
- News

---

## Layer 4 — Analytical Assets

Purpose

Generated analytical information.

Domains

- Feature Store
- Indicators
- AI Models
- Analysis Cache

---

## Layer 5 — Operational Assets

Purpose

Operational information.

Domains

- Logs
- Reports
- Temporary Data
- Diagnostics

---

# 9. Synchronization Categories

Every synchronization unit belongs to one category.

## Mandatory

Must always be synchronized.

Examples

- Schema
- Reference Data
- Historical Market Data

---

## Optional

Synchronized according to configuration.

Examples

- AI Models
- Feature Store

---

## Rebuildable

Normally regenerated.

Examples

- Indicators
- Analysis Cache
- Reports

---

## Transient

Never synchronized.

Examples

- Logs
- Temporary Files
- Runtime Cache

---

# 10. Dependency Model

Synchronization follows dependency order.

Platform Assets

↓

Database Assets

↓

Reference Data

↓

Instrument Master Data

↓

Historical Market Data

↓

Corporate Actions

↓

Financial Statements

↓

Analytical Assets

↓

Operational Assets

---

# 11. Architectural Rules

Rule 1

Synchronization shall operate on Synchronization Units.

---

Rule 2

Objects shall never define synchronization boundaries.

---

Rule 3

Every Synchronization Domain shall define its own synchronization policy.

---

Rule 4

Every Synchronization Unit shall be independently verifiable.

---

Rule 5

Synchronization shall remain independent from database technology.

---

Rule 6

Derived information should be rebuilt whenever possible.

---

# 12. Related Documents

- PHX-SYNC-001
- PHX-SYNC-002
- PHX-SYNC-004
- PHX-SYNC-005