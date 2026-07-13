# ADR-004 : Immutable Historical Data

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Historical market data is the foundation of all analytical processes within the Phoenix platform, including technical analysis, feature engineering, machine learning, backtesting, and performance evaluation.

Any modification to historical data after it has been stored would compromise reproducibility, invalidate analytical results, and make auditing impossible.

Therefore, a strict data preservation policy is required.

---

## Decision

Historical market data shall be immutable.

Once raw market data has been successfully validated and stored, it shall never be modified or overwritten.

If corrections are required, they shall be handled by one of the following approaches:

- Store a new corrected record with version information.
- Record the correction in a dedicated adjustment entity.
- Preserve the original record for audit purposes.

Derived analytical data (Indicators, Features, Predictions, Signals, Reports, etc.) shall always be stored separately from raw historical market data.

---

## Rationale

Immutability guarantees that analytical results remain reproducible over time.

It also simplifies auditing, debugging, model validation, and historical comparisons.

Keeping raw data unchanged ensures that every analysis can be repeated using the exact same input dataset.

---

## Consequences

### Advantages

- Guaranteed reproducibility.
- Complete audit trail.
- Higher data integrity.
- Reliable backtesting.
- Simplified debugging.
- Better regulatory compliance if required.

### Disadvantages

- Additional storage requirements.
- Slightly more complex correction process.

---

## Alternatives Considered

### Update Historical Records

Rejected.

Reason:

Updating historical records would invalidate previous analyses and compromise reproducibility.

---

## Related Decisions

ADR-000 Architecture Principles

ADR-001 Core Independence

ADR-002 Data Source Abstraction

ADR-003 Pipeline Architecture

---

End of ADR-004