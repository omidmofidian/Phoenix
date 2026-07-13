/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : NNN-Create<TableName>.sql
 * Category         : DDL
 * Object Type      : Table
 * Object Name      : <TableName>
 * Version          : 1.0
 * Status           : Draft
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the <TableName> table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * - List prerequisite tables or scripts.
 *
 * Related Standards
 * -------------------------------------------------------------------------------------------------
 * - SQLScriptDevelopmentStandard
 * - DatabaseDDLDevelopmentStandard
 * - TableDevelopmentStandard
 * - ConstraintDevelopmentStandard
 * - IndexDevelopmentStandard
 *
 * Related ADRs
 * -------------------------------------------------------------------------------------------------
 * - ADR-xxx
 *
 * Author           : Phoenix Architecture Team
 * Created          : YYYY-MM-DD
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 1.0       YYYY-MM-DD   Initial version
 **************************************************************************************************/

CREATE TABLE <schema_name>.<TableName>
(
    -------------------------------------------------------------------------------
    -- Primary Identifier
    -------------------------------------------------------------------------------

    id                  BIGINT GENERATED ALWAYS AS IDENTITY,

    -------------------------------------------------------------------------------
    -- Public Identifier
    -------------------------------------------------------------------------------

    public_id           UUID NOT NULL,

    -------------------------------------------------------------------------------
    -- Business Attributes
    -------------------------------------------------------------------------------

    code                VARCHAR(50)  NOT NULL,
    name                VARCHAR(200) NOT NULL,
    description         VARCHAR(500),

    -------------------------------------------------------------------------------
    -- Foreign Keys
    -------------------------------------------------------------------------------

    parent_id           BIGINT,

    -------------------------------------------------------------------------------
    -- Business Status
    -------------------------------------------------------------------------------

    is_active           BOOLEAN NOT NULL DEFAULT TRUE,

    -------------------------------------------------------------------------------
    -- Audit Columns
    -------------------------------------------------------------------------------

    created_at          TIMESTAMPTZ NOT NULL,
    created_by          BIGINT NOT NULL,

    updated_at          TIMESTAMPTZ,
    updated_by          BIGINT,

    version             INTEGER NOT NULL DEFAULT 1,

    -------------------------------------------------------------------------------
    -- Constraints
    -------------------------------------------------------------------------------

    CONSTRAINT PK_<TableName>
        PRIMARY KEY (id),

    CONSTRAINT UQ_<TableName>_PublicId
        UNIQUE (public_id)

);

COMMENT ON TABLE <schema_name>.<TableName>
IS '<Business description>';

COMMENT ON COLUMN <schema_name>.<TableName>.id
IS 'Internal surrogate identifier.';

COMMENT ON COLUMN <schema_name>.<TableName>.public_id
IS 'Public business identifier.';

COMMENT ON COLUMN <schema_name>.<TableName>.code
IS 'Business code.';

COMMENT ON COLUMN <schema_name>.<TableName>.name
IS 'Business name.';

COMMENT ON COLUMN <schema_name>.<TableName>.description
IS 'Business description.';

COMMENT ON COLUMN <schema_name>.<TableName>.parent_id
IS 'Reference to parent entity.';

COMMENT ON COLUMN <schema_name>.<TableName>.is_active
IS 'Business active flag.';

COMMENT ON COLUMN <schema_name>.<TableName>.created_at
IS 'Creation timestamp.';

COMMENT ON COLUMN <schema_name>.<TableName>.created_by
IS 'Creator identifier.';

COMMENT ON COLUMN <schema_name>.<TableName>.updated_at
IS 'Last update timestamp.';

COMMENT ON COLUMN <schema_name>.<TableName>.updated_by
IS 'Last updater identifier.';

COMMENT ON COLUMN <schema_name>.<TableName>.version
IS 'Optimistic concurrency version.';