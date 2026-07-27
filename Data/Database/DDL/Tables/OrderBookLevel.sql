/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : OrderBookLevel.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : OrderBookLevel
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical OrderBookLevel fact table.
 *
 * The OrderBookLevel table stores the individual bid and ask levels belonging
 * to an OrderBookSnapshot. Each record represents one price level on one side
 * of the order book.
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
 *     - market.order_book_snapshot
 *     - ref.order_book_side
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical fact detail table.
 * - Child table of OrderBookSnapshot.
 * - One record represents one level on one side of the order book.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.order_book_level
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    order_book_level_id            BIGINT
                                       GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                      UUID
                                       NOT NULL
                                       DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Parent Reference
    ----------------------------------------------------------------------------

    order_book_snapshot_id         BIGINT
                                       NOT NULL,

    ----------------------------------------------------------------------------
    -- Level Information
    ----------------------------------------------------------------------------

    order_book_side_id             BIGINT
                                       NOT NULL,

    level_number                   SMALLINT
                                       NOT NULL,

    ----------------------------------------------------------------------------
    -- Price Information
    ----------------------------------------------------------------------------

    order_price                    NUMERIC(20,8)
                                       NOT NULL,

    ----------------------------------------------------------------------------
    -- Quantity Information
    ----------------------------------------------------------------------------

    order_quantity                 NUMERIC(24,4)
                                       NOT NULL,

    order_count                    INTEGER
                                       NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                      BOOLEAN
                                       NOT NULL
                                       DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                     TIMESTAMPTZ
                                       NOT NULL
                                       DEFAULT CURRENT_TIMESTAMP,

    created_by                     BIGINT
                                       NOT NULL,

    updated_at                     TIMESTAMPTZ,

    updated_by                     BIGINT,

    version                        INTEGER
                                       NOT NULL
                                       DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_order_book_level
        PRIMARY KEY
        (
            order_book_level_id
        ),

    CONSTRAINT uq_order_book_level_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_order_book_level_business
        UNIQUE
        (
            order_book_snapshot_id,
            order_book_side_id,
            level_number
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_order_book_level_number
        CHECK
        (
            level_number > 0
        ),

    CONSTRAINT ck_order_book_level_price
        CHECK
        (
            order_price >= 0
        ),

    CONSTRAINT ck_order_book_level_quantity
        CHECK
        (
            order_quantity >= 0
        ),

    CONSTRAINT ck_order_book_level_order_count
        CHECK
        (
            order_count >= 0
        ),

    CONSTRAINT ck_order_book_level_version
        CHECK
        (
            version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_order_book_level_snapshot
        FOREIGN KEY
        (
            order_book_snapshot_id
        )
        REFERENCES market.order_book_snapshot
        (
            order_book_snapshot_id
        )
        ON UPDATE RESTRICT
        ON DELETE CASCADE,

    CONSTRAINT fk_order_book_level_side
        FOREIGN KEY
        (
            order_book_side_id
        )
        REFERENCES ref.order_book_side
        (
            order_book_side_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.order_book_level
IS
'Stores the canonical detail records for order book snapshots. Each record
represents one bid or ask level belonging to an OrderBookSnapshot and contains
the aggregated price, quantity, and order count for that level. This table
serves as the authoritative source for market depth analysis, liquidity
analysis, order book replay, quantitative research, and machine learning.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.order_book_level_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.order_book_level.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Parent Reference
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.order_book_snapshot_id
IS
'Reference to the parent OrderBookSnapshot to which this order book level belongs.';

----------------------------------------------------------------------------
-- Level Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.order_book_side_id
IS
'Reference to the side of the order book represented by this level (Bid or Ask).';

COMMENT ON COLUMN market.order_book_level.level_number
IS
'Sequential level number within the specified side of the order book. Level 1 represents the best available price.';

----------------------------------------------------------------------------
-- Price Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.order_price
IS
'Aggregated price associated with the specified order book level.';

----------------------------------------------------------------------------
-- Quantity Information
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.order_quantity
IS
'Aggregated quantity available at the specified order book level.';

COMMENT ON COLUMN market.order_book_level.order_count
IS
'Number of active orders aggregated at the specified order book level.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.is_active
IS
'Indicates whether the record is active and available for business operations within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.order_book_level.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.order_book_level.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.order_book_level.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.order_book_level.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.order_book_level.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------