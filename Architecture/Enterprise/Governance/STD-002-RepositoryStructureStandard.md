# Standard STD-002

# Repository Structure Standard

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | STD-002 |
| Title | Repository Structure Standard |
| Version | 1.0 |
| Status | Approved |
| Author | Phoenix Project |
| Date | 2026-06-28 |

---

# Purpose

This standard defines the official repository structure for the Phoenix Project.

The repository structure shall remain stable throughout the project lifecycle to ensure maintainability, modularity, traceability, and scalability.

---

# Scope

This standard applies to every file and directory within the Phoenix repository.

---

# Repository Root

```
Phoenix/
```

Only project-level artifacts are allowed in the repository root.

---

# Official Repository Structure

```text
Phoenix/
│
├── config/
├── data/
├── database/
├── docker/
├── docs/
├── logs/
├── scripts/
├── src/
├── tests/
├── backups/
│
├── .env
├── .env.example
├── docker-compose.yml
├── requirements.txt
├── README.md
└── LICENSE
```

---

# Directory Responsibilities

## config/

Application configuration files.

Examples

- YAML
- JSON
- TOML

No source code.

---

## data/

Working datasets.

Suggested structure

```
data/

    raw/

    processed/

    features/

    exports/

    temporary/
```

No production database files.

---

## database/

Database implementation only.

Contains

```
ddl/

dml/

views/

functions/

procedures/

migrations/

seed/

init/

backup/
```

No design documents.

---

## docker/

Docker-specific files.

Examples

```
Dockerfile

docker-entrypoint.sh

postgres/

python/

pgadmin/
```

---

## docs/

Project documentation.

Contains

```
ADR/

Architecture/

Database/

Standards/

Runbooks/

Reports/

UserGuide/
```

No executable files.

---

## logs/

Application logs.

Ignored by Git (if Git is used in the future).

---

## scripts/

Automation scripts.

Examples

```
Backup

Restore

Deployment

Utilities
```

---

## src/

Application source code.

High-level modules may include

```
core/

services/

engines/

api/

shared/

common/
```

Business logic belongs here.

---

## tests/

Automated tests.

Possible structure

```
unit/

integration/

performance/

system/
```

---

## backups/

Database backups.

Application exports.

Snapshots.

---

# Root Files

## README.md

Project overview.

Mandatory.

---

## requirements.txt

Python dependencies.

---

## docker-compose.yml

Development infrastructure.

---

## .env

Environment configuration.

Never commit secrets.

---

## .env.example

Example configuration.

Safe to publish.

---

# Naming Convention

Directories

lowercase

Examples

```
database

docker

services
```

---

Files

Markdown

```
STD-001-Documentation-Standard.md
```

Python

```
market_data_service.py
```

SQL

```
001-create-schema.sql
```

---

# Source Code Organization

The application shall follow a modular architecture.

Each business capability shall be implemented as an independent engine.

Examples

- Market Data Engine
- Indicator Engine
- Feature Engineering Engine
- Strategy Engine
- Backtesting Engine
- Machine Learning Engine
- Portfolio Engine
- Risk Management Engine
- Reporting Engine

Each engine shall expose a well-defined interface.

Direct dependencies between engines shall be minimized.

---

# Future Service-Oriented Architecture

Current implementation:

Modular Monolith

Future implementation:

Service-Oriented Architecture (SOA)

Potential deployment:

Independent Microservices

Repository structure shall support this migration without major refactoring.

---

# Repository Rules

Only one responsibility per directory.

No duplicated files.

No temporary files.

No executable binaries.

No generated outputs inside source folders.

Documentation and implementation must remain separated.

---

# Architecture Compliance

Repository changes affecting directory structure require:

- Architecture review
- Standard update
- ADR (when necessary)

---

# References

STD-001 Documentation Standard

ADR-009 Docker Development Environment

ADR-010 Containerized Infrastructure

ADR-011 Development Environment Standardization

ADR-012 Modular Architecture

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Release |