using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RSS.Models
{
    public partial class User
    {
        public static User GetUserByID(Guid ID)
        {
            RssFeedDBConnection db = new RssFeedDBConnection();
            User user = new User();
            user = db.Users.SingleOrDefault(u => u.ID == ID);
            return user;
        }
        public static Guid GetIDByName(string Name)
        {
            RssFeedDBConnection db = new RssFeedDBConnection();
            Guid ID;
            User user = db.Users.SingleOrDefault(u => u.UserName == Name);
            ID = user.ID;
            return ID;
        }
        
        public static User GetUserByName(string Name)
        {
            RssFeedDBConnection db = new RssFeedDBConnection();
            User user = db.Users.SingleOrDefault(u => u.UserName == Name);
            return user;
        }
    }
}