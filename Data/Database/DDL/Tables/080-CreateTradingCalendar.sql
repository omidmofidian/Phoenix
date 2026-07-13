/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 080-CreateTradingCalendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingCalendar
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the TradingCalendar reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * None
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
 **************************************************************************************************/

CREATE TABLE reference.TradingCalendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    trading_calendar_id     BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id               UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    calendar_date           DATE NOT NULL,
    persian_date            VARCHAR(10) NOT NULL,
    day_name                VARCHAR(20) NOT NULL,
    day_of_week             SMALLINT NOT NULL,
    week_of_year            SMALLINT,
    month_of_year           SMALLINT NOT NULL,
    year_number             INTEGER NOT NULL,
    is_weekend              BOOLEAN NOT NULL DEFAULT FALSE,
    is_trading_day          BOOLEAN NOT NULL DEFAULT TRUE,
    description             VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Business Status
    ------------------------------------------------------------------------------

    is_active               BOOLEAN NOT NULL DEFAULT TRUE,

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

    CONSTRAINT UQ_TradingCalendar_Date
        UNIQUE (calendar_date)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.TradingCalendar
IS 'Stores the official trading calendar used by the Phoenix Platform.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.TradingCalendar.trading_calendar_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.TradingCalendar.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.TradingCalendar.calendar_date
IS 'Gregorian calendar date.';

COMMENT ON COLUMN reference.TradingCalendar.persian_date
IS 'Equivalent Persian (Solar Hijri) calendar date.';

COMMENT ON COLUMN reference.TradingCalendar.day_name
IS 'Business name of the day.';

COMMENT ON COLUMN reference.TradingCalendar.day_of_week
IS 'Day number within the week.';

COMMENT ON COLUMN reference.TradingCalendar.week_of_year
IS 'Week number within the year.';

COMMENT ON COLUMN reference.TradingCalendar.month_of_year
IS 'Month number within the year.';

COMMENT ON COLUMN reference.TradingCalendar.year_number
IS 'Gregorian calendar year.';

COMMENT ON COLUMN reference.TradingCalendar.is_weekend
IS 'Indicates whether the date is a weekend.';

COMMENT ON COLUMN reference.TradingCalendar.is_trading_day
IS 'Indicates whether trading is permitted on the date.';

COMMENT ON COLUMN reference.TradingCalendar.description
IS 'Business description of the calendar date.';

COMMENT ON COLUMN reference.TradingCalendar.is_active
IS 'Indicates whether the calendar entry is active.';

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