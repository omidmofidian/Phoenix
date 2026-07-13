# ADR-001 : Core Independence

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Phoenix is intended to become a long-term quantitative analysis platform capable of supporting multiple financial markets.

Coupling the core business logic to a specific market, exchange, broker, or data source would significantly reduce maintainability and extensibility.

The platform must therefore be designed around a market-independent domain model.

---

## Decision

The core architecture shall remain independent from any specific financial market.

No business logic inside the Core layer shall contain assumptions related to:

- Iran Stock Exchange
- Cryptocurrency markets
- Forex
- US Stock Market
- Any broker-specific implementation

All market-specific functionality shall be implemented through dedicated adapters or plugins.

---

## Consequences

### Advantages

- High extensibility.
- Better maintainability.
- Easier testing.
- Supports multiple financial markets.
- Cleaner architecture.

### Disadvantages

- Slightly higher initial complexity.
- Additional abstraction layers.

---

## Alternatives Considered

Embedding market-specific logic inside the Core.

Rejected.

Reason:

Would make future expansion significantly more difficult.

---

## Related Decisions

ADR-002 Data Source Abstraction

ADR-003 Pipeline Architecture

---

End of ADR-001