CREATE DATABASE [Stammdaten]

USE [Stammdaten]
GO

/****** Object:  Table [dbo].[Personen]    Script Date: 5/15/2024 1:21:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Personen](
	[Name] [nvarchar](50) NULL,
	[Vorname] [nvarchar](50) NULL
) ON [PRIMARY]
GO


USE [Stammdaten]
GO

/****** Object:  StoredProcedure [dbo].[InsertNamen]    Script Date: 5/15/2024 1:22:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertNamen]
    @Namen XML,
	@Vornamen XML
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @VornamenString NVARCHAR(MAX);
    DECLARE @NamenString NVARCHAR(MAX);

    SET @NamenString = CONVERT(NVARCHAR(MAX), @Namen);   
    SET @VornamenString = CONVERT(NVARCHAR(MAX), @Vornamen);

    INSERT INTO Personen (Name, Vorname)
    VALUES (@NamenString, @VornamenString);

    -- Optionally, you can return the inserted XML string as a response
    SELECT * FROM Personen
END
GO


GRANT EXECUTE ON [dbo].[InsertNamen] TO [ACTDIR\BTS_ESB_InpSvcUser];


USE Stammdaten;
GO
CREATE USER [ACTDIR\BTS_ESB_InpSvcUser] FOR LOGIN [ACTDIR\BTS_ESB_InpSvcUser];
GO
EXEC sp_addrolemember N'db_datareader', N'ACTDIR\BTS_ESB_InpSvcUser';
EXEC sp_addrolemember N'db_datawriter', N'ACTDIR\BTS_ESB_InpSvcUser';
GO



