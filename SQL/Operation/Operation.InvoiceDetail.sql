USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InvoiceDetail] Record based on [InvoiceDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InvoiceDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailSelect] 
    @DocumentNo varchar(50),
    @InvoiceNo VARCHAR(50),
    @ModelNo VARCHAR(50),
    @SerialNo VARCHAR(50)
AS 
 

BEGIN

	SELECT DocumentNo, [InvoiceNo], [ModelNo], [SerialNo], [Make], [ExpiryDate], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceDetail] WITH (NOLOCK)
	WHERE  DocumentNo = @DocumentNo
			AND [InvoiceNo] = @InvoiceNo 
	       AND [ModelNo] = @ModelNo 
	       AND [SerialNo] = @SerialNo 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [InvoiceDetail] Records from [InvoiceDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InvoiceDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailList] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailList] 
	@DocumentNo varchar(50)
AS 
 
BEGIN
	SELECT DocumentNo,[InvoiceNo], [ModelNo], [SerialNo], [Make], [ExpiryDate], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceDetail] WITH (NOLOCK)
	where DocumentNo = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceDetailList] 
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [InvoiceDetail] Record Into [InvoiceDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailInsert] 
    @DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @ModelNo varchar(50),
    @SerialNo varchar(50),
    @Make varchar(50),
    @ExpiryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Operation].[InvoiceDetail] (DocumentNo, [InvoiceNo], [ModelNo], [SerialNo], [Make], [ExpiryDate], 
				[CreatedBy], [CreatedOn])
	SELECT		@DocumentNo,@InvoiceNo, @ModelNo, @SerialNo, @Make, @ExpiryDate, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceDetailInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [InvoiceDetail] Record Into [InvoiceDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailUpdate] 
    @DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @ModelNo varchar(50),
    @SerialNo varchar(50),
    @Make varchar(50),
    @ExpiryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
    
AS 
 
	
BEGIN

	UPDATE	[Operation].[InvoiceDetail]
	SET		[Make] = @Make, [ExpiryDate] = @ExpiryDate, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	DocumentNo = @DocumentNo
			AND [InvoiceNo] = @InvoiceNo
			AND [ModelNo] = @ModelNo
			AND [SerialNo] = @SerialNo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceDetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [InvoiceDetail] Record Into [InvoiceDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailSave] 
    @DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @ModelNo varchar(50),
    @SerialNo varchar(50),
    @Make varchar(50),
    @ExpiryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[InvoiceDetail] 
		WHERE 	[InvoiceNo] = @InvoiceNo
	       AND [ModelNo] = @ModelNo
	       AND [SerialNo] = @SerialNo)>0
	BEGIN
	    Exec [Operation].[usp_InvoiceDetailUpdate] 
		@DocumentNo,@InvoiceNo, @ModelNo, @SerialNo, @Make, @ExpiryDate, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_InvoiceDetailInsert] 
		@DocumentNo,@InvoiceNo, @ModelNo, @SerialNo, @Make, @ExpiryDate, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[InvoiceDetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [InvoiceDetail] Record  based on [InvoiceDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailDelete] 
    @DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @ModelNo varchar(50),
    @SerialNo varchar(50)
AS 

	
BEGIN

	DELETE
	FROM   [Operation].[InvoiceDetail]
	WHERE  DocumentNo = @DocumentNo
			AND	[InvoiceNo] = @InvoiceNo
	       AND [ModelNo] = @ModelNo
	       AND [SerialNo] = @SerialNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceDetailDelete]
-- ========================================================================================================================================

GO


