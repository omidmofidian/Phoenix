/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : TradingCalendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingCalendar
 * Schema           : reference
 * Version          : 2.0
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
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Exchange.sql
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - SQLScriptDevelopmentStandard
 * - DatabaseDDLDevelopmentStandard
 * - EnterpriseTableConvention
 * - TableDevelopmentStandard
 * - ConstraintDevelopmentStandard
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
 **************************************************************************************************/

CREATE TABLE reference.TradingCalendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    trading_calendar_id      BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id                UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    exchange_id              BIGINT NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    calendar_date            DATE NOT NULL,

    persian_date             VARCHAR(10) NOT NULL,

    is_weekend               BOOLEAN NOT NULL DEFAULT FALSE,

    is_trading_day           BOOLEAN NOT NULL DEFAULT TRUE,

    description              VARCHAR(500),

        ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at              TIMESTAMPTZ NOT NULL,
    created_by              BIGINT NOT NULL,

    updated_at              TIMESTAMPTZ,
    updated_by              BIGINT,

    version                 INTEGER NOT NULL DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT PK_TradingCalendar
        PRIMARY KEY (trading_calendar_id),

    CONSTRAINT UQ_TradingCalendar_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_TradingCalendar_Exchange_Date
        UNIQUE (exchange_id, calendar_date),

    CONSTRAINT FK_TradingCalendar_Exchange
        FOREIGN KEY (exchange_id)
        REFERENCES reference.Exchange (exchange_id)
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.TradingCalendar
IS 'Defines the official trading calendar for each supported exchange.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.TradingCalendar.trading_calendar_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.TradingCalendar.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.TradingCalendar.exchange_id
IS 'References the Exchange that owns this trading calendar.';

COMMENT ON COLUMN reference.TradingCalendar.calendar_date
IS 'Gregorian calendar date represented by this trading calendar entry.';

COMMENT ON COLUMN reference.TradingCalendar.persian_date
IS 'Equivalent Persian (Solar Hijri) calendar date.';

COMMENT ON COLUMN reference.TradingCalendar.is_weekend
IS 'Indicates whether the calendar date is considered a weekend by the owning exchange.';

COMMENT ON COLUMN reference.TradingCalendar.is_trading_day
IS 'Indicates whether trading sessions are permitted on the specified date.';

COMMENT ON COLUMN reference.TradingCalendar.description
IS 'Additional business information describing the calendar entry.';

COMMENT ON COLUMN reference.TradingCalendar.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.TradingCalendar.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.TradingCalendar.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.TradingCalendar.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.TradingCalendar.version
IS 'Optimistic concurrency version number.';

