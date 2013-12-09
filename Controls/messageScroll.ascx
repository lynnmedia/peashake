<%@ Control Language="C#" AutoEventWireup="true" CodeFile="messageScroll.ascx.cs" Inherits="Controls_MessageScroll" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div id="MessageScrollBox">
    <telerik:RadRotator ID="MessageScroll" RotatorType="AutomaticAdvance" ScrollDirection="Left"
        ScrollDuration="30000" runat="server" DataSourceID="MessageScrollXmlDataSource" Width="1440"
        ItemWidth="1000" Height="25" ItemHeight="25" FrameDuration="1" InitialItemIndex="-1">
        <ItemTemplate>
            <div class="MessageScrollBoxText">
                <span>
                    <asp:Label ID="ScrollItem" runat="server" Text='<%# XPath("Text") %>' />
                </span>
            </div>
        </ItemTemplate>
    </telerik:RadRotator>
</div>
<asp:XmlDataSource ID="MessageScrollXmlDataSource" runat="server" 
    DataFile="~/App_Data/messagescroll.xml">
</asp:XmlDataSource>
