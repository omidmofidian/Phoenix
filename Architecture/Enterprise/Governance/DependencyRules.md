# Dependency Rules

---

## Purpose

Defines allowed dependencies between architectural layers.

---

# Allowed Dependencies

Presentation

↓

Application

↓

Analysis

↓

Selection

↓

Reference

↓

Core Business

↓

Infrastructure

---

# Forbidden Dependencies

Infrastructure → Presentation

Core Business → Analysis

Reference → Application

Analysis → Infrastructure

Research → Core modification

---

# General Rules

Dependencies are one-directional.

Circular dependencies are prohibited.

Business entities never depend on analytical entities.

Infrastructure never contains business rules.

---

End