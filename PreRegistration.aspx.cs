using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PreRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void PreRegButtonClicked(object sender, EventArgs e)
    {
        // Collect form data - save to db
        string firstName = FirstName.Text;
        string email = Email.Text;

        ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
        SqlConnection connection = new SqlConnection(connectionStringSettings.ConnectionString);
        string sqlQuery = "INSERT INTO prereg (FirstName, Email) VALUES ('" + firstName + "','" + email + "')";
        SqlCommand command = new SqlCommand(sqlQuery, connection);
        connection.Open();
        command.ExecuteNonQuery();
        connection.Close();

        SuccessText.Text = "You are pre-registered for opening night.<br />Watch for your free pass in an email that will be sent to the address you used to pre-register.<h3>Thank you -- The Peashake House</h3>";
        prereg.Attributes.Add("style", "height:360px");
    }
}