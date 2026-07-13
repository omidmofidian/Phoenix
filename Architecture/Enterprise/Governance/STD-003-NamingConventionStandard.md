# Standard STD-003

# Naming Convention Standard

---

## Document Information

| Item | Value |
|------|-------|
| Document ID | STD-003 |
| Title | Naming Convention Standard |
| Version | 1.0 |
| Status | Approved |
| Date | 2026-06-28 |

---

# Purpose

This standard defines the naming conventions for all artifacts in the Phoenix Project.

Consistency in naming improves readability, discoverability, maintainability, and automation.

---

# General Rules

- Use English only.
- Use meaningful names.
- Avoid abbreviations unless universally accepted (API, SQL, CSV, UUID).
- Avoid names such as temp, test, new, final, copy.

---

# Naming by Artifact

| Artifact | Convention | Example |
|----------|------------|---------|
| Directory | lowercase | services |
| Python file | snake_case | market_data_service.py |
| Class | PascalCase | MarketDataService |
| Function | snake_case | import_daily_prices() |
| Variable | snake_case | closing_price |
| Constant | UPPER_SNAKE_CASE | MAX_RETRY_COUNT |
| Package | lowercase | analytics |
| SQL file | numeric-prefix | 001-create-schema.sql |
| Table | snake_case singular | daily_price |
| Column | snake_case | trade_date |
| Primary Key | id | id |
| Foreign Key | `<table>_id` | exchange_id |
| Index | idx_<table>_<column> | idx_daily_price_symbol |
| View | vw_<name> | vw_latest_prices |
| Function | fn_<name> | fn_import_prices |
| Trigger | trg_<name> | trg_update_timestamp |
| Docker Container | kebab-case | phoenix-postgres |
| Docker Network | kebab-case | phoenix-network |
| Docker Volume | kebab-case | phoenix-postgres-data |

---

# References

- STD-001
- STD-002

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-06-28 | Initial Release |