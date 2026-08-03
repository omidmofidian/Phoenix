/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : settlement_type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : SettlementType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical SettlementType reference table.
 *
 * The SettlementType table defines the standardized settlement methods used
 * throughout the Phoenix Platform.
 *
 * Each record represents a business classification describing how financial
 * obligations resulting from a trade are settled between counterparties.
 *
 * This table provides consistent settlement classifications used throughout
 * trading, clearing, settlement processing, reporting, analytics, auditing,
 * and historical trade analysis.
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
 *     - trading.trade
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

CREATE TABLE ref.settlement_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    settlement_type_id              BIGINT
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

    settlement_type_code            VARCHAR(50)
                                        NOT NULL,

    settlement_type_name            VARCHAR(100)
                                        NOT NULL,

    settlement_type_display_order   SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    settlement_type_description     VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    settlement_type_is_active       BOOLEAN
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

    CONSTRAINT pk_settlement_type
        PRIMARY KEY
        (
            settlement_type_id
        ),

    CONSTRAINT uk_settlement_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_settlement_type_code
        UNIQUE
        (
            settlement_type_code
        ),

    CONSTRAINT uk_settlement_type_name
        UNIQUE
        (
            settlement_type_name
        ),

    CONSTRAINT ck_settlement_type_code_not_empty
        CHECK
        (
            LENGTH(TRIM(settlement_type_code)) > 0
        ),

    CONSTRAINT ck_settlement_type_code_uppercase
        CHECK
        (
            settlement_type_code = UPPER(settlement_type_code)
        ),

    CONSTRAINT ck_settlement_type_name_not_empty
        CHECK
        (
            LENGTH(TRIM(settlement_type_name)) > 0
        ),

    CONSTRAINT ck_settlement_type_display_order_positive
        CHECK
        (
            settlement_type_display_order > 0
        ),

    CONSTRAINT ck_settlement_type_description_not_empty
        CHECK
        (
            settlement_type_description IS NULL
            OR LENGTH(TRIM(settlement_type_description)) > 0
        ),

    CONSTRAINT ck_settlement_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.settlement_type
IS
'Reference table defining the standardized settlement methods supported by the
Phoenix Platform. Each settlement type represents a business classification
describing how financial obligations resulting from a trade are settled between
counterparties. This table provides consistent settlement classifications used
throughout trading, clearing, settlement processing, reporting, analytics,
auditing, and historical trade analysis.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.settlement_type.settlement_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.settlement_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.settlement_type.settlement_type_code
IS
'Unique business code identifying the settlement type.';

COMMENT ON COLUMN ref.settlement_type.settlement_type_name
IS
'Official business name of the settlement type.';

COMMENT ON COLUMN ref.settlement_type.settlement_type_display_order
IS
'Display sequence used by applications when presenting settlement types to
users.';

COMMENT ON COLUMN ref.settlement_type.settlement_type_description
IS
'Optional business description providing additional information about the
settlement type.';

COMMENT ON COLUMN ref.settlement_type.settlement_type_is_active
IS
'Indicates whether the settlement type is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.settlement_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.settlement_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.settlement_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.settlement_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.settlement_type.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------