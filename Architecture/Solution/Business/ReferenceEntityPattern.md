# Reference Entity Pattern

| Item | Value |
|------|------|
| Pattern ID | PAT-REF-001 |
| Version | 1.0 |
| Status | Approved |
| Category | Architectural Pattern |
| Owner | Phoenix Architecture Team |

---

# 1. Purpose

This pattern defines the canonical structure for all reference entities within the Phoenix Platform.

Reference entities represent relatively static business classifications that are shared across multiple domains.

The purpose of this pattern is to ensure consistency, maintainability, and predictable implementation across all reference tables.

---

# 2. Scope

This pattern applies to all reference entities, including but not limited to:

- Exchange
- Market
- Board
- Industry
- Sector
- TradingCalendar
- HolidayCalendar (where applicable)

---

# 3. Characteristics

Reference entities generally have the following characteristics:

- Low rate of change
- Small data volume
- Shared across multiple services
- Frequently referenced by foreign keys
- Managed centrally
- Rarely deleted

---

# 4. Canonical Structure

Every reference entity shall follow this logical structure.

Primary Identifier

    <entity>_id

Public Identifier

    public_id

Business Attributes

    code
    name
    short_name
    english_name
    description

Optional Business Attributes

    display_order
    external_code
    effective_from
    effective_to

Status

    is_active

Audit

    created_at
    created_by
    updated_at
    updated_by
    version

---

# 5. Naming

Table names

Singular

PascalCase

Examples

Exchange

Market

Industry

Sector

Board

---

# 6. Business Rules

Reference entities:

- shall have immutable primary keys
- shall have immutable public identifiers
- shall use business codes
- shall be uniquely identifiable
- shall support comments
- shall support audit columns

---

# 7. Lifecycle

Typical lifecycle

Create

Update

Deactivate

Deletion should be avoided unless explicitly approved.

---

# 8. Relationships

Reference entities are typically referenced by transactional tables.

Reference entities should not depend on transactional entities.

---

# 9. Examples

Reference

Exchange

Market

Board

Industry

Sector

Non-reference

DailyMarketData

Trade

Order

Portfolio

Signal

ImportBatch

ImportLog

---

# 10. Related Standards

- EnterpriseTableConvention
- TableDevelopmentStandard
- ConstraintDevelopmentStandard
- DatabaseDDLDevelopmentStandard