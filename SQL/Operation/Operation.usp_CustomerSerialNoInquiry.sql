USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_SerialNoInquiry]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InvoiceDetail] Record based on [InvoiceDetail] table

--select * from Operation.Invoiceheader
 

-- [Operation].[usp_CustomerSerialNoInquiry]  'WX71E31VW694'
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_CustomerSerialNoInquiry]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_CustomerSerialNoInquiry] 
END 
GO
CREATE PROC [Operation].[usp_CustomerSerialNoInquiry] 
    @SerialNo VARCHAR(MAX)
AS 
 

BEGIN


--;With CustomerInvoiceType As
--(Select LookupID,LookupCode From Config.Lookup Where LookupCategory ='InvoiceType' And LookupCode ='CUSTOMER')
--Select Top (1) VnHd.InvoiceNo,VnHd.InvoiceDate,VnHd.CustomerCode,VnDt.ModelNo,Vndt.SerialNo,Vndt.ExpiryDate,CT.LookupCode
--From Operation.InvoiceDetail VnDt
--INNER JOIN Operation.InvoiceHeader VnHd ON
--	VnHd.InvoiceNo = VnDt.InvoiceNo
--INNER JOIN CustomerInvoiceType CT ON
--	VnHd.InvoiceType =  CT.LookupID
--Where SerialNo = ISNULL(@SerialNo,VnDt.SerialNo)
--Order By VnHd.InvoiceDate Desc





Declare @SQL nvarchar(max),
		@vSerialNo varchar(max)

Select @vSerialNo =  REPLACE(@SerialNo,'#',',')
Select @vSerialNo =  '''' + REPLACE(@vSerialNo,',',''',''') + ''''

Select @SQL = 
';With CustomerInvoiceType As
(Select LookupID,LookupCode From Config.Lookup Where LookupCategory =''InvoiceType'' And LookupCode =''CUSTOMER'')
Select  VnHd.InvoiceNo,VnHd.InvoiceDate,VnHd.CustomerCode,VnDt.ModelNo,Vndt.SerialNo,Vndt.ExpiryDate,CT.LookupCode
From Operation.InvoiceDetail VnDt
INNER JOIN Operation.InvoiceHeader VnHd ON
	VnHd.InvoiceNo = VnDt.InvoiceNo
INNER JOIN CustomerInvoiceType CT ON
	VnHd.InvoiceType =  CT.LookupID
Where SerialNo IN (' +  @vSerialNo + ') Order By VnHd.InvoiceDate Desc'


print @SQL

exec sp_ExecuteSQL @SQL


END