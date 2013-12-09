using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Calendar;
using FM.WebSync.Server;
using FM.WebSync.Core;

public partial class Chat : System.Web.UI.Page
{
    protected static MembershipUser user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
    protected static string userName = user.UserName;
    protected static Guid guid = (Guid)user.ProviderUserKey;
    protected static string userID = guid.ToString();
    static int m_chattersCurrentIndex = 0;
    static int m_chattersCount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        ChattersSqlDataSource.SelectCommand = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY UserName ASC) AS [Index], i.Data, p.UserName, p.FirstName, p.LastName FROM MemberProfile p LEFT OUTER JOIN Images i ON i.ImageId=p.ImageId WHERE p.UserId IN (select UserId from ChatRoomGuests g where ChatRoomId in (select ChatRoomId from ChatRoomGuests g where g.UserId='ADD672C2-C53E-4648-B034-DB75F37764C5') AND g.UserId != 'ADD672C2-C53E-4648-B034-DB75F37764C5')) AS InnerTable WHERE InnerTable.[Index] BETWEEN @StartIndex AND @EndIndex";
        if (!Page.IsPostBack)
        {
            ChattersListView.Rebind();
            ChattersListView.SelectedIndexes.Add(0);
        }
    }

    protected void leftButton_Clicked(object sender, EventArgs e)
    {
        int newValue = m_chattersCurrentIndex - 3;
        if (newValue < 0)
            newValue = 0;
        m_chattersCurrentIndex = newValue;
        ChattersListView.Items[0].FireCommandEvent(RadListView.PageCommandName, newValue.ToString());
    }

    protected void rightButton_Clicked(object sender, EventArgs e)
    {
        int newValue = m_chattersCurrentIndex + 3;
        if (newValue > (m_chattersCount-1))
            newValue = (m_chattersCount-3);
        m_chattersCurrentIndex = newValue;
        ChattersListView.Items[0].FireCommandEvent(RadListView.PageCommandName, newValue.ToString());
    }

    protected void ChattersListView_PageIndexChanged(object sender, RadListViewPageChangedEventArgs e)
    {
        ChattersSqlDataSource.SelectParameters["StartIndex"].DefaultValue = e.NewPageIndex.ToString();
        ChattersSqlDataSource.SelectParameters["EndIndex"].DefaultValue = (e.NewPageIndex + 4).ToString();
    }

    protected void ChattersListView_SelectedIndexChanged(object sender, EventArgs eventArgs)
    {
        BioListView.Rebind();
        ScriptManager.RegisterStartupScript(Page, typeof(Page), "hide", "HideLoadingPanel()", true);
    }

    protected void ChattersSqlDataSource_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        m_chattersCount = e.AffectedRows;
    }
}
