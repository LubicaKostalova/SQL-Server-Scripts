/* Ukážky mojich selektov z reálnych projektov použitých v SQL Server Management Studio 
** !! Názvy tabuliek a elementov sú zámerne zmenené !! */



/*** Ukážka selektov zo stránky predávajúcej nové byty **********************************************/
USE Byty_Klatovska
GO

SELECT * FROM dbo.byty
SELECT * FROM dbo.zajemce

SELECT * FROM dbo.zajemce AS z
inner join dbo.byty AS b
ON z.byt = b.id
WHERE b.podlazi = 2

UPDATE dbo.zajemce SET mesto = 'Brno' WHERE id = 3;




/*** Príklady selektov použitých pri testovaní informačného systému *********************************/

USE [master]
GO

-- Základné vyhľadanie DMJ v číselníku SupplMeasUnit
SELECT sID as DMJ, * FROM dbo.SupplMeasUnit  
WHERE 
 (((DateStart < (SELECT GETDATE())) and (DateEnd > (SELECT GETDATE()))) or DateEnd is NULL) 
 and ImportExport = 'Import'  and GeographicalAreaCode = 'MA'  
 and NomenclatureCode in ('92022100','74482560')




-- Vyhľadá v tabuľke BkrMessageOut všetky odchádzajúce správy priradené ku konkrétnemu identifikačnému číslu (LK171126A01nr112), 
-- rozbalí ich XML obsah do čitateľnej podoby a zoradí ich zostupne podľa typu správy. 
declare @CRN  as varchar(25) = 'LK171126A01nr112'
--------------------------------------------------
SELECT top 100 
	CAST(DECOMPRESS(XmlContent) as XMLf), 
	MessageType, CRN, BusinessCase, SendToMQState,ERCAttempt, *  
FROM dbo.BkrMessageOut  
WHERE CRN = @CRN
order by 2 desc




-- Postupne dohľadá prepojené interné identifikátory pre konkrétnu zásielku (LK171126A01nr112) 
-- následne vypíše detaily o subjektoch a položkách tejto zásielky v príslušných tabuľkách.
declare @CRN  as varchar(25) = 'LK171126A01nr112'
declare @IDSED as varchar(10)       (select @IDSED = IDSED from dbo.SED where CRN = @CRN)
declare @IDShipment as varchar(10)  (select @IDShipment = IDShipment from dbo.Shipment where IDSED = @IDSED)
declare @IDItem as varchar(10)      (select @IDItem = IDItem from dbo.Item where IDShipment = @IDShipment)
------------------------------------------------------------------------------------------------------------
SELECT * FROM dbo.SEDSubject where IDSED = @IDSED
SELECT * FROM dbo.Item  where IDShipment = @IDShipment
SELECT * FROM dbo.ItemSubject where IDItem = @IDItem
SELECT * FROM dbo.CancelRequest where IDSED = @IDSED





-- Spojí dve tabuľky týkajúce sa záruk (Guarantee a GuaranteeReference) 
-- a vypíše podrobné informácie o všetkých zárukách a ich referenciách priradených ku konkrétnemu dokladu (@IDSED).
declare @CRN  as varchar(25) = 'LK171126A01nr112'
declare @IDSED as varchar(10)  (select @IDSED = IDSED from dbo.SED where CRN = @CRN)
-----------------------------------------------------------------------------------------
SELECT g.IDSED, g.GuaranteeType, gr.*
FROM dbo.Guarantee g
JOIN dbo.GuaranteeReference gr ON g.IDGuarantee = gr.IDGuarantee
WHERE g.IDSED = @IDSED and g.IDTransactionDelete is NULL

