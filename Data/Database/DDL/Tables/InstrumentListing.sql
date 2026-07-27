/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : InstrumentListing.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentListing
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical InstrumentListing table.
 *
 * The InstrumentListing table represents the listing lifecycle of financial
 * instruments within supported exchanges, markets, and trading boards.
 * Each record identifies where and when an instrument is listed, becomes
 * effective for trading, changes its listing status, or is delisted.
 *
 * This table preserves the complete listing history of every financial
 * instrument and enables the Phoenix Platform to support multiple exchanges,
 * multiple markets, and historical listing changes.
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
 *     - Schema : market
 *     - Schema : ref
 *     - Table  : market.instrument
 *     - Table  : ref.exchange
 *     - Table  : ref.market
 *     - Table  : ref.board
 *     - Table  : ref.market_status
 *
 * Referenced Objects
 *     - market.instrument
 *     - ref.exchange
 *     - ref.market
 *     - ref.board
 *     - ref.market_status
 *
 * Referenced By
 *     - market.instrument_suspension
 *     - market.instrument_status_history
 *     - market.trading_halt
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
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.instrument_listing
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_listing_id         BIGINT
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

    instrument_id                 BIGINT
                                      NOT NULL,

    exchange_id                   BIGINT
                                      NOT NULL,

    market_id                     BIGINT
                                      NOT NULL,

    board_id                      BIGINT
                                      NOT NULL,

    market_status_id              BIGINT
                                      NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    listing_code                  VARCHAR(50)
                                      NOT NULL,

    listing_date                  DATE
                                      NOT NULL,

    effective_date                DATE
                                      NOT NULL,

    delisting_date                DATE,

    listing_reference             VARCHAR(200),

    published_at                  TIMESTAMPTZ,

    source_reference              VARCHAR(500),

    listing_reason                VARCHAR(500),

    delisting_reason              VARCHAR(500),

    description                   VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                     BOOLEAN
                                      NOT NULL
                                      DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                    TIMESTAMPTZ
                                      NOT NULL
                                      DEFAULT CURRENT_TIMESTAMP,

    updated_at                    TIMESTAMPTZ,

    created_by                    BIGINT
                                      NOT NULL,

    updated_by                    BIGINT,

    version                       INTEGER
                                      NOT NULL
                                      DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_listing
        PRIMARY KEY
        (
            instrument_listing_id
        ),

    CONSTRAINT uq_instrument_listing_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_instrument_listing_code
        UNIQUE
        (
            listing_code
        ),

    CONSTRAINT ck_instrument_listing_code_not_empty
        CHECK
        (
            LENGTH(TRIM(listing_code)) > 0
        ),

    CONSTRAINT ck_instrument_listing_source_reference_not_empty
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_instrument_listing_listing_reason_not_empty
        CHECK
        (
            listing_reason IS NULL
            OR LENGTH(TRIM(listing_reason)) > 0
        ),

    CONSTRAINT ck_instrument_listing_delisting_reason_not_empty
        CHECK
        (
            delisting_reason IS NULL
            OR LENGTH(TRIM(delisting_reason)) > 0
        ),

    CONSTRAINT ck_instrument_listing_version_positive
        CHECK
        (
            version > 0
        ),

    CONSTRAINT ck_instrument_listing_dates
        CHECK
        (
            delisting_date IS NULL
            OR delisting_date >= effective_date
        ),

    CONSTRAINT fk_instrument_listing_instrument
        FOREIGN KEY
        (
            instrument_id
        )
        REFERENCES market.instrument
        (
            instrument_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_listing_exchange
        FOREIGN KEY
        (
            exchange_id
        )
        REFERENCES ref.exchange
        (
            exchange_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_listing_market
        FOREIGN KEY
        (
            market_id
        )
        REFERENCES ref.market
        (
            market_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_listing_board
        FOREIGN KEY
        (
            board_id
        )
        REFERENCES ref.board
        (
            board_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_listing_market_status
        FOREIGN KEY
        (
            market_status_id
        )
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.instrument_listing
IS
'Maintains the complete listing lifecycle of financial instruments across
supported exchanges, markets, and trading boards. Each record represents a
listing event that defines where and when an instrument becomes available for
trading, changes its listing status, or is removed from trading.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_listing.instrument_listing_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.instrument_listing.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.instrument_listing.instrument_id
IS
'Reference to the financial instrument associated with this listing.';

COMMENT ON COLUMN market.instrument_listing.exchange_id
IS
'Reference to the exchange where the instrument is listed.';

COMMENT ON COLUMN market.instrument_listing.market_id
IS
'Reference to the market within the exchange where the instrument is listed.';

COMMENT ON COLUMN market.instrument_listing.board_id
IS
'Reference to the trading board on which the instrument is listed.';

COMMENT ON COLUMN market.instrument_listing.market_status_id
IS
'Reference to the current market status applicable to this listing.';

COMMENT ON COLUMN market.instrument_listing.listing_code
IS
'Unique business code identifying the instrument listing.';

COMMENT ON COLUMN market.instrument_listing.listing_date
IS
'Official date on which the listing was approved or announced.';

COMMENT ON COLUMN market.instrument_listing.effective_date
IS
'Date on which the listing became effective and the instrument became eligible for trading.';

COMMENT ON COLUMN market.instrument_listing.delisting_date
IS
'Date on which the instrument was officially removed from trading, if applicable.';

COMMENT ON COLUMN market.instrument_listing.listing_reference
IS
'Reference number or external identifier associated with the listing announcement or regulatory approval.';

COMMENT ON COLUMN market.instrument_listing.published_at
IS
'Timestamp indicating when the listing announcement or regulatory decision was officially published.';

COMMENT ON COLUMN market.instrument_listing.source_reference
IS
'External reference identifying the official source of the listing information, such as an exchange announcement, regulatory notice, document identifier, or URL.';

COMMENT ON COLUMN market.instrument_listing.listing_reason
IS
'Business reason describing why the instrument was listed.';

COMMENT ON COLUMN market.instrument_listing.delisting_reason
IS
'Business reason describing why the instrument was delisted, if applicable.';

COMMENT ON COLUMN market.instrument_listing.description
IS
'Optional business description providing additional information about the listing record.';

COMMENT ON COLUMN market.instrument_listing.is_active
IS
'Indicates whether the listing record is currently active and valid within the Phoenix Platform.';

COMMENT ON COLUMN market.instrument_listing.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.instrument_listing.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.instrument_listing.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.instrument_listing.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.instrument_listing.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------