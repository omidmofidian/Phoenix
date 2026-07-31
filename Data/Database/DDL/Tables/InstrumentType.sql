/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : instrument_type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical InstrumentType reference table.
 *
 * The InstrumentType table defines the standardized financial instrument types
 * supported by the Phoenix Platform. It provides the authoritative
 * classification used to categorize tradable financial instruments across all
 * supported financial markets, including equities, fixed income, derivatives,
 * exchange-traded funds, commodities, foreign exchange, and digital assets.
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
 *     - market.instrument
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
 * - Designed to support multiple financial markets.
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

 CREATE TABLE ref.instrument_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_type_id           BIGINT
                                     GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                    UUID
                                     NOT NULL
                                     DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    instrument_type_code         VARCHAR(30)
                                     NOT NULL,

    instrument_type_name         VARCHAR(200)
                                     NOT NULL,

    instrument_type_short_name                   VARCHAR(100),

    instrument_type_local_name                   VARCHAR(200),

    instrument_type_display_order                SMALLINT
                                     NOT NULL
                                     DEFAULT 1,

    instrument_type_description                  VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    instrument_type_is_active                    BOOLEAN
                                     NOT NULL
                                     DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                   TIMESTAMPTZ
                                     NOT NULL
                                     DEFAULT CURRENT_TIMESTAMP,

    updated_at                   TIMESTAMPTZ,

    created_by                   BIGINT
                                     NOT NULL,

    updated_by                   BIGINT,

    row_version                      INTEGER
                                     NOT NULL
                                     DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_type
        PRIMARY KEY
        (
            instrument_type_id
        ),

    CONSTRAINT uk_instrument_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_instrument_type_code
        UNIQUE
        (
            instrument_type_code
        ),

    CONSTRAINT ck_instrument_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(instrument_type_code)) > 0
        ),

    CONSTRAINT ck_instrument_type_code_length
        CHECK
        (
            LENGTH(TRIM(instrument_type_code)) BETWEEN 2 AND 30
        ),

    CONSTRAINT ck_instrument_type_code_uppercase
        CHECK 
        (
            instrument_type_code = UPPER(instrument_type_code)
        ),

    CONSTRAINT ck_instrument_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(instrument_type_name)) > 0
        ),
    CONSTRAINT ck_instrument_type_short_name_not_empty
        CHECK (
            instrument_type_short_name IS NULL
            OR LENGTH(TRIM(instrument_type_short_name)) > 0
        ),

    CONSTRAINT ck_instrument_type_local_name_not_empty
        CHECK (
            instrument_type_local_name IS NULL
            OR LENGTH(TRIM(instrument_type_local_name)) > 0
        ),

    CONSTRAINT ck_instrument_type_description_not_empty
        CHECK (
            instrument_type_description IS NULL
            OR LENGTH(TRIM(instrument_type_description)) > 0
        ),
    CONSTRAINT ck_instrument_type_display_order
        CHECK
        (
            instrument_type_display_order > 0
        ),

    CONSTRAINT ck_instrument_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.instrument_type
IS
'Reference table containing the standardized financial instrument types supported
by the Phoenix Platform. Each record represents an authoritative classification
used to categorize tradable financial instruments across all supported financial
markets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.instrument_type.instrument_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.instrument_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_code
IS
'Unique business code identifying the financial instrument type.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_name
IS
'Official business name of the financial instrument type.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_local_name
IS
'Official local-language name of the financial instrument type.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_display_order
IS
'Display sequence used by applications when presenting financial instrument types to users.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_description
IS
'Optional business description of the financial instrument type.';

COMMENT ON COLUMN ref.instrument_type.instrument_type_is_active
IS
'Indicates whether the financial instrument type is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.instrument_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.instrument_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.instrument_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.instrument_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.instrument_type.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------