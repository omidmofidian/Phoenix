# ADR-010 : Containerized Development Environment

---

## Status

Accepted

---

## Date

2026-06-27

---

## Context

Phoenix is intended to be developed on multiple computers during its lifecycle.

The development environment must remain portable, reproducible, and independent of the host operating system.

Direct installation of development dependencies such as PostgreSQL and Python may lead to version inconsistencies and difficult migrations.

A containerized development environment addresses these concerns.

---

## Decision

Phoenix shall use Docker as the standard development environment.

Core development services shall execute inside Docker containers.

The project source code shall remain outside containers and be mounted into the runtime environment.

---

## Standard Development Containers

Version 1.0 includes:

- PostgreSQL
- Python Runtime

Future versions may include:

- Redis
- JupyterLab
- pgAdmin
- MinIO
- Airflow

---

## Development Principles

The host operating system shall not contain project-specific runtime dependencies.

Containers shall remain stateless whenever practical.

Persistent data shall be stored in Docker Volumes.

Configuration shall be provided through environment variables.

The complete development environment shall be reproducible using Docker Compose.

---

## Rationale

Containerization ensures identical execution environments across all development machines.

It simplifies migration, improves reproducibility, and minimizes environment-specific issues.

---

## Consequences

### Advantages

- Platform independence
- Consistent environments
- Simplified migration
- Easy onboarding
- Reproducible builds
- Reduced configuration drift

### Disadvantages

- Initial learning curve
- Additional Docker configuration
- Slight resource overhead

---

## Deployment Strategy

Development

Windows 11 + Docker Desktop

Future

Ubuntu Linux

Production

Linux + Docker Engine

No architectural changes shall be required when moving between environments.

---

## Related Decisions

ADR-000 Architecture Principles

ADR-001 Core Independence

ADR-003 Pipeline Architecture

ADR-009 Canonical Data Dictionary

---

## Impact Analysis

Affected Documents

- ReferenceArchitecture.md
- DeploymentArchitecture.md
- SDD

Future Documents

- Docker Compose
- Environment Variables
- Deployment Guide

---

End of ADR-010