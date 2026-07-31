/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Trading_Halt_Category.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingHaltCategory
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TradingHaltCategory reference table.
 *
 * The TradingHaltCategory table defines the business classification of trading
 * halt events supported by the Phoenix Platform. Each category represents the
 * underlying reason or business context that caused an exchange to temporarily
 * suspend trading for a listed financial instrument.
 *
 * This table provides standardized classifications used throughout market
 * surveillance, regulatory processing, analytics, reporting, and historical
 * market event analysis.
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
 *     - market.trading_halt
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

CREATE TABLE ref.trading_halt_category
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    trading_halt_category_id         BIGINT
                                         GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                        UUID
                                         NOT NULL
                                         DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    trading_halt_category_code                    VARCHAR(50)
                                         NOT NULL,

    trading_halt_category_name                    VARCHAR(100)
                                         NOT NULL,

    trading_halt_category_display_order                    SMALLINT
                                         NOT NULL
                                         DEFAULT 1,

    trading_halt_category_description                      VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    trading_halt_category_is_active                        BOOLEAN
                                         NOT NULL
                                         DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                       TIMESTAMPTZ
                                         NOT NULL
                                         DEFAULT CURRENT_TIMESTAMP,

    updated_at                       TIMESTAMPTZ,

    created_by                       BIGINT
                                         NOT NULL,

    updated_by                       BIGINT,

    row_version                          INTEGER
                                         NOT NULL
                                         DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_trading_halt_category
        PRIMARY KEY
        (
            trading_halt_category_id
        ),

    CONSTRAINT uk_trading_halt_category_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_trading_halt_category_code
        UNIQUE
        (
            trading_halt_category_code
        ),

    CONSTRAINT uk_trading_halt_category_name
        UNIQUE
        (
            trading_halt_category_name
        ),

    CONSTRAINT ck_trading_halt_category_code_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_halt_category_code)) > 0
        ),

    CONSTRAINT ck_trading_halt_category_code_uppercase
        CHECK (
            trading_halt_category_code = UPPER(trading_halt_category_code)
        ),

    CONSTRAINT ck_trading_halt_category_name_not_empty
        CHECK
        (
            LENGTH(TRIM(trading_halt_category_name)) > 0
        ),

    CONSTRAINT ck_trading_halt_category_display_order_positive
        CHECK
        (
            trading_halt_category_display_order > 0
        ),

    CONSTRAINT ck_trading_halt_category_description_not_empty
        CHECK (
            trading_halt_category_description IS NULL
            OR LENGTH(TRIM(trading_halt_category_description)) > 0
        ),

    CONSTRAINT ck_trading_halt_category_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.trading_halt_category
IS
'Reference table defining the standardized business classifications of trading
halt events supported by the Phoenix Platform. Each category identifies the
underlying business or regulatory reason that resulted in a temporary suspension
of trading for a listed financial instrument.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.trading_halt_category.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_code
IS
'Unique business code identifying the trading halt category.';

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_name
IS
'Official business name of the trading halt category.';

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_display_order
IS
'Display sequence used by applications when presenting trading halt categories to users.';

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_description
IS
'Optional business description providing additional information about the trading halt category.';

COMMENT ON COLUMN ref.trading_halt_category.trading_halt_category_is_active
IS
'Indicates whether the trading halt category is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.trading_halt_category.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.trading_halt_category.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.trading_halt_category.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.trading_halt_category.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.trading_halt_category.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------