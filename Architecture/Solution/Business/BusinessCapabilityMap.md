# SDS-2026.1

# Business Capability Map

**Document ID**

SDS-BCM-001

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

This document defines the business capabilities of the Phoenix Platform.

Business capabilities represent stable business functions independent of implementation technology, database design, user interface, deployment architecture, or organizational structure.

All domain models, schemas, entities, services, APIs, and database objects shall be derived from these capabilities.

---

# Architectural Principles

Business capabilities shall:

* represent business functions;
* remain stable over time;
* be technology independent;
* be implementation independent;
* be mutually exclusive;
* collectively describe the complete business scope.

---

# Capability Hierarchy

## BC-01 Identity and Access Management

Responsible for authentication, authorization, security, identities, roles, permissions, and access control.

Typical responsibilities include:

* User management
* Authentication
* Authorization
* Roles
* Permissions
* Security policies

---

## BC-02 Organization Management

Responsible for organizational structures and ownership.

Typical responsibilities include:

* Organizations
* Companies
* Branches
* Departments
* Business ownership

---

## BC-03 Portfolio Management

Responsible for customer investment structures.

Typical responsibilities include:

* Portfolios
* Accounts
* Holdings
* Positions
* Investment ownership

---

## BC-04 Trading

Responsible for the complete trading lifecycle.

Typical responsibilities include:

* Orders
* Executions
* Trades
* Allocations
* Order lifecycle

---

## BC-05 Market Data

Responsible for all market-related information.

Typical responsibilities include:

* Instruments
* Symbols
* Quotes
* Candlesticks
* Order books
* Corporate actions

---

## BC-06 Reference Data

Responsible for master and shared business data.

Typical responsibilities include:

* Countries
* Currencies
* Exchanges
* Calendars
* Languages
* Time zones
* Instrument classifications

---

## BC-07 Configuration Management

Responsible for configurable system behavior.

Typical responsibilities include:

* System parameters
* Feature flags
* Application configuration
* Environment configuration

---

## BC-08 Reporting and Analytics

Responsible for business reporting.

Typical responsibilities include:

* Reports
* Dashboards
* Analytical views
* Materialized reporting objects

---

## BC-09 Audit and Compliance

Responsible for traceability and regulatory compliance.

Typical responsibilities include:

* Audit logs
* Change history
* Login history
* Security events
* Operational logs

---

## BC-10 Integration

Responsible for communication with external systems.

Typical responsibilities include:

* Broker connectivity
* Market providers
* Import
* Export
* Webhooks
* External APIs

---

# Capability Dependency Principles

Capabilities are designed to minimize coupling.

Reference Data provides shared business definitions for all other capabilities.

Audit records activities but does not own operational business data.

Reporting consumes operational data but does not own business entities.

Integration exchanges information with external systems without owning business processes.

---

# Out of Scope

This document does not define:

* Domains
* Schemas
* Entities
* Tables
* Database objects
* APIs
* Services

These artifacts are specified in subsequent architecture documents.

---

# Next Document

Canonical Domain Model

(Document SDS-CDM-001)
