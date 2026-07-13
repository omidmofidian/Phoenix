/***************************************************************************************************
 * Project          : Phoenix Platform
 * Script           : 010-ReferenceForeignKeys.sql
 * Category         : Database Definition Language (DDL)
 * Object Type      : Constraints
 * Object Name      : Reference Foreign Keys
 * Schema           : reference
 * Version          : 1.0
 * Status           : Approved
 *
 * Description
 * -------------------------------------------------------------------------------------------------
 * Creates all foreign key constraints for the Reference Data model.
 *
 * Dependencies
 * -------------------------------------------------------------------------------------------------
 * 010-CreateExchange.sql
 * 020-CreateMarket.sql
 * 030-CreateBoard.sql
 * 040-CreateIndustry.sql
 * 050-CreateSector.sql
 * 060-CreateCompany.sql
 * 070-CreateSymbol.sql
 * 080-CreateTradingCalendar.sql
 * 090-CreateHolidayCalendar.sql
 *
 * Standards
 * -------------------------------------------------------------------------------------------------
 * - SQLScriptDevelopmentStandard
 * - DatabaseDDLDevelopmentStandard
 * - ConstraintDevelopmentStandard
 * - EnterpriseTableConvention
 *
 * Author           : Phoenix Architecture Team
 * Created          : 2026-07-12
 *
 * Revision History
 * -------------------------------------------------------------------------------------------------
 * Version   Date         Description
 * -------   ----------   ---------------------------------------------------------
 * 1.0       2026-07-12   Initial version.
 **************************************************************************************************/

----------------------------------------------------------------------------------------------------
-- Market → Exchange
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Market
    ADD CONSTRAINT FK_Market_Exchange
    FOREIGN KEY (exchange_id)
    REFERENCES reference.Exchange (exchange_id);

----------------------------------------------------------------------------------------------------
-- Board → Market
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Board
    ADD CONSTRAINT FK_Board_Market
    FOREIGN KEY (market_id)
    REFERENCES reference.Market (market_id);

----------------------------------------------------------------------------------------------------
-- Sector → Industry
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Sector
    ADD CONSTRAINT FK_Sector_Industry
    FOREIGN KEY (industry_id)
    REFERENCES reference.Industry (industry_id);

----------------------------------------------------------------------------------------------------
-- Company → Exchange
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Company
    ADD CONSTRAINT FK_Company_Exchange
    FOREIGN KEY (exchange_id)
    REFERENCES reference.Exchange (exchange_id);

----------------------------------------------------------------------------------------------------
-- Company → Market
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Company
    ADD CONSTRAINT FK_Company_Market
    FOREIGN KEY (market_id)
    REFERENCES reference.Market (market_id);

----------------------------------------------------------------------------------------------------
-- Company → Board
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Company
    ADD CONSTRAINT FK_Company_Board
    FOREIGN KEY (board_id)
    REFERENCES reference.Board (board_id);

----------------------------------------------------------------------------------------------------
-- Company → Industry
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Company
    ADD CONSTRAINT FK_Company_Industry
    FOREIGN KEY (industry_id)
    REFERENCES reference.Industry (industry_id);

----------------------------------------------------------------------------------------------------
-- Company → Sector
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Company
    ADD CONSTRAINT FK_Company_Sector
    FOREIGN KEY (sector_id)
    REFERENCES reference.Sector (sector_id);

----------------------------------------------------------------------------------------------------
-- Symbol → Company
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.Symbol
    ADD CONSTRAINT FK_Symbol_Company
    FOREIGN KEY (company_id)
    REFERENCES reference.Company (company_id);

----------------------------------------------------------------------------------------------------
-- HolidayCalendar → TradingCalendar
----------------------------------------------------------------------------------------------------

ALTER TABLE reference.HolidayCalendar
    ADD CONSTRAINT FK_HolidayCalendar_TradingCalendar
    FOREIGN KEY (trading_calendar_id)
    REFERENCES reference.TradingCalendar (trading_calendar_id);

----------------------------------------------------------------------------------------------------
-- End of Script
----------------------------------------------------------------------------------------------------