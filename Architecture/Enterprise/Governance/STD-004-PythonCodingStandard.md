# Enterprise Python Development Standard

| Property | Value |
|----------|-------|
| Project | Phoenix Platform |
| Artifact ID | STD-004 |
| Document | EnterprisePythonDevelopmentStandard |
| Version | 2026.2 |
| Status | Approved |
| Classification | Enterprise Development Standard |
| Owner | Enterprise Architecture Team |
| Governed By | GOV-013 Governance Framework |
| Last Updated | 2026-07-21 |

---

# 1. Executive Summary

The Enterprise Python Development Standard defines the official software development practices for every Python component within the Phoenix Platform.

It establishes a unified approach for software architecture, implementation, maintainability, testing, security, and governance.

This standard transforms Python development from individual coding practices into an enterprise engineering discipline.

Its objectives include:

- architectural consistency;
- software quality;
- maintainability;
- scalability;
- readability;
- traceability;
- testability;
- long-term evolution.

This standard shall be applied to every Python artifact produced within the Phoenix Platform.

---

# 2. Purpose

The purpose of this standard is to define the mandatory engineering practices for Python software development.

The standard ensures that all Python implementations:

- conform to the approved enterprise architecture;
- preserve business integrity;
- follow consistent implementation patterns;
- remain technology-independent where practical;
- support automated validation;
- integrate with enterprise governance.

Coding style alone is insufficient.

Every software artifact shall also satisfy architectural requirements.

---

# 3. Scope

This standard applies to every Python artifact within the Phoenix Platform.

Included artifacts:

- applications;
- services;
- engines;
- libraries;
- packages;
- modules;
- scripts;
- automation tools;
- background workers;
- command-line utilities;
- testing utilities.

Prototype software intended for long-term use shall also comply with this standard.

---

# 4. Python Version Policy

The official development platform is:

```text
Python 3.13
```

Older Python versions are not supported.

All contributors shall develop and test against the approved Python version.

Migration to newer Python versions shall require:

- compatibility analysis;
- dependency validation;
- architecture review;
- regression testing.

---

# 5. Engineering Principles

Python development follows enterprise engineering principles.

---

## 5.1 Architecture First

Implementation shall follow approved architecture.

Software shall never redefine architecture.

---

## 5.2 Business First

Business rules belong to the Domain Layer.

Infrastructure shall not contain business logic.

---

## 5.3 Separation of Concerns

Each software component shall have a single responsibility.

Presentation, business logic, persistence, integration and infrastructure shall remain independent.

---

## 5.4 Simplicity

Simple implementations shall be preferred over complex solutions.

Complexity requires architectural justification.

---

## 5.5 Readability

Code is read more frequently than it is written.

Readable code shall take precedence over clever implementations.

---

## 5.6 Maintainability

Software shall be understandable by future developers.

Maintainability is considered an architectural quality attribute.

---

## 5.7 Testability

Business logic shall be designed for automated testing.

Hidden dependencies reduce testability and shall be avoided.

---

## 5.8 Extensibility

Modules shall support future extension without unnecessary modification.

Closed designs that prevent architectural evolution shall be avoided.

---

# 6. Project Architecture Compliance

Python software shall comply with the approved enterprise architecture.

Implementation shall remain consistent with:

- Domain-Driven Design (DDD);
- Modular Architecture;
- Service-Oriented Architecture roadmap;
- Repository Architecture;
- Enterprise Governance.

Implementation decisions shall never contradict approved ADRs.

---

# 7. Project Organization

Python projects shall follow the approved repository organization.

Typical implementation structure:

```text
Software/

├── Core/

├── Services/

├── Engines/

├── Shared/

├── Infrastructure/

├── Interfaces/

├── Configuration/

├── Tests/
```

Repository organization is governed by STD-002.

---

# 8. Module Design

Each module shall implement one clearly defined responsibility.

A module shall:

- expose a clear public interface;
- hide implementation details;
- minimize dependencies;
- maximize cohesion;
- remain independently testable.

Modules shall not perform unrelated business functions.

---

# 9. Package Organization

Packages shall group related business capabilities.

Recommended examples:

```text
market

reference

portfolio

analytics

configuration

integration

reporting

shared
```

Package organization shall reflect business architecture rather than technical implementation.

---

# 10. Engine Organization

Phoenix is an engine-oriented platform.

Each engine represents an independent business capability.

Examples include:

- Market Data Engine;
- Indicator Engine;
- Analytics Engine;
- Strategy Engine;
- Machine Learning Engine;
- Portfolio Engine;
- Risk Management Engine;
- Reporting Engine.

Each engine shall expose a stable interface while minimizing direct dependencies on other engines.

---

# 11. Service Organization

Services encapsulate reusable business capabilities.

Each service shall:

- represent one business responsibility;
- remain loosely coupled;
- expose stable interfaces;
- avoid infrastructure-specific assumptions.

Services shall not communicate through shared implementation details.

---

# 12. Layer Responsibilities

Software shall follow layered architecture.

```text
Presentation
        │
        ▼
Application Services
        │
        ▼
Domain
        │
        ▼
Infrastructure
```

Each layer shall depend only on the layers beneath it according to the approved architectural rules.

Cross-layer shortcuts are prohibited.

---

# 13. Architectural Dependencies

Allowed dependency direction:

```text
Presentation
        │
        ▼
Application
        │
        ▼
Domain
        │
        ▼
Infrastructure
```

Reverse dependencies shall not exist.

Business rules shall never depend on infrastructure frameworks.

---

# 14. Coding Standards

Python implementations shall comply with:

- PEP 8;
- PEP 257;
- PEP 484;
- approved enterprise standards.

Where conflicts exist, enterprise standards shall take precedence over style preferences.

---

# 15. Formatting Standards

Official formatter:

```text
Black
```

Maximum line length:

```text
88
```

Formatting shall be automated.

Manual formatting inconsistencies shall be eliminated before repository submission.

---

# 16. Naming Standards

All Python source code shall comply with **STD-003 — Enterprise Naming Convention Standard**.

The following conventions are mandatory.

| Artifact | Convention | Example |
|----------|------------|---------|
| Package | lowercase | analytics |
| Module | snake_case | market_data_service.py |
| Class | PascalCase | MarketDataImporter |
| Function | snake_case | import_daily_prices() |
| Method | snake_case | calculate_score() |
| Variable | snake_case | closing_price |
| Constant | UPPER_SNAKE_CASE | DEFAULT_TIMEOUT |
| Exception | PascalCase + Exception | InvalidMarketException |
| Enum | PascalCase | MarketType |

Meaningful business-oriented names shall always be preferred.

---

# 17. Import Standards

Imports shall follow the official Python import order.

Order:

1. Python Standard Library
2. Third-party Libraries
3. Phoenix Platform Modules

Example:

```python
import datetime
from pathlib import Path

import pandas as pd
import sqlalchemy as sa

from phoenix.market.services import MarketDataService
```

Wildcard imports are prohibited.

The following is prohibited:

```python
from module import *
```

Circular imports shall be eliminated through architectural redesign rather than import workarounds.

---

# 18. Type Hinting

Static typing is mandatory for all public interfaces.

Example:

```python
def load_prices(
    symbol: str,
    trade_date: date
) -> list[DailyMarketData]:
    ...
```

Requirements:

- all function parameters shall be typed;
- return values shall be typed;
- public attributes shall be typed;
- generic collections shall use explicit types.

Use of `Any` shall be minimized and justified.

---

# 19. Docstrings

Public modules, classes, methods and functions shall include docstrings.

Approved style:

```text
Google Style Docstrings
```

Each docstring shall describe:

- purpose;
- parameters;
- return value;
- exceptions;
- usage notes (where appropriate).

Example:

```python
def calculate_score(...) -> float:
    """
    Calculates the composite score for an instrument.

    Args:
        ...

    Returns:
        ...
    """
```

---

# 20. Logging Standards

Python applications shall use the standard logging framework.

The use of:

```python
print()
```

is prohibited except in temporary local experiments.

Logging shall support:

- DEBUG
- INFO
- WARNING
- ERROR
- CRITICAL

Business events shall produce meaningful log messages.

Sensitive information shall never be logged.

---

# 21. Error Handling

Only expected exceptions shall be handled.

Preferred:

```python
except ValueError:
```

Avoid:

```python
except:
```

Generic exception handling:

```python
except Exception as ex:
```

shall be limited to application boundaries.

Exceptions shall preserve useful diagnostic information.

---

# 22. Configuration Management

Configuration values shall never be hard coded.

Approved configuration sources:

- Environment Variables
- .env
- Configuration Files
- Secret Management Systems

Examples:

```text
database.yml

application.yml

.env
```

Configuration shall remain external to business logic.

---

# 23. Dependency Injection

Dependencies shall be injected.

Preferred:

```python
class MarketService:

    def __init__(
        self,
        repository: MarketRepository
    ):
        self.repository = repository
```

Avoid:

```python
repository = MarketRepository()
```

inside business logic.

Dependency Injection improves:

- testability;
- maintainability;
- modularity.

---

# 24. Database Access Standards

Database access shall be isolated within the persistence layer.

Business services shall never execute SQL directly.

Preferred architecture:

```text
Application Service
        │
        ▼
Repository
        │
        ▼
Database
```

Repository classes encapsulate persistence concerns.

---

# 25. Service Layer Standards

Application services coordinate business operations.

Responsibilities include:

- transaction orchestration;
- validation;
- workflow coordination;
- interaction between aggregates.

Services shall not become repositories for business logic.

Business rules belong to the Domain Layer.

---

# 26. Domain Layer Standards

The Domain Layer represents the business core.

Responsibilities include:

- entities;
- value objects;
- aggregates;
- domain services;
- business rules.

The Domain Layer shall remain independent of:

- databases;
- REST APIs;
- messaging systems;
- infrastructure frameworks.

---

# 27. Infrastructure Layer Standards

Infrastructure provides technical capabilities.

Examples:

- database connectivity;
- external APIs;
- file storage;
- message brokers;
- authentication providers;
- configuration providers.

Infrastructure shall not contain business decisions.

---

# 28. Engine Development Standards

Each engine shall represent a distinct business capability.

Engines shall:

- expose stable interfaces;
- remain independently deployable in the future;
- minimize coupling;
- maximize cohesion.

Engine communication shall occur through approved service contracts.

---

# 29. Performance Guidelines

Performance optimization shall follow measurement rather than assumptions.

Guidelines:

- avoid unnecessary object creation;
- minimize repeated database queries;
- prefer batch operations;
- use lazy evaluation where appropriate;
- profile before optimizing.

Premature optimization shall be avoided.

---

# 30. Security Guidelines

Python software shall follow secure coding practices.

Requirements:

- validate all external input;
- use parameterized SQL;
- never expose credentials;
- never commit secrets;
- sanitize log output;
- protect confidential information.

Security requirements shall be considered throughout development rather than after implementation.

---

# 31. Testing Standards

Testing is a mandatory activity for every business-critical component.

The official testing framework is:

```text
pytest
```

Testing categories include:

- Unit Tests
- Integration Tests
- System Tests
- Performance Tests
- Regression Tests

Business logic shall not be merged into the repository without appropriate automated tests.

---

## 31.1 Unit Testing

Unit tests shall validate isolated business behavior.

Requirements:

- deterministic execution;
- no external dependencies;
- repeatable results;
- high readability.

Business rules shall always be covered by unit tests.

---

## 31.2 Integration Testing

Integration tests validate interactions between components.

Examples include:

- Database integration;
- Service integration;
- External API integration;
- Messaging integration.

Mock implementations shall not replace integration testing where real interaction is required.

---

## 31.3 Test Organization

Recommended repository structure:

```text
Software/

└── Tests/

    ├── Unit/

    ├── Integration/

    ├── System/

    ├── Performance/

    └── TestData/
```

Test code shall remain separate from production code.

---

# 32. Static Analysis

Static code analysis is mandatory.

Approved tools include:

- Ruff
- mypy
- Black

Validation shall detect:

- syntax issues;
- unused imports;
- unreachable code;
- type inconsistencies;
- formatting violations.

No critical static analysis issues shall remain unresolved before approval.

---

# 33. Code Review

Every production-ready implementation shall undergo peer review.

The review shall verify:

- architectural compliance;
- coding standards;
- maintainability;
- readability;
- security;
- performance;
- test coverage;
- documentation quality.

Code review is an architectural quality gate, not merely a syntax check.

---

# 34. Continuous Integration

Every contribution shall pass the Continuous Integration (CI) pipeline before integration.

Typical CI activities include:

- dependency installation;
- formatting verification;
- static analysis;
- unit testing;
- integration testing;
- artifact validation.

A failed CI pipeline shall block repository integration until all issues are resolved.

---

# 35. Continuous Delivery Readiness

Software components shall be designed to support automated deployment.

Requirements include:

- deterministic builds;
- externalized configuration;
- reproducible environments;
- environment-independent execution.

Deployment-specific logic shall not be embedded within business code.

---

# 36. Performance Validation

Performance shall be validated using measurable criteria.

Validation activities may include:

- execution time measurement;
- memory profiling;
- database query analysis;
- scalability testing;
- concurrency evaluation.

Optimization efforts shall be evidence-based rather than assumption-driven.

---

# 37. Security Compliance

Python implementations shall comply with enterprise security requirements.

Validation shall confirm:

- secure dependency usage;
- absence of hard-coded credentials;
- secure exception handling;
- protected sensitive data;
- secure configuration management.

Security reviews shall be incorporated into the development lifecycle.

---

# 38. Documentation Requirements

Every significant software component shall include appropriate documentation.

Documentation may include:

- module descriptions;
- architecture notes;
- API documentation;
- usage examples;
- configuration guidance;
- operational considerations.

Implementation documentation shall remain synchronized with architectural documentation.

---

# 39. Compliance and Validation

Compliance with this standard shall be verified during:

- Architecture Reviews;
- Sprint Reviews;
- Repository Validation;
- Code Reviews;
- Quality Assurance Reviews;
- Baseline Reviews.

Validation shall ensure:

- architectural compliance;
- coding consistency;
- documentation completeness;
- testing adequacy;
- governance adherence.

Artifacts failing compliance shall not be approved for integration.

---

# 40. Enterprise Traceability

Python development participates in the Enterprise Traceability Framework.

Typical traceability chain:

```text
Platform Vision
        │
        ▼
Architecture Decision Records (ADR)
        │
        ▼
Governance Framework
        │
        ▼
Enterprise Standards
        │
        ▼
Business Architecture
        │
        ▼
Domain Model
        │
        ▼
Application Services
        │
        ▼
Python Implementation
        │
        ▼
Testing
        │
        ▼
Validation Reports
```

Each implementation artifact shall be traceable to its governing architectural decisions.

---

# 41. Related Artifacts

| Artifact | Relationship |
|----------|--------------|
| GOV-013 Governance Framework | Defines governance lifecycle |
| GOV-014 Governance Checklist | Verifies implementation compliance |
| STD-001 Documentation Standard | Documentation requirements |
| STD-002 Repository Structure Standard | Repository organization |
| STD-003 Naming Convention Standard | Naming rules |
| ADR-012 Modular Architecture | Modular implementation principles |
| ADR-022 Repository Architecture | Capability-centric repository structure |
| Repository Validation Report | Enterprise validation process |

---

# 42. Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Python Coding Standard. |
| 2026.2 | 2026-07-21 | Complete enterprise redesign. Expanded the document into the Enterprise Python Development Standard. Added architectural compliance, layered architecture, dependency injection, service and engine standards, testing strategy, security, CI/CD quality gates, governance, compliance validation, enterprise traceability, and integration with the Phoenix Enterprise Architecture framework. |

---

# End of Document