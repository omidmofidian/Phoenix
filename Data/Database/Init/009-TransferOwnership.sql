/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 009-TransferOwnership.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Transfers ownership of the Phoenix database.

 Standard     : SDS-2026.1

 Dependencies

   Bootstrap/
      001-CreateDatabase.sql
      002-ConfigureDatabase.sql

   Init/
      001-CreatePermissionRoles.sql
      002-CreateLoginRoles.sql
      003-GrantRoleMembership.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Execute after all initialization scripts.
 - Safe for repeated execution.
 - Schema ownership is configured during schema creation.
 - This script transfers DATABASE ownership only.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

ALTER DATABASE phoenix
OWNER TO phoenix_owner;

/*
==============================================================================
 End of File
==============================================================================
*/