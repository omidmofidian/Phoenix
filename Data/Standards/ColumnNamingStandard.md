# Column Naming Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-DATA-001 |
| Document | ColumnNamingStandard |
| Version | 2026.1 |
| Status | Draft |
| Classification | Enterprise Data Standard |
| Owner | Enterprise Architecture Team |
| Governed By | Enterprise Governance Framework |
| Last Updated | 2026-07-28 |

---

# 1. Introduction

## 1.1 Purpose

This standard defines the canonical naming conventions for all database
columns within the Phoenix Platform.

Its purpose is to ensure consistency, readability, maintainability, and
architectural integrity across every database object throughout the
repository.

This standard applies to every column regardless of table type.

---

## 1.2 Scope

This standard governs column naming for all database tables, including but
not limited to:

- Master Entity Tables
- Reference Tables
- Fact Tables
- Event Tables
- Bridge Tables

The rules defined in this document SHALL be applied consistently across all
database schemas within the Phoenix Platform.

---

## 1.3 Objectives

The objectives of this standard are to:

- Establish a single enterprise-wide column naming convention.
- Eliminate ambiguity in column names.
- Improve schema readability.
- Simplify database maintenance.
- Ensure consistency across all database objects.
- Support long-term repository evolution.

---

## 1.4 General Principles

Every column name SHALL:

- Be meaningful.
- Be self-descriptive.
- Be business-oriented.
- Be consistent throughout the repository.
- Follow the Enterprise Naming Standard.
- Follow the rules defined in this document.

Column names SHALL remain stable throughout the lifecycle of the database.

---

## 1.5 Canonical Naming Rule

Phoenix Platform adopts a single canonical naming convention for all
business columns.

Every business attribute SHALL include the entity name as its prefix.

The canonical format is:

<entity_name>_<attribute_name>

Examples:

exchange_name

exchange_local_name

exchange_short_name

exchange_code

market_name

market_local_name

board_name

board_local_name

instrument_name

instrument_local_name

issuer_name

issuer_local_name

No exceptions to this rule are permitted unless explicitly approved through
an Architecture Decision Record (ADR).

---

## 1.6 Consistency Principle

Equivalent business concepts SHALL use identical column names throughout
the repository.

Different names SHALL NOT be used to represent the same business concept.

Example:

exchange_name

market_name

board_name

issuer_name

are consistent because they follow the same canonical naming pattern.

---

## 1.7 Repository Compliance

Every database object within the Phoenix Platform SHALL comply with this
standard.

Local naming preferences are prohibited.

Repository-wide consistency SHALL take precedence over individual design
preferences.

---

## 1.8 Compliance Checklist

Every column SHALL satisfy the following requirements:

✓ Self-descriptive

✓ Business-oriented

✓ Consistent across the repository

✓ Entity-prefixed

✓ Enterprise Naming Standard compliant

---

# 2. General Naming Rules

## 2.1 Purpose

This section defines the general rules governing database column names
throughout the Phoenix Platform.

These rules establish a consistent naming convention applicable to every
database table regardless of its classification.

---

## 2.2 Language

All column names SHALL be written in English.

Localized names SHALL be stored as data values and SHALL NOT be used as
database identifiers.

---

## 2.3 Letter Case

All column names SHALL use lowercase letters.

Uppercase letters are prohibited.

Correct examples:

exchange_name

market_id

listing_date

Incorrect examples:

Exchange_Name

MarketID

ListingDate

---

## 2.4 Word Separator

Multiple words SHALL be separated using the underscore character (_).

CamelCase is prohibited.

PascalCase is prohibited.

Hyphens are prohibited.

Spaces are prohibited.

Correct examples:

exchange_local_name

instrument_type_id

listing_status_code

Incorrect examples:

exchangeLocalName

ExchangeLocalName

exchange-local-name

exchange local name

---

## 2.5 Naming Pattern

Column names SHALL follow the canonical format:

<entity_name>_<attribute_name>

Examples:

exchange_name

exchange_local_name

exchange_code

market_name

market_local_name

board_name

instrument_symbol

issuer_status_id

---

## 2.6 Singular Form

Entity names SHALL always be singular.

Correct examples:

exchange_name

market_name

board_name

Incorrect examples:

exchanges_name

markets_name

boards_name

---

## 2.7 Readability

Column names SHALL be concise while remaining meaningful.

Unnecessary abbreviations are prohibited.

Ambiguous names are prohibited.

Correct examples:

exchange_short_name

market_open_date

issuer_registration_number

Incorrect examples:

exch_nm

mkt_dt

iss_reg_no

---

## 2.8 Approved Abbreviations

Only enterprise-approved abbreviations MAY be used.

Examples include:

id

url

uri

uuid

isin

ip

utc

iso

json

xml

Unapproved abbreviations are prohibited.

---

## 2.9 Reserved Words

Database reserved keywords SHALL NOT be used as column names.

Examples of prohibited names include:

user

order

group

table

select

where

index

If a business concept conflicts with a reserved word, an alternative,
self-descriptive name SHALL be selected.

---

## 2.10 Stability

Column names SHALL remain stable throughout the database lifecycle.

Renaming an existing column SHALL require:

- Business justification.
- Architecture review.
- Repository-wide impact assessment.
- Approval through repository governance.

Backward compatibility SHALL be considered before renaming any column.

---

## 2.11 Consistency

Equivalent business concepts SHALL use identical naming patterns across the
entire repository.

Alternative naming for the same business attribute is prohibited.

Example:

exchange_name

market_name

board_name

issuer_name

instrument_name

---

## 2.12 Compliance Checklist

Every column name SHALL satisfy the following:

✓ English language

✓ Lowercase letters

✓ Snake_case format

✓ Singular entity name

✓ Canonical <entity>_<attribute> pattern

✓ Repository consistency

✓ Enterprise-approved abbreviations only

✓ Reserved words avoided

✓ Stable throughout the lifecycle

---

# 3. Identifier Columns

## 3.1 Purpose

This section defines the canonical naming rules for identifier columns
within the Phoenix Platform.

Identifier columns uniquely identify business entities and establish
relationships between database objects.

---

## 3.2 General Principles

Every identifier column SHALL:

- Be uniquely identifiable.
- Be self-descriptive.
- Include the entity name.
- Follow the Enterprise Naming Standard.
- Comply with the canonical naming rules defined in this document.

Generic identifier names are prohibited.

---

## 3.3 Primary Key Columns

Primary Key columns SHALL follow the format:

<entity_name>_id

Examples:

exchange_id

market_id

board_id

instrument_id

issuer_id

country_id

currency_id

---

## 3.4 Foreign Key Columns

Foreign Key columns SHALL use exactly the same name as the referenced
Primary Key column.

Examples:

exchange_id

market_id

board_id

issuer_id

instrument_type_id

market_status_id

---

## 3.5 Business Identifier Columns

Business identifiers SHALL clearly describe the business identifier they
represent.

Examples:

isin

lei

national_identifier

registration_number

license_number

Business identifiers SHALL NOT use the "_id" suffix unless they reference
another database entity.

---

## 3.6 External Identifier Columns

Identifiers originating from external systems SHALL explicitly indicate
their origin.

Examples:

tsetmc_identifier

codal_identifier

seo_identifier

vendor_identifier

provider_identifier

External identifiers SHALL remain stable whenever possible.

---

## 3.7 Classification Identifier Columns

Columns referencing classification entities SHALL follow the canonical
pattern:

<classification_entity>_id

Examples:

market_type_id

board_type_id

instrument_type_id

listing_status_id

currency_type_id

---

## 3.8 Identifier Consistency

Equivalent identifiers SHALL use identical names throughout the
repository.

Examples:

exchange_id

market_id

board_id

issuer_id

instrument_id

Alternative naming patterns are prohibited.

---

## 3.9 Prohibited Identifier Names

The following identifier names are prohibited:

id

entity_id

object_id

reference_id

record_id

key

identifier

value_id

These names are insufficiently descriptive and violate the canonical
naming convention.

---

## 3.10 Compliance Checklist

Every identifier column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Uses the "_id" suffix when referencing a database entity

✓ Business identifiers clearly described

✓ External identifiers explicitly identified

✓ Repository-wide consistency maintained

---

# 4. Name Columns

## 4.1 Purpose

This section defines the canonical naming rules for columns representing
business names within the Phoenix Platform.

These rules ensure that business names are consistent, self-descriptive,
and uniformly interpreted throughout the repository.

---

## 4.2 General Principles

Every name column SHALL:

- Represent a business name.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic name columns are prohibited.

---

## 4.3 Canonical Naming Pattern

Name columns SHALL follow the format:

<entity_name>_name

Examples:

exchange_name

market_name

board_name

instrument_name

issuer_name

industry_name

sector_name

country_name

currency_name

---

## 4.4 Local Name Columns

Columns representing localized or native-language names SHALL follow the
format:

<entity_name>_local_name

Examples:

exchange_local_name

market_local_name

board_local_name

instrument_local_name

issuer_local_name

industry_local_name

sector_local_name

country_local_name

currency_local_name

No exceptions to this rule are permitted.

---

## 4.5 Short Name Columns

Columns representing abbreviated business names SHALL follow the format:

<entity_name>_short_name

Examples:

exchange_short_name

market_short_name

board_short_name

instrument_short_name

issuer_short_name

---

## 4.6 Full Name Columns

When both short and full names are required, the complete business name
SHALL follow the format:

<entity_name>_full_name

Examples:

issuer_full_name

organization_full_name

company_full_name

---

## 4.7 Official Name Columns

When an official legal or regulatory name is required, the column SHALL
follow the format:

<entity_name>_official_name

Examples:

exchange_official_name

issuer_official_name

organization_official_name

---

## 4.8 Name Consistency

Equivalent business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

exchange_name

market_name

board_name

issuer_name

instrument_name

Likewise:

exchange_local_name

market_local_name

board_local_name

issuer_local_name

instrument_local_name

Repository-wide consistency SHALL take precedence over local preferences.

---

## 4.9 Prohibited Name Columns

The following column names are prohibited:

name

local_name

short_name

full_name

official_name

entity_name

object_name

record_name

These names violate the canonical entity-prefixed naming convention.

---

## 4.10 Compliance Checklist

Every name column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ No generic column names

---

# 5. Code Columns

## 5.1 Purpose

This section defines the canonical naming rules for columns representing
business codes within the Phoenix Platform.

Business codes uniquely identify or classify business entities according
to organizational, regulatory, market, or external standards.

---

## 5.2 General Principles

Every code column SHALL:

- Represent a business code.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic code columns are prohibited.

---

## 5.3 Canonical Naming Pattern

Code columns SHALL follow the format:

<entity_name>_code

Examples:

exchange_code

market_code

board_code

industry_code

sector_code

country_code

currency_code

---

## 5.4 External Standard Codes

Columns representing internationally recognized business codes SHALL also
include the entity name.

Examples:

instrument_isin

currency_iso_code

country_iso_code

organization_lei

exchange_mic_code

The use of standalone column names such as:

isin

lei

iso_code

mic

is prohibited.

---

## 5.5 Internal Business Codes

Organization-specific business codes SHALL clearly identify the entity they
describe.

Examples:

issuer_code

instrument_code

market_segment_code

trading_board_code

listing_category_code

---

## 5.6 Regulatory Codes

Codes assigned by regulatory authorities SHALL include both the entity name
and the regulatory context whenever appropriate.

Examples:

issuer_registration_code

exchange_license_code

security_registration_code

---

## 5.7 Vendor Codes

Codes originating from external providers SHALL indicate the provider when
necessary to avoid ambiguity.

Examples:

instrument_tsetmc_code

issuer_codal_code

exchange_vendor_code

provider_security_code

---

## 5.8 Code Consistency

Equivalent business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

exchange_code

market_code

board_code

issuer_code

instrument_code

Repository-wide consistency SHALL be maintained.

---

## 5.9 Prohibited Code Columns

The following column names are prohibited:

code

business_code

internal_code

external_code

system_code

vendor_code

identifier_code

These names violate the canonical entity-prefixed naming convention.

---

## 5.10 Compliance Checklist

Every code column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ No generic column names

---

# 6. Description Columns

## 6.1 Purpose

This section defines the canonical naming rules for columns containing
descriptive business information within the Phoenix Platform.

Description columns provide explanatory information about a business
entity and SHALL NOT be used as identifiers or business names.

---

## 6.2 General Principles

Every description column SHALL:

- Represent descriptive business information.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic description columns are prohibited.

---

## 6.3 Canonical Naming Pattern

Description columns SHALL follow the format:

<entity_name>_description

Examples:

exchange_description

market_description

board_description

instrument_description

issuer_description

industry_description

sector_description

---

## 6.4 Long Description Columns

When both short and extended descriptions are required, the extended
description SHALL follow the format:

<entity_name>_long_description

Examples:

exchange_long_description

market_long_description

instrument_long_description

---

## 6.5 Business Notes

Columns intended to store business notes SHALL explicitly indicate their
purpose.

Examples:

exchange_notes

market_notes

issuer_notes

instrument_notes

Business notes SHALL NOT replace structured business attributes.

---

## 6.6 Remarks

Columns containing remarks or operational comments SHALL follow the
canonical naming convention.

Examples:

exchange_remarks

market_remarks

board_remarks

issuer_remarks

---

## 6.7 Documentation Columns

Columns intended to reference additional documentation SHALL clearly
identify their purpose.

Examples:

exchange_document_reference

instrument_specification_reference

issuer_profile_reference

Such columns SHALL contain references only and SHALL NOT store large
documents.

---

## 6.8 Description Consistency

Equivalent business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

exchange_description

market_description

board_description

issuer_description

instrument_description

Repository-wide consistency SHALL be maintained.

---

## 6.9 Prohibited Description Columns

The following column names are prohibited:

description

long_description

notes

remarks

comments

text

detail

details

memo

These names violate the canonical entity-prefixed naming convention.

---

## 6.10 Compliance Checklist

Every description column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ No generic column names

---

# 7. Status Columns

## 7.1 Purpose

This section defines the canonical naming rules for columns representing
business status information within the Phoenix Platform.

Status columns describe the current state of a business entity throughout
its lifecycle.

---

## 7.2 General Principles

Every status column SHALL:

- Represent a business status.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic status columns are prohibited.

---

## 7.3 Canonical Naming Pattern

Status columns SHALL follow the format:

<entity_name>_status_id

Examples:

exchange_status_id

market_status_id

board_status_id

instrument_status_id

issuer_status_id

industry_status_id

sector_status_id

Status values SHALL reference an approved Reference Table.

---

## 7.4 Status Code Columns

When a business status is represented by a standardized business code,
the column SHALL follow the format:

<entity_name>_status_code

Examples:

exchange_status_code

market_status_code

board_status_code

instrument_status_code

issuer_status_code

Status codes SHALL be defined and governed by the corresponding
Reference Table.

---

## 7.5 Lifecycle Status Columns

Columns representing lifecycle states SHALL follow the canonical naming
convention.

Examples:

instrument_lifecycle_status_id

issuer_lifecycle_status_id

market_lifecycle_status_id

Lifecycle statuses SHALL be modeled as reference data.

---

## 7.6 Operational Status Columns

Operational status columns SHALL clearly identify the operational state
being represented.

Examples:

exchange_operational_status_id

market_operational_status_id

board_operational_status_id

trading_session_status_id

---

## 7.7 Boolean Status Columns

Binary business states SHALL use Boolean columns following the format:

<entity_name>_is_<state>

Examples:

exchange_is_active

market_is_active

board_is_tradable

instrument_is_listed

issuer_is_suspended

Boolean columns SHALL represent only two mutually exclusive states.

Business states containing more than two possible values SHALL use
Reference Tables instead of Boolean columns.

---

## 7.8 Status Consistency

Equivalent business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

exchange_status_id

market_status_id

board_status_id

issuer_status_id

instrument_status_id

Repository-wide consistency SHALL be maintained.

---

## 7.9 Prohibited Status Columns

The following column names are prohibited:

status

status_id

status_code

is_active

is_enabled

is_valid

active

enabled

valid

These names violate the canonical entity-prefixed naming convention.

---

## 7.10 Compliance Checklist

Every status column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ Generic column names prohibited

✓ Reference Tables used for multi-state business status

✓ Boolean columns limited to binary business states

---

# 8. Classification Columns

## 8.1 Purpose

This section defines the canonical naming rules for columns representing
business classifications within the Phoenix Platform.

Classification columns associate business entities with predefined
classification data maintained in Reference Tables.

---

## 8.2 General Principles

Every classification column SHALL:

- Represent a business classification.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Reference a canonical Reference Table.
- Be consistently named throughout the repository.

Generic classification columns are prohibited.

---

## 8.3 Canonical Naming Pattern

Classification columns SHALL follow the format:

<classification_entity>_id

Examples:

market_type_id

board_type_id

instrument_type_id

exchange_type_id

issuer_type_id

currency_type_id

country_type_id

Classification columns SHALL reference the corresponding Reference Table.

---

## 8.4 Category Classifications

Business categories SHALL use the canonical naming convention.

Examples:

industry_category_id

instrument_category_id

issuer_category_id

market_category_id

board_category_id

---

## 8.5 Group Classifications

Business grouping columns SHALL clearly identify the grouping entity.

Examples:

industry_group_id

sector_group_id

asset_group_id

instrument_group_id

---

## 8.6 Level Classifications

Hierarchical classification levels SHALL explicitly identify the level
being represented.

Examples:

risk_level_id

market_level_id

listing_level_id

priority_level_id

---

## 8.7 Classification Consistency

Equivalent business classifications SHALL use identical naming patterns
throughout the repository.

Examples:

instrument_type_id

market_type_id

board_type_id

issuer_type_id

Repository-wide consistency SHALL be maintained.

---

## 8.8 Reference Table Requirement

Classification columns SHALL always reference Reference Tables.

Classification values SHALL NOT be stored directly as free-text values.

Examples:

Correct:

instrument_type_id

market_type_id

Incorrect:

instrument_type

market_type

board_category

industry_group

---

## 8.9 Prohibited Classification Columns

The following column names are prohibited:

type

category

group

class

classification

level

type_id

category_id

group_id

These names violate the canonical entity-prefixed naming convention and
are insufficiently descriptive.

---

## 8.10 Compliance Checklist

Every classification column SHALL satisfy the following:

✓ Self-descriptive

✓ References a Reference Table

✓ Repository consistent

✓ Uses the approved naming pattern

✓ Generic classification names prohibited

✓ No free-text classification values

---

# 9. Date and Time Columns

## 9.1 Purpose

This section defines the canonical naming rules for columns representing
dates, times, timestamps, and temporal business information within the
Phoenix Platform.

Date and time columns SHALL accurately describe business events,
operational milestones, or lifecycle timestamps.

---

## 9.2 General Principles

Every date or time column SHALL:

- Represent a single business event or point in time.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic temporal column names are prohibited.

---

## 9.3 Canonical Naming Pattern

Temporal columns SHALL follow the format:

<entity_name>_<business_event>

Examples:

exchange_established_date

market_open_date

board_activation_date

instrument_listing_date

issuer_registration_date

industry_effective_date

---

## 9.4 Date Columns

Columns representing calendar dates SHALL use descriptive business names.

Examples:

instrument_listing_date

instrument_delisting_date

issuer_registration_date

exchange_established_date

market_closure_date

---

## 9.5 Time Columns

Columns representing a specific time of day SHALL clearly identify the
business event.

Examples:

market_open_time

market_close_time

auction_start_time

auction_end_time

---

## 9.6 Timestamp Columns

Columns representing an exact business timestamp SHALL follow the
canonical naming convention.

Examples:

instrument_listing_timestamp

market_open_timestamp

issuer_registration_timestamp

event_occurrence_timestamp

Timestamp columns SHALL represent a precise point in time.

---

## 9.7 Effective Period Columns

Columns representing business validity periods SHALL explicitly identify
the beginning and end of the period.

Examples:

exchange_effective_from

exchange_effective_to

market_valid_from

market_valid_to

instrument_trading_from

instrument_trading_to

---

## 9.8 Repository Consistency

Equivalent business events SHALL use identical naming patterns
throughout the repository.

Examples:

listing_date

registration_date

effective_from

effective_to

activation_date

The corresponding entity name SHALL always be included as the prefix.

---

## 9.9 Prohibited Temporal Column Names

The following column names are prohibited:

date

time

timestamp

created

updated

deleted

start_date

end_date

event_date

record_date

These names violate the canonical entity-prefixed naming convention and
are insufficiently descriptive.

---

## 9.10 Compliance Checklist

Every temporal column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ Generic temporal names prohibited

---

# 10. Numeric Columns

## 10.1 Purpose

This section defines the canonical naming rules for columns representing
numeric business values within the Phoenix Platform.

Numeric columns store measurable business information and SHALL clearly
describe the business value they represent.

---

## 10.2 General Principles

Every numeric column SHALL:

- Represent a measurable business value.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic numeric column names are prohibited.

---

## 10.3 Canonical Naming Pattern

Numeric columns SHALL follow the format:

<entity_name>_<numeric_attribute>

Examples:

instrument_quantity

instrument_weight

issuer_employee_count

market_trade_count

exchange_member_count

board_display_order

---

## 10.4 Count Columns

Columns representing the number of business objects SHALL use the suffix
"_count".

Examples:

exchange_member_count

market_trade_count

issuer_employee_count

instrument_shareholder_count

industry_company_count

---

## 10.5 Quantity Columns

Columns representing measurable quantities SHALL clearly identify the
business quantity.

Examples:

instrument_quantity

instrument_available_quantity

instrument_minimum_quantity

instrument_maximum_quantity

order_remaining_quantity

---

## 10.6 Sequence Columns

Columns representing business sequence values SHALL explicitly identify
their business purpose.

Examples:

board_display_order

market_display_order

industry_sort_order

sector_display_order

Sequence values SHALL NOT be used as business identifiers.

---

## 10.7 Percentage Columns

Columns representing percentage values SHALL explicitly indicate that the
stored value is a percentage.

Examples:

instrument_discount_percentage

issuer_ownership_percentage

market_fee_percentage

exchange_commission_percentage

---

## 10.8 Ratio Columns

Columns representing ratios SHALL explicitly identify the ratio being
stored.

Examples:

instrument_split_ratio

issuer_debt_ratio

market_utilization_ratio

portfolio_allocation_ratio

---

## 10.9 Precision Values

Numeric columns representing measurements SHALL clearly identify the
business measurement.

Examples:

instrument_tick_size

currency_decimal_places

market_price_precision

instrument_volume_precision

---

## 10.10 Numeric Consistency

Equivalent business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

member_count

trade_count

display_order

quantity

percentage

The corresponding entity name SHALL always be included as the prefix.

---

## 10.11 Prohibited Numeric Column Names

The following column names are prohibited:

count

number

quantity

value

amount

total

order

sequence

percentage

ratio

These names violate the canonical entity-prefixed naming convention and
are insufficiently descriptive.

---

## 10.12 Compliance Checklist

Every numeric column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ Generic numeric names prohibited

---

# 11. Financial Columns

## 11.1 Purpose

This section defines the canonical naming rules for columns representing
financial and monetary business values within the Phoenix Platform.

Financial columns SHALL represent monetary values, prices, fees, taxes,
valuations, and other financial measurements.

---

## 11.2 General Principles

Every financial column SHALL:

- Represent a financial business concept.
- Be self-descriptive.
- Include the entity name.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic financial column names are prohibited.

---

## 11.3 Canonical Naming Pattern

Financial columns SHALL follow the format:

<entity_name>_<financial_attribute>

Examples:

instrument_close_price

instrument_open_price

instrument_high_price

instrument_low_price

issuer_nominal_value

exchange_trading_fee

---

## 11.4 Price Columns

Columns representing market prices SHALL explicitly identify the business
price.

Examples:

instrument_open_price

instrument_close_price

instrument_high_price

instrument_low_price

instrument_last_price

instrument_reference_price

instrument_average_price

---

## 11.5 Value Columns

Columns representing monetary values SHALL clearly identify the business
value.

Examples:

issuer_nominal_value

instrument_market_value

portfolio_total_value

security_book_value

asset_fair_value

---

## 11.6 Amount Columns

Columns representing monetary amounts SHALL explicitly identify the
business amount.

Examples:

trade_amount

order_remaining_amount

transaction_total_amount

payment_amount

settlement_amount

---

## 11.7 Fee Columns

Columns representing fees or commissions SHALL clearly identify the fee
being represented.

Examples:

exchange_trading_fee

broker_commission_fee

transaction_processing_fee

market_service_fee

listing_fee

---

## 11.8 Tax Columns

Columns representing taxes SHALL explicitly identify the applicable tax.

Examples:

transaction_tax_amount

trade_tax_amount

dividend_tax_amount

capital_gain_tax_amount

---

## 11.9 Currency Columns

Columns identifying the monetary currency SHALL follow the canonical
naming convention.

Examples:

trade_currency_id

settlement_currency_id

issuer_reporting_currency_id

portfolio_base_currency_id

Currency columns SHALL reference the corresponding Currency Reference
Table.

---

## 11.10 Financial Consistency

Equivalent financial concepts SHALL use identical naming patterns
throughout the repository.

Examples:

open_price

close_price

market_value

nominal_value

trading_fee

tax_amount

The corresponding entity name SHALL always be included as the prefix.

---

## 11.11 Prohibited Financial Column Names

The following column names are prohibited:

price

value

amount

fee

commission

tax

cost

currency

balance

These names violate the canonical entity-prefixed naming convention and
are insufficiently descriptive.

---

## 11.12 Compliance Checklist

Every financial column SHALL satisfy the following:

✓ Entity-prefixed

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Uses the approved naming pattern

✓ Generic financial names prohibited

✓ Currency references use Reference Tables

---

# 12. Boolean Columns

## 12.1 Purpose

This section defines the canonical naming rules for Boolean columns within
the Phoenix Platform.

Boolean columns SHALL represent business attributes that have only two
possible states.

Boolean columns SHALL NOT be used to represent business concepts with
multiple possible values.

---

## 12.2 General Principles

Every Boolean column SHALL:

- Represent a binary business state.
- Be self-descriptive.
- Include the entity name.
- Clearly indicate the represented condition.
- Follow the canonical naming convention.
- Be consistently named throughout the repository.

Generic Boolean column names are prohibited.

---

## 12.3 Canonical Naming Pattern

Boolean columns SHALL follow the format:

<entity_name>_is_<state>

Examples:

exchange_is_active

market_is_open

board_is_visible

instrument_is_listed

issuer_is_verified

industry_is_enabled

---

## 12.4 State Naming

The Boolean state SHALL describe the business meaning rather than the
technical implementation.

Correct examples:

instrument_is_tradeable

market_is_active

issuer_is_public

board_is_default

Incorrect examples:

instrument_flag

market_status

issuer_value

board_option

---

## 12.5 Negative States

Negative expressions SHOULD be avoided whenever a positive business
expression can be used.

Preferred:

instrument_is_active

issuer_is_verified

market_is_open

Avoid:

instrument_is_not_active

issuer_is_not_verified

market_is_closed

When a negative business concept is the official business terminology, it
MAY be used with explicit architectural approval.

---

## 12.6 Boolean Business Rules

Boolean columns SHALL only represent business concepts having exactly two
mutually exclusive states.

Business concepts having more than two possible values SHALL use Reference
Tables instead.

Correct:

exchange_is_active

instrument_is_listed

Incorrect:

instrument_status

market_status

listing_status

These SHALL be modeled using Reference Tables.

---

## 12.7 Boolean Consistency

Equivalent Boolean business concepts SHALL use identical naming patterns
throughout the repository.

Examples:

exchange_is_active

market_is_active

board_is_active

issuer_is_active

instrument_is_active

Repository-wide consistency SHALL be maintained.

---

## 12.8 Prohibited Boolean Column Names

The following column names are prohibited:

is_active

is_enabled

is_default

is_visible

flag

active_flag

enabled_flag

status_flag

deleted_flag

These names violate the canonical entity-prefixed naming convention.

---

## 12.9 Compliance Checklist

Every Boolean column SHALL satisfy the following:

✓ Entity-prefixed

✓ Uses the "is" keyword

✓ Self-descriptive

✓ Business-oriented

✓ Repository consistent

✓ Represents exactly two states

✓ No generic Boolean names

---

# 13. Audit Columns

## 13.1 Purpose

This section defines the naming conventions for audit columns used within
the Phoenix Platform.

This section defines **only the naming rules** for audit columns.

The implementation, behavior, lifecycle, default values, triggers, and
governance of audit columns are defined exclusively in the
**AuditColumnDesignStandard**.

---

## 13.2 General Principles

Every audit column SHALL:

- Follow the Enterprise Naming Standard.
- Be consistently named throughout the repository.
- Use the canonical naming convention defined by the Phoenix Platform.
- Have exactly one approved name across all database objects.

Audit column names SHALL remain stable throughout the repository lifecycle.

---

## 13.3 Canonical Audit Column Names

The following audit column names are the only approved audit column names
within the Phoenix Platform.

Creation Audit

created_at

created_by

Modification Audit

updated_at

updated_by

Logical Deletion Audit

deleted_at

deleted_by

Version Audit

row_version

---

## 13.4 Audit Naming Consistency

Audit columns are enterprise infrastructure columns.

Unlike business attributes, audit columns are shared technical metadata.

Therefore, audit columns SHALL NOT include the entity name.

Correct examples:

created_at

updated_at

deleted_at

created_by

updated_by

deleted_by

Incorrect examples:

exchange_created_at

market_updated_at

issuer_deleted_by

instrument_created_by

---

## 13.5 Reserved Audit Column Names

The following names are reserved exclusively for enterprise auditing.

created_at

created_by

updated_at

updated_by

deleted_at

deleted_by

row_version

These names SHALL NOT be used for business attributes.

---

## 13.6 Business Audit Information

Business events SHALL NOT reuse enterprise audit column names.

Business event columns SHALL include the entity name.

Examples:

trade_execution_timestamp

instrument_listing_date

issuer_registration_date

exchange_established_date

Business audit information and technical audit information SHALL remain
strictly separated.

---

## 13.7 Repository Consistency

Every table requiring audit information SHALL use the same audit column
names.

Alternative audit naming conventions are prohibited.

Repository-wide consistency SHALL take precedence over local preferences.

---

## 13.8 Compliance Checklist

Every audit column SHALL satisfy the following:

✓ Uses the approved enterprise audit name

✓ Uses lowercase letters

✓ Uses snake_case

✓ Uses no entity prefix

✓ Repository consistent

✓ Defined by AuditColumnDesignStandard

---

# 14. Prohibited Column Names

## 14.1 Purpose

This section defines column names that SHALL NOT be used within the
Phoenix Platform.

Prohibited names are ambiguous, insufficiently descriptive, inconsistent
with the Enterprise Naming Standard, or violate the canonical naming
convention.

---

## 14.2 General Rule

Every database column SHALL have a unique business meaning that is evident
from its name.

Generic or context-dependent column names are prohibited.

---

## 14.3 Generic Identifier Names

The following identifier names SHALL NOT be used:

id

key

identifier

record_id

entity_id

object_id

reference_id

Reason:

These names do not identify the referenced business entity.

Correct examples:

exchange_id

market_id

instrument_id

issuer_id

---

## 14.4 Generic Name Columns

The following column names SHALL NOT be used:

name

local_name

short_name

full_name

official_name

display_name

Reason:

The associated business entity is not identifiable.

Correct examples:

exchange_name

exchange_local_name

issuer_short_name

instrument_full_name

---

## 14.5 Generic Code Columns

The following column names SHALL NOT be used:

code

business_code

internal_code

external_code

system_code

vendor_code

Reason:

The represented business concept is unclear.

Correct examples:

exchange_code

market_code

instrument_code

issuer_registration_code

instrument_isin

---

## 14.6 Generic Classification Columns

The following column names SHALL NOT be used:

type

category

group

class

classification

level

status

Reason:

These names do not identify the classified business entity.

Correct examples:

instrument_type_id

market_category_id

industry_group_id

risk_level_id

instrument_status_id

---

## 14.7 Generic Description Columns

The following column names SHALL NOT be used:

description

notes

remarks

comments

text

detail

details

memo

Reason:

The business subject of the description is not identified.

Correct examples:

exchange_description

issuer_notes

instrument_remarks

---

## 14.8 Generic Boolean Columns

The following Boolean column names SHALL NOT be used:

is_active

is_enabled

is_deleted

is_visible

flag

active_flag

enabled_flag

Reason:

The associated business entity is not identified.

Correct examples:

exchange_is_active

market_is_open

instrument_is_listed

issuer_is_verified

---

## 14.9 Generic Date and Time Columns

The following temporal column names SHALL NOT be used:

date

time

timestamp

start_date

end_date

event_date

record_date

Reason:

The represented business event is ambiguous.

Correct examples:

instrument_listing_date

exchange_established_date

market_open_time

trade_execution_timestamp

---

## 14.10 Generic Financial Columns

The following financial column names SHALL NOT be used:

price

amount

value

cost

fee

commission

tax

balance

Reason:

The represented financial concept is ambiguous.

Correct examples:

instrument_close_price

trade_amount

issuer_nominal_value

exchange_trading_fee

transaction_tax_amount

---

## 14.11 Reserved Technical Column Names

The following names are reserved exclusively for Enterprise Audit
Infrastructure and SHALL NOT be reused for business attributes:

created_at

created_by

updated_at

updated_by

deleted_at

deleted_by

row_version

These names SHALL only be used according to the
AuditColumnDesignStandard.

---

## 14.12 Reserved Database Keywords

Database reserved keywords SHALL NOT be used as column names.

Examples include:

user

order

group

table

select

where

index

constraint

primary

foreign

When a business concept conflicts with a reserved keyword, an alternative
self-descriptive name SHALL be selected.

---

## 14.13 Compliance Checklist

Every database column SHALL satisfy the following:

✓ Not a generic name

✓ Not ambiguous

✓ Not a reserved keyword

✓ Self-descriptive

✓ Entity-prefixed where applicable

✓ Repository consistent

✓ Compliant with Enterprise Naming Standard

---

# 15. Naming Examples

## 15.1 Purpose

This section provides canonical naming examples demonstrating the
application of the Enterprise Column Naming Standard.

These examples are normative and SHALL be used as implementation
references throughout the Phoenix Platform.

---

## 15.2 Master Entity Example

Entity: Exchange

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Identifier | exchange_id |
| Business Code | exchange_code |
| Business Name | exchange_name |
| Local Name | exchange_local_name |
| Short Name | exchange_short_name |
| Official Name | exchange_official_name |
| Description | exchange_description |
| Status | exchange_status_id |
| Active | exchange_is_active |
| Established Date | exchange_established_date |

---

## 15.3 Reference Table Example

Entity: Market Type

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Identifier | market_type_id |
| Business Code | market_type_code |
| Business Name | market_type_name |
| Local Name | market_type_local_name |
| Description | market_type_description |
| Display Order | market_type_display_order |
| Active | market_type_is_active |

---

## 15.4 Fact Table Example

Entity: Daily Market Data

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Identifier | daily_market_data_id |
| Instrument | instrument_id |
| Trading Date | trading_date |
| Open Price | instrument_open_price |
| High Price | instrument_high_price |
| Low Price | instrument_low_price |
| Close Price | instrument_close_price |
| Trade Count | instrument_trade_count |
| Trade Volume | instrument_trade_volume |
| Trade Value | instrument_trade_value |

---

## 15.5 Event Table Example

Entity: Trading Halt Event

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Identifier | trading_halt_event_id |
| Instrument | instrument_id |
| Event Type | trading_halt_event_type_id |
| Event Timestamp | trading_halt_event_timestamp |
| Event Reason | trading_halt_event_reason |
| Event Status | trading_halt_event_status_id |

---

## 15.6 Bridge Table Example

Entity: Instrument Sector

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Identifier | instrument_sector_id |
| Instrument | instrument_id |
| Sector | sector_id |
| Effective From | instrument_sector_effective_from |
| Effective To | instrument_sector_effective_to |
| Active | instrument_sector_is_active |

---

## 15.7 Foreign Key Example

Foreign Key columns SHALL always use the exact name of the referenced
Primary Key.

| Referenced Entity | Foreign Key Column |
|-------------------|--------------------|
| Exchange | exchange_id |
| Market | market_id |
| Board | board_id |
| Instrument | instrument_id |
| Issuer | issuer_id |
| Currency | currency_id |

---

## 15.8 Classification Example

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Instrument Type | instrument_type_id |
| Market Type | market_type_id |
| Board Type | board_type_id |
| Listing Status | listing_status_id |
| Risk Level | risk_level_id |

---

## 15.9 Boolean Example

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Exchange Active | exchange_is_active |
| Market Open | market_is_open |
| Instrument Listed | instrument_is_listed |
| Issuer Verified | issuer_is_verified |

---

## 15.10 Audit Example

Enterprise Audit columns SHALL use the canonical enterprise names.

| Business Concept | Approved Column Name |
|------------------|----------------------|
| Created Time | created_at |
| Created By | created_by |
| Updated Time | updated_at |
| Updated By | updated_by |
| Deleted Time | deleted_at |
| Deleted By | deleted_by |
| Row Version | row_version |

---

## 15.11 Repository Compliance

Every example presented in this section complies with:

- Enterprise Naming Standard
- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- AuditColumnDesignStandard
- ReferenceTableDesignStandard
- MasterEntityDesignStandard
- FactTableDesignStandard
- EventTableDesignStandard
- BridgeTableDesignStandard

These examples SHALL be considered canonical implementation references
for all future database objects.

---

# 16. Naming Validation Checklist

## 16.1 Purpose

This section defines the mandatory validation checklist for reviewing
database column names before implementation.

Every database column SHALL be validated against this checklist to ensure
full compliance with the Phoenix Platform Enterprise Naming Standards.

---

## 16.2 Mandatory Validation Rules

Every column name SHALL satisfy all of the following requirements.

### Rule 1 — Business Meaning

The column name SHALL clearly describe the represented business concept.

---

### Rule 2 — Self-Descriptive

The column name SHALL be understandable without requiring the table name
for interpretation.

---

### Rule 3 — Entity Prefix

Business columns SHALL include the business entity name.

Examples:

exchange_name

market_code

issuer_status_id

instrument_listing_date

---

### Rule 4 — Canonical Naming Pattern

The column SHALL follow the approved naming pattern for its category.

Examples:

Identifier

<entity>_id

Name

<entity>_name

Local Name

<entity>_local_name

Description

<entity>_description

Status

<entity>_status_id

Boolean

<entity>_is_<state>

---

### Rule 5 — English Language

Column names SHALL use English business terminology only.

---

### Rule 6 — Lowercase

Only lowercase letters SHALL be used.

---

### Rule 7 — Snake Case

Words SHALL be separated using underscores (_).

CamelCase, PascalCase, hyphens, and spaces are prohibited.

---

### Rule 8 — Approved Terminology

Only enterprise-approved business terminology SHALL be used.

Unapproved abbreviations are prohibited.

---

### Rule 9 — Repository Consistency

Equivalent business concepts SHALL use identical names throughout the
repository.

Example:

exchange_name

market_name

board_name

issuer_name

---

### Rule 10 — Reserved Keywords

Reserved database keywords SHALL NOT be used.

---

### Rule 11 — Generic Names

Generic names are prohibited.

Examples:

name

status

type

description

code

value

amount

---

### Rule 12 — Foreign Key Consistency

Every Foreign Key SHALL use exactly the same name as the referenced
Primary Key.

Example:

exchange_id

market_id

board_id

---

### Rule 13 — Reference Data

Business classifications SHALL reference Reference Tables.

Examples:

instrument_type_id

market_status_id

country_id

---

### Rule 14 — Audit Columns

Enterprise audit columns SHALL use the approved enterprise audit names.

Examples:

created_at

updated_at

deleted_at

created_by

updated_by

deleted_by

row_version

---

## 16.3 Validation Procedure

Every new database column SHALL be reviewed before implementation.

The review SHALL verify compliance with every rule defined in this
standard.

Non-compliant column names SHALL be corrected before database
implementation.

---

## 16.4 Architecture Review

Any proposed exception to this standard SHALL:

- Be documented.
- Include technical justification.
- Be reviewed by Enterprise Architecture.
- Be formally approved before implementation.

Unapproved exceptions are prohibited.

---

## 16.5 Repository Compliance

Every database object within the Phoenix Platform SHALL successfully pass
this validation checklist.

Compliance with this checklist is mandatory for:

- Master Entity Tables
- Reference Tables
- Fact Tables
- Event Tables
- Bridge Tables

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative documents governing or related
to the Enterprise Column Naming Standard.

Only the documents listed in this section SHALL be considered normative
references for the implementation of this standard.

---

## 17.2 Normative References

The following documents are normative and SHALL be complied with when
implementing this standard.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Document governance and documentation rules |
| Enterprise Naming Standard | Enterprise-wide naming principles |
| PrimaryKeyDesignStandard | Primary key naming rules |
| ForeignKeyDesignStandard | Foreign key naming rules |
| AuditColumnDesignStandard | Enterprise audit column definitions |
| MasterEntityDesignStandard | Master Entity table design |
| ReferenceTableDesignStandard | Reference table design |
| FactTableDesignStandard | Fact table design |
| EventTableDesignStandard | Event table design |
| BridgeTableDesignStandard | Bridge table design |

---

## 17.3 Related Standards

The following standards complement this document.

| Document | Relationship |
|----------|--------------|
| UniqueConstraintDesignStandard | Constraint naming consistency |
| CheckConstraintDesignStandard | Business rule implementation |
| IndexDesignStandard | Index naming consistency |

---

## 17.4 Governance

If a conflict exists between this document and another standard,
the conflict SHALL be resolved according to the Enterprise Governance
Framework.

Architecture Decisions (ADRs) SHALL take precedence over implementation
guidelines whenever an approved ADR explicitly defines a different rule.

---

## 17.5 Standard Evolution

Future standards affecting database column naming SHALL reference this
document rather than redefining naming rules.

Column naming rules SHALL have a single canonical source within the
repository.

Duplicate naming rules in multiple documents are prohibited.

---

## 17.6 Repository Compliance

Every database standard within the Phoenix Platform SHALL reference this
document whenever database column naming conventions are required.

This document SHALL remain the single authoritative source for all
database column naming rules.

---

# 18. Revision History

## 18.1 Purpose

This section records the revision history of the Column Naming Standard.

Every approved modification to this document SHALL be documented in this
section to ensure full traceability throughout the document lifecycle.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial enterprise column naming standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this standard SHALL be managed under the Enterprise Governance
Framework.

Every modification SHALL include:

- Change justification
- Impact assessment
- Architecture review
- Version update
- Repository approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing database objects SHALL include a repository-wide
impact analysis before approval.

When a naming rule changes, all affected artifacts SHALL be identified and
updated in a controlled manner.

Repository consistency SHALL take precedence over localized changes.

---

## 18.5 Architecture Freeze

Once a naming rule has been approved and implemented within the repository,
it SHALL be considered architecturally frozen.

Changing an approved naming rule SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Migration strategy
- Version increment

Architectural stability SHALL take precedence over stylistic preference.

---

## 18.6 Repository Compliance

All database objects created after the approval of this standard SHALL
comply with the latest approved version.

Existing database objects SHALL be aligned through planned repository
maintenance activities when necessary.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Questions, proposed improvements, or requests for exceptions SHALL be
submitted through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative source for database column naming
within the Phoenix Platform.

No other document may redefine, override, or duplicate the naming rules
defined herein.

All database standards, data models, table definitions, and SQL scripts
SHALL comply with this standard.

---

## End of Document