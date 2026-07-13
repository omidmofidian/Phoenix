# ADR-002 : Data Source Abstraction

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Phoenix will receive market data from different providers.

Possible sources include:

- Iran Exchange software export
- CSV files
- Excel files
- REST APIs
- Database imports
- Third-party market data providers

Direct dependency between business logic and a specific data source would reduce flexibility.

---

## Decision

Phoenix shall use a Data Source Abstraction Layer.

Each external data source shall be implemented through a dedicated Data Adapter.

Every adapter shall expose a unified interface to the rest of the system.

The Core modules shall never communicate directly with external data providers.

---

## Consequences

### Advantages

- Easy integration of new data providers.
- Loose coupling.
- Improved maintainability.
- Better testability.
- Simplified replacement of data providers.

### Disadvantages

- Additional abstraction layer.
- Slight increase in implementation effort.

---

## Alternatives Considered

Direct import from external sources.

Rejected.

Reason:

Creates tight coupling between business logic and data providers.

---

## Related Decisions

ADR-001 Core Independence

ADR-003 Pipeline Architecture

---

End of ADR-002