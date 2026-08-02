/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : trading_calendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingCalendar
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the TradingCalendar reference table.
 *
 * The TradingCalendar defines the official trading calendar for each Exchange
 * supported by the Phoenix Platform. Each Exchange maintains its own trading
 * calendar, enabling the platform to support multiple financial markets such as
 * stock exchanges, derivatives markets, foreign exchange markets, commodity
 * exchanges, and cryptocurrency exchanges.
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
 *     - Table  : ref.exchange
 *
 * Referenced Objects
 *     - ref.exchange
 *
 * Referenced By
 *     - market.daily_market_data   
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
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-11
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 1.0       2026-07-11   Initial version.
 * 2.0       2026-07-24   Redesigned based on ADR-015 (Market Classification Model)
 *                        and ADR-026 (Reference Data Normalization Model).
 * 2026.1    2026-07-24    Canonical implementation aligned with the Physical Design architecture.
 **************************************************************************************************/

CREATE TABLE ref.trading_calendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    trading_calendar_id      BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id                UUID 
                                NOT NULL
                                DEFAULT gen_random_uuid(),

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    exchange_id              BIGINT 
                                NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    calendar_date            DATE 
                                NOT NULL,

    persian_date             VARCHAR(10) 
                                NOT NULL,

    is_weekend               BOOLEAN 
                                NOT NULL 
                                DEFAULT FALSE,

    is_trading_day           BOOLEAN 
                                NOT NULL 
                                DEFAULT TRUE,

    trading_calendar_description              VARCHAR(500),

        ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at              TIMESTAMPTZ 
                            NOT NULL
                            DEFAULT CURRENT_TIMESTAMP,
 
    updated_at              TIMESTAMPTZ,

    created_by              BIGINT 
                                NOT NULL,

    updated_by              BIGINT,

    row_version                 INTEGER 
                                NOT NULL 
                                DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT pk_trading_calendar
        PRIMARY KEY 
        (
            trading_calendar_id
        ),

    CONSTRAINT uk_trading_calendar_Public_id
        UNIQUE 
        (
            public_id
        ),

    CONSTRAINT uk_trading_calendar_Exchange_date
        UNIQUE 
        (
            exchange_id, calendar_date
        ),

    CONSTRAINT ck_trading_calendar_persian_date_not_empty
        CHECK
        (
            LENGTH(TRIM(persian_date)) > 0
        ),

    CONSTRAINT ck_trading_calendar_calendar_date
        CHECK
        (
            calendar_date >= DATE '1900-01-01'
        ),

    CONSTRAINT ck_trading_calendar_weekend_logic
        CHECK
        (
            NOT (is_weekend = TRUE AND is_trading_day = TRUE)
        ),

    CONSTRAINT ck_trading_calendar_row_version_positive
        CHECK
        (
            row_version > 0
        ),


    CONSTRAINT fk_trading_calendar_exchange
        FOREIGN KEY 
        (
            exchange_id
        )
        REFERENCES ref.exchange 
        (
            exchange_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.trading_calendar
IS 
'Reference table containing the official trading calendar for each exchange
supported by the Phoenix Platform. Each record defines the trading status of a
specific exchange for a given calendar date and serves as the authoritative
calendar used by market data processing, trading services, and analytics.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.trading_calendar.trading_calendar_id
IS 
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.trading_calendar.public_id
IS 
'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN ref.trading_calendar.exchange_id
IS 
'References the Exchange that owns this trading calendar.';

COMMENT ON COLUMN ref.trading_calendar.calendar_date
IS 
'Gregorian calendar date represented by this trading calendar entry.';

COMMENT ON COLUMN ref.trading_calendar.persian_date
IS 
'Equivalent Persian (Solar Hijri) calendar date.';

COMMENT ON COLUMN ref.trading_calendar.is_weekend
IS 
'Indicates whether the calendar date is considered a weekend by the owning exchange.';

COMMENT ON COLUMN ref.trading_calendar.is_trading_day
IS 
'Indicates whether trading sessions are permitted on the specified date.';

COMMENT ON COLUMN ref.trading_calendar.trading_calendar_description
IS 
'Additional business information describing the calendar entry.';

COMMENT ON COLUMN ref.trading_calendar.created_at
IS 
'Timestamp when the record was created.';

COMMENT ON COLUMN ref.trading_calendar.created_by
IS 
'Identifier of the user or process that created the record.';

COMMENT ON COLUMN ref.trading_calendar.updated_at
IS 
'Timestamp when the record was last updated.';

COMMENT ON COLUMN ref.trading_calendar.updated_by
IS 
'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN ref.trading_calendar.row_version
IS 
'Optimistic concurrency version number.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------