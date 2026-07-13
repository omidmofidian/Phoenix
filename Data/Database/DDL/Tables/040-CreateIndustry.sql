/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 040-CreateIndustry.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Industry
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Industry reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * None
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

CREATE TABLE reference.Industry
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    industry_id             BIGINT GENERATED ALWAYS AS IDENTITY,

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

    CONSTRAINT PK_Industry
        PRIMARY KEY (industry_id),

    CONSTRAINT UQ_Industry_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Industry_Code
        UNIQUE (code)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.Industry
IS 'Stores industry classifications used throughout the Phoenix Platform.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Industry.industry_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.Industry.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Industry.code
IS 'Unique business code of the industry.';

COMMENT ON COLUMN reference.Industry.name
IS 'Official business name of the industry.';

COMMENT ON COLUMN reference.Industry.short_name
IS 'Short display name of the industry.';

COMMENT ON COLUMN reference.Industry.english_name
IS 'Official English name of the industry.';

COMMENT ON COLUMN reference.Industry.display_order
IS 'Display order used by user interfaces.';

COMMENT ON COLUMN reference.Industry.description
IS 'Business description of the industry.';

COMMENT ON COLUMN reference.Industry.is_active
IS 'Indicates whether the industry is active.';

COMMENT ON COLUMN reference.Industry.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Industry.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Industry.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.Industry.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Industry.version
IS 'Optimistic concurrency version number.';