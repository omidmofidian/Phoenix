# Enterprise Naming Convention Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-003 |
| Document | EnterpriseNamingConventionStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Standard |
| Owner | Enterprise Architecture Team |
| Governed By | Governance Framework |
| Last Updated | 2026-07-21 |

---

# 1. Executive Summary

The **Enterprise Naming Convention Standard** establishes the official naming policies for every architectural, technical, operational, and implementation artifact within the Phoenix Platform.

Consistent naming improves:

- readability;
- discoverability;
- maintainability;
- traceability;
- governance;
- automation;
- interoperability;
- long-term architectural consistency.

This standard applies uniformly across repository artifacts, documentation, software components, databases, services, infrastructure, and operational assets.

Naming is considered an enterprise governance concern rather than a coding preference.

---

# 2. Purpose

The purpose of this standard is to define a single, consistent naming convention for all artifacts produced within the Phoenix Platform.

Its objectives are to:

- establish enterprise-wide naming consistency;
- eliminate ambiguity;
- improve repository organization;
- support architectural traceability;
- simplify maintenance;
- facilitate automated validation;
- improve collaboration across architectural domains.

Every approved artifact shall comply with this standard.

---

# 3. Scope

This standard applies to every artifact maintained within the Phoenix Platform.

The scope includes:

- enterprise documentation;
- repository artifacts;
- Architecture Decision Records (ADR);
- standards;
- governance documents;
- business models;
- logical and physical database models;
- SQL scripts;
- source code;
- services;
- APIs;
- infrastructure;
- deployment assets;
- operational documentation;
- validation reports.

Third-party software naming is outside the scope unless incorporated into enterprise artifacts.

---

# 4. Enterprise Naming Principles

Naming throughout the Phoenix Platform follows a common set of architectural principles.

---

## 4.1 Clarity

Names shall communicate intent clearly.

Ambiguous names are prohibited.

---

## 4.2 Consistency

Identical concepts shall always use identical names.

Synonyms shall not be introduced for the same architectural concept.

---

## 4.3 Stability

Approved names should remain stable across releases.

Renaming canonical artifacts shall require governance approval.

---

## 4.4 Business-Oriented Terminology

Business terminology takes precedence over technical terminology whenever appropriate.

Domain language shall align with the Canonical Business Glossary.

---

## 4.5 Technology Independence

Architectural names should avoid implementation technologies whenever possible.

For example:

Correct

```
MarketDataService
```

Avoid

```
PythonMarketService
```

---

## 4.6 Enterprise Traceability

Names shall support traceability across:

- governance;
- architecture;
- design;
- implementation;
- validation.

Consistent naming improves automated repository validation.

---

## 4.7 Reusability

Naming conventions shall encourage reusable enterprise assets.

Reusable artifacts shall avoid project-specific terminology whenever possible.

---

## 5. Enterprise Language Policy

The Phoenix Platform follows a unified language policy.

| Area | Language |
|------|----------|
| Repository | English |
| Documentation | English |
| Architecture | English |
| Database | English |
| SQL | English |
| APIs | English |
| Source Code | English |
| Configuration | English |
| Comments | English |
| User Conversations | Persian |

Mixed-language artifact names are prohibited.

---

# 6. General Naming Rules

The following rules apply universally.

- Use meaningful names.
- Avoid unnecessary abbreviations.
- Prefer complete business terminology.
- Avoid implementation-specific prefixes unless standardized.
- Use singular nouns for entities.
- Use plural nouns only for collections.
- Avoid temporary words such as:
  - temp
  - new
  - final
  - latest
  - copy
  - test
  - old

Names shall remain descriptive throughout the artifact lifecycle.

---

# 7. Repository Naming

Repository capabilities follow the Capability-Centric Repository Architecture.

Top-level capability names shall:

- use PascalCase;
- represent business responsibilities;
- remain stable.

Approved examples:

```text
Architecture
Data
Knowledge
Operations
Platform
Project
Resources
Software
Workspace
Archive
```

Technology-oriented capability names are prohibited.

---

# 8. Folder Naming

Folders beneath repository capabilities shall:

- be concise;
- reflect architectural purpose;
- avoid abbreviations;
- remain stable across releases.

Examples:

```text
Architecture/Governance

Architecture/Business

Architecture/Solution

Data/Models

Data/Standards

Platform/Docker

Operations/RunBooks
```

Folder names shall not encode version numbers.

---

# 9. File Naming

File names shall match the official artifact title whenever practical.

Examples:

```text
GovernanceFramework.md

RepositoryValidationReport.md

EnterpriseDataDictionary.md

LogicalDatabaseModel.md

ReferenceDataModel.md
```

Artifact identifiers belong in document metadata rather than file names unless explicitly required by the artifact category.

---

# 10. Artifact Naming

Enterprise artifacts shall follow standardized identifiers.

Examples:

| Prefix | Artifact |
|---------|----------|
| ADR | Architecture Decision Record |
| STD | Enterprise Standard |
| GOV | Governance Document |
| VAL | Validation Report |
| REP | Enterprise Report |
| MAT | Traceability Matrix |
| RB | RunBook |
| KNW | Knowledge Artifact |

Artifact identifiers shall remain immutable after approval.

---

# 11. Documentation Naming

Documentation artifacts shall use descriptive, business-oriented names.

Examples:

```text
ProjectOverview.md

PlatformArchitectureVision.md

GovernanceFramework.md

RepositoryBaseline.md

RepositoryFreezeReport.md

EnterpriseDataDictionary.md
```

Documentation names shall:

- describe the document purpose;
- avoid unnecessary abbreviations;
- remain stable after approval;
- align with the official Artifact Catalog.

---

# 12. Metadata Naming

Document metadata shall use standardized property names.

Approved metadata includes:

| Property | Description |
|----------|-------------|
| Project | Project name |
| Artifact ID | Unique enterprise identifier |
| Document | Official document name |
| Version | Artifact version |
| Status | Lifecycle status |
| Classification | Artifact classification |
| Owner | Responsible team |
| Governed By | Governing artifact |
| Depends On | Upstream dependencies |
| Related Artifacts | Cross references |
| Last Updated | Last revision date |

Alternative property names shall not be introduced without governance approval.

---

# 13. Domain Naming

Business domains shall use clear business terminology.

Examples:

```text
Reference

Market

Portfolio

Analytics

MachineLearning

Configuration

Integration
```

Domain names shall remain independent of implementation technologies.

---

# 14. Business Entity Naming

Business entities shall use:

- singular nouns;
- PascalCase within documentation;
- snake_case in database implementation.

Examples:

Documentation

```text
Market

Exchange

Instrument

TradingBoard

Sector

Industry
```

Database

```text
market

exchange

instrument

trading_board

sector

industry
```

Business entity names shall align with the Canonical Business Glossary.

---

# 15. Service Naming

Services shall represent business capabilities rather than technical implementations.

Recommended format:

```text
<BusinessCapability>Service
```

Examples:

```text
MarketDataService

PortfolioService

RiskManagementService

ReportingService

AuthenticationService
```

Avoid:

```text
PythonService

RESTService

Microservice01
```

Service names shall remain stable even if implementation technology changes.

---

# 16. API Naming

API endpoints shall follow REST-oriented naming conventions.

Examples:

```text
/api/v1/markets

/api/v1/instruments

/api/v1/portfolios

/api/v1/orders
```

Guidelines:

- use lowercase;
- use plural resource names;
- avoid verbs within endpoint paths;
- maintain version consistency.

---

# 17. Database Naming

Database objects shall follow enterprise naming conventions.

---

## 17.1 Schema Names

Examples:

```text
reference

market

analytics

portfolio

configuration
```

---

## 17.2 Table Names

Rules:

- singular;
- snake_case;
- business-oriented.

Examples:

```text
market

exchange

instrument

daily_market_data

corporate_action
```

---

## 17.3 Column Names

Columns shall:

- use snake_case;
- avoid abbreviations;
- represent business meaning.

Examples:

```text
trade_date

closing_price

market_id

exchange_code

external_symbol_code
```

---

## 17.4 Primary Keys

Primary keys shall use:

```text
id
```

---

## 17.5 Foreign Keys

Foreign keys shall follow:

```text
<referenced_table>_id
```

Examples:

```text
market_id

exchange_id

instrument_id

sector_id
```

---

## 17.6 Indexes

Recommended format:

```text
idx_<table>_<column>
```

Examples:

```text
idx_instrument_symbol

idx_daily_market_data_trade_date
```

---

## 17.7 Views

Recommended format:

```text
vw_<business_name>
```

Examples:

```text
vw_latest_prices

vw_active_instruments
```

---

## 17.8 Functions

Recommended format:

```text
fn_<business_name>
```

Examples:

```text
fn_import_market_data

fn_calculate_indicator
```

---

## 17.9 Triggers

Recommended format:

```text
trg_<business_name>
```

Examples:

```text
trg_update_timestamp

trg_validate_reference_data
```

---

# 18. SQL Script Naming

SQL scripts shall use ordered numeric prefixes.

Examples:

```text
001-create-schema.sql

002-create-reference-tables.sql

003-create-market-tables.sql

101-create-indexes.sql
```

Migration scripts shall preserve execution order through filename numbering.

---

# 19. Source Code Naming

Python source code shall follow PEP 8 naming conventions together with enterprise business terminology.

Examples:

Modules

```text
market_data_service.py

portfolio_manager.py
```

Classes

```text
MarketDataImporter

PortfolioAnalyzer
```

Functions

```text
load_market_data()

calculate_indicator()
```

Variables

```text
closing_price

market_identifier

trade_volume
```

Constants

```text
MAX_RETRY_COUNT

DEFAULT_TIMEOUT
```

---

# 20. Configuration Naming

Configuration artifacts shall use descriptive and stable names.

Examples:

```text
config.yaml

application.yml

database.yml

logging.yml

docker-compose.yml

.env

.env.example
```

Configuration keys shall use lowercase snake_case unless constrained by third-party software.

Examples:

```text
database_host

database_port

default_market

log_level
```

Configuration names shall remain technology-independent whenever practical.

---

# 21. Infrastructure Naming

Infrastructure components shall follow standardized naming conventions.

---

## 21.1 Docker Containers

Recommended format:

```text
phoenix-postgres

phoenix-api

phoenix-worker

phoenix-nginx
```

---

## 21.2 Docker Networks

Recommended format:

```text
phoenix-network
```

---

## 21.3 Docker Volumes

Recommended format:

```text
phoenix-postgres-data

phoenix-logs

phoenix-backups
```

---

## 21.4 Environment Variables

Environment variables shall use UPPER_SNAKE_CASE.

Examples:

```text
POSTGRES_HOST

POSTGRES_PORT

POSTGRES_DB

POSTGRES_USER

POSTGRES_PASSWORD

PHOENIX_ENV
```

---

# 22. Version Naming

Versions shall follow the approved enterprise versioning strategy.

Enterprise documents:

```text
2026.1

2026.2

2027.1
```

Software releases:

```text
1.0.0

1.1.0

2.0.0
```

Version identifiers shall remain consistent throughout the repository.

---

# 23. Naming Governance

Naming conventions are governed through the Enterprise Governance Framework.

Changes affecting naming policies require:

- Architecture Review;
- Impact Analysis;
- Governance Approval;
- Repository Validation;
- Standard Revision.

Approved names shall not be modified arbitrarily.

---

# 24. Naming Compliance

Compliance with this standard shall be verified during:

- Architecture Reviews;
- Repository Audits;
- Repository Validation;
- Sprint Reviews;
- Baseline Reviews.

Validation shall confirm:

- naming consistency;
- artifact uniqueness;
- metadata compliance;
- traceability support;
- repository integrity.

Non-compliant artifacts shall not be approved.

---

# 25. Enterprise Traceability

Naming conventions participate in the Enterprise Traceability Framework.

Typical traceability chain:

```text
Governance Framework
        │
        ▼
Documentation Standard (STD-001)
        │
        ▼
Repository Structure Standard (STD-002)
        │
        ▼
Naming Convention Standard (STD-003)
        │
        ▼
Business Models
        │
        ▼
Database Models
        │
        ▼
Implementation
        │
        ▼
Validation Reports
```

Consistent naming enables automated governance and enterprise-wide traceability.

---

# 26. Related Artifacts

| Artifact | Relationship |
|----------|--------------|
| STD-001 Documentation Standard | Defines documentation structure |
| STD-002 Repository Structure Standard | Defines repository organization |
| GOV-013 Governance Framework | Governs naming lifecycle |
| GOV-014 Governance Checklist | Verifies compliance |
| ADR-022 Repository Architecture | Defines capability-centric repository |
| Repository Validation Report | Validates naming compliance |
| Repository Audit Report | Reviews repository consistency |
| Architecture Traceability Matrix | Maintains enterprise traceability |

---

# 27. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Naming Convention Standard. |
| 2026.2 | 2026-07-21 | Complete enterprise redesign. Expanded the standard from a project-level naming guide to an Enterprise Naming Convention Standard. Added repository naming, metadata naming, domain naming, service naming, API naming, database naming, infrastructure naming, governance, compliance, traceability, and integration with the Enterprise Architecture governance model. |

---

# End of Document