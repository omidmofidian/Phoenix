/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 004-CreateExtensions.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Installs required PostgreSQL extensions.

 Standard     : SDS-2026.1

 Dependencies
   Bootstrap/
      001-CreateDatabase.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Safe for repeated execution.
 - Uses only PostgreSQL standard features.
 - Compatible with Docker without modification.
 - Extensions are installed in the current database.

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

-------------------------------------------------------------------------------
-- pgcrypto
--
-- Provides:
--   • gen_random_uuid()
--   • crypt()
--   • digest()
-------------------------------------------------------------------------------

CREATE EXTENSION IF NOT EXISTS pgcrypto
WITH SCHEMA public;

COMMENT ON EXTENSION pgcrypto IS
'Cryptographic functions and UUID generation for Phoenix Platform.';

-------------------------------------------------------------------------------
-- citext
--
-- Provides case-insensitive text data type.
-------------------------------------------------------------------------------

CREATE EXTENSION IF NOT EXISTS citext
WITH SCHEMA public;

COMMENT ON EXTENSION citext IS
'Case-insensitive character string type for Phoenix Platform.';

/*
==============================================================================
 End of File
==============================================================================
*/