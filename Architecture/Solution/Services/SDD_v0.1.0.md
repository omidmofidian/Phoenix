# Software Design Document (SDD)

---

## Project Information

| Item | Value |
|------|-------|
| Project Name | Phoenix |
| Version | 0.1 |
| Status | Draft |
| Date | 2026-06-27 |
| Platform | Windows 11 / Linux |
| Language | Python 3.12+ |
| Database | PostgreSQL |
| IDE | Visual Studio Code |

---

# 1. Introduction

## 1.1 Purpose

The purpose of this document is to describe the architecture, design principles, functional requirements, and technical decisions of the Phoenix project.

This document serves as the primary reference throughout the software development lifecycle.

---

## 1.2 Project Definition

Phoenix is a modular Quantitative Analysis Platform designed to assist investment decision-making by analyzing historical market data, engineered features, statistical models, and machine learning algorithms.

The platform estimates the probability of successful trading opportunities instead of attempting deterministic price prediction.

---

## 1.3 Mission Statement

Design and develop an extensible quantitative analysis platform capable of supporting investment decisions through statistical analysis, feature engineering, risk assessment, and machine learning techniques.

---

## 1.4 Scope

Version 1.0 includes:

- End-of-Day (EOD) market analysis
- Historical database
- Technical indicators
- Feature engineering
- Strategy framework
- Backtesting engine
- Signal generation
- Reporting system

Excluded from Version 1.0:

- Real-time trading
- Order execution
- Broker connectivity
- High-frequency trading

---

## 1.5 Design Principles

- Architecture before implementation
- Modularity
- Extensibility
- Separation of concerns
- Data integrity
- Reproducibility
- Maintainability
- Testability

---

## 1.6 Architectural Decisions

### ADR-001

Core modules must remain independent from any specific financial market.

### ADR-002

Data acquisition shall be implemented through interchangeable Data Adapters.

---

End of Chapter 1