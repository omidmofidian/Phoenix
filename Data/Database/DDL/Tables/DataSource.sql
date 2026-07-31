/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : Data_Source.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : DataSource
 * Schema           : ref
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical DataSource reference table.
 *
 * The DataSource table defines the standardized sources from which market,
 * reference, corporate action, portfolio, and analytical data may be acquired.
 * Each record represents an authoritative data provider, broker platform,
 * exchange feed, internal service, file source, API endpoint, or other
 * supported data origin used throughout the Phoenix Platform.
 *
 * Architectural Source
 * -------------------------------------------------------------------------------------------------
 * - ADR-022 Repository Architecture
 * - ADR-026 Normalize Reference Data Model
 * - ADR-027 Canonical Market Data Model
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
 *     None
 *
 * Referenced By
 *     - market.daily_market_data
 *     - market.market_snapshot
 *     - market.market_event
 *     - market.corporate_action
 *     - Synchronization Engine
 *     - ETL Services
 *     - Import Services
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
 * - Designed for multi-provider and multi-market support.
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-30
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-30   Canonical enterprise implementation.
 **************************************************************************************************/

CREATE TABLE ref.data_source
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    data_source_id                    BIGINT
                                          GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                         UUID
                                          NOT NULL
                                          DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    data_source_code                  VARCHAR(50)
                                          NOT NULL,

    data_source_name                  VARCHAR(200)
                                          NOT NULL,

    data_source_short_name            VARCHAR(100),

    data_source_local_name            VARCHAR(200),

    data_source_type                  VARCHAR(30)
                                          NOT NULL,

    provider_name                     VARCHAR(200),

    source_url                        VARCHAR(500),

    data_source_display_order         SMALLINT
                                          NOT NULL
                                          DEFAULT 1,

    data_source_description           VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    data_source_is_active             BOOLEAN
                                          NOT NULL
                                          DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                        TIMESTAMPTZ
                                          NOT NULL
                                          DEFAULT CURRENT_TIMESTAMP,

    updated_at                        TIMESTAMPTZ,

    created_by                        BIGINT
                                          NOT NULL,

    updated_by                        BIGINT,

    row_version                       INTEGER
                                          NOT NULL
                                          DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_data_source
        PRIMARY KEY
        (
            data_source_id
        ),

    CONSTRAINT uk_data_source_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_data_source_code
        UNIQUE
        (
            data_source_code
        ),

    CONSTRAINT ck_data_source_code_not_empty
        CHECK
        (
            LENGTH(TRIM(data_source_code)) > 0
        ),

    CONSTRAINT ck_data_source_code_length
        CHECK 
        (
            LENGTH(TRIM(data_source_code)) BETWEEN 2 AND 50
        ),

    CONSTRAINT ck_data_source_name_not_empty
        CHECK
        (
            LENGTH(TRIM(data_source_name)) > 0
        ),

    CONSTRAINT ck_data_source_short_name_not_empty
        CHECK
        (
            data_source_short_name IS NULL
            OR LENGTH(TRIM(data_source_short_name)) > 0
        ),

    CONSTRAINT ck_data_source_local_name_not_empty
        CHECK
        (
            data_source_local_name IS NULL
            OR LENGTH(TRIM(data_source_local_name)) > 0
        ),

    CONSTRAINT ck_data_source_provider_name_not_empty
        CHECK
        (
            provider_name IS NULL
            OR LENGTH(TRIM(provider_name)) > 0
        ),

    CONSTRAINT ck_data_source_url_not_empty
        CHECK
        (
            source_url IS NULL
            OR LENGTH(TRIM(source_url)) > 0
        ),

    CONSTRAINT ck_data_source_type
        CHECK
        (
            data_source_type IN
            (
                'EXCHANGE',
                'BROKER',
                'API',
                'FILE',
                'DATABASE',
                'SERVICE',
                'MANUAL',
                'OTHER'
            )
        ),

    CONSTRAINT ck_data_source_display_order
        CHECK
        (
            data_source_display_order > 0
        ),

    CONSTRAINT ck_data_source_description_not_empty
        CHECK
        (
            data_source_description IS NULL
            OR LENGTH(TRIM(data_source_description)) > 0
        ),

    CONSTRAINT ck_data_source_row_version_positive
        CHECK
        (
            row_version > 0
        )
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.data_source
IS
'Reference table containing the standardized data sources supported by the
Phoenix Platform. Each record represents an authoritative external or internal
source from which market, reference, corporate action, portfolio, or analytical
data may be acquired.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.data_source.data_source_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.data_source.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.data_source.data_source_code
IS
'Unique business code identifying the data source.';

COMMENT ON COLUMN ref.data_source.data_source_name
IS
'Official business name of the data source.';

COMMENT ON COLUMN ref.data_source.data_source_short_name
IS
'Abbreviated name used by user interfaces and reports.';

COMMENT ON COLUMN ref.data_source.data_source_local_name
IS
'Official local-language name of the data source.';

COMMENT ON COLUMN ref.data_source.data_source_type
IS
'Classification of the data source such as EXCHANGE, BROKER, API, FILE,
DATABASE, SERVICE, MANUAL, or OTHER.';

COMMENT ON COLUMN ref.data_source.provider_name
IS
'Name of the organization or provider that supplies the data.';

COMMENT ON COLUMN ref.data_source.source_url
IS
'Optional URL, endpoint, or location associated with the data source.';

COMMENT ON COLUMN ref.data_source.data_source_display_order
IS
'Display sequence used by applications when presenting data sources to users.';

COMMENT ON COLUMN ref.data_source.data_source_description
IS
'Optional business description of the data source.';

COMMENT ON COLUMN ref.data_source.data_source_is_active
IS
'Indicates whether the data source is currently active and available for use
throughout the Phoenix Platform.';

COMMENT ON COLUMN ref.data_source.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.data_source.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.data_source.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.data_source.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.data_source.row_version
IS
'Optimistic concurrency control version number incremented after each successful
update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------