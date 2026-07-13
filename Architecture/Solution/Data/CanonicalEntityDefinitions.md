# Canonical Entity Definitions

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ARC-ENT-001 |
| Document | CanonicalEntityDefinitions |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Architecture |
| Owner | Enterprise Architecture |
| Depends On | CanonicalDomainModel, AggregateCatalog, EntityDictionary, CanonicalBusinessRules |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document provides the canonical architectural catalog of all enterprise entities within the Phoenix Platform.

It establishes the authoritative classification of business entities across all enterprise domains.

This document defines entity ownership, business responsibility and architectural classification.

Detailed business definitions remain in the Entity Dictionary.

---

# 2. Principles

The following principles govern all enterprise entities.

- Every Entity belongs to exactly one Domain.
- Every Entity belongs to exactly one Aggregate.
- Every Aggregate has exactly one Aggregate Root.
- Every Entity has one authoritative business owner.
- Business identity is independent of implementation technology.
- Entity definitions are technology independent.

---

# 3. Domain Overview

| Domain | Purpose |
|---------|---------|
| Reference | Enterprise reference data |
| Core | Core business entities |
| Market | Historical market information |
| Integration | External provider integration |
| Audit | Enterprise audit and traceability |
| Configuration | Enterprise business configuration |
| Reporting | Reporting and analytical presentation |

---

# 4. Canonical Entity Catalog

## 4.1 Reference Domain

### Exchange

**Purpose**

Represents a regulated securities exchange.

**Aggregate**

Exchange

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

### Trading Board

**Purpose**

Represents a trading board operated by an Exchange.

**Aggregate**

Trading Board

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

### Sector

**Purpose**

Represents a business sector.

**Aggregate**

Sector

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

### Industry

**Purpose**

Represents an industry classification.

**Aggregate**

Industry

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

### Trading Calendar

**Purpose**

Defines official trading days and market sessions.

**Aggregate**

Trading Calendar

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

# 4.2 Core Domain

### Company

**Purpose**

Represents a legal business entity.

**Aggregate**

Company

**Aggregate Root**

Yes

**Entity Type**

Master Entity

---

### Instrument

**Purpose**

Represents a tradable financial instrument.

**Aggregate**

Instrument

**Aggregate Root**

Yes

**Entity Type**

Master Entity

---

# 4.3 Market Domain

### Instrument Listing

**Purpose**

Represents the listing of an Instrument on a Trading Board.

**Aggregate**

Instrument Listing

**Aggregate Root**

Yes

**Entity Type**

Transactional Entity

---

### Daily Market Data

**Purpose**

Represents official daily trading information.

**Aggregate**

Daily Market Data

**Aggregate Root**

Yes

**Entity Type**

Historical Entity

---

### Corporate Action

**Purpose**

Represents official corporate events affecting an Instrument.

**Aggregate**

Corporate Action

**Aggregate Root**

Yes

**Entity Type**

Historical Event

---

# 4.4 Integration Domain

### Data Provider

**Purpose**

Represents an external source of enterprise information.

**Aggregate**

Data Provider

**Aggregate Root**

Yes

**Entity Type**

Reference Entity

---

### External Identifier

**Purpose**

Maps enterprise entities to provider-specific identifiers.

**Aggregate**

External Identifier

**Aggregate Root**

Yes

**Entity Type**

Integration Entity

---

# 4.5 Audit Domain

### Audit Session

**Purpose**

Represents a logical execution context.

**Aggregate**

Audit Session

**Aggregate Root**

Yes

**Entity Type**

Audit Entity

---

### Audit Event

**Purpose**

Represents an immutable enterprise audit record.

**Aggregate**

Audit Event

**Aggregate Root**

Yes

**Entity Type**

Audit Entity

---

# 4.6 Configuration Domain

### Configuration Group

**Purpose**

Represents a logical collection of enterprise configuration items.

**Aggregate**

Configuration Group

**Aggregate Root**

Yes

**Entity Type**

Configuration Entity

---

### Configuration Item

**Purpose**

Represents a configurable enterprise parameter.

**Aggregate**

Configuration Item

**Aggregate Root**

Yes

**Entity Type**

Configuration Entity

---

# 4.7 Reporting Domain

### Report Definition

**Purpose**

Represents a reusable enterprise report specification.

**Aggregate**

Report Definition

**Aggregate Root**

Yes

**Entity Type**

Reporting Entity

---

### Report Snapshot

**Purpose**

Represents an immutable generated report instance.

**Aggregate**

Report Snapshot

**Aggregate Root**

Yes

**Entity Type**

Reporting Entity

---

# 5. Entity Classification Summary

| Entity Type | Entities |
|-------------|----------|
| Reference Entity | Exchange, Trading Board, Sector, Industry, Trading Calendar, Data Provider |
| Master Entity | Company, Instrument |
| Transactional Entity | Instrument Listing |
| Historical Entity | Daily Market Data |
| Historical Event | Corporate Action |
| Integration Entity | External Identifier |
| Audit Entity | Audit Session, Audit Event |
| Configuration Entity | Configuration Group, Configuration Item |
| Reporting Entity | Report Definition, Report Snapshot |

---

# 6. Architectural Constraints

The following constraints apply to every enterprise entity.

- Every Entity belongs to exactly one Domain.
- Every Entity belongs to exactly one Aggregate.
- Aggregate Roots own their Aggregate.
- Cross-domain access occurs only through Aggregate Roots.
- Business identifiers remain immutable.
- Enterprise identifiers remain authoritative.

---

# 7. Traceability

| Artifact | Purpose |
|----------|---------|
| CanonicalDomainModel | Domain ownership |
| AggregateCatalog | Aggregate ownership |
| EntityDictionary | Detailed entity definitions |
| EnterpriseRelationshipCatalog | Entity relationships |
| EnterpriseRelationshipMatrix | Cardinality |
| CanonicalBusinessRules | Business constraints |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial enterprise canonical entity catalog |