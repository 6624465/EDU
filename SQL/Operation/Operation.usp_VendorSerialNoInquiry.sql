USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_VendorSerialNoInquiry]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InvoiceDetail] Record based on [InvoiceDetail] table

--select * from Operation.Invoiceheader
 

-- [Operation].[usp_VendorSerialNoInquiry]  '63OXT0GBTS97'
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_VendorSerialNoInquiry]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_VendorSerialNoInquiry] 
END 
GO
CREATE PROC [Operation].[usp_VendorSerialNoInquiry] 
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
';With VendorInvoiceType As
(Select LookupID,LookupCode From Config.Lookup Where LookupCategory =''InvoiceType'' And LookupCode =''VENDOR''),
CustomerInvoiceType As 
(Select LookupID,LookupCode From Config.Lookup Where LookupCategory =''InvoiceType'' And LookupCode =''CUSTOMER'')
Select Distinct VnHd.InvoiceNo,VnHd.InvoiceDate,VnHd.CustomerCode,VnDt.ModelNo,Vndt.SerialNo,Vndt.ExpiryDate,
COALESCE(CT.LookupCode,VT.LookupCode) As LookupCode
From Operation.InvoiceDetail VnDt
LEFT OUTER JOIN Operation.InvoiceHeader VnHd ON
	VnHd.InvoiceNo = VnDt.InvoiceNo
LEFT OUTER JOIN VendorInvoiceType VT ON
	VnHd.InvoiceType =  VT.LookupID
LEFT OUTER JOIN CustomerInvoiceType CT ON
	VnHd.InvoiceType =  CT.LookupID
Where SerialNo IN (' +  @vSerialNo + ') '


print @SQL

exec sp_ExecuteSQL @SQL


END