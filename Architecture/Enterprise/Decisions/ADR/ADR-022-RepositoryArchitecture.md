ADR-022 : Repository Architecture

Status
    Accepted

Context

The Phoenix Platform repository had evolved incrementally during the early architecture and foundation phases. As the project expanded, an asset-centric directory structure no longer provided clear ownership, scalability, or architectural consistency.

A long-term repository architecture was therefore required to support enterprise-scale development, domain-driven design, service-oriented architecture, and future platform growth.

Decision

The Phoenix repository adopts a Capability-Centric structure.

The repository is organized around stable enterprise capabilities rather than artifact types.

The primary root capabilities are:

- Architecture
- Data
- Knowledge
- Operations
- Platform
- Project
- Resources
- Software
- Workspace
- Archive

All repository artifacts shall belong to exactly one capability.

Infrastructure artifacts remain under Platform.

Business capabilities remain under Software.

Enterprise architectural assets remain under Architecture.

Consequences

Positive

- Clear ownership of repository artifacts.
- Better scalability.
- Stable long-term repository structure.
- Simplified maintenance.
- Better alignment with DDD and SOA.

Negative

- Initial migration effort was required.
- Existing documentation required relocation.

Decision Date

2026-07-08