/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : InstrumentSuspension.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentSuspension
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the InstrumentSuspension table.
 *
 * The InstrumentSuspension table records official suspension periods affecting
 * listed financial instruments. A suspension represents a regulatory or
 * exchange-imposed restriction preventing an instrument from being traded until
 * the suspension is lifted.
 *
 * Unlike TradingHalt, which represents operational interruptions to trading,
 * InstrumentSuspension records formal business or regulatory suspension events
 * that may remain effective for extended periods.
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
 *     - Schema : market
 *     - Schema : ref
 *     - Table  : market.instrument_listing
 *     - Table  : ref.market_status
 *     - Table  : ref.instrument_suspension_reason
 *     - Table  : ref.market_event_type
 *
 * Referenced Objects
 *     - market.instrument_listing
 *     - ref.market_status
 *     - ref.instrument_suspension_reason
 *     - ref.market_event_type
 *
 * Referenced By
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
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.instrument_suspension
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_suspension_id         BIGINT
                                         GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                        UUID
                                         NOT NULL
                                         DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    instrument_listing_id            BIGINT
                                         NOT NULL,

    market_status_id                 BIGINT
                                         NOT NULL,

    instrument_suspension_reason_id  BIGINT
                                         NOT NULL,

    market_event_type_id             BIGINT
                                         NOT NULL,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    suspension_code                  VARCHAR(50)
                                         NOT NULL,

    suspended_at                     TIMESTAMPTZ
                                         NOT NULL,

    expected_reactivation_at         TIMESTAMPTZ,

    reactivated_at                   TIMESTAMPTZ,

    announced_at                     TIMESTAMPTZ,

    reference_number                 VARCHAR(200),

    source_reference                 VARCHAR(500),

    suspension_reason                VARCHAR(500)
                                         NOT NULL,

    description                      VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    is_active                        BOOLEAN
                                         NOT NULL
                                         DEFAULT TRUE,

    ----------------------------------------------------------------------------
    -- Audit Columns
    ----------------------------------------------------------------------------

    created_at                       TIMESTAMPTZ
                                         NOT NULL
                                         DEFAULT CURRENT_TIMESTAMP,

    updated_at                       TIMESTAMPTZ,

    created_by                       BIGINT
                                         NOT NULL,

    updated_by                       BIGINT,

    version                          INTEGER
                                         NOT NULL
                                         DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_suspension
        PRIMARY KEY
        (
            instrument_suspension_id
        ),

    CONSTRAINT uq_instrument_suspension_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_instrument_suspension_code
        UNIQUE
        (
            suspension_code
        ),

    CONSTRAINT ck_instrument_suspension_code_not_empty
        CHECK (LENGTH(TRIM(suspension_code)) > 0),

    CONSTRAINT ck_instrument_suspension_reason_not_empty
        CHECK (LENGTH(TRIM(suspension_reason)) > 0),

    CONSTRAINT ck_instrument_suspension_reference_not_empty
        CHECK
        (
            reference_number IS NULL
            OR LENGTH(TRIM(reference_number)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_source_not_empty
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_instrument_suspension_expected_date
        CHECK
        (
            expected_reactivation_at IS NULL
            OR expected_reactivation_at >= suspended_at
        ),

    CONSTRAINT ck_instrument_suspension_reactivated_date
        CHECK
        (
            reactivated_at IS NULL
            OR reactivated_at >= suspended_at
        ),

    CONSTRAINT ck_instrument_suspension_version_positive
        CHECK
        (
            version > 0
        ),

    CONSTRAINT fk_instrument_suspension_listing
        FOREIGN KEY (instrument_listing_id)
        REFERENCES market.instrument_listing
        (
            instrument_listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_suspension_market_status
        FOREIGN KEY (market_status_id)
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_suspension_reason
        FOREIGN KEY (instrument_suspension_reason_id)
        REFERENCES ref.instrument_suspension_reason
        (
            instrument_suspension_reason_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_suspension_event_type
        FOREIGN KEY (market_event_type_id)
        REFERENCES ref.market_event_type
        (
            market_event_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.instrument_suspension
IS
'Stores the complete history of official suspension periods affecting listed
financial instruments. Each record represents a regulatory or exchange-imposed
suspension event, including its classification, effective period, expected
reactivation, actual reactivation, and associated business information.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_suspension.instrument_suspension_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.instrument_suspension.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.instrument_suspension.instrument_listing_id
IS
'Reference to the listed financial instrument affected by the suspension.';

COMMENT ON COLUMN market.instrument_suspension.market_status_id
IS
'Reference to the market status associated with the suspension period.';

COMMENT ON COLUMN market.instrument_suspension.instrument_suspension_reason_id
IS
'Reference to the standardized business reason for the instrument suspension.';

COMMENT ON COLUMN market.instrument_suspension.market_event_type_id
IS
'Reference to the market event type associated with this suspension event.';

COMMENT ON COLUMN market.instrument_suspension.suspension_code
IS
'Unique business code identifying the suspension event.';

COMMENT ON COLUMN market.instrument_suspension.suspended_at
IS
'Timestamp indicating when the instrument suspension became effective.';

COMMENT ON COLUMN market.instrument_suspension.expected_reactivation_at
IS
'Expected timestamp when trading is planned to resume according to the official exchange announcement.';

COMMENT ON COLUMN market.instrument_suspension.reactivated_at
IS
'Actual timestamp when the instrument suspension ended and trading resumed.';

COMMENT ON COLUMN market.instrument_suspension.announced_at
IS
'Timestamp when the suspension was officially announced by the exchange or regulatory authority.';

COMMENT ON COLUMN market.instrument_suspension.reference_number
IS
'Official announcement number or regulatory reference identifying the suspension event.';

COMMENT ON COLUMN market.instrument_suspension.source_reference
IS
'External reference identifying the official source of the suspension information, such as an exchange announcement, regulatory notice, document identifier, or URL.';

COMMENT ON COLUMN market.instrument_suspension.suspension_reason
IS
'Business explanation describing the specific reason for the instrument suspension.';

COMMENT ON COLUMN market.instrument_suspension.description
IS
'Optional business description providing additional information about the suspension event.';

COMMENT ON COLUMN market.instrument_suspension.is_active
IS
'Indicates whether the suspension record is currently active and valid within the Phoenix Platform.';

COMMENT ON COLUMN market.instrument_suspension.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.instrument_suspension.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.instrument_suspension.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.instrument_suspension.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.instrument_suspension.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------