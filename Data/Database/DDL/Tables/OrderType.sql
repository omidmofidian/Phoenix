/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : order_type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : OrderType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical OrderType reference table.
 *
 * The OrderType table defines the standardized business classifications of
 * trading order types supported by the Phoenix Platform.
 *
 * Each record represents a specific execution instruction submitted to an
 * exchange or trading venue, defining how an order should be processed.
 *
 * This table provides consistent order type classifications used throughout
 * order management, execution, trading analytics, reporting, auditing, and
 * historical trade analysis.
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

CREATE TABLE ref.order_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    order_type_id                   BIGINT
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

    order_type_code                 VARCHAR(50)
                                        NOT NULL,

    order_type_name                 VARCHAR(100)
                                        NOT NULL,

    order_type_display_order        SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    order_type_description          VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    order_type_is_active            BOOLEAN
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

    CONSTRAINT pk_order_type
        PRIMARY KEY
        (
            order_type_id
        ),

    CONSTRAINT uk_order_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_order_type_code
        UNIQUE
        (
            order_type_code
        ),

    CONSTRAINT uk_order_type_name
        UNIQUE
        (
            order_type_name
        ),

    CONSTRAINT ck_order_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(order_type_code)) > 0
        ),

    CONSTRAINT ck_order_type_code_uppercase
        CHECK
        (
            order_type_code = UPPER(order_type_code)
        ),

    CONSTRAINT ck_order_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(order_type_name)) > 0
        ),

    CONSTRAINT ck_order_type_display_order_positive
        CHECK
        (
            order_type_display_order > 0
        ),

    CONSTRAINT ck_order_type_description_not_empty
        CHECK
        (
            order_type_description IS NULL
            OR LENGTH(TRIM(order_type_description)) > 0
        ),

    CONSTRAINT ck_order_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.order_type
IS
'Reference table defining the standardized business classifications of trading
order types supported by the Phoenix Platform. Each order type represents a
specific execution instruction that determines how an order should be processed
by an exchange or trading venue. This table provides consistent order type
classifications used throughout order management, execution services,
reporting, analytics, auditing, and historical trading analysis.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.order_type.order_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.order_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.order_type.order_type_code
IS
'Unique business code identifying the order type.';

COMMENT ON COLUMN ref.order_type.order_type_name
IS
'Official business name of the order type.';

COMMENT ON COLUMN ref.order_type.order_type_display_order
IS
'Display sequence used by applications when presenting order types to users.';

COMMENT ON COLUMN ref.order_type.order_type_description
IS
'Optional business description providing additional information about the order
type.';

COMMENT ON COLUMN ref.order_type.order_type_is_active
IS
'Indicates whether the order type is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.order_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.order_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.order_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.order_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.order_type.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------