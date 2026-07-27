/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : country.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Country
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Country reference table.
 *
 * The Country table defines the standardized countries supported by the
 * Phoenix Platform. It serves as the authoritative geopolitical reference used
 * throughout the platform for exchanges, companies, currencies, regulatory
 * authorities, market classification, and other business entities.
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
 *     - ref.exchange
 *     - market.company
 *     - ref.currency
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
 * - Based on ISO 3166 country standards.
 * - Supports ISO 3166 Alpha-2, Alpha-3, and Numeric country codes.
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
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

CREATE TABLE ref.country
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    country_id              BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id               UUID
                                NOT NULL
                                DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    iso_alpha2_code         VARCHAR(2)
                                NOT NULL,

    iso_alpha3_code         VARCHAR(3)
                                NOT NULL,

    iso_numeric_code        char(3)
                                NOT NULL,

    country_name            VARCHAR(200)
                                NOT NULL,

    country_local_name              VARCHAR(200),

    nationality             VARCHAR(100),

    display_order           SMALLINT
                                NOT NULL
                                DEFAULT 1,

    description             VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active               BOOLEAN
                                NOT NULL
                                DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at              TIMESTAMPTZ
                                NOT NULL
                                DEFAULT CURRENT_TIMESTAMP,

    updated_at              TIMESTAMPTZ,

    created_by              BIGINT
                                NOT NULL,

    updated_by              BIGINT,

    version                 INTEGER
                                NOT NULL
                                DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_country
        PRIMARY KEY
        (
            country_id
        ),

    CONSTRAINT uq_country_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_country_iso_alpha2
        UNIQUE
        (
            iso_alpha2_code
        ),

    CONSTRAINT uq_country_iso_alpha3
        UNIQUE
        (
            iso_alpha3_code
        ),

    CONSTRAINT uq_country_iso_numeric
        UNIQUE
        (
            iso_numeric_code
        ),

    CONSTRAINT ck_country_iso_alpha2_not_empty
        CHECK
        (
            LENGTH(TRIM(iso_alpha2_code)) > 0
        ),

    CONSTRAINT ck_country_iso_alpha3_not_empty
        CHECK
        (
            LENGTH(TRIM(iso_alpha3_code)) > 0
        ),

    CONSTRAINT ck_country_name_not_empty
        CHECK
        (
            LENGTH(TRIM(country_name)) > 0
        ),

    CONSTRAINT ck_country_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_country_iso_alpha2_length
        CHECK
        (
            LENGTH(TRIM(iso_alpha2_code)) = 2
        ),

    CONSTRAINT ck_country_iso_alpha3_length
        CHECK
        (
            LENGTH(TRIM(iso_alpha3_code)) = 3
        ),

    CONSTRAINT ck_country_iso_numeric_length
        CHECK
        (
            LENGTH(TRIM(iso_numeric_code)) = 3
        ),

    CONSTRAINT ck_country_version_positive
        CHECK
        (
            version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.country
IS
'Reference table containing the standardized countries supported by the
Phoenix Platform. Each country represents an authoritative geopolitical entity
used throughout the platform for exchanges, companies, currencies, regulatory
authorities, market classification, and other business entities.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.country.country_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.country.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.country.iso_alpha2_code
IS
'ISO 3166-1 Alpha-2 country code.';

COMMENT ON COLUMN ref.country.iso_alpha3_code
IS
'ISO 3166-1 Alpha-3 country code.';

COMMENT ON COLUMN ref.country.iso_numeric_code
IS
'ISO 3166-1 numeric country code.';

COMMENT ON COLUMN ref.country.country_name
IS
'Official English name of the country.';

COMMENT ON COLUMN ref.country.country_local_name
IS
'Official local-language name of the country.';

COMMENT ON COLUMN ref.country.nationality
IS
'Official nationality or demonym associated with the country.';

COMMENT ON COLUMN ref.country.display_order
IS
'Display sequence used by applications when presenting countries to users.';

COMMENT ON COLUMN ref.country.description
IS
'Optional business description of the country.';

COMMENT ON COLUMN ref.country.is_active
IS
'Indicates whether the country is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.country.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.country.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.country.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.country.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.country.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------