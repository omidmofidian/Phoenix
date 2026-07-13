# Knowledge

## Purpose

The **Knowledge** folder serves as the centralized knowledge repository for the Phoenix Platform.

Unlike the **Architecture** and **Design** layers, which define how the platform is structured and implemented, the Knowledge layer captures the business, financial, and domain expertise upon which the platform is built.

It is the authoritative source of domain knowledge used throughout the entire project lifecycle.

---

# Scope

The Knowledge layer contains information that is independent of implementation technology and software architecture.

Typical knowledge artifacts include:

- Financial Market Knowledge
- Trading Concepts
- Market Regulations
- Financial Terminology
- Market Structures
- Trading Workflows
- Asset Class Definitions
- Market Data Concepts
- Reference Standards
- Research Notes
- Analytical Methodologies

---

# Objectives

The Knowledge layer aims to:

- Establish a common business vocabulary.
- Preserve financial domain expertise.
- Eliminate ambiguity in terminology.
- Support architectural and design decisions.
- Provide a reusable knowledge base for future platform enhancements.
- Reduce dependency on undocumented business knowledge.

---

# Folder Structure

```text
Knowledge/
│
├── FinancialMarkets/
│
├── Trading/
│
├── Analytics/
│
├── ArtificialIntelligence/
│
├── DataProviders/
│
├── Regulations/
│
├── Research/
│
└── Reference/
```

---

# Folder Responsibilities

## FinancialMarkets

Contains comprehensive information about supported financial markets.

Examples:

- Iran Capital Market
- Forex Market
- Cryptocurrency Market
- Commodity Market
- Bond Market
- Derivatives Market

---

## Trading

Contains trading-related knowledge.

Examples:

- Trading Lifecycle
- Order Types
- Execution Models
- Settlement Models
- Trading Sessions
- Market Calendars

---

## Analytics

Contains analytical methodologies.

Examples:

- Technical Analysis
- Quantitative Analysis
- Statistical Models
- Performance Metrics
- Risk Metrics
- Portfolio Analytics

---

## ArtificialIntelligence

Contains AI and Machine Learning knowledge.

Examples:

- Machine Learning Concepts
- Feature Engineering
- Model Evaluation
- Time Series Forecasting
- Reinforcement Learning
- AI Governance

---

## DataProviders

Contains knowledge related to market data sources.

Examples:

- TSETMC
- MetaTrader
- Interactive Brokers
- Binance
- Yahoo Finance
- Alpha Vantage
- Polygon.io

---

## Regulations

Contains regulatory information.

Examples:

- Market Rules
- Trading Restrictions
- Corporate Actions
- Settlement Regulations
- Exchange Rules

---

## Research

Contains research documents supporting future development.

Examples:

- Literature Reviews
- Market Studies
- Algorithm Comparisons
- Strategy Evaluations
- Technology Assessments

---

## Reference

Contains reference material used throughout the project.

Examples:

- ISO Standards
- Market Identifier Codes
- Currency Codes
- Country Codes
- Time Zone References
- Industry Classification Standards

---

# Responsibilities

The Knowledge layer is responsible for:

- Maintaining business knowledge.
- Preserving financial expertise.
- Standardizing terminology.
- Supporting Architecture and Design.
- Providing educational resources for contributors.
- Recording research findings.

---

# Out of Scope

The following artifacts shall NOT be stored here:

- Source Code
- SQL Scripts
- Architecture Decisions
- Database Models
- ER Diagrams
- Sprint Documentation
- Project Planning
- Operational Procedures

These artifacts belong to other repository areas.

---

# Relationship with Other Layers

```text
Knowledge
      │
      ▼
Architecture
      │
      ▼
Design
      │
      ▼
Implementation
      │
      ▼
Operations
```

The Knowledge layer provides the domain expertise that drives architectural decisions and technical design.

---

# Related Documentation

- Docs/Architecture
- Docs/Design
- Docs/Standards

---

# Ownership

Financial Domain Team

Architecture Team

Research Team

---

# Knowledge Governance

Knowledge artifacts shall:

- Be fact-based and verifiable.
- Reference authoritative sources whenever possible.
- Remain independent of implementation technologies.
- Use standardized terminology.
- Be periodically reviewed and updated.

Knowledge documents should represent long-term business understanding rather than temporary implementation decisions.

---

# Repository Compliance

Every knowledge document shall belong to a clearly defined business or financial domain.

Knowledge shall not duplicate architectural or design documentation.

Cross-references shall be preferred over repeated content.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2.0 | 2026-07-08 | Initial Knowledge README aligned with Repository Baseline v2.0. |