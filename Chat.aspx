<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Peashake Chat</title>
    <link href="Styles/chat.css" rel="stylesheet" type="text/css" />	
	<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
		<script type="text/javascript">
		    function friendMouseOver(sender) {
		        sender.className = "rlvHover";
		    }
		    function friendMouseOut(sender) {
		        sender.className = "rlvItem";
		    }
		    function friendMouseOutSelected(sender) {
		        sender.className = "rlvSelected";
		    }

		    var currentLoadingPanel = null;
		    var currentUpdatedControl = null;
		    function ShowLoadingPanel() {
		        currentLoadingPanel = $find("<%= ContentLoadingPanel.ClientID%>");
		        currentUpdatedControl = "<%= Content.ClientID %>";
		        currentLoadingPanel.show(currentUpdatedControl);
		    }
		    function HideLoadingPanel() {
		        if (currentLoadingPanel != null)
		            currentLoadingPanel.hide(currentUpdatedControl);
		        currentUpdatedControl = null;
		        currentLoadingPanel = null;
		    }
		    function OnChatEditorLoad(editor, args) {
		        editor.attachEventHandler("onkeydown", function (eventArgs) {
		            var key = eventArgs.keyCode;
		            if (key == "13") {
		                var editor1 = $find("<%=ReadEditor.ClientID %>");
		                editor1.get_document().body.innerHTML = editor.get_html(true);
		            }
		        });
		    }
		    function OnClientCommandExecuting(editor, args) {
		        var name = args.get_name();
		        var val = args.get_value();
		        if (name == "Emoticons") {
		            var tool = args.get_tool();
		            var span = tool.get_element().getElementsByTagName("SPAN")[0];
		            span.style.backgroundImage = "url(" + val + ")";
		            editor.pasteHtml("<img src='" + val + "'>");
		            //Cancel the further execution of the command as such a command does not exist in the editor command list     
		            args.set_cancel(true);
		        }
		    }    
        </script>
	</telerik:RadCodeBlock>
</head>
<body>
	<form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1">
	    <Scripts>
		    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
		    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
	    </Scripts>
    </telerik:RadScriptManager>
    
    <telerik:RadStyleSheetManager runat="server" ID="RadStyleSheetManager1" />
    <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="Scrollbars" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnableAJAX="true">
        <AjaxSettings>
		    <telerik:AjaxSetting AjaxControlID="ChattersListView">
			    <UpdatedControls>
				    <telerik:AjaxUpdatedControl ControlID="BioListView" LoadingPanelID="RadAjaxLoadingPanel1" />
			    </UpdatedControls>
		    </telerik:AjaxSetting>		    	    		    	
            <telerik:AjaxSetting AjaxControlID="BioListViewLayoutPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="BioListViewLayoutPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ChatterPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ChatterPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    
	<%-- Chatters list --%>
    <asp:SqlDataSource ID="ChattersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
         OnSelected="ChattersSqlDataSource_Selected" >
            <SelectParameters>
            <asp:Parameter Name="StartIndex" Type="Int32" DefaultValue="1" />
            <asp:Parameter Name="EndIndex" Type="Int32" DefaultValue="3" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BioSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        SelectCommand = "SELECT p.UserName, p.FirstName, p.LastName, p.City, p.state, p.description, dbo.ufn_GetAge(p.BirthDate, GETDATE()) as age, p.gender, i.data FROM MemberProfile p, Images i WHERE i.ImageId=p.ImageId AND p.UserName = @UserName">
        <SelectParameters>
            <asp:ControlParameter ControlID="ChattersListView" DefaultValue="" Name="UserName" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
	<telerik:RadListView ID="ChattersListView" runat="server" DataKeyNames="UserName" Width="300" AllowPaging="true"
        AllowCustomPaging="true" OnSelectedIndexChanged="ChattersListView_SelectedIndexChanged" ItemPlaceholderID="itemPlaceHolder"
		DataSourceID="ChattersSqlDataSource" VirtualItemCount="6" PageSize="3" OnPageIndexChanged="ChattersListView_PageIndexChanged">
		<LayoutTemplate>
            <asp:Panel ID="ChatterPanel" runat="server" Width="460"> 
			    <table class="rlv" cellpadding="0" cellspacing="3" border="0">
                    <tr>
                        <td>
                            <telerik:RadButton ID="LeftButton" runat="server" Width="25" Height="22" OnClick="leftButton_Clicked">
                                <Image ImageUrl="Images/left.gif" HoveredImageUrl="Images/left_hover.gif" IsBackgroundImage="true" />
                            </telerik:RadButton>	
                        </td>
					    <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                        <td>
                            <telerik:RadButton ID="RightButton" runat="server" Width="25" Height="22" OnClick="rightButton_Clicked">
                                <Image ImageUrl="Images/right.gif" HoveredImageUrl="Images/right_hover.gif" IsBackgroundImage="true" />
                            </telerik:RadButton>	
                        </td>
                    </tr>
			    </table>
            </asp:Panel>
		</LayoutTemplate>
		<ItemTemplate>
			<td class="rlvItem" onmouseover="friendMouseOver(this)" onmouseout="friendMouseOut(this)">
				<asp:LinkButton ID="ChatterButton" runat="server" CommandName="Select" OnClientClick="ShowLoadingPanel()">
					<telerik:RadBinaryImage ID="ChatterImage" runat="server" Width="40px" Height="40px"
						ResizeMode="Fit" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
						Tooltip='<%# Eval("FirstName") + " " + Eval("LastName") %>'
						CssClass="photo" /><span class="name"><%# Eval("UserName") %></span>
				</asp:LinkButton>
			</td>
		</ItemTemplate>
		<SelectedItemTemplate>
			<td class="rlvSelected" onmouseover="friendMouseOver(this)" onmouseout="friendMouseOutSelected(this)">
				<asp:LinkButton ID="SelectedChatterButton" runat="server" CommandName="Select" OnClientClick="ShowLoadingPanel()">
					<telerik:RadBinaryImage ID="SelectedChatterImage" runat="server" Width="40px" Height="40px"
						ResizeMode="Fit" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
						Tooltip='<%# Eval("FirstName") + " " + Eval("LastName") %>'
						CssClass="photo" /><span class="name"><%# Eval("UserName") %></span>
				</asp:LinkButton>
			</td>
		</SelectedItemTemplate>
	</telerik:RadListView>

	<telerik:RadSplitter runat="server" ID="RadSplitter1" BorderStyle="None" PanesBorderSize="0" Height="440" Width="460">
		<telerik:RadPane runat="Server" ID="leftPane" Width="180px" MaxWidth="460" Scrolling="None">
		    <telerik:RadListView ID="BioListView" runat="server" DataKeyNames="UserName" Width="100%" AllowPaging="true" 
                PageSize="1" DataSourceID="BioSqlDataSource" ItemPlaceholderID="ChattersContainer" AllowCustomPaging="true">
                <LayoutTemplate>
                    <asp:Panel ID="BioListViewLayoutPanel" runat="server">
                        <div class="container">
                            <asp:PlaceHolder ID="ChattersContainer" runat="server"></asp:PlaceHolder>
                        </div>
                    </asp:Panel>
                </LayoutTemplate>
			    <ItemTemplate>
                    <div class="user-details">
		                <div class="udImage">
                            <center>
                            <telerik:RadBinaryImage ID="RadBinaryImage1" runat="server" Width="120px" Height="120px"
                                ResizeMode="Fit" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>' Tooltip='<%# Eval("FirstName") + " " + Eval("LastName") %>' />
                            </center>
		                </div><br />
		                <div class="udName">
                            <center>
							<%# Eval("FirstName") + " " + Eval("LastName") %> (<%# Eval("UserName") %>)<br />
							<%# Eval("Gender") %> - <%# Eval("Age") %><br />
							<%# Eval("City") %>, <%# Eval("State") %><br />
                            </center>
		                </div><br />
	                    <div class="udBio" style="margin:5px;">
                            <span class="sm_label">A little about me:</span><br />
                            <%# Eval("Description") %>
	                    </div>
                    </div>
			    </ItemTemplate>
		    </telerik:RadListView>
		</telerik:RadPane>
		<telerik:RadSplitBar runat="server" ID="RadSplitBarVertical" CollapseMode="None" />
		<telerik:RadPane runat="Server" ID="rightPane" CssClass="right-pane" Width="280px" MaxWidth="280" Height="200" Scrolling="None">
	        <div class="content">
		        <asp:Panel runat="server" ID="Content">
                    <telerik:RadEditor runat="server" ID="ReadEditor" 
                        toolsfile="~/App_Data/ToolsFileRead.xml" EditModes="Preview" Width="278" Height="200">
                        <Content>
                        </Content>                     
                    </telerik:RadEditor>
                    <telerik:RadEditor runat="server" ID="ChatEditor" toolsfile="~/App_Data/ToolsFileChat.xml" EditModes="Design" Width="278" Height="200"
                        NewLineBr="false" OnClientLoad="OnChatEditorLoad" OnClientCommandExecuting="OnClientCommandExecuting">
                        <ImageManager DeletePaths="~/App_Data" UploadPaths="~/App_Data" 
                            ViewPaths="~/App_Data" />
                        <DocumentManager DeletePaths="~/App_Data" UploadPaths="~/App_Data" 
                            ViewPaths="~/App_Data" />
                        <FlashManager DeletePaths="~/App_Data" UploadPaths="~/App_Data" 
                            ViewPaths="~/App_Data" />
                        <MediaManager DeletePaths="~/App_Data" UploadPaths="~/App_Data" 
                            ViewPaths="~/App_Data" />
                        <Content>
                        </Content>                     
                    </telerik:RadEditor>
                </asp:Panel>
                <div class="toolbar">
		            <telerik:RadToolBar runat="server" ID="ChatToolBar" EnableViewState="false" EnableRoundedCorners="true" Width="276" Height="26">
			            <Items>
				            <telerik:RadToolBarButton Value="ChatSend" CommandName="SendChat">
					            <ItemTemplate>
                                    <telerik:RadButton ID="ChatSendButton" runat="server" Text="Send">
                                        <Icon PrimaryIconUrl="Images/chat_icon.gif" PrimaryIconLeft="2" PrimaryIconTop="4" />
                                    </telerik:RadButton>
					            </ItemTemplate>
				            </telerik:RadToolBarButton>
				            <telerik:RadToolBarButton Value="ChatClear" CommandName="ClearChat">
					            <ItemTemplate>
                                    <telerik:RadButton ID="ChatClearButton" runat="server" Text="Clear">
                                        <Icon PrimaryIconUrl="Images/edit-clear.png" PrimaryIconLeft="3" PrimaryIconTop="3" />
                                    </telerik:RadButton>
					            </ItemTemplate>
				            </telerik:RadToolBarButton>
				            <telerik:RadToolBarButton Value="ChatDrink" CommandName="TakeDrink">
					            <ItemTemplate>
                                    <telerik:RadButton ID="ChatDrinkButton" runat="server" Text="Drink">
                                        <Icon PrimaryIconUrl="Images/drink_icon.gif" PrimaryIconLeft="2" PrimaryIconTop="3" />
                                    </telerik:RadButton>
					            </ItemTemplate>
				            </telerik:RadToolBarButton>
				            <telerik:RadToolBarButton Value="ChatSave" CommandName="SaveChat">
					            <ItemTemplate>
                                    <telerik:RadButton ID="ChatSaveButton" runat="server" Text="Save">
                                        <Icon PrimaryIconCssClass="rbSave" PrimaryIconLeft="4" PrimaryIconTop="4" />
                                    </telerik:RadButton>
					            </ItemTemplate>
				            </telerik:RadToolBarButton>
			            </Items>
		            </telerik:RadToolBar>
                </div>
                <telerik:RadAjaxLoadingPanel runat="server" ID="ContentLoadingPanel" IsSticky="true" CssClass="ajaxLoader" />
	        </div>
		</telerik:RadPane>
	</telerik:RadSplitter>
	</form>
</body>
</html>
