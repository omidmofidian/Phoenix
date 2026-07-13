# Aggregate Attribute Matrix

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DM-007 |
| Document | AggregateAttributeMatrix |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Domain Model |
| Owner | Architecture Team |
| Depends On | AggregateCatalog, EnterpriseAttributeStandard, AttributeCatalog |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the assignment of standardized enterprise attributes to Aggregate Roots.

The objective is to ensure that every Aggregate uses approved, reusable and semantically consistent attributes defined by the Enterprise Attribute Catalog.

This matrix establishes the bridge between business architecture and information architecture.

---

# 2. Scope

This document defines:

- Aggregate Roots
- Assigned Attributes
- Attribute Categories
- Mandatory and Optional Attributes
- Business Identifiers
- Aggregate References

This document does not define:

- Attribute semantics
- SQL columns
- Physical data types
- Database implementation

---

# 3. Assignment Principles

## Principle 1

Attributes shall be assigned only after Aggregate boundaries have been approved.

---

## Principle 2

Only attributes defined in the Enterprise Attribute Catalog may be assigned.

---

## Principle 3

Each Aggregate shall define one Business Identifier.

---

## Principle 4

Audit attributes shall be inherited from the Base Entity Standard.

---

## Principle 5

Reference attributes shall reference Aggregate Roots only.

---

# 4. Attribute Categories

| Category | Description |
|----------|-------------|
| Identity | Enterprise identity |
| Naming | Human-readable names and codes |
| Business | Business information |
| Classification | Classification data |
| Reference | References to other Aggregates |
| Lifecycle | Business state |
| Temporal | Business validity |
| Audit | Audit information |
| External | External identifiers |
| Derived | Calculated attributes |

---

# 5. Reference Domain

## Exchange Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| exchange_id | Identity | Yes |
| exchange_code | Naming | Yes |
| exchange_name | Naming | Yes |
| country_id | Reference | Yes |
| timezone | Business | Yes |
| is_active | Lifecycle | Yes |
| created_at | Audit | Yes |
| updated_at | Audit | Yes |

---

## Trading Board Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| trading_board_id | Identity | Yes |
| exchange_id | Reference | Yes |
| board_code | Naming | Yes |
| board_name | Naming | Yes |
| is_active | Lifecycle | Yes |
| created_at | Audit | Yes |
| updated_at | Audit | Yes |

---

## Sector Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| sector_id | Identity | Yes |
| sector_code | Naming | Yes |
| sector_name | Naming | Yes |
| created_at | Audit | Yes |
| updated_at | Audit | Yes |

---

## Industry Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| industry_id | Identity | Yes |
| sector_id | Reference | Yes |
| industry_code | Naming | Yes |
| industry_name | Naming | Yes |
| created_at | Audit | Yes |
| updated_at | Audit | Yes |

---

## Trading Calendar Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| trading_calendar_id | Identity | Yes |
| market_id | Reference | Yes |
| trading_date | Temporal | Yes |
| is_trading_day | Business | Yes |
| created_at | Audit | Yes |

---

# 6. Core Domain

## Company Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| company_id | Identity | Yes |
| company_code | Naming | Yes |
| company_name | Naming | Yes |
| national_identifier | Business | No |
| sector_id | Reference | Yes |
| industry_id | Reference | Yes |
| status | Lifecycle | Yes |
| created_at | Audit | Yes |
| updated_at | Audit | Yes |

---

## Instrument Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| instrument_id | Identity | Yes |
| instrument_code | Naming | Yes |
| instrument_name | Naming | Yes |
| company_id | Reference | Yes |
| instrument_type_id | Reference | Yes |
| listing_date | Business | No |
| status | Lifecycle | Yes |
| created_at | Audit | Yes |

---

# 7. Market Domain

## Instrument Listing Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| listing_id | Identity | Yes |
| instrument_id | Reference | Yes |
| market_id | Reference | Yes |
| board_id | Reference | Yes |
| listing_status | Lifecycle | Yes |
| created_at | Audit | Yes |

---

## Daily Market Data Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| daily_market_data_id | Identity | Yes |
| listing_id | Reference | Yes |
| trading_date | Temporal | Yes |
| open_price | Business | Yes |
| high_price | Business | Yes |
| low_price | Business | Yes |
| close_price | Business | Yes |
| volume | Business | Yes |

---

## Corporate Action Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| corporate_action_id | Identity | Yes |
| instrument_id | Reference | Yes |
| action_type | Classification | Yes |
| effective_date | Temporal | Yes |
| created_at | Audit | Yes |

---

# 8. Integration Domain

## Data Provider Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| provider_id | Identity | Yes |
| provider_code | Naming | Yes |
| provider_name | Naming | Yes |
| provider_type | Classification | Yes |
| is_active | Lifecycle | Yes |

---

## External Identifier Aggregate

| Attribute | Category | Required |
|----------|----------|----------|
| external_identifier_id | Identity | Yes |
| provider_id | Reference | Yes |
| aggregate_name | Classification | Yes |
| aggregate_id | Reference | Yes |
| external_code | External | Yes |

---

# 9. Validation Rules

The following validations shall be performed:

- Every Aggregate has one identity attribute.
- Every reference points to an Aggregate Root.
- All mandatory attributes are assigned.
- All audit attributes comply with the Base Entity Standard.
- Every attribute exists in the Enterprise Attribute Catalog.

---

# 10. Relationship with Other Artifacts

This document shall be maintained together with:

- AggregateCatalog
- EnterpriseAttributeStandard
- AttributeCatalog
- AttributeDictionary
- LogicalDatabaseModel

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Aggregate Attribute Matrix |