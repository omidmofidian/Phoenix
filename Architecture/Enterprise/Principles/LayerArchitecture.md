# Layer Architecture

---

## Purpose

This document defines the static architectural organization of the Phoenix platform.

Layers organize responsibilities.

They do not describe execution flow.

---

# Layer Overview

```
Presentation Layer

↓

Application Layer

↓

Analysis Layer

↓

Selection Layer

↓

Reference Layer

↓

Core Business Layer

↓

Infrastructure Layer
```

---

## Infrastructure Layer

Responsibilities

- Data import
- External APIs
- File processing
- Database access
- Logging

Contains

- DataProvider
- ImportJob
- ImportFile
- ImportLog

---

## Core Business Layer

Responsibilities

Represents immutable business knowledge.

Contains

- Market
- Exchange
- Instrument
- Symbol
- DailyMarketData
- CorporateAction
- FinancialStatement

---

## Reference Layer

Contains

- Sector
- Industry
- TradingCalendar
- TradingSession

---

## Selection Layer

Contains

- TradingUniverse
- UniverseMembership

---

## Analysis Layer

Contains

- IndicatorDefinition
- IndicatorValue
- FeatureDefinition
- FeatureValue
- Prediction
- Strategy
- Signal

---

## Application Layer

Coordinates workflows.

Contains

- Import Service
- Analysis Service
- Backtest Service
- Portfolio Service

---

## Presentation Layer

Contains

- Desktop UI
- REST API
- CLI
- Reports

---

End