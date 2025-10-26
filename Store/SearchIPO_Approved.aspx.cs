using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

public partial class Store_SearchIPO_Approved : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddlDepartment.DataBind();
            ddlEmployee.DataBind();
            ddlDepartment.SelectedValue = Session["Dept_ID"].ToString();
            ddlEmployee.SelectedValue = Session["Emp_ID"].ToString();
            wdcFromDate.Value = DateTime.Now.AddDays(-10);
            wdcToDate.Value = DateTime.Now;
        }
    }
    protected void btnSearchRequisition_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["Demand_RequisitionNo"].DefaultValue = txtRequisitionNo.Text;
        SqlDataSource1.SelectParameters["From_Dept_ID"].DefaultValue = ddlDepartment.SelectedValue;
        SqlDataSource1.SelectParameters["Emp_ID"].DefaultValue = ddlEmployee.SelectedValue;
        SqlDataSource1.SelectParameters["FromDate"].DefaultValue = Convert.ToDateTime(wdcFromDate.Value).ToString("yyyy-MMMM-dd");
        SqlDataSource1.SelectParameters["ToDate"].DefaultValue = Convert.ToDateTime(wdcToDate.Value).ToString("yyyy-MMMM-dd");
        if (!chkPendingWorkFlow.Checked)
            SqlDataSource1.SelectParameters["PendingWorkFlow"].DefaultValue = "All";
        else
            SqlDataSource1.SelectParameters["PendingWorkFlow"].DefaultValue = "Pending";
        GridView1.DataBind();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        HyperLink hlnkAction = null;
        HiddenField hfld_Workflow_Process = null;
        HiddenField hfld_Demand_RQ_ID = null;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            hlnkAction = e.Row.FindControl("hlnkAction") as HyperLink;
            hfld_Workflow_Process = e.Row.FindControl("hfld_Workflow_Process") as HiddenField;
            hfld_Demand_RQ_ID = e.Row.FindControl("hfld_IB_ID") as HiddenField;

            if (hfld_Workflow_Process.Value == "Not Started")
            {
                hlnkAction.Text = "Forward for Approval";
                hlnkAction.NavigateUrl = string.Format("~/Store/Approve_Requisition.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
            }
            else
            {
                TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
                hlnkAction.Text = textInfo.ToTitleCase(hfld_Workflow_Process.Value);
                hlnkAction.NavigateUrl = string.Format("~/Store/ViewWorkFlowProgress.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
            }


        }

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