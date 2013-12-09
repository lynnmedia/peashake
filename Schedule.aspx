<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
	CodeFile="Schedule.aspx.cs" Inherits="Schedule" Title="Peashake Preferences - Schedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<telerik:RadAjaxManager runat="Server" ID="RadAjaxManager1">
		<AjaxSettings>
			<telerik:AjaxSetting AjaxControlID="RadCalendar1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadCalendar2" />
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="RadCalendar2">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadCalendar1" />
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="chkLuma">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="chkPeashake">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="chkComedy">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="chkFightClub">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1"/>
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="RadScheduler1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadScheduler1" LoadingPanelID="RadAjaxLoadingPanel1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
		</AjaxSettings>
	</telerik:RadAjaxManager>
	<telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" />
	<div class="calendar-container">
		<telerik:RadCalendar runat="server" ID="RadCalendar1" AutoPostBack="true" EnableMultiSelect="false"
			DayNameFormat="FirstTwoLetters" EnableNavigation="true" EnableMonthYearFastNavigation="false"
			OnSelectionChanged="RadCalendar1_SelectionChanged" OnDefaultViewChanged="RadCalendar1_DefaultViewChanged">
		</telerik:RadCalendar>
		<telerik:RadCalendar runat="server" ID="RadCalendar2" AutoPostBack="true" EnableMultiSelect="false"
			DayNameFormat="FirstTwoLetters" EnableNavigation="false" EnableMonthYearFastNavigation="false"
			OnSelectionChanged="RadCalendar2_SelectionChanged">
		</telerik:RadCalendar>
	</div>
	<telerik:RadPanelBar runat="server" ID="PanelBar" Width="100%">
		<Items>
			<telerik:RadPanelItem runat="server" Text="Peashake DJ's" Expanded="true">
				<Items>
					<telerik:RadPanelItem runat="server">
						<ItemTemplate>
							<div class="rpCheckBoxPanel">
								<div>
									<asp:CheckBox ID="chkLuma" runat="server" Text="Luma Room" Checked="true"
										AutoPostBack="true" OnCheckedChanged="CheckBoxes_CheckedChanged" />
								</div>
								<div>
									<asp:CheckBox ID="chkPeashake" runat="server" Text="Peashake Room" Checked="true" AutoPostBack="true"
										OnCheckedChanged="CheckBoxes_CheckedChanged" />
								</div>
							</div>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
			<telerik:RadPanelItem runat="server" Text="Coming Soon" Expanded="true">
				<Items>
					<telerik:RadPanelItem runat="server">
						<ItemTemplate>
							<div class="rpCheckBoxPanel">
								<div>
									<asp:CheckBox ID="chkComedy" runat="server" Text="Comedy" Checked="true" AutoPostBack="true"
										OnCheckedChanged="CheckBoxes_CheckedChanged" />
								</div>
								<div>
									<asp:CheckBox ID="chkFightClub" runat="server" Text="Fight Club" Checked="true" AutoPostBack="true"
										OnCheckedChanged="CheckBoxes_CheckedChanged" />
								</div>
							</div>
						</ItemTemplate>
					</telerik:RadPanelItem>
				</Items>
			</telerik:RadPanelItem>
		</Items>
	</telerik:RadPanelBar>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
	<telerik:RadScheduler runat="server" ID="RadScheduler1" EnableEmbeddedSkins="True"
		ShowFooter="false" SelectedDate="2011-07-02" DayStartTime="00:00:00" DayEndTime="23:59:59"
		TimeZoneOffset="03:00:00" SelectedView="DayView" Height="100%" Width="100%" TimelineView-UserSelectable="false"
		OnNavigationComplete="RadScheduler1_NavigationComplete" OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
        FirstDayOfWeek="Sunday" LastDayOfWeek="Saturday" AdvancedForm-Modal="true">
		<ResourceStyles>
			<telerik:ResourceStyleMapping Type="Calendar" Text="Luma Room" ApplyCssClass="rsCategoryGreen" />
			<telerik:ResourceStyleMapping Type="Calendar" Text="Peashake Room" ApplyCssClass="rsCategoryRed" />
			<telerik:ResourceStyleMapping Type="Calendar" Text="Comedy" ApplyCssClass="rsCategoryOrange" />
			<telerik:ResourceStyleMapping Type="Calendar" Text="Fight Club" ApplyCssClass="rsCategoryBlue" />
		</ResourceStyles>
	</telerik:RadScheduler>
</asp:Content>
