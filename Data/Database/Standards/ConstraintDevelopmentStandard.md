# Constraint Development Standard

| Item | Value |
|------|------|
| Document ID | STD-CON-001 |
| Version | 1.0 |
| Status | Draft |
| Category | Database Standard |
| Parent Standard | SQLScriptDevelopmentStandard |
| Related Standard | DatabaseDDLDevelopmentStandard |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This standard defines the design, implementation, naming, and governance rules for database constraints within the Phoenix Platform.

The objective is to ensure data integrity, consistency, and maintainability across all database objects.

---

# 2. Scope

This standard applies to all database constraints, including:

- Primary Key
- Foreign Key
- Unique Constraint
- Check Constraint
- Exclusion Constraint (if used)

This standard does not apply to:

- Indexes
- Triggers
- Views
- Functions
- Procedures

---

# 3. Architectural Principles

Every constraint shall comply with the following principles:

- Explicit Definition
- Explicit Naming
- Business Rule Enforcement
- Data Integrity First
- Deterministic Behavior
- Minimal Redundancy

---

# 4. Constraint Categories

| Constraint | Purpose |
|------------|---------|
| Primary Key | Row identification |
| Foreign Key | Referential integrity |
| Unique | Prevent duplicate values |
| Check | Validate business rules |
| Exclusion | Prevent conflicting data (when required) |

---

# 5. Constraint Naming Convention

Constraint names shall never rely on PostgreSQL automatic naming.

### Primary Key

```
PK_<TableName>
```

Example

```
PK_Company
```

---

### Foreign Key

```
FK_<ChildTable>_<ParentTable>
```

Example

```
FK_Company_Industry
```

---

### Unique Constraint

```
UQ_<TableName>_<ColumnName>
```

Example

```
UQ_Symbol_Code
```

---

### Check Constraint

```
CK_<TableName>_<BusinessRule>
```

Example

```
CK_Company_IsActive
```

Business rule names should be concise, descriptive, and stable.

---

### Exclusion Constraint

```
EX_<TableName>_<BusinessRule>
```

Example

```
EX_TradingSession_TimeRange
```

---

# 6. Primary Key Rules

Every table shall have exactly one primary key.

Primary keys shall:

- Be mandatory
- Be immutable
- Never contain business meaning
- Follow the enterprise identifier strategy

Composite primary keys are prohibited unless approved by an ADR.

---

# 7. Foreign Key Rules

Foreign keys shall:

- Reference a declared parent key
- Enforce referential integrity
- Be explicitly named
- Use matching data types
- Avoid circular dependencies

Delete and update actions (`ON DELETE`, `ON UPDATE`) shall be chosen based on documented business rules and must be explicit.

---

# 8. Unique Constraints

Unique constraints shall be used only for business uniqueness requirements.

Unique constraints shall not duplicate the behavior of the primary key.

---

# 9. Check Constraints

Check constraints shall enforce simple business validation rules.

Examples:

- Numeric ranges
- Allowed status values
- Positive quantities
- Valid percentages

Complex business workflows shall not be implemented using CHECK constraints.

---

# 10. Constraint Placement

Constraints shall be declared within the table definition unless a justified deployment dependency requires them to be created afterward.

If constraints are created separately, the execution dependency shall be documented.

---

# 11. Deferred Constraints

Deferred constraints shall only be used when required by a documented business or technical requirement.

The rationale shall be recorded in the script header or supporting documentation.

---

# 12. Error Messages

Constraint names should clearly identify the violated rule to simplify troubleshooting.

---

# 13. Documentation

Business-critical constraints shall be documented using SQL `COMMENT` statements where appropriate.

Constraint purpose shall also be reflected in the associated data model documentation when relevant.

---

# 14. Performance Considerations

Constraint design shall consider performance impacts.

Foreign keys supporting frequent joins should normally be backed by appropriate indexes in accordance with the Index Development Standard.

---

# 15. Quality Checklist

Every constraint shall satisfy the following checklist.

- Explicit Name
- Correct Naming Convention
- Business Rule Verified
- Correct Data Types
- Referential Integrity Preserved
- No Redundant Constraint
- Performance Considered
- Documentation Updated

---

# 16. Related Standards

- SQLScriptDevelopmentStandard
- DatabaseDDLDevelopmentStandard
- TableDevelopmentStandard
- IndexDevelopmentStandard
- EnterpriseDataTypeStandard
- IdentifierStrategy
- AuditModelStandard

---

# 17. Compliance

All database constraints within the Phoenix Platform shall comply with this standard.

Any exception requires an approved ADR.

---

# 18. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-07-11 | Initial version |