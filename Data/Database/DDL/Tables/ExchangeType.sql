/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : exchange_type.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : ExchangeType
* Schema           : ref
* Version          : 2026.1
* Status           : Approved
*
* Description
* ----------------------------------------------------------------------------
* Creates the canonical ExchangeType reference table.
*
* The ExchangeType table defines the standardized business classification of
* financial exchange organizations supported by the Phoenix Platform.
*
* Each exchange belongs to exactly one exchange type, enabling consistent
* classification of stock exchanges, commodity exchanges, futures exchanges,
* options exchanges, cryptocurrency exchanges, over-the-counter markets,
* and other organized trading venues across all supported markets.
*
* This table provides standardized classifications used throughout market
* structure modeling, reference data management, analytics, reporting,
* and multi-market platform operations.
*
* Architectural Source
* --------------------------------------------------------------------------------------------------
* * Architecture Decision Records (ADR)
* * Domain Model
* * Enterprise Data Dictionary
* * Logical Database Model
* * Physical Database Model
* * TablePhysicalSpecifications.md
* * ConstraintSpecifications.md
* * DDLTemplateSpecification.md
*
* Dependencies
* --------------------------------------------------------------------------------------------------
* Prerequisites
*   
*     - Schema : ref
*
* Referenced Objects
* 
*     - None
*
* Referenced By
* 
*     - ref.exchange
*
* Standards
* --------------------------------------------------------------------------------------------------
* - Enterprise Naming Standard
* - Enterprise Database Design Standard
* - PostgreSQL Physical Database Design
* - PostgreSQL Design Decisions
* - Table Physical Specifications
* - Constraint Specifications
* - DDL Template Specification
*
* Notes
* --------------------------------------------------------------------------------------------------
* - One database object per script.
* - One table per file.
* - Architecture-driven implementation.
* - PostgreSQL 17 compatible.
*
* Author           : Phoenix Architecture Team
* Created          : 2026-08-02
*
* Revision History
* --------------------------------------------------------------------------------------------------
* Version   Date         Description
* -------   ----------   ---------------------------------------------------------
* 2026.1    2026-08-02   Initial canonical implementation.
****************************************************************************************************/

CREATE TABLE ref.exchange_type
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------


exchange_type_id                BIGINT
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

exchange_type_code              VARCHAR(50)
                                    NOT NULL,

exchange_type_name              VARCHAR(100)
                                    NOT NULL,

exchange_type_short_name        VARCHAR(50),

exchange_type_local_name        VARCHAR(100),

exchange_type_display_order     SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

exchange_type_description       VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

exchange_type_is_active         BOOLEAN
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

CONSTRAINT pk_exchange_type
    PRIMARY KEY
    (
        exchange_type_id
    ),

CONSTRAINT uk_exchange_type_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_exchange_type_code
    UNIQUE
    (
        exchange_type_code
    ),

CONSTRAINT uk_exchange_type_name
    UNIQUE
    (
        exchange_type_name
    ),

CONSTRAINT ck_exchange_type_code_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_type_code)) > 0
    ),

CONSTRAINT ck_exchange_type_code_uppercase
    CHECK
    (
        exchange_type_code = UPPER(exchange_type_code)
    ),

CONSTRAINT ck_exchange_type_name_not_empty
    CHECK
    (
        LENGTH(TRIM(exchange_type_name)) > 0
    ),

CONSTRAINT ck_exchange_type_short_name_not_empty
    CHECK
    (
        exchange_type_short_name IS NULL
        OR LENGTH(TRIM(exchange_type_short_name)) > 0
    ),

CONSTRAINT ck_exchange_type_local_name_not_empty
    CHECK
    (
        exchange_type_local_name IS NULL
        OR LENGTH(TRIM(exchange_type_local_name)) > 0
    ),

CONSTRAINT ck_exchange_type_display_order_positive
    CHECK
    (
        exchange_type_display_order > 0
    ),

CONSTRAINT ck_exchange_type_description_not_empty
    CHECK
    (
        exchange_type_description IS NULL
        OR LENGTH(TRIM(exchange_type_description)) > 0
    ),

CONSTRAINT ck_exchange_type_row_version_positive
    CHECK
    (
        row_version > 0
    )


);


----------------------------------------------------------------------------
 -- Table Comment
----------------------------------------------------------------------------

COMMENT ON TABLE ref.exchange_type
IS
'Reference table defining the standardized business classifications of exchange organizations supported by the Phoenix Platform. Each record represents a canonical exchange type such as Stock Exchange, Commodity Exchange, Futures Exchange, Options Exchange, Cryptocurrency Exchange, Over-the-Counter Market, or other organized trading venue used throughout market structure modeling and multi-market platform operations.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.exchange_type.exchange_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.exchange_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization, and APIs.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_code
IS
'Unique business code identifying the exchange type.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_name
IS
'Official business name of the exchange type.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_short_name
IS
'Abbreviated name used by applications, reports, and user interfaces.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_local_name
IS
'Official local-language name of the exchange type.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_display_order
IS
'Display sequence used by applications when presenting exchange types to users.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_description
IS
'Optional business description providing additional information about the exchange type.';

COMMENT ON COLUMN ref.exchange_type.exchange_type_is_active
IS
'Indicates whether the exchange type is currently active and available for business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.exchange_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.exchange_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.exchange_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.exchange_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.exchange_type.row_version
IS
'Optimistic concurrency control version number incremented after each successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------