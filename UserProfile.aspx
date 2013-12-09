<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" Title="Peashake Preferences - Profile" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Reference Control="~/Controls/ActiveMemberScroll.ascx"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<telerik:RadAjaxManager runat="Server" ID="RadAjaxManager1">
		<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="PhotoGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserListView" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PhotoGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="profile_save">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="UserListView" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="PhotoGrid" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
		</AjaxSettings>
	</telerik:RadAjaxManager>
	<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1">
	</telerik:RadAjaxLoadingPanel>
    <telerik:RadListView ID="UserListView" runat="server" DataSourceID="UserSqlDataSource"
        ItemPlaceholderID="ListViewContainer">
        <LayoutTemplate>
            <asp:PlaceHolder runat="server" id="ListViewContainer" />
        </LayoutTemplate>
        <ItemTemplate>
            <center>
                UserName: <%#Eval("UserName")%><br />
                <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
                    AutoAdjustImageControlSize="false" Width="120px" Height="120px" ToolTip='<%#Eval("UserName", "Photo of {0}") %>'
                    AlternateText='<%#Eval("UserName", "Photo of {0}") %>' /><br />
                <%#Eval("FirstName")%>&nbsp;<%#Eval("lastName")%><br />
                <%#Eval("Email")%><br />
                <%#Eval("City")%>,&nbsp;<%#Eval("State")%><br />
                <%#Eval("CountryName")%><br />
                <%#Eval("Gender")%> - <%#Eval("Age")%><br />
                Member since: <%#Eval("RegisterDate")%>
            </center>            
        </ItemTemplate>
    </telerik:RadListView>
    <asp:SqlDataSource ID="UserSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
	<div style="height: 100%;" class="grid-placeholder">
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="ProfileMultiPage"
            SelectedIndex="0" CssClass="tabStrip">
            <Tabs>
                <telerik:RadTab Text="Personal Info">
                </telerik:RadTab>
                <telerik:RadTab Text="Interests">
                </telerik:RadTab>
                <telerik:RadTab Text="Photos">
                </telerik:RadTab>
                <telerik:RadTab Text="Membership">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage runat="server" ID="ProfileMultiPage" SelectedIndex="0">
            <telerik:RadPageView runat="server" ID="InfoPageView">
                <div class="preferences">
                    <h3>Edit Your Personal Information</h3>
                    <asp:FormView ID="ProfileView" runat="server" DataSourceID="ProfileSqlDataSource" DefaultMode="Edit" DataKeyNames="UserName"
                        OnItemUpdated="ProfileView_OnItemUpdated" OnDataBound="ProfileView_DataBound" 
                        OnItemUpdating="ProfileView_ItemUpdating">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="profile_firstName" runat="server" Width="300px" Text='<%#Bind("FirstName") %>' 
                                EmptyMessage="enter your first name" Label="First Name:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadTextBox ID="profile_lastName" runat="server" Width="300px" Text='<%#Bind("LastName") %>' 
                                EmptyMessage="enter your last name" Label="Last Name:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadTextBox ID="profile_email" runat="server" Width="300px" Text='<%#Bind("Email") %>' 
                                EmptyMessage="enter your email address" Label="Email:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadTextBox ID="profile_city" runat="server" Width="300px" Text='<%#Bind("City") %>' 
                                EmptyMessage="enter your city" Label="City:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadComboBox ID="profile_state" runat="server" Width="150px" Height="100px" Label="State:" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="select your state" /><br />
                            <telerik:RadComboBox ID="profile_country" runat="server" Width="220px" Height="100px" Label="Country:" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="select your country" /><br />
                            <telerik:RadComboBox ID="profile_birthMonth" runat="server" Width="100px" Label="Birth Date:" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="month" />&nbsp;&nbsp;&nbsp;
                            <telerik:RadComboBox ID="profile_birthDay" runat="server" Width="60px" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="day" />&nbsp;&nbsp;&nbsp;
                            <telerik:RadComboBox ID="profile_birthYear" runat="server" Width="80px" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="year" /><br />
                            <telerik:RadTextBox ID="profile_description" runat="server" Width="300px" Height="100px" 
                                Text='<%#Bind("Description") %>' EmptyMessage="describe yourself briefly        (this is one way members may find you in searches)" Label="Description:" 
                                CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" TextMode="MultiLine" Rows="5" Columns="5">
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br /><br />
                            <center>
                                <telerik:RadButton ID="profile_female" runat="server" ToggleType="Radio" ButtonType="StandardButton"
                                    GroupName="profile_gender" AutoPostBack="false">
                                    <ToggleStates>
                                        <telerik:RadButtonToggleState Text="Female" PrimaryIconCssClass="rbToggleRadioChecked" />
                                        <telerik:RadButtonToggleState Text="Female" PrimaryIconCssClass="rbToggleRadio" />
                                    </ToggleStates>
                                </telerik:RadButton>&nbsp;&nbsp;&nbsp;
                                <telerik:RadButton ID="profile_male" runat="server" ToggleType="Radio" ButtonType="StandardButton"
                                    GroupName="profile_gender" AutoPostBack="false">
                                    <ToggleStates>
                                        <telerik:RadButtonToggleState Text="Male" PrimaryIconCssClass="rbToggleRadioChecked" />
                                        <telerik:RadButtonToggleState Text="Male" PrimaryIconCssClass="rbToggleRadio" />
                                    </ToggleStates>
                                </telerik:RadButton><br /><br />
                                <telerik:RadButton ID="profile_save" runat="server" Text="Save" Width="120px" UseSubmitBehavior="false" CommandName="Update"></telerik:RadButton>
                            </center>
                        </EditItemTemplate>
                    </asp:FormView>
                </div>
                <asp:SqlDataSource id="ProfileSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DatasourceMode="DataReader"
                    UpdateCommand = "UPDATE MemberProfile SET FirstName=@FirstName, LastName=@LastName, Email=@Email, City=@City, State=@State, CountryId=@CountryId, BirthDate=@BirthDate, Gender=@Gender, Description=@Description WHERE UserName = @UserName">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="ProfileView$profile_state" PropertyName="SelectedValue" Name="State" />
                        <asp:ControlParameter ControlID="ProfileView$profile_country" PropertyName="SelectedValue" Name="CountryId" />
                        <asp:Parameter Name="Gender" />
                        <asp:Parameter Name="BirthDate" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </telerik:RadPageView>
            <telerik:RadPageView ID="InterestsPageView" runat="server">
                <div class="preferences">
                    <h3>Describe Your Interests</h3>
                    <asp:Panel ID="panelInterests" runat="server">
                    </asp:Panel>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="PhotoPageView" runat="server">
                <div class="preferences">
                    <h3>Upload/Organize Your Photos</h3>
                    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
                        <script type="text/javascript">
                            var uploadedFilesCount = 0;
                            var isEditMode;
                            function validateRadUpload(source, e) {
                                // When the RadGrid is in Edit mode the user is not obliged to upload file.
                                if (isEditMode == null || isEditMode == undefined) {
                                    e.IsValid = false;

                                    if (uploadedFilesCount > 0) {
                                        e.IsValid = true;
                                    }
                                }
                                isEditMode = null;
                            }

                            function OnClientFileUploaded(sender, eventArgs) {
                                uploadedFilesCount++;
                            }
                        </script>
                    </telerik:RadCodeBlock>
                    <telerik:RadGrid runat="server" ID="PhotoGrid" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                        Width="97%" ShowStatusBar="True" GridLines="None" OnItemCreated="PhotoGrid_ItemCreated" PageSize="3" 
                        OnInsertCommand="PhotoGrid_InsertCommand" OnNeedDataSource="PhotoGrid_NeedDataSource" OnDeleteCommand="PhotoGrid_DeleteCommand"
                        OnUpdateCommand="PhotoGrid_UpdateCommand" onitemcommand="PhotoGrid_ItemCommand">
                        <PagerStyle Mode="Slider" AlwaysVisible="true" />
                        <MasterTableView Width="100%" CommandItemDisplay="Top" DataKeyNames="ImageId">
                            <CommandItemSettings AddNewRecordText="Upload new photo" />
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                    <HeaderStyle Width="3%" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridTemplateColumn UniqueName="Make Default">
                                    <ItemTemplate>
                                        <asp:LinkButton CommandArgument="MakeDefault" ID="MakeDefaultBtn" Text="Make Default" runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Data" HeaderText="Image" UniqueName="Upload">
                                    <ItemTemplate>
                                        <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
                                            AutoAdjustImageControlSize="false" Height="80px" Width="80px" ToolTip='<%#Eval("Name", "Photo of {0}") %>'
                                            AlternateText='<%#Eval("Name", "Photo of {0}") %>' ResizeMode="Fit" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" OnClientFileUploaded="OnClientFileUploaded"
                                            AllowedFileExtensions="jpg,jpeg,png,gif"
                                            MaxFileSize="1048576" OnValidatingFile="RadAsyncUpload1_ValidatingFile">
                                        </telerik:RadAsyncUpload>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Image Name" UniqueName="ImageName" SortExpression="Name">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox runat="server" Width="150px" ID="txbName" Text='<%# Eval("Name") %>' />
                                    </EditItemTemplate>
                                    <HeaderStyle Width="30%" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" DataField="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" runat="server" Text='<%# TrimDescription(Eval("Description") as string) %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txbDescription" Width="200px" runat="server" TextMode="MultiLine"
                                            Text='<%# Eval("Description") %>' Height="150px" />
                                    </EditItemTemplate>
                                    <ItemStyle VerticalAlign="Top" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton">
                                    <HeaderStyle Width="2%" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="MembershipPageView" runat="server">
                <div class="preferences">
                    <h3>Update Your Membership</h3>
                    <asp:FormView ID="MembershipView" runat="server" DataSourceID="MembershipSqlDataSource" OnDataBound="MembershipView_DataBound"
                        DefaultMode="Edit" DataKeyNames="UserID">
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="membership_cardType" runat="server" Width="120px" Height="80px" Label="Card Type:" 
                                CssClass="PrefComboBox" LabelCssClass="PrefCbLabel" EmptyMessage="select card type" /><br />
                            <telerik:RadTextBox ID="membership_cardName" runat="server" Width="300px" Text='<%#Bind("CardName") %>' 
                                Label="Name on Card:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadTextBox ID="membership_cardAddress" runat="server" Width="300px" Text='<%#Bind("CardAddress") %>' 
                                EmptyMessage="enter billing address" Label="Address:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadTextBox ID="membership_cardCity" runat="server" Width="300px" Text='<%#Bind("CardCity") %>' 
                                EmptyMessage="enter city" Label="City:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadComboBox ID="membership_cardState" runat="server" Width="150px" Height="100px" Label="State:" 
                                CssClass="PrefComboBox" LabelCssClass="PrefCbLabel" EmptyMessage="select your state" /><br />
                            <telerik:RadTextBox ID="membership_cardZip" runat="server" Width="180px" Text='<%#Bind("CardZip") %>' 
                                EmptyMessage="enter your zip" Label="Zip:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadComboBox ID="membership_cardCountry" runat="server" Width="220px" Height="100px" Label="Country:" 
                                CssClass="PrefComboBox" LabelCssClass="PrefCbLabel" EmptyMessage="select your country" /><br />
                            <telerik:RadTextBox ID="membership_cardNumber" runat="server" Width="300px" Text='<%#Bind("CardNumber") %>' 
                                EmptyMessage="enter card number" Label="Card Number:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br />
                            <telerik:RadComboBox ID="membership_expMonth" runat="server" Width="100px" Label="Exp Month:" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabel" EmptyMessage="exp month" />&nbsp;&nbsp;&nbsp;
                            <telerik:RadComboBox ID="membership_expYear" runat="server" Width="80px" Label="Year:" CssClass="PrefComboBox" 
                                LabelCssClass="PrefCbLabelhalfMargin" EmptyMessage="exp year" /><br />
                            <telerik:RadTextBox ID="membership_cardCid" runat="server" Width="140px" Text='<%#Bind("CardCID") %>' 
                                EmptyMessage="enter card security code" Label="Security code:" CssClass="PrefTextBox" LabelCssClass="PrefTbLabel" >
                                <EmptyMessageStyle CssClass="PrefEmptyTextBox" />
                                <FocusedStyle CssClass="PrefFocusedTextBox" />
                                <HoveredStyle CssClass="PrefHoveredTextBox" />
                                <InvalidStyle CssClass="PrefInvalidTextBox" />
                            </telerik:RadTextBox><br /><br />
                            <center><telerik:RadButton ID="membership_pay" runat="server" Text="Submit Payment" Width="120px" UseSubmitBehavior="false" CommandName="Update" /></center>
                        </EditItemTemplate>
                    </asp:FormView>
                </div>
                <asp:SqlDataSource id="MembershipSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" DatasourceMode="DataReader" 
                    UpdateCommand = "UPDATE Address SET CardName=@CardName, Address1=@CardAddress, City=@CardCity, State=@CardState, Zip=@CardZip, CountryId=@CountryId, CardType=@CardType, CardNumber=@CardNumber, CardExpirationMonth=@CardExpMonth, CardExpirationYear=@CardExpYear, CardCID=@CardCID WHERE UserID = @UserID">
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="MembershipView$membership_cardType" PropertyName="SelectedValue" Name="CardType" />
                        <asp:ControlParameter ControlID="MembershipView$membership_cardState" PropertyName="SelectedValue" Name="CardState" />
                        <asp:ControlParameter ControlID="MembershipView$membership_cardCountry" PropertyName="SelectedValue" Name="CountryId" />
                        <asp:ControlParameter ControlID="MembershipView$membership_expMonth" PropertyName="SelectedValue" Name="CardExpMonth" />
                        <asp:ControlParameter ControlID="MembershipView$membership_expYear" PropertyName="SelectedValue" Name="CardExpYear" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
	</div>
</asp:Content>
