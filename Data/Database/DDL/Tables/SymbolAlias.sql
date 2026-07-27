/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : SymbolAlias.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : SymbolAlias
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the SymbolAlias table.
 *
 * The SymbolAlias table stores alternative symbols, historical symbols,
 * external vendor symbols, and legacy identifiers associated with listed
 * financial instruments. A single instrument may have multiple aliases during
 * its lifecycle depending on exchange rules, corporate actions, data vendors,
 * or regulatory changes.
 *
 * This table enables reliable symbol resolution across historical datasets,
 * market data providers, external systems, and internal services.
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
 *     - Schema : ref
 *     - Table  : market.instrument_listing
 *     - Table  : ref.market_event_type
 *
 * Referenced Objects
 *     - market.instrument_listing
 *     - ref.market_event_type
 *
 * Referenced By
 *     - Market Data Import Engine
 *     - Historical Data Loader
 *     - Symbol Resolution Service
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
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.symbol_alias
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    symbol_alias_id                 BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    instrument_listing_id           BIGINT
                                        NOT NULL,

    symbol_source_id                BIGINT 
                                        NOT NULL

    market_event_type_id            BIGINT,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    alias_symbol                    VARCHAR(50)
                                        NOT NULL,

    alias_name                      VARCHAR(200),

    effective_from                  DATE
                                        NOT NULL,

    effective_to                    DATE,

    description                     VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                       BOOLEAN
                                        NOT NULL
                                        DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                      TIMESTAMPTZ
                                        NOT NULL
                                        DEFAULT CURRENT_TIMESTAMP,

    updated_at                      TIMESTAMPTZ,

    created_by                      BIGINT
                                        NOT NULL,

    updated_by                      BIGINT,

    version                         INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_symbol_alias
        PRIMARY KEY
        (
            symbol_alias_id
        ),

    CONSTRAINT uq_symbol_alias_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_symbol_alias
        UNIQUE
        (
            instrument_listing_id,
            alias_symbol,
            effective_from
        ),

    CONSTRAINT ck_symbol_alias_not_empty
        CHECK
        (
            LENGTH(TRIM(alias_symbol)) > 0
        ),

    CONSTRAINT ck_symbol_alias_name_not_empty
        CHECK
        (
            alias_name IS NULL
            OR LENGTH(TRIM(alias_name)) > 0
        ),

    CONSTRAINT ck_symbol_alias_source_not_empty
        CHECK
        (
            source_system IS NULL
            OR LENGTH(TRIM(source_system)) > 0
        ),

    CONSTRAINT ck_symbol_alias_period
        CHECK
        (
            effective_to IS NULL
            OR effective_to >= effective_from
        ),

    CONSTRAINT ck_symbol_alias_version_positive
        CHECK
        (
            version > 0
        ),

    CONSTRAINT fk_symbol_alias_listing
        FOREIGN KEY
        (
            instrument_listing_id
        )
        REFERENCES market.instrument_listing
        (
            instrument_listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_symbol_alias_symbol_source
        FOREIGN KEY
        (
            symbol_source_id
        )
        REFERENCES ref.symbol_source
        (
            symbol_source_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_symbol_alias_market_event_type
        FOREIGN KEY
        (
            market_event_type_id
        )
        REFERENCES ref.market_event_type
        (
            market_event_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.symbol_alias
IS
'Stores alternative, historical, legacy, and external symbols associated with
listed financial instruments. Symbol aliases provide a canonical mapping
between an instrument and the various identifiers used by exchanges, market
data vendors, trading platforms, and external information providers throughout
the instrument lifecycle.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.symbol_alias.symbol_alias_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.symbol_alias.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.symbol_alias.instrument_listing_id
IS
'Reference to the listed financial instrument associated with this symbol alias.';

COMMENT ON COLUMN market.symbol_alias.symbol_source_id
IS
'Reference to the source system that defines or provides the symbol alias, such as an exchange, market data vendor, trading platform, or internal Phoenix service.';

COMMENT ON COLUMN market.symbol_alias.market_event_type_id
IS
'Reference to the market event type that caused or introduced this symbol alias, such as Listing, Symbol Change, Merger, Delisting, or Corporate Action.';

COMMENT ON COLUMN market.symbol_alias.alias_symbol
IS
'Alternative trading symbol, ticker, or market identifier assigned to the financial instrument.';

COMMENT ON COLUMN market.symbol_alias.alias_name
IS
'Alternative business name associated with the financial instrument while this symbol alias was in use.';

COMMENT ON COLUMN market.symbol_alias.source_system
IS
'Name of the external exchange, market data provider, trading platform, or internal system from which the symbol alias originated.';

COMMENT ON COLUMN market.symbol_alias.effective_from
IS
'Date on which the symbol alias became effective.';

COMMENT ON COLUMN market.symbol_alias.effective_to
IS
'Date on which the symbol alias ceased to be effective. NULL indicates that the alias is currently active.';

COMMENT ON COLUMN market.symbol_alias.description
IS
'Optional business description providing additional information about the symbol alias.';

COMMENT ON COLUMN market.symbol_alias.is_active
IS
'Indicates whether the symbol alias is currently active and available for business operations within the Phoenix Platform.';

COMMENT ON COLUMN market.symbol_alias.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.symbol_alias.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.symbol_alias.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.symbol_alias.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.symbol_alias.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------