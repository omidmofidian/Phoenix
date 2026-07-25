# Phoenix Platform

# Database Standard Document Template

| Item | Value |
|------|-------|
| Document ID | PHX-DB-TEMPLATE-001 |
| Version | 2026.1 |
| Status | Approved |
| Owner | Phoenix Architecture Team |
| Approver | Phoenix Architecture Team |
| Classification | Canonical |
| Last Updated | 2026-07-25 |

---

# 1. Purpose

This document defines the canonical structure for every database standard published by the Phoenix Platform.

Its objective is to ensure consistency, maintainability, readability, governance, and long-term evolution across all database standards.

Every new database standard shall conform to this template.

---

# 2. Scope

This template applies to every document maintained under:

```text
Data/Database/Standards
```

Including but not limited to:

- Development Standards
- Technical Specifications
- Architectural Strategies
- Operational Procedures

Templates themselves may omit sections that are not applicable.

---

# 3. Standard Metadata

Every database standard shall begin with the following metadata.

| Property | Description |
|----------|-------------|
| Document ID | Unique document identifier |
| Version | Current document version |
| Status | Draft, Review, Approved, Deprecated or Archived |
| Owner | Responsible team |
| Approver | Approving authority |
| Classification | Canonical or Supporting |
| Last Updated | Last modification date |

---

# 4. Required Document Structure

Every database standard shall contain the following sections unless explicitly justified.

```text
1. Purpose

2. Scope

3. Objectives

4. Principles

5. Requirements

6. Recommendations

7. Exceptions

8. Compliance

9. Related Standards

10. Revision History
```

Additional sections may be added where appropriate.

---

# 5. Writing Rules

Every database standard shall follow these writing principles.

## 5.1 Language

English shall be used.

---

## 5.2 Voice

Use active voice whenever possible.

---

## 5.3 Terminology

The following keywords shall follow RFC 2119 semantics.

| Keyword | Meaning |
|----------|---------|
| SHALL | Mandatory requirement |
| MUST | Absolute requirement |
| SHOULD | Recommended practice |
| MAY | Optional behavior |

The keywords SHALL and MUST shall not be used interchangeably.

---

## 5.4 Sentence Style

Requirements shall be written as short, clear and testable statements.

Avoid ambiguous words such as:

- usually
- normally
- generally
- preferably
- approximately

---

# 6. Formatting Rules

## Headings

Use ATX Markdown headings.

Example:

```markdown
# Title

## Section

### Subsection
```

---

## Lists

Use unordered lists unless sequence matters.

---

## Tables

Tables shall be used for:

- metadata
- comparison
- decision matrices
- compliance

---

## Code Blocks

Every SQL example shall use fenced code blocks.

Example:

```sql
CREATE TABLE ...
```

---

# 7. References

Every standard shall reference only directly related standards.

References shall avoid circular dependencies.

---

# 8. Compliance Rules

A document is considered compliant only if it satisfies all mandatory requirements defined by this template.

Exceptions shall be explicitly documented.

---

# 9. Quality Checklist

Before approval every standard shall be verified for:

- Purpose defined
- Scope defined
- Objectives defined
- Principles documented
- Requirements complete
- Recommendations separated
- Exceptions documented
- Compliance section included
- Related Standards updated
- Revision History updated

---

# 10. Revision History

| Version | Date | Description |
|----------|------------|----------------------------|
| 2026.1 | 2026-07-25 | Initial canonical version. |