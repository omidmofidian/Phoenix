================================================================================
Phoenix Platform
Database Object Registry
================================================================================

Document ID : DB-META-001

Version     : 2026.1

Status      : Canonical

Owner       : Phoenix Architecture Team

================================================================================
1. PURPOSE
================================================================================

The Database Object Registry is the authoritative registry of every database
object within the Phoenix Platform.

This document provides a permanent identity for every database object and serves
as the Configuration Management Database (CMDB) for the database layer.

Every database object SHALL be registered before implementation.

Every registered object SHALL have one permanent Object ID.

Object IDs SHALL never be reused.

Object IDs SHALL remain unchanged even if the object name changes.

================================================================================
2. SCOPE
================================================================================

The registry includes every database object including:

Extensions

Schemas

Domains

Types

Sequences

Tables

Constraints

Indexes

Views

Materialized Views

Functions

Triggers

Procedures

Reference Data Scripts

Seed Data Scripts

Validation Scripts

Migration Scripts

================================================================================
3. OBJECT IDENTIFIER FORMAT
================================================================================

Extension             EXT-0001

Schema                SCH-0001

Domain                DOM-0001

Type                  TYP-0001

Sequence              SEQ-0001

Table                 TAB-0001

Constraint            CON-0001

Index                 IDX-0001

View                  VIEW-0001

Materialized View     MVIEW-0001

Function              FUN-0001

Trigger               TRG-0001

Procedure             PROC-0001

Reference Data        REFDATA-0001

Seed Data             SEED-0001

Validation Script     VAL-0001

Migration             MIG-0001

================================================================================
4. REGISTRY COLUMNS
================================================================================

Object ID

Object Type

Schema

Object Name

Repository Path

Implementation Phase

Status

Owner

Architecture Source

Created Version

Last Updated

Depends On

Referenced By

Notes

================================================================================
5. OBJECT STATUS
================================================================================

PLANNED

IN_PROGRESS

IMPLEMENTED

REVIEWED

APPROVED

DEPRECATED

REPLACED

REMOVED

================================================================================
6. REGISTRATION RULES
================================================================================

Rule 1

Every database object SHALL have exactly one Object ID.

Rule 2

Object IDs SHALL never change.

Rule 3

Object IDs SHALL never be reused.

Rule 4

Every object SHALL be registered before implementation.

Rule 5

Every repository object SHALL appear in this registry.

Rule 6

Every Architecture Decision Record (ADR) SHALL reference Object IDs whenever
applicable.

Rule 7

Repository Audit SHALL validate this registry.

================================================================================
7. OBJECT REGISTRY
================================================================================

Columns

Object ID

Object Type

Schema

Object Name

Repository Path

Implementation Phase

Status

Depends On

Referenced By

Architecture Source

Notes

--------------------------------------------------------------------------------
Example Entries
--------------------------------------------------------------------------------

EXT-0001

Extension

-

pgcrypto

Data/Database/Bootstrap/Extensions.sql

Phase 0

APPROVED

-

All UUID-enabled tables

PostgreSQL Standard

Required for gen_random_uuid()

--------------------------------------------------------------------------------

EXT-0002

Extension

-

btree_gist

Data/Database/Bootstrap/Extensions.sql

Phase 0

APPROVED

-

Trading Halt

PostgreSQL Standard

Required for exclusion constraints

--------------------------------------------------------------------------------

SCH-0001

Schema

-

ref

Data/Database/Bootstrap/CreateSchemas.sql

Phase 0

APPROVED

-

All reference tables

Architecture

Canonical reference schema

--------------------------------------------------------------------------------

SCH-0002

Schema

-

market

Data/Database/Bootstrap/CreateSchemas.sql

Phase 0

APPROVED

-

Business tables

Architecture

Canonical business schema

--------------------------------------------------------------------------------

TAB-0001

Table

ref

country

Data/Database/DDL/Tables/Country.sql

Phase 0

APPROVED

-

exchange

Enterprise Data Dictionary

Canonical implementation

================================================================================
8. CHANGE CONTROL
================================================================================

No implementation SHALL exist without a registered Object ID.

Every new object SHALL first be added to this registry.

Repository Audit SHALL validate registry completeness.

This registry is the authoritative Configuration Management Database (CMDB)
for the Phoenix Platform database.

================================================================================
END OF DOCUMENT
================================================================================