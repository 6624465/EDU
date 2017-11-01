USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Config].[usp_LookupSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select the [Lookup] Record based on [Lookup] table
-- ========================================================================================================================================


IF OBJECT_ID('[Config].[usp_LookupSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupSelect] 
END 
GO
CREATE PROC [Config].[usp_LookupSelect] 
    @LookupID SMALLINT
AS 
 

BEGIN

	SELECT [LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Config].[Lookup] WITH (NOLOCK)
	WHERE  ([LookupID] = @LookupID) 

END
-- ========================================================================================================================================
-- END  											 [Config].[usp_LookupSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Config].[usp_LookupList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select all the [Lookup] Records from [Lookup] table
-- ========================================================================================================================================


IF OBJECT_ID('[Config].[usp_LookupList]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupList] 
END 
GO
CREATE PROC [Config].[usp_LookupList] 

AS 
 
BEGIN
	SELECT [LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Config].[Lookup] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Config].[usp_LookupList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Config].[usp_LookupInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Inserts the [Lookup] Record Into [Lookup] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_LookupInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupInsert] 
END 
GO
CREATE PROC [Config].[usp_LookupInsert] 
    @LookupID smallint,
    @LookupCode varchar(25),
    @LookupDescription varchar(255),
    @LookupCategory varchar(50),
    @Status bit,
    @ISOCode varchar(25),
    @MappingCode varchar(25),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Config].[Lookup] 
			([LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn])
	SELECT	 @LookupID, @LookupCode, @LookupDescription, @LookupCategory, @Status, @ISOCode, @MappingCode, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Config].[usp_LookupInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_LookupUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	updates the [Lookup] Record Into [Lookup] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_LookupUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupUpdate] 
END 
GO
CREATE PROC [Config].[usp_LookupUpdate] 
    @LookupID smallint,
    @LookupCode varchar(25),
    @LookupDescription varchar(255),
    @LookupCategory varchar(50),
    @Status bit,
    @ISOCode varchar(25),
    @MappingCode varchar(25),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 
	
BEGIN

	UPDATE	[Config].[Lookup]
	SET		[LookupID] = @LookupID, [LookupCode] = @LookupCode, [LookupDescription] = @LookupDescription, [LookupCategory] = @LookupCategory, 
			[Status] = @Status, [ISOCode] = @ISOCode, [MappingCode] = @MappingCode, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[LookupID] = @LookupID
	

END

-- ========================================================================================================================================
-- END  											 [Config].[usp_LookupUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_LookupSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Either INSERT or UPDATE the [Lookup] Record Into [Lookup] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_LookupSave]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupSave] 
END 
GO
CREATE PROC [Config].[usp_LookupSave] 
    @LookupID smallint,
    @LookupCode varchar(25),
    @LookupDescription varchar(255),
    @LookupCategory varchar(50),
    @Status bit,
    @ISOCode varchar(25),
    @MappingCode varchar(25),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Config].[Lookup] 
		WHERE 	[LookupID] = @LookupID)>0
	BEGIN
	    Exec [Config].[usp_LookupUpdate] 
			@LookupID, @LookupCode, @LookupDescription, @LookupCategory, @Status, @ISOCode, @MappingCode, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Config].[usp_LookupInsert] 
			@LookupID, @LookupCode, @LookupDescription, @LookupCategory, @Status, @ISOCode, @MappingCode, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Config].usp_[LookupSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Config].[usp_LookupDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Deletes the [Lookup] Record  based on [Lookup]

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_LookupDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupDelete] 
END 
GO
CREATE PROC [Config].[usp_LookupDelete] 
    @LookupID smallint
AS 

	
BEGIN

	UPDATE	[Config].[Lookup]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[LookupID] = @LookupID

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Config].[Lookup]
	WHERE  [LookupID] = @LookupID
	*/
END

-- ========================================================================================================================================
-- END  											 [Config].[usp_LookupDelete]
-- ========================================================================================================================================

GO

