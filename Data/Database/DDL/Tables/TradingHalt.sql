/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Trading_Halt.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : TradingHalt
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical TradingHalt table.
 *
 * The TradingHalt table records temporary trading suspensions affecting listed
 * financial instruments. Each record represents an official halt event issued
 * by an exchange or regulatory authority, including its reason, effective
 * period, and current status.
 *
 * This table provides the historical record of trading interruptions and
 * supports market surveillance, regulatory compliance, analytics, and
 * operational processing throughout the Phoenix Platform.
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
 *     - Table  : ref.market_status
 *
 * Referenced Objects
 *     - market.listing
 *     - ref.market_status
 *
 * Referenced By
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
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.trading_halt
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    trading_halt_id                 BIGINT
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

    listing_id                      BIGINT
                                        NOT NULL,

    market_status_id                BIGINT
                                        NOT NULL,

    market_event_type_id            BIGINT 
                                        NOT NULL,

    halt_category_id                BIGINT
                                        NOT NULL,

----------------------------------------------------------------------------
-- Business Attributes
----------------------------------------------------------------------------

    halt_code                      VARCHAR(50)
                                        NOT NULL,

    halt_start_at                  TIMESTAMPTZ
                                        NOT NULL,

    expected_resume_at             TIMESTAMPTZ,

    halt_end_at                    TIMESTAMPTZ,

    announced_at                   TIMESTAMPTZ,

    reference_number               VARCHAR(200),

    source_reference               VARCHAR(500),

    halt_reason                    VARCHAR(500)
                                        NOT NULL,

    trading_halt_description                    VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    trading_halt_is_active                       BOOLEAN
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

    row_version                         INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_trading_halt
        PRIMARY KEY
        (
            trading_halt_id
        ),

    CONSTRAINT uk_trading_halt_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_trading_halt_code
        UNIQUE
        (
            halt_code
        ),

    CONSTRAINT ex_trading_halt_period_overlap
        EXCLUDE USING gist
        (
            listing_id WITH =,
            tstzrange(
                halt_start_at,
                COALESCE(halt_end_at, 'infinity'::timestamptz),
                '[)'
            ) WITH &&
        ),

    CONSTRAINT ck_trading_halt_code_not_empty
        CHECK
        (
            LENGTH(TRIM(halt_code)) > 0
        ),

    CONSTRAINT ck_trading_halt_reason_not_empty
        CHECK
        (
            LENGTH(TRIM(halt_reason)) > 0
        ),

    CONSTRAINT ck_trading_halt_announced
        CHECK
        (
            announced_at IS NULL
            OR announced_at <= halt_start_at
        ),

    CONSTRAINT ck_trading_halt_reference_not_empty
        CHECK
        (
            reference_number IS NULL
            OR LENGTH(TRIM(reference_number)) > 0
        ),

    CONSTRAINT ck_trading_halt_source_not_empty
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_trading_halt_end_after_start
        CHECK
        (
            halt_end_at IS NULL
            OR halt_end_at >= halt_start_at
        ),

    CONSTRAINT ck_trading_halt_expected_resume
        CHECK
        (
            expected_resume_at IS NULL
            OR expected_resume_at >= halt_start_at
        ),

    CONSTRAINT ck_trading_halt_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    CONSTRAINT fk_trading_halt_listing
        FOREIGN KEY
        (
            listing_id
        )
        REFERENCES market.listing
        (
            listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_trading_halt_market_status
        FOREIGN KEY
        (
            market_status_id
        )
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_trading_halt_market_event_type
        FOREIGN KEY
        (
            market_event_type_id
        )
        REFERENCES ref.market_event_type
        (
            market_event_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_trading_halt_category
        FOREIGN KEY
        (
            halt_category_id
        )
        REFERENCES ref.trading_halt_category
        (
            trading_halt_category_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.trading_halt
IS
'Stores the complete history of temporary trading suspensions affecting listed
financial instruments. Each record represents an official trading halt issued
by an exchange or regulatory authority, including its effective period, current
status, and associated business information.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.trading_halt.trading_halt_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.trading_halt.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.trading_halt.listing_id
IS
'Reference to the instrument listing affected by the trading halt.';

COMMENT ON COLUMN market.trading_halt.market_status_id
IS
'Reference to the market status associated with the trading halt.';

COMMENT ON COLUMN market.trading_halt.market_event_type_id
IS
'Reference to the market event type associated with this trading halt event.';

COMMENT ON COLUMN market.trading_halt.halt_category_id
IS
'Reference to the business classification of the trading halt, 
such as Regulatory, Volatility, Corporate Action, Technical, or Extraordinary.';

COMMENT ON COLUMN market.trading_halt.halt_code
IS
'Unique business code identifying the trading halt event.';

COMMENT ON COLUMN market.trading_halt.halt_start_at
IS
'Timestamp indicating when the trading halt became effective.';

COMMENT ON COLUMN market.trading_halt.expected_resume_at
IS
'Expected timestamp when trading is planned to resume according to the official exchange announcement. 
The actual resumption time is recorded in halt_end_at.';

COMMENT ON COLUMN market.trading_halt.halt_end_at
IS
'Timestamp indicating when the trading halt was lifted and trading resumed, if applicable.';

COMMENT ON COLUMN market.trading_halt.announced_at
IS
'Timestamp when the trading halt was officially announced by the exchange or regulatory authority.';

COMMENT ON COLUMN market.trading_halt.reference_number
IS
'Official announcement number or regulatory reference identifying the trading halt.';

COMMENT ON COLUMN market.trading_halt.source_reference
IS
'External reference identifying the official source of the trading halt information, such as an exchange announcement, regulatory notice, document identifier, or URL.';

COMMENT ON COLUMN market.trading_halt.halt_reason
IS
'Business reason explaining why trading was temporarily suspended.';

COMMENT ON COLUMN market.trading_halt.trading_halt_description
IS
'Optional business description providing additional information about the trading halt.';

COMMENT ON COLUMN market.trading_halt.trading_halt_is_active
IS
'Indicates whether the trading halt record is currently active and valid within the Phoenix Platform.';

COMMENT ON COLUMN market.trading_halt.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.trading_halt.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.trading_halt.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.trading_halt.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.trading_halt.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------