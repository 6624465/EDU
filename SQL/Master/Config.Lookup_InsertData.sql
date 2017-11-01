 

TRUNCATE TABLE [Config].[Lookup]
GO

  
 
INSERT INTO [Config].[Lookup]([LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn])
SELECT 101, N'MANUFACTURER', N'MANUFACTURER', N'CustomerType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220' UNION ALL
SELECT 102, N'VENDOR', N'VENDOR', N'CustomerType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220' UNION ALL
SELECT 103, N'CUSTOMER', N'CUSTOMER', N'CustomerType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220'

INSERT INTO [Config].[Lookup]([LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn])
SELECT 120, N'VENDOR', N'VENDOR', N'InvoiceType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220' UNION ALL
SELECT 121, N'CUSTOMER', N'CUSTOMER', N'InvoiceType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220'  


INSERT INTO [Config].[Lookup]([LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn])
SELECT 125, N'REPLACEMENT', N'REPLACEMENT', N'ReplacementType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220' UNION ALL
SELECT 126, N'CREDITNOTE', N'CREDIT NOTE', N'ReplacementType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220'  UNION ALL 
SELECT 127, N'OPEN', N'OPEN', N'ReplacementType', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220'  


 
INSERT INTO [Config].[Lookup]([LookupID], [LookupCode], [LookupDescription], [LookupCategory], [Status], [ISOCode], [MappingCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn])
SELECT 1000, N'HARD DISK', N'HARD DISK', N'ProductCategory', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220' UNION ALL
SELECT 1001, N'MEMORY', N'MEMORY', N'ProductCategory', 1, N'', N'', N'SYSTEM', '20101225 14:47:17.220', N'SYSTEM', '20101225 14:47:17.220'


