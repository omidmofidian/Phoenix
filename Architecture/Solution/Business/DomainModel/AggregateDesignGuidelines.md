# Aggregate Design Guidelines

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DOM-007 |
| Document | AggregateDesignGuidelines |
| Version | 2026.1 |
| Status | Approved |
| Classification | Domain Architecture Guideline |
| Owner | Architecture Team |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the architectural guidelines for designing Aggregates within the Phoenix Platform.

The objective is to establish a consistent Domain-Driven Design (DDD) approach across all business domains and services.

These guidelines apply to every current and future domain of the platform.

---

# 2. Definition

An Aggregate is a cluster of closely related business entities that are treated as a single consistency boundary.

Each Aggregate:

- Protects business invariants
- Defines a transactional boundary
- Has a single Aggregate Root
- Owns the lifecycle of its child entities

---

# 3. Aggregate Design Principles

Every Aggregate shall comply with the following principles.

## 3.1 Single Responsibility

Each Aggregate shall represent exactly one business concept.

An Aggregate shall never combine unrelated responsibilities.

---

## 3.2 Single Aggregate Root

Each Aggregate shall have exactly one Aggregate Root.

The Aggregate Root is responsible for:

- Business validation
- Consistency enforcement
- Lifecycle management
- External access

Child entities shall never be accessed directly from outside the Aggregate.

---

## 3.3 High Cohesion

Entities inside an Aggregate shall have strong business relationships.

If two entities rarely change together, they probably belong to different Aggregates.

---

## 3.4 Low Coupling

Aggregates shall be independent.

Business rules of one Aggregate shall not depend on internal state of another Aggregate.

---

## 3.5 Transaction Boundary

A single business transaction shall modify only one Aggregate whenever possible.

Cross-Aggregate transactions shall be avoided.

---

## 3.6 Consistency Boundary

Business invariants shall always be maintained inside one Aggregate.

No invariant shall require simultaneous updates across multiple Aggregates.

---

# 4. Aggregate Root Responsibilities

The Aggregate Root shall:

- Control entity creation
- Control entity deletion
- Validate business rules
- Maintain consistency
- Expose business behavior
- Prevent invalid state transitions

---

# 5. Child Entity Rules

Child entities:

- Cannot exist independently
- Shall not be shared across Aggregates
- Shall not reference other child entities outside their Aggregate
- Shall always be owned by the Aggregate Root

---

# 6. Aggregate Size

Aggregates should remain small.

Indicators of an oversized Aggregate include:

- Many unrelated entities
- Frequent unrelated updates
- Complex lifecycle management
- Numerous external dependencies

Large Aggregates should be split when business consistency allows.

---

# 7. Aggregate Communication

Aggregates communicate only through:

- Canonical Identifier
- Domain Events
- Published Services

Direct object references between Aggregates are prohibited.

---

# 8. Cross-Aggregate References

Cross-Aggregate references shall:

- Use immutable identifiers
- Avoid navigation through object graphs
- Never bypass Aggregate Roots

---

# 9. Business Invariants

Every Aggregate shall explicitly define its Business Invariants.

Examples:

- Currency codes are unique.
- Exchange belongs to one Market.
- Region belongs to one Country.
- CurrencyPair contains exactly two currencies.

Business Invariants are enforced exclusively by the Aggregate Root.

---

# 10. Lifecycle Management

The Aggregate Root owns the lifecycle of every child entity.

A child entity:

- Cannot outlive its Aggregate Root
- Cannot migrate to another Aggregate
- Cannot be independently persisted

---

# 11. Aggregate Ownership

Each Aggregate belongs to exactly one Domain.

Ownership shall never be shared across Domains.

Cross-Domain modifications are prohibited.

---

# 12. Aggregate Identification

Every Aggregate shall use the Enterprise Identity Strategy.

Each Aggregate Root has:

- Canonical Identifier
- Business Identifier (when applicable)

External Identifiers are managed by the Integration Domain.

---

# 13. Aggregate Evolution

Aggregates may evolve over time.

Changes shall preserve:

- Business meaning
- Aggregate boundary
- Business invariants
- Published contracts

Breaking changes require architectural approval.

---

# 14. Design Heuristics

Create a new Aggregate when:

- A separate consistency boundary exists.
- Lifecycle differs.
- Ownership differs.
- Business invariants differ.
- Transactions rarely overlap.

Do not create a new Aggregate merely for organizational convenience.

---

# 15. Anti-Patterns

The following practices are prohibited:

- Multiple Aggregate Roots
- Shared child entities
- Cross-Aggregate object references
- Circular Aggregate dependencies
- Large "God Aggregates"
- Technical entities mixed with business entities
- Persistence-driven Aggregate design

---

# 16. Validation Checklist

Every Aggregate shall answer "Yes" to the following questions:

| Question | Yes/No |
|----------|---------|
| Does it have one Aggregate Root? | □ |
| Does it represent one business concept? | □ |
| Are business invariants clearly defined? | □ |
| Is the lifecycle fully owned? | □ |
| Is the Aggregate cohesive? | □ |
| Are dependencies minimal? | □ |
| Can transactions remain inside the Aggregate? | □ |
| Does it comply with the Enterprise Identity Standard? | □ |

---

# 17. Relationship to Other Standards

This guideline shall be used together with:

- PlatformArchitectureVision.md
- ArchitecturalPrinciples.md
- CanonicalDomainModel.md
- CanonicalAggregateCatalog.md
- EnterpriseIdentityStandard.md
- EnterpriseDataDictionaryStandard.md

---

# 18. Applicability

This guideline applies to all Phoenix domains, including but not limited to:

- Reference Domain
- Market Domain
- Portfolio Domain
- Analytics Domain
- Machine Learning Domain
- Configuration Domain
- Integration Domain
- Reporting Domain

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Aggregate Design Guidelines for the Phoenix Platform. |