using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Configuration;
using System.Data.SqlClient;

public partial class Store_DemandRequisitionSearch : System.Web.UI.Page
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
        bindGrid();
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
            hfld_Demand_RQ_ID = e.Row.FindControl("hfld_Demand_RQ_ID") as HiddenField;

            if (hfld_Workflow_Process.Value == "Not Started")
            {
                hlnkAction.Text = "Forward for Approval";
                hlnkAction.NavigateUrl = string.Format("~/Store/Demad/Approve_Demand_Requisition.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
            }
            else
            {
                TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
                hlnkAction.Text = textInfo.ToTitleCase(hfld_Workflow_Process.Value);
                hlnkAction.NavigateUrl = string.Format("~/Store/Demad/ViewDemandReqWorkFlowProgress.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
            }


        }

    }
    protected void lnkDemandId_Click(object sender, EventArgs e)
    {
        LinkButton btnTemp = (LinkButton)sender;
        GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        HiddenField hdfCID = (HiddenField)gvRow.FindControl("hdfCompany_ID");
        //Response.Redirect("Demand_Requisition_Report.aspx?RequsitionNo=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value);
        String path="Demand_Requisition_Report.aspx?RequsitionNo=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow","window.open('"+path+"','_newtab');", true);
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgDel = (ImageButton)sender;
        try
        {
            String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("Update Demand_Requisition_Main Set Is_Completed=NULL Where Demand_RQ_ID=@Demand_RQ_ID", con);
            cmd.Parameters.AddWithValue("@Demand_RQ_ID", imgDel.CommandArgument);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            cmd.Dispose();
            bindGrid();
        }
        catch (Exception ex)
        {
        }
    }
    protected void bindGrid()
    {
        if (txtRequisitionNo.Text == "")
        {
            SqlDataSource1.SelectParameters["Demand_RequisitionNo"].DefaultValue = "%";
            Response.Write(txtRequisitionNo.Text);
        }
        else
        {
            SqlDataSource1.SelectParameters["Demand_RequisitionNo"].DefaultValue = txtRequisitionNo.Text;
        }

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
}