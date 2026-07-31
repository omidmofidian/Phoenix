/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : currency.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Currency
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Currency reference table.
 *
 * The Currency table defines the standardized monetary units supported by the
 * Phoenix Platform. It serves as the authoritative reference for fiat
 * currencies, cryptocurrencies, commodity-based currencies, and any future
 * monetary instruments supported by the platform.
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
 *     None
 *
 * Referenced By
 *     - market.company
 *     - market.instrument
 *     - market.exchange_rate
 *     - market.daily_market_data
 *     - portfolio.position
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
 * - Supports fiat currencies, cryptocurrencies and commodity-based currencies.
 * - ISO 4217 compatible where applicable.
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

 CREATE TABLE ref.currency
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    currency_id             BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id               UUID
                                NOT NULL
                                DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    currency_code           VARCHAR(10)
                                NOT NULL,

    iso_numeric_code        CHAR(3),

    currency_name           VARCHAR(200)
                                NOT NULL,

    currency_local_name              VARCHAR(200),

    symbol                  VARCHAR(20),

    currency_category       VARCHAR(20)
                                NOT NULL,

    decimal_digits          SMALLINT
                        NOT NULL
                        DEFAULT 2,

    currency_display_order           SMALLINT
                                NOT NULL
                                DEFAULT 1,

    currency_description             VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    currency_is_active               BOOLEAN
                                NOT NULL
                                DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

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

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_currency
        PRIMARY KEY
        (
            currency_id
        ),

    CONSTRAINT uk_currency_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_currency_code
        UNIQUE
        (
            currency_code
        ),

    CONSTRAINT uk_currency_iso_numeric_code
        UNIQUE
        (
            iso_numeric_code
        ),

    CONSTRAINT ck_currency_code_not_empty
        CHECK
        (
            LENGTH(TRIM(currency_code)) > 0
        ),

    CONSTRAINT ck_currency_code_length
        CHECK 
        (
            LENGTH(TRIM(currency_code)) BETWEEN 2 AND 10
        ),

    CONSTRAINT ck_currency_iso_numeric_length
    CHECK 
    (
        iso_numeric_code IS NULL
        OR LENGTH(TRIM(iso_numeric_code)) = 3
    ),

    CONSTRAINT ck_currency_name_not_empty
        CHECK
        (
            LENGTH(TRIM(currency_name)) > 0
        ),

    CONSTRAINT ck_currency_local_name_not_empty
        CHECK 
        (
            currency_local_name IS NULL
            OR LENGTH(TRIM(currency_local_name)) > 0
        ),

    CONSTRAINT ck_currency_symbol_not_empty
        CHECK 
        (
            symbol IS NULL
            OR LENGTH(TRIM(symbol)) > 0
        ),

    CONSTRAINT ck_currency_description_not_empty
        CHECK 
        (
            currency_description IS NULL
            OR LENGTH(TRIM(currency_description)) > 0
        ),

    CONSTRAINT ck_currency_category
        CHECK
        (
            currency_category IN
            (
                'FIAT',
                'CRYPTO',
                'COMMODITY'
            )
        ),

    CONSTRAINT ck_currency_decimal_digits
        CHECK
        (
            decimal_digits >= 0
            AND decimal_digits <= 18
        ),

    CONSTRAINT ck_currency_display_order
        CHECK
        (
            currency_display_order > 0
        ),

    
    CONSTRAINT ck_currency_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.currency
IS
'Reference table containing the standardized currencies supported by the
Phoenix Platform. Each currency represents an authoritative monetary unit used
throughout the platform for pricing, valuation, settlement, reporting, and
financial analysis. The table supports fiat currencies, cryptocurrencies, and
commodity-based currencies.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.currency.currency_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.currency.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.currency.currency_code
IS
'Unique business code identifying the currency, typically based on the ISO 4217 alphabetic code where applicable.';

COMMENT ON COLUMN ref.currency.iso_numeric_code
IS
'ISO 4217 numeric currency code where applicable.';

COMMENT ON COLUMN ref.currency.currency_name
IS
'Official business name of the currency.';

COMMENT ON COLUMN ref.currency.currency_local_name
IS
'Official local-language name of the currency.';

COMMENT ON COLUMN ref.currency.symbol
IS
'Currency symbol used for display purposes.';

COMMENT ON COLUMN ref.currency.currency_category
IS
'Classification of the currency, such as FIAT, CRYPTO, or COMMODITY.';

COMMENT ON COLUMN ref.currency.decimal_digits
IS
'Number of fractional decimal digits supported by the currency.';

COMMENT ON COLUMN ref.currency.currency_display_order
IS
'Display sequence used by applications when presenting currencies to users.';

COMMENT ON COLUMN ref.currency.currency_description
IS
'Optional business description of the currency.';

COMMENT ON COLUMN ref.currency.currency_is_active
IS
'Indicates whether the currency is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.currency.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.currency.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.currency.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.currency.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.currency.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';