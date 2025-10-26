using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Recieved_Wise_Items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ShowReport();
        }
    }
    private void ShowReport()
    {
        ReportViewer1.LocalReport.DataSources.Clear();
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Consumption_ID", Request.QueryString["C_ID"]) };
        DataTable dt = new DataTable();
        dt = dbm.ExecuteDataTable("uspGetItemIssueByIPO", "STOREConnectionString", sp);
        ReportDataSource reportDataSource = new ReportDataSource();
        // Must match the DataSource in the RDLC
        reportDataSource.Name = "DataSet1";
        reportDataSource.Value = dt;
        String path = Server.MapPath("Receive_Wise_Report.rdlc");

        ReportViewer1.LocalReport.ReportPath = path;
        ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();

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
    protected void ButtonApprove_Click(object sender, EventArgs e)
    {
        SDS_Approved.Insert();
       
        ButtonApprove.Enabled = false;
        Response.Redirect("RecievedRequisitionList.aspx");
        
    }
}