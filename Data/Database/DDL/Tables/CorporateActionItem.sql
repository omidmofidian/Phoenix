/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : CorporateActionItem.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Table
 * Object Name      : CorporateActionItem
 * Schema           : market
 * Version          : 2026.1
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates the canonical CorporateActionItem table.
 *
 * The CorporateActionItem table represents the detailed components of a
 * corporate action. A single corporate action may consist of one or more
 * business items, each representing a specific financial impact, entitlement,
 * distribution, or adjustment associated with the parent corporate action.
 *
 * This design enables the Phoenix Platform to support complex corporate actions
 * such as mixed capital increases, dividend distributions, stock splits,
 * reverse splits, rights offerings, and other composite corporate events.
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
 *     - Table  : market.corporate_action
 *     - Table  : ref.corporate_action_type
 *     - Table  : ref.currency
 *
 * Referenced Objects
 *     - market.corporate_action
 *     - ref.corporate_action_type
 *     - ref.currency
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

CREATE TABLE market.corporate_action_item
(
    ----------------------------------------------------------------------------
    -- Primary Identifier
    ----------------------------------------------------------------------------

    corporate_action_item_id         BIGINT
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

    corporate_action_id              BIGINT
                                         NOT NULL,

    corporate_action_type_id         BIGINT
                                         NOT NULL,

    currency_id                      BIGINT,

    ----------------------------------------------------------------------------
    -- Business Attributes
    ----------------------------------------------------------------------------

    item_sequence                    SMALLINT
                                         NOT NULL
                                         DEFAULT 1,

    effective_date                   DATE
                                         NOT NULL,

    value                            NUMERIC(24,8),

    percentage                       NUMERIC(10,6),

    quantity                         NUMERIC(24,8),

    item_reference                   VARCHAR(200),

    source_reference                 VARCHAR(500),

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

    CONSTRAINT pk_corporate_action_item
        PRIMARY KEY
        (
            corporate_action_item_id
        ),

    CONSTRAINT uq_corporate_action_item_public_id
        UNIQUE
        (
            public_id
        ),

    CONSTRAINT uq_corporate_action_item_sequence
        UNIQUE
        (
            corporate_action_id,
            item_sequence
        ),

    CONSTRAINT ck_corporate_action_item_sequence_positive
        CHECK
        (
            item_sequence > 0
        ),

    CONSTRAINT ck_corporate_action_item_value_positive
        CHECK
        (
            value IS NULL
            OR value >= 0
        ),

    CONSTRAINT ck_corporate_action_item_percentage_positive
        CHECK
        (
            percentage IS NULL
            OR percentage >= 0
        ),

    CONSTRAINT ck_corporate_action_item_quantity_positive
        CHECK
        (
            quantity IS NULL
            OR quantity >= 0
        ),

    CONSTRAINT ck_corporate_action_item_reference_not_empty
        CHECK
        (
            item_reference IS NULL
            OR LENGTH(TRIM(item_reference)) > 0
        ),

    CONSTRAINT ck_corporate_action_item_source_reference_not_empty
        CHECK
        (
            source_reference IS NULL
            OR LENGTH(TRIM(source_reference)) > 0
        ),

    CONSTRAINT ck_corporate_action_item_version_positive
        CHECK
        (
            version > 0
        ),

    CONSTRAINT fk_corporate_action_item_action
        FOREIGN KEY
        (
            corporate_action_id
        )
        REFERENCES market.corporate_action
        (
            corporate_action_id
        )
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    CONSTRAINT fk_corporate_action_item_type
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

    CONSTRAINT fk_corporate_action_item_currency
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

COMMENT ON TABLE market.corporate_action_item
IS
'Stores the detailed business components of a corporate action. Each record
represents an individual financial entitlement, adjustment, or distribution
that forms part of a parent corporate action, enabling support for complex
corporate events consisting of multiple business items.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN market.corporate_action_item.corporate_action_item_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN market.corporate_action_item.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN market.corporate_action_item.corporate_action_id
IS
'Reference to the parent corporate action associated with this business item.';

COMMENT ON COLUMN market.corporate_action_item.corporate_action_type_id
IS
'Reference to the business classification of this corporate action item.';

COMMENT ON COLUMN market.corporate_action_item.currency_id
IS
'Reference to the currency associated with the financial value of this corporate action item, when applicable.';

COMMENT ON COLUMN market.corporate_action_item.item_sequence
IS
'Sequential order of the business item within the parent corporate action.';

COMMENT ON COLUMN market.corporate_action_item.effective_date
IS
'Business effective date on which this corporate action item becomes applicable.';

COMMENT ON COLUMN market.corporate_action_item.value
IS
'Financial value associated with this corporate action item, when applicable.';

COMMENT ON COLUMN market.corporate_action_item.percentage
IS
'Percentage associated with this corporate action item, such as dividend yield or capital increase ratio.';

COMMENT ON COLUMN market.corporate_action_item.quantity
IS
'Quantity of securities or units associated with this corporate action item, when applicable.';

COMMENT ON COLUMN market.corporate_action_item.item_reference
IS
'Business or regulatory reference identifying this corporate action item within the parent corporate action.';

COMMENT ON COLUMN market.corporate_action_item.source_reference
IS
'External reference identifying the official source of this corporate action item, 
such as an exchange announcement, regulatory notice, document identifier, or URL.';

COMMENT ON COLUMN market.corporate_action_item.description
IS
'Optional business description providing additional information about the corporate action item.';

COMMENT ON COLUMN market.corporate_action_item.is_active
IS
'Indicates whether the corporate action item is currently active and available for business operations within the Phoenix Platform.';

COMMENT ON COLUMN market.corporate_action_item.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN market.corporate_action_item.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN market.corporate_action_item.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN market.corporate_action_item.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN market.corporate_action_item.version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------