/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionMembersListFiltered]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionMembersListFiltered]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDimensionMembersListFiltered]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionCodelistNoConstrain]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionCodelistNoConstrain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDimensionCodelistNoConstrain]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionCodelistConstrain]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionCodelistConstrain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDimensionCodelistConstrain]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetList]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDatasetList]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDataSetID]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataSetID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDataSetID]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetDimensionsList]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetDimensionsList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDatasetDimensionsList]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetConceptDimensions]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetConceptDimensions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDatasetConceptDimensions]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetAttributesList]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetAttributesList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDatasetAttributesList]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDataflowList]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataflowList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetDataflowList]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetCategoryAndCategorisation]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetCategoryAndCategorisation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetCategoryAndCategorisation]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetAttributeCodeListNoConstrain]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetAttributeCodeListNoConstrain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetAttributeCodeListNoConstrain]
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetAttributeCodeListFiltered]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetAttributeCodeListFiltered]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_WBS_GetAttributeCodeListFiltered]
GO
/****** Object:  StoredProcedure [dbo].[proc_SDMX_GetObservations]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SDMX_GetObservations]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_SDMX_GetObservations]
GO
/****** Object:  StoredProcedure [dbo].[proc_SDMX_GetGroups]    Script Date: 03/03/2015 12:16:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SDMX_GetGroups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[proc_SDMX_GetGroups]
GO
/****** Object:  StoredProcedure [dbo].[proc_SDMX_GetGroups]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SDMX_GetGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--Example of exec
--EXEC dbo.proc_SDMX_GetObservations_test  ''MEI'', ''[$LOCATION$].Code=''''USA'''' AND [$TIME$].Code=''''2000M10'''' AND [$FREQUENCY$].Code=''''M'''''', ''SORENSEN_O'', ''$(Domain)''

 
CREATE PROCEDURE [dbo].[proc_SDMX_GetGroups]
	@DataSetCode varchar(50),
	@Columns varchar(max),
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
	
AS

declare @TableID nvarchar(255);
declare @TableName nvarchar(255);
declare @SQLStatement nvarchar(max);

SET @TableID =
(
	SELECT CatSet.[IDSet] FROM  CatSet WHERE CatSet.Code=@DataSetCode
)

SET @TableName = ''Dataset_''+@TableID+''_ViewCurrentData'';

declare @Fld nvarchar(255);


DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT name
		FROM syscolumns 
	WHERE id=OBJECT_ID(@TableName) 

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @Fld

SET @Columns =REPLACE(@Columns,'', '','','');
SET @Columns =''NULL as '' + REPLACE(@Columns,'','','', NULL as '');

WHILE @@FETCH_STATUS = 0
BEGIN     
	SET @Fld=REPLACE(@Fld,''_TIME_PERIOD'','' _TIME_PERIOD as _TIME_'');
	SET @Columns = REPLACE(@Columns,''NULL as _TIME_PERIOD'','' _TIME_PERIOD as _TIME_'');
	SET @Fld=REPLACE(@Fld,''_OBS_VALUE'','' _OBS_VALUE as VALUE '');
	SET @Columns = REPLACE(@Columns,''NULL as _OBS_VALUE'','' _OBS_VALUE as VALUE '');
	SET @Fld=REPLACE(@Fld,''_Value_'','' _Value_ as VALUE '');
	SET @Columns = REPLACE(@Columns,''NULL as _Value_'','' _Value_ as VALUE '');
			
	SET @Columns =
	CASE WHEN CHARINDEX('' as '',@Fld) <= 0
	THEN
		REPLACE(@Columns,''NULL as '' + SUBSTRING(@Fld,2,DATALENGTH(@Fld)-1),@Fld + '' as ''+ SUBSTRING(@Fld,2,DATALENGTH(@Fld)-1))
	ELSE  @Columns
	END
    FETCH NEXT FROM MY_CURSOR INTO @Fld
END


SET @SQLStatement= N''SELECT DISTINCT '' + @Columns + '' FROM '' + @TableName;
	
--
PRINT @SQLStatement


EXECUTE sp_executesql @SQLStatement;' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_SDMX_GetObservations]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_SDMX_GetObservations]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--Example of exec
--EXEC dbo.proc_SDMX_GetObservations_test  ''MEI'', ''[$LOCATION$].Code=''''USA'''' AND [$TIME$].Code=''''2000M10'''' AND [$FREQUENCY$].Code=''''M'''''', ''SORENSEN_O'', ''$(Domain)''

 
CREATE PROCEDURE [dbo].[proc_SDMX_GetObservations]
	@DataSetCode varchar(50),
	@WhereStatement varchar(max),
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null,
	@DataSetAction varchar(50) = ''Replace'',
	@Time varchar(max) = ''''
AS

declare @TableID nvarchar(255);
declare @TableName nvarchar(255);
declare @SQLStatement nvarchar(max);

SET @TableID =
(
	SELECT CatSet.[IDSet] FROM  CatSet WHERE CatSet.Code=@DataSetCode
)

SET @TableName = ''Dataset_''+@TableID+''_ViewCurrentData'';

declare @Fld nvarchar(255);
declare @Fields nvarchar(max);
declare @Orderby nvarchar(max);
declare @req_WherePart as varchar(max);

DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT name
		FROM syscolumns 
	WHERE id=OBJECT_ID(@TableName) 

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @Fld
SET @Fields='''';
SET @Orderby='''';
 
WHILE @@FETCH_STATUS = 0
BEGIN     
	SET @Fld=REPLACE(@Fld,''_TIME_PERIOD'','' _TIME_PERIOD as _TIME_'');
	SET @Fld=REPLACE(@Fld,''_OBS_VALUE'','' _OBS_VALUE as VALUE '');
	SET @Fld=REPLACE(@Fld,''_Value_'','' _Value_ as VALUE '');
	
	SELECT @Fields=
	CASE WHEN CHARINDEX('' as '',@Fld) > 0
	THEN
		@Fields + @Fld +'' ,''
	ELSE 
		@Fields + @Fld + '' as ''+ SUBSTRING(@Fld,2,DATALENGTH(@Fld)-1) +'' ,''
	END
	
	SELECT @Orderby=
	CASE WHEN CHARINDEX('' as '',@Fld) > 0
	THEN
		@Orderby
	ELSE
		@Orderby + SUBSTRING(@Fld,2,DATALENGTH(@Fld)-1) +'' ,''
	END

    FETCH NEXT FROM MY_CURSOR INTO @Fld
END

SET @Fields= LEFT(@Fields, LEN(@Fields)-1);
SET @Orderby= @Orderby + '' _TIME_'';

Set @req_WherePart=@WhereStatement
if(RTRIM(@Time) <> '''')
  SET @req_WherePart = @req_WherePart +'' AND ''+ @Time

SELECT
@req_WherePart=
(CASE WHEN CD.IsTimeSeriesDim=1  THEN replace(@req_WherePart,''[$TIME_PERIOD$].Code'', ''[_TIME_PERIOD]'')
 ELSE replace(@req_WherePart,''[$''+CD.CODE+''$].Code'', ''[_''+CD.CODE+'']'')
 END
)
from CatDim as CD 
where  CD.IDSet=@TableID
					  
PRINT @req_WherePart

IF (RTRIM(@req_WherePart) = '''' ) 
	SET @SQLStatement= N''SELECT '' + @Fields + '' FROM '' + @TableName ;
ELSE
	SET @SQLStatement= N''SELECT '' + @Fields + '' FROM '' + @TableName + '' WHERE '' + @req_WherePart ;

SET @SQLStatement=	@SQLStatement + '' ORDER BY '' + @Orderby
	 
--
PRINT @SQLStatement
--PRINT @Orderby

EXECUTE sp_executesql @SQLStatement;





' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetAttributeCodeListFiltered]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetAttributeCodeListFiltered]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetAttributeCodeListFiltered]
(
	@DatasetCode varchar(50), 
	@AttributeCode varchar(50), 
	@Depth bit = 0, 
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

Declare @ViewName varchar(100)
SET @ViewName = cast((select top 1 CatSet.IDSet from CatSet where CatSet.Code=@DatasetCode) as varchar(10))
SET @ViewName = ''Dataset_''+@ViewName+''_ViewCurrentData'';

Declare @AttributeTableName varchar(100)
SET @AttributeTableName = (select top 1 MemberTable from CatAtt where Code=@AttributeCode and IDSet=(select top 1 CatSet.IDSet from CatSet where CatSet.Code=@DatasetCode)) 


declare @esiste int
set @esiste=(
SELECT count(*) FROM information_schema.columns  WHERE table_name = @ViewName
AND COLUMN_NAME=''_'' + @AttributeCode)
IF (@esiste = 0)
BEGIN
	SELECT 1 as Tag,
	null as Parent ,
	''http://istat.it/OnTheFly'' as [DatasetBrowserParameter!1!xmlns] 

	FOR XML EXPLICIT
	RETURN -1
	--SELECT @errmessage = ''[proc_WBS_GetAttributeCodeListFiltered]: Invalid parameters. No Dataset name provided.''
	--RAISERROR (@errmessage,16,1) with LOG
	--RETURN -1
END

Create Table  #AttributeMembersList 
(   
	Padre varchar(255),

	ItmId int,
	AttributeMemberCode varchar(255),
	AttributeMemberIsoCode varchar(255),
	AttributeMemberDescription varchar(255),
	Livel int
)
Create Table   #Figli
(   
	Padre varchar(255),

	ItmId int,
	AttributeMemberCode varchar(255),
	AttributeMemberIsoCode varchar(255),
	AttributeMemberDescription varchar(255),
	Livel int
)



exec(''insert into #Figli
select distinct
attribute.Code as CodePadre,
attribute.IDMember,
attribute.Code,
attributeDesc.TwoLetterISO,
attributeDesc.Value,
1 as Livel
from ''+@AttributeTableName+'' as attribute
inner join [dbo].localised_''+@AttributeTableName+'' as attributeDesc on attributeDesc.IDMember=attribute.IDMember
inner join ''+@ViewName+'' as vista on vista._''+@AttributeCode+''= attribute.Code
Where Code=BaseCode'')

Declare @FigliCount int
SET @FigliCount = (select count(ItmId) from #Figli)
Declare @Livel int = 2

WHILE @FigliCount>0
BEGIN
insert into #AttributeMembersList
select * from #Figli

delete from #Figli

	exec(''insert into #Figli
	select distinct
	(select distinct Tot.Padre from #AttributeMembersList as Tot Where Tot.AttributeMemberCode=BaseCode)+''''-'''' + attribute.Code as CodePadre,
	attribute.IDMember,
	attribute.Code,
	attributeDesc.TwoLetterISO,
	attributeDesc.Value,
	''+@Livel+'' as Livel
	from ''+@AttributeTableName+'' as attribute
	inner join [dbo].localised_''+@AttributeTableName+'' as attributeDesc on attributeDesc.IDMember=attribute.IDMember
	inner join ''+@ViewName+'' as vista on vista._''+@AttributeCode+''= attribute.Code
	Where Code!=BaseCode and BaseCode in (select distinct Tot.AttributeMemberCode from #AttributeMembersList as Tot Where Tot.Livel=''+@Livel+''-1)
	'')

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(ItmId) from #Figli)
END

--select * from @DimensionMembersList
--order by Padre, DimMemberIsoCode

create table #T
(
	Tag int,
	Parent int null,
	[DatasetBrowserParameter!1!xmlns] varchar(100) null,
	[Codelist!2!Order!hide] varchar(500) null,
	[Codelist!2!Order2!hide] varchar(500) null,
	[Codelist!2!Code] varchar(50) null,
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #AttributeMembersList)
set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Member!''+@si1+''!Code] varchar(50) null,
[Member!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[DatasetBrowserParameter!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')
INSERT INTO #T (Tag,Parent,[Codelist!2!Code])  Values (2,1,@AttributeTableName)


set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	 set @siParent=case @i when 1 then ''2''
	  else	   cast(2*@i-1 as varchar(50)) end

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Padre, 
	AttributeMemberCode, ItmId
	from #AttributeMembersList where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],[Codelist!2!Order2!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select ''+@si2+'' as Tag, ''+@si1+'' as Parent, Padre, AttributeMemberIsoCode,
	AttributeMemberCode, ItmId,
	AttributeMemberIsoCode, AttributeMemberDescription 
	from #AttributeMembersList where Livel=''+@i)

	set @i = @i+1
end

select * from #T order by [Codelist!2!Order!hide],[Codelist!2!Order2!hide]
FOR XML EXPLICIT


' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetAttributeCodeListNoConstrain]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetAttributeCodeListNoConstrain]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[proc_WBS_GetAttributeCodeListNoConstrain]
(
	@CodeListTable varchar(255), 
	@UserName sysname = '''',
	@Depth bit = 0, 
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS



Create Table  #AttributeMembersList 
(   
	Padre varchar(255),

	ItmId int,
	AttributeMemberCode varchar(255),
	AttributeMemberIsoCode varchar(255),
	AttributeMemberDescription varchar(255),
	Livel int
)
Create Table   #Figli
(   
	Padre varchar(255),

	ItmId int,
	AttributeMemberCode varchar(255),
	AttributeMemberIsoCode varchar(255),
	AttributeMemberDescription varchar(255),
	Livel int
)

exec(''insert into #Figli
select 
attribute.Code as CodePadre,
attribute.IDMember,
attribute.Code,
attributeDesc.TwoLetterISO,
attributeDesc.Value,
1 as Livel
from ''+@CodeListTable+'' as attribute
inner join [dbo].localised_''+@CodeListTable+'' as attributeDesc on attributeDesc.IDMember=attribute.IDMember
Where Code=BaseCode'')

Declare @FigliCount int
SET @FigliCount = (select count(ItmId) from #Figli)
Declare @Livel int = 2

WHILE @FigliCount>0
BEGIN
insert into #AttributeMembersList
select * from #Figli

delete from #Figli

	exec(''insert into #Figli
	select
	(select distinct Tot.Padre from #AttributeMembersList as Tot Where Tot.AttributeMemberCode=BaseCode)+''''-'''' + attribute.Code as CodePadre,
	attribute.IDMember,
	attribute.Code,
	attributeDesc.TwoLetterISO,
	attributeDesc.Value,
	''+@Livel+'' as Livel
	from ''+@CodeListTable+'' as attribute
	inner join [dbo].localised_''+@CodeListTable+'' as attributeDesc on attributeDesc.IDMember=attribute.IDMember
	Where Code!=BaseCode and BaseCode in (select distinct Tot.AttributeMemberCode from #AttributeMembersList as Tot Where Tot.Livel=''+@Livel+''-1)
	'')

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(ItmId) from #Figli)
END

--select * from @DimensionMembersList
--order by Padre, DimMemberIsoCode

create table #T
(
	Tag int,
	Parent int null,
	[DatasetBrowserParameter!1!xmlns] varchar(100) null,
	[Codelist!2!Order!hide] varchar(500) null,
	[Codelist!2!Order2!hide] varchar(500) null,
	[Codelist!2!Code] varchar(50) null,
	
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #AttributeMembersList)
set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Member!''+@si1+''!Code] varchar(50) null,
[Member!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[DatasetBrowserParameter!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')
INSERT INTO #T (Tag,Parent,[Codelist!2!Code]) Values (2,1,@CodeListTable)
 
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	
	  set @siParent=case @i when 1 then ''2''
	  else	   cast(2*@i-1 as varchar(50)) end

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Padre, 
	AttributeMemberCode, ItmId
	from #AttributeMembersList where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],[Codelist!2!Order2!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select ''+@si2+'' as Tag, ''+@si1+'' as Parent, Padre, AttributeMemberIsoCode,
	AttributeMemberCode, ItmId,
	AttributeMemberIsoCode, AttributeMemberDescription 
	from #AttributeMembersList where Livel=''+@i)

	set @i = @i+1
end

select * from #T order by [Codelist!2!Order!hide],[Codelist!2!Order2!hide]
FOR XML EXPLICIT


' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetCategoryAndCategorisation]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetCategoryAndCategorisation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_WBS_GetCategoryAndCategorisation] 

	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
create table  #Themes 
(   
	IDTheme int,
	IDThemeParent int,
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	DataSetCode varchar(255),
	Livel int,
	Ordinamento varchar(255)

)
Declare    @ThemeChild Table
(   
	IDTheme int,
	IDThemeParent int,
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	DataSetCode varchar(255),
	Livel int,
	Ordinamento varchar(255)
)


Insert into @ThemeChild
select 
	CatTheme.IDTheme,
	CatTheme.IDThemeParent,
	LCatTheme.TwoLetterISO,
	LCatTheme.Value,
	CatSet.Code,
	1,
	cast(CatTheme.IDTheme as varchar(255))
from [dbo].CatTheme
inner Join [dbo].localised_CatTheme as LCatTheme on LCatTheme.IDMember= CatTheme.IDTheme
left join [dbo].CatSet on CatSet.IDTheme = CatTheme.IDTheme
where CatTheme.IDTheme=CatTheme.IDThemeParent



Declare @FigliCount int
SET @FigliCount = (select count(IDTheme) from @ThemeChild)
Declare @Livel int = 2
WHILE @FigliCount>0
BEGIN
	insert into #Themes
	select * from @ThemeChild

	delete from @ThemeChild

	Insert into @ThemeChild
	select 
		CatTheme.IDTheme,
		CatTheme.IDThemeParent,
		LCatTheme.TwoLetterISO,
		LCatTheme.Value,
		CatSet.Code,
		@Livel,
		(Select top 1 Ordinamento  from #Themes as O where O.IDTheme=CatTheme.IDThemeParent AND Livel=@Livel-1) + ''-'' + cast(CatTheme.IDTheme as varchar(255))
	from [dbo].CatTheme
	inner Join [dbo].localised_CatTheme as LCatTheme on LCatTheme.IDMember= CatTheme.IDTheme
	left join [dbo].CatSet on CatSet.IDTheme = CatTheme.IDTheme
	where CatTheme.IDThemeParent in (Select IDTheme from #Themes where Livel=@Livel-1) AND CatTheme.IDTheme<> CatTheme.IDThemeParent

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(IDTheme) from @ThemeChild)
END

--select *  from #Themes  Order by Ordinamento


--exec(''drop table #T'')
create table #T
(
	Tag int,
	Parent int null,
	[ThemeList!1!xmlns] varchar(100) null,
	[ThemeList!1!Order!hide] varchar(100) null,
	[ContentObject!2!type] varchar(500) null,
	[ContentObject!2!Code] varchar(500) null,
	[Name!3!LocaleIsoCode] char(2) null,
	[Name!3!!cdata]varchar(500) null,
	[DatasetList!4!] varchar(500) null,
	[Dataset!5!Code] varchar(500) null
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @si3 varchar(50)
declare @si4 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #Themes)
set @execstr = ''''
set @i = 2
while (@i <= @maxdepth)
begin
	set @si1 = cast(4*@i-2 as varchar(50))
	set @si2 = cast(4*@i-1 as varchar(50))
	set @si3 = cast(4*@i as varchar(50))
	set @si4 = cast(4*@i+1 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
	[ContentObject!''+@si1+''!type] varchar(500) null,
	[ContentObject!''+@si1+''!Code] varchar(500) null,
	[Name!''+@si2+''!LocaleIsoCode] char(2) null,
	[Name!''+@si2+''!!cdata]varchar(500) null,
	[DatasetList!''+@si3+''!] varchar(500) null,
	[Dataset!''+@si4+''!Code] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[ThemeList!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')


set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(4*@i-2 as varchar(50))
	set @si2 = cast(4*@i-1 as varchar(50))
	set @si3 = cast(4*@i as varchar(50))
	set @si4 = cast(4*@i+1 as varchar(50))
	set @siParent= 
	CASE  WHEN @i = 1 then  cast(1 as varchar(50))
	ELSE  cast(4*(@i-1)-2 as varchar(50))
	END

	EXEC(''INSERT INTO #T (Tag,Parent,[ThemeList!1!Order!hide],
	[ContentObject!''+@si1+''!type],[ContentObject!''+@si1+''!Code]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Ordinamento, 
	''''ContentTheme'''', IDTheme
	from #Themes where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[ThemeList!1!Order!hide],
	[ContentObject!''+@si1+''!type],[ContentObject!''+@si1+''!Code],
	[Name!''+@si2+''!LocaleIsoCode] ,	[Name!''+@si2+''!!cdata]) 
	select DISTINCT ''+@si2+'' as Tag, ''+@si1+'' as Parent, Ordinamento, 
	''''ContentTheme'''', IDTheme,DimMemberIsoCode, DimMemberDescription
	from #Themes where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[ThemeList!1!Order!hide],
	[ContentObject!''+@si1+''!type],[ContentObject!''+@si1+''!Code],
	[DatasetList!''+@si3+''!]) 
	select DISTINCT ''+@si3+'' as Tag, ''+@si1+'' as Parent, Ordinamento, 
	''''ContentTheme'''', IDTheme,null
	from #Themes where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[ThemeList!1!Order!hide],
	[ContentObject!''+@si1+''!type],[ContentObject!''+@si1+''!Code],
	[DatasetList!''+@si3+''!],[Dataset!''+@si4+''!Code]) 
	select DISTINCT ''+@si4+'' as Tag, ''+@si3+'' as Parent, Ordinamento, 
	''''ContentTheme'''', IDTheme, NULL , DataSetCode
	from #Themes where DataSetCode IS NOT NULL AND Livel=''+@i )

	set @i = @i+1
end

select * from #T order by [ThemeList!1!Order!hide], [Tag]
FOR XML EXPLICIT
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDataflowList]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataflowList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_WBS_GetDataflowList] 

	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
declare @DatasetList table
(   
	ID int,
	Code varchar(255),    
	EnDescription varchar(255),    
	LocaleIsoCode varchar(2)
)

	INSERT INTO @DatasetList 	
		SELECT DISTINCT
			[IDDataFlow],
			[Code],
			LCatDataFlow.[Value],
			LCatDataFlow.TwoLetterISO as LocaleIsoCode		
			FROM [dbo].CatDataFlow
			inner join [dbo].CatSet on CatSet.IDSet= CatDataFlow.IDSet
			inner join [dbo].localised_CatSet as LCatDataFlow on LCatDataFlow.IDMember= CatSet.IDSet

--In memory table created	
		
	SELECT   
		1 AS Tag,    
		NULL AS Parent,    
		NULL AS ''DataflowBrowserParameter!1!'',    
		NULL AS ''Dataflow!2!Code'',
		NULL AS ''Dataflow!2!DfID'',
		null as ''Dataflow!2!Order!hide'',
		NULL AS ''Name!3!LocaleIsoCode'',
		Null AS ''Name!3!!cdata''
	UNION ALL
	
	SELECT distinct   
		2 AS Tag, 
		1 AS Parent,
		null,    
		[Code],
		[ID],
		[ID],
		null,
		null	   	
		FROM @DatasetList
	UNION ALL
	
	SELECT 
		3 AS Tag, 
		2 AS Parent,    
		null,
		[Code],	
		[ID],		     
		[ID],		     
		[LocaleIsoCode],
		[EnDescription]
		FROM @DatasetList
	
		ORDER BY [Dataflow!2!Order!hide], [Name!3!LocaleIsoCode]
		
		FOR XML EXPLICIT		
END







' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetAttributesList]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetAttributesList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[proc_WBS_GetDatasetAttributesList]
(
	@Code varchar(50),
    @TimeStamp datetime = null
)
AS

declare @nulldate bit
set @nulldate=0
IF @TimeStamp is null
begin
set @nulldate=1
Set @TimeStamp = cast(''1900-01-01 0:00:00.000'' as datetime)
end

declare @AttributeList table
(   
	DatasetCode varchar(255),    	
	DatasetLocaleIsoCode  varchar(2),	
	LocaleDatasetDescription  varchar(255),
	IDAtt int,
	AttributeCode varchar(255),    
	LocaleIsoCode varchar(2),
	LocaleDescription varchar(255),
	CodelistTable varchar(255),
	IsMandatory bit,
	DimensionAttached int,
	DimensionTopIsTime bit
)

	INSERT INTO @AttributeList 	
			SELECT DISTINCT 
                      CatSet.Code , 
					  LCatSet.TwoLetterISO,LCatSet.Value,
					  CatAtt.IDAtt,CatAtt.Code,
					  LCatAtt.TwoLetterISO, LCatAtt.Value,
					  CatAtt.MemberTable,
                      CatAtt.IsMandatory,
					  (Select COUNT(*) from [dbo].CatAttDim where IDAtt=CatAtt.IDAtt) as ''DimensionAttached'',
					  (Select top 1 CatDim.IsTimeSeriesDim from [dbo].CatAttDim inner join CatDim on CatDim.IDDim=CatAttDim.IDDim where IDAtt=CatAtt.IDAtt) as ''DimensionTopIsTime''
FROM         [dbo].CatAtt 
INNER JOIN    [dbo].CatSet ON [dbo].CatSet.IdSet=[dbo].CatAtt.IDSet
LEFT JOIN [dbo].localised_CatAtt as LCatAtt ON LCatAtt.IDMember=[dbo].CatAtt.IDAtt
LEFT JOIN [dbo].localised_CatSet as LCatSet ON LCatSet.IDMember=[dbo].CatSet.IDSet
WHERE  (CatSet.Code = @Code)			

--In memory table created	
		
	SELECT distinct  
		1 AS Tag,    
		NULL AS Parent,    
		NULL AS ''DatasetBrowserParameter!1!'', 
		NULL AS ''DataSet!2!Code'',
		NULL AS ''Name!3!LocaleIsoCode'',
		Null AS ''Name!3!!cdata'',
		null as ''Attribute!4!Order!hide'',
		NULL AS ''Attribute!4!Code'',
		NULL AS ''Attribute!4!CodelistTable'',
		NULL AS ''Attribute!4!assignmentStatus'',
		NULL AS ''Attribute!4!attachmentLevel'',
		NULL AS ''Name!5!LocaleIsoCode'',
		Null AS ''Name!5!!cdata''
	UNION ALL
	
	SELECT distinct  
		2 AS Tag, 
		1 AS Parent,
		null,    
		[DatasetCode],
		null,
		null,	
		0,
		null,
		null,
		null,
		null,
		null,
		null		   	
		FROM @AttributeList
	UNION ALL
	
	SELECT distinct
		3 AS Tag, 
		2 AS Parent,    
		null,    
		[DatasetCode],
		[DatasetLocaleIsoCode],
		[LocaleDatasetDescription],	
		0,
		null,
		null,
		null,
		null,
		null,
		null	
		FROM @AttributeList
	
		UNION ALL
	
	SELECT distinct   
		4 AS Tag, 
		2 AS Parent,
		null,    
		[DatasetCode],   
		null,
		null,	
		[IDAtt],
		[AttributeCode],
		CodelistTable,
		CASE WHEN IsMandatory = 1 THEN ''Mandatory'' ELSE ''Conditional'' END,
		
		CASE 
		WHEN DimensionAttached = 0 THEN ''Dataset'' 
		WHEN DimensionAttached >1 and DimensionTopIsTime=1 THEN ''Observation'' 
		ELSE ''DimensionGroup'' END,

		null,
		null		   	
		FROM @AttributeList	
	UNION all
	
	SELECT distinct
		5 AS Tag, 
		4 AS Parent,    
		null,    
		[DatasetCode],
		null,
		null,	
		[IDAtt],
		[AttributeCode],
		CodelistTable,
		null,
		null,
		[LocaleIsoCode],
		[LocaleDescription]	
		FROM @AttributeList
		
		ORDER BY [DataSet!2!Code],[Attribute!4!Order!hide], [Name!5!LocaleIsoCode]--[Dimension!4!Order!hide],Tag
		
		FOR XML EXPLICIT		

RETURN









' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetConceptDimensions]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetConceptDimensions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[proc_WBS_GetDatasetConceptDimensions]
(
	@Code varchar(50),
    @TimeStamp datetime = null
)
AS

declare @nulldate bit
set @nulldate=0
IF @TimeStamp is null
begin
set @nulldate=1
Set @TimeStamp = cast(''1900-01-01 0:00:00.000'' as datetime)
end

declare @DimensionList table
(   
	DatasetCode varchar(255),    	
	DatasetLocaleIsoCode  varchar(2),	
	LocaleDatasetDescription  varchar(255),
	IDDim int,
	DimensionCode varchar(255),    
	LocaleIsoCode varchar(2),
	LocaleDescription varchar(255),
	CodelistTable varchar(255),
	IsTimeSeriesDim bit
)

	INSERT INTO @DimensionList 	
			SELECT DISTINCT 
                      CatSet.Code , 
					  LCatSet.TwoLetterISO,LCatSet.Value,
					  CatDim.IDDim,CatDim.Code,
					  LCatDim.TwoLetterISO, LCatDim.Value,
					  CatDim.MemberTable,
                      CatDim.IsTimeSeriesDim
FROM         [dbo].CatDim 
INNER JOIN    [dbo].CatSet ON [dbo].CatSet.IdSet=[dbo].CatDim.IDSet
LEFT JOIN [dbo].localised_CatDim as LCatDim ON LCatDim.IDMember=[dbo].CatDim.IDDim
LEFT JOIN [dbo].localised_CatSet as LCatSet ON LCatSet.IDMember=[dbo].CatSet.IDSet
WHERE  (CatSet.Code = @Code)			

--In memory table created	
		
	SELECT distinct  
		1 AS Tag,    
		NULL AS Parent,    
		NULL AS ''DatasetBrowserParameter!1!'', 
		NULL AS ''DataSet!2!Code'',
		NULL AS ''Name!3!LocaleIsoCode'',
		Null AS ''Name!3!!cdata'',
		null as ''Dimension!4!Order!hide'',
		NULL AS ''Dimension!4!Code'',
		NULL AS ''Dimension!4!CodelistTable'',
		NULL AS ''Dimension!4!IsTimeSeriesDim'',
		NULL AS ''Name!5!LocaleIsoCode'',
		Null AS ''Name!5!!cdata''
	UNION ALL
	
	SELECT distinct  
		2 AS Tag, 
		1 AS Parent,
		null,    
		[DatasetCode],
		null,
		null,	
		0,
		null,
		null,
		null,
		null,
		null		   	
		FROM @DimensionList
	UNION ALL
	
	SELECT distinct
		3 AS Tag, 
		2 AS Parent,    
		null,    
		[DatasetCode],
		[DatasetLocaleIsoCode],
		[LocaleDatasetDescription],	
		0,
		null,
		null,
		null,
		null,
		null	
		FROM @DimensionList
	
		UNION ALL
	
	SELECT distinct   
		4 AS Tag, 
		2 AS Parent,
		null,    
		[DatasetCode],   
		null,
		null,	
		[IDDim],
		[DimensionCode],
		CodelistTable,
		CASE WHEN IsTimeSeriesDim = 1 THEN ''true'' ELSE null END as [Dimension!3!IsTimeSeriesDim],
		null,
		null		   	
		FROM @DimensionList	
	UNION all
	
	SELECT distinct
		5 AS Tag, 
		4 AS Parent,    
		null,    
		[DatasetCode],
		null,
		null,	
		[IDDim],
		[DimensionCode],
		CodelistTable,
		CASE WHEN IsTimeSeriesDim = 1 THEN ''true'' ELSE null END as [Dimension!3!IsTimeSeriesDim],
		[LocaleIsoCode],
		[LocaleDescription]	
		FROM @DimensionList
		
		ORDER BY [DataSet!2!Code],[Dimension!4!Order!hide], [Name!5!LocaleIsoCode]--[Dimension!4!Order!hide],Tag
		
		FOR XML EXPLICIT		

RETURN









' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetDimensionsList]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetDimensionsList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[proc_WBS_GetDatasetDimensionsList]
(
	@Code varchar(50),
    @TimeStamp datetime = null
)
AS

declare @nulldate bit
set @nulldate=0
IF @TimeStamp is null
begin
set @nulldate=1
Set @TimeStamp = cast(''1900-01-01 0:00:00.000'' as datetime)
end

declare @DimensionList table
(   
	DatasetCode varchar(255),    	
	DatasetLocaleIsoCode  varchar(2),	
	LocaleDatasetDescription  varchar(255),
	IDDim int,
	DimensionCode varchar(255),    
	LocaleIsoCode varchar(2),
	LocaleDescription varchar(255),
	IsTimeSeriesDim bit
)

	INSERT INTO @DimensionList 	
			SELECT DISTINCT 
                      CatSet.Code , 
					  LCatSet.TwoLetterISO,LCatSet.Value,
					  CatDim.IDDim,CatDim.Code,
					  LCatDim.TwoLetterISO, LCatDim.Value,
                      CatDim.IsTimeSeriesDim
FROM         [dbo].CatDim 
INNER JOIN    [dbo].CatSet ON [dbo].CatSet.IdSet=[dbo].CatDim.IDSet
LEFT JOIN [dbo].localised_CatDim as LCatDim ON LCatDim.IDMember=[dbo].CatDim.IDDim
LEFT JOIN [dbo].localised_CatSet as LCatSet ON LCatSet.IDMember=[dbo].CatSet.IDSet
WHERE  (CatSet.Code = @Code)			

--In memory table created	
		
	SELECT distinct  
		1 AS Tag,    
		NULL AS Parent,    
		NULL AS ''DatasetBrowserParameter!1!'', 
		NULL AS ''DataSet!2!Code'',
		NULL AS ''Name!3!LocaleIsoCode'',
		Null AS ''Name!3!!cdata'',
		null as ''Dimension!4!Order!hide'',
		NULL AS ''Dimension!4!Code'',
		NULL AS ''Dimension!4!IsTimeSeriesDim'',
		NULL AS ''Name!5!LocaleIsoCode'',
		Null AS ''Name!5!!cdata''
	UNION ALL
	
	SELECT distinct  
		2 AS Tag, 
		1 AS Parent,
		null,    
		[DatasetCode],
		null,
		null,	
		0,
		null,
		null,
		null,
		null		   	
		FROM @DimensionList
	UNION ALL
	
	SELECT distinct
		3 AS Tag, 
		2 AS Parent,    
		null,    
		[DatasetCode],
		[DatasetLocaleIsoCode],
		[LocaleDatasetDescription],	
		0,
		null,
		null,
		null,
		null	
		FROM @DimensionList
	
		UNION ALL
	
	SELECT distinct   
		4 AS Tag, 
		2 AS Parent,
		null,    
		[DatasetCode],   
		null,
		null,	
		[IDDim],
		[DimensionCode],
		CASE WHEN IsTimeSeriesDim = 1 THEN ''true'' ELSE null END as [Dimension!3!IsTimeSeriesDim],
		null,
		null		   	
		FROM @DimensionList	
	UNION all
	
	SELECT distinct
		5 AS Tag, 
		4 AS Parent,    
		null,    
		[DatasetCode],
		null,
		null,	
		[IDDim],
		[DimensionCode],
		CASE WHEN IsTimeSeriesDim = 1 THEN ''true'' ELSE null END as [Dimension!3!IsTimeSeriesDim],
		[LocaleIsoCode],
		[LocaleDescription]	
		FROM @DimensionList
		
		ORDER BY [DataSet!2!Code],[Dimension!4!Order!hide], [Name!5!LocaleIsoCode]--[Dimension!4!Order!hide],Tag
		
		FOR XML EXPLICIT		

RETURN









' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDataSetID]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDataSetID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE    PROCEDURE [dbo].[proc_WBS_GetDataSetID]
(
	@Code varchar(50),
	@UserName sysname = '''',
	@Domain sysname = ''PCISTAT''
)
AS
SET NOCOUNT ON 

DECLARE @errmessage varchar(8000)

DECLARE @IDSet int

-- test if dataset exists, if not return to the user
SELECT TOP 1 @IDSet = C.IDSet
FROM CATSET C
WHERE C.Code = @Code 
SET @IDSet = ISNULL(@IDSet, 0)
IF (@IDSet = 0)
BEGIN
	SELECT @IDSet as IDSet
	RETURN 0
END

SELECT @IDSet as IDSet



' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDatasetList]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDatasetList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_WBS_GetDatasetList] 

	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
declare @DatasetList table
(   
	ID int,
	Code varchar(255),    
	EnDescription varchar(255),    
	LocaleIsoCode varchar(2)
)

	INSERT INTO @DatasetList 	
		SELECT DISTINCT
			IDSet,
			[Code],
			LCatSet.[Value],
			LCatSet.TwoLetterISO as LocaleIsoCode		
			FROM [dbo].CatSet
			inner join [dbo].localised_CatSet as LCatSet on LCatSet.IDMember= CatSet.IDSet

--In memory table created	
		
	SELECT   
		1 AS Tag,    
		NULL AS Parent,    
		NULL AS ''DatasetBrowserParameter!1!'',    
		NULL AS ''DataSet!2!Code'',
		null as ''DataSet!2!Order!hide'',
		NULL AS ''Name!3!LocaleIsoCode'',
		Null AS ''Name!3!!cdata''
	UNION ALL
	
	SELECT distinct   
		2 AS Tag, 
		1 AS Parent,
		null,    
		[Code],
		[ID],
		null,
		null	   	
		FROM @DatasetList
	UNION ALL
	
	SELECT 
		3 AS Tag, 
		2 AS Parent,    
		null,
		[Code],	
		[ID],		     
		[LocaleIsoCode],
		[EnDescription]
		FROM @DatasetList
	
		ORDER BY [DataSet!2!Order!hide], [Name!3!LocaleIsoCode]
		
		FOR XML EXPLICIT		
END







' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionCodelistConstrain]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionCodelistConstrain]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


Create PROCEDURE [dbo].[proc_WBS_GetDimensionCodelistConstrain]
(
	@DatasetCode varchar(50), 
	@DimCode varchar(50), 
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

Declare @DimTableName varchar(100)
SET @DimTableName = (select top 1 MemberTable from CatDim where Code=@DimCode and IDSet=(select top 1 CatSet.IDSet from CatSet where CatSet.Code=@DatasetCode)) 

Declare @ViewName varchar(100)
SET @ViewName = cast((select top 1 CatSet.IDSet from CatSet where CatSet.Code=@DatasetCode) as varchar(10))
SET @ViewName = ''Dataset_''+@ViewName+''_ViewCurrentData'';

Create Table  #DimensionMembersList 
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)
Create Table   #Figli
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)

exec(''insert into #Figli
select distinct
concept.Code as CodePadre,
concept.IDMember,
concept.Code,
ConceptDesc.TwoLetterISO,
ConceptDesc.Value,
1 as Livel
from ''+@DimTableName+'' as concept
inner join [dbo].localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
inner join ''+@ViewName+'' as vista on vista._''+@DimCode+''= concept.Code
Where Code=BaseCode'')

Declare @FigliCount int
SET @FigliCount = (select count(ItmId) from #Figli)
Declare @Livel int = 2

WHILE @FigliCount>0
BEGIN
insert into #DimensionMembersList
select * from #Figli

delete from #Figli

	exec(''insert into #Figli
	select distinct
	(select distinct Tot.Padre from #DimensionMembersList as Tot Where Tot.DimMemberCode=BaseCode)+''''-'''' + concept.Code as CodePadre,
	concept.IDMember,
	concept.Code,
	ConceptDesc.TwoLetterISO,
	ConceptDesc.Value,
	''+@Livel+'' as Livel
	from ''+@DimTableName+'' as concept
	inner join [dbo].localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
    inner join ''+@ViewName+'' as vista on vista._''+@DimCode+''= concept.Code
	Where Code!=BaseCode and BaseCode in (select distinct Tot.DimMemberCode from #DimensionMembersList as Tot Where Tot.Livel=''+@Livel+''-1)
	'')

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(ItmId) from #Figli)
END

--select * from @DimensionMembersList
--order by Padre, DimMemberIsoCode

create table #T
(
	Tag int,
	Parent int null,
	[DatasetBrowserParameter!1!xmlns] varchar(100) null,
	[Codelist!2!Order!hide] varchar(500) null,
	[Codelist!2!Order2!hide] varchar(500) null,
	[Codelist!2!Code] varchar(50) null,
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #DimensionMembersList)
set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Member!''+@si1+''!Code] varchar(50) null,
[Member!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[DatasetBrowserParameter!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')
INSERT INTO #T (Tag,Parent,[Codelist!2!Code])  Values (2,1,@DimTableName)

set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	set @siParent=case @i when 1 then ''2''
	else cast(2*@i-1 as varchar(50)) end

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Padre, 
	DimMemberCode, ItmId
	from #DimensionMembersList where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],[Codelist!2!Order2!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select ''+@si2+'' as Tag, ''+@si1+'' as Parent, Padre, DimMemberIsoCode,
	DimMemberCode, ItmId,
	DimMemberIsoCode, DimMemberDescription 
	from #DimensionMembersList where Livel=''+@i)

	set @i = @i+1
end

select * from #T order by [Codelist!2!Order!hide],[Codelist!2!Order2!hide]
FOR XML EXPLICIT' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionCodelistNoConstrain]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionCodelistNoConstrain]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[proc_WBS_GetDimensionCodelistNoConstrain]
(
	@DimTableName varchar(255), 
	@UserName sysname = '''',
	@Depth bit = 0, 
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS


Create Table  #DimensionMembersList 
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)
Create Table   #Figli
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)



exec(''insert into #Figli
select 
concept.Code as CodePadre,
concept.IDMember,
concept.Code,
ConceptDesc.TwoLetterISO,
ConceptDesc.Value,
1 as Livel
from ''+@DimTableName+'' as concept
inner join [dbo].localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
Where Code=BaseCode'')

Declare @FigliCount int
SET @FigliCount = (select count(ItmId) from #Figli)
Declare @Livel int = 2

WHILE @FigliCount>0
BEGIN
insert into #DimensionMembersList
select * from #Figli

delete from #Figli

	exec(''insert into #Figli
	select
	(select distinct Tot.Padre from #DimensionMembersList as Tot Where Tot.DimMemberCode=BaseCode)+''''-'''' + concept.Code as CodePadre,
	concept.IDMember,
	concept.Code,
	ConceptDesc.TwoLetterISO,
	ConceptDesc.Value,
	''+@Livel+'' as Livel
	from ''+@DimTableName+'' as concept
	inner join [dbo].localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
	Where Code!=BaseCode and BaseCode in (select distinct Tot.DimMemberCode from #DimensionMembersList as Tot Where Tot.Livel=''+@Livel+''-1)
	'')

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(ItmId) from #Figli)
END

--select * from @DimensionMembersList
--order by Padre, DimMemberIsoCode

create table #T
(
	Tag int,
	Parent int null,
	[DatasetBrowserParameter!1!xmlns] varchar(100) null,
	[Codelist!2!Order!hide] varchar(500) null,
	[Codelist!2!Order2!hide] varchar(500) null,
	[Codelist!2!Code] varchar(50) null,
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #DimensionMembersList)
set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Member!''+@si1+''!Code] varchar(50) null,
[Member!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[DatasetBrowserParameter!1!xmlns]) Values (1,''http://istat.it/OnTheFly'')
INSERT INTO #T (Tag,Parent,[Codelist!2!Code])  Values (2,1,@DimTableName)


set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+1 as varchar(50))
	set @si2 = cast(2*@i+2 as varchar(50))
	set @siParent=case @i when 1 then ''2''
	else cast(2*@i-1 as varchar(50)) end

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Padre, 
	DimMemberCode, ItmId
	from #DimensionMembersList where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[Codelist!2!Order!hide],[Codelist!2!Order2!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select ''+@si2+'' as Tag, ''+@si1+'' as Parent, Padre, DimMemberIsoCode,
	DimMemberCode, ItmId,
	DimMemberIsoCode, DimMemberDescription 
	from #DimensionMembersList where Livel=''+@i)

	set @i = @i+1
end

select * from #T order by [Codelist!2!Order!hide],[Codelist!2!Order2!hide]
FOR XML EXPLICIT


' 
END
GO
/****** Object:  StoredProcedure [dbo].[proc_WBS_GetDimensionMembersListFiltered]    Script Date: 03/03/2015 12:16:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[proc_WBS_GetDimensionMembersListFiltered]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[proc_WBS_GetDimensionMembersListFiltered]
(
	@DatasetCode varchar(50), 
	@DimCode varchar(50), 
	@Depth bit = 0, 
	@UserName sysname = '''',
	@Domain sysname = '''',
	@TimeStamp datetime = null
)
AS

Declare @DimTableName varchar(100)
SET @DimTableName = (select top 1 MemberTable from CatDim where Code=@DimCode)

Declare @ViewName varchar(100)
SET @ViewName = cast((select top 1 CatSet.IDSet from CatSet where CatSet.Code=@DatasetCode) as varchar(10))
SET @ViewName = ''Dataset_''+@ViewName+''_ViewCurrentData'';

Create Table  #DimensionMembersList 
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)
Create Table   #Figli
(   
	Padre varchar(255),

	ItmId int,
	DimMemberCode varchar(255),
	DimMemberIsoCode varchar(255),
	DimMemberDescription varchar(255),
	Livel int
)

exec(''insert into #Figli
select distinct
concept.Code as CodePadre,
concept.IDMember,
concept.Code,
ConceptDesc.TwoLetterISO,
ConceptDesc.Value,
1 as Livel
from ''+@DimTableName+'' as concept
inner join localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
inner join ''+@ViewName+'' as vista on vista._''+@DimCode+''= concept.Code
Where Code=BaseCode'')

Declare @FigliCount int
SET @FigliCount = (select count(ItmId) from #Figli)
Declare @Livel int = 2

WHILE @FigliCount>0
BEGIN
insert into #DimensionMembersList
select * from #Figli

delete from #Figli

	exec(''insert into #Figli
	select distinct
	(select distinct Tot.Padre from #DimensionMembersList as Tot Where Tot.DimMemberCode=BaseCode)+''''-'''' + concept.Code as CodePadre,
	concept.IDMember,
	concept.Code,
	ConceptDesc.TwoLetterISO,
	ConceptDesc.Value,
	''+@Livel+'' as Livel
	from ''+@DimTableName+'' as concept
	inner join localised_''+@DimTableName+'' as ConceptDesc on ConceptDesc.IDMember=concept.IDMember
    inner join ''+@ViewName+'' as vista on vista._''+@DimCode+''= concept.Code
	Where Code!=BaseCode and BaseCode in (select distinct Tot.DimMemberCode from #DimensionMembersList as Tot Where Tot.Livel=''+@Livel+''-1)
	'')

	Set @Livel=@Livel+1
	SET @FigliCount = (select count(ItmId) from #Figli)
END

--select * from @DimensionMembersList
--order by Padre, DimMemberIsoCode

create table #T
(
	Tag int,
	Parent int null,
	[DatasetBrowserParameter!1!xmlns] varchar(100) null,
	[DataSet!2!Order!hide] varchar(500) null,
	[DataSet!2!Order2!hide] varchar(500) null,
	[DataSet!2!Code] varchar(50) null,
	[Dimension!3!Code] varchar(50) null,
	[Name!4!LocaleIsoCode] char(2) null,
	[Name!4!!cdata] varchar(500) null
)
declare @i int
declare @si0 varchar(50)
declare @si1 varchar(50)
declare @si2 varchar(50)
declare @siParent varchar(50)
declare @execstr varchar(8000)
declare @maxdepth int;
set @maxdepth =(select MAX(Livel) from #DimensionMembersList)
set @execstr = ''''
set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+3 as varchar(50))
	set @si2 = cast(2*@i+4 as varchar(50))
	if (len(@execstr) > 0)
		set @execstr = @execstr + '',''
	set @execstr = @execstr + ''
[Member!''+@si1+''!Code] varchar(50) null,
[Member!''+@si1+''!ID!hide] int null,
[Name!''+@si2+''!LocaleIsoCode] char(2) null,
[Name!''+@si2+''!!cdata] varchar(500) null''
	set @i = @i+1
end

if (len(@execstr) > 0)
--	print(''alter table #T add ''+@execstr)
	exec(''alter table #T add ''+@execstr)

INSERT INTO #T (Tag,[DatasetBrowserParameter!1!xmlns]) Values (1,''http://stats.oecd.org/OECDStatWS/2004/03/01/'')
INSERT INTO #T (Tag,Parent,[DataSet!2!Code]) Values (2,1,@DatasetCode)
INSERT INTO #T (Tag,Parent,[Dimension!3!Code])  Values (3,2,@DimCode)
INSERT INTO #T (Tag,Parent,[Name!4!LocaleIsoCode],[Name!4!!cdata])  
select DISTINCT 4,3,
LCatDim.TwoLetterISO,LCatDim.Value
from CatDim inner join localised_CatDim as LCatDim on LCatDim.IDMember=CatDim.IDDim
where CatDim.Code= @DimCode

set @i = 1
while (@i <= @maxdepth)
begin
	set @si1 = cast(2*@i+3 as varchar(50))
	set @si2 = cast(2*@i+4 as varchar(50))
	set @siParent= cast(2*@i+1 as varchar(50))

	EXEC(''INSERT INTO #T (Tag,Parent,[DataSet!2!Order!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide]) 
	select DISTINCT ''+@si1+'' as Tag, ''+@siParent+'' as Parent, Padre, 
	DimMemberCode, ItmId
	from #DimensionMembersList where Livel=''+@i)

	EXEC(''INSERT INTO #T (Tag,Parent,[DataSet!2!Order!hide],[DataSet!2!Order2!hide],
	[Member!''+@si1+''!Code],[Member!''+@si1+''!ID!hide],
	[Name!''+@si2+''!LocaleIsoCode], [Name!''+@si2+''!!cdata]) 
	select ''+@si2+'' as Tag, ''+@si1+'' as Parent, Padre, DimMemberIsoCode,
	DimMemberCode, ItmId,
	DimMemberIsoCode, DimMemberDescription 
	from #DimensionMembersList where Livel=''+@i)

	set @i = @i+1
end

select * from #T order by [DataSet!2!Order!hide],[DataSet!2!Order2!hide]
FOR XML EXPLICIT' 
END
GO
