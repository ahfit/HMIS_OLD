using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Demad_SearchQuotation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindSubDept();


            txtStartDate.Value = DateTime.Now.AddDays(-10);
            txtEndDate.Value = DateTime.Now;
         
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();
    }

   
    protected void lbQutationReport_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

        Response.Redirect("~/Store/Demad/Qutation_Report.aspx?RQ_ID=" + lb.CommandArgument+"&T=L");
    }
    protected void bindSubDept()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@Type", "SubDeptAll") };
            ddlSubDepartment.DataSource = dbm.ExecuteDataTable("uspGetDefaultValuesDemand", "STOREConnectionString", sp);
            ddlSubDepartment.DataBind();
            // ddlSubDepartment.SelectedValue = Session["SubDeptID"].ToString();
        }
        catch (Exception ex)
        {

        }


    }
    protected void bindGrid()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@requisitionNo", txtIndentBookNo.Text),new SqlParameter("@ByDeparmtent",ddlSubDepartment.SelectedValue),
                                  new SqlParameter("@startDate",txtStartDate.Value),new SqlParameter("@endDate",txtEndDate.Value),
                                  new SqlParameter("@toSubDept",Session["SubDeptID"])};
            GridView1.DataSource = dbm.ExecuteDataTable("uspSelectDemandRequisitionQutationNew", "STOREConnectionString", sp);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
        }


    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }

    protected void lnkViewApprove_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        Label lbD = (Label)row.FindControl("lblDemandNo");
        HiddenField appID = (HiddenField)row.FindControl("hdfAppID");
        if(Convert.ToInt32(appID.Value)>0)
        {
            sds_Approve.UpdateParameters["Qutation_Main_ID"].DefaultValue = lb.CommandArgument;
            sds_Approve.UpdateParameters["Demand_RQ_ID"].DefaultValue = lbD.Text;
            sds_Approve.UpdateParameters["Approval_Request_Id"].DefaultValue = appID.Value;
            sds_Approve.UpdateParameters["Approval_Remarks"].DefaultValue = "";
            sds_Approve.Update();
        }
        
        Response.Redirect("Add_Qutation.aspx?RQ_ID=" + lbD.Text + "&Main_ID=" + lb.CommandArgument);

    }

    protected void lbImport_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

        Response.Redirect("~/Store/Demad/Qutation_Report.aspx?RQ_ID=" + lb.CommandArgument + "&T=I");
    }
}