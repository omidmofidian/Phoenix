/*
==============================================================================
 Project      : Phoenix Platform
 Script       : 001-CreateDatabase.sql
 Category     : Bootstrap
==============================================================================
*/

CREATE DATABASE phoenix
WITH
    ENCODING = 'UTF8'
    TEMPLATE = template0;

COMMENT ON DATABASE phoenix IS
'Phoenix Enterprise Database';