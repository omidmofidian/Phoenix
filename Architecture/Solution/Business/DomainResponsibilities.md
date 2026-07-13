# Domain Responsibilities

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | KNW-001 |
| Document | DomainResponsibilities |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Business Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalDomainModel, CanonicalServiceCatalog, ServiceContextMap |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical business responsibilities of each enterprise domain.

It establishes clear ownership boundaries, business capabilities and interaction rules to ensure a consistent Domain-Driven Design architecture.

---

# 2. Domain Responsibility Matrix

| Domain | Primary Responsibility | Owns Business Data | Publishes Information | Consumes Information |
|----------|-----------------------|--------------------|-----------------------|----------------------|
| Reference | Enterprise reference data | Yes | Yes | No |
| Core | Enterprise master business entities | Yes | Yes | Yes |
| Market | Market observations and trading information | Yes | Yes | Yes |
| Integration | External provider integration and identity mapping | No | Yes | Yes |
| Audit | Audit trail and domain events | Yes | Yes | Yes |
| Configuration | Runtime configuration | Yes | Yes | No |
| Reporting | Read-only analytical projections | Yes (Derived) | Yes | Yes |

---

# 3. Responsibilities

## 3.1 Reference Domain

### Mission

Provide stable enterprise reference data.

### Owns

- Exchange
- Trading Board
- Sector
- Industry
- Trading Calendar
- Currency
- Country

### Rules

- Independent.
- Shared by all operational domains.
- Business identifiers remain immutable.

---

## 3.2 Core Domain

### Mission

Manage enterprise master business entities.

### Owns

- Company
- Instrument
- Instrument Listing

### Rules

- Depends only on Reference.
- Owns enterprise identity.

---

## 3.3 Market Domain

### Mission

Capture market activity.

### Owns

- Daily Market Data
- Corporate Action

### Rules

- Historical records are immutable.
- Depends on Core and Reference.

---

## 3.4 Integration Domain

### Mission

Integrate external providers.

### Owns

- Data Provider
- External Identifier
- Import Session

### Rules

- Does not own business entities.
- Responsible for identifier mapping.
- Isolates external systems.

---

## 3.5 Audit Domain

### Mission

Provide enterprise auditability.

### Owns

- Audit Session
- Audit Event

### Rules

- Append-only.
- Observational.
- Independent from business logic.

---

## 3.6 Configuration Domain

### Mission

Manage runtime configuration.

### Owns

- Configuration Group
- Configuration Item

### Rules

- Independent.
- No business ownership.

---

## 3.7 Reporting Domain

### Mission

Provide analytical and reporting projections.

### Owns

- Report Definition
- Report Snapshot

### Rules

- Read-only.
- Derived from operational domains.

---

# 4. Responsibility Principles

- Every business capability shall belong to exactly one domain.
- Domain ownership shall never overlap.
- Cross-domain collaboration shall occur through published interfaces.
- Reporting shall never modify operational data.
- Audit shall never own business workflows.

---

# 5. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalDomainModel | Domain definitions |
| AggregateCatalog | Aggregate ownership |
| CanonicalServiceCatalog | Service alignment |
| DomainDependencyMatrix | Dependency validation |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version |