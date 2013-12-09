<%@ WebService Language="C#" Class="Peashakehouse.StartChat" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using FM.WebSync.Server;
using FM.WebSync.Core;

namespace Peashakehouse
{
    [WebService(Namespace = "http://peashakehouse.com/WebServices/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class StartChat : System.Web.Services.WebService
    {
        public StartChat()
        {
            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        [WebMethod]
        public Guid SendInvitation(string sender, string recipient)
        {
            SqlConnection connection = null;
            Guid chatRoomId = System.Guid.Empty;
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
            connection = new SqlConnection(connectionStringSettings.ConnectionString);
            SqlCommand cmd = new SqlCommand("MakeConnection", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Sender", sender));
            cmd.Parameters.Add(new SqlParameter("@Recipient", recipient));
            cmd.Parameters.Add(new SqlParameter("@ChatRoomId", chatRoomId));
            cmd.Parameters["@ChatRoomId"].Direction = ParameterDirection.Output;
            connection.Open();
            cmd.ExecuteNonQuery();
            chatRoomId = (Guid)cmd.Parameters["@ChatRoomId"].Value;
            connection.Close();

            string channel = "/user/" + recipient;
            string invitation = sender + " would like to invite you to chat";
            RequestHandler.Publish(channel, JSON.Serialize(new Invitation() { Text = invitation, ChatID = chatRoomId, From = sender }));
            return chatRoomId;
        }
    }
}
