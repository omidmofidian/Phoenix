/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : trading_session_type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingSessionType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TradingSessionType reference table.
 *
 * The TradingSessionType table defines the standardized business
 * classifications of trading sessions supported by the Phoenix Platform.
 *
 * Each record represents a distinct trading session category occurring during
 * the lifecycle of a trading day.
 *
 * This table provides consistent trading session classifications used
 * throughout market data processing, order management, trading, reporting,
 * analytics, auditing, and historical market analysis.
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
 *     - None
 *
 * Referenced By
 *     - market.trading_session
 *     - market.daily_market_data
 *     - market.tick_data
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
 * Created          : 2026-08-03
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-08-03   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.trading_session_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    trading_session_type_id              BIGINT
                                             GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                            UUID
                                             NOT NULL
                                             DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    trading_session_type_code            VARCHAR(50)
                                             NOT NULL,

    trading_session_type_name            VARCHAR(100)
                                             NOT NULL,

    trading_session_type_display_order   SMALLINT
                                             NOT NULL
                                             DEFAULT 1,

    trading_session_type_description     VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    trading_session_type_is_active       BOOLEAN
                                             NOT NULL
                                             DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                           TIMESTAMPTZ
                                             NOT NULL
                                             DEFAULT CURRENT_TIMESTAMP,

    updated_at                           TIMESTAMPTZ,

    created_by                           BIGINT
                                             NOT NULL,

    updated_by                           BIGINT,

    row_version                          INTEGER
                                             NOT NULL
                                             DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_trading_session_type
        PRIMARY KEY
        (
            trading_session_type_id
        ),

    CONSTRAINT uk_trading_session_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_trading_session_type_code
        UNIQUE
        (
            trading_session_type_code
        ),

    CONSTRAINT uk_trading_session_type_name
        UNIQUE
        (
            trading_session_type_name
        ),

    CONSTRAINT ck_trading_session_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_session_type_code)) > 0
        ),

    CONSTRAINT ck_trading_session_type_code_uppercase
        CHECK
        (
            trading_session_type_code =
            UPPER(trading_session_type_code)
        ),

    CONSTRAINT ck_trading_session_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_session_type_name)) > 0
        ),

    CONSTRAINT ck_trading_session_type_display_order_positive
        CHECK
        (
            trading_session_type_display_order > 0
        ),

    CONSTRAINT ck_trading_session_type_description_not_empty
        CHECK
        (
            trading_session_type_description IS NULL
            OR LENGTH(TRIM(trading_session_type_description)) > 0
        ),

    CONSTRAINT ck_trading_session_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.trading_session_type
IS
'Reference table defining the standardized business classifications of trading
sessions supported by the Phoenix Platform. Each trading session type
represents a distinct phase within the lifecycle of a trading day, such as
pre-open, continuous trading, auction, post-close, or after-hours trading.
This table provides consistent trading session classifications used throughout
market data processing, order management, trading, reporting, analytics,
auditing, and historical market analysis.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.trading_session_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_code
IS
'Unique business code identifying the trading session type.';

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_name
IS
'Official business name of the trading session type.';

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_display_order
IS
'Display sequence used by applications when presenting trading session types
to users.';

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_description
IS
'Optional business description providing additional information about the
trading session type.';

COMMENT ON COLUMN ref.trading_session_type.trading_session_type_is_active
IS
'Indicates whether the trading session type is currently active and available
for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.trading_session_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.trading_session_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.trading_session_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.trading_session_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.trading_session_type.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------