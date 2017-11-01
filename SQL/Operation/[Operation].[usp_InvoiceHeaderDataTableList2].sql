-- ========================================================================================================================================
-- START											 [Operation].[usp_InvoiceHeaderDataTableList2]
-- ========================================================================================================================================
-- Author:		Vijay
-- Create date: 	12-March-2017
-- Description: 

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderDataTableList2]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderDataTableList2]
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderDataTableList2] (
	@limit smallint,
	@offset smallint,
	@sortColumn varchar(15),
	@sortType varchar(15),
	@InvoiceType smallint,
	@BranchID smallint)
AS 
 
BEGIN

 /*
 Declare @Sql varchar(max);
 Set @Sql = 'Select * From [Operation].[InvoiceHeader] Where InvoiceType = '+ Convert(varchar(5), @InvoiceType) + ' Order By ' + @sortColumn + ' ' + @sortType + ' OFFSET ' + Convert(varchar(5), @offset) + ' ROWS
 Fetch Next ' + Convert(varchar(5), @limit) + ' Rows Only';

 Exec(@Sql) */

	Select InHd.DocumentNo, InHd.InvoiceNo, InHd.InvoiceType, InHd.InvoiceDate, InHd.CustomerCode,Cus.CustomerName, 
		InHd.ProductCode, Prd.Description as ProductName 
	From [Operation].[InvoiceHeader] as InHd
	inner Join [Master].[Customer] as Cus On 
		InHd.CustomerCode = Cus.CustomerCode
	inner Join [Master].[Product] as Prd
	On InHd.ProductCode = Prd.ProductCode
	Where InHd.InvoiceType = @InvoiceType 
	And InHd.BranchID = @BranchID
	Order By 
		Case When @sortColumn = 'DocumentNo' And @sortType = 'Asc' Then InHd.[DocumentNo] End Asc,
		Case When @sortColumn = 'DocumentNo' And @sortType = 'Desc' Then InHd.[DocumentNo] End Desc,
		Case When @sortColumn = 'InvoiceNo' And @sortType = 'Asc' Then InHd.[InvoiceNo] End Asc,
		Case When @sortColumn = 'InvoiceNo' And @sortType = 'Desc' Then InHd.[InvoiceNo] End Desc,
		Case When @sortColumn = 'CustomerCode' And @sortType = 'Asc' Then InHd.[CustomerCode] End Asc,
		Case When @sortColumn = 'CustomerCode' And @sortType = 'Desc' Then InHd.[CustomerCode] End Desc,
		Case When @sortColumn = 'ProductCode' And @sortType = 'Asc' Then InHd.[ProductCode] End Asc,
		Case When @sortColumn = 'ProductCode' And @sortType = 'Desc' Then InHd.[ProductCode] End Desc,
		Case When @sortColumn = 'InvoiceDate' And @sortType = 'Asc' Then InHd.[ProductCode] End Asc,
		Case When @sortColumn = 'InvoiceDate' And @sortType = 'Desc' Then InHd.[InvoiceDate] End Desc
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY

END


