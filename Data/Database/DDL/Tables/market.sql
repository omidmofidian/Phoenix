/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : market.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Market
 * Schema           : reference
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
 *
 * Referenced Objects
 *     - reference.exchange
 *
 * Referenced By
 *     - reference.trading_board
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

CREATE TABLE reference.market
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    id                      BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id               UUID
                                NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    exchange_id             BIGINT
                                NOT NULL,

    code                    VARCHAR(20)
                                NOT NULL,

    name                    VARCHAR(200)
                                NOT NULL,

    short_name              VARCHAR(100),

    english_name            VARCHAR(200),

    display_order           SMALLINT
                                NOT NULL
                                DEFAULT 1,

    description             VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active               BOOLEAN
                                NOT NULL
                                DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at              TIMESTAMPTZ
                                NOT NULL
                                DEFAULT CURRENT_TIMESTAMP,

    created_by              BIGINT
                                NOT NULL,

    updated_at              TIMESTAMPTZ,

    updated_by              BIGINT,

    version                 INTEGER
                                NOT NULL
                                DEFAULT 1,
                                    
                                    
                                    
    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_market
        PRIMARY KEY
        (
            id
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
            code
        ),

    CONSTRAINT ck_market_code_not_empty
        CHECK
        (
            LENGTH(TRIM(code)) > 0
        ),

    CONSTRAINT ck_market_name_not_empty
        CHECK
        (
            LENGTH(TRIM(name)) > 0
        ),

    CONSTRAINT ck_market_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT fk_market_exchange
        FOREIGN KEY
        (
            exchange_id
        )
        REFERENCES reference.exchange
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.market
IS
'Reference table containing the business markets supported by the Phoenix Platform.
Each market belongs to exactly one exchange and serves as the authoritative source
for market classification throughout the platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.market.id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN reference.market.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN reference.market.exchange_id
IS
'Reference to the parent exchange to which the market belongs.';

COMMENT ON COLUMN reference.market.code
IS
'Unique business code identifying the market within its parent exchange.';

COMMENT ON COLUMN reference.market.name
IS
'Official business name of the market.';

COMMENT ON COLUMN reference.market.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN reference.market.english_name
IS
'Official English name of the market when applicable.';

COMMENT ON COLUMN reference.market.display_order
IS
'Display sequence used by applications when presenting markets to users.';

COMMENT ON COLUMN reference.market.description
IS
'Optional business description of the market.';

COMMENT ON COLUMN reference.market.is_active
IS
'Indicates whether the market is currently active and available for business operations.';

COMMENT ON COLUMN reference.market.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN reference.market.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN reference.market.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN reference.market.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN reference.market.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------