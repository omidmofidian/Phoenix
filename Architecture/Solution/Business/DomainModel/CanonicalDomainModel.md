# SDS-2026.1

# Canonical Domain Model

**Document ID**

SDS-CDM-001

**Project**

Phoenix Platform

**Version**

2026.1

**Status**

Approved

**Sprint**

Sprint 2

---

# Purpose

The Canonical Domain Model defines the stable business structure of the Phoenix Platform.

This model represents business concepts only.

It is independent of:

* PostgreSQL
* Tables
* Schemas
* Services
* APIs
* UI
* Deployment

All technical artifacts shall be derived from this model.

---

# Domain Hierarchy

Phoenix Platform

│

├── Identity Domain

│ ├── Identity Management

│ ├── Authorization

│ └── Security

│

├── Organization Domain

│ ├── Organization Structure

│ ├── Company

│ └── Department

│

├── Portfolio Domain

│ ├── Portfolio

│ ├── Account

│ ├── Position

│ └── Holding

│

├── Trading Domain

│ ├── Order

│ ├── Execution

│ ├── Trade

│ └── Allocation

│

├── Market Domain

│ ├── Instrument

│ ├── Listing

│ ├── Market Data

│ ├── Quote

│ ├── Candle

│ └── Corporate Action

│

├── Reference Domain

│ ├── Geography

│ ├── Currency

│ ├── Calendar

│ ├── Exchange

│ ├── Classification

│ └── Localization

│

├── Configuration Domain

│ ├── Application Configuration

│ ├── System Parameters

│ └── Feature Flags

│

├── Audit Domain

│ ├── Audit

│ ├── Compliance

│ ├── Logging

│ └── Security Events

│

├── Reporting Domain

│ ├── Reporting

│ ├── Dashboard

│ └── Analytics

│

└── Integration Domain

├── Broker Connectivity

├── Provider Connectivity

├── Import

├── Export

└── Webhooks

---

# Domain Principles

Every business concept belongs to exactly one domain.

Domains own business terminology.

Domains own business rules.

Domains do not own implementation details.

Domains communicate through contracts.

No business concept shall have multiple owners.

---

# Subdomain Classification

Each domain is classified as one of the following.

## Core Domain

Provides competitive business value.

Examples

* Trading
* Portfolio

---

## Supporting Domain

Supports the Core Domains.

Examples

* Identity
* Organization
* Reporting

---

## Generic Domain

Shared enterprise services.

Examples

* Reference
* Configuration
* Audit
* Integration

---

# Domain Dependency

Reference Domain

↓

All Domains

Identity Domain

↓

Portfolio Domain

↓

Trading Domain

↓

Reporting Domain

Audit Domain

receives events from all domains.

Integration Domain

communicates with external systems without owning business entities.

---

# Stability

The Canonical Domain Model shall remain stable.

Changes require architectural review.

Entities may evolve.

Tables may evolve.

Services may evolve.

Domains should remain stable.

---

# Derived Artifacts

The following documents shall be derived from this model.

* Entity Catalog

* Aggregate Definitions

* Canonical ERD

* Schema Allocation

* Physical Database Design

* APIs

* Service Contracts

---

# Out of Scope

This document does not define:

* Entities

* Tables

* Columns

* Keys

* Constraints

* Data Types

* Database Objects

These are specified by subsequent architecture documents.

---

# Next Document

Entity Catalog

(Document SDS-EC-001)
