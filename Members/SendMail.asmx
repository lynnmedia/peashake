<%@ WebService Language="C#" Class="Peashakehouse.SendMail" %>

using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace Peashakehouse
{
    /// Web service to provide client-side smtp and sms mail
    [WebService(Namespace = "http://peashakehouse.com/WebServices/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class SendMail : System.Web.Services.WebService
    {
        public SendMail()
        {
            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        [WebMethod]
        public string SimpleResponse(string message)
        {
            return message;
        }

        [WebMethod]
        public string GetServerResponse(string callerName)
        {
            if (callerName == string.Empty)
                throw new Exception("Web Service Exception: invalid argument");

            return string.Format("Service responded to {0} at {1}", callerName, DateTime.Now.ToString());
        }

        [WebMethod]
        public string SendSmtp(string sender, string recipient, string subject, string message)
        {
            MailMessage mailToSend = new MailMessage(
                sender, recipient, subject, message);
            SmtpClient client = new SmtpClient("s2smtpout.secureserver.net");
            try
            {
                client.Send(mailToSend);
            }
            catch (Exception MailEx) 
            { 
                return MailEx.Message; 
            }
            return "Message Sent";
        }

        [WebMethod]
        public string SendSms(string sender, string phone, string carrier, string message)
        {
            string emailCarrier = "";
            switch (carrier)
            {
                case "Alltel":
                    emailCarrier = String.Format("{0}@message.alltel.com", phone);
                    break;
                case "Ameritech":
                    emailCarrier = String.Format("{0}@paging.acswireless.com", phone);
                    break;
                case "AT&T":
                    emailCarrier = String.Format("{0}@txt.att.net", phone);
                    break;
                case "Bellsouth":
                    emailCarrier = String.Format("{0}@bellsouth.cl", phone);
                    break;
                case "Boost":
                    emailCarrier = String.Format("{0}@myboostmobile.com", phone);
                    break;
                case "CellularOne":
                    emailCarrier = String.Format("{0}@mobile.celloneusa.com", phone);
                    break;
                case "CellularOneMMS":
                    emailCarrier = String.Format("{0}@mms.uscc.net", phone);
                    break;
                case "Cingular":
                    emailCarrier = String.Format("1{0}@mobile.mycingular.com", phone);
                    break;
                case "EdgeWireless":
                    emailCarrier = String.Format("{0}@sms.edgewireless.com", phone);
                    break;
                case "MetroPCS":
                    emailCarrier = String.Format("{0}@mymetropcs.com", phone);
                    break;
                case "Nextel":
                    emailCarrier = String.Format("{0}@messaging.nextel.com", phone);
                    break;
                case "O2":
                    emailCarrier = String.Format("{0}@mobile.celloneusa.com", phone);
                    break;
                case "Orange":
                    emailCarrier = String.Format("{0}@mobile.celloneusa.com", phone);
                    break;
                case "Qwest":
                    emailCarrier = String.Format("{0}@qwestmp.com", phone);
                    break;
                case "RogersWireless":
                    emailCarrier = String.Format("{0}@pcs.rogers.com", phone);
                    break;
                case "SprintPCS":
                    emailCarrier = String.Format("{0}@messaging.sprintpcs.com", phone);
                    break;
                case "T-Mobile":
                    emailCarrier = String.Format("{0}@tmomail.net", phone);
                    break;
                case "Teleflip":
                    emailCarrier = String.Format("{0}@teleflip.com", phone);
                    break;
                case "TelusMobility":
                    emailCarrier = String.Format("{0}@msg.telus.com", phone);
                    break;
                case "USCellular":
                    emailCarrier = String.Format("{0}@email.uscc.net", phone);
                    break;
                case "Verizon":
                    emailCarrier = String.Format("{0}@vtext.com", phone);
                    break;
                case "VirginMobile":
                    emailCarrier = String.Format("{0}@vmobl.com", phone);
                    break;
            }

            string subject = "Peashake House message from: " + sender;
            MailMessage mailToSend = new MailMessage(
                sender, emailCarrier, subject, message);
            SmtpClient client = new SmtpClient("s2smtpout.secureserver.net");
            try
            {
                client.Send(mailToSend);
            }
            catch (Exception MailEx)
            {
                return MailEx.Message;
            }
            return "Message Sent";
        }

    }
}