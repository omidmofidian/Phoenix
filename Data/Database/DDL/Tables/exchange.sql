/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : exchange.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Exchange
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Exchange reference table.
 *
 * The Exchange table represents stock exchanges supported by the Phoenix Platform.
 * It serves as the root reference entity for market classification and provides the
 * authoritative source for exchange metadata used throughout the platform.
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
 *     - Extension : pgcrypto (UUID generation, if applicable)
 *
 * Referenced Objects
 *     None
 *
 * Referenced By
 *     - market.market
 *     - market.trading_board
 *     - Additional reference entities
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

CREATE TABLE ref.exchange
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    exchange_id                      BIGINT
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

    exchange_code                    VARCHAR(20)
                                NOT NULL,

    exchange_name                    VARCHAR(200)
                                NOT NULL,

    short_name              VARCHAR(100),

    local_name            VARCHAR(200),

    country_id            BIGINT
                            NOT NULL,

    currency_id           BIGINT 
                            NOT NULL,

    timezone_id            BIGINT
                            NOT NULL,

    website                 VARCHAR(300),

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

    CONSTRAINT pk_exchange
        PRIMARY KEY
        (
            exchange_id
        ),

    CONSTRAINT uk_exchange_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_exchange_code
        UNIQUE
        (
            exchange_code
        ),

    CONSTRAINT ck_exchange_code_not_empty
        CHECK
        (
            LENGTH(TRIM(exchange_code)) > 0
        ),

    CONSTRAINT ck_exchange_name_not_empty
        CHECK
        (
            LENGTH(TRIM(exchange_name)) > 0
        ),

    CONSTRAINT ck_exchange_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT ck_exchange_country_code
        CHECK
        (
            country_id IS NULL
            OR country_id ~ '^[A-Z]{2}$'
        )
);
--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.exchange
IS
'Reference table containing the stock exchanges supported by the Phoenix Platform.
Each record represents one exchange and serves as the authoritative source for
exchange metadata across all platform services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.exchange.exchange_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.exchange.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.exchange.exchange_code
IS
'Unique business code identifying the exchange.';

COMMENT ON COLUMN ref.exchange.exchange_name
IS
'Official business name of the exchange.';

COMMENT ON COLUMN ref.exchange.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.exchange.local_name
IS
'Official English name of the exchange when applicable.';

COMMENT ON COLUMN ref.exchange.country_id
IS
'ISO 3166-1 Alpha-2 country code representing the country in which the exchange operates.';

COMMENT ON COLUMN ref.exchange.website
IS
'Official website of the exchange.';

COMMENT ON COLUMN ref.exchange.display_order
IS
'Display sequence used by applications when presenting exchanges to users.';

COMMENT ON COLUMN ref.exchange.description
IS
'Optional business description of the exchange.';

COMMENT ON COLUMN ref.exchange.is_active
IS
'Indicates whether the exchange is currently active and available for business operations.';

COMMENT ON COLUMN ref.exchange.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.exchange.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.exchange.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.exchange.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.exchange.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------