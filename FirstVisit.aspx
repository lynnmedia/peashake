<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FirstVisit.aspx.cs" Inherits="FirstVisit" %>

<%@ Register src="Controls/orientation.ascx" tagname="orientation" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Peashake House - First visit orientation</title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/firstvisit.js"></script>
    <style type="text/css">
            body { background-image:url('images/bkgs/1.jpg'); }
    </style>
</head>
<body onload="start()">
    <form id="form1" runat="server">
        <div>
            <uc1:orientation ID="orientation1" runat="server" />
        </div>
    </form>
</body>
</html>
