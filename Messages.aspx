<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
CodeFile="Messages.aspx.cs" Inherits="Message" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
		<AjaxSettings>
			<telerik:AjaxSetting AjaxControlID="RadGrid1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="DetailsView1" LoadingPanelID="RadAjaxLoadingPanel1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="RadTreeView1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
					<telerik:AjaxUpdatedControl ControlID="RadToolBar1" />
					<telerik:AjaxUpdatedControl ControlID="DetailsView1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
					<telerik:AjaxUpdatedControl ControlID="DetailsView1" LoadingPanelID="RadAjaxLoadingPanel1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
		</AjaxSettings>
	</telerik:RadAjaxManager>
	<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1">
        <asp:Image id="Image1" runat="server" Width="90px" Height="72px" ImageUrl="Images/Mr-P.gif"></asp:Image>
	</telerik:RadAjaxLoadingPanel>
	<telerik:RadTreeView runat="Server" ID="RadTreeView1" OnNodeClick="RadTreeView1_NodeClick"
		EnableViewState="false">
		<Nodes>
			<telerik:RadTreeNode Text="Email" Expanded="true" ImageUrl="Images/mailbox.gif"
				PostBack="true" Selected="True">
			</telerik:RadTreeNode>
			<telerik:RadTreeNode Text="SMS" Expanded="true" ImageUrl="Images/mailbox.gif"
				PostBack="true">
			</telerik:RadTreeNode>
		</Nodes>
	</telerik:RadTreeView>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
	<telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">

		<script type="text/javascript">
			/* <![CDATA[ */
			var toolbar;
			var grid;
			var searchButton;
			var ajaxManager;

			function pageLoad() {
				grid = $find("<%=RadGrid1.ClientID %>");
				toolbar = $find("<%= RadToolBar1.ClientID %>");
				ajaxManager = $find("<%=RadAjaxManager1.ClientID %>");

				if (grid.get_masterTableView().get_selectedItems().length == 0)
					toolbar.findButtonByCommandName("reply").disable();

				searchButton = toolbar.findButtonByCommandName("doSearch");

				$telerik.$(".inbox-search-textbox")
							.bind("keypress", function(e) {
								searchButton.set_imageUrl("images/search.gif");
								searchButton.set_value("search");
							});
			}

			function onKeyPress(sender, args) {
				if (args.get_keyCode() == 13) {
					args.get_domEvent().stopPropagation();
					args.get_domEvent().preventDefault();
					performSearch(sender);
					return;
				}
			}

			function onButtonClicked(sender, args) {
				var commandName = args.get_item().get_commandName();
				if (commandName == "doSearch") {
					var searchTextBox = sender.findButtonByCommandName("searchText").findControl("RadTextBox1");
					if (searchButton.get_value() == "clear") {
						searchTextBox.set_value("");
						searchButton.set_imageUrl("images/search.gif");
						searchButton.set_value("search");
					}

					performSearch(searchTextBox);
				} else if (commandName == "reply") {
					window.radopen(null, "comp");
				}
			}

			function performSearch(searchTextBox) {
				if (searchTextBox.get_value()) {
					searchButton.set_imageUrl("images/clear.gif");
					searchButton.set_value("clear");
				}

				ajaxManager.ajaxRequest(searchTextBox.get_value());
			}

			function onGridRowSelected(sender, args) {
				toolbar.findButtonByCommandName("reply").enable();
			}
			
			function onWindowLoad(sender, args) {

				var html = "<br /><br /><br /><hr />" +
							"<strong>From:</strong> " + $get("from").innerHTML + "<br />" +
							"<strong>Sent:</strong> " + $get("sent").innerHTML + "<br />" +
							"<strong>Subject:</strong> " + $get("subject").innerHTML + "<br />" +
							
							$get("message-body").innerHTML;
				
				sender.get_contentFrame().contentWindow.setEditorContent(html);
			}
			/* ]]> */
		</script>

	</telerik:RadScriptBlock>
	<telerik:RadWindowManager runat="Server" ID="RadWindowManager1" EnableViewState="false">
		<Windows>
			<telerik:RadWindow runat="server" ID="Edit" NavigateUrl="~/Compose.aspx" OnClientPageLoad="onWindowLoad"
				Width="870px" Height="550px" ReloadOnShow="true"
				ShowContentDuringLoad="false" Modal="True" Behaviors="Close,Move" VisibleStatusbar="false">
			</telerik:RadWindow>
		</Windows>
	</telerik:RadWindowManager>
	<telerik:RadSplitter runat="server" ID="RadSplitter1" Width="100%" BorderSize="0"
		BorderStyle="None" PanesBorderSize="0" Height="100%" Orientation="Horizontal">
		<telerik:RadPane runat="server" ID="RadPane1" Height="32px" EnableViewState="false" Scrollable="false">
			<telerik:RadToolBar runat="server" ID="RadToolBar1" CssClass="inbox-search-toolbar"
				OnClientButtonClicked="onButtonClicked" EnableViewState="false">
				<Items>
					<telerik:RadToolBarButton Text="Send Message" ImageUrl="~/Images/reply.gif" CommandName="reply" />
					<telerik:RadToolBarButton Value="searchTextBoxButton" CommandName="searchText">
						<ItemTemplate>
							<telerik:RadTextBox
								runat="server" ID="RadTextBox1"
								EmptyMessage="Search Messages"
								CssClass="inbox-search-textbox" Width="200px"
								ClientEvents-OnKeyPress="onKeyPress" />
						</ItemTemplate>
					</telerik:RadToolBarButton>
					<telerik:RadToolBarButton ImageUrl="~/Images/search.gif" Value="search" CommandName="doSearch" />
				</Items>
			</telerik:RadToolBar>
		</telerik:RadPane>
		<telerik:RadPane runat="server" ID="RadPane2">
			<telerik:RadGrid runat="server" ID="RadGrid1" DataSourceID="LinqDataSource1" AutoGenerateColumns="false"
				GridLines="None" Height="100%" BorderWidth="0" AllowSorting="true" Style="outline: none"
				ShowGroupPanel="true">
				<ClientSettings Scrolling-AllowScroll="True" Scrolling-UseStaticHeaders="true" Selecting-AllowRowSelect="true"
					EnablePostBackOnRowClick="true" AllowDragToGroup="true" EnableRowHoverStyle="true"
					ClientEvents-OnRowSelected="onGridRowSelected">
				</ClientSettings>
				<MasterTableView TableLayout="Fixed" GroupLoadMode="Client" DataKeyNames="MessageID"  Width="100%"
					AdditionalDataFieldNames="Date">
					<GroupByExpressions>
						<telerik:GridGroupByExpression>
							<GroupByFields>
								<telerik:GridGroupByField FieldName="DateResult" HeaderValueSeparator=":" SortOrder="Descending" />
							</GroupByFields>
							<SelectFields>
								<telerik:GridGroupByField FieldName="DateResult" HeaderText="Date" FormatString="{0:d}" />
							</SelectFields>
						</telerik:GridGroupByExpression>
					</GroupByExpressions>
					<Columns>
						<telerik:GridBoundColumn DataField="To" HeaderText="To" HeaderStyle-Width="120px">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="Subject" HeaderText="Subject" GroupByExpression="ConversationResult Conversation GROUP BY ConversationResult">
						</telerik:GridBoundColumn>
						<telerik:GridBoundColumn DataField="Sent" HeaderText="Date" HeaderStyle-Width="150px"
							GroupByExpression="DateResult Date GROUP BY DateResult">
						</telerik:GridBoundColumn>
						<telerik:GridCalculatedColumn UniqueName="Date" DataType="System.DateTime" DataFields="Sent"
							Expression="Sent.Value.Date" HeaderText="Date" Visible="false">
						</telerik:GridCalculatedColumn>
						<telerik:GridCalculatedColumn UniqueName="Conversation" DataType="System.String"
							DataFields="Subject" Expression='Subject.Replace("RE: ", "")' HeaderText="Conversation"
							Visible="false">
						</telerik:GridCalculatedColumn>
					</Columns>
				</MasterTableView>
			</telerik:RadGrid>
			<asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="HelpDeskDataContext"
				TableName="Message" Where='Folder == @Folder' OnSelecting="LinqDataSource1_Selecting"
				OrderBy="Sent DESC">
				<WhereParameters>
					<asp:ControlParameter ControlID="ctl00$ContentPlaceHolder1$RadTreeView1" Name="Folder" />
				</WhereParameters>
			</asp:LinqDataSource>
		</telerik:RadPane>
		<telerik:RadSplitBar runat="server" ID="RadSplitBar1" />
		<telerik:RadPane runat="server" ID="RadPane3" Height="240px">
			<asp:DetailsView runat="server" ID="DetailsView1" DataSourceID="LinqDataSource2"
				AutoGenerateRows="false" CssClass="message-view" GridLines="None" EnableViewState="false">
				<Fields>
					<asp:TemplateField ShowHeader="false">
						<ItemTemplate>
							<ul>
								<li><h3 id="subject"><%# Eval("Subject") %></h3></li>
								<li><span id="to"><%# Eval("To") %></span></li>
								<li>Sent: <span id="sent"><%# Eval("Sent") %></span></li>
							</ul>
							<div id="message-body">
								<%# ((string)Eval("Body")).Replace("\n", "<br />") %>
							</div>
						</ItemTemplate>
					</asp:TemplateField>
				</Fields>
			</asp:DetailsView>
			<asp:LinqDataSource runat="server" ID="LinqDataSource2" ContextTypeName="HelpDeskDataContext"
				TableName="Message" Where="MessageID == Convert.ToInt32(@MessageID)">
				<WhereParameters>
					<asp:ControlParameter ControlID="ctl00$ContentPlaceHolder2$RadGrid1" Name="MessageID" />
				</WhereParameters>
			</asp:LinqDataSource>
		</telerik:RadPane>
	</telerik:RadSplitter>
</asp:Content>
