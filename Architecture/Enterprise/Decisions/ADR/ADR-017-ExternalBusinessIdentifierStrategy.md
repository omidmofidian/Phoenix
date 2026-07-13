# ADR-017: External Business Identifier Strategy

## Status

Accepted

---

## Date

2026-06-29

---

## Context

Phoenix integrates market information from multiple external data providers.

Examples include:

* Tehran Stock Exchange (TSE)
* Iran Fara Bourse (IFB)
* CSDI
* Refinitiv
* Bloomberg
* Yahoo Finance
* Future proprietary providers

Each provider uses its own business identifiers.

Using an external provider identifier as the canonical business identifier would tightly couple Phoenix to a specific provider and significantly reduce flexibility.

---

## Decision

Phoenix distinguishes between two different business identifiers.

### 1. Internal Business Identifier

Every master entity shall contain an immutable internal business identifier.

Examples:

* exchange_code
* board_code
* sector_code
* industry_code
* company_code
* instrument_code

These identifiers are generated and maintained exclusively by Phoenix.

They are immutable and remain stable for the lifetime of the record.

---

### 2. External Business Identifier

Every master entity may contain an optional external identifier supplied by an external data provider.

Examples:

* external_exchange_code
* external_board_code
* external_sector_code
* external_industry_code
* external_company_code
* external_instrument_code

Characteristics:

* Optional (NULL allowed)
* Provider-specific
* May change over time
* Never replaces the Phoenix internal identifier

---

## Consequences

### Advantages

* Independence from any single data provider
* Support for multiple providers
* Stable internal references
* Stable REST APIs
* Easier migration between providers

### Disadvantages

* Additional database columns
* Additional mapping logic in import processes

---

## Design Principles

* Internal joins use **id**
* Public APIs expose **public_id**
* Business logic uses ***_code**
* External integrations use **external_*_code**

---

## Affected Documents

* ConceptualModel.md
* LogicalDatabaseModel.md
* PhysicalDatabaseModel.md
* DataDictionary/*
* Future DDL
* Import Engine Design

---

## Related ADRs

* ADR-015
* ADR-016

---

## Revision History

| Version | Date       | Description     |
| ------- | ---------- | --------------- |
| 1.0     | 2026-06-29 | Initial version |
