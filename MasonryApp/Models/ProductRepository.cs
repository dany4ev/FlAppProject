using System;
using System.Collections.Generic;

namespace MasonryApp.Models
{
    public static class ProductRepository
    {
        static List<Product> _objList;
        public static IEnumerable<Product> GetData(int pageIndex, int pageSize)
        {
            int startAt = (pageIndex - 1) * pageSize;
            _objList = new List<Product>();
            Random r = new Random();
            for (int i = startAt; i < startAt + pageSize; i++)
            {
                var n = r.Next(1, 7);
                var obj = new Product
                {
                    Url = String.Format("http://dummyimage.com/150x{1}/{0}{0}{0}/fff.png&text={2}", n, n*50, i + 1),
                    Description = "Description of product " + (i + 1)
                };
                _objList.Add(obj);
            }
            return _objList;
        }
    }
}