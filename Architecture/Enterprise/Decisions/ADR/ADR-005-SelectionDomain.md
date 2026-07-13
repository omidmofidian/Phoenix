# ADR-005 : Selection Domain

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Analytical workflows should rarely process every available financial instrument.

Different strategies, experiments, and users require different subsets of tradable instruments.

Examples include:

- Large-cap stocks
- Small-cap stocks
- Industry-specific groups
- Watchlists
- Machine Learning training datasets
- Backtesting universes

Embedding selection logic inside analysis modules would create unnecessary coupling and reduce flexibility.

---

## Decision

Phoenix shall introduce a dedicated Selection Domain.

The Selection Domain shall be responsible for defining and managing groups of financial instruments.

The initial entities are:

- TradingUniverse
- UniverseMembership

The Analysis Domain shall consume Trading Universes instead of directly querying all available Symbols.

---

## Rationale

Separating selection logic from analysis logic improves modularity and supports multiple independent analytical workflows.

Trading Universes become reusable assets that can be shared across strategies, machine learning experiments, reporting, and backtesting.

---

## Consequences

### Advantages

- Better separation of concerns.
- Reusable instrument groups.
- Simplified analytical workflows.
- Easier experimentation.
- Improved scalability.
- Better support for machine learning datasets.

### Disadvantages

- Additional entities.
- Slightly more complex database model.

---

## Alternatives Considered

### Direct Symbol Filtering

Rejected.

Reason:

Embedding filtering logic inside every analytical module leads to duplicated code and inconsistent behavior.

---

## Related Decisions

ADR-000 Architecture Principles

ADR-001 Core Independence

ADR-003 Pipeline Architecture

---

End of ADR-005