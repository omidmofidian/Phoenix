# Enterprise Table Convention

| Item | Value |
|------|------|
| Document ID | STD-TBL-000 |
| Version | 1.0 |
| Status | Approved |
| Category | Database Standard |
| Parent Standard | DatabaseDDLDevelopmentStandard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This document defines the enterprise-wide conventions that apply to every database table within the Phoenix Platform.

The objective is to establish a single, consistent contract for table structure, naming, identifiers, auditability, and schema organization.

All database tables shall comply with this convention.

---

# 2. Scope

This convention applies to every table created in the Phoenix database.

No table is exempt unless explicitly approved through an Architecture Decision Record (ADR).

---

# 3. Table Naming Convention

Table names shall comply with the following rules.

- Singular
- PascalCase
- English language
- Business-oriented names
- No abbreviations unless approved

Examples

```
Exchange
Market
Board
Industry
Company
Symbol
DailyMarketData
TradingCalendar
```

---

# 4. Primary Key Convention

Every table shall contain exactly one surrogate primary key.

Primary key column name

```
<table_name>_id
```

Examples

```
exchange_id
market_id
company_id
symbol_id
daily_market_data_id
```

Primary keys shall:

- Use BIGINT
- Use GENERATED ALWAYS AS IDENTITY
- Never contain business meaning
- Never be updated

---

# 5. Public Identifier Convention

Every table shall contain a public identifier.

Column

```
public_id UUID NOT NULL
```

Purpose

- Public APIs
- Synchronization
- External references
- Data exchange
- Distributed systems

The value shall remain immutable.

---

# 6. Business Columns

Business attributes shall appear immediately after the public identifier.

Business columns shall:

- Use enterprise data types
- Follow business terminology
- Avoid implementation-specific naming

---

# 7. Foreign Key Convention

Foreign key column names shall follow

```
<parent_table>_id
```

Examples

```
market_id
exchange_id
industry_id
company_id
```

Referenced column names shall always match the parent primary key.

---

# 8. Status Columns

Business status columns shall appear after business attributes.

Typical examples

```
is_active
status
effective_from
effective_to
```

Only columns required by the business shall be included.

---

# 9. Audit Columns

Every table shall include the enterprise audit model.

Mandatory columns

```
created_at
created_by

updated_at
updated_by

version
```

Definitions shall follow the Audit Model Standard.

---

# 10. Column Ordering

Every table shall follow the same column order.

1. Primary Identifier
2. Public Identifier
3. Business Attributes
4. Foreign Keys
5. Status Columns
6. Audit Columns

Deviation is not permitted.

---

# 11. Nullability Convention

Columns shall be declared NOT NULL unless NULL is required by business rules.

Nullable columns shall be explicitly justified.

---

# 12. Default Values

Default values shall only be defined when required by business rules.

Implicit defaults shall be avoided.

---

# 13. Constraint Convention

Constraints shall follow the enterprise naming convention.

Examples

```
PK_<Table>

FK_<Child>_<Parent>

UQ_<Table>_<Column>

CK_<Table>_<Rule>
```

Automatic PostgreSQL constraint names are prohibited.

---

# 14. Comment Convention

Every table shall include:

- Table COMMENT
- Column COMMENT

Comments shall describe business meaning rather than implementation details.

---

# 15. Schema Convention

Every table shall belong to an approved database schema.

Current enterprise schemas include:

```
reference
market
fundamental
integration
analytics
security
configuration
audit
```

The schema shall reflect the business domain of the table.

---

# 16. Versioning Convention

Every table shall support optimistic concurrency through the mandatory `version` column.

The version value shall be managed by the application layer unless otherwise specified.

---

# 17. Compliance

All Phoenix database tables shall comply with this convention.

Exceptions require an approved ADR.

---

# 18. Related Standards

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- IndexDevelopmentStandard
- AuditModelStandard
- IdentifierStrategy
- EnterpriseDataTypeStandard

---

# 19. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |