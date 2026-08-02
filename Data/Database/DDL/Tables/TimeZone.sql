/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : time_zone.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TimeZone
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TimeZone reference table.
 *
 * The TimeZone table defines the standardized time zones supported by the
 * Phoenix Platform. Each record represents a globally recognized IANA time zone
 * and provides the authoritative reference for exchanges, markets, trading
 * sessions, scheduling, timestamps, and time-based calculations.
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
 *     - market.market_session
 *     - scheduling services
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
 * - Uses IANA Time Zone Database identifiers.
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

CREATE TABLE ref.time_zone
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    time_zone_id             BIGINT
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

    time_zone_code           VARCHAR(100)
                                 NOT NULL,

    time_zone_name           VARCHAR(200)
                                 NOT NULL,

    utc_offset               VARCHAR(10)
                                 NOT NULL,

    time_zone_short_name               VARCHAR(20),

    time_zone_local_name               VARCHAR(200),

    time_zone_display_order            SMALLINT
                                 NOT NULL
                                 DEFAULT 1,

    time_zone_description              VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    time_zone_is_active                BOOLEAN
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

    CONSTRAINT pk_time_zone
        PRIMARY KEY
        (
            time_zone_id
        ),

    CONSTRAINT uk_time_zone_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_time_zone_code
        UNIQUE
        (
            time_zone_code
        ),

    CONSTRAINT ck_time_zone_code_not_empty
        CHECK
        (
            LENGTH(TRIM(time_zone_code)) > 0
        ),

    CONSTRAINT ck_time_zone_name_not_empty
        CHECK
        (
            LENGTH(TRIM(time_zone_name)) > 0
        ),

    CONSTRAINT ck_time_zone_utc_offset_not_empty
        CHECK
        (
            LENGTH(TRIM(utc_offset)) > 0
        ),

    CONSTRAINT ck_time_zone_short_name_not_empty
        CHECK 
        (
            time_zone_short_name IS NULL
            OR LENGTH(TRIM(time_zone_short_name)) > 0
        ),

    CONSTRAINT ck_time_zone_local_name_not_empty
        CHECK 
        (
            time_zone_local_name IS NULL
            OR LENGTH(TRIM(time_zone_local_name)) > 0
        ),

    CONSTRAINT ck_time_zone_description_not_empty
        CHECK 
        (
            time_zone_description IS NULL
            OR LENGTH(TRIM(time_zone_description)) > 0
        ),

    CONSTRAINT ck_time_zone_display_order
        CHECK
        (
            time_zone_display_order > 0
        ),

    CONSTRAINT ck_time_zone_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.time_zone
IS
'Reference table containing the standardized time zones supported by the
Phoenix Platform. Each record represents an authoritative IANA time zone used
for exchanges, markets, trading sessions, scheduling, timestamps, and
time-based business operations.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.time_zone.time_zone_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.time_zone.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.time_zone.time_zone_code
IS
'Unique IANA time zone identifier (for example, Asia/Tehran or Europe/London).';

COMMENT ON COLUMN ref.time_zone.time_zone_name
IS
'Official business name of the time zone.';

COMMENT ON COLUMN ref.time_zone.utc_offset
IS
'Default display UTC offset associated with the time zone. Time calculations
must use the IANA time_zone_code, which remains authoritative for daylight
saving and historical offset changes.';

COMMENT ON COLUMN ref.time_zone.time_zone_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.time_zone.time_zone_local_name
IS
'Official local-language name of the time zone.';

COMMENT ON COLUMN ref.time_zone.time_zone_display_order
IS
'Display sequence used by applications when presenting time zones to users.';

COMMENT ON COLUMN ref.time_zone.time_zone_description
IS
'Optional business description of the time zone.';

COMMENT ON COLUMN ref.time_zone.time_zone_is_active
IS
'Indicates whether the time zone is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.time_zone.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.time_zone.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.time_zone.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.time_zone.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.time_zone.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------