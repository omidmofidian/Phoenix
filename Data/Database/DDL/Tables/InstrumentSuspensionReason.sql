/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : instrument_suspension_reason.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentSuspensionReason
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical InstrumentSuspensionReason reference table.
 *
 * The InstrumentSuspensionReason table defines the standardized business reasons
 * that may cause a listed financial instrument to become suspended from trading.
 * These reasons are used to classify suspension events consistently across all
 * exchanges supported by the Phoenix Platform.
 *
 * The table provides a controlled vocabulary for regulatory reporting,
 * surveillance, analytics, notifications, and historical market analysis.
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
 *     - None
 *
 * Referenced By
 *     - market.instrument_suspension
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

CREATE TABLE ref.instrument_suspension_reason
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_suspension_reason_id      BIGINT
                                             GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                            UUID
                                             NOT NULL
                                             DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    instrument_suspension_reason_code                          VARCHAR(30)
                                             NOT NULL,

    instrument_suspension_reason_name                          VARCHAR(100)
                                             NOT NULL,

    instrument_suspension_reason_short_name                    VARCHAR(50),

    instrument_suspension_reason_local_name                    VARCHAR(100),

    instrument_suspension_reason_display_order                 SMALLINT
                                             NOT NULL
                                             DEFAULT 1,

    instrument_suspension_reason_description                   VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    instrument_suspension_reason_is_active                     BOOLEAN
                                             NOT NULL
                                             DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                           TIMESTAMPTZ
                                             NOT NULL
                                             DEFAULT CURRENT_TIMESTAMP,

    updated_at                           TIMESTAMPTZ,

    created_by                           BIGINT
                                             NOT NULL,

    updated_by                           BIGINT,

    row_version                              INTEGER
                                             NOT NULL
                                             DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_suspension_reason
        PRIMARY KEY
        (
            instrument_suspension_reason_id
        ),

    CONSTRAINT uq_instrument_suspension_reason_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_instrument_suspension_reason_code
        UNIQUE
        (
            instrument_suspension_reason_code
        ),

    CONSTRAINT uq_instrument_suspension_reason_name
        UNIQUE
        (
            instrument_suspension_reason_name
        ),

    CONSTRAINT ck_instrument_suspension_reason_code_not_empty
        CHECK
        (
            LENGTH(TRIM(instrument_suspension_reason_code)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_code_uppercase
        CHECK
        (
            instrument_suspension_reason_code = UPPER(instrument_suspension_reason_code)
        ),

    CONSTRAINT ck_instrument_suspension_reason_name_not_empty
        CHECK
        (
            LENGTH(TRIM(instrument_suspension_reason_name)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_short_name_not_empty
        CHECK
        (
            instrument_suspension_reason_short_name IS NULL
            OR LENGTH(TRIM(instrument_suspension_reason_short_name)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_local_name_not_empty
        CHECK
        (
            instrument_suspension_reason_local_name IS NULL
            OR LENGTH(TRIM(instrument_suspension_reason_local_name)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_display_order_positive
        CHECK
        (
            instrument_suspension_reason_display_order > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_description_not_empty
        CHECK
        (
            instrument_suspension_reason_description IS NULL
            OR LENGTH(TRIM(instrument_suspension_reason_description)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_reason_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.instrument_suspension_reason
IS
'Reference table defining the standardized business reasons for suspending a listed financial instrument. These reasons provide consistent classification of suspension events across all exchanges supported by the Phoenix Platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.instrument_suspension_reason.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_code
IS
'Unique business code identifying the instrument suspension reason.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_name
IS
'Official business name of the instrument suspension reason.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_short_name
IS
'Abbreviated name used by applications, reports, and user interfaces.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_local_name
IS
'Official local-language name of the instrument suspension reason.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_display_order
IS
'Display sequence used when presenting suspension reasons within user interfaces and reports.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_description
IS
'Optional business description providing additional information about the suspension reason.';

COMMENT ON COLUMN ref.instrument_suspension_reason.instrument_suspension_reason_is_active
IS
'Indicates whether the suspension reason is currently active and available for business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.instrument_suspension_reason.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.instrument_suspension_reason.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.instrument_suspension_reason.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.instrument_suspension_reason.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.instrument_suspension_reason.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------