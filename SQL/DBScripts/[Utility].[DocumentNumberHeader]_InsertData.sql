DELETE FROM [Utility].[DocumentNumberHeader]

  
INSERT INTO [Utility].[DocumentNumberHeader]([BranchID], [DocumentID], [DocumentKey], [DocumentPrefix], [NumberLength], [LastNumber], [UseCompany], [UseBranch], [UseYear], [UseMonth], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn])
SELECT 10, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 10, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 10, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910' UNION ALL

SELECT 20, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 20, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 20, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910' UNION ALL

SELECT 90, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 90, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 90, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910' UNION ALL

SELECT 100, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 100, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 100, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910' UNION ALL

SELECT 110, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 110, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 110, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910' UNION ALL

SELECT 120, N'RMAIncident', N'INCIDENT', N'INC', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130502 12:30:29.557', N'ADMIN', '20130502 12:30:29.557' UNION ALL
SELECT 120, N'RMAInvoice', N'INVOICE', N'INV', 5, 0, 0, 1, 1, 1, N'ADMIN', '20130602 11:22:56.860', N'ADMIN', '20130602 11:22:56.860' UNION ALL
SELECT 120, N'RMAOutward', N'RMAOUT', N'RO', 5, 0, 0, 1, 1, 1, N'ADMIN', '20170312 05:14:37.910', N'ADMIN', '20170312 05:14:37.910'  
 
