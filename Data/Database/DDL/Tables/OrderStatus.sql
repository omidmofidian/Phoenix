/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : order_status.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : OrderStatus
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical OrderStatus reference table.
 *
 * The OrderStatus table defines the standardized lifecycle states of trading
 * orders supported by the Phoenix Platform.
 *
 * Each record represents a business status that may occur during the processing,
 * execution, cancellation, expiration, or completion of an order.
 *
 * This table provides consistent order status classifications used throughout
 * order management, execution services, reporting, analytics, auditing, and
 * historical trading analysis.
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
 *     - trading.order
 *     - execution.order_execution
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
 * Created          : 2026-08-03
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-08-03   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.order_status
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    order_status_id                 BIGINT
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

    order_status_code               VARCHAR(50)
                                        NOT NULL,

    order_status_name               VARCHAR(100)
                                        NOT NULL,

    order_status_short_name         VARCHAR(50),

    order_status_local_name         VARCHAR(100),

    order_status_display_order      SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    order_status_description        VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    order_status_is_active          BOOLEAN
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

    CONSTRAINT pk_order_status
        PRIMARY KEY
        (
            order_status_id
        ),

    CONSTRAINT uk_order_status_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_order_status_code
        UNIQUE
        (
            order_status_code
        ),

    CONSTRAINT uk_order_status_name
        UNIQUE
        (
            order_status_name
        ),

    CONSTRAINT ck_order_status_code_not_empty
        CHECK
        (
            LENGTH(TRIM(order_status_code)) > 0
        ),

    CONSTRAINT ck_order_status_code_uppercase
        CHECK
        (
            order_status_code = UPPER(order_status_code)
        ),

    CONSTRAINT ck_order_status_name_not_empty
        CHECK
        (
            LENGTH(TRIM(order_status_name)) > 0
        ),

    CONSTRAINT ck_order_status_short_name_not_empty
        CHECK
        (
            order_status_short_name IS NULL
            OR LENGTH(TRIM(order_status_short_name)) > 0
        ),

    CONSTRAINT ck_order_status_local_name_not_empty
        CHECK
        (
            order_status_local_name IS NULL
            OR LENGTH(TRIM(order_status_local_name)) > 0
        ),

    CONSTRAINT ck_order_status_display_order_positive
        CHECK
        (
            order_status_display_order > 0
        ),

    CONSTRAINT ck_order_status_description_not_empty
        CHECK
        (
            order_status_description IS NULL
            OR LENGTH(TRIM(order_status_description)) > 0
        ),

    CONSTRAINT ck_order_status_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.order_status
IS
'Reference table defining the standardized lifecycle statuses of trading orders
supported by the Phoenix Platform. Each status represents a business state that
may occur during order creation, validation, routing, execution, cancellation,
expiration, or completion. This table provides consistent order status
classifications used throughout order management, execution services,
reporting, auditing, analytics, and historical trading analysis.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.order_status.order_status_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.order_status.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.order_status.order_status_code
IS
'Unique business code identifying the order status.';

COMMENT ON COLUMN ref.order_status.order_status_name
IS
'Official business name of the order status.';

COMMENT ON COLUMN ref.order_status.order_status_short_name
IS
'Optional abbreviated name used where compact display is required.';

COMMENT ON COLUMN ref.order_status.order_status_local_name
IS
'Optional localized business name of the order status.';

COMMENT ON COLUMN ref.order_status.order_status_display_order
IS
'Display sequence used by applications when presenting order statuses to users.';

COMMENT ON COLUMN ref.order_status.order_status_description
IS
'Optional business description providing additional information about the order
status.';

COMMENT ON COLUMN ref.order_status.order_status_is_active
IS
'Indicates whether the order status is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.order_status.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.order_status.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.order_status.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.order_status.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.order_status.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------