/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 002-CreateLoginRoles.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team

 Target       : PostgreSQL 17+
 Environment  : Docker / Linux / Windows / Cloud

 Category     : Initialization
 Description  : Creates Phoenix login roles.

 Standard     : SDS-2026.1

 Dependencies :
   001-CreatePermissionRoles.sql

 Related ADR
   ADR-018 Database Initialization Strategy
   ADR-020 Database Security and Identity Model

------------------------------------------------------------------------------
 Notes

 - Creates ONLY login roles.
 - Does NOT assign any permissions.
 - Does NOT grant membership.
 - Passwords are intentionally omitted.
 - Authentication credentials shall be configured during deployment.
 - Safe for repeated execution.

------------------------------------------------------------------------------
 Revision History

 2026-06-30
 Initial Enterprise Version

==============================================================================
*/


/******************************************************************************
 Security Notice

 Login roles are created without passwords.

 Passwords shall be assigned during deployment using:

   • ALTER ROLE
   • Docker Secrets
   • Kubernetes Secrets
   • Azure Key Vault
   • AWS Secrets Manager
   • HashiCorp Vault

******************************************************************************/

-------------------------------------------------------------------------------
-- Application Runtime Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_app'
    )
    THEN

        CREATE ROLE phoenix_app
            LOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            INHERIT;

        COMMENT ON ROLE phoenix_app IS
            'Runtime role used by Phoenix backend application.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Testing Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_test'
    )
    THEN

        CREATE ROLE phoenix_test
            LOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            INHERIT;

        COMMENT ON ROLE phoenix_test IS
            'Role used for automated and manual testing.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- ETL Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_etl'
    )
    THEN

        CREATE ROLE phoenix_etl
            LOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            INHERIT;

        COMMENT ON ROLE phoenix_etl IS
            'Role used for ETL and scheduled data processing.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Read Only Login Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_readonly'
    )
    THEN

        CREATE ROLE phoenix_readonly
            LOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            INHERIT;

        COMMENT ON ROLE phoenix_readonly IS
            'Login role used for reporting and analytics.';

    END IF;

END
$$;

-------------------------------------------------------------------------------
-- Deployment Role
-------------------------------------------------------------------------------

DO
$$
BEGIN

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'phoenix_deployer'
    )
    THEN

        CREATE ROLE phoenix_deployer
            LOGIN
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            INHERIT;

        COMMENT ON ROLE phoenix_deployer IS
            'Role used by deployment pipelines and migration tools.';

    END IF;

END
$$;

/*
==============================================================================
 End of File
==============================================================================
*/