/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 008-ConfigureDefaultPrivileges.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Configures default privileges for future database objects.

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
      007-ConfigureSearchPath.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Safe for repeated execution.
 - Applies ONLY to future objects.
 - Existing objects are NOT modified.
 - All database objects shall be created by phoenix_owner.
 - Compatible with Docker without modification.

------------------------------------------------------------------------------
 Revision History

 2026-07-01   Initial Enterprise Version

==============================================================================
*/

-------------------------------------------------------------------------------
-- CORE
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA core
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- REF
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA ref
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- MARKET
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA market
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- INTEGRATION
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA integration
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- AUDIT
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA audit
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- CONFIG
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA config
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

-------------------------------------------------------------------------------
-- REPORT
-------------------------------------------------------------------------------

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT SELECT ON TABLES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT USAGE, SELECT ON SEQUENCES TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT SELECT ON SEQUENCES TO phoenix_ro;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT EXECUTE ON FUNCTIONS TO phoenix_rw;

ALTER DEFAULT PRIVILEGES FOR ROLE phoenix_owner IN SCHEMA report
GRANT EXECUTE ON FUNCTIONS TO phoenix_ro;

/*
==============================================================================
 End of File
==============================================================================
*/