# ADR-008 : Separation of Core Business Entities and Derived Analytical Entities

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

The Phoenix platform processes raw financial market data through multiple analytical stages, including technical analysis, feature engineering, prediction models, signal generation, portfolio management, and research activities.

During system evolution, there is a significant risk that analytical results may become embedded within core business entities.

Mixing raw business data with derived analytical data would violate the Single Responsibility Principle, increase coupling, reduce maintainability, and compromise data integrity.

A clear architectural separation is therefore required.

---

## Decision

Phoenix shall maintain a strict separation between Core Business Entities and Derived Analytical Entities.

Core Business Entities represent immutable business facts collected from external financial markets.

Derived Analytical Entities represent information generated internally by analytical processes.

Derived entities shall reference Core Business Entities but shall never modify, extend, or embed analytical data within them.

---

## Entity Classification

### Core Business Entities

Examples include:

- Market
- Exchange
- Instrument
- Symbol
- DailyMarketData
- CorporateAction
- FinancialStatement

Characteristics

- Represent real-world business facts.
- Independent of analytical models.
- Immutable whenever practical.
- Long-lived.
- Technology independent.

---

### Derived Analytical Entities

Examples include:

- IndicatorDefinition
- IndicatorValue
- FeatureDefinition
- FeatureValue
- Prediction
- Signal

Characteristics

- Generated internally.
- Reproducible.
- Disposable and regenerable.
- Dependent on analytical workflows.
- Never modify raw market data.

---

## Architectural Rules

The following rules shall always apply:

1. Core Business Entities shall never contain calculated values.

2. Technical indicators shall be stored only in IndicatorValue.

3. Engineered features shall be stored only in FeatureValue.

4. Predictions shall never modify historical market data.

5. Signals shall reference Predictions rather than DailyMarketData directly whenever practical.

6. Historical market data shall remain immutable.

7. Analytical data may be deleted and regenerated without affecting business data.

---

## Rationale

Maintaining a strict separation between business data and analytical data improves architectural clarity and supports long-term maintainability.

This separation enables independent evolution of analytical algorithms without requiring changes to the underlying business model.

It also guarantees reproducibility, simplifies auditing, and allows analytical results to be regenerated whenever models or parameters change.

The approach aligns with the principles established in ADR-000 (Architecture Principles), ADR-004 (Immutable Historical Data), and ADR-007 (DailyMarketData Entity).

---

## Consequences

### Advantages

- Clear separation of concerns.
- Higher maintainability.
- Improved extensibility.
- Better reproducibility.
- Easier testing.
- Simplified auditing.
- Independent evolution of analytical models.
- Reduced technical debt.

### Disadvantages

- Additional entities.
- More relationships.
- Slightly more complex logical model.

---

## Alternatives Considered

### Embedding Indicators inside DailyMarketData

Rejected.

Reason:

Violates architectural separation and creates tight coupling between market data and analytical models.

---

### Storing Features inside Prediction records

Rejected.

Reason:

Features are reusable analytical artifacts and should remain independent from prediction models.

---

## Related Decisions

ADR-000 Architecture Principles

ADR-001 Core Independence

ADR-003 Pipeline Architecture

ADR-004 Immutable Historical Data

ADR-006 Business Time and System Time Separation

ADR-007 DailyMarketData Entity

---

## Impact Analysis

This decision affects the following architectural documents:

| Document | Action |
|----------|--------|
| DomainModel.md | Update |
| EntityClassification.md | Update |
| ConceptualModel.md | Review |
| LogicalModel.md | Update |
| PhysicalModel.md | Review |
| SDD | Reference |
| Future ERD | Update |

---

End of ADR-008