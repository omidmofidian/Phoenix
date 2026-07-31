/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : Market_Session.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : MarketSession
* Schema           : market
* Version          : 2026.1
* Status           : Approved
*
* Description
* -------------------------------------------------------------------------------------------------
* Creates the canonical MarketSession table.
*
* The MarketSession table defines the operational trading schedule of a market.
* Each record associates one Market with one standardized Trading Session and
* specifies the calendar, time zone, weekday, and daily operating time range
* during which that session is active.
*
* This table provides the authoritative market schedule used by trading
* calendars, market data validation, session management, scheduling services,
* and analytical engines throughout the Phoenix Platform.
*
* Architectural Source
* -------------------------------------------------------------------------------------------------
* * ADR-022 Repository Architecture
* * ADR-026 Normalize Reference Data Model
* * ADR-027 Canonical Market Data Model
* * ADR-028 Market Classification Strategy
* * Domain Model
* * Enterprise Data Dictionary
* * Logical Database Model
* * Physical Database Model
* * TablePhysicalSpecifications.md
* * ConstraintSpecifications.md
* * DDLTemplateSpecification.md
*
* Dependencies
* -------------------------------------------------------------------------------------------------
* Prerequisites
*     - Schema : market
*     - Schema : ref
*     - Table  : market.market
*     - Table  : ref.trading_session
*     - Table  : ref.calendar_type
*     - Table  : ref.time_zone
*
* Referenced Objects
*     - market.market
*     - ref.trading_session
*     - ref.calendar_type
*     - ref.time_zone
*
* Referenced By
*     - market.daily_market_data
*     - Trading Calendar Engine
*     - Scheduling Services
*     - Data Validation Services
*     - Analytics Services
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
* - One record represents one Market, one Trading Session, one Day of Week,
*   one Calendar Type, and one Time Zone.
*
* Author           : Phoenix Architecture Team
* Created          : 2026-07-30
*
* Revision History
* -------------------------------------------------------------------------------------------------
* Version   Date         Description
* -------   ----------   ---------------------------------------------------------
* 2026.1    2026-07-30   Canonical enterprise implementation.
  **************************************************************************************************/

CREATE TABLE market.market_session
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------

market_session_id                    BIGINT
                                         GENERATED ALWAYS AS IDENTITY,

----------------------------------------------------------------------------
-- Public Identifier
----------------------------------------------------------------------------

public_id                            UUID
                                         NOT NULL
                                         DEFAULT gen_random_uuid(),

----------------------------------------------------------------------------
-- Classification References
----------------------------------------------------------------------------

market_id                            BIGINT
                                         NOT NULL,

trading_session_id                   BIGINT
                                         NOT NULL,

calendar_type_id                     BIGINT
                                         NOT NULL,

time_zone_id                         BIGINT
                                         NOT NULL,

----------------------------------------------------------------------------
-- Business Attributes
----------------------------------------------------------------------------

day_of_week                          SMALLINT
                                         NOT NULL,

start_time                           TIME
                                         NOT NULL,

end_time                             TIME
                                         NOT NULL,

session_sequence                     SMALLINT
                                         NOT NULL
                                         DEFAULT 1,

market_session_description           VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

market_session_is_active             BOOLEAN
                                         NOT NULL
                                         DEFAULT TRUE,

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

created_at                           TIMESTAMPTZ
                                         NOT NULL
                                         DEFAULT CURRENT_TIMESTAMP,

created_by                           BIGINT
                                         NOT NULL,

updated_at                           TIMESTAMPTZ,

updated_by                           BIGINT,

row_version                          INTEGER
                                         NOT NULL
                                         DEFAULT 1,

----------------------------------------------------------------------------
-- Constraints
----------------------------------------------------------------------------

CONSTRAINT pk_market_session
    PRIMARY KEY
    (
        market_session_id
    ),

CONSTRAINT uk_market_session_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_market_session_business
    UNIQUE
    (
        market_id,
        trading_session_id,
        calendar_type_id,
        day_of_week
    ),

----------------------------------------------------------------------------
-- Check Constraints
----------------------------------------------------------------------------

CONSTRAINT ck_market_session_day_of_week
    CHECK
    (
        day_of_week BETWEEN 1 AND 7
    ),

CONSTRAINT ck_market_session_time_range
    CHECK
    (
        end_time > start_time
    ),

CONSTRAINT ck_market_session_sequence
    CHECK
    (
        session_sequence > 0
    ),

CONSTRAINT ck_market_session_description_not_empty
    CHECK
    (
        market_session_description IS NULL
        OR LENGTH(TRIM(market_session_description)) > 0
    ),

CONSTRAINT ck_market_session_row_version_positive
    CHECK
    (
        row_version > 0
    ),

----------------------------------------------------------------------------
-- Foreign Keys
----------------------------------------------------------------------------

CONSTRAINT fk_market_session_market
    FOREIGN KEY
    (
        market_id
    )
    REFERENCES market.market
    (
        market_id
    )
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

CONSTRAINT fk_market_session_trading_session
    FOREIGN KEY
    (
        trading_session_id
    )
    REFERENCES ref.trading_session
    (
        trading_session_id
    )
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

CONSTRAINT fk_market_session_calendar_type
    FOREIGN KEY
    (
        calendar_type_id
    )
    REFERENCES ref.calendar_type
    (
        calendar_type_id
    )
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,

CONSTRAINT fk_market_session_time_zone
    FOREIGN KEY
    (
        time_zone_id
    )
    REFERENCES ref.time_zone
    (
        time_zone_id
    )
    ON UPDATE RESTRICT
    ON DELETE RESTRICT

);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.market_session
IS
'Defines the operational trading schedule of a market within the Phoenix
Platform. Each record associates one market with one standardized trading
session, calendar type, and time zone, and specifies the weekday and operating
time range during which that session is active.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.market_session.market_session_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.market_session.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.market_session.market_id
IS
'Reference to the market for which the trading schedule is defined.';

COMMENT ON COLUMN market.market_session.trading_session_id
IS
'Reference to the standardized trading session type associated with the market schedule.';

COMMENT ON COLUMN market.market_session.calendar_type_id
IS
'Reference to the calendar system used by the market schedule.';

COMMENT ON COLUMN market.market_session.time_zone_id
IS
'Reference to the time zone in which the market schedule is defined.';

COMMENT ON COLUMN market.market_session.day_of_week
IS
'ISO weekday number on which the trading session occurs (1=Monday through 7=Sunday).';

COMMENT ON COLUMN market.market_session.start_time
IS
'Local start time of the trading session.';

COMMENT ON COLUMN market.market_session.end_time
IS
'Local end time of the trading session.';

COMMENT ON COLUMN market.market_session.session_sequence
IS
'Execution order of the trading session within the trading day when multiple sessions exist.';

COMMENT ON COLUMN market.market_session.market_session_description
IS
'Optional business description of the market session schedule.';

COMMENT ON COLUMN market.market_session.market_session_is_active
IS
'Indicates whether the market session schedule is currently active and available for business operations.';

COMMENT ON COLUMN market.market_session.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.market_session.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.market_session.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.market_session.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.market_session.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------