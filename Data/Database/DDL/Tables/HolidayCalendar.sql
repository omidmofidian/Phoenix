/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : HolidayCalendar.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : HolidayCalendar
 * Schema           : ref
 * Version          : 2026.1
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
 * 2026.1    2026-07-24   Canonical implementation aligned with the Physical Design architecture.
 **************************************************************************************************/

CREATE TABLE ref.holiday_calendar
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    holiday_calendar_id      BIGINT 
                                GENERATED ALWAYS AS IDENTITY,

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

    holiday_date             DATE 
                                NOT NULL,

    persian_date             VARCHAR(10) 
                                NOT NULL,

    holiday_name             VARCHAR(200) 
                                NOT NULL,

    holiday_type             VARCHAR(50) 
                                NOT NULL,

    description              VARCHAR(500),

        ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at               TIMESTAMPTZ 
                                NOT NULL
                                DEFAULT CURRENT_TIMESTAMP,

    updated_at               TIMESTAMPTZ,

    created_by               BIGINT 
                                NOT NULL,

    updated_by               BIGINT,

    version                  INTEGER 
                                NOT NULL 
                                DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT pk_holiday_calendar
        PRIMARY KEY 
        (
            holiday_calendar_id
        ),

    CONSTRAINT uq_holiday_calendar_public-id
        UNIQUE 
        (
            public_id
        ),

    CONSTRAINT uq_holiday_calendar_exchange_date
        UNIQUE 
        (
            exchange_id, holiday_date
        ),

    CONSTRAINT ck_holiday_calendar_persian_date_not_empty
        CHECK
        (
           LENGTH(TRIM(persian_date)) > 0
        ),

    CONSTRAINT ck_holiday_calendar_holiday_name_not_empty
        CHECK
        (
           LENGTH(TRIM(holiday_name)) > 0
        ),

    CONSTRAINT ck_holiday_calendar_holiday_type_not_empty
        CHECK
        (
           LENGTH(TRIM(holiday_type)) > 0
        ),

    CONSTRAINT ck_holiday_calendar_version_positive
        CHECK
        (
           version > 0
        ),

    CONSTRAINT fk_holiday_calendar_exchange
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

COMMENT ON TABLE ref.holiday_calendar
IS 
'Reference table containing the official holidays observed by exchanges supported
by the Phoenix Platform. Each record represents a holiday or extraordinary
market closure for a specific exchange and serves as the authoritative source
for trading calendar generation and market scheduling services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.holiday_calendar.holiday_calendar_id
IS 
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.holiday_calendar.public_id
IS 
'Immutable public identifier used for external integrations,
synchronization, and APIs.';

COMMENT ON COLUMN ref.holiday_calendar.exchange_id
IS 
'References the Exchange that observes this holiday.';

COMMENT ON COLUMN ref.holiday_calendar.holiday_date
IS 
'Gregorian calendar date of the holiday.';

COMMENT ON COLUMN ref.holiday_calendar.persian_date
IS 
'Equivalent Persian (Solar Hijri) calendar date.';

COMMENT ON COLUMN ref.holiday_calendar.holiday_name
IS 
'Official business name of the holiday.';

COMMENT ON COLUMN ref.holiday_calendar.holiday_type
IS 
'Classification of the holiday, such as National, Religious, Exchange, Regulatory or Extraordinary.';

COMMENT ON COLUMN ref.holiday_calendar.description
IS 
'Additional business information describing the holiday.';

COMMENT ON COLUMN ref.holiday_calendar.created_at
IS 
'Timestamp when the record was created.';

COMMENT ON COLUMN ref.holiday_calendar.created_by
IS 
'Identifier of the user or process that created the record.';

COMMENT ON COLUMN ref.holiday_calendar.updated_at
IS 
'Timestamp when the record was last updated.';

COMMENT ON COLUMN ref.holiday_calendar.updated_by
IS 
'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN ref.holiday_calendar.version
IS 
'Optimistic concurrency version number.';

