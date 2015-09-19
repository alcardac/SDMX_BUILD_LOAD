DECLARE	@ART_ID INT
DECLARE	@AG_ID INT

INSERT INTO dbo.ARTEFACT
        ( ID ,
          VERSION1 ,
          VERSION2 ,
          VERSION3 ,
          AGENCY ,
          VALID_FROM ,
          VALID_TO ,
          IS_FINAL ,
          URI ,
          LAST_MODIFIED
        )
VALUES ('AGENCIES',1,0,NULL,'SDMX',CONVERT(DATETIME,'01/05/2014',103),CONVERT(DATETIME,'25/05/2020',103),0,'urn:sdmx:org.sdmx.infomodel.base.AgencyScheme=SDMX:AGENCIES(1.0)',GETDATE())

SELECT @ART_ID = SCOPE_IDENTITY()
INSERT INTO	dbo.AGENCY_SCHEME
        ( AG_SCH_ID, IS_PARTIAL )
VALUES  ( @ART_ID,0)

INSERT INTO item (ID)
VALUES ('SDMX')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)

INSERT INTO item (ID)
VALUES ('ESTAT')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)

INSERT INTO item (ID)
VALUES ('IMF')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)

INSERT INTO item (ID)
VALUES ('IT1')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)

INSERT INTO item (ID)
VALUES ('WB')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)

INSERT INTO item (ID)
VALUES ('FAO')
SELECT @AG_ID = SCOPE_IDENTITY()
INSERT INTO AGENCY (AG_ID, AG_SCH_ID)
VALUES  (@AG_ID, @ART_ID)


SELECT *
FROM dbo.ARTEFACT
WHERE ART_ID = @ART_ID

SELECT *
FROM dbo.AGENCY_SCHEME
WHERE AG_SCH_ID = @ART_ID

SELECT *
FROM dbo.AGENCY A
	INNER JOIN dbo.ITEM B ON
		A.AG_ID = B.ITEM_ID
WHERE AG_SCH_ID = @ART_ID

INSERT INTO dbo.LOCALISED_STRING
        ( TYPE, ITEM_ID, ART_ID,LANGUAGE , TEXT )
SELECT 'Name',B.ITEM_ID,NULL,'en',B.ID
FROM dbo.AGENCY A
	INNER JOIN dbo.ITEM B ON
		A.AG_ID = B.ITEM_ID
WHERE AG_SCH_ID = @ART_ID



