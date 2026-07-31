/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Corporate_Action_Status.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : CorporateActionStatus
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical CorporateActionStatus reference table.
 *
 * The CorporateActionStatus table defines the standardized lifecycle statuses
 * of corporate actions supported by the Phoenix Platform. Each record
 * represents an authoritative status used to manage, validate, process,
 * publish, and archive corporate action events.
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
 *     None
 *
 * Referenced By
 *     - market.corporate_action
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

CREATE TABLE ref.corporate_action_status
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    corporate_action_status_id      BIGINT
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

    corporate_action_status_code     VARCHAR(30)
                                        NOT NULL,

    corporate_action_status_name     VARCHAR(100)
                                        NOT NULL,

    corporate_action_status_short_name                       VARCHAR(50),

    corporate_action_status_local_name                       VARCHAR(100),

    corporate_action_status_display_order                    SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    corporate_action_status_description                      VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    corporate_action_status_is_active                        BOOLEAN
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

    CONSTRAINT pk_corporate_action_status
        PRIMARY KEY
        (
            corporate_action_status_id
        ),

    CONSTRAINT uq_corporate_action_status_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_corporate_action_status_code
        UNIQUE
        (
            corporate_action_status_code
        ),

    CONSTRAINT ck_corporate_action_status_code_uppercase
        CHECK
        (
            corporate_action_status_code = UPPER(corporate_action_status_code)
        ),

    CONSTRAINT ck_corporate_action_status_code_length
        CHECK
        (
            LENGTH(TRIM(corporate_action_status_code)) BETWEEN 2 AND 30
        ),

    CONSTRAINT ck_corporate_action_status_code_not_empty
        CHECK
        (
            LENGTH(TRIM(corporate_action_status_code)) > 0
        ),

    CONSTRAINT ck_corporate_action_status_name_not_empty
        CHECK
        (
            LENGTH(TRIM(corporate_action_status_name)) > 0
        ),
    CONSTRAINT ck_corporate_action_status_short_name_not_empty
        CHECK
        (
            corporate_action_status_short_name IS NULL
            OR LENGTH(TRIM(corporate_action_status_short_name)) > 0
        ),

    CONSTRAINT ck_corporate_action_status_local_name_not_empty
        CHECK
        (
            corporate_action_status_local_name IS NULL
            OR LENGTH(TRIM(corporate_action_status_local_name)) > 0
        ),

    CONSTRAINT ck_corporate_action_status_display_order
        CHECK
        (
            corporate_action_status_display_order > 0
        ),

    CONSTRAINT ck_corporate_action_status_description_not_empty
        CHECK
        (
            corporate_action_status_description IS NULL
            OR LENGTH(TRIM(corporate_action_status_description)) > 0
        ),

    CONSTRAINT ck_corporate_action_status_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.corporate_action_status
IS
'Reference table containing the standardized lifecycle statuses of corporate
actions supported by the Phoenix Platform. Each record represents an
authoritative status used to manage, validate, process, publish, and archive
corporate action events throughout their lifecycle.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.corporate_action_status.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_code
IS
'Unique business code identifying the corporate action status.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_name
IS
'Official business name of the corporate action status.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_local_name
IS
'Official local-language name of the corporate action status.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_display_order
IS
'Display sequence used by applications when presenting corporate action statuses to users.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_description
IS
'Optional business description of the corporate action status.';

COMMENT ON COLUMN ref.corporate_action_status.corporate_action_status_is_active
IS
'Indicates whether the corporate action status is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.corporate_action_status.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.corporate_action_status.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.corporate_action_status.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.corporate_action_status.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.corporate_action_status.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------