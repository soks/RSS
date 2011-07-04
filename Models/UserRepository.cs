using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Security.Cryptography;


namespace RSS.Models
{
    public class UserRepository
    {
        private static string CreatePasswordHash(string pwd, string salt)
        {
            string saltAndPwd = String.Concat(pwd, salt);
            string hashedPwd =
                    FormsAuthentication.HashPasswordForStoringInConfigFile(
                    saltAndPwd, "sha1");
            return hashedPwd;
        }

        private static string CreateSalt()
        {
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] buff = new byte[32];
            rng.GetBytes(buff);

            return Convert.ToBase64String(buff);
        }

        public MembershipUser CreateUser(string username, string password, string email)
        {
            using (RssFeedDBConnection db = new RssFeedDBConnection())
            {
                User user = new User();
                user.ID = Guid.NewGuid();
                user.UserName = username;
                user.Email = email;
                user.PasswordSolt = CreateSalt();
                user.Password = CreatePasswordHash(password, user.PasswordSolt);
                user.CreatedDate = DateTime.Now;
                user.IsActivated = false;
                user.IsLockedOut = false;
                user.LastLockedOutDate = DateTime.Now;
                user.LastLoginDate = DateTime.Now;
                user.NewEmailKey = GenerateKey();
                db.AddToUsers(user);
                db.SaveChanges();
                SendEmailKey(user);

                return GetUser(username);
            }
        }

        public string GetUserNameByEmail(string email)
        {
            using (RssFeedDBConnection db = new RssFeedDBConnection())
            {
                var result = from u in db.Users where (u.Email == email) select u;
                if (result.Count() != 0)
                {
                    var dbuser = result.FirstOrDefault();
                    return dbuser.UserName;
                }
                else
                {
                    return "";
                }
            }
        }

        public MembershipUser GetUser(string username)
        {
            using (RssFeedDBConnection db = new RssFeedDBConnection())
            {
                var result = from u in db.Users where (u.UserName == username) select u;
                if (result.Count() != 0)
                {
                    var dbuser = result.FirstOrDefault();
                    string _username = dbuser.UserName;
                    Guid _providerUserKey = dbuser.ID;
                    string _email = dbuser.Email;
                    string _passwordQuestion = "";
                    string _comment = dbuser.Comments;
                    bool _isApproved = dbuser.IsActivated;
                    bool _isLockedOut = dbuser.IsLockedOut;
                    DateTime _creationDate = dbuser.CreatedDate;
                    DateTime _lastLoginDate = dbuser.LastLoginDate;
                    DateTime _lastActivityDate = DateTime.Now;
                    DateTime _lastPasswordChangedDate = DateTime.Now;
                    DateTime _lastLockedOutDate = dbuser.LastLockedOutDate;
                    MembershipUser user = new MembershipUser("CustomMembershipProvider",
                                                            _username,
                                                            _providerUserKey,
                                                            _email,
                                                            _passwordQuestion,
                                                            _comment,
                                                            _isApproved,
                                                            _isLockedOut,
                                                            _creationDate,
                                                            _lastLoginDate,
                                                            _lastActivityDate,
                                                            _lastPasswordChangedDate,
                                                            _lastLockedOutDate);
                    return user;
                }
                else
                {
                    return null;
                }
            }
        }

        public bool ValidateUser(string username, string password)
        {
            using (RssFeedDBConnection db = new RssFeedDBConnection())
            {
                var result = from u in db.Users where (u.UserName == username) select u;

                if (result.Count() != 0)
                {
                    var dbuser = result.First();

                    if (dbuser.Password == CreatePasswordHash(password, dbuser.PasswordSolt) &&
                                                                        dbuser.IsActivated == true)
                        return true;
                    else
                        return false;
                }
                else
                {
                    return false;
                }
            }
        }

        private static string GenerateKey()
        {
            Guid emailKey = Guid.NewGuid();
            return emailKey.ToString();
        }

        private void SendEmailKey(User user)
        {
            string ActivationLink = "http://localhost:38347/Account/Activate/" +
                                      user.UserName + "/" + user.NewEmailKey;

            var message = new MailMessage("soks001@mail.ru", user.Email)
            {
                Subject = "Activate your account",
                Body = ActivationLink
            };

            var client = new SmtpClient("smtp.mail.ru");
            client.Credentials = new System.Net.NetworkCredential("soks001@mail.ru", "soks123");

            client.Send(message);
        }

        public bool ActivateUser(string username, string key)
        {
            using (RssFeedDBConnection db = new RssFeedDBConnection())
            {
                var result = from u in db.Users where (u.UserName == username) select u;

                if (result.Count() != 0)
                {
                    var dbuser = result.First();

                    if (dbuser.NewEmailKey == key)
                    {
                        dbuser.IsActivated = true;
                        dbuser.LastModifiedDate = DateTime.Now;
                        dbuser.NewEmailKey = null;

                        db.SaveChanges();

                        return true;
                    }
                    else
                    {
                        return false;
                    }

                }
                else
                {
                    return false;
                }
            }
        }

    }
}
