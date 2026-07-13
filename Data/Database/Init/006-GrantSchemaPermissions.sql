/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 006-GrantSchemaPermissions.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Grants schema-level permissions.

 Standard     : SDS-2026.1

 Dependencies
   Bootstrap/
      001-CreateDatabase.sql

   Init/
      001-CreatePermissionRoles.sql
      002-CreateLoginRoles.sql
      003-GrantRoleMembership.sql
      004-CreateExtensions.sql
      005-CreateSchemas.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Safe for repeated execution.
 - Grants schema-level privileges only.
 - Does not grant object privileges.
 - Compatible with Docker without modification.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

-------------------------------------------------------------------------------
-- Administrative Permissions
-------------------------------------------------------------------------------

GRANT USAGE, CREATE
ON SCHEMA
    ref,
    core,
    market,
    integration,
    audit,
    config,
    report
TO phoenix_admin;

-------------------------------------------------------------------------------
-- Runtime Permissions
-------------------------------------------------------------------------------

GRANT USAGE
ON SCHEMA
    ref,
    core,
    market,
    integration,
    audit,
    config,
    report
TO phoenix_rw;

-------------------------------------------------------------------------------
-- Read Only Permissions
-------------------------------------------------------------------------------

GRANT USAGE
ON SCHEMA
    ref,
    core,
    market,
    integration,
    audit,
    config,
    report
TO phoenix_ro;

/*
==============================================================================
 End of File
==============================================================================
*/