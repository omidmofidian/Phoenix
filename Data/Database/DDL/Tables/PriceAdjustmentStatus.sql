/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : PriceAdjustmentStatus.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : PriceAdjustmentStatus
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical PriceAdjustmentStatus reference table.
 *
 * The PriceAdjustmentStatus table defines the classification of price adjustment
 * states applied to market data records within the Phoenix Platform.
 *
 * The table is shared across all market data fact tables and provides a
 * standardized mechanism for identifying whether price values are raw,
 * adjusted, partially adjusted, corrected, estimated, imported, or synthetic.
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

CREATE TABLE ref.price_adjustment_status
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    price_adjustment_status_id      SMALLINT
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

    adjustment_status_code                            VARCHAR(30)
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Information
    ----------------------------------------------------------------------------

    adjustment_status_name                            VARCHAR(100)
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

    CONSTRAINT pk_price_adjustment_status
        PRIMARY KEY
        (
            price_adjustment_status_id
        ),

    CONSTRAINT uq_price_adjustment_status_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_price_adjustment_status_code
        UNIQUE
        (
            adjustment_status_code
        ),

    CONSTRAINT uq_price_adjustment_status_name
        UNIQUE
        (
            adjustment_status_name
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_price_adjustment_status_code
        CHECK
        (
            LENGTH(TRIM(adjustment_status_code)) > 0
        ),

    CONSTRAINT ck_price_adjustment_status_name
        CHECK
        (
            LENGTH(TRIM(adjustment_status_name)) > 0
        ),

    CONSTRAINT ck_price_adjustment_status_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_price_adjustment_status_version
        CHECK
        (
            version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.price_adjustment_status
IS
'Defines the canonical reference values describing the price adjustment status
applied to market data records. The table standardizes the interpretation of
raw, adjusted, partially adjusted, corrected, imported, estimated, and
synthetic price data across all Phoenix Platform market data services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.price_adjustment_status.price_adjustment_status_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.price_adjustment_status.public_id
IS
'Immutable public identifier used for external integrations, synchronization, APIs, and distributed systems.';

COMMENT ON COLUMN ref.price_adjustment_status.adjustment_status_code
IS
'Short unique business code identifying the price adjustment status.';

COMMENT ON COLUMN ref.price_adjustment_status.adjustment_status_name
IS
'Unique business name of the price adjustment status.';

COMMENT ON COLUMN ref.price_adjustment_status.description
IS
'Optional business description explaining the purpose and usage of the price adjustment status.';

COMMENT ON COLUMN ref.price_adjustment_status.display_order
IS
'Display sequence used for user interfaces, reports, and ordered business lists.';

COMMENT ON COLUMN ref.price_adjustment_status.is_system
IS
'Indicates whether the record is a protected system-defined reference value managed by the Phoenix Platform.';

COMMENT ON COLUMN ref.price_adjustment_status.is_active
IS
'Indicates whether the reference value is active and available for business operations.';

COMMENT ON COLUMN ref.price_adjustment_status.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.price_adjustment_status.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.price_adjustment_status.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.price_adjustment_status.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.price_adjustment_status.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------