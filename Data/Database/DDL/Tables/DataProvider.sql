/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : data_provider.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : DataProvider
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical DataProvider reference table.
 *
 * The DataProvider table defines the organizations and systems that supply
 * market data, reference data, corporate actions, news, analytics, or other
 * financial information consumed by the Phoenix Platform.
 *
 * A data provider may represent a stock exchange, market data vendor,
 * brokerage, regulatory authority, financial information service, or an
 * internal Phoenix data service.
 *
 * This table provides standardized provider classifications used throughout
 * market data ingestion, validation, synchronization, auditing, analytics,
 * and historical traceability.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - Architecture Decision Records (ADR)
 * - Domain Model
 * - Enterprise Data Dictionary
 * - Logical Database Model
 * - Physical Database Model
 * - TablePhysicalSpecifications.md
 * - ConstraintSpecifications.md
 * - DDLTemplateSpecification.md
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * Prerequisites
 *     - Schema : ref
 *
 * Referenced Objects
 *     - None
 *
 * Referenced By
 *     - market.tick_data
 *     - market.daily_market_data
 *     - Additional business entities
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - Enterprise Naming Standard
 * - Enterprise Database Design Standard
 * - PostgreSQL Physical Database Design
 * - PostgreSQL Design Decisions
 * - Table Physical Specifications
 * - Constraint Specifications
 * - DDL Template Specification
 *
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-08-02
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-08-02   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE ref.data_provider
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    data_provider_id                BIGINT
                                        GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                       UUID
                                        NOT NULL
                                        DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    data_provider_code              VARCHAR(50)
                                        NOT NULL,

    data_provider_name              VARCHAR(100)
                                        NOT NULL,

    data_provider_display_order     SMALLINT
                                        NOT NULL
                                        DEFAULT 1,

    data_provider_description       VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    data_provider_is_active         BOOLEAN
                                        NOT NULL
                                        DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                      TIMESTAMPTZ
                                        NOT NULL
                                        DEFAULT CURRENT_TIMESTAMP,

    updated_at                      TIMESTAMPTZ,

    created_by                      BIGINT
                                        NOT NULL,

    updated_by                      BIGINT,

    row_version                     INTEGER
                                        NOT NULL
                                        DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_data_provider
        PRIMARY KEY
        (
            data_provider_id
        ),

    CONSTRAINT uk_data_provider_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_data_provider_code
        UNIQUE
        (
            data_provider_code
        ),

    CONSTRAINT uk_data_provider_name
        UNIQUE
        (
            data_provider_name
        ),

    CONSTRAINT ck_data_provider_code_not_empty
        CHECK
        (
            LENGTH(TRIM(data_provider_code)) > 0
        ),

    CONSTRAINT ck_data_provider_code_uppercase
        CHECK
        (
            data_provider_code = UPPER(data_provider_code)
        ),

    CONSTRAINT ck_data_provider_name_not_empty
        CHECK
        (
            LENGTH(TRIM(data_provider_name)) > 0
        ),

    CONSTRAINT ck_data_provider_display_order_positive
        CHECK
        (
            data_provider_display_order > 0
        ),

    CONSTRAINT ck_data_provider_description_not_empty
        CHECK
        (
            data_provider_description IS NULL
            OR LENGTH(TRIM(data_provider_description)) > 0
        ),

    CONSTRAINT ck_data_provider_row_version_positive
        CHECK
        (
            row_version > 0
        )
);


--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.data_provider
IS
'Reference table defining the authoritative organizations and systems that
provide market data, reference data, corporate actions, news, analytics, and
other financial information consumed by the Phoenix Platform. Each record
represents an approved data provider used for market data ingestion,
normalization, validation, synchronization, auditing, and historical
traceability across the platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.data_provider.data_provider_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.data_provider.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.data_provider.data_provider_code
IS
'Unique business code identifying the data provider.';

COMMENT ON COLUMN ref.data_provider.data_provider_name
IS
'Official business name of the data provider.';

COMMENT ON COLUMN ref.data_provider.data_provider_display_order
IS
'Display sequence used by applications when presenting data providers to users.';

COMMENT ON COLUMN ref.data_provider.data_provider_description
IS
'Optional business description providing additional information about the
data provider.';

COMMENT ON COLUMN ref.data_provider.data_provider_is_active
IS
'Indicates whether the data provider is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.data_provider.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.data_provider.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.data_provider.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.data_provider.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.data_provider.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------