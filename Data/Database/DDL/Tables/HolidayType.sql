/***************************************************************************************************

* Project          : Phoenix Platform
* Script           : holiday_type.sql
* Category         : Database Definition Language (DDL)
* Object Type      : Table
* Object Name      : HolidayType
* Schema           : ref
* Version          : 2026.1
* Status           : Approved
*
* Description
* -------------------------------------------------------------------------------------------------
* Creates the canonical HolidayType reference table.
*
* The HolidayType table defines the standardized business classification of
* holidays supported by the Phoenix Platform.
*
* Each holiday belongs to exactly one holiday type, enabling consistent
* classification of national holidays, religious holidays, exchange holidays,
* regulatory holidays, bank holidays, emergency closures, and other official
* non-trading calendar events across all supported exchanges and markets.
*
* This table provides standardized classifications used throughout trading
* calendar management, market schedule processing, analytics, reporting,
* and multi-market platform operations.
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
*    - Schema : ref
*
* Referenced Objects
*    - None
*
* Referenced By
*    - ref.trading_calendar
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

CREATE TABLE ref.holiday_type
(
----------------------------------------------------------------------------
-- Primary Identifier
----------------------------------------------------------------------------

holiday_type_id                 BIGINT
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

holiday_type_code               VARCHAR(50)
                                    NOT NULL,

holiday_type_name               VARCHAR(100)
                                    NOT NULL,

holiday_type_short_name         VARCHAR(50),

holiday_type_local_name         VARCHAR(100),

holiday_type_display_order      SMALLINT
                                    NOT NULL
                                    DEFAULT 1,

holiday_type_description        VARCHAR(500),

----------------------------------------------------------------------------
-- Business Status
----------------------------------------------------------------------------

holiday_type_is_active          BOOLEAN
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

CONSTRAINT pk_holiday_type
    PRIMARY KEY
    (
        holiday_type_id
    ),

CONSTRAINT uk_holiday_type_public_id
    UNIQUE
    (
        public_id
    ),

CONSTRAINT uk_holiday_type_code
    UNIQUE
    (
        holiday_type_code
    ),

CONSTRAINT uk_holiday_type_name
    UNIQUE
    (
        holiday_type_name
    ),

CONSTRAINT ck_holiday_type_code_not_empty
    CHECK
    (
        LENGTH(TRIM(holiday_type_code)) > 0
    ),

CONSTRAINT ck_holiday_type_code_uppercase
    CHECK
    (
        holiday_type_code = UPPER(holiday_type_code)
    ),

CONSTRAINT ck_holiday_type_name_not_empty
    CHECK
    (
        LENGTH(TRIM(holiday_type_name)) > 0
    ),

CONSTRAINT ck_holiday_type_short_name_not_empty
    CHECK
    (
        holiday_type_short_name IS NULL
        OR LENGTH(TRIM(holiday_type_short_name)) > 0
    ),

CONSTRAINT ck_holiday_type_local_name_not_empty
    CHECK
    (
        holiday_type_local_name IS NULL
        OR LENGTH(TRIM(holiday_type_local_name)) > 0
    ),

CONSTRAINT ck_holiday_type_display_order_positive
    CHECK
    (
        holiday_type_display_order > 0
    ),

CONSTRAINT ck_holiday_type_description_not_empty
    CHECK
    (
        holiday_type_description IS NULL
        OR LENGTH(TRIM(holiday_type_description)) > 0
    ),

CONSTRAINT ck_holiday_type_row_version_positive
    CHECK
    (
        row_version > 0
    )

);

--------------------------------------------------------------------------------
-- Table Comment
--------------------------------------------------------------------------------

COMMENT ON TABLE ref.holiday_type
IS
'Reference table defining the standardized business classifications of holidays
supported by the Phoenix Platform. Each record represents a canonical holiday
type such as National Holiday, Religious Holiday, Exchange Holiday, Regulatory
Holiday, Bank Holiday, Emergency Closure, or other official non-trading
calendar event used throughout trading calendar management and multi-market
platform operations.';

--------------------------------------------------------------------------------
-- Column Comments
--------------------------------------------------------------------------------

COMMENT ON COLUMN ref.holiday_type.holiday_type_id
IS
'Internal surrogate primary key generated by PostgreSQL.';

COMMENT ON COLUMN ref.holiday_type.public_id
IS
'Immutable public identifier used for external integrations, synchronization,
and APIs.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_code
IS
'Unique business code identifying the holiday type.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_name
IS
'Official business name of the holiday type.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_short_name
IS
'Abbreviated name used by applications, reports, and user interfaces.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_local_name
IS
'Official local-language name of the holiday type.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_display_order
IS
'Display sequence used by applications when presenting holiday types to users.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_description
IS
'Optional business description providing additional information about the
holiday type.';

COMMENT ON COLUMN ref.holiday_type.holiday_type_is_active
IS
'Indicates whether the holiday type is currently active and available for
business operations within the Phoenix Platform.';

COMMENT ON COLUMN ref.holiday_type.created_at
IS
'Timestamp indicating when the record was created.';

COMMENT ON COLUMN ref.holiday_type.created_by
IS
'Identifier of the user, service, or process that created the record.';

COMMENT ON COLUMN ref.holiday_type.updated_at
IS
'Timestamp indicating when the record was last modified.';

COMMENT ON COLUMN ref.holiday_type.updated_by
IS
'Identifier of the user, service, or process that last modified the record.';

COMMENT ON COLUMN ref.holiday_type.row_version
IS
'Optimistic concurrency control version number incremented after each
successful update.';

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------