# Enterprise ERD Layout

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | ERD-005A |
| Document | EnterpriseERDLayout |
| Version | 2026.1 |
| Status | Approved |
| Classification | Enterprise Data Architecture |
| Owner | Enterprise Architecture |
| Phase | Stage 9 — Canonical Enterprise ERD |
| Depends On | ERD-005 CanonicalEnterpriseERD |
| Last Updated | 2026-07-09 |

---

# 1. Purpose

This document defines the visual layout strategy for the Canonical Enterprise ERD.

Its objective is to establish a stable, readable and maintainable diagram layout that reflects the logical architecture of the Phoenix Platform.

The layout specification shall be used as the blueprint for creating the Draw.io and SVG representations of the Canonical Enterprise ERD.

---

# 2. Design Objectives

The Enterprise ERD layout shall:

- maximize readability;
- minimize relationship crossings;
- preserve domain boundaries;
- preserve aggregate boundaries;
- highlight Aggregate Roots;
- present a consistent top-to-bottom information flow;
- remain scalable as the model evolves.

---

# 3. Layout Principles

## LP-001 Domain-Oriented Layout

Domains are the primary visual containers.

No Aggregate shall exist outside a Domain.

---

## LP-002 Aggregate-Oriented Layout

Aggregates are visual containers inside Domains.

Each Aggregate shall contain all of its owned entities.

---

## LP-003 Aggregate Root Visibility

The Aggregate Root shall appear at the top of its Aggregate container.

---

## LP-004 Entity Grouping

Entities belonging to the same Aggregate shall remain visually grouped.

---

## LP-005 Relationship Clarity

Relationships shall avoid unnecessary crossings.

---

## LP-006 Hierarchical Reading Direction

The preferred reading direction is from top to bottom.

---

## LP-007 Business First

The layout reflects business architecture rather than database implementation.

---

## LP-008 Technology Neutral

The layout shall not expose physical database concepts.

---

# 4. Domain Placement

The recommended domain arrangement is:

```text
                    Reference Domain

        Core      Market      Integration

      Configuration     Reporting

                Audit
```

---

# 5. Aggregate Placement

Within each Domain:

- Aggregates shall be arranged horizontally where possible.
- Closely related Aggregates should be positioned near one another.
- Independent Aggregates should be separated to reduce visual complexity.

---

# 6. Entity Placement

Within each Aggregate:

1. Aggregate Root
2. Primary Child Entities
3. Supporting Entities

Entities shall not be positioned outside their Aggregate boundary.

---

# 7. Relationship Routing

Relationship lines shall:

- follow the shortest practical path;
- avoid unnecessary bends;
- avoid crossing Aggregate boundaries unless required;
- minimize line intersections;
- preserve readability.

---

# 8. Cardinality Placement

Cardinality labels shall:

- be placed adjacent to relationship endpoints;
- remain visible without overlapping entities;
- use consistent positioning throughout the diagram.

---

# 9. Visual Hierarchy

The visual hierarchy shall be:

1. Enterprise
2. Domain
3. Aggregate
4. Entity
5. Relationship
6. Cardinality

This hierarchy shall remain consistent across all diagram revisions.

---

# 10. Diagram Layers

The ERD shall be organized into logical layers:

- Enterprise Layer
- Domain Layer
- Aggregate Layer
- Entity Layer
- Relationship Layer
- Cardinality Layer

Future tooling may use these layers independently.

---

# 11. Scalability Guidelines

The layout shall support:

- new Domains;
- new Aggregates;
- new Entities;
- new Relationships;

without requiring a complete redesign of the diagram.

---

# 12. Diagram Outputs

This layout governs the generation of:

- CanonicalEnterpriseERD.drawio
- CanonicalEnterpriseERD.svg

Both outputs shall represent the same logical model.

---

# 13. Architecture Constraints

The layout shall never:

- expose database tables;
- expose indexes;
- expose physical keys;
- expose implementation classes;
- expose repositories;
- expose infrastructure components.

---

# 14. Compliance

The generated diagram shall comply with:

- CanonicalEnterpriseERD
- AggregateCatalog
- CanonicalEntityDefinitions
- EnterpriseRelationshipCatalog
- CardinalityMatrix
- BusinessConstraintMatrix

---

# 15. Approval

This document is approved as the official layout blueprint for the Canonical Enterprise ERD.

Status

**APPROVED**

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 2026.1 | 2026-07-09 | Initial Enterprise ERD Layout specification. |