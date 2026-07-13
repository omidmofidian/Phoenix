# SDS-2026.1

# Entity Catalog

**Document ID**

SDS-EC-001

**Project**

Phoenix Platform

**Version**

2026.1

**Status**

Approved

**Sprint**

Sprint 2

---

# Purpose

The Entity Catalog defines the canonical business entities of the Phoenix Platform.

Each entity has a single business owner and belongs to exactly one business domain.

This catalog is the authoritative source for all subsequent database design activities.

---

# Entity Classification

Entity Types

* Reference
* Master
* Transaction
* Event
* Configuration

Lifecycle

* Static
* Slow Changing
* Operational
* Historical

---

# Reference Domain

| Entity         | Type      | Lifecycle     | Aggregate      | Description                          |
| -------------- | --------- | ------------- | -------------- | ------------------------------------ |
| Country        | Reference | Static        | Country        | ISO countries                        |
| Currency       | Reference | Static        | Currency       | ISO currencies                       |
| Exchange       | Reference | Slow Changing | Exchange       | Trading exchanges                    |
| Calendar       | Reference | Slow Changing | Calendar       | Business calendars                   |
| TimeZone       | Reference | Static        | TimeZone       | Time zones                           |
| Language       | Reference | Static        | Language       | Supported languages                  |
| InstrumentType | Reference | Slow Changing | InstrumentType | Financial instrument classifications |
| AssetClass     | Reference | Slow Changing | AssetClass     | Asset classifications                |

---

# Identity Domain

| Entity     | Type        | Lifecycle     | Aggregate  | Description           |
| ---------- | ----------- | ------------- | ---------- | --------------------- |
| User       | Master      | Operational   | User       | Platform user         |
| Role       | Master      | Slow Changing | Role       | Security role         |
| Permission | Master      | Slow Changing | Permission | Permission definition |
| UserRole   | Transaction | Operational   | User       | User-role assignment  |
| Session    | Event       | Operational   | User       | Login session         |

---

# Organization Domain

| Entity       | Type   | Lifecycle     | Aggregate    | Description           |
| ------------ | ------ | ------------- | ------------ | --------------------- |
| Organization | Master | Slow Changing | Organization | Business organization |
| Company      | Master | Slow Changing | Organization | Legal company         |
| Department   | Master | Slow Changing | Organization | Organizational unit   |

---

# Portfolio Domain

| Entity    | Type        | Lifecycle   | Aggregate | Description          |
| --------- | ----------- | ----------- | --------- | -------------------- |
| Portfolio | Master      | Operational | Portfolio | Investment portfolio |
| Account   | Master      | Operational | Portfolio | Trading account      |
| Position  | Transaction | Operational | Portfolio | Current position     |
| Holding   | Transaction | Operational | Portfolio | Asset holding        |

---

# Trading Domain

| Entity     | Type        | Lifecycle   | Aggregate | Description      |
| ---------- | ----------- | ----------- | --------- | ---------------- |
| Order      | Transaction | Operational | Order     | Trading order    |
| Execution  | Event       | Historical  | Order     | Order execution  |
| Trade      | Transaction | Historical  | Trade     | Completed trade  |
| Allocation | Transaction | Historical  | Trade     | Trade allocation |

---

# Market Domain

| Entity          | Type   | Lifecycle     | Aggregate  | Description          |
| --------------- | ------ | ------------- | ---------- | -------------------- |
| Instrument      | Master | Slow Changing | Instrument | Financial instrument |
| Listing         | Master | Slow Changing | Instrument | Exchange listing     |
| Quote           | Event  | Historical    | Instrument | Market quote         |
| Candle          | Event  | Historical    | Instrument | OHLC candle          |
| CorporateAction | Event  | Historical    | Instrument | Corporate event      |

---

# Configuration Domain

| Entity             | Type          | Lifecycle     | Aggregate     | Description            |
| ------------------ | ------------- | ------------- | ------------- | ---------------------- |
| SystemSetting      | Configuration | Slow Changing | Configuration | System settings        |
| FeatureFlag        | Configuration | Operational   | Configuration | Feature toggles        |
| EnvironmentSetting | Configuration | Slow Changing | Configuration | Environment parameters |

---

# Audit Domain

| Entity        | Type  | Lifecycle  | Aggregate | Description     |
| ------------- | ----- | ---------- | --------- | --------------- |
| AuditLog      | Event | Historical | Audit     | Audit records   |
| ChangeHistory | Event | Historical | Audit     | Data changes    |
| LoginHistory  | Event | Historical | Audit     | Login events    |
| SecurityEvent | Event | Historical | Audit     | Security events |

---

# Reporting Domain

| Entity           | Type          | Lifecycle     | Aggregate | Description          |
| ---------------- | ------------- | ------------- | --------- | -------------------- |
| ReportDefinition | Configuration | Slow Changing | Reporting | Report metadata      |
| Dashboard        | Configuration | Operational   | Reporting | Dashboard definition |

---

# Integration Domain

| Entity             | Type          | Lifecycle   | Aggregate   | Description           |
| ------------------ | ------------- | ----------- | ----------- | --------------------- |
| BrokerConnection   | Configuration | Operational | Integration | Broker connectivity   |
| ProviderConnection | Configuration | Operational | Integration | Market data provider  |
| ImportJob          | Transaction   | Operational | Integration | Import process        |
| ExportJob          | Transaction   | Operational | Integration | Export process        |
| Webhook            | Configuration | Operational | Integration | Webhook configuration |

---

# Total Initial Canonical Entities

Reference Domain ............ 8

Identity Domain ............. 5

Organization Domain ......... 3

Portfolio Domain ............ 4

Trading Domain .............. 4

Market Domain ............... 5

Configuration Domain ........ 3

Audit Domain ............... 4

Reporting Domain ............ 2

Integration Domain .......... 5

---

Total ....................... 43 Entities

---

# Next Document

Aggregate Definitions

(Document SDS-AGG-001)
