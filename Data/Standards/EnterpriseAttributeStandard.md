# Enterprise Attribute Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-DATA-009 |
| Document | EnterpriseAttributeStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Information Standard |
| Owner | Architecture Team |
| Depends On | EnterpriseNamingStandard, EnterpriseDataTypeStandard, BaseEntityStandard, AuditModelStandard, IdentifierStrategy |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the enterprise-wide standard for modeling business attributes within the Phoenix Platform.

The objective of this standard is to establish a canonical, reusable and technology-independent attribute architecture that guarantees semantic consistency across all business domains, aggregates and logical information models.

Attributes are considered enterprise assets and shall be standardized before they are assigned to business entities.

---

# 2. Scope

This standard applies to:

- Business Concepts
- Aggregate Roots
- Member Entities
- Value Objects
- Logical Entities
- Enterprise Data Dictionary
- Enterprise Information Model

This standard does not define:

- SQL implementation
- Physical tables
- Database indexes
- Constraints
- Storage optimization

---

# 3. Enterprise Attribute Architecture

Attributes are modeled after the business architecture has been established.

The modeling sequence shall be:

Business Concept

↓

Domain Ownership

↓

Aggregate

↓

Entity

↓

Attribute

↓

Logical Information Model

↓

Physical Database Model

Attributes shall never drive business modeling.

Business architecture always precedes information architecture.

---

# 4. Enterprise Principles

## Principle 1

Attributes are enterprise assets.

---

## Principle 2

Each attribute shall have exactly one canonical business meaning.

---

## Principle 3

Each attribute shall have exactly one owning business definition.

---

## Principle 4

Reusable attributes shall be defined once and reused throughout the enterprise.

---

## Principle 5

Attributes describe business meaning rather than implementation details.

---

## Principle 6

Physical implementation shall never influence attribute semantics.

---

# 5. Attribute Ownership

Every attribute shall belong to exactly one Aggregate.

Attributes may be referenced by other Aggregates but shall never have multiple owners.

---

# 6. Attribute Classification

Every attribute shall belong to exactly one category.

| Category | Purpose |
|----------|---------|
| Identity | Enterprise identity |
| Naming | Business names and codes |
| Business | Business information |
| Classification | Categories and classifications |
| Reference | Aggregate references |
| Lifecycle | Business state |
| Temporal | Business validity |
| Audit | Change history |
| Derived | Calculated values |
| External | External system references |

---

# 7. Identity Attributes

Identity attributes uniquely identify business objects.

Typical examples include:

- id
- public_id
- business_key
- external_identifier

Identity attributes shall remain stable throughout the business lifecycle.

---

# 8. Naming Attributes

Naming attributes provide human-readable identification.

Typical examples:

- code
- short_name
- name
- display_name
- full_name

---

# 9. Business Attributes

Business attributes describe domain-specific business facts.

Examples:

- registration_number
- listing_date
- national_identifier

---

# 10. Classification Attributes

Classification attributes define business categorization.

Examples:

- type
- category
- class
- level
- priority

---

# 11. Reference Attributes

Reference attributes identify another Aggregate Root.

Examples:

- exchange_id
- market_id
- company_id
- sector_id
- industry_id
- currency_id

Reference attributes shall always reference Aggregate Roots.

---

# 12. Lifecycle Attributes

Lifecycle attributes describe business state transitions.

Examples:

- status
- is_active
- effective_from
- effective_to

---

# 13. Temporal Attributes

Temporal attributes define business validity.

Examples:

- business_date
- trading_date
- valid_from
- valid_to

---

# 14. Audit Attributes

Audit attributes are standardized by the Audit Model Standard.

Typical examples:

- created_at
- created_by
- updated_at
- updated_by
- version

---

# 15. Derived Attributes

Derived attributes are calculated from other enterprise data.

Derived attributes shall not replace business attributes.

---

# 16. External Attributes

External attributes identify business objects in external systems.

Examples:

- external_code
- external_symbol
- provider_identifier

External attributes shall never replace enterprise identifiers.

---

# 17. Attribute Reuse

Reusable attributes shall be defined once.

The same business meaning shall never be represented by multiple attribute definitions.

---

# 18. Attribute Naming Rules

Attribute names shall:

- be singular
- be descriptive
- avoid abbreviations
- avoid technology-specific terminology
- comply with the Enterprise Naming Standard

---

# 19. Attribute Validation

Every attribute shall be validated for:

- canonical naming
- ownership
- uniqueness
- semantic consistency
- classification
- reference integrity
- standards compliance

---

# 20. Relationship with Other Standards

This standard shall be applied together with:

- Enterprise Naming Standard
- Enterprise Data Type Standard
- Base Entity Standard
- Audit Model Standard
- Identifier Strategy
- Enterprise Data Dictionary Standard

---

# 21. Compliance

Every logical entity within the Phoenix Platform shall comply with this standard.

Any deviation requires formal architectural approval.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version |
| 2026.2 | 2026-07-09 | Rewritten as Enterprise Information Standard aligned with Sprint 3 Information Architecture |