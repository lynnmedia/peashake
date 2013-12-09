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
using FM.WebSync.Server;
using FM.WebSync.Core;

namespace Peashakehouse
{
    public partial class Friends : Page
    {
        protected static MembershipUser user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
        protected static string userName = user.UserName;
        protected static Guid guid = (Guid)user.ProviderUserKey;
        protected static string userID = guid.ToString();

        static string interestList = "''";
        static string selectClause = "SELECT p.userId,userName,firstName,lastName,city,state,c.countryname,gender,p.description,i.data,dbo.ufn_GetAge(birthdate,getdate()) as age FROM [MemberProfile] p LEFT JOIN Images i ON i.ImageId = p.ImageId JOIN [Countries] c ON c.CountryId = p.CountryId";
        static string whereClause = " WHERE p.userid != '" + userID + "'";
        static string andAge = "";
        static string andGender = "";
        static string andLocation = "";
        static string andKeyword = "";
        static string andActivity = "";
        static string userAge = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["PSHUserAge"] != null)
                userAge = Session["PSHUserAge"] as string;
            if (Session["memberSelectCommand"] == null)
            {
                FriendFinderSqlDataSource.SelectCommand = "";
            }
            else
            {
                FriendFinderSqlDataSource.SelectCommand = Session["memberSelectCommand"] as string;
            }
            LoadInterests();
            LoadContinents();
        }

        protected void UpdateFriendFinderSearch()
        {
            if (andAge == "" && andGender == "" && andLocation == "" && andKeyword == "" && andActivity == "")
                FriendFinderSqlDataSource.SelectCommand = "";
            else
                FriendFinderSqlDataSource.SelectCommand = selectClause + whereClause + andAge + andGender + andLocation + andKeyword + andActivity;
            Session["memberSelectCommand"] = FriendFinderSqlDataSource.SelectCommand;
            RadGrid1.Rebind();
        }

        protected void ContinentCb_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
        {
            LoadContinents();
        }

        protected void CountryCb_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
        {
            LoadCountries(e.Text);
        }

        protected void StateCb_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
        {
            LoadStates(e.Text);
        }

        protected void LoadContinents()
        {
            RadComboBox continentCb = (RadComboBox)RadPanelBar1.FindItemByValue("Location").FindControl("ContinentCb");
            continentCb.LoadContentFile("~/App_Data/Continents.xml");
        }

        protected void LoadCountries(string continentID)
        {
            SqlConnection connection = new SqlConnection(
            ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);

            //select a country based on the continentID
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CountryId, CountryName FROM Countries WHERE ContinentId=@ContinentId", connection);
            adapter.SelectCommand.Parameters.AddWithValue("@ContinentId", continentID);

            DataTable dt = new DataTable();
            adapter.Fill(dt);

            RadComboBox countryCb = (RadComboBox)RadPanelBar1.FindItemByValue("Location").FindControl("LocationPanel").FindControl("CountryCb");
            countryCb.DataTextField = "CountryName";
            countryCb.DataValueField = "CountryId";
            countryCb.DataSource = dt;
            countryCb.DataBind();
        }

        protected void LoadStates(string countryID)
        {
            RadComboBox stateCb = (RadComboBox)RadPanelBar1.FindItemByValue("Location").FindControl("StateCb");
            stateCb.LoadContentFile("~/App_Data/USA_States.xml");
        }

        protected void LoadInterests()
        {
            SqlDataReader interestReader = null;
            SqlConnection connection = null;
            SqlCommand command = null;
            Panel interestsPanel = (Panel)RadPanelBar1.FindItemByValue("Activity").FindControl("ActivityPanel");
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
                        interestsPanel.Controls.Add(header);
                        prevGroupName = groupName;
                    }

                    RadButton radButton = new RadButton();
                    radButton.ID = interestReader["Name"].ToString();
                    radButton.ToggleType = Telerik.Web.UI.ButtonToggleType.CheckBox;
                    radButton.ButtonType = Telerik.Web.UI.RadButtonType.ToggleButton;
                    radButton.AutoPostBack = true;
                    radButton.CssClass = "interestsCb";
                    radButton.GroupName = "Interests";
                    radButton.CheckedChanged += new EventHandler(radButton_CheckedChanged);

                    RadButtonToggleState checkedToggleState = new RadButtonToggleState(interestReader["Name"].ToString(), "rbToggleCheckboxChecked");
                    RadButtonToggleState uncheckedToggleState = new RadButtonToggleState(interestReader["Name"].ToString(), "rbToggleCheckbox");
                    radButton.ToggleStates.Add(checkedToggleState);
                    radButton.ToggleStates.Add(uncheckedToggleState);
                    interestsPanel.Controls.Add(radButton);
                    RadAjaxManager1.AjaxSettings.AddAjaxSetting(radButton, RadGrid1, RadAjaxLoadingPanel1);
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

        protected void Age_TextChanged(object sender, EventArgs e)
        {
            RadNumericTextBox loAge = (RadNumericTextBox)RadPanelBar1.FindItemByValue("Age").FindControl("AgePanel").FindControl("AgeFrom");
            RadNumericTextBox highAge = (RadNumericTextBox)RadPanelBar1.FindItemByValue("Age").FindControl("AgePanel").FindControl("AgeTo");
            andAge = " AND (dbo.ufn_GetAge(birthdate,getdate()) >=" + loAge.Value + "AND dbo.ufn_GetAge(birthdate,getdate()) <=" + highAge.Value + ")";
            UpdateFriendFinderSearch();
        }

        protected void GenderCb_Checked(Object sender, EventArgs e)
        {
            CheckBox femaleCb = (CheckBox)RadPanelBar1.FindItemByValue("Gender").FindControl("GenderPanel").FindControl("cbFemale");
            CheckBox maleCb = (CheckBox)RadPanelBar1.FindItemByValue("Gender").FindControl("GenderPanel").FindControl("cbMale");
            bool searchFemale = false;
            bool searchMale = false;
            string searchClause = "";
            if (femaleCb.Checked)
                searchFemale = true;
            if (maleCb.Checked)
                searchMale = true;
            if (searchFemale || searchMale)
            {
                searchClause = " AND (";
                if (searchFemale)
                {
                    searchClause += "Gender='F'";
                    if (searchMale)
                        searchClause += " OR Gender='M'";
                }
                else
                {
                    searchClause += "Gender='M'";
                }
                searchClause += ")";
            }
            andGender = searchClause;
            UpdateFriendFinderSearch();
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            string countryClause = "";
            string stateClause = "";

            RadComboBox countryCb = (RadComboBox)RadPanelBar1.FindItemByValue("Location").FindControl("LocationPanel").FindControl("CountryCb");
            RadComboBox stateCb = (RadComboBox)RadPanelBar1.FindItemByValue("Location").FindControl("LocationPanel").FindControl("StateCb");
            if (e.Argument == "Country")
            {
                countryClause = " AND p.countryId = " + countryCb.SelectedValue;
            }
            else if (e.Argument == "State")
            {
                stateClause = " AND p.state = '" + stateCb.SelectedValue + "'";
            }

            andLocation = countryClause + stateClause;
            UpdateFriendFinderSearch();
        }

        protected void Keyword_TextChanged(object sender, EventArgs e)
        {
            RadTextBox keywordTb = (RadTextBox)RadPanelBar1.FindItemByValue("Keyword").FindControl("KeywordPanel").FindControl("KeywordTb");
            andKeyword = " AND p.description like '%" + keywordTb.Text + "%'";
            UpdateFriendFinderSearch();
        }

        protected void radButton_CheckedChanged(object sender, EventArgs e)
        {
            RadButton radButton = (RadButton)sender;
            string sourceParameter = radButton.ID;
            if (radButton.Checked)
            {
                if (interestList.Length > 2)
                    interestList += ",'" + sourceParameter + "'";
                else
                    interestList = "'" + sourceParameter + "'";
            }
            else
            {
                int preLen = interestList.Length;
                string search = ",'" + sourceParameter + "'";
                string s = interestList.Replace(search, "");
                if (s.Length == preLen)
                {
                    search = "'" + sourceParameter + "'";
                    s = interestList.Replace(search, "''");
                }
                interestList = s;
            }

            andActivity = "";
            if (interestList.Length > 2)
                andActivity = " AND p.userid IN (select userid from memberInterest mi join Interests i on i.InterestId=mi.interestid where i.Name in (" + interestList + "))";
            UpdateFriendFinderSearch();
        }

        private void FriendRequests(string columnName)
        {
            RadGrid1.MasterTableView.GroupByExpressions.Clear();
            if (!string.IsNullOrEmpty(columnName))
                RadGrid1.MasterTableView.GroupByExpressions.Add(
                    new GridGroupByExpression(RadGrid1.MasterTableView.GetColumn(columnName)));
            RadGrid1.Rebind();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridNestedViewItem)
            {
                GridNestedViewItem nestedViewItem = (GridNestedViewItem)e.Item;
                RadButton winkButton = (RadButton)nestedViewItem.FindControl("send_wink");
                winkButton.Command += new CommandEventHandler(SendWinkCommandBtn_Click);
                RadButton chatButton = (RadButton)nestedViewItem.FindControl("chat_invite");
                chatButton.Command += new CommandEventHandler(ChatInviteCommandBtn_Click);
                RadButton friendButton = (RadButton)nestedViewItem.FindControl("friend_invite");
                friendButton.Command += new CommandEventHandler(FriendInviteCommandBtn_Click);
            }
        }

        protected void SendWinkCommandBtn_Click(Object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SendWink")
            {
                GridNestedViewItem nestedView = (sender as RadButton).NamingContainer as GridNestedViewItem;
                GridDataItem parentItem = nestedView.ParentItem;
                string name = parentItem.GetDataKeyValue("UserName").ToString();
                SendWink(name);
            }
        }

        protected void ChatInviteCommandBtn_Click(Object sender, CommandEventArgs e)
        {
            if (e.CommandName == "ChatInvite")
            {
                GridNestedViewItem nestedView = (sender as RadButton).NamingContainer as GridNestedViewItem;
                GridDataItem parentItem = nestedView.ParentItem;
                string name = parentItem.GetDataKeyValue("UserName").ToString();
                RequestChat(name);
            }
        }

        protected void FriendInviteCommandBtn_Click(Object sender, CommandEventArgs e)
        {
            if (e.CommandName == "FriendInvite")
            {
                GridNestedViewItem nestedView = (sender as RadButton).NamingContainer as GridNestedViewItem;
                GridDataItem parentItem = nestedView.ParentItem;
//                int index = parentItem.ItemIndex;
                string name = parentItem.GetDataKeyValue("UserName").ToString();
                InviteFriend(name);
            }
        }

        protected void SendWink(String recipientName)
        {
            SqlConnection connection = null;
            SqlCommand command = null;
            try
            {
                ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
                connection = new SqlConnection(connectionStringSettings.ConnectionString);
                command = new SqlCommand("SendWink", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@userId", userID));
                command.Parameters.Add(new SqlParameter("@recipientName", recipientName));
                connection.Open();
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
            }
            finally
            {
                connection.Close();
            }
        }

        protected void RequestChat(String friendName)
        {
            SqlConnection connection = null;
            Guid chatRoomId = System.Guid.Empty;
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
            connection = new SqlConnection(connectionStringSettings.ConnectionString);
            SqlCommand cmd = new SqlCommand("MakeConnection", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Sender", userName));
            cmd.Parameters.Add(new SqlParameter("@Recipient", friendName));
            cmd.Parameters.Add(new SqlParameter("@ChatRoomId", chatRoomId));
            cmd.Parameters["@ChatRoomId"].Direction = ParameterDirection.Output;
            connection.Open();
            cmd.ExecuteNonQuery();
            chatRoomId = (Guid)cmd.Parameters["@ChatRoomId"].Value;
            connection.Close();

            string channel = "/user/" + friendName;
            string invitation = userName + " would like to invite you to chat";
            Publication pub = RequestHandler.Publish(channel, JSON.Serialize(new Invitation() { Text = invitation, ChatID = chatRoomId, From = userName }));
            if (pub.Successful == true)
            {
                string chatChannel = "/chatroom/" + chatRoomId;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "openNextRadWindow();", true);
                
                String scriptName = "SubscribeChatScript";
                Type cstype = this.GetType();
                ClientScriptManager cs = Page.ClientScript;
                if (!cs.IsClientScriptBlockRegistered(scriptName))
                {
                    StringBuilder csText = new StringBuilder();
                    csText.Append("<script type=\"text/javascript\">");
                    csText.Append("client.subscribe({");
                    csText.Append("channel: chatChannel,");
                    csText.Append("onSuccess: function (args) {");
                    csText.Append("console.log('Subscribed:' + chatChannel);");
                    csText.Append("},");
                    csText.Append("onFailure: function (args) {");
                    csText.Append("console.log('Subscribe failed: ' + args.error);");
                    csText.Append("},");
                    csText.Append("onReceive: function (args) {");
                    csText.Append("console.log('Received data: ' + args.data.text);");
                    csText.Append("console.log('on: ' + args.data.chatId);");
                    csText.Append("displayChatMessage(args.data.from, args.data.text, args.data.chatId);");
                    csText.Append("}");
                    csText.Append("});");
                    csText.Append("</script>");
                    cs.RegisterClientScriptBlock(cstype, scriptName, csText.ToString());
                }
            }
        }

        protected void InviteFriend(String friendName)
        {
            string subject = "An invitation to be friends";
            string body = userName + " has invited you to be friends. You may respond by accepting or declining. You may also block this member from extending you further invitations.";
            SqlConnection connection = null;
            SqlCommand command = null;
            try
            {
                ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings["ApplicationServices"];
                connection = new SqlConnection(connectionStringSettings.ConnectionString);
                command = new SqlCommand("CreateFriendInvitation", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@userId", userID));
                command.Parameters.Add(new SqlParameter("@friendName", friendName));
                command.Parameters.Add(new SqlParameter("@subject", subject));
                command.Parameters.Add(new SqlParameter("@body", body));
                connection.Open();
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
            }
            finally
            {
                connection.Close();
            }
        }

    }
}


