/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 060-CreateCompany.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Company
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Company reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 010-CreateExchange.sql
 * 020-CreateMarket.sql
 * 030-CreateBoard.sql
 * 040-CreateIndustry.sql
 * 050-CreateSector.sql
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

CREATE TABLE reference.Company
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    company_id              BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id               UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    code                    VARCHAR(20)  NOT NULL,
    name                    VARCHAR(250) NOT NULL,
    short_name              VARCHAR(100),
    english_name            VARCHAR(250),
    national_id             VARCHAR(50),
    registration_number     VARCHAR(50),
    economic_code           VARCHAR(50),
    display_order           SMALLINT NOT NULL DEFAULT 1,
    description             VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    exchange_id             BIGINT NOT NULL,
    market_id               BIGINT NOT NULL,
    board_id                BIGINT NOT NULL,
    industry_id             BIGINT NOT NULL,
    sector_id               BIGINT NOT NULL,

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

    CONSTRAINT PK_Company
        PRIMARY KEY (company_id),

    CONSTRAINT UQ_Company_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Company_Code
        UNIQUE (code)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.Company
IS 'Stores listed companies supported by the Phoenix Platform.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Company.company_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.Company.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Company.code
IS 'Unique business code of the company.';

COMMENT ON COLUMN reference.Company.name
IS 'Official company name.';

COMMENT ON COLUMN reference.Company.short_name
IS 'Short display name of the company.';

COMMENT ON COLUMN reference.Company.english_name
IS 'Official English company name.';

COMMENT ON COLUMN reference.Company.national_id
IS 'National legal identifier of the company.';

COMMENT ON COLUMN reference.Company.registration_number
IS 'Official company registration number.';

COMMENT ON COLUMN reference.Company.economic_code
IS 'Official economic or tax identification code.';

COMMENT ON COLUMN reference.Company.display_order
IS 'Display order used by user interfaces.';

COMMENT ON COLUMN reference.Company.description
IS 'Business description of the company.';

COMMENT ON COLUMN reference.Company.exchange_id
IS 'References the parent exchange.';

COMMENT ON COLUMN reference.Company.market_id
IS 'References the parent market.';

COMMENT ON COLUMN reference.Company.board_id
IS 'References the parent trading board.';

COMMENT ON COLUMN reference.Company.industry_id
IS 'References the parent industry.';

COMMENT ON COLUMN reference.Company.sector_id
IS 'References the parent sector.';

COMMENT ON COLUMN reference.Company.is_active
IS 'Indicates whether the company is active.';

COMMENT ON COLUMN reference.Company.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Company.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Company.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.Company.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Company.version
IS 'Optimistic concurrency version number.';