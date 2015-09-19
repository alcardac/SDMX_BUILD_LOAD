using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SDMX_Dataloader.Engine
{
    public class Utility
    {

        public static readonly string Version_major = "1";
        public static readonly string Version_intermediate = "0";
        public static readonly string Version_lower = "0";

        public static readonly string HASHCODE = "SECURECODE"; 
        public static string EncriptMD5(string input)
        {
            string _returnString = string.Empty;
            // Create a new instance of the MD5CryptoServiceProvider object.
            using (System.Security.Cryptography.MD5 md5Hasher = System.Security.Cryptography.MD5.Create())
            {
                // Convert the input string to a byte array and compute the hash.
                byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

                // Create a new Stringbuilder to collect the bytes
                // and create a string.
                StringBuilder sBuilder = new StringBuilder();

                // Loop through each byte of the hashed data 
                // and format each one as a hexadecimal string.
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }

                // Return the hexadecimal string.
                _returnString = sBuilder.ToString();
            }
            return _returnString;
        }
    }
}
