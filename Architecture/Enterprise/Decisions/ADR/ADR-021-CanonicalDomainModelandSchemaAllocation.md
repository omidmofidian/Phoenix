# ADR-021 — Canonical Domain Model and Schema Allocation

| Item     | Value                                        |
| -------- | -------------------------------------------- |
| ADR      | ADR-021                                      |
| Title    | Canonical Domain Model and Schema Allocation |
| Status   | Accepted                                     |
| Date     | 2026-07-01                                   |
| Deciders | Phoenix Architecture Team                    |
| Standard | SDS-2026.1                                   |

---

# Context

The Phoenix Platform is designed as an enterprise-grade trading platform with a long expected lifecycle, multiple deployment environments, and independently evolving functional domains.

As the system grows, the database model must remain maintainable, scalable, and understandable.

Without clear domain boundaries, databases tend to become tightly coupled, difficult to evolve, and increasingly dependent on implementation details.

Therefore, the database architecture shall be organized around business domains rather than application modules.

---

# Decision

Phoenix adopts a **Canonical Domain Model** as the single architectural reference for all persistent business entities.

Every persistent entity shall belong to exactly one canonical domain.

Every canonical domain shall be mapped to exactly one PostgreSQL schema.

The schema allocation represents business ownership rather than physical storage.

Application layers may consume multiple schemas, but ownership of every entity remains inside its canonical schema.

---

# Canonical Schemas

The platform is divided into the following canonical schemas:

* ref
* core
* market
* integration
* audit
* config
* report

Each schema represents a bounded business domain with clearly defined responsibilities.

---

# Architectural Principles

The following principles shall always apply.

### Domain Ownership

Each entity belongs to one and only one schema.

---

### Single Source of Truth

Business data shall not be duplicated across schemas.

---

### Clear Dependency Direction

Dependencies between schemas shall remain explicit and controlled.

Circular dependencies shall be avoided.

---

### Separation of Concerns

Reference, operational, configuration, audit, reporting, and integration data shall remain isolated.

---

### Stable Business Boundaries

Schema allocation is driven by business semantics rather than implementation convenience.

---

### Long-Term Maintainability

Adding new business capabilities should extend existing domains or introduce new bounded domains without restructuring existing schemas.

---

# Consequences

Positive outcomes include:

* Clear architectural boundaries.
* Improved maintainability.
* Simplified security model.
* Independent schema evolution.
* Easier database governance.
* Better support for future modularization.
* Reduced coupling between business domains.

Trade-offs include:

* Slightly increased design effort.
* More explicit cross-schema references.
* Stronger governance requirements.

These trade-offs are accepted in exchange for long-term architectural stability.

---

# Out of Scope

This ADR does not define:

* Entity catalog
* ER diagrams
* Table definitions
* Columns
* Keys
* Constraints
* Indexes
* Data types

These artifacts are maintained by the SDS documentation and may evolve without modifying this ADR.

---

# Related Documents

* ADR-018 — Database Initialization Strategy
* ADR-020 — Database Bootstrap and Security Architecture
* SDS-2026.1
* Domain Catalog (Sprint 2)
* Canonical ERD (Sprint 2)

---

# Decision Summary

Phoenix uses a canonical domain-driven database architecture.

Business entities are allocated to stable bounded schemas.

Schema ownership reflects business responsibility rather than implementation structure.

This decision establishes the architectural foundation for all future database design activities.
