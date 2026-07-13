# External Identifier Data Dictionary

---

# Document Information

| Item | Value |
|------|-------|
| Entity | External Identifier |
| Schema | integration |
| Table | external_identifier |
| Version | 1.1 |
| Status | Architecture Freeze |
| Last Updated | 2026-06-29 |

---

# Purpose

The External Identifier entity maintains mappings between Phoenix business entities and identifiers assigned by external data providers.

It isolates integration concerns from the business domain and enables multiple providers to coexist without introducing provider-specific attributes into business tables.

---

# Description

External Identifier is an infrastructure entity.

It does not represent a business concept.

Instead, it stores the mapping between an internal Phoenix entity and the corresponding identifier assigned by an external provider.

One business entity may have multiple external identifiers.

One provider may identify many business entities.

---

# Primary Key

| Name | Type |
|------|------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY |

Description

Internal immutable surrogate identifier.

---

# Business Identity

The logical business identity is defined by:

```text
Provider

+

Entity Type

+

External Identifier
```

Constraint

```text
UNIQUE
(
    provider_name,
    entity_type,
    external_identifier
)
```

---

# Attributes

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| provider_name | VARCHAR(50) | No | External data provider |
| entity_type | VARCHAR(50) | No | Business entity type |
| entity_id | BIGINT | No | Internal Phoenix identifier |
| external_identifier | VARCHAR(100) | No | Provider identifier |
| is_primary | BOOLEAN | No | Preferred identifier for this provider |
| valid_from | DATE | Yes | Mapping start date |
| valid_to | DATE | Yes | Mapping end date |

---

# Supported Entity Types

Typical values include

```text
Exchange

TradingBoard

Sector

Industry

Company

Instrument
```

Future entity types may be introduced without changing the table structure.

---

# Provider Examples

Typical providers include

```text
TSETMC

Codal

Bloomberg

Refinitiv

Yahoo Finance

TradingView
```

Provider names are managed by application configuration.

Future versions may replace `provider_name` with a dedicated `data_provider` table.

---

# Relationships

External Identifier is logically associated with one business entity.

```text
Business Entity

1

↓

N

External Identifier
```

Examples

```text
Company

↓

Bloomberg Identifier

↓

Yahoo Finance Identifier

↓

TSETMC Identifier
```

---

# Business Rules

An External Identifier

- belongs to exactly one business entity.
- belongs to exactly one provider.
- identifies exactly one entity within that provider.
- shall never contain business data.
- shall never replace the internal primary key.
- shall never replace the public identifier.

---

# Identifier Lifecycle

A mapping

- may become obsolete.
- may be superseded by a newer identifier.
- shall preserve historical mappings.
- shall not be physically deleted unless explicitly authorized.

Validity is controlled through:

```text
valid_from

valid_to
```

---

# Validation Rules

- provider_name is mandatory.
- entity_type is mandatory.
- entity_id is mandatory.
- external_identifier is mandatory.
- valid_to shall not precede valid_from.

---

# Constraints

## Primary Key

```text
PRIMARY KEY (id)
```

---

## Business Key

```text
UNIQUE
(
    provider_name,
    entity_type,
    external_identifier
)
```

---

# Index Recommendation

Primary Index

```text
id
```

Composite Unique Index

```text
provider_name

entity_type

external_identifier
```

Lookup Index

```text
entity_type

entity_id
```

---

# Audit Columns

```text
created_at

updated_at

created_by

updated_by

is_active
```

---

# Dependencies

Depends On

Business entities within the Market schema.

Referenced By

Integration Services

Synchronization Jobs

Import Pipelines

Export Pipelines

API Connectors

---

# Related Documents

- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- ADR-017
- ArchitectureFreeze-v1.1.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.1 | 2026-06-29 | Initial Architecture Freeze version |