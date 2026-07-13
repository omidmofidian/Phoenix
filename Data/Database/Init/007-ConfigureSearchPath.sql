/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 007-ConfigureSearchPath.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Configures the default search_path for Phoenix login roles.

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
      006-GrantSchemaPermissions.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Safe for repeated execution.
 - Configures only login roles.
 - Does not create objects.
 - Does not grant permissions.
 - Compatible with Docker without modification.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

-------------------------------------------------------------------------------
-- Runtime Application
-------------------------------------------------------------------------------

ALTER ROLE phoenix_app
SET search_path =
    core,
    market,
    ref,
    public;

-------------------------------------------------------------------------------
-- Testing
-------------------------------------------------------------------------------

ALTER ROLE phoenix_test
SET search_path =
    core,
    market,
    ref,
    public;

-------------------------------------------------------------------------------
-- ETL
-------------------------------------------------------------------------------

ALTER ROLE phoenix_etl
SET search_path =
    core,
    market,
    ref,
    public;

-------------------------------------------------------------------------------
-- Read Only
-------------------------------------------------------------------------------

ALTER ROLE phoenix_readonly
SET search_path =
    report,
    ref,
    public;

-------------------------------------------------------------------------------
-- Deployment
-------------------------------------------------------------------------------

ALTER ROLE phoenix_deployer
SET search_path =
    core,
    market,
    integration,
    audit,
    config,
    report,
    ref,
    public;

/*
==============================================================================
 End of File
==============================================================================
*/