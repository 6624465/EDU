using EDU.Web.ViewModels.CustomerPayments;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EDU.Web.Controllers
{
    public class CustomerPaymentController : Controller
    {
        // GET: CustomerPayment
        public ActionResult Payment()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Payment(CustomerPaymentVM customerPayment)
        {
            return View();
        }

    }
}