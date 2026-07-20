# Physical Database Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | PDM-001 |
| Document | PhysicalDatabaseModel |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Physical Data Architecture |
| Owner | Enterprise Architecture |
| Phase | Sprint 4 — Database Infrastructure |
| Depends On | LogicalDatabaseModel, CanonicalEnterpriseERD, EnterpriseRelationshipCatalog, EnterpriseRelationshipMatrix, EnterpriseDataDictionary |
| Last Updated | 2026-07-20 |

---

# 1. Purpose

This document defines the canonical physical implementation of the Phoenix Platform Enterprise Data Model.

The Physical Database Model transforms the approved Logical Database Model into an implementation-ready PostgreSQL database specification while preserving all architectural principles, business semantics and enterprise governance requirements.

This document serves as the authoritative reference for physical schema implementation, database object definition and enterprise data governance.

---

# 2. Scope

This document defines the enterprise physical database architecture, including:

- Physical database schemas
- Physical tables
- Physical columns
- PostgreSQL data types
- Primary key implementation
- Foreign key implementation
- Unique constraints
- Check constraints
- Index strategy
- Partitioning strategy
- Storage strategy
- Audit strategy
- Performance considerations
- Physical integrity rules
- Cross-schema dependencies
- PostgreSQL implementation standards

The following topics are intentionally excluded from this document:

- SQL Data Definition Language (DDL) scripts
- Database migration scripts
- Seed data
- Data migration procedures
- Backup and recovery procedures
- Operational monitoring
- Database administration procedures

These topics are documented separately within the Database Infrastructure artifacts.

---

# 3. Architectural Role

The Physical Database Model represents the final architectural layer before implementation.

Its primary responsibilities are to:

- transform the approved Logical Database Model into a PostgreSQL implementation;
- preserve enterprise business semantics throughout physical implementation;
- standardize physical database structures across all business domains;
- define enterprise-wide implementation standards for database objects;
- establish consistent naming conventions and physical design rules;
- support scalability, maintainability and long-term evolution of the Phoenix Platform;
- provide the canonical foundation for database implementation, migration and governance.

The Physical Database Model is implementation-specific to PostgreSQL but remains fully aligned with the enterprise architecture baseline.

All physical database objects shall conform to the standards defined within this document.

No implementation shall introduce business concepts that are not defined by the approved Logical Database Model.

---

# 4. Physical Architecture Principles

The Phoenix Platform Physical Database Model is governed by a consistent set of enterprise architecture principles that ensure long-term maintainability, scalability, integrity and implementation consistency.

## 4.1 Enterprise-Driven Design

The physical database shall implement the approved Enterprise Architecture without introducing additional business semantics.

All physical objects shall be traceable to the corresponding Logical Database Model and Canonical Enterprise ERD.

---

## 4.2 Business Semantics Preservation

Physical implementation shall preserve the meaning of business entities, relationships, identifiers and constraints defined within the logical architecture.

No physical optimization shall alter approved business semantics.

---

## 4.3 Standardization First

All schemas, tables, columns, constraints, indexes and database objects shall follow enterprise-wide implementation standards.

Project-specific naming conventions or implementation shortcuts are prohibited.

---

## 4.4 Domain Ownership

Every physical table shall belong to exactly one Enterprise Domain.

Cross-domain ownership is prohibited.

Domain ownership shall remain consistent with:

- Canonical Domain Model
- Aggregate Catalog
- Domain Dependency Matrix

---

## 4.5 Referential Integrity

Relationships between business entities shall be enforced through explicit foreign key constraints unless formally exempted by an approved Architecture Decision Record (ADR).

Referential integrity shall never be delegated solely to application logic.

---

## 4.6 Performance by Design

The physical model shall support enterprise-scale workloads through:

- efficient indexing;
- optimized storage structures;
- partitioning where appropriate;
- scalable query execution;
- minimal redundancy.

Performance optimizations shall never compromise logical correctness.

---

## 4.7 Technology Governance

This document defines the approved PostgreSQL implementation standards for the Phoenix Platform.

Any deviation from these standards requires formal Enterprise Architecture approval.

---

# 5. Enterprise Physical Architecture Overview

The Phoenix Platform Physical Database is organized as a collection of domain-oriented schemas aligned with the Enterprise Architecture.

Each schema represents a distinct business capability and owns the physical implementation of its corresponding aggregates.

The architecture separates business responsibilities while preserving enterprise-wide consistency and traceability.

The physical architecture consists of the following logical layers:

- Reference Data Layer
- Core Business Layer
- Market Data Layer
- Integration Layer
- Audit Layer
- Configuration Layer
- Reporting Layer
- Shared Infrastructure Layer

Business entities remain isolated within their owning schema.

Cross-schema communication occurs exclusively through approved foreign key relationships and enterprise-defined dependency rules.

---

# 6. Target Platform Standards

The Phoenix Platform adopts PostgreSQL as its canonical relational database platform.

## 6.1 Database Platform

| Property | Standard |
|----------|----------|
| Database Engine | PostgreSQL 17 |
| Character Encoding | UTF-8 |
| Time Zone | UTC |
| Default Collation | PostgreSQL Default |
| SQL Standard | ANSI SQL (PostgreSQL Compatible) |

---

## 6.2 Enterprise Platform Requirements

The physical database implementation shall support:

- ACID-compliant transactions;
- referential integrity;
- declarative constraints;
- native partitioning;
- online index creation;
- JSONB support where explicitly approved;
- advanced indexing capabilities;
- enterprise backup and recovery mechanisms.

---

## 6.3 Architectural Compliance

Every PostgreSQL implementation shall comply with:

- Enterprise Architecture Principles;
- Enterprise Data Standards;
- Architecture Decision Records (ADR Series);
- Repository Standards;
- Database Governance Policies.

No physical implementation shall violate the approved Enterprise Architecture baseline.

---

# 7. Enterprise Schema Architecture

The Phoenix Platform Physical Database is organized into a set of enterprise schemas that align with the approved Domain-Driven Architecture and Enterprise Data Architecture.

Each schema owns the physical implementation of one or more Enterprise Domains and serves as the exclusive owner of its business entities.

Schema ownership, dependencies and responsibilities are governed by the Enterprise Architecture Baseline.

## 7.1 Enterprise Schema Catalog

| Schema | Primary Responsibility | Owner Domain |
|----------|------------------------|--------------|
| reference | Enterprise reference and classification data | Reference Domain |
| core | Core enterprise business entities | Core Domain |
| market | Market operations and historical market data | Market Domain |
| integration | External systems and provider integration | Integration Domain |
| audit | Enterprise auditing and traceability | Audit Domain |
| configuration | Platform configuration and runtime settings | Configuration Domain |
| reporting | Reporting and analytical structures | Reporting Domain |
| system | Shared platform infrastructure | Platform Services |

---

## 7.2 Enterprise Schema Principles

The following principles govern schema design throughout the Phoenix Platform.

- Every schema shall have a clearly defined business responsibility.
- Every physical table shall belong to exactly one schema.
- Schema ownership shall follow Enterprise Domain ownership.
- Cross-schema dependencies shall comply with the approved Domain Dependency Matrix.
- Circular schema dependencies are prohibited.
- Business semantics shall never be duplicated across schemas.
- Shared reference data shall remain within the Reference Domain.
- Physical implementation shall preserve logical domain boundaries.

---

## 7.3 Cross-Schema Dependency Rules

The following dependency rules apply to all physical schemas.

| Schema | May Reference |
|----------|---------------|
| reference | None |
| core | reference |
| market | reference, core |
| integration | reference, core, market |
| audit | All business schemas |
| configuration | None |
| reporting | All business schemas |
| system | Shared infrastructure only |

These dependencies represent the maximum allowable dependency scope.

Application implementations should reference only those schemas required by the corresponding business capability.

---

# 8. Enterprise Naming Standards

The Phoenix Platform adopts a single enterprise-wide naming convention for all physical database objects.

Consistent naming improves readability, maintainability, automation and long-term governance.

---

## 8.1 Schema Names

Schema names shall:

- use lowercase characters;
- use singular nouns;
- represent enterprise business capabilities;
- remain stable throughout the platform lifecycle.

Examples:

```text
reference
core
market
integration
audit
configuration
reporting
system
```

---

## 8.2 Table Names

Table names shall:

- use lowercase characters;
- use snake_case;
- use singular nouns;
- represent one business entity or aggregate.

Examples:

```text
exchange
trading_board
sector
industry
company
instrument
instrument_listing
daily_market_data
corporate_action
external_identifier
```

---

## 8.3 Column Names

Column names shall:

- use lowercase characters;
- use snake_case;
- remain descriptive;
- avoid abbreviations unless approved by enterprise standards.

Examples:

```text
exchange_code
company_name
instrument_code
listing_status
effective_date
created_at
updated_at
```

---

## 8.4 Constraint Naming Standards

| Object | Convention |
|---------|------------|
| Primary Key | `pk_<table>` |
| Foreign Key | `fk_<table>_<referenced_table>` |
| Unique Constraint | `uq_<table>_<column>` |
| Check Constraint | `ck_<table>_<rule>` |
| Index | `ix_<table>_<column>` |

---

## 8.5 Enterprise Naming Rules

The following rules apply throughout the physical database.

- Database object names shall be unique within their scope.
- Reserved PostgreSQL keywords shall not be used.
- Business terminology shall follow the Enterprise Business Glossary.
- Naming shall remain stable across platform versions.
- Object names shall be technology-independent whenever possible.

---

# 9. Enterprise PostgreSQL Data Standards

This section defines the approved PostgreSQL data types used throughout the Phoenix Platform.

Equivalent business concepts shall always use identical physical data types.

---

## 9.1 Standard Data Types

| Logical Type | PostgreSQL Type | Purpose |
|---------------|----------------|---------|
| Primary Identifier | BIGINT GENERATED ALWAYS AS IDENTITY | Internal surrogate key |
| Foreign Key | BIGINT | Referential integrity |
| Public Identifier | UUID | Immutable public identifier |
| Business Code | VARCHAR(30) | Stable business identifier |
| External Code | VARCHAR(50) | External provider identifier |
| Name | VARCHAR(200) | Standard business name |
| Long Name | VARCHAR(500) | Extended business name |
| Description | TEXT | Descriptive information |
| Boolean | BOOLEAN | Business flag |
| Date | DATE | Calendar date |
| Timestamp | TIMESTAMPTZ | UTC timestamp |
| Integer | INTEGER | Whole number |
| Long Integer | BIGINT | Large numeric value |
| Decimal | NUMERIC(20,8) | Financial values |
| Monetary Amount | NUMERIC(24,8) | Monetary calculations |
| Percentage | NUMERIC(10,4) | Percentage values |
| Structured Data | JSONB | Approved structured metadata |

---

## 9.2 Enterprise Data Type Principles

- Equivalent business concepts shall use identical PostgreSQL data types.
- Primary identifiers shall remain immutable.
- Public identifiers shall be globally unique.
- Business codes shall remain human-readable.
- Financial values shall preserve enterprise precision.
- All timestamps shall be stored using UTC.
- Data type selection shall prioritize consistency over implementation convenience.

---

## 9.3 Standards Traceability

The Enterprise PostgreSQL Data Standards are derived from the following approved architectural artifacts:

- LogicalDatabaseModel
- CanonicalEnterpriseERD
- EnterpriseDataDictionary
- AggregateAttributeMatrix
- EnterpriseAttributeStandard
- PostgreSQL Standards
- Architecture Decision Records (ADR Series)

---

# 10. Reference Schema

The **reference** schema contains enterprise reference data that is shared across all business domains.

Reference entities are relatively stable, change infrequently and establish the common vocabulary of the Phoenix Platform. These entities provide the foundation upon which Core, Market, Integration and Reporting domains are built.

All tables within this schema implement the complete Enterprise Audit Standard.

---

# 10.1 reference.exchange

## Business Purpose

Represents a securities exchange recognized by the Phoenix Platform.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| exchange_code | VARCHAR(30) | No | Business Identifier |
| exchange_name | VARCHAR(200) | No | Official Exchange Name |
| exchange_name_en | VARCHAR(200) | Yes | English Exchange Name |
| external_exchange_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (exchange_code)
```

---

# 10.2 reference.trading_board

## Business Purpose

Represents a trading board operating within a securities exchange.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| exchange_id | BIGINT | No | Exchange Reference |
| board_code | VARCHAR(30) | No | Business Identifier |
| board_name | VARCHAR(200) | No | Official Board Name |
| board_name_en | VARCHAR(200) | Yes | English Board Name |
| external_board_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (exchange_id, board_code)

FOREIGN KEY (exchange_id)
REFERENCES reference.exchange(id)
```

---

# 10.3 reference.sector

## Business Purpose

Represents the highest level of enterprise market classification.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| sector_code | VARCHAR(30) | No | Business Identifier |
| sector_name | VARCHAR(200) | No | Official Sector Name |
| sector_name_en | VARCHAR(200) | Yes | English Sector Name |
| external_sector_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (sector_code)
```

---

# 10.4 reference.industry

## Business Purpose

Represents an industry belonging to a sector.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| sector_id | BIGINT | No | Sector Reference |
| industry_code | VARCHAR(30) | No | Business Identifier |
| industry_name | VARCHAR(200) | No | Official Industry Name |
| industry_name_en | VARCHAR(200) | Yes | English Industry Name |
| external_industry_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (sector_id, industry_code)

FOREIGN KEY (sector_id)
REFERENCES reference.sector(id)
```

---

# 11. Core Schema

The **core** schema contains the principal business entities that define the operational identity of the Phoenix Platform.

Core entities represent legal organizations and financial instruments that participate in market activities. These entities are referenced by multiple business domains and therefore require stable identifiers and strict governance.

All tables within this schema implement the complete Enterprise Audit Standard.

---

# 11.1 core.company

## Business Purpose

Represents a legal organization that issues one or more financial instruments.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| industry_id | BIGINT | No | Industry Reference |
| company_code | VARCHAR(30) | No | Business Identifier |
| company_name | VARCHAR(200) | No | Official Company Name |
| company_name_en | VARCHAR(200) | Yes | English Company Name |
| national_identifier | VARCHAR(50) | Yes | National Registration Identifier |
| external_company_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (company_code)

FOREIGN KEY (industry_id)
REFERENCES reference.industry(id)
```

---

# 11.2 core.instrument

## Business Purpose

Represents a tradable financial instrument issued by a company.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| company_id | BIGINT | No | Company Reference |
| instrument_code | VARCHAR(30) | No | Business Identifier |
| instrument_name | VARCHAR(200) | No | Official Instrument Name |
| instrument_name_en | VARCHAR(200) | Yes | English Instrument Name |
| instrument_type | VARCHAR(30) | No | Instrument Type |
| isin | VARCHAR(20) | Yes | International Securities Identification Number |
| external_instrument_code | VARCHAR(50) | Yes | External Reference Code |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (instrument_code)

UNIQUE (isin)

FOREIGN KEY (company_id)
REFERENCES core.company(id)
```

---

# 12. Market Schema

The **market** schema contains operational market structures and historical trading information.

Unlike the Reference and Core schemas, Market entities are highly dynamic and continuously grow throughout the lifetime of the platform.

The physical design of this schema emphasizes historical integrity, efficient querying and scalability for time-series workloads.

# 12.1 market.instrument_listing

## Business Purpose

Represents the official listing of a financial instrument on a trading board.

An Instrument Listing defines where an Instrument is traded and maintains its listing lifecycle independently of the Instrument itself.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| instrument_id | BIGINT | No | Instrument Reference |
| trading_board_id | BIGINT | No | Trading Board Reference |
| listing_code | VARCHAR(30) | No | Business Identifier |
| listing_symbol | VARCHAR(50) | No | Trading Symbol |
| listing_name | VARCHAR(200) | No | Official Listing Name |
| listing_status | VARCHAR(30) | No | Listing Status |
| listing_date | DATE | No | Listing Date |
| delisting_date | DATE | Yes | Delisting Date |
| external_listing_code | VARCHAR(50) | Yes | External Reference Code |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (listing_code)

FOREIGN KEY (instrument_id)
REFERENCES core.instrument(id)

FOREIGN KEY (trading_board_id)
REFERENCES reference.trading_board(id)
```

---

# 12.2 market.daily_market_data

## Business Purpose

Represents the official end-of-day trading information for a listed financial instrument.

This table is the primary historical time-series repository of the Phoenix Platform and is expected to become one of the largest tables within the database.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| instrument_listing_id | BIGINT | No | Instrument Listing Reference |
| trading_calendar_id | BIGINT | No | Trading Calendar Reference |
| trading_date | DATE | No | Trading Date |
| open_price | NUMERIC(20,8) | No | Opening Price |
| high_price | NUMERIC(20,8) | No | Highest Price |
| low_price | NUMERIC(20,8) | No | Lowest Price |
| close_price | NUMERIC(20,8) | No | Closing Price |
| last_price | NUMERIC(20,8) | Yes | Last Traded Price |
| volume | BIGINT | No | Trading Volume |
| trade_count | INTEGER | Yes | Number of Trades |
| trade_value | NUMERIC(24,8) | Yes | Total Trading Value |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (
    instrument_listing_id,
    trading_date
)

FOREIGN KEY (instrument_listing_id)
REFERENCES market.instrument_listing(id)

FOREIGN KEY (trading_calendar_id)
REFERENCES reference.trading_calendar(id)
```

---

# 12.3 market.corporate_action

## Business Purpose

Represents official corporate events affecting financial instruments throughout their lifecycle.

Corporate Actions preserve the historical events required for accurate market analysis, portfolio valuation and backtesting.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| instrument_id | BIGINT | No | Instrument Reference |
| action_type | VARCHAR(50) | No | Corporate Action Type |
| effective_date | DATE | No | Effective Date |
| announcement_date | DATE | Yes | Announcement Date |
| reference_number | VARCHAR(100) | Yes | Official Reference Number |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

FOREIGN KEY (instrument_id)
REFERENCES core.instrument(id)
```

---

# 13. Integration Schema

The **integration** schema isolates the enterprise business model from external information providers.

This schema stores provider definitions and external business identifiers while ensuring that external identifiers never become part of the canonical enterprise identity.

---

# 13.1 integration.data_provider

## Business Purpose

Represents an external organization that supplies market, reference or analytical data to the Phoenix Platform.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| provider_code | VARCHAR(30) | No | Business Identifier |
| provider_name | VARCHAR(200) | No | Provider Name |
| provider_type | VARCHAR(50) | No | Provider Category |
| website_url | VARCHAR(500) | Yes | Official Website |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (provider_code)
```

---

# 13.2 integration.external_identifier

## Business Purpose

Represents the association between an enterprise business object and an identifier assigned by an external data provider.

External identifiers preserve interoperability with external systems while ensuring that enterprise business identifiers remain the authoritative source of identity.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| public_id | UUID | No | Immutable Public Identifier |
| data_provider_id | BIGINT | No | Data Provider Reference |
| entity_type | VARCHAR(50) | No | Enterprise Entity Type |
| entity_id | BIGINT | No | Enterprise Entity Identifier |
| external_identifier | VARCHAR(100) | No | Provider Identifier |
| identifier_type | VARCHAR(50) | Yes | Identifier Classification |
| is_primary | BOOLEAN | No | Primary Provider Identifier |
| valid_from | DATE | Yes | Effective Start Date |
| valid_to | DATE | Yes | Effective End Date |
| description | TEXT | Yes | Business Description |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (public_id)

UNIQUE (
    data_provider_id,
    entity_type,
    external_identifier
)

FOREIGN KEY (data_provider_id)
REFERENCES integration.data_provider(id)
```

---

# 14. Audit Schema

The **audit** schema stores immutable audit information required for enterprise governance, regulatory compliance and operational traceability.

Audit records are append-only and shall never be physically modified or deleted through normal business operations.

---

# 14.1 audit.audit_log

## Business Purpose

Captures all significant data modifications performed within the Phoenix Platform.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| event_timestamp | TIMESTAMPTZ | No | Event Timestamp |
| entity_type | VARCHAR(100) | No | Business Entity Type |
| entity_id | BIGINT | No | Business Entity Identifier |
| operation_type | VARCHAR(20) | No | INSERT, UPDATE or DELETE |
| changed_by | UUID | Yes | User Identifier |
| source_system | VARCHAR(100) | Yes | Originating System |
| transaction_id | UUID | Yes | Transaction Identifier |
| previous_values | JSONB | Yes | Previous Data Snapshot |
| new_values | JSONB | Yes | Updated Data Snapshot |

### Constraints

```sql
PRIMARY KEY (id)
```

---

# 15. Configuration Schema

The **configuration** schema stores configurable platform settings that control runtime behaviour without requiring software changes.

Configuration entities are managed centrally and shared across business services.

---

# 15.1 configuration.configuration_parameter

## Business Purpose

Represents a configurable parameter used by one or more platform components.

## Physical Columns

| Column | PostgreSQL Type | Nullable | Description |
|---------|-----------------|----------|-------------|
| id | BIGINT GENERATED ALWAYS AS IDENTITY | No | Primary Key |
| parameter_key | VARCHAR(200) | No | Configuration Key |
| parameter_value | TEXT | Yes | Configuration Value |
| parameter_group | VARCHAR(100) | No | Configuration Group |
| description | TEXT | Yes | Business Description |
| data_type | VARCHAR(50) | No | Expected Value Type |
| created_at | TIMESTAMPTZ | No | Record Creation Timestamp |
| updated_at | TIMESTAMPTZ | Yes | Last Modification Timestamp |
| created_by | UUID | Yes | Record Creator |
| updated_by | UUID | Yes | Last Modifier |
| is_active | BOOLEAN | No | Active Status |

### Constraints

```sql
PRIMARY KEY (id)

UNIQUE (parameter_key)
```

---

# 15.2 Configuration Principles

The following principles apply to all configuration entities.

- Configuration shall remain independent of business data.
- Configuration changes shall be auditable.
- Configuration keys shall remain globally unique.
- Runtime configuration shall not require database schema changes.
- Configuration values shall support version-controlled deployment processes.

---

# 16. Reporting Schema

The **reporting** schema contains physical structures optimized for reporting, analytical processing and decision support.

Objects within this schema are derived from canonical business data and shall never become the system of record.

Reporting objects may include materialized views, summary tables and analytical structures designed to improve reporting performance without affecting transactional workloads.

---

# 16.1 Reporting Principles

The following principles govern the Reporting schema.

- Reporting data shall originate exclusively from approved enterprise schemas.
- Reporting objects shall be read-optimized.
- Business rules shall remain consistent with the canonical enterprise model.
- Reporting structures shall never modify operational business data.
- Materialized data shall be refreshable using approved synchronization procedures.
- Denormalization is permitted only within the Reporting schema.

---

# 16.2 Candidate Reporting Objects

The following reporting structures may be introduced as the platform evolves.

| Object | Purpose |
|----------|---------|
| market_summary | Daily market statistics |
| company_statistics | Company-level analytical metrics |
| instrument_statistics | Instrument performance metrics |
| sector_statistics | Sector performance analysis |
| industry_statistics | Industry performance analysis |
| portfolio_statistics | Portfolio performance reporting |
| trading_activity_summary | Trading activity aggregation |

The implementation of reporting objects depends on business requirements and is intentionally excluded from the current implementation baseline.

---

# 17. System Schema

The **system** schema contains shared infrastructure objects required for platform operation.

Unlike business schemas, the System schema owns technical metadata rather than business information.

---

# 17.1 System Responsibilities

The System schema may contain objects supporting:

- internal platform services;
- distributed processing;
- job scheduling;
- background task execution;
- metadata management;
- application versioning;
- migration history;
- infrastructure monitoring.

Business entities shall never be stored within this schema.

---

# 17.2 Candidate Infrastructure Objects

Examples of future infrastructure tables include:

| Table | Purpose |
|---------|---------|
| application_version | Platform version management |
| migration_history | Database migration history |
| scheduled_job | Background job scheduling |
| background_task | Long-running task management |
| system_parameter | Internal platform configuration |
| execution_log | Infrastructure execution history |

The exact implementation shall be defined by future infrastructure architecture decisions.

---

# 18. Shared Infrastructure

Shared infrastructure services provide common capabilities used across all enterprise schemas.

These capabilities are implementation-wide standards rather than business-domain responsibilities.

---

# 18.1 Shared Infrastructure Components

The following capabilities are shared across the physical database.

| Capability | Description |
|------------|-------------|
| Identity Management | Enterprise identifier management |
| Audit Support | Standard audit implementation |
| Constraint Enforcement | Declarative integrity validation |
| Transaction Management | ACID transaction support |
| Concurrency Control | Multi-user consistency |
| Error Handling | Database exception management |
| Backup Support | Recovery infrastructure |
| Performance Monitoring | Operational performance analysis |

---

# 18.2 Shared Infrastructure Principles

The following principles apply to the entire physical database.

- Shared infrastructure shall remain independent of business domains.
- Infrastructure services shall support all enterprise schemas consistently.
- Infrastructure components shall not introduce business semantics.
- Enterprise standards shall be enforced centrally whenever possible.
- Infrastructure shall support future horizontal and vertical scalability.
- Operational concerns shall remain separated from business data.

---

# 19. Primary Key Strategy

The Phoenix Platform adopts a uniform enterprise-wide strategy for primary key implementation.

Every persistent table shall implement an immutable surrogate primary key to ensure consistency, scalability and long-term maintainability.

Business identifiers shall never be used as primary keys.

## 19.1 Primary Key Standard

All tables shall implement the following primary key definition.

```sql
id BIGINT GENERATED ALWAYS AS IDENTITY
```

The use of `BIGSERIAL` is prohibited.

---

## 19.2 Primary Key Principles

The following principles apply to every primary key.

- Every table shall contain exactly one primary key.
- Primary keys shall be immutable.
- Primary keys shall have no business meaning.
- Primary keys shall never be updated.
- Primary keys shall be generated exclusively by PostgreSQL.
- Primary keys shall be referenced by all foreign keys.

---

## 19.3 Rationale

The surrogate key strategy provides:

- implementation independence;
- stable relationships;
- efficient indexing;
- simplified schema evolution;
- protection against business identifier changes.

---

# 20. Foreign Key Strategy

Foreign keys preserve referential integrity between enterprise entities and enforce the relationships defined by the Canonical Enterprise ERD.

Every foreign key shall reference the primary key of its parent table.

---

## 20.1 Foreign Key Naming Standard

Foreign key columns shall use the following convention.

```text
<referenced_table>_id
```

Examples:

```text
exchange_id
sector_id
industry_id
company_id
instrument_id
instrument_listing_id
trading_calendar_id
data_provider_id
```

---

## 20.2 Referential Actions

Unless explicitly approved by an Architecture Decision Record (ADR), all foreign keys shall implement:

```sql
ON UPDATE RESTRICT

ON DELETE RESTRICT
```

Alternative referential actions require explicit architectural approval.

---

## 20.3 Foreign Key Principles

- Every foreign key shall reference an existing parent record.
- Orphan records are prohibited.
- Foreign keys shall enforce business relationships.
- Foreign key indexes shall be created for all foreign key columns.
- Cross-schema references shall comply with the approved dependency model.

---

# 21. Public Identifier Strategy

In addition to internal surrogate keys, enterprise master entities expose immutable public identifiers for external references.

Public identifiers provide stable references independent of database implementation.

---

## 21.1 Public Identifier Standard

Master entities shall implement the following column.

```sql
public_id UUID NOT NULL
```

The value shall be globally unique.

---

## 21.2 Applicable Entities

Public identifiers shall be implemented for all enterprise master entities, including:

- Exchange
- Trading Board
- Trading Calendar
- Sector
- Industry
- Company
- Instrument
- Instrument Listing
- Data Provider
- Corporate Action

Additional entities may adopt public identifiers where justified by business requirements.

---

## 21.3 Public Identifier Principles

- Public identifiers shall be immutable.
- Public identifiers shall never encode business semantics.
- Public identifiers shall remain globally unique.
- Public identifiers shall not replace surrogate primary keys.
- Public identifiers shall be suitable for external APIs, integrations and distributed services.

---

## 21.4 Traceability

The Public Identifier Strategy implements the following approved architectural decisions.

- ADR-015 — Public Identifier Strategy
- Logical Database Model
- Canonical Enterprise ERD
- Enterprise Data Dictionary

---

# 22. Business Identifier Strategy

Business identifiers provide stable, human-readable identifiers for enterprise business entities.

Unlike surrogate primary keys, business identifiers carry business meaning and are used by users, business processes and external documentation.

Business identifiers shall remain stable throughout the lifecycle of an entity unless modified through an approved business governance process.

---

## 22.1 Business Identifier Principles

The following principles apply to all business identifiers.

- Business identifiers shall be unique within their business scope.
- Business identifiers shall remain human-readable.
- Business identifiers shall not be used as primary keys.
- Business identifiers shall be protected by UNIQUE constraints.
- Business identifiers shall remain stable whenever possible.
- Business identifiers shall be governed by enterprise business rules.

---

## 22.2 Standard Business Identifiers

| Entity | Business Identifier |
|----------|---------------------|
| Exchange | exchange_code |
| Trading Board | board_code |
| Trading Calendar | trading_date |
| Sector | sector_code |
| Industry | industry_code |
| Company | company_code |
| Instrument | instrument_code |
| Instrument Listing | listing_code |
| Data Provider | provider_code |
| Corporate Action | reference_number |

---

## 22.3 External Business Identifiers

Identifiers assigned by external providers shall never replace enterprise business identifiers.

Provider-specific identifiers shall be stored exclusively within the **integration.external_identifier** table.

This separation preserves enterprise identity while supporting interoperability with external information providers.

---

# 23. Enterprise Audit Strategy

Audit information provides complete traceability for enterprise data throughout its lifecycle.

Audit implementation shall be standardized across all physical tables according to the entity category.

---

## 23.1 Master Data Audit Standard

Master entities shall implement the complete audit column set.

| Column | PostgreSQL Type |
|---------|-----------------|
| created_at | TIMESTAMPTZ |
| updated_at | TIMESTAMPTZ |
| created_by | UUID |
| updated_by | UUID |
| is_active | BOOLEAN |

---

## 23.2 Operational Data Audit Standard

High-volume operational entities may implement a reduced audit model where approved by Enterprise Architecture.

Standard columns include:

| Column | PostgreSQL Type |
|---------|-----------------|
| created_at | TIMESTAMPTZ |
| updated_at | TIMESTAMPTZ |

Examples include large historical time-series tables such as:

- market.daily_market_data

Additional audit columns may be introduced where required by governance or regulatory requirements.

---

## 23.3 Audit Principles

- Audit information shall never alter business semantics.
- Audit timestamps shall be stored in UTC.
- Audit data shall remain historically traceable.
- Audit columns shall follow enterprise naming standards.
- Audit implementation shall remain consistent across all schemas.

---

# 24. Constraint Strategy

Database constraints enforce enterprise business rules at the physical database level.

Wherever possible, business integrity shall be enforced declaratively rather than exclusively through application logic.

---

## 24.1 Constraint Categories

The following constraint categories are used throughout the Phoenix Platform.

| Constraint Type | Purpose |
|-----------------|---------|
| PRIMARY KEY | Entity identity |
| FOREIGN KEY | Referential integrity |
| UNIQUE | Business uniqueness |
| CHECK | Business rule validation |
| NOT NULL | Mandatory attributes |

---

## 24.2 Constraint Principles

- Every table shall define a primary key.
- Every parent-child relationship shall be protected by a foreign key.
- Business identifiers shall be protected by UNIQUE constraints.
- Mandatory business attributes shall be defined as NOT NULL.
- CHECK constraints shall enforce physical validation rules where appropriate.

---

## 24.3 Constraint Naming Convention

| Constraint | Naming Standard |
|------------|-----------------|
| Primary Key | pk_<table> |
| Foreign Key | fk_<table>_<parent_table> |
| Unique Constraint | uq_<table>_<column> |
| Check Constraint | ck_<table>_<rule> |

Constraint names shall remain stable throughout the lifecycle of the database and comply with the Enterprise Naming Standards.

---

# 25. Index Strategy

Indexes provide efficient data retrieval while preserving data integrity and supporting enterprise-scale workloads.

The Phoenix Platform adopts a standardized indexing strategy to ensure consistent performance across all business domains.

---

## 25.1 Index Categories

The following index categories are approved for enterprise-wide use.

| Index Category | Purpose |
|----------------|---------|
| Primary Key Index | Enforce entity identity |
| Unique Index | Protect business uniqueness |
| Foreign Key Index | Optimize joins and referential access |
| Business Identifier Index | Accelerate business lookups |
| Public Identifier Index | Support API and integration access |
| Analytical Index | Improve reporting and historical analysis |
| Composite Index | Optimize multi-column predicates |

---

## 25.2 Standard Index Rules

The following indexes shall be created for every applicable table.

- Primary Key
- UNIQUE constraints
- Foreign Keys
- Public Identifier (`public_id`)
- Business Identifier
- Frequently searched business attributes

Additional indexes may be introduced following performance analysis and Enterprise Architecture approval.

---

## 25.3 Composite Index Guidelines

Composite indexes shall:

- reflect common query patterns;
- place the most selective columns first;
- avoid unnecessary duplication;
- be periodically reviewed for effectiveness.

Composite indexes shall be supported by workload analysis and query execution plans.

---

## 25.4 Index Governance

The creation, modification or removal of indexes shall be governed through the database change management process.

Unused or redundant indexes shall be identified through operational monitoring and removed after architectural review.

---

# 26. Partitioning Strategy

Partitioning supports scalable storage and efficient query processing for high-volume tables.

Partitioning is applied only where justified by data volume and access patterns.

---

## 26.1 Partitioning Principles

The following principles govern partitioning.

- Only high-volume tables shall be partitioned.
- Partitioning shall remain transparent to application logic.
- Partition boundaries shall follow stable business attributes.
- Partition pruning shall be supported by query design.
- Partitioning shall not alter logical business semantics.

---

## 26.2 Candidate Partitioned Tables

| Table | Partition Method | Partition Key |
|--------|------------------|---------------|
| market.daily_market_data | RANGE | trading_date |

Future tables may adopt partitioning based on operational requirements and architectural approval.

---

## 26.3 Partition Maintenance

Partition management shall support:

- automatic partition creation;
- archival of historical partitions;
- efficient backup and recovery;
- independent maintenance operations;
- optimized storage management.

---

# 27. Storage Strategy

The storage strategy defines how enterprise data is physically organized to balance performance, scalability and maintainability.

Storage optimization shall never compromise business integrity.

---

## 27.1 Storage Principles

- Normalize business entities whenever practical.
- Apply physical denormalization only when justified.
- Preserve enterprise traceability.
- Minimize unnecessary redundancy.
- Optimize for long-term maintainability.

---

## 27.2 Physical Denormalization

Physical denormalization is permitted only when it provides measurable operational benefits.

Approved examples include:

- duplication of `trading_date` within `market.daily_market_data` to support native PostgreSQL partitioning;
- reporting-specific summary structures within the Reporting schema.

All denormalization decisions shall be documented and traceable to an approved Architecture Decision Record (ADR).

---

## 27.3 Large Object Storage

Large binary objects and unstructured documents shall not be stored directly within operational business tables unless explicitly required.

External object storage solutions are preferred for:

- documents;
- images;
- reports;
- attachments;
- large analytical artifacts.

Business tables shall retain only the metadata required to reference externally stored content.

---

# 28. Performance Strategy

The Phoenix Platform database shall be optimized for enterprise-scale analytical and operational workloads while preserving data integrity and maintainability.

Performance optimization shall never compromise the canonical business model or enterprise governance principles.

---

## 28.1 Performance Objectives

The physical database shall optimize for:

- High-volume read operations
- Historical market analysis
- Time-series processing
- Enterprise reporting
- Efficient business identifier lookup
- High-performance joins
- Large-scale analytical workloads

---

## 28.2 Performance Principles

The following principles govern database performance optimization.

- Normalize business data before introducing optimization.
- Optimize based on measured workload characteristics.
- Avoid premature optimization.
- Preserve logical consistency.
- Maintain predictable query performance.
- Minimize unnecessary data duplication.

---

## 28.3 Performance Techniques

Approved optimization techniques include:

- B-tree indexes
- Composite indexes
- Table partitioning
- Materialized views
- Query optimization
- Parallel query execution
- PostgreSQL execution plan analysis

Additional techniques shall require Enterprise Architecture approval.

---

# 29. Time-Series Data Strategy

Historical market information represents the largest data volume within the Phoenix Platform.

Time-series data shall be managed using storage and indexing strategies specifically designed for sequential historical datasets.

---

## 29.1 Time-Series Principles

The following principles apply.

- Historical records are immutable.
- Records are appended only.
- Updates are exceptional and governed.
- Deletions are prohibited unless explicitly approved.
- Time-series tables shall support efficient chronological access.

---

## 29.2 Primary Time-Series Entities

The following enterprise entities are classified as time-series data.

| Entity | Characteristics |
|---------|-----------------|
| Daily Market Data | High-volume historical market records |
| Corporate Action | Historical business events |
| Audit Log | Historical operational events |

Additional entities may be classified as time-series data in future releases.

---

## 29.3 Time-Series Optimization

Time-series tables should support:

- chronological partitioning;
- efficient range scans;
- historical aggregation;
- analytical processing;
- long-term archival.

---

# 30. Security Strategy

Database security protects enterprise information against unauthorized access while supporting authorized operational and analytical activities.

Security controls shall be implemented using the principle of least privilege.

---

## 30.1 Security Principles

The following principles apply.

- Least privilege
- Separation of duties
- Secure authentication
- Role-based authorization
- Complete auditability
- Defense in depth

---

## 30.2 Database Roles

Typical database roles include:

| Role | Responsibility |
|------|----------------|
| Database Administrator | Database administration |
| Application Service | Operational data access |
| Integration Service | External system integration |
| Reporting Service | Read-only analytical access |
| Data Migration Service | Controlled bulk loading |

Implementation details shall be defined within database deployment specifications.

---

## 30.3 Sensitive Data Protection

Sensitive information shall be protected through appropriate database controls.

Protection mechanisms may include:

- role-based access control;
- encryption where required;
- secure credential management;
- audit logging;
- controlled administrative access.

Security implementation shall comply with enterprise security policies and applicable regulatory requirements.

---

# 31. Backup and Recovery Strategy

The Phoenix Platform shall implement an enterprise-grade backup and recovery strategy to ensure business continuity and protection against data loss.

Backup procedures shall support both operational recovery and disaster recovery objectives.

---

## 31.1 Backup Principles

The following principles apply.

- Backups shall be performed automatically.
- Backup operations shall not compromise production availability.
- Backup integrity shall be verified periodically.
- Recovery procedures shall be documented and tested.
- Backup retention shall comply with enterprise governance policies.

---

## 31.2 Backup Categories

| Backup Type | Purpose |
|--------------|---------|
| Full Backup | Complete database recovery |
| Incremental Backup | Capture changes since previous backup |
| WAL Archive | Point-in-time recovery |
| Schema Backup | Metadata preservation |
| Configuration Backup | Infrastructure recovery |

---

## 31.3 Recovery Objectives

The physical database shall support:

- complete database recovery;
- point-in-time recovery (PITR);
- schema restoration;
- selective object recovery;
- disaster recovery operations.

Recovery implementation shall follow the enterprise operational runbooks.

---

# 32. Database Compliance

The Physical Database Model shall comply with all approved enterprise architecture standards.

Every physical implementation shall be traceable to the canonical logical and conceptual models.

---

## 32.1 Compliance Principles

The following principles apply.

- Every physical table shall originate from an approved logical entity.
- Every logical entity shall originate from an approved business object.
- Physical implementation shall not introduce unauthorized business concepts.
- Database standards shall be applied consistently across all schemas.
- Architecture Decisions (ADRs) shall govern implementation choices.

---

## 32.2 Compliance Matrix

| Physical Database Element | Governing Artifact |
|---------------------------|--------------------|
| Physical Tables | Logical Database Model |
| Physical Columns | Enterprise Attribute Dictionary |
| Relationships | Canonical Enterprise ERD |
| Constraints | Canonical Business Rules |
| Naming Standards | Enterprise Naming Standard |
| Data Types | PostgreSQL Standards |
| Identifiers | Enterprise Identifier Strategy |

---

# 33. Architecture Traceability

Every component of the Physical Database Model shall be traceable to approved enterprise architecture artifacts.

Traceability ensures architectural consistency throughout the implementation lifecycle.

---

## 33.1 Traceability Matrix

| Source Artifact | Relationship |
|-----------------|--------------|
| Vision | Defines long-term architectural direction |
| Architectural Principles | Defines physical design principles |
| Canonical Domain Model | Defines enterprise business concepts |
| Conceptual Database Model | Defines business entities |
| Logical Database Model | Defines logical structures |
| Enterprise Relationship Catalog | Defines business relationships |
| Enterprise Attribute Dictionary | Defines enterprise attributes |
| Canonical Business Rules | Defines business constraints |
| Enterprise Naming Standard | Defines naming conventions |
| Architecture Decision Records (ADRs) | Governs implementation decisions |

---

## 33.2 Traceability Principles

The following principles shall always apply.

- Every physical object shall have a logical origin.
- Every logical entity shall have a conceptual origin.
- Every implementation decision shall be governed by an approved ADR where applicable.
- Architecture artifacts shall remain internally consistent.
- Traceability shall be preserved throughout the evolution of the Phoenix Platform.

---

# 34. Architecture Decisions Applied

The Physical Database Model implements the enterprise architecture decisions approved by the Phoenix Architecture Board.

These Architecture Decision Records (ADRs) establish the mandatory standards governing the physical implementation of the Phoenix Platform database.

## 34.1 Applied Architecture Decisions

| ADR | Title | Scope |
|------|-------|-------|
| ADR-015 | Public Identifier Strategy | Enterprise public identifier implementation |
| ADR-016 | Primary Key Strategy | Enterprise surrogate primary key implementation |
| ADR-017 | External Identifier Mapping Strategy | Separation of enterprise and provider identifiers |
| ADR-022 | Repository Architecture | Repository organization and artifact governance |
| ADR-026 | Reference Data Normalization Strategy | Normalization of enterprise reference data |

Additional ADRs shall be incorporated as the enterprise architecture evolves.

---

# 35. Related Artifacts

The Physical Database Model is part of the Phoenix Enterprise Architecture repository and shall be interpreted together with the following authoritative artifacts.

## 35.1 Core Architecture Documents

- Vision
- Architectural Principles
- Quality Attributes
- Canonical Domain Model
- Canonical Enterprise ERD
- Conceptual Database Model
- Logical Database Model
- Enterprise Attribute Dictionary
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Canonical Business Rules

---

## 35.2 Supporting Standards

- Enterprise Naming Standard
- Enterprise Data Type Standard
- Enterprise Audit Standard
- Enterprise Identifier Standard
- Database Development Standards
- PostgreSQL Standards

---

## 35.3 Repository Position

```text
Architecture/
└── Data/
    ├── ConceptualDatabaseModel.md
    ├── LogicalDatabaseModel.md
    ├── PhysicalDatabaseModel.md
    ├── EnterpriseRelationshipCatalog.md
    ├── EnterpriseRelationshipMatrix.md
    └── EnterpriseAttributeDictionary.md
```

The Physical Database Model is the authoritative source for all physical database implementation activities.

---

# 36. Document Summary

The Physical Database Model defines the canonical physical implementation of the Phoenix enterprise database.

It translates the technology-independent Logical Database Model into a PostgreSQL implementation while preserving architectural integrity and business semantics.

## 36.1 Summary of Physical Schemas

| Schema | Responsibility |
|----------|----------------|
| market | Enterprise master market data |
| trading | Operational and historical market data |
| integration | External system integration |
| audit | Audit and traceability |
| configuration | Runtime configuration |
| reporting | Analytical and reporting structures |
| system | Shared infrastructure services |

---

## 36.2 Key Characteristics

The Physical Database Model provides:

- Standardized PostgreSQL implementation
- Enterprise-wide naming conventions
- Uniform primary key strategy
- Public identifier implementation
- Standardized business identifiers
- Referential integrity enforcement
- Enterprise audit support
- Indexing strategy
- Partitioning strategy
- Performance optimization guidelines
- Enterprise governance compliance

This document serves as the authoritative reference for database implementation, schema evolution and long-term maintenance across the Phoenix Platform.
---

# 37. Approval

The Phoenix Architecture Board formally approves this Physical Database Model as the official enterprise physical database specification for the Phoenix Platform.

This document is the authoritative implementation reference for all PostgreSQL database development activities and shall govern the creation, modification and maintenance of physical database objects.

## Approval Status

**APPROVED**

---

# 38. Revision History

| Version | Date | Description |
|----------|------------|--------------------------------------------------------------|
| 2026.1 | 2026-07-20 | Initial Enterprise Repository Edition |

---

# 39. Architecture Compliance Statement

This document complies with the Phoenix Enterprise Architecture Repository Standards.

The Physical Database Model is fully aligned with:

- Enterprise Architecture Principles
- Domain-Driven Design (DDD)
- Repository Architecture Standard (ADR-022)
- Canonical Data Modeling Standards
- PostgreSQL 17 Physical Database Standards
- Enterprise Naming Standards
- Enterprise Data Governance Framework

All future modifications shall preserve backward architectural compatibility unless superseded by an approved Architecture Decision Record (ADR).

---

# 40. Document Classification

| Property | Value |
|----------|-------|
| Document Type | Enterprise Architecture Artifact |
| Artifact Category | Physical Data Architecture |
| Repository Layer | Architecture / Data |
| Lifecycle Status | Approved |
| Implementation Status | Canonical Baseline |
| Technology | PostgreSQL 17 |
| Owner | Phoenix Architecture Board |
| Approval Authority | Enterprise Architecture Board |
| Repository Edition | 2026.1 |
| Next Planned Review | Sprint 5 |