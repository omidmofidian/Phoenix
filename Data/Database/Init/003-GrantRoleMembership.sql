/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 003-GrantRoleMembership.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Grants membership between login roles and permission roles.

 Standard     : SDS-2026.1

 Dependencies
   001-CreatePermissionRoles.sql
   002-CreateLoginRoles.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Bootstrap and Security Architecture

------------------------------------------------------------------------------
 Notes

 - Creates NO roles.
 - Grants NO object permissions.
 - Assigns membership only.
 - Safe for repeated execution.
 - Follows Role-Based Access Control (RBAC).

------------------------------------------------------------------------------
 Revision History

 2026-07-01
 Initial Enterprise Version

==============================================================================
*/

-------------------------------------------------------------------------------
-- Runtime Application
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_auth_members m
        JOIN pg_roles r1 ON r1.oid = m.roleid
        JOIN pg_roles r2 ON r2.oid = m.member
        WHERE r1.rolname = 'phoenix_rw'
          AND r2.rolname = 'phoenix_app'
    )
    THEN

        GRANT phoenix_rw TO phoenix_app;

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Testing
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_auth_members m
        JOIN pg_roles r1 ON r1.oid = m.roleid
        JOIN pg_roles r2 ON r2.oid = m.member
        WHERE r1.rolname = 'phoenix_rw'
          AND r2.rolname = 'phoenix_test'
    )
    THEN

        GRANT phoenix_rw TO phoenix_test;

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- ETL
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_auth_members m
        JOIN pg_roles r1 ON r1.oid = m.roleid
        JOIN pg_roles r2 ON r2.oid = m.member
        WHERE r1.rolname = 'phoenix_rw'
          AND r2.rolname = 'phoenix_etl'
    )
    THEN

        GRANT phoenix_rw TO phoenix_etl;

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Read Only
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_auth_members m
        JOIN pg_roles r1 ON r1.oid = m.roleid
        JOIN pg_roles r2 ON r2.oid = m.member
        WHERE r1.rolname = 'phoenix_ro'
          AND r2.rolname = 'phoenix_readonly'
    )
    THEN

        GRANT phoenix_ro TO phoenix_readonly;

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Deployment
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_auth_members m
        JOIN pg_roles r1 ON r1.oid = m.roleid
        JOIN pg_roles r2 ON r2.oid = m.member
        WHERE r1.rolname = 'phoenix_admin'
          AND r2.rolname = 'phoenix_deployer'
    )
    THEN

        GRANT phoenix_admin TO phoenix_deployer;

    END IF;

END
$$;

/*
==============================================================================
 End of File
==============================================================================
*/