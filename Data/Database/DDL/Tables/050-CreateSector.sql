/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 050-CreateSector.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Sector
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Sector reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 040-CreateIndustry.sql
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - SQLScriptDevelopmentStandard
 * - DatabaseDDLDevelopmentStandard
 * - EnterpriseTableConvention
 * - TableDevelopmentStandard
 * - ConstraintDevelopmentStandard
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-11
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 1.0       2026-07-11   Initial version.
 **************************************************************************************************/

CREATE TABLE reference.Sector
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    sector_id               BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id               UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    code                    VARCHAR(20)  NOT NULL,
    name                    VARCHAR(200) NOT NULL,
    short_name              VARCHAR(100),
    english_name            VARCHAR(200),
    display_order           SMALLINT NOT NULL DEFAULT 1,
    description             VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    industry_id             BIGINT NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Status
    ------------------------------------------------------------------------------

    is_active               BOOLEAN NOT NULL DEFAULT TRUE,

    ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at              TIMESTAMPTZ NOT NULL,
    created_by              BIGINT NOT NULL,

    updated_at              TIMESTAMPTZ,
    updated_by              BIGINT,

    version                 INTEGER NOT NULL DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT PK_Sector
        PRIMARY KEY (sector_id),

    CONSTRAINT UQ_Sector_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Sector_Industry_Code
        UNIQUE (industry_id, code)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.Sector
IS 'Stores sector classifications within an industry.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Sector.sector_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.Sector.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Sector.code
IS 'Unique business code of the sector within its industry.';

COMMENT ON COLUMN reference.Sector.name
IS 'Official business name of the sector.';

COMMENT ON COLUMN reference.Sector.short_name
IS 'Short display name of the sector.';

COMMENT ON COLUMN reference.Sector.english_name
IS 'Official English name of the sector.';

COMMENT ON COLUMN reference.Sector.display_order
IS 'Display order used by user interfaces.';

COMMENT ON COLUMN reference.Sector.description
IS 'Business description of the sector.';

COMMENT ON COLUMN reference.Sector.industry_id
IS 'References the parent industry.';

COMMENT ON COLUMN reference.Sector.is_active
IS 'Indicates whether the sector is active.';

COMMENT ON COLUMN reference.Sector.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Sector.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Sector.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.Sector.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Sector.version
IS 'Optimistic concurrency version number.';