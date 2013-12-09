<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ActiveMemberScroll.ascx.cs" Inherits="Controls_ActiveMemberScroll" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div id="activeMembers">
    <div style="overflow:hidden;">
        <asp:Panel ID="RotatorWrapper" runat="server" CssClass="rotWrapper">
            <telerik:RadRotator ID="RadRotator1" runat="server" Width="750px" ItemWidth="100"
                ScrollDirection="Left, Right" Height="200px" ItemHeight="100" ScrollDuration="500"
                FrameDuration="2000" PauseOnMouseOver="false" RotatorType="CoverFlow" 
                OnClientItemShown="OnClientItemShown" OnClientItemClicked="OnClientItemClicked"
                CssClass="RemoveRotatorBorder" DataSourceID="ActiveMembersSqlDataSource">
                <ItemTemplate>
                    <telerik:radbinaryimage runat="server" id="ActiveMemberBinaryImage" DataValue='<%#Eval("Data") is DBNull ? null : Eval("Data")%>'
                        AutoAdjustImageControlSize="true" ToolTip='<%#Eval("username") %>' /><span class="name"><%# Eval("UserName") %></span>
                </ItemTemplate>
            </telerik:RadRotator>
            <asp:SqlDataSource id="ActiveMembersSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                SelectCommand="select p.username, i.Data from memberProfile p join images i on i.ImageId=p.ImageId"></asp:SqlDataSource>
            <script type="text/javascript">
                //<![CDATA[
                // The set_scrollAnimationOptions method takes two arguments - the first one is the ClientID of the rotator, which we want to configure and the second one is
                // a hash table with the options we want to apply.
                Telerik.Web.UI.RadRotatorAnimation.set_scrollAnimationOptions("<%= RadRotator1.ClientID %>", // The ClientID of the RadRotator
                    {
                    minScale: 0.6, // The size scale [0; 1], applied to the items that are not selected.
                    yO: 50, // The offset in pixels of the center of the selected item from the top edge of the rotator.
                    xR: -20, // The offset in pixels between the selected items and the first item on the left and on the right of the selected item.
                    xItemSpacing: 50, // The offset in pixels between the items in the rotator.0
                    matrix: { m11: 1, m12: 0, m21: -0.1, m22: 1 }, // The 2d transformation matrix, applied to the items that appear on the right of the selected item.
                    reflectionHeight: 0.5, // The height of the reflection
                    reflectionOpacity: 1 // The opacity, applied to the reflection
                }
                ); // end of animationOptions
                //]]>
            </script>
        </asp:Panel>
    </div>
    <script type="text/javascript">
    //<![CDATA[
        var indexToScrollTo = -1;
        function OnClientItemShown(oRotator, args) {
            if (oRotator.get_rotatorType() == Telerik.Web.UI.RotatorType.CoverFlow) {
                var currentIndex = args.get_item().get_index();
                // Change the scroll direction of the rotator, in case it has displayed its last item for the current scroll direction.
                if (0 == currentIndex || currentIndex == (oRotator.get_items().length - 1)) {
                    var directionEnum = Telerik.Web.UI.RotatorScrollDirection;
                    var newScrollDirection = 0 == currentIndex ? directionEnum.Left : directionEnum.Right;

                    oRotator.set_scrollDirection(newScrollDirection);
                    oRotator.set_animationDirection(newScrollDirection);
                }
            }
        }

        function OnClientItemClicked(oRotator, args) {
            oRotator.set_currentItemIndex(args.get_item().get_index(), true);
        }
        //]]>
    </script>
</div>
