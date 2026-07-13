# ADR-007 : DailyMarketData Entity

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

The initial conceptual model introduced an entity named **DailyPrice** to represent end-of-day market information.

Further analysis showed that this entity stores considerably more than price information.

Typical daily market records include:

- Open Price
- High Price
- Low Price
- Close Price
- Adjusted Close
- Trading Volume
- Trading Value
- Number of Trades
- Market Capitalization (optional)
- Symbol Status
- Trading Flags

The name **DailyPrice** does not accurately represent the business concept.

---

## Decision

The entity shall be renamed from **DailyPrice** to **DailyMarketData**.

DailyMarketData represents the complete End-of-Day (EOD) market snapshot for a financial instrument.

The entity shall become the primary source of historical market information for all analytical modules.

---

## Rationale

Entity names should reflect business meaning rather than implementation details.

Using DailyMarketData provides a more accurate and extensible abstraction.

Future market attributes can be added without violating the semantic meaning of the entity.

---

## Consequences

### Advantages

- Improved domain clarity.
- Better extensibility.
- More accurate business terminology.
- Supports future market attributes.

### Disadvantages

- Slightly longer entity name.

---

## Alternatives Considered

### DailyPrice

Rejected.

Reason:

Represents only one aspect of the stored business information.

---

## Related Decisions

ADR-004 Immutable Historical Data

ADR-006 Business Time and System Time Separation

---

End of ADR-007