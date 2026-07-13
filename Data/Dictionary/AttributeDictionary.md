# Attribute Dictionary

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-004 |
| Document | AttributeDictionary |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Data Dictionary |
| Owner | Architecture Team |
| Depends On | EnterpriseAttributeStandard, AttributeCatalog, AggregateAttributeMatrix, EnterpriseDataDictionaryStandard |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

The Attribute Dictionary defines the canonical business semantics of enterprise attributes used throughout the Phoenix Platform.

It serves as the authoritative source for the meaning of each approved attribute, ensuring that every attribute has one and only one business definition across the enterprise.

This document focuses exclusively on semantic definitions and business understanding.

---

# 2. Scope

This dictionary defines:

- Canonical business meaning
- Business purpose
- Business notes
- Usage guidance
- Business examples
- Related business concepts

This dictionary does not define:

- Attribute ownership
- Attribute classification
- Mandatory or optional usage
- Physical data types
- SQL implementation
- Database columns
- Aggregate assignments

These aspects are governed by their respective enterprise artifacts.

---

# 3. Relationship with Enterprise Artifacts

| Artifact | Responsibility |
|----------|----------------|
| EnterpriseAttributeStandard | Defines attribute modeling rules |
| AttributeCatalog | Registers approved enterprise attributes |
| AggregateAttributeMatrix | Assigns attributes to Aggregates |
| AttributeDictionary | Defines business semantics |
| EntityDictionary | Defines business entities |
| RelationshipDictionary | Defines business relationships |

---

# 4. Identity Attributes

## id

**Business Definition**

Unique internal identifier assigned to an Aggregate Root within the Phoenix Platform.

**Business Purpose**

Provides stable enterprise identity throughout the lifecycle of a business object.

**Business Notes**

The identifier has no business meaning and shall never be interpreted by users.

**Example**

Each Company, Exchange or Instrument possesses its own unique identifier.

---

## public_id

**Business Definition**

Stable identifier intended for communication with external systems and public interfaces.

**Business Purpose**

Allows business objects to be referenced without exposing internal identifiers.

---

# 5. Naming Attributes

## code

**Business Definition**

A concise business code used to identify an object within its business context.

**Business Purpose**

Supports business communication, reporting and operational identification.

**Example**

Exchange Code

Company Code

Instrument Code

---

## name

**Business Definition**

Official business name assigned to a business object.

**Business Purpose**

Provides a human-readable representation of the object.

---

# 6. Business Attributes

## registration_number

**Business Definition**

Official registration identifier assigned by the responsible legal authority.

**Business Purpose**

Supports legal and regulatory identification.

---

## listing_date

**Business Definition**

Business date on which an instrument becomes available for trading.

**Business Purpose**

Marks the beginning of the trading lifecycle.

---

# 7. Reference Attributes

## exchange_id

**Business Definition**

Business reference identifying the Exchange responsible for a business object.

**Business Purpose**

Associates business information with an Exchange.

---

## company_id

**Business Definition**

Business reference identifying the Company related to another Aggregate.

**Business Purpose**

Represents business ownership relationships.

---

# 8. Lifecycle Attributes

## status

**Business Definition**

Current business state of an enterprise object.

**Business Purpose**

Represents lifecycle progression from creation through retirement.

---

## is_active

**Business Definition**

Indicates whether a business object is currently active within the enterprise.

**Business Purpose**

Supports operational decision making.

---

# 9. Temporal Attributes

## trading_date

**Business Definition**

Official business date representing a trading session.

**Business Purpose**

Associates market information with a business trading day.

---

# 10. Audit Attributes

## created_at

**Business Definition**

Business timestamp recording when an object first became part of the enterprise information model.

**Business Purpose**

Supports business traceability.

---

## updated_at

**Business Definition**

Business timestamp indicating the latest approved modification.

**Business Purpose**

Supports information governance and change tracking.

---

# 11. Derived Attributes

## market_cap

**Business Definition**

Calculated market value of an instrument based on approved business calculations.

**Business Purpose**

Supports analytical and financial evaluation.

---

# 12. External Attributes

## external_code

**Business Definition**

Identifier assigned to a business object by an external information provider.

**Business Purpose**

Supports interoperability with external systems while preserving enterprise identity.

---

# 13. Governance Rules

Every attribute defined in this dictionary shall:

- have exactly one business meaning;
- remain technology independent;
- avoid implementation-specific terminology;
- comply with the Enterprise Attribute Standard;
- exist in the Attribute Catalog before being used;
- be assigned to Aggregates through the Aggregate Attribute Matrix.

---

# 14. Related Documents

- EnterpriseAttributeStandard
- AttributeCatalog
- AggregateAttributeMatrix
- EntityDictionary
- RelationshipDictionary
- EnterpriseDataDictionaryStandard

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial version |
| 2026.2 | 2026-07-09 | Redesigned as a semantic dictionary with Single Source of Truth alignment |