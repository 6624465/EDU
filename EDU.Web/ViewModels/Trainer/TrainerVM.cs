using EDU.Web.Models;
using EZY.EDU.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EDU.Web.ViewModels.Trainer
{
    public class TrainerVM
    {
        public TrainerInformation TrainerInformation { get; set; }
        public IEnumerable<Country> countryList { get; set; }

    }
}