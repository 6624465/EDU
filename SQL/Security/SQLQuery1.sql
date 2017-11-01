USE [RMAS];
GO
-- ========================================================================================================================================
-- START											 [Security].[usp_ChangeUserPassword]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2013
-- Description:	Change User Password

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_ChangeUserPassword]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_ChangeUserPassword] 
END 
GO
CREATE PROC [Security].[usp_ChangeUserPassword] 
    @UserID varchar(10),
    @OldPassword varchar(20),
    @NewPassword varchar(20)

AS 
 
	
BEGIN

	UPDATE [Security].[User]
	SET    [Password]=@NewPassword
	WHERE  [UserID] = @UserID
	And Password=@OldPassword
	
	Select COUNT(0) 
	From [Security].[User]
	WHERE  [UserID] = @UserID
	And Password=@NewPassword

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_ChangeUserPassword]
-- ========================================================================================================================================

GO


 