/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : symbol_source.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : SymbolSource
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical SymbolSource reference table.
 *
 * The SymbolSource table defines the authoritative sources from which trading
 * symbols, ticker identifiers, and market codes originate.
 *
 * A symbol source may represent an exchange, market data vendor, broker,
 * trading platform, regulatory organization, or an internal Phoenix service.
 *
 * This table standardizes symbol origin throughout the Phoenix Platform and
 * enables historical symbol resolution, external integrations, market data
 * normalization, and cross-provider identifier mapping.
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
 *     - market.symbol_alias
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

CREATE TABLE ref.symbol_source
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    symbol_source_id                BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    symbol_source_code              VARCHAR(50)
                                        NOT NULL,

    symbol_source_name              VARCHAR(100)
                                        NOT NULL,

    symbol_source_display_order     SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    symbol_source_description       VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    symbol_source_is_active         BOOLEAN
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

    row_version                     INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_symbol_source
        PRIMARY KEY
        (
            symbol_source_id
        ),

    CONSTRAINT uk_symbol_source_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_symbol_source_code
        UNIQUE
        (
            symbol_source_code
        ),

    CONSTRAINT uk_symbol_source_name
        UNIQUE
        (
            symbol_source_name
        ),

    CONSTRAINT ck_symbol_source_code_not_empty
        CHECK
        (
            LENGTH(TRIM(symbol_source_code)) > 0
        ),

    CONSTRAINT ck_symbol_source_code_uppercase
        CHECK
        (
            symbol_source_code = UPPER(symbol_source_code)
        ),

    CONSTRAINT ck_symbol_source_name_not_empty
        CHECK
        (
            LENGTH(TRIM(symbol_source_name)) > 0
        ),

    CONSTRAINT ck_symbol_source_display_order_positive
        CHECK
        (
            symbol_source_display_order > 0
        ),

    CONSTRAINT ck_symbol_source_description_not_empty
        CHECK
        (
            symbol_source_description IS NULL
            OR LENGTH(TRIM(symbol_source_description)) > 0
        ),

    CONSTRAINT ck_symbol_source_row_version_positive
        CHECK
        (
            row_version > 0
        )
);


--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.symbol_source
IS
'Reference table defining the authoritative sources from which trading symbols,
ticker identifiers, and market codes originate. Each record represents an
approved symbol provider such as an exchange, market data vendor, broker,
trading platform, regulatory authority, or internal Phoenix service. This table
provides standardized symbol source classifications used throughout the Phoenix
Platform for symbol management, market data integration, historical symbol
resolution, and external system interoperability.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.symbol_source.symbol_source_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.symbol_source.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.symbol_source.symbol_source_code
IS
'Unique business code identifying the symbol source.';

COMMENT ON COLUMN ref.symbol_source.symbol_source_name
IS
'Official business name of the symbol source.';

COMMENT ON COLUMN ref.symbol_source.symbol_source_display_order
IS
'Display sequence used by applications when presenting symbol sources to users.';

COMMENT ON COLUMN ref.symbol_source.symbol_source_description
IS
'Optional business description providing additional information about the
symbol source.';

COMMENT ON COLUMN ref.symbol_source.symbol_source_is_active
IS
'Indicates whether the symbol source is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.symbol_source.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.symbol_source.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.symbol_source.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.symbol_source.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.symbol_source.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------