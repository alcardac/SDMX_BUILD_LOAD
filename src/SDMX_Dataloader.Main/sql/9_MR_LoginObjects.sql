/****** Object:  StoredProcedure [dbo].[GET_DSD_CODE_ID]    Script Date: 30/06/2015 08:59:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_DSD_CODE_ID]
	@p_cl_id bigint,
	@p_code_id varchar(50),
	@p_found_id bigint out
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @p_found_id = LCD_ID	
	FROM dbo.DSD_CODE A
	INNER JOIN ITEM b ON a.LCD_ID = b.ITEM_ID
	WHERE a.CL_ID = @p_cl_id  AND ID = @p_code_id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CODELIST_ID]    Script Date: 30/06/2015 08:59:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_CODELIST_ID]
(
	@pId		VARCHAR(100),
	@pAgency	VARCHAR(100),
	@pVersion1	INT,
	@pVersion2	INT,
	@pVersion3	INT,
	@foundId	INT OUTPUT
)
AS
BEGIN

	SELECT @foundId = [ART_ID]
	FROM [dbo].[ARTEFACT]
	WHERE (ID = @pId OR @pId IS NULL)  AND (AGENCY = @pAgency OR @pAgency IS NULL ) AND (VERSION1 = @pVersion1 OR @pVersion1 IS NULL ) AND ( VERSION2 = @pVersion2 OR @pVersion2 IS NULL );

END


GO
/****** Object:  Table [dbo].[WR_USERS]    Script Date: 30/06/2015 08:59:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WR_USERS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[name] [varchar](100) NULL,
	[surname] [varchar](100) NULL,
 CONSTRAINT [PK_WR_USERS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WR_USERS_AGENCY]    Script Date: 30/06/2015 08:59:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WR_USERS_AGENCY](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[wr_users_id] [int] NOT NULL,
	[agency_id] [bigint] NOT NULL
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[WR_USERS] ON 

INSERT [dbo].[WR_USERS] ([id], [username], [password], [name], [surname]) VALUES (1, N'admin', N'nFXAiQJXzlM=', N'Admin', N'Admin')
SET IDENTITY_INSERT [dbo].[WR_USERS] OFF

INSERT [dbo].[WR_USERS_AGENCY] ([wr_users_id], [agency_id]) 
SELECT 1,AG_ID
FROM agency

ALTER TABLE [dbo].[WR_USERS_AGENCY]  WITH CHECK ADD  CONSTRAINT [FK_WR_USERS_ID] FOREIGN KEY([wr_users_id])
REFERENCES [dbo].[WR_USERS] ([id])
GO
ALTER TABLE [dbo].[WR_USERS_AGENCY] CHECK CONSTRAINT [FK_WR_USERS_ID]
GO
