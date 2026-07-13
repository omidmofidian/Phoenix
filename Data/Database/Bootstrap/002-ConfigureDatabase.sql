/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 002-ConfigureDatabase.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Bootstrap
 Description  : Configures Phoenix database metadata.

 Standard     : SDS-2026.1

 Dependencies
   001-CreateDatabase.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Execute while connected to database "phoenix".
 - Safe for repeated execution.
 - This script does NOT create database objects.
 - Database owner will be transferred later during Init.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

COMMENT ON DATABASE phoenix IS
'Phoenix Trading Platform Database';

/*
==============================================================================
 End of File
==============================================================================
*/