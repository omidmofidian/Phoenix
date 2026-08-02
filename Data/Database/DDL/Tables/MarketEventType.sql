/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : market_event_type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : MarketEventType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical MarketEventType reference table.
 *
 * The MarketEventType table defines the standardized business classifications
 * of market events supported by the Phoenix Platform. These event types provide
 * a common taxonomy for operational processing, analytics, notifications,
 * workflow automation, regulatory reporting, and event-driven services.
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
 *     - market.instrument_suspension
 *     - market.corporate_action
 *     - market.corporate_announcement_reference
 *     - market.market_snapshot
 *     - Future event-driven services
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

CREATE TABLE ref.market_event_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    market_event_type_id             BIGINT
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

    market_event_type_code                       VARCHAR(50)
                                         NOT NULL,

    market_event_type_name                       VARCHAR(100)
                                         NOT NULL,

    market_event_type_short_name                       VARCHAR(50),

    market_event_type_display_order                    SMALLINT
                                         NOT NULL
                                         DEFAULT 1,

    market_event_type_description                      VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    market_event_type_is_active                        BOOLEAN
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

    CONSTRAINT pk_market_event_type
        PRIMARY KEY
        (
            market_event_type_id
        ),

    CONSTRAINT uq_market_event_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_market_event_type_code
        UNIQUE
        (
            market_event_type_code
        ),

    CONSTRAINT uq_market_event_type_name
        UNIQUE
        (
            market_event_type_name
        ),

    CONSTRAINT ck_market_event_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(market_event_type_code)) > 0
        ),

    CONSTRAINT ck_market_event_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(market_event_type_name)) > 0
        ),

    CONSTRAINT ck_market_event_type_display_order_positive
        CHECK
        (
            market_event_type_display_order > 0
        ),

    CONSTRAINT ck_market_event_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.market_event_type
IS
'Reference table defining the standardized business classifications of market
events supported by the Phoenix Platform. Market event types provide a common
taxonomy for event-driven processing, analytics, workflow automation,
notifications, and regulatory reporting across all supported financial markets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_event_type.market_event_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.market_event_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_code
IS
'Unique business code identifying the market event type.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_name
IS
'Official business name of the market event type.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_short_name
IS
'Abbreviated business name used by applications, dashboards, reports, and user interfaces.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_display_order
IS
'Display sequence used when presenting market event types within user interfaces and reports.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_description
IS
'Optional business description providing additional information about the market event type.';

COMMENT ON COLUMN ref.market_event_type.market_event_type_is_active
IS
'Indicates whether the market event type is currently active and available for business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.market_event_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.market_event_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.market_event_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.market_event_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.market_event_type.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------