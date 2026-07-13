/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 020-CreateMarket.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Market
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Market reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 010-CreateExchange.sql
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
 * 1.0       2026-07-11   Initial version
 **************************************************************************************************/

CREATE TABLE reference.Market
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    market_id              BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id              UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    exchange_id            BIGINT NOT NULL,

    code                   VARCHAR(20)  NOT NULL,
    name                   VARCHAR(200) NOT NULL,
    short_name             VARCHAR(100),
    english_name           VARCHAR(200),
    display_order          SMALLINT NOT NULL DEFAULT 1,
    description            VARCHAR(500),

    ------------------------------------------------------------------------------
    -- Business Status
    ------------------------------------------------------------------------------

    is_active              BOOLEAN NOT NULL DEFAULT TRUE,

    ------------------------------------------------------------------------------
    -- Audit Columns
    ------------------------------------------------------------------------------

    created_at             TIMESTAMPTZ NOT NULL,
    created_by             BIGINT NOT NULL,

    updated_at             TIMESTAMPTZ,
    updated_by             BIGINT,

    version                INTEGER NOT NULL DEFAULT 1,

    ------------------------------------------------------------------------------
    -- Constraints
    ------------------------------------------------------------------------------

    CONSTRAINT PK_Market
        PRIMARY KEY (market_id),

    CONSTRAINT UQ_Market_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Market_Exchange_Code
        UNIQUE (exchange_id, code)
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.Market
IS 'Reference table containing markets within supported exchanges.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Market.market_id
IS 'Internal surrogate identifier.';

COMMENT ON COLUMN reference.Market.public_id
IS 'Public immutable identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Market.exchange_id
IS 'Identifier of the parent exchange.';

COMMENT ON COLUMN reference.Market.code
IS 'Unique business code within the exchange.';

COMMENT ON COLUMN reference.Market.name
IS 'Official market name.';

COMMENT ON COLUMN reference.Market.short_name
IS 'Short display name.';

COMMENT ON COLUMN reference.Market.english_name
IS 'Official English name.';

COMMENT ON COLUMN reference.Market.display_order
IS 'Display sequence used by user interfaces.';

COMMENT ON COLUMN reference.Market.description
IS 'Business description of the market.';

COMMENT ON COLUMN reference.Market.is_active
IS 'Indicates whether the market is active.';

COMMENT ON COLUMN reference.Market.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Market.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Market.updated_at
IS 'Timestamp of the last update.';

COMMENT ON COLUMN reference.Market.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Market.version
IS 'Optimistic concurrency version number.';