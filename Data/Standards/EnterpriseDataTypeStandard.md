# Enterprise Data Type Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-002 |
| Document | EnterpriseDataTypeStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Task | T3-002 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical data type standards for the Phoenix Platform.

Its purpose is to establish a consistent, technology-independent approach to representing business information across the enterprise architecture.

The standard ensures data consistency, interoperability, maintainability, and long-term portability across all platform components.

---

# 2. Scope

This standard applies to:

- Logical Data Model
- Physical Database Design
- SQL Objects
- Services
- APIs
- Integration
- Configuration
- Reporting
- Machine Learning datasets
- Data Exchange
- Future implementations

All newly designed data structures shall comply with this standard.

---

# 3. Principles

The following principles govern data type selection.

- Business meaning takes precedence over storage optimization.
- Data types shall preserve information without unnecessary precision loss.
- Data types shall be technology-independent whenever possible.
- Types shall support future scalability.
- Consistency is preferred over local optimization.
- Explicit typing is mandatory.

---

# 4. Canonical Data Categories

Enterprise data is classified into the following categories.

| Category | Purpose |
|----------|---------|
| Identifier | Business identifiers |
| Reference | Foreign references |
| Numeric | Numbers and calculations |
| Monetary | Financial values |
| Percentage | Ratios and percentages |
| Quantity | Counts and volumes |
| Boolean | True / False values |
| Text | Human-readable text |
| Enumeration | Controlled value sets |
| Date | Calendar dates |
| Time | Time values |
| Timestamp | Business events |
| Duration | Time intervals |
| Binary | Binary content |
| Structured | JSON documents |
| Large Object | External files |

---

# 5. Canonical PostgreSQL Mapping

The following table defines the approved PostgreSQL data types.

| Business Category | PostgreSQL Type |
|------------------|-----------------|
| Identifier | uuid |
| Reference | uuid |
| Integer Number | bigint |
| Decimal Number | numeric |
| Monetary Value | numeric(19,4) |
| Percentage | numeric(7,4) |
| Quantity | numeric(19,6) |
| Boolean | boolean |
| Short Text | varchar |
| Long Text | text |
| Enumeration | varchar |
| Business Date | date |
| Business Time | time |
| Event Timestamp | timestamp with time zone |
| Duration | interval |
| Binary | bytea |
| Structured Data | jsonb |

---

# 6. Identifier Standard

All business entities shall use UUID as the canonical identifier.

Characteristics:

- Globally unique
- Immutable
- Technology independent
- Suitable for distributed systems
- Suitable for microservices

Sequential numeric identifiers shall not be used as primary business identifiers.

---

# 7. Numeric Standards

Numeric values shall be selected according to business meaning.

| Data | Recommended Type |
|------|------------------|
| Counter | bigint |
| Price | numeric(19,4) |
| Amount | numeric(19,4) |
| Volume | numeric(19,6) |
| Percentage | numeric(7,4) |
| Exchange Rate | numeric(19,8) |
| Statistical Value | numeric(20,10) |

Floating-point types (`real`, `double precision`) shall not be used for financial calculations.

---

# 8. Date and Time Standards

Business events shall always include time zone information.

Approved types:

| Purpose | Type |
|---------|------|
| Calendar Date | date |
| Clock Time | time |
| Event Timestamp | timestamp with time zone |
| Duration | interval |

The use of `timestamp without time zone` is prohibited unless explicitly approved.

---

# 9. Text Standards

Text shall be classified according to business requirements.

| Type | Usage |
|------|-------|
| varchar | Short structured values |
| text | Long descriptions |
| jsonb | Structured dynamic content |

Text length limits shall only be defined where business rules require them.

---

# 10. Boolean Standards

Boolean values shall represent only two logical states.

Approved values:

- TRUE
- FALSE

Boolean columns shall not represent multiple business states.

Where more than two states exist, an enumeration or reference entity shall be used.

---

# 11. Enumeration Standards

Enumerations represent controlled business vocabularies.

Examples include:

- Market Status
- Order Status
- Currency Type
- Instrument Category

Enumerations shall be documented in the Enterprise Data Dictionary.

Business-critical enumerations may later be promoted to reference tables.

---

# 12. JSON Standards

The `jsonb` type shall only be used for:

- Flexible metadata
- External provider payloads
- Configuration documents
- Machine learning metadata
- Audit snapshots

Core business data shall not be modeled as JSON.

---

# 13. Binary Standards

Binary storage shall be limited to:

- Cryptographic hashes
- Digital signatures
- Small binary payloads

Large files shall be stored externally with only their metadata maintained within the database.

---

# 14. Nullability

Columns shall be declared `NOT NULL` unless a valid business reason exists.

Nullability shall represent the absence of business information rather than implementation convenience.

---

# 15. Default Values

Default values shall represent meaningful business defaults.

Implementation-specific defaults shall be avoided.

Examples:

- FALSE
- CURRENT_TIMESTAMP

Default values shall never conceal missing business information.

---

# 16. Compliance

Compliance with this standard is mandatory.

All logical models, physical database designs, SQL scripts, and application components shall conform to this document.

Exceptions require formal architectural approval.

---

# 17. Related Documents

- EnterpriseNamingStandard.md
- BaseEntityStandard.md
- AuditModelStandard.md
- IdentifierStrategy.md
- LogicalDatabaseModel.md
- PhysicalDatabaseModel.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Data Type Standard. |