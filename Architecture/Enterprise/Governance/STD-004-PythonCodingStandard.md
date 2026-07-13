# Standard STD-004

# Python Coding Standard

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | STD-004 |
| Title | Python Coding Standard |
| Version | 1.0 |
| Status | Approved |
| Author | Phoenix Project |
| Date | 2026-06-28 |

---

# Purpose

This standard defines the coding rules, architectural principles, and quality requirements for all Python source code developed within the Phoenix Project.

The objectives are:

- Consistency
- Readability
- Maintainability
- Testability
- Scalability

---

# Scope

Applies to every Python module, package, script, library, service, and engine.

---

# Python Version

Official version

```
Python 3.13
```

Older versions are not supported.

---

# Coding Style

Python code shall comply with

- PEP 8
- PEP 257
- PEP 484

---

# Formatting

Formatting tool

```
Black
```

Maximum line length

```
88
```

---

# Linting

Linting tool

```
Ruff
```

All warnings shall be resolved before merge.

---

# Type Hinting

Type hints are mandatory.

Example

```python
def load_prices(symbol: str) -> list[DailyPrice]:
    ...
```

---

# Docstrings

Every public module, class and function shall include a docstring.

Style

Google Style Docstrings.

---

# Imports

Import order

1. Standard Library

2. Third-party Packages

3. Project Modules

Example

```python
import datetime

import pandas as pd

from phoenix.market import importer
```

---

# Logging

Never use

```python
print()
```

Always use

```python
logging
```

---

# Configuration

Configuration values shall never be hard coded.

Allowed sources

- .env
- config/
- Environment Variables

---

# Error Handling

Catch only expected exceptions.

Never use

```python
except:
```

Use

```python
except ValueError:
```

or

```python
except Exception as ex:
```

only at application boundaries.

---

# Architecture

Each module shall have one responsibility.

Business logic shall never appear in UI or infrastructure layers.

---

# Dependency Injection

Services shall receive dependencies through constructors.

Avoid global state.

---

# Testing

Testing framework

```
pytest
```

Unit tests are mandatory for business logic.

---

# File Naming

Use

```
snake_case.py
```

Examples

```
market_data_service.py

indicator_engine.py
```

---

# Class Naming

Use

```
PascalCase
```

Example

```
MarketDataImporter
```

---

# Function Naming

Use

```
snake_case
```

Example

```
calculate_rsi()
```

---

# Constants

Use

```
UPPER_SNAKE_CASE
```

Example

```
DEFAULT_TIMEOUT
```

---

# Comments

Explain

WHY

not

WHAT

---

# References

- STD-001
- STD-002
- STD-003
- ADR-012

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Release |