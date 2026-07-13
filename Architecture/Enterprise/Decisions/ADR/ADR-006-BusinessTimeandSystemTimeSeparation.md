# ADR-006 : Business Time and System Time Separation

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Financial data naturally contains multiple temporal dimensions.

Every record has at least two distinct timestamps:

1. The time at which the event occurred in the financial market.
2. The time at which the information became available inside the Phoenix platform.

Treating these timestamps as a single value would introduce look-ahead bias, reduce reproducibility, and compromise historical analysis.

The platform must therefore distinguish between business events and system events.

---

## Decision

Phoenix shall explicitly separate Business Time from System Time.

Every time-dependent entity shall record timestamps according to their semantic meaning.

The following temporal concepts are defined:

### Business Time

Represents when an event actually occurred in the financial market.

Examples:

- Trading Date
- Financial Statement Date
- Dividend Date
- Corporate Action Date

### System Time

Represents when Phoenix received, validated, stored, or processed the data.

Examples:

- Imported At
- Stored At
- Processed At
- Prediction Generated At

Business Time and System Time shall never be used interchangeably.

---

## Rationale

Separating business time from system time eliminates look-ahead bias and guarantees that historical simulations only use information that would have been available at the time.

This design also improves auditing, debugging, incremental imports, and machine learning reproducibility.

---

## Consequences

### Advantages

- Eliminates look-ahead bias.
- Supports reproducible backtesting.
- Enables complete auditing.
- Improves machine learning dataset integrity.
- Supports incremental synchronization.

### Disadvantages

- Additional timestamp fields.
- Slightly more complex database schema.

---

## Alternatives Considered

### Single Timestamp Per Record

Rejected.

Reason:

A single timestamp cannot accurately represent both business events and system events.

---

## Related Decisions

ADR-000 Architecture Principles

ADR-003 Pipeline Architecture

ADR-004 Immutable Historical Data

---

End of ADR-006