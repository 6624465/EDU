
-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [Customer] Record based on [Customer] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_CustomerSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerSelect] 
END 
GO
CREATE PROC [Master].[usp_CustomerSelect] 
	@BranchID smallint,
    @CustomerCode VARCHAR(10)
AS 
 

BEGIN

	;With CustomerTypeDescription As
	(Select LookupID,LookupCode,LookupCategory From Config.Lookup where LookupCategory='CustomerType')

	SELECT 
		[BranchID], [CustomerCode], [CustomerName], [CustomerType], [Status], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], 
		[FaxNumber], [ContactPerson], [MobilePhoneNumber], [EmailID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],CTD.LookupCode As CustomerTypeDescription 
	FROM   [Master].[Customer] Cst  
	LEFT OUTER JOIN CustomerTypeDescription CTD  ON
		cst.CustomerType = ctd.LookupID
	WHERE  
	[BranchID] = @BranchID 
	AND [CustomerCode] = @CustomerCode
END
-- ========================================================================================================================================
-- END  											 [Master].[usp_CustomerSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [Customer] Records from [Customer] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_CustomerList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerList] 
END 
GO
CREATE PROC [Master].[usp_CustomerList] 
	@BranchID smallint
AS 
 
BEGIN
	
	;With CustomerTypeDescription As
	(Select LookupID,LookupCode,LookupCategory From Config.Lookup where LookupCategory='CustomerType')

	SELECT 
		[BranchID],[CustomerCode], [CustomerName], [CustomerType], [Status], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], 
		[FaxNumber], [ContactPerson], [MobilePhoneNumber], [EmailID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],CTD.LookupCode As CustomerTypeDescription 
	FROM   [Master].[Customer] Cst WITH (NOLOCK)
	LEFT OUTER JOIN CustomerTypeDescription CTD WITH (NOLOCK) ON
		cst.CustomerType = ctd.LookupID
	WHERE  
	[BranchID] = @BranchID 
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_CustomerList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [Customer] Record Into [Customer] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_CustomerInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerInsert] 
END 
GO
CREATE PROC [Master].[usp_CustomerInsert] 
    @BranchID smallint, 
    @CustomerCode varchar(10),
    @CustomerName nvarchar(255),
    @CustomerType smallint,
    @Status bit,
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
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Master].[Customer] 
			(BranchID,[CustomerCode], [CustomerName], [CustomerType], [Status], [Address1], [Address2], [State], [CountryCode], [PostCode], [PhoneNumber], 
			 [FaxNumber], [ContactPerson], [MobilePhoneNumber], [EmailID], [CreatedBy], [CreatedOn])
	SELECT	@BranchID,@CustomerCode, @CustomerName, @CustomerType, @Status, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, 
			@FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_CustomerInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [Customer] Record Into [Customer] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_CustomerUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerUpdate] 
END 
GO
CREATE PROC [Master].[usp_CustomerUpdate] 
    @BranchID smallint, 
    @CustomerCode varchar(10),
    @CustomerName nvarchar(255),
    @CustomerType smallint,
    @Status bit,
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
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE	[Master].[Customer]
	SET		[CustomerName] = @CustomerName, [CustomerType] = @CustomerType, [Status] = @Status, [Address1] = @Address1, [Address2] = @Address2, 
			[State] = @State, [CountryCode] = @CountryCode, [PostCode] = @PostCode, [PhoneNumber] = @PhoneNumber, [FaxNumber] = @FaxNumber, 
			[ContactPerson] = @ContactPerson, [MobilePhoneNumber] = @MobilePhoneNumber, [EmailID] = @EmailID, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[BranchID]= @BranchID
	AND [CustomerCode] = @CustomerCode
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_CustomerUpdate]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [Customer] Record Into [Customer] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_CustomerSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerSave] 
END 
GO
CREATE PROC [Master].[usp_CustomerSave] 
    @BranchID smallint, 
    @CustomerCode varchar(10),
    @CustomerName nvarchar(255),
    @CustomerType smallint,
    @Status bit,
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
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[Customer] 
		WHERE 	[CustomerCode] = @CustomerCode)>0
	BEGIN
	    Exec [Master].[usp_CustomerUpdate] 
		@BranchID,@CustomerCode, @CustomerName, @CustomerType, @Status, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, @FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_CustomerInsert] 
		@BranchID,@CustomerCode, @CustomerName, @CustomerType, @Status, @Address1, @Address2, @State, @CountryCode, @PostCode, @PhoneNumber, @FaxNumber, @ContactPerson, @MobilePhoneNumber, @EmailID, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[CustomerSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_CustomerDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [Customer] Record  based on [Customer]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_CustomerDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerDelete] 
END 
GO
CREATE PROC [Master].[usp_CustomerDelete] 
   @BranchID smallint, 
   @CustomerCode varchar(10)
AS 

	
BEGIN

	UPDATE	[Master].[Customer]
	SET	[Status] = CAST(0 as bit)
	WHERE 	
	[BranchID]= @BranchID
	AND [CustomerCode] = @CustomerCode

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Master].[Customer]
	WHERE  [CustomerCode] = @CustomerCode
	*/
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_CustomerDelete]
-- ========================================================================================================================================

GO


