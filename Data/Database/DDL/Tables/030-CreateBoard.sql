/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 030-CreateBoard.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : Board
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the Board reference table.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 010-CreateExchange.sql
 * 020-CreateMarket.sql
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

CREATE TABLE reference.Board
(
    ------------------------------------------------------------------------------
    -- Primary Identifier
    ------------------------------------------------------------------------------

    board_id                BIGINT GENERATED ALWAYS AS IDENTITY,

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

    market_id               BIGINT NOT NULL,

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

    CONSTRAINT PK_Board
        PRIMARY KEY (board_id),

    CONSTRAINT UQ_Board_PublicId
        UNIQUE (public_id),

    CONSTRAINT UQ_Board_Market_Code
        UNIQUE (market_id, code)
);

----------------------------------------------------------------------------------------------------
-- Table Comment
----------------------------------------------------------------------------------------------------

COMMENT ON TABLE reference.Board
IS 'Stores trading boards defined within each market.';

----------------------------------------------------------------------------------------------------
-- Column Comments
----------------------------------------------------------------------------------------------------

COMMENT ON COLUMN reference.Board.board_id
IS 'Internal surrogate primary key.';

COMMENT ON COLUMN reference.Board.public_id
IS 'Immutable public identifier used for external integration and synchronization.';

COMMENT ON COLUMN reference.Board.code
IS 'Unique business code of the board within its market.';

COMMENT ON COLUMN reference.Board.name
IS 'Official business name of the board.';

COMMENT ON COLUMN reference.Board.short_name
IS 'Short display name of the board.';

COMMENT ON COLUMN reference.Board.english_name
IS 'Official English name of the board.';

COMMENT ON COLUMN reference.Board.display_order
IS 'Display order used by user interfaces.';

COMMENT ON COLUMN reference.Board.description
IS 'Business description of the board.';

COMMENT ON COLUMN reference.Board.market_id
IS 'References the parent market.';

COMMENT ON COLUMN reference.Board.is_active
IS 'Indicates whether the board is active.';

COMMENT ON COLUMN reference.Board.created_at
IS 'Timestamp when the record was created.';

COMMENT ON COLUMN reference.Board.created_by
IS 'Identifier of the user or process that created the record.';

COMMENT ON COLUMN reference.Board.updated_at
IS 'Timestamp when the record was last updated.';

COMMENT ON COLUMN reference.Board.updated_by
IS 'Identifier of the user or process that last updated the record.';

COMMENT ON COLUMN reference.Board.version
IS 'Optimistic concurrency version number.';