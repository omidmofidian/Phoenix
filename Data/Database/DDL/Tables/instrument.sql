/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : instrument.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Instrument
 * Schema           : reference
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Instrument reference table.
 *
 * The Instrument table represents the tradable financial instruments supported
 * by the Phoenix Platform. Each instrument belongs to exactly one Company and
 * represents the security traded on a specific trading board. This entity is the
 * master reference for market data, corporate actions, analytics, portfolio
 * management, and trading services.
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
 *     - Table  : reference.company
 *
 * Referenced Objects
 *     - reference.company
 *
 * Referenced By
 *     - market.daily_market_data
 *     - market.corporate_action
 *     - portfolio.position
 *     - analytics.feature
 *     - Additional transactional entities
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

CREATE TABLE reference.instrument
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

    code                        VARCHAR(50)
                                    NOT NULL,

    ticker                      VARCHAR(50)
                                    NOT NULL,

    name                        VARCHAR(250)
                                    NOT NULL,

    short_name                  VARCHAR(100),

    english_name                VARCHAR(250),

    isin                        VARCHAR(12),

    display_order               SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

    description                 VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Classification Reference
    ----------------------------------------------------------------------------

    company_id                  BIGINT
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

    CONSTRAINT pk_instrument
        PRIMARY KEY
        (
            id
        ),

    CONSTRAINT uk_instrument_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_instrument_code
        UNIQUE
        (
            code
        ),

    CONSTRAINT uk_instrument_ticker
        UNIQUE
        (
            ticker
        ),

    CONSTRAINT uk_instrument_isin
        UNIQUE
        (
            isin
        ),

    CONSTRAINT ck_instrument_code_not_empty
        CHECK
        (
            LENGTH(TRIM(code)) > 0
        ),

    CONSTRAINT ck_instrument_ticker_not_empty
        CHECK
        (
            LENGTH(TRIM(ticker)) > 0
        ),

    CONSTRAINT ck_instrument_name_not_empty
        CHECK
        (
            LENGTH(TRIM(name)) > 0
        ),

    CONSTRAINT ck_instrument_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT fk_instrument_company
        FOREIGN KEY
        (
            company_id
        )
        REFERENCES reference.company
        (
            id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.instrument
IS
'Reference table containing the tradable financial instruments supported by the
Phoenix Platform. Each instrument belongs to exactly one company and serves as
the authoritative master entity for market data, trading, analytics, portfolio
management, and other investment services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.instrument.id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN reference.instrument.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN reference.instrument.code
IS
'Unique internal business code identifying the financial instrument.';

COMMENT ON COLUMN reference.instrument.ticker
IS
'Trading ticker or trading symbol assigned by the exchange.';

COMMENT ON COLUMN reference.instrument.name
IS
'Official business name of the financial instrument.';

COMMENT ON COLUMN reference.instrument.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN reference.instrument.english_name
IS
'Official English name of the financial instrument when applicable.';

COMMENT ON COLUMN reference.instrument.isin
IS
'International Securities Identification Number (ISIN).';

COMMENT ON COLUMN reference.instrument.display_order
IS
'Display sequence used by applications when presenting financial instruments to users.';

COMMENT ON COLUMN reference.instrument.description
IS
'Optional business description of the financial instrument.';

COMMENT ON COLUMN reference.instrument.company_id
IS
'Reference to the parent company that issued the financial instrument.';

COMMENT ON COLUMN reference.instrument.is_active
IS
'Indicates whether the financial instrument is currently active and available for trading and business operations.';

COMMENT ON COLUMN reference.instrument.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN reference.instrument.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN reference.instrument.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN reference.instrument.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN reference.instrument.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------