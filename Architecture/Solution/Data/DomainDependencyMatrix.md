# Domain Dependency Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | MAT-004 |
| Document | DomainDependencyMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Logical Data Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalDomainModel, AggregateDependencyMatrix, EnterpriseRelationshipMatrix |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical dependency relationships among the business domains of the Phoenix Platform.

It establishes the permitted dependency directions between domains and serves as the authoritative reference for service architecture, modularization, dependency validation and implementation governance.

This document is implementation independent.

---

# 2. Architectural Principles

The following principles govern domain dependencies.

- Domain dependencies shall always be unidirectional.
- Circular dependencies between domains are prohibited.
- Lower-level domains shall never depend on higher-level domains.
- Cross-domain interactions shall occur only through published interfaces.
- Reporting shall consume data without introducing business dependencies.
- Audit shall observe domains without influencing their behavior.

---

# 3. Domain Dependency Matrix

| Source Domain | Reference | Core | Market | Integration | Audit | Configuration | Reporting |
|---------------|:---------:|:----:|:------:|:-----------:|:-----:|:-------------:|:---------:|
| **Reference** | — | ✕ | ✕ | ✕ | ✕ | ✕ | ✕ |
| **Core** | ✓ | — | ✕ | ✕ | ✕ | ✕ | ✕ |
| **Market** | ✓ | ✓ | — | ✕ | ✕ | ✓ | ✕ |
| **Integration** | ✓ | ✓ | ✓ | — | ✕ | ✓ | ✕ |
| **Audit** | ✓ | ✓ | ✓ | ✓ | — | ✓ | ✕ |
| **Configuration** | ✕ | ✕ | ✕ | ✕ | ✕ | — | ✕ |
| **Reporting** | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | — |

Legend:

- ✓ Allowed Dependency
- ✕ Not Allowed
- — Same Domain

---

# 4. Dependency Summary

| Domain | Depends On |
|----------|------------|
| Reference | None |
| Core | Reference |
| Market | Reference, Core, Configuration |
| Integration | Reference, Core, Market, Configuration |
| Audit | Reference, Core, Market, Integration, Configuration |
| Configuration | None |
| Reporting | All Domains |

---

# 5. Dependency Layers

```text
                Reporting
                    ▲
                    │
                 Audit
                    ▲
                    │
              Integration
                    ▲
                    │
                Market
                    ▲
                    │
                 Core
                    ▲
                    │
              Reference

Configuration
      │
      └────────────► Consumed by Runtime Domains
```

---

# 6. Dependency Rules

## Reference Domain

- Independent.
- Shall not depend on any other domain.

---

## Core Domain

- Depends only on Reference.
- Defines enterprise business entities.

---

## Market Domain

- Depends on Core and Reference.
- Defines market activities and observations.

---

## Integration Domain

- Depends on Reference, Core and Market.
- Responsible for external system integration.
- Shall never own business entities.

---

## Audit Domain

- May observe every operational domain.
- Shall never introduce business behavior.
- Shall remain append-only.

---

## Configuration Domain

- Independent.
- Provides runtime configuration.
- Shall not depend on business domains.

---

## Reporting Domain

- Read-only.
- May consume information from every domain.
- Shall never own business entities.

---

# 7. Validation Rules

The following rules shall always hold.

- Circular dependencies are prohibited.
- Dependency direction shall follow the enterprise architecture.
- Cross-domain communication shall occur only through published contracts.
- Configuration shall never depend on operational domains.
- Reporting shall remain read-only.
- Audit shall remain observational.

---

# 8. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalDomainModel | Domain definitions |
| AggregateDependencyMatrix | Aggregate dependencies |
| EnterpriseRelationshipMatrix | Entity relationships |
| CanonicalServiceCatalog | Service ownership |
| ServiceContextMap | Service boundaries |
| ADR-012-Service-OrientedModularArchitecture | Service architecture principles |
| ADR-023-EnterpriseAuditandDomainEventStrategy | Audit architecture |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Domain Dependency Matrix |