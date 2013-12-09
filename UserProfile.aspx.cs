using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class UserProfile : Page
{
    protected static MembershipUser user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
    protected static string userName = user.UserName;
    protected static Guid guid = (Guid)user.ProviderUserKey;
    protected static string userID = guid.ToString();

    const int MaxTotalBytes = 1048576; // 1 MB
    int totalBytes;

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadInterests();
        SetUserInterests();
        ProfileSqlDataSource.SelectCommand = "SELECT p.UserName, p.FirstName, p.LastName, p.Email, p.City, p.state, c.countryid, c.countryname, dbo.ufn_GetAge(p.BirthDate, GETDATE()) as age, DATEPART(year, p.Birthdate) as year, DATEPART(month, p.Birthdate) as month, DATEPART(day, p.BirthDate) as day, p.gender, p.description from MemberProfile p left outer join Countries c on p.CountryId=c.CountryId where UserName = '" + userName + "'";
        MembershipSqlDataSource.SelectCommand = "SELECT p.UserID, a.cardname, a.address1 as cardAddress, a.city as cardCity, a.state as cardState, a.zip as cardZip, c.countryname as cardCountry, a.cardtype, a.cardnumber, a.cardexpirationmonth as cardexpmonth, a.cardexpirationyear as cardexpyear, a.cardCID from Address a, Countries c, MemberProfile p where p.userid=a.userId and a.CountryId=c.CountryId and p.UserName='" + userName + "'";
        UserSqlDataSource.SelectCommand = "select p.firstname,p.lastname,p.username,p.email,CONVERT(VARCHAR(11), p.registerdate, 101) AS [registerdate],p.city,p.state,dbo.ufn_GetAge(p.BirthDate, GETDATE()) as age, p.gender,c.countryname,i.Data from MemberProfile p left outer join Countries c on p.CountryId=c.CountryId left outer join Images i on i.ImageId=p.imageid where UserName = '" + userName + "'";
    }

    protected void LoadInterests()
    {
        SqlDataReader interestReader = null;
        SqlConnection connection = null;
        SqlCommand command = null;
        string groupName = "";
        string prevGroupName = "";

        try
        {
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
            connection = new SqlConnection(connectionStringSettings.ConnectionString);
            string sqlQuery = "SELECT * FROM Interests ORDER BY GroupName";
            command = new SqlCommand(sqlQuery, connection);
            connection.Open();
            interestReader = command.ExecuteReader();

            while (interestReader.Read())
            {
                groupName = interestReader["GroupName"].ToString();
                if (prevGroupName != groupName)
                {
                    LiteralControl header = new LiteralControl("<h6>" + groupName + "</h6>");
                    panelInterests.Controls.Add(header);
                    prevGroupName = groupName;
                }

                RadButton radButton = new RadButton();
                radButton.ID = interestReader["Name"].ToString();
                radButton.ToggleType = Telerik.Web.UI.ButtonToggleType.CheckBox;
                radButton.ButtonType = Telerik.Web.UI.RadButtonType.ToggleButton;
                radButton.AutoPostBack = false;
                radButton.CssClass = "interestsCb";

                RadButtonToggleState checkedToggleState = new RadButtonToggleState(interestReader["Name"].ToString(), "rbToggleCheckboxChecked");
                RadButtonToggleState uncheckedToggleState = new RadButtonToggleState(interestReader["Name"].ToString(), "rbToggleCheckbox");
                radButton.ToggleStates.Add(checkedToggleState);
                radButton.ToggleStates.Add(uncheckedToggleState);
                panelInterests.Controls.Add(radButton);
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            if (interestReader != null)
                interestReader.Close();

            connection.Close();
        }

        RadButton saveButton = new RadButton();
        saveButton.ID = "profile_interests_save";
        saveButton.Text = "Save";
        saveButton.Width = 120;
        saveButton.AutoPostBack = true;
        saveButton.CommandName = "Update";
        saveButton.Command += new CommandEventHandler(SaveInterestsCommandBtn_Click);
        saveButton.Click += new System.EventHandler(SaveInterestsBtn_Click);
        LiteralControl centerTagOpen = new LiteralControl("<br /><br /><center>");
        panelInterests.Controls.Add(centerTagOpen);
        panelInterests.Controls.Add(saveButton);
        LiteralControl centerTagClose = new LiteralControl("</center>");
        panelInterests.Controls.Add(centerTagClose);
    }

    protected void SetUserInterests()
    {
        SqlDataReader myInterestsReader = null;
        SqlConnection connection = null;
        SqlCommand command = null;

        try
        {
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
            connection = new SqlConnection(connectionStringSettings.ConnectionString);
            string sqlQuery = "select name from memberinterests mi, interests i where i.InterestId=mi.interestid and mi.userid='" + userID + "'";
            command = new SqlCommand(sqlQuery, connection);
            connection.Open();
            myInterestsReader = command.ExecuteReader();

            while (myInterestsReader.Read())
            {
                RadButton myInterest = (RadButton)InterestsPageView.FindControl(myInterestsReader["name"].ToString());
                myInterest.Checked = true;
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            if (myInterestsReader != null)
                myInterestsReader.Close();

            connection.Close();
        }
    }

    protected void SaveUserInterests()
    {
        SqlDataReader interestReader = null;
        SqlConnection connection = null;
        SqlCommand command = null;
        List<int> myInterests = new List<int>();
        
        try
        {
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
            connection = new SqlConnection(connectionStringSettings.ConnectionString);
            string sqlQuery = "SELECT * FROM Interests ORDER BY GroupName";
            command = new SqlCommand(sqlQuery, connection);
            connection.Open();
            interestReader = command.ExecuteReader();

            while (interestReader.Read())
            {
                RadButton interest = (RadButton)InterestsPageView.FindControl(interestReader["name"].ToString());
                if (interest.Checked == true)
                {
                    myInterests.Add(int.Parse(interestReader["InterestId"].ToString()));
                }
            }

            if (interestReader != null)
            {
                interestReader.Close();
                interestReader = null;
            }

            if (myInterests.Count > 0)
            {
                string deleteQuery = "DELETE FROM MemberInterests WHERE UserID='" + userID + "'";
                SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection);
                deleteCommand.ExecuteNonQuery();
                foreach (int interest in myInterests)
                {
                    string insertQuery = "INSERT INTO MemberInterests (UserID, InterestId) VALUES ('" + userID + "', '" + interest + "')";
                    SqlCommand insertCommand = new SqlCommand(insertQuery, connection);
                    insertCommand.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            if (interestReader != null)
                interestReader.Close();

            connection.Close();
        }
    }

    protected void SaveInterestsCommandBtn_Click(Object sender, CommandEventArgs e)
    {
        SaveUserInterests();
    }

    protected void SaveInterestsBtn_Click(Object sender, EventArgs e)
    {
    }

    protected void ProfileView_OnItemUpdated(Object sender, FormViewUpdatedEventArgs e)
    {
        UserListView.Rebind();
    }

    protected void ProfileView_DataBound(object sender, EventArgs e)
    {
        RadComboBox stateCb = (RadComboBox)ProfileView.FindControl("profile_state");
        stateCb.LoadContentFile("~/App_Data/USA_States.xml");
            
        RadComboBox countryCb = (RadComboBox)ProfileView.FindControl("profile_country");
        countryCb.LoadContentFile("~/App_Data/Global_Countries.xml");

        RadComboBox monthCb = (RadComboBox)ProfileView.FindControl("profile_birthMonth");
        monthCb.LoadContentFile("~/App_Data/Months.xml");

        RadComboBox dayCb = (RadComboBox)ProfileView.FindControl("profile_birthDay");
        dayCb.LoadContentFile("~/App_Data/Days.xml");

        RadComboBox yearCb = (RadComboBox)ProfileView.FindControl("profile_birthYear");
        yearCb.LoadContentFile("~/App_Data/Years.xml");

        using (SqlDataReader rdrProfile = (SqlDataReader)ProfileSqlDataSource.Select(DataSourceSelectArguments.Empty))
        {
            int index = -1;
            if (rdrProfile.Read())
            {
                index = stateCb.FindItemIndexByValue(rdrProfile["state"].ToString());
                stateCb.SelectedIndex = index;

                index = countryCb.FindItemIndexByValue(rdrProfile["countryid"].ToString());
                countryCb.SelectedIndex = index;

                index = monthCb.FindItemIndexByValue(rdrProfile["month"].ToString());
                monthCb.SelectedIndex = index;

                index = dayCb.FindItemIndexByValue(rdrProfile["day"].ToString());
                dayCb.SelectedIndex = index;

                index = yearCb.FindItemIndexByValue(rdrProfile["year"].ToString());
                yearCb.SelectedIndex = index;

                if (rdrProfile["gender"].ToString() == "F")
                {
                    RadButton femaleRb = (RadButton)ProfileView.FindControl("profile_female");
                    femaleRb.Checked = true;
                }
                else
                {
                    RadButton maleRb = (RadButton)ProfileView.FindControl("profile_male");
                    maleRb.Checked = true;
                }

                Session["PSHUserAge"] = rdrProfile["age"].ToString();
            }
        }
    }

    protected void ProfileView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        RadButton femalebutton = (RadButton)(sender as FormView).FindControl("profile_female");
        if (femalebutton.Checked)
        {
            ProfileSqlDataSource.UpdateParameters["Gender"].DefaultValue = "F";
        }
        else
        {
            ProfileSqlDataSource.UpdateParameters["Gender"].DefaultValue = "M";
        }

        RadComboBox monthCb = (RadComboBox)ProfileView.FindControl("profile_birthMonth");
        string birthMonth = monthCb.SelectedValue;
        RadComboBox dayCb = (RadComboBox)ProfileView.FindControl("profile_birthDay");
        string birthDay = dayCb.SelectedValue;
        RadComboBox yearCb = (RadComboBox)ProfileView.FindControl("profile_birthYear");
        string birthYear = yearCb.SelectedValue;
        string birthDate = String.Format("{0}-{1}-{2}", birthYear, birthMonth, birthDay);
        ProfileSqlDataSource.UpdateParameters["BirthDate"].DefaultValue = birthDate;
    }

    protected void MembershipView_DataBound(object sender, EventArgs e)
    {
/*
        RadComboBox cardTypeCb = (RadComboBox)MembershipView.FindControl("membership_cardType");
        cardTypeCb.LoadContentFile("~/App_Data/cardType.xml");

        RadComboBox stateCb = (RadComboBox)MembershipView.FindControl("membership_cardState");
        stateCb.LoadContentFile("~/App_Data/USA_States.xml");

        RadComboBox countryCb = (RadComboBox)MembershipView.FindControl("membership_cardCountry");
        countryCb.LoadContentFile("~/App_Data/Global_Countries.xml");

        RadComboBox monthCb = (RadComboBox)MembershipView.FindControl("membership_expMonth");
        monthCb.LoadContentFile("~/App_Data/expMonth.xml");

        RadComboBox yearCb = (RadComboBox)MembershipView.FindControl("membership_expYear");
        yearCb.LoadContentFile("~/App_Data/expYear.xml");
        using (SqlDataReader rdrMember = (SqlDataReader)MembershipSqlDataSource.Select(DataSourceSelectArguments.Empty))
        {
            int index = -1;
            if (rdrMember.Read())
            {
                index = cardTypeCb.FindItemIndexByValue(rdrMember["cardtype"].ToString());
                cardTypeCb.SelectedIndex = index;

                index = stateCb.FindItemIndexByValue(rdrMember["cardstate"].ToString());
                stateCb.SelectedIndex = index;

                index = countryCb.FindItemIndexByText(rdrMember["cardcountry"].ToString());
                countryCb.SelectedIndex = index;

                index = monthCb.FindItemIndexByValue(rdrMember["cardexpmonth"].ToString());
                monthCb.SelectedIndex = index;

                index = yearCb.FindItemIndexByValue(rdrMember["cardexpyear"].ToString());
                yearCb.SelectedIndex = index;
            }
        }
*/
    }

    public bool? IsRadAsyncValid
    {
        get
        {
            if (Session["IsRadAsyncValid"] == null)
            {
                Session["IsRadAsyncValid"] = true;
            }

            return Convert.ToBoolean(Session["IsRadAsyncValid"].ToString());
        }
        set
        {
            Session["IsRadAsyncValid"] = value;
        }
    }

    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        }
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        IsRadAsyncValid = null;
    }

    protected void PhotoGrid_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            RadAsyncUpload upload = ((GridEditableItem)e.Item)["Upload"].FindControl("AsyncUpload1") as RadAsyncUpload;
            TableCell cell = (TableCell)upload.Parent;

            CustomValidator validator = new CustomValidator();
            validator.ErrorMessage = "Please select file to be uploaded";
            validator.ClientValidationFunction = "validateRadUpload";
            validator.Display = ValidatorDisplay.Dynamic;
            cell.Controls.Add(validator);
        }
    }

    protected string TrimDescription(string description)
    {
        if (!string.IsNullOrEmpty(description) && description.Length > 200)
        {
            return string.Concat(description.Substring(0, 200), "...");
        }
        return description;
    }

    private static DataTable GetDataTable(string queryString)
    {
        SqlConnection MySqlConnection = new SqlConnection(ConnectionString);
        SqlDataAdapter MySqlDataAdapter = new SqlDataAdapter();
        MySqlDataAdapter.SelectCommand = new SqlCommand(queryString, MySqlConnection);

        DataTable myDataTable = new DataTable();
        MySqlConnection.Open();
        try
        {
            MySqlDataAdapter.Fill(myDataTable);
        }
        finally
        {
            MySqlConnection.Close();
        }

        return myDataTable;
    }
    
    protected void PhotoGrid_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {
        PhotoGrid.DataSource = GetDataTable("SELECT * FROM [Images] WHERE UserID = '" + userID + "'");
    }
    
    protected void PhotoGrid_InsertCommand(object source, GridCommandEventArgs e)
    {
        if (!IsRadAsyncValid.Value)
        {
            e.Canceled = true;
            RadAjaxManager1.Alert("The length of the uploaded file must be less than 1 MB");
            return;
        }

        GridEditFormInsertItem insertItem = e.Item as GridEditFormInsertItem;
        string imageName = (insertItem["ImageName"].FindControl("txbName") as RadTextBox).Text;
        string description = (insertItem["Description"].FindControl("txbDescription") as RadTextBox).Text;
        RadAsyncUpload radAsyncUpload = insertItem["Upload"].FindControl("AsyncUpload1") as RadAsyncUpload;

        UploadedFile file = radAsyncUpload.UploadedFiles[0];
        byte[] fileData = new byte[file.InputStream.Length];
        file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("UploadMemberPhoto", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar, 256, "UserId");
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50, "Name");
            cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 4000, "Description");
            cmd.Parameters.Add("@Data", SqlDbType.Image);

            cmd.Parameters["@UserId"].Value = userID;
            cmd.Parameters["@Name"].Value = imageName;
            cmd.Parameters["@Description"].Value = description;
            cmd.Parameters["@Data"].Value = fileData;

            cmd.ExecuteNonQuery();
        }

        UserListView.Rebind();
    }
    
    protected void PhotoGrid_UpdateCommand(object source, GridCommandEventArgs e)
    {
        if (!IsRadAsyncValid.Value)
        {
            e.Canceled = true;
            RadAjaxManager1.Alert("The length of the uploaded file must be less than 1 MB");
            return;
        }
        GridEditableItem editedItem = e.Item as GridEditableItem;
        int ImageId = Convert.ToInt32(editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["ImageId"].ToString());
        string imageName = (editedItem["ImageName"].FindControl("txbName") as RadTextBox).Text;
        string description = (editedItem["Description"].FindControl("txbDescription") as RadTextBox).Text;
        RadAsyncUpload radAsyncUpload = editedItem["Upload"].FindControl("AsyncUpload1") as RadAsyncUpload;

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            conn.Open();
            SqlCommand cmd;
            if (radAsyncUpload.UploadedFiles.Count > 0)
            {
                cmd = new SqlCommand("UPDATE [Images] SET [Name] = @Name, [Description] = @Description, [Data] = @Data WHERE [ImageId] = @ImageId", conn);
                UploadedFile file = radAsyncUpload.UploadedFiles[0];
                byte[] fileData = new byte[file.InputStream.Length];
                file.InputStream.Read(fileData, 0, (int)file.InputStream.Length);
                cmd.Parameters.Add("@Data", SqlDbType.Image);
                cmd.Parameters["@Data"].Value = fileData;
            }
            else
            {
                cmd = new SqlCommand("UPDATE [Images] SET [Name] = @Name, [Description] = @Description WHERE [ImageId] = @ImageId", conn);
            }

            cmd.Parameters.Add("@ImageId", SqlDbType.Int);
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50, "Name");
            cmd.Parameters.Add("@Description", SqlDbType.NVarChar);

            cmd.Parameters["@ImageId"].Value = ImageId;
            cmd.Parameters["@Name"].Value = imageName;
            cmd.Parameters["@Description"].Value = description;
            cmd.ExecuteScalar();
        }
    }
    
    protected void PhotoGrid_DeleteCommand(object source, GridCommandEventArgs e)
    {
        string ImageId = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ImageId"].ToString();

        using (SqlConnection conn = new SqlConnection(ConnectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM [Images] WHERE ImageId = @ImageId", conn);

            cmd.Parameters.Add("@ImageId", SqlDbType.Int);

            cmd.Parameters["@ImageId"].Value = ImageId;
            cmd.ExecuteScalar();
        }
    }
    
    public void RadAsyncUpload1_ValidatingFile(object sender, Telerik.Web.UI.Upload.ValidateFileEventArgs e)
    {
        if ((totalBytes < MaxTotalBytes) && (e.UploadedFile.ContentLength < MaxTotalBytes))
        {
            e.IsValid = true;
            totalBytes += e.UploadedFile.ContentLength;
            IsRadAsyncValid = true;
        }
        else
        {
            e.IsValid = false;
            IsRadAsyncValid = false;
        }
    }

    protected void PhotoGrid_ItemCommand(object source, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.EditCommandName || e.CommandName == RadGrid.InitInsertCommandName)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "SetEditMode", "isEditMode = true;", true);
            //The next code disables the module which causes the yellow image to blink forever
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "DisableFileApi", "Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable = function () { return false; };", true);
        }
        else if (e.CommandArgument == "MakeDefault")
        {
            string ImageId = (e.Item as GridDataItem).OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ImageId"].ToString();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE [MemberProfile] SET ImageId=@ImageId WHERE UserName = @UserName", conn);

                cmd.Parameters.Add("@ImageId", SqlDbType.Int);
                cmd.Parameters["@ImageId"].Value = ImageId;
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar, 256, "UserName");
                cmd.Parameters["@UserName"].Value = userName;
                cmd.ExecuteScalar();
            }

            UserListView.Rebind();
            Controls_ActiveMemberScroll ams = (Controls_ActiveMemberScroll)Page.LoadControl("~/Controls/ActiveMemberScroll.ascx");
            var rotator = (RadRotator)ams.Controls[1].Controls[0];
            rotator.DataBind();
        }
    }
}