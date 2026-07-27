/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : CalendarType.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : CalendarType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical CalendarType reference table.
 *
 * The CalendarType table defines the standardized calendar systems supported by
 * the Phoenix Platform. Each record represents an authoritative calendar system
 * used for date conversion, localization, scheduling, reporting, and business
 * operations across multiple countries and financial markets.
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
 *     - ref.country
 *     - ref.trading_calendar
 *     - ref.holiday_calendar
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
 * - Supports international calendar systems.
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

CREATE TABLE ref.calendar_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    calendar_type_id         BIGINT
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

    calendar_type_code       VARCHAR(30)
                                 NOT NULL,

    calendar_type_name       VARCHAR(100)
                                 NOT NULL,

    short_name               VARCHAR(50),

    calendar_type_local_name               VARCHAR(100),

    display_order            SMALLINT
                                 NOT NULL
                                 DEFAULT 1,

    description              VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                BOOLEAN
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

    version                  INTEGER
                                 NOT NULL
                                 DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_calendar_type
        PRIMARY KEY
        (
            calendar_type_id
        ),

    CONSTRAINT uq_calendar_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_calendar_type_code
        UNIQUE
        (
            calendar_type_code
        ),

    CONSTRAINT ck_calendar_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(calendar_type_code)) > 0
        ),

    CONSTRAINT ck_calendar_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(calendar_type_name)) > 0
        ),

    CONSTRAINT ck_calendar_type_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_calendar_type_version_positive
        CHECK
        (
            version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.calendar_type
IS
'Reference table containing the standardized calendar systems supported by the
Phoenix Platform. Each record represents an authoritative calendar system used
for date processing, localization, scheduling, reporting, and business
operations across multiple countries and financial markets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.calendar_type.calendar_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.calendar_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.calendar_type.calendar_type_code
IS
'Unique business code identifying the calendar type.';

COMMENT ON COLUMN ref.calendar_type.calendar_type_name
IS
'Official business name of the calendar system.';

COMMENT ON COLUMN ref.calendar_type.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.calendar_type.calendar_type_local_name
IS
'Official local-language name of the calendar system.';

COMMENT ON COLUMN ref.calendar_type.display_order
IS
'Display sequence used by applications when presenting calendar types to users.';

COMMENT ON COLUMN ref.calendar_type.description
IS
'Optional business description of the calendar system.';

COMMENT ON COLUMN ref.calendar_type.is_active
IS
'Indicates whether the calendar type is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.calendar_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.calendar_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.calendar_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.calendar_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.calendar_type.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------