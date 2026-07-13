# Enterprise Identity Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-008 |
| Document | EnterpriseIdentityStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the enterprise identity model used throughout the Phoenix Platform.

The objective is to establish a consistent identity strategy that separates business identity, canonical platform identity, and external system identities.

This standard applies to every persistent business entity.

---

# 2. Identity Principles

Phoenix distinguishes between three independent identity layers:

- Business Identity
- Canonical Identity
- External Identity

Each layer serves a distinct architectural purpose and shall not be used interchangeably.

---

# 3. Canonical Identity

The Canonical Identity is the internal identity of an entity within the Phoenix Platform.

Characteristics:

- Globally unique
- Immutable
- Technology independent
- Used across all services
- Never exposed as a business identifier

Recommended implementation:

- UUID (UUIDv7 when available; otherwise UUIDv4)

Example:

```text
550e8400-e29b-41d4-a716-446655440000
```

---

# 4. Business Identity

The Business Identity represents the business meaning of an entity.

Characteristics:

- Stable
- Human recognizable
- Business governed
- May follow international standards

Examples:

| Entity | Business Identifier |
|---------|---------------------|
| Country | ISO 3166-1 Alpha-2 |
| Currency | ISO 4217 |
| Language | ISO 639-1 |
| TimeZone | IANA Time Zone ID |
| Exchange | MIC (where applicable) |
| Market | Enterprise Market Code |

Business identifiers shall remain immutable.

---

# 5. External Identity

External identities map Phoenix entities to external systems.

Characteristics:

- Provider-specific
- Optional
- Multiple mappings permitted
- Independently managed

Examples:

| Provider | Example |
|----------|----------|
| TSETMC | 46348559193224090 |
| MetaTrader | EURUSD |
| Binance | BTCUSDT |
| Yahoo Finance | AAPL |
| Alpha Vantage | IBM |

External identities shall never replace canonical or business identities.

---

# 6. Identity Hierarchy

```text
Business Concept
        │
        ▼
Business Identifier
        │
        ▼
Canonical Identifier (Phoenix)
        │
        ▼
External Identifier(s)
```

Each layer has a single responsibility.

---

# 7. Identity Rules

The following rules apply to all entities:

- Every entity shall have exactly one Canonical Identifier.
- Every entity shall have one Business Identifier when applicable.
- An entity may have zero, one, or many External Identifiers.
- External identifiers are provider-specific.
- Canonical identifiers never change.
- Business identifiers change only through formal governance.
- External identifiers may change according to provider policies.

---

# 8. Mapping Strategy

Mappings between Canonical and External identities shall be maintained through dedicated mapping entities or mapping tables.

The logical model shall not assume a one-to-one relationship.

---

# 9. Service Responsibilities

Reference Domain owns:

- Business Identity
- Canonical Identity

Integration Domain owns:

- External Identity mappings
- Synchronization with providers

This separation preserves domain boundaries and avoids coupling.

---

# 10. Traceability

Every identity shall be traceable to:

- Entity Dictionary
- Business Glossary
- Reference Domain
- Integration Domain

---

# 11. Compliance

All logical models, physical models, APIs, and services shall conform to this identity strategy.

No implementation may introduce alternative identity mechanisms without architectural approval.

---

# 12. Related Documents

- IdentifierStrategy.md
- EnterpriseDataDictionaryStandard.md
- ReferenceDomainArchitecture.md
- ReferenceEntityDefinitions.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Identity Standard. |