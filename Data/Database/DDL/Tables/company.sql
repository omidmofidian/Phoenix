/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : company.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Company
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Company master table.
 *
 * The Company table represents legal business entities recognized by the Phoenix Platform.
 * A company may issue one or more financial instruments supported by the Phoenix Platform.
 * Each company is classified by Exchange, Market, Trading Board, Industry, and
 * Sector, providing the master business entity for financial instruments,
 * market data, and analytical services throughout the Phoenix Platform.
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
 *     - Schema : market
 *     - Table  : ref.exchange
 *     - Table  : market.market
 *     - Table  : market.trading_board
 *     - Table  : ref.industry
 *     - Table  : ref.sector
 *
 * Referenced Objects
 *     - ref.exchange
 *     - market.market
 *     - market.trading_board
 *     - ref.industry
 *     - ref.sector
 *
 * Referenced By
 *     - market.instrument
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
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
 * - Exchange and Market references are intentionally stored together with Trading Board
 *   for analytical query optimization and classification performance.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-24
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-24   Canonical implementation aligned with the Physical Design
 *                        architecture.
 **************************************************************************************************/

CREATE TABLE market.company
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    company_id                  BIGINT
                                    GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                   UUID
                                    NOT NULL
                                    DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    company_code                        VARCHAR(20)
                                    NOT NULL,

    company_name                        VARCHAR(200)
                                    NOT NULL,

    company_short_name                  VARCHAR(100),

    company_local_name                  VARCHAR(200),

    national_id                 VARCHAR(50),

    registration_number         VARCHAR(50),

    economic_code               VARCHAR(50),

    company_display_order               SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

    company_description                 VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    exchange_id                 BIGINT
                                    NOT NULL,

    market_id                   BIGINT
                                    NOT NULL,

    trading_board_id            BIGINT
                                    NOT NULL,

    industry_id                 BIGINT
                                    NOT NULL,

    sector_id                   BIGINT
                                    NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    company_is_active                   BOOLEAN
                                    NOT NULL
                                    DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                  TIMESTAMPTZ
                                    NOT NULL
                                    DEFAULT CURRENT_TIMESTAMP,

    created_by                  BIGINT
                                    NOT NULL,

    updated_at                  TIMESTAMPTZ,

    updated_by                  BIGINT,

    row_version                     INTEGER
                                    NOT NULL
                                    DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_company
        PRIMARY KEY
        (
            company_id
        ),

    CONSTRAINT uk_company_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_company_code
        UNIQUE
        (
            company_code
        ),

    CONSTRAINT ck_company_code_not_empty
        CHECK
        (
            LENGTH(TRIM(company_code)) > 0
        ),

    CONSTRAINT ck_company_name_not_empty
        CHECK
        (
            LENGTH(TRIM(company_name)) > 0
        ),

    CONSTRAINT ck_company_short_name_not_empty
        CHECK 
        (
            company_short_name IS NULL
            OR LENGTH(TRIM(company_short_name)) > 0
        ),

    CONSTRAINT ck_company_local_name_not_empty
        CHECK 
        (
            company_local_name IS NULL
            OR LENGTH(TRIM(company_local_name)) > 0
        ),

    CONSTRAINT ck_company_national_id_not_empty
        CHECK 
        (
            national_id IS NULL
            OR LENGTH(TRIM(national_id)) > 0
        ),

    CONSTRAINT ck_company_registration_number_not_empty
        CHECK 
        (
            registration_number IS NULL
            OR LENGTH(TRIM(registration_number)) > 0
        ),

    CONSTRAINT ck_company_economic_code_not_empty
        CHECK 
        (
            economic_code IS NULL
            OR LENGTH(TRIM(economic_code)) > 0
        ),

    CONSTRAINT ck_company_description_not_empty
        CHECK 
        (
            company_description IS NULL
            OR LENGTH(TRIM(company_description)) > 0
        ),

    CONSTRAINT ck_company_display_order
        CHECK
        (
            company_display_order > 0
        ),

    CONSTRAINT ck_company_row_version_positive
        CHECK 
        (
            row_version > 0
        ),

    CONSTRAINT fk_company_exchange
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

    CONSTRAINT fk_company_market
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

    CONSTRAINT fk_company_exchange_market
        FOREIGN KEY 
        (
            exchange_id, 
            market_id
        )
        REFERENCES market.market 
        (
            exchange_id, 
            market_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_trading_board
        FOREIGN KEY
        (
            trading_board_id
        )
        REFERENCES market.trading_board
        (
            trading_board_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_market_trading_board
        FOREIGN KEY
        (
            market_id,
            trading_board_id
        )
        REFERENCES market.trading_board
        (
            market_id,
            trading_board_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_industry
        FOREIGN KEY
        (
            industry_id
        )
        REFERENCES ref.industry
        (
            industry_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_sector
        FOREIGN KEY
        (
            sector_id
        )
        REFERENCES ref.sector
        (
            sector_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
        
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.company
IS
'Master table containing the legal companies supported by the Phoenix Platform.
Each company is classified by exchange, market, trading board, industry, and
sector, and serves as the authoritative business entity for financial instruments,
market data, and analytical services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.company.company_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.company.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.company.company_code
IS
'Unique business code identifying the company.';

COMMENT ON COLUMN market.company.company_name
IS
'Official legal name of the company.';

COMMENT ON COLUMN market.company.company_short_name
IS
'Abbreviated company name used by user interfaces and reports.';

COMMENT ON COLUMN market.company.company_local_name
IS
'Official local-language name of the company.';

COMMENT ON COLUMN market.company.national_id
IS
'National legal identifier assigned to the company.';

COMMENT ON COLUMN market.company.registration_number
IS
'Official company registration number issued by the registration authority.';

COMMENT ON COLUMN market.company.economic_code
IS
'Official economic or tax identification code assigned to the company.';

COMMENT ON COLUMN market.company.company_display_order
IS
'Display sequence used by applications when presenting companies to users.';

COMMENT ON COLUMN market.company.company_description
IS
'Optional business description of the company.';

COMMENT ON COLUMN market.company.exchange_id
IS
'Reference to the parent exchange to which the company belongs.';

COMMENT ON COLUMN market.company.market_id
IS
'Reference to the parent market to which the company belongs.';

COMMENT ON COLUMN market.company.trading_board_id
IS
'Reference to the parent trading board to which the company belongs.';

COMMENT ON COLUMN market.company.industry_id
IS
'Reference to the parent industry to which the company belongs.';

COMMENT ON COLUMN market.company.sector_id
IS
'Reference to the parent sector to which the company belongs.';

COMMENT ON COLUMN market.company.company_is_active
IS
'Indicates whether the company is currently active and available for business operations.';

COMMENT ON COLUMN market.company.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.company.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.company.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.company.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.company.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------