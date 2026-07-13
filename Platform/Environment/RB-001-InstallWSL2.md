# Runbook RB-001

# Install WSL2

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | RB-001 |
| Title | Install WSL2 |
| Version | 1.0 |
| Status | Approved |
| Date | 2026-06-28 |

---

# Purpose

This runbook describes the standard procedure for installing and validating Windows Subsystem for Linux version 2 (WSL2) for the Phoenix Development Platform.

WSL2 is a mandatory prerequisite for Docker Desktop and the Phoenix development environment.

---

# Scope

Applies to:

- Windows 11 (64-bit)
- Development Workstation

---

# Prerequisites

- Windows 11
- Administrator privileges
- Internet connection

---

# Installation

Open **Command Prompt** or **PowerShell** as Administrator.

Install WSL:

```bash
wsl --install
```

If WSL components are already installed:

```bash
wsl --status
```

---

# Set Default Version

```bash
wsl --set-default-version 2
```

---

# Reboot

Restart Windows.

---

# Validation

Check installation.

```bash
wsl --version
```

Example:

```text
WSL version: 2.x.x
Kernel version: 6.x.x
```

---

List installed distributions.

```bash
wsl --list --verbose
```

Expected:

```text
VERSION
2
```

---

# Troubleshooting

## WSL command not found

Enable:

- Windows Subsystem for Linux
- Virtual Machine Platform

Restart Windows.

---

## Virtualization disabled

Enable Intel VT-x or AMD-V in BIOS.

---

# Acceptance Criteria

- WSL installed
- Default version is WSL2
- Kernel installed
- Validation commands executed successfully

---

# References

- ADR-009
- ADR-011

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial release |