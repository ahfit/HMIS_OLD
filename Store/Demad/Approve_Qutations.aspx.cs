using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Approve_Qutations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lbApproveQutation_Click(object sender, EventArgs e)
    {
        LinkButton RQ_ID = (LinkButton) sender;
        GridViewRow row = (GridViewRow)RQ_ID.NamingContainer;
        HiddenField Main_ID = row.FindControl("hfQutation_Main_ID") as HiddenField;
        Response.Redirect("~/Store/Demad/Add_Qutation.aspx?RQ_ID=" + RQ_ID.CommandArgument+"&Main_ID="+Main_ID.Value);
    }
}