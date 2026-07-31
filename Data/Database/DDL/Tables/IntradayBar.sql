/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Intraday_Bar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : IntradayBar
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical IntradayBar fact table.
 *
 * The IntradayBar table stores aggregated intraday OHLCV bars generated from
 * executed trade events. Each record represents one completed aggregation
 * period for one listed financial instrument and serves as the canonical source
 * for technical indicators, quantitative analysis, strategy evaluation,
 * backtesting, reporting, and machine learning.
 *
 * Tick-level trade events are stored separately in market.tick_data.
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
 *     - ref.time_frame
 *     - ref.trading_session
 *     - ref.market_status
 *     - ref.calendar_type
 *     - ref.time_zone
 *     - ref.data_source
 *     - ref.price_adjustment_status
 *     - ref.data_quality_status
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical fact table.
 * - Aggregated from TickData.
 * - One record represents one completed bar.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.intraday_bar
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    intraday_bar_id               BIGINT
                                      GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                     UUID
                                      NOT NULL
                                      DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    listing_id         BIGINT
                                      NOT NULL,

    time_frame_id                 BIGINT
                                      NOT NULL,

    trading_session_id            BIGINT
                                      NOT NULL,

    market_status_id              BIGINT
                                      NOT NULL,

    calendar_type_id              BIGINT
                                      NOT NULL,

    time_zone_id                  BIGINT
                                      NOT NULL,

    data_source_id                BIGINT
                                      NOT NULL,

    price_adjustment_status_id    BIGINT
                                      NOT NULL,

    data_quality_status_id        BIGINT
                                      NOT NULL,

    ----------------------------------------------------------------------------
    -- Time Information
    ----------------------------------------------------------------------------

    trading_date                  DATE
                                      NOT NULL,

    bar_start_timestamp           TIMESTAMPTZ
                                      NOT NULL,

    bar_end_timestamp             TIMESTAMPTZ
                                      NOT NULL,

    ----------------------------------------------------------------------------
    -- OHLC Metrics
    ----------------------------------------------------------------------------

    open_price                    NUMERIC(20,8)
                                      NOT NULL,

    high_price                    NUMERIC(20,8)
                                      NOT NULL,

    low_price                     NUMERIC(20,8)
                                      NOT NULL,

    close_price                   NUMERIC(20,8)
                                      NOT NULL,

    ----------------------------------------------------------------------------
    -- Volume Metrics
    ----------------------------------------------------------------------------

    trade_volume                  NUMERIC(24,4)
                                      NOT NULL,

    trade_value                   NUMERIC(24,4),

    ----------------------------------------------------------------------------
    -- Trade Statistics
    ----------------------------------------------------------------------------

    trade_count                   INTEGER
                                      NOT NULL,

    ----------------------------------------------------------------------------
    -- Traceability
    ----------------------------------------------------------------------------

    source_reference              VARCHAR(500),

    intraday_bar_description                   VARCHAR(500),

        ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    intraday_bar_is_active                     BOOLEAN
                                      NOT NULL
                                      DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                    TIMESTAMPTZ
                                      NOT NULL
                                      DEFAULT CURRENT_TIMESTAMP,

    created_by                    BIGINT
                                      NOT NULL,

    updated_at                    TIMESTAMPTZ,

    updated_by                    BIGINT,

    row_version                       INTEGER
                                      NOT NULL
                                      DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_intraday_bar
        PRIMARY KEY
        (
            intraday_bar_id
        ),

    CONSTRAINT uk_intraday_bar_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_intraday_bar_business
        UNIQUE
        (
            listing_id,
            time_frame_id,
            bar_start_timestamp,
            price_adjustment_status_id
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_intraday_bar_time_range
        CHECK
        (
            bar_start_timestamp
            <
            bar_end_timestamp
        ),

    CONSTRAINT ck_intraday_bar_prices
        CHECK
        (
            open_price  > 0
            AND
            high_price  > 0
            AND
            low_price   > 0
            AND
            close_price > 0
            AND
            high_price >= low_price
            AND
            high_price >= open_price
            AND
            high_price >= close_price
            AND
            low_price <= open_price
            AND
            low_price <= close_price
        ),

    CONSTRAINT ck_intraday_bar_trade_volume
        CHECK
        (
            trade_volume >= 0
        ),

    CONSTRAINT ck_intraday_bar_trade_value
        CHECK
        (
            trade_value IS NULL
            OR trade_value >= 0
        ),

    CONSTRAINT ck_intraday_bar_trade_count
        CHECK
        (
            trade_count >= 0
        ),

    CONSTRAINT ck_intraday_bar_source_reference
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_intraday_bar_description
        CHECK
        (
            intraday_bar_description IS NULL
            OR LENGTH(TRIM(intraday_bar_description)) > 0
        ),

    CONSTRAINT ck_intraday_bar_version
        CHECK
        (
            row_version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_intraday_bar_instrument_listing
        FOREIGN KEY (listing_id)
        REFERENCES market.listing (listing_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_time_frame
        FOREIGN KEY (time_frame_id)
        REFERENCES ref.time_frame (time_frame_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_trading_session
        FOREIGN KEY (trading_session_id)
        REFERENCES ref.trading_session (trading_session_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_market_status
        FOREIGN KEY (market_status_id)
        REFERENCES ref.market_status (market_status_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_calendar_type
        FOREIGN KEY (calendar_type_id)
        REFERENCES ref.calendar_type (calendar_type_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_time_zone
        FOREIGN KEY (time_zone_id)
        REFERENCES ref.time_zone (time_zone_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_data_source
        FOREIGN KEY (data_source_id)
        REFERENCES ref.data_source (data_source_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_price_adjustment_status
        FOREIGN KEY (price_adjustment_status_id)
        REFERENCES ref.price_adjustment_status (price_adjustment_status_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_intraday_bar_data_quality_status
        FOREIGN KEY (data_quality_status_id)
        REFERENCES ref.data_quality_status (data_quality_status_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.intraday_bar
IS
'Stores the canonical aggregated intraday OHLCV bars generated from executed
trade events. Each record represents one completed aggregation period for one
listed financial instrument and serves as the authoritative source for
technical analysis, quantitative research, strategy evaluation, backtesting,
market analytics, reporting, and machine learning. Tick-level trade events are
stored separately in market.tick_data.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.intraday_bar_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.intraday_bar.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Classification References
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.listing_id
IS
'Reference to the listed financial instrument represented by this intraday bar.';

COMMENT ON COLUMN market.intraday_bar.time_frame_id
IS
'Reference to the aggregation interval used to generate the intraday bar.';

COMMENT ON COLUMN market.intraday_bar.trading_session_id
IS
'Reference to the trading session during which the bar was formed.';

COMMENT ON COLUMN market.intraday_bar.market_status_id
IS
'Reference to the market status applicable during the aggregation period.';

COMMENT ON COLUMN market.intraday_bar.calendar_type_id
IS
'Reference to the calendar system used for the trading date.';

COMMENT ON COLUMN market.intraday_bar.time_zone_id
IS
'Reference to the time zone associated with the aggregation timestamps.';

COMMENT ON COLUMN market.intraday_bar.data_source_id
IS
'Reference to the data source from which the aggregated market data originated.';

COMMENT ON COLUMN market.intraday_bar.price_adjustment_status_id
IS
'Reference to the price adjustment status applied to the bar values.';

COMMENT ON COLUMN market.intraday_bar.data_quality_status_id
IS
'Reference to the validated data quality status assigned to the bar.';

----------------------------------------------------------------------------
-- Time Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.trading_date
IS
'Official exchange trading date assigned by the trading calendar, 
which may differ from the calendar date derived from bar_start_timestamp in markets 
with overnight or cross-midnight sessions.';

COMMENT ON COLUMN market.intraday_bar.bar_start_timestamp
IS
'Timestamp indicating the inclusive start of the aggregation period.';

COMMENT ON COLUMN market.intraday_bar.bar_end_timestamp
IS
'Timestamp indicating the exclusive end of the aggregation period.';

----------------------------------------------------------------------------
-- OHLC Metrics
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.open_price
IS
'First executed trade price within the aggregation period.';

COMMENT ON COLUMN market.intraday_bar.high_price
IS
'Highest executed trade price within the aggregation period.';

COMMENT ON COLUMN market.intraday_bar.low_price
IS
'Lowest executed trade price within the aggregation period.';

COMMENT ON COLUMN market.intraday_bar.close_price
IS
'Last executed trade price within the aggregation period.';

----------------------------------------------------------------------------
-- Volume Metrics
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.trade_volume
IS
'Total executed trading volume aggregated during the period.';

COMMENT ON COLUMN market.intraday_bar.trade_value
IS
'Total monetary value of all executed trades aggregated during the period.';

----------------------------------------------------------------------------
-- Trade Statistics
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.trade_count
IS
'Total number of executed trades aggregated during the period.';

----------------------------------------------------------------------------
-- Traceability
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.source_reference
IS
'Optional external identifier, file name, API transaction identifier, batch identifier, or message identifier associated with the source data used to generate the bar.';

COMMENT ON COLUMN market.intraday_bar.intraday_bar_description
IS
'Optional business description providing additional information about the aggregated bar.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.intraday_bar_is_active
IS
'Indicates whether the record is active and available for business operations within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.intraday_bar.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.intraday_bar.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.intraday_bar.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.intraday_bar.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.intraday_bar.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------