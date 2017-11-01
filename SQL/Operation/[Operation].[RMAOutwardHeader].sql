 
-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [RMAOutwardHeader] Record based on [RMAOutwardHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderSelect] 
    @BranchID smallint,
    @DocumentNo varchar(50)
AS 
 

BEGIN

	SELECT [BranchID], [DocumentNo], [DocumentDate], [ReferenceNo], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[RMAOutwardHeader]
	WHERE  [BranchID] = @BranchID 
	       AND [DocumentNo] = @DocumentNo

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [RMAOutwardHeader] Records from [RMAOutwardHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderList] 
    @BranchID smallint
AS 
 
BEGIN
	SELECT [BranchID], [DocumentNo], [DocumentDate], [ReferenceNo], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]  
	FROM   [Operation].[RMAOutwardHeader]
		WHERE  [BranchID] = @BranchID 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardHeaderList] 
-- ========================================================================================================================================

GO


 

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [RMAOutwardHeader] Record Into [RMAOutwardHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderInsert] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @DocumentDate datetime = NULL,
    @ReferenceNo varchar(50),
    @CreatedBy varchar(50) = NULL,
    @ModifiedBy varchar(50) = NULL,
	@NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[RMAOutwardHeader] (
			[BranchID], [DocumentNo], [DocumentDate], [ReferenceNo], [Status], [CreatedBy], [CreatedOn] )
	SELECT	@BranchID, @DocumentNo, @DocumentDate, @ReferenceNo, Cast(1 as bit), @CreatedBy, getutcdate()
	
		Select @NewDocumentNo = @DocumentNo
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardHeaderInsert]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [RMAOutwardHeader] Record Into [RMAOutwardHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderUpdate] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @DocumentDate datetime = NULL,
    @ReferenceNo varchar(50),
    @CreatedBy varchar(50) = NULL,
    @ModifiedBy varchar(50) = NULL,
	@NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE [Operation].[RMAOutwardHeader]
	SET     [DocumentDate] = @DocumentDate, [ReferenceNo] = @ReferenceNo,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = getutcdate()
	WHERE  [BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo
	
	Select @NewDocumentNo = @DocumentNo
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardHeaderUpdate]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [RMAOutwardHeader] Record Into [RMAOutwardHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderSave] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @DocumentDate datetime = NULL,
    @ReferenceNo varchar(50),
    @CreatedBy varchar(50) = NULL,
    @ModifiedBy varchar(50) = NULL,
	@NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[RMAOutwardHeader] 
		WHERE 	[BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo)>0
	BEGIN
	    Exec [Operation].[usp_RMAOutwardHeaderUpdate] 
		@BranchID, @DocumentNo, @DocumentDate, @ReferenceNo, @CreatedBy,  @ModifiedBy ,@NewDocumentNo = @NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN
		declare @dt datetime,
				@DocID varchar(20)

		Select @Dt = GETDATE() ,@DocID 	='RMAOutward' 
		print @DocID
	
	
		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10, 'RMAOutward', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
	
		Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @DocumentNo OUTPUT


	    Exec [Operation].[usp_RMAOutwardHeaderInsert] 
		@BranchID, @DocumentNo, @DocumentDate, @ReferenceNo, @CreatedBy,  @ModifiedBy ,@NewDocumentNo = @NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[RMAOutwardHeaderSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [RMAOutwardHeader] Record  based on [RMAOutwardHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardHeaderDelete] 
    @BranchID smallint,
    @DocumentNo varchar(50)
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[RMAOutwardHeader]
	WHERE  [BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardHeaderDelete]
-- ========================================================================================================================================

GO 