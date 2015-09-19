using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;

namespace SDMX_Dataloader.Main.Class
{
    public class Util
    {
        public static bool IsValidEmail(string email)
        {
            try
            {
                var mail = new System.Net.Mail.MailAddress(email);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool SendMail(string smtpHost, int smtpPort, bool smtpSsl, string mailFrom, string mailFromPassword, string nameFrom,string mailTo,string mailObj,string mailBody)
        {
            try
            {
                
                SmtpClient client = new SmtpClient(smtpHost, smtpPort);
                client.EnableSsl = smtpSsl;

                MailAddress from = new MailAddress(mailFrom, nameFrom);
                MailAddress to = new MailAddress(mailTo);

                MailMessage message = new MailMessage(from, to);
                message.Body = mailBody;
                message.Subject = mailObj;

                System.Net.NetworkCredential myCreds = new System.Net.NetworkCredential(mailFrom, mailFromPassword);

                client.Credentials = myCreds;

                client.Send(message);

                return true;
            }
            catch (Exception ex) {
                Console.Write(ex.Message);
                return false;
            }
        }
    }
}