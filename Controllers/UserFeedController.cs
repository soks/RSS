using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using System.Xml.Linq;
using RSS.Models;

using Filter = RSS.Models.Filter;

namespace RSS.Controllers
{
    public class UserFeedController : Controller
    {
        private readonly RssFeedDBConnection db = new RssFeedDBConnection();
        //
        // GET: /UserFeed/

        public ActionResult Index()
        {
            User user = Models.User.GetUserByName(User.Identity.Name);

            if (user.UserFeeds.Count() != 0)
            {
                Guid userID = Models.User.GetIDByName(User.Identity.Name);
                List<UserFeed> userFeed = db.UserFeeds.Where(u => u.User_ID == userID && u.IsFavourite == true).ToList();
                if (userFeed.Count == 0)
                {
                    userFeed = db.UserFeeds.Where(u => u.User_ID == userID).ToList();
                }
                List<XElement> RssList = new List<XElement>();
                foreach (UserFeed feed in userFeed)
                {
                    foreach (var rss in feed.RssFeeds)
                    {
                        var xml = XDocument.Load(rss.Address);
                        var result = xml.Element("rss").Element("channel").Elements("item");
                        foreach (var xElement in result)
                        {
                            RssList.Add(xElement);
                        }
                    }
                }
                ViewBag.Rss = RssList;
                return View();
            }
            return RedirectToAction("Create", "UserFeed");
        }

        //
        // GET: /UserFeed/Details/5

        public ViewResult Details(Guid id)
        {
            UserFeed userfeed = db.UserFeeds.Single(u => u.ID == id);
            return View(userfeed);
        }

        //
        // GET: /UserFeed/Create

        public ViewResult Create()
        {
            ViewBag.UserID = new SelectList(db.Users, "ID", "UserName").FirstOrDefault();
            return View();
        }

        //
        // POST: /UserFeed/Create

        [HttpPost]
        public ActionResult Create(NewUserFeedModel newUserFeed)
        {
            if (ModelState.IsValid)
            {
                UserFeed userFeed = new UserFeed
                                        {
                                            ID = Guid.NewGuid(),
                                            Description = newUserFeed.Description,
                                            Filter =
                                                new Filter { ID = Guid.NewGuid(), FilterText = newUserFeed.FilterText },
                                            IsFavourite = newUserFeed.IsFavourite,
                                            IsPublic = newUserFeed.IsPublic,
                                            Title = newUserFeed.Name,
                                            User_ID = Models.User.GetIDByName(User.Identity.Name)
                                        };
                TempData["usrfeed"] = userFeed;
                db.UserFeeds.AddObject(userFeed);
                db.SaveChanges();
                return RedirectToAction("AddRssFeed");
            }
            ViewBag.User_ID = new SelectList(db.Users, "ID", "UserName", newUserFeed.UserId);
            return View(newUserFeed);
        }
        
        public ActionResult AddRssFeed()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddRssFeed(RssFeed newRssFeed)
        {
            UserFeed usrFeed = (UserFeed) TempData["usrfeed"];
            Guid usrFeedId = usrFeed.ID;
            UserFeed userFeed = db.UserFeeds.SingleOrDefault(u => u.ID == usrFeedId);
            if (ModelState.IsValid)
            {
                RssFeed rssFeed = new RssFeed()
                                      {
                                          Address = newRssFeed.Address,
                                          ID = Guid.NewGuid(),
                                          Title = newRssFeed.Title,
                                      };
                db.RssFeeds.AddObject(rssFeed);
                userFeed.RssFeeds.Add(rssFeed);
                db.SaveChanges();
                return RedirectToAction("AddRssFeed");
            }
            return View();
        }

        //
        // GET: /UserFeed/Edit/5

        public ActionResult Edit(Guid id)
        {
            UserFeed userfeed = db.UserFeeds.Single(u => u.ID == id);
            ViewBag.Filter_ID = new SelectList(db.Filters, "ID", "FilterText", userfeed.Filter_ID);
            ViewBag.User_ID = new SelectList(db.Users, "ID", "UserName", userfeed.User_ID);
            return View(userfeed);
        }

        //
        // POST: /UserFeed/Edit/5

        [HttpPost]
        public ActionResult Edit(UserFeed userfeed)
        {
            if (ModelState.IsValid)
            {
                db.UserFeeds.Attach(userfeed);
                db.ObjectStateManager.ChangeObjectState(userfeed, EntityState.Modified);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Filter_ID = new SelectList(db.Filters, "ID", "FilterText", userfeed.Filter_ID);
            ViewBag.User_ID = new SelectList(db.Users, "ID", "UserName", userfeed.User_ID);
            return View(userfeed);
        }

        //
        // GET: /UserFeed/Delete/5

        public ActionResult Delete(Guid id)
        {
            UserFeed userfeed = db.UserFeeds.Single(u => u.ID == id);
            return View(userfeed);
        }

        //
        // POST: /UserFeed/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(Guid id)
        {
            UserFeed userfeed = db.UserFeeds.Single(u => u.ID == id);
            db.UserFeeds.DeleteObject(userfeed);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult UserFeedList()
        {
            Models.User user = Models.User.GetUserByName(User.Identity.Name);
            UserFeedsModel userfeeds = new UserFeedsModel();
            userfeeds.UserFeeds = user.UserFeeds.ToList();
            return View(userfeeds);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}