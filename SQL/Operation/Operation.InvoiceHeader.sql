 

-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InvoiceHeader] Record based on [InvoiceHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InvoiceHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderSelect]
	@BranchID	smallint, 
    @DocumentNo VARCHAR(50),
    @InvoiceNo VARCHAR(50),
    @InvoiceType SMALLINT
AS 
 

BEGIN

	;With ProductCategoryDescription As (Select LookupId,LookupDescription From Config.Lookup where LookupCategory='ProductCategory'),
	InvoiceTypeDescription As (Select LookupId,LookupDescription From Config.Lookup where LookupCategory='InvoiceType')
	SELECT  InHd.BranchID,InHd.[DocumentNo],InHd.[InvoiceNo], InHd.[InvoiceType], InHd.[InvoiceDate], InHd.[CustomerCode], InHd.[ProductCode], InHd.[WarrantyPeriod], 
			InHd.[Status], InHd.[FileName], InHd.[CreatedBy], InHd.[CreatedOn], InHd.[ModifiedBy], InHd.[ModifiedOn],
			InHd.[Quantity],InHd.[UnitPrice],InHd.[CurrencyCode],InHd.[ProductCategory],InHd.[ModelNo] ,
			Cust.CustomerName,
			ISNULL(PD.LookupDescription,'') As ProductCategoryDescription,
			ISNULL(ID.LookupDescription,'') As InvoiceTypeDescription
	FROM	[Operation].[InvoiceHeader]  InHd
	Left Outer Join Master.Customer Cust ON 
		InHd.BranchID = Cust.BranchID 
		And InHd.CustomerCode = Cust.CustomerCode
	Left Outer Join Master.Product Prd On 
		InHd.ProductCode = Prd.ProductCode
		AND InHd.ModelNo = Prd.ModelNo
	Left Outer Join ProductCategoryDescription PD On 
		InHd.ProductCategory = PD.LookupID
	Left Outer Join InvoiceTypeDescription ID ON 
		InHd.InvoiceType = ID.LookupID
	WHERE  
		InHd.BranchID = @BranchID
		And InHd.DocumentNo = @DocumentNo
		   AND InHd.[InvoiceNo] = @InvoiceNo
	       AND InHd.[InvoiceType] = @InvoiceType

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [InvoiceHeader] Records from [InvoiceHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InvoiceHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderList] 
	@BranchID smallint
AS 
 
BEGIN
	;With ProductCategoryDescription As (Select LookupId,LookupDescription From Config.Lookup where LookupCategory='ProductCategory'),
	InvoiceTypeDescription As (Select LookupId,LookupDescription From Config.Lookup where LookupCategory='InvoiceType')
	SELECT  InHd.BranchID,InHd.[DocumentNo],InHd.[InvoiceNo], InHd.[InvoiceType], InHd.[InvoiceDate], InHd.[CustomerCode], InHd.[ProductCode], InHd.[WarrantyPeriod], 
			InHd.[Status], InHd.[FileName], InHd.[CreatedBy], InHd.[CreatedOn], InHd.[ModifiedBy], InHd.[ModifiedOn],
			InHd.[Quantity],InHd.[UnitPrice],InHd.[CurrencyCode],InHd.[ProductCategory],InHd.[ModelNo] ,
			Cust.CustomerName,
			ISNULL(PD.LookupDescription,'') As ProductCategoryDescription,
			ISNULL(ID.LookupDescription,'') As InvoiceTypeDescription
	FROM	[Operation].[InvoiceHeader]  InHd
	Left Outer Join Master.Customer Cust ON 
		InHd.BranchID = Cust.BranchID 
		And InHd.CustomerCode = Cust.CustomerCode
	Left Outer Join Master.Product Prd On 
		InHd.ProductCode = Prd.ProductCode
		AND InHd.ModelNo = Prd.ModelNo
	Left Outer Join ProductCategoryDescription PD On 
		InHd.ProductCategory = PD.LookupID
	Left Outer Join InvoiceTypeDescription ID ON 
		InHd.InvoiceType = ID.LookupID
	Where InHd.BranchID = @BranchID
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceHeaderList] 
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [InvoiceHeader] Record Into [InvoiceHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderInsert] 
    @BranchID smallint,
	@DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @InvoiceType smallint,
    @InvoiceDate datetime,
    @CustomerCode varchar(10),
    @ProductCode varchar(50),
    @WarrantyPeriod smallint,
    @Status bit,
    @FileName nvarchar(255),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@Quantity smallint,
	@UnitPrice decimal(18,2),
	@CurrencyCode nvarchar(3),
	@ProductCategory smallint,
	@ModelNo nvarchar(50),
    @NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[InvoiceHeader] (
				[BranchID],[DocumentNo],[InvoiceNo], [InvoiceType], [InvoiceDate], [CustomerCode], [ProductCode], [WarrantyPeriod], 
				[Status], [FileName], [CreatedBy], [CreatedOn],Quantity,UnitPrice,CurrencyCode,ProductCategory,ModelNo)
	SELECT		@BranchID,@DocumentNo,@InvoiceNo, @InvoiceType, @InvoiceDate, @CustomerCode, @ProductCode, @WarrantyPeriod, 
				@Status, @FileName, @CreatedBy, GETDATE(),@Quantity,@UnitPrice,@CurrencyCode,@ProductCategory,@ModelNo
	
	SELECT @NewDocumentNo = @DocumentNo 
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceHeaderInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [InvoiceHeader] Record Into [InvoiceHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderUpdate] 
    @BranchID smallint,
	@DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @InvoiceType smallint,
    @InvoiceDate datetime,
    @CustomerCode varchar(10),
    @ProductCode varchar(50),
    @WarrantyPeriod smallint,
    @Status bit,
    @FileName nvarchar(255),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@Quantity smallint,
	@UnitPrice decimal(18,2),
	@CurrencyCode nvarchar(3),
	@ProductCategory smallint,
	@ModelNo nvarchar(50),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE	[Operation].[InvoiceHeader]
	SET		[InvoiceDate] = @InvoiceDate, [CustomerCode] = @CustomerCode, 
			[ProductCode] = @ProductCode, [WarrantyPeriod] = @WarrantyPeriod, [Status] = @Status, [FileName] = @FileName, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),
			Quantity = @Quantity,ProductCategory = @ProductCategory, UnitPrice = @UnitPrice, 
			ModelNo = @ModelNo, CurrencyCode = @CurrencyCode
	WHERE  BranchID = @BranchID
			ANd [DocumentNo]= @DocumentNo
		   AND	[InvoiceNo] = @InvoiceNo
	       AND [InvoiceType] = @InvoiceType
	
	SELECT @NewDocumentNo = @DocumentNo 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceHeaderUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [InvoiceHeader] Record Into [InvoiceHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderSave] 
    @BranchID smallint,
	@DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @InvoiceType smallint,
    @InvoiceDate datetime,
    @CustomerCode varchar(10),
    @ProductCode varchar(50),
    @WarrantyPeriod smallint,
    @Status bit,
    @FileName nvarchar(255),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@Quantity smallint,
	@UnitPrice decimal(18,2),
	@CurrencyCode nvarchar(3),
	@ProductCategory smallint,
	@ModelNo nvarchar(50),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN


 Declare @Dt dateTime,
		 @DocID varchar(25) 

	IF (SELECT COUNT(0) FROM [Operation].[InvoiceHeader] 
		WHERE DocumentNo = @DocumentNo 
			AND	[InvoiceNo] = @InvoiceNo
			AND	[InvoiceType] = @InvoiceType)>0
	BEGIN
	    Exec [Operation].[usp_InvoiceHeaderUpdate] 
			@BranchID,@DocumentNo,@InvoiceNo, @InvoiceType, @InvoiceDate, @CustomerCode, @ProductCode, @WarrantyPeriod, @Status, 
			@FileName, @CreatedBy, @ModifiedBy,@Quantity,@UnitPrice,@CurrencyCode,@ProductCategory,@ModelNo,
			@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN
	
		Select @Dt = GETDATE() ,@DocID 	='RMAInvoice' 
		print @DocID
	
	
		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 100, 'RMAInvoice', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
	
	
		Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @DocumentNo OUTPUT
		

	
	
	    Exec [Operation].[usp_InvoiceHeaderInsert] 
			@BranchID,@DocumentNo,@InvoiceNo, @InvoiceType, @InvoiceDate, @CustomerCode, @ProductCode, @WarrantyPeriod, @Status, 
			@FileName, @CreatedBy, @ModifiedBy,@Quantity,@UnitPrice,@CurrencyCode,@ProductCategory,@ModelNo,
			@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[InvoiceHeaderSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [InvoiceHeader] Record  based on [InvoiceHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderDelete] 
    @BranchID smallint,
	@DocumentNo varchar(50),
    @InvoiceNo varchar(50),
    @InvoiceType smallint
AS 

	
BEGIN

	UPDATE	[Operation].[InvoiceHeader]
	SET	[Status] = CAST(0 as bit)
	WHERE 	
BranchId = @BranchID
AND DocumentNo = @DocumentNo
AND	[InvoiceNo] = @InvoiceNo
AND [InvoiceType] = @InvoiceType

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Operation].[InvoiceHeader]
	WHERE  [InvoiceNo] = @InvoiceNo
	       AND [InvoiceType] = @InvoiceType
	*/
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InvoiceHeaderDelete]
-- ========================================================================================================================================

GO
 
