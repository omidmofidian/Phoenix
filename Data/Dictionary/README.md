# Phoenix Data Dictionary

---

# Purpose

The Phoenix Data Dictionary provides the authoritative definition of every database table, column, relationship, constraint, and business rule.

It serves as the primary reference for:

- Database Design
- Application Development
- Data Integration
- ETL Processes
- API Development
- Reporting
- Future Data Governance

---

# Scope

The Data Dictionary covers all physical database objects defined in the Phoenix database.

Current Version includes:

- market.exchange
- market.trading_board
- market.sector
- market.industry
- market.company
- market.instrument
- market.instrument_listing
- trading.trading_calendar
- trading.daily_market_data
- trading.corporate_action

---

# Relationship with Other Documents

The Data Dictionary is derived from the following design documents.

1. ConceptualModel.md
2. LogicalDatabaseModel.md
3. PhysicalDatabaseModel.md

The Data Dictionary shall never contradict these documents.

---

# Naming Convention

## Tables

- Singular
- snake_case
- lowercase

Examples

```text
exchange

instrument

instrument_listing

daily_market_data
```

---

## Columns

- snake_case
- lowercase

Examples

```text
company_id

instrument_id

public_id

created_at
```

---

## Identifier Strategy

Every table contains two identifiers.

### Internal Identifier

```text
id
```

Purpose

- Primary Key
- Internal joins
- Foreign Keys

Type

```text
BIGINT GENERATED ALWAYS AS IDENTITY
```

---

### Public Identifier

```text
public_id
```

Purpose

- REST APIs
- External Integrations
- Future SOA
- Future Microservices

Type

```text
UUID
```

---

# Standard Audit Columns

Every table includes

```text
created_at

updated_at
```

Type

```text
TIMESTAMPTZ
```

---

# Standard Sections

Every table document follows the same structure.

1. Document Information
2. Purpose
3. Table Information
4. Business Description
5. Columns
6. Keys
7. Constraints
8. Relationships
9. Business Rules
10. Indexes
11. Default Values
12. Sample Record
13. Remarks
14. Related Documents
15. Revision History

---

# File Structure

```text
DataDictionary/

README.md

01-exchange.md

02-trading_board.md

03-sector.md

04-industry.md

05-company.md

06-instrument.md

07-instrument_listing.md

08-trading_calendar.md

09-daily_market_data.md

10-corporate_action.md
```

---

# Related Documents

- ArchitectureFreeze-v1.0.md
- ConceptualModel.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md
- ADR-016

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-29 | Initial Data Dictionary |