IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Split]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetNewID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TranscodingAttributeValues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TranscodingAttributeValues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_RemoveInvalidRecords]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_RemoveInvalidRecords]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetSQLFiltTableUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_GetSQLFiltTableUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FiltTableUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_FiltTableUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FactTableUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_FactTableUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeTranscodingAttributeValues]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DeTranscodingAttributeValues]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CreateTemporaryTables]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_CreateTemporaryTables]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AttributeMain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_AttributeMain]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[prod_INSERT_LOAD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[prod_INSERT_LOAD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_UPDATE_USER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_UPDATE_USER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_TRY_LOGIN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_TRY_LOGIN]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_TRANSCODETIME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_SET_TRANSCODETIME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_LOCATION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_SET_LOCATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_ATT_ATTACH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_SET_ATT_ATTACH]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_USER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_USER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_THEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_THEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_MAPPING]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_MAPPING]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_LOAD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_LOAD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DOMAIN_THEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DOMAIN_THEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DOMAIN_SET]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DOMAIN_SET]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DIMENSION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DIMENSION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATAFLOW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DATAFLOW]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_MAPPING]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DATA_MAPPING]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_FILTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DATA_FILTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_FACTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_DATA_FACTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_CODE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_CODE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_ATTRIBUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_INSERT_ATTRIBUTE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GetCodeCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GetCodeCount]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_USERS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_USERS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_TRANSCODETIME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_TRANSCODETIME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_TIME_PERIOD]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_TIME_PERIOD]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_THEME_URN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_THEME_URN]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_THEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_THEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_SID_VIEW_FILTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_SID_VIEW_FILTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_SID_FILTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_SID_FILTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPINGS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_MAPPINGS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING_SCHEME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_MAPPING_SCHEME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING_COLUMNS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_MAPPING_COLUMNS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_MAPPING]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_LOCATION_ALL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_LOCATION_ALL]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_LOCATION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_LOCATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_IDDIM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_IDDIM]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENSIONS_REFERENCE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DIMENSIONS_REFERENCE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENSIONS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DIMENSIONS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENISION_CODE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DIMENISION_CODE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DATASTRUCTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCT_BY_USER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DATASTRUCT_BY_USER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_DATASTRUCT]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CUBE_NAME]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_CUBE_NAME]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CUBE_DETAILS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_CUBE_DETAILS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODES_DIMENSION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_CODES_DIMENSION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODES_ATTRIBUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_CODES_ATTRIBUTE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODE_ID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_CODE_ID]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATTRIBUTES]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_ATTRIBUTES]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATTRIBUTE_CODE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_ATTRIBUTE_CODE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATT_ATTACH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_GET_ATT_ATTACH]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_USER]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_DELETE_USER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_MAPPING]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_DELETE_MAPPING]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_DATA_FACTS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_DELETE_DATA_FACTS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_CUBE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_DELETE_CUBE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_VW]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_VW]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_FILT_TABLE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_FILT_TABLE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_FACT_TABLE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_FACT_TABLE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_ViewAllSeries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_ViewAllSeries]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_DataFactS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_DataFactS]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_AllData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_AllData]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_CUBE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_COMMON_DIMENSION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_COMMON_DIMENSION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_COMMON_ATTRIBUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CREATE_COMMON_ATTRIBUTE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_COUNT_LOCATION]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_COUNT_LOCATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_COUNT_CODE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_COUNT_CODE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_ClearTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_ClearTable]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_ClearDB]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_ClearDB]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CLEAR_DOMAIN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_CLEAR_DOMAIN]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CLEAR_DOMAIN]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_CLEAR_DOMAIN]
	@id_user int
AS
BEGIN
	DELETE FROM [dbo].DOMAIN WHERE [dbo].DOMAIN.ID_USER=@id_user
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_ClearDB]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_ClearDB]

AS
BEGIN
DECLARE	@return_value int

EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.DOMAIN''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatDataflow''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatSet''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''localised_CatSet''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatDim''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''localised_CatDim''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatAtt''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''localised_CatAtt''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatAtt''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatAttDim''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.DATA_MAPPING''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CAT_MAPPING''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''dbo.CatTheme''
EXEC	@return_value = [dbo].[proc_ClearTable]
		@table = N''localised_CatTheme''

SELECT	''Return Value'' = @return_value

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_ClearTable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_ClearTable]
	@table nchar(255)
AS
BEGIN
	
BEGIN TRANSACTION
	DECLARE @_Sql varchar(max)
	SET @_Sql=''ALTER TABLE ''+@table+'' NOCHECK CONSTRAINT all''
	EXEC (@_Sql)
	SET @_Sql=''DELETE FROM ''+@table+'' ''
	EXEC (@_Sql)

END
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

COMMIT TRANSACTION
RETURN 0
ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_COUNT_CODE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_COUNT_CODE]
@MemberTable varchar(255),
@Code varchar(255),
@MemberField varchar(255)=''Code'',
@COUNT INT OUT 

AS
BEGIN


DECLARE @Sql NVARCHAR(max)
SET @Sql=N''SELECT COUNT(*) RCOUNT INTO ##RET FROM dbo.''+@MemberTable+'' WHERE [''+@MemberField+''] = ''+''''''''+@Code+''''''''
--PRINT(@Sql)
EXECUTE (@Sql)

SELECT @COUNT = RCOUNT FROM ##RET

DROP TABLE ##RET

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_COUNT_LOCATION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_COUNT_LOCATION]
(
	@MemberTable varchar(50),
	@MemberColumnID  varchar(50),
	@TwoLetterISO varchar(2),
	@Value varchar(max),
	@COUNT INT OUT 
)

AS
BEGIN


	DECLARE @Sql NVARCHAR(max)
	SET @Sql=N''SELECT COUNT(*) RCOUNT INTO ##RET 
	FROM localised_''+@MemberTable+'' 
	WHERE [IDMember] = ''+@MemberColumnID+'' 
	AND [TwoLetterISO] = ''''''+@TwoLetterISO+'''''' 
	AND [Value] = ''+''''''''+@Value+''''''''
	--PRINT(@Sql)
	EXECUTE (@Sql)

	SELECT @COUNT = RCOUNT FROM ##RET

	DROP TABLE ##RET


END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_COMMON_ATTRIBUTE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[proc_CREATE_COMMON_ATTRIBUTE]
	@MemberTable varchar(50)
AS

DECLARE @strCreate VARCHAR(8000)
DECLARE @strPK VARCHAR(8000)
DECLARE @strFK VARCHAR(8000)
DECLARE @strTR VARCHAR(8000)
DECLARE @strIX VARCHAR(8000)

BEGIN TRANSACTION
/******************************************************************************
	Error if dimension table already present
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[Att''+@MemberTable+'']''))
BEGIN
	GOTO SOLVED_SELF
END
/******************************************************************************
	Create MetaData Table
*******************************************************************************/
SET @strCreate = ''CREATE TABLE [dbo].[Att''+@MemberTable+''] (
	[IDMember] [int] IDENTITY(1,1),
	[Code] [varchar] (50) NOT NULL DEFAULT '''''''',
	[BaseCode] [varchar] (50) NULL ,
	[Order] [int] NULL,
	[TimeStamp] [datetime] NOT NULL
)''
--PRINT @strCreate
EXEC(@strCreate)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

/******************************************************************************
	Set Primary Key
******************************************************************************/
SET @strPK = ''ALTER TABLE [dbo].[Att''+@MemberTable+''] WITH NOCHECK ADD 
	CONSTRAINT [PK_Att''+@MemberTable+''] PRIMARY KEY CLUSTERED
	([IDMember])''
--PRINT @strPK
EXEC(@strPK)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END
/******************************************************************************
	Create Index
******************************************************************************/
SET @strIX = ''CREATE  INDEX [IX_IDAtt_Code] ON [dbo].[Att''+@MemberTable+'']([IDMember],[Code])''
--PRINT @strIX
EXEC(@strIX)
IF @@ERROR <> 0
BEGIN
 GOTO ERROR_HANDLING
END

/************************************************
Create localised Table
****************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N''[localised_Att''+@MemberTable+'']''))
BEGIN
	GOTO SOLVED_SELF
END
/******************************************************************************
	Create MetaData Table
*******************************************************************************/
SET @strCreate = ''CREATE TABLE [localised_Att''+@MemberTable+''] (
	[IDLocation] [int] IDENTITY(1,1),
	[IDMember] int,
	[TwoLetterISO] [varchar] (2) NULL ,
	[Value] [varchar] (max) NULL ,
)''
EXEC(@strCreate)
--PRINT @strCreate
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END
/******************************************************************************
	Set Primary Key
******************************************************************************/
SET @strPK = ''ALTER TABLE [localised_Att''+@MemberTable+''] WITH NOCHECK ADD 
	CONSTRAINT [PK_localised_Att''+@MemberTable+''] PRIMARY KEY CLUSTERED
	([IDLocation])''
EXEC(@strPK)
--PRINT @strPK
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

EXEC	[dbo].[proc_CREATE_VW]
		@MemberTable = @MemberTable,
		@PrefixTable = N''Att''

COMMIT TRANSACTION
Return 0

/******************************************************************************/
SOLVED_SELF:
/******************************************************************************/
COMMIT TRANSACTION
Return 2

/******************************************************************************/
ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_COMMON_DIMENSION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- Batch submitted through debugger: SQLQuery14.sql|7|0|C:\Users\Valerio\AppData\Local\Temp\~vs7192.sql
-- Batch submitted through debugger: SQLQuery47.sql|6|0|C:\Users\Valerio\AppData\Local\Temp\~vs4561.sql

CREATE PROCEDURE [dbo].[proc_CREATE_COMMON_DIMENSION]
	@MemberTable varchar(50)
AS

DECLARE @strCreate VARCHAR(8000)
DECLARE @strPK VARCHAR(8000)
DECLARE @strFK VARCHAR(8000)
DECLARE @strTR VARCHAR(8000)
DECLARE @strIX VARCHAR(8000)

BEGIN TRANSACTION
/******************************************************************************
	Error if dimension table already present
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[Dim''+@MemberTable+'']''))
BEGIN
	GOTO SOLVED_SELF
END
/******************************************************************************
	Create MetaData Table
*******************************************************************************/
SET @strCreate = ''CREATE TABLE [dbo].[Dim''+@MemberTable+''] (
	[IDMember] [int] IDENTITY(1,1),
	[Code] [varchar] (50) NOT NULL DEFAULT '''''''',
	[BaseCode] [varchar] (50) NULL ,
	[Order] [int] NULL,
	[TimeStamp] [datetime] NOT NULL
)''
EXEC(@strCreate)
--PRINT @strCreate

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END
/******************************************************************************
	Set Primary Key
******************************************************************************/
SET @strPK = ''ALTER TABLE [dbo].[Dim''+@MemberTable+''] WITH NOCHECK ADD 
	CONSTRAINT [PK_Dim''+@MemberTable+''] PRIMARY KEY CLUSTERED
	([IDMember])''

EXEC(@strPK)
--PRINT @strPK

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

SET @strIX = ''CREATE  INDEX [IX_IDDim_Code] ON [dbo].[Dim''+@MemberTable+'']([IDMember],[Code])''
EXEC(@strIX)
--PRINT @strIX

IF @@ERROR <> 0
BEGIN
 GOTO ERROR_HANDLING
END


/************************************************
Create Location Table
****************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N''[localised_Dim''+@MemberTable+'']''))
BEGIN
	GOTO SOLVED_SELF
END
/******************************************************************************
	Create MetaData Table
*******************************************************************************/
SET @strCreate = ''CREATE TABLE [localised_Dim''+@MemberTable+''] (
	[IDLocation] [int] IDENTITY(1,1),
	[IDMember] int,
	[TwoLetterISO] [varchar] (2) NULL ,
	[Value] [varchar] (max) NULL ,
)''
EXEC(@strCreate)
--PRINT @strCreate
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END
/******************************************************************************
	Set Primary Key
******************************************************************************/
SET @strPK = ''ALTER TABLE [localised_Dim''+@MemberTable+''] WITH NOCHECK ADD 
	CONSTRAINT [PK_LOCATION_Dim''+@MemberTable+''] PRIMARY KEY CLUSTERED
	([IDLocation])''
EXEC(@strPK)
--PRINT @strPK
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

EXEC	[dbo].[proc_CREATE_VW]
		@MemberTable = @MemberTable,
		@PrefixTable = N''Dim''

COMMIT TRANSACTION
Return 0

/******************************************************************************/
SOLVED_SELF:
/******************************************************************************/
COMMIT TRANSACTION
Return 2

/******************************************************************************/
ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1









' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[proc_CREATE_CUBE]
(
	@IDUser int,
	@DatasetCode varchar(50),
	@IDTheme int
)
AS


SET @DatasetCode = UPPER(LTRIM(RTRIM(@DatasetCode)))
IF EXISTS(SELECT 1 FROM [dbo].[CatSet] WHERE Code = @DatasetCode)
BEGIN
	RETURN -1
END


DECLARE	@IDSet int

EXEC	@IDSet = [dbo].[GetNewID] 
		@tableName=''[dbo].[CatSet]'',
		@tableIDColumn=''IDSet'' 

BEGIN TRANSACTION

INSERT INTO [dbo].[CatSet] (IDSet, Code,IDTheme, LastUpdated)
VALUES (@IDSet, @DatasetCode,@IDTheme, getdate())

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

INSERT INTO [dbo].[DOMAIN] ([ID_USER],IDSet) VALUES (@IDUser,@IDSet)

SELECT @IDSet AS IDSet

COMMIT TRANSACTION

RETURN @IDSet

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_AllData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_AllData]
  @IDSet INT,
  @Debug BIT = 0
AS
SET NOCOUNT ON

DECLARE @strIDSet VARCHAR(MAX) = CONVERT(VARCHAR, @IDSet)
DECLARE @column_names varchar(MAX) = ''''
DECLARE @table_joins varchar(MAX) = ''''
DECLARE @dynamic_sql VARCHAR(MAX)

DECLARE @view_name_base VARCHAR(MAX) = ''Dataset_''+ @strIDSet+''_ViewAllData''

DECLARE @IDAtt int
DECLARE @AttCode varchar(50)
DECLARE @IDDim int
DECLARE @DimCode varchar(50)
DECLARE @IDName varchar(50)
DECLARE @MemberTable varchar(50)



-- Delete views if they already exist
IF exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') and OBJECTPROPERTY(id, N''IsView'') = 1)
	SET @dynamic_sql = ''drop view [dbo].[''+@view_name_base+'']''
	IF @Debug=1 PRINT @dynamic_sql
	EXEC(@dynamic_sql)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

-- dynamic SQL generation for Dimension view
/*
SELECT
	@column_names = @column_names + MemberTable + ''.Code as _'' + Code + '', '',
	@table_joins = @table_joins + '' INNER JOIN '' + MemberTable + CHAR(10) + ''  ON '' +''F''+ ''.'' + IDName + ''='' + MemberTable+''.IDMember''
FROM dbo.CatDim
WHERE IDSet=@IDSet AND IsTimeSeriesDim=0
ORDER BY IDDim
*/

DECLARE @IndexComponent int =0 

DECLARE curDIM CURSOR FOR
	SELECT IDDim,IDName,Code,MemberTable
	FROM dbo.CatDim
	WHERE IDSet=@IDSet AND IsTimeSeriesDim=0
	ORDER BY IDDim

OPEN curDIM
WHILE 1=1
BEGIN
	FETCH NEXT FROM curDIM INTO @IDDim,@IDName,@DimCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	DECLARE @MemberTable_Alias varchar(54)=''[''+CONVERT(varchar(10),@IndexComponent)+''_''+@MemberTable+'']'';

	SET @column_names = @column_names + @MemberTable_Alias + ''.[Code] as _'' + @DimCode + CHAR(10) + '', '';
	SET @table_joins = @table_joins + '' INNER JOIN '' + @MemberTable +'' as ''+@MemberTable_Alias+ CHAR(10) + ''  ON '' +''F''+ ''.'' + @IDName + ''='' + @MemberTable_Alias+''.IDMember'';

	SET @IndexComponent=@IndexComponent+1;
END	
CLOSE curDIM
DEALLOCATE curDIM

-- dynamic SQL generation for Attribute view
DECLARE cursCFT CURSOR FOR
	SELECT IDAtt,IDName,Code,MemberTable
	FROM CatAtt
	WHERE IDSet = @IDSet
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDAtt,@IDName,@AttCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK


	DECLARE @str_MemberTable varchar(50)
	SET @str_MemberTable=''CatAttDim''
	DECLARE @MemberField varchar(50)
	SET @MemberField=''IDAtt''
	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_CODE @str_MemberTable,@IDAtt,@MemberField, @COUNT OUT

	IF @COUNT=1
	BEGIN
		SET @column_names = @column_names + @MemberTable + ''.Code as _'' + @AttCode + '', ''
		SET @table_joins = @table_joins + '' LEFT JOIN '' + @MemberTable + CHAR(10) + ''  ON FA.'' + @IDName + ''='' + @MemberTable+''.IDMember''
	END
	ELSE -- IF @COUNT<>1
	BEGIN 
		SET @column_names = @column_names + @MemberTable + ''.Code as _'' + @AttCode + '', ''
		SET @table_joins = @table_joins + '' LEFT JOIN '' + @MemberTable + CHAR(10) + ''  ON F.'' + @IDName + ''='' + @MemberTable+''.IDMember''
	END

END
CLOSE cursCFT
DEALLOCATE cursCFT
/***************************/

-- dynamic sql finialisation
SET @column_names = @column_names + '' FA.Value AS _Value_, FA.Flags AS Flags, TM.Code AS _TIME_PERIOD''
SET @table_joins = ''FiltS''+ @strIDSet+ '' AS F'' + CHAR(10) +
	'' INNER JOIN FactS''+ @strIDSet + '' AS FA'' + CHAR(10) + 
	''  ON F.SID=FA.SID'' + CHAR(10) +
	'' INNER JOIN dbo.DimTIME_PERIOD as TM'' + CHAR(10) + 
	''  ON FA.IDTIME=TM.IDMember'' + CHAR(10) + 
	@table_joins

SET @dynamic_sql = ''CREATE VIEW [dbo].''+@view_name_base+'' AS ''+CHAR(10)+''SELECT '' + @column_names + CHAR(10) + ''FROM '' + @table_joins

IF @Debug=1 PRINT @dynamic_sql

EXEC(@dynamic_sql)

RETURN 0

ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION
RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_DataFactS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_DataFactS]
  @IDSet INT,
  @Debug BIT = 0
AS
SET NOCOUNT ON

DECLARE @strIDSet VARCHAR(MAX) = CONVERT(VARCHAR, @IDSet)
DECLARE @column_names varchar(MAX) = ''''
DECLARE @table_joins varchar(MAX) = ''''
DECLARE @dynamic_sql VARCHAR(MAX)
DECLARE @STEP VARCHAR(MAX)
DECLARE @view_name_base VARCHAR(MAX) = ''VIEW_DataFactS''+@strIDSet

DECLARE @IDDim int
DECLARE @DimCode varchar(50)
DECLARE @IDAtt int
DECLARE @AttCode varchar(50)
DECLARE @IDName varchar(50)
DECLARE @MemberTable varchar(50)

-- Delete views if they already exist
IF exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') and OBJECTPROPERTY(id, N''IsView'') = 1)
	SET @dynamic_sql = ''drop view [dbo].[''+@view_name_base+'']''
	IF @Debug=1 PRINT @dynamic_sql
	EXEC(@dynamic_sql)
IF @@ERROR <> 0
BEGIN
	SET @STEP = ''Drop All Data View''
	GOTO ERROR_HANDLING
	RETURN
END

-- dynamic SQL generation for Dimension view
DECLARE @IndexComponent int =0 

DECLARE curDIM CURSOR FOR
	SELECT IDDim,IDName,Code,MemberTable
	FROM dbo.CatDim
	WHERE IDSet=@IDSet AND IsTimeSeriesDim=0
	ORDER BY IDDim

OPEN curDIM
WHILE 1=1
BEGIN
	FETCH NEXT FROM curDIM INTO @IDDim,@IDName,@DimCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	DECLARE @MemberTable_Alias varchar(54)=''[''+CONVERT(varchar(10),@IndexComponent)+''_''+@MemberTable+'']'';

	SET @column_names = @column_names + @MemberTable_Alias + ''.[IDMember] as '' + @IDName  + CHAR(10) +  '', '';
	SET @table_joins = @table_joins + '' INNER JOIN '' + @MemberTable  +'' as ''+@MemberTable_Alias+ CHAR(10) + ''  ON F.'' + @IDName + ''='' + @MemberTable_Alias+''.IDMember'';
	
	SET @IndexComponent=@IndexComponent+1;
END	
CLOSE curDIM
DEALLOCATE curDIM


-- dynamic SQL generation for Attribute view
DECLARE cursCFT CURSOR FOR
	SELECT IDAtt,IDName,Code,MemberTable
	FROM CatAtt
	WHERE IDSet = @IDSet
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDAtt,@IDName,@AttCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	DECLARE @str_MemberTable varchar(50)
	SET @str_MemberTable=''CatAttDim''
	DECLARE @MemberField varchar(50)
	SET @MemberField=''IDAtt''
	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_CODE @str_MemberTable,@IDAtt,@MemberField, @COUNT OUT

	IF @COUNT=1
	BEGIN
		SET @column_names = @column_names + @MemberTable + ''.IDMember as '' + @IDName + '', ''
		SET @table_joins = @table_joins + '' LEFT JOIN '' + @MemberTable + CHAR(10) + ''  ON FA.'' + @IDName + ''='' + @MemberTable+''.IDMember''
	END
	ELSE -- IF @COUNT>1
	BEGIN 
		SET @column_names = @column_names + @MemberTable + ''.IDMember as '' + @IDName + '', ''
		SET @table_joins = @table_joins + '' LEFT JOIN '' + @MemberTable + CHAR(10) + ''  ON F.'' + @IDName + ''='' + @MemberTable+''.IDMember''
	END

END
CLOSE cursCFT
DEALLOCATE cursCFT
/***************************/

-- dynamic sql finialisation
SET @column_names = @column_names + '' FA.Value AS Value, FA.Flags AS Flags, TM.IDMember AS IDTIME_PERIOD''
SET @table_joins = ''FiltS''+ @strIDSet+ '' AS F'' + CHAR(10) +
	'' INNER JOIN FactS''+ @strIDSet + '' AS FA'' + CHAR(10) + 
	''  ON F.SID=FA.SID'' + CHAR(10) +
	'' INNER JOIN dbo.DimTIME_PERIOD as TM'' + CHAR(10) + 
	''  ON FA.IDTIME=TM.IDMember'' + CHAR(10) + 
	@table_joins

SET @dynamic_sql = ''CREATE VIEW [dbo].''+@view_name_base+'' AS ''+CHAR(10)+''SELECT '' + @column_names + CHAR(10) + ''FROM '' + @table_joins

EXEC(@dynamic_sql)

RETURN 0

ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION
RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_CUBE_VIEW_ViewAllSeries]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_CREATE_CUBE_VIEW_ViewAllSeries]
  @IDSet INT,
  @Debug BIT = 0
AS
SET NOCOUNT ON

DECLARE @strIDSet VARCHAR(MAX) = CONVERT(VARCHAR, @IDSet)
DECLARE @column_names varchar(MAX) = ''''
DECLARE @table_joins varchar(MAX) = ''''
DECLARE @dynamic_sql VARCHAR(MAX)
DECLARE @view_name_base VARCHAR(MAX) = ''Dataset_''+ @strIDSet+''_ViewAllSeries''

DECLARE @IDDim int
DECLARE @DimCode varchar(255)
DECLARE @IDAtt int
DECLARE @AttCode varchar(255)
DECLARE @IDName varchar(255)
DECLARE @MemberTable varchar(255)

-- Delete views if they already exist
IF exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') and OBJECTPROPERTY(id, N''IsView'') = 1)
	SET @dynamic_sql = ''drop view [dbo].[''+@view_name_base+'']''
	IF @Debug=1 PRINT @dynamic_sql
	EXEC(@dynamic_sql)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

-- dynamic SQL generation for Dimension view
DECLARE @IndexComponent int =0 

DECLARE curDIM CURSOR FOR
	SELECT IDDim,IDName,Code,MemberTable
	FROM dbo.CatDim
	WHERE IDSet=@IDSet AND IsTimeSeriesDim=0
	ORDER BY IDDim

OPEN curDIM
WHILE 1=1
BEGIN
	FETCH NEXT FROM curDIM INTO @IDDim,@IDName,@DimCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	DECLARE @MemberTable_Alias varchar(54)=''[''+CONVERT(varchar(10),@IndexComponent)+''_''+@MemberTable+'']'';

	SET @column_names = @column_names + @MemberTable_Alias + ''.[Code] as _'' + @DimCode + CHAR(10) + '', '';
	SET @table_joins = @table_joins + '' INNER JOIN '' + @MemberTable +'' as ''+@MemberTable_Alias+ CHAR(10) + ''  ON '' +''F''+ ''.'' + @IDName + ''='' + @MemberTable_Alias+''.IDMember'';

	SET @IndexComponent=@IndexComponent+1;
END	
CLOSE curDIM
DEALLOCATE curDIM


-- dynamic SQL generation for Attribute view
DECLARE cursCFT CURSOR FOR
	SELECT IDAtt,IDName,Code,MemberTable
	FROM CatAtt
	WHERE IDSet = @IDSet
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDAtt,@IDName,@AttCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK


	DECLARE @str_MemberTable varchar(255)
	SET @str_MemberTable=''CatAttDim''
	DECLARE @MemberField varchar(255)
	SET @MemberField=''IDAtt''
	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_CODE @str_MemberTable,@IDAtt,@MemberField, @COUNT OUT

	IF @COUNT<>1
	BEGIN 
		SET @column_names = @column_names + @MemberTable + ''.Code as '' + @AttCode +'',''
		SET @table_joins = @table_joins + '' LEFT JOIN '' + @MemberTable + CHAR(10) + ''  ON F.'' + @IDName + ''='' + @MemberTable+''.IDMember''
	END

END
CLOSE cursCFT
DEALLOCATE cursCFT
/***************************/

-- dynamic sql finialisation
SET @column_names=substring(ltrim(rtrim(@column_names)),0,len(@column_names) )
SET @table_joins = ''FiltS''+ @strIDSet+ '' AS F'' + CHAR(10) + @table_joins
SET @dynamic_sql = ''CREATE VIEW [dbo].''+@view_name_base+'' AS ''+CHAR(10)+''SELECT F.SID, '' + @column_names + CHAR(10) +
 ''FROM '' + @table_joins

EXEC(@dynamic_sql)

RETURN 0

ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION
RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_FACT_TABLE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_CREATE_FACT_TABLE]
(
	@IDSet int
)
AS

/***************************/
--DECLARE @IDSet INT
--SET @IDSet = 184
/***************************/


DECLARE @IDAtt int
DECLARE @IDName varchar(50)
DECLARE @AttCode varchar(50)
DECLARE @MemberTable varchar(50)
DECLARE @strDrop VARCHAR(max)
DECLARE @strCreate VARCHAR(max)
DECLARE @strCreate_att VARCHAR(max)
DECLARE @strPKIX VARCHAR(max)
DECLARE @strPK VARCHAR(max)

DECLARE @strIDSet varchar(10)
DECLARE @separator char(1)
SET @strIDSet = CAST(@IDSet as varchar(10))
DECLARE @timestamp varchar(255)
SET @timestamp=cast(getdate() AS varchar(255))

/*
	Entry Condition
*/

IF NOT EXISTS (SELECT 1 FROM CatSet WHERE IDSet = @IDSet)
BEGIN
	RETURN -1
END

BEGIN TRANSACTION
/******************************************************************************
	Drop table if already present.
*******************************************************************************/
SET @strDrop = ''drop table [dbo].[FactS''+@strIDSet+'']''
if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[FactS''+@strIDSet+'']'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
	--EXEC(@strDrop)
	PRINT @strDrop
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

SET @strCreate_att=''''
SET @separator=''''
/* Get list att on level series */
DECLARE cursCFT CURSOR FOR
	SELECT IDAtt,IDName,Code,MemberTable
	FROM CatAtt
	WHERE IDSet = @IDSet
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDAtt,@IDName,@AttCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK
		
	DECLARE @str_MemberTable varchar(50)
	SET @str_MemberTable=''CatAttDim''
	DECLARE @MemberField varchar(50)
	SET @MemberField=''IDAtt''
	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_CODE @str_MemberTable,@IDAtt,@MemberField, @COUNT OUT

	IF @COUNT=1
	BEGIN
		SET @strCreate_att = @strCreate_att + @separator+ ''[''+@IDName+''] [int] NULL''
		SET @separator='',''
	END


END
CLOSE cursCFT
DEALLOCATE cursCFT

IF @strCreate_att<>''''
SET @strCreate_att=@strCreate_att+@separator
ELSE
SET @strCreate_att=''''

/******************************************************************************
	Create Fact Table
*******************************************************************************/
SET @strCreate = ''CREATE TABLE [dbo].[FactS''+@strIDSet+''] 
([SID] [int] NOT NULL,''+
''[IDTIME] [int] NOT NULL,''+
@strCreate_att+
''[Value] [decimal](38, 5) NULL,
[Flags] [varchar] (10) NOT NULL,
[LastUpdated] [datetime] NOT NULL)''

EXEC(@strCreate)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

/******************************************************************************
	Set Primary Key
*******************************************************************************/
SET @strPK = ''ALTER TABLE [dbo].[FactS''+@strIDSet+''] WITH NOCHECK
ADD CONSTRAINT [PK_FactS''+@strIDSet+''] PRIMARY KEY CLUSTERED ([SID],[IDTIME])''
--PRINT @strPK
EXEC(@strPK)
IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END


COMMIT TRANSACTION
RETURN 0

/******************************************************************************/
ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_FILT_TABLE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_CREATE_FILT_TABLE]
(
	@IDSet int
)
AS

/***************************/
--DECLARE @IDSet INT
--SET @IDSet = 184
/***************************/

DECLARE @errmessage varchar(255)
DECLARE @MicroData bit
DECLARE @IDAtt int
DECLARE @IDName varchar(50)
DECLARE @AttCode varchar(50)
DECLARE @MemberTable varchar(50)
DECLARE @isTimeDim bit
DECLARE @strDrop varchar(max)
DECLARE @SQL varchar(max)
DECLARE @strIndex varchar(max)
DECLARE @STEP varchar(50)
DECLARE @strIDSet varchar(50)
DECLARE @strCreate_dim varchar(max)
DECLARE @strPK_dim varchar(max)
DECLARE @strCreate_att varchar(max)
DECLARE @separator char(1)
SET @strIDSet = CAST(@IDSet as varchar(10))

DECLARE @MaxKey int
SET @MaxKey=16

IF @IDSet = -1 SET @strIDSet = ''ReferenceSeries'' -- DR 17-06-2005

IF NOT EXISTS (SELECT 1 FROM dbo.CatSet WHERE IDSet = @IDSet)
BEGIN
	SET @STEP = ''Dataset not found in catalog''
	SELECT @errmessage = ''proc_CreateFiltTable: Step: %s. @IDSet: %d.''
	RAISERROR (@errmessage,16,1, @STEP, @IDSet) 
	RETURN -1
END

BEGIN TRANSACTION
/******************************************************************************
	Drop table if already present.
*******************************************************************************/
SET @strDrop = ''drop table [dbo].[FiltS''+@strIDSet+'']''
if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[FiltS''+@strIDSet+'']'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
	EXEC(@strDrop)
	--PRINT(@strDrop)
IF @@ERROR <> 0
BEGIN
	SET @STEP = ''Drop Table''
	GOTO ERROR_HANDLING
END


/* Get list dim */
DECLARE cursCFT CURSOR FOR
	SELECT IDName,IsTimeSeriesDim
	FROM CatDim
	WHERE IDSet = @IDSet
		
SET @separator=''''
SET @strCreate_dim = ''''
SET @strPK_dim = ''''


DECLARE @CountKey int
SET @CountKey=0

OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDName,@isTimeDim
	IF @@FETCH_STATUS <> 0 
		BREAK
	IF @isTimeDim = 0 
	BEGIN
		SET @strCreate_dim = @strCreate_dim + @separator+ ''[''+@IDName+''] [int] NOT NULL'' + char(13) + char(10)
		--SET @strPK_dim = @strPK_dim + @separator +''[''+@IDName+'']'' + char(13) + char(10)
		--print @CountKey
		IF @MaxKey<>@CountKey
		BEGIN
			SET @strPK_dim = @strPK_dim + @separator +''[''+@IDName+'']'' + char(13) + char(10)
			SET @CountKey=@CountKey+1
		END
		SET @separator='',''
	END
END
CLOSE cursCFT
DEALLOCATE cursCFT

IF @strCreate_dim<>''''
	SET @strCreate_dim=@strCreate_dim+@separator


SET @strCreate_att=''''
SET @separator=''''

/* Get list att on level dimension group */
DECLARE cursCFT CURSOR FOR
	SELECT IDAtt,IDName,Code,MemberTable
	FROM CatAtt
	WHERE IDSet = @IDSet
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @IDAtt,@IDName,@AttCode,@MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	DECLARE @str_MemberTable varchar(50)
	SET @str_MemberTable=''CatAttDim''
	DECLARE @MemberField varchar(50)
	SET @MemberField=''IDAtt''
	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_CODE @str_MemberTable,@IDAtt,@MemberField, @COUNT OUT

	IF @COUNT>1
	BEGIN
		SET @strCreate_att = @strCreate_att + @separator+ ''[''+@IDName+''] [int] NULL'' + char(13) + char(10)
		SET @separator='',''
	END
	IF @COUNT=0
	BEGIN
		SET @strCreate_att = @strCreate_att + @separator+ ''[''+@IDName+''] [int] NULL'' + char(13) + char(10)
		SET @separator='',''
	END


END
CLOSE cursCFT
DEALLOCATE cursCFT


/******************************************************************************
	Filter table creation
*******************************************************************************/
SET @SQL = ''CREATE TABLE [dbo].[FiltS''+@strIDSet+''] ([SID] [INT] IDENTITY(1,1) NOT NULL,
''+@strCreate_dim+@strCreate_att+''
CONSTRAINT [PK_FiltS''+@strIDSet+''] PRIMARY KEY CLUSTERED (''+@strPK_dim+'') WITH FILLFACTOR=90)''
--PRINT @SQL
EXEC(@SQL)

/******************************************************************************
	Create indexes
*******************************************************************************/

SET @strIndex = ''
		CREATE NONCLUSTERED INDEX [IX_FiltS''+@strIDSet+''_SID] ON dbo.[FiltS''+@strIDSet+'']
		([SID]) WITH(FILLFACTOR = 90)''

EXEC(@strIndex)
IF @@ERROR <> 0
BEGIN
	CLOSE cursCFT
	DEALLOCATE cursCFT
	SET @STEP = ''Create index''
	GOTO ERROR_HANDLING
END

COMMIT TRANSACTION
RETURN 0

/******************************************************************************/
ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1









' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_CREATE_VW]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_CREATE_VW]
	@MemberTable varchar(50),
	@PrefixTable varchar(3),
	@Debug BIT = 0
AS
SET NOCOUNT ON

DECLARE @STEP VARCHAR(MAX)

DECLARE @dynamic_sql varchar(max)

DECLARE @view_name_base varchar(max) =''VW_''+@PrefixTable+@MemberTable 
-- Delete views if they already exist
IF exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') and OBJECTPROPERTY(id, N''IsView'') = 1)
	SET @dynamic_sql = ''drop view [dbo].[''+@view_name_base+'']''
	IF @Debug=1 PRINT @dynamic_sql
	EXEC(@dynamic_sql)
IF @@ERROR <> 0
BEGIN
	SET @STEP = ''Drop All Data View''
	GOTO ERROR_HANDLING
	RETURN
END

SET @dynamic_sql=''CREATE VIEW [dbo].''+@view_name_base+'' AS ''
SET @dynamic_sql+=''SELECT TableCode.IDMember, TableCode.Code, TableValue.TwoLetterISO, TableValue.Value FROM ''+@PrefixTable+@MemberTable+'' as TableCode INNER JOIN localised_''+@PrefixTable+@MemberTable+'' AS TableValue ON TableCode.IDMember = TableValue.IDMember''

PRINT @dynamic_sql

EXEC(@dynamic_sql)
RETURN 0

ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_CUBE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_DELETE_CUBE]
	@IDSet int
AS

BEGIN TRANSACTION

DECLARE @strDrop varchar(max)
DECLARE @strIDSet varchar(10)
DECLARE @view_name_base varchar(MAX)


DELETE FROM [dbo].DOMAIN WHERE IDSet=@IDSet

DELETE FROM dbo.DATA_MAPPING WHERE ID_SCHEMA=(SELECT ID_SCHEMA FROM  dbo.CAT_MAPPING WHERE ID_SET=@IDSet)
DELETE FROM dbo.CAT_MAPPING WHERE ID_SET=@IDSet

DELETE FROM localised_CatDataFlow WHERE IDMember=@IDSet
DELETE FROM dbo.CatDataFlow WHERE IDSet=@IDSet

DELETE FROM localised_CatSet WHERE IDMember=@IDSet
DELETE FROM dbo.CatSet WHERE IDSet=@IDSet

DECLARE @MemberTable varchar(50)
DECLARE @str_MemberTable varchar(50)
DECLARE @MemberField varchar(50)
DECLARE @COUNT INT = 0

-- Delete not associated attribute table
DECLARE cursCFT CURSOR FOR
	SELECT MemberTable FROM dbo.CatAtt WHERE IDSet=@IDSet
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK

	SET @str_MemberTable=''CatAtt''
	SET @MemberField=''MemberTable''
	EXEC proc_COUNT_CODE @str_MemberTable,@MemberTable,@MemberField, @COUNT OUT
	
	IF @COUNT=1
	BEGIN
		EXEC (''DROP VIEW dbo.VW_''+@MemberTable)
		EXEC (''DROP TABLE dbo.''+@MemberTable)
		EXEC (''DROP TABLE localised_''+@MemberTable)
	END
END
CLOSE cursCFT
DEALLOCATE cursCFT

-- Delete not associated dimension table
DECLARE cursCFT CURSOR FOR
	SELECT MemberTable FROM dbo.CatDim WHERE IDSet=@IDSet AND IsTimeSeriesDim=0
		
OPEN cursCFT
WHILE 1=1
BEGIN
	FETCH NEXT FROM cursCFT INTO @MemberTable
	IF @@FETCH_STATUS <> 0 
		BREAK
		
	SET @str_MemberTable=''CatDim''
	SET @MemberField=''MemberTable''
	EXEC proc_COUNT_CODE @str_MemberTable,@MemberTable,@MemberField, @COUNT OUT

	IF @COUNT=1
	BEGIN
		EXEC (''DROP VIEW dbo.VW_''+@MemberTable)
		EXEC (''DROP TABLE dbo.''+@MemberTable)
		EXEC (''DROP TABLE localised_''+@MemberTable)
	END
end
CLOSE cursCFT
DEALLOCATE cursCFT


DELETE FROM localised_CatAtt WHERE IDMember IN(SELECT IDATT FROM  dbo.CatAtt WHERE IDSet=@IDSet)
DELETE FROM dbo.CatAttDim WHERE IDAtt IN(SELECT IDATT FROM  dbo.CatAtt WHERE IDSet=@IDSet)
DELETE FROM dbo.CatAtt WHERE IDSet=@IDSet

DELETE FROM localised_CatDim WHERE IDMember IN(SELECT IDDIM FROM  dbo.CatDim WHERE IDSet=@IDSet)
DELETE FROM dbo.CatDim WHERE IDSet=@IDSet

SET @strIDSet = CAST(@IDSet as varchar(10))
SET @view_name_base = ''VIEW_DataFactS''+@strIDSet

SET @strDrop = ''DROP VIEW [dbo].[''+@view_name_base+'']''
IF EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') )
	EXEC(@strDrop)

	IF @@ERROR <> 0
		BEGIN
			GOTO ERROR_HANDLING
			RETURN
		END

SET @view_name_base = ''Dataset_''+@strIDSet+''_ViewAllData''

SET @strDrop = ''DROP VIEW [dbo].[''+@view_name_base+'']''
IF EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') )
	EXEC(@strDrop)

	IF @@ERROR <> 0
		BEGIN
			GOTO ERROR_HANDLING
			RETURN
		END

SET @view_name_base = ''Dataset_''+@strIDSet+''_ViewAllSeries''
SET @strDrop = ''DROP VIEW [dbo].[''+@view_name_base+'']''
IF EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@view_name_base+'']'') )
	EXEC(@strDrop)

	IF @@ERROR <> 0
		BEGIN
			GOTO ERROR_HANDLING
			RETURN
		END

SET @strDrop = ''DROP TABLE [dbo].[FiltS''+@strIDSet+'']''
IF EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[FiltS''+@strIDSet+'']'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
	EXEC(@strDrop)
	--PRINT @strDrop
IF @@ERROR <> 0
	BEGIN
		GOTO ERROR_HANDLING
	END

SET @strDrop = ''DROP TABLE [dbo].[FactS''+@strIDSet+'']''
IF EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[FactS''+@strIDSet+'']'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
	EXEC(@strDrop)
	--PRINT @strDrop
IF @@ERROR <> 0
	BEGIN
		GOTO ERROR_HANDLING
	END


COMMIT TRANSACTION

RETURN 0

/******************************************************************************/
ERROR_HANDLING:
/*******************************************************************************/
ROLLBACK TRANSACTION

RETURN -1










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_DATA_FACTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_DELETE_DATA_FACTS]
	@IDSet int,
	@SID int,
	@IDTime int
AS

DECLARE @str_IDSet varchar(10)
SET @str_IDSet = CAST(@IDSet as varchar(10))
DECLARE @str_SID varchar(10) 
SET @str_SID = CAST(@SID as varchar(10))
DECLARE @str_IDTime varchar(10) 
SET @str_IDTime = CAST(@IDTime as varchar(10))

BEGIN
	
	DECLARE @Sql varchar(300)
	SET @Sql=N''DELETE FROM FactS''+@str_IDSet+'' WHERE SID=''+@str_SID+'' AND IDTime=''+@str_IDTime
	EXEC(@Sql)

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_MAPPING]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_DELETE_MAPPING]
	@IDSchema int
AS
BEGIN

DELETE FROM dbo.CAT_MAPPING WHERE @IDSchema=ID_SCHEMA

DELETE FROM dbo.DATA_MAPPING WHERE @IDSchema=ID_SCHEMA

END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_DELETE_USER]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_DELETE_USER]
	@id_user int
AS
BEGIN
	DELETE FROM [dbo].DOMAIN WHERE [dbo].DOMAIN.ID_USER=@id_user
	DELETE FROM [dbo].[USER] WHERE [dbo].[USER].ID_USER=@id_user
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATT_ATTACH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_ATT_ATTACH]
	@IDSet int,
	@AttCode varchar(50)
AS
BEGIN

SET NOCOUNT ON;

SELECT CatAttDim.IDDim
FROM CatAtt INNER JOIN
	CatAttDim ON CatAtt.IDAtt = CatAttDim.IDAtt
WHERE (CatAtt.IDSet = @IDset) AND (CatAtt.Code = @AttCode)

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATTRIBUTE_CODE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_ATTRIBUTE_CODE]
	@IDAtt int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT DISTINCT(Code) FROM CatAtt WHERE CatAtt.IDAtt=@IDAtt

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_ATTRIBUTES]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_ATTRIBUTES]
	@IDSet varchar(50),
	@TwoLetterISO varchar(2) = "en"
AS
BEGIN

SELECT CatAtt.IDAtt,CatAtt.IDName, CatAtt.Code, CatAtt.MemberTable, CatAtt.[TimeStamp], CatAtt.IsCodelist,CatAtt.IsMandatory, localised.TwoLetterISO, localised.Value
FROM CatAtt INNER JOIN
 localised_CatAtt AS localised ON CatAtt.IDAtt = localised.IDMember
WHERE (CatAtt.IDSet = @IDSet) AND (localised.TwoLetterISO = ''en'')

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODE_ID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_CODE_ID]
	@MemberTable varchar(50),
	@Code varchar(50)
AS
BEGIN


	DECLARE @IDDim int
	SET @IDDim = -1

	DECLARE @Sql varchar(max)
	SET @Sql = N''SELECT IDMember FROM dbo.''+@MemberTable+'' WHERE Code=''''''+@Code+''''''''
	EXECUTE (@Sql);
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODES_ATTRIBUTE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_CODES_ATTRIBUTE]
	@Code varchar(50),
	@TwoLetterISO varchar(2)
AS
BEGIN

	DECLARE @MemberTable nvarchar(50)
	DECLARE @Sql varchar(3000)

	SELECT @MemberTable=MemberTable FROM CatAtt WHERE Code=@Code

	--SELECT @MemberTable AS MemberTable
	
	
	SET @Sql=''SELECT ''+@MemberTable+''.IDMember, ''+@MemberTable+''.Code, ''+@MemberTable+''.BaseCode, ''+@MemberTable+''.[Order], ''+@MemberTable+''.TimeStamp, localised.TwoLetterISO, localised.Value
	FROM ''+@MemberTable+'' INNER JOIN localised_''+@MemberTable+'' AS localised ON ''+@MemberTable+''.IDMember = localised.IDMember
	WHERE (localised.TwoLetterISO = ''+''''''''+@TwoLetterISO+''''''''+'')''

	print @Sql

	EXEC(@Sql)

END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CODES_DIMENSION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_CODES_DIMENSION]
	@Code varchar(50),
	@TwoLetterISO varchar(2)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @MemberTable nvarchar(50)
	DECLARE @Sql varchar(3000)

	SELECT @MemberTable=MemberTable FROM CatDim WHERE Code=@Code

	--SELECT @MemberTable AS MemberTable
	
	SET @Sql=''SELECT ''+@MemberTable+''.IDMember, ''+@MemberTable+''.Code, ''+@MemberTable+''.BaseCode, ''+@MemberTable+''.[Order], ''+@MemberTable+''.TimeStamp, localised.TwoLetterISO, localised.Value
	FROM ''+@MemberTable+'' INNER JOIN localised_''+@MemberTable+'' AS localised ON ''+@MemberTable+''.IDMember = localised.IDMember
	WHERE (localised.TwoLetterISO = ''+''''''''+@TwoLetterISO+''''''''+'')''
	print @Sql
	EXEC(@Sql)

	RETURN

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CUBE_DETAILS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_CUBE_DETAILS]

@CUBEID VARCHAR(1000)

AS


--DECLARE @IDSET AS VARCHAR(15)

--SELECT @IDSET = IDSET
--FROM dbo.CatSet
--WHERE Code = @CUBEID

EXECUTE (''SELECT * FROM Dataset_''+ @CUBEID +''_ViewAllData'' )' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_CUBE_NAME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_CUBE_NAME]

@IDSET INT

as


SELECT TOP 1 ID
FROM dbo.CatDataFlow
WHERE IDSet = @IDSET




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCT]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DATASTRUCT]
	@IDSet int,
	@TwoLetterISO varchar(2)=''en''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CatSet.IDSet, CatSet.Code, CatSet.LastUpdated, CatSet.UnitDimension,CatSet.IDTheme, 
		CatDataFlow.IDDataFlow as IDDataFlow, CatTheme.Urn ThemeURN,
		''Dataflow'' = CatDataFlow.ID +''+''+ dbo.CatDataFlow.AgencyID +''+''+ dbo.CatDataFlow.Version 
FROM   CatDataFlow 
		INNER JOIN CatSet ON 
			CatDataFlow.IDSet = CatSet.IDSet
		INNER JOIN CatTheme ON
			CatSet.IDTheme = dbo.CatTheme.IDTheme
WHERE  (CatSet.IDSet = @IDSet)
ORDER BY CatSet.IDSet DESC

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCT_BY_USER]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DATASTRUCT_BY_USER]
	@IDUser int,
	@TwoLetterISO varchar(2)=''en''
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @idset int
	DECLARE @code varchar(50)
	DECLARE @idflow int
	DECLARE @idTheme int
	DECLARE @value  varchar(max)
	DECLARE @twoletter varchar(2)

	DECLARE @idsettemp int
	SET @idsettemp=-1

	DECLARE @MatchTemp TABLE(
		IDSet int,
		IDDataFlow int,
		Code varchar(50),
		IDTheme int,
		Value  varchar(max),
		TwoLetterISO varchar(2)
	)

	DECLARE _cursor CURSOR
    FOR SELECT	CatSet.IDSet as IDSet,
				CatDataFlow.IDDataFlow,
				CatSet.Code as Code,
				CatSet.IDTheme,
				Localised.Value as Value,
				Localised.TwoLetterISO as TwoLetterISO
		FROM	CatSet INNER JOIN 
				CatDataFlow ON CatDataFlow.IDSet = CatSet.IDSet INNER JOIN
                dbo.DOMAIN ON CatSet.IDSet = dbo.DOMAIN.IDSet OR CatSet.IDTheme = dbo.DOMAIN.IDTheme INNER JOIN
				localised_CatSet AS Localised ON CatSet.IDSet = Localised.IDMember
		WHERE (dbo.DOMAIN.ID_USER = @IDUser)
		ORDER BY CatSet.IDSet
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @idset,@idflow,@code,@idTheme,@value,@twoletter;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF(@idsettemp<>@idset)
		INSERT INTO @MatchTemp(
		IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO
		)
		VALUES (@idset,@idflow,@code,@idTheme,@value,@twoletter)

		SET @idsettemp=@idset;

		FETCH NEXT FROM _cursor  INTO @idset,@idflow,@code,@idTheme,@value,@twoletter;
	END
	
	CLOSE _cursor;
	DEALLOCATE _cursor;


	SELECT IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO
	FROM @MatchTemp
	GROUP BY IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DATASTRUCTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DATASTRUCTS]

AS
BEGIN
SET NOCOUNT ON;

	DECLARE @idset int
	DECLARE @code varchar(50)
	DECLARE @idflow int
	DECLARE @idTheme int
	DECLARE @value  varchar(max)
	DECLARE @twoletter varchar(2)

	DECLARE @idsettemp int
	SET @idsettemp=-1

	DECLARE @MatchTemp TABLE(
		IDSet int,
		IDDataFlow int,
		Code varchar(50),
		IDTheme int,
		Value  varchar(max),
		TwoLetterISO varchar(2)
	)

	DECLARE _cursor CURSOR
    FOR SELECT	CatSet.IDSet as IDSet,
				CatDataFlow.IDDataFlow,
				CatSet.Code as Code,
				CatSet.IDTheme,
				Localised.Value as Value,
				Localised.TwoLetterISO as TwoLetterISO
		FROM	CatSet INNER JOIN 
				CatDataFlow ON CatDataFlow.IDSet = CatSet.IDSet INNER JOIN
				localised_CatSet AS Localised ON CatSet.IDSet = Localised.IDMember
		ORDER BY CatSet.IDSet
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @idset,@idflow,@code,@idTheme,@value,@twoletter;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF(@idsettemp<>@idset)
		INSERT INTO @MatchTemp(
		IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO
		)
		VALUES (@idset,@idflow,@code,@idTheme,@value,@twoletter)

		SET @idsettemp=@idset;

		FETCH NEXT FROM _cursor  INTO @idset,@idflow,@code,@idTheme,@value,@twoletter;
	END
	
	CLOSE _cursor;
	DEALLOCATE _cursor;


	SELECT IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO
	FROM @MatchTemp
	GROUP BY IDSet,
		IDDataFlow,
		Code,
		IDTheme,
		Value,
		TwoLetterISO

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENISION_CODE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DIMENISION_CODE]
	@IDDim int
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT DISTINCT(Code) FROM CatDim WHERE CatDim.IDDim=@IDDim

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENSIONS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DIMENSIONS]
	@IDSet varchar(50),
	@TwoLetterISO varchar(2) = "en"
AS
BEGIN
	
SELECT 
localised.TwoLetterISO,
localised.Value, 
CatDim.IDName, 
CatDim.Code, 
CatDim.IDDim, 
CatDim.MemberTable, 
CatDim.[TimeStamp],
CatDim.IsTimeSeriesDim
FROM CatDim RIGHT JOIN localised_CatDim AS localised ON CatDim.IDDim = localised.IDMember
WHERE (CatDim.IDSet = @IDSet) AND (localised.TwoLetterISO = ''en'')

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_DIMENSIONS_REFERENCE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_DIMENSIONS_REFERENCE]
	@IDAtt int

AS
BEGIN
	SELECT COUNT(*) as DimReference FROM dbo.CatAttDim WHERE  dbo.CatAttDim.IDAtt=@IDAtt
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_IDDIM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_IDDIM]
	@IDSet int,
	@Code varchar(50)
AS
BEGIN

	SELECT IDDim FROM CatDim WHERE Code=@Code AND IDSet=@IDSet

END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_LOCATION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_LOCATION]
	@IDMember int,
	@MemberTable varchar(50),
	@TwoLetterISO varchar(2)
AS
BEGIN

	BEGIN TRANSACTION
	
	SET NOCOUNT ON;

	DECLARE @str_IDMember varchar(10)
	SET @str_IDMember=CAST(@IDMember as varchar(10))
	DECLARE @Sql varchar(255)
	SET @Sql=''SELECT * FROM localised_''+@MemberTable+'' WHERE IDMember=''+@str_IDMember+'' AND TwoLetterISO=''''''+ @TwoLetterISO+''''''''
	--print @Sql
	EXEC(@Sql)

	IF @@ERROR <> 0
		BEGIN
			GOTO ERROR_HANDLING
		END
	
	COMMIT TRANSACTION
	
	RETURN 0
END

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_LOCATION_ALL]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_GET_LOCATION_ALL]
	@IDMember int,
	@MemberTable varchar(50) 
AS
BEGIN

	BEGIN TRANSACTION

	SET NOCOUNT ON;
	
	DECLARE @str_IDMember varchar(10)
	SET @str_IDMember=CAST(@IDMember as varchar(10))
	DECLARE @Sql varchar(255)
	SET @Sql=''SELECT * FROM localised_''+@MemberTable+'' WHERE IDMember=''+@str_IDMember
	--print @Sql
	EXEC(@Sql)

	IF @@ERROR <> 0
		BEGIN
			GOTO ERROR_HANDLING
		END
	
	COMMIT TRANSACTION
	
	RETURN 0
END

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_MAPPING]
	@IDSet int
AS
BEGIN
	SET NOCOUNT ON;

SELECT ID_SCHEMA, NAME,[TIMESTAMP], [DESCRIPTION],[FILE_CSV_CHAR],[FILE_CSV_HASHEADER],[TRANSCODE_USE],[TRANSCODE_CHAR],[TRANSCODE_VALUE]
FROM dbo.CAT_MAPPING
WHERE (ID_SET = @IDSet)

END








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING_COLUMNS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_MAPPING_COLUMNS]
	@IDSchema bigint
AS
BEGIN
	SET NOCOUNT ON;
SELECT ID_MAP, ID_COLUMN,NAME_COLUMN, NAME 
FROM            dbo.DATA_MAPPING
WHERE        (ID_SCHEMA = @IDSchema)
END








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPING_SCHEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_MAPPING_SCHEME]
	@IDMappingScheme int
AS
BEGIN
	SET NOCOUNT ON;

SELECT        ID_SCHEMA, ID_SET, NAME, DESCRIPTION,[TIMESTAMP], FILE_CSV_CHAR, FILE_CSV_HASHEADER,TRANSCODE_USE, TRANSCODE_CHAR, TRANSCODE_VALUE
FROM            dbo.CAT_MAPPING
WHERE        (ID_SCHEMA = @IDMappingScheme)

END








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_MAPPINGS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_MAPPINGS]
	@IDUser int
AS
BEGIN
	SET NOCOUNT ON;

SELECT        dbo.DOMAIN.ID_USER, dbo.CAT_MAPPING.NAME,dbo.CAT_MAPPING.ID_SCHEMA, dbo.CAT_MAPPING.DESCRIPTION, dbo.CAT_MAPPING.FILE_CSV_CHAR, 
            dbo.CAT_MAPPING.FILE_CSV_HASHEADER, dbo.CAT_MAPPING.TRANSCODE_CHAR, dbo.CAT_MAPPING.TRANSCODE_VALUE, dbo.CAT_MAPPING.TRANSCODE_USE, dbo.CAT_MAPPING.TIMESTAMP, dbo.CAT_MAPPING.ID_SET
FROM            dbo.CAT_MAPPING INNER JOIN
                         dbo.DOMAIN ON dbo.CAT_MAPPING.ID_SET = dbo.DOMAIN.IDSet
WHERE        (dbo.DOMAIN.ID_USER = @IDUser)

END








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_SID_FILTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_SID_FILTS]
	@IDSet int,
	@Sql_Where varchar(max),
	@SID INT OUT 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @strIDSet varchar(10)
	SET @strIDSet = CAST(@IDSet as varchar(10))
	DECLARE @Sql varchar(max)

	SET @Sql=N''SELECT [SID] RCOUNT INTO ##RET FROM FiltS''+@strIDSet+'' WHERE ''+@Sql_Where

	EXECUTE(@Sql)

	SELECT @SID = RCOUNT FROM ##RET

	DROP TABLE ##RET

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_SID_VIEW_FILTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_SID_VIEW_FILTS]
	@IDSet int,
	@Sql_Where varchar(max),
	@SID INT OUT 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @strIDSet varchar(10)
	SET @strIDSet = CAST(@IDSet as varchar(10))
	DECLARE @Sql varchar(max)

	SET @Sql=N''SELECT [SID] RCOUNT INTO ##RET FROM Dataset_''+@strIDSet+''_ViewAllSeries WHERE ''+@Sql_Where

	EXECUTE(@Sql)

	SELECT @SID = RCOUNT FROM ##RET

	DROP TABLE ##RET

END


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_THEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_THEME]
	@IdUser int = NULL
AS
BEGIN
	
	IF(@IdUser IS NOT NULL)
	BEGIN
		SELECT CatTheme.IDTheme, CatTheme.IDThemeParent, CatTheme.Urn, dbo.DOMAIN.ID_USER
		FROM CatTheme INNER JOIN dbo.DOMAIN ON CatTheme.IDTheme = dbo.DOMAIN.IDTheme
		WHERE (dbo.DOMAIN.ID_USER = @IdUser)
	
	END
	ELSE
		SELECT CatTheme.IDTheme, CatTheme.IDThemeParent, CatTheme.Urn FROM dbo.CatTheme
	
END



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_THEME_URN]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_THEME_URN]
	@IDTheme int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM dbo.CatTheme WHERE dbo.CatTheme.IDTheme=@IDTheme
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_TIME_PERIOD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_TIME_PERIOD]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DimTIME_PERIOD.IDMember as ID , DimTIME_PERIOD.Code as CODE FROM DimTIME_PERIOD
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_TRANSCODETIME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_TRANSCODETIME]
	@IDSchema int,
	@TransChar char OUT,
	@TransValue int OUT
AS
BEGIN
	

	SELECT @TransChar=[dbo].[CAT_MAPPING].[TRANSCODE_CHAR],@TransValue=[dbo].[CAT_MAPPING].[TRANSCODE_VALUE] FROM [dbo].[CAT_MAPPING] WHERE [dbo].[CAT_MAPPING].[ID_SCHEMA]=@IDSchema


END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GET_USERS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GET_USERS]

AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM [dbo].[USER]
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_GetCodeCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_GetCodeCount]
@MemberTable varchar(255),
@Code varchar(255),
@COUNT INT OUT 

AS
BEGIN

DECLARE @Sql NVARCHAR(max)
SET @Sql=N''SELECT COUNT(*) RCOUNT INTO ##RET FROM dbo.Dim''+@MemberTable+'' WHERE [Code] = ''+''''''''+@Code+''''''''

EXECUTE (@Sql)

SELECT @COUNT = RCOUNT FROM ##RET

DROP TABLE ##RET

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_ATTRIBUTE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[proc_INSERT_ATTRIBUTE]
(
	@IDName varchar(50),
	@IDSet int,
	@AttCode varchar(50),
	@MemberTable varchar(50),
	@IsMandatory bit=0,
	@IsCodelist bit
)
AS

SET @AttCode = UPPER(LTRIM(RTRIM(@AttCode)))


DECLARE @DatasetCode varchar(255)
SET @DatasetCode = (SELECT Code FROM CatSet WHERE IDSet = @IDSet)

IF EXISTS(SELECT 1 FROM CatAtt WHERE IDSet = @IDSet AND Code = @AttCode)
BEGIN
	RAISERROR (''A dimension with the code "%s" has already been specified for dataset "%s"'', 16,1, @AttCode, @DatasetCode)
	RETURN -1
END
IF EXISTS(SELECT 1 FROM CatAtt WHERE IDSet = @IDSet AND UPPER(IDName) = UPPER(@IDName))
BEGIN
	RAISERROR (''A dimension with the id name "%s" has already been specified for dataset "%s"'', 16,1, @IDName, @DatasetCode)
	RETURN -1
END


DECLARE	@IDAtt int
EXEC	@IDAtt = [dbo].[GetNewID] 
		@tableName=''[dbo].[CatAtt]'',
		@tableIDColumn=''IDAtt'' 
		
DECLARE @FinalMemberTable varchar(50)
SET @FinalMemberTable = ''Att'' + @MemberTable


-- Get time now
DECLARE @TimeStamp datetime 
SET @TimeStamp = GetDate()

BEGIN TRANSACTION

INSERT INTO CatAtt (IDAtt, IDSet, IDName, Code, MemberTable, TimeStamp, IsMandatory, IsCodelist)
VALUES (@IDAtt,@IDSet,@IDName,@AttCode,@FinalMemberTable,@TimeStamp,@IsMandatory,@IsCodelist)

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

SELECT @IDAtt AS IDAtt

COMMIT TRANSACTION

RETURN @IDAtt

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_CODE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_CODE]
	@CodeType varchar(3),
	@MemberTable varchar(50),
	@Code varchar(50),
	@BaseCode varchar(50),
	@Order varchar(50)
AS
DECLARE @errmessage varchar(255)
SELECT @errmessage = ''[proc_AddCode] failed. ''
-- Get time now
DECLARE @TimeStamp datetime 
SET @TimeStamp = GetDate()
DECLARE @sTimeStamp varchar(20)
DECLARE @smalldatetime smalldatetime = @TimeStamp
SET @sTimeStamp = cast(@smalldatetime as varchar(20))


DECLARE @str_MemberTable varchar(50)
SET @str_MemberTable=@CodeType+@MemberTable

-- Validate Code value
SET @Code = UPPER(LTRIM(RTRIM(REPLACE(@Code COLLATE Latin1_General_BIN,'''''''', '''''''''''' ))))
DECLARE @COUNT INT = 0
EXEC proc_COUNT_CODE @str_MemberTable,@Code,''Code'', @COUNT OUT

DECLARE @Sql varchar(max)

IF @COUNT>0
BEGIN
	SET @errmessage = @errmessage + ''Code Alrealy exsist.''
	RAISERROR (@errmessage,16,1) 
	RETURN -2
	--SET @Sql=N''DELETE FROM localised.''+@str_MemberTable+'' WHERE IDMember IN SELECT IDDim FROM dbo.''+@str_MemberTable+'' WHERE Code=''''''+@Code+''''''''
	--EXEC (@Sql)

	--SET @Sql=N''DELETE FROM dbo.''+@str_MemberTable+'' WHERE Code=''''''+@Code+''''''''
	--EXEC (@Sql)
	
END

BEGIN TRANSACTION

SET @Sql=''INSERT INTO dbo.''+@str_MemberTable+'' (Code,BaseCode,[Order],TimeStamp)
VALUES(
''''''+@Code+'''''',
''''''+@BaseCode+'''''',
''+@Order+'',
''''''+@sTimeStamp+'''''')''
EXEC (@Sql)

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END


SELECT IDENT_CURRENT (''dbo.''+@CodeType+@MemberTable) as IDMember;


COMMIT TRANSACTION

RETURN 0

-------------------------------------------------------------------------------------
ERROR_HANDLING:
ROLLBACK TRANSACTION
RAISERROR (@errmessage,16,1)
RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_FACTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_INSERT_DATA_FACTS]
	@IDSet int,
	@SID int,
	@IDTime int,
	@Value decimal(38,5) = NULL,
	@Sql_part_h varchar(max)='''',
	@Sql_part_d varchar(max)=''''
AS

BEGIN TRANSACTION

DECLARE @strIDSet varchar(10)
SET @strIDSet = CAST(@IDSet as varchar(10))

DECLARE @strSID varchar(10)
SET @strSID = CAST(@SID as varchar(10))

DECLARE @strIDTime varchar(10)
SET @strIDTime = CAST(@IDTime as varchar(10))

DECLARE @strValue varchar(100)
SET @strValue =''null''
IF(@Value IS NOT NULL)
	SET @strValue = CAST(@Value as varchar(100))

DECLARE @_Sql_part_h  varchar(max)
SET @_Sql_part_h=LTRIM(RTRIM(@Sql_part_h))

DECLARE @_Sql_part_d  varchar(max)
SET @_Sql_part_d=LTRIM(RTRIM(@Sql_part_d))

DECLARE @Sql varchar(max)
DECLARE @COUNT int

DECLARE @TypeResult int 
SET @TypeResult=0

-- Check if exist record
/*
SET @Sql=N''SELECT COUNT(*) RCOUNT INTO ##RET FROM dbo.FactS''+@strIDSet+'' WHERE  SID=''+@strSID+'' AND IDTIME=''+@strIDTime
EXECUTE (@Sql)
SELECT @COUNT = RCOUNT FROM ##RET
DROP TABLE ##RET
IF @COUNT>0 -- record exist
BEGIN
	SET @TypeResult=2
	GOTO DELETE_INSERT
END
*/
DELETE_INSERT:
-- delete previus value
EXEC proc_DELETE_DATA_FACTS @IDSet,@SID,@IDTime
-- insert new value

SET @Sql=''INSERT INTO dbo.FACTS''+@strIDSet+'' (SID,IDTIME,Value,Flags,LastUpdated''

IF(@_Sql_part_h<>'''') SET @Sql=@Sql+'',''+@_Sql_part_h
SET @Sql=@Sql+'') VALUES (''+@strSID+'',''+@strIDTime+'',''+@strValue
SET @Sql=@Sql+'',0,''''''+convert(varchar, GetDate(), 0 )+''''''''
IF(@_Sql_part_d<>'''')
	SET @Sql=@Sql+'',''+@_Sql_part_d+'')''
ELSE
	SET @Sql=@Sql+'')''


EXECUTE (@Sql)

IF(@@ERROR<>0) GOTO ERROR_HANDLING

COMMIT TRANSACTION
-- return success
SELECT @TypeResult as Result
RETURN @TypeResult
-------------------------------------------------------------------------------------
ERROR_HANDLING:
ROLLBACK TRANSACTION
-- return error
SELECT -1 as Result
RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_FILTS]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_DATA_FILTS]
	@IDSet int,
	@Sql_part_h varchar(max),
	@Sql_part_d varchar(max),
	@Sql_part_w varchar(max)
AS


BEGIN TRANSACTION

DECLARE @SID INT = NULL
EXEC proc_GET_SID_FILTS @IDSet,@Sql_part_w,@SID OUT

IF(@SID IS NOT NULL)
	GOTO RETURN_VALUE

	
DECLARE @strIDSet varchar(10)
SET @strIDSet = CAST(@IDSet as varchar(10))
DECLARE @Sql varchar(max)
SET @Sql=''INSERT INTO dbo.FILTS''+@strIDSet+'' (''+@Sql_part_h+'') VALUES (''+@Sql_part_d+'')''

EXEC (@Sql)

IF(@@ERROR<>0) 
	GOTO ERROR_HANDLING

SET @SID=IDENT_CURRENT (''dbo.FILTS''+@strIDSet);

RETURN_VALUE:

COMMIT TRANSACTION

SELECT @SID as SID

RETURN 0
-------------------------------------------------------------------------------------

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATA_MAPPING]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_DATA_MAPPING]
	@IDSchema int,
	@IDColumn int,
	@NameColumn  varchar(255),
	@Name varchar(255)
AS
BEGIN
INSERT INTO [dbo].[DATA_MAPPING]
           ([ID_SCHEMA]
           ,[ID_COLUMN]
		   ,[NAME_COLUMN]
           ,[NAME])
     VALUES
           (@IDSchema,
		   @IDColumn,
		   @NameColumn,
		   @Name)
END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DATAFLOW]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_DATAFLOW]
	@IDSet int,
	@IDFlow int,
	@AgencyID varchar(255),
	@ID varchar(255),
	@Version varchar(255)
AS
DECLARE @errmessage varchar(255)
SELECT @errmessage = ''[[proc_INSERT_DATAFLOW]] failed. ''

BEGIN TRANSACTION

INSERT INTO dbo.CatDataFlow (IDDataFlow,IDSet,AgencyID,ID,Version) VALUES(@IDFlow,@IDSet,@AgencyID,@ID,@Version)

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END


SELECT IDENT_CURRENT (''dbo.CatDataFlow '') as IDDataFlow;


COMMIT TRANSACTION

RETURN 0

-------------------------------------------------------------------------------------
ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DIMENSION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE Procedure [dbo].[proc_INSERT_DIMENSION]
(
	@IDName varchar(50),
	@IDSet int,
	@DimCode varchar(50),
	@MemberTable varchar(50),
	@IsTimeSeriesDim bit
)
AS
DECLARE @errmessage varchar(255)
SELECT @errmessage = ''[proc_INSERT_DIMENSION] failed.''


DECLARE @DatasetCode varchar(255)
SET @DatasetCode = (SELECT Code FROM CatSet WHERE IDSet = @IDSet)

SET @DimCode = UPPER(LTRIM(RTRIM(@DimCode)))
IF EXISTS(SELECT 1 FROM CATDIM WHERE IDSet = @IDSet AND Code = @DimCode)
BEGIN
	SET @errmessage = @errmessage +'' A dimension with the code "%s" has already been specified for dataset "%s"''
	RAISERROR (@errmessage , 16,1, @DimCode, @DatasetCode)
	RETURN -1
END
IF EXISTS(SELECT 1 FROM CATDIM WHERE IDSet = @IDSet AND UPPER(IDName) = UPPER(@IDName))
BEGIN
	RAISERROR (''A dimension with the id name "%s" has already been specified for dataset "%s"'', 16,1, @IDName, @DatasetCode)
	RETURN -1
END

-- Get time now
DECLARE @TimeStamp datetime 
SET @TimeStamp = GetDate()

DECLARE	@IDDim int
EXEC	@IDDim = [dbo].[GetNewID] 
		@tableName=''[dbo].[CatDim]'',
		@tableIDColumn=''IDDim'' 

DECLARE @FinalMemberTable varchar(50)
SET @FinalMemberTable = ''Dim'' + @MemberTable

BEGIN TRANSACTION

INSERT INTO CatDim (IDDim, IDName, IDSet, Code, MemberTable, TimeStamp, IsTimeSeriesDim)
VALUES (@IDDim,@IDName,@IDSet,@DimCode,@FinalMemberTable,@TimeStamp,@IsTimeSeriesDim)


IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

SELECT @IDDim AS IDDim

COMMIT TRANSACTION

RETURN @IDDim

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DOMAIN_SET]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_DOMAIN_SET]
	@id_user int,
	@id_set int
AS
BEGIN
	INSERT INTO [dbo].[DOMAIN] (ID_USER,IDSet) VALUES(@id_user,@id_set)
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_DOMAIN_THEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_DOMAIN_THEME]
	@id_user int,
	@id_theme int
AS
BEGIN
	INSERT INTO [dbo].[DOMAIN] (ID_USER,IDTheme) VALUES(@id_user,@id_theme)
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_LOAD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[proc_INSERT_LOAD]
	@IDSet int,
	@MIN_TIME varchar(10),
	@MAX_TIME varchar(10),
	@RECORD_COUNT int,
	@FILENAME varchar(255)=null
AS
BEGIN

	INSERT INTO CatLoad(IDSet,MIN_TIME,MAX_TIME,RecorderCount,[Filename],[Timestamp])
	VALUES(@IDSet,@MIN_TIME,@MAX_TIME,@RECORD_COUNT,@FILENAME,GetDate())

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_MAPPING]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_MAPPING]
	@IDSet int,
	@IDUser int,
	@Name varchar(max),
	@Description varchar(max)='''',
	@file_csv_char varchar(1)='';'',
	@file_csv_hasheader bit=1,
	@transcode_use bit=1,
	@transcode_char varchar(50)=NULL,
	@transcode_value int=NULL
AS
BEGIN

DECLARE @IDSchema int

IF EXISTS(SELECT TOP 1 ID_SET FROM dbo.CAT_MAPPING WHERE NAME=@name)
BEGIN
	RETURN -1
END

BEGIN TRANSACTION

INSERT INTO dbo.CAT_MAPPING (ID_USER, ID_SET, NAME,[DESCRIPTION],TIMESTAMP,[FILE_CSV_CHAR],[FILE_CSV_HASHEADER],[TRANSCODE_USE],[TRANSCODE_CHAR],[TRANSCODE_VALUE])
VALUES (@IDUser,@IDSet,@Name,@Description,convert(varchar, GetDate(), 0 ),@file_csv_char,@file_csv_hasheader,@transcode_use,@transcode_char,@transcode_value)


SELECT SCOPE_IDENTITY() AS ID_SCHEME;
COMMIT TRANSACTION



END






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_THEME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_THEME]
	@Urn varchar(max),
	@IDTheme int OUT
AS

BEGIN TRANSACTION

INSERT INTO CatTheme (Urn) VALUES(@Urn)

IF @@ERROR <> 0
BEGIN
	GOTO ERROR_HANDLING
END

SELECT @IDTheme=SCOPE_IDENTITY();

COMMIT TRANSACTION

RETURN @IDTheme


ERROR_HANDLING:
ROLLBACK TRANSACTION
RETURN -1

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_INSERT_USER]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_INSERT_USER]
	@username varchar(255),
	@password varchar(255),
	@id_role int,
	@name varchar(255),
	@surname varchar(255),
	@email varchar(255),
	@proflag bit =0

AS
BEGIN
	
	BEGIN TRANSACTION

	INSERT INTO [dbo].[USER](USERNAME,PWD,ID_ROLE,NAME,SURNAME,EMAIL,PROFLAG) 
	VALUES (
	RTRIM(LTRIM(@username)),
	RTRIM(LTRIM(@password)),
	@id_role,
	RTRIM(LTRIM(@name)),
	RTRIM(LTRIM(@surname)),
	RTRIM(LTRIM(@email)),
	@proflag)
	

	DECLARE @IDUser int
	
	SET @IDUser=IDENT_CURRENT (''dbo.User'');

	RETURN_VALUE:

	COMMIT TRANSACTION

	SELECT @IDUser as USERID

	RETURN @IDUser

END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_ATT_ATTACH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_SET_ATT_ATTACH]
	@IDAtt int,
	@IDDim int
AS
BEGIN
	
	IF NOT EXISTS (SELECT 1 FROM dbo.CatAttDim WHERE IDAtt=@IDAtt AND IDDim=@IDDim)

	INSERT INTO dbo.CatAttDim (IDAtt,IDDim) VALUES (@IDAtt,@IDDim)

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_LOCATION]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_SET_LOCATION]
	@IDMember int,
	@MemberTable varchar(50),
	@TwoLetterISO varchar(2) = "en",
	@Value varchar(max)
AS
BEGIN

	DECLARE @str_IDMember varchar(10)
	DECLARE @Sql nvarchar(max)
	
	SET @str_IDMember=CAST(@IDMember as varchar(10))
	SET @Value = LTRIM(RTRIM(REPLACE(@Value COLLATE Latin1_General_BIN,'''''''', '''''''''''' )))

	BEGIN TRANSACTION
	
	IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N''[dbo].[''+@MemberTable+'']'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
	BEGIN
		GOTO ERROR_HANDLING
	END

	DECLARE @COUNT INT = 0
	EXEC proc_COUNT_LOCATION 
		@MemberTable,
		@str_IDMember,
		@TwoLetterISO,
		@Value,
		@COUNT OUT
	IF @COUNT > 0
	BEGIN
		GOTO SOLVED_SELF
	END

	SET @Sql=N''INSERT INTO localised_''+@MemberTable+'' (IDMember,TwoLetterIso,Value) VALUES(''+@str_IDMember+'',''''''+@TwoLetterISO+'''''',''''''+@Value+'''''')''
	
	EXEC(@Sql)

	IF @@ERROR <> 0
	BEGIN
		GOTO ERROR_HANDLING
	END
	
	COMMIT TRANSACTION

	RETURN 0

END

SOLVED_SELF:
ROLLBACK TRANSACTION
RETURN -2

ERROR_HANDLING:
ROLLBACK TRANSACTION

RETURN -1







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SET_TRANSCODETIME]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_SET_TRANSCODETIME]
	@IDSchema int,
	@TransChar char,
	@TransValue int
AS
BEGIN
	
UPDATE dbo.CAT_MAPPING
SET TRANSCODE_VALUE = @TransValue, TRANSCODE_CHAR = @TransChar
WHERE (ID_SCHEMA = @IDSchema)

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_TRY_LOGIN]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_TRY_LOGIN]
	@username nchar(255),
	@password nchar(255)
AS
BEGIN
	
SELECT        
dbo.[USER].ID_USER,
dbo.ROLE.ID_ROLE, 
dbo.ROLE.DESC_ROLE, 
dbo.[USER].NAME, 
dbo.[USER].SURNAME, 
dbo.[USER].EMAIL,
dbo.[USER].PROFLAG
FROM dbo.[USER] INNER JOIN dbo.ROLE ON dbo.[USER].ID_ROLE = dbo.ROLE.ID_ROLE
WHERE (dbo.[USER].PWD = @password) AND (dbo.[USER].USERNAME = @username)

END







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_UPDATE_USER]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[proc_UPDATE_USER]
	@id_user int,
	@username varchar(255)=null,
	@password varchar(255)=null,
	@id_role int=null,
	@name varchar(255)=null,
	@surname varchar(255)=null,
	@email varchar(255)=null,
	@proflag bit =null

AS
BEGIN

	DECLARE @SQL varchar(max) = '''';
	DECLARE @SQLSeparator varchar(1) = '' '';
	 
	SET @SQL=''UPDATE dbo.[USER] SET'';

	IF(@username IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''USERNAME = ''''''+RTRIM(LTRIM(@username))+''''''''
		SET @SQLSeparator='','';
	END
	IF(@password IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''PWD = ''''''+RTRIM(LTRIM(@password))+''''''''
		SET @SQLSeparator='','';
	END
	IF(@id_role IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''ID_ROLE = ''+RTRIM(LTRIM(@id_role))
		SET @SQLSeparator='','';
	END
	IF(@name IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''NAME = ''''''+RTRIM(LTRIM(@name))+''''''''
		SET @SQLSeparator='','';
	END
	IF(@surname IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''SURNAME = ''''''+RTRIM(LTRIM(@surname))+''''''''
		SET @SQLSeparator='','';
	END
	IF(@email IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''EMAIL = ''''''+RTRIM(LTRIM(@email))+''''''''
		SET @SQLSeparator='','';
	END
	IF(@proflag IS NOT NULL)
	BEGIN
		SET @SQL+=@SQLSeparator+''PROFLAG = ''+RTRIM(LTRIM(@proflag))
		SET @SQLSeparator='','';
	END


	SET @SQL+='' WHERE ID_USER=''+RTRIM(LTRIM(@id_user));

	EXEC (@SQL)

END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[prod_INSERT_LOAD]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[prod_INSERT_LOAD]
	@IDSet int,
	@MIN_TIME varchar(10),
	@MAX_TIME varchar(10),
	@RECORD_COUNT int,
	@FILENAME varchar(255)=null
AS
BEGIN

	INSERT INTO CatLoad(IDSet,MIN_TIME,MAX_TIME,RecorderCount)
	VALUES(@IDSet,@MIN_TIME,@MAX_TIME,@RECORD_COUNT)

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AttributeMain]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*

begin tran
EXEC sp_TranscodingAttributeValues 2;

select *
from temp_attribute



select *
from temp_attribute_transcoded

select *
from temp_attribute_SCARTED

drop table temp_attribute

select *
from ##att_observation

select *
from facts4

exec sp_AttributeMain 2

select *
from facts4

select *
from ##ATT_FILT

rollback tran

EXEC sp_FiltTableUpdate 2

EXEC sp_TranscodingAttributeValues 1;
EXEC sp_CreateTemporaryTables;
EXEC sp_FiltTableUpdate 1;
EXEC sp_FactTableUpdate 1;

*/
CREATE PROC [dbo].[sp_AttributeMain]

@IDSet INT

AS

SET NOCOUNT ON


EXEC sp_TranscodingAttributeValues @IDSet;
EXEC sp_CreateTemporaryTables;
EXEC sp_RemoveInvalidRecords @IDSet;
EXEC sp_FiltTableUpdate @IDSet;
EXEC sp_FactTableUpdate @IDSet;
EXEC sp_DeTranscodingAttributeValues @IDSet;





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CreateTemporaryTables]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_CreateTemporaryTables]

AS

IF OBJECT_ID(''tempdb.dbo.##ATT_DATASET'', ''U'') IS NOT NULL
  DROP TABLE ##ATT_DATASET;

IF OBJECT_ID(''tempdb.dbo.##ATT_OBSERVATION'', ''U'') IS NOT NULL
  DROP TABLE ##ATT_OBSERVATION;

IF OBJECT_ID(''tempdb.dbo.##ATT_FILT'', ''U'') IS NOT NULL
  DROP TABLE ##ATT_FILT;


DECLARE @POPOLATETBLDATASET VARCHAR(8000) = ''''
DECLARE @POPOLATETBLOBSERVATION VARCHAR(8000) = ''''
DECLARE @DELETEDATASETRECORD VARCHAR(8000) = ''''
DECLARE @DELETEOBSERVATIONRECORD VARCHAR(8000) = ''''
DECLARE @WHEREDATASET VARCHAR(4000) = ''''
DECLARE @WHEREOBSERVATION VARCHAR(4000) = ''''
DECLARE @COLNAME VARCHAR(500) = ''''

DECLARE attNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = ''Temp_Attribute_Transcoded''
	AND SUBSTRING(COLUMN_NAME,1,2) = ''D_''

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @WHEREDATASET = @WHEREDATASET +'' AND ''+ @COLNAME +'' IS NULL ''
	SET @WHEREOBSERVATION = @WHEREOBSERVATION +'' AND ''+ @COLNAME +'' IS NOT NULL ''

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;

SET @POPOLATETBLDATASET = ''SELECT * '' +
							''INTO ##ATT_DATASET '' +
							''FROM Temp_Attribute_Transcoded '' +
							''WHERE 1=1 '' +
							@WHEREDATASET

SET @DELETEDATASETRECORD = ''DELETE Temp_Attribute_Transcoded '' +
							''FROM Temp_Attribute_Transcoded '' +
							''WHERE 1=1 '' +
							@WHEREDATASET

SET @POPOLATETBLOBSERVATION = ''SELECT * '' +
							''INTO ##ATT_OBSERVATION '' +
							''FROM Temp_Attribute_Transcoded '' +
							''WHERE 1=1 '' +
							@WHEREOBSERVATION

SET @DELETEOBSERVATIONRECORD = ''DELETE Temp_Attribute_Transcoded '' +
								''FROM Temp_Attribute_Transcoded '' +
								''WHERE 1=1 '' +
								@WHEREOBSERVATION

EXEC(@POPOLATETBLDATASET)
EXEC(@DELETEDATASETRECORD)
EXEC(@POPOLATETBLOBSERVATION)
EXEC(@DELETEOBSERVATIONRECORD)

SELECT *
INTO ##ATT_FILT
FROM Temp_Attribute_Transcoded
 ' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DeTranscodingAttributeValues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/*
SELECT *
FROM Temp_Attribute

SELECT *
FROM Temp_Attribute_Transcoded

begin tran 

SELECT *
FROM Temp_Attribute_Scarted

exec sp_DeTranscodingAttributeValues 1 

SELECT *
FROM Temp_Attribute_Scarted

rollback tran

select A_DECIMALS, Code 
FROM Temp_Attribute_Scarted A
 	INNER JOIN AttDECI_IT1_10 B ON
	 		cast(A.A_DECIMALS as varchar(500)) = cast(B.IDMember as varchar(500))
WHERE A.A_DECIMALS IS NOT NULL

begin tran 
UPDATE Temp_Attribute_Scarted 
SET D_TIPO_INDDEM= Code 
FROM Temp_Attribute_Scarted A
 	INNER JOIN DimINDICATORI_POP_IT1_13 B ON
	 		cast(A.D_TIPO_INDDEM as varchar(500)) = cast(B.IDMember as varchar(500)) 
WHERE A.D_TIPO_INDDEM IS NOT NULL

rollback tran

*/
-- sp_TranscodingAttributeValues 2
CREATE PROCEDURE [dbo].[sp_DeTranscodingAttributeValues]

@IDSET INT

AS	


DECLARE @COLNAME VARCHAR(500) = ''''
DECLARE @SQLUPDATE VARCHAR(2000) 
DECLARE @TABLENAME VARCHAR(500) = ''''

DECLARE attNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = ''Temp_Attribute_Transcoded''

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQLUPDATE = ''''
	SET @TABLENAME = ''''

	IF(SUBSTRING(@COLNAME,1,1) = ''D'')
	BEGIN
		SELECT @TABLENAME = MemberTable
		FROM CatDim
		WHERE IDSet = @IDSET
			AND code = SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2)
	END
	ELSE IF(SUBSTRING(@COLNAME,1,1) = ''A'')	
	BEGIN
		SELECT @TABLENAME = MemberTable
		FROM CatAtt
		WHERE IDSet = @IDSET
			AND code = SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2)
	END

	IF (@TABLENAME <> '''')
	BEGIN

		SET @SQLUPDATE = ''UPDATE Temp_Attribute_Scarted '' +
				''SET ''+ @COLNAME +''= Code '' +
				''FROM Temp_Attribute_Scarted A '' +
				''	INNER JOIN ''+ @TABLENAME +'' B ON '' +
				''		CAST(A.''+ @COLNAME +'' AS VARCHAR(500)) = CAST(B.IDMember AS VARCHAR(500)) '' +
				''WHERE A.''+ @COLNAME +'' IS NOT NULL''
		PRINT @SQLUPDATE
		EXEC(@SQLUPDATE)
	END	

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;








				' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FactTableUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* 
sp_FactTableUpdate 4

*/
CREATE PROCEDURE [dbo].[sp_FactTableUpdate]

@IDSET INT

AS

DECLARE @VIDSET VARCHAR(10)
DECLARE @COLNAME VARCHAR(500)
DECLARE @SQLCOMMAND VARCHAR(8000)
DECLARE @UPDATECOLUMNSNAME VARCHAR(8000) = ''''
DECLARE @JOINCOLUMNSNAME VARCHAR(8000) = ''''

SET @VIDSET=CAST(@IDSET AS VARCHAR(10))

----
DECLARE attNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS a
	INNER JOIN CatAtt b ON
		a.COLUMN_NAME = b.IDName
WHERE TABLE_NAME = ''FactS''+ @VIDSET
	AND IDSet = @IDSET

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @UPDATECOLUMNSNAME = @UPDATECOLUMNSNAME + @COLNAME + ''=''+ ''A_''+ SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2) + '',''

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;

DECLARE joinNameCursor CURSOR FOR 

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS a
	LEFT OUTER JOIN CatAtt b ON
		a.COLUMN_NAME = b.IDName
		AND IDSet = @IDSET
WHERE TABLE_NAME = ''FiltS''+ @VIDSET
	AND b.IDName IS NULL
	AND COLUMN_NAME <> ''SID''

OPEN joinNameCursor

FETCH NEXT FROM joinNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @JOINCOLUMNSNAME = @JOINCOLUMNSNAME + '' AND A.''+ @COLNAME + ''=''+ ''C.D_''+ SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2) 

	FETCH NEXT FROM joinNameCursor 
	INTO @COLNAME
END 
CLOSE joinNameCursor;
DEALLOCATE joinNameCursor;

IF ( ISNULL(@UPDATECOLUMNSNAME,'''') = '''')
	RETURN

SET @SQLCOMMAND = ''
	UPDATE FactS''+ @VIDSET +''
	SET ''+ SUBSTRING(@UPDATECOLUMNSNAME,1,LEN(@UPDATECOLUMNSNAME)-1) +''
	FROM dbo.FiltS'' + @VIDSET +'' A
		INNER JOIN dbo.FactS'' + @VIDSET +'' B ON
			A.SID = B.SID
		INNER JOIN ##ATT_OBSERVATION C ON
			B.IDTIME = C.D_TIME_PERIOD
			''+ @JOINCOLUMNSNAME +'';''

EXEC(@SQLCOMMAND)



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FiltTableUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

sp_FiltTableUpdate 1
*/
CREATE PROC [dbo].[sp_FiltTableUpdate]

@IDSet INT

AS

DECLARE @SQLDECLARE VARCHAR(8000)
DECLARE @SQLCOLUMNSNAME VARCHAR(8000)
DECLARE @SQLINTO VARCHAR(8000)
DECLARE @SQLDIMUPDATE VARCHAR(8000)
DECLARE @SQLDATASETUPDATE VARCHAR(8000)

EXEC sp_GetSQLFiltTableUpdate @IDSet,@SQLDECLARE OUT,@SQLCOLUMNSNAME OUT,@SQLINTO OUT, @SQLDIMUPDATE OUT, @SQLDATASETUPDATE OUT 


DECLARE @SELECTDIM VARCHAR(8000)
DECLARE @SELECTDATASET VARCHAR(8000)
SET @SELECTDIM = ''SELECT ''+ @SQLCOLUMNSNAME + '' FROM ##ATT_FILT''
SET @SELECTDATASET = ''SELECT ''+ @SQLCOLUMNSNAME + '' FROM ##ATT_DATASET''

/*
SELECT *
FROM ##ATT_DATASET

SELECT *
FROM ##ATT_OBSERVATION

SELECT *
FROM ##ATT_FILT

PRINT @SQLDECLARE 
PRINT @SQLCOLUMNSNAME
PRINT @SQLINTO
PRINT @SQLDIMUPDATE
PRINT @SQLDATASETUPDATE

*/

IF(@SQLDIMUPDATE <>'''')
	EXEC(
		@SQLDECLARE +
		''DECLARE cCursor CURSOR FOR '' +
		@SELECTDIM + '' 
		OPEN cCursor 
		FETCH NEXT FROM cCursor '' +
		''INTO ''+ @SQLINTO + ''
		WHILE @@FETCH_STATUS = 0
		BEGIN '' +
			@SQLDIMUPDATE +''

			FETCH NEXT FROM cCursor 
			INTO ''+ @SQLINTO + ''
		END 
		CLOSE cCursor;
		DEALLOCATE cCursor;''
		)

IF(@SQLDATASETUPDATE <>'''')
	EXEC(
		@SQLDECLARE +
		''DECLARE cCursor CURSOR FOR '' +
		@SELECTDATASET + '' 
		OPEN cCursor 
		FETCH NEXT FROM cCursor '' +
		''INTO ''+ @SQLINTO + ''
		WHILE @@FETCH_STATUS = 0
		BEGIN '' +
			@SQLDATASETUPDATE +''

			FETCH NEXT FROM cCursor 
			INTO ''+ @SQLINTO + ''
		END 
		CLOSE cCursor;
		DEALLOCATE cCursor;''
		)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetSQLFiltTableUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/* 
declare @sqlRet varchar(8000)
exec sp_GetSQLFiltTableUpdate 4,@sqlRet out
print @sqlRet

*/
CREATE PROCEDURE [dbo].[sp_GetSQLFiltTableUpdate]

@IDSET INT,
@SQLDECLARE VARCHAR(8000) OUT,
@SQLCOLUMNSNAME VARCHAR(8000) OUT,
@SQLINTO VARCHAR(8000) OUT,
@SQLDIMUPDATE VARCHAR(8000) OUT,
@SQLDATASETUPDATE VARCHAR(8000) OUT

AS

DECLARE @VIDSET VARCHAR(10)
DECLARE @COLNAME VARCHAR(500)
DECLARE @DIMNAME VARCHAR(500)
DECLARE @ATTRIBUTENAMECOLLECTION VARCHAR(4000) = ''''
DECLARE @DIMENSIONNAMECOLLECTION VARCHAR(4000) = ''''
DECLARE @DECLARENAMECOLLECTION VARCHAR(8000) = ''''

SET @VIDSET=CAST(@IDSET AS VARCHAR(10))
SET @SQLCOLUMNSNAME = '''';
SET @SQLINTO = '''';

DECLARE attNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS a
	INNER JOIN CatAtt b ON
		a.COLUMN_NAME = b.IDName
WHERE TABLE_NAME = ''FiltS''+ @VIDSET
	AND IDSet = @IDSET

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ATTRIBUTENAMECOLLECTION = @ATTRIBUTENAMECOLLECTION + @COLNAME + ''=''+ ''@''+ @COLNAME +'', ''
	SET @DECLARENAMECOLLECTION = @DECLARENAMECOLLECTION + ''DECLARE @''+ @COLNAME + '' AS INT; ''
	SET @SQLCOLUMNSNAME = @SQLCOLUMNSNAME + ''A_''+ SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2) + '',''
	SET @SQLINTO = @SQLINTO +''@''+ @COLNAME + '',''

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;


DECLARE dimNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS a
	LEFT OUTER JOIN CatAtt b ON
		a.COLUMN_NAME = b.IDName
		AND IDSet = @IDSET
WHERE TABLE_NAME = ''FiltS''+ @VIDSET
	AND b.IDName IS NULL

OPEN dimNameCursor

FETCH NEXT FROM dimNameCursor 
INTO @DIMNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@DIMNAME <> ''SID'')
	BEGIN
		SET @DIMENSIONNAMECOLLECTION = @DIMENSIONNAMECOLLECTION + 
			''(''+ @DIMNAME +''='' + ''@''+ @DIMNAME +'' OR @''+ @DIMNAME +'' IS NULL) AND ''
		SET @DECLARENAMECOLLECTION = @DECLARENAMECOLLECTION + ''DECLARE @''+ @DIMNAME + '' AS INT; ''
		SET @SQLCOLUMNSNAME = @SQLCOLUMNSNAME + ''D_''+ SUBSTRING(@DIMNAME,3,LEN(@DIMNAME)-2) + '',''
		SET @SQLINTO = @SQLINTO +''@''+ @DIMNAME + '',''


	END
	FETCH NEXT FROM dimNameCursor 
	INTO @DIMNAME
END 
CLOSE dimNameCursor;
DEALLOCATE dimNameCursor;

SET @SQLDECLARE = @DECLARENAMECOLLECTION;

IF @ATTRIBUTENAMECOLLECTION <> ''''
SET @SQLDATASETUPDATE = ''UPDATE FiltS''+ @VIDSET + 
	'' SET ''+ SUBSTRING(@ATTRIBUTENAMECOLLECTION,1,LEN(@ATTRIBUTENAMECOLLECTION) -1) 

IF @DIMENSIONNAMECOLLECTION <> ''''
SET @SQLDIMUPDATE = @SQLDATASETUPDATE +
	'' WHERE ''+ SUBSTRING(@DIMENSIONNAMECOLLECTION,1,LEN(@DIMENSIONNAMECOLLECTION) -4) +'';''

SET @SQLCOLUMNSNAME = SUBSTRING(@SQLCOLUMNSNAME,1,LEN(@SQLCOLUMNSNAME)-1) 

SET @SQLINTO = SUBSTRING(@SQLINTO,1,LEN(@SQLINTO)-1) 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_RemoveInvalidRecords]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

EXEC sp_RemoveInvalidRecords 2

*/
CREATE PROCEDURE [dbo].[sp_RemoveInvalidRecords]

@IDSET INT

AS	

DECLARE @COLNAME VARCHAR(500) = ''''
DECLARE @ATTACHLEVEL VARCHAR(20) = ''''

DECLARE @SQLINSERTFROMDATASET VARCHAR(2000) 
DECLARE @SQLINSERTFROMFILT VARCHAR(2000) 
DECLARE @SQLINSERTFROMOBSERVATION VARCHAR(2000) 

DECLARE @SQLDELETEFROMDATASET VARCHAR(2000) 
DECLARE @SQLDELETEFROMFILT VARCHAR(2000) 
DECLARE @SQLDELETEFROMOBSERVATION VARCHAR(2000) 

DECLARE @SQLFILTWHERE VARCHAR(2000) = ''''
DECLARE @SQLOBSERVATIONWHERE VARCHAR(2000) = ''''

DECLARE attNameCursor CURSOR FOR 
SELECT a.Code,
		''AttaChLevel'' = MAX(CASE 
							WHEN c.Code = ''TIME_PERIOD'' THEN 
								''OBS'' 
							WHEN c.Code IS NULL THEN 
								''DATASET''
							ELSE  
								''DIMGROUP''
							END)
FROM CatAtt A 
	LEFT OUTER JOIN dbo.CatAttDim B ON
		a.IDAtt = B.IDAtt
	LEFT OUTER JOIN dbo.CatDim C ON
		b.IDDim = c.IDDim
WHERE A.IDSet = @IDSET
GROUP BY a.Code

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME, @ATTACHLEVEL
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(@ATTACHLEVEL = ''OBS'')
		SET @SQLFILTWHERE = @SQLFILTWHERE + ''OR A_''+ @COLNAME + '' IS NOT NULL ''
	ELSE
		SET @SQLOBSERVATIONWHERE = @SQLOBSERVATIONWHERE + ''OR A_''+ @COLNAME + '' IS NOT NULL ''

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME, @ATTACHLEVEL
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;


IF (@SQLFILTWHERE <> '''')
BEGIN
	SET @SQLFILTWHERE = SUBSTRING(@SQLFILTWHERE,3,LEN(@SQLFILTWHERE)-2)

	SET @SQLINSERTFROMDATASET = ''INSERT INTO Temp_Attribute_Scarted
								 SELECT *,''''ONE OR MORE ATTRIBUTE/S IS TYPED OBSERVATION'''' 
								 FROM ##ATT_DATASET
								 WHERE '' + @SQLFILTWHERE
	SET @SQLINSERTFROMFILT = ''INSERT INTO Temp_Attribute_Scarted
								 SELECT *,''''ONE OR MORE ATTRIBUTE/S IS TYPED OBSERVATION'''' 
								 FROM ##ATT_FILT
								 WHERE '' + @SQLFILTWHERE
	SET @SQLDELETEFROMDATASET = ''DELETE
								 FROM ##ATT_DATASET
								 WHERE '' + @SQLFILTWHERE
	SET @SQLDELETEFROMFILT = ''DELETE
								 FROM ##ATT_FILT
								 WHERE '' + @SQLFILTWHERE

	--PRINT @SQLINSERTFROMDATASET;
	--PRINT @SQLINSERTFROMFILT;

	EXEC(@SQLINSERTFROMDATASET);
	EXEC(@SQLINSERTFROMFILT);
	EXEC(@SQLDELETEFROMDATASET);
	EXEC(@SQLDELETEFROMFILT);

END

IF (@SQLOBSERVATIONWHERE <> '''')
BEGIN
	SET @SQLOBSERVATIONWHERE = SUBSTRING(@SQLOBSERVATIONWHERE,3,LEN(@SQLOBSERVATIONWHERE)-2)

	SET @SQLINSERTFROMOBSERVATION = ''INSERT INTO Temp_Attribute_Scarted
									 SELECT *,''''ONE OR MORE ATTRIBUTE/S IS NOT TYPED OBSERVATION'''' 
									 FROM ##ATT_OBSERVATION
									 WHERE '' + @SQLOBSERVATIONWHERE
	SET @SQLDELETEFROMOBSERVATION = ''DELETE
									 FROM ##ATT_OBSERVATION
									 WHERE '' + @SQLOBSERVATIONWHERE

	EXEC(@SQLINSERTFROMOBSERVATION);
	EXEC(@SQLDELETEFROMOBSERVATION);
	
END







				' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TranscodingAttributeValues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
SELECT *
FROM Temp_Attribute

SELECT *
FROM Temp_Attribute_Transcoded

SELECT *
FROM Temp_Attribute_Scarted

*/
-- sp_TranscodingAttributeValues 2
CREATE PROCEDURE [dbo].[sp_TranscodingAttributeValues]

@IDSET INT

AS	


DECLARE @COLNAME VARCHAR(500) = ''''
DECLARE @SQLUPDATE VARCHAR(2000) 
DECLARE @SQLSCARTED VARCHAR(2000) 
DECLARE @SQLDELETE VARCHAR(2000) 
DECLARE @TABLENAME VARCHAR(500) = ''''

IF OBJECT_ID(''dbo.Temp_Attribute_Transcoded'', ''U'') IS NOT NULL
  DROP TABLE dbo.Temp_Attribute_Transcoded; 

IF OBJECT_ID(''dbo.Temp_Attribute_Scarted'', ''U'') IS NOT NULL
  DROP TABLE dbo.Temp_Attribute_Scarted; 

SELECT * 
INTO Temp_Attribute_Transcoded
FROM Temp_Attribute

SELECT * 
INTO Temp_Attribute_Scarted
FROM Temp_Attribute
WHERE 1 = 2

ALTER TABLE Temp_Attribute_Scarted
ADD REASON VARCHAR(500)

DECLARE attNameCursor CURSOR FOR 
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = ''Temp_Attribute_Transcoded''

OPEN attNameCursor

FETCH NEXT FROM attNameCursor 
INTO @COLNAME
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQLUPDATE = ''''
	SET @TABLENAME = ''''
	SET @SQLSCARTED = ''''

	IF(SUBSTRING(@COLNAME,1,1) = ''D'')
	BEGIN
		SELECT @TABLENAME = MemberTable
		FROM CatDim
		WHERE IDSet = @IDSET
			AND code = SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2)
	END
	ELSE IF(SUBSTRING(@COLNAME,1,1) = ''A'')	
	BEGIN
		SELECT @TABLENAME = MemberTable
		FROM CatAtt
		WHERE IDSet = @IDSET
			AND code = SUBSTRING(@COLNAME,3,LEN(@COLNAME)-2)
	END

	IF (@TABLENAME <> '''')
	BEGIN

		SET @SQLSCARTED = ''INSERT INTO Temp_Attribute_Scarted
			SELECT A.*, ''''''+ @COLNAME +'' NOT TRANSCODED''''
			FROM Temp_Attribute_Transcoded A
 				LEFT OUTER JOIN ''+ @TABLENAME +'' B ON '' +
	 		''		A.''+ @COLNAME +'' = B.CODE '' +
			''WHERE IDMember IS NULL AND ''+ @COLNAME + '' IS NOT NULL''

		SET @SQLDELETE = ''DELETE Temp_Attribute_Transcoded
			FROM Temp_Attribute_Transcoded A
 				LEFT OUTER JOIN ''+ @TABLENAME +'' B ON '' +
	 		''		A.''+ @COLNAME +'' = B.CODE '' +
			''WHERE IDMember IS NULL AND ''+ @COLNAME + '' IS NOT NULL''

		SET @SQLUPDATE = ''UPDATE Temp_Attribute_Transcoded '' +
				''SET ''+ @COLNAME +''= IDMember '' +
				''FROM Temp_Attribute_Transcoded A '' +
				''	INNER JOIN ''+ @TABLENAME +'' B ON '' +
				''		A.''+ @COLNAME +'' = B.CODE '' +
				''WHERE A.''+ @COLNAME +'' IS NOT NULL''

		EXEC(@SQLSCARTED)
		EXEC(@SQLDELETE)
		EXEC(@SQLUPDATE)
	END	

	FETCH NEXT FROM attNameCursor 
	INTO @COLNAME
END 
CLOSE attNameCursor;
DEALLOCATE attNameCursor;








				' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNewID]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[GetNewID]
(
	@tableName varChar(50),
	@tableIDColumn varChar(50)
)
RETURNS int
AS
BEGIN

	DECLARE @newID int
	DECLARE	@newIDColumn int
	DECLARE @sqlstatement nvarchar(3000)

	SET @sqlstatement=N''DECLARE _cursor CURSOR FOR SELECT ''+@tableIDColumn+''
		FROM ''+@tableName+''
		WHERE ''+@tableIDColumn+'' > 0 ORDER BY ''+@tableIDColumn

	exec sp_executesql @sqlstatement

	SET @newID = 1
	OPEN _cursor
	WHILE 1=1
	BEGIN
		FETCH NEXT FROM _cursor INTO @newIDColumn
		IF @@FETCH_STATUS <> 0 
		BREAK
		IF @newIDColumn > @newID
			BREAK
		SET @newID = @newID+1
	END
	CLOSE _cursor
	DEALLOCATE _cursor


	RETURN @newID

END







' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[Split]
(
    @String NVARCHAR(4000),
    @Delimiter NCHAR(1)
)
RETURNS TABLE 
AS
RETURN 
(
    WITH Split(stpos,endpos) 
    AS(
        SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
        UNION ALL
        SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
            FROM Split
            WHERE endpos > 0
    )
    SELECT ''Id'' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
        ''Data'' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
    FROM Split
)







' 
END

GO
