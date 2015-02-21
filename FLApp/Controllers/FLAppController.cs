using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using FLApp.Models;

namespace FLApp.Controllers
{
    public class FlAppController : Controller
    {
        public ActionResult Index()
        {
            return View(GetAllNews());
        }

        private List<News> GetAllNews()
        {
            var path = Server.MapPath("images");
            var di = new DirectoryInfo(path);

            return di.GetFiles().Select(name => new News
            {
                ImgUrl = string.Format("images/{0}", name.Name),
                Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer."
            }).ToList();

            //return new List<News>
            //{
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //    new News
            //    {
            //        ImgUrl = "images/00b2d8084165c920dee5b19c7b46033b.jpg",
            //        Content = "A four year cycle in summer, football fans Festival, today, to review the 1990 Italy summer. "
            //    },
            //};
        }

        [HttpGet]
        public static IEnumerable<Product> GetData(int pageNo, int pageSize)
        {
            return ProductRepository.GetData(pageNo, pageSize);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}