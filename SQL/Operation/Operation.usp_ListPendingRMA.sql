USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_ListPendingRMA]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Get the list of Pending RMA list

-- Exec [Operation].[usp_ListPendingRMA]
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_ListPendingRMA]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_ListPendingRMA] 
END 
GO
CREATE PROC [Operation].[usp_ListPendingRMA] 
    
AS 
 

BEGIN
Select Distinct RmHd.DocumentNo,RmHd.IncidentDate,RmHd.CustomerCode,Cst.CustomerName,RmHd.Status 
From  Operation.RMAHeader RmHd
INNER JOIN Operation.RMADetail RmDt WITH (NOLOCK) ON
	RmHd.DocumentNo = RmDt.DocumentNo
LEFT OUTER JOIN master.Customer Cst WITH (NOLOCK) ON
	RmHd.CustomerCode  = cst.CustomerCode
Where RmHd.Status=1
And RmDt.ClosureType=0

END