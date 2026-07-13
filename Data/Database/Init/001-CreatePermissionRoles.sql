/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 001-CreatePermissionRoles.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Creates Phoenix permission roles.

 Standard     : SDS-2026.1

 Dependencies : None

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Security and Identity Model

------------------------------------------------------------------------------
 Notes

 - Creates ONLY permission roles.
 - No LOGIN roles are created here.
 - Safe for repeated execution.
 - Passwords are intentionally omitted.

------------------------------------------------------------------------------
 Revision History

 2026-06-30
 Initial Enterprise Version

==============================================================================
*/


/******************************************************************************
 Security Notice

 This script creates ONLY permission roles.

 These roles are NOT allowed to authenticate.

 Login roles are created separately in:

     002-CreateLoginRoles.sql

******************************************************************************/

-------------------------------------------------------------------------------
-- Database Owner Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_owner'
    )
    THEN

        CREATE ROLE phoenix_owner
            NOLOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOINHERIT;

        COMMENT ON ROLE phoenix_owner IS
            'Owns all Phoenix database objects.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Administrative Permission Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_admin'
    )
    THEN

        CREATE ROLE phoenix_admin
            NOLOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOINHERIT;

        COMMENT ON ROLE phoenix_admin IS
            'Administrative permission role.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Read / Write Permission Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_rw'
    )
    THEN

        CREATE ROLE phoenix_rw
            NOLOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOINHERIT;

        COMMENT ON ROLE phoenix_rw IS
            'Read and write permission role.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Read Only Permission Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_ro'
    )
    THEN

        CREATE ROLE phoenix_ro
            NOLOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOINHERIT;

        COMMENT ON ROLE phoenix_ro IS
            'Read-only permission role.';

    END IF;

END
$$;

/*
==============================================================================
 End of File
==============================================================================
*/