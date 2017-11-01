
-- ========================================================================================================================================
-- START											 [Master].[usp_SiteSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select the [Site] Record based on [Site] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_SiteSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteSelect] 
END 
GO
CREATE PROC [Master].[usp_SiteSelect] 
    @SiteCode VARCHAR(10)
AS 
 

BEGIN

	SELECT [SiteCode], [SitePrefix], [SiteName], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Site] WITH (NOLOCK)
	WHERE  ([SiteCode] = @SiteCode) 

END
-- ========================================================================================================================================
-- END  											 [Master].[usp_SiteSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_SiteList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select all the [Site] Records from [Site] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_SiteList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteList] 
END 
GO
CREATE PROC [Master].[usp_SiteList] 

AS 
 
BEGIN
	SELECT [SiteCode], [SitePrefix], [SiteName], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Site] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_SiteList] 
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_SiteInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Inserts the [Site] Record Into [Site] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_SiteInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteInsert] 
END 
GO
CREATE PROC [Master].[usp_SiteInsert] 
    @SiteCode varchar(10),
    @SitePrefix varchar(2),
    @SiteName varchar(100),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
  

BEGIN
	
	INSERT INTO [Master].[Site] 
		([SiteCode], [SitePrefix], [SiteName], [Status], [CreatedBy], [CreatedOn])
	SELECT @SiteCode, @SitePrefix, @SiteName, @Status, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_SiteInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_SiteUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	updates the [Site] Record Into [Site] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_SiteUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteUpdate] 
END 
GO
CREATE PROC [Master].[usp_SiteUpdate] 
    @SiteCode varchar(10),
    @SitePrefix varchar(2),
    @SiteName varchar(100),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 
	
BEGIN

	UPDATE [Master].[Site]
	SET    [SitePrefix] = @SitePrefix, [SiteName] = @SiteName, [Status] = @Status, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [SiteCode] = @SiteCode
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_SiteUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_SiteSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Either INSERT or UPDATE the [Site] Record Into [Site] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_SiteSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteSave] 
END 
GO
CREATE PROC [Master].[usp_SiteSave] 
    @SiteCode varchar(10),
    @SitePrefix varchar(2),
    @SiteName varchar(100),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[Site] 
		WHERE 	[SiteCode] = @SiteCode)>0
	BEGIN
	    Exec [Master].[usp_SiteUpdate] 
			@SiteCode, @SitePrefix, @SiteName, @Status, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_SiteInsert] 
			@SiteCode, @SitePrefix, @SiteName, @Status, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[SiteSave]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_SiteDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Deletes the [Site] Record  based on [Site]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_SiteDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SiteDelete] 
END 
GO
CREATE PROC [Master].[usp_SiteDelete] 
    @SiteCode varchar(10)
AS 

	
BEGIN

	UPDATE	[Master].[Site]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[SiteCode] = @SiteCode

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Master].[Site]
	WHERE  [SiteCode] = @SiteCode
	*/
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_SiteDelete]
-- ========================================================================================================================================

GO

