/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : sector.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Sector
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical Sector reference table.
 *
 * The Sector table represents standardized business sectors within an Industry.
 * Each sector belongs to exactly one Industry and provides an additional level
 * of business classification for companies, financial instruments, and
 * analytical models.
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
 *     - Table  : ref.industry
 *
 * Referenced Objects
 *     - ref.industry
 *
 * Referenced By
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

CREATE TABLE ref.sector
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    sector_id                      BIGINT
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

    industry_id             BIGINT
                                NOT NULL,

    sector_code                    VARCHAR(20)
                                NOT NULL,

    sector_name                    VARCHAR(200)
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

    CONSTRAINT pk_sector
        PRIMARY KEY
        (
            sector_id
        ),

    CONSTRAINT uk_sector_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_sector_industry_code
        UNIQUE
        (
            industry_id,
            sector_code
        ),

    CONSTRAINT ck_sector_code_not_empty
        CHECK
        (
            LENGTH(TRIM(sector_code)) > 0
        ),

    CONSTRAINT ck_sector_name_not_empty
        CHECK
        (
            LENGTH(TRIM(sector_name)) > 0
        ),

    CONSTRAINT ck_sector_display_order
        CHECK
        (
            display_order > 0
        ),

    CONSTRAINT fk_sector_industry
        FOREIGN KEY
        (
            industry_id
        )
        REFERENCES ref.industry
        (
            industry_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.sector
IS
'Reference table containing the standardized business sectors supported by the
Phoenix Platform. Each sector belongs to exactly one industry and provides the
authoritative sector classification for companies, financial instruments, and
analytical datasets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.sector.sector_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.sector.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.sector.industry_id
IS
'Reference to the parent industry to which the sector belongs.';

COMMENT ON COLUMN ref.sector.sector_code
IS
'Unique business code identifying the sector within its parent industry.';

COMMENT ON COLUMN ref.sector.sector_name
IS
'Official business name of the sector.';

COMMENT ON COLUMN ref.sector.short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.sector.local_name
IS
'Official local-language name of the sector.';

COMMENT ON COLUMN ref.sector.display_order
IS
'Display sequence used by applications when presenting sectors to users.';

COMMENT ON COLUMN ref.sector.description
IS
'Optional business description of the sector.';

COMMENT ON COLUMN ref.sector.is_active
IS
'Indicates whether the sector is currently active and available for business classification.';

COMMENT ON COLUMN ref.sector.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.sector.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.sector.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.sector.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.sector.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------