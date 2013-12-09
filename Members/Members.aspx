<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Members.aspx.cs" Inherits="Members_Members" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="../Controls/luma.ascx" tagname="luma" tagprefix="uc1" %>
<%@ Register src="../Controls/peashake.ascx" tagname="peashake" tagprefix="uc2" %>
<%@ Register src="../Controls/Legal.ascx" tagname="Legal" tagprefix="uc3" %>
<%@ Register src="../Controls/privacy.ascx" tagname="privacy" tagprefix="uc4" %>
<%@ Register src="../Controls/messageScroll.ascx" tagname="messageScroll" tagprefix="uc5" %>
<%@ Register src="../Controls/ActiveMemberScroll.ascx" tagname="ActiveMemberScroll" tagprefix="uc6" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
    <title>PeaShake House: Real Time... Real People!</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://sync3.frozenmountain.com/client.js?v=3.5.0"></script>
    <script type="text/javascript" src="client.ashx"></script>
    <script type="text/javascript" src="../Scripts/members.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
	    <div class="ImagesRotator">
		    <uc6:ActiveMemberScroll ID="ActiveMemberScroll1" runat="server" />
	    </div>
        <uc1:luma ID="luma" runat="server" />
        <uc2:peashake ID="peashake" runat="server" />
        <div class="loginDisplay">
            <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                <AnonymousTemplate>
                    <a href="~/Login.aspx" ID="HeadLoginStatus" runat="server">Log in</a>
                </AnonymousTemplate>
                <LoggedInTemplate>
                    <span class="bold"><asp:LoginName ID="HeadLoginName" runat="server" /></span>&nbsp;
                    <asp:LoginStatus ID="HeadLoginStatus" runat="server" LogoutAction="Redirect" LogoutText="Log out" LogoutPageUrl="~/Login.aspx"/>
                </LoggedInTemplate>
            </asp:LoginView><br />
        </div>
        <uc3:Legal ID="Legal" runat="server" />
        <uc4:privacy ID="Privacy" runat="server" />
		<telerik:RadScriptManager runat="server" EnableCdn="true" ID="RadScriptManager1">
			<Services>
				<asp:ServiceReference Path="SendMail.asmx" />
				<asp:ServiceReference Path="StartChat.asmx" />
			</Services>
		</telerik:RadScriptManager>
        <uc5:MessageScroll ID="PeashakeMessageScroll" runat="server" />
        <div id="concierge">
            <script type="text/javascript">
            //<![CDATA[
                function openPrefWin() {
                    radopen(null, "PreferencesWindow");
                }

                function openChatWin() {
                    radopen(null, "ChatWindow");
                }
                function showLumaNotice() {
                    var notification = $find("<%=LumaNotice.ClientID %>");
                    notification.show();
                }
                function showPeashakeNotice() {
                    var notification = $find("<%=PeashakeNotice.ClientID %>");
                    notification.show();
                }
                function showComedyClubNotice() {
                    var notification = $find("<%=ComedyClubNotice.ClientID %>");
                    notification.show();
                }
            //]]>                                                                        
            </script>
            <div id="conciergeServices">
                <asp:ImageButton id="cgPreferencesButton" class="conciergeButton" runat="server" ImageUrl="~/images/Icons/AccountInfo.png" ToolTip="Preferences" OnClientClick="openPrefWin(); return false;" />
                <asp:ImageButton id="cgChatButton" class="conciergeButton" runat="server" ImageUrl="~/images/Icons/Message.png" ToolTip="Chat" OnClientClick="openChatWin(); return false;" />
            </div>
            <div id="conciergeRooms">
                <asp:ImageButton id="cgLumaButton" class="conciergeButton" runat="server" ImageUrl="~/images/Icons/Luma.png" ToolTip="Luma" OnClientClick="showLumaNotice(); return false;" />
                <asp:ImageButton id="cgPeashakeButton" class="conciergeButton" runat="server" ImageUrl="~/images/Icons/PeaShake.png" ToolTip="PeaShake" OnClientClick="showPeashakeNotice(); return false;" />
                <asp:ImageButton id="cgComedyClubButton" class="conciergeButton" runat="server" ImageUrl="~/images/Icons/ComedyClub.png" ToolTip="Comedy Club" OnClientClick="showComedyClubNotice(); return false;" />
            </div>
        </div>
	    <telerik:RadWindowManager style="z-index:30000;" runat="Server" ID="RadWindowManager1" EnableViewState="false" EnableShadow="true" RestrictionZoneID="zoneID1" >
		    <Windows>
			    <telerik:RadWindow runat="server" ID="PreferencesWindow" NavigateUrl="~/UserProfile.aspx" 
                    Right="300" Top="125" Width="740px" Height="560px" VisibleStatusbar="false"
				    ReloadOnShow="true" ShowContentDuringLoad="false" Modal="false" Behaviors="Close,Move,Minimize,Pin" Title="Preferences"
                    IconUrl="~/Images/Mr-P-ico.gif" CssClass="PrefsWindow">
			    </telerik:RadWindow>
                <telerik:RadWindow runat="server" ID="ChatWindow" NavigateUrl="~/Chat.aspx" 
                    Left="150" Top="150" Width="500px" Height="553px" VisibleStatusbar="false"
                    ReloadOnShow="true" showcontentduringload="false" Modal="false" Behaviors="Close,Move,Minimize,Pin" Title="Chat"
                    IconUrl="~/Images/Mr-P-ico.gif" CssClass="ChatWindow">
                </telerik:RadWindow>
		    </Windows>
	    </telerik:RadWindowManager>
        <table id="windowZone">
            <tr>
                <td id="zoneID1">
                </td>
            </tr>
        </table>
         <telerik:RadNotification ID="LumaNotice" runat="server" EnableRoundedCorners="true" Position="BottomCenter" AutoCloseDelay="750"
            EnableShadow="true" Text="The Luma Room is open daily from 10am until 5pm." Title="A Luma Room Notice" Width="300" Height="100">
        </telerik:RadNotification>
        <telerik:RadNotification ID="PeashakeNotice" runat="server" EnableRoundedCorners="true" Position="BottomCenter" AutoCloseDelay="750"
            EnableShadow="true" Text="The Peashake Room is open daily from 5pm until 2am." Title="A Peashake Room Notice" Width="300" Height="100">
        </telerik:RadNotification>
        <telerik:RadNotification ID="ComedyClubNotice" runat="server" EnableRoundedCorners="true" Position="BottomCenter" AutoCloseDelay="750"
            EnableShadow="true" Text="The Comedy Club will be opening soon." Title="A Comedy Club Notice" Width="300" Height="100">
        </telerik:RadNotification>
     </form>
</body>
</html>
