/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : trading_session.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingSession
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TradingSession reference table.
 *
 * The TradingSession table defines the standardized trading sessions supported
 * by the Phoenix Platform. A trading session represents a distinct phase within
 * a trading day, such as pre-open, opening auction, continuous trading,
 * closing auction, or after-hours trading.
 *
 * This table provides the authoritative reference for trading session
 * definitions across all supported financial markets, including stock
 * exchanges, derivatives markets, commodity exchanges, foreign exchange
 * markets, and cryptocurrency exchanges.
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
 *     - Schema : ref
 *
 * Referenced Objects
 *     None
 *
 * Referenced By
 *     - market.daily_market_data
 *     - market.market_session
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
 * - Designed for multi-market support.
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

CREATE TABLE ref.trading_session
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    trading_session_id        BIGINT
                                  GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                 UUID
                                  NOT NULL
                                  DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    trading_session_code      VARCHAR(30)
                                  NOT NULL,

    trading_session_name      VARCHAR(200)
                                  NOT NULL,

    trading_session_short_name                VARCHAR(100),

    trading_session_local_name                VARCHAR(200),

    trading_session_display_order             SMALLINT
                                  NOT NULL
                                  DEFAULT 1,

    trading_session_description               VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    trading_session_is_active                 BOOLEAN
                                  NOT NULL
                                  DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                TIMESTAMPTZ
                                  NOT NULL
                                  DEFAULT CURRENT_TIMESTAMP,

    updated_at                TIMESTAMPTZ,

    created_by                BIGINT
                                  NOT NULL,

    updated_by                BIGINT,

    row_version                   INTEGER
                                  NOT NULL
                                  DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_trading_session
        PRIMARY KEY
        (
            trading_session_id
        ),

    CONSTRAINT uq_trading_session_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_trading_session_code
        UNIQUE
        (
            trading_session_code
        ),

    CONSTRAINT ck_trading_session_code_length
        CHECK 
        (
            LENGTH(TRIM(trading_session_code)) BETWEEN 2 AND 30
        ),

    CONSTRAINT ck_trading_session_code_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_session_code)) > 0
        ),

    CONSTRAINT ck_trading_session_name_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_session_name)) > 0
        ),

    CONSTRAINT ck_trading_session_display_order
        CHECK
        (
            trading_session_display_order > 0
        ),

    CONSTRAINT ck_trading_session_short_name_not_empty
        CHECK 
        (
            trading_session_short_name IS NULL
            OR LENGTH(TRIM(trading_session_short_name)) > 0
        ),

    CONSTRAINT ck_trading_session_local_name_not_empty
        CHECK 
        (
            trading_session_local_name IS NULL
            OR LENGTH(TRIM(trading_session_local_name)) > 0
        ),

    CONSTRAINT ck_trading_session_description_not_empty
        CHECK 
        (
            trading_session_description IS NULL
            OR LENGTH(TRIM(trading_session_description)) > 0
        ),

    CONSTRAINT ck_trading_session_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.trading_session
IS
'Reference table containing the standardized trading session types supported by
the Phoenix Platform. Each record defines a reusable trading session type
(such as pre-open, opening auction, continuous trading, closing auction, or
after-hours trading) that may be associated with one or more market-specific
trading schedules.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.trading_session.trading_session_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.trading_session.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.trading_session.trading_session_code
IS
'Unique business code identifying the trading session.';

COMMENT ON COLUMN ref.trading_session.trading_session_name
IS
'Official business name of the trading session.';

COMMENT ON COLUMN ref.trading_session.trading_session_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.trading_session.trading_session_local_name
IS
'Official local-language name of the trading session.';

COMMENT ON COLUMN ref.trading_session.trading_session_display_order
IS
'Display sequence used by applications when presenting trading sessions to users.';

COMMENT ON COLUMN ref.trading_session.trading_session_description
IS
'Optional business description of the trading session.';

COMMENT ON COLUMN ref.trading_session.trading_session_is_active
IS
'Indicates whether the trading session is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.trading_session.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.trading_session.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.trading_session.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.trading_session.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.trading_session.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------