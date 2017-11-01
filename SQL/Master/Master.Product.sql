
-- ========================================================================================================================================
-- START											 [Master].[usp_ProductSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select the [Product] Record based on [Product] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductSelect] 
END 
GO
CREATE PROC [Master].[usp_ProductSelect] 
    @ProductCode VARCHAR(50),
    @ModelNo varchar(50)
AS 
 

BEGIN

	;With ProductCategoryDescription As (
	Select LookupId,LookupCode From Config.Lookup where LookupCategory='ProductCategory')
	SELECT	P.[ProductCode],P.ModelNo, P.[Description],P.ProductCategory, P.[Status], 
			P.[CreatedBy], P.[CreatedOn], P.[ModifiedBy], P.[ModifiedOn],
	ISNULL(PC.LookupCode,'') As ProductCategoryDescription 
	FROM   [Master].[Product] P  
	LEFT OUTER JOIN ProductCategoryDescription PC ON
		PC.LookupID = P.ProductCategory
	WHERE  [ProductCode] = @ProductCode
		   And ModelNo= @ModelNo

END
-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_ProductList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Select all the [Product] Records from [Product] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductList] 
END 
GO
CREATE PROC [Master].[usp_ProductList] 

AS 
 
BEGIN
	;With ProductCategoryDescription As (
	Select LookupId,LookupCode From Config.Lookup where LookupCategory='ProductCategory')
	SELECT	P.[ProductCode],P.ModelNo, P.[Description],P.ProductCategory, P.[Status], 
			P.[CreatedBy], P.[CreatedOn], P.[ModifiedBy], P.[ModifiedOn],
	ISNULL(PC.LookupCode,'') As ProductCategoryDescription 
	FROM   [Master].[Product] P 
	LEFT OUTER JOIN ProductCategoryDescription PC ON
		PC.LookupID = P.ProductCategory

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ProductInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Inserts the [Product] Record Into [Product] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductInsert] 
END 
GO
CREATE PROC [Master].[usp_ProductInsert] 
    @ProductCode varchar(50),
    @ModelNo varchar(50),
    @Description varchar(255),
    @Status bit,
    @ProductCategory smallint,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
  

BEGIN
	
	INSERT INTO [Master].[Product] 
		([ProductCode],ModelNo, [Description],ProductCategory, [Status], [CreatedBy], [CreatedOn])
	SELECT @ProductCode,@ModelNo, @Description,@ProductCategory, @Status, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	updates the [Product] Record Into [Product] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductUpdate] 
END 
GO
CREATE PROC [Master].[usp_ProductUpdate] 
    @ProductCode varchar(50),
    @ModelNo varchar(50),
    @Description varchar(255),
    @Status bit,
    @ProductCategory smallint,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 
	
BEGIN

	UPDATE [Master].[Product]
	SET    [Description] = @Description,ProductCategory=@ProductCategory, [Status] = @Status, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [ProductCode] = @ProductCode
		   And [ModelNo] = @ModelNo
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Deletes the [Product] Record  based on [Product]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductDelete] 
END 
GO
CREATE PROC [Master].[usp_ProductDelete] 
    @ProductCode varchar(50),
    @ModelNo varchar(50)
AS 

	
BEGIN

	UPDATE	[Master].[Product]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[ProductCode] = @ProductCode
			And [ModelNo]=@ModelNo

	/*
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Master].[Product]
	WHERE  [ProductCode] = @ProductCode
	*/
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductDelete]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-March-2013
-- Description:	Either INSERT or UPDATE the [Product] Record Into [Product] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductSave] 
END 
GO
CREATE PROC [Master].[usp_ProductSave] 
    @ProductCode varchar(50),
    @ModelNo varchar(50),
    @Description varchar(255),
    @Status bit,
    @ProductCategory smallint,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[Product] 
		WHERE 	[ProductCode] = @ProductCode And ModelNo = @ModelNo)>0
	BEGIN
	    Exec [Master].[usp_ProductUpdate] 
			@ProductCode,@ModelNo, @Description, @Status,@ProductCategory, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_ProductInsert] 
			@ProductCode,@ModelNo, @Description, @Status,@ProductCategory, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[ProductSave]
-- ========================================================================================================================================

GO

