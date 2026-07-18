# Phoenix Document Metadata Standard

**Document ID:** PHX-STD-DOC-001
**Document Title:** Phoenix Document Metadata Standard
**Version:** 1.0
**Status:** Approved
**Classification:** Internal
**Owner:** Phoenix Architecture Board
**Approver:** Phoenix Architecture Board
**Created:** 2026-07-16
**Last Updated:** 2026-07-16
**Review Cycle:** Annual

---

# 1. Purpose

This standard defines the mandatory metadata header for all canonical documents within the Phoenix repository.

Its objectives are to ensure consistency, traceability, governance, and maintainability across all repository artifacts.

---

# 2. Scope

This standard applies to all canonical repository documents maintained within the Phoenix repository, regardless of their capability ownership (Architecture, Data, Domain, Knowledge, Operations, Platform, Project or Software).

* Architecture
* Data
* Domain
* Knowledge
* Operations
* Platform
* Project

Temporary notes, working drafts, and personal documents are excluded unless explicitly promoted to canonical status.

---

# 3. Mandatory Metadata

Every canonical Repository document shall begin with the following metadata block:

```markdown
**Document ID:** XXXXX
**Document Title:** XXXXX
**Version:** X.X
**Status:** Draft | Review | Approved | Deprecated | Archived
**Classification:** Internal | Public | Confidential
**Owner:** XXXXX
**Approver:** XXXXX
**Created:** YYYY-MM-DD
**Last Updated:** YYYY-MM-DD
**Review Cycle:** XXXXX
```

The order of these fields shall not be changed.

---

# 4. Field Definitions

| Field          | Description                           |
| -------------- | ------------------------------------- |
| Document ID    | Unique identifier of the document.    |
| Document Title | Official document title.              |
| Version        | Current document version.             |
| Status         | Current lifecycle status.             |
| Classification | Information classification level.     |
| Owner          | Responsible document owner.           |
| Approver       | Final approving authority.            |
| Created        | Initial creation date.                |
| Last Updated   | Date of the latest approved revision. |

---

# 5. Rules

The following rules are mandatory:

* Every canonical repository document shall contain all mandatory metadata fields.
* Metadata shall appear immediately after the document title.
* Metadata order shall remain unchanged.
* Metadata names shall always be written in English.
* Dates shall follow the ISO-8601 format (YYYY-MM-DD).

---

# 6. Exceptions

Repository templates, generated artifacts, and archived historical documents may temporarily deviate from this standard until formally updated.

---

# 7. Compliance

Compliance with this standard is mandatory for all future documentation.

Repository audits shall verify compliance with this standard before repository certification. Compliance with this standard is mandatory for all canonical repository documents.

---

# 8. Related Documents

The following documents are directly related to this standard:

- RepositoryStructure.md
- ProjectOverview.md
- RepositoryCertificationReport.md

---

# 9. Change History

| Version | Date       | Description                           |
| ------- | ---------- | ------------------------------------- |
| 1.0     | 2026-07-16 | Initial enterprise metadata standard. |
