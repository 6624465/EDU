USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_SerialNoInquiry]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InvoiceDetail] Record based on [InvoiceDetail] table

--select * from Operation.Invoiceheader
 

-- [Operation].[usp_SerialNoInquiry]  'WX71E31VW694'
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SerialNoInquiry]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SerialNoInquiry] 
END 
GO
CREATE PROC [Operation].[usp_SerialNoInquiry] 
    @SerialNo VARCHAR(50)
AS 
 

BEGIN


;With VendorInvoiceType As
(Select LookupID,LookupCode From Config.Lookup Where LookupCategory ='InvoiceType' And LookupCode ='VENDOR'),
CustomerInvoiceType As
(Select LookupID,LookupCode From Config.Lookup Where LookupCategory ='InvoiceType' And LookupCode ='CUSTOMER')
Select Top (1) VnHd.InvoiceNo,VnHd.InvoiceDate,VnHd.CustomerCode,VnDt.ModelNo,Vndt.SerialNo,Vndt.ExpiryDate,VT.LookupCode
From Operation.InvoiceDetail VnDt
Left JOIN Operation.InvoiceHeader VnHd ON
	VnHd.InvoiceNo = VnDt.InvoiceNo
Left JOIN VendorInvoiceType VT ON
	VnHd.InvoiceType =  VT.LookupID
Where SerialNo = ISNULL(@SerialNo,VnDt.SerialNo)


UNION ALL

Select Top (1) VnHd.InvoiceNo,VnHd.InvoiceDate,VnHd.CustomerCode,VnDt.ModelNo,Vndt.SerialNo,Vndt.ExpiryDate,CT.LookupCode
From Operation.InvoiceDetail VnDt
INNER JOIN Operation.InvoiceHeader VnHd ON
	VnHd.InvoiceNo = VnDt.InvoiceNo
INNER JOIN CustomerInvoiceType CT ON
	VnHd.InvoiceType =  CT.LookupID
Where SerialNo = ISNULL(@SerialNo,VnDt.SerialNo)
Order By VnHd.InvoiceDate Desc



END