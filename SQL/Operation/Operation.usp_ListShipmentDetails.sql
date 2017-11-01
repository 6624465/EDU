
USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_ListShipmentDetails]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Get the list of Shipment Details

-- Exec [Operation].[usp_ListShipmentDetails] '2013-04-01','2013-05-10',NULL
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_ListShipmentDetails]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_ListShipmentDetails] 
END 
GO
CREATE PROC [Operation].[usp_ListShipmentDetails]
    
    @DateFrom		datetime,
    @DateTo			datetime,
    @InvoiceType	smallint = NULL
    
AS 
 

BEGIN

	SELECT  InvoiceNo,InvoiceDate,CustomerCode,ProductCode,FileName FROM Operation.InvoiceHeader
	Where	CONVERT(Char(10),InvoiceDate,120) >= Convert(Char(10),@DateFrom,120)
			AND CONVERT(Char(10),InvoiceDate,120) <= Convert(Char(10),@DateTo,120)
			And InvoiceType = ISNULL(@InvoiceType,InvoiceType)
			And Status = CAST(1 as bit)
			

END
