/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : order_side.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : OrderSide
* Schema           : ref
* Version          : 2026.1
* Status           : Approved
*
* Description
* -------------------------------------------------------------------------------------------------
* Creates the canonical OrderSide reference table.
*
* The OrderSide table defines the standardized business classification of
* order sides supported by the Phoenix Platform.
*
* Each order belongs to exactly one order side, enabling consistent
* classification of buy and sell orders across all supported financial
* markets and trading venues.
*
* This table provides standardized classifications used throughout order
* management, order book processing, market data analysis, trading engines,
* analytics, reporting, and multi-market platform operations.
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
*     - market.order_book_level
*     - Future order management entities
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

CREATE TABLE ref.order_side
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------

order_side_id                    BIGINT
                                    GENERATED ALWAYS AS IDENTITY,

----------------------------------------------------------------------------
-- Public Identifier
----------------------------------------------------------------------------

public_id                        UUID
                                    NOT NULL
                                    DEFAULT gen_random_uuid(),

----------------------------------------------------------------------------
-- Business Attributes
----------------------------------------------------------------------------

order_side_code                  VARCHAR(50)
                                    NOT NULL,

order_side_name                  VARCHAR(100)
                                    NOT NULL,

order_side_short_name            VARCHAR(50),

order_side_local_name            VARCHAR(100),

order_side_display_order         SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

order_side_description           VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

order_side_is_active             BOOLEAN
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

row_version                      INTEGER
                                    NOT NULL
                                    DEFAULT 1,

----------------------------------------------------------------------------
-- Constraints
----------------------------------------------------------------------------

CONSTRAINT pk_order_side
    PRIMARY KEY
    (
        order_side_id
    ),

CONSTRAINT uk_order_side_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_order_side_code
    UNIQUE
    (
        order_side_code
    ),

CONSTRAINT uk_order_side_name
    UNIQUE
    (
        order_side_name
    ),

CONSTRAINT ck_order_side_code_not_empty
    CHECK
    (
        LENGTH(TRIM(order_side_code)) > 0
    ),

CONSTRAINT ck_order_side_code_uppercase
    CHECK
    (
        order_side_code = UPPER(order_side_code)
    ),

CONSTRAINT ck_order_side_name_not_empty
    CHECK
    (
        LENGTH(TRIM(order_side_name)) > 0
    ),

CONSTRAINT ck_order_side_short_name_not_empty
    CHECK
    (
        order_side_short_name IS NULL
        OR LENGTH(TRIM(order_side_short_name)) > 0
    ),

CONSTRAINT ck_order_side_local_name_not_empty
    CHECK
    (
        order_side_local_name IS NULL
        OR LENGTH(TRIM(order_side_local_name)) > 0
    ),

CONSTRAINT ck_order_side_display_order_positive
    CHECK
    (
        order_side_display_order > 0
    ),

CONSTRAINT ck_order_side_description_not_empty
    CHECK
    (
        order_side_description IS NULL
        OR LENGTH(TRIM(order_side_description)) > 0
    ),

CONSTRAINT ck_order_side_row_version_positive
    CHECK
    (
        row_version > 0
    )

);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.order_side
IS
'Reference table defining the standardized business classifications of order
sides supported by the Phoenix Platform. Each record represents a canonical
order side such as Buy or Sell used throughout order management, order book
processing, trading operations, and multi-market platform services.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.order_side.order_side_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.order_side.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.order_side.order_side_code
IS
'Unique business code identifying the order side.';

COMMENT ON COLUMN ref.order_side.order_side_name
IS
'Official business name of the order side.';

COMMENT ON COLUMN ref.order_side.order_side_short_name
IS
'Abbreviated name used by applications, reports, and user interfaces.';

COMMENT ON COLUMN ref.order_side.order_side_local_name
IS
'Official local-language name of the order side.';

COMMENT ON COLUMN ref.order_side.order_side_display_order
IS
'Display sequence used by applications when presenting order sides to users.';

COMMENT ON COLUMN ref.order_side.order_side_description
IS
'Optional business description providing additional information about the
order side.';

COMMENT ON COLUMN ref.order_side.order_side_is_active
IS
'Indicates whether the order side is currently active and available for
business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.order_side.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.order_side.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.order_side.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.order_side.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.order_side.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------