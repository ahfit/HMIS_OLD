using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_MyPendingApprovalRequests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnkDemandId_Click(object sender, EventArgs e)
    {
        LinkButton btnTemp = (LinkButton)sender;
        GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        HiddenField hdfCID = (HiddenField)gvRow.FindControl("hdfCompany_ID");
        //Response.Redirect("Demand_Requisition_Report.aspx?RequsitionNo=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value);
        String path = "IPOrderReport.aspx?QO_ID=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + path + "','_newtab');", true);
    }
}