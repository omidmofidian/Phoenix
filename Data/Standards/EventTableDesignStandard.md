---
title: Event Table Design Standard
document_id: PHX-STD-DATA-004
version: 1.0
status: Draft
owner: Phoenix Architecture Team
reviewers:
  - Enterprise Architecture
  - Data Architecture
approvers:
  - Chief Architect
created: 2026-07-27
last_updated: 2026-07-27
category: Database Standard
domain: Data
layer: Database
applies_to:
  - PostgreSQL
  - Phoenix Platform
related_documents:
  - EnterpriseNamingStandard
  - EnterpriseDataTypeStandard
  - MasterEntityColumnNamingStandard
  - AuditModelStandard
  - MasterEntityDesignStandard
  - ReferenceTableDesignStandard
  - FactTableDesignStandard
---

# 1. Introduction

## 1.1 Purpose

This standard defines the canonical design principles for Event Tables
within the Phoenix Platform.

Event Tables record significant business events that occur during the
lifecycle of financial markets, financial instruments, and related business
processes.

This document establishes a consistent architectural approach for designing,
implementing, and governing Event Tables across the repository.

---

## 1.2 Scope

This standard applies to every Event Table implemented within the Phoenix
Platform.

It governs:

- Logical database design
- Physical database design
- Naming conventions
- Keys and constraints
- Data integrity
- Lifecycle management
- Repository governance

This standard applies to all current and future financial markets supported
by the Phoenix Platform.

---

## 1.3 Objectives

The objectives of this standard are to:

- Standardize Event Table design.
- Preserve business event integrity.
- Support historical traceability.
- Improve repository consistency.
- Enable future platform evolution.
- Minimize architectural ambiguity.

---

## 1.4 Architectural Context

Within the Phoenix Platform, Event Tables are one of the four canonical
database table categories:

Master Entity

↓

Reference

↓

Fact

↓

Event

Each category has a distinct architectural responsibility.

---

## 1.5 Intended Audience

This standard is intended for:

- Enterprise Architects
- Solution Architects
- Database Architects
- Database Developers
- Backend Developers
- Data Engineers
- Repository Maintainers

---

## 1.6 Repository Compliance

All Event Tables SHALL comply with this standard unless an approved
Architecture Decision Record (ADR) explicitly authorizes an exception.

---

# 2. Event Table Definition

## 2.1 Purpose

This section defines the canonical meaning of an Event Table within the
Phoenix Platform.

A precise definition ensures consistent architectural classification and
prevents overlap with other database table categories.

---

## 2.2 Definition

An Event Table records the occurrence of a significant business event.

A business event represents something that happened at a specific point in
time and may affect one or more business entities.

An Event Table records the event itself rather than the resulting
measurements or classifications.

---

## 2.3 Characteristics

An Event Table typically possesses the following characteristics:

- Represents a business occurrence.
- Has a business timestamp.
- May affect one or more Master Entities.
- May reference one or more Reference Tables.
- Preserves historical records.
- Is append-oriented.
- Is rarely updated after creation.

---

## 2.4 Architectural Responsibility

The responsibility of an Event Table is to answer questions such as:

"What happened?"

"When did it happen?"

"Which business object was affected?"

It SHALL NOT answer:

"What currently exists?" (Master Entity)

"What category does it belong to?" (Reference)

"What value was measured?" (Fact)

---

## 2.5 Typical Examples

Typical Event Tables include:

- InstrumentPriceAdjustment
- CashDividend
- CapitalIncrease
- TradingHalt
- TradingResume
- SymbolSuspension
- SymbolReopening
- InitialPublicOffering
- TradingSessionEvent

These represent business events rather than business entities or
measurements.

---

## 2.6 Non-Examples

The following are NOT Event Tables:

Master Entity

- Instrument
- Exchange
- Market

Reference

- Currency
- OrderBookSide
- MarketSnapshotType

Fact

- DailyMarketData
- OrderBookLevel
- MarketIndexValue

---

## 2.7 Design Principles

Every Event Table SHALL satisfy the following principles:

- Represent exactly one business event.
- Record historical business facts.
- Preserve business chronology.
- Maintain referential integrity.
- Remain independent of presentation concerns.

---

## 2.8 Event Immutability

Once an Event Table record has been committed, it SHOULD remain immutable.

Corrections SHOULD be implemented through subsequent business events rather
than modifying historical records, unless legal or operational requirements
explicitly permit updates.

---

# 3. Event Table Classification

## 3.1 Purpose

This section defines the canonical classification of Event Tables within
the Phoenix Platform.

Consistent classification ensures that every business event is modeled
according to its architectural responsibility and prevents overlap with
Master Entity, Reference, and Fact Tables.

---

## 3.2 Classification Principles

Every Event Table SHALL belong to exactly one business event category.

An Event Table SHALL represent a business occurrence and SHALL NOT combine
multiple unrelated event types.

Each event category SHALL have a clearly defined business meaning.

---

## 3.3 Event Categories

Business events MAY be classified into one of the following categories:

- Market Events
- Instrument Events
- Trading Events
- Corporate Action Events
- Regulatory Events
- Operational Events
- Calendar Events

Additional categories MAY be introduced when justified by business
requirements.

---

## 3.4 Market Events

Market Events describe occurrences affecting an entire exchange or market.

Typical examples include:

- TradingSessionOpen
- TradingSessionClose
- MarketHoliday
- MarketInterruption

---

## 3.5 Instrument Events

Instrument Events affect one financial instrument.

Typical examples include:

- InstrumentPriceAdjustment
- InstrumentListing
- InstrumentDelisting
- InstrumentSuspension
- InstrumentReopening

---

## 3.6 Corporate Action Events

Corporate Action Events represent issuer actions that affect financial
instruments.

Typical examples include:

- CashDividend
- StockDividend
- CapitalIncrease
- StockSplit
- ReverseStockSplit
- RightsOffering

---

## 3.7 Trading Events

Trading Events describe changes related to trading activity.

Typical examples include:

- TradingHalt
- TradingResume
- AuctionStart
- AuctionEnd

---

## 3.8 Classification Rules

Every Event Table SHALL represent only one category.

An Event Table SHALL NOT combine multiple event categories within the same
table.

Related event categories MAY reference shared Master Entities and Reference
Tables.

---

## 3.9 Repository Consistency

Equivalent business events SHALL use identical classification principles
throughout the repository.

The same business event SHALL NOT be modeled differently by different
services.

---

# 4. Event Table Characteristics

## 4.1 Purpose

This section defines the mandatory characteristics of Event Tables within
the Phoenix Platform.

These characteristics distinguish Event Tables from the other canonical
database table categories.

---

## 4.2 Core Characteristics

Every Event Table SHALL:

- Represent a completed business event.
- Preserve business history.
- Be time-oriented.
- Be append-oriented.
- Maintain referential integrity.
- Support auditability.

---

## 4.3 Historical Preservation

Event Tables SHALL preserve historical business events.

Historical event records SHALL NOT be removed solely because they are no
longer operationally active.

Historical integrity SHALL take precedence over storage optimization.

---

## 4.4 Event Timestamp

Every Event Table SHALL contain at least one business timestamp describing
when the event occurred.

The business timestamp SHALL represent the actual business occurrence rather
than the database insertion time.

---

## 4.5 Referential Integrity

Event Tables SHALL reference related Master Entities through Foreign Keys.

Reference Tables MAY also be referenced when business classifications are
required.

Relationships SHALL comply with the Enterprise Naming Standard.

---

## 4.6 Event Independence

Each record SHALL represent one independent business event.

Multiple business events SHALL NOT be merged into a single record.

---

## 4.7 Immutability

Event records SHOULD remain immutable after successful persistence.

Corrections SHOULD be represented through new business events rather than
modifying historical records.

Where updates are legally or operationally required, they SHALL remain fully
auditable.

---

## 4.8 Repository Consistency

All Event Tables SHALL follow the same architectural principles regardless
of the supported financial market.

This ensures consistent implementation across Iranian equities, and future
markets such as Forex and Digital Assets.

---

## 4.9 Design Objectives

Event Tables are designed to provide:

- Accurate business history
- Complete event traceability
- Reliable chronological sequencing
- High data integrity
- Consistent repository architecture

---

# 5. Event Table Design Principles

## 5.1 Purpose

This section defines the mandatory design principles for Event Tables within
the Phoenix Platform.

These principles ensure that Event Tables consistently represent business
events while preserving historical integrity, repository consistency, and
future extensibility.

---

## 5.2 Single Responsibility

Every Event Table SHALL represent exactly one business event.

An Event Table SHALL NOT combine multiple unrelated event types.

Examples

Correct

CashDividend

CapitalIncrease

TradingHalt

Incorrect

CorporateActionAndTradingEvent

MarketActivity

---

## 5.3 Business Event Focus

Event Tables SHALL record the occurrence of business events.

They SHALL NOT store:

- Master data
- Reference data
- Measurements
- Calculated summaries
- Reporting results

Business events SHALL remain the sole responsibility of Event Tables.

---

## 5.4 Historical Accuracy

Every Event Table SHALL preserve the historical state of the recorded
business event.

Event records SHALL accurately represent the business information known at
the time the event occurred.

Historical event records SHALL NOT be rewritten to reflect later business
changes.

---

## 5.5 Atomicity

Each record SHALL represent one and only one business event.

Multiple business events SHALL NOT be combined into a single record.

If multiple business events occur simultaneously, each SHALL be stored as an
independent event record.

---

## 5.6 Business Traceability

Every event SHALL be traceable to the affected business object.

Event Tables SHALL reference the relevant Master Entity through Foreign
Keys.

Business relationships SHALL remain explicit and self-descriptive.

---

## 5.7 Minimal Redundancy

Event Tables SHALL avoid storing duplicate business information.

Business attributes already maintained by Master Entities or Reference
Tables SHALL NOT be unnecessarily duplicated.

Only business information required to preserve the historical event MAY be
stored.

---

## 5.8 Time Orientation

Every Event Table SHALL be organized around business time.

Business timestamps SHALL represent when the event actually occurred.

Database processing timestamps SHALL NOT replace business timestamps.

---

## 5.9 Consistency

Equivalent business events SHALL follow identical design principles
throughout the repository.

The same business event SHALL NOT be modeled differently across services or
markets.

---

## 5.10 Repository Compliance

Every Event Table SHALL comply with:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard
- Repository governance policies

---

# 6. Mandatory Column Groups

## 6.1 Purpose

This section defines the mandatory column groups for Event Tables within the
Phoenix Platform.

A consistent column organization improves readability, maintainability,
historical traceability, and repository-wide consistency.

Unless explicitly approved through an Architecture Decision Record (ADR),
every Event Table SHALL follow the column group structure defined in this
standard.

---

## 6.2 Mandatory Group Order

Event Tables SHALL organize their columns in the following order:

1. Primary Identifier

2. Event Identification

3. Master Entity References

4. Reference Data References

5. Event Details

6. Event Timestamp

7. Lifecycle Attributes

8. Audit Attributes

---

## 6.3 Primary Identifier

Purpose

Provide the immutable surrogate identifier of the event.

Requirements

- Exactly one column.
- BIGINT.
- GENERATED ALWAYS AS IDENTITY.
- Primary Key.
- Immutable.

Example

cash_dividend_id

---

## 6.4 Event Identification

Purpose

Identify the recorded business event.

Typical columns

event_sequence_number

event_source_identifier

external_event_identifier

Only identifiers required by the business SHALL be included.

---

## 6.5 Master Entity References

Purpose

Identify the business objects affected by the event.

Typical examples

instrument_id

issuer_id

market_id

exchange_id

Foreign Keys SHALL reference Master Entity tables.

---

## 6.6 Reference Data References

Purpose

Reference business classifications required by the event.

Typical examples

trading_halt_reason_id

price_adjustment_method_id

corporate_action_status_id

Reference Tables SHALL be used only when business classifications are
required.

---

## 6.7 Event Details

Purpose

Store the business information describing the event.

Examples

adjustment_factor

cash_dividend_amount

announcement_number

approval_reference

Only attributes belonging to the business event SHALL be stored.

---

## 6.8 Event Timestamp

Purpose

Record when the business event occurred.

Typical columns

event_date

event_timestamp

announcement_date

effective_date

Business timestamps SHALL represent business time rather than database
processing time.

---

## 6.9 Lifecycle Attributes

Purpose

Describe the business lifecycle of the event.

Typical examples

event_status_id

is_cancelled

Lifecycle attributes SHALL describe the business state of the event.

---

## 6.10 Audit Attributes

Purpose

Provide complete traceability for database operations.

Audit columns SHALL comply with the AuditModelStandard.

Custom audit implementations are prohibited.

---

## 6.11 Summary

Every Event Table SHALL organize its columns according to the following
canonical sequence:

Primary Identifier

↓

Event Identification

↓

Master Entity References

↓

Reference Data References

↓

Event Details

↓

Event Timestamp

↓

Lifecycle Attributes

↓

Audit Attributes

---

# 7. Primary Key Standard

## 7.1 Purpose

This section defines the mandatory requirements for Primary Keys used by
Event Tables within the Phoenix Platform.

Every Event Table SHALL use a surrogate Primary Key to ensure repository-wide
consistency, stable relationships, and long-term maintainability.

---

## 7.2 Primary Key Requirement

Every Event Table SHALL define exactly one Primary Key.

The Primary Key SHALL uniquely identify one recorded business event.

The Primary Key SHALL have no business meaning.

---

## 7.3 Primary Key Type

The Primary Key SHALL satisfy the following requirements:

- BIGINT
- NOT NULL
- GENERATED ALWAYS AS IDENTITY
- Immutable
- Unique

Primary Key values SHALL never be modified.

---

## 7.4 Naming Convention

Primary Key column names SHALL comply with the Enterprise Naming Standard.

The naming format SHALL be:

<event_table_name>_id

Examples:

cash_dividend_id

capital_increase_id

instrument_price_adjustment_id

trading_halt_id

Generic names are prohibited, including:

id

event_id

record_id

---

## 7.5 Surrogate Identifier

Event Tables SHALL use surrogate identifiers as their Primary Keys.

Business identifiers SHALL remain separate from the Primary Key.

The Primary Key SHALL NOT be exposed as a business identifier.

---

## 7.6 Business Independence

Business identifiers MAY change if required by external business rules.

Such changes SHALL NOT require modification of the Primary Key.

The Primary Key SHALL remain stable throughout the lifetime of the event
record.

---

## 7.7 Foreign Key References

Other database objects SHALL reference Event Tables through their Primary
Keys.

Relationships SHALL NOT be established using business identifiers.

Correct:

cash_dividend_id

Incorrect:

announcement_number

external_event_identifier

---

## 7.8 Prohibited Practices

The following practices are prohibited:

- Using business identifiers as Primary Keys.
- Updating Primary Key values.
- Composite Primary Keys.
- Generic column names.
- Business-dependent identifiers.

---

## 7.9 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Exactly one Primary Key

✓ BIGINT

✓ GENERATED ALWAYS AS IDENTITY

✓ Immutable

✓ Self-descriptive column name

✓ No business meaning

---

# 8. Business Key Standard

## 8.1 Purpose

This section defines the requirements for Business Keys used by Event Tables
within the Phoenix Platform.

A Business Key uniquely identifies a business event according to business
rules while remaining independent from the technical Primary Key.

---

## 8.2 General Principles

An Event Table MAY define a Business Key when a stable business identifier
exists.

Business Keys SHALL NOT be invented solely to satisfy database design.

If no natural business identifier exists, the Event Table SHALL rely only on
its surrogate Primary Key.

---

## 8.3 Typical Business Keys

Business Keys MAY consist of one or more business attributes.

Typical examples include:

announcement_number

external_event_identifier

exchange_event_number

issuer_event_reference

Composite Business Keys MAY be used when required by documented business
rules.

---

## 8.4 Stability

Business Keys SHOULD remain stable.

When an external authority changes a Business Key, the change SHALL be fully
auditable.

Business Key changes SHALL NOT require modification of the Primary Key.

---

## 8.5 Uniqueness

Where a Business Key exists, it SHALL be unique.

Business uniqueness SHALL be enforced using a UNIQUE constraint.

Duplicate Business Keys are prohibited.

---

## 8.6 Nullability

Business Key columns SHALL be defined as NOT NULL whenever they are required
by business rules.

Optional external identifiers MAY be nullable.

---

## 8.7 Naming Convention

Business Key columns SHALL comply with the Enterprise Naming Standard.

Examples include:

announcement_number

external_event_identifier

issuer_event_reference

Generic names such as:

number

reference

identifier

code

are prohibited.

---

## 8.8 Relationship to Primary Key

The Primary Key provides technical identity.

The Business Key provides business identity.

Database relationships SHALL use the Primary Key.

Business interoperability MAY use the Business Key where appropriate.

---

## 8.9 Prohibited Practices

The following practices are prohibited:

- Using the Business Key as the Primary Key.
- Creating artificial Business Keys without business justification.
- Allowing duplicate Business Keys.
- Using generic column names.

---

## 8.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Business Key defined when required

✓ Business Key independent of Primary Key

✓ UNIQUE constraint applied where applicable

✓ Naming complies with the Enterprise Naming Standard

✓ Business meaning documented

---

# 9. Foreign Key Standard

## 9.1 Purpose

This section defines the mandatory requirements for Foreign Keys used by
Event Tables within the Phoenix Platform.

Foreign Keys preserve referential integrity by connecting business events to
their related Master Entity and Reference Tables.

---

## 9.2 General Principles

Every Foreign Key SHALL represent a documented business relationship.

Foreign Keys SHALL improve business traceability rather than merely satisfy
technical implementation requirements.

Unnecessary Foreign Keys are prohibited.

---

## 9.3 Master Entity Relationships

Event Tables SHALL reference the affected Master Entity whenever the event
belongs to a business object.

Typical examples include:

instrument_id

issuer_id

market_id

exchange_id

Foreign Keys SHALL reference the corresponding Master Entity Primary Key.

---

## 9.4 Reference Table Relationships

Event Tables MAY reference Reference Tables when business classifications
are required.

Typical examples include:

corporate_action_type_id

price_adjustment_method_id

trading_halt_reason_id

event_status_id

Reference Tables SHALL NOT be duplicated within Event Tables.

---

## 9.5 Event-to-Event Relationships

An Event Table MAY reference another Event Table only when an explicit
business dependency exists.

Typical examples include:

- A Trading Resume event referencing the corresponding Trading Halt event.
- A correction event referencing the original business event.

Such relationships SHALL represent documented business rules.

---

## 9.6 Prohibited Relationships

Event Tables SHALL NOT:

- Reference Fact Tables.
- Use business attributes instead of Primary Keys.
- Create undocumented relationships.
- Introduce circular dependencies.

---

## 9.7 Naming Convention

Foreign Key column names SHALL comply with the Enterprise Naming Standard.

Format:

<referenced_table_name>_id

Examples:

instrument_id

market_id

trading_halt_reason_id

Generic names such as:

entity_id

reference_id

parent_id

object_id

are prohibited.

---

## 9.8 Referential Integrity

All Foreign Keys SHALL enforce referential integrity.

Recommended referential actions:

ON UPDATE RESTRICT

ON DELETE RESTRICT

Alternative actions SHALL require documented business justification.

---

## 9.9 Nullability

Foreign Keys SHALL be NOT NULL whenever the business relationship is
mandatory.

Nullable Foreign Keys MAY be used only when the relationship is genuinely
optional.

---

## 9.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Business relationships documented

✓ Foreign Keys reference Primary Keys

✓ Self-descriptive Foreign Key names

✓ Referential integrity enforced

✓ No circular dependencies

✓ No references to Fact Tables

---

# 10. Data Type Standard

## 10.1 Purpose

This section defines the canonical data type requirements for Event Tables
within the Phoenix Platform.

Event Tables SHALL use enterprise-approved data types to ensure repository
consistency, historical integrity, and interoperability.

Detailed data type definitions are governed by the
EnterpriseDataTypeStandard.

---

## 10.2 General Principles

Every column SHALL use the most appropriate data type according to its
business meaning.

Data types SHALL remain consistent across equivalent Event Tables.

Business meaning SHALL always take precedence over implementation
convenience.

---

## 10.3 Identifier Columns

Primary Key columns SHALL use:

BIGINT

Foreign Key columns SHALL use the same data type as the referenced Primary
Key.

Business identifier columns SHALL comply with the
EnterpriseDataTypeStandard.

---

## 10.4 Business Attribute Columns

Business attributes SHALL use data types appropriate to the business event.

Typical examples include:

announcement_number

VARCHAR

approval_reference

VARCHAR

document_reference

VARCHAR

---

## 10.5 Event Timestamp Columns

Business dates SHALL use:

DATE

Business timestamps SHALL use:

TIMESTAMP WITH TIME ZONE

when time precision is required by the business.

Examples include:

event_date

announcement_date

effective_date

event_timestamp

---

## 10.6 Numeric Business Values

Numeric values SHALL use appropriate enterprise data types.

Typical examples include:

adjustment_factor

cash_dividend_amount

capital_increase_percentage

share_quantity

Numeric precision SHALL comply with the
EnterpriseDataTypeStandard.

---

## 10.7 Boolean Attributes

Boolean business attributes SHALL use:

BOOLEAN

Typical examples include:

is_cancelled

is_confirmed

is_reversed

---

## 10.8 Nullability

Columns SHALL be defined as NOT NULL whenever the business value is
mandatory.

Nullable columns SHALL be used only where the business explicitly permits
missing information.

---

## 10.9 Repository Consistency

Equivalent business attributes SHALL use identical data types throughout the
repository.

The same business concept SHALL NOT be implemented using different data
types.

---

## 10.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Canonical enterprise data types

✓ Consistent identifier types

✓ Appropriate timestamp types

✓ Appropriate numeric precision

✓ Mandatory values defined as NOT NULL

✓ Compliance with EnterpriseDataTypeStandard

---

# 11. Unique Constraint Standard

## 11.1 Purpose

This section defines the standard for UNIQUE constraints used by Event
Tables within the Phoenix Platform.

UNIQUE constraints preserve business identity by preventing duplicate
registration of the same business event.

---

## 11.2 General Principles

UNIQUE constraints SHALL be implemented only when a documented business rule
requires business uniqueness.

Unlike Reference Tables, UNIQUE constraints are NOT mandatory for every
Event Table.

Business requirements SHALL determine whether uniqueness is required.

---

## 11.3 Business Key Uniqueness

When an Event Table defines a Business Key, that Business Key SHALL be
protected by a UNIQUE constraint.

Typical examples include:

announcement_number

exchange_event_number

external_event_identifier

issuer_event_reference

---

## 11.4 Composite Business Keys

Business uniqueness MAY depend upon multiple business attributes.

Typical examples include:

instrument_id +
announcement_number

instrument_id +
event_timestamp +
event_type_id

Composite UNIQUE constraints SHALL represent documented business rules.

---

## 11.5 Technical Requirements

UNIQUE constraints SHALL:

- Be explicitly named.
- Represent documented business rules.
- Prevent duplicate business events.
- Remain stable throughout the event lifecycle.

Constraint names SHALL comply with the Enterprise Naming Standard.

---

## 11.6 Constraint Naming

Recommended naming format:

uq_<event_table_name>_<business_attribute>

Examples:

uq_cash_dividend_announcement_number

uq_capital_increase_external_event_identifier

uq_trading_halt_exchange_event_number

---

## 11.7 Duplicate Constraints

Duplicate UNIQUE constraints are prohibited.

Equivalent uniqueness rules SHALL be implemented only once.

---

## 11.8 Business Meaning

Every UNIQUE constraint SHALL have a documented business purpose.

Technical uniqueness without business justification is prohibited.

---

## 11.9 Repository Consistency

Equivalent Event Tables SHALL implement equivalent business uniqueness
rules.

The same business event SHALL NOT use inconsistent uniqueness rules across
the repository.

---

## 11.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Business uniqueness documented

✓ UNIQUE constraints applied where required

✓ Explicitly named constraints

✓ No duplicate business identifiers

✓ Enterprise Naming Standard compliance

---

# 12. Check Constraint Standard

## 12.1 Purpose

This section defines the standard for CHECK constraints used by Event
Tables within the Phoenix Platform.

CHECK constraints SHALL enforce deterministic business validation rules at
the database level while preserving data integrity.

---

## 12.2 General Principles

CHECK constraints SHALL validate only simple business rules that can be
evaluated by the database.

Business workflows SHALL NOT be implemented using CHECK constraints.

---

## 12.3 Appropriate Usage

CHECK constraints SHOULD validate:

- Numeric ranges
- Positive quantities
- Percentage limits
- Date consistency
- Timestamp consistency
- Boolean consistency

Typical examples include:

cash_dividend_amount >= 0

adjustment_factor > 0

effective_date >= announcement_date

---

## 12.4 Prohibited Usage

CHECK constraints SHALL NOT:

- Reference other tables.
- Call external functions.
- Implement business workflows.
- Replace application logic.
- Enforce authorization rules.

---

## 12.5 Constraint Naming

CHECK constraint names SHALL comply with the Enterprise Naming Standard.

Recommended format:

ck_<event_table_name>_<business_rule>

Examples:

ck_cash_dividend_positive_amount

ck_capital_increase_percentage

ck_trading_halt_date_range

---

## 12.6 Nullability

CHECK constraints SHALL correctly distinguish between:

- Mandatory business values
- Optional business values

Mandatory values SHALL additionally use NOT NULL constraints.

---

## 12.7 Repository Consistency

Equivalent business validation rules SHALL use equivalent CHECK constraints
throughout the repository.

Validation logic SHALL remain consistent across Event Tables.

---

## 12.8 Documentation

Every CHECK constraint SHALL represent a documented business rule.

Its business meaning SHALL be understandable without application code.

---

## 12.9 Prohibited Practices

The following practices are prohibited:

- Redundant CHECK constraints.
- Conflicting validation rules.
- Undocumented validation rules.
- Overly complex expressions.
- Using CHECK constraints as workflow engines.

---

## 12.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Deterministic validation rules

✓ Enterprise Naming Standard compliance

✓ Business rules documented

✓ Mandatory values protected

✓ Repository-wide consistency maintained

---

# 13. Index Standard

## 13.1 Purpose

This section defines the indexing principles for Event Tables within the
Phoenix Platform.

Indexes SHALL support efficient retrieval of business events while
preserving write performance, scalability, and repository-wide consistency.

---

## 13.2 General Principles

Indexes SHALL be created based on documented access patterns rather than
speculation.

Every index SHALL provide measurable business or technical value.

Duplicate or unnecessary indexes are prohibited.

---

## 13.3 Primary Key Index

The Primary Key SHALL be indexed automatically by the database.

Additional indexes SHALL NOT be created on the Primary Key.

---

## 13.4 Foreign Key Indexes

Indexes SHOULD be created on Foreign Key columns when they support:

- Business object lookups
- Join operations
- Event history retrieval
- Event timeline analysis

Typical examples include:

instrument_id

market_id

exchange_id

issuer_id

---

## 13.5 Business Key Indexes

When a Business Key exists, the associated UNIQUE constraint SHALL provide
an efficient lookup path.

Additional indexes SHALL NOT duplicate the UNIQUE index.

---

## 13.6 Timestamp Indexes

Business timestamp columns SHOULD be indexed whenever chronological queries
are expected.

Typical examples include:

event_date

event_timestamp

announcement_date

effective_date

Time-based analysis SHALL be considered a primary Event Table access
pattern.

---

## 13.7 Composite Indexes

Composite indexes MAY be created when supported by documented query
patterns.

Typical examples include:

instrument_id +
event_date

instrument_id +
event_timestamp

market_id +
event_date

Columns SHALL be ordered according to expected filtering selectivity.

---

## 13.8 Index Naming

Index names SHALL comply with the Enterprise Naming Standard.

Recommended format:

idx_<table_name>_<column_list>

Examples:

idx_cash_dividend_instrument_id

idx_cash_dividend_event_date

idx_trading_halt_market_id_event_date

---

## 13.9 Performance Review

Indexes SHALL be periodically reviewed.

Indexes with no measurable benefit SHOULD be removed.

Index optimization SHALL balance read performance against write
performance.

---

## 13.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Primary Key indexed

✓ Foreign Keys indexed where justified

✓ Timestamp indexes evaluated

✓ No duplicate indexes

✓ Enterprise Naming Standard compliance

✓ Performance periodically reviewed

---

# 14. Event Lifecycle Standard

## 14.1 Purpose

This section defines the lifecycle management principles for Event Tables
within the Phoenix Platform.

Event Tables SHALL preserve the complete history of business events while
ensuring traceability, auditability, and historical integrity.

---

## 14.2 Lifecycle Principles

Every business event SHALL follow a controlled lifecycle.

The lifecycle SHALL preserve the original occurrence of the event.

Historical business events SHALL remain available for future analysis.

---

## 14.3 Event Creation

A new Event record SHALL be created when a business event occurs.

Every new event SHALL:

- Have a valid Primary Key.
- Satisfy all mandatory constraints.
- Reference required Master Entities.
- Reference required Reference Tables.
- Record the business occurrence time.

---

## 14.4 Event Confirmation

Business processes MAY distinguish between:

- Recorded events
- Confirmed events

Where confirmation is required, the business state SHALL be represented by
documented lifecycle attributes.

---

## 14.5 Event Correction

Historical Event records SHOULD NOT be modified.

Business corrections SHOULD be represented by:

- Correction events
- Reversal events
- Replacement events

Direct modification SHALL be permitted only when required by legal or
operational obligations and SHALL remain fully auditable.

---

## 14.6 Event Cancellation

Business cancellation SHALL NOT remove historical evidence that the event
was recorded.

Cancelled events SHOULD remain stored together with their business status.

Physical deletion is discouraged.

---

## 14.7 Event Retention

Historical Event records SHALL be retained according to repository data
retention policies.

Event retention SHALL support:

- Historical analysis
- Regulatory compliance
- Business traceability
- Audit requirements

---

## 14.8 Event Archiving

Historical Event records MAY be archived.

Archiving SHALL preserve:

- Referential integrity
- Business chronology
- Audit information

Archived records SHALL remain recoverable.

---

## 14.9 Governance

Lifecycle operations SHALL comply with repository governance policies.

Major lifecycle changes MAY require approval through an Architecture
Decision Record (ADR).

---

## 14.10 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Controlled event creation

✓ Historical integrity preserved

✓ Event corrections remain auditable

✓ Event cancellation preserves history

✓ Retention policy defined

✓ Governance process followed

---

# 15. Event Governance Standard

## 15.1 Purpose

This section defines the governance principles for Event Tables within the
Phoenix Platform.

Business events constitute permanent business records and SHALL be governed
as enterprise assets to ensure consistency, traceability, integrity, and
long-term maintainability.

---

## 15.2 Governance Principles

Event data SHALL be:

- Business governed
- Repository controlled
- Fully auditable
- Historically preserved
- Consistently documented

Event records SHALL NOT be managed independently by individual
applications or services.

---

## 15.3 Ownership

Every Event Table SHALL have an identified business owner.

The business owner SHALL be responsible for:

- Defining business meaning.
- Approving structural changes.
- Approving lifecycle rules.
- Approving retention requirements.
- Maintaining business documentation.

Technical implementation SHALL remain the responsibility of the development
team.

---

## 15.4 Change Management

Changes affecting Event Tables SHALL follow the repository change management
process.

Every change SHALL be evaluated for its impact on:

- Historical integrity
- Dependent business processes
- Related Master Entities
- Related Reference Tables
- Analytical services
- Reporting services

---

## 15.5 Version Control

All Event Table definitions SHALL be maintained under version control.

Every structural modification SHALL be traceable through repository
history.

Business rule modifications SHOULD also be documented.

---

## 15.6 Documentation

Every Event Table SHALL include documented information describing:

- Business purpose
- Business event definition
- Business owner
- Relationships
- Lifecycle
- Retention policy
- Business rules

Documentation SHALL remain synchronized with the implemented database
schema.

---

## 15.7 Repository Consistency

Equivalent business events SHALL follow identical architectural principles.

Duplicate Event Tables representing the same business event are prohibited.

Repository consistency SHALL take precedence over local implementation
preferences.

---

## 15.8 Governance Review

Event Tables SHOULD be reviewed periodically to verify:

- Continued business relevance
- Historical integrity
- Naming consistency
- Lifecycle compliance
- Repository compliance

---

## 15.9 Compliance Checklist

Every Event Table SHALL satisfy the following:

✓ Business owner identified

✓ Repository governance followed

✓ Fully documented

✓ Version controlled

✓ Lifecycle documented

✓ Repository consistency maintained

---

# 16. Event Table Anti-Patterns

## 16.1 Purpose

This section identifies common design mistakes that SHALL be avoided when
designing Event Tables within the Phoenix Platform.

Avoiding these anti-patterns improves repository consistency, historical
accuracy, maintainability, and architectural quality.

---

## 16.2 Mixing Multiple Business Events

An Event Table SHALL represent exactly one business event.

Incorrect:

CorporateActionEvent

Correct:

CashDividend

CapitalIncrease

StockSplit

---

## 16.3 Using Event Tables as Master Entities

Event Tables SHALL NOT store business entities.

Incorrect:

Instrument

Broker

Issuer

Correct:

InstrumentListing

BrokerRegistration

IssuerNameChange

---

## 16.4 Using Event Tables as Reference Tables

Event Tables SHALL NOT contain static business classifications.

Incorrect:

TradingHaltReason

CorporateActionType

Correct:

TradingHalt

CashDividend

---

## 16.5 Using Event Tables as Fact Tables

Event Tables SHALL NOT store:

- Daily measurements
- Aggregated values
- Statistical summaries
- Time-series observations

Incorrect:

DailyMarketData

MarketIndexValue

Correct:

InstrumentPriceAdjustment

TradingResume

---

## 16.6 Updating Historical Events

Historical Event records SHOULD NOT be routinely updated.

Business corrections SHOULD be represented through additional business
events.

Direct modification SHALL remain exceptional.

---

## 16.7 Generic Column Names

Generic column names are prohibited.

Incorrect:

id

code

name

status

date

Correct:

cash_dividend_id

event_status_id

announcement_date

effective_date

---

## 16.8 Missing Business Timestamp

Every Event Table SHALL contain a business timestamp.

Database insertion timestamps SHALL NOT replace business occurrence time.

---

## 16.9 Circular Dependencies

Circular dependencies between Event Tables are prohibited.

Event relationships SHALL remain hierarchical and traceable.

---

## 16.10 Duplicate Business Events

The same business event SHALL NOT be recorded multiple times unless
explicitly required by documented business rules.

Business uniqueness SHALL be enforced where applicable.

---

## 16.11 Repository Inconsistency

Equivalent business events SHALL be modeled consistently throughout the
repository.

Naming, relationships, lifecycle, and constraints SHALL remain consistent.

---

## 16.12 Premature Generalization

Event Tables SHALL NOT be designed for hypothetical future business events.

Only approved business requirements SHALL influence the current design.

Future extensibility SHALL be achieved through architectural flexibility
rather than speculative implementation.

---

## 16.13 Summary

The following practices are prohibited:

✗ Mixing multiple business events

✗ Using Event Tables as Master Entities

✗ Using Event Tables as Reference Tables

✗ Using Event Tables as Fact Tables

✗ Updating historical events without justification

✗ Generic column names

✗ Missing business timestamps

✗ Circular dependencies

✗ Duplicate business events

✗ Repository inconsistency

✗ Premature generalization

---

# 17. Event Table Design Checklist

## 17.1 Purpose

This checklist defines the mandatory architectural verification criteria
for designing Event Tables within the Phoenix Platform.

Every new Event Table SHALL satisfy all applicable checklist items before
implementation.

---

## 17.2 Business Purpose

□ Represents exactly one business event.

□ Has a clearly documented business purpose.

□ Has an identified business owner.

□ Does not represent a Master Entity.

□ Does not represent a Reference Table.

□ Does not represent a Fact Table.

---

## 17.3 Naming Compliance

□ Table name complies with the Enterprise Naming Standard.

□ All column names are self-descriptive.

□ No generic column names are used.

□ Naming is consistent across the repository.

---

## 17.4 Primary Key

□ Uses a surrogate Primary Key.

□ BIGINT.

□ GENERATED ALWAYS AS IDENTITY.

□ Primary Key is immutable.

□ Primary Key name follows:

<event_table_name>_id

---

## 17.5 Business Key

□ Business Key defined when required.

□ Business Key independent from Primary Key.

□ UNIQUE constraint implemented where applicable.

□ Business meaning documented.

---

## 17.6 Relationships

□ Foreign Keys reference Master Entity tables.

□ Reference Tables used only where appropriate.

□ No references to Fact Tables.

□ No circular dependencies.

□ Referential integrity enforced.

---

## 17.7 Event Attributes

□ Business event attributes are complete.

□ Business timestamps are present.

□ Event chronology preserved.

□ No duplicated business information.

---

## 17.8 Constraints

□ UNIQUE constraints implemented where required.

□ CHECK constraints validate simple business rules.

□ NOT NULL applied where appropriate.

□ Constraint names comply with the Enterprise Naming Standard.

---

## 17.9 Data Types

□ Enterprise data types are used.

□ Identifier types are consistent.

□ Business timestamps use approved types.

□ Numeric precision complies with the EnterpriseDataTypeStandard.

---

## 17.10 Indexes

□ Primary Key indexed.

□ Foreign Key indexes evaluated.

□ Timestamp indexes evaluated.

□ No duplicate indexes.

---

## 17.11 Lifecycle

□ Event creation documented.

□ Event correction policy defined.

□ Historical integrity preserved.

□ Retention policy documented.

□ Archive strategy defined where applicable.

---

## 17.12 Governance

□ Business owner identified.

□ Fully documented.

□ Version controlled.

□ Repository governance followed.

□ Repository consistency verified.

---

## 17.13 Final Verification

An Event Table SHALL NOT be approved unless all mandatory checklist items
have been reviewed and satisfied.

Any deviation from this standard SHALL require formal architectural
approval through the repository governance process.

---

# 18. References

## 18.1 Purpose

This section identifies the repository standards and architectural
documents referenced by this standard.

EventTableDesignStandard SHALL be interpreted together with these documents
to ensure a consistent and maintainable enterprise database architecture.

---

## 18.2 Mandatory Standards

The following standards are mandatory references:

- EnterpriseNamingStandard
- EnterpriseDataTypeStandard
- MasterEntityColumnNamingStandard
- AuditModelStandard

Compliance with these standards is required unless an approved Architecture
Decision Record (ADR) explicitly authorizes an exception.

---

## 18.3 Related Database Standards

The following database standards complement this document:

- MasterEntityDesignStandard
- ReferenceTableDesignStandard
- FactTableDesignStandard

Together these documents define the canonical database table architecture
for the Phoenix Platform.

---

## 18.4 Repository Standards

Event Tables SHALL comply with repository-wide standards governing:

- Repository organization
- Documentation
- Naming
- Governance
- Database architecture

Repository standards take precedence over local implementation
preferences.

---

## 18.5 Architecture Decision Records

Whenever this standard conflicts with an approved Architecture Decision
Record (ADR), the ADR SHALL take precedence.

All approved deviations SHALL be documented through an ADR.

---

## 18.6 Future Revisions

This standard SHALL evolve together with the Phoenix Platform.

Future revisions SHALL preserve backward compatibility whenever reasonably
possible.

Breaking changes SHALL be reviewed and approved before adoption.

---

## 18.7 Summary

EventTableDesignStandard defines the canonical design principles for
Business Event Tables within the Phoenix Platform.

Together with the Master Entity, Reference Table, and Fact Table standards,
it establishes the enterprise database foundation for all current and future
financial markets supported by the platform.

---

## End of Document