# ADR-000 : Architecture Principles

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

The Phoenix project is intended to become a long-term, extensible, and maintainable quantitative analysis platform.

To ensure consistency across architectural decisions, implementation, documentation, and future development, a set of fundamental architectural principles is required.

These principles serve as the foundation for all subsequent Architecture Decision Records (ADRs).

---

## Decision

The Phoenix platform shall follow the architectural principles listed below.

### 1. Architecture Before Implementation

No implementation shall begin before the corresponding architectural design has been reviewed and approved.

---

### 2. Separation of Concerns

Each module shall have a clearly defined responsibility.

Business logic, infrastructure, presentation, and data access must remain separated.

---

### 3. Single Responsibility Principle

Every class, module, and component should have only one reason to change.

---

### 4. Domain Independence

The Core domain model shall remain independent from any specific financial market, broker, exchange, or data provider.

---

### 5. Data Integrity

Historical market data shall never be modified after being stored.

Derived data shall always be stored separately from raw data.

---

### 6. Extensibility

The architecture shall support future extensions without requiring modifications to existing Core components.

---

### 7. Reproducibility

Given identical input data and configuration, the system shall always produce identical outputs.

---

### 8. Testability

All components shall be designed to support independent testing.

Dependencies should be minimized and clearly defined.

---

### 9. Modularity

The system shall be organized into loosely coupled and highly cohesive modules.

---

### 10. Documentation First

Every significant architectural decision shall be documented before implementation.

---

### 11. Configuration over Hard Coding

Business rules, thresholds, and environment-specific settings shall be configurable whenever practical.

Hard-coded values should be avoided.

---

### 12. Simplicity

Architectural solutions should remain as simple as possible while satisfying functional and non-functional requirements.

Unnecessary complexity shall be avoided.

---

### 13. Consistent Naming

Business entities shall use a single canonical name throughout the project.

The same entity name shall be used consistently across architecture documents, database models, source code, APIs, and technical documentation.

Business entity names shall follow the PascalCase naming convention.

---

### 14. Ubiquitous Language

Phoenix shall maintain a common domain vocabulary.

Each business concept shall have exactly one official term.

All stakeholders, documentation, and implementation shall use the same terminology.

The project glossary is the authoritative source for domain terminology.

---

### 15. Documentation Consistency

Architectural documents shall remain consistent at all times.

Whenever an Architecture Decision Record (ADR) changes the architecture, every affected document shall be reviewed and updated accordingly.

No architectural document shall contradict an accepted ADR.

---

## Consequences

### Advantages

- Consistent architecture.
- Improved maintainability.
- Better scalability.
- Easier onboarding.
- Higher software quality.
- Reduced technical debt.

### Disadvantages

- Higher initial design effort.
- More documentation to maintain.

---

## Related Decisions

This ADR serves as the foundation for all subsequent ADRs.

---

End of ADR-000