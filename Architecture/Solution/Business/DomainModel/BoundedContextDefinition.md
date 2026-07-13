# SDS-2026.1

# Bounded Context Definition

**Document ID**

SDS-BCD-001

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

This document defines the bounded contexts of the Phoenix Platform.

A bounded context establishes the ownership boundary of a business domain.

Each context owns its business concepts, terminology, rules, lifecycle, and consistency boundaries.

Bounded contexts are independent of database implementation and physical storage.

---

# Architectural Principles

A bounded context:

* owns its business language;
* owns its business rules;
* owns its business entities;
* exposes contracts to other contexts;
* shall not duplicate ownership of another context.

---

# Context Map

## BCX-01 Identity Context

Purpose

Identity, authentication, authorization and access management.

Responsibilities

* Users
* Roles
* Permissions
* Authentication
* Authorization
* Sessions

Consumes

Reference Context

---

## BCX-02 Organization Context

Purpose

Business ownership and organizational hierarchy.

Responsibilities

* Organizations
* Companies
* Branches
* Departments

Consumes

Reference Context

---

## BCX-03 Portfolio Context

Purpose

Customer investment structures.

Responsibilities

* Portfolios
* Accounts
* Positions
* Holdings

Consumes

Identity Context

Organization Context

Reference Context

Market Context

---

## BCX-04 Trading Context

Purpose

Trading lifecycle.

Responsibilities

* Orders
* Executions
* Trades
* Allocations

Consumes

Portfolio Context

Market Context

Reference Context

---

## BCX-05 Market Context

Purpose

Market information.

Responsibilities

* Instruments
* Listings
* Quotes
* Candles
* Order Books
* Corporate Actions

Consumes

Reference Context

---

## BCX-06 Reference Context

Purpose

Enterprise master data.

Responsibilities

* Countries
* Exchanges
* Currencies
* Calendars
* Languages
* Time Zones
* Instrument Classifications

Consumes

None

---

## BCX-07 Configuration Context

Purpose

Application configuration.

Responsibilities

* System Parameters
* Feature Flags
* Environment Settings

Consumes

None

---

## BCX-08 Reporting Context

Purpose

Business reporting and analytical models.

Responsibilities

* Reports
* Dashboards
* Analytical Views

Consumes

All operational contexts

---

## BCX-09 Audit Context

Purpose

Operational traceability.

Responsibilities

* Audit Logs
* Change History
* Security Events
* Login History

Consumes

All operational contexts

---

## BCX-10 Integration Context

Purpose

External communication.

Responsibilities

* Broker Connections
* Provider Connections
* Import Jobs
* Export Jobs
* Webhooks
* External APIs

Consumes

Operational contexts as required

---

# Context Dependency Rules

Reference Context is the foundation of the system.

Operational contexts may consume Reference Context but shall never modify it.

Reporting Context is read-only.

Audit Context records activities but does not own operational business data.

Integration Context exchanges information without becoming the owner of external business entities.

Identity Context shall remain independent from Trading and Market business logic.

---

# Context Ownership

Each business entity belongs to one and only one bounded context.

Cross-context communication shall occur through explicit contracts.

No entity shall have multiple owners.

---

# Out of Scope

This document does not define:

* Schemas
* Tables
* Columns
* Keys
* Constraints
* Indexes

Those artifacts are defined in subsequent documents.

---

# Next Document

Canonical Domain Model

(Document SDS-CDM-001)
