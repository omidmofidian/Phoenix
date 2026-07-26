/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : industry.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Industry
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Industry reference table.
 *
 * The Industry table represents the standardized industry classifications used
 * throughout the Phoenix Platform. It provides the authoritative industry
 * taxonomy for classifying companies, financial instruments, and analytical
 * datasets.
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
 *     - ref.sector
 *     - market.company
 *     - Additional business classification entities
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

CREATE TABLE ref.industry
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    industry_id                      BIGINT
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

    industry_code                    VARCHAR(20)
                                NOT NULL,

    industry_name                    VARCHAR(200)
                                NOT NULL,

    short_name              VARCHAR(100),

    local_name              VARCHAR(200),

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

    updated_at              TIMESTAMPTZ,

    created_by              BIGINT
                                NOT NULL,

    updated_by              BIGINT,

    version                 INTEGER
                                NOT NULL
                                DEFAULT 1,

        ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_industry
        PRIMARY KEY
        (
            industry_id
        ),

    CONSTRAINT uk_industry_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_industry_code
        UNIQUE
        (
            industry_code
        ),

    CONSTRAINT ck_industry_code_not_empty
        CHECK
        (
            LENGTH(TRIM(industry_code)) > 0
        ),

    CONSTRAINT ck_industry_name_not_empty
        CHECK
        (
            LENGTH(TRIM(industry_name)) > 0
        ),

    CONSTRAINT ck_industry_display_order
        CHECK
        (
            display_order > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.industry
IS
'Reference table containing the standardized industry classifications supported
by the Phoenix Platform. Each record represents an authoritative industry used
for classifying companies, financial instruments, and analytical datasets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.industry.industry_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.industry.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.industry.industry_code
IS
'Unique business code identifying the industry.';

COMMENT ON COLUMN ref.industry.industry_name
IS
'Official business name of the industry.';

COMMENT ON COLUMN ref.industry.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.industry.local_name
IS
'Official local-language name of the industry.';

COMMENT ON COLUMN ref.industry.display_order
IS
'Display sequence used by applications when presenting industries to users.';

COMMENT ON COLUMN ref.industry.description
IS
'Optional business description of the industry.';

COMMENT ON COLUMN ref.industry.is_active
IS
'Indicates whether the industry is currently active and available for use throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.industry.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.industry.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.industry.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.industry.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.industry.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------