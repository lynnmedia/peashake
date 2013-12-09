using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class Message : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadGrid1.Rebind();
            SelectFirstGridRow();
        }
    }

    private void SelectFirstGridRow()
    {
        GridDataItem firstDataItem = RadGrid1.Items.OfType<GridDataItem>().FirstOrDefault();
        if (firstDataItem != null)
            firstDataItem.Selected = true;
    }

    protected void RadTreeView1_NodeClick(object sender, RadTreeNodeEventArgs e)
    {
        RadGrid1.Rebind();
        SelectFirstGridRow();
        RadTextBox searchTextBox =
            (RadTextBox)((RadToolBarButton)RadToolBar1.FindButtonByCommandName("searchText")).FindControl("RadTextBox1");
        searchTextBox.Text = string.Empty;
    }

    private string searchString;

    protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        searchString = e.Argument.ToLower();
        RadGrid1.Rebind();
    }

    protected void LinqDataSource1_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        if (!string.IsNullOrEmpty(searchString))
        {
            var context = new HelpDeskDataContext();
            e.Result = from message in context.Message
                       where message.Subject.ToLower().Contains(searchString) ||
                                message.Body.ToLower().Contains(searchString) ||
                                message.To.ToLower().Contains(searchString)
                       select message;
        }
    }
}
