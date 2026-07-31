/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Tick_Data.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TickData
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TickData fact table.
 *
 * The TickData table stores executed trade events captured from supported
 * financial markets. Each record represents one completed market execution and
 * serves as the canonical source for intraday analytics, bar generation,
 * strategy evaluation, market replay, and machine learning.
 *
 * Quote updates, bid/ask changes, and order book events are intentionally
 * excluded from this table and are stored in OrderBookSnapshot.
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
 * - Stores only executed trades.
 * - Quote and order book events are stored separately.
 * - Optimized for high-volume append-only workloads.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.tick_data
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    tick_data_id                    BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    listing_id           BIGINT
                                        NOT NULL,

    trading_session_id              BIGINT
                                        NOT NULL,

    market_status_id                BIGINT
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
    -- Time Information
    ----------------------------------------------------------------------------

    trading_date                    DATE
                                        NOT NULL,

    tick_timestamp                  TIMESTAMPTZ
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Trade Information
    ----------------------------------------------------------------------------

    execution_id                    BIGINT,

    execution_sequence              BIGINT,

    ----------------------------------------------------------------------------
    -- Price Metrics
    ----------------------------------------------------------------------------

    execution_price                 NUMERIC(20,8)
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Volume Metrics
    ----------------------------------------------------------------------------

    execution_quantity              NUMERIC(24,4)
                                        NOT NULL,

    execution_value                 NUMERIC(24,4),

    ----------------------------------------------------------------------------
    -- Trade Metadata
    ----------------------------------------------------------------------------

    source_reference                VARCHAR(500),

    tick_data_description                     VARCHAR(500),

        ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    tick_data_is_active                        BOOLEAN
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

    row_version                          INTEGER
                                          NOT NULL
                                          DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_tick_data
        PRIMARY KEY
        (
            tick_data_id
        ),

    CONSTRAINT uk_tick_data_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_tick_data_business
        UNIQUE
        (
            listing_id,
            tick_timestamp,
            execution_sequence,
            price_adjustment_status_id
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_tick_data_trading_date
        CHECK
        (
            trading_date >= DATE '1900-01-01'
        ),

    CONSTRAINT ck_tick_data_timestamp
        CHECK
        (
            tick_timestamp >= TIMESTAMPTZ '1900-01-01 00:00:00+00'
        ),

    CONSTRAINT ck_tick_data_execution_price
        CHECK
        (
            execution_price > 0
        ),

    CONSTRAINT ck_tick_data_execution_quantity
        CHECK
        (
            execution_quantity > 0
        ),

    CONSTRAINT ck_tick_data_execution_value
        CHECK
        (
            execution_value IS NULL
            OR execution_value >= 0
        ),

    CONSTRAINT ck_tick_data_execution_sequence
        CHECK
        (
            execution_sequence IS NULL
            OR execution_sequence >= 0
        ),

    CONSTRAINT ck_tick_data_execution_id
        CHECK
        (
            execution_id IS NULL
            OR execution_id >= 0
        ),

    CONSTRAINT ck_tick_data_source_reference
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_tick_data_description
        CHECK
        (
            tick_data_description IS NULL
            OR LENGTH(TRIM(tick_data_description)) > 0
        ),

    CONSTRAINT ck_tick_data_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_tick_data_listing
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

    CONSTRAINT fk_tick_data_trading_session
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

    CONSTRAINT fk_tick_data_market_status
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

    CONSTRAINT fk_tick_data_calendar_type
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

    CONSTRAINT fk_tick_data_time_zone
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

    CONSTRAINT fk_tick_data_data_source
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

    CONSTRAINT fk_tick_data_price_adjustment_status
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

    CONSTRAINT fk_tick_data_data_quality_status
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

COMMENT ON TABLE market.tick_data
IS
'Stores the canonical executed trade events captured from supported financial
markets. Each record represents one completed trade execution and serves as
the authoritative source for intraday analytics, bar generation, market replay,
backtesting, quantitative research, and machine learning. Quote updates,
bid/ask changes, and order book events are intentionally excluded from this
table and are maintained in the OrderBookSnapshot table.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.tick_data_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.tick_data.public_id
IS
'Immutable public identifier used for external integrations, synchronization, APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Classification References
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.listing_id
IS
'Reference to the listed financial instrument associated with the executed trade.';

COMMENT ON COLUMN market.tick_data.trading_session_id
IS
'Reference to the trading session during which the execution occurred.';

COMMENT ON COLUMN market.tick_data.market_status_id
IS
'Reference to the market status at the time of execution.';

COMMENT ON COLUMN market.tick_data.calendar_type_id
IS
'Reference to the calendar system used for the trading date.';

COMMENT ON COLUMN market.tick_data.time_zone_id
IS
'Reference to the time zone associated with the execution timestamp.';

COMMENT ON COLUMN market.tick_data.data_source_id
IS
'Reference to the data source that supplied the execution event.';

COMMENT ON COLUMN market.tick_data.price_adjustment_status_id
IS
'Reference to the price adjustment status associated with this execution record.';

COMMENT ON COLUMN market.tick_data.data_quality_status_id
IS
'Reference to the validated data quality status assigned to this execution record.';

----------------------------------------------------------------------------
-- Time Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.trading_date
IS
'Official trading date associated with the execution event.';

COMMENT ON COLUMN market.tick_data.tick_timestamp
IS
'Precise timestamp at which the trade execution occurred.';

----------------------------------------------------------------------------
-- Trade Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.execution_id
IS
'Optional execution identifier supplied by the originating market or data provider.';

COMMENT ON COLUMN market.tick_data.execution_sequence
IS
'Optional execution sequence number defining the order of executions within the trading session.';

----------------------------------------------------------------------------
-- Price Metrics
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.execution_price
IS
'Price at which the trade execution occurred.';

----------------------------------------------------------------------------
-- Volume Metrics
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.execution_quantity
IS
'Quantity executed in the completed trade.';

COMMENT ON COLUMN market.tick_data.execution_value
IS
'Total monetary value of the executed trade.';

----------------------------------------------------------------------------
-- Traceability
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.source_reference
IS
'Optional external identifier, file name, API transaction identifier, or message identifier associated with the imported execution record.';

COMMENT ON COLUMN market.tick_data.tick_data_description
IS
'Optional business description providing additional information about the execution record.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.tick_data_is_active
IS
'Indicates whether the record is active and available for business operations within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.tick_data.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.tick_data.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.tick_data.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.tick_data.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.tick_data.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------