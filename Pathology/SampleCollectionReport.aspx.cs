using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pathology_SampleCollectionReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            showReport();

          
            
        }
    }

    private void showReport()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Main_ID", Request.QueryString["Main_iD"]) };
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("uspSampleCollectionReport", "Path_ConnectionString", sqlParm);
        ReportViewer1.LocalReport.DataSources.Clear();
        string reportPath = Server.MapPath("~/Pathology/SampleCollectionReport.rdlc");
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

        ReportViewer1.LocalReport.Refresh();
        if (Request.Browser.Browser == "Chrome")
        {
            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(bytes);
            Response.End();
        }

        else
            ReportViewer1.Visible = true;
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
}