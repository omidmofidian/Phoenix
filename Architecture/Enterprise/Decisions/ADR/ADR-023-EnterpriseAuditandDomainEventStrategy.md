# ADR-023 — Enterprise Audit and Domain Event Strategy

| Property | Value |
|----------|-------|
| ADR ID | ADR-023 |
| Title | Enterprise Audit and Domain Event Strategy |
| Status | Accepted |
| Decision Date | 2026-07-09 |
| Owner | Enterprise Architecture |

---

# Context

Phoenix Platform is designed as a long-lived enterprise platform following Domain-Driven Design (DDD), Service-Oriented Architecture (SOA), and Architecture-First principles.

The platform requires a complete audit capability for governance, traceability, regulatory compliance, and operational diagnostics.

At the same time, future architectural evolution may require asynchronous communication between services, domain event publication, workflow orchestration, and event-driven processing.

Although these capabilities are related, they serve different architectural purposes.

A clear enterprise strategy is therefore required to prevent coupling between auditing and business event processing.

---

# Decision

Phoenix distinguishes **Audit Events** from **Domain Events** as two independent architectural concepts.

## Audit Events

Audit Events exist to provide enterprise traceability.

Their purpose is to record:

- business operations
- data modifications
- security activities
- administrative actions
- execution history

Audit Events are historical records.

They are immutable.

They are append-only.

They never execute business logic.

---

## Domain Events

Domain Events represent significant business occurrences inside a bounded context.

Examples include:

- Instrument Listed
- Trading Day Closed
- Market Data Imported
- Corporate Action Published
- Portfolio Rebalanced

Domain Events communicate business state changes.

They may trigger additional business processes.

They are part of the business model rather than the audit model.

---

# Architectural Principles

The following principles shall govern both concepts.

## Principle 1

Audit Events and Domain Events are independent.

Neither replaces the other.

---

## Principle 2

Every Domain Event may generate one or more Audit Events.

The reverse is not necessarily true.

---

## Principle 3

Audit storage shall never become the integration mechanism between services.

---

## Principle 4

Business services shall not consume Audit Events for business processing.

---

## Principle 5

Domain Events shall remain technology independent.

No specific messaging platform is assumed.

---

## Principle 6

The platform shall support future implementation of:

- Event Bus
- Message Queue
- Event Streaming
- Outbox Pattern
- Event Replay

without requiring changes to the business model.

---

# Consequences

## Positive

- Clear separation of responsibilities.
- Strong enterprise traceability.
- Support for future Event-Driven Architecture.
- Easier migration toward distributed services.
- Better scalability.
- Better maintainability.
- Improved architectural consistency.

---

## Negative

- Additional architectural concepts must be maintained.
- Event definitions require governance.
- Audit and messaging infrastructures evolve independently.

---

# Current Implementation Strategy

Current Sprint

- Audit Domain is implemented.
- Domain Events are not implemented.

Future Sprint

- Domain Event Catalog
- Event Contracts
- Event Bus
- Integration Messaging
- Event Versioning
- Outbox Pattern

---

# Related ADRs

- ADR-002 — Data Source Abstraction
- ADR-007 — Daily Market Data Entity
- ADR-012 — Service-Oriented Modular Architecture
- ADR-013 — Documentation as Code
- ADR-017 — External Business Identifier Strategy
- ADR-020 — Database Bootstrap and Security Architecture
- ADR-021 — Canonical Domain Model and Schema Allocation

---

# Related Artifacts

- AuditDomainLogicalModel
- IntegrationDomainLogicalModel
- CanonicalBusinessRules
- AggregateCatalog
- EnterpriseRelationshipMatrix (planned)

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial enterprise audit and domain event strategy |