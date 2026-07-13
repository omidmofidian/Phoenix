/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 010-CreateExchange.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Exchange
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Exchange reference table.
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
 * 1.0       2026-07-11   Initial version
 **************************************************************************************************/

CREATE TABLE reference.Exchange
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    exchange_id            BIGINT GENERATED ALWAYS AS IDENTITY,

    ------------------------------------------------------------------------------
    -- Public Identifier
    ------------------------------------------------------------------------------

    public_id              UUID NOT NULL,

    ------------------------------------------------------------------------------
    -- Business Attributes
    ------------------------------------------------------------------------------

    code                   VARCHAR(20)  NOT NULL,
    name                   VARCHAR(200) NOT NULL,
    short_name             VARCHAR(100),
    english_name           VARCHAR(200),
    country_code           CHAR(2),
    website                VARCHAR(300),
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

    CONSTRAINT PK_Exchange
        PRIMARY KEY (exchange_id),

    CONSTRAINT UQ_Exchange_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Exchange_Code
        UNIQUE (code)
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE reference.Exchange
IS 'Reference table containing stock exchanges supported by the Phoenix Platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Exchange.exchange_id
IS 'Internal surrogate identifier.';

COMMENT ON COLUMN reference.Exchange.public_id
IS 'Public immutable identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Exchange.code
IS 'Unique business code of the exchange.';

COMMENT ON COLUMN reference.Exchange.name
IS 'Official exchange name.';

COMMENT ON COLUMN reference.Exchange.short_name
IS 'Short display name.';

COMMENT ON COLUMN reference.Exchange.english_name
IS 'Official English name.';

COMMENT ON COLUMN reference.Exchange.country_code
IS 'ISO 3166-1 Alpha-2 country code.';

COMMENT ON COLUMN reference.Exchange.website
IS 'Official website of the exchange.';

COMMENT ON COLUMN reference.Exchange.display_order
IS 'Display sequence used by user interfaces.';

COMMENT ON COLUMN reference.Exchange.description
IS 'Business description of the exchange.';

COMMENT ON COLUMN reference.Exchange.is_active
IS 'Indicates whether the exchange is active.';

COMMENT ON COLUMN reference.Exchange.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Exchange.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Exchange.updated_at
IS 'Timestamp of the last update.';

COMMENT ON COLUMN reference.Exchange.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Exchange.version
IS 'Optimistic concurrency version number.';