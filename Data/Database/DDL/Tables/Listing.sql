/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : listing.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : Listing
* Schema           : market
* Version          : 2026.1
* Status           : Approved
*
* Description
* -------------------------------------------------------------------------------------------------
* Creates the canonical Listing master table.
*
* The Listing table connects financial instruments to trading venues and
* represents the official admission of an instrument for trading on a specific
* trading board.
*
* Each listing defines the exchange-scoped trading identity, ticker, lifecycle,
* and operational status of an instrument within the Phoenix Platform.
*
* Architectural Source
* -------------------------------------------------------------------------------------------------
* - ADR-028 Market Classification Strategy
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
*     - Table  : market.instrument
*     - Table  : market.trading_board
*     - Table  : ref.market_status
*
* Referenced Objects
*     - market.instrument
*     - market.trading_board
*     - ref.market_status
*
* Referenced By
*     - market.daily_market_data
*     - market.corporate_action
*     - market.order_book
*     - market.trading_session
*     - Additional transactional entities
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
* - Canonical bridge entity between Instrument and TradingBoard.
* - Supports future multi-exchange and multi-board listings.
* - Ticker uniqueness is enforced within the Trading Board scope.
* - One database object per script.
* - One table per file.
* - PostgreSQL 17 compatible.
*
* Author           : Phoenix Architecture Team
* Created          : 2026-07-30
*
* Revision History
* -------------------------------------------------------------------------------------------------
* Version   Date         Description
* -------   ----------   ---------------------------------------------------------
* 2026.1    2026-07-30   Canonical enterprise implementation.
  **************************************************************************************************/

CREATE TABLE market.listing
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------

listing_id                         BIGINT
                                   GENERATED ALWAYS AS IDENTITY,

----------------------------------------------------------------------------
-- Public Identifier
----------------------------------------------------------------------------

public_id                          UUID
                                   NOT NULL
                                   DEFAULT gen_random_uuid(),

----------------------------------------------------------------------------
-- Listing Identity
----------------------------------------------------------------------------

instrument_id                      BIGINT
                                   NOT NULL,

trading_board_id                   BIGINT
                                   NOT NULL,

ticker                             VARCHAR(50)
                                   NOT NULL,

listing_code                       VARCHAR(50),

----------------------------------------------------------------------------
-- Listing Lifecycle
----------------------------------------------------------------------------

listing_date                       DATE,

effective_date                     DATE,

delisting_date                     DATE,

market_status_id                   BIGINT
                                   NOT NULL,

listing_reference                  VARCHAR(100),

published_at                       TIMESTAMPTZ,

----------------------------------------------------------------------------
-- Business Metadata
----------------------------------------------------------------------------

listing_display_order              SMALLINT
                                   NOT NULL
                                   DEFAULT 1,

listing_description                VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

listing_is_active                  BOOLEAN
                                   NOT NULL
                                   DEFAULT TRUE,

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

created_at                         TIMESTAMPTZ
                                   NOT NULL
                                   DEFAULT CURRENT_TIMESTAMP,

updated_at                         TIMESTAMPTZ,

created_by                         BIGINT
                                   NOT NULL,

updated_by                         BIGINT,

row_version                        INTEGER
                                   NOT NULL
                                   DEFAULT 1,

----------------------------------------------------------------------------
-- Constraints
----------------------------------------------------------------------------

CONSTRAINT pk_listing
    PRIMARY KEY
    (
        listing_id
    ),

CONSTRAINT uk_listing_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_listing_instrument_board
    UNIQUE
    (
        instrument_id,
        trading_board_id
    ),

CONSTRAINT uk_listing_board_ticker
    UNIQUE
    (
        trading_board_id,
        ticker
    ),

CONSTRAINT uk_listing_reference
    UNIQUE
    (
        listing_reference
    ),

----------------------------------------------------------------------------
-- Check Constraints
----------------------------------------------------------------------------

CONSTRAINT ck_listing_ticker_not_empty
    CHECK
    (
        LENGTH(TRIM(ticker)) > 0
    ),

CONSTRAINT ck_listing_code_not_empty
    CHECK
    (
        listing_code IS NULL
        OR LENGTH(TRIM(listing_code)) > 0
    ),

CONSTRAINT ck_listing_reference_not_empty
    CHECK
    (
        listing_reference IS NULL
        OR LENGTH(TRIM(listing_reference)) > 0
    ),

CONSTRAINT ck_listing_description_not_empty
    CHECK
    (
        listing_description IS NULL
        OR LENGTH(TRIM(listing_description)) > 0
    ),

CONSTRAINT ck_listing_display_order
    CHECK
    (
        listing_display_order > 0
    ),

CONSTRAINT ck_listing_dates
    CHECK
    (
        (
            effective_date IS NULL 
            OR listing_date IS NULL 
            OR effective_date >= listing_date
        )
        AND
        (
            delisting_date IS NULL 
            OR effective_date IS NULL 
            OR delisting_date >= effective_date
        )

    ),

CONSTRAINT ck_listing_row_version_positive
    CHECK
    (
        row_version > 0
    ),

----------------------------------------------------------------------------
-- Foreign Keys
----------------------------------------------------------------------------

CONSTRAINT fk_listing_instrument
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

CONSTRAINT fk_listing_trading_board
    FOREIGN KEY
    (
        trading_board_id
    )
    REFERENCES market.trading_board
    (
        trading_board_id
    )
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

CONSTRAINT fk_listing_market_status
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

COMMENT ON TABLE market.listing
IS
'Master table containing the official listings of financial instruments on
trading boards within the Phoenix Platform. Each listing connects one instrument
to one trading board and defines the exchange-scoped trading identity, ticker,
lifecycle, and operational status of the instrument.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.listing.listing_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.listing.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.listing.instrument_id
IS
'Reference to the financial instrument being listed.';

COMMENT ON COLUMN market.listing.trading_board_id
IS
'Reference to the trading board on which the instrument is listed.';

COMMENT ON COLUMN market.listing.ticker
IS
'Exchange-scoped trading ticker assigned to the listed instrument.';

COMMENT ON COLUMN market.listing.listing_code
IS
'Optional internal business code identifying the listing.';

COMMENT ON COLUMN market.listing.listing_date
IS
'Official admission date of the instrument for trading.';

COMMENT ON COLUMN market.listing.effective_date
IS
'Date on which the listing became operationally effective.';

COMMENT ON COLUMN market.listing.delisting_date
IS
'Date on which the instrument was removed from trading.';

COMMENT ON COLUMN market.listing.market_status_id
IS
'Reference to the operational market status of the listing.';

COMMENT ON COLUMN market.listing.listing_reference
IS
'Official exchange or regulatory reference associated with the listing.';

COMMENT ON COLUMN market.listing.published_at
IS
'Timestamp at which the listing information was officially published.';

COMMENT ON COLUMN market.listing.listing_display_order
IS
'Display sequence used by applications when presenting listings to users.';

COMMENT ON COLUMN market.listing.listing_description
IS
'Optional business description of the listing.';

COMMENT ON COLUMN market.listing.listing_is_active
IS
'Indicates whether the listing is currently active and available for trading operations.';

COMMENT ON COLUMN market.listing.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.listing.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.listing.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.listing.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.listing.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------