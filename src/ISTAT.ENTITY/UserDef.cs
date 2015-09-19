using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ISTAT.ENTITY
{

    public class UserDef
    {
        public enum RoleDef { 
            Administrator=0,
            Operator=1,
        }
        public enum ActionDef
        {
                       
            DefaultProc=0,    

            CRUDDataset=201,

            CRUDSchema = 301,

            CRUDProfile=401,

            CRUDDomain = 501,
        }
        
        public static readonly string UserSessionKey = "LOGGEDUSER";

        private int _id = -1;
        private string _userName = string.Empty;
        private string _password = string.Empty;
        private RoleDef _role = RoleDef.Operator;
        private string _name = string.Empty;
        private string _surname = string.Empty;
        private string _email = string.Empty;
        private bool _proFlag = false;

        public int ID { get { return _id; } set { _id = value; } }
        public string Username { get { return _userName; } set { _userName = value; } }
        public string Password { get { return _password; } set { _password = value; } }
        public string Name { get { return _name; } set { _name = value; } }
        public string Surname { get { return _surname; } set { _surname = value; } }
        public string Email { get { return _email; } set { _email = value; } }
        public RoleDef Role { get { return _role; } set { _role = value; } }
        public bool ProFlag { get { return _proFlag; } set { _proFlag = value; } }

        public static bool UserCan(UserDef user, ActionDef action) {
            switch (action)
            {
                case ActionDef.CRUDProfile:
                    {
                        return (user._role == RoleDef.Administrator);
                    }
                case ActionDef.CRUDDataset:
                case ActionDef.CRUDSchema:
                case ActionDef.CRUDDomain:
                    {
                        return (user._role == RoleDef.Administrator || user.ProFlag);
                    }
                case ActionDef.DefaultProc:
                    {
                        return (user._role == RoleDef.Administrator || user._role == RoleDef.Operator);
                    }
            }

            return false;
        }

        public UserDef Clone() {
            return new UserDef()
            {

                ID = this.ID,
                Username = this.Username,
                Password = this.Password,
                Role = this.Role,
                ProFlag = this.ProFlag,
                Name = this.Name,
                Surname = this.Surname,
                Email = this.Email
            };
        }
        public void CloneTo(UserDef user)
        {
            this.ID = user.ID;
            this.Username = user.Username;
            this.Password = user.Password;
            this.Role = user.Role;
            this.ProFlag = user.ProFlag;
            this.Name = user.Name;
            this.Surname = user.Surname;
            this.Email = user.Email;
        }
    }
    


}
