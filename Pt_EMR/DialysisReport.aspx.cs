using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pt_EMR_DialysisReport : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {
            ShowReport();
    }

    }


    protected void ShowReport()
    {
        SqlConnection conn = new SqlConnection(conStr);
        try
        {
            DbManager dbMgr = new DbManager();

            // DataSet 1 

            SqlParameter[] sqlParam = {  new SqlParameter("@DialysisID", Session["DialysisID"]) };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("uspGetPatientMainDialysis", "TreatmentConnectionString", sqlParam);

            // DataSet2

            DbManager dbMgr2 = new DbManager();
            SqlParameter[] sqlParam2 = { new SqlParameter("@DialysisID", Session["DialysisID"]) };
            DataTable dt2 = new DataTable();
            dt2 = dbMgr2.ExecuteDataTable("uspGetPatientMainDialysisSerology", "TreatmentConnectionString", sqlParam2);

            //DataSet3

            DbManager dbMgr3 = new DbManager();
            SqlParameter[] sqlParam3 = { new SqlParameter("@DialysisID", Session["DialysisID"]) };
            DataTable dt3 = new DataTable();
            dt3 = dbMgr3.ExecuteDataTable("uspGetPatientMainDialysisSchedules", "TreatmentConnectionString", sqlParam3);


            string path = Server.MapPath("DialysisReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt2));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", dt3));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch(Exception ex)
        {
            Response.Write(ex.Message);
        }
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
}