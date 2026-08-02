/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : instrument_status_history.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : InstrumentStatusHistory
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the InstrumentStatusHistory table.
 *
 * The InstrumentStatusHistory table stores the complete history of business
 * status changes for each listed financial instrument. Every status transition
 * is recorded together with its effective period, allowing the Phoenix Platform
 * to reconstruct the exact lifecycle of an instrument at any point in time.
 *
 * Unlike TradingHalt and InstrumentSuspension, which record specific market
 * events, this table maintains the historical timeline of the instrument's
 * operational status.
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
 *     - Table  : market.listing
 *     - Table  : ref.market_status
 *     - Table  : ref.market_event_type
 *
 * Referenced Objects
 *     - market.listing
 *     - ref.market_status
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
 * Notes
 * -------------------------------------------------------------------------------------------------
 * - One database object per script.
 * - One table per file.
 * - Architecture-driven implementation.
 * - PostgreSQL 17 compatible.
 * - PostgreSQL Extension : btree_gist
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

CREATE TABLE market.instrument_status_history
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    instrument_status_history_id      BIGINT
                                          GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                         UUID
                                          NOT NULL
                                          DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    listing_id             BIGINT
                                          NOT NULL,

    previous_market_status_id         BIGINT,

    market_status_id                  BIGINT
                                          NOT NULL,

    status_event_type_id              BIGINT
                                          NOT NULL,
    
    trigger_event_type_id          BIGINT,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    change_reason_code                VARCHAR(50),

    effective_from                    TIMESTAMPTZ
                                          NOT NULL,

    effective_to                      TIMESTAMPTZ,

    announced_at                      TIMESTAMPTZ,

    reference_number                  VARCHAR(200),

    source_reference                  VARCHAR(500),

    status_change_reason                     VARCHAR(500),

    status_change_description                       VARCHAR(500),

    ----------------------------------------------------------------------------
    -- Business Status
    ----------------------------------------------------------------------------

    instrument_status_history_is_active                         BOOLEAN
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

    row_version                           INTEGER
                                          NOT NULL
                                          DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_instrument_status_history
        PRIMARY KEY
        (
            instrument_status_history_id
        ),

    CONSTRAINT uk_instrument_status_history_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_instrument_status_history_business
        UNIQUE
        (
            listing_id,
            market_status_id,
            effective_from
        ),

    CONSTRAINT ex_instrument_status_history_period_overlap
        EXCLUDE USING gist
            (
                listing_id WITH =,
                tstzrange(effective_from, effective_to, '[)') WITH &&
            ),

    CONSTRAINT ck_instrument_status_history_previous_market_status
        CHECK (
            previous_market_status_id IS NULL
            OR previous_market_status_id <> market_status_id
        ),

    CONSTRAINT ck_instrument_status_history_announcement
        CHECK (
            announced_at IS NULL
            OR announced_at <= effective_from
        ),

    CONSTRAINT ck_instrument_status_history_reference_not_empty
        CHECK
        (
            reference_number IS NULL
            OR LENGTH(TRIM(reference_number)) > 0
        ),

    CONSTRAINT ck_instrument_status_history_source_reference_not_empty
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_instrument_status_history_period
        CHECK
        (
            effective_to IS NULL
            OR effective_to >= effective_from
        ),

    CONSTRAINT ck_instrument_status_history_change_reason_code_not_empty
        CHECK
        (
            change_reason_code IS NULL
            OR LENGTH(TRIM(change_reason_code)) > 0
        ),

    CONSTRAINT ck_instrument_status_history_row_version_positive
        CHECK
        (
            row_version > 0
        ),

    CONSTRAINT fk_instrument_status_history_listing
        FOREIGN KEY
        (
            listing_id
        )
        REFERENCES market.listing
        (
            listing_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_status_history_market_status
        FOREIGN KEY
        (
            market_status_id
        )
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_status_history_previous_market_status
        FOREIGN KEY
        (
            previous_market_status_id
        )
        REFERENCES ref.market_status
        (
            market_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_status_history_trigger_event_type
        FOREIGN KEY
        (
            trigger_event_type_id
        )
        REFERENCES ref.market_event_type
        (
            market_event_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_instrument_status_history_status_event_type
        FOREIGN KEY
        (
            status_event_type_id
        )
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

COMMENT ON TABLE market.instrument_status_history
IS
'Stores the complete history of business status changes for listed financial
instruments. Each record represents a status transition together with its
effective period, announcement information, and supporting business references,
allowing the complete lifecycle of an instrument to be reconstructed at any
point in time.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.instrument_status_history.instrument_status_history_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.instrument_status_history.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.instrument_status_history.listing_id
IS
'Reference to the listed financial instrument whose status changed.';

COMMENT ON COLUMN market.instrument_status_history.previous_market_status_id
IS
'Reference to the market status that was effective immediately before the current status became active.';

COMMENT ON COLUMN market.instrument_status_history.market_status_id
IS
'Reference to the current market status assigned to the financial instrument during the effective period.';

COMMENT ON COLUMN market.instrument_status_history.status_event_type_id
IS
'Reference to the market event type responsible for the status transition.';

COMMENT ON COLUMN market.instrument_status_history.trigger_event_type_id
IS
'Reference to the market event type that initiated or caused the status transition.';

COMMENT ON COLUMN market.instrument_status_history.change_reason_code
IS
'Optional business code identifying the specific reason for the status transition according to exchange or regulatory classifications.';

COMMENT ON COLUMN market.instrument_status_history.effective_from
IS
'Timestamp indicating when the instrument status became effective.';

COMMENT ON COLUMN market.instrument_status_history.effective_to
IS
'Timestamp indicating when the instrument status ceased to be effective. NULL indicates that the status is currently in effect.';

COMMENT ON COLUMN market.instrument_status_history.announced_at
IS
'Timestamp when the status change was officially announced by the exchange or regulatory authority.';

COMMENT ON COLUMN market.instrument_status_history.reference_number
IS
'Official announcement number or regulatory reference identifying the status change.';

COMMENT ON COLUMN market.instrument_status_history.source_reference
IS
'External reference identifying the official source of the status change, such as an exchange announcement, regulatory notice, document identifier, or URL.';

COMMENT ON COLUMN market.instrument_status_history.status_change_reason
IS
'Business explanation describing the reason for the instrument status change.';

COMMENT ON COLUMN market.instrument_status_history.status_change_description
IS
'Optional business description providing additional information about the status transition.';

COMMENT ON COLUMN market.instrument_status_history.instrument_status_history_is_active
IS
'Indicates whether the status history record is currently active and valid within the Phoenix Platform.';

COMMENT ON COLUMN market.instrument_status_history.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.instrument_status_history.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.instrument_status_history.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.instrument_status_history.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.instrument_status_history.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------