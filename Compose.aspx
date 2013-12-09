<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Compose.aspx.cs" Inherits="Compose" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head id="Head1" runat="server">
	<title>Edit</title>
	<link rel="stylesheet" href="Styles/compose.css" type="text/css" />
</head>
<body class="composeWindow">
	<form id="form1" runat="server">
	<telerik:RadScriptManager ID="ScriptManager" runat="server" />
	<telerik:RadSkinManager runat="Server" ID="SkinManager1" Skin="Vista" PersistenceKey="Skin"
		PersistenceMode="Session">
	</telerik:RadSkinManager>
	<telerik:RadStyleSheetManager runat="server" ID="RadStyleSheetManager1" />
	<telerik:RadEditor ID="RadEditor1" Width="854px" Height="480px" AutoResizeHeight="false"
		runat="server" ImageManager-ViewPaths="~/Img" ImageManager-UploadPaths="~/Img"
		ImageManager-DeletePaths="~/Img" ImageManager-MaxUploadFileSize="512000" DocumentManager-DeletePaths="~/Documents"
		FlashManager-DeletePaths="~/Flash" MediaManager-DeletePaths="~/Flash" TemplateManager-DeletePaths="~/Documents"
		DocumentManager-ViewPaths="~/Documents" DocumentManager-UploadPaths="~/Documents"
		FlashManager-UploadPaths="~/Flash" MediaManager-UploadPaths="~/Flash" TemplateManager-UploadPaths="~/Documents"
		FlashManager-ViewPaths="~/Flash" MediaManager-ViewPaths="~/Media" EnableResize="false"
		EditModes="Design">
		<Modules>
			<telerik:EditorModule Name="fakeModule" />
		</Modules>
	</telerik:RadEditor>
	<div id="composeActions">
		<asp:Button ID="Button1" runat="server" Style="width: 75px" Text="Save" OnClientClick="return save()" /><asp:Button
			ID="Button2" runat="server" Style="width: 75px" Text="Cancel" OnClientClick="return cancel()" />
	</div>

	<script type="text/javascript">

	    function setEditorContent(content) {
	        window.setTimeout(function () {

	            var editor = $find("<%= RadEditor1.ClientID%>");
	            editor.set_html(content);
	        }, 0);
	    }

	    function save() {
	        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
	        var editor = $find("<%= RadEditor1.ClientID%>");
	        radWindow.close(editor.get_html());

	        return false;
	    }

	    function cancel() {
	        var radWindow = window.radWindow ? window.radWindow : window.frameElement.radWindow;
	        radWindow.close();

	        return false;
	    }
	</script>

	<telerik:RadFormDecorator runat="server" ID="RadFormDecorator1" />
	</form>
</body>
</html>
