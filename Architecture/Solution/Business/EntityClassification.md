# Entity Classification

---

## Purpose

This document classifies all entities within the Phoenix platform according to their architectural responsibility.

Entity classification improves consistency across the Domain Model, Database Design, Software Architecture, and implementation.

Each entity belongs to exactly one primary category.

---

# Entity Categories

The Phoenix architecture classifies entities into the following categories.

---

## 1. Core Business Entities

Core Business Entities represent the fundamental concepts of the financial domain.

They are independent of implementation technology.

Examples:

- Market
- Exchange
- Instrument
- Symbol
- DailyMarketData
- CorporateAction
- FinancialStatement

Characteristics

- Represent real-world business concepts
- Long-lived
- Immutable whenever practical
- Used throughout the entire platform

---

## 2. Reference Entities

Reference Entities provide classification and metadata.

Examples

- Sector
- Industry
- TradingCalendar
- TradingSession

Characteristics

- Low update frequency
- Shared by multiple domains
- Used primarily for classification

---

## 3. Selection Entities

Selection Entities define subsets of financial instruments for analytical purposes.

Examples

- TradingUniverse
- UniverseMembership

Characteristics

- User-defined
- Reusable
- Independent of analysis logic

---

## 4. Derived Analytical Entities

Derived Analytical Entities are produced from raw market data.

Examples

- IndicatorDefinition
- IndicatorValue
- FeatureDefinition
- FeatureValue
- Prediction
- Signal

Characteristics

- Never modify raw market data
- Reproducible
- May be regenerated at any time

---

## 5. Strategy Entities

Strategy Entities define investment decision logic.

Examples

- Strategy
- StrategyParameter
- StrategyVersion

Characteristics

- Version controlled
- Reusable
- Independent from market data

---

## 6. Portfolio Entities

Portfolio Entities represent investment holdings and trading activities.

Examples

- Portfolio
- Position
- Trade

Characteristics

- Transaction-oriented
- Historical
- Auditable

---

## 7. Research Entities

Research Entities support quantitative research and experimentation.

Examples

- Backtest
- Experiment
- ModelVersion
- Report

Characteristics

- Reproducible
- Independent
- Experimental

---

## 8. Operational Entities

Operational Entities support system operation.

Examples

- DataProvider
- ImportJob
- ImportFile
- ImportLog

Characteristics

- Infrastructure related
- Not part of the financial domain
- Support platform operations

---

# Entity Dependency Rules

Core Business Entities shall never depend on any other category.

Reference Entities may be referenced by Core Business Entities.

Selection Entities may reference Core Business Entities.

Derived Analytical Entities may reference Core Business Entities but shall never modify them.

Portfolio Entities may reference Signals and Predictions.

Operational Entities shall never contain business logic.

Research Entities may reference any entity but shall never modify Core Business Entities.

---

# Layer Dependency

```

Operational

↓

Core Business

↓

Reference

↓

Selection

↓

Derived Analytics

↓

Strategy

↓

Portfolio

↓

Research

```

Dependencies are allowed only in the downward direction unless explicitly documented by an ADR.

---

# Architectural Principles

- Core Business Entities are immutable whenever practical.
- Derived entities are reproducible.
- Business logic belongs to services, not entities.
- Raw market data shall never contain analytical results.
- Every entity has a single architectural responsibility.

---

End of Entity Classification