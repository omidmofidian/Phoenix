/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : company.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Company
 * Schema           : reference
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Company reference table.
 *
 * The Company table represents the legal entities listed on supported exchanges.
 * Each company is classified by Exchange, Market, Trading Board, Industry, and
 * Sector, providing the master business entity for financial instruments,
 * market data, and analytical services throughout the Phoenix Platform.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - Physical Database Model
 * - PostgreSQLPhysicalDatabaseDesign.md
 * - PostgreSQLDesignDecisions.md
 * - TablePhysicalSpecifications.md
 * - ConstraintSpecifications.md
 * - DDLTemplateSpecification.md
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : reference
 *     - Table  : reference.exchange
 *     - Table  : reference.market
 *     - Table  : reference.trading_board
 *     - Table  : reference.industry
 *     - Table  : reference.sector
 *
 * Referenced Objects
 *     - reference.exchange
 *     - reference.market
 *     - reference.trading_board
 *     - reference.industry
 *     - reference.sector
 *
 * Referenced By
 *     - reference.instrument
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

CREATE TABLE reference.company
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    id                          BIGINT
                                    GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                   UUID
                                    NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    code                        VARCHAR(20)
                                    NOT NULL,

    name                        VARCHAR(250)
                                    NOT NULL,

    short_name                  VARCHAR(100),

    english_name                VARCHAR(250),

    national_id                 VARCHAR(50),

    registration_number         VARCHAR(50),

    economic_code               VARCHAR(50),

    display_order               SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

    description                 VARCHAR(500),

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

    is_active                   BOOLEAN
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

    version                     INTEGER
                                    NOT NULL
                                    DEFAULT 1,

        ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_company
        PRIMARY KEY
        (
            id
        ),

    CONSTRAINT uk_company_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_company_code
        UNIQUE
        (
            code
        ),

    CONSTRAINT ck_company_code_not_empty
        CHECK
        (
            LENGTH(TRIM(code)) > 0
        ),

    CONSTRAINT ck_company_name_not_empty
        CHECK
        (
            LENGTH(TRIM(name)) > 0
        ),

    CONSTRAINT ck_company_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT fk_company_exchange
        FOREIGN KEY
        (
            exchange_id
        )
        REFERENCES reference.exchange
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_market
        FOREIGN KEY
        (
            market_id
        )
        REFERENCES reference.market
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_trading_board
        FOREIGN KEY
        (
            trading_board_id
        )
        REFERENCES reference.trading_board
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_industry
        FOREIGN KEY
        (
            industry_id
        )
        REFERENCES reference.industry
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_company_sector
        FOREIGN KEY
        (
            sector_id
        )
        REFERENCES reference.sector
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.company
IS
'Reference table containing the legal companies supported by the Phoenix Platform.
Each company is classified by exchange, market, trading board, industry, and
sector, and serves as the authoritative business entity for financial instruments,
market data, and analytical services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.company.id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN reference.company.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN reference.company.code
IS
'Unique business code identifying the company.';

COMMENT ON COLUMN reference.company.name
IS
'Official legal name of the company.';

COMMENT ON COLUMN reference.company.short_name
IS
'Abbreviated company name used by user interfaces and reports.';

COMMENT ON COLUMN reference.company.english_name
IS
'Official English name of the company when applicable.';

COMMENT ON COLUMN reference.company.national_id
IS
'National legal identifier assigned to the company.';

COMMENT ON COLUMN reference.company.registration_number
IS
'Official company registration number issued by the registration authority.';

COMMENT ON COLUMN reference.company.economic_code
IS
'Official economic or tax identification code assigned to the company.';

COMMENT ON COLUMN reference.company.display_order
IS
'Display sequence used by applications when presenting companies to users.';

COMMENT ON COLUMN reference.company.description
IS
'Optional business description of the company.';

COMMENT ON COLUMN reference.company.exchange_id
IS
'Reference to the parent exchange to which the company belongs.';

COMMENT ON COLUMN reference.company.market_id
IS
'Reference to the parent market to which the company belongs.';

COMMENT ON COLUMN reference.company.trading_board_id
IS
'Reference to the parent trading board to which the company belongs.';

COMMENT ON COLUMN reference.company.industry_id
IS
'Reference to the parent industry to which the company belongs.';

COMMENT ON COLUMN reference.company.sector_id
IS
'Reference to the parent sector to which the company belongs.';

COMMENT ON COLUMN reference.company.is_active
IS
'Indicates whether the company is currently active and available for business operations.';

COMMENT ON COLUMN reference.company.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN reference.company.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN reference.company.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN reference.company.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN reference.company.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------