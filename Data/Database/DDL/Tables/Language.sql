/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : language.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Language
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Language reference table.
 *
 * The Language table defines the standardized languages supported by the
 * Phoenix Platform. Each record represents an authoritative language used for
 * localization, internationalization, user preferences, reporting, and
 * multilingual business data.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - Architecture Decision Records (ADR)
 * - Domain Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 * - TablePhysicalSpecifications.md
 * - ConstraintSpecifications.md
 * - DDLTemplateSpecification.md
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : ref
 *
 * Referenced Objects
 *     None
 *
 * Referenced By
 *     - security.user
 *     - ref.country
 *     - localization services
 *     - Reporting services
 *     - Additional business entities
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - Enterprise Naming Standard
 * - Enterprise Database Design Standard
 * - PostgreSQL Physical Database Design
 * - PostgreSQL Design Decisions
 * - Table Physical Specifications
 * - Constraint Specifications
 * - DDL Template Specification
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
 * - Uses ISO 639 language codes.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.language
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    language_id              BIGINT
                                 GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                UUID
                                 NOT NULL
                                 DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    language_code            CHAR(2)
                                 NOT NULL,

    language_name            VARCHAR(200)
                                 NOT NULL,

    native_name              VARCHAR(200)
                                 NOT NULL,

    iso639_2_code            CHAR(3),

    script_direction         VARCHAR(3)
                                 NOT NULL
                                 DEFAULT 'LTR',

    locale_code              VARCHAR(20),

    language_display_order            SMALLINT
                                 NOT NULL
                                 DEFAULT 1,

    language_description              VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    language_is_active                BOOLEAN
                                 NOT NULL
                                 DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at               TIMESTAMPTZ
                                 NOT NULL
                                 DEFAULT CURRENT_TIMESTAMP,

    updated_at               TIMESTAMPTZ,

    created_by               BIGINT
                                 NOT NULL,

    updated_by               BIGINT,

    row_version                  INTEGER
                                 NOT NULL
                                 DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_language
        PRIMARY KEY
        (
            language_id
        ),

    CONSTRAINT uk_language_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_language_code
        UNIQUE
        (
            language_code
        ),

    CONSTRAINT uk_language_iso639_2
        UNIQUE
        (
            iso639_2_code
        ),

    CONSTRAINT uk_language_locale_code
        UNIQUE
        (
            locale_code
        ),

    CONSTRAINT ck_language_code_not_empty
        CHECK
        (
            LENGTH(TRIM(language_code)) > 0
        ),

    CONSTRAINT ck_language_code_format
        CHECK
        (
            language_code = LOWER(language_code)
        ),

    CONSTRAINT ck_language_name_not_empty
        CHECK
        (
            LENGTH(TRIM(language_name)) > 0
        ),

    CONSTRAINT ck_language_native_name_not_empty
        CHECK
        (
            LENGTH(TRIM(native_name)) > 0
        ),

    CONSTRAINT ck_language_iso639_2_length
        CHECK
        (
            iso639_2_code IS NULL
            OR 
            (iso639_2_code = LOWER(iso639_2_code)
            AND LENGTH(TRIM(iso639_2_code)) = 3)
        ),

    CONSTRAINT ck_language_locale_code_not_empty
        CHECK
        (
            locale_code IS NULL
            OR LENGTH(TRIM(locale_code)) > 0
        ),

    CONSTRAINT ck_language_locale_code_format
        CHECK
        (
            locale_code IS NULL
            OR locale_code ~ '^[a-z]{2}(-[A-Z]{2})?$'
        ),

    CONSTRAINT ck_language_script_direction
        CHECK
        (
            script_direction IN ('LTR', 'RTL')
        ),

    CONSTRAINT ck_language_display_order
        CHECK
        (
            language_display_order > 0
        ),

    CONSTRAINT ck_language_description_not_empty
        CHECK
        (
            language_description IS NULL
            OR LENGTH(TRIM(language_description)) > 0
        ),

    CONSTRAINT ck_language_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.language
IS
'Reference table containing the standardized languages supported by the
Phoenix Platform. Each record represents an authoritative language used for
localization, internationalization, multilingual business data, reporting,
and user preferences.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.language.language_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.language.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.language.language_code
IS
'Unique business code -ISO 639-1 two-character code- identifying the language.';

COMMENT ON COLUMN ref.language.language_name
IS
'Official English name of the language.';

COMMENT ON COLUMN ref.language.native_name
IS
'Official native-language name of the language.';

COMMENT ON COLUMN ref.language.iso639_2_code
IS
'ISO 639-2 three-character language code.';

COMMENT ON COLUMN ref.language.script_direction
IS
'Writing direction used by the language. Supported values are LTR (Left-to-Right) and RTL (Right-to-Left).';

COMMENT ON COLUMN ref.language.locale_code
IS
'Standard locale identifier based on IETF BCP 47 (for example, en-US, fa-IR, ar-SA, or zh-CN).';

COMMENT ON COLUMN ref.language.language_display_order
IS
'Display sequence used by applications when presenting languages to users.';

COMMENT ON COLUMN ref.language.language_description
IS
'Optional business description of the language.';

COMMENT ON COLUMN ref.language.language_is_active
IS
'Indicates whether the language is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.language.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.language.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.language.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.language.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.language.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------