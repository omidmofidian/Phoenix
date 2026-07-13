/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 070-CreateSymbol.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Symbol
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Symbol reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 060-CreateCompany.sql
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

CREATE TABLE reference.Symbol
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    symbol_id               BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id               UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    code                    VARCHAR(50)  NOT NULL,
    ticker                  VARCHAR(50)  NOT NULL,
    name                    VARCHAR(250) NOT NULL,
    short_name              VARCHAR(100),
    english_name            VARCHAR(250),
    isin                    VARCHAR(12),
    display_order           SMALLINT NOT NULL DEFAULT 1,
    description             VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Foreign Keys
    ------------------------------------------------------------------------------

    company_id              BIGINT NOT NULL,

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

    CONSTRAINT PK_Symbol
        PRIMARY KEY (symbol_id),

    CONSTRAINT UQ_Symbol_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Symbol_Code
        UNIQUE (code),

    CONSTRAINT UQ_Symbol_Ticker
        UNIQUE (ticker),

    CONSTRAINT UQ_Symbol_ISIN
        UNIQUE (isin)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.Symbol
IS 'Stores tradable market symbols supported by the Phoenix Platform.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Symbol.symbol_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.Symbol.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Symbol.code
IS 'Unique business code of the symbol.';

COMMENT ON COLUMN reference.Symbol.ticker
IS 'Trading ticker displayed by the exchange.';

COMMENT ON COLUMN reference.Symbol.name
IS 'Official symbol name.';

COMMENT ON COLUMN reference.Symbol.short_name
IS 'Short display name of the symbol.';

COMMENT ON COLUMN reference.Symbol.english_name
IS 'Official English symbol name.';

COMMENT ON COLUMN reference.Symbol.isin
IS 'International Securities Identification Number (ISIN).';

COMMENT ON COLUMN reference.Symbol.display_order
IS 'Display order used by user interfaces.';

COMMENT ON COLUMN reference.Symbol.description
IS 'Business description of the symbol.';

COMMENT ON COLUMN reference.Symbol.company_id
IS 'References the parent company.';

COMMENT ON COLUMN reference.Symbol.is_active
IS 'Indicates whether the symbol is active.';

COMMENT ON COLUMN reference.Symbol.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Symbol.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Symbol.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.Symbol.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Symbol.version
IS 'Optimistic concurrency version number.';