# Table Development Standard

| Item | Value |
|------|------|
| Document ID | STD-TBL-001 |
| Version | 1.0 |
| Status | Draft |
| Category | Database Standard |
| Parent Standard | SQLScriptDevelopmentStandard |
| Related Standard | DatabaseDDLDevelopmentStandard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This standard defines the rules, conventions, structure, and quality requirements for creating database tables within the Phoenix Platform.

The objective is to ensure that every table is implemented consistently, remains maintainable, and complies with the enterprise architecture.

---

# 2. Scope

This standard applies to every table created in the Phoenix database.

This standard does not apply to:

- Views
- Materialized Views
- Functions
- Procedures
- Triggers
- Sequences

---

# 3. General Principles

Every table shall comply with the following principles.

- Single Responsibility
- Business-Oriented Design
- Stable Structure
- Explicit Naming
- Consistent Data Types
- Auditability
- Extensibility
- Maintainability

---

# 4. One Table per Script

Each DDL script shall create exactly one table.

Correct

```
010-CreateExchange.sql
```

Incorrect

```
010-CreateReferenceTables.sql
```

---

# 5. Table Naming

Tables shall follow these rules.

- Singular
- PascalCase
- Business Name
- No abbreviations
- English only

Examples

```
Exchange
Market
Company
TradingCalendar
HolidayCalendar
DailyMarketData
```

---

# 6. Standard Column Order

Every table shall use the following column order.

## 6.1 Primary Identifier

Enterprise Identifier

---

## 6.2 Public Identifier

External/Public Identifier when applicable.

---

## 6.3 Business Attributes

Business columns.

---

## 6.4 Foreign Keys

References to parent entities.

---

## 6.5 Status Columns

Business lifecycle status.

Example

```
is_active
```

---

## 6.6 Audit Columns

Audit columns shall always appear at the end.

---

# 7. Mandatory Audit Columns

Every table shall contain the enterprise audit columns.

Example

```
created_at

created_by

updated_at

updated_by

version
```

The exact definition shall follow the Audit Model Standard.

---

# 8. Primary Key

Every table shall have exactly one primary key.

Primary key names shall follow:

```
PK_<TableName>
```

Example

```
PK_Company
```

---

# 9. Public Identifier

Public identifiers shall be included whenever required by the business model.

Their implementation shall follow the Identifier Strategy standard.

---

# 10. Foreign Keys

Foreign keys shall

- be explicitly declared
- be explicitly named
- reference the parent table
- enforce referential integrity

Naming convention

```
FK_<ChildTable>_<ParentTable>
```

---

# 11. Constraints

Constraint names shall never rely on PostgreSQL automatic naming.

Every constraint shall have an explicit name.

---

# 12. Indexes

Indexes shall not be created inside table scripts unless explicitly approved by the Index Development Standard.

---

# 13. Default Values

Default values shall be defined only when required by business rules.

Implicit defaults shall be avoided.

---

# 14. Nullability

Columns shall be NOT NULL unless business requirements explicitly allow NULL.

Nullable columns shall be documented.

---

# 15. Comments

Every table shall include

- Table COMMENT
- Column COMMENT

Comments shall describe business meaning rather than implementation details.

---

# 16. Storage

Table-specific storage parameters shall only be defined when justified by performance or operational requirements.

Otherwise PostgreSQL defaults shall be used.

---

# 17. Security

Security shall not be configured inside table creation scripts.

Permissions shall be managed by dedicated security scripts.

---

# 18. Out of Scope

The following objects shall be implemented in dedicated scripts.

- Indexes
- Views
- Triggers
- Functions
- Procedures
- Seed Data

---

# 19. Quality Checklist

Every table shall satisfy the following checklist.

- Standard SQL Header
- Correct File Name
- Correct Table Name
- Standard Data Types
- Primary Key
- Public Identifier (when applicable)
- Foreign Keys
- Audit Columns
- Explicit Constraints
- Comments
- No Security Configuration
- No DML Statements

---

# 20. Related Standards

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- EnterpriseDataTypeStandard
- BaseEntityStandard
- AuditModelStandard
- IdentifierStrategy
- ConstraintDevelopmentStandard
- IndexDevelopmentStandard

---

# 21. Compliance

Every table in the Phoenix Platform shall comply with this standard.

Any exception requires an approved ADR.

---

# 22. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |