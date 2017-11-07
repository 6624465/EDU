using EDU.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EDU.Web.Controllers
{
    public class RegistrationController : Controller
    {
        EducationEntities dbContext = new EducationEntities();

        [HttpGet]
        public ActionResult GetRegistrationList()
        {
            List<Registration> registrationList = dbContext.Registrations.ToList();
            return View(registrationList);
        }

        public ActionResult Registration(int Id)
        {
            Registration registration = dbContext.Registrations.Where(x => x.RegistrationId == Id).FirstOrDefault();

            return View(registration);
        }
        [HttpPost]
        public ActionResult Registration(Registration registration)
        {
            if (registration.RegistrationId != -1)
            {
                dbContext.Registrations.Add(registration);
                dbContext.SaveChanges();
            }
            else
            {

            }
            return View();
        }
    }
}