/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : DataQualityStatus.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : DataQualityStatus
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical DataQualityStatus reference table.
 *
 * The DataQualityStatus table defines the standardized quality classification
 * assigned to market data records after data acquisition, validation, quality
 * control, and correction processes.
 *
 * The table provides a consistent quality model across all market data fact
 * tables and analytical services within the Phoenix Platform.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - ADR-026 Normalize Reference Data Model
 * - ADR-027 Canonical Market Data Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 * - ConstraintSpecifications.md
 * - DDLTemplateSpecification.md
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : ref
 *
 * Referenced By
 * -------------------------------------------------------------------------------------------------
 *     - market.daily_market_data
 *     - market.intraday_bar
 *     - market.tick_data
 *     - market.order_book_snapshot
 *     - market.market_snapshot
 *     - market.instrument_price_history
 *     - Analytics Engine
 *     - Indicator Engine
 *     - Strategy Engine
 *     - Backtesting Engine
 *     - Machine Learning Engine
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - Enterprise Naming Standard
 * - Enterprise Database Design Standard
 * - PostgreSQL Physical Database Design
 * - PostgreSQL Design Decisions
 * - Reference Table Standard
 * - Constraint Specifications
 * - DDL Template Specification
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical reference table.
 * - One database object per script.
 * - Shared across all supported financial markets.
 * - PostgreSQL 17 compatible.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-27
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   -------------------------------------------------------
 * 2026.1    2026-07-27   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.data_quality_status
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    data_quality_status_id          BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Identifier
    ----------------------------------------------------------------------------

    quality_status_code                            VARCHAR(30)
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Information
    ----------------------------------------------------------------------------

    quality_status_name                            VARCHAR(100)
                                        NOT NULL,

    description                     VARCHAR(500),

    display_order                   SMALLINT
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- System Attributes
    ----------------------------------------------------------------------------

    is_system                       BOOLEAN
                                        NOT NULL
                                        DEFAULT TRUE,

    is_active                       BOOLEAN
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

    version                         INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_data_quality_status
        PRIMARY KEY
        (
            data_quality_status_id
        ),

    CONSTRAINT uq_data_quality_status_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_data_quality_status_code
        UNIQUE
        (
            quality_status_code
        ),

    CONSTRAINT uq_data_quality_status_name
        UNIQUE
        (
            quality_status_name
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_data_quality_status_code
        CHECK
        (
            LENGTH(TRIM(quality_status_code)) > 0
        ),

    CONSTRAINT ck_data_quality_status_name
        CHECK
        (
            LENGTH(TRIM(quality_status_name)) > 0
        ),

    CONSTRAINT ck_data_quality_status_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_data_quality_status_version
        CHECK
        (
            version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.data_quality_status
IS
'Defines the canonical reference values describing the quality status assigned
to market data records after acquisition, validation, quality control, and
correction processes. The table provides a standardized data quality model
shared across all Phoenix Platform market data services and analytical
components.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.data_quality_status.data_quality_status_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.data_quality_status.public_id
IS
'Immutable public identifier used for external integrations, synchronization, APIs, and distributed systems.';

COMMENT ON COLUMN ref.data_quality_status.quality_status_code
IS
'Short unique business code identifying the data quality status.';

COMMENT ON COLUMN ref.data_quality_status.quality_status_name
IS
'Unique business name of the data quality status.';

COMMENT ON COLUMN ref.data_quality_status.description
IS
'Optional business description explaining the purpose and usage of the data quality status.';

COMMENT ON COLUMN ref.data_quality_status.display_order
IS
'Display sequence used for user interfaces, reports, and ordered business lists.';

COMMENT ON COLUMN ref.data_quality_status.is_system
IS
'Indicates whether the record is a protected system-defined reference value managed by the Phoenix Platform.';

COMMENT ON COLUMN ref.data_quality_status.is_active
IS
'Indicates whether the reference value is active and available for business operations.';

COMMENT ON COLUMN ref.data_quality_status.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.data_quality_status.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.data_quality_status.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.data_quality_status.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.data_quality_status.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- Seed Data
--------------------------------------------------------------------------------

INSERT INTO ref.data_quality_status
(
    quality_status_code,
    quality_status_name,
    description,
    display_order,
    is_system,
    is_active,
    created_by
)
VALUES

(
    'VALID',
    'Valid',
    'Data successfully validated and approved for all business operations.',
    1,
    TRUE,
    TRUE,
    1
),

(
    'EST',
    'Estimated',
    'Data generated through estimation because official values were unavailable.',
    2,
    TRUE,
    TRUE,
    1
),

(
    'COR',
    'Corrected',
    'Previously published data that has been officially corrected.',
    3,
    TRUE,
    TRUE,
    1
),

(
    'PVAL',
    'Pending Validation',
    'Data received but awaiting completion of validation and quality control procedures.',
    4,
    TRUE,
    TRUE,
    1
),

(
    'INV',
    'Invalid',
    'Data failed validation rules and shall not be used for business processing.',
    5,
    TRUE,
    TRUE,
    1
),

(
    'REJ',
    'Rejected',
    'Data explicitly rejected during validation or quality control processes.',
    6,
    TRUE,
    TRUE,
    1
);

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------