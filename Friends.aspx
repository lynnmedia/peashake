<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
	CodeFile="Friends.aspx.cs" Inherits="Peashakehouse.Friends" Title="Peashake Preferences - Friends" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
		<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cbFemale">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cbMale">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="AgeFrom">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="AgeTo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="KeywordTb">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
		</AjaxSettings>
	</telerik:RadAjaxManager>
	<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1">
	</telerik:RadAjaxLoadingPanel>
    <asp:Image ID="Logo" ImageUrl="~/Images/Friend-Finder.gif" height="48" width="240" runat="server" />
	<telerik:RadPanelBar runat="server" ID="RadPanelBar1" Width="100%" OnClientItemExpand="clientItemExpand">
		<Items>
			<telerik:RadPanelItem Text="Age" Expanded="True" runat="server">
				<Items>
					<telerik:RadPanelItem runat="server" Value="Age">
						<ItemTemplate>
                            <asp:Panel ID="AgePanel" runat="server" CssClass="ff_panel">
                                <span class="instructions">Searching for friends in the age range</span><br  />
                                <telerik:RadNumericTextBox ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true"
                                    IncrementSettings-InterceptMouseWheel="true" Label="From:" runat="server" Value='20' MinValue="14" MaxValue="119"
                                    ID="AgeFrom" Width="80px" Type="Number" NumberFormat-DecimalDigits="0" OnTextChanged="Age_TextChanged"
                                    LabelCssClass="FriendFinderLabel" AutoPostBack="true">
                                    <ClientEvents OnValueChanged="ValueChanged" />
                                </telerik:RadNumericTextBox>&nbsp;&nbsp;&nbsp;
                                <telerik:RadNumericTextBox ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true"
                                    IncrementSettings-InterceptMouseWheel="true" Label="to:" runat="server" Value='35'
                                    ID="AgeTo" Width="80px" Type="Number" NumberFormat-DecimalDigits="0" MinValue="15" MaxValue="120"
                                    LabelCssClass="FriendFinderLabel" AutoPostBack="true" OnTextChanged="Age_TextChanged">
                                    <ClientEvents OnValueChanged="ValueChanged" />
                                </telerik:RadNumericTextBox>
                            </asp:Panel>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
			<telerik:RadPanelItem Text="Gender" Expanded="True" runat="server">
				<Items>
					<telerik:RadPanelItem runat="server" Value="Gender">
						<ItemTemplate>
                            <asp:Panel ID="GenderPanel" runat="server" CssClass="ff_panel">
                                <span class="instructions">Searching for females, males or both</span><br  />
                                <asp:CheckBox id="cbFemale" Text="Female" TextAlign="Right" AutoPostBack="True" runat="server" 
                                    OnCheckedChanged="GenderCb_Checked" CssClass="genderCb" />&nbsp;&nbsp;
                                <asp:CheckBox id="cbMale" Text="Male" TextAlign="Right" AutoPostBack="True" runat="server"
                                OnCheckedChanged="GenderCb_Checked" CssClass="genderCb" />
                            </asp:Panel>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
			<telerik:RadPanelItem Text="Location" Expanded="False" runat="server">
				<Items>
					<telerik:RadPanelItem runat="server" Value="Location">
						<ItemTemplate>
                            <asp:Panel ID="LocationPanel" runat="server" CssClass="ff_panel">
                                <span class="instructions">Searching for friends based on location</span><br />
                                <asp:Label ID="ContinentLabel" runat="server" AssociatedControlID="ContinentCb" CssClass="FriendFinderLabel">Continent:</asp:Label>
                                <telerik:RadComboBox ID="ContinentCb" EmptyMessage="Select Your Continent" runat="server"
                                    Width="150px" CssClass="PrefComboBox" OnClientSelectedIndexChanging="LoadCountries"
                                    OnItemsRequested="ContinentCb_ItemsRequested" />
                                <br />
                                <asp:Label ID="CountryLabel" runat="server" AssociatedControlID="CountryCb" CssClass="FriendFinderLabel">Country:</asp:Label>
                                <telerik:RadComboBox ID="CountryCb" EmptyMessage="Select Your Country" runat="server"
                                    Width="150px" CssClass="PrefComboBox" OnClientSelectedIndexChanging="LoadStates"
                                    Enabled="false" OnClientItemsRequested="ItemsLoaded" OnItemsRequested="CountryCb_ItemsRequested" />
                                <br />
                                <asp:Label ID="StateLabel" runat="server" AssociatedControlID="StateCb" CssClass="FriendFinderLabel">State:</asp:Label>
                                <telerik:RadComboBox ID="StateCb" EmptyMessage="Select Your State" runat="server"
                                    Width="150px" Enabled="false" CssClass="PrefComboBox" OnClientItemsRequested="ItemsLoaded"
                                    OnItemsRequested="StateCb_ItemsRequested" OnClientSelectedIndexChanged="StateSelectedIndexChanged" />
                            </asp:Panel>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
			<telerik:RadPanelItem Text="Keyword" Expanded="False" runat="server">
				<Items>
					<telerik:RadPanelItem runat="server" Value="Keyword">
						<ItemTemplate>
                            <asp:Panel ID="KeywordPanel" runat="server" CssClass="ff_panel">
                                <span class="instructions">Searching for friends based on a keyword</span><br  />
                                <telerik:RadTextBox ID="KeywordTb" runat="server" Width="200px" Text='<%#Bind("keyword") %>' OnTextChanged="Keyword_TextChanged" 
                                    Label="Keyword:" CssClass="PrefTextBox" LabelCssClass="FriendFinderLabel" AutoPostBack="true">
                                    <FocusedStyle CssClass="PrefFocusedTextBox" />
                                    <HoveredStyle CssClass="PrefHoveredTextBox" />
                                    <InvalidStyle CssClass="PrefInvalidTextBox" />
                                </telerik:RadTextBox>&nbsp;&nbsp;&nbsp;
                            </asp:Panel>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
			<telerik:RadPanelItem Text="Activity" Expanded="False" runat="server">
				<Items>
					<telerik:RadPanelItem runat="server" Value="Activity">
						<ItemTemplate>
                            <asp:Panel ID="ActivityPanel" runat="server" CssClass="ff_panel">
                                <span class="instructions">Searching based on common activities</span><br  />
                            </asp:Panel>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
		</Items>
	</telerik:RadPanelBar>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
	<telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
        <script type="text/javascript">
        //<![CDATA[
            function ValueChanged(sender, args) {
                var otherBox = $find(sender.get_id().replace("AgeFrom", "AgeTo"));
                if (otherBox == sender) {
                    otherBox = $find(sender.get_id().replace("AgeTo", "AgeFrom"));
                    if (sender.get_value() < otherBox.get_value()) {
                        otherBox.set_value(sender.get_value());
                    }
                }
                else {
                    if (sender.get_value() > otherBox.get_value()) {
                        otherBox.set_value(sender.get_value());
                    }
                }
            }
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow;
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
                return oWindow;
            }
            function openNextRadWindow() {
                GetRadWindow().BrowserWindow.openChatWin();
            }
            function openChatWin() {
                radopen(null, "ChatWindow");
            }
            function clientItemExpand(sender, args) {
                var itemText = args.get_item().get_text();
                $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest(itemText);
            }

            function onGridRowClicked(sender, args) {
                args.get_tableView().fireCommand("ExpandCollapse", args.get_itemIndexHierarchical());
            }

            var countriesCombo;
            var statesCombo;
            var ajaxManager1;

            function pageLoad() {
                countriesCombo = Telerik.Web.UI.RadComboBox.ComboBoxes[1];
                statesCombo = Telerik.Web.UI.RadComboBox.ComboBoxes[2];
            }

            function LoadCountries(combo, eventArqs) {
                var item = eventArqs.get_item();
                countriesCombo.set_text("Loading...");
                statesCombo.clearSelection();

                // if a continent is selected
                if (item.get_index() >= 0) {
                    countriesCombo.enable();
                    // this will fire the ItemsRequested event of the
                    // countries combobox passing the continentID as a parameter
                    countriesCombo.requestItems(item.get_value(), false);
                }
                else {
                    countriesCombo.disable();
                    // the -Select a continent- item was chosen
                    countriesCombo.set_text(" ");
                    countriesCombo.clearItems();

                    statesCombo.set_text(" ");
                    statesCombo.clearItems();
                }
            }

            function LoadStates(combo, eventArqs) {
                var item = eventArqs.get_item();
                if (item.get_value() == 225) {
                    statesCombo.set_text("Loading...");
                    statesCombo.enable();
                    statesCombo.requestItems(item.get_value(), false);
                }
                else {
                    statesCombo.set_text("United States only");
                    statesCombo.disable();
                    $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("Country");
                }
            }

            function StateSelectedIndexChanged(combo, eventArgs) {

                var item = eventArgs.get_item();
                $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("State");
            }

            function ItemsLoaded(combo, eventArqs) {
                if (combo.get_items().get_count() > 0) {
                    // pre-select the first item
                    combo.set_text(combo.get_items().getItem(0).get_text());
                    combo.get_items().getItem(0).highlight();
                    combo.showDropDown();
                }
            }

        //]]>                                                                        
		</script>

	</telerik:RadScriptBlock>
	<telerik:RadSplitter runat="server" ID="RadSplitter1" Width="100%" BorderSize="0"
		BorderStyle="None" PanesBorderSize="0" Height="100%" Orientation="Horizontal">
		<telerik:RadPane runat="server" ID="gridPane">
			<telerik:RadGrid runat="Server" ID="RadGrid1" 
                DataSourceID="FriendFinderSqlDataSource" GridLines="None"
				Height="100%" BorderWidth="0px" AllowSorting="True" Style="outline: none" 
                CellSpacing="0">
				<ClientSettings Scrolling-AllowScroll="True" Scrolling-UseStaticHeaders="true" 
                    EnableRowHoverStyle="true" ClientEvents-OnRowClick="onGridRowClicked" 
                    Selecting-AllowRowSelect="true" AllowRowsDragDrop="true">
				    <Selecting AllowRowSelect="True" />
                    <ClientEvents OnRowClick="onGridRowClicked" />
				</ClientSettings>
                <MasterTableView AutoGenerateColumns="False" Width="100%" DataKeyNames="UserName" 
                    DataSourceID="FriendFinderSqlDataSource">
					<CommandItemSettings ExportToPdfText="Export to PDF" />
                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                        Visible="True">
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="UserName" 
                            HeaderText="UserName" SortExpression="UserName" UniqueName="UserName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Gender" 
                            HeaderText="Gender" SortExpression="Gender" UniqueName="Gender">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Age" 
                            HeaderText="Age" SortExpression="Age" UniqueName="Age">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="City" 
                            FilterControlAltText="Filter City column" HeaderText="City" 
                            SortExpression="City" UniqueName="City">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="State" 
                            FilterControlAltText="Filter State column" HeaderText="State" 
                            SortExpression="State" UniqueName="State">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="CountryName" Groupable="true"  GroupByExpression="Group By Country.CountryName"
                            FilterControlAltText="Filter Country column" HeaderText="Country" 
                            SortExpression="CountryName" UniqueName="CountryName">
                            <ItemTemplate>
                                <%# Eval("CountryName") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                        
                    </Columns>
					<NestedViewTemplate>
						<div class="contact-col">
                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
                                AutoAdjustImageControlSize="false" Width="120px" Height="120px" ToolTip='<%#Eval("UserName", "Photo of {0}") %>'
                                PersistDataIfNotVisible="true" /></div>
                        <div class="contact-col">
							<%# Eval("FirstName") + " " + Eval("LastName") %> (<%# Eval("UserName") %>)<br />
							<%# Eval("Gender") %> - <%# Eval("Age") %><br />
							<%# Eval("City") %>, <%# Eval("State") %> <%# Eval("CountryName") %><br />
                            <%# Eval("Description") %>
                        </div>
                        <div class="contact-col">
                            <telerik:RadButton ID="send_wink" runat="server" Text="Send a Wink" Width="120px" UseSubmitBehavior="false" CommandName="SendWink" OnCommand="SendWinkCommandBtn_Click"></telerik:RadButton>
                            <telerik:RadButton ID="chat_invite" runat="server" Text="Invite to Chat" Width="120px" UseSubmitBehavior="false" CommandName="ChatInvite" OnCommand="ChatInviteCommandBtn_Click"></telerik:RadButton>
                            <telerik:RadButton ID="friend_invite" runat="server" Text="Make a Friend" Width="120px" UseSubmitBehavior="false" CommandName="FriendInvite" OnCommand="FriendInviteCommandBtn_Click"></telerik:RadButton><br /><br />
                        </div>
					</NestedViewTemplate>
				</MasterTableView>
                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                </HeaderContextMenu>
			</telerik:RadGrid>
            <asp:SqlDataSource ID="FriendFinderSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
            </asp:SqlDataSource>
		</telerik:RadPane>
	</telerik:RadSplitter>
</asp:Content>
