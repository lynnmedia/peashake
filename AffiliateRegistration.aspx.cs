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

public partial class AffiliateRegistration : System.Web.UI.Page
{
    protected bool isRegistrationOpen = true;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (isRegistrationOpen)
        {
            RegisterUser.ContinueDestinationPageUrl = "FirstVisit.aspx";
        }
    }

    private bool UserExists(string username)
    {
        if (Membership.GetUser(username) != null) { return true; }

        return false;
    }

    protected void RegisterUser_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (isRegistrationOpen)
        {
            if (e.CurrentStepIndex == 0)
            {
                if (AccountName.Text.Trim() == "" || UserExists(AccountName.Text))
                {
                    SearchAccountMessage.Text = "That user name already exists. Please select a different user name.";
                    e.Cancel = true;
                }
                else
                {
                    Control ctrl = RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("UserName");
                    Control ctrllbl = RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("displayUserName");
                    if (ctrl != null && ctrllbl != null)
                    {
                        TextBox userNameTextBox = (TextBox)ctrl;
                        Label displayUserNameLabel = (Label)ctrllbl;
                        userNameTextBox.Text = AccountName.Text;
                        userNameTextBox.Attributes.Add("style", "display:none");
                        displayUserNameLabel.Text = AccountName.Text; ;
                        SearchAccountMessage.Text = "";
                        e.Cancel = false;
                    }
                }
            }
        }
        else
        {
            SearchAccountMessage.Text = "The Peashake House is currently not accepting memberships.";
            e.Cancel = true;
        }
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

        // Collect form data - save to db
        TextBox userNameTextBox = (TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("UserName");
        string userName = userNameTextBox.Text;

        TextBox emailTextBox = (TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Email");
        string email = emailTextBox.Text;

        TextBox passwordTextBox = (TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Password");
        string password = passwordTextBox.Text;

        DropDownList stateDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("State");
        string state = stateDropDownList.SelectedItem.Value;

        DropDownList countryDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Country");
        string country = countryDropDownList.SelectedItem.Value;

        DropDownList birthMonthDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("BirthMonth");
        string birthMonth = birthMonthDropDownList.SelectedItem.Value;

        DropDownList birthDayDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("BirthDay");
        string birthDay = birthDayDropDownList.SelectedItem.Value;

        DropDownList birthYearDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("BirthYear");
        string birthYear = birthYearDropDownList.SelectedItem.Value;

        string birthDate = String.Format("{0}-{1}-{2}", birthYear, birthMonth, birthDay);

        DropDownList genderDropDownList = (DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Gender");
        string gender = genderDropDownList.SelectedItem.Value;

        Guid guid = (Guid)Membership.GetUser(RegisterUser.UserName).ProviderUserKey;
        string userID = guid.ToString();

        ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
        SqlConnection connection = new SqlConnection(connectionStringSettings.ConnectionString);
        string sqlQuery = "INSERT INTO MemberProfile (UserName, UserId, Password, Email, State, CountryId, Gender, BirthDate) VALUES ('" + userName + "','" + userID + "','" + password + "','" + email + "','" + state + "'," + country + ",'" + gender + "','" + birthDate + "')";
        SqlCommand command = new SqlCommand(sqlQuery, connection);
        connection.Open();
        command.ExecuteNonQuery();
        connection.Close();

        // Redirect to Members only section
        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        Response.Redirect(continueUrl);
    }
}