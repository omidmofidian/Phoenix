# Attribute Catalog

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DICT-003 |
| Document | AttributeCatalog |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Information Catalog |
| Owner | Architecture Team |
| Depends On | EnterpriseAttributeStandard, EnterpriseNamingStandard, EnterpriseDataTypeStandard |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the canonical catalog of enterprise attributes used throughout the Phoenix Platform.

The catalog serves as the authoritative registry of reusable business attributes before they are assigned to business entities.

---

# 2. Scope

This catalog includes:

- Canonical business attributes
- Reusable enterprise attributes
- Attribute ownership
- Attribute classification
- Canonical naming

This catalog does not define:

- Entity-specific attribute usage
- Physical database columns
- SQL data types
- Implementation details

---

# 3. Attribute Lifecycle

Every enterprise attribute progresses through the following lifecycle:

Proposed

↓

Reviewed

↓

Approved

↓

Reusable

↓

Deprecated

↓

Retired

---

# 4. Catalog Structure

Each catalog entry contains:

- Canonical Name
- Business Meaning
- Classification
- Owner Domain
- Owning Aggregate
- Reusable
- Mandatory
- Related Standard

---

# 5. Identity Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| id | Identity | Enterprise | Yes |
| public_id | Identity | Enterprise | Yes |
| business_key | Identity | Enterprise | Yes |
| external_identifier | External | Integration | Yes |

---

# 6. Naming Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| code | Naming | Enterprise | Yes |
| short_name | Naming | Enterprise | Yes |
| name | Naming | Enterprise | Yes |
| display_name | Naming | Enterprise | Yes |
| full_name | Naming | Enterprise | Yes |

---

# 7. Business Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| registration_number | Business | Core | Yes |
| national_identifier | Business | Core | Yes |
| listing_date | Business | Market | Yes |
| ticker_symbol | Business | Market | Yes |

---

# 8. Classification Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| type | Classification | Enterprise | Yes |
| category | Classification | Enterprise | Yes |
| level | Classification | Enterprise | Yes |
| priority | Classification | Enterprise | Yes |

---

# 9. Reference Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| exchange_id | Reference | Reference | Yes |
| market_id | Reference | Reference | Yes |
| company_id | Reference | Core | Yes |
| sector_id | Reference | Reference | Yes |
| industry_id | Reference | Reference | Yes |
| currency_id | Reference | Reference | Yes |

---

# 10. Lifecycle Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| status | Lifecycle | Enterprise | Yes |
| is_active | Lifecycle | Enterprise | Yes |
| effective_from | Lifecycle | Enterprise | Yes |
| effective_to | Lifecycle | Enterprise | Yes |

---

# 11. Temporal Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| business_date | Temporal | Enterprise | Yes |
| trading_date | Temporal | Market | Yes |
| valid_from | Temporal | Enterprise | Yes |
| valid_to | Temporal | Enterprise | Yes |

---

# 12. Audit Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| created_at | Audit | Enterprise | Yes |
| created_by | Audit | Enterprise | Yes |
| updated_at | Audit | Enterprise | Yes |
| updated_by | Audit | Enterprise | Yes |
| version | Audit | Enterprise | Yes |

---

# 13. Derived Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| market_cap | Derived | Analytics | Yes |
| average_price | Derived | Analytics | Yes |
| daily_return | Derived | Analytics | Yes |

---

# 14. External Attributes

| Attribute | Classification | Owner Domain | Reusable |
|----------|----------------|--------------|----------|
| external_code | External | Integration | Yes |
| external_symbol | External | Integration | Yes |
| provider_identifier | External | Integration | Yes |

---

# 15. Catalog Governance

New attributes shall be added only when:

- no existing canonical attribute satisfies the business requirement;
- the business meaning is unique;
- the attribute complies with the Enterprise Attribute Standard;
- architectural approval has been granted.

Existing attributes shall be reused whenever possible.

---

# 16. Relationship with Other Artifacts

The Attribute Catalog is related to the following enterprise artifacts:

- EnterpriseAttributeStandard
- AttributeDictionary
- EntityDictionary
- CanonicalDomainModel
- AggregateCatalog
- EnterpriseDataDictionaryStandard

---

# 17. Compliance

All logical entities shall use attributes defined in this catalog.

Entity-specific attributes not listed in this catalog shall be reviewed and approved before adoption.

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Enterprise Attribute Catalog |