# Enterprise Naming Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | DST-001 |
| Document | EnterpriseNamingStandard |
| Version | 2026.1 |
| Status | Approved |
| Classification | Design Standard |
| Owner | Architecture Team |
| Sprint | Sprint 3 |
| Task | T3-001 |
| Last Updated | 2026-07-07 |

---

# 1. Purpose

This document defines the canonical naming conventions used throughout the Phoenix Platform.

The objective is to establish a single, consistent, technology-independent naming standard applicable to all architectural, database, service, and implementation artifacts.

This standard ensures consistency, readability, maintainability, and long-term scalability across the entire platform.

---

# 2. Scope

This standard applies to:

- Business terminology
- Domain entities
- Bounded contexts
- Services
- Database schemas
- Tables
- Columns
- Keys
- Constraints
- Indexes
- Views
- Functions
- Stored procedures
- Sequences
- Triggers
- APIs
- Events
- Source code
- Documentation

All newly created artifacts shall comply with this standard.

---

# 3. General Principles

The following principles govern all naming decisions.

- Business terminology takes precedence over technical terminology.
- Names shall clearly express business meaning.
- Abbreviations shall be avoided unless universally accepted.
- Names shall remain stable over time.
- Singular nouns shall be preferred unless otherwise specified.
- Every name shall have one unambiguous meaning.
- The same concept shall never be represented by multiple names.

---

# 4. Naming Layers

Phoenix distinguishes between business names and implementation names.

| Layer | Convention | Example |
|--------|------------|----------|
| Business Documentation | Title Case | Market Symbol |
| Domain Model | PascalCase | MarketSymbol |
| Database Objects | snake_case | market_symbol |
| SQL Scripts | snake_case | create_market_symbol.sql |
| Python Modules | snake_case | market_symbol.py |
| Python Classes | PascalCase | MarketSymbol |
| API Resources | kebab-case | /market-symbols |
| Configuration Keys | snake_case | database_timeout |
| Environment Variables | UPPER_SNAKE_CASE | POSTGRES_HOST |

---

# 5. Naming Characteristics

Names shall be:

- Meaningful
- Explicit
- Stable
- Readable
- Technology independent
- Business oriented

Names shall never describe implementation details.

---

# 6. Language

English is the canonical language for all project artifacts.

The use of local languages in identifiers is prohibited.

Documentation may include translated explanations where appropriate.

---

# 7. Reserved Words

Reserved words defined by PostgreSQL, SQL standards, Python, or other adopted technologies shall not be used as identifiers.

Examples include:

- user
- order
- table
- index
- group
- select
- where
- from

Where a business concept conflicts with a reserved word, an alternative business name shall be selected.

---

# 8. Case Sensitivity

Unless explicitly stated otherwise:

- Database identifiers shall use lowercase.
- SQL scripts shall use lowercase filenames.
- Python modules shall use lowercase.
- Environment variables shall use uppercase.
- Business documentation shall use Title Case.
- Domain classes shall use PascalCase.

---

# 9. Separators

The following separators are approved.

| Context | Separator |
|----------|-----------|
| Database | underscore (_) |
| Python | underscore (_) |
| Environment Variables | underscore (_) |
| API | hyphen (-) |
| Documentation Titles | space |

No other separator shall be used.

---

# 10. Prefixes and Suffixes

Prefixes and suffixes shall only be used where they convey meaningful architectural information.

Technical prefixes shall be avoided unless standardized.

Approved examples include:

- pk_
- fk_
- uq_
- chk_
- idx_

Business names shall not include technical prefixes.

---

# 11. Consistency Rules

A business concept shall retain the same canonical name throughout the platform.

Example:

Business

Market Symbol

↓

Domain

MarketSymbol

↓

Database

market_symbol

↓

Python

MarketSymbol

↓

API

market-symbols

Only the naming convention changes; the business concept remains identical.

---

# 12. Exceptions

Exceptions require approval through an Architecture Decision Record (ADR).

Temporary exceptions shall be documented and reviewed before becoming permanent.

---

# 13. Compliance

Compliance with this standard is mandatory.

All architecture reviews, design reviews, and code reviews shall verify adherence to this document.

Non-compliant artifacts shall be corrected before approval.

---

# 14. Related Documents

- ArchitecturalPrinciples.md
- CanonicalDomainModel.md
- CanonicalServiceCatalog.md
- IdentifierStrategy.md
- PostgreSQLDataTypeStandard.md

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-07 | Initial Enterprise Naming Standard. |