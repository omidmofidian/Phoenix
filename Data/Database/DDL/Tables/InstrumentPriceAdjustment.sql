/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Instrument_Price_Adjustment.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentPriceAdjustment
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical InstrumentPriceAdjustment table.
 *
 * The InstrumentPriceAdjustment table stores the adjustment parameters required
 * to derive adjusted historical market prices following corporate actions.
 *
 * Each record represents one adjustment event affecting one listed financial
 * instrument. Adjusted prices are calculated from DailyMarketData together with
 * the adjustment information stored in this table.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - ADR-026 Normalize Reference Data Model
 * - ADR-027 Canonical Market Data Model
 * - Domain Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : market
 *     - Schema : ref
 *
 * Referenced Objects
 *     - market.listing
 *     - market.corporate_action_item
 *     - ref.price_adjustment_status
 *     - ref.data_quality_status
 *     - ref.data_source
 *
 * Referenced By
 * -------------------------------------------------------------------------------------------------
 *     - Analytics Engine
 *     - Indicator Engine
 *     - Feature Engineering
 *     - Machine Learning Engine
 *     - Strategy Engine
 *     - Backtesting Engine
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical market adjustment table.
 * - Stores adjustment metadata only.
 * - Does not store adjusted prices.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.instrument_price_adjustment
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_price_adjustment_id      BIGINT
                                            GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                           UUID
                                            NOT NULL
                                            DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business References
    ----------------------------------------------------------------------------

    listing_id               BIGINT
                                            NOT NULL,

    corporate_action_item_id            BIGINT
                                            NOT NULL,

    price_adjustment_status_id          BIGINT
                                            NOT NULL,

    data_quality_status_id              BIGINT
                                            NOT NULL,

    data_source_id                      BIGINT
                                            NOT NULL,

    ----------------------------------------------------------------------------
    -- Adjustment Information
    ----------------------------------------------------------------------------

    adjustment_factor                   NUMERIC(20,10)
                                            NOT NULL,

    is_backward_adjustment              BOOLEAN
                                            NOT NULL
                                            DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    instrument_price_adjustment_is_active                           BOOLEAN
                                            NOT NULL
                                            DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                          TIMESTAMPTZ
                                            NOT NULL
                                            DEFAULT CURRENT_TIMESTAMP,

    created_by                          BIGINT
                                            NOT NULL,

    updated_at                          TIMESTAMPTZ,

    updated_by                          BIGINT,

    row_version                             INTEGER
                                            NOT NULL
                                            DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_price_adjustment
        PRIMARY KEY
        (
            instrument_price_adjustment_id
        ),

    CONSTRAINT uk_instrument_price_adjustment_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_instrument_price_adjustment_business
        UNIQUE
        (
            listing_id,
            corporate_action_item_id
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_instrument_price_adjustment_factor
        CHECK
        (
            adjustment_factor > 0
        ),

    CONSTRAINT ck_instrument_price_adjustment_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_instrument_price_adjustment_listing
        FOREIGN KEY
        (
            listing_id
        )
        REFERENCES market.listing
        (
            listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_price_adjustment_corporate_action_item
        FOREIGN KEY
        (
            corporate_action_item_id
        )
        REFERENCES market.corporate_action_item
        (
            corporate_action_item_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_price_adjustment_status
        FOREIGN KEY
        (
            price_adjustment_status_id
        )
        REFERENCES ref.price_adjustment_status
        (
            price_adjustment_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_price_adjustment_quality_status
        FOREIGN KEY
        (
            data_quality_status_id
        )
        REFERENCES ref.data_quality_status
        (
            data_quality_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_price_adjustment_data_source
        FOREIGN KEY
        (
            data_source_id
        )
        REFERENCES ref.data_source
        (
            data_source_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.instrument_price_adjustment
IS
'Stores the canonical price adjustment parameters for listed financial
instruments following corporate actions. Each record represents one adjustment
event affecting one listed instrument and provides the information required to
derive adjusted historical market prices without modifying the original market
data.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_price_adjustment.instrument_price_adjustment_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.instrument_price_adjustment.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Business References
----------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_price_adjustment.listing_id
IS
'Reference to the listed financial instrument affected by the price adjustment.';

COMMENT ON COLUMN market.instrument_price_adjustment.corporate_action_item_id
IS
'Reference to the corporate action item that caused the price adjustment.';

COMMENT ON COLUMN market.instrument_price_adjustment.price_adjustment_status_id
IS
'Reference to the current processing status of the price adjustment.';

COMMENT ON COLUMN market.instrument_price_adjustment.data_quality_status_id
IS
'Reference to the quality assessment status of the adjustment data.';

COMMENT ON COLUMN market.instrument_price_adjustment.data_source_id
IS
'Reference to the source from which the adjustment information was obtained.';

----------------------------------------------------------------------------
-- Adjustment Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_price_adjustment.adjustment_factor
IS
'Multiplicative adjustment factor applied when deriving adjusted historical prices.';

COMMENT ON COLUMN market.instrument_price_adjustment.is_backward_adjustment
IS
'Indicates whether the adjustment is applied backward to historical prices or forward to subsequent prices.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_price_adjustment.instrument_price_adjustment_is_active
IS
'Indicates whether the adjustment record is active and available for business operations within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_price_adjustment.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.instrument_price_adjustment.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.instrument_price_adjustment.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.instrument_price_adjustment.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.instrument_price_adjustment.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------