using EDU.Web.Models;
using EDU.Web.ViewModels.Master;
using EDU.Web.ViewModels.Trainer;
using EZY.EDU.BusinessFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EDU.Web.Controllers
{
    public class TrainerController : Controller
    {
        EducationEntities dbContext = new EducationEntities();

        // GET: Trainer
        public ActionResult Index(int Id = -1)
        {
            //TrainerInformation TrainerInfo = dbContext.TrainerInformations.Where(x => x.TrianerId == Id).FirstOrDefault();
            //if (TrainerInfo == null)
            //{
            //    TrainerInfo = new TrainerInformation();
            //    TrainerInfo.TrianerId = Id;
            //}

            var trainerVM = new TrainerVM()
            {

                countryList = new CountryBO().GetList().AsEnumerable()
            };
            trainerVM.TrainerInformation = new TrainerInformation()
            {
                TrianerId = Id
            };

            return View(trainerVM);

        }

        public ActionResult SaveTrainer(TrainerInformation TrainerInfo)
        {
            if (TrainerInfo.TrianerId == -1)
            {
                dbContext.TrainerInformations.Add(TrainerInfo);
                dbContext.SaveChanges();
            }
            else
            {
                TrainerInformation trainerInfoDetail = dbContext.TrainerInformations.
                    Where(x => x.TrianerId == TrainerInfo.TrianerId).FirstOrDefault();
                if (trainerInfoDetail != null)
                {
                    trainerInfoDetail.Address = TrainerInfo.Address;
                    trainerInfoDetail.Contact = TrainerInfo.Contact;
                    trainerInfoDetail.Country = TrainerInfo.Country;
                    trainerInfoDetail.Profile = TrainerInfo.Profile;
                    trainerInfoDetail.Remarks = TrainerInfo.Remarks;
                    trainerInfoDetail.Technology = TrainerInfo.Technology;
                    trainerInfoDetail.TrainerRate = TrainerInfo.TrainerRate;
                    trainerInfoDetail.VendorName = TrainerInfo.VendorName;
                }
                dbContext.SaveChanges();
            }
            return RedirectToAction("");
        }

        [HttpGet]
        public ActionResult TrainersList()
        {
            List<TrainerInformation> trainerList = dbContext.TrainerInformations.ToList();
            return View(trainerList);
        }


        [HttpPost]
        public JsonResult DeleteRegistration(int Id)
        {
            TrainerInformation trainerInfoDetail = dbContext.TrainerInformations.
                   Where(x => x.TrianerId == Id).FirstOrDefault();
            if (trainerInfoDetail != null)
            {
                dbContext.TrainerInformations.Remove(trainerInfoDetail);
                dbContext.SaveChanges();
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}