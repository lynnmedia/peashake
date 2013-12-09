<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PreRegistration.aspx.cs" Inherits="PreRegistration" %>

<%@ Register Assembly="skmValidators" Namespace="skmValidators" TagPrefix="skm" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="Controls/Legal.ascx" tagname="Legal" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
<title>PeaShake House: Real Time... Real People! Pre-Registration</title>
<link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
<style type="text/css">
        body { background-image:url('images/bkgs/1.jpg'); }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<form id="Form1" runat="server">
        <div id="djmusic">
            <object width="1" height="1">
                <param name="movie" value="http://fpdownload.adobe.com/strobe/FlashMediaPlayback.swf"></param>
                <param name="flashvars" value="src=rtmp%3A%2F%2Fec2-50-16-154-255.compute-1.amazonaws.com%2Fvod%2Fmp4%3Apeashake-house-lobby.mp4&controlBarMode=none&playButtonOverlay=false&autoPlay=true"></param>
                <param name="allowFullScreen" value="true"></param>
                <param name="allowscriptaccess" value="always"></param>
                <embed src="http://fpdownload.adobe.com/strobe/FlashMediaPlayback.swf" 
                    type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="1" height="1" 
                    flashvars="src=rtmp%3A%2F%2Fec2-50-16-154-255.compute-1.amazonaws.com%2Fvod%2Fmp4%3Apeashake-house-lobby.mp4&controlBarMode=none&playButtonOverlay=false&autoPlay=true">
                </embed>
            </object>
        </div>
        <div id="prereg" runat="server">
            <div class="blackpaper">
            <center>
                <p>
                    <img src="Images/Bkgs/login-logo.gif" border="0" />
                    <h2>Pre-Registration</h2>
                </p>
                <p>
                    <table>
                        <tr>
                            <td align="left">
                                <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstName" CssClass="regLabel">First Name:</asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="FirstName" runat="server" CssClass="textEntryLogin" TabIndex="1" />
                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName" 
                                        CssClass="failureNotification" ErrorMessage="First Name is required." ToolTip="First Name is required." 
                                        ValidationGroup="PreRegUserValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" CssClass="regLabel">Email:</asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="Email" runat="server" CssClass="textEntryLogin" TabIndex="2" />
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                        CssClass="failureNotification" ErrorMessage="Email is required." ToolTip="Email is required." 
                                        ValidationGroup="PreRegUserValidationGroup">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" height="5px"></td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:ImageButton ID="PreRegButton" runat="server" CommandName="PreReg" OnClick="PreRegButtonClicked" ImageUrl="~/Images/Buttons/Login.gif" 
                                    ValidationGroup="PreRegUserValidationGroup" TabIndex="5" style="vertical-align:middle;" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" height="5px"></td>
                        </tr>
                    </table>
                    <span class="failureNotification">
                        <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                    </span>
                    <span class="successNotification">
                        <asp:Literal ID="SuccessText" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="PreRegUserValidationSummary" runat="server" CssClass="failureNotification" 
                            ValidationGroup="PreRegUserValidationGroup"/>
                </p>
            </center>
            </div>
        </div>
        <uc1:Legal ID="Legal1" runat="server" />
    </form>
</body>
</html>
