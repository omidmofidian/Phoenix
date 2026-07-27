/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : MarketSnapshotType.sql
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

    snapshot_type_code                         VARCHAR(30)
                                     NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Information
    ----------------------------------------------------------------------------

    snapshot_type_name                         VARCHAR(100)
                                     NOT NULL,

    description                  TEXT,

    sort_order                   SMALLINT
                                     NOT NULL
                                     DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                    BOOLEAN
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

    version                      INTEGER
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

    CONSTRAINT uq_market_snapshot_type_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_market_snapshot_type_code
        UNIQUE
        (
            snapshot_type_code
        ),

    ----------------------------------------------------------------------------
    -- Check Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT ck_market_snapshot_type_code
        CHECK
        (
            LENGTH(TRIM(snapshot_type_code)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_name
        CHECK
        (
            LENGTH(TRIM(snapshot_type_name)) > 0
        ),

    CONSTRAINT ck_market_snapshot_type_sort_order
        CHECK
        (
            sort_order > 0
        ),

    CONSTRAINT ck_market_snapshot_type_version
        CHECK
        (
            version > 0
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

COMMENT ON COLUMN ref.market_snapshot_type.snapshot_type_code
IS
'Stable business code uniquely identifying the market snapshot type.';

----------------------------------------------------------------------------
-- Business Information
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.snapshot_type_name
IS
'Business name of the market snapshot type.';

COMMENT ON COLUMN ref.market_snapshot_type.description
IS
'Optional business description explaining the purpose and usage of the market snapshot type.';

COMMENT ON COLUMN ref.market_snapshot_type.sort_order
IS
'Display and processing order used when presenting market snapshot types.';

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

COMMENT ON COLUMN ref.market_snapshot_type.is_active
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

COMMENT ON COLUMN ref.market_snapshot_type.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------