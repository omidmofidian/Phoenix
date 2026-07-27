/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : DailyMarketData.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : DailyMarketData
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical DailyMarketData fact table.
 *
 * The DailyMarketData table stores the official end-of-day (EOD) market facts
 * for listed financial instruments supported by the Phoenix Platform.
 *
 * Each record represents one trading day for one instrument listing and serves
 * as the authoritative source for technical analysis, screening, portfolio
 * valuation, quantitative research, backtesting, reporting, and machine
 * learning workloads.
 *
 * This table stores only observable market facts.
 * Business metadata, reference classifications, listing information, corporate
 * actions, and lifecycle events are maintained in their dedicated tables.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - ADR-022 Repository Architecture
 * - ADR-026 Normalize Reference Data Model
 * - ADR-027 Canonical Market Data Model
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
 *     - Schema : market
 *     - Schema : ref
 *
 * Referenced Objects
 *     - market.instrument_listing
 *     - ref.trading_session
 *     - ref.market_status
 *     - ref.calendar_type
 *     - ref.time_zone
 *     - ref.data_source
 *     - ref.price_adjustment_status
 *     - ref.data_quality_status
 *
 * Referenced By
 *     - Indicator Engine
 *     - Strategy Engine
 *     - Analytics Engine
 *     - Backtesting Engine
 *     - Reporting Engine
 *     - Machine Learning Engine
 *     - Portfolio Engine
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
 * - Canonical Fact Table.
 * - One record represents one Instrument Listing, one Trading Session,
 *   one Trading Date and one Price Adjustment Status.
 * - Designed for PostgreSQL 17.
 * - Optimized for analytical workloads.
 * - Designed for table partitioning.
 * - Append-only business model.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-27
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   -------------------------------------------------------
 * 2026.1    2026-07-27   Canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.daily_market_data
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    daily_market_data_id             BIGINT
                                         GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                        UUID
                                         NOT NULL
                                         DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    instrument_listing_id            BIGINT
                                         NOT NULL,

    trading_session_id               BIGINT
                                         NOT NULL,

    market_status_id                 BIGINT
                                         NOT NULL,

    calendar_type_id                BIGINT
                                         NOT NULL,

    time_zone_id                    BIGINT
                                         NOT NULL,

    data_source_id                  BIGINT
                                         NOT NULL,

    price_adjustment_status_id      BIGINT
                                         NOT NULL,

    data_quality_status_id          BIGINT
                                         NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    trading_date                    DATE
                                         NOT NULL,

    open_price                      NUMERIC(20,8)
                                         NOT NULL,

    high_price                      NUMERIC(20,8)
                                         NOT NULL,

    low_price                       NUMERIC(20,8)
                                         NOT NULL,

    last_price                      NUMERIC(20,8)
                                         NOT NULL,

    closing_price                   NUMERIC(20,8)
                                         NOT NULL,

    previous_close_price            NUMERIC(20,8),

    average_price                   NUMERIC(20,8),

    vwap_price                      NUMERIC(20,8),

    price_change                    NUMERIC(20,8),

    price_change_percent            NUMERIC(10,4),

    trade_count                     BIGINT,

    trade_volume                    NUMERIC(24,4),

    trade_value                     NUMERIC(24,4),

    buy_trade_count                 BIGINT,

    buy_volume                      NUMERIC(24,4),

    buy_value                       NUMERIC(24,4),

    sell_trade_count                BIGINT,

    sell_volume                     NUMERIC(24,4),

    sell_value                      NUMERIC(24,4),

    base_volume                     NUMERIC(24,4),

    market_cap                      NUMERIC(30,4),

    adjustment_factor               NUMERIC(20,10)
                                         NOT NULL
                                         DEFAULT 1.0000000000,

    source_reference                VARCHAR(500),

    description                     VARCHAR(500),

        ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                        BOOLEAN
                                          NOT NULL
                                          DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                       TIMESTAMPTZ
                                          NOT NULL
                                          DEFAULT CURRENT_TIMESTAMP,

    created_by                       BIGINT
                                          NOT NULL,

    updated_at                       TIMESTAMPTZ,

    updated_by                       BIGINT,

    version                          INTEGER
                                          NOT NULL
                                          DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_daily_market_data
        PRIMARY KEY
        (
            daily_market_data_id
        ),

    CONSTRAINT uq_daily_market_data_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_daily_market_data_business
        UNIQUE
        (
            instrument_listing_id,
            trading_session_id,
            trading_date,
            price_adjustment_status_id
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_daily_market_data_price_range
        CHECK
        (
            high_price >= low_price
        ),

    CONSTRAINT ck_daily_market_data_open_price_range
        CHECK
        (
            open_price BETWEEN low_price AND high_price
        ),

    CONSTRAINT ck_daily_market_data_last_price_range
        CHECK
        (
            last_price BETWEEN low_price AND high_price
        ),

    CONSTRAINT ck_daily_market_data_closing_price_range
        CHECK
        (
            closing_price BETWEEN low_price AND high_price
        ),

    CONSTRAINT ck_daily_market_data_adjustment_factor
        CHECK
        (
            adjustment_factor > 0
        ),

    CONSTRAINT ck_daily_market_data_trade_count
        CHECK
        (
            trade_count IS NULL
            OR trade_count >= 0
        ),

    CONSTRAINT ck_daily_market_data_trade_volume
        CHECK
        (
            trade_volume IS NULL
            OR trade_volume >= 0
        ),

    CONSTRAINT ck_daily_market_data_trade_value
        CHECK
        (
            trade_value IS NULL
            OR trade_value >= 0
        ),

    CONSTRAINT ck_daily_market_data_buy_trade_count
        CHECK
        (
            buy_trade_count IS NULL
            OR buy_trade_count >= 0
        ),

    CONSTRAINT ck_daily_market_data_buy_volume
        CHECK
        (
            buy_volume IS NULL
            OR buy_volume >= 0
        ),

    CONSTRAINT ck_daily_market_data_buy_value
        CHECK
        (
            buy_value IS NULL
            OR buy_value >= 0
        ),

    CONSTRAINT ck_daily_market_data_sell_trade_count
        CHECK
        (
            sell_trade_count IS NULL
            OR sell_trade_count >= 0
        ),

    CONSTRAINT ck_daily_market_data_sell_volume
        CHECK
        (
            sell_volume IS NULL
            OR sell_volume >= 0
        ),

    CONSTRAINT ck_daily_market_data_sell_value
        CHECK
        (
            sell_value IS NULL
            OR sell_value >= 0
        ),

    CONSTRAINT ck_daily_market_data_base_volume
        CHECK
        (
            base_volume IS NULL
            OR base_volume >= 0
        ),

    CONSTRAINT ck_daily_market_data_market_cap
        CHECK
        (
            market_cap IS NULL
            OR market_cap >= 0
        ),

    CONSTRAINT ck_daily_market_data_price_change_percent
        CHECK
        (
            price_change_percent IS NULL
            OR price_change_percent BETWEEN -100.0000 AND 100000.0000
        ),

    CONSTRAINT ck_daily_market_data_source_reference
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_daily_market_data_description
        CHECK
        (
            description IS NULL
            OR LENGTH(TRIM(description)) > 0
        ),

    CONSTRAINT ck_daily_market_data_version
        CHECK
        (
            version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_daily_market_data_instrument_listing
        FOREIGN KEY
        (
            instrument_listing_id
        )
        REFERENCES market.instrument_listing
        (
            instrument_listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_trading_session
        FOREIGN KEY
        (
            trading_session_id
        )
        REFERENCES ref.trading_session
        (
            trading_session_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_market_status
        FOREIGN KEY
        (
            market_status_id
        )
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_calendar_type
        FOREIGN KEY
        (
            calendar_type_id
        )
        REFERENCES ref.calendar_type
        (
            calendar_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_time_zone
        FOREIGN KEY
        (
            time_zone_id
        )
        REFERENCES ref.time_zone
        (
            time_zone_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_data_source
        FOREIGN KEY
        (
            data_source_id
        )
        REFERENCES ref.data_source
        (
            data_source_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_daily_market_data_price_adjustment_status
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

    CONSTRAINT fk_daily_market_data_data_quality_status
        FOREIGN KEY
        (
            data_quality_status_id
        )
        REFERENCES ref.data_quality_status
        (
            data_quality_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.daily_market_data
IS
'Stores the canonical daily end-of-day (EOD) market facts for listed financial
instruments within the Phoenix Platform. Each record represents one trading
session for one instrument listing on one trading date and serves as the
authoritative source for analytics, technical analysis, screening,
backtesting, reporting, portfolio valuation, and machine learning. The table
contains only observable market facts and excludes business metadata,
reference data, master data, and business events.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.daily_market_data.daily_market_data_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.daily_market_data.public_id
IS
'Immutable public identifier used for external integrations, synchronization, APIs, and distributed systems.';

--------------------------------------------------------------------------------
-- Classification References
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.daily_market_data.instrument_listing_id
IS
'Reference to the listed financial instrument for which the daily market data was recorded.';

COMMENT ON COLUMN market.daily_market_data.trading_session_id
IS
'Reference to the trading session during which the market data was collected.';

COMMENT ON COLUMN market.daily_market_data.market_status_id
IS
'Reference to the market status applicable to the instrument during the trading session.';

COMMENT ON COLUMN market.daily_market_data.calendar_type_id
IS
'Reference to the calendar system used to interpret the trading date.';

COMMENT ON COLUMN market.daily_market_data.time_zone_id
IS
'Reference to the time zone associated with the trading session.';

COMMENT ON COLUMN market.daily_market_data.data_source_id
IS
'Reference to the external or internal data source from which the market data was obtained.';

COMMENT ON COLUMN market.daily_market_data.price_adjustment_status_id
IS
'Reference to the price adjustment status indicating whether prices are raw, adjusted, partially adjusted, or derived.';

COMMENT ON COLUMN market.daily_market_data.data_quality_status_id
IS
'Reference to the data quality assessment assigned after validation and quality control processes.';

--------------------------------------------------------------------------------
-- Business Attributes
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.daily_market_data.trading_date
IS
'Official trading date associated with the market observations.';

COMMENT ON COLUMN market.daily_market_data.open_price
IS
'Official opening price of the financial instrument for the trading session.';

COMMENT ON COLUMN market.daily_market_data.high_price
IS
'Highest traded price recorded during the trading session.';

COMMENT ON COLUMN market.daily_market_data.low_price
IS
'Lowest traded price recorded during the trading session.';

COMMENT ON COLUMN market.daily_market_data.last_price
IS
'Price of the last executed trade during the trading session.';

COMMENT ON COLUMN market.daily_market_data.closing_price
IS
'Official closing price published by the exchange at the end of the trading session.';

COMMENT ON COLUMN market.daily_market_data.previous_close_price
IS
'Official closing price from the previous trading session.';

COMMENT ON COLUMN market.daily_market_data.average_price
IS
'Arithmetic average trading price calculated for the trading session.';

COMMENT ON COLUMN market.daily_market_data.vwap_price
IS
'Volume Weighted Average Price (VWAP) calculated from all executed trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.price_change
IS
'Absolute price difference between the current closing price and the previous closing price.';

COMMENT ON COLUMN market.daily_market_data.price_change_percent
IS
'Percentage price change between the current closing price and the previous closing price.';

COMMENT ON COLUMN market.daily_market_data.trade_count
IS
'Total number of executed trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.trade_volume
IS
'Total quantity traded during the trading session.';

COMMENT ON COLUMN market.daily_market_data.trade_value
IS
'Total monetary value of all executed trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.buy_trade_count
IS
'Total number of executed buy-side trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.buy_volume
IS
'Total quantity purchased during the trading session.';

COMMENT ON COLUMN market.daily_market_data.buy_value
IS
'Total monetary value of executed buy-side trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.sell_trade_count
IS
'Total number of executed sell-side trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.sell_volume
IS
'Total quantity sold during the trading session.';

COMMENT ON COLUMN market.daily_market_data.sell_value
IS
'Total monetary value of executed sell-side trades during the trading session.';

COMMENT ON COLUMN market.daily_market_data.base_volume
IS
'Exchange-defined base trading volume used for regulatory calculations and market-specific rules.';

COMMENT ON COLUMN market.daily_market_data.market_cap
IS
'Calculated market capitalization of the listed financial instrument on the trading date.';

COMMENT ON COLUMN market.daily_market_data.adjustment_factor
IS
'Multiplication factor used by the adjustment engine when calculating adjusted historical prices.';

COMMENT ON COLUMN market.daily_market_data.source_reference
IS
'External reference, source identifier, file name, message identifier, or API transaction identifier associated with the imported market data.';

COMMENT ON COLUMN market.daily_market_data.description
IS
'Optional business description providing additional information about the daily market data record.';

--------------------------------------------------------------------------------
-- Business Status
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.daily_market_data.is_active
IS
'Indicates whether the record is active and available for business operations within the Phoenix Platform.';

--------------------------------------------------------------------------------
-- Audit Columns
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.daily_market_data.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.daily_market_data.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.daily_market_data.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.daily_market_data.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.daily_market_data.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------

