
-- ========================================================================================================================================
-- START											 [Master].[usp_ContactSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select the [Contact] Record based on [Contact] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ContactSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactSelect] 
END 
GO
CREATE PROC [Master].[usp_ContactSelect] 
    @ContactID BIGINT
AS 
 

BEGIN

	SELECT	[ContactID], [AddressLinkID], [EntityType], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], 
			[FaxNumber], [ContactPerson], [MobilePhoneNumber], [EmailID], [IsDefault], [Status] 
	FROM	[Master].[Contact] WITH (NOLOCK)
	WHERE  ([ContactID] = @ContactID) 

END
-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_ContactList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select all the [Contact] Records from [Contact] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ContactList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactList] 
END 
GO
CREATE PROC [Master].[usp_ContactList] 

AS 
 
BEGIN
	SELECT	[ContactID], [AddressLinkID], [EntityType], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], [FaxNumber], 
			[ContactPerson], [MobilePhoneNumber], [EmailID], [IsDefault], [Status] 
	FROM	[Master].[Contact] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ContactInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Inserts the [Contact] Record Into [Contact] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactInsert] 
END 
GO
CREATE PROC [Master].[usp_ContactInsert] 
    @ContactID bigint,
    @AddressLinkID nvarchar(100),
    @EntityType varchar(50),
    @Address1 nvarchar(255),
    @Address2 nvarchar(255),
    @State nvarchar(100),
    @CountryCode varchar(2),
    @PostCode varchar(25),
    @PhoneNumber varchar(50),
    @FaxNumber varchar(50),
    @ContactPerson nvarchar(50),
    @MobilePhoneNumber varchar(25),
    @EmailID varchar(100),
    @IsDefault bit,
    @Status bit
AS 
  

BEGIN
	
	INSERT INTO [Master].[Contact] ([ContactID], [AddressLinkID], [EntityType], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], [FaxNumber], [ContactPerson], [MobilePhoneNumber], [EmailID], [IsDefault], [Status])
	SELECT @ContactID, @AddressLinkID, @EntityType, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, @FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @IsDefault, @Status
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ContactUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	updates the [Contact] Record Into [Contact] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactUpdate] 
END 
GO
CREATE PROC [Master].[usp_ContactUpdate] 
    @ContactID bigint,
    @AddressLinkID nvarchar(100),
    @EntityType varchar(50),
    @Address1 nvarchar(255),
    @Address2 nvarchar(255),
    @State nvarchar(100),
    @CountryCode varchar(2),
    @PostCode varchar(25),
    @PhoneNumber varchar(50),
    @FaxNumber varchar(50),
    @ContactPerson nvarchar(50),
    @MobilePhoneNumber varchar(25),
    @EmailID varchar(100),
    @IsDefault bit,
    @Status bit
AS 
 
	
BEGIN

	UPDATE [Master].[Contact]
	SET    [ContactID] = @ContactID, [AddressLinkID] = @AddressLinkID, [EntityType] = @EntityType, [Address1] = @Address1, [Address2] = @Address2, [State] = @State, [CountryCode] = @CountryCode, [PostCode] = @PostCode, [PhoneNumber] = @PhoneNumber, [FaxNumber] = @FaxNumber, [ContactPerson] = @ContactPerson, [MobilePhoneNumber] = @MobilePhoneNumber, [EmailID] = @EmailID, [IsDefault] = @IsDefault, [Status] = @Status
	WHERE  [ContactID] = @ContactID
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ContactSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Either INSERT or UPDATE the [Contact] Record Into [Contact] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactSave] 
END 
GO
CREATE PROC [Master].[usp_ContactSave] 
    @ContactID bigint,
    @AddressLinkID nvarchar(100),
    @EntityType varchar(50),
    @Address1 nvarchar(255),
    @Address2 nvarchar(255),
    @State nvarchar(100),
    @CountryCode varchar(2),
    @PostCode varchar(25),
    @PhoneNumber varchar(50),
    @FaxNumber varchar(50),
    @ContactPerson nvarchar(50),
    @MobilePhoneNumber varchar(25),
    @EmailID varchar(100),
    @IsDefault bit,
    @Status bit
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[Contact] 
		WHERE 	[ContactID] = @ContactID)>0
	BEGIN
	    Exec [Master].[usp_ContactUpdate] 
		@ContactID, @AddressLinkID, @EntityType, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, @FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @IsDefault, @Status


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_ContactInsert] 
		@ContactID, @AddressLinkID, @EntityType, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, @FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @IsDefault, @Status


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[ContactSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ContactDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Deletes the [Contact] Record  based on [Contact]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactDelete] 
END 
GO
CREATE PROC [Master].[usp_ContactDelete] 
    @ContactID bigint
AS 

	
BEGIN

	UPDATE	[Master].[Contact]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[ContactID] = @ContactID

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Master].[Contact]
	WHERE  [ContactID] = @ContactID
	*/
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactDelete]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_ContactListByCustomer]
-- ========================================================================================================================================
-- Author:			Sharma
-- Create date: 	01-March-2013
-- Description:		-

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactListByCustomer]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ContactListByCustomer] 
END 
GO

CREATE PROCEDURE [Master].[usp_ContactListByCustomer] 
 @AddressLinkID varchar(50),
 @EntityType varchar(50)
 
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.

    -- Insert statements for procedure here
 SELECT [ContactID], [Address1], [Address2], [AddressLinkID],[EntityType], [ContactPerson],[Cntry].[CountryCode],[Cntry].[CountryName], [EmailID], [FaxNumber], [IsDefault], 
    [MobilePhoneNumber], [PhoneNumber], [PostCode], [Social1], [Social2], [State], [WebSite],[Status],CAST(0 as bit) AS IsNewRecord
 FROM   [Master].[Contact] WITH (NOLOCK)
 Left Join [Master].[Country] Cntry WITH (NOLOCK) ON [Master].[Contact].[CountryCode] = [Cntry].[CountryCode]
 WHERE [AddressLinkID] = @AddressLinkID AND [EntityType]=@EntityType
END
-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactListByCustomer]
-- ========================================================================================================================================

GO