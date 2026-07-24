/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : HolidayCalendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : HolidayCalendar
 * Schema           : reference
 * Version          : 2.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the HolidayCalendar reference table.
 *
 * The HolidayCalendar defines official holidays observed by each Exchange
 * supported by the Phoenix Platform. Holidays may include national, religious,
 * exchange-specific, or extraordinary closure events that affect trading
 * activities.
 *
 * This table stores only holiday definitions. Daily trading availability is
 * maintained separately by the TradingCalendar.
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

CREATE TABLE reference.HolidayCalendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    holiday_calendar_id      BIGINT GENERATED ALWAYS AS IDENTITY,

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

    holiday_date             DATE NOT NULL,

    persian_date             VARCHAR(10) NOT NULL,

    holiday_name             VARCHAR(200) NOT NULL,

    holiday_type             VARCHAR(50) NOT NULL,

    description              VARCHAR(500),

        ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at               TIMESTAMPTZ NOT NULL,
    created_by               BIGINT NOT NULL,

    updated_at               TIMESTAMPTZ,
    updated_by               BIGINT,

    version                  INTEGER NOT NULL DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT PK_HolidayCalendar
        PRIMARY KEY (holiday_calendar_id),

    CONSTRAINT UQ_HolidayCalendar_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_HolidayCalendar_Exchange_Date
        UNIQUE (exchange_id, holiday_date),

    CONSTRAINT FK_HolidayCalendar_Exchange
        FOREIGN KEY (exchange_id)
        REFERENCES reference.Exchange (exchange_id)
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.HolidayCalendar
IS 'Defines official holidays observed by each supported exchange.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.HolidayCalendar.holiday_calendar_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.HolidayCalendar.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.HolidayCalendar.exchange_id
IS 'References the Exchange that observes this holiday.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_date
IS 'Gregorian calendar date of the holiday.';

COMMENT ON COLUMN reference.HolidayCalendar.persian_date
IS 'Equivalent Persian (Solar Hijri) calendar date.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_name
IS 'Official business name of the holiday.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_type
IS 'Classification of the holiday, such as National, Religious, Exchange, Regulatory or Extraordinary.';

COMMENT ON COLUMN reference.HolidayCalendar.description
IS 'Additional business information describing the holiday.';

COMMENT ON COLUMN reference.HolidayCalendar.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.HolidayCalendar.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.HolidayCalendar.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.HolidayCalendar.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.HolidayCalendar.version
IS 'Optimistic concurrency version number.';

