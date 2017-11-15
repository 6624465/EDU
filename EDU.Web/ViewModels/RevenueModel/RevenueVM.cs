using EDU.Web.Models;
using EZY.EDU.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDU.Web.ViewModels.RevenueModel
{
    public class RevenueVM
    {
        public Revenue revenueInfo { get; set; }
        public IEnumerable<Branch> countryList { get; set; }
        //public IEnumerable<Product> productList { get; set; }
        //public IEnumerable<Models.Lookup> currencyList { get; set; }

    }
    
}