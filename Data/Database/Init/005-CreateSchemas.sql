/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 005-CreateSchemas.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Creates the logical schemas of the Phoenix database.

 Standard     : SDS-2026.1

 Dependencies
   Bootstrap/
      001-CreateDatabase.sql

   Init/
      001-CreatePermissionRoles.sql
      002-CreateLoginRoles.sql
      003-GrantRoleMembership.sql
      004-CreateExtensions.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Safe for repeated execution.
 - Creates only application schemas.
 - All schemas are owned by phoenix_owner.
 - Compatible with Docker without modification.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

BEGIN;

-------------------------------------------------------------------------------
-- Reference Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS ref
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA ref IS
'Reference and master data.';

-------------------------------------------------------------------------------
-- Core Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS core
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA core IS
'Core business entities.';

-------------------------------------------------------------------------------
-- Market Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS market
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA market IS
'Market data and trading information.';

-------------------------------------------------------------------------------
-- Integration Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS integration
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA integration IS
'External providers and integration infrastructure.';

-------------------------------------------------------------------------------
-- Audit Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS audit
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA audit IS
'Audit and historical information.';

-------------------------------------------------------------------------------
-- Configuration Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS config
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA config IS
'Application configuration.';

-------------------------------------------------------------------------------
-- Reporting Schema
-------------------------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS report
    AUTHORIZATION phoenix_owner;

COMMENT ON SCHEMA report IS
'Reporting views and reporting objects.';

COMMIT;

/*
==============================================================================
 End of File
==============================================================================
*/