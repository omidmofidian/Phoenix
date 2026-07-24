/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : industry.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Industry
 * Schema           : reference
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
 * - Physical Database Model
 * - PostgreSQLPhysicalDatabaseDesign.md
 * - PostgreSQLDesignDecisions.md
 * - TablePhysicalSpecifications.md
 * - ConstraintSpecifications.md
 * - DDLTemplateSpecification.md
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : reference
 *
 * Referenced Objects
 *     None
 *
 * Referenced By
 *     - reference.company
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

CREATE TABLE reference.industry
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    id                      BIGINT
                                GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id               UUID
                                NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    code                    VARCHAR(20)
                                NOT NULL,

    name                    VARCHAR(200)
                                NOT NULL,

    short_name              VARCHAR(100),

    english_name            VARCHAR(200),

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

    CONSTRAINT pk_industry
        PRIMARY KEY
        (
            id
        ),

    CONSTRAINT uk_industry_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_industry_code
        UNIQUE
        (
            code
        ),

    CONSTRAINT ck_industry_code_not_empty
        CHECK
        (
            LENGTH(TRIM(code)) > 0
        ),

    CONSTRAINT ck_industry_name_not_empty
        CHECK
        (
            LENGTH(TRIM(name)) > 0
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

COMMENT ON TABLE reference.industry
IS
'Reference table containing the standardized industry classifications supported
by the Phoenix Platform. Each record represents an authoritative industry used
for classifying companies, financial instruments, and analytical datasets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.industry.id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN reference.industry.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN reference.industry.code
IS
'Unique business code identifying the industry.';

COMMENT ON COLUMN reference.industry.name
IS
'Official business name of the industry.';

COMMENT ON COLUMN reference.industry.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN reference.industry.english_name
IS
'Official English name of the industry when applicable.';

COMMENT ON COLUMN reference.industry.display_order
IS
'Display sequence used by applications when presenting industries to users.';

COMMENT ON COLUMN reference.industry.description
IS
'Optional business description of the industry.';

COMMENT ON COLUMN reference.industry.is_active
IS
'Indicates whether the industry is currently active and available for business classification.';

COMMENT ON COLUMN reference.industry.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN reference.industry.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN reference.industry.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN reference.industry.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN reference.industry.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------