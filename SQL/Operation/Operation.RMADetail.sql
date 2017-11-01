

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [RMADetail] Record based on [RMADetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMADetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailSelect] 
    @DocumentNo VARCHAR(50),
    @SerialNo varchar(50)
AS 
 

BEGIN

	
	SELECT [DocumentNo], [SerialNo],[WarrantyExpiryDate],[IsValid] , [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]
	FROM   [Operation].[RMADetail] Dt 
	WHERE   [DocumentNo] = @DocumentNo  
	       AND  [SerialNo] = @SerialNo 
	        

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMADetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [RMADetail] Records from [RMADetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMADetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailList] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailList] 
	@DocumentNo varchar(50)
AS 
 
BEGIN

	SELECT [DocumentNo], [SerialNo],[WarrantyExpiryDate],[IsValid] , [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]
	FROM   [Operation].[RMADetail] Dt 
	WHERE   [DocumentNo] = @DocumentNo  
	       

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMADetailList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [RMADetail] Record Into [RMADetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMADetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailInsert] 
    @DocumentNo varchar(50),
    @SerialNo varchar(50),
    @WarrantyExpiryDate datetime,
	@IsValid bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
  

BEGIN
	
	INSERT INTO [Operation].[RMADetail] (
			[DocumentNo], [SerialNo], [WarrantyExpiryDate], [IsValid], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo, @SerialNo, @WarrantyExpiryDate, @IsValid, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMADetailInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [RMADetail] Record Into [RMADetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMADetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailUpdate] 
    @DocumentNo varchar(50),
    @SerialNo varchar(50),
    @WarrantyExpiryDate datetime,
	@IsValid bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 
	
BEGIN

	UPDATE	[Operation].[RMADetail]
	SET		WarrantyExpiryDate=@WarrantyExpiryDate,IsValid=@IsValid, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[DocumentNo] = @DocumentNo
			AND SerialNo = @SerialNo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMADetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [RMADetail] Record Into [RMADetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMADetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailSave] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailSave] 
    @DocumentNo varchar(50),
    @SerialNo varchar(50),
    @WarrantyExpiryDate datetime,
	@IsValid bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[RMADetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND SerialNo = @SerialNo)>0
	BEGIN
	    Exec [Operation].[usp_RMADetailUpdate] 
		DocumentNo, @SerialNo, @WarrantyExpiryDate, @IsValid, @CreatedBy, @ModifiedBy
	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_RMADetailInsert] 
		DocumentNo, @SerialNo, @WarrantyExpiryDate, @IsValid,@CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[RMADetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_RMADetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [RMADetail] Record  based on [RMADetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMADetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMADetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_RMADetailDelete] 
    @DocumentNo varchar(50),
    @SerialNo varchar(50)
AS 

	
BEGIN


	DELETE
	FROM   [Operation].[RMADetail]
	WHERE  [DocumentNo] = @DocumentNo
	       AND [SerialNo] = @SerialNo
	
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMADetailDelete]
-- ========================================================================================================================================

GO

 