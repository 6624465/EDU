select * from master.branch
 


Insert Into Master.Branch(BranchCode,BranchName,RegNo,IsActive,CompanyCode,AddressID,CreatedBy,CreatedOn,ModifiedBy,ModifiedOn)
Select 'MMR','MYANMAR','',1,'EZY','','ADMIN',GETUTCDATE(),'ADMIN',GETUTCDATE() UNION ALL
Select 'BGD','BANGLADESH','',1,'EZY','','ADMIN',GETUTCDATE(),'ADMIN',GETUTCDATE() UNION ALL
Select 'KHM','CAMBODIA','',1,'EZY','','ADMIN',GETUTCDATE(),'ADMIN',GETUTCDATE() UNION ALL
Select 'LKA','SRILANKA','',1,'EZY','','ADMIN',GETUTCDATE(),'ADMIN',GETUTCDATE()  
