USE [RMAS];
GO

-- ========================================================================================================================================
-- START											 [Security].[usp_ValidateUserLogin]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Select the [UserSites] Record based on [UserSites] table
-- exec [Security].[usp_ValidateUserLogin] @UserID=N'S1811963',@Password=N'rag'

-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_ValidateUserLogin]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_ValidateUserLogin] 
END 
GO
CREATE PROC [Security].[usp_ValidateUserLogin] 
    @UserID VARCHAR(25),
    @Password varchar(15)

AS 
 
BEGIN


Declare @IsUserExist int =0;
Declare @vUserName varchar(100) = ''


	Select @IsUserExist = COUNT(0)
	From	[Security].[User]
	Where	[UserId]=@UserID
			And [Password]=@Password
			And Status=CAST(1 as bit)

	If @IsUserExist =0
	Begin
		RAISERROR('Invalid UserId Or Password',16,1)
		Return -1
	
	End
	Else
	Begin
		print 'user exists!!'
		Select 1
	End

END
-- ========================================================================================================================================
-- END  											 [Security].[usp_ValidateUserLogin]
-- ========================================================================================================================================

GO




 