/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : volume_unit.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : VolumeUnit
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical VolumeUnit reference table.
 *
 * The VolumeUnit table defines the standardized business classifications of
 * quantity measurement units used throughout the Phoenix Platform.
 *
 * Each record represents a unit of measure used to express trading volume,
 * transaction quantity, holdings, or other financial quantities associated
 * with market data and trading activities.
 *
 * This table provides consistent volume unit classifications used throughout
 * market data ingestion, trading, portfolio management, reporting, analytics,
 * auditing, and historical market analysis.
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
 *     - market.daily_market_data
 *     - market.tick_data
 *     - portfolio.position
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
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-08-03
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-08-03   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.volume_unit
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    volume_unit_id                  BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    volume_unit_code                VARCHAR(50)
                                        NOT NULL,

    volume_unit_name                VARCHAR(100)
                                        NOT NULL,

    volume_unit_display_order       SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    volume_unit_description         VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    volume_unit_is_active           BOOLEAN
                                        NOT NULL
                                        DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                      TIMESTAMPTZ
                                        NOT NULL
                                        DEFAULT CURRENT_TIMESTAMP,

    updated_at                      TIMESTAMPTZ,

    created_by                      BIGINT
                                        NOT NULL,

    updated_by                      BIGINT,

    row_version                     INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_volume_unit
        PRIMARY KEY
        (
            volume_unit_id
        ),

    CONSTRAINT uk_volume_unit_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_volume_unit_code
        UNIQUE
        (
            volume_unit_code
        ),

    CONSTRAINT uk_volume_unit_name
        UNIQUE
        (
            volume_unit_name
        ),

    CONSTRAINT ck_volume_unit_code_not_empty
        CHECK
        (
            LENGTH(TRIM(volume_unit_code)) > 0
        ),

    CONSTRAINT ck_volume_unit_code_uppercase
        CHECK
        (
            volume_unit_code = UPPER(volume_unit_code)
        ),

    CONSTRAINT ck_volume_unit_name_not_empty
        CHECK
        (
            LENGTH(TRIM(volume_unit_name)) > 0
        ),

    CONSTRAINT ck_volume_unit_display_order_positive
        CHECK
        (
            volume_unit_display_order > 0
        ),

    CONSTRAINT ck_volume_unit_description_not_empty
        CHECK
        (
            volume_unit_description IS NULL
            OR LENGTH(TRIM(volume_unit_description)) > 0
        ),

    CONSTRAINT ck_volume_unit_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.volume_unit
IS
'Reference table defining the standardized units of measure used to represent
trading volume, transaction quantities, holdings, and other financial
quantities throughout the Phoenix Platform. Each volume unit represents a
business classification describing how quantitative values are measured and
reported across market data, trading, portfolio management, analytics,
auditing, and historical market analysis.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.volume_unit.volume_unit_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.volume_unit.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.volume_unit.volume_unit_code
IS
'Unique business code identifying the volume unit.';

COMMENT ON COLUMN ref.volume_unit.volume_unit_name
IS
'Official business name of the volume unit.';

COMMENT ON COLUMN ref.volume_unit.volume_unit_display_order
IS
'Display sequence used by applications when presenting volume units to users.';

COMMENT ON COLUMN ref.volume_unit.volume_unit_description
IS
'Optional business description providing additional information about the
volume unit.';

COMMENT ON COLUMN ref.volume_unit.volume_unit_is_active
IS
'Indicates whether the volume unit is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.volume_unit.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.volume_unit.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.volume_unit.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.volume_unit.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.volume_unit.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------