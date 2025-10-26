using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class RecordManagement_Patient_File_Activity_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadReport();
        }
    }
    protected void LoadReport()
    {
        ReportViewer1.LocalReport.DataSources.Clear();
        SqlDataSource1.SelectParameters["Patient_File_ID"].DefaultValue = Request.QueryString["File_Id"];
        SqlDataSource2.SelectParameters["Patient_File_ID"].DefaultValue = Request.QueryString["File_Id"];
        DataView dv = SqlDataSource1.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dt = dv.Table;
        DataView dv1 = SqlDataSource2.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dt1 = dv1.Table;
        string reportPath = Server.MapPath("~/RecordManagement/Patient_File_Activity_Report.rdlc");


        ReportViewer1.LocalReport.ReportPath = reportPath;


        foreach (DataRow dr in dt.Rows)
        {
            dr[0] = dr[0].ToString().Replace("&nbsp;", " ");
        }
        foreach (DataRow dr1 in dt1.Rows)
        {
            dr1[0] = dr1[0].ToString().Replace("&nbsp;", " ");
        }

        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", dt1));
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
        { }
        finally { }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RecordManagement/IssuePatientRecord.aspx");
    }
}