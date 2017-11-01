USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Security].[usp_UserSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [User] Record based on [User] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UserSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserSelect] 
END 
GO
CREATE PROC [Security].[usp_UserSelect] 
    @UserID VARCHAR(10)
AS 
 

BEGIN

	SELECT [UserID], [UserName],[Password], [EmailID], [Status] 
	FROM   [Security].[User] WITH (NOLOCK)
	WHERE  ([UserID] = @UserID ) 

END
-- ========================================================================================================================================
-- END  											 [Security].[usp_UserSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Security].[usp_UserList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [User] Records from [User] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UserList]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserList] 
END 
GO
CREATE PROC [Security].[usp_UserList] 

AS 
 
BEGIN
	SELECT [UserID], [UserName],[Password], [EmailID], [Status] 
	FROM   [Security].[User] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UserInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [User] Record Into [User] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserInsert] 
END 
GO
CREATE PROC [Security].[usp_UserInsert] 
    @UserID varchar(10),
    @UserName varchar(50),
    @Password varchar(20),
    @EmailID varchar(255),
    @Status bit
AS 
  

BEGIN
	
	INSERT INTO [Security].[User] ([UserID], [UserName],[Password], [EmailID], [Status])
	SELECT @UserID, @UserName,@Password, @EmailID, @Status
	
               
END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UserUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [User] Record Into [User] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserUpdate] 
END 
GO
CREATE PROC [Security].[usp_UserUpdate] 
    @UserID varchar(10),
    @UserName varchar(50),
    @Password varchar(20),
    @EmailID varchar(255),
    @Status bit
AS 
 
	
BEGIN

	UPDATE [Security].[User]
	SET    [UserID] = @UserID, [UserName] = @UserName,[Password]=@Password, [EmailID] = @EmailID, [Status] = @Status
	WHERE  [UserID] = @UserID
	

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Security].[usp_UserSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [User] Record Into [User] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserSave]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserSave] 
END 
GO
CREATE PROC [Security].[usp_UserSave] 
    @UserID varchar(10),
    @UserName varchar(50),
    @Password varchar(20),
    @EmailID varchar(255),
    @Status bit
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Security].[User] 
		WHERE 	[UserID] = @UserID)>0
	BEGIN
	    Exec [Security].[usp_UserUpdate] 
		@UserID, @UserName,@Password, @EmailID, @Status


	END
	ELSE
	BEGIN
	    Exec [Security].[usp_UserInsert] 
		@UserID, @UserName,@Password, @EmailID, @Status


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Security].usp_[UserSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Security].[usp_UserDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [User] Record  based on [User]

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserDelete] 
END 
GO
CREATE PROC [Security].[usp_UserDelete] 
    @UserID varchar(10)
AS 

	
BEGIN

	UPDATE	[Security].[User]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[UserID] = @UserID

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Security].[User]
	WHERE  [UserID] = @UserID
	*/
END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserDelete]
-- ========================================================================================================================================

GO
 