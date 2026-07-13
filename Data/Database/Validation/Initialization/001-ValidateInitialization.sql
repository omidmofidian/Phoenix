/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 001-ValidateInitialization.sql
 Version      : SDS-2026.1
 Author       : Phoenix Architecture Team
 Target       : PostgreSQL 17
 Category     : Validation
 Description  : Quality Gate #1 - Initialization Validation

 Purpose:
     Validates that the database initialization phase has been completed
     successfully before any business objects are created.

 Standard     : SDS-2026.1
 Related ADR  : ADR-018

 Notes:
     - Read Only
     - Zero Side Effects
     - Fail Fast
     - CI/CD Ready

==============================================================================
*/

DO
$$

DECLARE

    v_extension text;
    v_role      text;
    v_schema    text;

BEGIN

----------------------------------------------------------------------------
-- Validate Database
----------------------------------------------------------------------------

IF current_database() <> 'phoenix' THEN
    RAISE EXCEPTION
        'Initialization Validation FAILED: Connected database is "%". Expected "phoenix".',
        current_database();
END IF;

----------------------------------------------------------------------------
-- Validate PostgreSQL Version
----------------------------------------------------------------------------

IF current_setting('server_version_num')::integer < 170000 THEN

    RAISE EXCEPTION
        'Initialization Validation FAILED: PostgreSQL 17 or later is required. Current version: %',
        current_setting('server_version');

END IF;

----------------------------------------------------------------------------
-- Validate Required Extensions
----------------------------------------------------------------------------

FOREACH v_extension IN ARRAY ARRAY[
    'pgcrypto',
    'citext'
]
LOOP

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_extension
        WHERE extname = v_extension
    )
    THEN
        RAISE EXCEPTION
            'Initialization Validation FAILED: Extension "%" is missing.',
            v_extension;
    END IF;

END LOOP;

----------------------------------------------------------------------------
-- Validate Roles
----------------------------------------------------------------------------

FOREACH v_role IN ARRAY ARRAY[
    'phoenix_owner',
    'phoenix_app',
    'phoenix_test',
    'phoenix_etl',
    'phoenix_readonly',
    'phoenix_deployer'
]
LOOP

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = v_role
    )
    THEN
        RAISE EXCEPTION
            'Initialization Validation FAILED: Role "%" does not exist.',
            v_role;
    END IF;

END LOOP;

----------------------------------------------------------------------------
-- Validate Schemas
----------------------------------------------------------------------------

FOREACH v_schema IN ARRAY ARRAY[
    'ref',
    'core',
    'market',
    'integration',
    'config',
    'audit',
    'report'
]
LOOP

    IF NOT EXISTS
    (
        SELECT 1
        FROM information_schema.schemata
        WHERE schema_name = v_schema
    )
    THEN
        RAISE EXCEPTION
            'Initialization Validation FAILED: Schema "%" does not exist.',
            v_schema;
    END IF;

END LOOP;

----------------------------------------------------------------------------
-- Validate Public Schema
----------------------------------------------------------------------------

IF EXISTS
(
    SELECT 1
    FROM pg_tables
    WHERE schemaname = 'public'
)
THEN

    RAISE EXCEPTION
        'Initialization Validation FAILED: Schema "public" must not contain user tables.';

END IF;

IF EXISTS
(
    SELECT 1
    FROM pg_views
    WHERE schemaname = 'public'
)
THEN

    RAISE EXCEPTION
        'Initialization Validation FAILED: Schema "public" must not contain user views.';

END IF;

----------------------------------------------------------------------------
-- Validate Schema Ownership
----------------------------------------------------------------------------

IF EXISTS
(
    SELECT 1
    FROM pg_namespace n
         JOIN pg_roles r
           ON r.oid = n.nspowner
    WHERE n.nspname IN
    (
        'ref',
        'core',
        'market',
        'integration',
        'config',
        'audit',
        'report'
    )
    AND r.rolname <> 'phoenix_owner'
)
THEN

    RAISE EXCEPTION
        'Initialization Validation FAILED: One or more schemas are not owned by phoenix_owner.';

END IF;

----------------------------------------------------------------------------
-- Validate Database Search Path
----------------------------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM pg_database
    WHERE datname = 'phoenix'
      AND datconfig IS NOT NULL
)
THEN

    RAISE EXCEPTION
        'Initialization Validation FAILED: Database search_path is not configured.';

END IF;

----------------------------------------------------------------------------
-- Validate Role Search Paths
----------------------------------------------------------------------------

FOREACH v_role IN ARRAY ARRAY[
    'phoenix_app',
    'phoenix_test',
    'phoenix_etl',
    'phoenix_readonly',
    'phoenix_deployer'
]
LOOP

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_roles
        WHERE rolname = v_role
          AND rolconfig IS NOT NULL
    )
    THEN

        RAISE EXCEPTION
            'Initialization Validation FAILED: search_path is not configured for role "%".',
            v_role;

    END IF;

END LOOP;

----------------------------------------------------------------------------
-- Validate Schema Documentation
----------------------------------------------------------------------------

FOREACH v_schema IN ARRAY ARRAY[
    'ref',
    'core',
    'market',
    'integration',
    'config',
    'audit',
    'report'
]
LOOP

    IF NOT EXISTS
    (
        SELECT 1
        FROM pg_namespace
        WHERE nspname = v_schema
          AND obj_description(oid, 'pg_namespace') IS NOT NULL
    )
    THEN

        RAISE EXCEPTION
            'Initialization Validation FAILED: Schema "%" has no COMMENT.',
            v_schema;

    END IF;

END LOOP;

----------------------------------------------------------------------------
-- SUCCESS
----------------------------------------------------------------------------

RAISE NOTICE '';
RAISE NOTICE '============================================================';
RAISE NOTICE ' Phoenix Platform';
RAISE NOTICE ' Initialization Validation ............... PASSED';
RAISE NOTICE ' Quality Gate #1 ......................... PASSED';
RAISE NOTICE ' Database Status ......................... READY';
RAISE NOTICE '============================================================';
RAISE NOTICE '';

END
$$;