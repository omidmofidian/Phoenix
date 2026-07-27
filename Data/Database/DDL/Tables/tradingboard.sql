/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : trading_board.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingBoard
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Trading Board reference table.
 *
 * The Trading Board table represents the trading boards operating within a
 * supported market. Each trading board belongs to exactly one Market and
 * provides the business classification used for listing and trading financial
 * instruments.
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
 *     - Table  : market.market
 *
 * Referenced Objects
 *     - market.market
 *
 * Referenced By
 *     - market.instrument
 *     - Additional trading classification entities
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
 * Created          : 2026-07-24
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-24   Canonical implementation aligned with the Physical Design
 *                        architecture.
 **************************************************************************************************/

CREATE TABLE market.trading_board
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    trading_board_id                      BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                             UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    market_id               BIGINT
                                NOT NULL,

    trading_board_code                    VARCHAR(20)
                                NOT NULL,

    trading_board_name                    VARCHAR(200)
                                NOT NULL,

    short_name              VARCHAR(100),

    trading_board_local_name              VARCHAR(200),

    display_order           SMALLINT
                                NOT NULL
                                DEFAULT 1,

    description             VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active               BOOLEAN
                                NOT NULL
                                DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at              TIMESTAMPTZ
                                NOT NULL
                                DEFAULT CURRENT_TIMESTAMP,

    updated_at              TIMESTAMPTZ,

    created_by              BIGINT
                                NOT NULL,
 
    updated_by              BIGINT,

    version                 INTEGER
                                NOT NULL
                                DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_trading_board
        PRIMARY KEY
        (
            trading_board_id
        ),

    CONSTRAINT uk_trading_board_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_trading_board_market_code
        UNIQUE
        (
            market_id,
            trading_board_code
        ),

    CONSTRAINT ck_trading_board_code_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_board_code)) > 0
        ),

    CONSTRAINT ck_trading_board_name_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_board_name)) > 0
        ),

    CONSTRAINT ck_trading_board_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT fk_trading_board_market
        FOREIGN KEY
        (
            market_id
        )
        REFERENCES market.market
        (
            market_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.trading_board
IS
'Reference table containing the trading boards supported by the Phoenix Platform.
Each trading board belongs to exactly one market and provides the authoritative
classification for listing and trading financial instruments.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.trading_board.trading_board_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.trading_board.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.trading_board.market_id
IS
'Reference to the parent market to which the trading board belongs.';

COMMENT ON COLUMN market.trading_board.trading_board_code
IS
'Unique business code identifying the trading board within its parent market.';

COMMENT ON COLUMN market.trading_board.trading_board_name
IS
'Official business name of the trading board.';

COMMENT ON COLUMN market.trading_board.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN market.trading_board.trading_board_local_name
IS
'Official local-language name of the trading board.';

COMMENT ON COLUMN market.trading_board.display_order
IS
'Display sequence used by applications when presenting trading boards to users.';

COMMENT ON COLUMN market.trading_board.description
IS
'Optional business description of the trading board.';

COMMENT ON COLUMN market.trading_board.is_active
IS
'Indicates whether the trading board is currently active and available for business operations.';

COMMENT ON COLUMN market.trading_board.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.trading_board.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.trading_board.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.trading_board.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.trading_board.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------