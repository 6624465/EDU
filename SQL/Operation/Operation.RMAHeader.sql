

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [RMAHeader] Record based on [RMAHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderSelect] 
    @DocumentNo VARCHAR(50),
	@CountryCode nvarchar(3),
	@EmailID nvarchar(50)
AS 
 

BEGIN

	SELECT	[DocumentNo], CountryCode,EmailID,ContactNo, [IncidentDate],CustomerAddress, [Status], 
			[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], IsCompleted
	FROM	[Operation].[RMAHeader] 
	WHERE	[DocumentNo] = @DocumentNo 
	And CountryCode = @CountryCode
	And EmailID = @EmailID

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [RMAHeader] Records from [RMAHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_RMAHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderList] 
		@CountryCode nvarchar(3)

AS 
 
BEGIN
	SELECT [DocumentNo], CountryCode,EmailID,ContactNo, [IncidentDate],CustomerAddress, [Status], 
			[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] ,IsCompleted
	FROM   [Operation].[RMAHeader] 
	WHERE  CountryCode = @CountryCode 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAHeaderList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [RMAHeader] Record Into [RMAHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderInsert] 
    @DocumentNo varchar(50),
	@CountryCode nvarchar(3),
	@EmailID nvarchar(50),
	@ContactNo nvarchar(20),
    @IncidentDate datetime,
	@CustomerAddress nvarchar(200),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[RMAHeader] (
			[DocumentNo],[CountryCode],[EmailID],[ContactNo], [IncidentDate],[CustomerAddress], [Status], [CreatedBy], [CreatedOn],IsCompleted)
	SELECT	@DocumentNo,@CountryCode,@EmailID,@ContactNo,@IncidentDate,@CustomerAddress, @Status, @CreatedBy, GETDATE() ,Cast(0 as bit)
	
	
	SELECT @NewDocumentNo = @DocumentNo 
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAHeaderInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [RMAHeader] Record Into [RMAHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderUpdate] 
    @DocumentNo varchar(50),
	@CountryCode nvarchar(3),
	@EmailID nvarchar(50),
	@ContactNo nvarchar(20),
    @IncidentDate datetime,
	@CustomerAddress nvarchar(200),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
    
AS 
 
	
BEGIN

	UPDATE	[Operation].[RMAHeader]
	SET		[IncidentDate] = @IncidentDate,ContactNo = @ContactNo, CustomerAddress = @CustomerAddress,
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[DocumentNo] = @DocumentNo
	And CountryCode = @CountryCode
	And EmailID = @EmailID
	
	
	SELECT @NewDocumentNo = @DocumentNo 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAHeaderUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [RMAHeader] Record Into [RMAHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderSave] 
    @DocumentNo varchar(50),
	@CountryCode nvarchar(3),
	@EmailID nvarchar(50),
	@ContactNo nvarchar(20),
    @IncidentDate datetime,
	@CustomerAddress nvarchar(200),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN

 Declare @Dt dateTime,
		 @DocID varchar(25),
		 @BranchID smallint


	IF (SELECT COUNT(0) FROM [Operation].[RMAHeader] 
		WHERE 	[DocumentNo] = @DocumentNo And EmailID = @EmailID and CountryCode = @CountryCode)>0
	BEGIN
	    Exec [Operation].[usp_RMAHeaderUpdate] 
		@DocumentNo,@CountryCode,@EmailID,@ContactNo, @IncidentDate, @CustomerAddress, @Status, @CreatedBy, @ModifiedBy,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN
	
		Select @Dt = GETDATE() ,@DocID 	='RMAIncident',@BranchID=100
		print @DocID
	
	
		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 100, 'RMAIncident', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
	
	
		Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @DocumentNo OUTPUT
		
			
	    Exec [Operation].[usp_RMAHeaderInsert] 
		@DocumentNo,@CountryCode,@EmailID,@ContactNo, @IncidentDate, @CustomerAddress, @Status, @CreatedBy, @ModifiedBy,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[RMAHeaderSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [RMAHeader] Record  based on [RMAHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderDelete] 
    @DocumentNo varchar(50),
	@CountryCode nvarchar(3),
	@EmailID nvarchar(50)
AS 

	
BEGIN

 
	 
	UPDATE	[Operation].[RMAHeader]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[DocumentNo] = @DocumentNo
	And CountryCode = @CountryCode
	And EmailID = @EmailID
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_RMAHeaderDelete]
-- ========================================================================================================================================

GO


  