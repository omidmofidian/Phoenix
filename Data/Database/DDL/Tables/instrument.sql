/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : instrument.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Instrument
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Instrument reference table.
 *
 * The Instrument table represents the tradable financial instruments supported
 * by the Phoenix Platform. Each instrument belongs to exactly one Company and 
 * represents a tradable financial security issued by that company.
 * This entity is the master reference for market data, corporate actions, 
 * analytics, portfolio management, and trading services.
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
 *     - Table  : market.company
 *
 * Referenced Objects
 *     - market.company
 *
 * Referenced By
 *     - market.daily_market_data
 *     - market.corporate_action
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

CREATE TABLE ref.instrument
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_id                          BIGINT
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

    instrument_code                        VARCHAR(50)
                                    NOT NULL,

    ticker                      VARCHAR(50)
                                    NOT NULL,

    instrument_name                        VARCHAR(200)
                                    NOT NULL,

    short_name                  VARCHAR(100),

    local_name                  VARCHAR(200),

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

    instrument_type_id          BIGINT 
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

    updated_at                  TIMESTAMPTZ,

    created_by                  BIGINT
                                    NOT NULL,

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
            instrument_id
        ),

    CONSTRAINT uk_instrument_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_instrument_code
        UNIQUE
        (
            instrument_code
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
            LENGTH(TRIM(instrument_code)) > 0
        ),

    CONSTRAINT ck_instrument_ticker_not_empty
        CHECK
        (
            LENGTH(TRIM(ticker)) > 0
        ),

    CONSTRAINT ck_instrument_name_not_empty
        CHECK
        (
            LENGTH(TRIM(instrument_name)) > 0
        ),

    CONSTRAINT ck_instrument_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_instrument_isin_length
        CHECK
        (
            isin IS NULL
            OR LENGTH(TRIM(isin)) = 12
        ),

    CONSTRAINT fk_instrument_company
        FOREIGN KEY
        (
            company_id
        )
        REFERENCES market.company
        (
            company_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_instrument_type
        FOREIGN KEY 
        (
            instrument_type_id
        )
        REFERENCES ref.instrument_type 
        (
            instrument_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.instrument
IS
'Reference table containing the tradable financial instruments supported by the
Phoenix Platform. Each instrument represents a tradable financial security
issued by exactly one company and serves as the authoritative master entity for
market data, corporate actions, analytics, and investment services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.instrument.instrument_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.instrument.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.instrument.instrument_code
IS
'Unique internal business code identifying the financial instrument.';

COMMENT ON COLUMN ref.instrument.ticker
IS
'Trading ticker or trading symbol assigned by the exchange.';

COMMENT ON COLUMN ref.instrument.instrument_name
IS
'Official business name of the financial instrument.';

COMMENT ON COLUMN ref.instrument.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.instrument.local_name
IS
'Official local-language name of the financial instrument.';

COMMENT ON COLUMN ref.instrument.isin
IS
'International Securities Identification Number (ISIN) assigned to the instrument.';

COMMENT ON COLUMN ref.instrument.display_order
IS
'Display sequence used by applications when presenting financial instruments to users.';

COMMENT ON COLUMN ref.instrument.description
IS
'Optional business description of the financial instrument.';

COMMENT ON COLUMN ref.instrument.company_id
IS
'Reference to the parent company that issued the financial instrument.';

COMMENT ON COLUMN ref.instrument.instrument_type_id
IS
'Reference to the standardized financial instrument type assigned to the instrument.';

COMMENT ON COLUMN ref.instrument.is_active
IS
'Indicates whether the financial instrument is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.instrument.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.instrument.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.instrument.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.instrument.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.instrument.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------