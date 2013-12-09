using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Charting;
using Telerik.Web.UI;

public partial class Members_Members : System.Web.UI.Page
{
    static MembershipUser user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
    static string userName = user.UserName;
    static Guid guid = (Guid)user.ProviderUserKey;
    static string userID = guid.ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            InitializeWebSync();
        }
    }

    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        }
    }

    protected void Log(string content, string category)
    {
        SqlConnection connection = new SqlConnection(ConnectionString);
        string sqlQuery = "INSERT INTO Log (Category, Content) VALUES (@category, @content)";
        SqlCommand command = new SqlCommand(sqlQuery, connection);

        SqlParameter param0 = new SqlParameter("@category", SqlDbType.NVarChar, 256);
        param0.Value = category;
        command.Parameters.Add(param0);

        SqlParameter param1 = new SqlParameter("@content", SqlDbType.Text);
        param1.Value = content;
        command.Parameters.Add(param1);

        connection.Open();
        command.ExecuteNonQuery();
        connection.Close();
    }

    protected void InitializeWebSync()
    {
        // Create javascript to initialize and subscribe the user
        String csName = "WebSyncInitSubscribeScript";
        Type csType = this.GetType();

        // Get a ClientScriptManager reference from the Page class.
        ClientScriptManager cs = Page.ClientScript;

        // Check to see if the client script is already registered.
        if (!cs.IsStartupScriptRegistered(csType, csName))
        {
            StringBuilder csText = new StringBuilder();
            csText.Append("<script type=\"text/javascript\">");
            csText.Append("var client = fm.websync.client;");
            csText.Append("client.initialize();");
            csText.Append("client.connect({");
            csText.Append("});");
            csText.Append("client.subscribe({");
            csText.Append("channel: '/user/");
            csText.Append(user.UserName);
            csText.Append("',");
            csText.Append("onSuccess: function (args) {");
            csText.Append("console.log('subscribed to personal channel');");
            csText.Append("},");
            csText.Append("onFailure: function (args) {");
            csText.Append("console.log('failed to subscribe to personal channel' + args.error);");
            csText.Append("},");
            csText.Append("onReceive: function (args) {");
            csText.Append("console.log('received invitation to chat room:' + args.data.chatId);");
            csText.Append("client.subscribe({");
            csText.Append("channel: '/chatroom/' + args.data.chatId,");
            csText.Append("onSuccess: function (args) {");
            csText.Append("console.log('subscribed to chat room');");
            csText.Append("},");
            csText.Append("onFailure: function (args) {");
            csText.Append("console.log('failed to subscribe to chat room' + args.error);");
            csText.Append("},");
            csText.Append("onReceive: function (args) {");
            csText.Append("displayChatMessage(true, args.data.text, args.data.chatId);");
            csText.Append("console.log('received chat message:' + args.data.text);");
            csText.Append("console.log('<br />on:' + args.data.chatId);");
            csText.Append("}");
            csText.Append("});");
            csText.Append("}");
            csText.Append("});");
            csText.Append("</script>");
            cs.RegisterStartupScript(csType, csName, csText.ToString());
        }
    }
}
