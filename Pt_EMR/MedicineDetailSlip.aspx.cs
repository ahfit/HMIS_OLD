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

public partial class Pt_EMR_MedicineDetailSlip : System.Web.UI.Page
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
            SqlParameter[] sqlParam =
                {
                new SqlParameter("@RegNo", Session["registrationno"]),
                new SqlParameter("@YearlyNo", Session["YearlyNo"])


                };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("usp_MedicineDetail", "TreatmentConnectionString", sqlParam);
            string path = Server.MapPath("MedicineDetailSlip.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
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