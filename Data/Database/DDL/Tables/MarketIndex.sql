/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : market_index.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : MarketIndex
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical MarketIndex table.
 *
 * The MarketIndex table stores the master definition of financial market
 * indices supported by the Phoenix Platform.
 *
 * A market index represents a calculated benchmark derived from one or more
 * financial instruments and is used for market analysis, benchmarking,
 * performance measurement, portfolio evaluation, and reporting.
 *
 * This table stores only the static business definition of an index.
 * Historical index values are stored in dedicated fact tables.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - Domain Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 * - Naming Convention Standard
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : market
 *     - Schema : ref
 *
 * Referenced Objects
 *     - ref.exchange
 *     - market.market
 *     - ref.currency
 *     - ref.index_calculation_method
 *
 * Referenced By
 * -------------------------------------------------------------------------------------------------
 *     - DailyIndexData
 *     - IndexConstituent
 *     - IndexRebalance
 *     - Analytics Engine
 *     - Reporting Engine
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Stores index master data only.
 * - Does not store historical index values.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE market.market_index
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    market_index_id                BIGINT
                                       GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                      UUID
                                       NOT NULL
                                       DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business References
    ----------------------------------------------------------------------------

    exchange_id                    BIGINT
                                       NOT NULL,

    market_id                      BIGINT
                                       NOT NULL,

    currency_id                    BIGINT
                                       NOT NULL,

    index_calculation_method_id    BIGINT
                                       NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Identification
    ----------------------------------------------------------------------------

    market_index_code                     VARCHAR(50)
                                       NOT NULL,

    market_index_symbol                   VARCHAR(50)
                                       NOT NULL,

    market_index_name                     VARCHAR(200)
                                       NOT NULL,

    market_index_local_name                   VARCHAR(200),

    market_index_short_name                     VARCHAR(100),

    ----------------------------------------------------------------------------
    -- Description
    ----------------------------------------------------------------------------

    market_index_description                    TEXT,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    market_index_is_active                      BOOLEAN
                                       NOT NULL
                                       DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                     TIMESTAMPTZ
                                       NOT NULL
                                       DEFAULT CURRENT_TIMESTAMP,

    created_by                     BIGINT
                                       NOT NULL,

    updated_at                     TIMESTAMPTZ,

    updated_by                     BIGINT,

    row_version                        INTEGER
                                       NOT NULL
                                       DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_market_index
        PRIMARY KEY
        (
            market_index_id
        ),

    CONSTRAINT uk_market_index_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_market_index_code
        UNIQUE
        (
            exchange_id,
            market_index_code
        ),

    CONSTRAINT uk_market_index_symbol
        UNIQUE
        (
            exchange_id,
            market_index_symbol
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------
    
    CONSTRAINT ck_market_index_code_not_empty
        CHECK 
        (
            LENGTH(TRIM(market_index_code)) > 0
        ),

    CONSTRAINT ck_market_index_symbol_not_empty
        CHECK 
        (
            LENGTH(TRIM(market_index_symbol)) > 0
        ),

    CONSTRAINT ck_market_index_name_not_empty
        CHECK 
        (
            LENGTH(TRIM(market_index_name)) > 0
        ),

    CONSTRAINT ck_market_index_local_name_not_empty
        CHECK
        (
            market_index_local_name IS NULL
            OR LENGTH(TRIM(market_index_local_name)) > 0
        ),

    CONSTRAINT ck_market_index_short_name_not_empty
        CHECK
        (
            market_index_short_name IS NULL
            OR LENGTH(TRIM(market_index_short_name)) > 0
        ),

    CONSTRAINT ck_market_index_description_not_empty
        CHECK
        (
            market_index_description IS NULL
            OR LENGTH(TRIM(market_index_description)) > 0
        ),

    CONSTRAINT ck_market_index_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    ----------------------------------------------------------------------------
    -- Foreign Keys
    ----------------------------------------------------------------------------

    CONSTRAINT fk_market_index_exchange
        FOREIGN KEY
        (
            exchange_id
        )
        REFERENCES ref.exchange
        (
            exchange_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_market_index_market
        FOREIGN KEY
        (
            market_id
        )
        REFERENCES ref.market
        (
            market_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_market_index_calculation_method
        FOREIGN KEY 
        (
            index_calculation_method_id
        )
        REFERENCES ref.index_calculation_method
        (
            index_calculation_method_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_market_index_currency
        FOREIGN KEY
        (
            currency_id
        )
        REFERENCES ref.currency
        (
            currency_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.market_index
IS
'Stores the canonical master definition of financial market indices supported by
the Phoenix Platform. Each record represents a business definition of a market
index. Historical index values and constituent changes are stored in dedicated
fact tables.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.market_index_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.market_index.public_id
IS
'Immutable public identifier used for APIs, synchronization, integrations, and distributed systems.';

----------------------------------------------------------------------------
-- Business References
----------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.exchange_id
IS
'Reference to the exchange responsible for publishing the market index.';

COMMENT ON COLUMN market.market_index.market_id
IS
'Reference to the market to which the index belongs.';

COMMENT ON COLUMN market.market_index.currency_id
IS
'Reference to the currency used when publishing the index value.';

----------------------------------------------------------------------------
-- Business Identification
----------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.market_index_code
IS
'Unique business code identifying the market index within an exchange.';

COMMENT ON COLUMN market.market_index.market_index_symbol
IS
'Official trading or reporting symbol representing the market index.';

COMMENT ON COLUMN market.market_index.market_index_name
IS
'Official business name of the market index.';

COMMENT ON COLUMN market.market_index.market_index_local_name
IS
'Official local-language name of the market index.';

COMMENT ON COLUMN market.market_index.market_index_short_name
IS
'Short display name used in user interfaces and reports.';

----------------------------------------------------------------------------
-- Description
----------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.market_index_description
IS
'Optional business description of the market index.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.market_index_is_active
IS
'Indicates whether the market index is active within the Phoenix Platform.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN market.market_index.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.market_index.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.market_index.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.market_index.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.market_index.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------