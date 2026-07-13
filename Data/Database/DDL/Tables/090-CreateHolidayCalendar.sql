/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 090-CreateHolidayCalendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : HolidayCalendar
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the HolidayCalendar reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 080-CreateTradingCalendar.sql
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

CREATE TABLE reference.HolidayCalendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    holiday_calendar_id     BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id               UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    holiday_date            DATE NOT NULL,
    persian_date            VARCHAR(10) NOT NULL,
    holiday_name            VARCHAR(200) NOT NULL,
    holiday_type            VARCHAR(50) NOT NULL,
    description             VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    trading_calendar_id     BIGINT NOT NULL,

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

    CONSTRAINT PK_HolidayCalendar
        PRIMARY KEY (holiday_calendar_id),

    CONSTRAINT UQ_HolidayCalendar_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_HolidayCalendar_Date
        UNIQUE (holiday_date)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.HolidayCalendar
IS 'Stores official holidays affecting market trading activities.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.HolidayCalendar.holiday_calendar_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.HolidayCalendar.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_date
IS 'Gregorian holiday date.';

COMMENT ON COLUMN reference.HolidayCalendar.persian_date
IS 'Equivalent Persian (Solar Hijri) holiday date.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_name
IS 'Official holiday name.';

COMMENT ON COLUMN reference.HolidayCalendar.holiday_type
IS 'Holiday classification such as National, Religious or Exchange.';

COMMENT ON COLUMN reference.HolidayCalendar.description
IS 'Business description of the holiday.';

COMMENT ON COLUMN reference.HolidayCalendar.trading_calendar_id
IS 'References the associated trading calendar entry.';

COMMENT ON COLUMN reference.HolidayCalendar.is_active
IS 'Indicates whether the holiday definition is active.';

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