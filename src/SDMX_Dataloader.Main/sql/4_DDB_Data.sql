DELETE FROM [dbo].[DATA_MAPPING]
GO
DELETE FROM [dbo].[CAT_MAPPING]
GO
DELETE FROM [dbo].[localised_CatTheme]
GO
DELETE FROM [dbo].[localised_CatSet]
GO
DELETE FROM [dbo].[localised_CatDim]
GO
DELETE FROM [dbo].[localised_CatDataFlow]
GO
DELETE FROM [dbo].[localised_CatAtt]
GO
DELETE FROM [dbo].[CatTheme]
GO
DELETE FROM [dbo].[CatDim]
GO
DELETE FROM [dbo].[CatAttDim]
GO
DELETE FROM [dbo].[CatAtt]
GO
DELETE FROM [dbo].[USER]
GO
DELETE FROM [dbo].[ROLE]
GO
DELETE FROM [dbo].[DOMAIN]
GO
DELETE FROM [dbo].[CatDataFlow]
GO
DELETE FROM [dbo].[CatSet]
GO
INSERT [dbo].[ROLE] ([ID_ROLE], [DESC_ROLE]) VALUES (0, N'Administrator')
INSERT [dbo].[ROLE] ([ID_ROLE], [DESC_ROLE]) VALUES (1, N'Operator')
SET IDENTITY_INSERT [dbo].[USER] ON 

INSERT [dbo].[USER] ([ID_USER], [USERNAME], [PWD], [ID_ROLE], [NAME], [SURNAME], [EMAIL], [PROFLAG]) VALUES (1, N'admin', N'21232f297a57a5a743894a0e4a801fc3', 0, N'admin', N'admin', N'', 1)
SET IDENTITY_INSERT [dbo].[USER] OFF

