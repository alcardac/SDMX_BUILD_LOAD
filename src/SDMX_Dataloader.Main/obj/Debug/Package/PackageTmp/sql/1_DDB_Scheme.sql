IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatSet_Access_CatSet]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatSet_Access]'))
ALTER TABLE [dbo].[CatSet_Access] DROP CONSTRAINT [FK_CatSet_Access_CatSet]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USER]') AND type in (N'U'))
DROP TABLE [dbo].[USER]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ROLE]') AND type in (N'U'))
DROP TABLE [dbo].[ROLE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatTheme]') AND type in (N'U'))
DROP TABLE [dbo].[localised_CatTheme]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatSet]') AND type in (N'U'))
DROP TABLE [dbo].[localised_CatSet]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatDim]') AND type in (N'U'))
DROP TABLE [dbo].[localised_CatDim]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatDataFlow]') AND type in (N'U'))
DROP TABLE [dbo].[localised_CatDataFlow]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatAtt]') AND type in (N'U'))
DROP TABLE [dbo].[localised_CatAtt]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DOMAIN]') AND type in (N'U'))
DROP TABLE [dbo].[DOMAIN]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DATA_MAPPING]') AND type in (N'U'))
DROP TABLE [dbo].[DATA_MAPPING]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatTheme]') AND type in (N'U'))
DROP TABLE [dbo].[CatTheme]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSet_Access]') AND type in (N'U'))
DROP TABLE [dbo].[CatSet_Access]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSet]') AND type in (N'U'))
DROP TABLE [dbo].[CatSet]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatLoad]') AND type in (N'U'))
DROP TABLE [dbo].[CatLoad]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatDim]') AND type in (N'U'))
DROP TABLE [dbo].[CatDim]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatDataFlow]') AND type in (N'U'))
DROP TABLE [dbo].[CatDataFlow]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatAttDim]') AND type in (N'U'))
DROP TABLE [dbo].[CatAttDim]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatAtt]') AND type in (N'U'))
DROP TABLE [dbo].[CatAtt]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CAT_MAPPING]') AND type in (N'U'))
DROP TABLE [dbo].[CAT_MAPPING]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CAT_MAPPING]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CAT_MAPPING](
	[ID_SCHEMA] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_USER] [bigint] NOT NULL,
	[ID_SET] [bigint] NOT NULL,
	[TIMESTAMP] [datetime] NOT NULL,
	[NAME] [nvarchar](255) NULL,
	[DESCRIPTION] [nvarchar](max) NULL,
	[FILE_CSV_CHAR] [char](1) NOT NULL,
	[FILE_CSV_HASHEADER] [bit] NOT NULL,
	[TRANSCODE_USE] [bit] NOT NULL,
	[TRANSCODE_CHAR] [nvarchar](50) NULL,
	[TRANSCODE_VALUE] [int] NULL,
 CONSTRAINT [PK_CAT_MAPPING] PRIMARY KEY CLUSTERED 
(
	[ID_SCHEMA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatAtt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatAtt](
	[IDAtt] [int] NOT NULL,
	[IDSet] [int] NOT NULL,
	[IDName] [varchar](50) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[MemberTable] [varchar](50) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[IsMandatory] [bit] NOT NULL,
	[IsCodelist] [bit] NOT NULL,
 CONSTRAINT [PK_CatAtt] PRIMARY KEY CLUSTERED 
(
	[IDAtt] ASC,
	[IDSet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatAttDim]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatAttDim](
	[IDAtt] [int] NOT NULL,
	[IDDim] [int] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatDataFlow]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatDataFlow](
	[IDDataFlow] [int] NOT NULL,
	[IDSet] [int] NOT NULL,
	[AgencyID] [varchar](255) NOT NULL,
	[ID] [varchar](255) NOT NULL,
	[Version] [varchar](255) NOT NULL,
 CONSTRAINT [PK_CatDataFlow] PRIMARY KEY CLUSTERED 
(
	[IDDataFlow] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatDim]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatDim](
	[IDDim] [int] NOT NULL,
	[IDSet] [int] NOT NULL,
	[IDName] [varchar](50) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[MemberTable] [varchar](50) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[IsTimeSeriesDim] [bit] NOT NULL,
 CONSTRAINT [PK_CatDim] PRIMARY KEY CLUSTERED 
(
	[IDDim] ASC,
	[IDSet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatLoad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatLoad](
	[IDLoad] [bigint] IDENTITY(1,1) NOT NULL,
	[IDSet] [bigint] NOT NULL,
	[IDDataflow] [bigint] NOT NULL,
	[MIN_TIME] [nchar](10) NOT NULL,
	[MAX_TIME] [nchar](10) NOT NULL,
	[RecorderCount] [int] NOT NULL,
	[Filename] [nchar](255) NULL,
	[Timestamp] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatSet](
	[IDSet] [int] NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[UnitDimension] [varchar](50) NULL,
	[IDTheme] [int] NULL,
 CONSTRAINT [PK_CatSetList] PRIMARY KEY CLUSTERED 
(
	[IDSet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatSet_Access]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatSet_Access](
	[IDSet] [int] NOT NULL,
	[UserGroup] [sysname] NOT NULL,
	[Domain] [sysname] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatTheme]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatTheme](
	[IDTheme] [int] IDENTITY(1,1) NOT NULL,
	[IDThemeParent] [int] NULL,
	[Urn] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DATA_MAPPING]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DATA_MAPPING](
	[ID_MAP] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_SCHEMA] [bigint] NOT NULL,
	[ID_COLUMN] [int] NOT NULL,
	[NAME_COLUMN] [nvarchar](255) NULL,
	[NAME] [nvarchar](255) NULL,
 CONSTRAINT [PK_DATA_MAPPING] PRIMARY KEY CLUSTERED 
(
	[ID_MAP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DOMAIN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DOMAIN](
	[ID_DOMAIN] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_USER] [int] NOT NULL,
	[IDSet] [int] NULL,
	[IDTheme] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID_DOMAIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatAtt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[localised_CatAtt](
	[IDLocation] [int] IDENTITY(1,1) NOT NULL,
	[IDMember] [int] NULL,
	[TwoLetterISO] [varchar](2) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_LOCATION_[CatAtt] PRIMARY KEY CLUSTERED 
(
	[IDLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatDataFlow]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[localised_CatDataFlow](
	[IDLocation] [int] IDENTITY(1,1) NOT NULL,
	[IDMember] [int] NULL,
	[TwoLetterISO] [varchar](2) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_LOCATION_[CatDataFlow] PRIMARY KEY CLUSTERED 
(
	[IDLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatDim]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[localised_CatDim](
	[IDLocation] [int] IDENTITY(1,1) NOT NULL,
	[IDMember] [int] NULL,
	[TwoLetterISO] [varchar](2) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_LOCATION_[CatDim] PRIMARY KEY CLUSTERED 
(
	[IDLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatSet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[localised_CatSet](
	[IDLocation] [int] IDENTITY(1,1) NOT NULL,
	[IDMember] [int] NULL,
	[TwoLetterISO] [varchar](2) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_LOCATION_CatSet] PRIMARY KEY CLUSTERED 
(
	[IDLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[localised_CatTheme]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[localised_CatTheme](
	[IDLocation] [int] IDENTITY(1,1) NOT NULL,
	[IDMember] [int] NULL,
	[TwoLetterISO] [varchar](2) NULL,
	[Value] [varchar](max) NULL,
 CONSTRAINT [PK_LOCATION_CatTheme] PRIMARY KEY CLUSTERED 
(
	[IDLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ROLE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ROLE](
	[ID_ROLE] [int] NOT NULL,
	[DESC_ROLE] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[ID_ROLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USER]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[USER](
	[ID_USER] [int] IDENTITY(1,1) NOT NULL,
	[USERNAME] [varchar](255) NOT NULL,
	[PWD] [varchar](255) NOT NULL,
	[ID_ROLE] [int] NOT NULL,
	[NAME] [varchar](255) NOT NULL,
	[SURNAME] [varchar](255) NOT NULL,
	[EMAIL] [varchar](255) NULL,
	[PROFLAG] [bit] NULL,
 CONSTRAINT [PK_USER] PRIMARY KEY CLUSTERED 
(
	[ID_USER] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatSet_Access_CatSet]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatSet_Access]'))
ALTER TABLE [dbo].[CatSet_Access]  WITH NOCHECK ADD  CONSTRAINT [FK_CatSet_Access_CatSet] FOREIGN KEY([IDSet])
REFERENCES [dbo].[CatSet] ([IDSet])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CatSet_Access_CatSet]') AND parent_object_id = OBJECT_ID(N'[dbo].[CatSet_Access]'))
ALTER TABLE [dbo].[CatSet_Access] CHECK CONSTRAINT [FK_CatSet_Access_CatSet]
GO
