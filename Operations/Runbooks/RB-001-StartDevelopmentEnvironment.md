# Runbook RB-001

# Start Development Environment

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | RB-001 |
| Title | Start Development Environment |
| Version | 1.0 |
| Status | Approved |
| Author | Phoenix Project |
| Date | 2026-06-28 |

---

# Purpose

This runbook describes the standard procedure for starting the Phoenix Development Environment.

Following this document guarantees that every development session starts from a known and consistent state.

---

# Scope

This procedure applies to:

- Windows 11 Development Machine
- WSL2
- Docker Desktop
- PostgreSQL
- Future Development Containers

---

# Preconditions

Before starting development, ensure that:

- Windows has finished booting.
- Docker Desktop is installed.
- WSL2 is installed.
- The Phoenix project directory exists.
- Docker Desktop is running.

---

# Project Directory

Example:

```text
D:\Phoenix
```

Move to the project root.

```bash
cd D:\Phoenix
```

---

# Step 1 — Verify Docker

Check Docker installation.

```bash
docker --version
```

Expected:

```text
Docker version xx.xx.x
```

---

Check Docker Compose.

```bash
docker compose version
```

Expected:

```text
Docker Compose version xx.xx.x
```

---

# Step 2 — Verify Docker Engine

```bash
docker ps
```

Expected:

Docker Engine is running.

No connection error should appear.

---

# Step 3 — Verify Environment File

Ensure the following file exists.

```text
.env
```

Verify required variables:

- PROJECT_NAME
- POSTGRES_VERSION
- POSTGRES_DB
- POSTGRES_USER
- POSTGRES_PASSWORD
- POSTGRES_PORT
- POSTGRES_CONTAINER
- POSTGRES_VOLUME
- PHOENIX_NETWORK
- TZ

---

# Step 4 — Start Infrastructure

Run:

```bash
docker compose up -d
```

Expected:

- PostgreSQL container starts.
- Network is available.
- Named volume is mounted.

---

# Step 5 — Verify Running Containers

```bash
docker ps
```

Expected container:

```text
phoenix-postgres
```

Status:

```text
Up
```

---

# Step 6 — Verify PostgreSQL

View logs.

```bash
docker logs phoenix-postgres
```

Expected message:

```text
database system is ready to accept connections
```

---

# Step 7 — Connect to PostgreSQL

```bash
docker exec -it phoenix-postgres bash
```

Inside container:

```bash
psql -U phoenix -d phoenix
```

Verify installation.

```sql
SELECT version();
```

Expected:

PostgreSQL version information.

---

# Step 8 — Verify Docker Resources

Volumes

```bash
docker volume ls
```

Expected:

```text
phoenix-postgres-data
```

Network

```bash
docker network ls
```

Expected:

```text
phoenix-network
```

---

# Step 9 — Shutdown Environment

To stop containers:

```bash
docker compose stop
```

To start again:

```bash
docker compose start
```

To remove containers while preserving database:

```bash
docker compose down
```

Database volume remains intact.

---

# Step 10 — Full Cleanup (Development Only)

WARNING

This operation permanently deletes all database contents.

```bash
docker compose down -v
```

Use only when a clean database is required.

---

# Troubleshooting

## Docker is not running

Start Docker Desktop.

---

## PostgreSQL container exited

Check:

```bash
docker logs phoenix-postgres
```

---

## Port 5432 already in use

Identify the process.

Windows:

```bash
netstat -ano | findstr 5432
```

Change POSTGRES_PORT in `.env` if necessary.

---

## Docker Compose cannot read .env

Verify:

- File name is exactly `.env`
- File is located beside `docker-compose.yml`

---

# Validation Checklist

- Docker Desktop is running
- Docker Engine is available
- PostgreSQL container is running
- Database accepts connections
- Volume exists
- Network exists
- Project directory is correct

---

# References

- ADR-009 — Docker Development Environment
- ADR-010 — Containerized Infrastructure
- ADR-011 — Development Environment Standardization
- ADR-012 — Modular Project Structure

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial version |