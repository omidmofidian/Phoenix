/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : CorporateAction.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : CorporateAction
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical CorporateAction table.
 *
 * The CorporateAction table stores corporate events announced by listed
 * companies that affect financial instruments, shareholders, market prices,
 * or capital structure. Each corporate action is associated with exactly one
 * financial instrument and is classified by both action type and action status.
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
 *     - Table  : ref.instrument
 *     - Table  : ref.corporate_action_type
 *     - Table  : ref.corporate_action_status
 *     - Table  : ref.currency
 *
 * Referenced Objects
 *     - ref.instrument
 *     - ref.corporate_action_type
 *     - ref.corporate_action_status
 *     - ref.currency
 *
 * Referenced By
 *     - Additional corporate action processing entities
 *     - Portfolio services
 *     - Analytics services
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
 * Created          : 2026-07-26
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 2026.1    2026-07-26   Initial canonical implementation.
 **************************************************************************************************/

CREATE TABLE market.corporate_action
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    corporate_action_id          BIGINT
                                    GENERATED ALWAYS AS IDENTITY,

    ----------------------------------------------------------------------------
    -- Public Identifier
    ----------------------------------------------------------------------------

    public_id                    UUID
                                    NOT NULL
                                    DEFAULT gen_random_uuid(),

    ----------------------------------------------------------------------------
    -- Classification References
    ----------------------------------------------------------------------------

    instrument_id                BIGINT
                                    NOT NULL,

    corporate_action_type_id     BIGINT
                                    NOT NULL,

    corporate_action_status_id   BIGINT
                                    NOT NULL,

    currency_id                  BIGINT,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    announcement_date            DATE
                                    NOT NULL,

    effective_date               DATE
                                    NOT NULL,

    record_date                  DATE,

    payment_date                 DATE,

    reference_number             VARCHAR(100),

    title                        VARCHAR(300)
                                    NOT NULL,

    ratio                         NUMERIC(18,8),

    amount                        NUMERIC(18,4),

    old_value                     NUMERIC(18,4),

    new_value                     NUMERIC(18,4),

    description                  VARCHAR(1000),

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

    updated_at                   TIMESTAMPTZ,

    created_by                   BIGINT
                                    NOT NULL,

    updated_by                   BIGINT,

    version                      INTEGER
                                    NOT NULL
                                    DEFAULT 1,

    ----------------------------------------------------------------------------
    -- Constraints
    ----------------------------------------------------------------------------

    CONSTRAINT pk_corporate_action
        PRIMARY KEY
        (
            corporate_action_id
        ),

    CONSTRAINT uk_corporate_action_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uk_corporate_action_business
        UNIQUE
        (
            instrument_id,
            corporate_action_type_id,
            effective_date
        ),

    CONSTRAINT ck_corporate_action_title_not_empty
        CHECK
        (
            LENGTH(TRIM(title)) > 0
        ),

    CONSTRAINT ck_corporate_action_reference_number_not_empty
        CHECK
        (
            reference_number IS NULL
            OR LENGTH(TRIM(reference_number)) > 0
        ),

    CONSTRAINT ck_corporate_action_ratio_positive
        CHECK
        (
            ratio IS NULL
            OR ratio > 0
        ),

    CONSTRAINT ck_corporate_action_amount_positive
        CHECK
        (
            amount IS NULL
            OR amount >= 0
        ),

    CONSTRAINT ck_corporate_action_old_value_positive
        CHECK
        (
            old_value IS NULL
            OR old_value >= 0
        ),

    CONSTRAINT ck_corporate_action_new_value_positive
        CHECK
        (
            new_value IS NULL
            OR new_value >= 0
        ),

    CONSTRAINT ck_corporate_action_version_positive
        CHECK
        (
            version > 0
        ),

    CONSTRAINT ck_corporate_action_effective_date
        CHECK
        (
            effective_date >= announcement_date
        ),

    CONSTRAINT ck_corporate_action_record_date
        CHECK
        (
            record_date IS NULL
            OR record_date >= announcement_date
        ),

    CONSTRAINT ck_corporate_action_payment_date
        CHECK
        (
            payment_date IS NULL
            OR record_date IS NULL
            OR payment_date >= record_date
        ),

    CONSTRAINT fk_corporate_action_instrument
        FOREIGN KEY
        (
            instrument_id
        )
        REFERENCES ref.instrument
        (
            instrument_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_corporate_action_type
        FOREIGN KEY
        (
            corporate_action_type_id
        )
        REFERENCES ref.corporate_action_type
        (
            corporate_action_type_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_corporate_action_status
        FOREIGN KEY
        (
            corporate_action_status_id
        )
        REFERENCES ref.corporate_action_status
        (
            corporate_action_status_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_corporate_action_currency
        FOREIGN KEY
        (
            currency_id
        )
        REFERENCES ref.currency
        (
            currency_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE market.corporate_action
IS
'Stores corporate actions announced by listed companies. Each record represents
a business event affecting a financial instrument, including dividends, capital
increases, stock splits, rights issues, mergers, acquisitions, delistings, and
other corporate events supported by the Phoenix Platform.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.corporate_action.corporate_action_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.corporate_action.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.corporate_action.instrument_id
IS
'Reference to the financial instrument affected by the corporate action.';

COMMENT ON COLUMN market.corporate_action.corporate_action_type_id
IS
'Reference to the classification describing the type of corporate action.';

COMMENT ON COLUMN market.corporate_action.corporate_action_status_id
IS
'Reference to the current processing or lifecycle status of the corporate action.';

COMMENT ON COLUMN market.corporate_action.currency_id
IS
'Reference to the currency applicable to monetary corporate actions such as cash dividends or capital repayments.';

COMMENT ON COLUMN market.corporate_action.announcement_date
IS
'Official date on which the corporate action was publicly announced.';

COMMENT ON COLUMN market.corporate_action.effective_date
IS
'Date on which the corporate action becomes legally or operationally effective.';

COMMENT ON COLUMN market.corporate_action.record_date
IS
'Date used to determine shareholder eligibility for the corporate action.';

COMMENT ON COLUMN market.corporate_action.payment_date
IS
'Date on which any monetary entitlement or distribution is paid to eligible shareholders.';

COMMENT ON COLUMN market.corporate_action.reference_number
IS
'Official reference number assigned by the exchange, regulator, or issuing company.';

COMMENT ON COLUMN market.corporate_action.title
IS
'Official business title or summary describing the corporate action.';

COMMENT ON COLUMN market.corporate_action.ratio
IS
'Business ratio associated with the corporate action, such as stock split or bonus share ratio.';

COMMENT ON COLUMN market.corporate_action.amount
IS
'Monetary amount associated with the corporate action when applicable.';

COMMENT ON COLUMN market.corporate_action.old_value
IS
'Original value before the corporate action when value comparison is required.';

COMMENT ON COLUMN market.corporate_action.new_value
IS
'Resulting value after the corporate action when value comparison is required.';

COMMENT ON COLUMN market.corporate_action.description
IS
'Optional business description providing additional details about the corporate action.';

COMMENT ON COLUMN market.corporate_action.is_active
IS
'Indicates whether the corporate action record is currently active and available for business processing.';

COMMENT ON COLUMN market.corporate_action.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.corporate_action.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.corporate_action.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.corporate_action.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.corporate_action.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------