-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [RMAOutwardDetail] Record based on [RMAOutwardDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailSelect] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @OldSerialNo varchar(50)
AS 
 

BEGIN

	SELECT	Rma.[BranchID], Rma.[DocumentNo], Rma.[OldSerialNo], Rma.[ProductCode], Rma.[NewSerialNo], Rma.[IsCreditNote], 
			Rma.[CreatedBy], Rma.[CreatedOn], Rma.[ModifiedBy], Rma.[ModifiedOn] , Prd.Description As ProductDescription
	FROM	[Operation].[RMAOutwardDetail] Rma
	Left Outer Join Master.Product Prd On 
		Rma.ProductCode = Prd.ProductCode
	WHERE	Rma.[BranchID] = @BranchID  
			AND Rma.[DocumentNo] = @DocumentNo  
			AND Rma.[OldSerialNo] = @OldSerialNo 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [RMAOutwardDetail] Records from [RMAOutwardDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailList] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailList] 
    @BranchID smallint,
	@DocumentNo varchar(50)
AS 
 
BEGIN
	SELECT	Rma.[BranchID], Rma.[DocumentNo], Rma.[OldSerialNo], Rma.[ProductCode], Rma.[NewSerialNo], Rma.[IsCreditNote], 
			Rma.[CreatedBy], Rma.[CreatedOn], Rma.[ModifiedBy], Rma.[ModifiedOn] , Prd.Description As ProductDescription
	FROM	[Operation].[RMAOutwardDetail] Rma
	Left Outer Join Master.Product Prd On 
		Rma.ProductCode = Prd.ProductCode
	WHERE	Rma.[BranchID] = @BranchID
	And DocumentNo = @DocumentNo  

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardDetailList] 
-- ========================================================================================================================================

GO


 
-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [RMAOutwardDetail] Record Into [RMAOutwardDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailInsert] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @OldSerialNo varchar(50),
    @ProductCode varchar(50),
    @NewSerialNo varchar(50) = NULL,
    @IsCreditNote bit = NULL,
    @CreatedBy varchar(25) = NULL,
    @ModifiedBy varchar(25) = NULL
AS 
  

BEGIN
	
	INSERT INTO [Operation].[RMAOutwardDetail] (
			[BranchID], [DocumentNo], [OldSerialNo], [ProductCode], [NewSerialNo], [IsCreditNote], [CreatedBy], [CreatedOn] )
	SELECT	@BranchID, @DocumentNo, @OldSerialNo, @ProductCode, @NewSerialNo, @IsCreditNote, @CreatedBy, GetUtcDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardDetailInsert]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [RMAOutwardDetail] Record Into [RMAOutwardDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailUpdate] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @OldSerialNo varchar(50),
    @ProductCode varchar(50),
    @NewSerialNo varchar(50) = NULL,
    @IsCreditNote bit = NULL,
    @CreatedBy varchar(25) = NULL,
    @ModifiedBy varchar(25) = NULL
AS 
 
	
BEGIN

	UPDATE [Operation].[RMAOutwardDetail]
	SET    [ProductCode] = @ProductCode, [NewSerialNo] = @NewSerialNo, [IsCreditNote] = @IsCreditNote,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = getutcdate()
	WHERE  [BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo
	       AND [OldSerialNo] = @OldSerialNo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardDetailUpdate]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [RMAOutwardDetail] Record Into [RMAOutwardDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailSave] 
    @BranchID smallint,
    @DocumentNo varchar(50),
    @OldSerialNo varchar(50),
    @ProductCode varchar(50),
    @NewSerialNo varchar(50) = NULL,
    @IsCreditNote bit = NULL,
    @CreatedBy varchar(25) = NULL,
    @ModifiedBy varchar(25) = NULL
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[RMAOutwardDetail] 
		WHERE 	[BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo
	       AND [OldSerialNo] = @OldSerialNo)>0
	BEGIN
	    Exec [Operation].[usp_RMAOutwardDetailUpdate] 
			@BranchID, @DocumentNo, @OldSerialNo, @ProductCode, @NewSerialNo, @IsCreditNote, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_RMAOutwardDetailInsert] 
			@BranchID, @DocumentNo, @OldSerialNo, @ProductCode, @NewSerialNo, @IsCreditNote, @CreatedBy, @ModifiedBy 

	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[RMAOutwardDetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAOutwardDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [RMAOutwardDetail] Record  based on [RMAOutwardDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAOutwardDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAOutwardDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_RMAOutwardDetailDelete] 
    @BranchID smallint,
    @DocumentNo varchar(50) 
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[RMAOutwardDetail]
	WHERE  [BranchID] = @BranchID
	       AND [DocumentNo] = @DocumentNo
	       
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAOutwardDetailDelete]
-- ========================================================================================================================================

GO 