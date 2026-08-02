/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : market_data_frequency.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : MarketDataFrequency
* Schema           : ref
* Version          : 2026.1
* Status           : Approved
*
* Description
* -------------------------------------------------------------------------------------------------
* Creates the canonical MarketDataFrequency reference table.
*
* The MarketDataFrequency table defines the standardized frequencies used for
* market data aggregation, storage, analytics, and reporting throughout the
* Phoenix Platform.
*
* Each market data record belongs to exactly one frequency classification,
* enabling consistent representation of tick, intraday, daily, weekly,
* monthly, quarterly, yearly, and custom market data intervals across all
* supported financial markets.
*
* This table provides standardized frequency classifications used throughout
* market data processing, feature engineering, backtesting, analytics,
* reporting, and multi-market platform operations.
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
*     - market.daily_market_data
*     - market.tick_data
*     - market.order_book_snapshot
*     - Future analytical and aggregation entities
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
* Created          : 2026-08-02
*
* Revision History
* -------------------------------------------------------------------------------------------------
* Version   Date         Description
* -------   ----------   ---------------------------------------------------------
* 2026.1    2026-08-02   Initial canonical implementation.
  **************************************************************************************************/

CREATE TABLE ref.market_data_frequency
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------

market_data_frequency_id            BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

----------------------------------------------------------------------------
-- Public Identifier
----------------------------------------------------------------------------

public_id                           UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

----------------------------------------------------------------------------
-- Business Attributes
----------------------------------------------------------------------------

market_data_frequency_code           VARCHAR(50)
                                        NOT NULL,

market_data_frequency_name           VARCHAR(100)
                                        NOT NULL,

market_data_frequency_short_name     VARCHAR(50),

market_data_frequency_local_name     VARCHAR(100),

market_data_frequency_display_order  SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

market_data_frequency_description    VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

market_data_frequency_is_active      BOOLEAN
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

CONSTRAINT pk_market_data_frequency
    PRIMARY KEY
    (
        market_data_frequency_id
    ),

CONSTRAINT uk_market_data_frequency_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_market_data_frequency_code
    UNIQUE
    (
        market_data_frequency_code
    ),

CONSTRAINT uk_market_data_frequency_name
    UNIQUE
    (
        market_data_frequency_name
    ),

CONSTRAINT ck_market_data_frequency_code_not_empty
    CHECK
    (
        LENGTH(TRIM(market_data_frequency_code)) > 0
    ),

CONSTRAINT ck_market_data_frequency_code_uppercase
    CHECK
    (
        market_data_frequency_code = UPPER(market_data_frequency_code)
    ),

CONSTRAINT ck_market_data_frequency_name_not_empty
    CHECK
    (
        LENGTH(TRIM(market_data_frequency_name)) > 0
    ),

CONSTRAINT ck_market_data_frequency_short_name_not_empty
    CHECK
    (
        market_data_frequency_short_name IS NULL
        OR LENGTH(TRIM(market_data_frequency_short_name)) > 0
    ),

CONSTRAINT ck_market_data_frequency_local_name_not_empty
    CHECK
    (
        market_data_frequency_local_name IS NULL
        OR LENGTH(TRIM(market_data_frequency_local_name)) > 0
    ),

CONSTRAINT ck_market_data_frequency_display_order_positive
    CHECK
    (
        market_data_frequency_display_order > 0
    ),

CONSTRAINT ck_market_data_frequency_description_not_empty
    CHECK
    (
        market_data_frequency_description IS NULL
        OR LENGTH(TRIM(market_data_frequency_description)) > 0
    ),

CONSTRAINT ck_market_data_frequency_row_version_positive
    CHECK
    (
        row_version > 0
    )

);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.market_data_frequency
IS
'Reference table defining the standardized frequencies used for market data
aggregation, storage, analytics, and reporting throughout the Phoenix Platform.
Each record represents a canonical market data frequency such as Tick, Second,
Minute, Hourly, Daily, Weekly, Monthly, Quarterly, or Yearly used across
supported financial markets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.market_data_frequency.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_code
IS
'Unique business code identifying the market data frequency.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_name
IS
'Official business name of the market data frequency.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_short_name
IS
'Abbreviated name used by applications, reports, and user interfaces.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_local_name
IS
'Official local-language name of the market data frequency.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_display_order
IS
'Display sequence used by applications when presenting market data frequencies
to users.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_description
IS
'Optional business description providing additional information about the
market data frequency.';

COMMENT ON COLUMN ref.market_data_frequency.market_data_frequency_is_active
IS
'Indicates whether the market data frequency is currently active and available
for business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.market_data_frequency.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.market_data_frequency.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.market_data_frequency.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.market_data_frequency.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.market_data_frequency.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------