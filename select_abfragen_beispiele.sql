/* Beispiele meiner SELECT-Abfragen aus realen Projekten, verwendet im SQL Server Management Studio 
** !! Die Namen der Tabellen und Elemente wurden absichtlich geändert !! */



/*** Beispiel von SELECT-Abfragen einer Webseite für den Verkauf neuer Wohnungen *******************/
USE Byty_Klatovska
GO

SELECT * FROM dbo.byty
SELECT * FROM dbo.zajemce

SELECT * FROM dbo.zajemce AS z
inner join dbo.byty AS b
ON z.byt = b.id
WHERE b.podlazi = 2

UPDATE dbo.zajemce SET mesto = 'Brno' WHERE id = 3;




/*** Beispiele von SELECT-Abfragen, die beim Testen eines Informationssystems verwendet wurden ******/

USE [master]
GO

-- Grundlegende Suche nach der besonderen Maßeinheit (DMJ) im Verzeichnis SupplMeasUnit
SELECT sID as DMJ, * FROM dbo.SupplMeasUnit  
WHERE 
 (((DateStart < (SELECT GETDATE())) and (DateEnd > (SELECT GETDATE()))) or DateEnd is NULL) 
 and ImportExport = 'Import'  and GeographicalAreaCode = 'MA'  
 and NomenclatureCode in ('92022100','74482560')




-- Sucht in der Tabelle BkrMessageOut alle ausgehenden Nachrichten, die einer bestimmten Identifikationsnummer (LK171126A01nr112) zugeordnet sind, 
-- entpackt deren XML-Inhalt in ein lesbares Format und sortiert sie absteigend nach Nachrichtentyp. 
declare @CRN  as varchar(25) = 'LK171126A01nr112'
--------------------------------------------------
SELECT top 100 
	CAST(DECOMPRESS(XmlContent) as XMLf), 
	MessageType, CRN, BusinessCase, SendToMQState,ERCAttempt, *  
FROM dbo.BkrMessageOut  
WHERE CRN = @CRN
order by 2 desc




-- Ermittelt schrittweise die verknüpften internen Identifikatoren für eine bestimmte Sendung (LK171126A01nr112) 
-- und gibt anschließend Details zu den Beteiligten (Subjekten) und Positionen dieser Sendung in den entsprechenden Tabellen aus.
declare @CRN  as varchar(25) = 'LK171126A01nr112'
declare @IDSED as varchar(10)       (select @IDSED = IDSED from dbo.SED where CRN = @CRN)
declare @IDShipment as varchar(10)  (select @IDShipment = IDShipment from dbo.Shipment where IDSED = @IDSED)
declare @IDItem as varchar(10)      (select @IDItem = IDItem from dbo.Item where IDShipment = @IDShipment)
------------------------------------------------------------------------------------------------------------
SELECT * FROM dbo.SEDSubject where IDSED = @IDSED
SELECT * FROM dbo.Item  where IDShipment = @IDShipment
SELECT * FROM dbo.ItemSubject where IDItem = @IDItem
SELECT * FROM dbo.CancelRequest where IDSED = @IDSED





-- Verknüpft zwei Tabellen bezüglich Sicherheiten/Bürgschaften (Guarantee und GuaranteeReference) 
-- und gibt detaillierte Informationen zu allen Sicherheiten und deren Referenzen aus, die einem bestimmten Dokument (@IDSED) zugeordnet sind.
declare @CRN  as varchar(25) = 'LK171126A01nr112'
declare @IDSED as varchar(10)  (select @IDSED = IDSED from dbo.SED where CRN = @CRN)
-----------------------------------------------------------------------------------------
SELECT g.IDSED, g.GuaranteeType, gr.*
FROM dbo.Guarantee g
JOIN dbo.GuaranteeReference gr ON g.IDGuarantee = gr.IDGuarantee
WHERE g.IDSED = @IDSED and g.IDTransactionDelete is NULL
