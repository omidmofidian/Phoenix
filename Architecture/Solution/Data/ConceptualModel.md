# Conceptual Database Model

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | CDM-001 |
| Document | ConceptualDatabaseModel |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Conceptual Data Architecture |
| Architecture Layer | Conceptual Data Architecture |
| Owner | Enterprise Architecture |
| Repository Path | Architecture/Data/Conceptual/ConceptualDatabaseModel.md |
| Depends On | PlatformArchitectureVision, CanonicalDomainModel, BoundedContextDefinition, CanonicalBusinessRules |
| Consumed By | LogicalDatabaseModel, PhysicalDatabaseModel, CanonicalEnterpriseERD, EntityCatalog, AggregateCatalog |
| Approval Authority | Enterprise Architecture Board |
| Last Updated | 2026-07-19 |

---

# 1. Purpose

The Conceptual Database Model defines the canonical business information model of the Phoenix Platform.

It identifies the enterprise business concepts that are required to support all current and future market engines while remaining completely independent of implementation technologies, database products and software architecture.

The Conceptual Database Model establishes the semantic foundation from which all subsequent data architecture artifacts are derived.

It serves as the authoritative reference for enterprise data analysis, logical modeling and business information governance.

---

# 2. Scope

This document defines the conceptual representation of enterprise information across all approved business domains of the Phoenix Platform.

The scope includes:

- Enterprise business concepts
- Business entities
- Business ownership
- Information ownership
- Business relationships
- Aggregate boundaries
- Domain boundaries
- Enterprise information governance
- Conceptual business rules

The scope explicitly excludes:

- Database schemas
- Tables
- Columns
- Primary Keys
- Foreign Keys
- Data types
- Indexes
- Database constraints
- Physical storage
- ORM mappings
- Service implementations
- APIs
- Infrastructure components

---

# 3. Objectives

The objectives of the Conceptual Database Model are to:

- establish a common enterprise business vocabulary;
- define the conceptual structure of enterprise information;
- identify business ownership of information assets;
- establish enterprise information boundaries;
- provide the foundation for logical database modeling;
- support Domain-Driven Design (DDD);
- ensure long-term architectural consistency;
- enable future expansion without conceptual redesign.

---

# 4. Conceptual Modeling Principles

The Conceptual Database Model is governed by the following architectural principles.

| Principle ID | Principle |
|--------------|-----------|
| CMP-001 | Business concepts shall be modeled independently of implementation technology. |
| CMP-002 | Every business entity shall represent exactly one business concept. |
| CMP-003 | Every business entity shall belong to exactly one Domain. |
| CMP-004 | Every business entity shall belong to exactly one Aggregate. |
| CMP-005 | Every Aggregate shall have exactly one Aggregate Root. |
| CMP-006 | Every business concept shall have one authoritative owner. |
| CMP-007 | Business semantics shall remain stable across technology changes. |
| CMP-008 | The conceptual model shall serve as the single source of truth for enterprise information architecture. |

---

# 5. Enterprise Conceptual Architecture

The Phoenix Platform organizes enterprise information into independent business domains that collaborate through well-defined business relationships while preserving ownership boundaries.

```text
                    Phoenix Platform

        ┌────────────────────────────────────┐
        │        Enterprise Domains          │
        └────────────────────────────────────┘

                Reference Domain
                        │
                        ▼
                  Core Domain
                        │
                        ▼
                 Market Domain
                        │
         ┌──────────────┼──────────────┐
         ▼              ▼              ▼
 Configuration      Audit Domain   Reporting
     Domain                           Domain
         │                              ▲
         └──────────────┬───────────────┘
                        │
                        ▼
              Integration Domain
```

Each Domain owns its business concepts while collaborating through approved enterprise relationships.

No Domain owns information belonging to another Domain.

---

# 6. Enterprise Information Architecture

Enterprise information within the Phoenix Platform is classified into the following conceptual categories.

| Information Category | Description |
|----------------------|-------------|
| Reference Information | Stable enterprise reference data shared across multiple domains and market engines. |
| Master Information | Canonical business entities representing long-lived enterprise objects. |
| Operational Information | Business information generated during daily platform operation. |
| Historical Information | Immutable records preserving historical business activity. |
| Configuration Information | Enterprise configuration governing platform behavior. |
| Audit Information | Immutable records supporting governance, compliance and traceability. |
| Analytical Information | Derived information supporting reporting and decision making. |

These categories provide the conceptual foundation for enterprise information governance and subsequent logical data modeling.

---

# 7. Canonical Business Domains

The Conceptual Database Model is organized into independent business domains that collectively represent the enterprise information architecture of the Phoenix Platform.

| Domain | Primary Responsibility | Information Type |
|---------|------------------------|------------------|
| Reference Domain | Enterprise reference information | Reference Data |
| Core Domain | Enterprise business entities | Master Data |
| Market Domain | Market activity and historical information | Operational Data |
| Integration Domain | External system integration | Integration Data |
| Configuration Domain | Enterprise configuration | Configuration Data |
| Audit Domain | Governance and traceability | Historical Data |
| Reporting Domain | Enterprise reporting and analytics | Analytical Data |

Each Domain owns its business concepts, terminology, lifecycle and information governance.

No Domain may assume ownership of information belonging to another Domain.

---

# 8. Conceptual Business Entities

The following conceptual entities constitute the canonical enterprise information model.

## 8.1 Reference Domain

| Entity | Business Purpose |
|----------|-----------------|
| Exchange | Represents a regulated securities exchange. |
| Trading Board | Represents a trading board operating within an Exchange. |
| Sector | Represents a high-level economic sector classification. |
| Industry | Represents an industry classification within a Sector. |
| Trading Calendar | Defines official trading days and market sessions. |

---

## 8.2 Core Domain

| Entity | Business Purpose |
|----------|-----------------|
| Company | Represents a legal business organization. |
| Instrument | Represents a tradable financial instrument. |

---

## 8.3 Market Domain

| Entity | Business Purpose |
|----------|-----------------|
| Instrument Listing | Represents the listing of an Instrument on a Trading Board. |
| Daily Market Data | Represents historical daily trading information. |
| Corporate Action | Represents business events affecting an Instrument. |

---

## 8.4 Integration Domain

| Entity | Business Purpose |
|----------|-----------------|
| Data Provider | Represents an external provider of business information. |
| External Identifier | Maps enterprise entities to provider-specific identifiers. |

---

## 8.5 Configuration Domain

| Entity | Business Purpose |
|----------|-----------------|
| Configuration Group | Groups related enterprise configuration items. |
| Configuration Item | Represents a configurable enterprise parameter. |

---

## 8.6 Audit Domain

| Entity | Business Purpose |
|----------|-----------------|
| Audit Session | Represents an execution context for auditing. |
| Audit Event | Represents an immutable audit record. |

---

## 8.7 Reporting Domain

| Entity | Business Purpose |
|----------|-----------------|
| Report Definition | Defines a reusable enterprise report. |
| Report Snapshot | Represents an immutable generated report instance. |

---

# 9. Conceptual Business Relationships

Conceptual relationships express business semantics rather than implementation details.

The primary enterprise relationships are summarized below.

| Parent Entity | Child Entity | Business Meaning |
|---------------|--------------|------------------|
| Exchange | Trading Board | An Exchange operates one or more Trading Boards. |
| Sector | Industry | A Sector groups one or more Industries. |
| Industry | Company | A Company belongs to one Industry. |
| Company | Instrument | A Company issues one or more Instruments. |
| Instrument | Instrument Listing | An Instrument may have one or more Listings. |
| Trading Board | Instrument Listing | A Trading Board hosts Instrument Listings. |
| Instrument Listing | Daily Market Data | Market Data belongs to an Instrument Listing. |
| Trading Calendar | Daily Market Data | Market Data is recorded for one Trading Day. |
| Instrument | Corporate Action | Corporate Actions affect Instruments. |
| Data Provider | External Identifier | Providers assign External Identifiers. |
| Enterprise Entity | External Identifier | Enterprise entities may have multiple External Identifiers. |
| Audit Session | Audit Event | Audit Sessions contain Audit Events. |
| Configuration Group | Configuration Item | Configuration Groups organize Configuration Items. |
| Report Definition | Report Snapshot | Report Definitions produce Report Snapshots. |

---

# 10. Aggregate Boundaries

Enterprise information is organized into Aggregates that define business consistency boundaries.

| Aggregate | Aggregate Root | Domain |
|------------|----------------|--------|
| Exchange | Exchange | Reference |
| Trading Board | Trading Board | Reference |
| Sector | Sector | Reference |
| Industry | Industry | Reference |
| Trading Calendar | Trading Calendar | Reference |
| Company | Company | Core |
| Instrument | Instrument | Core |
| Instrument Listing | Instrument Listing | Market |
| Daily Market Data | Daily Market Data | Market |
| Corporate Action | Corporate Action | Market |
| Data Provider | Data Provider | Integration |
| External Identifier | External Identifier | Integration |
| Audit Session | Audit Session | Audit |
| Audit Event | Audit Event | Audit |
| Configuration Group | Configuration Group | Configuration |
| Configuration Item | Configuration Item | Configuration |
| Report Definition | Report Definition | Reporting |
| Report Snapshot | Report Snapshot | Reporting |

Aggregate boundaries define transactional consistency and business ownership.

Cross-Aggregate communication shall occur exclusively through Aggregate Roots.

---

# 11. Business Ownership

Business ownership is assigned at the Domain level.

Each business entity has exactly one authoritative owner responsible for its lifecycle, governance and semantic integrity.

| Domain | Business Owner |
|---------|----------------|
| Reference Domain | Enterprise Reference Service |
| Core Domain | Core Business Service |
| Market Domain | Market Service |
| Integration Domain | Integration Service |
| Configuration Domain | Configuration Service |
| Audit Domain | Audit Service |
| Reporting Domain | Reporting Service |

---

# 12. Information Ownership

## 12.1 Purpose

Information ownership establishes the authoritative responsibility for the governance, lifecycle, quality, and business meaning of conceptual information assets across the Phoenix Platform.

Each information category shall have exactly one owning Domain. Ownership is defined at the business architecture level and remains independent of logical or physical implementation.

No information asset shall have multiple business owners.

---

## 12.2 Information Ownership Matrix

| Information Category | Owning Domain | Ownership Scope |
|----------------------|---------------|-----------------|
| Reference Information | Reference Domain | Enterprise reference data |
| Master Information | Core Domain | Enterprise master entities |
| Operational Information | Market Domain | Market operations and historical market data |
| Integration Information | Integration Domain | External system mappings and provider metadata |
| Configuration Information | Configuration Domain | Enterprise configuration and system parameters |
| Audit Information | Audit Domain | Compliance, governance, and traceability |
| Analytical Information | Reporting Domain | Reporting models and analytical views |

---

## 12.3 Ownership Principles

The following principles govern conceptual information ownership.

- Every information asset shall have exactly one owning Domain.
- Ownership defines business responsibility rather than implementation responsibility.
- Information ownership shall remain stable throughout the enterprise architecture lifecycle.
- Ownership shall not be duplicated across Domains.
- Cross-domain access shall never imply ownership transfer.
- Business semantics shall always be governed by the owning Domain.

---

# 13. Domain Invariants

## 13.1 Enterprise Invariants

The following enterprise-wide invariants apply to every business Domain.

- Business ownership is unique.
- Aggregate ownership is unique.
- Business identity is immutable.
- Canonical business semantics shall remain consistent across the platform.
- Domain boundaries shall not be violated.

---

## 13.2 Reference Domain

- Every Trading Board belongs to exactly one Exchange.
- Every Industry belongs to exactly one Sector.
- Trading Calendars define valid trading sessions.
- Reference information is centrally governed.

---

## 13.3 Core Domain

- Every Company belongs to exactly one Industry.
- Every Instrument belongs to exactly one Company.
- Business identity remains immutable throughout the entity lifecycle.

---

## 13.4 Market Domain

- Every Instrument Listing references exactly one Instrument.
- Every Instrument Listing belongs to exactly one Trading Board.
- Daily Market Data cannot exist without an Instrument Listing.
- Corporate Actions always reference one Instrument.
- Published historical market information is immutable.

---

## 13.5 Integration Domain

- Enterprise entities never store provider-specific identifiers.
- External Identifiers are owned exclusively by the Integration Domain.
- One enterprise entity may be mapped to multiple external providers.
- Provider identifiers never redefine enterprise identity.

---

## 13.6 Configuration Domain

- Every Configuration Item belongs to exactly one Configuration Group.
- Configuration information is centrally governed.

---

## 13.7 Audit Domain

- Audit information is append-only.
- Audit records are immutable.
- Historical audit information shall never be modified.
- Audit entities never own operational business data.

---

## 13.8 Reporting Domain

- Reporting information is read-only.
- Reports consume enterprise information without modifying it.
- Analytical views shall never become the authoritative business source.

---

# 14. Enterprise Conceptual Design Rules

The following architectural rules govern the evolution of the Conceptual Database Model.

| Rule ID | Rule |
|----------|------|
| CDR-001 | Every business entity shall belong to exactly one Domain. |
| CDR-002 | Every business entity shall belong to exactly one Aggregate. |
| CDR-003 | Every Aggregate shall define one Aggregate Root. |
| CDR-004 | Business ownership shall remain unique. |
| CDR-005 | Information ownership shall remain unique. |
| CDR-006 | Conceptual relationships shall represent business semantics only. |
| CDR-007 | Implementation details shall not appear in the conceptual model. |
| CDR-008 | Conceptual changes shall preserve business meaning. |
| CDR-009 | The conceptual model shall remain technology independent. |
| CDR-010 | All derived architectural artifacts shall conform to this conceptual model. |

---

# 15. Transition to Logical Data Architecture

The Conceptual Database Model provides the architectural foundation for all subsequent data architecture artifacts.

The following artifacts are derived directly from this model:

- Canonical Entity Definitions
- Aggregate Catalog
- Enterprise Relationship Catalog
- Enterprise Relationship Matrix
- Cardinality Matrix
- Aggregate Dependency Matrix
- Business Constraint Matrix
- Domain Logical Models
- Canonical Enterprise ERD
- Logical Database Model
- Physical Database Model

Implementation-specific concerns are intentionally deferred to later architecture phases.

This model serves as the highest-level representation of enterprise information and provides the conceptual baseline from which all logical and physical data architecture artifacts are derived.

---

# 16. Traceability

Every conceptual business concept shall be traceable to its corresponding architectural artifacts.

Platform Architecture Vision

↓

Architectural Principles

↓

Bounded Context Definition

↓

Canonical Domain Model

↓

Conceptual Database Model

↓

Logical Database Model

↓

Physical Database Model

| Source Artifact | Traceability Purpose |
|-----------------|----------------------|
| Platform Architecture Vision | Enterprise architectural vision |
| Architectural Principles | Architectural governance |
| Bounded Context Definition | Domain ownership |
| Canonical Domain Model | Business domains |
| Canonical Business Rules | Business semantics |
| Canonical Entity Definitions | Enterprise entities |
| Aggregate Catalog | Aggregate ownership |
| Canonical Enterprise ERD | Enterprise relationships |
| Logical Database Model | Logical realization |
| Physical Database Model | Physical realization |

---

# 17. Related Artifacts

This document shall be used together with the following Enterprise Architecture specifications:

- PlatformArchitectureVision
- ArchitecturalPrinciples
- BoundedContextDefinition
- CanonicalDomainModel
- CanonicalEntityDefinitions
- AggregateCatalog
- EnterpriseRelationshipCatalog
- EnterpriseRelationshipMatrix
- CardinalityMatrix
- AggregateDependencyMatrix
- BusinessConstraintMatrix
- CanonicalEnterpriseERD
- LogicalDatabaseModel
- PhysicalDatabaseModel
- EnterpriseDataDictionary

---

# 18. Architectural Governance

The Conceptual Database Model is a controlled Enterprise Architecture artifact.

Any modification affecting:

- Business concepts
- Domain boundaries
- Aggregate boundaries
- Information ownership
- Business relationships
- Enterprise semantics
- Information ownership

shall require:

- Enterprise Architecture Review
- Business Impact Analysis
- Architecture Board Approval
- Repository Baseline Update

---

# 19. Approval

The Enterprise Architecture Board approves this Conceptual Database Model as the official conceptual information architecture baseline for the Phoenix Platform.

**Approval Status**

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-12 | Initial Conceptual Database Model. |
| 1.1 | 2026-06-29 | Architecture Freeze baseline introducing the Integration Layer and External Identifier strategy. |
| 2026.2 | 2026-07-19 | Repository-wide architectural rewrite aligned with the Phoenix Enterprise Architecture baseline and repository standards. |
