/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Market_Snapshot_Type.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Reference Table
 * Object Name      : MarketSnapshotType
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical MarketSnapshotType reference table.
 *
 * The MarketSnapshotType table defines the business classification of market
 * snapshots captured by the Phoenix Platform. It provides a standardized
 * reference used by market data entities to identify how and why a snapshot
 * was generated.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - ADR-026 Normalize Reference Data Model
 * - ADR-027 Canonical Market Data Model
 * - Domain Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 *
 * Referenced By
 * -------------------------------------------------------------------------------------------------
 *     - market.order_book_snapshot
 *     - market.market_snapshot (future)
 *     - market.market_depth_snapshot (future)
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - Canonical reference table.
 * - Shared by all supported financial markets.
 * - PostgreSQL 17 compatible.
 **************************************************************************************************/

CREATE TABLE ref.market_snapshot_type
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    market_snapshot_type_id      BIGINT
                                     GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                    UUID
                                     NOT NULL
                                     DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Identifier
    ----------------------------------------------------------------------------

    market_snapshot_type_code                         VARCHAR(30)
                                     NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Information
    ----------------------------------------------------------------------------

    market_snapshot_type_name                         VARCHAR(100)
                                     NOT NULL,

    market_snapshot_type_short_name                 VARCHAR(50),

    market_snapshot_type_local_name                 VARCHAR(100),

    market_snapshot_type_description                  TEXT,

    market_snapshot_type_display_order                   SMALLINT
                                     NOT NULL
                                     DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    market_snapshot_type_is_active                    BOOLEAN
                                     NOT NULL
                                     DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                   TIMESTAMPTZ
                                     NOT NULL
                                     DEFAULT CURRENT_TIMESTAMP,

    created_by                   BIGINT
                                     NOT NULL,

    updated_at                   TIMESTAMPTZ,

    updated_by                   BIGINT,

    row_version                      INTEGER
                                     NOT NULL
                                     DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_market_snapshot_type
        PRIMARY KEY
        (
            market_snapshot_type_id
        ),

    CONSTRAINT uk_market_snapshot_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_market_snapshot_type_code
        UNIQUE
        (
            market_snapshot_type_code
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_market_snapshot_type_code
        CHECK
        (
            LENGTH(TRIM(market_snapshot_type_code)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_code_uppercase
        CHECK
        (
            market_snapshot_type_code = UPPER(market_snapshot_type_code)
        ),

    CONSTRAINT ck_market_snapshot_type_name
        CHECK
        (
            LENGTH(TRIM(market_snapshot_type_name)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_short_name_not_empty
    CHECK
        (
            market_snapshot_type_short_name IS NULL
            OR LENGTH(TRIM(market_snapshot_type_short_name)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_local_name_not_empty
    CHECK
        (
            market_snapshot_type_local_name IS NULL
            OR LENGTH(TRIM(market_snapshot_type_local_name)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_display_order
        CHECK
        (
            market_snapshot_type_display_order > 0
        ),

    CONSTRAINT ck_market_snapshot_type_description_not_empty
        CHECK
        (
            market_snapshot_type_description IS NULL
            OR LENGTH(TRIM(market_snapshot_type_description)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.market_snapshot_type
IS
'Defines the canonical business classification of market snapshots supported by
the Phoenix Platform. Each record identifies how and why a market snapshot was
generated and provides a standardized reference used by market data entities
across supported financial markets.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.market_snapshot_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
APIs, and distributed systems.';

----------------------------------------------------------------------------
-- Business Identifier
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_code
IS
'Stable business code uniquely identifying the market snapshot type.';

----------------------------------------------------------------------------
-- Business Information
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_name
IS
'Business name of the market snapshot type.';

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_local_name
IS
'Official local-language name of the market snapshot type.';

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_description
IS
'Optional business description explaining the purpose and usage of the market snapshot type.';

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_display_order
IS
'Display and processing order used when presenting market snapshot types.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.market_snapshot_type_is_active
IS
'Indicates whether the market snapshot type is active and available for business operations.';

----------------------------------------------------------------------------
-- Audit Columns
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.market_snapshot_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.market_snapshot_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.market_snapshot_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.market_snapshot_type.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------