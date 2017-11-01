-- ========================================================================================================================================
-- START											 [Operation].[usp_RMAHeaderClose]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [RMAHeader] Record  based on [RMAHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_RMAHeaderClose]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_RMAHeaderClose] 
END 
GO
CREATE PROC [Operation].[usp_RMAHeaderClose] 
	@BranchID smallint,
	@ReferenceNo varchar(50)
AS 

	
BEGIN
 
 Declare 
	@RMAOutCount smallint=0,
	@RMAInCount smallint=0

--Select @ReferenceNo ='INC170300003'

Select @RMAOutCount = ISNULL(COUNT(ODt.OldSerialNo),0)   From 
[Operation].[RMAOutwardDetail] ODt 
Inner Join [Operation].[RMAOutwardHeader] Hd On 
ODt.BranchID = Hd.BranchID
And ODt.DocumentNo = Hd.DocumentNo
Where 
Hd.BranchID = @BranchID
And Hd.ReferenceNo = @ReferenceNo
And Hd.Status = Cast(1 as bit)


Select @RMAInCount = COUNT (Dt.SerialNo) 
From [Operation].[RMAHeader] Hd
Inner Join [Operation].[RMADetail] Dt On
Hd.DocumentNo = Dt.DocumentNo
Where Hd.DocumentNo = @ReferenceNo


Update [Operation].[RMAHeader] Set IsCompleted = Cast(1 as bit)
Where DocumentNo = @ReferenceNo
And ( @RMAInCount - @RMAOutCount ) =0


END