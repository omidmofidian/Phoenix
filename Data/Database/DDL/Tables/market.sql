/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : market.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Market
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Market reference table.
 *
 * The Market table represents the business markets operating within a supported
 * stock exchange. Each market belongs to exactly one Exchange and serves as the
 * parent entity for trading boards and other market classification structures.
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
 *
 * Referenced Objects
 *     - ref.exchange
 *
 * Referenced By
 *     - market.trading_board
 *     - Additional market classification entities
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

CREATE TABLE market.market
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    market_id                      BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                      UUID
                                    NOT NULL
                                     DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    exchange_id             BIGINT
                                NOT NULL,

    market_code                    VARCHAR(20)
                                NOT NULL,

    market_name                    VARCHAR(200)
                                NOT NULL,

    market_short_name              VARCHAR(100),

    market_local_name             VARCHAR(200),

    market_display_order           SMALLINT
                                NOT NULL
                                DEFAULT 1,

    market_description             VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    market_is_active               BOOLEAN
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

    CONSTRAINT pk_market
        PRIMARY KEY
        (
            market_id
        ),

    CONSTRAINT uk_market_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_market_exchange_code
        UNIQUE
        (
            exchange_id,
            market_code
        ),

    CONSTRAINT uk_market_exchange_market
        UNIQUE 
        (
            exchange_id, 
            market_id
        ),

    CONSTRAINT ck_market_code_not_empty
        CHECK
        (
            LENGTH(TRIM(market_code)) > 0
        ),

    CONSTRAINT ck_market_name_not_empty
        CHECK
        (
            LENGTH(TRIM(market_name)) > 0
        ),

    CONSTRAINT ck_market_short_name_not_empty
        CHECK 
        (
            market_short_name IS NULL
            OR LENGTH(TRIM(market_short_name)) > 0
        ),

    CONSTRAINT ck_market_local_name_not_empty
        CHECK 
        (
            market_local_name IS NULL
            OR LENGTH(TRIM(market_local_name)) > 0
        ),

    CONSTRAINT ck_market_description_not_empty
        CHECK 
        (
            market_description IS NULL
            OR LENGTH(TRIM(market_description)) > 0
        ),

    CONSTRAINT ck_country_row_version_positive
        CHECK 
        (
            row_version > 0
        ),

    CONSTRAINT ck_market_display_order
        CHECK
        (
            market_display_order > 0
        ),

    CONSTRAINT fk_market_exchange
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

COMMENT ON TABLE market.market
IS
'Reference table containing the business markets supported by the Phoenix Platform.
Each market belongs to exactly one exchange and serves as the authoritative source
for market classification throughout the platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.market.market_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.market.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.market.exchange_id
IS
'Reference to the parent exchange to which the market belongs.';

COMMENT ON COLUMN market.market.market_code
IS
'Unique business code identifying the market within its parent exchange.';

COMMENT ON COLUMN market.market.market_name
IS
'Official business name of the market.';

COMMENT ON COLUMN market.market.market_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN market.market.market_local_name
IS
'Official local-language name of the market.';

COMMENT ON COLUMN market.market.market_display_order
IS
'Display sequence used by applications when presenting markets to users.';

COMMENT ON COLUMN market.market.market_description
IS
'Optional business description of the market.';

COMMENT ON COLUMN market.market.market_is_active
IS
'Indicates whether the market is currently active and available for business operations.';

COMMENT ON COLUMN market.market.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.market.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.market.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.market.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.market.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------