using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Pt_EMR_DialysisReportSessionWise : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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

           

            DbManager dbMgr3 = new DbManager();
            SqlParameter[] sqlParam3 = {
                                           new SqlParameter("@DialysisID", Session["DialysisID"]),
                                               new SqlParameter("@DialysisSessionID", Session["DialysisSessionID"])
                                       };
            DataSet ds = new DataSet();
            ds = dbMgr3.ExecuteDataSet("uspSlectDialysisPatientSeesionReport", "TreatmentConnectionString", sqlParam3);


            string path = Server.MapPath("DialysisReportSessionWise.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", ds.Tables[0]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", ds.Tables[1]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", ds.Tables[2]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet4", ds.Tables[3]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet5", ds.Tables[7]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet6", ds.Tables[5]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet7", ds.Tables[6]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet8", ds.Tables[4]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet9", ds.Tables[8]));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
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