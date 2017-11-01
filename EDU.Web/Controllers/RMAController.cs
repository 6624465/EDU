using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EZY.EDU.Contract;
using EZY.EDU.BusinessFactory;
using System.Threading.Tasks;
using System.IO;
using System.Web.Hosting;
using System.Globalization;
using LogiCon.Utilities;

namespace EDU.Web.Controllers
{
    [WebSsnFilter]
    public class RMAController : BaseController
    {
        public Task MessageServices { get; private set; }


        public ActionResult Inward()
        {
            ViewBag.countries = new CountryBO().GetList().Select(x => new
            {
                Value = x.CountryCode,
                Text = x.CountryName
            }).ToList();
            return View(new RMAHeader { IncidentDate = UTILITY.SINGAPORETIME });
        }
        public ActionResult VendorRMA()
        {
            ViewBag.countries = new CountryBO().GetList().Select(x => new
            {
                Value = x.CountryCode,
                Text = x.CountryName
            }).ToList();
            return View(new VendorRMAHeader { IncidentDate = UTILITY.SINGAPORETIME });
        }
        public ActionResult ProcessVendorRMA(VendorRMAHeader vendorRmaHeader)
        {
            if (vendorRmaHeader.VendorRmaDetails == null)
            {
                return RedirectToAction("VendorRMA");
            }
            else
            {
                for (var i = 0; i < vendorRmaHeader.VendorRmaDetails.Count; i++)
                {
                    var VendorRmaInwardDTO = new InvoiceDetailBO().GetVendorDetailBySerialNo(vendorRmaHeader.VendorRmaDetails[i].SerialNo, BRANCH_ID, UTILITY.CONFIG_INVOICETYPE_VENDOR);//CONFIG_INVOICETYPE_CUSTOMER

                    if (VendorRmaInwardDTO != null)
                    {
                        vendorRmaHeader.VendorRmaDetails[i].VendorInvoiceNo = VendorRmaInwardDTO.VendorInvoiceNo;
                        vendorRmaHeader.VendorRmaDetails[i].VendorName = VendorRmaInwardDTO.VendorName;
                        vendorRmaHeader.VendorRmaDetails[i].DocumentNo = VendorRmaInwardDTO.DocumentNo;
                        vendorRmaHeader.VendorRmaDetails[i].WarrantyExpiryDate = VendorRmaInwardDTO.CustomerWarrantyExpiryDate;
                        vendorRmaHeader.VendorRmaDetails[i].IsValid = (UTILITY.SINGAPORETIME < vendorRmaHeader.VendorRmaDetails[i].WarrantyExpiryDate);
                        if (VendorRmaInwardDTO.VendorWarrantyExpiryDate != null)
                        {
                            vendorRmaHeader.VendorRmaDetails[i].RMAIsValid = (UTILITY.SINGAPORETIME < VendorRmaInwardDTO.VendorWarrantyExpiryDate);
                            vendorRmaHeader.VendorRmaDetails[i].VendorWarrantyExpiryDate = VendorRmaInwardDTO.VendorWarrantyExpiryDate;
                        }
                    }
                    else
                    {
                        vendorRmaHeader.VendorRmaDetails[i].IsValid = false;
                    }
                }
                ViewBag.countries = new CountryBO().GetList().Select(x => new
                {
                    Value = x.CountryCode,
                    Text = x.CountryName
                }).ToList();
                return View("VendorRMA", vendorRmaHeader);


            }
        }
        public ActionResult ProcessRMAInward(RMAHeader rmaHeader)
        {
            if (rmaHeader.rmaDetails == null)
            {
                return RedirectToAction("Inward");
            }
            else
            {
                for (var i = 0; i < rmaHeader.rmaDetails.Count; i++)
                {
                    //Comment by krishna 31/08/2017 
                    //  var rmaInwardDTO = new InvoiceDetailBO().GetVendorInvoiceDetailBySerialNo(rmaHeader.rmaDetails[i].SerialNo, BRANCH_ID, UTILITY.CONFIG_INVOICETYPE_VENDOR);//CONFIG_INVOICETYPE_CUSTOMER
                    var rmaInwardDTO = new InvoiceDetailBO().GetVendorInvoiceDetailBySerialNo(rmaHeader.rmaDetails[i].SerialNo, BRANCH_ID, UTILITY.CONFIG_INVOICETYPE_CUSTOMER);//CONFIG_INVOICETYPE_CUSTOMER
                    if (rmaInwardDTO != null)
                    {
                        rmaHeader.rmaDetails[i].DocumentNo = rmaInwardDTO.DocumentNo;
                        rmaHeader.rmaDetails[i].WarrantyExpiryDate = rmaInwardDTO.InvoiceDate.AddMonths(rmaInwardDTO.WarrantyPeriod);
                        rmaHeader.rmaDetails[i].IsValid = (UTILITY.SINGAPORETIME < rmaHeader.rmaDetails[i].WarrantyExpiryDate);
                    }
                    else
                    {
                        rmaHeader.rmaDetails[i].IsValid = false;
                    }
                }
            }

            ViewBag.countries = new CountryBO().GetList().Select(x => new
            {
                Value = x.CountryCode,
                Text = x.CountryName
            }).ToList();

            return View("Inward", rmaHeader);
        }
        //[HttpPost]
        //[AllowAnonymous]
        //public async Task<ActionResult> SendEmail(RMAHeader model)
        //{
        //    var message = await EMailTemplate("WelcomeEmail");
        //    message = message.Replace("@ViewBag.Name", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(model.EmailID));
        //    await EmailGenerator.SendEmailAsync(model.EmailID, "Welcome!", message);
        //    return View("EmailSent");
        //}
        public ActionResult EmailSent()
        {
            return View();
        }
        public static async Task<string> EMailTemplate(string template)
        {
            var templateFilePath = HostingEnvironment.MapPath("~/Css/templates/") + template + ".cshtml";
            StreamReader objstreamreaderfile = new StreamReader(templateFilePath);
            var body = await objstreamreaderfile.ReadToEndAsync();
            objstreamreaderfile.Close();
            return body;
        }

        public ActionResult GenerateRMA(RMAHeader rmaHeader)
        {

            rmaHeader.rmaDetails = rmaHeader.rmaDetails.Where(x => x.IsValid == true).ToList();
            rmaHeader.Status = true;
            rmaHeader.CreatedBy = USER_ID;
            rmaHeader.CreatedOn = UTILITY.SINGAPORETIME;
            rmaHeader.ModifiedBy = USER_ID;
            rmaHeader.ModifiedOn = UTILITY.SINGAPORETIME;
            rmaHeader.IncidentDate = UTILITY.SINGAPORETIME;
            var result = new RMAHeaderBO().SaveRMAHeader(rmaHeader, BRANCH_ID);
            string documentNo = rmaHeader.rmaDetails.FirstOrDefault().DocumentNo;
            List<RMADetail> rmaDetails = new RMADetailBO().GetListByDocumentNo(documentNo);
            List<string> serialNos = rmaDetails.Select(s => s.SerialNo).ToList();
            var SNo = string.Empty;
            for (int i = 0; i < serialNos.Count; i++)
            {
                SNo += serialNos[i]+"</br>";
            }
            new EmailGenerator().ConfigMail(rmaHeader.EmailID, true, documentNo, SNo);
            return Content("<script language='javascript' type='text/javascript'>alert('RMA Number is Sent To Your Mail!');window.location = '/RMA/Inward';</script>");
            //return RedirectToAction("Inward");
        }
        public ActionResult GenerateVendorRMA(VendorRMAHeader vendorRmaHeader)
        {
            vendorRmaHeader.VendorRmaDetails = vendorRmaHeader.VendorRmaDetails.Where(x => x.IsValid == true).ToList();
            vendorRmaHeader.Status = true;
            vendorRmaHeader.CreatedBy = USER_ID;
            vendorRmaHeader.CreatedOn = UTILITY.SINGAPORETIME;
            vendorRmaHeader.ModifiedBy = USER_ID;
            vendorRmaHeader.ModifiedOn = UTILITY.SINGAPORETIME;
            vendorRmaHeader.IncidentDate = UTILITY.SINGAPORETIME;
            var result = new VendorRMAHeaderBO().SaveVendorRMAHeader(vendorRmaHeader, BRANCH_ID);

            return RedirectToAction("VendorRMA");
        }
        [HttpGet]
        public ActionResult VendorRMAOutwardList()
        {
            var list = new VendorRMAHeaderBO().GetListByBranchID(BRANCH_ID);
            return View("VendorOutwardRMA", list);
        }

        [HttpGet]
        public ActionResult OutwardList()
        {
            var list = new RMAHeaderBO().GetListByBranchID(BRANCH_ID);
            return View("OutwardList", list);
        }

        [HttpGet]
        public ActionResult GetRMAByDocumentNo(string documentNo)
        {
            RMAOutwardHeader RMAOutwardHeader = new RMAOutwardHeader();
            RMAOutwardHeader.RmaDetails = new RMAOutwardDetailBO().RMAOutWardDetailListByRMAInWardDocumentNo(documentNo, BRANCH_ID);
            RMAOutwardHeader.ReferenceNo = RMAOutwardHeader.RmaDetails.FirstOrDefault() != null ?
                                                 RMAOutwardHeader.RmaDetails.FirstOrDefault().DocumentNo : string.Empty;
            return View(RMAOutwardHeader);
        }

        [HttpGet]
        public ActionResult GetVendorRMAByDocumentNo(string documentNo)
        {
            VendorRMAOutwardHeader vendorRMAOutwardHeader = new VendorRMAOutwardHeader();
            vendorRMAOutwardHeader.VendorRmaDetails = new VendorRMAOutwardDetailBO().VendorRMAOutWardDetailListByRMAInWardDocumentNo(documentNo, BRANCH_ID);
            vendorRMAOutwardHeader.ReferenceNo = vendorRMAOutwardHeader.VendorRmaDetails.FirstOrDefault() != null ?
                                                 vendorRMAOutwardHeader.VendorRmaDetails.FirstOrDefault().DocumentNo : string.Empty;
            ViewBag.vProducts = new ProductBO().GetList()
                   .Where(x => x.Status == true)
                   .Select(x => new
                   {
                       Value = x.ProductCode,
                       Text = x.ProductCode
                   })
                   .ToList();
            return View(vendorRMAOutwardHeader);
        }


        [HttpPost]
        public ActionResult SaveRMAOutWard(RMAOutwardHeader header)
        {
            Func<RMAOutwardDetail, bool> WhereFunc = delegate (RMAOutwardDetail detail)
            {
                var NewSerialNo = detail.NewSerialNo ?? "";
                var IsCreditNote = detail.IsCreditNote;
                return NewSerialNo.Trim().Length > 0 || IsCreditNote;
            };
            var IsRecordUpdated = false;
            IsRecordUpdated = header.RmaDetails.Where(WhereFunc).Count() > 0;
            if (IsRecordUpdated)
            {
                header.BranchID = BRANCH_ID;
                header.DocumentDate = UTILITY.SINGAPORETIME;
                header.Status = true;
                header.CreatedBy = USER_ID;
                header.CreatedOn = UTILITY.SINGAPORETIME;
                header.ModifiedBy = USER_ID;
                header.ModifiedOn = UTILITY.SINGAPORETIME;

                header.RmaDetails.ForEach(x =>
                {
                    x.BranchID = BRANCH_ID;
                    x.CreatedBy = USER_ID;
                    x.CreatedOn = UTILITY.SINGAPORETIME;
                    x.ModifiedBy = USER_ID;
                    x.ModifiedOn = UTILITY.SINGAPORETIME;
                });

                var result = new RMAOutwardHeaderBO().SaveRMAOutwardHeader(header);
            }
            return RedirectToAction("OutwardList", "RMA");
        }
        [HttpPost]
        public ActionResult SaveVendorRMAOutWard(VendorRMAOutwardHeader vendorRMAOutwardHeader)
        {
            Func<VendorRMAOutwardDetail, bool> WhereFunc = delegate (VendorRMAOutwardDetail detail)
            {
                var NewSerialNo = detail.NewSerialNo ?? "";
                var IsCreditNote = detail.IsCreditNote;
                return NewSerialNo.Trim().Length > 0 || IsCreditNote;
            };

            var IsRecordUpdated = false;
            IsRecordUpdated = vendorRMAOutwardHeader.VendorRmaDetails.Where(WhereFunc).Count() > 0;

            if (IsRecordUpdated)
            {

                vendorRMAOutwardHeader.BranchID = BRANCH_ID;
                vendorRMAOutwardHeader.DocumentDate = UTILITY.SINGAPORETIME;
                vendorRMAOutwardHeader.Status = true;
                vendorRMAOutwardHeader.CreatedBy = USER_ID;
                vendorRMAOutwardHeader.CreatedOn = UTILITY.SINGAPORETIME;
                vendorRMAOutwardHeader.ModifiedBy = USER_ID;
                vendorRMAOutwardHeader.ModifiedOn = UTILITY.SINGAPORETIME;

                vendorRMAOutwardHeader.VendorRmaDetails.ForEach(x =>
                {
                    x.BranchID = BRANCH_ID;
                    x.CreatedBy = USER_ID;
                    x.CreatedOn = UTILITY.SINGAPORETIME;
                    x.ModifiedBy = USER_ID;
                    x.ModifiedOn = UTILITY.SINGAPORETIME;
                });

                var result = new VendorRMAOutwardHeaderBO().SaveVendorRMAOutwardHeader(vendorRMAOutwardHeader);
            }

            return RedirectToAction("VendorRMAOutwardList", "RMA");
        }
        /*
        [HttpPost]
        public JsonResult RMAOutwordList(DataTableObject Obj)
        {
            try
            {
                Obj.BranchID = BRANCH_ID;               

                var RMAOutwordList = new RMAOutwardHeaderBO().GetList(BRANCH_ID);
                return Json(new
                {
                    RMAOutwordList = RMAOutwordList                   
                    
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { }, JsonRequestBehavior.AllowGet);
            }

        }*/

        [HttpGet]
        [EncryptedActionParameter]
        public ActionResult Outword(string ReferenceNo = null, string documentNo = null)
        {
            if (string.IsNullOrWhiteSpace(documentNo))
                return View(new RMAOutwardHeader { });
            else
            {
                var OutwordHeader = new RMAOutwardHeaderBO().GetRMAOutwardHeader(new RMAOutwardHeader { BranchID = BRANCH_ID, DocumentNo = documentNo });
                return View(OutwordHeader);
            }
        }

    }
}