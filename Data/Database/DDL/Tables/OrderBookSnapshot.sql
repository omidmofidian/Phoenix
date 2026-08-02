/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : order_book_snapshot.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : OrderBookSnapshot
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical OrderBookSnapshot fact table.
 *
 * The OrderBookSnapshot table stores the header information for an order book
 * snapshot captured from a supported financial market.
 *
 * Each record represents one snapshot captured at a specific point in time.
 * The individual bid and ask levels are stored separately in the
 * market.order_book_level table.
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
 *     - ref.data_quality_status
 *     - ref.market_snapshot_type
 *
 * Referenced By
 * -------------------------------------------------------------------------------------------------
 *     - market.order_book_level
 *     - Analytics Engine
 *     - Feature Engineering
 *     - Machine Learning Engine
 *     - Strategy Engine
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical fact table.
 * - Header table for OrderBookLevel.
 * - Stores no bid/ask price or quantity information.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.order_book_snapshot
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    order_book_snapshot_id          BIGINT
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

    data_quality_status_id          BIGINT
                                        NOT NULL,

    market_snapshot_type_id                BIGINT
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Time Information
    ----------------------------------------------------------------------------

    trading_date                    DATE
                                        NOT NULL,

    snapshot_timestamp              TIMESTAMPTZ
                                        NOT NULL,

    ----------------------------------------------------------------------------
    -- Snapshot Information
    ----------------------------------------------------------------------------

    snapshot_sequence               BIGINT,

    source_record_identifier        VARCHAR(200),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    order_book_snapshot_is_active                       BOOLEAN
                                        NOT NULL
                                        DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                      TIMESTAMPTZ
                                        NOT NULL
                                        DEFAULT CURRENT_TIMESTAMP,

    created_by                      BIGINT
                                        NOT NULL,

    updated_at                      TIMESTAMPTZ,

    updated_by                      BIGINT,

    row_version                         INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_order_book_snapshot
        PRIMARY KEY
        (
            order_book_snapshot_id
        ),

    CONSTRAINT uk_order_book_snapshot_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_order_book_snapshot_business
        UNIQUE
        (
            listing_id,
            snapshot_timestamp,
            data_source_id
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_order_book_snapshot_trading_date
        CHECK 
        (
            trading_date >= DATE '1900-01-01'
        ),

    CONSTRAINT ck_order_book_snapshot_timestamp
        CHECK
        (
            snapshot_timestamp >= TIMESTAMPTZ '1900-01-01 00:00:00+00'
        ),

    CONSTRAINT ck_order_book_snapshot_sequence
        CHECK
        (
            snapshot_sequence IS NULL
            OR snapshot_sequence >= 0
        ),

    CONSTRAINT ck_order_book_snapshot_source_record_identifier
        CHECK
        (
            source_record_identifier IS NULL
            OR LENGTH(TRIM(source_record_identifier)) > 0
        ),

    CONSTRAINT ck_order_book_snapshot_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_order_book_snapshot_listing
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

    CONSTRAINT fk_order_book_snapshot_trading_session
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

    CONSTRAINT fk_order_book_snapshot_market_status
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

    CONSTRAINT fk_order_book_snapshot_calendar_type
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

    CONSTRAINT fk_order_book_snapshot_time_zone
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

    CONSTRAINT fk_order_book_snapshot_data_source
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

    CONSTRAINT fk_order_book_snapshot_market_snapshot_type
        FOREIGN KEY
        (
            market_snapshot_type_id
        )
        REFERENCES ref.market_snapshot_type
        (
            market_snapshot_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_order_book_snapshot_data_quality_status
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

COMMENT ON TABLE market.order_book_snapshot
IS
'Stores the canonical header information for order book snapshots captured from
supported financial markets. Each record represents one snapshot captured at a
specific point in time for one listed financial instrument. Individual bid and
ask levels are stored separately in the market.order_book_level table. This
table serves as the authoritative source for market depth analysis, liquidity
analysis, replay, quantitative research, and machine learning.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.order_book_snapshot_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.order_book_snapshot.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Classification References
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.listing_id
IS
'Reference to the listed financial instrument associated with the captured order book snapshot.';

COMMENT ON COLUMN market.order_book_snapshot.trading_session_id
IS
'Reference to the trading session during which the snapshot was captured.';

COMMENT ON COLUMN market.order_book_snapshot.market_status_id
IS
'Reference to the market status applicable when the snapshot was captured.';

COMMENT ON COLUMN market.order_book_snapshot.calendar_type_id
IS
'Reference to the calendar system used for the trading date.';

COMMENT ON COLUMN market.order_book_snapshot.time_zone_id
IS
'Reference to the time zone associated with the snapshot timestamp.';

COMMENT ON COLUMN market.order_book_snapshot.data_source_id
IS
'Reference to the data source from which the snapshot originated.';

COMMENT ON COLUMN market.order_book_snapshot.market_snapshot_type_id
IS
'Reference to the market snapshot type defining how the order book snapshot was generated.';

COMMENT ON COLUMN market.order_book_snapshot.data_quality_status_id
IS
'Reference to the validated data quality status assigned to the snapshot.';

----------------------------------------------------------------------------
-- Time Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.trading_date
IS
'Official trading date associated with the captured snapshot.';

COMMENT ON COLUMN market.order_book_snapshot.snapshot_timestamp
IS
'Precise timestamp at which the order book snapshot was captured.';

----------------------------------------------------------------------------
-- Snapshot Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.snapshot_sequence
IS
'Optional sequence number defining the relative ordering of snapshots captured during the trading session.';

COMMENT ON COLUMN market.order_book_snapshot.source_record_identifier
IS
'Optional external identifier supplied by the originating exchange, broker, vendor, API, message stream, or imported data file.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.order_book_snapshot_is_active
IS
'Indicates whether the snapshot record is active and available for business operations within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_snapshot.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.order_book_snapshot.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.order_book_snapshot.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.order_book_snapshot.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.order_book_snapshot.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------