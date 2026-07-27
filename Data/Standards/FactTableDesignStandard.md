# Fact Table Design Standard

| Item | Value |
|------|-------|
| Document ID | STD-FT-001 |
| Document Name | Fact Table Design Standard |
| Category | Enterprise Database Standard |
| Status | Approved |
| Version | 2026.1 |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

## 1.1 Objective

This standard defines the canonical design principles, architectural rules,
and implementation requirements for all Fact Tables within the Phoenix Platform.

The purpose of this document is to ensure that every Fact Table is designed
using a consistent, scalable, maintainable, and architecture-driven approach.

This standard establishes a single enterprise-wide design model for all
historical, transactional, measurement, event, and snapshot data stored by
the Phoenix Platform.

---

## 1.2 Goals

The objectives of this standard are to:

- Establish a canonical design model for Fact Tables.
- Ensure consistency across the entire repository.
- Support Architecture-First development.
- Support Domain-Driven Design (DDD).
- Eliminate duplicated business data.
- Improve maintainability.
- Improve scalability.
- Improve long-term extensibility.
- Support multi-market expansion.
- Support future analytical workloads.
- Support machine learning workloads.
- Support historical data management.

---

## 1.3 Design Philosophy

Fact Tables represent business facts.

A Fact Table stores observations, events, measurements, or historical business
records that occurred at a specific point in time.

Fact Tables SHALL NOT contain business definitions.

Fact Tables SHALL NOT contain business master data.

Fact Tables SHALL NOT contain duplicated reference information.

Fact Tables SHALL reference Master Entities through canonical foreign keys.

---

## 1.4 Architecture Principles

Every Fact Table shall follow the following architectural principles:

- Architecture First
- Canonical Data Model
- Domain-Driven Design (DDD)
- Single Source of Truth
- Separation of Concerns
- High Cohesion
- Low Coupling
- Enterprise Naming Standard
- Enterprise Database Design Standard

---

## 1.5 Repository Scope

This standard applies to every Fact Table stored within the Phoenix Repository,
including but not limited to:

- DailyMarketData
- TickData
- IntradayBar
- OrderBookSnapshot
- OrderBookLevel
- InstrumentPriceAdjustment
- DailyIndexData
- PortfolioValuation
- TechnicalIndicatorValue
- FeatureValue
- Any future Fact Table

---

## 1.6 Out of Scope

This standard does not apply to:

- Master Entities
- Reference Tables
- Bridge Tables
- Configuration Tables
- Metadata Tables
- Security Tables
- Audit Tables
- Log Tables

These objects are governed by their own dedicated standards.

---

## 1.7 Relationship to Other Standards

This document shall be used together with the following Phoenix standards:

- Enterprise Naming Standard
- Enterprise Database Design Standard
- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- IdentifierStrategy
- AuditModelStandard

This document defines only the rules specific to Fact Tables.

General database design rules, enterprise naming conventions, audit
requirements, identifier strategies, and master entity rules shall not be
duplicated in this document.

---

## 1.8 Compliance

Every new Fact Table introduced into the Phoenix Repository SHALL comply with
this standard before architectural approval.

Any exception requires a formally approved Architecture Decision Record (ADR).

---

# 2. Fact Table Definition

## 2.1 Definition

A Fact Table is a database object that stores business facts representing
events, observations, measurements, states, or historical records occurring
at a specific point in time.

Fact Tables capture what happened, when it happened, and to which business
entity it happened.

Fact Tables are the primary source of historical business information within
the Phoenix Platform.

---

## 2.2 Characteristics

Every Fact Table SHALL exhibit the following characteristics:

- Time-dependent
- Historical
- Append-oriented
- Business measurable
- Referentially linked
- Non-descriptive
- Architecture-driven

Fact Tables SHALL store business facts only.

---

## 2.3 Business Responsibilities

A Fact Table is responsible for:

- Recording business events.
- Recording business measurements.
- Recording market observations.
- Recording historical business states.
- Preserving business history.
- Supporting analytical processing.
- Supporting reporting.
- Supporting machine learning.
- Supporting historical reconstruction.

---

## 2.4 Business Facts

Business facts include, but are not limited to:

- Market prices
- Trade quantities
- Trading values
- Trading counts
- Order book states
- Technical measurements
- Portfolio valuations
- Corporate action results
- Risk measurements
- Indicator values
- Feature values

---

## 2.5 Time Dependency

Every Fact Table SHALL contain at least one business time attribute.

Examples include:

- trading_date
- trade_timestamp
- snapshot_timestamp
- event_timestamp
- valuation_timestamp

Business time SHALL represent the time at which the business fact occurred,
not the time at which the database record was inserted.

---

## 2.6 Referential Model

Fact Tables SHALL reference business master data through canonical foreign keys.

Business descriptions SHALL NOT be duplicated.

Example:

Correct

instrument_id

Incorrect

instrument_symbol

instrument_name

exchange_name

market_name

Business descriptive attributes belong to Master Entities.

---

## 2.7 Mutability

Business facts should be considered immutable whenever possible.

Correction of historical facts SHALL be performed using approved business
processes.

Historical records SHALL NOT be modified merely to reflect updated business
definitions.

---

## 2.8 Canonical Source of Truth

Each business fact SHALL have exactly one canonical source.

Duplicate storage of the same business fact in multiple Fact Tables is
prohibited unless explicitly approved through an ADR.

---

## 2.9 Derived Facts

Derived values SHALL NOT be stored together with observed facts unless
there is a documented business requirement.

Examples of observed facts:

- last_price
- trade_volume
- trade_value

Examples of derived facts:

- moving_average
- RSI
- MACD
- volatility
- beta
- Sharpe_ratio

Derived facts belong to dedicated analytical Fact Tables.

---

## 2.10 Fact Table Categories

Within the Phoenix Platform, Fact Tables are classified into the following
categories.

### Measurement Facts

Business measurements captured at a point in time.

Examples:

- DailyMarketData
- DailyIndexData

---

### Event Facts

Business events.

Examples:

- InstrumentPriceAdjustment
- CorporateActionExecution

---

### Snapshot Facts

Business state captured at a specific instant.

Examples:

- OrderBookSnapshot

---

### Detail Facts

Granular records associated with a parent fact.

Examples:

- OrderBookLevel

---

### Analytical Facts

Business values produced by calculation.

Examples:

- TechnicalIndicatorValue
- FeatureValue
- RiskMetric

---

## 2.11 Relationship with Master Entities

Fact Tables SHALL NEVER replace Master Entities.

Fact Tables reference Master Entities.

Master Entities define business concepts.

Fact Tables record business history.

Both object types have separate architectural responsibilities.

---

## 2.12 Design Principle

The following principle governs every Fact Table in Phoenix:

"A Fact Table stores what happened, never what something is."

Business definitions belong to Master Entities.

Business history belongs to Fact Tables.

---

# 3. Design Principles

## 3.1 General Principles

Every Fact Table within the Phoenix Platform SHALL be designed according to
a common set of enterprise architectural principles.

These principles ensure consistency, maintainability, scalability, and
long-term compatibility across all supported financial markets.

---

## 3.2 Single Responsibility

A Fact Table SHALL represent exactly one business concept.

A Fact Table SHALL NOT mix unrelated business facts.

Correct:

DailyMarketData

Stores daily trading measurements.

Incorrect:

DailyMarketData

Stores prices, news, financial statements, technical indicators,
and corporate actions.

---

## 3.3 Single Source of Truth

Every business fact SHALL have one and only one canonical storage location.

The same business fact SHALL NOT be duplicated across multiple Fact Tables.

If duplication is required for performance reasons, it SHALL be documented
and approved through an Architecture Decision Record (ADR).

---

## 3.4 Separation of Concerns

Business definitions belong to Master Entities.

Business classifications belong to Reference Tables.

Business facts belong to Fact Tables.

Analytical results belong to Analytical Fact Tables.

System configuration belongs to Configuration Tables.

Each object type SHALL have a single architectural responsibility.

---

## 3.5 Canonical References

Fact Tables SHALL reference business entities using canonical foreign keys.

Business descriptive attributes SHALL NOT be duplicated.

Correct:

instrument_id

Incorrect:

instrument_symbol

instrument_name

exchange_name

market_name

---

## 3.6 Historical Integrity

Fact Tables SHALL preserve historical business information.

Business history SHALL NOT be rewritten merely because master data has changed.

Historical records SHALL remain reproducible.

---

## 3.7 Business Time

Fact Tables SHALL always represent business time.

Business timestamps SHALL describe when the business event occurred.

Audit timestamps SHALL describe when the database record changed.

These two concepts SHALL remain independent.

---

## 3.8 Immutability

Business facts SHOULD be treated as immutable.

Updates SHALL be limited to:

- Data correction
- Official market revisions
- Approved business adjustments

Business facts SHALL NOT be modified to reflect changing business definitions.

---

## 3.9 Normalization

Fact Tables SHALL comply with the Phoenix Enterprise Database Design Standard.

Reference data SHALL NOT be duplicated.

Business master data SHALL NOT be duplicated.

Derived descriptive information SHALL NOT be stored.

---

## 3.10 Self-Descriptive Columns

Every column SHALL follow the Phoenix Enterprise Naming Standard.

Column names SHALL clearly identify their business meaning without requiring
knowledge of the table name.

Examples:

instrument_id

market_index_id

trade_volume

trade_value

snapshot_timestamp

price_adjustment_status_id

Generic names are prohibited.

Examples of prohibited names:

id

code

name

symbol

description

status

type

---

## 3.11 Extensibility

Fact Tables SHALL be designed to support future business growth.

The design SHALL accommodate:

- Additional financial markets
- Additional exchanges
- Additional asset classes
- Additional business measurements

without requiring architectural redesign.

---

## 3.12 Performance Independence

Logical database design SHALL remain independent from physical optimization.

Indexes

Partitioning

Compression

Storage optimization

Materialized views

are implementation concerns and SHALL NOT influence the logical design of
Fact Tables.

---

## 3.13 Architecture Before Implementation

Fact Tables SHALL be designed from the enterprise architecture.

Implementation SHALL follow architecture.

Architecture SHALL NOT evolve as a consequence of implementation shortcuts.

---

## 3.14 Repository Consistency

Every Fact Table introduced into the Phoenix Repository SHALL follow the
same architectural principles.

Consistency across the repository has higher priority than local
optimization.

---

## 3.15 Design Principle Summary

Every Fact Table shall satisfy the following principles:

✓ Single Responsibility

✓ Single Source of Truth

✓ Separation of Concerns

✓ Canonical References

✓ Historical Integrity

✓ Business Time

✓ Immutability

✓ Normalization

✓ Self-Descriptive Columns

✓ Extensibility

✓ Architecture First

✓ Repository Consistency

---

# 4. Canonical Fact Table Architecture

## 4.1 Overview

Every Fact Table within the Phoenix Platform SHALL follow a common
architectural structure.

This structure provides consistency across the repository and simplifies
design, implementation, maintenance, review, and future evolution.

Every Fact Table SHALL be organized into well-defined logical sections.

---

## 4.2 Canonical Section Order

The sections SHALL appear in the following order.

1. Primary Identifier

2. Public Identifier

3. Business References

4. Business Timestamp

5. Business Measurements

6. Business Status

7. Audit Columns

8. Constraints

9. Table Comment

10. Column Comments

No section shall be omitted unless it is not applicable to the business
object.

---

## 4.3 Primary Identifier

Every Fact Table SHALL contain exactly one surrogate primary key.

Naming convention:

<entity>_id

Examples:

daily_market_data_id

tick_data_id

order_book_snapshot_id

order_book_level_id

instrument_price_adjustment_id

The primary key SHALL be generated by PostgreSQL using:

GENERATED ALWAYS AS IDENTITY

---

## 4.4 Public Identifier

Every Fact Table SHALL contain a public identifier.

Column:

public_id UUID

Generation:

gen_random_uuid()

Purpose:

- API exposure
- External integration
- Synchronization
- Distributed systems
- Object portability

The public identifier SHALL NOT replace the surrogate primary key.

---

## 4.5 Business References

Business references SHALL appear immediately after the public identifier.

Examples:

instrument_id

exchange_id

market_id

currency_id

price_adjustment_status_id

data_quality_status_id

Only canonical foreign keys SHALL be stored.

Duplicated business descriptions are prohibited.

---

## 4.6 Business Timestamp

Every Fact Table SHALL contain one or more business time attributes.

Examples:

trading_date

trade_timestamp

snapshot_timestamp

event_timestamp

valuation_timestamp

Business timestamps SHALL describe when the business fact occurred.

They SHALL NOT describe database activity.

---

## 4.7 Business Measurements

Business measurements represent the observed business facts.

Examples:

last_price

trade_volume

trade_value

trade_count

best_bid_price

best_ask_price

adjustment_factor

Business measurements SHALL NOT include descriptive attributes.

---

## 4.8 Business Status

Business state SHALL be represented explicitly.

Examples:

is_active

price_adjustment_status_id

data_quality_status_id

Boolean values SHALL be used only where appropriate.

Business classifications SHALL use reference tables.

---

## 4.9 Audit Columns

Audit information SHALL appear after all business information.

Standard audit columns:

created_at

created_by

updated_at

updated_by

version

The audit model SHALL comply with AuditModelStandard.

---

## 4.10 Constraints

All database constraints SHALL appear after column definitions.

Constraint order SHALL be:

Primary Key

Unique Constraints

Check Constraints

Foreign Keys

Constraint names SHALL comply with the Enterprise Naming Standard.

---

## 4.11 Documentation

Every Fact Table SHALL contain:

Table Comment

Column Comments

Business-oriented documentation

Comments SHALL describe business meaning rather than implementation details.

---

## 4.12 Canonical Layout

The following layout SHALL be used for every Fact Table.

Primary Identifier

↓

Public Identifier

↓

Business References

↓

Business Timestamp

↓

Business Measurements

↓

Business Status

↓

Audit Columns

↓

Constraints

↓

Comments

This layout is mandatory for every Fact Table in the Phoenix Repository.

---

# 5. Fact Table Classification

## 5.1 Overview

Fact Tables within the Phoenix Platform are classified according to the
business nature of the facts they store.

Classification defines the architectural responsibility of a Fact Table and
shall be determined before physical database design begins.

Each Fact Table SHALL belong to exactly one primary classification.

---

## 5.2 Measurement Fact

Measurement Facts store observed business measurements collected directly from
an external or authoritative business source.

Characteristics:

- Represents observed values.
- Time-dependent.
- Historical.
- Not derived from other Fact Tables.
- Serves as a primary business record.

Examples:

- DailyMarketData
- DailyIndexData

---

## 5.3 Event Fact

Event Facts record discrete business events that occur at a specific point in
time.

Characteristics:

- Represents a business event.
- May affect future business calculations.
- Immutable after official confirmation.
- May reference one or more Master Entities.

Examples:

- InstrumentPriceAdjustment
- CorporateActionExecution
- TradingSessionEvent

---

## 5.4 Snapshot Fact

Snapshot Facts capture the state of a business object at a specific instant.

Characteristics:

- Represents a point-in-time state.
- Time-dependent.
- Historical.
- Used for replay, monitoring, and auditing.

Examples:

- OrderBookSnapshot

---

## 5.5 Detail Fact

Detail Facts store granular information associated with a parent Fact Table.

Characteristics:

- Depends on a parent Fact.
- Cannot exist independently.
- Provides detailed business information.

Examples:

- OrderBookLevel

---

## 5.6 Derived Fact

Derived Facts store values calculated from one or more business facts.

Characteristics:

- Produced by business calculation.
- Traceable to source facts.
- Reproducible.
- May be regenerated.

Examples:

- IntradayBar
- TechnicalIndicatorValue
- FeatureValue
- RiskMetric

---

## 5.7 Classification Rules

Every new Fact Table SHALL be assigned exactly one classification.

If a Fact Table appears to satisfy multiple classifications, the dominant
business responsibility SHALL determine its classification.

The selected classification SHALL be documented during architecture review.

---

## 5.8 Future Extensions

Additional classifications may be introduced as the Phoenix Platform evolves.

New classifications require approval through an Architecture Decision Record
(ADR).

---

## 5.9 Classification Summary

| Classification | Purpose | Example |
|----------------|---------|---------|
| Measurement Fact | Stores observed business measurements | DailyMarketData |
| Event Fact | Records business events | InstrumentPriceAdjustment |
| Snapshot Fact | Captures business state | OrderBookSnapshot |
| Detail Fact | Stores granular child records | OrderBookLevel |
| Derived Fact | Stores calculated business values | IntradayBar |

---

# 6. Mandatory Column Groups

## 6.1 Overview

Every Fact Table within the Phoenix Platform SHALL be organized into a
consistent set of mandatory column groups.

Column groups improve readability, maintainability, architectural consistency,
and simplify repository reviews.

Unless explicitly exempted by an approved Architecture Decision Record (ADR),
every Fact Table SHALL follow the column group structure defined in this
standard.

---

## 6.2 Mandatory Group Order

The following column groups SHALL appear in the specified order.

1. Primary Identifier

2. Public Identifier

3. Business References

4. Business Timestamp

5. Business Measurements

6. Business Status

7. Audit Columns

---

## 6.3 Primary Identifier

Purpose

Provide the internal surrogate identifier for the Fact Table.

Requirements

- Exactly one column.
- Generated by PostgreSQL.
- Primary Key.
- Immutable.

Example

daily_market_data_id

---

## 6.4 Public Identifier

Purpose

Provide a globally unique identifier for external systems.

Requirements

- UUID
- NOT NULL
- Generated automatically
- Never modified

Example

public_id

---

## 6.5 Business References

Purpose

Connect the Fact Table to Master Entities and Reference Tables.

Requirements

- Foreign Keys only.
- No duplicated descriptive data.
- Reference canonical business objects.

Examples

instrument_id

exchange_id

market_id

currency_id

price_adjustment_status_id

data_quality_status_id

---

## 6.6 Business Timestamp

Purpose

Record the time at which the business fact occurred.

Requirements

- At least one business timestamp.
- Represents business time.
- Independent from audit timestamps.

Examples

trading_date

trade_timestamp

snapshot_timestamp

event_timestamp

valuation_timestamp

---

## 6.7 Business Measurements

Purpose

Store the business facts observed or calculated.

Requirements

- Numeric or measurable business values.
- No descriptive attributes.
- No duplicated master data.

Examples

last_price

trade_volume

trade_value

trade_count

adjustment_factor

best_bid_price

best_ask_price

---

## 6.8 Business Status

Purpose

Represent the current business status of the recorded fact.

Requirements

- Use Reference Tables whenever business classifications exist.
- Boolean values only for lifecycle control.

Examples

is_active

price_adjustment_status_id

data_quality_status_id

---

## 6.9 Audit Columns

Purpose

Support traceability and optimistic concurrency.

Mandatory Columns

created_at

created_by

updated_at

updated_by

version

Requirements

The audit model SHALL comply with AuditModelStandard.

---

## 6.10 Optional Column Groups

Additional column groups may be introduced only when justified by business
requirements.

Examples include:

- Data Quality
- Processing Metadata
- Source Metadata
- Synchronization Metadata

Optional groups SHALL appear after Business Status and before Audit Columns.

---

## 6.11 Prohibited Groups

The following groups SHALL NOT appear within Fact Tables:

- Business Descriptions
- Master Entity Attributes
- Configuration Data
- User Interface Data
- Presentation Data
- Security Configuration
- Application Settings

Such information belongs to dedicated architectural components.

---

## 6.12 Summary

Every Fact Table SHALL organize its columns according to the following
canonical sequence:

Primary Identifier

↓

Public Identifier

↓

Business References

↓

Business Timestamp

↓

Business Measurements

↓

Business Status

↓

Audit Columns

This structure is mandatory throughout the Phoenix Repository.

---

# 7. Primary Key Standard

## 7.1 Purpose

Every Fact Table SHALL contain a single canonical primary key that uniquely
identifies each business record within the table.

The primary key provides internal identity only and SHALL NOT be used as a
business identifier.

---

## 7.2 Primary Key Strategy

Phoenix adopts the Surrogate Key strategy for all Fact Tables.

Natural business keys SHALL NOT be used as primary keys.

Business uniqueness SHALL be enforced through separate UNIQUE constraints.

---

## 7.3 Naming Convention

The primary key column SHALL follow the Enterprise Naming Standard.

Format:

<entity>_id

Examples:

daily_market_data_id

tick_data_id

intraday_bar_id

order_book_snapshot_id

order_book_level_id

instrument_price_adjustment_id

market_snapshot_id

---

## 7.4 Data Type

The canonical data type for every Fact Table primary key SHALL be:

BIGINT

No alternative integer types shall be used without an approved ADR.

---

## 7.5 Value Generation

Primary keys SHALL be generated by PostgreSQL using:

GENERATED ALWAYS AS IDENTITY

Sequences SHALL NOT be created manually.

Application-generated identifiers SHALL NOT be used.

---

## 7.6 Immutability

Primary key values SHALL NEVER be modified.

Primary keys represent permanent object identity.

Business corrections SHALL NOT change the primary key.

---

## 7.7 Business Independence

Primary keys SHALL NOT contain business meaning.

The following SHALL NOT be encoded within a primary key:

- Trading Date
- Instrument Code
- Exchange Code
- Market Code
- Business Status
- Source System

Business information belongs to dedicated columns.

---

## 7.8 Composite Primary Keys

Composite Primary Keys are prohibited.

Business uniqueness SHALL be enforced through UNIQUE constraints.

Correct:

PRIMARY KEY (daily_market_data_id)

UNIQUE (instrument_id, trading_date)

Incorrect:

PRIMARY KEY (instrument_id, trading_date)

---

## 7.9 Foreign Key Referencing

Child Fact Tables SHALL reference the surrogate primary key of the parent table.

References SHALL NOT use business keys.

Example:

order_book_level.order_book_snapshot_id

References:

order_book_snapshot.order_book_snapshot_id

---

## 7.10 Performance Considerations

The primary key SHALL be optimized for:

- Fast insertion
- Efficient indexing
- Stable joins
- Long-term scalability

Performance optimization SHALL NOT alter the logical identity model.

---

## 7.11 Architectural Rationale

The use of surrogate primary keys provides:

- Stable identifiers
- Business independence
- Simplified relationships
- Easier schema evolution
- Better scalability
- Consistent repository design

---

## 7.12 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Exactly one primary key

✓ BIGINT data type

✓ GENERATED ALWAYS AS IDENTITY

✓ Self-descriptive column name

✓ No business meaning

✓ Immutable

✓ Non-composite primary key

✓ Business uniqueness enforced separately

---

# 8. Business Key Standard

## 8.1 Purpose

Every Fact Table SHALL define a business key that uniquely identifies a
business fact within its business context.

The business key represents business uniqueness and SHALL be independent from
the surrogate primary key.

The business key SHALL NOT replace the primary key.

---

## 8.2 Business Identity

A business key identifies a business fact according to business rules.

Unlike the surrogate primary key, a business key carries business meaning and
is used to prevent duplicate business records.

Business identity SHALL be enforced through a UNIQUE constraint.

---

## 8.3 Composition

A business key may consist of one or more business attributes.

Business keys SHALL contain only business attributes.

Surrogate identifiers SHALL NOT participate in business keys.

Examples:

DailyMarketData

- instrument_id
- trading_date

TickData

- instrument_id
- trade_timestamp
- trade_sequence

IntradayBar

- instrument_id
- bar_timeframe_id
- bar_timestamp

OrderBookSnapshot

- instrument_id
- snapshot_timestamp
- snapshot_type_id

OrderBookLevel

- order_book_snapshot_id
- order_book_side_id
- order_book_level_number

InstrumentPriceAdjustment

- instrument_id
- adjustment_effective_date
- adjustment_sequence

---

## 8.4 Stability

Business keys SHOULD remain stable throughout the lifetime of a business fact.

If business rules require modification of a business key, the change SHALL be
approved through the appropriate business process.

---

## 8.5 Uniqueness

Business uniqueness SHALL be enforced using a UNIQUE constraint.

Example

UNIQUE
(
    instrument_id,
    trading_date
)

The UNIQUE constraint SHALL reflect the true business definition of uniqueness.

---

## 8.6 Nullability

Columns participating in a business key SHALL be defined as NOT NULL unless
business rules explicitly require otherwise.

Nullable business keys are discouraged.

---

## 8.7 Business Semantics

Every column included in a business key SHALL contribute to the business
identity of the recorded fact.

Columns unrelated to business uniqueness SHALL NOT be included.

---

## 8.8 Architectural Independence

Business keys SHALL remain independent from:

- Primary Keys
- Public Identifiers
- Audit Columns
- Processing Metadata

Business identity SHALL represent only business uniqueness.

---

## 8.9 Repository Consistency

Fact Tables with similar business semantics SHALL adopt consistent business
key patterns across the Phoenix Repository.

For example, all time-series market data SHALL consistently identify records
using the relevant business entity together with the applicable business time.

---

## 8.10 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Business key defined

✓ Business uniqueness documented

✓ UNIQUE constraint implemented

✓ NOT NULL business key columns

✓ No surrogate key participation

✓ Consistent with business rules

✓ Consistent with IdentifierStrategy

---

# 9. Foreign Key Standard

## 9.1 Purpose

Foreign Keys establish and enforce the relationships between Fact Tables,
Master Entities, and Reference Tables.

Every foreign key SHALL represent a valid business relationship and preserve
referential integrity throughout the Phoenix Platform.

---

## 9.2 Design Principles

Foreign Keys SHALL:

- Preserve referential integrity.
- Reference canonical business objects.
- Prevent orphan records.
- Reflect real business relationships.
- Support long-term maintainability.

Foreign Keys SHALL NOT be introduced solely for implementation convenience.

---

## 9.3 Canonical Reference Targets

A Fact Table may reference only the following canonical object types:

- Master Entities
- Reference Tables
- Parent Fact Tables (when a parent-child relationship exists)

Direct references to configuration tables, audit tables, or log tables are
prohibited unless explicitly approved by an ADR.

---

## 9.4 Naming Convention

Foreign key columns SHALL follow the Enterprise Naming Standard.

Format:

<referenced_entity>_id

Examples:

instrument_id

exchange_id

market_id

currency_id

board_id

market_index_id

price_adjustment_status_id

data_quality_status_id

order_book_snapshot_id

---

## 9.5 Constraint Naming

Foreign key constraints SHALL follow the Enterprise Naming Standard.

Format:

fk_<table_name>_<referenced_table_name>

Examples:

fk_daily_market_data_instrument

fk_tick_data_instrument

fk_order_book_snapshot_instrument

fk_order_book_level_snapshot

fk_order_book_level_order_book_side

---

## 9.6 Update Rule

Unless a documented business requirement exists, every foreign key SHALL use:

ON UPDATE RESTRICT

This prevents unintended modification of business identities.

---

## 9.7 Delete Rule

The delete action SHALL be selected according to the business relationship.

### Master Entity References

Master Entities SHALL normally use:

ON DELETE RESTRICT

Example:

Instrument

Exchange

Market

Currency

### Reference Tables

Reference Tables SHALL normally use:

ON DELETE RESTRICT

### Parent Fact Tables

Parent-child Fact Tables SHOULD normally use:

ON DELETE CASCADE

only when the child record has no independent business meaning.

Example:

OrderBookSnapshot

↓

OrderBookLevel

If the child Fact Table has an independent lifecycle, CASCADE SHALL NOT be
used.

---

## 9.8 Nullability

Mandatory business relationships SHALL use:

NOT NULL

Optional business relationships MAY allow:

NULL

Nullability SHALL reflect business rules rather than implementation choices.

---

## 9.9 Prohibited Practices

The following are prohibited:

- Foreign keys to non-canonical tables.
- Foreign keys to business codes.
- Foreign keys to names.
- Foreign keys to descriptive attributes.
- Circular foreign key dependencies.
- Duplicate relationship paths.

---

## 9.10 Repository Consistency

All Fact Tables SHALL use identical relationship patterns for equivalent
business concepts.

For example:

Every reference to Instrument SHALL use:

instrument_id

Every reference to Exchange SHALL use:

exchange_id

No alternative naming conventions are permitted.

---

## 9.11 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Canonical foreign key names

✓ Canonical reference targets

✓ Referential integrity enforced

✓ ON UPDATE RESTRICT

✓ Appropriate ON DELETE action

✓ NOT NULL for mandatory relationships

✓ No circular dependencies

✓ Enterprise Naming Standard compliance

---

# 10. Numeric Data Standard

## 10.1 Purpose

This section defines the standard numeric data types for business
measurements stored in Fact Tables.

General data type definitions are governed by the
EnterpriseDataTypeStandard.

This section specifies only the numeric conventions applicable to
Fact Tables.

---

## 10.2 General Principles

Business measurements SHALL use numeric data types that preserve accuracy.

Floating-point data types (REAL, FLOAT, DOUBLE PRECISION) SHALL NOT be used
for business values requiring exact precision.

NUMERIC SHALL be used for all financial calculations.

---

## 10.3 Price Values

Price-related measurements SHALL use:

NUMERIC(20,8)

Examples:

open_price

high_price

low_price

close_price

last_price

best_bid_price

best_ask_price

reference_price

---

## 10.4 Quantity Values

Business quantities SHALL use:

NUMERIC(24,4)

Examples:

trade_volume

bid_volume

ask_volume

remaining_volume

matched_volume

---

## 10.5 Monetary Values

Business monetary values SHALL use:

NUMERIC(24,4)

Examples:

trade_value

market_value

portfolio_value

transaction_value

---

## 10.6 Percentage Values

Percentages SHALL use:

NUMERIC(7,4)

Examples:

price_change_percentage

return_percentage

weight_percentage

---

## 10.7 Factors

Adjustment and calculation factors SHALL use:

NUMERIC(20,10)

Examples:

adjustment_factor

split_factor

normalization_factor

---

## 10.8 Integer Values

Integer data types SHALL be used only for discrete counts.

Examples:

trade_count

order_count

sequence_number

level_number

priority_number

---

## 10.9 Boolean Values

BOOLEAN SHALL be used only for binary business states.

Examples:

is_active

is_final

is_deleted

Business classifications SHALL NOT be represented using BOOLEAN values.

Reference Tables SHALL be used instead.

---

## 10.10 Nullability

Business measurements SHALL be defined as NOT NULL whenever the business
fact is mandatory.

Nullable numeric columns SHALL be used only when the business meaning of
"unknown" or "not applicable" is valid.

---

## 10.11 Unit Consistency

Each numeric measurement SHALL represent exactly one business unit.

Examples:

Price

Currency

Quantity

Shares

Percentage

Percent

Time

Milliseconds

Mixed units within a single column are prohibited.

---

## 10.12 Future Compatibility

Numeric precision SHALL be selected to accommodate future business growth,
additional markets, and increased data volumes without requiring schema
redesign.

---

## 10.13 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Exact numeric types for financial values

✓ Standard precision for prices

✓ Standard precision for quantities

✓ Standard precision for monetary values

✓ Standard precision for percentages

✓ Integer types only for discrete counts

✓ BOOLEAN only for binary states

✓ One business unit per column

✓ Compliance with EnterpriseDataTypeStandard

---

# 11. Unique Constraint Standard

## 11.1 Purpose

Unique Constraints enforce business uniqueness within Fact Tables.

Unlike the Primary Key, which provides technical identity, a Unique Constraint
ensures that the same business fact cannot be recorded more than once.

Every Fact Table SHALL define one or more Unique Constraints whenever business
rules require uniqueness.

---

## 11.2 Design Principles

Unique Constraints SHALL:

- Enforce business uniqueness.
- Prevent duplicate business facts.
- Reflect real business rules.
- Be independent of the Primary Key.
- Use only business attributes.

Unique Constraints SHALL NOT include surrogate primary keys.

---

## 11.3 Relationship to Business Keys

Every Business Key SHALL be implemented using a Unique Constraint.

The Business Key defines the logical business identity.

The Unique Constraint enforces that identity within the database.

---

## 11.4 Naming Convention

Constraint names SHALL comply with the Enterprise Naming Standard.

Format:

uq_<table_name>_<business_context>

Examples:

uq_daily_market_data_instrument_date

uq_tick_data_instrument_timestamp_sequence

uq_intraday_bar_instrument_timeframe_timestamp

uq_order_book_snapshot_instrument_timestamp_type

uq_order_book_level_snapshot_side_level

uq_instrument_price_adjustment_instrument_date_sequence

---

## 11.5 Column Selection

Only business attributes SHALL participate in a Unique Constraint.

Typical business attributes include:

- instrument_id
- trading_date
- trade_timestamp
- snapshot_timestamp
- bar_timestamp
- adjustment_effective_date
- order_book_level_number

Audit columns SHALL NOT participate.

Primary keys SHALL NOT participate.

Public identifiers SHALL NOT participate.

---

## 11.6 Nullability

Columns participating in a Unique Constraint SHOULD be defined as NOT NULL.

Nullable columns SHALL be used only where explicitly required by business
rules.

---

## 11.7 Multiple Unique Constraints

A Fact Table MAY define more than one Unique Constraint if multiple business
rules require independent uniqueness.

Each Unique Constraint SHALL represent a distinct business rule.

---

## 11.8 Prohibited Practices

The following practices are prohibited:

- Using the Primary Key as a business uniqueness constraint.
- Including surrogate keys in Unique Constraints.
- Creating duplicate Unique Constraints.
- Defining Unique Constraints without documented business justification.

---

## 11.9 Examples

DailyMarketData

UNIQUE
(
    instrument_id,
    trading_date
)

---

TickData

UNIQUE
(
    instrument_id,
    trade_timestamp,
    trade_sequence
)

---

OrderBookSnapshot

UNIQUE
(
    instrument_id,
    snapshot_timestamp,
    snapshot_type_id
)

---

OrderBookLevel

UNIQUE
(
    order_book_snapshot_id,
    order_book_side_id,
    order_book_level_number
)

---

## 11.10 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Business uniqueness documented

✓ Unique Constraint implemented

✓ Business attributes only

✓ No surrogate keys

✓ Enterprise Naming Standard compliance

✓ Business Key consistency

✓ No duplicate business facts

---

# 12. Check Constraint Standard

## 12.1 Purpose

Check Constraints enforce business validation rules at the database level.

They ensure that business measurements stored within Fact Tables remain
valid, consistent, and compliant with defined business rules.

Check Constraints SHALL protect data quality independently of application
logic.

---

## 12.2 Design Principles

Check Constraints SHALL:

- Validate business values.
- Prevent invalid measurements.
- Protect business integrity.
- Be deterministic.
- Be independent of application code.

Business validation SHALL NOT rely solely on the application layer.

---

## 12.3 Scope

Check Constraints MAY be defined for:

- Numeric ranges
- Business flags
- Enumerated values
- Temporal relationships
- Logical consistency
- Measurement validity

---

## 12.4 Naming Convention

Constraint names SHALL comply with the Enterprise Naming Standard.

Format:

ck_<table_name>_<business_rule>

Examples:

ck_daily_market_data_price

ck_tick_data_trade_volume

ck_intraday_bar_price_range

ck_order_book_level_level_number

ck_instrument_price_adjustment_factor

---

## 12.5 Numeric Validation

Business measurements SHOULD be validated whenever meaningful business
limits exist.

Examples include:

- Price greater than zero.
- Quantity greater than or equal to zero.
- Trade count greater than or equal to zero.
- Adjustment factor greater than zero.

---

## 12.6 Temporal Validation

Business timestamps MAY be validated when meaningful chronological rules
exist.

Examples include:

- Session end after session start.
- Effective date not earlier than listing date.
- Expiration date after issue date.

---

## 12.7 Logical Validation

Logical relationships between columns MAY be enforced.

Examples include:

- High price greater than or equal to low price.
- Open price within daily price range.
- Close price within daily price range.
- Best ask price greater than or equal to best bid price.

---

## 12.8 Prohibited Practices

The following practices are prohibited:

- Using Check Constraints for cross-table validation.
- Referencing external tables.
- Implementing business workflows.
- Encoding application logic.

Cross-table business validation belongs to the application or business layer.

---

## 12.9 Implementation Guidelines

Check Constraints SHALL:

- Be deterministic.
- Be easy to understand.
- Have meaningful names.
- Represent permanent business rules.

Temporary business policies SHALL NOT be implemented as Check Constraints.

---

## 12.10 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Business validation implemented where appropriate

✓ Meaningful constraint names

✓ Deterministic expressions

✓ No cross-table validation

✓ No application logic

✓ Permanent business rules only

---

# 13. Index Standard

## 13.1 Purpose

Indexes improve data retrieval performance while preserving the logical
integrity of Fact Tables.

This section defines the standard indexing strategy for Fact Tables within
the Phoenix Platform.

Index design SHALL support efficient querying, analytical processing,
historical data retrieval, and future scalability.

---

## 13.2 Design Principles

Indexes SHALL:

- Improve query performance.
- Support common access patterns.
- Minimize insertion overhead.
- Preserve data integrity.
- Be based on documented business requirements.

Indexes SHALL NOT be created without a justified business or technical need.

---

## 13.3 Mandatory Indexes

Every Fact Table SHALL contain the following indexes:

- Primary Key Index
- Unique Constraint Index(es)

These indexes are created automatically by PostgreSQL.

Additional indexes SHALL be created only when justified.

---

## 13.4 Foreign Key Indexes

Foreign key columns SHOULD be indexed when they are:

- Frequently joined.
- Frequently filtered.
- Frequently used in reporting.
- Frequently used in analytical queries.

Typical examples include:

instrument_id

exchange_id

market_id

order_book_snapshot_id

market_index_id

---

## 13.5 Time-Based Indexes

Business time columns SHOULD be indexed when historical queries are expected.

Examples:

trading_date

trade_timestamp

snapshot_timestamp

bar_timestamp

adjustment_effective_date

Time-based indexes are essential for time-series data.

---

## 13.6 Composite Indexes

Composite indexes MAY be created for common query patterns.

Column order SHALL reflect query selectivity.

Examples:

(instrument_id, trading_date)

(instrument_id, trade_timestamp)

(instrument_id, snapshot_timestamp)

(bar_timeframe_id, bar_timestamp)

Composite indexes SHALL be supported by documented query patterns.

---

## 13.7 Covering Indexes

Covering indexes MAY be introduced when they significantly reduce query cost.

Their use SHALL be justified through performance analysis.

---

## 13.8 Prohibited Practices

The following practices are prohibited:

- Duplicate indexes.
- Redundant indexes.
- Indexes on unused columns.
- Indexes created solely by convention.
- Excessive indexing that degrades insert performance.

---

## 13.9 Index Naming Convention

Index names SHALL comply with the Enterprise Naming Standard.

Format:

ix_<table_name>_<business_context>

Examples:

ix_daily_market_data_trading_date

ix_daily_market_data_instrument

ix_tick_data_trade_timestamp

ix_intraday_bar_bar_timestamp

ix_order_book_snapshot_snapshot_timestamp

---

## 13.10 Performance Review

Indexes SHALL be periodically reviewed.

Unused indexes SHOULD be removed.

New indexes SHALL be introduced only after workload analysis.

Index optimization SHALL be evidence-based.

---

## 13.11 Repository Consistency

Equivalent Fact Tables SHALL adopt consistent indexing strategies.

Time-series Fact Tables SHALL consistently index:

- Business entity reference(s)
- Business time attribute(s)

This consistency simplifies maintenance and improves predictability.

---

## 13.12 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Primary Key indexed

✓ Unique Constraint indexed

✓ Foreign key indexes evaluated

✓ Time-based indexes evaluated

✓ Composite indexes justified

✓ No duplicate indexes

✓ Enterprise Naming Standard compliance

✓ Performance-based index design

---

# 14. Partitioning Standard

## 14.1 Purpose

Partitioning improves scalability, maintainability, and query performance for
large Fact Tables.

This section defines the architectural principles governing table
partitioning within the Phoenix Platform.

Partitioning SHALL be introduced only when justified by data volume,
maintenance requirements, or performance analysis.

---

## 14.2 Design Principles

Partitioning SHALL:

- Improve scalability.
- Improve maintenance.
- Improve historical data management.
- Improve query performance.
- Preserve logical consistency.

Partitioning SHALL NOT alter the logical data model.

---

## 14.3 Partition Eligibility

Not every Fact Table requires partitioning.

Partitioning SHOULD be considered for Fact Tables that:

- Store large historical datasets.
- Grow continuously over time.
- Contain time-series business facts.
- Require archival policies.
- Require high-performance historical queries.

Small reference or transactional tables SHALL NOT be partitioned.

---

## 14.4 Recommended Partition Key

For time-series Fact Tables, the preferred partition key SHALL be the
business time attribute.

Typical examples include:

- trading_date
- trade_timestamp
- snapshot_timestamp
- bar_timestamp
- adjustment_effective_date

Business time provides predictable data distribution and aligns with common
query patterns.

---

## 14.5 Partition Strategy

Phoenix adopts the following order of preference:

1. RANGE Partitioning
2. LIST Partitioning
3. HASH Partitioning

### RANGE Partitioning

Preferred for historical and time-series data.

Examples:

- Monthly partitions
- Quarterly partitions
- Yearly partitions

---

### LIST Partitioning

Suitable for low-cardinality business classifications.

Examples:

- Market
- Exchange
- Asset Class

LIST partitioning SHALL NOT be used for continuously growing time-series
data.

---

### HASH Partitioning

Reserved for exceptional high-volume workloads where RANGE or LIST
partitioning cannot provide balanced data distribution.

Its use requires architectural approval.

---

## 14.6 Time-Series Recommendation

The following Fact Tables are expected to become partition candidates as data
volume grows:

- DailyMarketData
- TickData
- IntradayBar
- OrderBookSnapshot
- OrderBookLevel
- DailyIndexData

Partitioning SHALL be introduced only when operational evidence justifies it.

---

## 14.7 Lifecycle Management

Partitioning SHALL support:

- Historical retention
- Archiving
- Backup
- Data restoration
- Efficient deletion of obsolete data

Partition management procedures SHALL be documented separately.

---

## 14.8 Prohibited Practices

The following practices are prohibited:

- Partitioning without documented justification.
- Partitioning based on surrogate primary keys.
- Excessive partition creation.
- Mixing unrelated partitioning strategies within equivalent Fact Tables.

---

## 14.9 Repository Consistency

Equivalent Fact Tables SHALL adopt consistent partitioning strategies.

Time-series Fact Tables SHOULD use business time as the partition key whenever
partitioning is implemented.

---

## 14.10 Compliance Checklist

Every partitioned Fact Table SHALL satisfy the following:

✓ Business justification documented

✓ Appropriate partition strategy selected

✓ Business time used where applicable

✓ Logical model unchanged

✓ Lifecycle management supported

✓ Repository consistency maintained

---

# 15. Fact Data Quality Standard

## 15.1 Purpose

This section defines the enterprise data quality requirements for Fact Tables
within the Phoenix Platform.

Fact Tables SHALL store business facts that are accurate, complete,
consistent, traceable, and suitable for analytical processing.

Data quality SHALL be enforced as close to the database as practical while
remaining aligned with business rules.

---

## 15.2 Data Quality Principles

Every Fact Table SHALL satisfy the following quality principles:

- Accuracy
- Completeness
- Consistency
- Validity
- Timeliness
- Traceability
- Reproducibility

These principles apply throughout the lifecycle of every business fact.

---

## 15.3 Accuracy

Business facts SHALL accurately represent the information received from the
authoritative source.

Values SHALL NOT be modified unless an approved correction process exists.

---

## 15.4 Completeness

Mandatory business attributes SHALL be populated.

Required foreign keys SHALL NOT be NULL.

Business measurements SHALL be recorded whenever the source provides them.

Missing values SHALL represent legitimate business conditions rather than
processing errors.

---

## 15.5 Consistency

Equivalent business facts SHALL be represented consistently across the
Phoenix Repository.

Identical business concepts SHALL use:

- identical data types
- identical units
- identical naming conventions
- identical reference models

---

## 15.6 Validity

Business values SHALL satisfy all defined validation rules.

Validation mechanisms include:

- Data Types
- NOT NULL constraints
- CHECK constraints
- UNIQUE constraints
- FOREIGN KEY constraints

Business validation SHALL NOT rely solely on application logic.

---

## 15.7 Traceability

Every business fact SHALL be traceable to its originating business source.

Where applicable, source-related metadata SHOULD be retained to support
verification and auditing.

---

## 15.8 Reproducibility

Business calculations SHALL be reproducible.

Derived Facts SHALL be capable of being regenerated from their authoritative
source data using the applicable business rules.

---

## 15.9 Data Quality Status

Where business requirements demand explicit quality classification, Fact
Tables SHOULD reference the canonical DataQualityStatus reference table.

Quality classifications SHALL NOT be represented using free-text values.

---

## 15.10 Error Handling

Invalid business facts SHALL NOT be silently accepted.

Data validation failures SHALL be handled through documented ingestion,
correction, or rejection processes defined outside this standard.

---

## 15.11 Compliance Checklist

Every Fact Table SHALL satisfy the following:

✓ Accurate business facts

✓ Complete mandatory attributes

✓ Consistent business representation

✓ Valid business values

✓ Traceable source data

✓ Reproducible derived values

✓ Canonical quality classification where required

---

# 16. Fact Table Anti-Patterns

## 16.1 Purpose

This section identifies design practices that are prohibited within Fact
Tables.

Avoiding these anti-patterns preserves architectural consistency, improves
maintainability, and protects long-term scalability across the Phoenix
Platform.

---

## 16.2 Duplicate Business Facts

The same business fact SHALL NOT be stored in multiple Fact Tables.

Business information SHALL have exactly one canonical storage location.

---

## 16.3 Descriptive Attributes

Fact Tables SHALL NOT store descriptive business information.

Examples of prohibited columns include:

- instrument_name
- exchange_name
- market_name
- currency_name

Descriptive attributes belong to Master Entities or Reference Tables.

---

## 16.4 Generic Column Names

Generic column names are prohibited.

Examples:

id

code

name

type

status

description

Every column SHALL comply with the Enterprise Naming Standard.

Correct examples:

instrument_id

market_index_name

price_adjustment_status_id

trade_volume

---

## 16.5 Business Logic

Business logic SHALL NOT be implemented within Fact Tables.

Fact Tables SHALL store business facts only.

Business workflows belong to the application or business layer.

---

## 16.6 Derived Descriptions

Fact Tables SHALL NOT store values that can be obtained through joins with
Master Entities or Reference Tables.

Duplicated descriptive data increases maintenance cost and risks
inconsistency.

---

## 16.7 Mixed Responsibilities

A Fact Table SHALL represent a single business concept.

Examples of prohibited combinations include:

- Market data with configuration settings
- Trading data with user preferences
- Business facts with presentation data

---

## 16.8 Missing Business Keys

Every Fact Table SHALL define a Business Key.

Relying solely on the surrogate Primary Key is prohibited.

---

## 16.9 Circular Relationships

Fact Tables SHALL NOT participate in circular foreign key dependencies.

Relationships SHALL remain hierarchical and predictable.

---

## 16.10 Inconsistent Naming

Equivalent business concepts SHALL use identical names throughout the
repository.

Examples:

instrument_id

NOT

instrument

instrument_code

security_id

for the same concept.

---

## 16.11 Inappropriate Data Types

Business measurements SHALL use the canonical data types defined by the
EnterpriseDataTypeStandard.

Approximate numeric types SHALL NOT be used for financial values.

---

## 16.12 Premature Optimization

Fact Tables SHALL NOT be redesigned solely for anticipated future
performance.

Denormalization, partitioning, and specialized indexing require documented
business or operational justification.

---

## 16.13 Repository Consistency

Local optimization SHALL NOT compromise repository-wide consistency.

Architectural consistency has higher priority than isolated implementation
convenience.

---

## 16.14 Compliance Checklist

Every Fact Table SHALL avoid the following:

✓ Duplicate business facts

✓ Descriptive business attributes

✓ Generic column names

✓ Embedded business logic

✓ Derived descriptive data

✓ Mixed responsibilities

✓ Missing business keys

✓ Circular dependencies

✓ Inconsistent naming

✓ Non-standard data types

✓ Premature optimization

---

# 17. Compliance Checklist

## 17.1 Purpose

This checklist defines the minimum compliance requirements for every Fact
Table within the Phoenix Platform.

Every newly created or modified Fact Table SHALL be reviewed against this
checklist before being accepted into the repository.

---

## 17.2 Architecture

The Fact Table SHALL:

✓ Represent exactly one business concept.

✓ Follow the canonical Fact Table architecture.

✓ Belong to exactly one Fact Table classification.

✓ Follow the mandatory column group order.

✓ Avoid mixed business responsibilities.

---

## 17.3 Naming

The Fact Table SHALL:

✓ Comply with the Enterprise Naming Standard.

✓ Use self-descriptive table names.

✓ Use self-descriptive column names.

✓ Avoid generic names such as:

- id
- code
- name
- type
- status

---

## 17.4 Primary Key

The Fact Table SHALL:

✓ Define one surrogate primary key.

✓ Use BIGINT.

✓ Use GENERATED ALWAYS AS IDENTITY.

✓ Keep the primary key immutable.

---

## 17.5 Business Key

The Fact Table SHALL:

✓ Define a business key.

✓ Implement the business key using a UNIQUE constraint.

✓ Use only business attributes.

✓ Exclude surrogate identifiers.

---

## 17.6 Relationships

The Fact Table SHALL:

✓ Reference only canonical Master Entities.

✓ Reference only canonical Reference Tables.

✓ Preserve referential integrity.

✓ Avoid circular dependencies.

---

## 17.7 Business Data

The Fact Table SHALL:

✓ Store business facts only.

✓ Avoid descriptive business attributes.

✓ Avoid duplicated business information.

✓ Preserve historical integrity.

---

## 17.8 Data Quality

The Fact Table SHALL:

✓ Enforce mandatory validation.

✓ Use canonical data types.

✓ Apply CHECK constraints where appropriate.

✓ Preserve business consistency.

---

## 17.9 Performance

The Fact Table SHALL:

✓ Use indexes only when justified.

✓ Consider partitioning only when justified.

✓ Preserve logical design independence.

---

## 17.10 Repository Consistency

The Fact Table SHALL:

✓ Follow all Phoenix architectural standards.

✓ Remain consistent with equivalent Fact Tables.

✓ Avoid local design exceptions.

✓ Document approved deviations through an ADR.

---

## 17.11 Final Review

Before repository integration, every Fact Table SHALL successfully pass:

✓ Architecture Review

✓ Naming Review

✓ Database Design Review

✓ Data Quality Review

✓ Repository Review

---

## 17.12 Certification

A Fact Table SHALL be considered Phoenix compliant only after satisfying all
requirements defined in this standard.

---

# 18. References

## 18.1 Purpose

This section identifies the canonical standards and architectural documents
that govern the design of Fact Tables within the Phoenix Platform.

These references are normative unless explicitly stated otherwise.

---

## 18.2 Normative References

The following documents SHALL be considered authoritative for Fact Table
design.

### Repository Architecture

- RepositoryArchitecture.md

Defines the canonical repository structure.

---

### Enterprise Database Design

- EnterpriseDatabaseDesignStandard.md

Defines enterprise-wide database design principles.

---

### Enterprise Naming

- EnterpriseNamingStandard.md

Defines naming conventions for database objects.

---

### Master Entity Design

- MasterEntityDesignStandard.md

Defines the architectural rules for Master Entities.

---

### Master Entity Column Naming

- MasterEntityColumnNamingStandard.md

Defines the canonical naming rules for Master Entity columns.

---

### Reference Table Design

- ReferenceTableDesignStandard.md

Defines the architectural rules for Reference Tables.

---

### Enterprise Data Types

- EnterpriseDataTypeStandard.md

Defines the canonical data types used throughout the repository.

---

### Audit Model

- AuditModelStandard.md

Defines the canonical audit model adopted by the Phoenix Platform.

---

### Identifier Strategy

- IdentifierStrategy.md

Defines the enterprise identifier model, including surrogate identifiers,
public identifiers, and business identifiers.

---

## 18.3 Conflict Resolution

If conflicting guidance exists between this document and another normative
standard, the more specialized standard SHALL take precedence within its own
scope.

General enterprise standards SHALL remain authoritative for enterprise-wide
concerns.

---

## 18.4 Change Management

Modifications to this standard SHALL be reviewed through the established
repository governance process.

Breaking architectural changes SHOULD be documented through an Architecture
Decision Record (ADR).

---

## 18.5 Repository Compliance

Every Fact Table incorporated into the Phoenix Repository SHALL comply with
this standard together with all applicable normative references.

Compliance with this document alone does not guarantee repository acceptance.

---

## End of Document