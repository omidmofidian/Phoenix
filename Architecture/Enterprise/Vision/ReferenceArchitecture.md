# Phoenix Reference Architecture

---

## Document Information

| Item | Value |
|------|-------|
| Document | Reference Architecture |
| Project | Phoenix |
| Version | 0.1.0 |
| Status | Draft |
| Date | 2026-06-27 |

---

# Purpose

This document defines the overall reference architecture of the Phoenix platform.

It describes the architectural layers, domains, data flow, dependency rules, and major architectural decisions.

This document serves as the primary architectural reference for all future implementation.

---

# Architectural Vision

Phoenix is a modular, extensible, and technology-independent quantitative analysis platform.

The architecture separates business knowledge from implementation details and analytical processing.

The platform is designed according to the following principles:

- Domain-Driven Design (Pragmatic)
- Layered Architecture
- Pipeline Architecture
- Separation of Concerns
- Single Responsibility Principle
- Immutable Historical Data
- Extensibility
- Reproducibility

---

# High-Level Architecture

```
                External Data Sources
                         │
                         ▼
              Data Acquisition Layer
                         │
                         ▼
              Market Data Domain
                         │
                         ▼
              Selection Domain
                         │
                         ▼
              Analysis Pipeline
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
 Indicator Engine   Feature Engine   ML Engine
        │                │                │
        └────────────────┼────────────────┘
                         ▼
                 Prediction Engine
                         │
                         ▼
                 Signal Generation
                         │
                         ▼
                 Portfolio Management
                         │
                         ▼
              Backtesting & Research
                         │
                         ▼
                 Reporting Services
```

---

# Architectural Layers

## Layer 1 — Infrastructure Layer

Responsibilities:

- Data acquisition
- Import jobs
- External integrations
- File processing
- API communication
- Logging

Entities:

- DataProvider
- ImportJob
- ImportFile
- ImportLog

---

## Layer 2 — Core Business Layer

Responsibilities:

Represents immutable financial business knowledge.

Entities:

- Market
- Exchange
- Instrument
- Symbol
- DailyMarketData
- CorporateAction
- FinancialStatement

Rules:

- Immutable whenever practical
- No derived analytical data
- Independent from implementation

---

## Layer 3 — Reference Layer

Responsibilities:

Provides classification and metadata.

Entities:

- Sector
- Industry
- TradingCalendar
- TradingSession

---

## Layer 4 — Selection Layer

Responsibilities:

Defines analytical scopes.

Entities:

- TradingUniverse
- UniverseMembership

---

## Layer 5 — Analysis Layer

Responsibilities:

Transforms market data into analytical information.

Entities:

- IndicatorDefinition
- IndicatorValue
- FeatureDefinition
- FeatureValue

---

## Layer 6 — Intelligence Layer

Responsibilities:

Machine Learning

Probability estimation

Prediction generation

Entities:

- Prediction
- ModelVersion
- Experiment

---

## Layer 7 — Decision Layer

Responsibilities:

Generate investment decisions.

Entities:

- Strategy
- Signal

---

## Layer 8 — Portfolio Layer

Responsibilities:

Investment tracking.

Entities:

- Portfolio
- Position
- Trade

---

## Layer 9 — Research Layer

Responsibilities:

Historical evaluation.

Entities:

- Backtest
- Report

---

# Data Flow

```
External Source

↓

Import

↓

Validation

↓

DailyMarketData

↓

Indicators

↓

Features

↓

Prediction

↓

Signal

↓

Trade

↓

Portfolio

↓

Backtest

↓

Report
```

---

# Dependency Rules

Each layer may depend only on lower layers.

```
Research

↓

Portfolio

↓

Decision

↓

Intelligence

↓

Analysis

↓

Selection

↓

Reference

↓

Core Business

↓

Infrastructure
```

Upward dependencies are prohibited.

---

# Domain Boundaries

Core Domain

- Market
- Instrument
- Symbol
- DailyMarketData

Supporting Domains

- Selection
- Portfolio
- Research

Infrastructure Domains

- Import
- Logging
- Data Providers

---

# Cross-Cutting Concerns

Applicable to every layer:

- Logging
- Configuration
- Exception Handling
- Validation
- Security
- Auditing

---

# Architectural Constraints

Historical market data shall remain immutable.

Business entities shall not contain derived analytical data.

All external data shall enter through Data Providers.

Analytical modules shall never modify business entities.

Every major architectural decision shall be documented through an ADR.

---

# Supported Workflows

- Historical data import
- Indicator calculation
- Feature engineering
- Machine learning
- Signal generation
- Backtesting
- Portfolio evaluation
- Reporting

---

# Reference ADRs

- ADR-000 Architecture Principles
- ADR-001 Core Independence
- ADR-002 Data Source Abstraction
- ADR-003 Pipeline Architecture
- ADR-004 Immutable Historical Data
- ADR-005 Selection Domain
- ADR-006 Business Time and System Time Separation
- ADR-007 DailyMarketData Entity
- ADR-008 Separation of Core Business Entities and Derived Analytical Entities

---

# Future Extensions

The architecture has been intentionally designed to support future capabilities, including:

- Real-time market data
- Intraday analysis
- Multi-market support
- Multi-currency portfolios
- Distributed computation
- GPU-accelerated machine learning
- Plugin-based analytical engines
- Broker integration
- Automated order execution

These capabilities shall be implemented without requiring modifications to the Core Business Layer.

---

End of Reference Architecture