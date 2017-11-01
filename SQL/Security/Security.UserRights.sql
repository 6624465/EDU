USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [UserRights] Record based on [UserRights] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UserRightsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsSelect] 
END 
GO
CREATE PROC [Security].[usp_UserRightsSelect] 
    @UserID VARCHAR(10),
    @SecurableItem VARCHAR(50),
    @Permission VARCHAR(200)
AS 
 

BEGIN

	SELECT [UserID], [SecurableItem], [Permission], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Security].[UserRights] WITH (NOLOCK)
	WHERE  ([UserID] = @UserID ) 
	       AND ([SecurableItem] = @SecurableItem ) 
	       AND ([Permission] = @Permission ) 

END
-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [UserRights] Records from [UserRights] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UserRightsList]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsList] 
END 
GO
CREATE PROC [Security].[usp_UserRightsList] 

AS 
 
BEGIN
	SELECT [UserID], [SecurableItem], [Permission], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Security].[UserRights] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [UserRights] Records from [UserRights] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UserRightsListByUser]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsListByUser] 
END 
GO
CREATE PROC [Security].[usp_UserRightsListByUser] 
@UserID varchar(10)
AS 
 
BEGIN
	SELECT [UserID], [SecurableItem], [Permission], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Security].[UserRights] WITH (NOLOCK)
	WHERE	UserID = @UserID

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [UserRights] Record Into [UserRights] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserRightsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsInsert] 
END 
GO
CREATE PROC [Security].[usp_UserRightsInsert] 
    @UserID varchar(10),
    @SecurableItem varchar(50),
    @Permission varchar(200),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Security].[UserRights] ([UserID], [SecurableItem], [Permission], [CreatedBy], [CreatedOn])
	SELECT @UserID, @SecurableItem, @Permission, @CreatedBy, GETDATE() 
	
               
END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [UserRights] Record Into [UserRights] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserRightsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsUpdate] 
END 
GO
CREATE PROC [Security].[usp_UserRightsUpdate] 
    @UserID varchar(10),
    @SecurableItem varchar(50),
    @Permission varchar(200),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE [Security].[UserRights]
	SET    [UserID] = @UserID, [SecurableItem] = @SecurableItem, [Permission] = @Permission, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [UserID] = @UserID
	       AND [SecurableItem] = @SecurableItem
	       AND [Permission] = @Permission
	

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsUpdate]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [UserRights] Record Into [UserRights] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserRightsSave]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsSave] 
END 
GO
CREATE PROC [Security].[usp_UserRightsSave] 
    @UserID varchar(10),
    @SecurableItem varchar(50),
    @Permission varchar(200),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Security].[UserRights] 
		WHERE 	[UserID] = @UserID
	       AND [SecurableItem] = @SecurableItem
	       AND [Permission] = @Permission)>0
	BEGIN
	    Exec [Security].[usp_UserRightsUpdate] 
		@UserID, @SecurableItem, @Permission, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Security].[usp_UserRightsInsert] 
		@UserID, @SecurableItem, @Permission, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Security].usp_[UserRightsSave]
-- ========================================================================================================================================

GO





-- ========================================================================================================================================
-- START											 [Security].[usp_UserRightsDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [UserRights] Record  based on [UserRights]

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UserRightsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UserRightsDelete] 
END 
GO
CREATE PROC [Security].[usp_UserRightsDelete] 
    @UserID varchar(10),
    @SecurableItem varchar(50),
    @Permission varchar(200)
AS 

	
BEGIN


	DELETE
	FROM   [Security].[UserRights]
	WHERE  [UserID] = @UserID
	       AND [SecurableItem] = @SecurableItem
	       AND [Permission] = @Permission

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UserRightsDelete]
-- ========================================================================================================================================

GO

