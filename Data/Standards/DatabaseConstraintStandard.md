# Document Metadata

| Property | Value |
|----------|-------|
| Document Name | DatabaseConstraintStandard |
| Document Title | Enterprise Database Constraint Standard |
| Document Identifier | STD-DATA-007 |
| Domain | Data Architecture |
| Category | Database Design Standard |
| Status | Draft |
| Version | 2026.1 |
| Owner | Enterprise Architecture Team |
| Repository | Phoenix Platform |
| Language | English |
| Classification | Internal |
| Created | 2026-07-28 |
| Last Updated | 2026-07-28 |
| Next Review | TBD |

---

# 1. Introduction

## 1.1 Purpose

This document defines the Enterprise Standard governing the
architecture, classification, governance, lifecycle, and repository-wide
usage of database constraints throughout the Phoenix Platform.

It establishes a unified architectural framework for database
constraints while delegating implementation details to the respective
constraint-specific standards.

This document SHALL serve as the umbrella standard for all database
constraints.

---

## 1.2 Scope

This standard applies to every database constraint implemented within
the Phoenix Platform, including:

- Primary Keys
- Foreign Keys
- Unique Constraints
- Check Constraints

This document governs the architectural principles applicable to all
constraint types.

Implementation details SHALL be defined in their respective standards.

---

## 1.3 Objectives

The objectives of this standard are to:

- Define a unified constraint architecture.
- Establish repository-wide consistency.
- Define architectural responsibilities.
- Standardize constraint governance.
- Prevent overlapping responsibilities.
- Support architecture-driven database design.
- Improve repository maintainability.

---

## 1.4 Guiding Principles

This standard is based upon the following principles:

- Constraints protect data integrity.
- Every constraint SHALL have exactly one responsibility.
- Declarative integrity SHALL be preferred over procedural logic.
- Repository consistency SHALL take precedence over implementation
  preference.
- Constraint implementation SHALL be architecture-driven.

---

## 1.5 Relationship to Other Standards

This document SHALL be used together with:

- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard
- ColumnNamingStandard
- AuditColumnDesignStandard
- DDLTemplateSpecification
- PostgreSQL Design Decisions

This document SHALL NOT redefine implementation rules already specified
within those standards.

---

## 1.6 Compliance

Compliance with this standard is mandatory.

Every database constraint implemented within the Phoenix Platform SHALL
comply with this document as well as its corresponding specialized
standard.

Any deviation SHALL require formal approval by the Enterprise
Architecture Team.

---

# 2. Constraint Architecture

## 2.1 Purpose

Database constraints constitute the declarative integrity layer of the
Phoenix Platform.

Their purpose is to protect data integrity independently of application
logic.

---

## 2.2 Architectural Role

Constraints SHALL define the integrity rules governing relational data.

They SHALL be considered part of the Logical Database Model and SHALL be
implemented within the Physical Database Model.

Constraints SHALL NOT be regarded as performance optimization objects.

---

## 2.3 Declarative Integrity

The Phoenix Platform adopts a declarative integrity model.

Whenever practical, integrity SHALL be enforced using database
constraints rather than procedural code.

Declarative integrity SHALL take precedence over triggers or application
logic.

---

## 2.4 Business Integrity

Business integrity SHALL be enforced through the appropriate constraint
type.

Each business rule SHALL be protected by the constraint designed for its
architectural responsibility.

---

## 2.5 Constraint Hierarchy

The Phoenix Platform recognizes the following hierarchy of database
constraints:

1. Primary Key
2. Unique Constraint
3. Foreign Key
4. Check Constraint

Each constraint type has a distinct architectural responsibility.

Responsibilities SHALL NOT overlap.

---

## 2.6 Architecture First

Constraint design SHALL follow the Architecture First methodology.

Constraint implementation SHALL be derived from:

- Architecture Decision Records (ADRs)
- Domain Model
- Enterprise Data Dictionary
- Logical Database Model
- Physical Database Model

Implementation SHALL never precede architectural definition.

---

## 2.7 Repository-wide Consistency

Equivalent business requirements SHALL produce equivalent constraint
implementations throughout the repository.

Repository consistency SHALL take precedence over developer preference.

---

## 2.8 Compliance

Every database constraint SHALL:

- Belong to the declarative integrity layer.
- Have one architectural responsibility.
- Be architecture-driven.
- Be repository consistent.
- Comply with this standard.

---

# 3. Constraint Classification

## 3.1 Purpose

This section classifies the database constraints recognized by the
Phoenix Platform.

Each constraint category SHALL have one clearly defined architectural
responsibility.

---

## 3.2 Primary Key

Primary Keys SHALL uniquely identify database rows.

Primary Key implementation SHALL comply with the
**PrimaryKeyDesignStandard**.

---

## 3.3 Foreign Key

Foreign Keys SHALL enforce referential integrity between related tables.

Foreign Key implementation SHALL comply with the
**ForeignKeyDesignStandard**.

---

## 3.4 Unique Constraint

Unique Constraints SHALL enforce business uniqueness.

Unique Constraint implementation SHALL comply with the
**UniqueConstraintDesignStandard**.

---

## 3.5 Check Constraint

Check Constraints SHALL enforce business validation rules.

Check Constraint implementation SHALL comply with the
**CheckConstraintDesignStandard**.

---

## 3.6 Responsibility Matrix

| Constraint Type | Architectural Responsibility |
|-----------------|------------------------------|
| Primary Key | Row Identity |
| Foreign Key | Referential Integrity |
| Unique Constraint | Business Uniqueness |
| Check Constraint | Business Validation |

No constraint type SHALL assume the responsibility of another.

---

## 3.7 Single Responsibility Principle

Every constraint SHALL have exactly one architectural responsibility.

Constraint responsibilities SHALL remain independent, explicit, and
non-overlapping throughout the repository.

---

## 3.8 Compliance

Every database constraint SHALL:

- Be correctly classified.
- Follow its specialized design standard.
- Maintain a single architectural responsibility.
- Preserve repository consistency.

---

# 4. Enterprise Design Principles

## 4.1 Purpose

This section defines the enterprise-wide architectural principles that
govern every database constraint implemented within the Phoenix
Platform.

These principles apply uniformly to all constraint types.

---

## 4.2 Single Responsibility

Every constraint SHALL enforce exactly one architectural responsibility.

Multiple independent responsibilities SHALL NOT be combined within a
single constraint.

---

## 4.3 Explicit Naming

Every constraint SHALL have an explicit, deterministic, and meaningful
name.

Constraint-specific naming SHALL comply with the corresponding design
standard.

Automatically generated names SHALL NOT be retained.

---

## 4.4 Declarative First

Whenever practical, business integrity SHALL be enforced using
declarative database constraints.

Procedural implementations SHALL be considered only where declarative
constraints cannot satisfy the requirement.

---

## 4.5 Architecture Driven

Constraint implementation SHALL originate from approved architectural
artifacts.

Implementation decisions SHALL NOT be based solely upon developer
preference.

---

## 4.6 Repository Consistency

Equivalent business requirements SHALL produce equivalent constraint
implementations across every repository schema.

Consistency SHALL take precedence over local optimization.

---

## 4.7 Separation of Responsibilities

Database constraints SHALL NOT replace one another.

Primary Keys, Foreign Keys, Unique Constraints, and Check Constraints
SHALL each perform only their intended architectural role.

---

## 4.8 Compliance

Every database constraint SHALL:

- Follow Enterprise Architecture.
- Follow the Single Responsibility Principle.
- Use declarative integrity.
- Remain repository consistent.
- Comply with the corresponding specialized standard.

---

# 5. Constraint Naming Governance

## 5.1 Purpose

This section defines the Enterprise Governance model governing the naming
of database constraints throughout the Phoenix Platform.

Naming rules SHALL remain consistent across the entire repository.

This document defines governance only.

Constraint-specific naming conventions SHALL be defined by the
corresponding specialized standards.

---

## 5.2 Naming Principles

Every database constraint SHALL have:

- An explicit name.
- A deterministic name.
- A meaningful name.
- A repository-consistent name.

Automatically generated database names SHALL NOT be retained.

---

## 5.3 Constraint-Specific Standards

Constraint naming SHALL comply with the following standards:

| Constraint Type | Governing Standard |
|-----------------|--------------------|
| Primary Key | PrimaryKeyDesignStandard |
| Foreign Key | ForeignKeyDesignStandard |
| Unique Constraint | UniqueConstraintDesignStandard |
| Check Constraint | CheckConstraintDesignStandard |

This document SHALL NOT redefine naming conventions established within
those standards.

---

## 5.4 Repository Consistency

Equivalent database objects SHALL use equivalent naming patterns.

Repository consistency SHALL take precedence over developer preference.

---

## 5.5 Name Stability

Approved constraint names SHALL remain stable throughout the repository
lifecycle.

Constraint renaming SHALL occur only when required by:

- Architectural change
- Repository refactoring
- Naming standard evolution

---

## 5.6 Traceability

Constraint names SHOULD clearly identify the protected business rule or
database relationship.

Naming SHALL support architecture review and repository auditing.

---

## 5.7 Governance

All naming exceptions SHALL require formal Enterprise Architecture
approval.

Undocumented naming deviations are prohibited.

---

## 5.8 Compliance

Every database constraint SHALL:

- Have an explicit name.
- Follow the appropriate specialized standard.
- Remain repository consistent.
- Support repository traceability.

---

# 6. Constraint Ordering

## 6.1 Purpose

This section defines the canonical ordering of database constraints
within table definitions.

Consistent ordering improves readability, maintainability, repository
consistency, and architecture review.

---

## 6.2 Canonical Ordering

Database constraints SHALL appear in the following order:

1. Primary Key
2. Unique Constraints
3. Foreign Keys
4. Check Constraints

Every table SHALL follow this ordering.

---

## 6.3 Constraint Grouping

Constraints of the same type SHALL be grouped together.

Mixing different constraint types is prohibited.

---

## 6.4 Readability

Constraint definitions SHALL follow the approved DDL formatting rules.

Logical grouping SHALL improve readability.

---

## 6.5 DDL Template Alignment

The canonical ordering defined herein SHALL be reflected within the
DDLTemplateSpecification.

Every DDL script SHALL follow the same ordering.

---

## 6.6 Repository Consistency

Equivalent tables SHALL implement constraints using identical ordering.

Repository consistency SHALL take precedence over developer preference.

---

## 6.7 Deterministic Structure

Constraint ordering SHALL be deterministic.

Ordering SHALL NOT depend upon implementation sequence.

---

## 6.8 Compliance

Every database table SHALL:

- Follow canonical ordering.
- Group equivalent constraint types.
- Follow the DDL template.
- Remain repository consistent.

---

# 7. Constraint Interaction

## 7.1 Purpose

This section defines the architectural relationships between different
constraint types.

Each constraint SHALL cooperate with, but SHALL NOT replace, another
constraint type.

---

## 7.2 Architectural Independence

Each constraint type SHALL perform exactly one architectural
responsibility.

Responsibilities SHALL remain independent.

---

## 7.3 Primary Key Interaction

Primary Keys establish row identity.

Primary Keys MAY be referenced by one or more Foreign Keys.

Primary Keys SHALL NOT enforce business validation.

---

## 7.4 Foreign Key Interaction

Foreign Keys depend upon existing candidate keys.

Foreign Keys SHALL enforce referential integrity only.

Foreign Keys SHALL NOT enforce business uniqueness.

---

## 7.5 Unique Constraint Interaction

Unique Constraints SHALL protect business uniqueness.

Unique Constraints SHALL NOT replace Primary Keys.

Unique Constraints MAY provide alternate candidate keys.

---

## 7.6 Check Constraint Interaction

Check Constraints SHALL validate business rules affecting columns within
the same database row.

Check Constraints SHALL NOT replace:

- Primary Keys
- Foreign Keys
- Unique Constraints

---

## 7.7 Responsibility Matrix

| Constraint | May Cooperate With | Shall Not Replace |
|------------|--------------------|-------------------|
| Primary Key | Foreign Key | UNIQUE, CHECK |
| Foreign Key | Primary Key, UNIQUE | CHECK |
| Unique Constraint | Foreign Key | Primary Key |
| Check Constraint | All constraint types | Any other constraint |

---

## 7.8 Compliance

Every database constraint SHALL:

- Cooperate appropriately.
- Preserve architectural independence.
- Maintain a single responsibility.
- Comply with repository architecture.

---

# 8. Constraint Lifecycle

## 8.1 Purpose

This section defines the lifecycle governing every database constraint
within the Phoenix Platform.

Constraints SHALL remain fully traceable throughout their lifecycle.

---

## 8.2 Lifecycle Stages

Every database constraint SHALL progress through the following stages:

1. Business Requirement
2. Architecture Definition
3. Logical Design
4. Physical Design
5. SQL Implementation
6. Validation
7. Deployment
8. Maintenance
9. Retirement

---

## 8.3 Design Phase

Constraint design SHALL originate from documented business
requirements.

Architectural decisions SHALL precede implementation.

---

## 8.4 Implementation Phase

Constraint implementation SHALL comply with:

- DDLTemplateSpecification
- Constraint-specific standards
- Repository governance

---

## 8.5 Validation Phase

Every constraint SHALL be validated during:

- Architecture Review
- Repository Audit
- Database Testing
- Release Validation

---

## 8.6 Maintenance Phase

Existing constraints SHALL be reviewed whenever:

- Business rules change.
- Data models evolve.
- Repository refactoring occurs.

---

## 8.7 Retirement

Constraint removal SHALL require:

- Business justification.
- Architecture review.
- Repository impact assessment.
- Migration strategy.

Constraint retirement SHALL preserve repository integrity.

---

## 8.8 Compliance

Every database constraint SHALL:

- Follow the approved lifecycle.
- Remain fully traceable.
- Preserve architectural integrity.
- Comply with repository governance.

---

# 9. Constraint Governance

## 9.1 Purpose

This section defines the Enterprise Governance Framework governing the
approval, implementation, validation, maintenance, and review of
database constraints throughout the Phoenix Platform.

Constraint governance SHALL ensure repository consistency, architectural
integrity, and long-term maintainability.

---

## 9.2 Governance Principles

Database constraints SHALL be governed according to the following
principles:

- Architecture First
- Declarative Integrity
- Repository Consistency
- Traceability
- Controlled Change
- Formal Approval

Every constraint SHALL remain under Enterprise Architecture governance.

---

## 9.3 Architecture Review

Every newly introduced database constraint SHALL undergo Enterprise
Architecture Review.

The review SHALL verify:

- Architectural responsibility
- Correct constraint classification
- Compliance with the applicable design standard
- Repository consistency
- Traceability to business requirements

No constraint SHALL be approved without successful architectural review.

---

## 9.4 Repository Review

Repository-wide reviews SHALL periodically verify:

- Naming consistency
- Constraint ordering
- Duplicate implementations
- Missing constraints
- Repository-wide architectural consistency

Repository audits SHALL identify deviations from approved standards.

---

## 9.5 Code Review

Database constraints SHALL be reviewed as part of every database code
review.

Reviewers SHALL verify:

- Compliance with DDLTemplateSpecification
- Compliance with specialized standards
- SQL correctness
- Readability
- Maintainability

---

## 9.6 Change Governance

Any modification to an existing database constraint SHALL include:

- Business justification
- Architecture impact assessment
- Repository impact assessment
- Migration strategy
- Version control

Constraint changes SHALL remain fully traceable.

---

## 9.7 Exception Management

Exceptions to this standard SHALL:

- Be documented.
- Include architectural justification.
- Be approved by the Enterprise Architecture Team.
- Be periodically reviewed.

Undocumented exceptions are prohibited.

---

## 9.8 Compliance

Every database constraint SHALL:

- Be governed by Enterprise Architecture.
- Pass architecture review.
- Pass repository review.
- Remain fully traceable.
- Comply with repository governance.

---

# 10. Canonical Repository Patterns

## 10.1 Purpose

This section defines the canonical architectural patterns governing the
use of database constraints within different table categories.

These patterns SHALL provide repository-wide implementation consistency.

---

## 10.2 Reference Tables

Reference tables SHALL normally contain:

- Primary Key
- Unique Constraint(s)
- Check Constraint(s)

Foreign Keys SHALL be introduced only where business relationships
require them.

---

## 10.3 Master Entity Tables

Master entity tables SHALL normally contain:

- Primary Key
- Unique Constraint(s)
- Foreign Key(s)
- Check Constraint(s)

Constraint implementation SHALL reflect documented business rules.

---

## 10.4 Transaction Tables

Transaction tables SHALL normally contain:

- Primary Key
- Foreign Key(s)
- Check Constraint(s)

Unique Constraints SHALL be introduced only where business uniqueness is
required.

---

## 10.5 Bridge Tables

Bridge tables SHALL normally contain:

- Primary Key (or Composite Primary Key)
- Foreign Key(s)

Additional constraints SHALL be introduced only when required by
business rules.

---

## 10.6 Event Tables

Event tables SHALL normally contain:

- Primary Key
- Foreign Key(s)
- Check Constraint(s)

Business validation SHALL remain declarative whenever practical.

---

## 10.7 Fact Tables

Fact tables SHALL normally contain:

- Primary Key (if applicable)
- Foreign Key(s)
- Check Constraint(s)

Constraint design SHALL support analytical workloads while preserving
data integrity.

---

## 10.8 Compliance

Every table category SHALL follow the canonical architectural pattern
defined by this standard and its corresponding table design standard.

---

# 11. Constraint Traceability

## 11.1 Purpose

This section defines the traceability model governing database
constraints throughout the Phoenix Platform.

Every constraint SHALL be traceable from business requirement to SQL
implementation.

---

## 11.2 Traceability Chain

Every database constraint SHOULD follow the following traceability
chain:

Business Requirement

↓

Business Rule

↓

Architecture Decision Record (ADR)

↓

Domain Model

↓

Logical Database Model

↓

Physical Database Model

↓

DDL Script

↓

Database Object

---

## 11.3 Business Rule Traceability

Every database constraint SHALL protect a documented business rule or
data integrity requirement.

Undocumented constraints are prohibited.

---

## 11.4 Repository Traceability

Constraint implementation SHALL remain traceable throughout:

- Repository reviews
- Architecture audits
- Database certification
- Future maintenance activities

---

## 11.5 Documentation

Every constraint SHALL be documented within the appropriate repository
artifacts.

Documentation SHALL remain synchronized with implementation.

---

## 11.6 Version Traceability

Constraint modifications SHALL be version controlled.

Historical revisions SHALL remain available for audit purposes.

---

## 11.7 Repository Integrity

Complete traceability SHALL preserve repository integrity throughout the
entire lifecycle.

---

## 11.8 Compliance

Every database constraint SHALL:

- Be fully traceable.
- Protect a documented requirement.
- Remain synchronized with repository documentation.
- Preserve architectural integrity.

---

# 12. Anti-Patterns

## 12.1 Purpose

This section identifies prohibited architectural practices related to
database constraints.

The anti-patterns defined herein SHALL NOT be used.

---

## 12.2 Missing Primary Key

Every persistent business table SHALL have a Primary Key unless an
approved architectural exception exists.

Tables without row identity are prohibited.

---

## 12.3 Missing Foreign Key

Documented relationships SHALL NOT rely solely upon application logic.

Referential integrity SHALL be enforced using Foreign Keys whenever
practical.

---

## 12.4 Anonymous Constraints

Automatically generated constraint names SHALL NOT be retained.

Every database constraint SHALL have an explicit name.

---

## 12.5 Mixed Responsibilities

A database constraint SHALL NOT perform multiple architectural
responsibilities.

Each constraint SHALL enforce exactly one responsibility.

---

## 12.6 Procedural Integrity

Triggers or application logic SHALL NOT replace declarative database
constraints when declarative integrity is sufficient.

Declarative integrity SHALL be preferred.

---

## 12.7 Duplicate Constraints

Equivalent integrity rules SHALL NOT be implemented multiple times
within the same database object.

Duplicate or redundant constraints are prohibited.

---

## 12.8 Compliance

Every implementation SHALL avoid:

- Missing constraints.
- Anonymous constraints.
- Duplicate constraints.
- Mixed responsibilities.
- Procedural replacement of declarative integrity.

Repository consistency SHALL always take precedence over implementation
preferences.

---

# 13. Migration Rules

## 13.1 Purpose

This section defines the Enterprise Standard governing the migration,
refactoring, evolution, and retirement of database constraints
throughout the Phoenix Platform.

Migration activities SHALL preserve business integrity, repository
consistency, and architectural stability.

---

## 13.2 Integrity Preservation

Database constraint migration SHALL preserve:

- Row identity
- Referential integrity
- Business uniqueness
- Business validation

Migration SHALL NOT alter business semantics unless explicitly approved.

---

## 13.3 Legacy Migration

Legacy databases MAY contain:

- Anonymous constraints
- Inconsistent naming
- Missing Foreign Keys
- Missing Check Constraints
- Duplicate constraints
- Mixed responsibilities

During migration, these implementations SHALL be aligned with the
approved Enterprise standards.

---

## 13.4 Constraint Refactoring

Constraint refactoring MAY include:

- Renaming
- Reorganization
- Decomposition
- Standardization
- Documentation updates

Refactoring SHALL preserve existing business behavior.

---

## 13.5 Migration Validation

Before deployment, every migrated constraint SHALL be validated to
ensure:

- Existing data satisfies the constraint.
- Repository consistency is preserved.
- Architectural integrity is maintained.
- No unintended business impact exists.

Migration SHALL fail if integrity cannot be guaranteed.

---

## 13.6 Repository Alignment

Following migration, every database constraint SHALL comply with:

- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard
- DatabaseConstraintStandard
- DDLTemplateSpecification

---

## 13.7 Controlled Change

Constraint migration SHALL be performed through controlled change
management procedures.

Every migration SHALL include:

- Version control
- Architecture review
- Repository impact assessment
- Rollback strategy

---

## 13.8 Compliance

Every migration SHALL:

- Preserve business integrity.
- Preserve repository consistency.
- Preserve architectural stability.
- Comply with Enterprise governance.

---

# 14. Validation Checklist

## 14.1 Purpose

This checklist SHALL be used during architecture review, repository
audit, implementation approval, and database certification.

---

## 14.2 Classification Validation

Verify that:

- Every constraint is correctly classified.
- Architectural responsibility is correct.
- The applicable specialized standard is referenced.

---

## 14.3 Naming Validation

Verify that:

- Every constraint has an explicit name.
- Constraint naming follows the applicable standard.
- Automatically generated names are not retained.

---

## 14.4 Structural Validation

Verify that:

- Constraint ordering is correct.
- Duplicate constraints do not exist.
- Mixed responsibilities do not exist.
- Repository consistency is preserved.

---

## 14.5 Architecture Validation

Verify that:

- Constraints implement declarative integrity.
- Business rules are protected.
- Constraints do not replace one another.
- Architectural responsibilities remain independent.

---

## 14.6 Documentation Validation

Verify that:

- Business rules are documented.
- Constraints are traceable.
- Repository documentation is synchronized.
- Architecture artifacts remain current.

---

## 14.7 Repository Validation

Verify that:

- Repository standards are followed.
- Constraint-specific standards are followed.
- DDLTemplateSpecification is followed.
- Repository consistency is maintained.

---

## 14.8 Compliance Checklist

Every database constraint SHALL satisfy all of the following:

✓ Correct classification

✓ Explicit naming

✓ Single responsibility

✓ Declarative integrity

✓ Repository consistency

✓ Architecture compliance

✓ Documentation traceability

No database constraint SHALL be approved unless every applicable
validation requirement has been successfully satisfied.

---

# 15. Repository Rules

## 15.1 Repository-wide Consistency

All database constraints SHALL follow identical architectural principles
throughout every Phoenix repository schema.

---

## 15.2 Single Source of Truth

This document SHALL serve as the single authoritative governance
standard for database constraints.

Implementation details SHALL remain within the corresponding specialized
standards.

---

## 15.3 Relationship with Specialized Standards

This document SHALL govern database constraint architecture.

Implementation SHALL comply with:

- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard

This document SHALL NOT duplicate implementation rules.

---

## 15.4 Mandatory Documentation

Every database constraint SHALL be traceable to documented business or
architectural requirements.

Undocumented constraints are prohibited.

---

## 15.5 Repository Governance

Constraint implementation SHALL remain under Enterprise Architecture
governance throughout the repository lifecycle.

---

## 15.6 DDL Template Compliance

Every database constraint SHALL be implemented according to the approved
DDLTemplateSpecification.

---

## 15.7 Repository Certification

Repository certification SHALL verify compliance with:

- DatabaseConstraintStandard
- Constraint-specific standards
- Enterprise governance

---

## 15.8 Compliance

Repository compliance with this standard is mandatory.

---

# 16. Architecture Rules

## 16.1 Enterprise Principle

Database constraints SHALL implement declarative integrity.

Business integrity SHALL reside within the database whenever practical.

---

## 16.2 Architectural Responsibility Principle

Each database constraint SHALL have exactly one architectural
responsibility.

| Constraint | Responsibility |
|------------|----------------|
| Primary Key | Row Identity |
| Foreign Key | Referential Integrity |
| Unique Constraint | Business Uniqueness |
| Check Constraint | Business Validation |

Responsibilities SHALL remain mutually exclusive.

---

## 16.3 Separation of Responsibilities

Database constraints SHALL NOT replace one another.

Specifically:

- Primary Keys SHALL NOT validate business rules.
- Foreign Keys SHALL NOT enforce uniqueness.
- Unique Constraints SHALL NOT establish row identity.
- Check Constraints SHALL NOT enforce referential integrity.

Each responsibility SHALL remain isolated.

---

## 16.4 Architecture Governance

Any deviation from this standard SHALL:

- Include documented justification.
- Include architectural impact assessment.
- Receive Enterprise Architecture approval.
- Be recorded for repository audit.

---

## 16.5 Architecture Freeze

Once approved, the Enterprise Constraint Architecture SHALL be
considered architecturally frozen.

Changes SHALL require:

- Business justification
- Architecture review
- Repository impact assessment
- Migration strategy
- Version update

---

## 16.6 Future Standards

Future database standards SHALL reference this document whenever
database constraints are discussed.

Constraint behavior SHALL NOT be redefined elsewhere.

---

## 16.7 Repository Integrity

Repository-wide consistency SHALL always take precedence over individual
implementation preferences.

Enterprise integrity SHALL remain the governing principle.

---

## 16.8 Compliance

Every database constraint SHALL comply with:

- Enterprise Architecture
- Approved ADRs
- Repository Governance
- This standard

Compliance is mandatory.

---

# 17. References

## 17.1 Purpose

This section identifies the authoritative documents governing the
architecture, implementation, governance, validation, and lifecycle
management of database constraints within the Phoenix Platform.

Only the documents referenced herein SHALL be considered normative.

---

## 17.2 Normative References

The following standards SHALL be complied with when implementing
database constraints.

| Document | Purpose |
|----------|---------|
| Enterprise Documentation Standard (STD-001) | Enterprise documentation governance |
| ColumnNamingStandard | Canonical database column naming |
| PrimaryKeyDesignStandard | Primary Key implementation |
| ForeignKeyDesignStandard | Foreign Key implementation |
| UniqueConstraintDesignStandard | Business uniqueness implementation |
| CheckConstraintDesignStandard | Business validation implementation |
| AuditColumnDesignStandard | Enterprise audit column implementation |
| DDLTemplateSpecification | Canonical SQL script template |
| PostgreSQL Design Decisions | PostgreSQL implementation guidance |

---

## 17.3 Related Standards

The following documents complement this standard.

| Document | Relationship |
|----------|--------------|
| PhysicalDatabaseModel | Physical implementation of constraints |
| LogicalDatabaseModel | Logical definition of data integrity |
| EnterpriseDataDictionary | Business rule definitions |
| TablePhysicalSpecifications | Physical table implementation |
| RepositoryGovernanceStandard | Repository governance |
| Architecture Decision Records (ADRs) | Architectural decisions |

---

## 17.4 Related Architecture Artifacts

Every database constraint SHOULD be traceable to one or more of the
following architecture artifacts:

- Business Requirements
- Business Rule Catalog
- Architecture Decision Records (ADRs)
- Domain Model
- Logical Database Model
- Physical Database Model
- Enterprise Data Dictionary
- DDL Scripts

Constraint implementation SHALL always originate from approved
architectural artifacts.

---

## 17.5 Governance

Where conflicts exist between this document and another implementation
standard, the Enterprise Governance Framework SHALL determine
precedence.

Approved Architecture Decision Records SHALL override implementation
guidance whenever an explicit architectural decision exists.

---

## 17.6 Single Source of Truth

This document SHALL remain the single authoritative governance standard
for database constraints throughout the Phoenix Platform.

Implementation details SHALL remain within the corresponding specialized
constraint standards.

Constraint behavior SHALL NOT be redefined elsewhere.

---

## 17.7 Repository Compliance

Every database constraint implemented within the Phoenix Platform SHALL
comply with this standard.

Compliance SHALL be verified during:

- Architecture Review
- Repository Audit
- Database Review
- Repository Certification
- Database Release Approval

---

## 17.8 Traceability

Every database constraint SHOULD be traceable through the following
chain:

Business Requirement

↓

Business Rule

↓

Architecture Decision Record (ADR)

↓

Domain Model

↓

Logical Database Model

↓

Physical Database Model

↓

DDL Script

↓

Database Constraint

Complete traceability SHALL be maintained throughout the repository
lifecycle.

---

# 18. Revision History

## 18.1 Purpose

This section records the lifecycle and revision history of the
Enterprise Database Constraint Standard.

Every approved modification SHALL be documented to preserve
architectural traceability and repository governance.

---

## 18.2 Version History

| Version | Date | Status | Description | Approved By |
|----------|------|--------|-------------|-------------|
| 2026.1 | 2026-07-28 | Draft | Initial Enterprise Database Constraint Standard | Enterprise Architecture Team |

---

## 18.3 Change Management

Changes to this document SHALL be managed under the Enterprise
Governance Framework.

Every proposed change SHALL include:

- Business justification
- Architecture impact assessment
- Repository impact assessment
- Migration assessment
- Version increment
- Formal approval

Unapproved modifications are prohibited.

---

## 18.4 Backward Compatibility

Changes affecting existing database constraints SHALL include a
repository-wide compatibility assessment.

Migration activities SHALL preserve:

- Business integrity
- Data integrity
- Repository consistency
- Architectural stability

Backward compatibility SHALL be evaluated before implementation.

---

## 18.5 Architecture Freeze

Once approved, the Enterprise Database Constraint Architecture SHALL be
considered architecturally frozen.

Changes SHALL require:

- Business justification
- Enterprise Architecture approval
- Repository impact assessment
- Migration strategy
- Version update

Architectural stability SHALL take precedence over implementation
convenience.

---

## 18.6 Repository Compliance

All database models, SQL scripts, documentation, deployment artifacts,
and future implementations SHALL comply with the latest approved version
of this standard.

Legacy implementations SHALL be aligned through controlled migration
activities where required.

---

## 18.7 Document Ownership

This document is owned and governed by the Enterprise Architecture Team.

Requests for modification, clarification, exception, or extension SHALL
be submitted through the Enterprise Architecture governance process.

---

## 18.8 Final Statement

This document is the single authoritative governance standard for all
database constraints implemented within the Phoenix Platform.

It defines the architectural principles governing constraint
classification, responsibility, interaction, lifecycle, governance, and
repository consistency.

Implementation details SHALL remain exclusively within the following
specialized standards:

- PrimaryKeyDesignStandard
- ForeignKeyDesignStandard
- UniqueConstraintDesignStandard
- CheckConstraintDesignStandard

Every database constraint SHALL remain:

- Architecture-driven
- Declarative
- Explicitly documented
- Repository-consistent
- Fully traceable
- Governed by Enterprise Architecture

Each constraint type SHALL maintain one—and only one—architectural
responsibility throughout the entire repository lifecycle.

Business integrity, referential integrity, business uniqueness, and row
identity SHALL remain independent responsibilities and SHALL never be
implemented by an inappropriate constraint type.

---

## End of Document