using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Store_SupplierWiseGRNReport : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddlDepartment.DataBind();

            ddlDepartment.SelectedValue = Session["Dept_ID"].ToString();

            wdcFromDate.Value = DateTime.Now.AddDays(-10);
            wdcToDate.Value = DateTime.Now;
          
        }
    }
    protected void btnSearchRequisition_Click(object sender, EventArgs e)
    {
        //SqlDataSource1.SelectParameters["Demand_RequisitionNo"].DefaultValue = txtRequisitionNo.Text;
        //SqlDataSource1.SelectParameters["From_Dept_ID"].DefaultValue = ddlDepartment.SelectedValue;

        //SqlDataSource1.SelectParameters["FromDate"].DefaultValue = Convert.ToDateTime(wdcFromDate.Value).ToString("yyyy-MMMM-dd");
        //SqlDataSource1.SelectParameters["ToDate"].DefaultValue = Convert.ToDateTime(wdcToDate.Value).ToString("yyyy-MMMM-dd");

        //    SqlDataSource1.SelectParameters["PendingWorkFlow"].DefaultValue = "All";

        //    SqlDataSource1.SelectParameters["PendingWorkFlow"].DefaultValue = "Pending";
        ShowReport();
    }
    protected void ShowReport()
    {
        SqlConnection conn = new SqlConnection(conStr);
        try
        {
            DbManager dbMgr = new DbManager();
          
            DataTable dt = new DataTable();
            string path = null;
            
                SqlParameter[] sqlParam = {
                    new SqlParameter("@From_Dept_ID", ddlDepartment.SelectedValue),
                    new SqlParameter("@FromDate",Convert.ToDateTime(wdcFromDate.Value).ToString("yyyy-MMMM-dd")),
                                        new SqlParameter("@ToDate",Convert.ToDateTime(wdcToDate.Value).ToString("yyyy-MMMM-dd")),
                                        new SqlParameter("@partyid",DDLparty.SelectedValue),};
                dt = dbMgr.ExecuteDataTable("PartyWiseGRNReturn", "STOREConnectionString", sqlParam);
                 path = Server.MapPath("PartyWiseGRNReturn.rdlc");
           

            //ReportParameter[] repParams = new ReportParameter[2];
           
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            //repParams[0] = new ReportParameter("Start_Date", "");
            //repParams[1] = new ReportParameter("End_Date", "");
            //ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch(Exception ex) 
        { }
        finally
        {

        }
    }

    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }
    }

    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    HyperLink hlnkAction = null;
    //    HiddenField hfld_Workflow_Process = null;
    //    HiddenField hfld_Demand_RQ_ID = null;

    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        hlnkAction = e.Row.FindControl("hlnkAction") as HyperLink;
    //        hfld_Workflow_Process = e.Row.FindControl("hfld_Workflow_Process") as HiddenField;
    //        hfld_Demand_RQ_ID = e.Row.FindControl("hfld_IB_ID") as HiddenField;

    //        if (hfld_Workflow_Process.Value == "Not Started")
    //        {
    //            hlnkAction.Text = "Forward for Approval";
    //            hlnkAction.NavigateUrl = string.Format("~/Store/Approve_Requisition.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
    //        }
    //        else
    //        {
    //            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
    //            hlnkAction.Text = textInfo.ToTitleCase(hfld_Workflow_Process.Value);
    //            hlnkAction.NavigateUrl = string.Format("~/Store/ViewWorkFlowProgress.aspx?RQ_ID={0}", hfld_Demand_RQ_ID.Value);
    //        }


    //    }

    //}
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
     {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
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
    protected void TextBox_specificMedicine_TextChanged(object sender, EventArgs e)
    {
    }
}